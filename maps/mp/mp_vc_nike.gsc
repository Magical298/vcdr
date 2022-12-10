// __/\\\________/\\\_______________________________________________________________________/\\\\\\\\\__/\\\\\\_________________________________        
//  _\/\\\_______\/\\\____________________________________________________________________/\\\////////__\////\\\_________________________________       
//   _\//\\\______/\\\___/\\\__________________/\\\_______/\\\___________________________/\\\/______________\/\\\_________________________________      
//   __\//\\\____/\\\___\///___/\\\\\\\\\\__/\\\\\\\\\\\_\///______/\\\\\\\\____________/\\\________________\/\\\_____/\\\\\\\\\_____/\\/\\\\\\___     
//    ___\//\\\__/\\\_____/\\\_\/\\\//////__\////\\\////___/\\\___/\\\//////____________\/\\\________________\/\\\____\////////\\\___\/\\\////\\\__    
//     ____\//\\\/\\\_____\/\\\_\/\\\\\\\\\\____\/\\\______\/\\\__/\\\___________________\//\\\_______________\/\\\______/\\\\\\\\\\__\/\\\__\//\\\_   
//      _____\//\\\\\______\/\\\_\////////\\\____\/\\\_/\\__\/\\\_\//\\\___________________\///\\\_____________\/\\\_____/\\\/////\\\__\/\\\___\/\\\_  
//       ______\//\\\_______\/\\\__/\\\\\\\\\\____\//\\\\\___\/\\\__\///\\\\\\\\______________\////\\\\\\\\\__/\\\\\\\\\_\//\\\\\\\\/\\_\/\\\___\/\\\_ 
//        _______\///________\///__\//////////______\/////____\///_____\////////__________________\/////////__\/////////___\////////\//__\///____\///__

/*
  _   ________   _  __              _        
 | | / / ___( ) / |/ /__ ___  ___  (_)_ _____
 | |/ / /__ |/ /    / -_) _ \/ _ \/ / // (_-<
 |___/\___/   /_/|_/\__/_//_/_//_/_/\_,_/___/
                                             
 © VC' Blade
*/

main()
{
	maps\mp\_load::main();

	game["allies"] = "marines";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "desert";
	game["axis_soldiertype"] = "desert";
	
	//dvars
	setdvar( "r_specularcolorscale", "1" );
    setdvar( "r_glowbloomintensity0", ".25" );
    setdvar( "r_glowbloomintensity1", ".25" );
    setdvar( "r_glowskybleedintensity0", ".3" );
    setdvar( "compassmaxrange", "1800" );
	setDvar("bg_falldamagemaxheight", 700 );
	setDvar("bg_falldamageminheight", 500 );
	
	//Precaches
	precacheItem ( "ak47_mp" );
	precacheItem ( "winchester1200_mp" );
	precacheItem ( "uzi_mp" );
	precacheItem ( "mp5_mp" );
	precacheItem ( "barrett_mp" );
	
	//fx
	level.poo = LoadFX ( "mp_vc_nike/toilet" );
	level.explosion = LoadFX ( "mp_vc_nike/explosion" );
	level.light = LoadFX ( "mp_vc_nike/light" );
	
	//normal shit
	level.nike_glow=(randomint(100)/100,randomint(100)/100,randomint(100)/100);
	thread startdoor();
	thread nike_0();
	thread bounce();
	thread bouncer();
	thread nike_it_up();
	thread elevator();
	thread vip_room();
	thread get_weap();
	thread hud();
	
	//traps
	
	thread levler();
	thread trap_1();
	thread trap_2();
	thread trap_3();
	thread trap_4();
	thread trap_5();
	thread trap_6();
	thread trap_7();
	thread trap_8();
	thread trap_9();
	thread trap_10();
	
	//endrooms
	
	thread endroom_knife();
	thread endroom_snipe();
	thread endroom_jump();
	
	//secret
	
	thread port_1();
	thread port_2();
	thread port_3();
	thread port_4();
	thread port_5();
	thread port_6();
	thread port_7();
	thread vip_weap();
	
	//music
	if(!isdefined(level.music))
		level.music=[];

	level.music[0]["song"]	="20syl - Ongoing Thing";
	level.music[0]["alias"]	="ambient_1";
	level.music[1]["song"]	="A-Track - Ray ban Vision";
	level.music[1]["alias"]	="ambient_2";
	level.music[2]["song"]	="Linkin Park - Breaking The Habit";
	level.music[2]["alias"]	="ambient_3";
	level.music[3]["song"]	="Majid Jordan - A Place like this";
	level.music[3]["alias"]	="ambient_4";
	level.music[4]["song"]	="Yelawolf - Animal";
	level.music[4]["alias"]	="ambient_5";
	
	thread musictrig();

	// Anti Freerun
	addtriggertolist("trap_1_trigger");
	addtriggertolist("trap_2_trigger");
	addtriggertolist("trap_3_trigger");
	addtriggertolist("trap_4_trigger");
	addtriggertolist("trap_5_trigger");
	addtriggertolist("trap_6_trigger");
	addtriggertolist("trap_7_trigger");
	addtriggertolist("trap_8_trigger");
	addtriggertolist("trap_9_trigger");
	addtriggertolist("trap_10_trigger");
}

addTriggerToList( name )
{
    if( !isDefined( level.trapTriggers ) )
        level.trapTriggers = [];
    level.trapTriggers[level.trapTriggers.size] = getEnt( name, "targetname" );
}

