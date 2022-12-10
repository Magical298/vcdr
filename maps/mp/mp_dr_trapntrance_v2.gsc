/*	 _    ___      __  _                               ______  
	| |  / (_)____/ /_(_)____                         / _____\ 
	| | / / / ___/ __/ / ___/                        / / ___/ |
	| |/ / (__  ) /_/ / /__                         / / /__  / 
	|___/_/____/\__/_/\___/  __    ____            |  \___/ /  
	   / __ \___  ____ _/ /_/ /_  / __ \__  ______  \______/   
	  / / / / _ \/ __ `/ __/ __ \/ /_/ / / / / __ \            
	 / /_/ /  __/ /_/ / /_/ / / / _, _/ /_/ / / / /            
	/_____/\___/\__,_/\__/_/ /_/_/ |_|\__,_/_/ /_/             
	                                                           
	mp_dr_trapntrance_v2 - Blade & Niko (uNI) ©

	Discord: 
			Blade #6504
			Niko #2926
*/
main()
{
	maps\mp\_load::main();

	// ================ Game Settings ================ //
	game["allies"] = "sas";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "woodland";
	game["axis_soldiertype"] = "woodland";

	// ==================== Dvars ==================== //
	setdvar("bg_falldamagemaxheight", 20000 );
	setdvar("bg_falldamageminheight", 15000 );

  	setdvar( "r_specularcolorscale", "1" );
  	setdvar("r_glowbloomintensity0",".25");
  	setdvar("r_glowbloomintensity1",".25");
  	setdvar("r_glowskybleedintensity0",".3");
  	setDvar( "compassmaxrange", "1024" );

  	// ================== Precache =================== //
  	precachemodel("vistic_logo");

  	precacheitem("winchester1200_mp");
  	precacheitem("knife_mp");
  	precacheitem("deserteagle_mp");
  	precacheitem("deserteaglegold_mp");
  	precacheitem("m40a3_mp");
  	precacheitem("remington700_mp");

  	// =================== Effects =================== //
  	level.tnt_red_embers = loadfx("vistic/red_embers");
  	level.tnt_cyan_embers = loadfx("vistic/cyan_embers");
  	level.tnt_purple_embers = loadfx("vistic/purple_embers");
  	level.tnt_red_light = loadfx("vistic/purple_light");

  	// =================== Scripts =================== //
  	thread doors();
  	thread trapntrancehud();
  	thread texts();
  	thread tnt_endmap();
  	thread tnt_secret();
  	thread tnt_rooms();

  	thread trap_traps();
  	thread trance_traps();

   if(!isdefined(level.vcQueueCustom))
   level.vcQueueCustom = (-2623,-8805,562);

}

doors()
{
	trap = getent("trap_door","targetname");
	trance = getent("trance_door","targetname");

	acti_trap = getent("acti_trap","targetname");
	acti_trance = getent("acti_trance","targetname");

	level waittill("round_started");

	thread map_effects();

	wait 1;
	thread welcomecucc();

	if(level.freerun)
	{
		vc = randomint(4);
		if(vc == 0)
			ambientplay("trap0",2);
		else if(vc == 1)
			ambientplay("trap1",2);
		else if(vc == 2)
			ambientplay("trance0",2);
		else 
			ambientplay("trance1",2);

		trap movez(-200,5);
		trance movez(-200,5);

		wait 5;

		trap delete();
		trance delete();
	}
	else 
	{
		thread trap_way();
		thread trance_way();
		thread random_way();

		wait 10;

		if(!isdefined(level.tnt_way))
		{
			level.tnt_way = true;

			level.trap_trig delete();
			level.trance_trig delete();
			level.random_trig delete();

			iprintlnbold("^2Activator^7 appears to be AFK!");

			vc = randomint(6);
			if(vc == 0 || vc == 2 || vc == 4)
			{
				level.trap_n_trance.glowcolor = (0,0,1);
				level.trap_n_trance settext("Trap");

				iprintln("^5Trap^7 Way opened");

				level.activ setorigin(acti_trap.origin);
				level.activ setplayerangles(acti_trap.angles);

				vc = randomint(2);

				ambientplay("trap"+vc,2);

				trap movez(-200,5);
				wait 5;
				trap delete();
			}
			else 
			{
				level.trap_n_trance.glowcolor = (0,1,0);
				level.trap_n_trance settext("Trance");

				iprintlnbold("^2Trance^7 Way opened");

				level.activ setorigin(acti_trance.origin);
				level.activ setplayerangles(acti_trance.angles);

				vc = randomint(2);

				ambientplay("trance"+vc,2);

				trance movez(-200,5);
				wait 5;
				trance delete();
			}
		}
	}
}

