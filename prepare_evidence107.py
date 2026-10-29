"""Derive version-specific collectors without changing retained release evidence."""
from pathlib import Path

ROOT = Path(__file__).resolve().parent


def main():
    source = (ROOT/'audit_mobile_storage106.py').read_text(encoding='utf8')
    (ROOT/'audit_mobile_storage107.py').write_text(source.replace('release106/', 'release107/'), encoding='utf8')

    source = (ROOT/'collect_visual106.py').read_text(encoding='utf8')
    source = source.replace("OUT=ROOT/'release106'", "OUT=ROOT/'release107'")
    # Include area and subarea: three FRAME106 scenarios otherwise overwrite
    # each other's capture and hide a different map from visual review.
    source = source.replace("scenario.split(',')[6]+'-'+scenario.split(',')[3]+'-'+p.name",
                            "'-'.join(scenario.split(',')[:4])+'-'+scenario.split(',')[6]+'-'+p.name")
    source = source.replace("world=[OUT/f'{mode}-{rate}-{mode}-{tick}.png' for mode,tick in\n"
                            "           [('water104',26),('oasis104',15),('walls104',246)] for rate in (30,60)]",
                            "world=[OUT/f'{area}-{sub}-0-{rate}-{mode}-{mode}-{tick}.png' for area,sub,mode,tick in\n"
                            "           [('sewers',2,'water104',26),('oasis',1,'oasis104',15),('1',1,'walls104',246)] for rate in (30,60)]")
    source = source.replace("f'intro104-{rate}-intro104-{tick}.png'", "f'1-1-0-{rate}-intro104-intro104-{tick}.png'")
    source = source.replace("Other small helper profiles may share desktop CPU/GPU with a second isolated regression process.",
                            "All release107 Runner scenarios execute sequentially.")
    marker = "    (OUT/'visual-images.json').write_text"
    addition = '''    latest=[]
    for rate in (30,60):
        for area,sub,loop,ticks,mode in [
            ('venuz',1,0,50,'prompt107'),('venuz',1,0,190,'trail107'),
            ('venuz',1,0,220,'retry107'),('venuz',400,0,220,'retry107'),
            ('HQ',1,0,55,'police107'),('elevator',3,0,55,'police107'),
            ('junkyard',4,0,340,'junk107'),('junkyard',5,0,340,'junk107'),
            ('cavesinv',3,0,270,'cavewalls107'),('venuz',1,0,45,'car107'),
            ('throne',1,0,50,'fall107'),
            ('venuz',10,0,160,'portraitprofile107'),('throne',1,0,160,'portraitprofile107')]:
            scenario=f'{area},{sub},{loop},{rate},{ticks},42,{mode}'
            if mode=='retry107':scenario+=',Simplified Chinese'
            latest+=collect(scenario,'*.png')
            log=(ROOT/('gameplay-'+scenario.replace(',','-')+'.log')).read_text(encoding='utf8',errors='replace')
            for record in re.findall(r'HARDMODE PORTRAIT107 (\\{[^\\r\\n]+\\})',log):
                item=json.loads(record)
                import statistics
                def summarize(rows):
                    values=sorted(r[1] for r in rows)
                    return {'frames':len(values),'median_us':statistics.median(values),
                            'p95_us':values[min(len(values)-1,int(len(values)*.95))],
                            'max_us':max(values)} if values else None
                item['summary']={
                    'before':summarize([r for r in item['frames'] if r[0]<45]),
                    'during':summarize([r for r in item['frames'] if r[2]]),
                    'after':summarize([r for r in item['frames'] if r[0]>=45 and not r[2]])}
                profiles[f'PORTRAIT107-{area}-{sub}-{rate}']=item
    contact('repairs107-contact.png',latest,4)
    images['repairs107-contact.png']=sha(OUT/'repairs107-contact.png')
'''
    assert marker in source
    source = source.replace(marker,addition+marker)
    (ROOT/'collect_visual107.py').write_text(source,encoding='utf8')

    source = (ROOT/'make_release106_receipt.py').read_text(encoding='utf8')
    source = source.replace('release106','release107').replace('1.0.6','1.0.7')
    source = source.replace("('1.0.7', 7,", "('1.0.7', 8,")
    source = source.replace('media_pixels_and_audio_unchanged_since_1_0_5','media_pixels_and_audio_unchanged_since_1_0_6')
    # The previous release's certificate remains the anchor, independent of
    # the new package's version and the current release configuration.
    source = source.replace("Hardmode-Android-1.0.7.validation.json')['certificate_sha256']",
                            "Hardmode-Android-1.0.7.validation.json')['certificate_sha256']")
    marker = '    artifacts = []'
    functions = ['scrHMPlayerNativeHidden107','scrHMPoliceArea107','scrHMCanHavePolice107',
                 'scrHMPoliceDeath107','scrHMPoliceRevive107','scrHMShieldKeepPlasma107',
                 'scrHMVanStop107','scrHMThroneFall107','scrHMVenusLoadout107',
                 'scrHMVenusRetry107','scrHMVenusRetryDestination107','scrHMIceCrystal107',
                 'scrHMPortalDestination107','scrHMAdvanceDestination107',
                 'scrHMPrepareJunkyard107','scrHMPortalClearWall107','scrHMTopPotFloor107',
                 'scrHMPlainWallDraw107','scrHMPalaceHorrorMove107']
    source = source.replace(marker, '    functions += '+repr(functions)+'\n'+marker)
    source = source.replace("'version':VERSION,'build':BUILD,'mod':'Hardmode b24',",
                            "'version':VERSION,'build':BUILD,'mod':'Hardmode b24',\n"
                            "              'installation_packages_generated':True,\n"
                            "              'source_manifest_sha256':sha(OUT/'final-source.json'),\n"
                            "              'source_code_archive_sha256':sha(OUT/'final-code.zip'),")
    source = source.replace("'compiled_repair_functions':functions})",
                            "'compiled_repair_functions':functions,\n"
                            "                          'validation_sha256':sha(path.with_suffix('.validation.json'))})")
    (ROOT/'make_release107_receipt.py').write_text(source,encoding='utf8')
    print('Prepared release107 collectors; old release tools/evidence unchanged')


if __name__ == '__main__': main()
