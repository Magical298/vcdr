/* 
|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||                 
||| |||| ||| |||   |||       || |||   |||||||||||   ||| |||||||  |||| ||||| |||
||| |||| ||| || ||| ||||| ||||| || ||| ||||||||| ||| || |||||| || |||   ||| |||
||| |||| ||| || ||||||||| ||||| || ||||||||||||| |||||| ||||| |||| || || || |||
||| |||| ||| |||   |||||| ||||| || ||||||    ||| |||||| ||||| |||| || || || |||
||| |||| ||| |||||| ||||| ||||| || ||||||||||||| |||||| |||||      || ||  | |||
|||| || |||| |||||| ||||| ||||| || ||| ||||||||| ||| || ||||| |||| || ||| | |||
|||||  ||||| ||    |||||| ||||| |||   |||||||||||   |||    || |||| || ||||  |||
|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

------------- Map       :	Crpyt
------------- Mapper  	:	VC' Icomar
------------- Server  	:	VC' Deathrun: 62.75.222.118:28960
------------- xFire   	: 	icomar272
------------- Homepage	:  	vistic-clan.tk
------------- Help		:  	VC' Blade
*/
main()
{
	maps\mp\_load::main();
	
	ambientPlay( "crypt_music" );
	
	game["allies"] = "marines";
    game["axis"] = "opfor";
    game["attackers"] = "axis";
    game["defenders"] = "allies";
    game["allies_soldiertype"] = "desert";
    game["axis_soldiertype"] = "desert";
	
	//effects
	level.water_splash = LoadFX ( "mp_deathrun_online/water_splash_waterworld" );
	level.suicide[ "wtf" ] = LoadFX ( "mp_deathrun_online/stone_explosion" );
	level.cliff = LoadFX ( "mp_deathrun_online/big_explosion" );
	level.explosion = LoadFX ( "mp_deathrun_online/trap_7_explosion" );
	level.laser_death = LoadFX ( "mp_deathrun_online/laser_death" );
	level.laser_spawn = LoadFX ( "mp_deathrun_online/laser_start" );
	level.light = LoadFX ( "mp_deathrun_online/light_up" );
	level.light_green = LoadFX ( "mp_deathrun_online/light_up_green" );
	level.light_explosion = LoadFX ( "mp_deathrun_online/light_explosion" );
	level.expbullt = loadfx( "mp_deathrun_online/shotgun_explosion" );
	level.dust = LoadFX ( "mp_deathrun_online/vc_dust" );
	level.fire = LoadFX ( "mp_deathrun_online/fire" );
	
	//dvars
	setdvar( "r_specularcolorscale", "1" );
    setdvar( "r_glowbloomintensity0", ".25" );
    setdvar( "r_glowbloomintensity1", ".25" );
    setdvar( "r_glowskybleedintensity0", ".3" );
    setdvar( "compassmaxrange", "1800" );
	
	//Precaches
	precacheItem ( "winchester1200_mp" );
	precacheItem ( "uzi_mp" );
	precacheItem ( "mp5_mp" );
	
	//traps
	thread trap_order();
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
	
	//bouncer
	thread trap_2_bouncer_1();
	thread trap_2_bouncer_2();
	thread trap_2_bouncer_3();
	thread trap_2_bouncer_4();
	
	//others
	thread water();
	thread sniper_water();
	thread knife_water();
	thread laser();
	thread dust();
	thread fire();
	thread clip_effect();
	thread secret_trigger();
	thread secret();
	thread secret_fail_1();
	thread secret_fail_2();
	
	//rooms
	thread endrooms();
	thread jump_bouncer_1();
	thread jump_bouncer_2();
	thread super_bounce_1();
	thread super_bounce_2();
	thread endroom_snipe();
	thread endroom_knife();
	thread endroom_jump();
	
	//test
	thread addTestClients();
}

dust()
{
	target_1 = getEnt ( "dust_1" ,"targetname" );
	target_2 = getEnt ( "dust_2" ,"targetname" );
	target_3 = getEnt ( "dust_3" ,"targetname" );
	target_4 = getEnt ( "dust_4" ,"targetname" );
	target_5 = getEnt ( "dust_5" ,"targetname" );
	target_6 = getEnt ( "dust_6" ,"targetname" );
	target_7 = getEnt ( "dust_7" ,"targetname" );
	target_8 = getEnt ( "dust_8" ,"targetname" );
	target_9 = getEnt ( "dust_9" ,"targetname" );
	target_10 = getEnt ( "dust_10" ,"targetname" );
	
	playLoopedFx ( level.dust, 1, target_1.origin );
	playLoopedFx ( level.dust, 1, target_2.origin );
	playLoopedFx ( level.dust, 1, target_3.origin );
	playLoopedFx ( level.dust, 1, target_4.origin );
	playLoopedFx ( level.dust, 1, target_5.origin );
	playLoopedFx ( level.dust, 1, target_6.origin );
	playLoopedFx ( level.dust, 1, target_7.origin );
	playLoopedFx ( level.dust, 1, target_8.origin );
	playLoopedFx ( level.dust, 1, target_9.origin );
	playLoopedFx ( level.dust, 1, target_10.origin );
}

dust_sniper()
{
	target_1 = getEnt ( "dust_11" ,"targetname" );
	target_2 = getEnt ( "dust_12" ,"targetname" );
	target_3 = getEnt ( "dust_13" ,"targetname" );
	target_4 = getEnt ( "dust_14" ,"targetname" );
	target_5 = getEnt ( "dust_15" ,"targetname" );
	target_6 = getEnt ( "dust_16" ,"targetname" );
	target_7 = getEnt ( "dust_17" ,"targetname" );
	target_8 = getEnt ( "dust_18" ,"targetname" );
	target_9 = getEnt ( "dust_19" ,"targetname" );
	target_10 = getEnt ( "dust_20" ,"targetname" );
	
	playLoopedFx ( level.dust, 1, target_1.origin );
	playLoopedFx ( level.dust, 1, target_2.origin );
	playLoopedFx ( level.dust, 1, target_3.origin );
	playLoopedFx ( level.dust, 1, target_4.origin );
	playLoopedFx ( level.dust, 1, target_5.origin );
	playLoopedFx ( level.dust, 1, target_6.origin );
	playLoopedFx ( level.dust, 1, target_7.origin );
	playLoopedFx ( level.dust, 1, target_8.origin );
	playLoopedFx ( level.dust, 1, target_9.origin );
	playLoopedFx ( level.dust, 1, target_10.origin );
}

dust_knife()
{
	target_1 = getEnt ( "dust_21" ,"targetname" );
	target_2 = getEnt ( "dust_22" ,"targetname" );
	target_3 = getEnt ( "dust_23" ,"targetname" );
	target_4 = getEnt ( "dust_24" ,"targetname" );
	target_5 = getEnt ( "dust_25" ,"targetname" );
	target_6 = getEnt ( "dust_26" ,"targetname" );
	target_7 = getEnt ( "dust_27" ,"targetname" );
	target_8 = getEnt ( "dust_28" ,"targetname" );
	target_9 = getEnt ( "dust_29" ,"targetname" );
	target_10 = getEnt ( "dust_30" ,"targetname" );
	target_11 = getEnt ( "dust_31" ,"targetname" );
	target_12 = getEnt ( "dust_32" ,"targetname" );
	target_13 = getEnt ( "dust_33" ,"targetname" );
	target_14 = getEnt ( "dust_34" ,"targetname" );
	target_15 = getEnt ( "dust_35" ,"targetname" );
	
	playLoopedFx ( level.dust, 1, target_1.origin );
	playLoopedFx ( level.dust, 1, target_2.origin );
	playLoopedFx ( level.dust, 1, target_3.origin );
	playLoopedFx ( level.dust, 1, target_4.origin );
	playLoopedFx ( level.dust, 1, target_5.origin );
	playLoopedFx ( level.dust, 1, target_6.origin );
	playLoopedFx ( level.dust, 1, target_7.origin );
	playLoopedFx ( level.dust, 1, target_8.origin );
	playLoopedFx ( level.dust, 1, target_9.origin );
	playLoopedFx ( level.dust, 1, target_10.origin );
	playLoopedFx ( level.dust, 1, target_11.origin );
	playLoopedFx ( level.dust, 1, target_12.origin );
	playLoopedFx ( level.dust, 1, target_13.origin );
	playLoopedFx ( level.dust, 1, target_14.origin );
	playLoopedFx ( level.dust, 1, target_15.origin );
}