startdoor()
{
	door=getent("startdoor","targetname");

	level waittill("round_started");

	ambientstop();
	musicstop();
	ambientplay("ambient_nike");

	wait 12;
	iprintLnBold ( "^0<< ^7Map by VC' Nennius ^0>>" );
	door moveZ ( 264, 10 );
	wait 5;
	door delete();
}

//by Blade
hud()
{
    if( isDefined( level.icomarhud ) )
        level.icomarhud destroy();
 
    level.icomarhud = newHudElem();
    level.icomarhud.foreground = true;
    level.icomarhud.alignX = "center";
    level.icomarhud.alignY = "top";
    level.icomarhud.horzAlign = "center";
    level.icomarhud.vertAlign = "top";
    level.icomarhud.x = 4;
    level.icomarhud.y = 0;
    level.icomarhud.sort = 0;
    level.icomarhud.fontScale = 2;
    level.icomarhud.font = "objective";
    level.icomarhud.glowAlpha = 1;
    level.icomarhud.hidewheninmenu = true;

    if(isdefined(level.randomcolor))
    	level.icomarhud.glowcolor=level.randomcolor;
    else 
    	level.icomarhud.glowcolor=level.nike_glow;

    level.icomarhud setText( "Vistic's Nike" );
    wait 15;
	level.icomarhud setText( "Map by VC' Nennius" );
	wait 15;
	level.icomarhud setText( "Additional help: VC' Icomar" );
	wait 15;
	level.icomarhud setText( "Just do It" );
	wait 15;

	if( isDefined( level.icomarhud ) )
        level.icomarhud destroy();
}

nike_0()
{
	target = getEnt ( "nike_0", "targetname" );
	
	while(1)
	{
		target rotateYaw ( 360, 20 );
		wait 20;
	}
}

bounce()
{
	target = getEnt ( "secret_bounce", "targetname" );
	trigger = getEnt ( "secret_bounce_trigger", "targetname" );
	
	target moveY ( -200, 3, 1, 2 );
	wait 5;
	
	trigger waittill ( "trigger", player );
	trigger delete();
	
	while(1)
	{
		target moveY ( 200, 3, 1, 2 );
		wait 5;
		target moveY ( -200, 3, 1, 2 );
		wait 5;
	}
}

bouncer()
{
	trigger = getEnt ( "bouncer", "targetname" );
	
	while(1)
	{
		trigger waittill ( "trigger", who );
		thread bounce_the_player(who);
	}
}

bounce_the_player(who)
{
	oldpos = who.origin;
	strenght = 3;
	for( i=0; i<strenght; i++ )
	{
	    who.health += 230;
        who finishPlayerDamage(who, level.jumpattacker, 230, 0, "MOD_FALLING", "jump_mp", who.origin, AnglesToForward((-90,0,0)), "none", 0);
	}
}

nike_it_up()
{
	trigger = getEnt ( "nike_it_up", "targetname" );
	target = getEnt ( "nike_it_up_clip", "targetname" );
	thread poo();
	
	wait 15;
	
	while(1)
	{
		trigger waittill ( "trigger", player );
		
		i = randomintrange( 0, 8 );
		if(i == 0)
		{
			player LinkTo( target );
			wait 1;
		
			target moveZ ( 300, 4 );
			wait 7;
		
			target moveZ ( 1500, 20 );
			wait 30;
		
			player UnLink();
			wait 1;
			
			trigger delete();
		}
		else if(i == 1)
		{
			wait 3;
		}
		else if(i == 2)
		{
			wait 3;
		}
		else if(i == 3)
		{
			wait 3;
		}
		else if(i == 4)
		{
			wait 10;
		}
		else if(i == 5)
		{
			wait 10;
		}
		else if(i == 6)
		{
			wait 10;
		}
		else if(i == 7)
		{
			wait 10;
		}
	}
}

elevator()
{
	trigger = getEnt ( "elevator_trigger", "targetname" );
	target = getEnt ( "elevator", "targetname" );
	
	trigger waittill ( "trigger", player );
	trigger delete();
	
	while(1)
	{
		target moveZ ( -208, 3, 1, 2 );
		wait 5;
		target moveZ ( 208, 3, 1, 2 );
		wait 5;
	}
}
	
poo()
{
	target = getEnt ( "toilet", "targetname" );
	trigger = getEnt ( "toilet_trigger", "targetname" );
	clip = getEnt ( "toilet_clip", "targetname" );
	
	trigger waittill ( "trigger", player );
	trigger delete();
	playLoopedFx ( level.poo, 2, target.origin );
	wait 0.5;
	
	clip notSolid();
	wait 180;
	
	clip Solid();
}

get_weap()
{
	trigger = getEnt ( "get_weap", "targetname" );
	
	while(1)
	{
		trigger setHintstring ( "^0<< ^7Get Weapon ^0>>" );
		wait 0.5;
		
		trigger waittill ( "trigger", player );
		trigger setHintstring ( "^0<< ^7Loading ^0>>" );
		wait 0.5;
		
		player GiveWeapon ( "m40a3_mp" );
		player GiveMaxAmmo ( "m40a3_mp" );
		player SwitchToWeapon ( "m40a3_mp" );
		wait 0.5;
	}
}

//traps

