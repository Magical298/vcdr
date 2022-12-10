main()
{
	maps\mp\_load::main();	

	game["allies"] = "marines";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "desert";
	game["axis_soldiertype"] = "desert";

	level.fire = loadFX("deathrun/myfire");
	level.room = loadFX("deathrun/ui_pickup_available");
	playLoopedFX(level.fire, 0.1, (91,173,-120));
	playLoopedFX(level.fire, 0.12, (-148.5,188.5,-120));
	playLoopedFX(level.room, 999.0, (2864,10888,-815));
	playLoopedFX(level.room, 999.1, (2925,10977,-418));
	playLoopedFX(level.room, 999.2, (2093,11280,-471));


	thread musicBox();
	thread creator();
	thread darkMode();
	thread traps();
	thread rooms();
	thread misc();

	addTriggerToList( "trap1trig" );
	addTriggerToList( "trap2trig" );
	addTriggerToList( "trap3trig" );
	addTriggerToList( "trap4trig" );
	addTriggerToList( "trap5trig" ); 
	addTriggerToList( "trap7trig" ); 
	addTriggerToList( "trap8trig" ); 
	addTriggerToList( "trap8trig" ); 
	addTriggerToList( "trap9trig" ); 
	addTriggerToList( "trap10trig" ); 
	addTriggerToList( "trap11trig" ); 
	addTriggerToList( "trap12trig" );
	addTriggerToList( "trap13trig" );
	addTriggerToList( "juggernaut_trigger" );
}

addTriggerToList(name)
{
    if(!isDefined(level.trapTriggers))
        level.trapTriggers=[];
    level.trapTriggers[level.trapTriggers.size]=getEnt(name,"targetname");
}

creator()
{
	level waittill("round_started");
	
	ambientplay("musicmap");
	thread braxi\_mod::drawinformationsmall(800,0.8,1,"^5---^3Shadow 1.2^5---");

	for(;;)
	{
		iprintln("Map made by^5 MadLion");
		wait 10;
		iprintln("xFire:^5 madlion3");
		wait 10;
		iprintln("Script fixes by^5 Blade");
		wait 10;
		iprintln("visit:^5 vistic-clan.com");
		wait 30+randomint(30);
	}
}

darkMode()
{
	trig=getent("juggernaut_trigger","targetname");
	trig sethintstring("^5---^3Dark Mode?^5---");

	trig waittill("trigger",player);
	iprintlnbold("Activator ^5"+player.name+"^7 activated the ^5Dark Mode^7!");

	for(;;)
	{
		wait .5;
		setexpfog(256,200,0,0,0,0.1);
	}
}

musicBox()
{
	trig=getent("musictrig","targetname");
	trig waittill("trigger",p);
	trig delete();
	
	iprintlnbold("Map made by ^5MadLion");
	ambientstop();
	switch(randomint(5))
	{
		case 0:
			ambientplay("jump");
			break;
		case 1:
			ambientplay("jump2");
			break;
		case 2:
			ambientplay("jump3");
			break;
		case 3:
			ambientplay("jump4");
			break;
		case 4:
			ambientplay("jump5");
			break;
	}
}

traps()
{
	thread trap1();
	thread trap2();
	thread trap3();
	thread trap4();
	thread trap5();
	thread trap8();
	thread trap9();
	thread trap10();
	thread trap11();
	thread trap12();
	thread trap13();
}

trap1()
{
	trig = getEnt( "trap1trig", "targetname" );
	down = getEnt( "trap1", "targetname" );
	 
	trig waittill ("trigger");
	trig delete();
 
	down movez( -300, 4 );
	wait 4;
	down movez( 300, 4 );
}

trap2()
{
	trig = getEnt( "trap2trig", "targetname" );
	trap21 = getEnt( "trap21", "targetname" );
	trap22 = getEnt( "trap22", "targetname" );
	trap23 = getEnt( "trap23", "targetname" );
	 
	trig waittill ("trigger");
	trig delete();
	 
	while( 1 )
	{
		trap21 movez( -300, 3 );
		wait 5;
		trap21 movez( 300, 3 );
		wait 5;
		trap22 movez( -300, 3 );
		trap23 movez( -300, 3 );
		wait 5;
		trap23 movez( 300, 3 );
		trap22 movez( 300, 3 );
		trap21 movez( -300, 3 );
		wait 5;
		trap22 movez( -300, 3 );
		trap23 movez( -300, 3 );
		wait 5;
		trap23 movez( 300, 3 );
		trap22 movez( 300, 3 );
		trap21 movez( 300, 3 );
		wait 5;
	}
}

