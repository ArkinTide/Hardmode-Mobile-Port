"""Audited adaptations of b24 definitions; never edit the frozen source."""
from gml_parser import Parser


def ast_repair(path, definition, walk):
    if path=='props.mod.gml' and definition.name=='joao_shockwave':
        # NTT conversion must not invoke the old cursed enemy's Destroy:
        # modern InvSpider.Destroy can spawn two more cursed spiders.
        nodes=[n for n in walk(definition.body) if n.kind=='with' and n.line==2630]
        assert len(nodes)==1
        nodes[0].args[1]=Parser('''if instance_exists(other) {
            if point_in_rectangle(x,y,view_xview[0]-32,view_yview[0]-32,view_xview[0]+game_width+32,view_yview[0]+game_height+32) {
                if(fork()) {wait(distance_to_object(_target)/8);
                    if instance_exists(self) scrHMConvertCursedEnemy(LaserCrystal);
                    exit;
                }
            } else scrHMConvertCursedEnemy(LaserCrystal);
        }''').statement()
        nodes=[n for n in walk(definition.body) if n.kind=='expr' and n.line in {2678,2686}]
        # Modern cursed ammunition uses a subclass, not just the NTT flag.
        assert len(nodes)==2,[(n.line,n.kind) for n in nodes]
        for node in nodes:
            replacement=Parser('scrHMClearCursedAmmo();').statement()
            node.kind,node.args=replacement.kind,replacement.args
    if path == 'enemies.mod.gml' and definition.name == 'step':
        nodes = [n for n in walk(definition.body) if n.kind == 'with' and n.line == 282]
        assert len(nodes) == 1
        nodes[0].args[1] = Parser('scrHMPalaceHorrorStep();').statement()
    if path == 'maincode.mod.gml' and definition.name == 'step':
        nodes = [n for n in walk(definition.body) if n.kind == 'expr' and n.line == 1388]
        assert len(nodes) == 1
        # Reliable post-destruction dispatch replaces a bind that ran before
        # the native HyperCrystal's inherited death event on some frames.
        nodes[0].kind, nodes[0].args = 'empty', []
        nodes = [n for n in walk(definition.body) if n.kind == 'with' and n.line == 538]
        assert len(nodes)==1
        nodes[0].kind,nodes[0].args='empty',[]
    if path=='enemies.mod.gml' and definition.name=='IDPDLaserCannon_step':
        nodes=[n for n in walk(definition.body) if n.kind=='while' and n.line==3207]
        assert len(nodes)==1
        replacement=Parser('dist=scrHMBeamDistance(x,y,aim+ang);').statement()
        nodes[0].kind,nodes[0].args=replacement.kind,replacement.args
        nodes=[n for n in walk(definition.body) if n.kind=='with' and n.line==3210]
        assert len(nodes)==1
        nodes[0].args[1].args.append(Parser('scrHMIDPDBeamFix(other.x,other.y,other.aim+ang);').statement())


def emitted_repair(path, name, emitted):
    if path == 'enemies.mod.gml' and name == 'step':
        assert 'hp = 10016;' in emitted
        emitted = emitted.replace('hp = 10016;', 'scrHMPalaceHorrorInit();')
    if path == 'bosses/gatorboss.mod.gml':
        if name == 'gatorboss_step':
            marker='on_step = scrHMScriptRef(hm_bosses_gatorboss_mod_gml_Gatorfist);'
            assert marker in emitted
            emitted=emitted.replace(marker,'hm_fist_timer0=0;hm_fist_timer1=0;\n'+marker)
        if name == 'Gatorfist':
            emitted=emitted.replace('alarm[0]','hm_fist_timer0').replace('alarm[1]','hm_fist_timer1')
        if name == 'Gatorfist_wall':
            emitted='function hm_bosses_gatorboss_mod_gml_Gatorfist_wall() {scrHMGatorFistWall();}'
    if path == 'bosses/titank.mod.gml':
        if name in {'tinade_create','tinade'}:
            emitted=emitted.replace('alarm[0]','hm_grenade_fuse')
        if name == 'tinade_create':
            emitted=emitted.replace('hm_grenade_fuse = 40;', 'hm_grenade_fuse = 40;\ncreator=_hml__creator;')
        if name == 'tinade_wall':
            emitted='function hm_bosses_titank_mod_gml_tinade_wall() {scrHMTinadeWall();}'
        if name == 'titank_create':
            marker='name = "titank";'
            assert marker in emitted
            emitted=emitted.replace(marker,marker+'\nHMWorld.hm_titank_entering=false;')
    if path == 'maincode.mod.gml' and name == 'CHCoutro':
        emitted='function hm_maincode_mod_gml_CHCoutro(_x,_y) {scrHMCursedCavesRestore(_x,_y);instance_destroy();}'
    if path=='maincode.mod.gml' and name=='versionnumber':
        emitted='function hm_maincode_mod_gml_versionnumber() {scrHMMenuDrawComplete();}'
    if path=='maincode.mod.gml' and name=='step':
        stack='\n'.join(f'scrHMSoundPlay(sndFootSlime{i});' for i in range(1,7))+'\nscrHMSoundPlay(sndSewerDrip);'
        assert emitted.count(stack)==2 or emitted.count('scrHMSewerTick();')==2
        emitted=emitted.replace(stack,'scrHMWaterEntrySound();')
    if path=='areas/sewers.area.gml' and name=='area_start':
        import re
        emitted=re.sub(r'instance_create\(([^;\n]+), PortalClear\)',r'scrHMSewerClear(\1)',emitted)
    if path=='enemies.mod.gml' and name=='IDPDLaserCannon_step':
        emitted=emitted.replace('move_contact_solid(', 'scrHMParticleRay(')
    if path=='props.mod.gml' and name=='fishskull_create':
        assert 'hp = 50;' in emitted
        emitted=emitted.replace('hp = 50;','max_hp=(GameCont.loops>0?3000:100);hp=max_hp;')
    if path=='props.mod.gml' and name=='joao_shockwave':
        assert emitted.count('instance_change(Spider, 1);')==2
        emitted=emitted.replace('instance_change(Spider, 1);','scrHMConvertCursedEnemy(Spider);')
    return emitted