trapntrancehud()
{
	if(isdefined(level.trap_n_trance))
		level.trap_n_trance destroy();

	level.trap_n_trance = newhudelem();
	level.trap_n_trance.alignx = "center";
	level.trap_n_trance.aligny = "bottom";
	level.trap_n_trance.horzalign = "center";
	level.trap_n_trance.vertalign = "bottom";
	level.trap_n_trance.y = -7;
	level.trap_n_trance.x = 0;
	level.trap_n_trance.font = "objective";
	level.trap_n_trance.fontscale = 1.6;
	level.trap_n_trance.glowalpha = 1;
	level.trap_n_trance.label = &"Map Way: &&1";

	level.trap_n_trance.glowcolor = (1,0,0);
	level.trap_n_trance settext("... pending ...");
}

trap_way()
{
	level.trap_trig = getent("acti_trapway","targetname");
	trap = getent("trap_door","targetname");
	acti_trap = getent("acti_trap","targetname");

	level.trap_trig sethintstring("Press [^5&&1^7] to choose a ^5Trap ^7Way");
	level.trap_trig waittill("trigger");

	if(!isdefined(level.tnt_way))
	{
		level.tnt_way = true;

		level.trance_trig delete();
		level.random_trig delete();

		vc = randomint(2);

		ambientplay("trap"+vc,2);
	}

	level.trap_n_trance.glowcolor = (0,0,1);
	level.trap_n_trance settext("Trap");

	iprintln("^5Trap^7 Way opened");

	level.activ setorigin(acti_trap.origin);
	level.activ setplayerangles(acti_trap.angles);

	trap movez(-200,5);
	wait 5;
	trap delete();
}

trance_way()
{
	level.trance_trig = getent("acti_tranceway","targetname");
	trance = getent("trance_door","targetname");
	acti_trance = getent("acti_trance","targetname");

	level.trance_trig sethintstring("Press [^2&&1^7] to choose a ^2Trance ^7Way");
	level.trance_trig waittill("trigger");

	if(!isdefined(level.tnt_way))
	{
		level.tnt_way = true;

		level.trap_trig delete();
		level.random_trig delete();

		vc = randomint(2);

		ambientplay("trance"+vc,2);
	}

	level.trap_n_trance.glowcolor = (0,1,0);
	level.trap_n_trance settext("Trance");

	iprintln("^2Trance^7 Way opened");

	level.activ setorigin(acti_trance.origin);
	level.activ setplayerangles(acti_trance.angles);

	trance movez(-200,5);
	wait 5;
	trance delete();
}

random_way()
{
	level.random_trig = getent("acti_randomway","targetname");
	trap = getent("trap_door","targetname");
	trance = getent("trance_door","targetname");

	acti_trap = getent("acti_trap","targetname");
	acti_trance = getent("acti_trance","targetname");

	level.random_trig sethintstring("Press [^3&&1^7] to choose a Random Way");
	level.random_trig waittill("trigger");

	if(!isdefined(level.tnt_way))
	{
		level.tnt_way = true;

		level.trap_trig delete();
		level.trance_trig delete();

		iprintlnbold("^2Activator^7 decided a Random Way");

		vc = randomint(6);
		if(vc == 0 || vc == 2 || vc == 4)
		{
			level.trap_n_trance.glowcolor = (0,0,1);
			level.trap_n_trance settext("Trap");

			iprintln("^5Trap^7 Way opened");

			level.activ setorigin(acti_trap.origin);
			level.activ setplayerangles(acti_trap.angles);

			vc = randomint(2);

			ambientplay("trap"+vc,2);

			trap movez(-200,5);
			wait 5;
			trap delete();
		}
		else 
		{
			level.trap_n_trance.glowcolor = (0,1,0);
			level.trap_n_trance settext("Trance");

			iprintln("^2Trance^7 Way opened");

			level.activ setorigin(acti_trance.origin);
			level.activ setplayerangles(acti_trance.angles);

			vc = randomint(2);

			ambientplay("trance"+vc,2);

			trance movez(-200,5);
			wait 5;
			trance delete();
		}
	}
}