levler()
{
	target_1 = getEnt ( "nike_1", "targetname" );
	target_2 = getEnt ( "nike_2", "targetname" );
	target_3 = getEnt ( "nike_3", "targetname" );
	target_4 = getEnt ( "nike_4", "targetname" );
	target_5 = getEnt ( "nike_5", "targetname" );
	target_6 = getEnt ( "nike_6", "targetname" );
	target_7 = getEnt ( "nike_7", "targetname" );
	target_8 = getEnt ( "nike_8", "targetname" );
	target_9 = getEnt ( "nike_9", "targetname" );
	target_10 = getEnt ( "nike_10", "targetname" );
	knife = getEnt ( "knife_rotate", "targetname" );
	wall = getEnt ( "knife_rotate_wall", "targetname" );
	nike = getEnt ( "knife_nike_model", "targetname" );
	sniper = getEnt ( "sniper_sphere", "targetname" );
	sniper_nike = getEnt ( "sniper_nike", "targetname" );
	bounce = getEnt ( "bounceroom_weap", "targetname" );
	jump = getEnt ( "jump_sky", "targetname" );
	
	wall LinkTo( knife );
	
	while(1)
	{
		target_1 rotateYaw ( 360, 10 );
		target_2 rotateYaw ( 360, 10 );
		target_3 rotateYaw ( 360, 10 );
		target_4 rotateYaw ( 360, 10 );
		target_5 rotateYaw ( 360, 10 );
		target_6 rotateYaw ( 360, 10 );
		target_7 rotateYaw ( 360, 10 );
		target_8 rotateYaw ( 360, 10 );
		target_9 rotateYaw ( 360, 10 );
		target_10 rotateYaw ( 360, 10 );
		jump rotatePitch ( 150, 10 );
		knife rotateYaw ( 360, 10 );
		nike rotateYaw ( -360, 10 );
		sniper rotatePitch ( 180, 10 );
		sniper_nike rotateYaw ( 360, 10 );
		bounce rotateYaw ( 360, 10 );
		wait 10;
	}
}

trap_1()
{
	trigger = getEnt ( "trap_1_trigger", "targetname" );
	target_1 = getEnt ( "trap_1_target_a", "targetname" );
	target_2 = getEnt ( "trap_1_target_b", "targetname" );
	
	trigger setHintString("^0<<^7Just do It^0>>");
	
	trigger waittill ( "trigger", player );
	trigger setHintString("^0<<^7NIKE^0>>");
	player braxi\_rank::giveRankXp( "trap_activation" );
	
	i = randomintrange( 0, 2 );
	if(i == 0)
	{
		target_1 hide();
		wait 0.05;
		target_1 notSolid();
	}
	else if(i == 1)
	{
		target_2 hide();
		wait 0.05;
		target_2 notSolid();
	}
}

trap_2()
{
	trigger = getEnt ( "trap_2_trigger", "targetname" );
	target = getEnt ( "trap_2_target", "targetname" );
	
	trigger setHintString("^0<<^7Just do It^0>>");
	
	trigger waittill ( "trigger", player );
	trigger setHintString("^0<<^7NIKE^0>>");
	player braxi\_rank::giveRankXp( "trap_activation" );
	
	while(1)
	{
		target RotatePitch ( -360, 4 );
		wait 4;
	}
}

trap_3()
{
	trigger = getEnt ( "trap_3_trigger", "targetname" );
	target = getEnt ( "trap_3_target", "targetname" );
	
	trigger setHintString("^0<<^7Just do It^0>>");
	
	trigger waittill ( "trigger", player );
	trigger setHintString("^0<<^7NIKE^0>>");
	player braxi\_rank::giveRankXp( "trap_activation" );
	
	while(1)
	{
		i = randomintrange( 0, 2 );
		if(i == 0)
		{
			target moveZ ( 160, 3 );
			wait 5;
			
			target moveZ ( -160, 3 );
			wait 10;
		}
		else if(i == 1)
		{
			target moveY ( -300, 3 );
			wait 5;
			
			target moveY ( 300, 3 );
			wait 10;
		}
	}
}

trap_4()
{
	trigger = getEnt ( "trap_4_trigger", "targetname" );
	target = getEnt ( "trap_4_target", "targetname" );
	
	trigger setHintString("^0<<^7Just do It^0>>");
	
	trigger waittill ( "trigger", player );
	trigger setHintString("^0<<^7NIKE^0>>");
	player braxi\_rank::giveRankXp( "trap_activation" );
	
	target hide();
	wait 1;
	
	target notSolid();
	wait 5;
}

