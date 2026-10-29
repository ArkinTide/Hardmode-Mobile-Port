// Source areas/venuz.area.gml:1; __load
function hm_areas_venuz_area_gml___load() {
global.hm_module_vars[$ "area:venuz"].wall103out = sprHM_areas_venuz_area_2;
global.hm_module_vars[$ "area:venuz"].floor1 = sprHM_areas_venuz_area_3;
global.hm_module_vars[$ "area:venuz"].explo1 = sprHM_areas_venuz_area_5;
global.hm_module_vars[$ "area:venuz"].trans1 = sprHM_areas_venuz_area_6;
global.hm_module_vars[$ "area:venuz"].bot1 = sprHM_areas_venuz_area_7;
global.hm_module_vars[$ "area:venuz"].out1 = sprHM_areas_venuz_area_8;
global.hm_module_vars[$ "area:venuz"].top1 = sprHM_areas_venuz_area_9;
global.hm_module_vars[$ "area:venuz"].debris1 = sprHM_areas_venuz_area_10;
global.hm_module_vars[$ "area:venuz"].detail1 = sprHM_areas_venuz_area_11;
global.hm_module_vars[$ "area:venuz"].VenuzBars1Open = sprHM_areas_venuz_area_12;
global.hm_module_vars[$ "area:venuz"].floor2 = sprHM_areas_venuz_area_14;
global.hm_module_vars[$ "area:venuz"].floorb = sprHM_areas_venuz_area_15;
global.hm_module_vars[$ "area:venuz"].explo2 = sprHM_areas_venuz_area_16;
global.hm_module_vars[$ "area:venuz"].floor3 = sprHM_areas_venuz_area_18;
global.hm_module_vars[$ "area:venuz"].explo3 = sprHM_areas_venuz_area_20;
global.hm_module_vars[$ "area:venuz"].trans3 = sprHM_areas_venuz_area_21;
global.hm_module_vars[$ "area:venuz"].bot3 = sprHM_areas_venuz_area_22;
global.hm_module_vars[$ "area:venuz"].out3 = sprHM_areas_venuz_area_23;
global.hm_module_vars[$ "area:venuz"].top3 = sprHM_areas_venuz_area_24;
global.hm_module_vars[$ "area:venuz"].debris3 = sprHM_areas_venuz_area_25;
global.hm_module_vars[$ "area:venuz"].detail3 = sprHM_areas_venuz_area_26;
global.hm_module_vars[$ "area:venuz"].gungodz01 = scrHMSoundAdd("../music/01 Godz Of Gunz.ogg");
;
global.hm_module_vars[$ "area:venuz"].gungodz02 = scrHMSoundAdd("../music/02 Venus Supermax.ogg");
;
global.hm_module_vars[$ "area:venuz"].gungodz03 = scrHMSoundAdd("../music/03 Deep In The Sewers.ogg");
;
global.hm_module_vars[$ "area:venuz"].gungodz04 = scrHMSoundAdd("../music/04 Finest Wine Cellar.ogg");
;
global.hm_module_vars[$ "area:venuz"].gungodz05 = scrHMSoundAdd("../music/05 Elevator Music.ogg");
;
global.hm_module_vars[$ "area:venuz"].gungodz06 = scrHMSoundAdd("../music/06 Welcome To The Crib.ogg");
;
global.hm_module_vars[$ "area:venuz"].gungodz07 = scrHMSoundAdd("../music/07 Highest Point Of Venus.ogg");
;
global.hm_module_vars[$ "area:venuz"].kills = 0;
global.hm_module_vars[$ "area:venuz"].items = 0;
global.hm_module_vars[$ "area:venuz"].time = 0;
global.hm_module_vars[$ "area:venuz"].secrets = 0;
global.hm_module_vars[$ "area:venuz"].p1 = "XXXXXXXXXXXXXXXXXXXXXXXXX\nXXXXXXXXXXXXXXP__M__XXXXX\nXXX_M___=____=_____S___EX\nXXXM____XXXXXXP__M__XXXXX\nXXXaM___=____XXXXXXXXXXXX\nXXXXXX-XXXXX_XXXXXXXXXXXX\nXXXXXXFXXXFX+XFXXXXXXXXXX\nXXXXXXXXXX-X_X-XXXXXXXXXX\nXXXXMM_=_______hXXXXXXXXX\nX__=___XXX-X-XXXXXXXXXXXX\nX_XX___XXXF_FXFXXXXXXXXXX\nX_XXX+XXXXXXXX-XXXXXXXXXX\nX_aM|_=____________XXXXXX\nXXXXX-XXXXXXXXXX-X_XXXXXX\nXXXXF_|_M______=_M_XXXXXX\nXXXX_FXXOX-X-X-X__aXXXXXX\nXXXXXXXX*X*X*X*XXXXXXXXXX\nXXXXXXXXXXXXXXXXXXXXXXXXX\n";
global.hm_module_vars[$ "area:venuz"].p1d = "XXXXXXXXXXXXXXXXXXXXXXXXX\nXXXXXXXXXXXXXXiiiiiiXXXXX\nXXXgggggHhhhhIiiiiiiiiiiX\nXXXgggggXXXXXXiiiiiiXXXXX\nXXXgggggGffffXXXXXXXXXXXX\nXXXXXXgXXXXXfXXXXXXXXXXXX\nXXXXXXgXXXdXFXdXXXXXXXXXX\nXXXXXXXXXXdXdXdXXXXXXXXXX\nXXXXcccDddddddddXXXXXXXXX\nXeeEcccXXXdXdXXXXXXXXXXXX\nXeXXcccXXXdddXaXXXXXXXXXX\nXbXXXCXXXXXXXXaXXXXXXXXXX\nXbbbbbBaaaaaaaaaaaaXXXXXX\nXXXXX_XXXXXXXXXXaXaXXXXXX\nXXXX___________AaaaXXXXXX\nXXXX__XX_X_X_X_XaaaXXXXXX\nXXXXXXXX_X_X_X_XXXXXXXXXX\nXXXXXXXXXXXXXXXXXXXXXXXXX\n";
global.hm_module_vars[$ "area:venuz"].p2 = "XXXXXXXXXXXXXXXXXXXXXXXXXX\nXXXXXXXXXXXXXX___XXXXXXXXX\nXXXXXXXXXXXX_|_h_|CXXXXXXX\nX___XXXXXXXXXXX_XXXXXXXXXX\nX_M_XXXXXXXXXX______M__XXX\nX______XXXXXXXPM__X_X___XX\nX___X__MXXXXE_S__M_____MXX\nX_M_X_M__XXXXXPM__X___X_aX\nX___XX__M_XXXX______X___XX\nX___XXX___XXXXXXXXXXM___XX\nXX+XXXX+XXXXXXXXXXXX____XX\nXX_X_FX_XXXXXXXXXXXX__X_XX\nXX_|FA=_XXXXXXXXXXXX__M_XX\nXX_X_FX_XXXXXXXXXXXXX___XX\nXX+XXXX+XXXXXXX___hFX___XX\nX___X_____XXXXX___XXXX+XXX\nX_2_X__F__XXXXXMX_XXXX_XXX\nXP_PXM_X_M=_________=__XXX\nXX_XX_M_M_XX___MX-XXXXXXXX\nXX_XXa____XX__M__S_aXXXXXX\nXX*XX-X-X-XX_______AXXXXXX\nXXXXXFXFXFXXXXXXXXXXXXXXXX\n";
global.hm_module_vars[$ "area:venuz"].p2d = "XXXXXXXXXXXXXXXXXXXXXXXXXX\nXXXXXXXXXXXXXXgggXXXXXXXXX\nXXXXXXXXXXXXgggggggXXXXXXX\nXbbbXXXXXXXXXXXgXXXXXXXXXX\nXbbbXXXXXXXXXXgggggggggXXX\nXbbbbbbXXXXXXXggggXgXgggXX\nXbbbXbbbXXXXggggggggggggXX\nXbbbXbbbbXXXXXggggXgggXggX\nXbbbXXbbbbXXXXggggggXgggXX\nXbbbXXXbbbXXXXXXXXXXggggXX\nXXBXXXXCXXXXXXXXXXXXggggXX\nXXaXaaXcXXXXXXXXXXXXggXgXX\nXXaaaaacXXXXXXXXXXXXggggXX\nXXaXaaXcXXXXXXXXXXXXXgggXX\nXXAXXXXDXXXXXXXeeeeeXgggXX\nX___XdddddXXXXXeeeXXXXGXXX\nX___XdddddXXXXXeXeXXXXfXXX\nXP_PXddXddEeeeeeeeeeFffXXX\nXX_XXdddddXXeeeeXeXXXXXXXX\nXX_XXdddddXXeeeeeeeeXXXXXX\nXX_XXdXdXdXXeeeeeeeeXXXXXX\nXXXXXdXdXdXXXXXXXXXXXXXXXX\n";
global.hm_module_vars[$ "area:venuz"].p3 = "XXXXXXXXXXXXXXXXXXXXXX\nXX_C__M__M__M____XXXXX\nXX+XXXXXXXOXXXXX+XXXXX\nX__ASXXXX___XXX___XXXX\nX___XXXXX___XX__S__XXX\nX___XXXXXXXXXM_____MXX\nX___XXXXX_XXM__XSX__MX\nX_S_XXXXX_XXX___h___XX\nXPCPXXXXX+XXM__X+X__MX\nXXEXXX____XXX__M_M__XX\nXXXXXX____XXXX_____XXX\nXXXXXXFFT_XXXXX___XXXX\nXXXXXX____XXXXXX+XXXXX\nXXXXXXXXXXXX___XAXXXXX\nXXXXXXXXXXXX_X_=_|SXXX\nXXXXXXXXXXXXOXXXXXXXXX\nXXXXXXXXXXa___h____XXX\nXXXXXXXXXX-X-X-XOX-XXX\nXXXXAXXXXX___S_____XXX\nXXXXFXXX__M__XP____=SX\nXXXXOXXX_____S___M_XXX\nX_F|_XXX+X-XOX-X-X-XXX\nXXXX_XXX_X____a_h_AXXX\nX_M=__XX+XXXXXXXXXXXXX\nX_XXXMX__M_M_MXXXXXXXX\nX_X_X_X_____S_|FXXXXXX\nX_X_X_XA_M____XXXXXXXX\nX_|SXCXXXXX_X_|FXXXXXX\nX_X_X_XXX_____XXXXXXXX\nX_X_XM__=_a_S_|FXXXXXX\nX*XXXXXXX__M_MXXXXXXXX\nXXXXXXXXXXXX-XXXXXXXXX\nXXXXXXXXXXXXFXXXXXXXXX\n";
global.hm_module_vars[$ "area:venuz"].p3d = "XXXXXXXXXXXXXXXXXXXXXX\nXXfffffffffffffffXXXXX\nXXIXXXXXXXfXXXXXFXXXXX\nXiiiiXXXXfffXXXeeeXXXX\nXiiiXXXXXfffXXeeeeeXXX\nXiiiXXXXXGXXXeeeeeeeXX\nXiiiXXXXXgXXeeeXeXeeeX\nXiiiXXXXXgXXXeeeeeeeXX\nXiiiXXXXXHXXeeeXeXeeeX\nXXiXXXhhhhXXXeeeeeeeXX\nXXXXXXhhhhXXXXeeeeeXXX\nXXXXXXhhhhXXXXXeeeXXXX\nXXXXXXhhhhXXXXXXEXXXXX\nXXXXXXXXXXXXcccXkXXXXX\nXXXXXXXXXXXXcXcKkkkXXX\nXXXXXXXXXXXXcXXXXXXXXX\nXXXXXXXXXXcccccccccXXX\nXXXXXXXXXXcXcXcXcXcXXX\nXXXXjXXXXXcccccccccXXX\nXXXXjXXXcccccXcccccDdX\nXXXXjXXXcccccccccccXXX\nXjjjjXXXCXcXcXcXcXcXXX\nXXXXjXXXbXcccccccccXXX\nX__JjjXXBXXXXXXXXXXXXX\nX_XXXjXaaaaaaaXXXXXXXX\nX_X_XjXaaaaaaaaaXXXXXX\nX_X_XjXaaaaaaaXXXXXXXX\nX___XjXXXXXaXaaaXXXXXX\nX_X_XjXXXaaaaaXXXXXXXX\nX_X_XjjjAaaaaaaaXXXXXX\nX*XXXXXXXaaaaaXXXXXXXX\nXXXXXXXXXXXXaXXXXXXXXX\nXXXXXXXXXXXXaXXXXXXXXX\n";
global.hm_module_vars[$ "area:venuz"].s1 = "XXXXXXXXXXXXXXXXXXXXX\nXXXXXXXXXX_a_XXXXXXXX\nXXXXXX___=_X_XXXXXXXX\nXXXXX__XXXS|SXXXXXXXX\nXXXXX___UX_X_XXXXXXXX\nXX__=M__hX___XShXXXXX\nXX_XX_aM_XX+XX__XS_AX\nX___XXXX_XX_XM____X_X\nX_M__MXXCXX_S_M_X___X\nXXXSXMXXAXXXXXXXXX_XX\nXXC___hXXXXXXXXXXX+XX\nXXXXX_SXXXXXXXXXXX_XX\nXXXXX+XXEXXA__M|aM_XX\nXXXXX_XX_XX_XX_XXX_XX\nXXXA__|S_XX_XX___C_XX\nXXX_X-X__XX_XXXXXXXXX\nXXXM_M_M_XX*XXXXXXXXX\nXXXXXXXXXXXXXXXXXXXXX\n";
global.hm_module_vars[$ "area:venuz"].s1d = "XXXXXXXXXXXXXXXXXXXXX\nXXXXXXXXXXbbbXXXXXXXX\nXXXXXXeeeEbXbXXXXXXXX\nXXXXXeeXXXbbbXXXXXXXX\nXXXXXeeeeXbXbXXXXXXXX\nXXccCeeeeXbbbXaaXXXXX\nXXcXXeeeeXXBXXaaXaaaX\nXcccXXXXeXXaXaaaaaXaX\nXcccccXXeXXaaaaaXaaaX\nXXXcXcXXeXXXXXXXXXaXX\nXXcccccXXXXXXXXXXXAXX\nXXXXXccXXXXXXXXXXX_XX\nXXXXXDXXdXX________XX\nXXXXXdXXdXX_XX_XXX_XX\nXXXddddddXX_XX_____XX\nXXXdXdXddXX_XXXXXXXXX\nXXXddddddXX_XXXXXXXXX\nXXXXXXXXXXXXXXXXXXXXX\n";
global.hm_module_vars[$ "area:venuz"].s2 = "XXXXXXXXXXXXXXXXXXXXX\nXXXXXhXX_M_XXaXXXXXXX\nXXU|_S___X__US_XXXXXX\nXXU|_CS__X_U_X_AXXXXX\nXXU|_XXXXXS__M_XXXXXX\nXXXX_XS|_XXXX_XXXXXXX\nXXACUX_X-X_M_CXXXXXXX\nXXXX+X__S__XXXXXXXXXX\nXXXX_XAX-X-XX__MAXXXX\nXX___XM|______M_XXXXX\nXX___X_X_X-XX___XEXXX\nXX_3_X__M_SXXX+XXUXXX\nXXX_XXXXXXaXXX_XCUCXX\nXXX_XXXXXXXXXX*X_M_XX\nXXX+XXAXXX_aMXXX___XX\nXXX__MM|__MX___X___XX\nXXXMMXMXhXM|_U_XX_XXX\nXXX_M|MS__SX____=SXXX\nXXXXXXXXXX_aMXXXX?XXX\nXXXXXXXXXXXXXXT___XXX\nXXXXXXXXXXXXXXXXXXXXX\n";
global.hm_module_vars[$ "area:venuz"].s2d = "XXXXXXXXXXXXXXXXXXXXX\nXXXXXaXXaaaXXaXXXXXXX\nXXaaaaaaaXaaaaaXXXXXX\nXXaaaaaaaXaaaXaaXXXXX\nXXaaaXXXXXaaaaaXXXXXX\nXXXXaXaaaXXXXaXXXXXXX\nXXaaaXaXaXaaaaXXXXXXX\nXXXXBXaaaaaXXXXXXXXXX\nXXXXbXaXaXaXXaaaaXXXX\nXXbbbXaaaaaaaaaaXXXXX\nXXbbbXaXaXaXXaaaXdXXX\nXXbbbXaaaaaXXXAXXdXXX\nXXXbXXXXXXaXXX_XdddXX\nXXXbXXXXXXXXXX*XdddXX\nXXXCXXcXXXcccXXXdddXX\nXXXccccccccXcccXdddXX\nXXXccXcXcXcccccXXdXXX\nXXXccccccccXccccDdXXX\nXXXXXXXXXXcccXXXXEXXX\nXXXXXXXXXXXXXXeeeeXXX\nXXXXXXXXXXXXXXXXXXXXX\n";
global.hm_module_vars[$ "area:venuz"].s3 = "XXXXXXXXXXXXX\nXXXX_A_A_XXXX\nXXXX_XXX_XXXX\nXXX___3___XXX\nX___X___X___X\nXaX_______XhX\nX_Xa__r__aX_X\nXhX_______XaX\nX___X___X___X\nXXX___2___XXX\nXXXX_XXX_XXXX\nXXXX__a__XXXX\nXXXXXX_XXXXXX\nXXXXXX_XXXXXX\nXXXXXX_XXXXXX\nXXXXXX*XXXXXX\n";
global.hm_module_vars[$ "area:venuz"].s3d = "XXXXXXXXXXXXX\nXXXXXXXXXXXXX\nXXXXXXXXXXXXX\nXXXXXXXXXXXXX\nXXXXXXXXXXXXX\nXXXXXXXXXXXXX\nXXXXXXXXXXXXX\nXXXXXXXXXXXXX\nXXXXXXXXXXXXX\nXXXXXXXXXXXXX\nXXXXXXXXXXXXX\nXXXXXXXXXXXXX\nXXXXXXXXXXXXX\nXXXXXXXXXXXXX\nXXXXXXXXXXXXX\nXXXXXX*XXXXXX\n";
global.hm_module_vars[$ "area:venuz"].b1 = "XXXXXXXXXXXXXXXXXXXXXXXXX\nXX___S__=__G______EXXXXXX\nXX_X_X__X____XXXXXXXXXXXX\nXX______X___PX_____M_XXXX\nXX__G__SX___XX___S__M_XXX\nXXX___XXXXXXX___XXXX__XXX\nXU_____hXX______XXa_____X\nXS______XX___MC_XXb_XX__X\nXXXXXX__XX+X+XXXXXXG___aX\nXXA____MXXh___|XXX______X\nXX_____SXXM___|_X__X____X\nXX+XXXXXXXXX__XXXX_2____X\nX_UbXXXXXG_|_____XX___X_X\nX_a_XXXXX__|M_____X_____X\nXCBCXXXXX__XXXXXU_X_____X\nX___XXXXX__XXXX__AXX___bX\nX___=C____________XX__XXX\nX___X____________XXX*XXXX\nXb_bXXXXXXXXXSXXXXXXXXXXX\nXXXXXXXXXXXXXXXXXXXXXXXXX\n";
global.hm_module_vars[$ "area:venuz"].b1d = "XXXXXXXXXXXXXXXXXXXXXXXXX\nXXccccccBbbbbbbbbbbXXXXXX\nXXccccccXbbbbXXXXXXXXXXXX\nXXccccccXbbbbX_______XXXX\nXXccccccXbbbXX________XXX\nXXccccccXXXXX___XXXX__XXX\nXaccccccXX______XX______X\nXaccccccXX______XX__XX__X\nXXXXXXccXXDXDXXXXXX_____X\nXXccccccXXdddddXXX______X\nXXccccccXXddddddX__X____X\nXXCXXXXXXXXXddXXXX______X\nXaaaXXXXXddddddddXX___X_X\nXaaaXXXXXdddddddddX_____X\nXaaaXXXXXdddddddddX_____X\nXaaaXXXXXdddddddddXX____X\nXaaaAdddddddddddddXX__XXX\nXaaaXddddddddddddXXX*XXXX\nXaaaXXXXXXXXXdXXXXXXXXXXX\nXXXXXXXXXXXXXXXXXXXXXXXXX\n";
global.hm_module_vars[$ "area:venuz"].b2 = "XXXXXXXXXXXXXXXXXXXXXXXXXX\nXXXXXEXXX_CG____S___S_XXXX\nXXXXXGXXX+XX_MXhX_M___XXXX\nXXXX___XX_XXb__U__aX+XXXXX\nXXXX___XXSXXXXX-XXXXM3___X\nXXXXS_SX_4_XX__S_aXX-XXXCX\nXXXXX+XX___XAC___XXX__MX_X\nXXG_M__|___X__BX_=A=_ChX_X\nXX_X_2XXX_XXX_S__XXX__MX_X\nXXMXXXXX_G_XXX__b_XX_XXX_X\nXX__XX__M_MXX__U__XX_XUX_X\nXX__C______XX_____X__X+X+X\nXXbX_____U_XX__XM_XA_____X\nXXhXXXXX---XX_____XXb__M_X\nXX-XXXXXUSUX_____MXX-X-X_X\nXX___a_XXXXXM_bX__X______X\nXX_X_M_=_2____G___X_G__G_X\nX__XXXXX___XXXXXXXX_XXXXXX\nX*XXXXXXXXXXXhC_____|F_XXX\nXXXXXXXXXXXXXXXXXXXXXXXXXX\n";
global.hm_module_vars[$ "area:venuz"].b2d = "XXXXXXXXXXXXXXXXXXXXXXXXXX\nXXXXXhXXXffffffaffffffXXXX\nXXXXXhXXXGXXffXaXfffffXXXX\nXXXXhhhXXgXXfaaaaafXFXXXXX\nXXXXhhhXXgXXXXXaXXXXcceeeX\nXXXXhhhXgggXXaaaaaXXcXXXeX\nXXXXXHXXgggXaaaaaXXXcccXeX\nXXgggggggggXaaaXaBbCcccXeX\nXXgXggXXXgXXXaaaaXXXcccXeX\nXXgXXXXXgggXXXaaaaXXcXXXeX\nXXggXXgggggXXaaaaaXXcXdXeX\nXX__gggggggXXaaaaaXccXDXEX\nXX_XgggggggXXaaXaaXccccccX\nXX_XXXXXgggXXaaaaaXXcccccX\nXX_XXXXXgggXaaaaaaXXcXcXcX\nXX_____XXXXXaaaXaaXccccccX\nXX_X___AaaaaaaaaaaXccccccX\nX__XXXXXaaaXXXXXXXXcXXXXXX\nX*XXXXXXXXXXXccccccccccXXX\nXXXXXXXXXXXXXXXXXXXXXXXXXX\n";
global.hm_module_vars[$ "area:venuz"].b3 = "XXXXXXXXXXXXXXXXXXXXXXXXXX\nXXXXXXXXXXXXXXXXXXXXEXXXXX\nXXXXXXXXXXXXXXXXXXXX_XXXXX\nXXXXXXXXXX___XXXJ_P___P_JX\nXXXXXXXXXX_T___@_________X\nXXXXXXXXXX___XXXP___2___PX\nXXXXXXXXXXXXXXXX_________X\nXRSGRXXXXXXXXXXXJ_P___P_JX\nXS___XXXXXXXXXXXXXXX+XXXXX\nXXX_h___|_FXXXXXXXXX+XXXXX\nX_J_____|F_XXXXXXJ_____JXX\nXXX_XXX_XXXXXXXXX_X_B_X_XX\nXXX_XXX___bXXXXXX_______XX\nXXXAXXXUCM_M__AXXSXXAXXSXX\nXXX+XXX__XMX__MXXSXXAXXSXX\nX_____XU_M_M___XX_a___a_XX\nXM_h_MX_MXMXXX_XX_______XX\nX_SXS_XA___XXX3XX_______XX\nX__a__XXXXXXXX+XXXXX+XXXXX\nXMS_S_|____JXX_XU__|J_SXXX\nXXXGXXX__X+XXXaXXXXX_XhXXX\nXXX_XXXBSX__AX*XSAU___UXXX\nXXX+XXXS_X_X_XXX_X_XXXXXXX\nXXX_XXX__X__U=S=__GXXXXXXX\nXXX___=__XJXXXXXXXXXXXXXXX\nXXXXXXXXXXXXXXXXXXXXXXXXXX\n";
global.hm_module_vars[$ "area:venuz"].b3d = "XXXXXXXXXXXXXXXXXXXXXXXXXX\nXXXXXXXXXXXXXXXXXXXXiXXXXX\nXXXXXXXXXXXXXXXXXXXXiXXXXX\nXXXXXXXXXXkkkXXXiiiiiiiiiX\nXXXXXXXXXXkkkkkKiiiiiiiiiX\nXXXXXXXXXXkkkXXXiiiiiiiiiX\nXXXXXXXXXXXXXXXXiiiiiiiiiX\nXaaaaXXXXXXXXXXXiiiiiiiiiX\nXaaaaXXXXXXXXXXXXXXXIXXXXX\nXXXaaaaaaaaXXXXXXXXXJXXXXX\nXaaaaaaaaaaXXXXXXhhhhhhhXX\nXXXaXXXaXXXXXXXXXhXhhhXhXX\nXXXaXXXaaaaXXXXXXhhhhhhhXX\nXXXaXXXaaaaaaaaXXhXXhXXhXX\nXXXBXXXaaXaXaaaXXhXXhXXhXX\nXbbbbbXaaaaaaaaXXhhhhhhhXX\nXbbbbbXaaXaXXXaXXhhhhhhhXX\nXbbXbbXaaaaXXXaXXhhhhhhhXX\nXbbbbbXXXXXXXXAXXXXXHXXXXX\nXbbbbbbbbbbbXX_XgggggggXXX\nXXXbXXXbbXEXXX_XXXXXgXgXXX\nXXXbXXXddXeeeX*XgggggggXXX\nXXXCXXXddXeXeXXXgXgXXXXXXX\nXXXcXXXddXeeeFfGgggXXXXXXX\nXXXcccDddXeXXXXXXXXXXXXXXX\nXXXXXXXXXXXXXXXXXXXXXXXXXX\n";
global.hm_module_vars[$ "area:venuz"].m1 = "XXXXXXXXXXXXXXXXXXXXXXXX\nXXXXXXXXXXXXXXXXXXXXXXXX\nXXXXC__X____U__=_____XXX\nXXXXa__=a_J__h_X_____XXX\nXXXX___X____U__X_____XXX\nXXXXX_XXXXXXX--XXXX+XXXX\nXXXXt_Xa_____________XXX\nXXXX__X_____X__X_____XXX\nXXXXX_X____t____t____XXX\nXXXXX_X___XXX--XXX___XXX\nXXXXX_X___XEXGJXGXU_UXXX\nX_____X_X_X_XXXX_XXXXXXX\nX_t_t_X__tX_X___a=t_hXXX\nX_X_X_X_A_XHX_G__X__CXXX\nX_t_t_X_X_X_X___aX_X_XXX\nX_X_X_X__SX_=_PXSX__SXXX\nX_____X___XXXXXX-X_A_XXX\nX__2__X__J____t___J__XXX\nXXX*XXX_h_t_X_3Xht__UXXX\nXXXXXXXt______S___J_aXXX\nXXXXXXXXXXXXXXXXXXXXXXXX\n";
global.hm_module_vars[$ "area:venuz"].m1d = "XXXXXXXXXXXXXXXXXXXXXXXX\nXXXXXXXXXXXXXXXXXXXXXXXX\nXXXX___XaaaaaaaBbbbbbXXX\nXXXX___AaaaaaaaXbbbbbXXX\nXXXX___XaaaaaaaXbbbbbXXX\nXXXXX_XXXXXXXaaXXXXCXXXX\nXXXX__XcccccaaaacccccXXX\nXXXX__XcccccXaaXcccccXXX\nXXXXX_XcccccaaaacccccXXX\nXXXXX_XcccXXXaaXXXcccXXX\nXXXXX_XcccXeXaaXdXcccXXX\nX_____XcXcXeXXXXdXXXXXXX\nX_____XcccXeXddddDcccXXX\nX_X_X_XcccXeXddccXcccXXX\nX_____XcccXeXddccXcccXXX\nX_X_X_XcccXeEddXcXcccXXX\nX_____XcccXXXXXXcXcccXXX\nX_____XccccccccccccccXXX\nXXX*XXXccccccccccccccXXX\nXXXXXXXccccccccccccccXXX\nXXXXXXXXXXXXXXXXXXXXXXXX\n";
global.hm_module_vars[$ "area:venuz"].m2 = "WWWWWWWWWWWWWWWWWWWWW\nWWWWWWxxxxxWWWWWWWWWW\nWWtaSAtXXXat_h__JWWWW\nWW_U_U_XXX_X___XRWWWW\nWWU_X_U=A=_____S_WWWW\nWW__S__XXX___H__4WWWW\nWxa____XTX_____S_WWWW\nWxXX+XXX?X_X___XAWWWW\nWxXXtXXS____th__JxWWW\nWxXX+XX____XXXXXXxWWW\nWxX_2_X____XXhXhXxWWW\nWxX___XShHS=AS__GxWWW\nWxXX+XXXXXXXP____WWWW\nWxXX_XXXXXE_tX_XtWWWW\nWxXX*XXXXXXXP_H__WWWW\nWxXXXXXXXXXXJCHCJWWWW\nWxXXXXXXXXXxxWWWWWWWW\nWWXXXXXXXXWWWWWWWWWWW\nWWWWWWWWWWWWWWWWWWWWW\nWWWWWWWWWWWWWWWWWWWWW\n";
global.hm_module_vars[$ "area:venuz"].m2d = "WWWWWWWWWWWWWWWWWWWWW\nWWWWWWWWWWWWWWWWWWWWW\nWWcccccXXXeeeeeeeWWWW\nWWcccccXXXeeeeeeeWWWW\nWWcccccDdEeeeeeeeWWWW\nWWcccccXXXeeeeeeeWWWW\nWWcccccXgXeeeeeeeWWWW\nWXXXCXXXGXeeeeeeeWWWW\nWXXXbXXeeeeeeeeeeWWWW\nWXXXBXXeeeeXXXXXXWWWW\nWXXaaaXeeeeXfffffWWWW\nWXXaaaXeeeeFfffffWWWW\nWXXXAXXXXXXXfffffWWWW\nWXXX_XXXXXfffffffWWWW\nWXXX*XXXXXXXfffffWWWW\nWXXXXXXXXXXXfffffWWWW\nWXXXXXXXXXXXWWWWWWWWW\nWWWWWWWWWWWWWWWWWWWWW\nWWWWWWWWWWWWWWWWWWWWW\nWWWWWWWWWWWWWWWWWWWWW\n";
global.hm_module_vars[$ "area:venuz"].boss2 = "WWWWWWWWWWWWW\nWR____&___RWW\nW_h________WW\nW__XX__XX__WW\nW__XA__aX__WW\nW__________WW\nW__X*__AX__WW\nW__XX__XX__WW\nW________h_WW\nWR________RWW\nWWWWWWWWWWWWW\n";
global.hm_module_vars[$ "area:venuz"].boss2d = "XXXXXXXXXXXX\nXXXXXXXXXXXX\nXXXXXXXXXXXX\nXXXXXXXXXXXX\nXXXXXXXXXXXX\nXXXXXXXXXXXX\nXXXXXXXXXXXX\nXXXXXXXXXXXX\nXXXXXXXXXXXX\nXXXXXXXXXXXX\nXXXXXXXXXXXX\n";
global.hm_module_vars[$ "area:venuz"].ps = "XXXXXXXXXXXXXX\nXX_]]||||CXXXX\nXX-XXXXXX-XXXX\nXX=XXXXXX-XXXX\nXX-XXXXXXCXXXX\nXX=XXXXXXC|]_X\nXX=XXXXXXXXX-X\nXX=XXXXXXXXX-X\nX___XXXXXXXX=X\nX_2_XXXXX_||_X\nX___XXXXX-XXXX\nXX*XXXXX___XXX\nXXXXXXXX_C_XXX\nXXXXXXXXP_PXXX\nXXXXXXXXXEXXXX\n";
global.hm_module_vars[$ "area:venuz"].ss = "XXXXXXXXXXXXXX\nXXXXXXX33XXXXX\nXXXXXXX33XXXXX\nXXXXXXX33XXXXX\nXXXXXXX__XXXXX\nXXX________XEX\nXXX___C__U_XMX\nXXX__M____M|CX\nXh__X-X_AX_XMX\nX__XXM___|_X_X\nX_MXXM___|UX_X\nX__XX-Xa_XHXUX\nXUU________X_X\nXUU__M____MX_X\nXXXXXXX__X-X_X\nXXXXXXX___AX_X\nXXXXX______X_X\nXXX_=____XaXCX\nXXX2X______X_X\nXXX_XM____MX_X\nXXX_X--__--X+X\nXXX_XUUUUUUUUX\nXXX*XCCCCCCCCX\nXXXXXCCCCCCCCX\nXXXXXXXXXXXXXX\n";
global.hm_module_vars[$ "area:venuz"].ssd = "XXXXXXXXXXXXXX\nXXXXXXXaaXXXXX\nXXXXXXXaaXXXXX\nXXXXXXXaaXXXXX\nXXXXXXXaaXXXXX\nXXXaaaaaaaaXbX\nXXXaaaaaaaaXbX\nXXXaaaaaaaaabX\nXaaaXaXaaXaXbX\nXaaXXaaaaaaXbX\nXaaXXaaaaaaXbX\nXaaXXaXaaXaXbX\nXaaaaaaaaaaXbX\nXaaaaaaaaaaXbX\nXXXXXXXaaXaXbX\nXXXXXXXaaaaXbX\nXXXXXaaaaaaXbX\nXXX_AaaaaXaXbX\nXXX_XaaaaaaXbX\nXXX_XaaaaaaXbX\nXXX_XaaaaaaXBX\nXXX_XaaaaaaaaX\nXXX*XaaaaaaaaX\nXXXXXaaaaaaaaX\nXXXXXXXXXXXXXX\n";
global.hm_module_vars[$ "area:venuz"].bs = "XXXXXXXXXXXXXXXXX\nXXXXb_C___C_bXXXX\nXXXX__4___J__XXXX\nXXXX__XXaXX__XXXX\nXb__U_3___h_U__bX\nX____U_____U____X\nXCJXh_X___X_2X4CX\nX__X_________X__X\nX__a____*____a__X\nX__X_________X__X\nXC4X2_X___X_hXJCX\nX____U_____U____X\nXb__U_h___3_U__bX\nXXXX__XX_XX__XXXX\nXXXX__J_a_4__XXXX\nXXXXb_C___C_bXXXX\nXXXXXXXXXXXXXXXXX\n";
global.hm_module_vars[$ "area:venuz"].bsd = "XXXXXXXXXXXXXXXXX\nXXXXXXXXXXXXXXXXX\nXXXXXXXXXXXXXXXXX\nXXXXXXXXXXXXXXXXX\nXXXXXXXXXXXXXXXXX\nXXXXXXXXXXXXXXXXX\nXXXXXXXXXXXXXXXXX\nXXXXXXXXXXXXXXXXX\nXXXXXXXXXXXXXXXXX\nXXXXXXXXXXXXXXXXX\nXXXXXXXXXXXXXXXXX\nXXXXXXXXXXXXXXXXX\nXXXXXXXXXXXXXXXXX\nXXXXXXXXXXXXXXXXX\nXXXXXXXXXXXXXXXXX\nXXXXXXXXXXXXXXXXX\nXXXXXXXXXXXXXXXXX\n";
global.hm_module_vars[$ "area:venuz"].ms = "WWWWWWWWWWWWW\nWW_____|tXXWW\nWW_XXX+XXXXWW\nWW_XPmmmPXEWW\nWW_XmtXtmX_WW\nWW_XmmmmmX_WW\nWW_XmtXtmX_WW\nWW*XPmmmPX_WW\nWWXXXX+XXX_WW\nWWXXt|____CWW\nWWWWWWWWWWWWW\n";
global.hm_module_vars[$ "area:venuz"].msd = "WWWWWWWWWWWWW\nWW_____|tXXWW\nWW_XXXAXXXXWW\nWW_XaaaaaXbWW\nWW_XaaaaaXbWW\nWW_XaaaaaXbWW\nWW_XaaaaaXbWW\nWW*XaaaaaXbWW\nWWXXXXBXXXbWW\nWWXXbbbbbbbWW\nWWWWWWWWWWWWW\n";
global.hm_module_vars[$ "area:venuz"].ms2 = "WWWWWWWWWWWWW\nWWXXXX_____WW\nWWXXEX_XXX*WW\nWWXX_X+XXXXWW\nWWmm_m_mmmmWW\nWWm5_____5mWW\nWWm_m_%_m_mWW\nWWm_______mWW\nWWm_______mWW\nWWmmm_V_mmmWW\nWWWWWWWWWWWWW\n";
global.hm_module_vars[$ "area:venuz"].ms2d = "WWWWWWWWWWWWW\nWWXXXX_____WW\nWWXXaX_XXX*WW\nWWXXaXAXXXXWW\nWWaaaaaaaaaWW\nWWaaaaaaaaaWW\nWWaaaaaaaaaWW\nWWaaaaaaaaaWW\nWWaaaaaaaaaWW\nWWaaaaaaaaaWW\nWWWWWWWWWWWWW\n";

global.hm_module_vars[$ "area:venuz"].psd="XXXXXXXXXXXXXX\nXXbbbbbbbbXXXX\nXXbXXXXXXbXXXX\nXXBXXXXXXbXXXX\nXXaXXXXXXbXXXX\nXXAXXXXXXbbbbX\nXXAXXXXXXXXXbX\nXXAXXXXXXXXXbX\nX___XXXXXXXXCX\nX___XXXXXccccX\nX___XXXXXcXXXX\nXX_XXXXXcccXXX\nXXXXXXXXcccXXX\nXXXXXXXXcccXXX\nXXXXXXXXXcXXXX\n";
}

