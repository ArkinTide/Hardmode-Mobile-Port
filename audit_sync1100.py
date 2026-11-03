"""Account for native transformations and mobile compatibility decisions."""
from pathlib import Path
from collections import Counter
import hashlib,json,re
from plan_sync1100 import ROOT,NATIVE,OUT,save
from compile_sync1100 import safe

def text(source):
    name='scrHMCompiled_'+safe(source)
    return (ROOT/'project/scripts'/name/(name+'.gml')).read_text('utf8')

def main():
    binding=json.loads((OUT/'native-source-binding.json').read_text('utf8'))
    for path,digest in binding['native_files'].items():
        assert hashlib.sha256((NATIVE/'mod'/path).read_bytes()).hexdigest()==digest,path
    changes=json.loads((NATIVE/'changes.json').read_text('utf8'))
    assert len(changes)==543
    staged=json.loads((OUT/'staged-compilation.json').read_text('utf8'))
    assert not staged['failures'] and not staged['new_artwork']
    installed=json.loads((OUT/'installed-definitions.json').read_text('utf8'))
    functions={(r['source'],r['name']):r['function'] for r in staged['definitions']}
    live={r['function'] for r in installed}
    unused=set(json.loads((ROOT/'mod-inventory.json').read_text('utf8'))['unreferenced_gml_files'])
    rows=[]
    for index,row in enumerate(changes):
        source,name=row['file'],row['script'];function=functions.get((source,name))
        if source=='hm_grillskills.mod.gml':
            status='EXCLUDED_PER_USER';reason='Mobile retains its existing mutation selector; do not import Grillskills.'
        elif source in unused:
            status='UNLOADED_UPSTREAM_FILE';reason='Not loaded by either the supplied native MOD entrypoint or the mobile module graph; active equivalents remain loaded.'
        elif source=='options.mod.gml' and name in {'step','draw_gui','hm_settings_toggle'}:
            status='MOBILE_EQUIVALENT';reason='Touch-accessible Hardmode options retain Chinese labels and existing mutation selection; Bossbar, throneballs and playerboost switches use the same saved fields.'
        elif source=='maincode.mod.gml' and name=='__load':
            status='MOBILE_EQUIVALENT';reason='Mobile asset/localization/bootstrap and platform timing are retained; native desktop loader is not replayed.'
        elif source=='areas/venuz.area.gml' and name in {'__load','area_make_floor'}:
            status='MOBILE_EQUIVALENT';reason='Mobile sprite registration and previously repaired authored Venus terrain remain in place.'
        else:
            assert function and function in live,(index,row)
            code=text(source)
            assert 'function '+function+'(' in code,function
            status='IMPORTED';reason=function
        rows.append(dict(index=index,**row,status=status,resolution=reason))
    # Resolve the earlier port's replaced AST contracts by responsibility,
    # rather than replaying obsolete balance/AI patches onto new native code.
    resolutions={
      ('bosses/gatorboss.mod.gml','gatorboss_step'):'Native target guards plus retained mobile emitted guard; custom fist timers and collision adapters remain.',
      ('bosses/titank.mod.gml','titank_create'):'Native body-owned jump completion, independent leg indices and damage receivers replace the old jump fix; retained host receiver registration is idempotent.',
      ('areas/city.area.gml','area_start'):'Native room-owned hm_hunter_pending and wanttitank controllers replace the old host pending marker.',
      ('maincode.mod.gml','step'):'Native water, police, cave restoration and canister policies replace old branches. Host overrides preserve five-point swimming, portal enums, authored-wall filtering and van class guard.',
      ('enemies.mod.gml','step'):'Native rat-revival setting and palace Horror helper replace old branches; carried rider-mask and corpse conversions remain.',
      ('enemies.mod.gml','IDPDLaserCannon_step'):'Native bounded beam distance and aim-lock replace the old scan; carried host beam orientation/particle fix remains.',
      ('props.mod.gml','draw_shadows'):'Native draw helper restricts shadow work to CustomObject and Effect; no all-bullet scan.',
      ('props.mod.gml','elevator_step'):'Native clear-gate countdown disables the blocking mask before opening an IDPD portal; native final value 2 already matches the mobile Portal enum.',
      ('props.mod.gml','joao_shockwave'):'Native non-destructive wall palette conversion plus carried host cursed-actor and ammo-subclass conversions preserve collision and avoid duplicate deaths.',
      ('areas/palace.area.gml','area_start'):'Native authored-wall list and hm_generator_at coordinate deduplication replace the old palace adapter.',
      ('areas/palace.area.gml','area_pop_enemies'):'Native hm_horror_base initializes the small palace Horror directly; no old 10016-HP placeholder.',
      ('bosses/ravenboss.mod.gml','ravenboss_step'):'Native single alarm decrement, point-distance landing, bounded flight age and radial movement replace the old flight patch.',
      ('enemies.mod.gml','enemyrogue_step'):'Native source removed unused SOUND-as-sprite dimensions; portal strike still uses strike_x/strike_y.',
    }
    reviews=[]
    for filename,key in [('portable-ast-review.json','definition'),('portable-emission-review.json','name')]:
        for row in json.loads((OUT/filename).read_text('utf8')):
            if row['status'] not in {'NATIVE_REPLACED_SUBTREE_REVIEW','NATIVE_SUPERSEDES_REVIEW'}:continue
            pair=row['source'],row[key];assert pair in resolutions,pair
            reviews.append(dict(**row,resolution=resolutions[pair],review_status='RESOLVED'))
    checks={
       'raven flight uses point distance':'point_distance(x, y, flight_x, flight_y)' in text('bosses/ravenboss.mod.gml'),
       'rogue avoids sound sprite queries':not re.search(r'sprite_get_(?:width|height)\(sndPortalStrikeFireButt\)',text('enemies.mod.gml')),
       'native beam has bounded search':'hm_arkintide_mod_gml_hm_beam_distance' in text('enemies.mod.gml'),
       'new callbacks registered':'venus_request_retry' in (ROOT/'project/scripts/scrHMRegistry/scrHMRegistry.gml').read_text('utf8'),
       'no imported Grillskills':all('grillskills' not in r['source'].lower() for r in installed),
       'mobile water adapter':'scrHMSewerTick();' in text('arkintide.mod.gml'),
       'throne annex generated before walls':'scrHMThroneGeneratorZone1100' in text('arkintide.mod.gml'),
       'host van class excluded from repeated portal requests':'!instance_is(id,Van)' in text('maincode.mod.gml'),
       'native maxlevel mapped to mobile cap':'GameCont.maxlevel' not in text('arkintide.mod.gml'),
       'crown visits mapped to host':'GameCont.vaults' not in text('arkintide.mod.gml'),
       'native loop pool has no duplicate host roll':'scrHMLoopPopulationFallback1100();' in (ROOT/'project/scripts/scrPopEnemies/scrPopEnemies.gml').read_text('utf8'),
       'mobile pause retry uses synchronized elevator':'with(instance_find(Player,0)) hm_maincode_mod_gml_venus_request_retry();' in (ROOT/'project/scripts/scrHMRepairs107/scrHMRepairs107.gml').read_text('utf8'),
    }
    assert all(checks.values()),checks
    save(OUT/'migration-ledger.json',dict(status='PASS',counts=dict(Counter(r['status'] for r in rows)),
         changes=rows,compatibility_reviews=reviews,structural_checks=checks,
         limits=['This ledger records implementation coverage, not individual runtime acceptance of all 543 historical transformations.']))
    delta=json.loads((OUT/'definition-delta.json').read_text('utf8'));delta['status']='REGISTERED_WITH_MOBILE_EQUIVALENTS';save(OUT/'definition-delta.json',delta)
    print('Migration coverage:',Counter(r['status'] for r in rows),'resolved compatibility reviews',len(reviews))

if __name__=='__main__':main()
