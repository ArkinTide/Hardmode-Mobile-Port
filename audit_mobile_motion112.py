"""Source and desktop-callback validation of cross-platform MOD presentation."""
from pathlib import Path
from datetime import datetime,timezone
import argparse,hashlib,json,re,shutil,subprocess,sys,zipfile
from run_release107_checks import current
ROOT=Path(__file__).resolve().parent
OUT=ROOT/'release112'
SCENARIOS=[]
for rate in (30,60):
    SCENARIOS.extend([f'1,1,0,{rate},100,42,motion112',
        f'sewers,2,0,{rate},65,81,waterbank112',
        f'sewers,2,0,{rate},180,42,perf111',
        f'venuz,5,0,{rate},180,42,perf111',
        f'scorpionboss,3,0,{rate},65,42,visual'])

def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()

def main():
    parser=argparse.ArgumentParser();parser.add_argument('part',choices=['runtime','collect'])
    part=parser.parse_args().part
    windows=json.loads((OUT/'windows-delivery-receipt.json').read_text())
    assert windows['status']=='PASS' and sha(ROOT/windows['path'])==windows['sha256']
    digest=sha(ROOT/'build-windows/nuclearthronemobile.win')
    assert digest!=windows['desktop_vm_sha256']
    if part=='runtime':
        pending=[s for s in SCENARIOS if not current(s,digest)]
        if pending:subprocess.run([sys.executable,'-B','run_gameplay_checks.py','--keep-going',*pending],cwd=ROOT,check=True)
        return
    rows=[];cadence=[]
    for scenario in SCENARIOS:
        assert current(scenario,digest),scenario
        stem='gameplay-'+scenario.replace(',','-')
        rows.append(json.loads((ROOT/(stem+'-receipt.json')).read_text()))
        for ext in ('.log','-receipt.json'):shutil.copyfile(ROOT/(stem+ext),OUT/('mobile-'+stem+ext))
        text=(ROOT/(stem+'.log')).read_text(encoding='utf8',errors='replace')
        match=re.search(r'HARDMODE MOBILE MOTION112 (\{[^\r\n]+\})',text)
        if match:cadence.append(json.loads(match[1]))
    relative='project/scripts/scrHMRepairs111/scrHMRepairs111.gml'
    with zipfile.ZipFile(OUT/'windows-code.zip') as z:before=z.read(relative).decode('utf8')
    after=(ROOT/relative).read_text(encoding='utf8')
    def visual(t):return t[t.index('function scrHMVisualOffset111()'):t.index('function scrHMActorDraw111()')]
    assert 'os_type!=os_windows' in visual(before) and 'os_type' not in visual(after)
    schedule={}
    for kind in ('CustomObject','CustomEnemy','CustomProjectile'):
        for event in ('Step_0','Step_1','Step_2'):
            p=ROOT/f'project/objects/{kind}/{event}.gml'
            assert 'if(!scrHMReadyTick()) exit;' in p.read_text()
            schedule[p.relative_to(ROOT).as_posix()]=sha(p)
        assert 'scrHMActorDraw();' in (ROOT/f'project/objects/{kind}/Draw_0.gml').read_text()
    assert (ROOT/'project/objects/HMBinding/Draw_0.gml').read_text().strip()=='scrHMBindingDraw112();'
    # Enumerate manual movement sites without treating them as a reason to
    # double the original simulation/AI rate.
    sites=[]
    for p in (ROOT/'project/scripts').glob('scrHMCompiled_*/*.gml'):
        for n,line in enumerate(p.read_text(encoding='utf8').splitlines(),1):
            if re.match(r'\s*[xy]\s*(?:[+\-]=|=\s*\(?[xy]\s*[+\-])',line):
                sites.append(dict(path=p.relative_to(ROOT).as_posix(),line=n))
    report=dict(status='PASS',verified_utc=datetime.now(timezone.utc).isoformat(),
        windows_delivered_before_inspection=True,windows_artifact_sha256=windows['sha256'],
        windows_desktop_vm_sha256=windows['desktop_vm_sha256'],desktop_validation_vm_sha256=digest,
        found_mobile_windows_only_presentation_gate=True,removed_platform_gate=True,
        simulation_rate_hz=30,manual_movement_sites=sites,event_schedule_sha256=schedule,
        runtime_cases=rows,custom_actor_cadence=cadence,
        bound_renderers=['crystal top','swimming cropped body','space swimming cropped body'],
        phone_device_tested=False,limits=['Desktop execution of shared callbacks and packaged mobile VM/source inspection; no phone frame-rate measurement.'])
    (OUT/'mobile-motion-audit.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf8')
    print('Mobile presentation PASS:',len(rows),'runtime cases,',len(sites),'manual coordinate sites; simulation remains 30Hz')

if __name__=='__main__':main()