trap3()
{
 
	trig = getEnt( "trap3trig", "targetname" );
	trap3 = getEnt( "trap3", "targetname" );
	killtrigger = getent ("trap3hurt" , "targetname");
	 
	trig waittill ("trigger");
	trig delete();
	 
	while( 1 )
	{
		killtrigger enablelinkto ();
		killtrigger linkto (trap3);
		trap3 movey( 600, 3 );
		wait 3;
		trap3 movey( -600, 3 );
		wait 3;
	}
}

trap4()
{
	trig = getEnt( "trap4trig", "targetname" );
	trap4 = getEnt( "trap4", "targetname" );
	 
	trig waittill ("trigger");
	trig delete();
 
	trap4 movez( -200, 2 );
}

trap5()
{
	trig = getEnt( "trap5trig", "targetname" );
	trap51 = getEnt( "trap51", "targetname" );
	trap52 = getEnt( "trap52", "targetname" );
	 
	trig waittill ("trigger");
	trig delete();

	while( 1 )
	{
		trap51 movex( -280, 2 );
		wait 2;
		trap51 movex( 280, 2 );
		trap52 movex( -280, 2 );
		wait 2;
		trap52 movex( 280, 2 );
	}
}

trap6()
{
	trig = getEnt( "trap7trig", "targetname" );
	trap6 = getEnt( "trap6666", "targetname" );
	 
	trig waittill ("trigger");
	trig delete();

	trap6 movez( -200, 2 );
}

trap8()
{
	trig = getEnt( "trap8trig", "targetname" );
	trap81 = getEnt( "trap81", "targetname" );
	trap82 = getEnt( "trap82", "targetname" );
	 
	trig waittill ("trigger");
	trig delete();

	while( 1 )
	{
		trap81 rotatepitch( 360, 2 );
		wait 2;
		trap82 rotatepitch( 360, 2 );
		wait 2;
	}
}

trap9()
{
	trig = getEnt( "trap9trig", "targetname" );
	trap9 = getEnt( "trap9", "targetname" );
	 
	trig waittill ("trigger");
	trig delete();

	while( 1 )
	{
		trap9 rotateroll( 360, 2 );
		wait 4;
	}
}

trap10()
{
	trig = getEnt( "trap10trig", "targetname" );
	trap10 = getEnt( "trap10", "targetname" );
	 
	trig waittill ("trigger");
	trig delete();

	while( 1 )
	{
		trap10 rotateyaw( 360, 2 );
		wait 2;
	}
}

trap11()
{
	trig = getEnt( "trap11trig", "targetname" );
	trap11 = getEnt( "trap11", "targetname" );
	trap111 = getEnt( "trap111", "targetname" );
	 
	trig waittill ("trigger");
	trig delete();

	while( 1 )
	{
		trap11 movez( 180, 1 );
		trap111 movez( -180, 1 );
		wait 1;
		trap11 movez( -360, 1 );
		trap111 movez( 360, 1 );
		wait 1;
		trap11 movez( 180, 1 );
		trap111 movez( -180, 1 );
		wait 1;
	}
}

trap12()
{
	trig = getEnt( "trap12trig", "targetname" );
	trap12 = getEnt( "trap12", "targetname" );
	 
	trig waittill ("trigger");
	trig delete();

	trap12 movez( -999, 3 );
	wait 3;
	trap12 movez( 999, 3 );
	wait 3;
}

trap13()
{
	trig = getEnt( "trap13trig", "targetname" );
	trap13 = getEnt( "trap13", "targetname" );
	trap133 = getEnt( "trap133", "targetname" );
	 
	trig waittill ("trigger");
	trig delete();

	while( 1 )
	{
		trap13 movez( 90, 1 );
		trap133 movez( -90, 1 );
		wait 1;
		trap13 movez( -180, 3 );
		trap133 movez( 180, 3 );
		wait 3;
		trap13 movez( 90, 1 );
		trap133 movez( -90, 1 );
		wait 1;
	}
}