// Source areas/venuz.area.gml:756; area_name
function hm_areas_venuz_area_gml_area_name() {
return ("??" + string(GameCont.subarea));
}

// Source areas/venuz.area.gml:758; area_sprite
function hm_areas_venuz_area_gml_area_sprite(_hml_q) {
if (((GameCont.subarea <= 3) || (GameCont.subarea == 100))) {
{
switch (_hml_q) {
case sprFloor1:
return global.hm_module_vars[$ "area:venuz"].floor1;
;
case sprFloor1B:
return global.hm_module_vars[$ "area:venuz"].floor1;
;
case sprFloor1Explo:
return global.hm_module_vars[$ "area:venuz"].explo1;
;
case sprWall1Trans:
return global.hm_module_vars[$ "area:venuz"].trans1;
;
case sprWall1Bot:
return global.hm_module_vars[$ "area:venuz"].bot1;
;
case sprWall1Out:
return global.hm_module_vars[$ "area:venuz"].out1;
;
case sprWall1Top:
return global.hm_module_vars[$ "area:venuz"].top1;
;
case sprDebris1:
return global.hm_module_vars[$ "area:venuz"].debris1;
;
case sprDetail1:
return global.hm_module_vars[$ "area:venuz"].detail1;
;
}
}
} else {
if ((((GameCont.subarea <= 6) and (GameCont.subarea > 3)) || (GameCont.subarea == 200))) {
{
switch (_hml_q) {
case sprFloor1:
return global.hm_module_vars[$ "area:venuz"].floor2;
;
case sprFloor1B:
return global.hm_module_vars[$ "area:venuz"].floor2;
;
case sprFloor1Explo:
return global.hm_module_vars[$ "area:venuz"].explo2;
;
case sprWall1Trans:
return sprWall2Trans;
;
case sprWall1Bot:
return sprWall2Bot;
;
case sprWall1Out:
return sprWall2Out;
;
case sprWall1Top:
return sprWall2Top;
;
case sprDebris1:
return sprDebris2;
;
case sprDetail1:
return sprDetail2;
;
}
}
} else {
if ((((GameCont.subarea <= 9) and (GameCont.subarea > 6)) || (GameCont.subarea == 300))) {
{
switch (_hml_q) {
case sprFloor1:
return global.hm_module_vars[$ "area:venuz"].floor3;
;
case sprFloor1B:
return global.hm_module_vars[$ "area:venuz"].floor3;
;
case sprFloor1Explo:
return global.hm_module_vars[$ "area:venuz"].explo3;
;
case sprWall1Trans:
return global.hm_module_vars[$ "area:venuz"].trans3;
;
case sprWall1Bot:
return global.hm_module_vars[$ "area:venuz"].bot3;
;
case sprWall1Out:
return global.hm_module_vars[$ "area:venuz"].out3;
;
case sprWall1Top:
return global.hm_module_vars[$ "area:venuz"].top3;
;
case sprDebris1:
return global.hm_module_vars[$ "area:venuz"].debris3;
;
case sprDetail1:
return global.hm_module_vars[$ "area:venuz"].detail3;
;
}
}
} else {
if ((((GameCont.subarea >= 10) and (GameCont.subarea < 100)) || (GameCont.subarea >= 400))) {
{
switch (_hml_q) {
case sprFloor1:
return sprFloor103;
;
case sprFloor1B:
return sprFloor103B;
;
case sprFloor1Explo:
return sprFloor103Explo;
;
case sprWall1Trans:
return sprWall103Trans;
;
case sprWall1Bot:
return sprWall103Bot;
;
case sprWall1Out:
return sprWall103Out;
;
case sprWall1Top:
return sprWall103Top;
;
case sprDebris1:
return sprDebris103;
;
case sprDetail1:
return sprMoney;
;
}
}
}
}
}
}
}

