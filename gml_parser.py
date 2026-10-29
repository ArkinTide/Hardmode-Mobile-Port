"""Parse the legacy NTT subset before any native code is generated.

No mod source is executed by this module. Positions survive parsing so missing
semantics and diagnostics can be attributed to their original source lines.
"""
from dataclasses import dataclass
import json
import re
from pathlib import Path

from gml_frontend import tokenize


@dataclass
class Node:
    kind: str
    args: list
    line: int


@dataclass
class Definition:
    name: str
    parameters: list
    body: Node
    line: int


class Parser:
    PRECEDENCE = {
        "=": 1, "+=": 1, "-=": 1, "*=": 1, "/=": 1, "%=": 1, "&=": 1, "|=": 1, "^=": 1,
        "?": 2, "or": 3, "||": 3, "xor": 4, "^^": 4, "and": 5, "&&": 5,
        "==": 6, "!=": 6, "<>": 6, "<": 7, ">": 7, "<=": 7, ">=": 7, "in": 7, "not in": 7,
        "|": 8, "^": 9, "&": 10, "<<": 11, ">>": 11,
        "+": 12, "-": 12, "*": 13, "/": 13, "div": 13, "mod": 13, "%": 13,
    }
    ASSIGN = {"=", "+=", "-=", "*=", "/=", "%=", "&=", "|=", "^="}

    def __init__(self, text, source="<text>"):
        self.tokens = tokenize(text)
        self.index = 0
        self.source = source

    @property
    def current(self):
        return self.tokens[self.index] if self.index < len(self.tokens) else None

    def value(self, offset=0):
        pos = self.index + offset
        return self.tokens[pos].text if pos < len(self.tokens) else "<eof>"

    def error(self, message):
        token = self.current
        raise SyntaxError(f"{self.source}:{token.line if token else 'EOF'}: {message}; got {self.value()!r}")

    def accept(self, value):
        if self.value() == value:
            self.index += 1
            return True
        return False

    def take(self, value=None):
        token = self.current
        if not token or (value is not None and token.text != value):
            self.error(f"Expected {value}")
        self.index += 1
        return token

    def expression(self, minimum=0, condition=False):
        token = self.take()
        value = token.text
        if value in {"+", "-", "!", "~", "not", "++", "--"}:
            left = Node("unary", [value, self.expression(14, condition)], token.line)
        elif value == "(":
            left = self.expression(condition=condition)
            self.take(")")
        elif value == "[":
            items = []
            while not self.accept("]"):
                items.append(self.expression(condition=True))
                if not self.accept(","):
                    self.take("]")
                    break
            left = Node("array", items, token.line)
        elif token.kind in {"identifier", "number", "string"}:
            left = Node(token.kind, [value], token.line)
        else:
            self.error(f"Unexpected expression token {value}")

        while self.current:
            op = self.value()
            if op == ".":
                self.take()
                field = self.take()
                if field.kind != "identifier":
                    self.error("Expected field name")
                left = Node("member", [left, field.text], left.line)
            elif op == "[":
                self.take()
                accessor = self.take().text if self.value() in {"?", "|", "#", "@", "$"} else ""
                indexes = [self.expression(condition=True)]
                while self.accept(","):
                    indexes.append(self.expression(condition=True))
                self.take("]")
                left = Node("index", [left, accessor, indexes], left.line)
            elif op == "(":
                self.take()
                arguments = []
                while not self.accept(")"):
                    arguments.append(self.expression(condition=True))
                    if not self.accept(","):
                        self.take(")")
                        break
                left = Node("call", [left, arguments], left.line)
            elif op in {"++", "--"}:
                self.take()
                left = Node("postfix", [left, op], left.line)
            else:
                if op == "not" and self.value(1) == "in":
                    op = "not in"
                precedence = 6 if op == "=" and condition else self.PRECEDENCE.get(op, -1)
                if precedence < minimum:
                    break
                self.take()
                if op == "not in":
                    self.take("in")
                if op == "?":
                    yes = self.expression(condition=True)
                    self.take(":")
                    no = self.expression(precedence, True)
                    left = Node("ternary", [left, yes, no], left.line)
                else:
                    assignment = op in self.ASSIGN and not (op == "=" and condition)
                    right = self.expression(precedence if assignment else precedence + 1, condition or assignment)
                    left = Node("binary", ["==" if op == "=" and condition else op, left, right], left.line)
        return left

    def statement(self):
        token = self.current
        value = self.value()
        if self.accept(";"):
            return Node("empty", [], token.line)
        if self.accept("{"):
            body = []
            while not self.accept("}"):
                if not self.current:
                    self.error("Unclosed block")
                body.append(self.statement())
            return Node("block", body, token.line)
        if self.accept("if"):
            test = self.expression(condition=True)
            yes = self.statement()
            while self.accept(";"):
                pass
            no = self.statement() if self.accept("else") else Node("empty", [], token.line)
            return Node("if", [test, yes, no], token.line)
        if value in {"while", "repeat", "with"}:
            self.take()
            target = self.expression(condition=True)
            return Node(value, [target, self.statement()], token.line)
        if self.accept("do"):
            body = self.statement()
            if self.accept("until"):
                return Node("do", [body, self.expression(condition=True)], token.line)
            self.take("while")
            return Node("do_while", [body, self.expression(condition=True)], token.line)
        if self.accept("for"):
            self.take("(")
            init = self.statement() if self.value() != ";" else Node("empty", [], token.line)
            self.accept(";")
            test = self.expression(condition=True) if self.value() != ";" else Node("number", ["1"], token.line)
            self.take(";")
            step = self.expression() if self.value() != ")" else None
            self.take(")")
            return Node("for", [init, test, step, self.statement()], token.line)
        if self.accept("switch"):
            test = self.expression(condition=True)
            self.take("{")
            cases = []
            while not self.accept("}"):
                label = self.take()
                if label.text == "case":
                    match = self.expression(2, True)
                elif label.text == "default":
                    match = None
                else:
                    self.error("Expected case/default")
                self.take(":")
                body = []
                while self.value() not in {"case", "default", "}", "<eof>"}:
                    body.append(self.statement())
                cases.append((match, Node("block", body, label.line)))
            return Node("switch", [test, cases], token.line)
        if self.accept("var"):
            declarations = []
            while True:
                name = self.take()
                if name.kind != "identifier":
                    self.error("Expected local name")
                init = self.expression(condition=True) if self.accept("=") else None
                declarations.append((name.text, init))
                if not self.accept(","):
                    break
            return Node("var", declarations, token.line)
        if self.accept("#"):
            self.take("macro")
            name = self.take().text
            return Node("macro", [name, self.expression()], token.line)
        if value in {"return", "exit", "break", "continue", "wait"}:
            self.take()
            expression = None
            if value in {"return", "wait"} and self.value() not in {";", "}", "<eof>"}:
                if self.current.line == token.line or value == "wait":
                    expression = self.expression(condition=True)
            return Node(value, [expression] if expression else [], token.line)
        if value in {"else", "case", "default", "until", "#"}:
            self.error("Unexpected statement boundary")
        return Node("expr", [self.expression()], token.line)

    def all(self):
        body = []
        while self.current:
            before = self.index
            body.append(self.statement())
            assert self.index > before
        return Node("block", body, body[0].line if body else 1)