trap_5()
{
	trigger = getEnt ( "trap_5_trigger", "targetname" );
	target_1 = getEnt ( "trap_5_target_a", "targetname" );
	hurt_1 = getEnt ( "trap_5_hurt_a", "targetname" );
	target_2 = getEnt ( "trap_5_target_b", "targetname" );
	hurt_2 = getEnt ( "trap_5_hurt_b", "targetname" );
	target_3 = getEnt ( "trap_5_target_c", "targetname" );
	hurt_3 = getEnt ( "trap_5_hurt_c", "targetname" );
	target_4 = getEnt ( "trap_5_target_d", "targetname" );
	hurt_4 = getEnt ( "trap_5_hurt_d", "targetname" );
	target_5 = getEnt ( "trap_5_target_e", "targetname" );
	hurt_5 = getEnt ( "trap_5_hurt_e", "targetname" );
	target_6 = getEnt ( "trap_5_target_f", "targetname" );
	hurt_6 = getEnt ( "trap_5_hurt_f", "targetname" );
	
	hurt_1 enableLinkTo();
	hurt_1 LinkTo( target_1 );
	hurt_2 enableLinkTo();
	hurt_2 LinkTo( target_2 );
	hurt_3 enableLinkTo();
	hurt_3 LinkTo( target_3 );
	hurt_4 enableLinkTo();
	hurt_4 LinkTo( target_4 );
	hurt_5 enableLinkTo();
	hurt_5 LinkTo( target_5 );
	hurt_6 enableLinkTo();
	hurt_6 LinkTo( target_6 );
	wait 1;
	
	target_1 moveZ ( -300, 1 );
	target_2 moveZ ( -300, 1 );
	target_3 moveZ ( -300, 1 );
	target_4 moveZ ( -300, 1 );
	target_5 moveZ ( -300, 1 );
	target_6 moveZ ( -300, 1 );
	wait 1;
	
	target_1 notSolid();
	target_2 notSolid();
	target_3 notSolid();
	target_4 notSolid();
	target_5 notSolid();
	target_6 notSolid();
	wait 1;
	
	trigger setHintString("^0<<^7Just do It^0>>");
	
	trigger waittill ( "trigger", player );
	trigger setHintString("^0<<^7NIKE^0>>");
	player braxi\_rank::giveRankXp( "trap_activation" );
	thread back_spike();
	
	target_1 moveZ ( 300, 0.5 );
	wait 0.5;
	target_2 moveZ ( 300, 0.5 );
	wait 0.5;
	target_3 moveZ ( 300, 0.5 );
	wait 0.5;
	target_4 moveZ ( 300, 0.5 );
	wait 0.5;
	target_5 moveZ ( 300, 0.5 );
	wait 0.5;
	target_6 moveZ ( 300, 0.5 );
	wait 0.5;
}	
	
back_spike()
{
	target_1 = getEnt ( "trap_5_target_a", "targetname" );
	target_2 = getEnt ( "trap_5_target_b", "targetname" );
	target_3 = getEnt ( "trap_5_target_c", "targetname" );
	target_4 = getEnt ( "trap_5_target_d", "targetname" );
	target_5 = getEnt ( "trap_5_target_e", "targetname" );
	target_6 = getEnt ( "trap_5_target_f", "targetname" );
	
	wait 1;
	
	target_1 moveZ ( -300, 1 );
	wait 1;
	target_2 moveZ ( -300, 1 );
	wait 1;
	target_3 moveZ ( -300, 1 );
	wait 1;
	target_4 moveZ ( -300, 1 );
	wait 1;
	target_5 moveZ ( -300, 1 );
	wait 1;
	target_6 moveZ ( -300, 1 );
	wait 1;
}

trap_6()
{
	trigger = getEnt ( "trap_6_trigger", "targetname" );
	target_1 = getEnt ( "trap_6_target_a", "targetname" );
	target_2 = getEnt ( "trap_6_target_b", "targetname" );
	
	trigger setHintString("^0<<^7Just do It^0>>");
	
	trigger waittill ( "trigger", player );
	trigger setHintString("^0<<^7NIKE^0>>");
	player braxi\_rank::giveRankXp( "trap_activation" );
	
	target_1 notSolid();
	target_2 notSolid();
	wait 0.05;
	
	target_1 rotateRoll ( 90, 3 );
	target_2 rotateRoll ( -90, 3 );
	wait 10;
	target_1 rotateRoll ( -90, 3 );
	target_2 rotateRoll ( 90, 3 );
	wait 3;
	
	target_1 Solid();
	target_2 Solid();
	wait 0.05;
}

trap_7()
{
	trigger = getEnt ( "trap_7_trigger", "targetname" );
	target_1 = getEnt ( "trap_7_target_a", "targetname" );
	target_2 = getEnt ( "trap_7_target_b", "targetname" );
	
	trigger setHintString("^0<<^7Just do It^0>>");
	
	target_1 hide();
	target_1 notSolid();
	target_2 hide();
	target_2 notSolid();
	
	trigger waittill ( "trigger", player );
	trigger setHintString("^0<<^7NIKE^0>>");
	player braxi\_rank::giveRankXp( "trap_activation" );
	
	target_1 show();
	target_1 Solid();
	target_2 show();
	target_2 Solid();
	wait 0.05;
	
	target_1 moveY ( 128, 3 );
	wait 3.5;
	
	while(1)
	{
		target_1 moveX ( -992, 10 );
		target_2 moveX ( 992, 10 );
		wait 10.5;
		
		target_1 moveY ( -128, 3 );
		target_2 moveY ( 128, 3 );
		wait 3.5;
		
		target_1 moveX ( 992, 10 );
		target_2 moveX ( -992, 10 );
		wait 10.5;
		
		target_1 moveY ( 128, 3 );
		target_2 moveY ( -128, 3 );
		wait 3.5;
	}
}

trap_8()
{
	trigger = getEnt ( "trap_8_trigger", "targetname" );
	target_1 = getEnt ( "trap_8_target_a", "targetname" );
	target_2 = getEnt ( "trap_8_target_b", "targetname" );
	hurt_1 = getEnt ( "trap_8_hurt_a", "targetname" );
	hurt_2 = getEnt ( "trap_8_hurt_b", "targetname" );
	
	hurt_1 enableLinkTo();
	hurt_1 LinkTo( target_2 );
	hurt_2 enableLinkTo();
	hurt_2 LinkTo( target_2 );
	
	trigger setHintString("^0<<^7Just do It^0>>");
	
	trigger waittill ( "trigger", player );
	trigger setHintString("^0<<^7NIKE^0>>");
	player braxi\_rank::giveRankXp( "trap_activation" );
	
	target_2 notSolid();
	
	while(1)
	{
		target_2 rotateYaw ( 360, 2 );
		target_1 rotateYaw ( 361, 2 );
		wait 2;
	}
}