// Source areas/venuz.area.gml:812; area_transit
function hm_areas_venuz_area_gml_area_transit() {
if (((lastarea != scrHMAreaResolve("venuz")) && (lastarea == scrHMAreaResolve("space")))) {
area = scrHMAreaResolve("venuz");
}
}

// Source areas/venuz.area.gml:815; area_finish
function hm_areas_venuz_area_gml_area_finish() {
if ((subarea <= 12)) {
{
area = scrHMAreaResolve("venuz");
;
lastarea = scrHMAreaResolve("venuz");
;
subarea += 1;
;
}
} else {
{
area = scrHMAreaResolve(107);
subarea = 1;
;
scrHMSoundStop(global.hm_module_vars[$ "area:venuz"].gungodz01);
;
scrHMSoundStop(global.hm_module_vars[$ "area:venuz"].gungodz02);
;
scrHMSoundStop(global.hm_module_vars[$ "area:venuz"].gungodz03);
;
scrHMSoundStop(global.hm_module_vars[$ "area:venuz"].gungodz04);
;
scrHMSoundStop(global.hm_module_vars[$ "area:venuz"].gungodz05);
;
scrHMSoundStop(global.hm_module_vars[$ "area:venuz"].gungodz06);
;
scrHMSoundStop(global.hm_module_vars[$ "area:venuz"].gungodz07);
;
}
}
{ var __hm_with1 = scrHMInstances(SpiralCont), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
type = 4;
}
if(__hm_break3) break;
}}
;
{ var __hm_with4 = scrHMInstances(Spiral), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
type = 3;
;
sprite_index = mskNone;
;
}
}
if(__hm_break6) break;
}}
}

