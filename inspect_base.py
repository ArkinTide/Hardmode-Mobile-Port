"""Read-only original NTT native event inspection; no game code is executed."""
from pathlib import Path
import re,struct,sys,math
ROOT=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT.parent/'native-deps'))
from capstone import Cs,CS_ARCH_X86,CS_MODE_32
b=Path('D:/Steam/steamapps/common/Nuclear Throne/9940/NuclearThroneTogether.exe').read_bytes()
pe=struct.unpack_from('<I',b,0x3c)[0];opt=pe+24
base=struct.unpack_from('<I',b,opt+28)[0]
sh=opt+struct.unpack_from('<H',b,pe+20)[0]
sections=[struct.unpack_from('<8sIIII',b,sh+40*i)[1:] for i in range(struct.unpack_from('<H',b,pe+6)[0])]
def offset(va):
    for vs,rva,sz,raw in sections:
        if rva<=va-base<rva+sz:return raw+va-base-rva
def string(va):
    p=offset(va)
    if p is None:return ''
    raw=b[p:b.find(b'\0',p,p+180)]
    return raw.decode('ascii','replace') if raw and all(32<=c<127 for c in raw) else ''
names={int(a,16):n for a,n in (line.split('\t') for line in (ROOT/'ntt-contracts-names.tsv').read_text().splitlines())}
variables={int(a,16):n for a,n in (line.split('\t') for line in (ROOT.parent/'ntte-complete/ntt-native-variables.tsv').read_text().splitlines())}
md=Cs(CS_ARCH_X86,CS_MODE_32);ordered=sorted(names)
for target in sys.argv[1:]:
    lines=[]
    for va,n in names.items():
        if not (n.startswith('gml_Object_'+target+'_') or n=='gml_Script_'+target or n==target):continue
        end=next((a for a in ordered if a>va),va+0x1000)
        p=offset(va);lines.append(f'\n=== {n} {va:08x} size {end-va} ===')
        for ins in md.disasm(b[p:p+min(end-va,0x10000)],va):
            extra=''
            for h in re.findall(r'0x[0-9a-f]+',ins.op_str):
                number=int(h,16)
                if number in names:extra+=' ; '+names[number]
                elif string(number):extra+=' ; '+repr(string(number))
                else:
                    pvalue=offset(number)
                    if pvalue is not None and pvalue>=4:
                        if 'qword ptr [0x' in ins.op_str:
                            rawvalue=struct.unpack_from('<d',b,pvalue)[0]
                            if math.isfinite(rawvalue) and (rawvalue==0 or 1e-8<=abs(rawvalue)<=1e7):extra+=' ; raw-double '+str(rawvalue)
                        label=string(struct.unpack_from('<I',b,pvalue-4)[0])
                        if re.fullmatch(r'[A-Za-z_][A-Za-z_0-9]*',label):extra+=' ; runtime '+label
                        if pvalue+16<len(b) and struct.unpack_from('<I',b,pvalue+12)[0] in (0,1,2):
                            value=struct.unpack_from('<d',b,pvalue)[0]
                            if math.isfinite(value) and (value==0 or 1e-8<=abs(value)<=1e7):extra+=' ; constant '+str(value)
            match=re.search(r'add\s+\w+, 0x([a-f0-9]+)$',ins.mnemonic+' '+ins.op_str)
            if match:
                number=int(match[1],16)
                if number%16==0 and number//16 in variables:extra+=' ; field '+variables[number//16]
            lines.append(f'{ins.address:08x} {ins.mnemonic:8s} {ins.op_str}{extra}')
    (ROOT/('original-'+target+'.txt')).write_text('\n'.join(lines)+'\n',encoding='utf8')
    print(target,len(lines),'instructions')