dust_jump()
{
	target_1 = getEnt ( "dust_54" ,"targetname" );
	target_2 = getEnt ( "dust_55" ,"targetname" );
	target_3 = getEnt ( "dust_56" ,"targetname" );
	target_4 = getEnt ( "dust_46" ,"targetname" );
	target_5 = getEnt ( "dust_47" ,"targetname" );
	target_6 = getEnt ( "dust_36" ,"targetname" );
	target_7 = getEnt ( "dust_37" ,"targetname" );
	target_8 = getEnt ( "dust_38" ,"targetname" );
	target_9 = getEnt ( "dust_39" ,"targetname" );
	target_10 = getEnt ( "dust_40" ,"targetname" );
	target_11 = getEnt ( "dust_41" ,"targetname" );
	target_12 = getEnt ( "dust_42" ,"targetname" );
	target_13 = getEnt ( "dust_43" ,"targetname" );
	target_14 = getEnt ( "dust_44" ,"targetname" );
	target_15 = getEnt ( "dust_45" ,"targetname" );
	target_16 = getEnt ( "dust_46" ,"targetname" );
	target_17 = getEnt ( "dust_47" ,"targetname" );
	target_18 = getEnt ( "dust_48" ,"targetname" );
	target_19 = getEnt ( "dust_49" ,"targetname" );
	target_20 = getEnt ( "dust_50" ,"targetname" );
	target_21 = getEnt ( "dust_51" ,"targetname" );
	
	playLoopedFx ( level.dust, 1, target_1.origin );
	playLoopedFx ( level.dust, 1, target_2.origin );
	playLoopedFx ( level.dust, 1, target_3.origin );
	playLoopedFx ( level.dust, 1, target_4.origin );
	playLoopedFx ( level.dust, 1, target_5.origin );
	playLoopedFx ( level.dust, 1, target_6.origin );
	playLoopedFx ( level.dust, 1, target_7.origin );
	playLoopedFx ( level.dust, 1, target_8.origin );
	playLoopedFx ( level.dust, 1, target_9.origin );
	playLoopedFx ( level.dust, 1, target_10.origin );
	playLoopedFx ( level.dust, 1, target_11.origin );
	playLoopedFx ( level.dust, 1, target_12.origin );
	playLoopedFx ( level.dust, 1, target_13.origin );
	playLoopedFx ( level.dust, 1, target_14.origin );
	playLoopedFx ( level.dust, 1, target_15.origin );
	playLoopedFx ( level.dust, 1, target_16.origin );
	playLoopedFx ( level.dust, 1, target_17.origin );
	playLoopedFx ( level.dust, 1, target_18.origin );
	playLoopedFx ( level.dust, 1, target_19.origin );
	playLoopedFx ( level.dust, 1, target_20.origin );
	playLoopedFx ( level.dust, 1, target_21.origin );
}

clip_effect()
{
	clip = getEnt ( "clip", "targetname" );
	effect_1 = getEnt ( "clip_effect_1", "targetname" );
	effect_2 = getEnt ( "clip_effect_2", "targetname" );
	
	effect_1 LinkTo ( clip );
	effect_2 LinkTo ( clip );
	
	thread clip_fx();
	
	while(1)
	{
		clip rotateYaw ( 360, 3 );
		wait 3;
	}
}

clip_fx()
{
	effect_1 = getEnt ( "clip_effect_1", "targetname" );
	effect_2 = getEnt ( "clip_effect_2", "targetname" );

	while(1)
	{
		playFx ( level.light_green, effect_1.origin );
		playFx ( level.light_green, effect_2.origin );
		wait 0.05;
	}
}

fire()
{
	target_1 = getEnt ( "fire_1" ,"targetname" );
	target_2 = getEnt ( "fire_2" ,"targetname" );
	target_3 = getEnt ( "fire_3" ,"targetname" );
	
	playLoopedFx ( level.fire, 0.5, target_1.origin );
	playLoopedFx ( level.fire, 0.5, target_2.origin );
	playLoopedFx ( level.fire, 0.5, target_3.origin );
}

water()
{
	trigger = getEnt ( "water_trigger", "targetname" );
	
	while(1)
	{
		trigger waittill ( "trigger", player );
		
		player thread water_death();
	}
}

sniper_water()
{
	trigger = getEnt ( "sniper_water", "targetname" );
	
	while(1)
	{
		trigger waittill ( "trigger", player );
		
		player thread water_death();
	}
}

knife_water()
{
	trigger = getEnt ( "knife_water", "targetname" );
	
	while(1)
	{
		trigger waittill ( "trigger", player );
		
		player thread water_death();
	}
}

water_death()
{
	playFX ( level.water_splash, self.origin );
	ambientPlay( "water_splash_small" );
	wait 0.05;
	self suicide();
}

laser()
{
	trigger = getEnt ( "trap_9_hurt", "targetname" );
	
	while(1)
	{
		trigger waittill ( "trigger", player );
		
		player thread laser_death();
	}
}

laser_death()
{
	playFX ( level.laser_death, self.origin );
	wait 0.05;
	self suicide();
}

trap_order()
{
    level.order = true;
       
    while(1)
    {
		wait 0.05;
        if( !level.order )
        {
            wait 18;
			iprintlnBold ( "^2<< ^7The ^1Activator ^7can activate a trap now ^2>>" );
            level.order = true;
		}
	}
}

trap_1()
{
	trigger = getEnt ( "trap_1_trigger", "targetname" );
	blades = getEnt ( "trap_1_blades", "targetname" );
	target = getEnt ( "trap_1_target", "targetname" );
	blades_hurt = getEnt ( "trap_1_hurt", "targetname" );
	target_hurt = getEnt ( "trap_1_hurt_2", "targetname" );
	
	blades_hurt enableLinkTo();
	blades_hurt LinkTo( blades );
	target_hurt enableLinkTo();
	target_hurt LinkTo( target );
	
	wait 6;
	
	for(;;)
	{
		blades hide();
		target hide();
		
		iprintln ( "^1<< ^7The spinners are ready to activate" );
		wait 1;
		
		trigger setHintString( "^2[^7activate the spinners^2]" );
		trigger waittill ( "trigger", player );
		if( !level.order )
            continue;
			
        level.order = false;
		wait 0.05;
		
		blades show();
		target show();
		
		iprintlnBold ( "^1<< ^7The ^2spinners ^7got activated ^1>>" );
		trigger setHintString( "^1[^7loading^1]" );
		wait 0.05;
		
		blades moveZ ( 320, 2 );
		target moveZ ( 320, 2 );
		wait 3;
		
		blades notSolid();
		wait 0.05;
		
		blades rotateYaw ( 1800, 12 );
		target rotateYaw ( 1800, 12 );
		wait 10;
		
		blades moveZ ( -320, 3 );
		target moveZ ( -320, 3 );
		wait 3;
		
		blades Solid();
		wait 30;
	}
}