misc()
{
	thread teleport1();
 	thread teleport2();
 	thread jumper();
}

teleport1()
{
  	trig = getEnt( "oldroom", "targetname"); 
  	target = getEnt( "oldentered", "targetname");

  	for(;;)
  	{
     	trig waittill ("trigger", player); 
     	player SetOrigin(target.origin);
     	player SetPlayerAngles( target.angles );
    }
}

teleport2()
{
  	trig = getEnt( "actijump", "targetname"); 
  	target = getEnt( "actijumped", "targetname");

  	for(;;)
  	{
     	trig waittill ("trigger", player); 
     	player SetOrigin(target.origin);
     	player SetPlayerAngles( target.angles );
    }
}

jumper()
{
	level.jumpx1 = getent ("finishair","targetname");
	air1 = getent ("air1","targetname");
	air2 = getent ("air2","targetname");
	air3 = getent ("air3","targetname");
	air4 = getent ("air4","targetname");
	
	time = 2;
	for(;;)
	{
		level.jumpx1 waittill ("trigger",user);
		wait(0.05);
		if (user istouching(level.jumpx1))
		{		
			air = spawn ("script_model",(0,0,0));
			air.origin = user.origin;
			air.angles = user.angles;
			user linkto (air);
			air moveto (air1.origin, time);
			wait 2;
			air moveto (air2.origin, time);
			wait 2.3;
			air moveto (air3.origin, time);
			wait 2;
			air moveto (air4.origin, time);
            user unlink();
		}
	}
}

rooms()
{
	thread sniper();
	thread knife();
	thread crazyknife();
	thread dog();
}

sniper()
{
    level.sniper=getent("mus2","targetname");
 
    jump=getent("snipjump","targetname");
    acti=getent("snipacti","targetname");
 
    while(1)
    {
        level.sniper waittill("trigger",player);

		// ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================

        thread snipmove();
        thread snipback1();
        thread snipback2();
        
        if(!isdefined(level.sniper)) return;
 
        if(!isdefined(level.entertext)||!level.entertext)
        {
            level.entertext=true;
            level.canPlaySound=false;
 
            level.dog delete();
            level.crazyknife delete();
            level.knife delete();
 
            iprintlnbold("^5"+player.name+" ^7entered Sniper Fight");
        }
 
       	player createroomport("m40a3_mp",undefined,1,jump,100);
        level.activ createroomport("m40a3_mp",undefined,1,acti,100);

        noti = SpawnStruct();
		noti.titleText = "Sniper Fight";
		noti.notifyText = level.activ.name + " ^5VS^7 " + player.name;
		noti.glowcolor = (0,0.9,0.7);
		noti.duration = 4;
		players = getentarray("player", "classname");
		for(i=0;i<players.size;i++)
			players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
 
        wait 3;

        player freezecontrols(0);
        level.activ freezecontrols(0);
 
       	while(isalive(player)&&isdefined(player))
            wait 1;

        iPrintlnBold("^1"+self.name+" ^7died^1!");
    }
}

knife()
{
    level.knife=getent("mus","targetname");
 
    jump=getent("jumperjump","targetname");
    acti=getent("jumperacti","targetname");
 
    while(1)
    {
        level.knife waittill("trigger",player);

        if(!isdefined(level.knife)) return;

		// ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================

 
        if(!isdefined(level.entertext)||!level.entertext)
        {
            level.entertext=true;
            level.canPlaySound=false;
 
            level.dog delete();
            level.crazyknife delete();
            level.sniper delete();
 
            iprintlnbold("^5"+player.name+" ^7entered Knife Fight");
        }
 
        player createroomport("knife_mp",undefined,1,jump,100);
        level.activ createroomport("knife_mp",undefined,1,acti,100);

        noti = SpawnStruct();
		noti.titleText = "Knife Fight";
		noti.notifyText = level.activ.name + " ^5VS^7 " + player.name;
		noti.glowcolor = (0,0.9,0.7);
		noti.duration = 4;
		players = getentarray("player", "classname");
		for(i=0;i<players.size;i++)
			players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
 
        wait 3;

        player freezecontrols(0);
        level.activ freezecontrols(0);
 
       	while(isalive(player)&&isdefined(player))
            wait 1;

        iPrintlnBold("^1"+self.name+" ^7died^1!");
    }
}