texts()
{
	trap_start = getent("trap_start","targetname");
	trap_end = getent("trap_end","targetname");

	trance_start = getent("trance_start","targetname");
	trance_end = getent("trance_end","targetname");

	while(1)
	{
		trap_start rotateyaw(-360,6);
		trap_end rotateyaw(-360,6);

		trance_start rotateyaw(360,6);
		trance_end rotateyaw(360,6);

		wait 6;
	}
}

map_effects()
{
	red_embers = getentarray("tnt_red_embers","targetname");
	purple_embers = getentarray("tnt_blue_fire","targetname");
	cyan_embers = getentarray("tnt_green_fire","targetname");

	red_fx = undefined;
	purple_fx = undefined;
	cyan_fx = undefined;

	for(i=0;i<red_embers.size;i++)
	{
		red_fx[i] = spawnfx(level.tnt_red_embers,red_embers[i].origin);
		triggerfx(red_fx[i]);
	}

	for(i=0;i<purple_embers.size;i++)
	{
		purple_fx[i] = spawnfx(level.tnt_purple_embers,purple_embers[i].origin);
		triggerfx(purple_fx[i]);
	}

	for(i=0;i<cyan_embers.size;i++)
	{
		cyan_fx[i] = spawnfx(level.tnt_cyan_embers,cyan_embers[i].origin);
		triggerfx(cyan_fx[i]);
	}
}

tnt_endmap()
{
	trig = getent("tnt_endmap","targetname");
	targ = getent("tnt_endmap_origin","targetname");

	while(1)
	{
		trig waittill("trigger",who);

		if(!isdefined(trig))
			return;

		 // ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(who))
			continue;
		// =====================================

		if(!isdefined(level.tnt_endmap_first))
		{
			level.tnt_endmap_first = true;
			iprintlnbold("^5"+who.name+"^7 has finished ^2"+getdvar("mapname")+" ^7First!");
			//who braxi\_rank::giverankxp(undefined,150);
		}

		who thread tnt_secret_tp(targ);
		who takeallweapons();

		while(isalive(who) && isdefined(who))
			wait 1;

		iprintlnbold("^5"+who.name+"^7 has been killed.");
	}
}

welcomecucc()
{
	wait 2;
	thread welcomecuc(getdvar("mapname"));
	wait 6;
	thread welcomecuc("Map & Script - VC' Blade" );
	wait 6;
	thread welcomecuc("Design & Textures - VC' Niko" );
}

welcomecuc(text)
{
	welcomehud = new_hud( "center", 0.1, 1000, 100 );
	welcomehud setText( text );
	welcomehud moveOverTime( 2 );
	welcomehud.x = 0;
	wait( 4 );
	welcomehud moveOverTime( 2 );
	welcomehud.x = 1000 * -1;
	wait 1;
	welcomehud destroy();
}

new_hud( align, fade_in_time, x_off, y_off )
{
	welcomehud2 = newHudElem();
    welcomehud2.foreground = true;
	welcomehud2.x = x_off;
	welcomehud2.y = y_off;
	welcomehud2.alignX = align;
	welcomehud2.alignY = "middle";
	welcomehud2.horzAlign = align;
	welcomehud2.vertAlign = "middle";
 	welcomehud2.fontScale = 2;
	welcomehud2.color = (1, 1, 1);
	welcomehud2.font = "objective";
	welcomehud2.glowColor = (0, 0.5, 1);
	welcomehud2.glowAlpha = 1;
	welcomehud2.alpha = 0;
	welcomehud2 fadeovertime( fade_in_time );
	welcomehud2.alpha = 1;
	welcomehud2.hidewheninmenu = true;
	welcomehud2.sort = 10;
	return welcomehud2;
}