trap_2_bouncer_1()
{
	bounce_trig_1 = getEnt ( "trap_2_bounce_1_a", "targetname" );
	
	for(;;)
	{
		bounce_trig_1 waittill ( "trigger", who );
		
		oldpos = who.origin;
		strenght = 4;
		for(i=0;i<strenght;i++)
		{
			who.health += 200;
			who finishPlayerDamage(who, level.jumpattacker, 200, 0, "MOD_FALLING", "jump_mp", who.origin, AnglesToForward((-90,0,0)), "none", 0);
		}
	}
}

trap_2_bouncer_2()
{
	bounce_trig_2 = getEnt ( "trap_2_bounce_1_b", "targetname" );
	
	for(;;)
	{
		bounce_trig_2 waittill ( "trigger", who );
		
		oldpos = who.origin;
		strenght = 4;
		for(i=0;i<strenght;i++)
		{
			who.health += 200;
			who finishPlayerDamage(who, level.jumpattacker, 200, 0, "MOD_FALLING", "jump_mp", who.origin, AnglesToForward((-90,0,0)), "none", 0);
		}
	}
}

trap_2_bouncer_3()
{
	bounce_trig_3 = getEnt ( "trap_2_bounce_1_c", "targetname" );
	
	for(;;)
	{
		bounce_trig_3 waittill ( "trigger", who );
		
		oldpos = who.origin;
		strenght = 4;
		for(i=0;i<strenght;i++)
		{
			who.health += 200;
			who finishPlayerDamage(who, level.jumpattacker, 200, 0, "MOD_FALLING", "jump_mp", who.origin, AnglesToForward((-90,0,0)), "none", 0);
		}
	}
}

trap_2_bouncer_4()
{
	bounce_trig_4 = getEnt ( "trap_2_bounce_1_d", "targetname" );
	
	for(;;)
	{
		bounce_trig_4 waittill ( "trigger", who );
		
		oldpos = who.origin;
		strenght = 4;
		for(i=0;i<strenght;i++)
		{
			who.health += 200;
			who finishPlayerDamage(who, level.jumpattacker, 200, 0, "MOD_FALLING", "jump_mp", who.origin, AnglesToForward((-90,0,0)), "none", 0);
		}
	}
}

trap_2()
{
	trigger = getEnt ( "trap_2_trigger", "targetname" );
	bouncer_1 = getEnt ( "trap_2_bounce_2_a", "targetname" );
	bouncer_2 = getEnt ( "trap_2_bounce_2_b", "targetname" );
	bouncer_3 = getEnt ( "trap_2_bounce_2_c", "targetname" );
	bouncer_4 = getEnt ( "trap_2_bounce_2_d", "targetname" );
	bounce_trig_1 = getEnt ( "trap_2_bounce_1_a", "targetname" );
	bounce_trig_2 = getEnt ( "trap_2_bounce_1_b", "targetname" );
	bounce_trig_3 = getEnt ( "trap_2_bounce_1_c", "targetname" );
	bounce_trig_4 = getEnt ( "trap_2_bounce_1_d", "targetname" );
	
	bounce_trig_1 enableLinkTo();
	bounce_trig_1 LinkTo( bouncer_1 );
	bounce_trig_2 enableLinkTo();
	bounce_trig_2 LinkTo( bouncer_2 );
	bounce_trig_3 enableLinkTo();
	bounce_trig_3 LinkTo( bouncer_3 );
	bounce_trig_4 enableLinkTo();
	bounce_trig_4 LinkTo( bouncer_4 );
	
	bouncer_1 notSolid();
	bouncer_2 notSolid();
	bouncer_3 notSolid();
	bouncer_4 notSolid();
	
	wait 80;
	
	for(;;)
	{
		bouncer_1 hide();
		bouncer_2 hide();
		bouncer_3 hide();
		bouncer_4 hide();
		
		iprintln ( "^1<< ^7The bouncers are ready to activate" );
		wait 1;
		
		trigger setHintString( "^2[^7activate the bouncers^2]" );
		trigger waittill ( "trigger", player );
		if( !level.order )
            continue;
               
        level.order = false;
		wait 0.05;
		
		iprintlnBold ( "^1<< ^7The ^2bouncers ^7got activated ^1>>" );
		trigger setHintString( "^1[^7loading^1]" );
		wait 3;
		
		i = randomintrange( 0, 4 );
		if(i == 0)
		{
			bouncer_1 show();
			bouncer_3 show();
			wait 0.05;
				
			bouncer_1 moveZ ( 488, 0.5 );
			bouncer_3 moveZ ( 488, 0.5 );
			wait 0.6;
				
			bouncer_1 moveZ ( -488, 5 );
			bouncer_3 moveZ ( -488, 5 );
			wait 5;
				
			bouncer_1 hide();
			bouncer_3 hide();
			wait 0.05;
		}
		else if(i == 1)
		{
			bouncer_2 show();
			bouncer_4 show();
			wait 0.05;
				
			bouncer_2 moveZ ( 488, 0.5 );
			bouncer_4 moveZ ( 488, 0.5 );
			wait 0.6;
				
			bouncer_2 moveZ ( -488, 5 );
			bouncer_4 moveZ ( -488, 5 );
			wait 5;
				
			bouncer_2 hide();
			bouncer_4 hide();
			wait 0.05;
		}
		else if(i == 2)
		{
			bouncer_1 show();
			bouncer_2 show();
			wait 0.05;
				
			bouncer_1 moveZ ( 488, 0.5 );
			bouncer_2 moveZ ( 488, 0.5 );
			wait 0.6;
				
			bouncer_1 moveZ ( -488, 5 );
			bouncer_2 moveZ ( -488, 5 );
			wait 5;
				
			bouncer_1 hide();
			bouncer_2 hide();
			wait 0.05;
		}
		else if(i == 3)
		{
			bouncer_3 show();
			bouncer_4 show();
			wait 0.05;
				
			bouncer_3 moveZ ( 488, 0.5 );
			bouncer_4 moveZ ( 488, 0.5 );
			wait 0.6;
				
			bouncer_3 moveZ ( -488, 5 );
			bouncer_4 moveZ ( -488, 5 );
			wait 5;
				
			bouncer_3 hide();
			bouncer_4 hide();
			wait 0.05;
		}
		wait 40;
	}
}

trap_3()
{
	trigger = getEnt ( "trap_3_trigger", "targetname" );
	target_1 = getEnt ( "trap_3_target", "targetname" );
	target_2 = getEnt ( "trap_3_target_2", "targetname" );
	
	wait 40;
	
	for(;;)
	{
		target_1 hide();
		target_2 hide();
	
		iprintln ( "^1<< ^7The pushers are ready to activate" );
		wait 1;
	
		trigger setHintString( "^2[^7activate the pushers^2]" );
		trigger waittill ( "trigger", player );
		if( !level.order )
            continue;
               
        level.order = false;
		wait 0.05;
		
		trigger setHintString( "^1[^7loading^1]" );
		wait 0.05;
		
		i = randomintrange( 0, 2 );
		if(i == 0)
		{
			iprintlnBold ( "^1<< ^7The ^2pushers ^7got activated ^1>>" );
			wait 0.05;
				
			target_1 show();
			target_2 show();
			wait 0.05;
			
			target_1 moveZ ( 512, 1, 0.5, 0.2 );
			wait 1;
				
			target_1 moveX ( -1600, 4, 1, 2 );
			wait 4;
			
			target_1 moveX ( 1600, 4, 1, 2 );
			wait 4;
				
			target_1 moveZ ( -512, 1, 0.5, 0.2 );
			target_2 moveZ ( 512, 1, 0.5, 0.2 );
			wait 1;
				
			target_2 moveY ( 1500, 3, 1, 2 );
			wait 3;
				
			target_2 moveY ( -1500, 3, 1, 2 );
			wait 3;
				
			target_2 moveZ ( -512, 3, 1, 2 );
			wait 3;
		}
		else if(i == 1)
		{
			iprintlnBold ( "^1<< ^7The ^2pusher ^7got activated ^1>>" );
			wait 0.05;
				
			target_1 show();
			wait 0.05;
				
			target_1 moveZ ( 512, 3, 1, 2 );
			wait 3.5;
				
			target_1 moveX ( -1600, 4, 1, 2 );
			wait 4;
				
			target_1 moveX ( 1600, 4, 1, 2 );
			wait 4;
				
			target_1 moveZ ( -512, 3, 1, 2 );
			wait 3.5;
		}
		wait 30;
	}
}