trap_9()
{
	trigger = getEnt ( "trap_9_trigger", "targetname" );
	target_1 = getEnt ( "trap_9_target_a", "targetname" );
	target_2 = getEnt ( "trap_9_target_b", "targetname" );
	
	trigger setHintString("^0<<^7Just do It^0>>");
	
	trigger waittill ( "trigger", player );
	trigger setHintString("^0<<^7NIKE^0>>");
	player braxi\_rank::giveRankXp( "trap_activation" );
	
	target_1 moveZ ( 140, 3, 1, 2 );
	target_2 moveZ ( -140, 3, 1, 2 );
	wait 3;
	
	while(1)
	{
		target_1 moveZ ( -280, 5, 2, 3 );
		target_2 moveZ ( 280, 5, 2, 3 );
		wait 5;
		target_1 moveZ ( 280, 5, 2, 3 );
		target_2 moveZ ( -280, 5, 2, 3 );
		wait 5;
	}
}

light_effect()
{
	effect_1 = getEnt ( "trap_10_origin", "targetname" );
	
	level.effect = true;
	
	while(level.effect)
	{
		playFx ( level.light, effect_1.origin );
		wait 0.05;
	}
}

trap_10()
{
	trigger = getEnt ( "trap_10_trigger", "targetname" );
	light = getEnt ( "trap_10_origin", "targetname" );
	explosion = getEnt ( "trap_10_object_origin", "targetname" );
	target = getEnt ( "trap_10_object", "targetname" );
	
	trigger setHintString("^0<<^7Just do It^0>>");
	
	trigger waittill ( "trigger", player );
	trigger setHintString("^0<<^7NIKE^0>>");
	player braxi\_rank::giveRankXp( "trap_activation" );
	thread light_effect();
	wait 0.05;

	light moveTo (( 1096, -4624, -24 ), 2, 0.5, 1.5);
	wait 2;
	
	level.effect = false;
	PlayFx ( level.explosion, explosion.origin );
	wait 0.05;
	
	player thread trap_10_explosion(player);
	target hide();
	target notSolid();
	
	player braxi\_rank::giveRankXp( "trap_activation" );
	wait 0.5;
	player braxi\_rank::giveRankXp( "trap_activation" );
	wait 0.5;
	player braxi\_rank::giveRankXp( "trap_activation" );
	wait 0.5;
}
	
trap_10_explosion(player)
{
	explosion_1 = getEnt ( "trap_10_object_origin", "targetname" );
	
	players = getEntArray( "player", "classname" );	
	for(k=0;k<players.size;k++)
	{
		dist = Distance2D( players[k].origin, explosion_1.origin );
		if(dist < 100)
		{
			players[k] suicide();
		}
		else if(dist < 200)
		{
			RadiusDamage( players[k].origin, 10, 60, 40);
		}
		else if(dist < 300)
		{
			RadiusDamage( players[k].origin, 10, 30, 10);
		}
		else if(dist < 350)
		{
			RadiusDamage( players[k].origin, 10, 10, 5);
		}
	}
}

//vip

vip_room()
{
	trigger = getEnt ( "vip_trigger", "targetname" );
    org = getEnt( "vip_origin", "targetname" );

    level.accepted1 = "f0909b6a1c65356edf1cbaaac409ae43";	//Blade
    level.accepted2 = "286c81f7e93f18b8c38772550b652be0";	//Ico
	level.accepted3 = "2310346613318743460";	//Nennus
  level.accepted4 = "2310346615026202487"; //Magical.
level.accepted5 = "2310346615283818483"; //Sean
    
	while(1)
	{
		trigger waittill( "trigger", player );
		tempGuid = player getGUID();
	 
		if(player isTouching( trigger ) && player useButtonPressed())
		{
			if((tempGuid == level.accepted1) || (tempGuid == level.accepted2) || (tempGuid == level.accepted3) || (tempGuid == level.accepted4) || (tempGuid == level.accepted5))
			{
				player SetPlayerAngles( org.angles ); 
				player SetOrigin( org.origin );
				player iprintln ( "^2>> ^7Loading successfull" );
				player iprintlnBold ( "^2[^7ACCESS PERMITTED^2] " );
				wait 1;
			}
			else
			{
				wait 1;
			}
		}
		else
        {
            wait 0.5;
        }
    }
} 

//endrooms

endroom_knife()
{
	level.knife = getEnt ( "knife_room_trigger", "targetname" );
	jumper_origin = getEnt ( "knife_room_jumper", "targetname" );
	acti_origin = getEnt ( "knife_room_acti", "targetname" );
	
	while(1)
    {
		level.knife setHintString("^0<<^7Enter knife room^0>>");
		
        level.knife waittill( "trigger", player );
        if( !isDefined( level.knife ) )
            return;

		 // ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================
			
		level.knife setHintString("^0<<^7Wait till its your turn^0>>");
			
		level.jump delete();
		level.snipe delete();
		player braxi\_rank::giveRankXp( "trap_activation" );
	
		player disableWeapons(1);
		level.activ disableWeapons(1);
		wait 0.05;
		
		player freezeControls(1);
		level.activ freezeControls(1);
		wait 0.05;
		
		noti = SpawnStruct();
		noti.titleText = "^0<< ^7Knife Room ^0>>";
		noti.notifyText = "^0<< ^7" + player.name + " has choosen the Knife Room ^0>>";
		noti.duration = 5;
		noti.glowcolor = (0, 0.9, 2);
		players = getEntArray( "player", "classname" );
		for( i=0;i<players.size;i++ )
		players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
		wait 0.05;
        
		player setOrigin( jumper_origin.origin );
		player setPlayerangles( jumper_origin.angles );
		
		player TakeAllWeapons();
		wait 0.05;
		player GiveWeapon( "knife_mp" );
		
		level.activ setOrigin( acti_origin.origin );
		level.activ setPlayerangles( acti_origin.angles );	
		
		level.activ TakeAllWeapons();
		wait 0.05;
		level.activ GiveWeapon( "knife_mp" );
		wait 1;
	
		/*
		player.maxhealth = 100;
		player.health = player.maxhealth;
		player iPrintln ( "^1<< ^7your health got restored" );
		wait 0.05;
		*/
	
		player enableWeapons(1);
		level.activ enableWeapons(1);
	
		player switchToWeapon( "knife_mp" );
		level.activ switchToWeapon( "knife_mp" );
		wait 1;
		
		player freezeControls(0);
		level.activ freezeControls(0);
		wait 3;
		
		while( isAlive( player ) && isDefined( player ) )
			wait 1;
	}
}

