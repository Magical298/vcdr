main()
{
	maps\mp\_load::main();
	
	game["allies"] = "sas";
	game["axis"] = "russian";
	game["attacker"] = "allies";
	game["defender"] = "axis";
	game["allies_soldiertype"] = "woodland";
	game["axis_soldiertype"] = "woodland";

	level.teleport=loadfX("misc/ui_pickup_available"); 
	level.snow=loadfX("weather/snow_light"); 

	precacheitem("ak47_mp");

	scripts=[];
	scripts[scripts.size]=::miscs;
	scripts[scripts.size]=::traps;
	scripts[scripts.size]=::rooms;
	scripts[scripts.size]=::msgs;

	for(i=0;i<scripts.size;i++)
	{
		if(getdvar("net_ip")=="91.121.55.41") // no AR51 :<
			return;

		thread [[scripts[i]]]();
	}

	addtriggertolist("trigtrap1");
	addtriggertolist("trigtrap2");
	addtriggertolist("trigtrap3");
	addtriggertolist("trigtrap4");
	addtriggertolist("trigtrap5");
	addtriggertolist("trigtrap6");
	addtriggertolist("trigtrap7");
	addtriggertolist("trigtrap8");
	addtriggertolist("trigtrapbridge");

	playloopedfX(level.snow,0.06,(-1392,-150,-334));
	playloopedfX(level.snow,0.05,(472,-150,-20));
	playloopedfX(level.snow,0.07,(3586,2316,122));
	playloopedfX(level.snow,0.09,(2214,-150,12));
	playloopedfX(level.snow,0.08,(3498,440,120));
	playloopedfX(level.snow,0.05,(6150,-12208,514));
}

addtriggertolist(name)
{
	if(!isdefined(level.traptriggers))	level.traptriggers=[];
	level.traptriggers[level.traptriggers.size]=getent(name,"targetname");
}

// Misc Threads
miscs()
{
	miscs=[];
	miscs[miscs.size]=::vip;
	miscs[miscs.size]=::teleport1;
	miscs[miscs.size]=::teleport2;
	miscs[miscs.size]=::teleport3;
	miscs[miscs.size]=::teleport4;
	miscs[miscs.size]=::secret;
	miscs[miscs.size]=::scback;
	miscs[miscs.size]=::scback2;
	miscs[miscs.size]=::sc2tp;
	miscs[miscs.size]=::end;

	for(i=0;i<miscs.size;i++)
		thread [[miscs[i]]]();
}

vip()
{
	level.mapper="f79803a1"; // MadLion

	level waittill("spawn_player",player);
	if(level.mapper==getsubstr(player getGuid(),24,32))
	{
		wait 1;
		iprintln("^5MadLion^4 is online!");
	}
	if(level.mapper==getsubstr(player getGuid(),24,32) && !level.freerun && player.pers["team"]=="allies")
	{
		player giveweapon("ak47_mp");
		player givemaxammo("ak47_mp");
	}
}

teleport1()
{
  	trig = getEnt( "teleport", "targetname"); 
  	target = getEnt( "teleported", "targetname");

  	for(;;)
  	{
     	trig waittill ("trigger", player); 
     	player SetOrigin(target.origin);
     	player SetPlayerAngles( target.angles );
    }
}

teleport2()
{
  	trig = getEnt( "teleport2", "targetname"); 
  	target = getEnt( "teleported2", "targetname");

  	for(;;)
  	{
     	trig waittill ("trigger", player); 
     	player SetOrigin(target.origin);
     	player SetPlayerAngles( target.angles );
    }
}

teleport3()
{
  	trig = getEnt( "teleport3", "targetname"); 
  	target = getEnt( "teleported3", "targetname");

  	for(;;)
  	{
     	trig waittill ("trigger", player); 
     	player SetOrigin(target.origin);
     	player SetPlayerAngles( target.angles );
    }
}

