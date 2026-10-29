max_hp=1;size=1;dir=choose(1,2,3);
switch(dir) {
case 1:spr_idle=sprTable1;spr_hurt=sprTable1Hurt;spr_dead=sprTable1Dead;break;
case 2:spr_idle=sprTable2;spr_hurt=sprTable2Hurt;spr_dead=sprTable2Dead;break;
case 3:spr_idle=sprFallenChair;spr_hurt=sprFallenChairHurt;spr_dead=sprFallenChairDead;break;
}
event_inherited();sprite_index=spr_idle;mask_index=-1;