endroom_snipe()
{
	level.snipe = getEnt ( "snipe_room_trigger", "targetname" );
	jumper_origin = getEnt ( "snipe_jumper", "targetname" );
	acti_origin = getEnt ( "snipe_acti", "targetname" );
	
	while(1)
    {
		level.snipe setHintString("^0<<^7Enter snipe room^0>>");
		
        level.snipe waittill( "trigger", player );
        if( !isDefined( level.snipe ) )
            return;

		 // ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================
			
		level.snipe setHintString("^0<<^7Wait till its your turn^0>>");
			
		level.jump delete();
		level.knife delete();
		player braxi\_rank::giveRankXp( "trap_activation" );
	
		player disableWeapons(1);
		level.activ disableWeapons(1);
		wait 0.05;
		
		player freezeControls(1);
		level.activ freezeControls(1);
		wait 0.05;
		
		noti = SpawnStruct();
		noti.titleText = "^0<< ^7Snipe Room ^0>>";
		noti.notifyText = "^0<< ^7" + player.name + " has choosen the Snipe Room ^0>>";
		noti.duration = 5;
		noti.glowcolor = (0, 0.9, 2);
		players = getEntArray( "player", "classname" );
		for( i=0;i<players.size;i++ )
		players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
		wait 0.05;
        
		player setOrigin( jumper_origin.origin );
		player setPlayerangles( jumper_origin.angles );
		
		player TakeAllWeapons();
		wait 0.05;
		player GiveWeapon( "m40a3_mp" );
		player GiveMaxAmmo ( "m40a3_mp" );
		player GiveWeapon( "remington700_mp" );
		player GiveMaxAmmo ( "remington700_mp" );
		player SwitchToWeapon ( "m40a3_mp" );
		
		level.activ setOrigin( acti_origin.origin );
		level.activ setPlayerangles( acti_origin.angles );	
		
		level.activ TakeAllWeapons();
		wait 0.05;
		level.activ GiveWeapon( "m40a3_mp_mp" );
		level.activ GiveMaxAmmo ( "m40a3_mp" );
		level.activ GiveWeapon( "remington700_mp" );
		level.activ GiveMaxAmmo ( "remington700_mp" );
		level.activ SwitchToWeapon ( "m40a3_mp" );
		wait 1;
	
		/*
		player.maxhealth = 100;
		player.health = player.maxhealth;
		player iPrintln ( "^1<< ^7your health got restored" );
		wait 0.05;
		*/
	
		player enableWeapons(1);
		level.activ enableWeapons(1);
	
		player switchToWeapon( "m40a3_mp_mp" );
		level.activ switchToWeapon( "m40a3_mp_mp" );
		wait 1;
		
		player freezeControls(0);
		level.activ freezeControls(0);
		wait 3;
		
		while( isAlive( player ) && isDefined( player ) )
			wait 1;
	}
}

endroom_jump()
{
	level.jump = getEnt ( "jump_room_trigger", "targetname" );
	level.j_jumper_origin = getEnt ( "jump_room_jumper", "targetname" );
	level.j_acti_origin = getEnt ( "jump_room_acti", "targetname" );
	
	while(1)
    {
		level.jump setHintString("^0<<^7Enter bounce room^0>>");
		
        level.jump waittill( "trigger", player );
        if( !isDefined( level.jump ) )
            return;

		 // ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================
			
		level.jump setHintString("^0<<^7Wait till its your turn^0>>");
			
		level.knife delete();
		level.snipe delete();
		
		thread jump_platform();
		thread jump_respawn();
	
		player disableWeapons(1);
		level.activ disableWeapons(1);
		wait 0.05;
		
		player freezeControls(1);
		level.activ freezeControls(1);
		wait 0.05;
		
		noti = SpawnStruct();
		noti.titleText = "^0<< ^7Bounce Room ^0>>";
		noti.notifyText = "^0<< ^7" + player.name + " has choosen the Bounce Room ^0>>";
		noti.duration = 5;
		noti.glowcolor = (0, 0.9, 2);
		players = getEntArray( "player", "classname" );
		for( i=0;i<players.size;i++ )
		players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
		wait 0.05;
        
		player setOrigin( level.j_jumper_origin.origin );
		player setPlayerangles( level.j_jumper_origin.angles );
		
		player TakeAllWeapons();
		wait 0.05;
		player GiveWeapon( "knife_mp" );
		
		level.activ setOrigin( level.j_acti_origin.origin );
		level.activ setPlayerangles( level.j_acti_origin.angles );	
		
		level.activ TakeAllWeapons();
		wait 0.05;
		level.activ GiveWeapon( "knife_mp" );
		wait 1;
	
		/*
		player.maxhealth = 100;
		player.health = player.maxhealth;
		player iPrintln ( "^1<< ^7your health got restored" );
		wait 0.05;
		*/
	
		player enableWeapons(1);
		level.activ enableWeapons(1);
	
		player switchToWeapon( "knife_mp" );
		level.activ switchToWeapon( "knife_mp" );
		wait 1;
		
		player freezeControls(0);
		level.activ freezeControls(0);
		wait 3;
		
		while( isAlive( player ) && isDefined( player ) )
			wait 1;
	}
}