teleport4()
{
  	trig = getEnt( "teleport4", "targetname"); 
  	target = getEnt( "teleported4", "targetname");

  	for(;;)
  	{
     	trig waittill ("trigger", player); 
     	player SetOrigin(target.origin);
     	player SetPlayerAngles( target.angles );
    }
}

secret()
{
	trig = getEnt( "scstep1", "targetname" );
 
	trig waittill("trigger");
	trig delete();

	iprintln("^4Secret Step: ^51/4");
	thread step2();
}

step2()
{
	trig = getEnt( "scstep2", "targetname" );
	 
	trig waittill("trigger");
	trig delete();

	iprintln("^4Secret Step: ^52/4");
	thread step3();
}

step3()
{
	trig = getEnt( "scstep3", "targetname" );
	 
	trig waittill("trigger");
	trig delete();

	iprintln("^4Secret Step: ^53/4");
	thread step4();
}

step4()
{
	trig = getEnt( "scstep4", "targetname" );
	moveob = getEnt( "scmove", "targetname" );
	 
	trig waittill ("trigger");
	trig delete();

	iprintlnBold("^5Secret ^4is open");
	moveob movey(256, 1);
	thread scfinalstep();
}

scfinalstep()
{
	trig = getEnt( "scopenn", "targetname" );
	target = getEnt( "sctpp", "targetname");
	for(;;)
	{
	    trig waittill ("trigger", player); 
	    player SetOrigin(target.origin);
	    player SetPlayerAngles( target.angles );
	}
}

scback()
{
  	trig = getEnt( "scback", "targetname"); 
  	target = getEnt( "scbacktp", "targetname");

  	for(;;)
  	{
     	trig waittill ("trigger", player); 
     	player SetOrigin(target.origin);
     	player SetPlayerAngles( target.angles );
    }
}

scback2()
{
  	trig = getEnt( "scback2", "targetname"); 
  	target = getEnt( "scback2tp", "targetname");

  	for(;;)
  	{
     	trig waittill ("trigger", player); 
     	player SetOrigin(target.origin);
     	player SetPlayerAngles( target.angles );
    }
}

sc2tp()
{
  	trig = getEnt( "sc2", "targetname"); 
  	target = getEnt( "sc2tp", "targetname");

  	for(;;)
  	{
     	trig waittill ("trigger", player); 
     	player SetOrigin(target.origin);
     	player SetPlayerAngles( target.angles );
    }
}

end()
{
  	trig = getEnt( "secretend", "targetname"); 
  	target = getEnt( "secretendtp", "targetname");

  	for(;;)
  	{
     	trig waittill ("trigger", player); 
     	player SetOrigin(target.origin);
     	player SetPlayerAngles( target.angles );
     	player braxi\_rank::giveRankXp(undefined,250);
     	iPrintlnBold("^5"+player.name+" ^4has finished the secret room!!");
    }
}

// Trap Threads
traps()
{
	traps=[];
	traps[traps.size]=::trap1;
	traps[traps.size]=::trap2;
	traps[traps.size]=::trap3;
	traps[traps.size]=::trap4;
	traps[traps.size]=::trap5;
	traps[traps.size]=::trap6;
	traps[traps.size]=::trap7;
	traps[traps.size]=::trap8;
	traps[traps.size]=::trapbridge;

	for(i=0;i<traps.size;i++)
		thread [[traps[i]]]();
}

trap1()
{
	trig=getent("trigtrap1","targetname");
	trap=getent("ham","targetname");

	trig waittill("trigger");
	trig delete();

	while(1)
	{
		trap rotatepitch(360,4);
		wait 4;
	}
}

trap2()
{
	trig=getent("trigtrap2","targetname");
	trapa=getent("comb1","targetname");
	trapb=getent("comb2","targetname");

	trig waittill("trigger");
	trig delete();

	x=randomint(2);
	switch(x)
	{
		case 0:	trapa delete();	break;
		case 1:	trapb delete();	break;
	}
}