trap_traps()
{
	thread trap_trap1();
	thread trap_trap2();
	thread trap_trap3();
	thread trap_trap4();
	thread trap_trap5();
	thread trap_trap6();
	thread trap_trap7();

	addTriggerToList( "trap_trap1_trig" );
	addTriggerToList( "trap_trap2_trig" );
	addTriggerToList( "trap_trap3_trig" );
	addTriggerToList( "trap_trap4_trig" );
	addTriggerToList( "trap_trap5_trig" );
	addTriggerToList( "trap_trap6_trig" );
	addTriggerToList( "trap_trap7_trig" );
}

trap_trap1()
{
	trig = getEnt("trap_trap1_trig", "targetname");
	trap = getEnt("trap_trap1", "targetname");

	trig setHintString("Press [^5&&1^7] to activate ^5Trap 1");
	trig waittill("trigger");
	trig delete();

	while(isdefined(trap))
	{
		trap rotatePitch(-360, 14);
		wait 1;
	}
}

trap_trap2()
{
	trig = getEnt("trap_trap2_trig", "targetname");
	trapa = getEnt("trap_trap2a", "targetname");
	trapb = getEnt("trap_trap2b", "targetname");

	trig setHintString("Press [^5&&1^7] to activate ^5Trap 2");
	trig waittill("trigger");
	trig delete();

	trapa movez(70, 1.5);	
	trapb movez(-70,1.5);

	wait 1.5;

	while(isdefined(trapa) && isdefined(trapb))
	{
		trapa movez(-140, 1.5);
		trapb movez(140,1.5);
		wait 1.5;
		trapa movez(140, 1.5);
		trapb movez(-140, 1.5);
		wait 1.5;
	}
}

trap_trap3()
{
	trig = getEnt("trap_trap3_trig", "targetname");
	trapa = getEnt("trap_trap3a", "targetname");
	trapb = getent("trap_trap3b","targetname");

	trig setHintString("Press [^5&&1^7] to activate ^5Trap 3");
	trig waittill("trigger");
	trig delete();

	trapa thread rotate_pitch();

	while(isdefined(trapb))
	{
		trapb rotateYaw(360, 3);
		wait 3;
	}
}

rotate_pitch()
{
	while(isdefined(self))
	{
		self rotateroll(-360, 3);
		wait 3;
	}
}

trap_trap4()
{
  	trig = getEnt("trap_trap4_trig", "targetname");
  	trapa = getEnt("trap_trap4a", "targetname");
 	trapb = getEnt("trap_trap4b", "targetname");
  
  	trig setHintString("Press [^5&&1^7] to activate ^5Trap 4");
	trig waittill("trigger");
	trig delete();

  	while(isdefined(trapa) && isdefined(trapb))
  	{
    	trapa rotatePitch(360,1.5);
		trapb rotatePitch(-360,1.5);
    	wait 1.5;
  	}
}

trap_trap5()
{
	trig = getEnt("trap_trap5_trig", "targetname");
	help = getent("trap_trap5_help","targetname");

	help notsolid();

	trig setHintString("Press [^5&&1^7] to activate ^5Trap 5");
	trig waittill("trigger");
	trig delete();

	iPrintLnBold("Hahaha, scared? It's just a fake.");
}

trap_trap6()
{
	trig = getEnt("trap_trap6_trig", "targetname");
	trap = getEnt("trap_trap6", "targetname");

	trig setHintString("Press [^5&&1^7] to activate ^5Trap 6");
	trig waittill("trigger");
	trig delete();

	while(isdefined(trap))
	{
		trap rotateYaw(360, 2);
		wait 2;
	}
}