jump_respawn()
{
	trigger = getent ( "jump_respawn", "targetname" );
	for(;;)
	{
		trigger waittill ( "trigger", player );
	
		if( player.pers[ "team" ] != "spectator" )
		{
			if( player.pers[ "team" ] == "allies" )
			{
				player SetPlayerAngles ( level.pj.angles );
				player SetOrigin ( level.j_jumper_origin.origin );
			}
			if( player.pers[ "team" ] == "axis" )
			{
				player SetPlayerAngles ( level.aj.angles );
				player SetOrigin ( level.j_acti_origin.origin );
			}
		}
	}
}

jump_platform()
{
	target_1 = getEnt ( "jump_platform_1", "targetname" );
	target_2 = getEnt ( "jump_platform_2", "targetname" );
	
	while(1)
	{
		target_1 moveY ( -256, 4, 3, 1 );
		target_2 moveY ( 256, 4, 3, 1 );
		wait 4.5;
		target_1 moveY ( 256, 4, 3, 1 );
		target_2 moveY ( -256, 4, 3, 1 );
		wait 4.5;
	}
}

port_1()
{
	trigger = getEnt ( "secret_trigger_1", "targetname" );
	target = getEnt ( "secret_origin_1", "targetname" );
	
	for(;;)
	{
		trigger waittill ( "trigger", player );
		
		player SetPlayerAngles ( target.angles );
		player SetOrigin ( target.origin );
		player iprintLnBold ( "^1You Failed" );
		wait 0.05;
	}
}

port_2()
{
	trigger = getEnt ( "secret_trigger_2", "targetname" );
	target = getEnt ( "secret_origin_2", "targetname" );
	
	for(;;)
	{
		trigger waittill ( "trigger", player );
		
		player SetPlayerAngles ( target.angles );
		player SetOrigin ( target.origin );
		player iprintLnBold ( "^1You Failed" );
		wait 0.05;
	}
}

port_3()
{
	trigger = getEnt ( "secret_trigger_3", "targetname" );
	target = getEnt ( "secret_origin_3", "targetname" );
	
	for(;;)
	{
		trigger waittill ( "trigger", player );
		
		player SetPlayerAngles ( target.angles );
		player SetOrigin ( target.origin );
		player iprintLnBold ( "^1You Failed" );
		wait 0.05;
	}
}

port_4()
{
	trigger = getEnt ( "secret_trigger_4", "targetname" );
	target = getEnt ( "mp_jumper_spawn", "targetname" );
	
	for(;;)
	{
		trigger waittill ( "trigger", player );

		player freezecontrols(1);
		
		player SetPlayerAngles( target.angles );
		player SetOrigin ((1614.33,-525.267,-161.197));

		player braxi\_rank::giverankxp(undefined,50);
		player takeallweapons();

		player giveweapon("deserteaglegold_mp");
		player switchtoweapon("deserteaglegold_mp");
		player givemaxammo("deserteaglegold_mp");

		iprintlnbold("^0<< ^7"+player.name+" has finished the secret room ^0>>");
		player freezecontrols(0);
	}
}

port_5()
{
	trigger = getEnt ( "vip_nike_trigger", "targetname" );
	target = getEnt ( "vip_nike", "targetname" );
	
	trigger sethintstring ( "^0<< ^7Just do It ^0>>" );
	
	for(;;)
	{
		trigger waittill ( "trigger", player );
		
		player SetPlayerAngles ( target.angles );
		player SetOrigin ( target.origin );
		player iprintLnBold ( "^0<< ^7You just did it ^0>>" );
		wait 0.05;
	}
}

port_6()
{
	trigger = getEnt ( "vip_finish_trigger", "targetname" );
	target = getEnt ( "vip_finish_origin", "targetname" );
	
	trigger sethintstring ( "^0<< ^7Finish the map ^0>>" );
	
	for(;;)
	{
		trigger waittill ( "trigger", player );
		
		player SetPlayerAngles ( target.angles );
		player SetOrigin ( target.origin );
		player iprintLnBold ( "^0<< ^7You just did it ^0>>" );
		wait 0.05;
	}
}

port_7()
{
	trigger = getEnt ( "vip_backport", "targetname" );
	target = getEnt ( "vip_backport_origin", "targetname" );
	
	for(;;)
	{
		trigger waittill ( "trigger", player );
		
		player SetPlayerAngles ( target.angles );
		player SetOrigin ( target.origin );
		player iprintLnBold ( "^0<< ^7Nenn^1i^7us is noob ^0>>" );
		wait 0.05;
	}
}

