"""Compile the parsed NTT modules to native GML and resumable basic blocks.

This compiler deliberately has no 'ignore unsupported' fallback. It emits a
source map and dependency inventory; runtime adapters must be implemented and
verified before the generated modules can be enabled in the playable project.
"""
from dataclasses import asdict
from pathlib import Path
import json
import re

from gml_parser import Node, parse_inventory
from runtime_schema import API, FIELD_ALIASES, SCALED_FIELDS, module_key
from legacy_repairs import prison_door_mask
from repairs103 import ast_repair, emitted_repair
from repairs104 import ast_repair as ast_repair104, emitted_repair as emitted_repair104
from repairs105 import emitted_repair as emitted_repair105
from repairs106 import emitted_repair as emitted_repair106
from repairs107 import ast_repair as ast_repair107, emitted_repair as emitted_repair107

ROOT = Path(__file__).resolve().parent


def walk(value):
    if isinstance(value, Node):
        yield value
        for child in value.args:
            yield from walk(child)
    elif isinstance(value, (tuple, list)):
        for child in value:
            yield from walk(child)


def safe(value):
    return re.sub(r"\W", "_", value)


FIELDS = FIELD_ALIASES


class Emitter:
    def __init__(self, module, definition, all_definitions, artwork):
        self.module, self.definition = module, definition
        self.definitions, self.artwork = all_definitions, artwork
        self.locals = set(definition.parameters)
        for node in walk(definition.body):
            if node.kind == "var":
                self.locals.update(name for name, _ in node.args)
        self.async_mode = any(node.kind == "wait" or self.is_fork(node) for node in walk(definition.body))
        self.native_name = "hm_" + safe(module) + "_" + definition.name
        self.fork_entry = None
        self.native_scope = False
        self.temp = 0
        self.calls = set()
        self.sync_loop_stack = []
        # These source renderers advance simulation state as well as drawing.
        # Keep their state/attacks at NTT's 30 Hz without skipping rendering.
        self.draw_logic = (module,definition.name) in {
            ('bosses/guardianboss.mod.gml','guardiandark_draw'),
            ('bosses/guardianboss.mod.gml','guardianwall_draw'),
            ('enemies.mod.gml','crystalshielder_draw'),
            ('enemies.mod.gml','enemyrogue_draw'),
            ('tests/compiler-fixture.gml','draw_logic_probe'),
            ('maincode.mod.gml','PortalShrink'),
        }

    def domain(self, node):
        if node.kind == "identifier" and node.args[0] not in self.locals:
            name = node.args[0]
        elif node.kind == "member":
            if node.args[0].kind == "identifier" and node.args[0].args[0] == "global":
                return None
            name = node.args[1]
        else:
            return None
        if name in {"area", "lastarea", "hqarea", "spawnarea"}: return "Area"
        if name in {"wep", "bwep", "storedwep"}: return "Weapon"
        if name == "race": return "Race"
        return None

    @staticmethod
    def is_fork(node):
        return node.kind == "call" and node.args[0].kind == "identifier" and node.args[0].args[0] == "fork"

    def new(self, prefix):
        self.temp += 1
        return "__hm_" + prefix + str(self.temp)

    def with_targets(self, node):
        value = self.expression(node)
        # Static fill walls exist for host collision only. Authored area
        # setup and secret-door placement must see the original boundary.
        if value == 'Wall' and ((self.module.startswith('areas/') and self.definition.name == 'area_start')
                or (self.module == 'maincode.mod.gml' and self.definition.name == 'step' and node.line == 2359)):
            return 'scrHMAuthoredWalls105()'
        # The filter already snapshots unique instance IDs, including array
        # inputs. Do not recursively copy and deduplicate its result again.
        if (node.kind == 'call' and node.args[0].kind == 'identifier'
                and node.args[0].args[0] in {
                    'instances_matching', 'instances_matching_ne',
                    'instances_matching_ge', 'instances_matching_gt',
                    'instances_matching_le', 'instances_matching_lt'}):
            return value
        return 'scrHMInstances(' + value + ')'

    def local(self, name):
        return "_hm.vars." + name if self.async_mode else "_hml_" + name

    def identifier(self, value):
        if value in self.locals:
            return self.local(value)
        if value == 'background_color':
            return 'scrHMBackgroundColour105()'
        # NTT gives each loaded module its own global namespace. Sharing the
        # host's global struct silently cross-wires identically named sprites,
        # counters and options between independently loaded modules.
        if value == "global" and not self.module.startswith("tests/"):
            return "global.hm_module_vars[$ " + json.dumps(module_key(self.module)) + "]"
        if (not self.async_mode or self.native_scope) and value in {"self", "other"}:
            return "id" if value == "self" else "(scrHMOther(other))"
        if value in self.definitions[self.module]:
            return "hm_" + safe(self.module) + "_" + value
        if value == "null":
            return "undefined"
        if value in API:
            return API[value]
        if not self.async_mode and re.fullmatch(r"argument\d+", value):
            index = int(value[8:])
            if index < len(self.definition.parameters):
                return self.local(self.definition.parameters[index])
        if self.async_mode:
            if value == "self":
                return "_hm.scope"
            if value == "other":
                return "_hm.other_scope"
            if value == "argument_count":
                return "array_length(_hm.args)"
            if re.fullmatch(r"argument\d+", value):
                return "_hm.args[" + value[8:] + "]"
            if value == "argument":
                return "_hm.args"
        if re.fullmatch(r"alarm\d+", value):
            return "alarm[" + value[5:] + "]"
        return FIELDS.get(value, value)

    def scale(self, node):
        if self.module.startswith("tests/compiler"):
            return None
        if node.kind=="identifier" and node.args[0] not in self.locals:
            return SCALED_FIELDS.get(node.args[0])
        if node.kind=="member":
            if node.args[0].kind=="identifier" and node.args[0].args[0]=="global":
                return None
            return SCALED_FIELDS.get(node.args[1])
        return None

    @staticmethod
    def factor(power):
        return "timescale" if power==1 else "(timescale * timescale)"

    def increment(self, target, delta, post):
        field=target.args[0] if target.kind=="identifier" else target.args[1]
        scope="id" if target.kind=="identifier" else self.expression(target.args[0])
        return "scrHMScaledIncrement("+scope+", "+json.dumps(FIELDS.get(field,field))+", "+str(delta)+", "+str(post).lower()+", "+self.factor(self.scale(target))+")"

    def maxhealth_scope(self, node):
        if node.kind == "identifier" and node.args[0] == "maxhealth" and "maxhealth" not in self.locals:
            return "id"
        if node.kind == "member" and node.args[1] == "maxhealth":
            if node.args[0].kind == "identifier" and node.args[0].args[0] in {"global", "GameCont"}:
                return None
            return self.expression(node.args[0])
        return None

    def domain_alternatives(self, node):
        if node.kind in {"string", "number"}:
            return [node]
        if node.kind == "binary" and node.args[0] in {"||", "or"}:
            left, right = self.domain_alternatives(node.args[1]), self.domain_alternatives(node.args[2])
            if left and right: return left+right
        return None

    def expression(self, node, condition=False, lvalue=False):
        kind, args = node.kind, node.args
        if kind == "identifier":
            text=self.identifier(args[0])
            power=self.scale(node)
            return "("+text+" / "+self.factor(power)+")" if power and not lvalue else text
        if kind == "number":
            return args[0]
        if kind == "string":
            return json.dumps(args[0][1:-1], ensure_ascii=False)
        if kind == "array":
            return "[" + ", ".join(self.expression(child) for child in args) + "]"
        if kind == "member":
            target = self.expression(args[0])
            if args[0].kind not in {"identifier", "member", "index"}:
                target = "(" + target + ")"
            # Controller kill statistics and a module's global.kills counter
            # are not the per-enemy 'award kill credit' flag.
            preserve = args[0].kind == "identifier" and args[0].args[0] in {"global", "GameCont"}
            field=args[1]
            if not preserve and re.fullmatch(r"alarm\d+",field):
                text=target+".alarm["+field[5:]+"]"
            else:
                text=target + "." + (field if preserve else FIELDS.get(field, field))
            power=self.scale(node)
            return "("+text+" / "+self.factor(power)+")" if power and not lvalue else text
        if kind == "index":
            if args[0].kind == "identifier":
                name=args[0].args[0]
                if name in {"view_xview","view_yview"}:
                    assert len(args[2])==1 and not args[1]
                    return name
                if name=="view_object":
                    assert len(args[2])==1 and not args[1]
                    return "global.hm_camera_targets["+self.expression(args[2][0])+"]"
            if args[0].kind == "identifier" and (ROOT / "project/objects" / args[0].args[0]).is_dir():
                assert len(args[2]) == 1 and not args[1], "Unsupported indexed object lookup"
                return "instance_find(" + args[0].args[0] + ", " + self.expression(args[2][0]) + ")"
            return self.expression(args[0]) + "[" + args[1] + ", ".join(self.expression(child) for child in args[2]) + "]"
        if kind == "unary":
            if args[0] in {"++","--"} and self.scale(args[1]):
                return self.increment(args[1],1 if args[0]=="++" else -1,False)
            return "(" + args[0] + " " + self.expression(args[1], condition) + ")"
        if kind == "postfix":
            if self.scale(args[0]):
                return self.increment(args[0],1 if args[1]=="++" else -1,True)
            return "(" + self.expression(args[0]) + args[1] + ")"
        if kind == "binary":
            op, left, right = args
            assignments={"=","+=","-=","*=","/=","%=","&=","|=","^=","<<=",">>="}
            if op in assignments and not condition:
                if left.kind == 'identifier' and left.args[0] == 'background_color':
                    assert op == '='
                    self.calls.add('background_set_colour')
                    return 'background_set_colour('+self.expression(right)+')'
                scope=self.maxhealth_scope(left)
                if scope is not None:
                    self.calls.add("scrHMMaxHealthWrite")
                    return "scrHMMaxHealthWrite("+scope+", "+self.expression(right)+", "+json.dumps(op)+")"
                power=self.scale(left)
                rhs=self.expression(right)
                if power and op in {"=","+=","-="}:
                    rhs="("+rhs+") * "+self.factor(power)
                elif power and op not in {"*=","/="}:
                    raise ValueError(f"Unsupported dimensional assignment {op} at {self.module}:{node.line}")
                domain = self.domain(left)
                if domain and op == "=":
                    rhs = "scrHM"+domain+"Resolve("+rhs+")"
                return "("+self.expression(left,lvalue=True)+" "+op+" "+rhs+")"
            if op in {"in", "not in"}:
                text = "scrHMVariableExists(" + self.expression(right) + ", " + self.expression(left) + ")"
                self.calls.add("scrHMVariableExists")
                return "(!" + text + ")" if op == "not in" else text
            op = "==" if condition and op == "=" else op
            a, b = self.expression(left, condition), self.expression(right, condition)
            if op in {"==", "!=", "<>", ">", "<", ">=", "<="}:
                # The supplied Harpoon Gun spells its two permitted areas as
                # area=("oasis"||101). Interpret this explicit value list as
                # alternatives, rather than converting a string to a bool.
                alternatives = self.domain_alternatives(right)
                if self.domain(left) and right.kind == "binary" and alternatives and op in {"==", "!=", "<>"}:
                    joiner = " || " if op == "==" else " && "
                    return "("+joiner.join("("+a+" "+op+" scrHM"+self.domain(left)+"Resolve("+self.expression(item)+"))" for item in alternatives)+")"
                if self.domain(left): b = "scrHM"+self.domain(left)+"Resolve("+b+")"
                elif self.domain(right): a = "scrHM"+self.domain(right)+"Resolve("+a+")"
            return "(" + a + " " + op + " " + b + ")"
        if kind == "ternary":
            return "(" + self.expression(args[0], True) + " ? " + self.expression(args[1]) + " : " + self.expression(args[2]) + ")"
        if kind == "call":
            callee, arguments = args
            if self.is_fork(node):
                if self.fork_entry is None:
                    raise ValueError(f"Unlowered fork at {self.module}:{node.line}")
                return f"scrHMTaskFork(_hm, {self.fork_entry})"
            name = callee.args[0] if callee.kind == "identifier" else None
            if name in {"script_ref_create", "script_bind_draw", "script_bind_end_step"} and arguments:
                first = arguments[0]
                if first.kind == "string":
                    local_name = first.args[0][1:-1]
                    assert local_name in self.definitions[self.module], (self.module, node.line, local_name)
                    arguments = [Node("identifier", [local_name], first.line), *arguments[1:]]
            if name and name.startswith("sprite_") and "base64" in name:
                asset = self.artwork[(self.module, node.line)]
                resource = asset["native_resource"]
                if name.startswith("sprite_replace"):
                    self.calls.add("scrHMSpriteReplace")
                    return "scrHMSpriteReplace(" + self.expression(arguments[0]) + ", " + resource + ")"
                return resource
            text = self.expression(callee)
            if (name=="instance_destroy" and not arguments and
                    ((self.module=="maincode.mod.gml" and self.definition.name in {"shilling","versionnumber","StablePortal","PortalShrink","bigdogintro","sewerboi","spacesewerboi"})
                    or (self.module=="props.mod.gml" and self.definition.name in {"E","outsider_draw"}))):
                text="scrHMMenuDrawComplete"
            if (self.module == "bosses/titank.mod.gml" and self.definition.name == "wanttitank_step"
                    and name == "titank_create"):
                # The source deletes its spawner immediately after starting
                # this delayed, local-only entrance. Own that continuation
                # on the room controller until it enters the new boss scope.
                text = "scrHMTitankEntrance"
            if name:
                self.calls.add(name)
            values=[self.expression(child) for child in arguments]
            if name == "either" and arguments and self.domain(arguments[0]):
                domain=self.domain(arguments[0])
                values=values[:1]+["scrHM"+domain+"Resolve("+value+")" for value in values[1:]]
            return text + "(" + ", ".join(values) + ")"
        raise NotImplementedError((kind, node.line))

    def simple(self, node):
        kind, args = node.kind, node.args
        if kind == "empty":
            return ";"
        if kind == "expr":
            # Modern GML does not accept parenthesized assignment statements.
            text = self.expression(args[0])
            if args[0].kind in {"binary", "postfix", "unary"} and text.startswith("(") and text.endswith(")"):
                text = text[1:-1]
            if "(scrHMOther(other))" in text:
                # GMS2 statement lvalues cannot start with a parenthesized
                # function result. Resolve NTT's logical other in this exact
                # with scope, including callbacks entered from a coroutine.
                other = self.new("other")
                text = "var " + other + "=scrHMOther(other);\n" + text.replace("(scrHMOther(other))", other)
            text += ";"
            expression=args[0]
            target=None
            if expression.kind=='binary' and expression.args[0] in {'=','+=','-=','*=','/='}:
                target=expression.args[1]
            elif expression.kind=='postfix':target=expression.args[0]
            elif expression.kind=='unary' and expression.args[0] in {'++','--'}:target=expression.args[1]
            if self.draw_logic and target and (target.kind!='identifier' or target.args[0] not in self.locals):
                text='if(scrHMReadyTick()) { '+text+' }'
            return text
        if kind == "var":
            return "\n".join(("" if self.async_mode else "var ") + self.local(name) + (" = " + self.expression(init) if init else " = undefined") + ";"
                             for name, init in args)
        if kind == "macro":
            return "#macro " + args[0] + " " + self.expression(args[1])
        if kind == "return":
            return "return" + (" " + self.expression(args[0]) if args else "") + ";"
        if kind in {"break", "continue", "exit"}:
            if kind == "break" and self.sync_loop_stack and self.sync_loop_stack[-1] is not None:
                return self.sync_loop_stack[-1] + "=true; break;"
            return kind + ";"
        raise NotImplementedError((kind, node.line))

    def sync(self, node):
        kind, args = node.kind, node.args
        if kind == "block":
            return "{\n" + "\n".join(self.sync(child) for child in args) + "\n}"
        if kind == "if":
            condition=self.expression(args[0], True)
            if self.draw_logic and any(n.kind=='call' and n.args[0].kind=='identifier' and n.args[0].args[0]=='random' for n in walk(args[0])):
                condition='scrHMReadyTick() && ('+condition+')'
            text = "if (" + condition + ") {\n" + self.sync(args[1]) + "\n}"
            if args[2].kind != "empty":
                text += " else {\n" + self.sync(args[2]) + "\n}"
            return text
        if kind in {"while", "repeat"}:
            self.sync_loop_stack.append(None)
            body = self.sync(args[1])
            self.sync_loop_stack.pop()
            return kind + " (" + self.expression(args[0], kind == "while") + ") " + body
        if kind in {"do", "do_while"}:
            self.sync_loop_stack.append(None)
            body = self.sync(args[0])
            self.sync_loop_stack.pop()
            return "do " + body + (" until (" if kind == "do" else " until (!(") + self.expression(args[1], True) + (");" if kind=="do" else "));" )
        if kind == "for":
            init = self.sync(args[0]).rstrip(";")
            step = self.simple(Node("expr", [args[2]], node.line)).rstrip(";") if args[2] else ""
            self.sync_loop_stack.append(None)
            body = self.sync(args[3])
            self.sync_loop_stack.pop()
            return "for (" + init + "; " + self.expression(args[1], True) + "; " + step + ") " + body
        if kind == "with":
            items, index, flag = self.new("with"), self.new("index"), self.new("break")
            self.sync_loop_stack.append(flag)
            body = self.sync(args[1])
            self.sync_loop_stack.pop()
            return "{ var " + items + " = " + self.with_targets(args[0]) + ", " + flag + "=false;\nfor (var " + index + "=0; " + index + "<array_length(" + items + "); ++" + index + ") {\nif(instance_exists(" + items + "[" + index + "])) with (" + items + "[" + index + "]) {\n" + body + "\n}\nif(" + flag + ") break;\n}}"
        if kind == "switch":
            self.sync_loop_stack.append(None)
            text = "switch (" + self.expression(args[0]) + ") {\n"
            for label, body in args[1]:
                value=self.expression(label) if label else ""
                domain=self.domain(args[0])
                if domain and label: value="scrHM"+domain+"Resolve("+value+")"
                text += ("case " + value if label else "default") + ":\n" + "\n".join(self.sync(child) for child in body.args) + "\n"
            self.sync_loop_stack.pop()
            return text + "}"
        return self.simple(node)

    def emit(self):
        if not self.async_mode:
            params = ", ".join(self.local(name) for name in self.definition.parameters)
            return "function " + self.native_name + "(" + params + ") " + self.sync(self.definition.body)
        flow = Flow(self)
        entry = flow.compile(self.definition.body, 0)
        code = self.native_name + "_resume"
        text = "function " + self.native_name + "() {\nvar _args = [];\nfor(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);\n"
        parameters = json.dumps(self.definition.parameters)
        text += f"return scrHMTaskStart({code}, id, scrHMOther(other), _args, {entry}, {parameters});\n}}\n"
        text += f"function {code}(_hm) {{\nvar _budget=0;\nwhile(!_hm.done) {{\nassert(++_budget<100000,\"Hardmode runaway continuation: {self.native_name}\");\n"
        text += "if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }\n"
        text += "with (_hm.scope) { switch (_hm.pc) {\ncase 0: _hm.done=true; return;\n"
        for pc, (line, body) in flow.blocks.items():
            text += f"case {pc}: // {self.module}:{line}\n{body}\nbreak;\n"
        text += "default: throw \"Hardmode invalid continuation PC\";\n}}\n}\n}\n"
        return text