trap_4()
{
	trigger = getEnt ( "trap_4_trigger", "targetname" );
	target = getEnt ( "suicide_trigger", "targetname" );
	
	wait 100;
	
	for(;;)
	{
		iprintln ( "^1<< ^7The free ^2WTF ^7is ready to activate" );
		wait 1;
	
		trigger setHintString( "^2[^7activate the free WTF^2]" );
		trigger waittill ( "trigger", player );
		if( !level.order )
            continue;
               
        level.order = false;
		iPrintLnBold ( "^1<<^7 " + player.name + " activated the free ^2WTF ^1>>" );
		trigger setHintString( "^1[^7loading^1]" );
		wait 3;
		
		target waittill ( "trigger", player );
		wait 3;
		
		iprintlnbold( "^1<<^7 " + player.name + " won the free ^2WTF ^1>>" );
		wait 1;
		
		//playSound ( "wtf" );
		self playSound( "artillery_impact" );
		wait 1;
		
		playFx ( level.suicide[ "wtf" ], player.origin );
		earthquake ( 1, 1, player.origin, 500 );
		wait 0.05;
		
		players = getEntArray( "player", "classname" );	
		for(k=0;k<players.size;k++)
		{
			dist = Distance2D( players[k].origin, player.origin );
			if(dist < 100)
			{
				players[k] suicide();
			}
			else if(dist < 450)
			{
				RadiusDamage( players[k].origin, 10, 60, 40);
			}
			else if(dist < 650)
			{
				RadiusDamage( players[k].origin, 10, 30, 10);
			}
		}
		wait 0.05;
		//player suicide();
		wait 260;
	}
}

trap_5()
{
	trigger = getEnt ( "trap_5_trigger", "targetname" );
	target_1 = getEnt ( "trap_5_target", "targetname" );
	target_2 = getEnt ( "trap_5_target_2", "targetname" );
	target_3 = getEnt ( "trap_5_target_3", "targetname" );
	hurt_1 = getEnt ( "trap_5_hurt", "targetname" );
	hurt_2 = getEnt ( "trap_5_hurt_2", "targetname" );
	hurt_3 = getEnt ( "trap_5_hurt_3", "targetname" );
	
	hurt_1 enableLinkTo();
	hurt_1 LinkTo( target_1 );
	hurt_2 enableLinkTo();
	hurt_2 LinkTo( target_2 );
	hurt_3 enableLinkTo();
	hurt_3 LinkTo( target_3 );
	
	target_1 hide();
	target_2 hide();
	target_3 hide();
	
	target_1 notSolid();
	target_2 notSolid();
	target_3 notSolid();
	
	wait 5;
	
	for(;;)
	{
		target_1 hide();
		target_2 hide();
		target_3 hide();
		
		iprintln ( "^1<< ^7The side spinner ready to activate" );
		wait 1;
	
		trigger setHintString( "^2[^7activate the side spinner^2]" );
		trigger waittill ( "trigger", player );
		
		target_1 show();
		target_2 show();
		target_3 show();
		
		if( !level.order )
            continue;
               
        level.order = false;
		trigger setHintString( "^1[^7loading^1]" );
		iprintlnBold ( "^1<< ^7The ^2side spinner ^7got activated ^1>>" );
		wait 3;
		
		i = randomintrange( 0, 3 );
		if(i == 0)
		{
			target_1 moveZ ( 880, 3, 1, 2 );
			wait 3;
			
			target_1 rotateYaw ( 180, 2, 0.5, 1.5 );
			wait 2;
			
			target_1 moveZ ( -880, 3, 1, 2 );
			wait 3;
			
			target_1 rotateYaw ( -180, 2, 0.5, 1.5 );
			wait 2;
		}
		else if(i == 1)
		{
			target_2 moveZ ( 880, 3, 1, 2 );
			wait 3;
			
			target_2 rotateYaw ( 180, 2, 0.5, 1.5 );
			wait 2;
			
			target_2 moveZ ( -880, 3, 1, 2 );
			wait 3;
			
			target_2 rotateYaw ( -180, 2, 0.5, 1.5 );
			wait 2;
		}
		else if(i == 2)
		{
			target_3 moveZ ( 880, 3, 1, 2 );
			wait 3;
			
			target_3 rotateYaw ( 180, 2, 0.5, 1.5 );
			wait 2;
			
			target_3 moveZ ( -880, 3, 1, 2 );
			wait 3;
			
			target_3 rotateYaw ( -180, 2, 0.5, 1.5 );
			wait 2;
		}
		wait 30;
	}
}

trap_6()
{
	trigger = getEnt ( "trap_6_trigger", "targetname" );
	rocks = getEnt ( "trap_6_rocks", "targetname" );
	target = getEnt ( "trap_6_target", "targetname" );
	earthquake = getEnt ( "trap_4_effect", "targetname" );
	hurt_1 = getEnt ( "trap_6_hurt_1", "targetname" );
	hurt_2 = getEnt ( "trap_6_hurt_2", "targetname" );
	hurt_3 = getEnt ( "trap_6_hurt_3", "targetname" );
	hurt_4 = getEnt ( "trap_6_hurt_4", "targetname" );
	hurt_5 = getEnt ( "trap_6_hurt_5", "targetname" );
	
	hurt_1 enableLinkTo();
	hurt_1 LinkTo ( rocks );
	hurt_2 enableLinkTo();
	hurt_2 LinkTo ( rocks );
	hurt_3 enableLinkTo();
	hurt_3 LinkTo ( rocks );
	hurt_4 enableLinkTo();
	hurt_4 LinkTo ( rocks );
	hurt_5 enableLinkTo();
	hurt_5 LinkTo ( rocks );
	
	wait 25;
	
	for(;;)
	{
		iprintln ( "^1<< ^7The cliff explosion is ready to activate" );
		wait 1;
	
		trigger setHintString( "^2[^7activate the cliff explosion^2]" );
		trigger waittill ( "trigger", player );
		if( !level.order )
			continue;
               
		level.order = false;
		trigger setHintString( "^1[^7done^1]" );
		iprintlnBold ( "^1<< ^7The ^2cliff explosion ^7got activated ^1>>" );
		wait 3;
	
		playFx ( level.cliff, target.origin );
		self playSound( "artillery_impact" );
		wait 0.5;
		
		earthquake( 2, 3, earthquake.origin, 1000 );
		rocks moveZ ( -1976, 2, 0.5, 1.5 );
		wait 5;
	
		rocks hide();
		wait 9999;
	}
}

trap_7()
{
	trigger = getEnt ( "trap_7_trigger", "targetname" );
	target = getEnt ( "trap_4_effect", "targetname" );
	
	wait 7;
	
	for(;;)
	{
		iprintln ( "^1<< ^7The explosion ^7is ready to activate" );
		wait 1;
	
		trigger setHintString( "^2[^7activate the explosion^2]" );
		trigger waittill ( "trigger", player );
		if( !level.order )
            continue;
               
        level.order = false;
		iPrintLnBold ( "^1<<^7 " + player.name + " activated the ^2explosion ^1>>" );
		trigger setHintString( "^1[^7loading^1]" );
		wait 1;
		
		playFx ( level.explosion, target.origin );
		self playSound( "artillery_impact" );
		earthquake ( 1, 1, target.origin, 500 );
		wait 0.05;
		
		players = getEntArray( "player", "classname" );	
		for(k=0;k<players.size;k++)
		{
			dist = Distance2D( players[k].origin, target.origin );
			if(dist < 200)
			{
				players[k] suicide();
			}
			else if(dist < 350)
			{
				RadiusDamage( players[k].origin, 10, 60, 40);
			}
			else if(dist < 450)
			{
				RadiusDamage( players[k].origin, 10, 30, 10);
			}
			else if(dist < 550)
			{
				RadiusDamage( players[k].origin, 10, 10, 5);
			}
		}
		wait 40;
	}
}