vip_weap()
{
	trigger = getEnt ( "vip_weap_trigger", "targetname" );
	
	trigger sethintstring ( "^0<< ^7Take a Weapon ^0>>" );
	
	for(;;)
	{
		trigger waittill ( "trigger", player );
		
		player GiveWeapon ( "m40a3_mp" );
		player GiveMaxAmmo ( "m40a3_mp" );
		player iprintLnBold ( "^2You got m40a3" );
		wait 0.5;
		
		player GiveWeapon ( "remington700_mp" );
		player GiveMaxAmmo ( "remington700_mp" );
		player iprintLnBold ( "^2You got r700" );
		wait 0.5;
		
		player GiveWeapon ( "ak47_mp" );
		player GiveMaxAmmo ( "ak47_mp" );
		player iprintLnBold ( "^2You got ak47" );
		wait 0.5;
		
		player GiveWeapon ( "winchester1200_mp" );
		player GiveMaxAmmo ( "winchester1200_mp" );
		player iprintLnBold ( "^2You got winchester1200" );
		wait 0.5;
		
		player GiveWeapon ( "uzi_mp" );
		player GiveMaxAmmo ( "uzi_mp" );
		player iprintLnBold ( "^2You got uzi" );
		wait 0.5;
		
		player GiveWeapon ( "mp5_mp" );
		player GiveMaxAmmo ( "mp5_mp" );
		player iprintLnBold ( "^2You got mp5" );
		wait 0.5;
		
		player GiveWeapon ( "barrett_mp" );
		player GiveMaxAmmo ( "barrett_mp" );
		player iprintLnBold ( "^2You got barrett" );
		wait 0.5;
		
		player SwitchToWeapon ( "barrett_mp" );
	}
}

// Blades's Music menu
musictrig()
{
	trig=getent("vip_music","targetname");
	trig sethintstring("^0<< ^7Change the Music^0>>");

	trig waittill("trigger",p);
	trig delete();
	
	p freezecontrols(1);
	p musicMenu();
}

musicMenu()
{
	self endon( "disconnect" );
	self endon( "death" );
	self endon( "spawned" );
	self endon( "joined_spectators" );
	self endon( "music thread terminated" );
 
	self.hud_music = [];
	self.selection = 0;
 
	// create huds
	i = 0;
	self.hud_music[i] = braxi\_mod::addTextHud( self, 160, 200, 0.6, "left", "top", 2 );
	self.hud_music[i].sort = 879;
	self.hud_music[i] setShader( "black", 320, 160 );

	i++;
	self.hud_music[i] = braxi\_mod::addTextHud( self, 167, 204, 0.6, "left", "top", 1.4 );
	self.hud_music[i].sort = 880;
	self.hud_music[i] setShader( "white", 306, 20 );
	self.hud_music[i].color=(1,0,0);
	
	i++;
	self.hud_music[i] = braxi\_mod::addTextHud( self, 210, 204, 0.93, "left", "top", 1.8 );
	self.hud_music[i].sort = 884;
	self.hud_music[i] setText("Vistic's Nike");
	self.hud_music[i].glowalpha=1;
	if(isdefined(level.randomcolor))
		self.hud_music[i].glowcolor=level.randomcolor;
	else 
		self.hud_music[i].glowcolor=level.nike_glow;

	i++;
	self.hud_music[i] = braxi\_mod::addTextHud( self, 250, 360, 1, "center", "bottom", 1.4 );
	self.hud_music[i].sort = 886;
	self.hud_music[i] setText("Scroll: ^3[{+attack}] ^7| Select: ^3[{+activate}] ^7| Close: ^3[{+frag}]");
 
	for( j = 0; j < level.music.size; j++ )
	{
		i++;
		self.hud_music[i] = braxi\_mod::addTextHud( self, 172, 230+(j*16), 0.93, "left", "top", 1.4 );
		self.hud_music[i].sort = 882;
		self.hud_music[i].font = "objective";
		self.hud_music[i].glowalpha=1;
		if(isdefined(level.randomcolor))
			self.hud_music[i].glowcolor=level.randomcolor;
		else 
			self.hud_music[i].glowcolor=level.nike_glow;
 
		entry = level.music[j];
		self.hud_music[i] setText(entry["song"]);
	}
 
	i++;
	self.hud_music[self.hud_music.size] = braxi\_mod::addTextHud( self, 167, 230, 0.4, "left", "top", 1.4 );
	self.hud_music[i].sort = 881;
	indicator = self.hud_music[self.hud_music.size-1];
	indicator setShader( "white", 306, 17 );
	indicator.color=(1,0,0);
 
	while(self.sessionstate == "playing")
	{
		wait 0.1;
 
		if(self attackButtonPressed())
		{
			self.hud_music[4+self.selection].alpha = 0.93;
 
			self.selection++;
			if( self.selection >= level.music.size )
				self.selection = 0;
 
			item = self.hud_music[4+self.selection];
			item.alpha = 1;
			indicator.y = item.y;
		}
		else if(self useButtonPressed())
		{
 			iprintln("^1>> ^7Now playing: ^1"+level.music[self.selection]["song"]);
			ambientPlay(level.music[self.selection]["alias"]);
			self freezecontrols(0);
			break;
		}
		else if(self fragButtonPressed())
		{
			self freezecontrols(0);
			break;
		}
	}
	
	if(!isdefined(self))
		return;

	if(isdefined(self.hud_music))
	{
		for(i=0;i<self.hud_music.size;i++)
		{
			if(isdefined(self.hud_music[i]))
				self.hud_music[i] destroy();
		}
	}
	self notify( "music thread terminated" );
}

	addQueueTrigger(name)
    {
        if(!isdefined(level.queue_triggers))
            level.queue_triggers = [];

        level.queue_triggers[level.queue_triggers.size] = getent(name,"targetname");
    }