trap_trap7()
{
	trig = getEnt("trap_trap7_trig", "targetname");
	trap = getEnt("trap_trap7", "targetname");

	trap thread move_trap7();

	trig setHintString("Press [^5&&1^7] to activate ^5Trap 7");
	trig waittill("trigger");
	trig delete();

	if(isdefined(trap))
	{
		trap notsolid();
		wait 5;
		trap solid();
	}
}

move_trap7()
{
	while(isdefined(self))
	{
		self movey(-464,5);
		wait 5;
		self movey(464,5);
		wait 5;
	}
}


trance_traps()
{
	thread trance_trap1();
	thread trance_trap2();
	thread trance_trap3();
	thread trance_trap4();
	thread trance_trap5();
	thread trance_trap6();

	addTriggerToList( "trance_trap1_trig" );
	addTriggerToList( "trance_trap2_trig" );
	addTriggerToList( "trance_trap3_trig" );
	addTriggerToList( "trance_trap4_trig" );
	addTriggerToList( "trance_trap5_trig" );
	addTriggerToList( "trance_trap6_trig" );
}

trance_trap1()
{
	trig = getEnt("trance_trap1_trig", "targetname");
	trap = getEnt("trance_trap1", "targetname");

	trig setHintString("Press [^2&&1^7] to activate ^2Trap 1");
	trig waittill("trigger");
	trig delete();

	trap hide();
	trap notsolid();

	wait 5;

	trap show();
	trap solid();
}

trance_trap2()
{
	trig = getEnt("trance_trap2_trig", "targetname");
	move = getent("trance_trap2_move","targetname");
	trapa = getEnt("trance_trap2a", "targetname");
	trapb = getEnt("trance_trap2b", "targetname");

	move thread move_trap2();

	trig setHintString("Press [^2&&1^7] to activate ^2Trap 2");
	trig waittill("trigger");
	trig delete();

	while(1)
	{
		trapa moveZ(-150, 0.5);
		trapb moveZ(150, 0.5);
		wait 1;
		trapa moveZ(150, 0.5);
		trapb moveZ(-150, 0.5);
		wait 1;
	}
}

move_trap2()
{
	while(isdefined(self))
	{
		self movey(-1440,5);
		wait 5;
		self movey(1440,5);
		wait 5;
	}
}

trance_trap3()
{
	trig = getEnt("trance_trap3_trig", "targetname");
	trapa = getEnt("trance_trap3a", "targetname");
	trapb = getEnt("trance_trap3b", "targetname");
	trapc = getEnt("trance_trap3c", "targetname");

	trig setHintString("Press [^2&&1^7] to activate ^2Trap 3");
	trig waittill("trigger");
	trig delete();

	trapb rotateYaw(90, 1);
	trapc rotateRoll(-30, 1);

	while(isdefined(trapa))
	{
		trapa moveZ(-200, 2);
		wait 2;
		trapa moveZ(200, 2);
		wait 2;
	}
}

trance_trap4()
{
	trig = getEnt("trance_trap4_trig", "targetname");
	trap = getEnt("trance_trap4", "targetname");

	trig setHintString("Press [^2&&1^7] to activate ^2Trap 4");
	trig waittill("trigger");
	trig delete();

	while(isdefined(trap))
	{
		trap moveZ(-256, 0.2);
		wait 3;
		trap moveZ(256, 1);
		wait 3;
	}
}

trance_trap5()
{
	trig = getEnt("trance_trap5_trig", "targetname");
	trap = getEnt("trance_trap5", "targetname");

	trig setHintString("Press [^2&&1^7] to activate ^2Trap 5");
	trig waittill("trigger");
	trig delete();

	while(isdefined(trap))
	{
		trap rotatePitch(360, 14);
		wait 1;
	}
}

trance_trap6()
{
	trig = getEnt("trance_trap6_trig", "targetname");
	trap = getEnt("trance_trap6", "targetname");

	trig setHintString("Press [^2&&1^7] to activate ^2Trap 6");
	trig waittill("trigger");
	trig delete();

	trap hide();
	trap notsolid();

	wait 5;

	trap show();
	trap solid();
}