// Source areas/venuz.area.gml:834; area_setup
function hm_areas_venuz_area_gml_area_setup() {
if ((GameCont.subarea == 1)) {
{
scrHMSoundLoop(global.hm_module_vars[$ "area:venuz"].gungodz02);
;
scrHMSoundStop(mus1);
;
scrHMSoundStop(mus1b);
;
scrHMSoundStop(mus3);
;
scrHMSoundStop(mus3b);
;
{ var __hm_with1 = scrHMInstances(Player), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
ammo[1] = 0;
;
ammo[2] = 0;
;
ammo[3] = 0;
;
ammo[4] = 0;
;
ammo[5] = 0;
;
wep = scrHMWeaponResolve(0);
;
bwep = scrHMWeaponResolve(0);
scrHMVenusLoadout107();
;
}
}
if(__hm_break3) break;
}}
}
} else {
if ((GameCont.subarea == 4)) {
{
scrHMSoundStop(global.hm_module_vars[$ "area:venuz"].gungodz02);
;
scrHMSoundLoop(global.hm_module_vars[$ "area:venuz"].gungodz03);
;
}
} else {
if ((GameCont.subarea == 7)) {
{
scrHMSoundStop(global.hm_module_vars[$ "area:venuz"].gungodz03);
;
scrHMSoundLoop(global.hm_module_vars[$ "area:venuz"].gungodz04);
;
}
} else {
if ((GameCont.subarea == 10)) {
{
scrHMSoundStop(global.hm_module_vars[$ "area:venuz"].gungodz04);
;
scrHMSoundLoop(global.hm_module_vars[$ "area:venuz"].gungodz06);
;
}
} else {
if ((GameCont.subarea == 12)) {
{
scrHMSoundStop(global.hm_module_vars[$ "area:venuz"].gungodz06);
;
scrHMSoundLoop(global.hm_module_vars[$ "area:venuz"].gungodz07);
;
}
}
}
}
}
}
goal = 1;
if (((GameCont.subarea <= 3) || (GameCont.subarea == 100))) {
{
background_set_colour(make_color_rgb(30, 37, 47));
;
{ var __hm_with4 = scrHMInstances(BackCont), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
shadow_color = c_black;
}
if(__hm_break6) break;
}}
;
}
} else {
if ((((GameCont.subarea <= 6) and (GameCont.subarea > 3)) || (GameCont.subarea == 200))) {
{
background_set_colour(make_color_rgb(76, 89, 70));
;
{ var __hm_with7 = scrHMInstances(TopCont), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
fog = sprFog2;
}
if(__hm_break9) break;
}}
;
{ var __hm_with10 = scrHMInstances(BackCont), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
shadow_color = c_black;
}
if(__hm_break12) break;
}}
;
}
} else {
if ((((GameCont.subarea <= 9) and (GameCont.subarea > 6)) || (GameCont.subarea == 300))) {
{
background_set_colour(make_color_rgb(30, 18, 11));
;
{ var __hm_with13 = scrHMInstances(TopCont), __hm_break15=false;
for (var __hm_index14=0; __hm_index14<array_length(__hm_with13); ++__hm_index14) {
if(instance_exists(__hm_with13[__hm_index14])) with (__hm_with13[__hm_index14]) {
fog = (- 4);
}
if(__hm_break15) break;
}}
;
{ var __hm_with16 = scrHMInstances(BackCont), __hm_break18=false;
for (var __hm_index17=0; __hm_index17<array_length(__hm_with16); ++__hm_index17) {
if(instance_exists(__hm_with16[__hm_index17])) with (__hm_with16[__hm_index17]) {
shadow_color = c_black;
}
if(__hm_break18) break;
}}
;
}
} else {
if ((((GameCont.subarea >= 10) and (GameCont.subarea < 100)) || (GameCont.subarea >= 400))) {
{
background_set_colour(make_color_rgb(197, 190, 122));
;
{ var __hm_with19 = scrHMInstances(TopCont), __hm_break21=false;
for (var __hm_index20=0; __hm_index20<array_length(__hm_with19); ++__hm_index20) {
if(instance_exists(__hm_with19[__hm_index20])) with (__hm_with19[__hm_index20]) {
fog = (- 4);
}
if(__hm_break21) break;
}}
;
{ var __hm_with22 = scrHMInstances(BackCont), __hm_break24=false;
for (var __hm_index23=0; __hm_index23<array_length(__hm_with22); ++__hm_index23) {
if(instance_exists(__hm_with22[__hm_index23])) with (__hm_with22[__hm_index23]) {
shadow_color = 1310738;
}
if(__hm_break24) break;
}}
;
}
} else {
if ((GameCont.subarea == 99)) {
GameCont.subarea = 100;
} else {
if ((GameCont.subarea == 199)) {
GameCont.subarea = 200;
} else {
if ((GameCont.subarea == 299)) {
GameCont.subarea = 300;
} else {
if ((GameCont.subarea == 399)) {
GameCont.subarea = 400;
}
}
}
}
}
}
}
}
{ var __hm_with25 = scrHMInstances(TopCont), __hm_break27=false;
for (var __hm_index26=0; __hm_index26<array_length(__hm_with25); ++__hm_index26) {
if(instance_exists(__hm_with25[__hm_index26])) with (__hm_with25[__hm_index26]) {
darkness = 0;
}
if(__hm_break27) break;
}}
;
{ var __hm_with28 = scrHMInstances(GenCont), __hm_break30=false;
for (var __hm_index29=0; __hm_index29<array_length(__hm_with28); ++__hm_index29) {
if(instance_exists(__hm_with28[__hm_index29])) with (__hm_with28[__hm_index29]) {
{
safespawn = 0;
safedist = (- 12);
}
}
if(__hm_break30) break;
}}
}