class Flow:
    def __init__(self, emitter):
        self.e = emitter
        self.blocks = {}
        self.next_pc = 1

    def reserve(self):
        pc = self.next_pc
        self.next_pc += 1
        return pc

    def set(self, pc, line, text):
        self.blocks[pc] = (line, text)
        return pc

    def add(self, line, text):
        return self.set(self.reserve(), line, text)

    def synchronous(self, node, breaks=0, continues=0):
        if not isinstance(node, Node): return True
        if node.kind in {"wait","return","exit"} or self.e.is_fork(node): return False
        if node.kind=="break" and breaks==0: return False
        if node.kind=="continue" and continues==0: return False
        loop=node.kind in {"with","while","do","do_while","repeat","for"}
        next_breaks=breaks+loop+(node.kind=="switch")
        next_continues=continues+loop
        def safe_child(child):
            if isinstance(child,Node): return self.synchronous(child,next_breaks,next_continues)
            if isinstance(child,(list,tuple)): return all(safe_child(c) for c in child)
            return True
        return all(safe_child(child) for child in node.args)

    def compile(self, node, after, break_to=None, continue_to=None):
        kind, args, line = node.kind, node.args, node.line
        if kind not in {"empty","expr","var","macro"} and self.synchronous(node):
            self.e.native_scope=True
            try: text=self.e.sync(node)
            finally: self.e.native_scope=False
            return self.add(line,text+f"\n_hm.pc={after};")
        if kind == "empty":
            return after
        if kind == "block":
            # Contiguous code without a suspension executes atomically as in
            # NTT. In particular, a wall may destroy itself and create its
            # replacement before leaving the current event scope.
            groups=[]
            pending=[]
            for child in args:
                if self.synchronous(child):
                    pending.append(child)
                else:
                    if pending:
                        groups.append(Node('block',pending,pending[0].line));pending=[]
                    groups.append(child)
            if pending: groups.append(Node('block',pending,pending[0].line))
            for child in reversed(groups):
                after = self.compile(child, after, break_to, continue_to)
            return after
        if kind == "if":
            yes = self.compile(args[1], after, break_to, continue_to)
            no = self.compile(args[2], after, break_to, continue_to)
            previous = self.e.fork_entry
            self.e.fork_entry = yes
            expression = self.e.expression(args[0], True)
            self.e.fork_entry = previous
            return self.add(line, f"_hm.pc = ({expression}) ? {yes} : {no};")
        if kind == "wait":
            duration = self.e.expression(args[0]) if args else "1"
            return self.add(line, f"_hm.wait_ticks=max(0,{duration}); _hm.pc={after}; return;")
        if kind in {"return", "exit"}:
            result = self.e.expression(args[0]) if args else "undefined"
            return self.add(line, f"_hm.result={result}; _hm.done=true; return;")
        if kind in {"break", "continue"}:
            dest = break_to if kind == "break" else continue_to
            if dest is None:
                raise ValueError(f"Unbound {kind} at {self.e.module}:{line}")
            return self.add(line, f"_hm.pc={dest};")
        if kind == "with":
            done = self.add(line, "scrHMTaskWithNext(_hm);")
            abort = self.add(line, "scrHMTaskWithAbort(_hm);")
            body = self.compile(args[1], done, abort, done)
            targets = self.e.with_targets(args[0])
            return self.add(line, f"scrHMTaskWithEnter(_hm,{targets},{body},{after});")
        if kind in {"while", "do", "do_while", "repeat", "for"}:
            check = self.reserve()
            if kind == "repeat":
                key = self.e.new("repeat")
                decrement = self.add(line, f"_hm.vars.{key}--; _hm.pc={check};")
                body = self.compile(args[1], decrement, after, decrement)
                self.set(check, line, f"_hm.pc=(_hm.vars.{key}>0)?{body}:{after};")
                return self.add(line, f"_hm.vars.{key}=round({self.e.expression(args[0])}); _hm.pc={check};")
            if kind == "for":
                increment = self.add(line, (self.e.simple(Node("expr", [args[2]], line)) if args[2] else "") + f" _hm.pc={check};")
                body = self.compile(args[3], increment, after, increment)
                self.set(check, line, f"_hm.pc=({self.e.expression(args[1],True)})?{body}:{after};")
                return self.compile(args[0], check, break_to, continue_to)
            if kind == "while":
                body = self.compile(args[1], check, after, check)
                self.set(check, line, f"_hm.pc=({self.e.expression(args[0],True)})?{body}:{after};")
                return check
            body = self.compile(args[0], check, after, check)
            yes, no = (after, body) if kind == "do" else (body, after)
            self.set(check, line, f"_hm.pc=({self.e.expression(args[1],True)})?{yes}:{no};")
            return body
        if kind == "switch":
            key = self.e.new("switch")
            case_entries = []
            next_case = after
            for label, body in reversed(args[1]):
                next_case = self.compile(body, next_case, after, continue_to)
                case_entries.insert(0, (label, next_case))
            default = next((entry for label, entry in case_entries if label is None), after)
            text = f"_hm.vars.{key}={self.e.expression(args[0])};\n"
            for label, entry in case_entries:
                if label:
                    value=self.e.expression(label)
                    domain=self.e.domain(args[0])
                    if domain: value="scrHM"+domain+"Resolve("+value+")"
                    text += f"if (_hm.vars.{key}=={value}) {{_hm.pc={entry};}} else "
            text += f"{{_hm.pc={default};}}"
            return self.add(line, text)
        return self.add(line, self.e.simple(node) + f"\n_hm.pc={after};")


