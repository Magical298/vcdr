/*
	 _   ________   ___  __        __   
	| | / / ___( ) / _ )/ /__ ____/ /__ 
	| |/ / /__ |/ / _  / / _ `/ _  / -_)
	|___/\___/   /____/_/\_,_/\_,_/\__/ 

	� VC' Blade
	Website: vistic-clan.com

	Original Script by Jumpy

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

	precacheShader("mtl_plr_dnf_duke_body");
	precacheShader("mtl_plr_dnf_duke_glasses");
	precacheShader("mtl_plr_dnf_duke_glasses_lens");
	precacheShader("mtl_plr_dnf_duke_hand");
	precacheShader("mtl_plr_dnf_duke_head");
	precacheModel("playermodel_dnf_duke");

	setdvar("compassmaxrange","1800");
	setdvar("g_speed",240);

	thread traps();
	thread rooms();
	thread teleports();
	thread others();

	addTriggerToList( "trap1_trig" );
    addTriggerToList( "trap2_trig" );
    addTriggerToList( "trap3_trig" );
    addTriggerToList( "trap4_trig" );
    addTriggerToList( "trap5_trig" );
    addTriggerToList( "trap6_trig" );
    addTriggerToList( "trap7_trig" );
    addTriggerToList( "trap8_trig" );
    addTriggerToList( "trap9_trig" );
    addTriggerToList( "trap10_trig" );
    addTriggerToList( "spike_trig" );
}

addTriggerToList(name)
{
    if(!isDefined(level.trapTriggers))
        level.trapTriggers=[];
    level.trapTriggers[level.trapTriggers.size]=getEnt(name,"targetname");
}

traps()
{
	thread trap1();
	thread trap2();
	thread trap3();
	thread trap4();
	thread trap5();
	thread trap6();
	thread trap7();
	thread trap8();
	thread trap9();
	thread trap10();
	thread trap11();
}

trap1()
{
	trap=getent("trap1","targetname");
	trig=getent("trap1_trig","targetname");

	trig waittill("trigger");
	trig delete();

	while(1)
	{
		trap movez(-182,1);
		wait 3;
		trap movez(182,1);
		wait 3;
	}
}

trap2()
{
	trap=getent("trap2","targetname");
	trig=getent("trap2_trig","targetname");

	trig waittill("trigger");
	trig delete();

	trap notsolid();
}

trap3()
{
	trap=getent("trap3","targetname");
	trig=getent("trap3_trig","targetname");

	trig waittill("trigger");
	trig delete();

	trap movez(-344,1);
	wait 1;

	while(1)
	{
		trap rotateroll(360,1);
		wait 1;
	}
}

trap4()
{
	trapa=getent("trap4","targetname");
	trapb=getent("trap4_a","targetname");
	trig=getent("trap4_trig","targetname");

	trig waittill("trigger");
	trig delete();
	trapa delete();

	while(1)
	{
		trapb rotateyaw(360,3);
		wait 3;
		trapb rotateyaw(-360,3);
		wait 3;
	}
}

trap5()
{
	trap=getent("trap5","targetname");
	trig=getent("trap5_trig","targetname");

	trig waittill("trigger");
	trig delete();

	while(1)
	{
		trap movey(780,1);
		wait 1;
		trap movey(-780,1);
		wait 1;
	}
}

trap6()
{
	trap=getent("trap6","targetname");
	kill=getent("kill_trig","targetname");
	trig=getent("trap6_trig","targetname");

	trig waittill("trigger");
	trig delete();

	kill enablelinkto();
	kill linkto(trap);
	trap movez(248,2,2);
}

trap7()
{
	trap=getent("trap7","targetname");
	trig=getent("trap7_trig","targetname");

	trig waittill("trigger");
	trig delete();
	trap delete();
}

trap8()
{
	trap=getent("trap8","targetname");
	trig=getent("trap8_trig","targetname");

	trig waittill("trigger");
	trig delete();
	trap delete();
}

trap9()
{
	trapa=getent("trap9","targetname");
	trapb=getent("trap9_a","targetname");
	trapc=getent("trap9_b","targetname");
	trapd=getent("trap9_c","targetname");
	trig=getent("trap9_trig","targetname");

	trig waittill("trigger");
	trig delete();

	trapa movez(-120,3,3);
	wait 3;

	while(1)
	{
		trapb rotateyaw(360,0.5);
		wait 0.5;
		trapc rotateyaw(360,0.5);
		wait 0.5;
		trapd rotateyaw(360,0.5);
		wait 0.5;
	}
}

trap10()
{
	trap=getent("trap10","targetname");
	trig=getent("trap10_trig","targetname");

	trig waittill("trigger");
	trig delete();

	while(1)
	{
		trap movex(88,2);
		wait 2;
		trap movex(-88,2);
		wait 2;
	}
}

trap11()
{
	trap=getent("spike","targetname");
	kill=getent("killer_trig","targetname");
	trig=getent("spike_trig","targetname");

	trig waittill("trigger");
	trig delete();

	kill enablelinkto();
	kill linkto(trap);

	while(1)
	{
		trap movey(-465,2);
		wait 10;
		trap movey(465,2);
		wait 10;
	}
}

rooms()
{
	thread sniper();
	thread knife();
	thread jump();
	thread old();
	thread weapon();
}

sniper()
{
    level.sniper=getent("sniper_trig","targetname");
    jump=getent("sniper1","targetname");
    acti=getent("sniper2","targetname");
    level.firstenter=true;

    while(1)
    {
        level.sniper waittill("trigger",player);
        if(!isdefined(level.sniper))
            return;

		 // ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================

        if(level.firstenter==true)
        {
            level.firstenter = false;
            iprintlnbold("|^0"+player.name+"^3 has chosen ^0Sniper^7|");

            level.knife delete();
            level.old delete();
            level.jump delete();
            level.weapon delete();
        }

        if(isdefined(level.activ))
        {
            player freezecontrols(1);
            level.activ freezecontrols(1);
            player setorigin(jump.origin);
            level.activ setorigin(acti.origin);
            player setplayerangles(jump.angles);
            level.activ setplayerangles(acti.angles);
            player takeallweapons();
            level.activ takeallweapons();
            
            level.activ thread counterundsetup("m40a3_mp","remington700_mp",100);
            player thread counterundsetup("m40a3_mp","remington700_mp",100);
        }
        else
        {
            player freezecontrols(1);
            player setorigin(jump.origin);
            player setplayerangles(jump.angles);
            player takeallweapons();
            
            player thread counterundsetup("m40a3_mp","remington700_mp",100);
        }
        while(isalive(player)&&isdefined(player))
            wait 1;
    }
}

knife()
{
    level.knife=getent("knife_trig","targetname");
    jump=getent("knife1","targetname");
    acti=getent("knife2","targetname");
    level.firstenter=true;

    while(1)
    {
        level.knife waittill("trigger",player);
        if(!isdefined(level.knife))
            return;

		 // ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================

        if(level.firstenter==true)
        {
            level.firstenter = false;
            iprintlnbold("|^0"+player.name+"^3 has chosen ^0Knife^7|");

            level.sniper delete();
            level.old delete();
            level.jump delete();
            level.weapon delete();
        }

        if(isdefined(level.activ))
        {
            player freezecontrols(1);
            level.activ freezecontrols(1);
            player setorigin(jump.origin);
            level.activ setorigin(acti.origin);
            player setplayerangles(jump.angles);
            level.activ setplayerangles(acti.angles);
            player takeallweapons();
            level.activ takeallweapons();
            
            level.activ thread counterundsetup("knife_mp",undefined,100);
            player thread counterundsetup("knife_mp",undefined,100);
        }
        else
        {
            player freezecontrols(1);
            player setorigin(jump.origin);
            player setplayerangles(jump.angles);
            player takeallweapons();
            
            player thread counterundsetup("knife_mp",undefined,100);
        }
        while(isalive(player)&&isdefined(player))
            wait 1;
    }
}

old()
{
    level.old=getent("old_trig","targetname");
    jump=getent("old1","targetname");
    acti=getent("old2","targetname");
    level.firstenter=true;

    while(1)
    {
        level.old waittill("trigger",player);
        if(!isdefined(level.old))
            return;

		 // ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================

        if(level.firstenter==true)
        {
            level.firstenter = false;
            iprintlnbold("|^0"+player.name+"^3 has chosen ^0Old^7|");

            level.sniper delete();
            level.knife delete();
            level.jump delete();
            level.weapon delete();
        }

        if(isdefined(level.activ))
        {
            player setorigin(jump.origin);
            level.activ setorigin(acti.origin);
            player setplayerangles(jump.angles);
            level.activ setplayerangles(acti.angles);
        }
        else
        {
            player freezecontrols(1);
            player setorigin(jump.origin);
            player setplayerangles(jump.angles);
        }
        while(isalive(player)&&isdefined(player))
            wait 1;
    }
}

weapon()
{
    level.weapon=getent("weapon_trig","targetname");
    jump=getent("weapon1","targetname");
    acti=getent("weapon2","targetname");
    level.firstenter=true;

    while(1)
    {
        level.weapon waittill("trigger",player);
        if(!isdefined(level.weapon))
            return;

		 // ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================

        if(level.firstenter==true)
        {
            level.firstenter = false;
            iprintlnbold("|^0"+player.name+"^3 has chosen ^0Weapon^7|");

            level.sniper delete();
            level.old delete();
            level.jump delete();
            level.knife delete();
        }

        if(isdefined(level.activ))
        {
            player freezecontrols(1);
            level.activ freezecontrols(1);
            player setorigin(jump.origin);
            level.activ setorigin(acti.origin);
            player setplayerangles(jump.angles);
            level.activ setplayerangles(acti.angles);
            player takeallweapons();
            level.activ takeallweapons();
            
            level.activ thread counterundsetup("ak47_mp","deserteagle_mp",100);
            player thread counterundsetup("ak47_mp","deserteagle_mp",100);
        }
        else
        {
            player freezecontrols(1);
            player setorigin(jump.origin);
            player setplayerangles(jump.angles);
            player takeallweapons();
            
            player thread counterundsetup("ak47_mp","deserteagle_mp",100);
        }
        while(isalive(player)&&isdefined(player))
            wait 1;
    }
}

jump()
{
    level.jump=getent("jump_trig","targetname");
    jump=getent("jump1","targetname");
    acti=getent("jump2","targetname");
    level.firstenter=true;

    while(1)
    {
        level.jump waittill("trigger",player);
        if(!isdefined(level.jump))
            return;

		 // ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================

        if(level.firstenter==true)
        {
            level.firstenter = false;
            iprintlnbold("|^0"+player.name+"^3 has chosen ^0Jump^7|");

            level.sniper delete();
            level.old delete();
            level.weapon delete();
            level.knife delete();
        }

        if(isdefined(level.activ))
        {
            player freezecontrols(1);
            level.activ freezecontrols(1);
            player setorigin(jump.origin);
            level.activ setorigin(acti.origin);
            player setplayerangles(jump.angles);
            level.activ setplayerangles(acti.angles);
            player takeallweapons();
            level.activ takeallweapons();
            
            level.activ thread counterundsetup("knife_mp",undefined,100);
            player thread counterundsetup("knife_mp",undefined,100);
        }
        else
        {
            player freezecontrols(1);
            player setorigin(jump.origin);
            player setplayerangles(jump.angles);
            player takeallweapons();
            
            player thread counterundsetup("knife_mp",undefined,100);
        }
        while(isalive(player)&&isdefined(player))
            wait 1;
    }
}

counterundsetup(waffe,waffe2,leben)
{
	self.health=leben;
	self iprintln("|^0Health^3 restored^7|");

	self iprintlnbold("|^03^7|");
	wait 1;
	self iprintlnbold("|^02^7|");
	wait 1;
	self iprintlnbold("|^01^7|");
	wait 1;
	self iprintlnbold("|^0Fight^7|");


    if(isdefined(waffe))
    {
        self giveweapon(waffe);
        self givemaxammo(waffe);
    }
    if(isdefined(waffe))
    {
        self giveweapon(waffe2);
        self givemaxammo(waffe2);
    }
    self switchtoweapon(waffe);
    self freezecontrols(0);
}

teleports()
{
	thread wealth_room();
	thread back();
	thread jumpback();
	thread jumpback2();
	thread nortd();
	thread custom_rtd();
	thread unlucky();
	thread acti_teleport();
	thread acti_teleport2();
}

wealth_room()
{
	trig=getent("wealth_trig","targetname");
	targ=getent("wealth_origin","targetname");

	trig waittill("trigger",p);
	trig delete();

	p setorigin(targ.origin);
	p setplayerangles(targ.angles);
}

back()
{
	trig=getent("back_trig","targetname");
	targ=getent("back_origin","targetname");

	trig waittill("trigger",p);
	trig delete();

	p setorigin(targ.origin);
	p setplayerangles(targ.angles);
}

unlucky()
{
	trig=getent("noluck_trig","targetname");
	targ=getent("noluck_origin","targetname");

	for(;;)
	{
		trig waittill("trigger",p);
		p setorigin(targ.origin);
		p setplayerangles(targ.angles);
	}
}

acti_teleport()
{
	trig=getent("actisend_trig","targetname");
	targ=getent("actisend_origin","targetname");

	for(;;)
	{
		trig waittill("trigger",p);
		p setorigin(targ.origin);
		p setplayerangles(targ.angles);
	}
}

acti_teleport2()
{
	trig=getent("actisend_trig2","targetname");
	targ=getent("actisend_origin2","targetname");

	for(;;)
	{
		trig waittill("trigger",p);
		p setorigin(targ.origin);
		p setplayerangles(targ.angles);
	}
}

custom_rtd()
{
	triga=getent("rtd_trig1","targetname");
	trigb=getent("rtd_trig2","targetname");
	targ=getent("rtd_origin","targetname");

	triga waittill("trigger",p);
	trigb waittill("trigger",p);

	p setorigin(targ.origin);
	p setplayerangles(targ.angles);
}

nortd()
{
	trig=getent("nortd_trig","targetname");
	targ=getent("nortd_origin","targetname");

	for(;;)
	{
		trig waittill("trigger",p);
		p setorigin(targ.origin);
		p setplayerangles(targ.angles);
	}
}

jumpback()
{
	trig=getent("jumpback_trig","targetname");
	targ=getent("jumpback_origin","targetname");

	for(;;)
	{
		trig waittill("trigger",p);
		p setorigin(targ.origin);
		p setplayerangles(targ.angles);
	}
}

jumpback2()
{
	trig=getent("jumpback_trig2","targetname");
	targ=getent("jumpback_origin2","targetname");

	for(;;)
	{
		trig waittill("trigger",p);
		p setorigin(targ.origin);
		p setplayerangles(targ.angles);
	}
}

others()
{
	thread credits();
	thread mover();
	thread wealth();
	thread nogiver();
	thread floatgun();
	thread jumpgun();
	thread rtd();
}

credits()
{
	level waittill("round_started");
	ambientplay("song_main");
	iprintln("|^0Now Playing:^3 Deadmau5 - Ghosts N Stuff^7|");
	wait 10;
	iprintln("|^0Map made by^3 Jumpy^7|");
}

mover()
{
	trap=getent("mover","targetname");
	while(1)
	{
		trap movex(1012,4);
		wait 6;
		trap movex(-1012,4);
		wait 6;
	}
}

wealth()
{
	trig=getent("wealth_trigger","targetname");
	trig waittill("trigger",player);
	trig delete();

	iprintlnbold("|^0"+player.name+"^7 is ^3wealthy^7 now!|");
	player braxi\_rank::giverankxp(undefined,250);
	player playsound("holy_shit");
}

nogiver()
{
	trig=getent("no_trig","targetname");
	trig waittill("trigger",player);
	trig delete();

	player iprintlnbold("| ^1FATAL ERROR. ^0XP^3 cant be given^7|");
	wait 1;
	player freezecontrols(1);
}

floatgun()
{
	gun=getent("float_gun","targetname");
	while(1)
	{
		gun movez(3,2);
		wait 2;
		gun movez(-3,2);
		wait 2;
	}
}

jumpgun()
{
	trig = getEnt("jumpwep_trig","targetname" ); 

	for(;;)
	{
		trig waittill( "trigger", player );
		player giveWeapon( "colt45_mp" );
		player giveMaxAmmo( "colt45_mp" );
		player switchToWeapon( "colt45_mp" );
	}
}

rtd()
{
	trig=getent("rtd_trig","targetname");
	trig waittill("trigger",p);

	p iprintlnbold("^0Roll ^7the ^0Dice ^3activated...");
	wait 0.1;
	p iprintlnbold("|^03^7|");
	wait 1;
	p iprintlnbold("|^02^7|");
	wait 1;
	p iprintlnbold("|^01^7|");
	wait 1;
	r=randomint(11);
	switch(r)
	{
		case 0:
			p takeallweapons();
			p giveweapon("deserteagle_mp");
			p switchtoweapon("deserteagle_mp");
			p iprintlnbold("^0You ^3got a ^0Deagle!");
			break;
		case 1:
			p takeallweapons();
			p giveweapon("ak47_mp");
			p switchtoweapon("ak47_mp");
			p iprintlnbold("^0You ^3got a ^0AK-47!");
			break;
		case 2:
			p takeallweapons();
			p giveweapon("remington700_mp");
			p switchtoweapon("remington700_mp");
			p iprintlnbold("^0You ^3got a ^0R700!");
			break;
		case 3:
			p takeallweapons();
			p braxi\_rank::giverankxp(undefined,200);
			p iprintlnbold("^0You ^3got ^0200XP!");
			break;
		case 4:
			p takeallweapons();
			p giveweapon("knife_mp");
			p switchtoweapon("knife_mp");
			p iprintlnbold("^0You ^3got ^0Nothing!");
			break;
		case 5:
			p iprintlnbold("^0You ^3got ^0WTF!");
			p playsound("rtd_wtf");
			p suicide();
			break;
		case 6:
			p iprintlnbold("^0You ^3got ^0Frozen!");
			p freezecontrols(1);
			wait 10;
			p freezecontrols(0);
			break;
		case 7:
			p iprintlnbold("^0You ^3got ^0Invisible!");
			p hide();
			wait 30;
			p show();
			break;
		case 8:
			p iprintlnbold("^0You ^3got ^0Speed!");
			p setmovespeedscale(1.2);
			break;
		case 9:
			p iprintlnbold("^0You ^3got ^0Hurt!");
			p.health=10;
			break;
		case 10:
			p iprintlnbold("^0You ^3got ^0Duke Nukem Power!");
			p detachall();
			p setmodel("playermodel_dnf_duke");
			break;
	}
}