"""Ship a portable Windows executable and only its required game resources."""
from pathlib import Path
from datetime import datetime,timezone
import argparse,hashlib,json,re,shutil,subprocess,zipfile
import test_volume
from release_config import VERSION,DIRECTORY

ROOT=Path(__file__).resolve().parent
OUT=ROOT/DIRECTORY
BUILD=ROOT/'build-windows'
NAME=f'NuclearThrone.Hardmode-Windows-{VERSION}'
STAGE=ROOT/'deliverables'/NAME
RUNTIME=Path('C:/ProgramData/GameMakerStudio2-LTS2026/Cache/runtimes/runtime-2026.0.0.23/windows/x64/Runner.exe')
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()

def main():
    assert VERSION=='1.0.10'
    # The user's ordering: finish and publish mobile before generating Windows.
    publication=json.loads((OUT/'publication-receipt.json').read_text(encoding='utf8'))
    assert publication['status']=='PASS' and publication['version']==VERSION
    delivery=json.loads((OUT/'delivery-receipt.json').read_text(encoding='utf8'))
    assert delivery['status']=='PASS'
    assert sha(BUILD/'nuclearthronemobile.win')==delivery['final_desktop_vm_sha256']
    assert not (BUILD/'.vm-test-in-use.json').exists()
    STAGE.mkdir(parents=True,exist_ok=True)
    files={'NuclearThrone-Hardmode.exe':RUNTIME,'data.win':BUILD/'nuclearthronemobile.win',
        'LICENSE.txt':ROOT/'original-source/LICENSE',
        'GameMaker-runtime-notice.txt':ROOT/'project/options/windows/installer/license.txt'}
    for name in ('execute_shell_simple_ext_x64.dll','options.ini','sdl2.txt','sdl2license.txt','controllerblacklist.csv','controllertypes.csv'):
        files[name]=BUILD/name
    files.update({p.name:p for p in BUILD.glob('*.ogg')})
    for folder in ('lang','lang_mobile','legacy_localizations'):
        files.update({p.relative_to(BUILD).as_posix():p for p in (BUILD/folder).rglob('*') if p.is_file()})
    for relative,source in files.items():
        assert source.is_file(),source
        destination=STAGE/relative;destination.parent.mkdir(parents=True,exist_ok=True)
        shutil.copyfile(source,destination)
    (STAGE/'Start-Hardmode.cmd').write_bytes(b'@echo off\r\ncd /d "%~dp0"\r\nstart "" "%~dp0NuclearThrone-Hardmode.exe" -game "%~dp0data.win"\r\n')
    (STAGE/'README.txt').write_text(f'''Nuclear Throne: Hardmode {VERSION} — Windows x64

解压整个压缩包，然后运行 NuclearThrone-Hardmode.exe 或 Start-Hardmode.cmd。
请保留 data.win、音频、语言文件及 DLL；不需要 GameMaker 编辑器。

键鼠模式支持鼠标滚轮向上／向下切换武器，空格换枪仍可使用。
暂停、控制台、设置或演出锁定期间不会响应换枪。
30／60帧逻辑均验证；正常游玩音量按游戏设置。

这是相同移动工程的 Windows 便携构建，可能保留部分移动端界面。
源码：https://github.com/ArkinTide/Hardmode-Mobile-Port
APK／IPA：https://mega.nz/folder/7TY3wZRB#PgQeCYQzxvrVGjfjX6YefA
''',encoding='utf8')
    manifest={p.relative_to(STAGE).as_posix():sha(p) for p in STAGE.rglob('*') if p.is_file()}
    assert len(manifest)>100 and all('test-' not in p and not p.endswith('.sav') for p in manifest)
    receipts=[]
    # Exercise the shipped executable and its automatic data.win discovery,
    # without -game or a dependency on the developer runtime path.
    for rate in (30,60):
        scenario=f'1,1,0,{rate},90,42,windows110'
        log=OUT/f'packaged-windows-{rate}.log'
        state=OUT/f'packaged-windows-state-{rate}';state.mkdir(exist_ok=True)
        with log.open('wb') as stream:
            process=subprocess.Popen([str(STAGE/'NuclearThrone-Hardmode.exe'),
                '--hardmode-gameplay-tests','--hardmode-scenario='+scenario,
                '--hardmode-test-root='+state.as_posix()],cwd=STAGE,stdout=stream,stderr=subprocess.STDOUT,
                creationflags=subprocess.CREATE_NO_WINDOW)
            helper=test_volume.configure(process)
            try:code=process.wait(timeout=65)
            except subprocess.TimeoutExpired:process.terminate();process.wait(timeout=5);raise
            test_volume.verify(helper)
        text=log.read_text(encoding='utf8',errors='replace')
        match=re.search(r'HARDMODE GAMEPLAY RESULT (\{[^\r\n]+\})',text)
        assert code==0 and match and 'HARDMODE GAMEPLAY FAILED' not in text,text[-2500:]
        result=json.loads(match[1]);assert result['checks']==18
        receipts.append(result)
    for relative,digest in manifest.items():assert sha(STAGE/relative)==digest,relative
    # No test logs, generated screenshots or isolated test saves enter the ZIP.
    archive=ROOT/'deliverables'/(NAME+'.zip')
    with zipfile.ZipFile(archive,'w',zipfile.ZIP_DEFLATED,compresslevel=6) as z:
        for relative in sorted(manifest):z.write(STAGE/relative,NAME+'/'+relative)
    with zipfile.ZipFile(archive) as z:
        assert z.testzip() is None and len(z.namelist())==len(manifest)
        assert hashlib.sha256(z.read(NAME+'/data.win')).hexdigest()==delivery['final_desktop_vm_sha256']
    report={'status':'PASS','version':VERSION,'path':archive.relative_to(ROOT).as_posix(),
        'sha256':sha(archive),'bytes':archive.stat().st_size,'files':manifest,
        'desktop_vm_sha256':delivery['final_desktop_vm_sha256'],
        'shipped_executable_smoke_30_60':receipts,'automatic_data_win_discovery':True,
        'wheel_checks_use_synthetic_samples_with_real_player_step':True,'physical_mouse_automation':False,
        'verified_utc':datetime.now(timezone.utc).isoformat()}
    archive.with_suffix('.validation.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    (OUT/'windows-delivery-receipt.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    print('Windows portable PASS:',archive,'bytes',report['bytes'],'SHA256',report['sha256'])

if __name__=='__main__':main()