// Source areas/venuz.area.gml:899; area_make_floor
function hm_areas_venuz_area_gml_area_make_floor() {
switch (GameCont.subarea) {
case 1:
var _hml_level = global.hm_module_vars[$ "area:venuz"].p1;
;
var _hml_doors = global.hm_module_vars[$ "area:venuz"].p1d;
;
var _hml_height_ = 17;
;
break;
;
case 2:
var _hml_level = global.hm_module_vars[$ "area:venuz"].p2;
;
var _hml_doors = global.hm_module_vars[$ "area:venuz"].p2d;
;
var _hml_height_ = 22;
;
break;
;
case 3:
var _hml_level = global.hm_module_vars[$ "area:venuz"].p3;
;
var _hml_doors = global.hm_module_vars[$ "area:venuz"].p3d;
;
var _hml_height_ = 33;
;
break;
;
case 4:
var _hml_level = global.hm_module_vars[$ "area:venuz"].s1;
;
var _hml_doors = global.hm_module_vars[$ "area:venuz"].s1d;
;
var _hml_height_ = 17;
;
break;
;
case 5:
var _hml_level = global.hm_module_vars[$ "area:venuz"].s2;
;
var _hml_doors = global.hm_module_vars[$ "area:venuz"].s2d;
;
var _hml_height_ = 21;
;
break;
;
case 6:
var _hml_level = global.hm_module_vars[$ "area:venuz"].s3;
;
var _hml_doors = global.hm_module_vars[$ "area:venuz"].s3d;
;
var _hml_height_ = 16;
;
break;
;
case 7:
var _hml_level = global.hm_module_vars[$ "area:venuz"].b1;
;
var _hml_doors = global.hm_module_vars[$ "area:venuz"].b1d;
;
var _hml_height_ = 19;
;
break;
;
case 8:
var _hml_level = global.hm_module_vars[$ "area:venuz"].b2;
;
var _hml_doors = global.hm_module_vars[$ "area:venuz"].b2d;
;
var _hml_height_ = 19;
;
break;
;
case 9:
var _hml_level = global.hm_module_vars[$ "area:venuz"].b3;
;
var _hml_doors = global.hm_module_vars[$ "area:venuz"].b3d;
;
var _hml_height_ = 25;
;
break;
;
case 10:
var _hml_level = global.hm_module_vars[$ "area:venuz"].m1;
;
var _hml_doors = global.hm_module_vars[$ "area:venuz"].m1d;
;
var _hml_height_ = 21;
;
break;
;
case 11:
var _hml_level = global.hm_module_vars[$ "area:venuz"].m2;
;
var _hml_doors = global.hm_module_vars[$ "area:venuz"].m2d;
;
var _hml_height_ = 21;
;
break;
;
case 12:
var _hml_level = global.hm_module_vars[$ "area:venuz"].boss2;
;
var _hml_doors = global.hm_module_vars[$ "area:venuz"].boss2d;
;
var _hml_height_ = 11;
;
break;
;
case 100:
var _hml_level = global.hm_module_vars[$ "area:venuz"].ps;
;
var _hml_doors = global.hm_module_vars[$ "area:venuz"].psd;
;
var _hml_height_ = 15;
;
break;
;
case 200:
var _hml_level = global.hm_module_vars[$ "area:venuz"].ss;
;
var _hml_doors = global.hm_module_vars[$ "area:venuz"].ssd;
;
var _hml_height_ = 25;
;
break;
;
case 300:
var _hml_level = global.hm_module_vars[$ "area:venuz"].bs;
;
var _hml_doors = global.hm_module_vars[$ "area:venuz"].bsd;
;
var _hml_height_ = 18;
;
break;
;
case 400:
var _hml_level = global.hm_module_vars[$ "area:venuz"].ms;
;
var _hml_doors = global.hm_module_vars[$ "area:venuz"].msd;
;
var _hml_height_ = 11;
;
break;
;
case 401:
var _hml_level = global.hm_module_vars[$ "area:venuz"].ms2;
;
var _hml_doors = global.hm_module_vars[$ "area:venuz"].ms2d;
;
var _hml_height_ = 11;
;
break;
;
}
_hml_level = string_split(_hml_level, "\n");
_hml_doors = string_split(_hml_doors, "\n");
var _hml_leng_ = string_length(_hml_level[0]);
;
var _hml_sp_ = 0;
for (var _hml_col = 0; (_hml_col < _hml_height_); _hml_col++) {
for (var _hml_row = 0; (_hml_row < _hml_leng_); _hml_row++) {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "X")) {
{
if ((((GameCont.subarea >= 10) and (GameCont.subarea < 100)) || (GameCont.subarea >= 400))) {
{
{ var __hm_with1 = scrHMInstances(instance_create((_hml_row * 32), (_hml_col * 32), Effect)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
sprite_index = global.hm_module_vars[$ "area:venuz"].wall103out;
;
depth = (20 - (y / 10000));
}
}
if(__hm_break3) break;
}}
{ var __hm_with4 = scrHMInstances(instance_create(((_hml_row * 32) + 16), (_hml_col * 32), Effect)), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
sprite_index = global.hm_module_vars[$ "area:venuz"].wall103out;
;
depth = (20 - (y / 10000));
}
}
if(__hm_break6) break;
}}
{ var __hm_with7 = scrHMInstances(instance_create((_hml_row * 32), ((_hml_col * 32) + 16), Effect)), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
{
sprite_index = global.hm_module_vars[$ "area:venuz"].wall103out;
;
depth = (20 - (y / 10000));
}
}
if(__hm_break9) break;
}}
{ var __hm_with10 = scrHMInstances(instance_create(((_hml_row * 32) + 16), ((_hml_col * 32) + 16), Effect)), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
{
sprite_index = global.hm_module_vars[$ "area:venuz"].wall103out;
;
depth = (20 - (y / 10000));
}
}
if(__hm_break12) break;
}}
{ var __hm_with13 = scrHMInstances(instance_create((_hml_row * 32), ((_hml_col * 32) - 8), Effect)), __hm_break15=false;
for (var __hm_index14=0; __hm_index14<array_length(__hm_with13); ++__hm_index14) {
if(instance_exists(__hm_with13[__hm_index14])) with (__hm_with13[__hm_index14]) {
{
sprite_index = sprWall103Trans;
image_xscale = 2;
image_yscale = 2;
depth = 19;
}
}
if(__hm_break15) break;
}}
{ var __hm_with16 = scrHMInstances(instance_create((_hml_row * 32), (_hml_col * 32), Effect)), __hm_break18=false;
for (var __hm_index17=0; __hm_index17<array_length(__hm_with16); ++__hm_index17) {
if(instance_exists(__hm_with16[__hm_index17])) with (__hm_with16[__hm_index17]) {
{
sprite_index = sprWall103Trans;
image_xscale = 2;
image_yscale = 16;
depth = 20;
image_alpha = 0.2;
}
}
if(__hm_break18) break;
}}
}
}
continue;
;
}
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "W")) {
{
{ var __hm_with19 = scrHMInstances(instance_create(((_hml_row * 32) + 16), ((_hml_col * 32) + 16), CustomObject)), __hm_break21=false;
for (var __hm_index20=0; __hm_index20<array_length(__hm_with19); ++__hm_index20) {
if(instance_exists(__hm_with19[__hm_index20])) with (__hm_with19[__hm_index20]) {
{
sprite_index = sprFloor1;
name = "window";
}
}
if(__hm_break21) break;
}}
}
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "x")) {
{
continue;
;
}
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "+")) {
{
scrHMModCall("mod", "props", "VenuzDoor_create", ((_hml_row * 32) + 16), ((_hml_col * 32) + 16), string_char_at(_hml_doors[_hml_col], _hml_row));
;
{ var __hm_with22 = scrHMInstances(instance_create((_hml_row * 32), (_hml_col * 32), DustOLD)), __hm_break24=false;
for (var __hm_index23=0; __hm_index23<array_length(__hm_with22); ++__hm_index23) {
if(instance_exists(__hm_with22[__hm_index23])) with (__hm_with22[__hm_index23]) {
{
image_speed = (0) * timescale;
image_angle = 0;
direction = 0;
speed = (0) * timescale;
depth = 10;
mask_index = mskFloor;
sprite_index = (instance_nearest(x, y, Floor)).sprite_index;
image_index = 0;
name = "imadoor";
}
}
if(__hm_break24) break;
}}
}
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "=")) {
{
scrHMModCall("mod", "props", "VenuzDoorSide_create", ((_hml_row * 32) + 16), ((_hml_col * 32) + 16), string_char_at(_hml_doors[_hml_col], _hml_row));
;
{ var __hm_with25 = scrHMInstances(instance_create((_hml_row * 32), (_hml_col * 32), DustOLD)), __hm_break27=false;
for (var __hm_index26=0; __hm_index26<array_length(__hm_with25); ++__hm_index26) {
if(instance_exists(__hm_with25[__hm_index26])) with (__hm_with25[__hm_index26]) {
{
image_speed = (0) * timescale;
image_angle = 0;
direction = 0;
speed = (0) * timescale;
depth = 10;
mask_index = mskFloor;
sprite_index = (instance_nearest(x, y, Floor)).sprite_index;
image_index = 0;
name = "imadoor";
}
}
if(__hm_break27) break;
}}
}
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "?")) {
{
scrHMModCall("mod", "props", "VenuzDoor_create", ((_hml_row * 32) + 16), ((_hml_col * 32) + 16), string_char_at(_hml_doors[_hml_col], _hml_row));
;
{ var __hm_with28 = scrHMInstances(instance_create((_hml_row * 32), (_hml_col * 32), DustOLD)), __hm_break30=false;
for (var __hm_index29=0; __hm_index29<array_length(__hm_with28); ++__hm_index29) {
if(instance_exists(__hm_with28[__hm_index29])) with (__hm_with28[__hm_index29]) {
{
image_speed = (0) * timescale;
image_angle = 0;
direction = 0;
speed = (0) * timescale;
depth = 10;
mask_index = mskFloor;
sprite_index = (instance_nearest(x, y, Floor)).sprite_index;
image_index = 0;
imasecret = 1;
}
}
if(__hm_break30) break;
}}
}
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "@")) {
{
scrHMModCall("mod", "props", "VenuzDoorSide_create", ((_hml_row * 32) + 16), ((_hml_col * 32) + 16), string_char_at(_hml_doors[_hml_col], _hml_row));
;
{ var __hm_with31 = scrHMInstances(instance_create((_hml_row * 32), (_hml_col * 32), DustOLD)), __hm_break33=false;
for (var __hm_index32=0; __hm_index32<array_length(__hm_with31); ++__hm_index32) {
if(instance_exists(__hm_with31[__hm_index32])) with (__hm_with31[__hm_index32]) {
{
image_speed = (0) * timescale;
image_angle = 0;
direction = 0;
speed = (0) * timescale;
depth = 10;
mask_index = mskFloor;
sprite_index = (instance_nearest(x, y, Floor)).sprite_index;
image_index = 0;
imasecret = 1;
}
}
if(__hm_break33) break;
}}
}
} else {
{
{ var __hm_with34 = scrHMInstances(instance_create((_hml_row * 32), (_hml_col * 32), Floor)), __hm_break36=false;
for (var __hm_index35=0; __hm_index35<array_length(__hm_with34); ++__hm_index35) {
if(instance_exists(__hm_with34[__hm_index35])) with (__hm_with34[__hm_index35]) {
{
if ((string_char_at(_hml_doors[_hml_col], _hml_row) == "a")) {
door = 1;
} else {
if ((string_char_at(_hml_doors[_hml_col], _hml_row) == "b")) {
door = 2;
} else {
if ((string_char_at(_hml_doors[_hml_col], _hml_row) == "c")) {
door = 3;
} else {
if ((string_char_at(_hml_doors[_hml_col], _hml_row) == "d")) {
door = 4;
} else {
if ((string_char_at(_hml_doors[_hml_col], _hml_row) == "e")) {
door = 5;
} else {
if ((string_char_at(_hml_doors[_hml_col], _hml_row) == "f")) {
door = 6;
} else {
if ((string_char_at(_hml_doors[_hml_col], _hml_row) == "g")) {
door = 7;
} else {
if ((string_char_at(_hml_doors[_hml_col], _hml_row) == "h")) {
door = 8;
} else {
if ((string_char_at(_hml_doors[_hml_col], _hml_row) == "i")) {
door = 9;
} else {
if ((string_char_at(_hml_doors[_hml_col], _hml_row) == "j")) {
door = 10;
} else {
if ((string_char_at(_hml_doors[_hml_col], _hml_row) == "k")) {
door = 11;
} else {
door = 0;
}
}
}
}
}
}
}
}
}
}
}
var _hml__x = (x + 16);
;
var _hml__y = (y + 16);
;
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "E")) {
{ var __hm_with37 = scrHMInstances(instance_create(x, y, CustomObject)), __hm_break39=false;
for (var __hm_index38=0; __hm_index38<array_length(__hm_with37); ++__hm_index38) {
if(instance_exists(__hm_with37[__hm_index38])) with (__hm_with37[__hm_index38]) {
{
name = "VenuzElevator";
image_speed = (0) * timescale;
sprite_index = sprFloor103;
image_index = 1;
depth = 7;
activated = 0;
}
}
if(__hm_break39) break;
}}
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "M")) {
scrHMModCall("mod", "enemies", "VenuzSpawn_create", _hml__x, _hml__y, "Molefish", door);
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "S")) {
scrHMModCall("mod", "enemies", "VenuzSpawn_create", _hml__x, _hml__y, "Molesarge", door);
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "C")) {
scrHMModCall("mod", "enemies", "VenuzSpawn_create", _hml__x, _hml__y, "Charger", door);
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "F")) {
scrHMModCall("mod", "enemies", "VenuzSpawn_create", _hml__x, _hml__y, "prisoner", door);
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "G")) {
scrHMModCall("mod", "enemies", "VenuzSpawn_create", _hml__x, _hml__y, "Minigunner", door);
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "J")) {
scrHMModCall("mod", "enemies", "VenuzSpawn_create", _hml__x, _hml__y, "Jock", door);
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "U")) {
scrHMModCall("mod", "enemies", "VenuzSpawn_create", _hml__x, _hml__y, "FireBaller", door);
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "H")) {
scrHMModCall("mod", "enemies", "VenuzSpawn_create", _hml__x, _hml__y, "SuperFireBaller", door);
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "t")) {
scrHMModCall("mod", "enemies", "VenuzSpawn_create", _hml__x, _hml__y, "Turtle", door);
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "r")) {
scrHMModCall("mod", "ratboss", "ratbosssleep_create", _hml__x, _hml__y);
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "&")) {
scrHMModCall("mod", "gungod", "GunGod_create", _hml__x, (_hml__y - 72));
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "O")) {
{ var __hm_with40 = scrHMInstances(instance_create(_hml__x, _hml__y, Effect)), __hm_break42=false;
for (var __hm_index41=0; __hm_index41<array_length(__hm_with40); ++__hm_index41) {
if(instance_exists(__hm_with40[__hm_index41])) with (__hm_with40[__hm_index41]) {
{
image_speed = (0) * timescale;
sprite_index = global.hm_module_vars[$ "area:venuz"].VenuzBars1Open;
shadow = 1;
}
}
if(__hm_break42) break;
}}
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "-")) {
scrHMModCall("mod", "props", "VenuzBars_create", _hml__x, _hml__y);
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "|")) {
scrHMModCall("mod", "props", "VenuzBarsSide_create", _hml__x, _hml__y);
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "P")) {
instance_create(_hml__x, _hml__y, PlantPot);
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "B")) {
instance_create(_hml__x, _hml__y, Barrel);
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "b")) {
instance_create(_hml__x, _hml__y, Cactus);
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "%")) {
{
instance_create(_hml__x, (_hml__y - 16), VenuzCouch);
instance_create(_hml__x, _hml__y, VenuzCarpet);
}
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "V")) {
{ var __hm_with43 = scrHMInstances(instance_create(_hml__x, (_hml__y + 16), VenuzTV)), __hm_break45=false;
for (var __hm_index44=0; __hm_index44<array_length(__hm_with43); ++__hm_index44) {
if(instance_exists(__hm_with43[__hm_index44])) with (__hm_with43[__hm_index44]) {
spr_shadow = mskNone;
}
if(__hm_break45) break;
}}
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "m")) {
instance_create(_hml__x, _hml__y, MoneyPile);
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "T")) {
scrHMModCall("mod", "props", "VenuzStar_create", _hml__x, _hml__y);
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "a")) {
scrHMModCall("mod", "props", "VenuzAmmo1_create", _hml__x, _hml__y);
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "A")) {
scrHMModCall("mod", "props", "VenuzAmmo2_create", _hml__x, _hml__y);
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "R")) {
scrHMModCall("mod", "props", "VenuzAmmo3_create", _hml__x, _hml__y);
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "h")) {
scrHMModCall("mod", "enemies", "VenuzSpawn_create", _hml__x, _hml__y, "HP", door);
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "2")) {
{ var __hm_with46 = scrHMInstances(instance_create((_hml__x - 10), _hml__y, WepPickup)), __hm_break48=false;
for (var __hm_index47=0; __hm_index47<array_length(__hm_with46); ++__hm_index47) {
if(instance_exists(__hm_with46[__hm_index47])) with (__hm_with46[__hm_index47]) {
{
wep = scrHMWeaponResolve("secretweapong2");
rotation = 0;
ammo = 1;
}
}
if(__hm_break48) break;
}}
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "3")) {
{ var __hm_with49 = scrHMInstances(instance_create((_hml__x - 13), _hml__y, WepPickup)), __hm_break51=false;
for (var __hm_index50=0; __hm_index50<array_length(__hm_with49); ++__hm_index50) {
if(instance_exists(__hm_with49[__hm_index50])) with (__hm_with49[__hm_index50]) {
{
wep = scrHMWeaponResolve("secretweapong3");
rotation = 0;
ammo = 1;
}
}
if(__hm_break51) break;
}}
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "4")) {
{ var __hm_with52 = scrHMInstances(instance_create((_hml__x - 17), _hml__y, WepPickup)), __hm_break54=false;
for (var __hm_index53=0; __hm_index53<array_length(__hm_with52); ++__hm_index53) {
if(instance_exists(__hm_with52[__hm_index53])) with (__hm_with52[__hm_index53]) {
{
wep = scrHMWeaponResolve("secretweapong4");
rotation = 0;
ammo = 1;
}
}
if(__hm_break54) break;
}}
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "5")) {
instance_create(_hml__x, _hml__y, GiantWeaponChest);
} else {
if ((string_char_at(_hml_level[_hml_col], _hml_row) == "*")) {
{ var __hm_with55 = scrHMInstances(instance_create(_hml__x, _hml__y, CustomObject)), __hm_break57=false;
for (var __hm_index56=0; __hm_index56<array_length(__hm_with55); ++__hm_index56) {
if(instance_exists(__hm_with55[__hm_index56])) with (__hm_with55[__hm_index56]) {
{
name = "spawnpoint";
ind_ = _hml_sp_;
_hml_sp_++;
}
}
if(__hm_break57) break;
}}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
if ((((GameCont.subarea >= 10) and (GameCont.subarea < 100)) || (GameCont.subarea >= 400))) {
{
{ var __hm_with58 = scrHMInstances(instance_create((_hml_row * 32), (_hml_col * 32), Effect)), __hm_break60=false;
for (var __hm_index59=0; __hm_index59<array_length(__hm_with58); ++__hm_index59) {
if(instance_exists(__hm_with58[__hm_index59])) with (__hm_with58[__hm_index59]) {
{
sprite_index = sprWall103Trans;
image_xscale = 2;
image_yscale = 16;
depth = 20;
image_alpha = 0.1;
}
}
if(__hm_break60) break;
}}
}
}
}
}
if(__hm_break36) break;
}}
}
}
}
}
}
}
}
}
}
}
}