addTriggerToList(name)
{
    if(!isDefined(level.trapTriggers))
        level.trapTriggers = [];

    level.trapTriggers[level.trapTriggers.size] = getent(name,"targetname");
}

tnt_rooms()
{
	thread sniper_room();
	thread deagle_room();
	thread shotgun_room();
	thread knife_room();
	thread bounce_room();

	thread sniper_fail();
	thread bounce_fail();

	thread bounce_jump_weapon();
	thread bounce_acti_weapon();
}

sniper_room()
{
    level.sniper = getent("tnt_sniper_trig","targetname");
    jump = getent("sniper_jump","targetname");
    acti = getent("sniper_acti","targetname");

    level.sniper sethintstring("Press [^2&&1^7] to choose ^5Sniper ^7Endroom");

    while(1)
    {
        level.sniper waittill("trigger",player);

        if(!isdefined(level.sniper))
            return; 

        if(isdefined(level.activ))
        {
            player room_setup(jump,"m40a3_mp","remington700_mp","yes",1);
            level.activ room_setup(acti,"remington700_mp","m40a3_mp","yes",1);

            noti = SpawnStruct();
            noti.titleText = "Sniper Room";
            noti.notifyText = "^7"+level.activ.name+" ^1vs ^7"+player.name;
            noti.duration = 6;
            noti.glowcolor = (0, 1, 1);
            players = getEntArray("player", "classname");
            for(i=0;i<players.size;i++)
            	players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
 
            wait 5;

            iPrintLnBold("^1>> ^7Fight! ^1<<");
            player freezecontrols(0);
            level.activ freezecontrols(0);
        }
        else 
        {
            player room_setup(jump,"m40a3_mp","remington700_mp","yes",1);
            wait 5;
            player freezecontrols(0);
        }

        while(isAlive(player) && isDefined(player))
            wait 1;
    }
}

deagle_room()
{
    level.deagle = getent("tnt_deagle_trig","targetname");
    jump = getent("deagle_jump","targetname");
    acti = getent("deagle_acti","targetname");

    level.deagle sethintstring("Press [^2&&1^7] to choose ^5Deagle ^7Endroom");

    while(1)
    {
        level.deagle waittill("trigger",player);

        if(!isdefined(level.deagle))
            return; 

        if(isdefined(level.activ))
        {
            player room_setup(jump,"deserteagle_mp",undefined,"yes",1);
            level.activ room_setup(acti,"deserteaglegold_mp",undefined,"yes",1);

            noti = SpawnStruct();
            noti.titleText = "Deagle Room";
            noti.notifyText = "^7"+level.activ.name+" ^1vs ^7"+player.name;
            noti.duration = 6;
            noti.glowcolor = (1, 0, 1);
            players = getEntArray("player", "classname");
            for(i=0;i<players.size;i++)
            	players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
 
            wait 5;

            iPrintLnBold("^1>> ^7Fight! ^1<<");
            player freezecontrols(0);
            level.activ freezecontrols(0);
        }
        else 
        {
            player room_setup(jump,"deserteagle_mp",undefined,"yes",1);
            wait 5;
            player freezecontrols(0);
        }

        while(isAlive(player) && isDefined(player))
            wait 1;
    }
}

shotgun_room()
{
    level.shotgun = getent("tnt_shotgun_trig","targetname");
    jump = getent("shotgun_jump","targetname");
    acti = getent("shotgun_acti","targetname");

    level.shotgun sethintstring("Press [^2&&1^7] to choose ^5Shotgun ^7Endroom");

    while(1)
    {
        level.shotgun waittill("trigger",player);

        if(!isdefined(level.shotgun))
            return; 

        if(isdefined(level.activ))
        {
            player room_setup(jump,"winchester1200_mp",undefined,"yes",1);
            level.activ room_setup(acti,"winchester1200_mp",undefined,"yes",1);

            noti = SpawnStruct();
            noti.titleText = "Shotgun Room";
            noti.notifyText = "^7"+level.activ.name+" ^1vs ^7"+player.name;
            noti.duration = 6;
            noti.glowcolor = (0, 0, 1);
            players = getEntArray("player", "classname");
            for(i=0;i<players.size;i++)
            	players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
 
            wait 5;

            iPrintLnBold("^1>> ^7Fight! ^1<<");
            player freezecontrols(0);
            level.activ freezecontrols(0);
        }
        else 
        {
            player room_setup(jump,"winchester1200_mp",undefined,"yes",1);
            wait 5;
            player freezecontrols(0);
        }

        while(isAlive(player) && isDefined(player))
            wait 1;
    }
}