trap_8()
{
	trigger = getEnt ( "trap_8_trigger", "targetname" );
	station_1 = getEnt ( "trap_8_target_2", "targetname" );
	station_2 = getEnt ( "trap_8_target_3", "targetname" );
	
	wait 100;
	
	for(;;)
	{
		station_2 hide();
		station_1 hide();
		station_1 notsolid();
		station_2 notsolid();
		
		iprintln ( "^1<< ^7The high tide ^7is ready to activate" );
		wait 1;
	
		trigger setHintString( "^2[^7activate the high tide^2]" );
		trigger waittill ( "trigger", player );
		if( !level.order )
			continue;
               
		level.order = false;

		thread trap_8_water();
		player iPrintLnBold ( "^1<<^7 You ^2can't move ^7now ^1>>" );
		
		station_1 show();
		station_2 show();
		station_1 solid();
		station_2 solid();
		
		iPrintLnBold ( "^1<<^7 " + player.name + " activated the ^2high tide ^1>>" );
		trigger setHintString( "^1[^7done^1]" );
		
		player freezeControls(1);
		
		station_1 moveZ ( 1040, 3, 0.5, 2.5 );
		wait 1.5;
		station_2 moveZ ( 1040, 3, 0.5, 2.5 );
		wait 20;
		
		station_1 hide();
		station_1 notsolid();
		wait 0.05;
		
		station_1 moveZ ( -1040, 1 );
		wait 5;
		
		station_2 moveZ ( -1040, 8, 4, 6 );
		wait 8;
		player freezeControls(0);
		player iPrintLnBold ( "^1<<^7 You can ^2move ^7now again ^1>>" );
	
		station_2 hide();
		station_2 notsolid();
		wait 9999;
	}
}

trap_8_water()
{
	target = getEnt ( "trap_8_target", "targetname" );
	water = getEnt ( "water_trigger", "targetname" );
	
	water enableLinkTo();
	water LinkTo ( target );
	
	target moveZ ( 162, 15 );
	wait 20;
	
	target moveZ ( -162, 15 );
	wait 15;
}

trap_9()
{
	trigger = getEnt ( "trap_9_trigger", "targetname" );
	target = getEnt ( "trap_9_target", "targetname" );
	hurt = getEnt ( "trap_9_hurt", "targetname" );
	laser = getEnt ( "trap_9_laser", "targetname" );
	effect_1 = getEnt ( "trap_9_effect_1", "targetname" );
	effect_2 = getEnt ( "trap_9_effect_2", "targetname" );
	
	thread laser_effect();
	
	hurt enableLinkTo();
	hurt LinkTo ( laser );
	
	laser notSolid();
	
	wait 8;
	
	for(;;)
	{		
		iprintln ( "^1<< ^7The laser ^7is ready to activate" );
		wait 1;
	
		trigger setHintString( "^2[^7activate the laser^2]" );
		trigger waittill ( "trigger", player );
		if( !level.order )
            continue;
               
        level.order = false;
		
		iPrintLnBold ( "^1<<^7 " + player.name + " activated the ^2laser ^1>>" );
		trigger setHintString( "^1[^7loading^1]" );
		
		target moveZ ( 768, 3, 1, 2 );
		effect_1 moveZ ( 768, 3, 1, 2 );
		effect_2 moveZ ( 768, 3, 1, 2 );
		laser moveZ ( 768, 3, 1, 2 );
		wait 3.5;
		
		target moveY ( -1344, 5, 3, 2 );
		effect_1 moveY ( -1344, 5, 3, 2 );
		effect_2 moveY ( -1344, 5, 3, 2 );
		laser moveY ( -1344, 5, 3, 2 );
		wait 6;
		
		target moveY ( 1344, 5, 3, 2 );
		laser moveY ( 1344, 5, 3, 2 );
		effect_1 moveY ( 1344, 5, 3, 2 );
		effect_2 moveY ( 1344, 5, 3, 2 );
		wait 5.2;
		
		target moveZ ( -768, 3, 1, 2 );
		laser moveZ ( -768, 3, 1, 2 );
		effect_1 moveZ ( -768, 3, 1, 2 );
		effect_2 moveZ ( -768, 3, 1, 2 );
		wait 40;
	}
}

laser_effect()
{
	effect_1 = getEnt ( "trap_9_effect_1", "targetname" );
	effect_2 = getEnt ( "trap_9_effect_2", "targetname" );
	
	while(1)
	{
		playFx ( level.laser_spawn, effect_1.origin );
		playFx ( level.laser_spawn, effect_2.origin );
		wait 0.05;
	}
}

light_effect()
{
	effect_1 = getEnt ( "trap_10_effect_1", "targetname" );
	
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
	effect_1 = getEnt ( "trap_10_effect_1", "targetname" );
	explosion_1 = getEnt ( "trap_10_explosion_1", "targetname" );
	explosion_2 = getEnt ( "trap_10_explosion_2", "targetname" );
	explosion_3 = getEnt ( "trap_10_explosion_3", "targetname" );
	explosion_4 = getEnt ( "trap_10_explosion_4", "targetname" );
	
	wait 9;
	
	for(;;)
	{		
		iprintln ( "^1<< ^7The light ^7is ready to activate" );
		wait 1;
	
		trigger setHintString( "^2[^7activate the light^2]" );
		trigger waittill ( "trigger", player );
		if( !level.order )
            continue;
               
        level.order = false;
		
		thread light_effect();
		iPrintLnBold ( "^1<<^7 " + player.name + " activated the ^2light ^1>>" );
		trigger setHintString( "^1[^7loading^1]" );
		wait 10;

		i = randomintrange( 0, 4 );
		if(i == 0)
		{
			effect_1 moveTo (( 384, 392, 24 ), 2, 0.5, 1.5);
			wait 2;
		
			level.effect = false;
			PlayFx ( level.light_explosion, explosion_1.origin );
			wait 0.05;
		
			player thread lights_explosion_1(player);
			effect_1 moveTo (( 0, 0, 832 ), 2, 0.5, 1.5);
			wait 3;
			
			player.maxhealth = 100;
			player.health = player.maxhealth;
			player iPrintln ( "^1<< ^7your health got restored" );
			wait 0.05;
		}
		else if(i == 1)
		{
			effect_1 moveTo (( -384, 384, 24 ), 2, 0.5, 1.5);
			wait 2;
		
			level.effect = false;
			PlayFx ( level.light_explosion, explosion_2.origin );
			wait 0.05;
		
			player thread lights_explosion_2(player);
			effect_1 moveTo (( 0, 0, 832 ), 2, 0.5, 1.5);
			wait 3;
			
			player.maxhealth = 100;
			player.health = player.maxhealth;
			player iPrintln ( "^1<< ^7your health got restored" );
			wait 0.05;
		}
		else if(i == 2)
		{
			effect_1 moveTo (( -384, -392, 24 ), 2, 0.5, 1.5);
			wait 2;
		
			level.effect = false;
			PlayFx ( level.light_explosion, explosion_3.origin );
			wait 0.05;
		
			player thread lights_explosion_3(player);
			effect_1 moveTo (( 0, 0, 832 ), 2, 0.5, 1.5);
			wait 3;
			
			player.maxhealth = 100;
			player.health = player.maxhealth;
			player iPrintln ( "^1<< ^7your health got restored" );
			wait 0.05;
		}
		else if(i == 3)
		{
			effect_1 moveTo (( 384, -384, 24 ), 2, 0.5, 1.5);
			wait 2;
		
			level.effect = false;
			PlayFx ( level.light_explosion, explosion_4.origin );
			wait 0.05;
		
			player thread lights_explosion_4(player);
			effect_1 moveTo (( 0, 0, 832 ), 2, 0.5, 1.5);
			wait 3;
			
			player.maxhealth = 100;
			player.health = player.maxhealth;
			player iPrintln ( "^1<< ^7your health got restored" );
			wait 0.05;
		}
		wait 55;
	}
}