// Source areas/venuz.area.gml:1238; area_start
function hm_areas_venuz_area_gml_area_start() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_areas_venuz_area_gml_area_start_resume, id, scrHMOther(other), _args, 6, []);
}
function hm_areas_venuz_area_gml_area_start_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_areas_venuz_area_gml_area_start");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // areas/venuz.area.gml:1306
{
;
}
_hm.pc=0;
break;
case 2: // areas/venuz.area.gml:1306
_hm.result=undefined; _hm.done=true; return;
break;
case 3: // areas/venuz.area.gml:1302
{
{ var __hm_with1 = scrHMMatchingGT(Floor, "door", 0), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
scrHMModCall("mod", "enemies", "VenuzSpawn_create", x, y, "floor", door);
;
scrHMDelete(id);
}
}
if(__hm_break3) break;
}}
}
_hm.pc=2;
break;
case 4: // areas/venuz.area.gml:1301
_hm.wait_ticks=max(0,1); _hm.pc=3; return;
break;
case 5: // areas/venuz.area.gml:1300
_hm.pc = (scrHMTaskFork(_hm, 4)) ? 4 : 0;
break;
case 6: // areas/venuz.area.gml:1244
{
{ var __hm_with4 = scrHMMatching(GameObject, "object_index", RadChest, HealthChest, RogueChest), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
instance_change(Wind, 1);
instance_destroy();
}
}
if(__hm_break6) break;
}}
{ var __hm_with7 = scrHMInstances(instance_create((- 1000), (- 1000), CustomEnemy)), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
{
name = "portalblocker";
canfly = 1;
scrHMMaxHealthWrite(id, 10000, "=");
hp = 10000;
}
}
if(__hm_break9) break;
}}
{ var __hm_with10 = scrHMMatching(CustomObject, "name", "window"), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
{
{ var __hm_with13 = scrHMInstances(Floor), __hm_break15=false;
for (var __hm_index14=0; __hm_index14<array_length(__hm_with13); ++__hm_index14) {
if(instance_exists(__hm_with13[__hm_index14])) with (__hm_with13[__hm_index14]) {
if ((distance_to_object((scrHMOther(other))) <= (- 1))) {
scrHMDelete(id);
}
}
if(__hm_break15) break;
}}
{ var __hm_with16 = scrHMAuthoredWalls105(), __hm_break18=false;
for (var __hm_index17=0; __hm_index17<array_length(__hm_with16); ++__hm_index17) {
if(instance_exists(__hm_with16[__hm_index17])) with (__hm_with16[__hm_index17]) {
if ((point_distance((x + 8), (y + 4), (scrHMOther(other)).x, (scrHMOther(other)).y) <= 14)) {
scrHMDelete(id);
}
}
if(__hm_break18) break;
}}
}
}
if(__hm_break12) break;
}}
{ var __hm_with19 = scrHMInstances(Floor), __hm_break21=false;
for (var __hm_index20=0; __hm_index20<array_length(__hm_with19); ++__hm_index20) {
if(instance_exists(__hm_with19[__hm_index20])) with (__hm_with19[__hm_index20]) {
{
if (((((! position_meeting((x - 16), (y - 16), Floor)) and (! position_meeting((x - 16), (y - 16), Wall))) and (! position_meeting((x - 16), (y - 16), InvisiWall))) and (! position_meeting((x - 16), (y - 16), DustOLD)))) {
instance_create((x - 16), (y - 16), InvisiWall);
}
if (((((! position_meeting(x, (y - 16), Floor)) and (! position_meeting(x, (y - 16), Wall))) and (! position_meeting(x, (y - 16), InvisiWall))) and (! position_meeting(x, (y - 16), DustOLD)))) {
instance_create(x, (y - 16), InvisiWall);
}
if (((((! position_meeting((x + 16), (y - 16), Floor)) and (! position_meeting((x + 16), (y - 16), Wall))) and (! position_meeting((x + 16), (y - 16), InvisiWall))) and (! position_meeting((x + 16), (y - 16), DustOLD)))) {
instance_create((x + 16), (y - 16), InvisiWall);
}
if (((((! position_meeting((x + 32), (y - 16), Floor)) and (! position_meeting((x + 32), (y - 16), Wall))) and (! position_meeting((x + 32), (y - 16), InvisiWall))) and (! position_meeting((x + 32), (y - 16), DustOLD)))) {
instance_create((x + 32), (y - 16), InvisiWall);
}
if (((((! position_meeting((x + 32), y, Floor)) and (! position_meeting((x + 32), y, Wall))) and (! position_meeting((x + 32), y, InvisiWall))) and (! position_meeting((x + 32), y, DustOLD)))) {
instance_create((x + 32), y, InvisiWall);
}
if (((((! position_meeting((x + 32), (y + 16), Floor)) and (! position_meeting((x + 32), (y + 16), Wall))) and (! position_meeting((x + 32), (y + 16), InvisiWall))) and (! position_meeting((x + 32), (y + 16), DustOLD)))) {
instance_create((x + 32), (y + 16), InvisiWall);
}
if (((((! position_meeting((x - 16), y, Floor)) and (! position_meeting((x - 16), y, Wall))) and (! position_meeting((x - 16), y, InvisiWall))) and (! position_meeting((x - 16), y, DustOLD)))) {
instance_create((x - 16), y, InvisiWall);
}
if (((((! position_meeting((x - 16), (y + 16), Floor)) and (! position_meeting((x - 16), (y + 16), Wall))) and (! position_meeting((x - 16), (y + 16), InvisiWall))) and (! position_meeting((x - 16), (y + 16), DustOLD)))) {
instance_create((x - 16), (y + 16), InvisiWall);
}
if (((((! position_meeting((x - 16), (y + 32), Floor)) and (! position_meeting((x - 16), (y + 32), Wall))) and (! position_meeting((x - 16), (y + 32), InvisiWall))) and (! position_meeting((x - 16), (y + 32), DustOLD)))) {
instance_create((x - 16), (y + 32), InvisiWall);
}
if (((((! position_meeting(x, (y + 32), Floor)) and (! position_meeting(x, (y + 32), Wall))) and (! position_meeting(x, (y + 32), InvisiWall))) and (! position_meeting(x, (y + 32), DustOLD)))) {
instance_create(x, (y + 32), InvisiWall);
}
if (((((! position_meeting((x + 16), (y + 32), Floor)) and (! position_meeting((x + 16), (y + 32), Wall))) and (! position_meeting((x + 16), (y + 32), InvisiWall))) and (! position_meeting((x + 16), (y + 32), DustOLD)))) {
instance_create((x + 16), (y + 32), InvisiWall);
}
if (((((! position_meeting((x + 32), (y + 32), Floor)) and (! position_meeting((x + 32), (y + 32), Wall))) and (! position_meeting((x + 32), (y + 32), InvisiWall))) and (! position_meeting((x + 32), (y + 32), DustOLD)))) {
instance_create((x + 32), (y + 32), InvisiWall);
}
}
}
if(__hm_break21) break;
}}
}
_hm.pc=5;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}


// Source areas/venuz.area.gml:1311; area_pop_enemies
function hm_areas_venuz_area_gml_area_pop_enemies() {

}

// Source areas/venuz.area.gml:1313; area_pop_props
function hm_areas_venuz_area_gml_area_pop_props() {

}

// Source areas/venuz.area.gml:1315; area_mapdata
function hm_areas_venuz_area_gml_area_mapdata(_hml_lx, _hml_ly, _hml_lp, _hml_ls, _hml_ws, _hml_ll) {
return [_hml_lx, 0];
;
}