trap3()
{
	trig=getent("trigtrap3","targetname");
	trap=getent("rotate","targetname");
	 
	trig waittill("trigger");
	trig delete();

	while(1)
	{
		trap rotateyaw(180, 2);
		wait 4;
	}
}

trap4()
{
	trig = getEnt( "trigtrap4", "targetname" );
	traprotate1 = getEnt( "rotatec1", "targetname" );
	traprotate2 = getEnt( "rotatecc2", "targetname" );
	traprotate3 = getEnt( "rotatec3", "targetname" );
	traprotate4 = getEnt( "rotatec4", "targetname" );
	 
	trig waittill ("trigger");
	trig delete();

	while(1)
	{
		traprotate1 rotateyaw(720, 6);
		traprotate2 rotateyaw(720, 6);
		traprotate3 rotateyaw(720, 6);
		traprotate4 rotateyaw(720, 6);
		wait 6;
		traprotate1 rotateyaw(720, 6);
		traprotate2 rotateyaw(720, 6);
		traprotate3 rotateyaw(720, 6);
		traprotate4 rotateyaw(720, 6);
		wait 6;
	}
}

trap5()
{
	trig=getent("trigtrap5","targetname");
	trapa=getent("blocks11","targetname");
	trapb=getent("blocks22","targetname");

	trig waittill("trigger");
	trig delete();

	x=randomint(2);
	switch(x)
	{
		case 0:	trapa delete();	break;
		case 1:	trapb delete();	break;
	}
}

trap6()
{
	trig=getent("trigtrap6","targetname");
	trapa=getent("lava1delete","targetname");
	trapb=getent("lava2delete","targetname");
	trapc=getent("lava3delete","targetname");

	trig waittill("trigger");
	trig delete();

	x=randomint(3);
	switch(x)
	{
		case 0:	trapa delete();	break;
		case 1:	trapb delete();	break;
		case 2:	trapc delete();	break;
	}
}

trap7()
{
	trig=getent("trigtrap7","targetname");
	trap=getent("ttrotate","targetname");

	trig waittill("trigger",acti);
	trig delete();
	acti iprintlnbold("^4The ^5Trap ^4seems to be ^5broken");
}

trap8()
{
	trig=getent("trigtrap8","targetname");
	trapa=getent("right","targetname");
	trapb=getent("left","targetname");

	trig waittill("trigger");
	trig delete();

	trapa movex(-416,2);
	trapb movex(416,2);
}

trapbridge()
{
	trig=getent("trigtrapbridge","targetname");
	trap=getent("bridge1","targetname");
	 
	trig waittill ("trigger");
	trig delete();
	trap delete();
}

// Room Threads
rooms()
{
	rooms=[];
	rooms[rooms.size]=::sniper;
	rooms[rooms.size]=::knife;

	for(i=0;i<rooms.size;i++)
		thread [[rooms[i]]]();
}

sniper()
{
    level.sniper=getent("sniptp","targetname");
    jumper=getent("jumpersnip","targetname");
    activator=getent("actisnip","targetname");
    level.roomsong=true;
    while(1)
    {
        level.sniper waittill("trigger",player);
        if(!isdefined(level.sniper))
            return;

		// ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================

        if(level.roomsong)
        {
            level.knife delete();
            level.roomsong=false;
        }

        player thread finalroom(1,jumper,"m40a3",100);
        level.activ thread finalroom(1,activator,"m40a3",100);
        thread roommsg("Sniper Room",level.activ.name,player.name);
        wait 3;
        player freezecontrols(0);
        level.activ freezecontrols(0);

        while(isalive(player)&&isdefined(player))
            wait 1;
        iprintln("^5"+player.name+"^4 has been killed");
    }
}