lights_explosion_1(player)
{
	explosion_1 = getEnt ( "trap_10_explosion_1", "targetname" );
	
	self playSound( "artillery_impact" );
	players = getEntArray( "player", "classname" );	
	for(k=0;k<players.size;k++)
	{
		dist = Distance2D( players[k].origin, explosion_1.origin );
		if(dist < 200)
		{
			players[k] suicide();
		}
		else if(dist < 350)
		{
			RadiusDamage( players[k].origin, 10, 60, 40);
		}
		else if(dist < 450)
		{
			RadiusDamage( players[k].origin, 10, 30, 10);
		}
		else if(dist < 550)
		{
			RadiusDamage( players[k].origin, 10, 10, 5);
		}
	}
}

lights_explosion_2(player)
{
	explosion_1 = getEnt ( "trap_10_explosion_2", "targetname" );
	
	self playSound( "artillery_impact" );
	players = getEntArray( "player", "classname" );	
	for(k=0;k<players.size;k++)
	{
		dist = Distance2D( players[k].origin, explosion_1.origin );
		if(dist < 200)
		{
			players[k] suicide();
		}
		else if(dist < 350)
		{
			RadiusDamage( players[k].origin, 10, 60, 40);
		}
		else if(dist < 450)
		{
			RadiusDamage( players[k].origin, 10, 30, 10);
		}
		else if(dist < 550)
		{
			RadiusDamage( players[k].origin, 10, 10, 5);
		}
	}
}

lights_explosion_3(player)
{
	explosion_1 = getEnt ( "trap_10_explosion_3", "targetname" );
	
	self playSound( "artillery_impact" );
	players = getEntArray( "player", "classname" );	
	for(k=0;k<players.size;k++)
	{
		dist = Distance2D( players[k].origin, explosion_1.origin );
		if(dist < 200)
		{
			players[k] suicide();
		}
		else if(dist < 350)
		{
			RadiusDamage( players[k].origin, 10, 60, 40);
		}
		else if(dist < 450)
		{
			RadiusDamage( players[k].origin, 10, 30, 10);
		}
		else if(dist < 550)
		{
			RadiusDamage( players[k].origin, 10, 10, 5);
		}
	}
}

lights_explosion_4(player)
{
	explosion_1 = getEnt ( "trap_10_explosion_4", "targetname" );
	
	self playSound( "artillery_impact" );
	players = getEntArray( "player", "classname" );	
	for(k=0;k<players.size;k++)
	{
		dist = Distance2D( players[k].origin, explosion_1.origin );
		if(dist < 200)
		{
			players[k] suicide();
		}
		else if(dist < 350)
		{
			RadiusDamage( players[k].origin, 10, 60, 40);
		}
		else if(dist < 450)
		{
			RadiusDamage( players[k].origin, 10, 30, 10);
		}
		else if(dist < 550)
		{
			RadiusDamage( players[k].origin, 10, 10, 5);
		}
	}
}

addTestClients()
{
	setDvar("scr_testclients", "");
	wait 1;
	for(;;)
	{
		if(getdvarInt("scr_testclients") > 0)
			break;
		wait 1;
	}
	testclients = getdvarInt("scr_testclients");
	setDvar( "scr_testclients", 0 );
	for(i=0;i<testclients;i++)
	{
		ent[i] = addtestclient();

		if (!isdefined(ent[i]))
		{
			println("Could not add test client");
			wait 1;
			continue;
		}
		ent[i].pers["isBot"] = true;
		ent[i] thread TestClient("autoassign");
	}
	thread addTestClients();
}

TestClient(team)
{
	self endon( "disconnect" );

	while(!isdefined(self.pers["team"]))
	wait .05;
		
	self notify("menuresponse", game["menu_team"], team);
	wait 0.5;
}

endrooms()
{
	teleport = getEnt ( "endroom_choice", "targetname" );
	teleport_2 = getEnt ( "endroom_choice_acti", "targetname" );
	trigger = getEnt ( "activate_endroom", "targetname" );
	
	wait 5;
	
	while(1)
	{
		trigger waittill ( "trigger", player );
		if( GetTeamPlayersAlive( "allies" ) != 1 || GetTeamPlayersAlive( "axis" ) != 1 )
			continue;
		thread endroom_portals();
		
		players = getentarray( "player", "classname" );
		for( i=0;i<=players.size;i++ )
		{
			if( players[i].pers[ "team" ] == "allies" )
			{
				players[i] setOrigin( teleport.origin );
				wait 0.1;
			}
			else if( players[i].pers[ "team" ] == "axis" )
			wait 0.5;
			level.activ setOrigin( teleport_2.origin );
			level.activ setPlayerangles( teleport_2.angles );	
		}
	break;
	}
}

endroom_portals()
{
	endroom_portals = getEnt ( "endroom_portal", "targetname" );
	
	endroom_portals moveZ ( 384, 5, 3, 2 );
	wait 5;
	
	thread dust_sniper();
	thread dust_knife();
	thread dust_jump();
	
	noti = SpawnStruct();
	noti.titleText = "^2Choose your Endroom";
	noti.notifyText = "^2Knife ^1- ^2Sniper ^1- ^2Jump";
	noti.duration = 5;
	noti.glowcolor = (0, 0.9, 2);
	players = getEntArray( "player", "classname" );
	for( i=0;i<players.size;i++ )
	players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
}

endroom_snipe()
{
    level.snipe = getent ( "endroom_snipe_trigger", "targetname" );
	level.snipe_acti_respawn = getent ("sniper_acti_porter","targetname");
	level.snipe_jumper_respawn = getent ("sniper_jumper_porter","targetname");
	
    level.snipe waittill( "trigger", player );
	
	player disableWeapons(1);
	level.activ disableWeapons(1);
	wait 0.05;
		
	player freezeControls(1);
	level.activ freezeControls(1);
	wait 0.5;
		
	noti = SpawnStruct();
	noti.titleText = "^2Sniper Room";
	noti.notifyText = "^1" + player.name + "^2 has choosen the Sniper Room";
	noti.duration = 5;
	noti.glowcolor = (0, 0.9, 2);
	players = getEntArray( "player", "classname" );
	for( i=0;i<players.size;i++ )
	players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
	wait 0.05;
        
    player setOrigin( level.snipe_jumper_respawn.origin );
	player setPlayerangles( level.snipe_jumper_respawn.angles );
		
	player TakeAllWeapons();
	wait 0.05;
	player GiveWeapon( "m40a3_mp" );
	player GiveWeapon( "remington700_mp" );
	player GiveMaxAmmo( "m40a3_mp" );
	player GiveMaxAmmo( "remington700_mp" );
		
	level.activ setOrigin( level.snipe_acti_respawn.origin );
	level.activ setPlayerangles( level.snipe_acti_respawn.angles );	
		
	level.activ TakeAllWeapons();
	wait 0.05;
	level.activ GiveWeapon( "m40a3_mp" );
	level.activ GiveWeapon( "remington700_mp" );
	level.activ GiveMaxAmmo( "m40a3_mp" );
	level.activ GiveMaxAmmo( "remington700_mp" );
	wait 3;
	
	start = NewHudElem();
	start.alignX = "center";
	start.alignY = "middle";
	start.horzalign = "center";
	start.vertalign = "middle";
	start.alpha = 1;
	start.x = 0;
	start.y = -50;
	start.font = "objective";
	start.fontscale = 3;
	start.glowalpha = 1;
	start.glowcolor = ( 0, 1, 0 );
	start setText( "^2[ ^13 ^2]" );
	start SetPulseFX( 100, 4000, 500 );
	wait 1.6;
	start setText( "^2[ ^12 ^2]" );
	start SetPulseFX( 100, 4000, 500 );
	wait 1.6;
	
	player.maxhealth = 100;
	player.health = player.maxhealth;
	player iPrintln ( "^1<< ^7your health got restored" );
	wait 0.05;
	
	player enableWeapons(1);
	level.activ enableWeapons(1);
	
	player switchToWeapon( "m40a3_mp" );
	level.activ switchToWeapon( "m40a3_mp" );
	
	start setText( "^2[ ^11 ^2]" );
	start SetPulseFX( 100, 4000, 500 );
	wait 1.8;
	start setText( "^2[ ^1GO ^2]" );
	start SetPulseFX( 100, 4000, 500 );
		
	player freezeControls(0);
	level.activ freezeControls(0);
    wait 3;
	
	start destroy();
}