def definitions(text, source):
    pattern = re.compile(r"^\s*#define\s+(\w+)(?:[ \t]*\(([^\r\n]*)\))?[^\S\r\n]*", re.M)
    headers = list(pattern.finditer(text))
    parts = [("__load", [], 0, headers[0].start() if headers else len(text))]
    for i, match in enumerate(headers):
        parts.append((match[1], [x.strip() for x in (match[2] or "").split(",") if x.strip()],
                      match.end(), headers[i + 1].start() if i + 1 < len(headers) else len(text)))
    result = []
    for name, params, start, stop in parts:
        # Retain line positions without carrying the giant image literals into
        # generated diagnostics or the eventual control-flow representation.
        prefix = "\n" * text.count("\n", 0, start)
        result.append(Definition(name, params, Parser(prefix + text[start:stop], source + "::" + name).all(),
                                 text.count("\n", 0, start) + 1))
    return result


def parse_inventory(root):
    inventory = json.loads((root / "mod-inventory.json").read_text(encoding="utf8"))
    result, failures = {}, []
    for module in inventory["modules"]:
        path = root / "reference/hardmode-b24" / module["path"]
        try:
            result[module["path"]] = definitions(path.read_text(encoding="utf8"), module["path"])
        except SyntaxError as error:
            failures.append(module["path"] + ": " + str(error))
    return result, failures


if __name__ == "__main__":
    root = Path(__file__).resolve().parent
    parsed, failures = parse_inventory(root)
    print(json.dumps({"parsed_modules": len(parsed), "errors": failures}, indent=2))
    if failures:
        raise SystemExit(1)
