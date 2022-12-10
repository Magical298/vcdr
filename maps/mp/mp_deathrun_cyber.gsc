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
  _   ________   ___  __        __   
 | | / / ___( ) / _ )/ /__ ____/ /__ 
 | |/ / /__ |/ / _  / / _ `/ _  / -_)
 |___/\___/   /____/_/\_,_/\_,_/\__/ 

 © VC' Blade

*/

main()
{
	maps\mp\_load::main();

	game["allies"] = "sas";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "woodland";
	game["axis_soldiertype"] = "woodland";

	setdvar( "r_specularcolorscale", "1" );
  	setdvar("r_glowbloomintensity0",".25");
  	setdvar("r_glowbloomintensity1",".25");
  	setdvar("r_glowskybleedintensity0",".3");
  	setDvar( "compassmaxrange", "1024" );

	level.trap2=getent("trap2","targetname");
		level.trap2 hide();
		level.trap2 notsolid();

	level.secret_b=getent("secret_b","targetname");
		level.secret_b hide();
		level.secret_b notsolid();

	level.blink=loadfx("halloween/halloween_2");
	level.laser_center = LoadFX("shiet/laser_center");
	level.magic_orbs = LoadFx("shiet/magic_orbs");
	level.orb_center = LoadFX("shiet/orb_center");
	level.orb_explosion = LoadFX("shiet/orb_explosion");
	level.fireball_incomming = LoadFX("shiet/fire_incomming");
	level.fireball_impact = LoadFX("shiet/fire_impact");
	level.fire_blue = LoadFX("shiet/fire_blue");
	level.flys=loadfx("vistic/flys_bunt");

	level.m_1=false;
	level.m_2=false;
	level.secret=false;
	level.steps=0;
	level.song1 = "3LAU - How You Love Me feat. Bright Lights";
	level.song2 = "Ran-D - Living for the Moment";

	thread startdoor();
	thread music_1();
	thread music_2();

	thread firstTeleport();
	thread secondTeleport();
	thread ActiFirstTeleport();
	thread ActisecondTeleport();
	thread mapMove();

	thread stepsCheck();
	thread secret();
	thread secretEndTeleport();

	thread trap1();
	thread trap2();
	thread trap3();
	thread trap4();
	thread trap5();
	thread trap6();
	thread trap7();
	thread trap8();

	thread fx();
	thread sniper();
	thread knife();
	thread jump();
	thread antifail();

	thread mapCredits();
}

mapCredits()
{
	level waittill("round_started");
	wait 4;
	thread drawInformation(800,0.8, 1, "Deathrun Cyber");
	wait 4;
	thread drawInformation(800,0.8, 1, "Made by VC' Blade");
	wait 4;
	thread drawInformation(800,0.8, -1, "Visit: vistic-clan.com");
}

drawInformation( start_offset, movetime, mult, text )
{
	start_offset *= mult;
	hud = new_ending_hud( "center", 0.1, start_offset, 90 );
	hud setText( text );
	hud moveOverTime( movetime );
	hud.x = 0;
	wait( movetime );
	wait( 3 );
	hud moveOverTime( movetime );
	hud.x = start_offset * -1;

	wait movetime;
	hud destroy();
}

new_ending_hud( align, fade_in_time, x_off, y_off )
{
	hud = newHudElem();
    hud.foreground = true;
	hud.x = x_off;
	hud.y = y_off;
	hud.alignX = align;
	hud.alignY = "middle";
	hud.horzAlign = align;
	hud.vertAlign = "middle";
 	hud.fontScale = 2;
	hud.color = (1,1,1);
	hud.font = "objective";
	hud.glowColor = (0,1,0);
	hud.glowAlpha = 1;
	hud.alpha = 0;
	hud fadeovertime( fade_in_time );
	hud.alpha = 1;
	hud.hidewheninmenu = true;
	hud.sort = 10;
	return hud;
}

startdoor()
{
	door=getent("start_trig","targetname");
	dooor=getent("startdoor","targetname");
	door sethintstring("Press [^1Use^7] to open the ^1Door");

	for(;;)
	{
		door waittill("trigger");
		if(level.m_1==false && level.m_2==false)
		{
			iprintlnbold("A ^1Song ^7is required to start the ^1Map");
		}
		else if(level.m_1==true && level.m_2==false)
		{
			door delete();
			iprintlnbold("^1Map ^7is starting the song^1 "+level.song1+"^7 now.");
			wait 5;
			ambientplay("cyber01");
			dooor delete();
		}
		else if(level.m_1==false && level.m_2==true)
		{
			door delete();
			iprintlnbold("^1Map ^7is starting the song^1 "+level.song2+"^7 now.");
			wait 5;
			ambientplay("cyber02");
			dooor delete();
		}
	}
}

music_1()
{
	level.music_1=getent("music_1","targetname");
	level.music_1 sethintstring(level.song1);
	level.music_1 waittill("trigger");

	level.music_1 delete();
	level.music_2 delete();

	level.m_1=true;
	level.m_2=false;
}

music_2()
{
	level.music_2=getent("music_2","targetname");
	level.music_2 sethintstring(level.song2);
	level.music_2 waittill("trigger");

	level.music_1 delete();
	level.music_2 delete();

	level.m_1=false;
	level.m_2=true;
}

firstTeleport()
{
	trig = getEnt("cyber_tp_1","targetname");
	targ = getEnt("cyber_tg_1","targetname");
	
	while(1)
	{
		trig waittill ("trigger", player);
		
		player freezecontrols(1);
		wait 1;
		player setorigin(targ.origin);
		player setplayerangles(targ.angles);
		player freezecontrols(0);
	}
}

secondTeleport()
{
	trig = getEnt("cyber_tp_2","targetname");
	targ = getEnt("cyber_tg_2","targetname");
	
	while(1)
	{
		trig waittill ("trigger", player);
		
		player freezecontrols(1);
		wait 1;
		player setorigin(targ.origin);
		player setplayerangles(targ.angles);
		player freezecontrols(0);
	}
}

ActiFirstTeleport()
{
	trig = getEnt("acti_tp01","targetname");
	targ = getEnt("acti_tg01","targetname");
	
	while(1)
	{
		trig waittill ("trigger", player);
		
		player setorigin(targ.origin);
		player setplayerangles(targ.angles);
	}
}

ActisecondTeleport()
{
	trig = getEnt("acti_tp02","targetname");
	targ = getEnt("acti_tg02","targetname");
	
	while(1)
	{
		trig waittill ("trigger", player);
		
		player setorigin(targ.origin);
		player setplayerangles(targ.angles);
	}
}

mapMove()
{
	trig = getEnt("cyber_move_1","targetname");
	
	while(1)
	{
		trig movex(630,3);
		wait 5;
		trig movex(-630,3);
		wait 5;
	}
}

trap1()
{
	trig=getent("trig_1","targetname");
	trig sethintstring("Press [^1Use^7] to activate");
	setdvar("trap_1","0");
	for(;;)
	{
		trig waittill("trigger",p);
		if(!level.trapsdisabled)
		{
			if(getdvar("trap_1")!="1")
			{
				thread trap1_funktion();
				p braxi\_rank::giverankxp(undefined,20);
				setdvar("trap_1","1");
			}
			else if(getdvar("trap_1")=="1")
			{
				p iprintlnbold("Trap has already been used.");
				trig delete();
			}
		}
		else
		{
			iprintlnbold("^1"+p.name+"^7 tried to activate in Free Run");
			trig delete();
		}
	}
}
trap1_funktion()
{
	del=getent("trap1_del","targetname");
	a=getent("trap1a","targetname");
	b=getent("trap1b","targetname");

	del delete();
	vc=randomint(5);
	if(vc==3||vc==1||vc==4)
		a notsolid();
	else
		b notsolid();
}

trap2()
{
	trig=getent("trig_2","targetname");
	trig sethintstring("Press [^1Use^7] to activate");
	setdvar("trap_2","0");
	for(;;)
	{
		trig waittill("trigger",p);
		if(!level.trapsdisabled)
		{
			if(getdvar("trap_2")!="1")
			{
				thread trap2_funktion();
				p braxi\_rank::giverankxp(undefined,20);
				setdvar("trap_2","1");
			}
			else if(getdvar("trap_2")=="1")
			{
				p iprintlnbold("Trap has already been used.");
				trig delete();
			}
		}
		else
		{
			iprintlnbold("^1"+p.name+"^7 tried to activate in Free Run");
			trig delete();
		}
	}
}
trap2_funktion()
{
	level.trap2 solid();
	level.trap2 show();
	level.trap2 movez(-2000,3);
	wait 4;
	level.trap2 delete();
}

trap3()
{
	trig=getent("trig_3","targetname");
	trig sethintstring("Press [^1Use^7] to activate");
	setdvar("trap_3","0");
	for(;;)
	{
		trig waittill("trigger",p);
		if(!level.trapsdisabled)
		{
			if(getdvar("trap_3")!="1")
			{
				thread trap3_funktion();
				p braxi\_rank::giverankxp(undefined,20);
				setdvar("trap_3","1");
			}
			else if(getdvar("trap_3")=="1")
			{
				p iprintlnbold("Trap has already been used.");
				trig delete();
			}
		}
		else
		{
			iprintlnbold("^1"+p.name+"^7 tried to activate in Free Run");
			trig delete();
		}
	}
}
trap3_funktion()
{
	del=getent("trap3_del","targetname");
	a=getent("trap3","targetname");

	del delete();
	while(1)
	{
		a rotateyaw(360,5);
		wait 5;
	}
}

trap4()
{
	trig=getent("trig_4","targetname");
	trig sethintstring("Press [^1Use^7] to activate");
	setdvar("trap_4","0");
	for(;;)
	{
		trig waittill("trigger",p);
		if(!level.trapsdisabled)
		{
			if(getdvar("trap_4")!="1")
			{
				thread trap4_funktion();
				p braxi\_rank::giverankxp(undefined,20);
				setdvar("trap_4","1");
			}
			else if(getdvar("trap_4")=="1")
			{
				p iprintlnbold("Trap has already been used.");
				trig delete();
			}
		}
		else
		{
			iprintlnbold("^1"+p.name+"^7 tried to activate in Free Run");
			trig delete();
		}
	}
}
trap4_funktion()
{
	a=getent("trap4a","targetname");
	b=getent("trap4b","targetname");

	h=getent("trap4a_hurt","targetname");
	k=getent("trap4b_hurt","targetname");

	h enablelinkto();
	k enablelinkto();

	h linkto(a);
	k linkto(b);

	while(1)
	{
		a movez(80,2);
		wait 2;
		a movex(970,6);
		wait 6;
		a movex(-970,6);
		wait 6;
		a movez(-80,2);
		wait 2;
		b movez(70,2);
		wait 2;
		b movex(-970,6);
		wait 6;
		b movex(970,6);
		wait 6;
		b movez(-70,2);
		wait 2;
	}
}

trap5()
{
	trig=getent("trig_5","targetname");
	trig sethintstring("Press [^1Use^7] to activate");
	setdvar("trap_5","0");
	for(;;)
	{
		trig waittill("trigger",p);
		if(!level.trapsdisabled)
		{
			if(getdvar("trap_5")!="1")
			{
				thread trap5_funktion();
				p braxi\_rank::giverankxp(undefined,20);
				setdvar("trap_5","1");
			}
			else if(getdvar("trap_5")=="1")
			{
				p iprintlnbold("Trap has already been used.");
				trig delete();
			}
		}
		else
		{
			iprintlnbold("^1"+p.name+"^7 tried to activate in Free Run");
			trig delete();
		}
	}
}
trap5_funktion()
{
	a=getent("trap5a","targetname");
	b=getent("trap5b","targetname");

	while(1)
	{
		a rotateroll(360,4);
		wait 6;
		b rotateroll(-360,4);
		wait 6;
	}
}

trap6()
{
	trig=getent("trig_6","targetname");
	trig sethintstring("Press [^1Use^7] to activate");
	setdvar("trap_6","0");
	for(;;)
	{
		trig waittill("trigger",p);
		if(!level.trapsdisabled)
		{
			if(getdvar("trap_6")!="1")
			{
				thread trap6_funktion();
				p braxi\_rank::giverankxp(undefined,20);
				setdvar("trap_6","1");
			}
			else if(getdvar("trap_6")=="1")
			{
				p iprintlnbold("Trap has already been used.");
				trig delete();
			}
		}
		else
		{
			iprintlnbold("^1"+p.name+"^7 tried to activate in Free Run");
			trig delete();
		}
	}
}
trap6_funktion()
{
	a=getent("trap6","targetname");

	while(1)
	{
		a rotateroll(360,6);
		wait 6;
	}
}

trap7()
{
	trig=getent("trig_7","targetname");
	trig sethintstring("Press [^1Use^7] to activate");
	setdvar("trap_7","0");
	for(;;)
	{
		trig waittill("trigger",p);
		if(!level.trapsdisabled)
		{
			if(getdvar("trap_7")!="1")
			{
				thread trap7_funktion();
				p braxi\_rank::giverankxp(undefined,20);
				setdvar("trap_7","1");
			}
			else if(getdvar("trap_7")=="1")
			{
				p iprintlnbold("Trap has already been used.");
				trig delete();
			}
		}
		else
		{
			iprintlnbold("^1"+p.name+"^7 tried to activate in Free Run");
			trig delete();
		}
	}
}
trap7_funktion()
{
	a=getent("trap7a","targetname");
	b=getent("trap7b","targetname");

	while(1)
	{
		a rotateyaw(360,5);
		b rotateyaw(-360,5);
		wait 5;
	}
}

trap8()
{
	trig=getent("trig_8","targetname");
	trig sethintstring("Press [^1Use^7] to activate");
	setdvar("trap_8","0");
	for(;;)
	{
		trig waittill("trigger",p);
		if(!level.trapsdisabled)
		{
			if(getdvar("trap_8")!="1")
			{
				thread trap8_funktion();
				p braxi\_rank::giverankxp(undefined,20);
				setdvar("trap_8","1");
			}
			else if(getdvar("trap_8")=="1")
			{
				p iprintlnbold("Trap has already been used.");
				trig delete();
			}
		}
		else
		{
			iprintlnbold("^1"+p.name+"^7 tried to activate in Free Run");
			trig delete();
		}
	}
}
trap8_funktion()
{
	a=getent("trap8","targetname");
	a delete();
}

secret()
{
	level.secret_trigs = [];
	i=0;
	level.secret_trigs[i]=getEnt("secret_1","targetname");	
	i++;
	level.secret_trigs[i]=getEnt("secret_2","targetname");	
	i++;
	level.secret_trigs[i]=getEnt("secret_3","targetname");	

	for(i=0;i<level.secret_trigs.size;i++)
	{
		level.secret_trigs[i] thread triggerMe(i);
	}
}

triggerMe(number)
{
	nmb=number+1;
	self waittill("trigger");
	self delete();
	iprintln("Secret Step ^1"+nmb+" ^7done.");
	level.steps++;
}

stepsCheck()
{
	while(level.steps<3)
	{
		wait 2;
		if(level.steps==3 && !level.secret)
		{
			iprintlnbold("Secret has been opened");
			thread secretTeleport();
			wait 1;
			level.secret=true;
		}
		else
		{
			//just in case
		}
	}
}

secretTeleport()
{
	trig=getent("secret_enter","targetname");
	targ=getent("secret_port","targetname");
	level.secret_b show();
	level.secret_b solid();

	while(1)
	{
		trig waittill ("trigger", player);
		
		player iprintlnbold("Teleport loading...");
		wait 1;
		player freezecontrols(1);
		player setorigin(targ.origin);
		player setplayerangles(targ.angles);
		player iprintlnbold("Successfully teleported");
		wait 3;
		player freezecontrols(0);
	}
}

secretEndTeleport()
{
	trig=getent("secret_finish","targetname");
	targ=getent("secret_end","targetname");

	while(1)
	{
		trig waittill ("trigger", player);
		
		player setorigin(targ.origin);
		player setplayerangles(targ.angles);
		iprintlnbold("^1"+player.name+"^7 has finished the ^1Secret");
		player braxi\_rank::giverankxp(undefined,50);
	}
}

fx()
{
	cyber = getEntArray("blink_fx","targetname");
	while(1)
	{
		for(b=0;b<cyber.size;b++)
			playFx(level.blink,cyber[b].origin);
		wait .5;
	}
}

sniper()
{
	level.sniper=getent("sniper","targetname");
	acti=getent("acti_snip","targetname");
	jump=getent("jump_snip","targetname");
	clip=getent("snipe_clip","targetname");

	level.sniper setHintString("Press [^1Use^7] for Sniper Fight");
    while(1)
    {
    	level.sniper setHintString("Press [^1Use^7] for Sniper Fight");
        level.sniper waittill("trigger",player);
        if(!isDefined(level.sniper))
            return; 

		// ====== Part for Queue Plugin ========
        if(!plugins\_queue::checkQueueRoom(player))
            continue;
	    // =====================================

        if(level.first==true)
		{
			level.first=false;
			level.knife delete();
			level.jump delete();
		}

		player SetPlayerAngles( jump.angles );
        player setOrigin( jump.origin );
        level.activ setPlayerangles( acti.angles );
        level.activ setOrigin( acti.origin );
		player takeallweapons();
        level.activ takeallweapons();
        player setroomgun("remington700_mp");
        level.activ setroomgun("remington700_mp");
        
        if(getTeamPlayersAlive("allies")<2)
		{
			level.room_time=20;
			thread last_jump_snipe();
			thread roomcountdown();
		}
		else
		{
			player FreezeControls(1);
			level.activ FreezeControls(1);
			level.room_time=5;
			thread roomcountdown();
		}

        wait level.room_time;
        clip delete();
		player FreezeControls(0);
		level.activ FreezeControls(0);

        while(isAlive(player)&&isDefined(player))
            wait 1;

        iprintlnbold("^1"+player.name+"^7 died.");
        iprintlnbold("^1Sniper^7 Teleport is ^1open^7 again.");
    }
}

knife()
{
	level.knife=getent("knife","targetname");
	acti=getent("acti_knife","targetname");
	jump=getent("jump_knife","targetname");
	level.knife setHintString("Press [^1Use^7] for Knife Fight");
    while(1)
    {
    	level.knife setHintString("Press [^1Use^7] for Knife Fight");
        level.knife waittill("trigger",player);
        if(!isDefined(level.knife))
            return; 

		// ====== Part for Queue Plugin ========
        if(!plugins\_queue::checkQueueRoom(player))
            continue;
	    // =====================================

        if(level.first==true)
		{
			level.first=false;
			level.sniper delete();
			level.jump delete();
		}

		player SetPlayerAngles( jump.angles );
        player setOrigin( jump.origin );
        level.activ setPlayerangles( acti.angles );
        level.activ setOrigin( acti.origin );
		player takeallweapons();
        level.activ takeallweapons();
        player setroomgun("knife_mp");
        level.activ setroomgun("knife_mp");
        
        if(getTeamPlayersAlive("allies")<2)
		{
			player FreezeControls(1);
			level.activ FreezeControls(1);
			level.room_time=10;
			thread last_jump_knife();
			thread roomcountdown();
		}
		else
		{
			player FreezeControls(1);
			level.activ FreezeControls(1);
			level.room_time=5;
			thread roomcountdown();
		}

        wait level.room_time;
		player FreezeControls(0);
		level.activ FreezeControls(0);

        while(isAlive(player)&&isDefined(player))
            wait 1;

        iprintlnbold("^1"+player.name+"^7 died.");
        iprintlnbold("^1Knife^7 Teleport is ^1open^7 again.");
    }
}

jump()
{
	level.jump=getent("jump","targetname");
	acti=getent("acti_jump","targetname");
	jump=getent("jump_jump","targetname");
	level.jump setHintString("Press [^1Use^7] for Jump Fight");
    while(1)
    {
    	level.jump setHintString("Press [^1Use^7] for Jump Fight");
        level.jump waittill("trigger",player);
        if(!isDefined(level.jump))
            return; 

		// ====== Part for Queue Plugin ========
        if(!plugins\_queue::checkQueueRoom(player))
            continue;
	    // =====================================

        if(level.first==true)
		{
			level.first=false;
			level.sniper delete();
			level.knife delete();
		}

		player SetPlayerAngles( jump.angles );
        player setOrigin( jump.origin );
        level.activ setPlayerangles( acti.angles );
        level.activ setOrigin( acti.origin );
		player takeallweapons();
        level.activ takeallweapons();
        player setroomgun("knife_mp");
        level.activ setroomgun("knife_mp");
        
        if(getTeamPlayersAlive("allies")<2)
		{
			player FreezeControls(1);
			level.activ FreezeControls(1);
			level.room_time=10;
			thread last_jump_jump();
			thread roomcountdown();
		}
		else
		{
			player FreezeControls(1);
			level.activ FreezeControls(1);
			level.room_time=5;
			thread roomcountdown();
		}

        wait level.room_time;
		player FreezeControls(0);
		level.activ FreezeControls(0);

        while(isAlive(player)&&isDefined(player))
            wait 1;

        iprintlnbold("^1"+player.name+"^7 died.");
        iprintlnbold("^1Jump^7 Teleport is ^1open^7 again.");
    }
}

setroomgun( gun )
{
	self takeallweapons();
	self giveweapon(gun);
	self switchtoweapon(gun);
}

roomcountdown()
{
	level.countdown = NewHudElem();
	level.countdown.alignX = "center";
	level.countdown.alignY = "middle";
	level.countdown.horzalign = "center";
	level.countdown.vertalign = "middle";
	level.countdown.alpha = 1;
	level.countdown.x = 0;
	level.countdown.y = 0;
	level.countdown.font = "default";
	level.countdown.fontscale = 2;
	level.countdown.glowalpha = 1;
	level.countdown.glowcolor = (1, 0.5, 0);
	level.countdown.label = &"Room starts in: ^1&&1";
    level.countdown settimer(level.room_time);
    wait level.room_time;
	level.countdown destroy();
}

last_jump_snipe()
{
	SetExpFog(128,768,0,0,0,3);

	center = (5184,-1536,32);
	ang = 0;
	fire_pos = undefined;
	fireball = undefined;
	
	for(i=0;i<5;i++)
	{
		fire_pos[i] = center+AnglesToForward( (0,ang,0) )*420;
		thread CreateFireball( fire_pos[i]+(0,0,300) );
		ang += 72;
		wait 1;
	}
	wait 1;
	fireball = getentarray("fireball", "targetname");
	for(i=0;i<fireball.size;i++)
	{
		trace = BulletTrace( fireball[i].origin, fireball[i].origin-(0,0,3000), false, fireball[i] );
		fireball[i] MoveTo( fireball[i].origin-(0,0,300), 1, 1, 0 );
	}
	wait 1;
	for(i=0;i<fireball.size;i++)
	{
		EarthQuake( 1, 1, fireball[i].origin, 700 );
		PlayFX( level.finalfight2_fireball_impact, fireball[i].origin );
		PlayFX( level._effect["fire_blue"], fireball[i].origin );
		fireball[i] delete();
	}
	wait 2;
	PlayFX( level.laser_center, (5184,-1536,32) );
	wait 1;
	
	orb = Spawn("script_model", (5184,-1536,32) );
	orb SetModel("tag_origin");
	wait 0.05;
	PlayFXOnTag( level.orb_center, orb, "tag_origin" );
	orb MoveZ( 600, 5, 1, 1 );
	
	wait 2;
	
	PlayFX( level.orb_explosion, orb.origin );
	EarthQuake( 1.5, 1.5, orb.origin, 1600 );
	orb delete();
	
	spawns = getentarray("mp_tdm_spawn", "classname");
	for(i=0;i<spawns.size;i++)
		PlayFX( level.fireball_impact, spawns[i].origin+(5184,-1536,32) );
}

CreateFireball( pos )
{
	fireball = spawn("script_model", pos );
	fireball SetModel("tag_origin");
	fireball.targetname = "fireball";
	wait 0.05;
	PlayFXOnTag( level.fireball_incomming, fireball, "tag_origin" );
}

last_jump_knife()
{
	SetExpFog(256,768,0,0,0,3);
	wait 9;
	PlayFX(level.flys,(5168,-5756,248));
	PlayFX(level.flys,(4944,-5980,248));
	PlayFX(level.flys,(5168,-6204,248));
	PlayFX(level.flys,(5392,-5980,248));
}

last_jump_jump()
{
	SetExpFog(256,768,0,0,0,3);
	wait 9;
}

antifail()
{
	acti = getEnt("acti_jump","targetname");
	jump = getEnt("jump_jump","targetname");
	trigger = getent("jump_fail","targetname");
	for(;;)
	{
		trigger waittill("trigger",player);
		if(player.pers["team"] != "spectator")
		{
			if(player.pers["team"] == "allies")
			{
				player SetPlayerAngles(jump.angles);
				player SetOrigin(jump.origin);
			}
			if(player.pers["team"] == "axis")
			{
				player SetPlayerAngles(acti.angles);
				player SetOrigin(acti.origin);
			}
		}
	}
}