endroom_knife()
{
    level.knife = getent ( "endroom_knife_trigger", "targetname" );
	level.knife_acti_respawn = getent ( "knife_acti_porter","targetname" );
	level.knife_jumper_respawn = getent ( "knife_jumper_porter","targetname" );
	
    level.knife waittill( "trigger", player );
	
	player disableWeapons(1);
	level.activ disableWeapons(1);
	wait 0.05;
		
	player freezeControls(1);
	level.activ freezeControls(1);
	wait 0.5;
		
	noti = SpawnStruct();
	noti.titleText = "^2Knife Room";
	noti.notifyText = "^1" + player.name + "^2 has choosen the Knife Room";
	noti.duration = 5;
	noti.glowcolor = (0, 0.9, 2);
	players = getEntArray( "player", "classname" );
	for( i=0;i<players.size;i++ )
	players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
	wait 0.05;
        
    player setOrigin( level.knife_jumper_respawn.origin );
	player setPlayerangles( level.knife_jumper_respawn.angles );
		
	player TakeAllWeapons();
	wait 0.05;
	player GiveWeapon( "knife_mp" );
		
	level.activ setOrigin( level.knife_acti_respawn.origin );
	level.activ setPlayerangles( level.knife_acti_respawn.angles );	
		
	level.activ TakeAllWeapons();
	wait 0.05;
	level.activ GiveWeapon( "knife_mp" );
	wait 3;
	
	start = NewHudElem();
	start.alignX = "center";
	start.alignY = "middle";
	start.horzalign = "center";
	start.vertalign = "middle";
	start.alpha = 1;
	start.x = 0;
	start.y = -50;
	start.font = "objective";
	start.fontscale = 3;
	start.glowalpha = 1;
	start.glowcolor = ( 0, 1, 0 );
	start setText( "^2[ ^13 ^2]" );
	start SetPulseFX( 100, 4000, 500 );
	wait 1.6;
	start setText( "^2[ ^12 ^2]" );
	start SetPulseFX( 100, 4000, 500 );
	wait 1.6;
	
	player.maxhealth = 100;
	player.health = player.maxhealth;
	player iPrintln ( "^1<< ^7your health got restored" );
	wait 0.05;
	
	player enableWeapons(1);
	level.activ enableWeapons(1);
	
	player switchToWeapon( "knife_mp" );
	level.activ switchToWeapon( "knife_mp" );
	
	start setText( "^2[ ^11 ^2]" );
	start SetPulseFX( 100, 4000, 500 );
	wait 1.8;
	start setText( "^2[ ^1GO ^2]" );
	start SetPulseFX( 100, 4000, 500 );
		
	player freezeControls(0);
	level.activ freezeControls(0);
    wait 3;
	
	start destroy();
}

endroom_jump()
{
    level.jump = getent ( "endroom_jump_trigger", "targetname" );
	level.jump_acti_respawn = getent ( "jump_acti_respawn","targetname" );
	level.jump_jumper_respawn = getent ( "jump_jumper_respawn","targetname" );
	
    level.jump waittill( "trigger", player );
	
	player disableWeapons(1);
	level.activ disableWeapons(1);
	wait 0.05;
		
	player freezeControls(1);
	level.activ freezeControls(1);
	wait 0.5;
	
	level.icomar = false;
		
	noti = SpawnStruct();
	noti.titleText = "^2Jump Room";
	noti.notifyText = "^1" + player.name + "^2 has choosen the Jump Room";
	noti.duration = 5;
	noti.glowcolor = (0, 0.9, 2);
	players = getEntArray( "player", "classname" );
	for( i=0;i<players.size;i++ )
	players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
	wait 0.05;
        
    player setOrigin( level.jump_jumper_respawn.origin );
	player setPlayerangles( level.jump_jumper_respawn.angles );
		
	player TakeAllWeapons();
	wait 0.05;
	player GiveWeapon( "knife_mp" );
		
	level.activ setOrigin( level.jump_acti_respawn.origin );
	level.activ setPlayerangles( level.jump_acti_respawn.angles );	
		
	level.activ TakeAllWeapons();
	wait 0.05;
	level.activ GiveWeapon( "knife_mp" );
	wait 3;
	
	start = NewHudElem();
	start.alignX = "center";
	start.alignY = "middle";
	start.horzalign = "center";
	start.vertalign = "middle";
	start.alpha = 1;
	start.x = 0;
	start.y = -50;
	start.font = "objective";
	start.fontscale = 3;
	start.glowalpha = 1;
	start.glowcolor = ( 0, 1, 0 );
	start setText( "^2[ ^13 ^2]" );
	start SetPulseFX( 100, 4000, 500 );
	wait 1.6;
	start setText( "^2[ ^12 ^2]" );
	start SetPulseFX( 100, 4000, 500 );
	wait 1.6;
	
	player.maxhealth = 100;
	player.health = player.maxhealth;
	player iPrintln ( "^1<< ^7your health got restored" );
	wait 0.05;
	
	player enableWeapons(1);
	level.activ enableWeapons(1);
	
	player switchToWeapon( "knife_mp" );
	level.activ switchToWeapon( "knife_mp" );
	
	start setText( "^2[ ^11 ^2]" );
	start SetPulseFX( 100, 4000, 500 );
	wait 1.8;
	start setText( "^2[ ^1GO ^2]" );
	start SetPulseFX( 100, 4000, 500 );
		
	player freezeControls(0);
	level.activ freezeControls(0);
    wait 3;
	
	start destroy();
	thread jump_respawn();
	thread jump_weapon();
	wait 0.05;
}

jump_bouncer_1()
{
	bounce_trig = getEnt ( "jump_bouncer_1", "targetname" );
	
	for(;;)
	{
		bounce_trig waittill ( "trigger", who );
		
		oldpos = who.origin;
		strenght = 3;
		for(i=0;i<strenght;i++)
		{
			who.health += 200;
			who finishPlayerDamage(who, level.jumpattacker, 200, 0, "MOD_FALLING", "jump_mp", who.origin, AnglesToForward((-90,0,0)), "none", 0);
		}
	}
}