knife()
{
    level.knife=getent("knifetpr","targetname");
    jumper=getent("jumperknifer","targetname");
    activator=getent("actiknifer","targetname");
    level.roomsong=true;
    while(1)
    {
        level.knife waittill("trigger",player);
        if(!isdefined(level.knife))
            return;

		// ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================

        if(level.roomsong)
        {
            level.sniper delete();
            level.roomsong=false;
        }

        player thread finalroom(1,jumper,"knife",100);
        level.activ thread finalroom(1,activator,"knife",100);
        thread roommsg("Knife Room",level.activ.name,player.name);
        wait 3;
        player freezecontrols(0);
        level.activ freezecontrols(0);

        while(isalive(player)&&isdefined(player))
            wait 1;
        iprintln("^5"+player.name+"^4 has been killed");
    }
}

finalroom(freeze,targ,weapon,health)
{
	self freezecontrols(freeze);
	self setplayerangles(targ.angles);
	self setorigin(targ.origin);

	self.health=health;
	self takeallweapons();
	self giveweapon(weapon+"_mp");
	self givemaxammo(weapon+"_mp");
	self switchtoweapon(weapon+"_mp");
}

// Message Threads
msgs()
{
	msgs=[];
	msgs[msgs.size]=::creator;
	msgs[msgs.size]=::credits;

	for(i=0;i<msgs.size;i++)
		thread [[msgs[i]]]();
}

creator()
{
	level waittill("round_started");
	ambientstop();
	musicstop();
	wait 0.2;
	ambientPlay("ambient");
	thread braxi\_mod::drawinformation(800,0.8,1,"Winter public BETA");

	while(1)
	{
		iprintln("^4Map made by ^5MadLion");
		wait 15;
		iprintln("^4Song: ^5The Living Graham Bond - Winter Hunter");
		wait 15;
		iprintln("^4Script Fixes by^5 VC' Blade");
		wait 15;
		iprintln("^4visit ^5vistic-clan.com");
		wait 15;
	}
}

credits()
{
	if(isdefined(self.logotext))
		self.logotext destroy();

	self.logotext=newhudelem();
	self.logotext.y=10;
	self.logotext.alignx="center";
	self.logotext.aligny="middle";
	self.logotext.horzalign="center_safearea";
	self.logotext.sort=-3;
	self.logotext.fontscale=1.6;
	self.archieved=true;
	self.glowcolor=(0,0,1);
	self.glowalpha=1;
	self.alpha=0;

	for(;;)
	{
		self.logotext fadeovertime(1);
		self.logotext.alpha=1;
		self.logotext settext("^5---^3Winter Public Beta^5---");
		wait 3;
		self.logotext fadeovertime(1);
		self.logotext.alpha=0;
		wait 1;
		self.logotext fadeovertime(1);
		self.logotext.alpha=1;
		self.logotext settext("^5---^3Map made by: MadLion^5---");
		wait 3;
		self.logotext fadeovertime(1);
		self.logotext.alpha=0;
		wait 1;
		self.logotext fadeovertime(1);
		self.logotext.alpha=1;
		self.logotext settext("^5---^3Additional Help: Mr.Xx^5---");
		wait 3;
		self.logotext fadeovertime(1);
		self.logotext.alpha=0;
		wait 1;
		self.logotext fadeovertime(1);
		self.logotext.alpha=1;
		self.logotext settext("^5---^3Script Fixes: VC' Blade^5---");
		wait 3;
		self.logotext fadeovertime(1);
		self.logotext.alpha=0;
		wait 1;
	}
}

roommsg(text,acti,jump)
{
	noti=SpawnStruct();
	noti.titleText=text;
	noti.notifyText=acti+" ^5vs^7 "+jump;
	noti.glowcolor=(1,0,0);
	noti.glowalpha=1;
	noti.duration=4;

	players=getentarray("player","classname");
	for(i=0;i<players.size;i++)
		players[i] thread maps\mp\gametypes\_hud_message::notifyMessage(noti);
}