knife_room()
{
    level.knife = getent("tnt_knife_trig","targetname");
    jump = getent("deagle_jump","targetname");
    acti = getent("deagle_acti","targetname");

    level.knife sethintstring("Press [^2&&1^7] to choose ^5Knife ^7Endroom");

    while(1)
    {
        level.knife waittill("trigger",player);

        if(!isdefined(level.knife))
            return; 

        if(isdefined(level.activ))
        {
            player room_setup(jump,"knife_mp",undefined,"yes",1);
            level.activ room_setup(acti,"knife_mp",undefined,"yes",1);

            noti = SpawnStruct();
            noti.titleText = "Knife Room";
            noti.notifyText = level.activ.name + " ^1VS^7 " + player.name;
            noti.duration = 6;
            noti.glowcolor = (1, 0, 1);
            players = getEntArray("player", "classname");
            for(i=0;i<players.size;i++)
            	players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
 
            wait 5;

            iPrintLnBold("^1>> ^7Fight! ^1<<");
            player freezecontrols(0);
            level.activ freezecontrols(0);
        }
        else 
        {
            player room_setup(jump,"knife_mp",undefined,"yes",1);
            wait 5;
            player freezecontrols(0);
        }

        while(isAlive(player) && isDefined(player))
            wait 1;
    }
}

bounce_room()
{
    level.bounce = getent("tnt_bounce_trig","targetname");
    jump = getent("bounce_jump","targetname");
    acti = getent("bounce_acti","targetname");

    level.bounce sethintstring("Press [^2&&1^7] to choose ^5Bounce ^7Endroom");

    while(1)
    {
        level.bounce waittill("trigger",player);

        if(!isdefined(level.bounce))
            return; 

        if(isdefined(level.activ))
        {
            player room_setup(jump,"knife_mp",undefined,"yes",1);
            level.activ room_setup(acti,"knife_mp",undefined,"yes",1);

            noti = SpawnStruct();
            noti.titleText = "Bouce Room";
            noti.notifyText = level.activ.name + " ^1VS^7 " + player.name;
            noti.duration = 6;
            noti.glowcolor = (0.4, 0.4, 1);
            players = getEntArray("player", "classname");
            for(i=0;i<players.size;i++)
            	players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
 
            wait 5;

            iPrintLnBold("^1>> ^7Fight! ^1<<");
            player freezecontrols(0);
            level.activ freezecontrols(0);
        }
        else 
        {
            player room_setup(jump,"knife_mp",undefined,"yes",1);
            wait 5;
            player freezecontrols(0);
        }

        while(isAlive(player) && isDefined(player))
            wait 1;
    }
}

sniper_fail()
{
    trig = getent("tnt_sniper_fail","targetname");
    acti = getent("sniper_acti","targetname");
    jump = getent("sniper_jump","targetname");
    for(;;)
    {
        trig waittill("trigger",who);
        if(who.pers["team"] != "spectator")
        {
            if(who.pers["team"] == "allies")
            {
                who setorigin(jump.origin);
                who setplayerangles(jump.angles);
            }
            else 
            {
                who setorigin(acti.origin);
                who setplayerangles(acti.angles);
            }
        }
    }
}

bounce_fail()
{
    trig = getent("tnt_bounce_fail","targetname");
    acti = getent("bounce_acti","targetname");
    jump = getent("bounce_jump","targetname");
    for(;;)
    {
        trig waittill("trigger",who);
        if(who.pers["team"] != "spectator")
        {
            if(who.pers["team"] == "allies")
            {
                who setorigin(jump.origin);
                who setplayerangles(jump.angles);
            }
            else 
            {
                who setorigin(acti.origin);
                who setplayerangles(acti.angles);
            }
        }
    }
}