jump_bouncer_2()
{
	bounce_trig = getEnt ( "jump_bouncer_2", "targetname" );
	
	for(;;)
	{
		bounce_trig waittill ( "trigger", who );
		
		oldpos = who.origin;
		strenght = 3;
		for(i=0;i<strenght;i++)
		{
			who.health += 200;
			who finishPlayerDamage(who, level.jumpattacker, 200, 0, "MOD_FALLING", "jump_mp", who.origin, AnglesToForward((-90,0,0)), "none", 0);
		}
	}
}

super_bounce_1()
{
	bounce_trig = getEnt ( "super_bounce_1", "targetname" );
	
	for(;;)
	{
		bounce_trig waittill ( "trigger", who );
		
		oldpos = who.origin;
		strenght = 2;
		for(i=0;i<strenght;i++)
		{
			who.health += 80;
			who finishPlayerDamage(who, level.jumpattacker, 80, 0, "MOD_FALLING", "jump_mp", who.origin, AnglesToForward((-90,0,0)), "none", 0);
		}
	}
}

super_bounce_2()
{
	bounce_trig = getEnt ( "super_bounce_2", "targetname" );
	
	for(;;)
	{
		bounce_trig waittill ( "trigger", who );
		
		oldpos = who.origin;
		strenght = 2;
		for(i=0;i<strenght;i++)
		{
			who.health += 80;
			who finishPlayerDamage(who, level.jumpattacker, 80, 0, "MOD_FALLING", "jump_mp", who.origin, AnglesToForward((-90,0,0)), "none", 0);
		}
	}
}

jump_respawn()
{
	trigger = getent ( "jump_respawn", "targetname" );
	
	for(;;)
	{
		trigger waittill ( "trigger", player );
		
		playFX ( level.water_splash, self.origin );
		self playSound ( "water_splash_small" );
		wait 0.05;
	
		if( player.pers[ "team" ] != "spectator" )
		{
			if( player.pers[ "team" ] == "allies" )
			{
				player SetPlayerAngles ( level.pj.angles );
				player SetOrigin ( level.jump_jumper_respawn.origin );
			}
			if( player.pers[ "team" ] == "axis" )
			{
				player SetPlayerAngles ( level.aj.angles );
				player SetOrigin ( level.jump_acti_respawn.origin );
			}
		}
		wait 0.05;
	}
}

jump_weapon()
{
	jump_trigger = getEnt ( "jump_give_weap", "targetname" );
	
	jump_trigger waittill ( "trigger", player );
	jump_trigger delete();
	
	player TakeAllWeapons();
	
	if ( RandomIntRange ( 1, 101) > 50 )
	{
		for ( i = 1; i < 5; i++ )
		{
			player giveWeapon ( "remington700_mp" );
			player giveMaxAmmo ( "remington700_mp" );
			player switchToWeapon ( "remington700_mp" );
			wait 0.5;
		}
	}
	else
	{
		for ( i = 5; i < 9; i++ )
		{
			player giveWeapon( "winchester1200_mp" );
			player giveMaxAmmo( "winchester1200_mp" );
			player switchToWeapon( "winchester1200_mp" );
			wait 0.5;
		}
		wait 0.05;
	}
}

secret()
{
	trigger_1 = getEnt ( "secret_step_1", "targetname" );
	button_1 = getEnt ( "secret_button_1", "targetname" );
	button_trigger_1 = getEnt ( "secret_button_trigger_1", "targetname" );
	
	button_trigger_1 enableLinkTo();
	button_trigger_1 LinkTo( button_1 );
	
	button_1 moveY ( 48, 0.5 );
	
	for(;;)
	{
		trigger_1 waittill ( "trigger", player );
		if( isDefined( level.trapsDisabled ) && level.trapsDisabled )
		{
			player iPrintLnBold( "^1Fire burns!!!" );
			wait 30;
		}
		else
		{
			button_1 moveY ( -48, 2 );
			wait 8;
		
			button_1 moveY ( 48, 2 );
			wait 50;
		}
	}
}

secret_trigger()
{
	button_trigger = getEnt ( "secret_button_trigger_1", "targetname" );
	
	button_trigger waittill ( "trigger", player );
	
	player giveWeapon( "winchester1200_mp" );
	player giveMaxAmmo( "winchester1200_mp" );
	player switchToWeapon( "winchester1200_mp" );
	
	player thread killstreak();
	player thread Jump_high(player);
}
	
secret_fail_1()
{
	trigger = getEnt ( "secret_fail_1", "targetname" );
	
	trigger waittill ( "trigger", player );
	
	wait 1;
	iPrintlnBold ( "^1Fire burns!!!" );
}

secret_fail_2()
{
	trigger = getEnt ( "secret_fail_2", "targetname" );
	
	trigger waittill ( "trigger", player );
	
	wait 1;
	iPrintlnBold ( "^1Fire burns!!!" );
}

Jump_high(player)
{
	player endon( "death" );
	
	oldpos = player.origin;
	jumped = false;
	level.icomar = true;
	
	while(level.icomar)
	{
		if( ( player.origin[2] - oldpos[2] ) > 10  && !player IsOnGround() && !jumped )
		{
			if( jumped )
				continue;
			strenght = 1;
			for(i=0;i<strenght;i++)
			{
				player.health += 100;
				player finishPlayerDamage( player, level.jumpattacker, 100, 0, "MOD_FALLING", "jump_mp", player.origin, AnglesToForward((-90,0,0)), "none", 0 );
			}
			jumped = true;
		}
		else if(oldpos[2] > player.origin[2] && player IsOnGround() && jumped)
			jumped = false;
		oldpos = player.origin;
		wait 0.1;
	}
}

killstreak()
{
	self endon("death");
	
	while(1)
	{
		self waittill("weapon_fired");
		my = self gettagorigin("j_head");
		trace=bullettrace(my, my + anglestoforward(self getplayerangles())*100000,true,self)["position"];
		
		playfx(level.expbullt,trace);
		
		self playSound( "artillery_impact" );
		dis=distance(self.origin, trace);
		
		if(dis<101) RadiusDamage( trace, dis, 200, 50, self );
		RadiusDamage( trace, 60, 250, 50, self );
		RadiusDamage( trace, 100, 800, 50, self );
		
		vec = anglestoforward(self getPlayerAngles());
		end = (vec[0] * 200000, vec[1] * 200000, vec[2] * 200000);
		
		SPLOSIONlocation = BulletTrace( self gettagorigin("tag_eye"), self gettagorigin("tag_eye")+end, 0, self)[ "position" ];
		explode = loadfx( "fire/tank_fire_engine" );
		
		playfx(explode, SPLOSIONlocation);
		self thread DamageArea(SPLOSIONlocation,500,800,200,"artillery_mp",false);
	}
}

DamageArea(Point,Radius,MaxDamage,MinDamage,Weapon,TeamKill)
{
	KillMe = false;
	Damage = MaxDamage;
	
	for(i=0;i<level.players.size+1;i++)
	{
		DamageRadius = distance(Point,level.players[i].origin);
		
		if(DamageRadius<Radius)
		{
			if(MinDamage<MaxDamage)
			
			Damage = int(MinDamage+((MaxDamage-MinDamage)*(DamageRadius/Radius)));
			if( ( level.players[i] != self ) && ( ( TeamKill && level.teamBased ) || ( ( self.pers["team"] != level.players[i].pers["team"] ) && level.teamBased ) || !level.teamBased ) )
			level.players[i] FinishPlayerDamage( level.players[i], self,Damage, 0, "MOD_PROJECTILE_SPLASH", Weapon,level.players[i].origin,level.players[i].origin, "none", 0);
			if( level.players[i] == self )
			KillMe = true;
		}
		wait 0.01;
	}
	RadiusDamage(Point,Radius-(Radius*0.25),MaxDamage,MinDamage,self);
	
	if(KillMe)
	self FinishPlayerDamage(self,self,Damage,0,"MOD_PROJECTILE_SPLASH",Weapon,self.origin,self.origin,"none",0);
}