def main():
    modules, failures = parse_inventory(ROOT)
    assert not failures, failures
    artwork = json.loads((ROOT / "artwork-manifest.json").read_text(encoding="utf8"))["artwork"]
    art_map = {(row["source"], row["line"]): row for row in artwork}
    names = {path: {definition.name for definition in definitions} for path, definitions in modules.items()}
    output = ROOT / "generated"
    output.mkdir(exist_ok=True)
    manifest = []
    for path, definitions in modules.items():
        text, records = [], []
        for definition in definitions:
            ast_repair(path, definition, walk)
            ast_repair104(path, definition, walk)
            ast_repair107(path, definition, walk)
            if path == "maincode.mod.gml" and definition.name == "step":
                # The two original setrads loops are superseded by the tested
                # reversible level-cap policy. Retain the absorption mechanic
                # and every subsequent source statement unchanged.
                removed = [n for n in definition.body.args if 238 <= n.line <= 251]
                assert len(removed) == 2 and all(n.kind == "with" for n in removed)
                definition.body.args[:] = [n for n in definition.body.args if n not in removed]
            emitter = Emitter(path, definition, names, art_map)
            emitted=emitter.emit()
            if path=='enemies.mod.gml' and definition.name=='elitebanditsleep_step':
                emitted=emitted.replace('hm_enemies_mod_gml_elitebandit_create(', 'scrHMBanditWake(')
                # Modern instance_change(true) runs the old enemy Destroy,
                # producing a live knockback corpse during an ordinary wake.
                emitted=emitted.replace('instance_change(Wind, 1);','instance_change(Wind, 0);')
            if path=='enemies.mod.gml' and definition.name=='step':
                # Native actors can retain a positive ID after player death.
                emitted=emitted.replace('(target > 0)', 'instance_exists(target)')
                emitted=emitted.replace('(distance_to_object(target) < 150)', '(instance_exists(target) && (distance_to_object(target) < 150))')
                emitted=emitted.replace('(smoking <= 0)', '((smoking <= 0) && instance_exists(target))')
                emitted=emitted.replace('(target.object_index == Player)', '(instance_exists(target) && (target.object_index == Player))')
            if path=='bosses/bossintros.mod.gml' and definition.name=='draw_gui':
                top='scrHMDrawSprite(sprLetterbox, letterind, 0, 0);'
                bottom='scrHMDrawSpriteExt(sprLetterbox, letterind, view_width, view_height, (- 1), (- 1), 0, c_white, 1);'
                assert top in emitted and bottom in emitted
                emitted=emitted.replace(top,'scrHMDrawBossLetterbox(letterind);').replace(bottom,'')
            if path=='bosses/scorpionboss.mod.gml' and definition.name=='scorpionboss_step':
                # The hurt retaliation uses a/d before their later var declarations.
                # Capture the current target direction/distance before either fork.
                marker='var _args = [];'
                init=('var _target=instance_nearest(x,y,Player);\n'
                      'var _a=instance_exists(_target)?point_direction(x,y,_target.x,_target.y):direction;\n'
                      'var _d=instance_exists(_target)?point_distance(x,y,_target.x,_target.y):128;\n')
                emitted=emitted.replace(marker,init+marker,1)
                emitted=emitted.replace(', _args, ', ', [_a,_d], ',1).replace(', []);\n}', ', ["a","d"]);\n}',1)

            if path=='areas/venuz.area.gml' and definition.name=='__load':
                layouts=[n.args[2].args[0][1:-1] for n in walk(definition.body)
                         if n.kind=='binary' and n.args[0]=='='
                         and n.args[1].kind=='member' and n.args[1].args[1]=='ps']
                assert len(layouts)==1
                mask=prison_door_mask(layouts[0])
                emitted=emitted[:-1]+'\nglobal.hm_module_vars[$ "area:venuz"].psd='+json.dumps(mask)+';\n}'
            if path=='bosses/ravenboss.mod.gml' and definition.name=='wantravenboss_step':
                emitted='function '+emitter.native_name+'() {scrHMRavenSpawnStep();}'
            emitted=emitted_repair(path,definition.name,emitted)
            emitted=emitted_repair104(path,definition.name,emitted)
            emitted=emitted_repair105(path,definition.name,emitted)
            emitted=emitted_repair106(path,definition.name,emitted)
            emitted=emitted_repair107(path,definition.name,emitted)
            text.append(f"// Source {path}:{definition.line}; {definition.name}\n" + emitted)
            records.append({"name": definition.name, "line": definition.line, "native_name": emitter.native_name,
                            "uses_coroutine": emitter.async_mode, "calls": sorted(emitter.calls)})
        destination = output / (safe(path) + ".gml")
        destination.write_text("\n\n".join(text) + "\n", encoding="utf8")
        manifest.append({"source": path, "generated": destination.relative_to(ROOT).as_posix(), "definitions": records})
    report = {"status": "GENERATED_NOT_ENABLED_OR_GAMEPLAY_VERIFIED", "modules": manifest,
              "definitions_excluding_load_hooks": sum(len(row["definitions"]) - 1 for row in manifest),
              "async_functions": sum(record["uses_coroutine"] for row in manifest for record in row["definitions"])}
    (ROOT / "native-compilation-map.json").write_text(json.dumps(report, indent=2) + "\n", encoding="utf8")
    print(json.dumps({k: v for k, v in report.items() if k != "modules"}))


if __name__ == "__main__":
    main()