bounce_jump_weapon()
{
	trig = getent("bounce_jump_weap","targetname");
	logo = getent("bounce_jump_logo","targetname");

	logo thread rotate_logo();
	playfx(level.tnt_red_light,(3568,288,-1000));

	for(;;)
	{
		trig sethintstring("Press [^2&&1^7] to equip ^5M40A3");
		trig waittill("trigger",who);

		who giveweapon("m40a3_mp");
		who switchtoweapon("m40a3_mp");
		who givemaxammo("m40a3_mp");

		trig sethintstring("... ^1pending^7 ...");
		wait 5;
	}
}

bounce_acti_weapon()
{
	trig = getent("bounce_acti_weap","targetname");
	logo = getent("bounce_acti_logo","targetname");

	logo thread rotate_logo();
	playfx(level.tnt_red_light,(2464,-1824,-1000));

	for(;;)
	{
		trig sethintstring("Press [^2&&1^7] to equip ^5M40A3");
		trig waittill("trigger",who);

		who giveweapon("m40a3_mp");
		who switchtoweapon("m40a3_mp");
		who givemaxammo("m40a3_mp");

		trig sethintstring("... ^1pending^7 ...");
		wait 5;
	}
}

room_setup(targ,weap,weap2,health,freeze)
{
    self setorigin(targ.origin);
    self setplayerangles(targ.angles);

    self takeallweapons();
    self giveweapon(weap);
    self switchtoweapon(weap);
    self givemaxammo(weap);

    if(isdefined(weap2))
    {
        self giveweapon(weap2);
        self givemaxammo(weap2);
    }

    self freezecontrols(freeze);

    if( health == "yes")
    {
        if(self.health < self.maxhealth)
            self.health=self.maxhealth;
    }
}

tnt_secret()
{
	thread tnt_secret_open();
	thread tnt_secret_exit();
}

tnt_secret_open()
{
	triga = getent("tnt_secret_open1","targetname");
	trigb = getent("tnt_secret_open2","targetname");
	logo = getent("tnt_secret_logo","targetname");
	fx = getent("tnt_secret_fx","targetname");

	triga waittill("trigger");
	iprintln("^1MAN");
	triga delete();

	trigb waittill("trigger");
	iprintln("^2GO");
	trigb delete();

	wait 2;
	rot_logo = spawn("script_model",logo.origin);
	rot_logo setmodel("vistic_logo");
	rot_logo thread rotate_logo();

	wait 2;
	rot_logo movez(-240,5);
	wait 6;

	playfx(level.tnt_red_light,fx.origin);
	thread tnt_secret_enter();
}

rotate_logo()
{
	while(isdefined(self))
	{
		self rotateyaw(360,8);
		wait 8;
	}
}

tnt_secret_enter()
{
	trig = getent("tnt_secret_enter","targetname");
	targ = getent("tnt_secret_enter_targ","targetname");

	for(;;)
	{
		trig waittill("trigger",who);
		who thread tnt_secret_tp(targ);
	}
}

tnt_secret_exit()
{
	trig = getent("tnt_secret_end","targetname");
	targ = getent("tnt_secret_endorigin","targetname");
	fx = getent("secret_end_fx","targetname");
	logo = getent("tnt_secret_endlogo","targetname");

	logo thread rotate_logo();
	playfx(level.tnt_red_light,fx.origin);

	for(;;)
	{
		trig waittill("trigger",who);
		who thread tnt_secret_tp(targ);
	}
}

tnt_secret_tp(orig)
{
	self freezecontrols(1);
	self setorigin(orig.origin);
	self setplayerangles(orig.angles);
	wait 1;
	self freezecontrols(0);
}

addQueueTrigger(name)
    {
        if(!isdefined(level.queue_triggers))
            level.queue_triggers = [];

        level.queue_triggers[level.queue_triggers.size] = getent(name,"targetname");
    }