crazyknife()
{
    level.crazyknife=getent("mus1","targetname");
 
    jump=getent("jumpjump","targetname");
    acti=getent("jumpacti","targetname");
 
    while(1)
    {
        level.crazyknife waittill("trigger",player);

		// ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================
        
        if(!isdefined(level.crazyknife)) return;
 
        if(!isdefined(level.entertext)||!level.entertext)
        {
            level.entertext=true;
            level.canPlaySound=false;
 
            level.dog delete();
            level.knife delete();
            level.sniper delete();
 
            iprintlnbold("^5"+player.name+" ^7entered Crazy Knife Fight");
        }
 
        player createroomport("knife_mp",undefined,1,jump,100);
        level.activ createroomport("knife_mp",undefined,1,acti,100);

        player setJumpHeight(500);
		level.activ setJumpHeight(500);
		player setGravity(300);
		level.activ setGravity(300);

        noti = SpawnStruct();
		noti.titleText = "Crazy Knife Fight";
		noti.notifyText = level.activ.name + " ^5VS^7 " + player.name;
		noti.glowcolor = (0,0.9,0.7);
		noti.duration = 4;
		players = getentarray("player", "classname");
		for(i=0;i<players.size;i++)
			players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
 
        wait 3;

        player freezecontrols(0);
        level.activ freezecontrols(0);
 
       	while(isalive(player)&&isdefined(player))
            wait 1;

        iPrintlnBold("^1"+self.name+" ^7died^1!");
    }
}

dog()
{
    level.dog=getent("mus3","targetname");
 
    jump=getent("dogjump","targetname");
    acti=getent("dogacti","targetname");
 
    while(1)
    {
        level.dog waittill("trigger",player);

		// ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================
        
        if(!isdefined(level.dog)) return;
 
        if(!isdefined(level.entertext)||!level.entertext)
        {
            level.entertext=true;
            level.canPlaySound=false;
 
            level.knife delete();
            level.crazyknife delete();
            level.sniper delete();
 
            iprintlnbold("^5"+player.name+" ^7entered Dog Fight");
        }
        player setmodel("german_sheperd_dog");
        level.activ setmodel("german_sheperd_dog");

        wait .1;
 
        player createroomport("dog_mp",undefined,1,jump,100);
        level.activ createroomport("dog_mp",undefined,1,acti,100);

        noti = SpawnStruct();
		noti.titleText = "Crazy Knife Fight";
		noti.notifyText = level.activ.name + " ^5VS^7 " + player.name;
		noti.glowcolor = (0,0.9,0.7);
		noti.duration = 4;
		players = getentarray("player", "classname");
		for(i=0;i<players.size;i++)
			players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
 
        wait 3;

        player freezecontrols(0);
        level.activ freezecontrols(0);
 
       	while(isalive(player)&&isdefined(player))
            wait 1;

        iPrintlnBold("^1"+self.name+" ^7died^1!");
    }
}

createroomport(weapon,weapon2,freeze,where,health)
{
    self takeallweapons();
    self giveweapon(weapon);
    if(isdefined(weapon2))
    	self giveweapon(weapon2);
    self switchtoweapon(weapon);
 
    self freezecontrols(freeze);
    self setorigin(where.origin);
    self setplayerangles(where.angles);
 
    self.health=health;
}


snipmove()
{
	up = getEnt( "movesnip1", "targetname" );
	down = getEnt( "movesnip2", "targetname" );

	while( 1 )
	{
		up movez( -50, 2 );
		down movez( 50, 2 );
		wait 2;
		up movez( 50, 2 );
		down movez( -50, 2 );
		wait 2;
	}
}

snipback1()
{
	trig = getEnt( "snipback1", "targetname"); 
	target = getEnt( "sniptpd1", "targetname");

  	for(;;)
  	{
     	trig waittill ("trigger", player); 
     	player SetOrigin(target.origin);
     	player SetPlayerAngles( target.angles );
    }
}

snipback2()
{
  	trig = getEnt( "snipback2", "targetname"); 
  	target = getEnt( "sniptpd2", "targetname");

  	for(;;)
  	{
     	trig waittill ("trigger", player); 
     	player SetOrigin(target.origin);
     	player SetPlayerAngles( target.angles );
    }
}