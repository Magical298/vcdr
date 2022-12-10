main()
{
	maps\mp\_load::main();

	game["allies"]="marines";
	game["axis"]="opfor";
	game["attackers"]="axis";
	game["defenders"]="allies";
	game["allies_soldiertype"]="desert";
	game["axis_soldiertype"]="desert";

	setdvar( "r_specularcolorscale", "1" );
	setdvar( "dr_jumpers_speed", "1.2" );
	setdvar( "dr_activators_speed", "1.2" );
	setdvar("r_glowbloomintensity0",".25");
	setdvar("r_glowbloomintensity1",".25");
	setdvar("r_glowskybleedintensity0",".3");
	setdvar("compassmaxrange","1800");

	level.dvar["time_limit"]=8;
	level.dvar["dr_timelimit"]=8;

	thread traps();
	thread finalfights();
	thread teleports();
	thread credits();
	thread secrets();
	thread others();

	addTriggerToList( "trig_trap1" );
    addTriggerToList( "trig_trap2" );
    addTriggerToList( "trig_trap3" );
    addTriggerToList( "trig_trap4" );
    addTriggerToList( "trig_trap5" );
    addTriggerToList( "trig_trap6" );
    addTriggerToList( "trig_trap7" );
    addTriggerToList( "trig_trap8" );
    addTriggerToList( "trig_trap9" );
    addTriggerToList( "trig_trap10" );
    addTriggerToList( "trig_trap11" );
    addTriggerToList( "trig_trap12" );
    addTriggerToList( "trig_trap13" );
    addTriggerToList( "trig_trap14" );
    addTriggerToList( "trig_trap15" );
    addTriggerToList( "trig_trap16" );
    addTriggerToList( "trig_trap17" );
    addTriggerToList( "trig_trap18" );
    addTriggerToList( "trig_trap19" );
}

addTriggerToList(name)
{
    if(!isDefined(level.trapTriggers))
        level.trapTriggers=[];
    level.trapTriggers[level.trapTriggers.size]=getEnt(name,"targetname");
}

traps()
{
	thread trap0();
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
	thread trap12();
	thread trap13();
	thread trap16();
	thread trap18();
	thread trap19();
}

finalfights()
{
	thread knife_r();
	thread snipe_r();
	thread old_r();
	thread jump_r();
}

teleports()
{
	thread activator1();
	thread activator2();
	thread activator3();
	thread activator4();
	thread activator5();
	thread activator6();
	thread activator7();
	thread activator8();
	thread activator9();
	thread activator10();
	thread jumproompod1();
 	thread jumproompod2();
}

credits()
{
	thread printCredits();
	thread creator();
}

secrets()
{
	thread secretroom();
 	thread secret();
}

others()
{
	thread pad1();
	thread pad2();
	thread pad3();
	thread pad4();
	thread pad5();
	thread pad6();
	thread pad7();
	thread pad8();
	thread pad9();
	thread pad10();
	thread pad11();
	thread pad12();
	thread pad13();
	thread pad14();
	thread pad15();
	thread pad16();
	thread pad17();
	thread pad18();
	thread pad19();
	thread pad20();
	thread pad21();
	thread pad22();
	thread pad23();
	thread pad24();
 	thread mapmusic();
 	thread vrata1();
 	thread vrata2();
	thread vrata3();
 	thread vrata4();
 	thread automove1();
 	thread automove2();
 	thread specialroomdisable();
}

knife_r()
{
    level.knife=getent("kniferoom","targetname");
    jump=getent("knife","targetname");
    acti=getent("actiknife","targetname");
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

        if(level.roomsong==true)
        {
            level.roomsong=false;
            iprintlnbold("^5"+player.name+"^7 has choosen ^5Knife Fight^7!");
            level.snip delete();
            level.old delete();
            level.jump delete();
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
            thread room_msg(player.name+" vs "+level.activ.name);
            wait 5;
            player setroomgun("knife_mp",undefined);
            level.activ setroomgun("knife_mp",undefined);
            player freezecontrols(0);
            level.activ freezecontrols(0);
        }
        else
        {
            player freezecontrols(1);
            player setorigin(jump.origin);
            player setplayerangles(jump.angles);
            player takeallweapons();
            wait 5;
            player setroomgun("knife_mp",undefined);
            player freezecontrols(0);
        }
        while(isalive(player)&&isdefined(player))
            wait 1;
        iprintln("^5"+player.name+"^7 has been killed");
    }
}

snipe_r()
{
    level.snip=getent("sniproom","targetname");
    jump=getent("scope","targetname");
    acti=getent("actiscope","targetname");
    level.roomsong=true;
    while(1)
    {
        level.snip waittill("trigger",player);
        if(!isdefined(level.snip))
            return;

		// ====== Part for Queue Plugin ========
        if(!plugins\_queue::checkQueueRoom(player))
            continue;
	    // =====================================

        if(level.roomsong==true)
        {
            level.roomsong=false;
            iprintlnbold("^5"+player.name+"^7 has choosen ^5Sniper Fight^7!");
            level.knife delete();
            level.jump delete();
            level.old delete();
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
            thread room_msg(player.name+" vs "+level.activ.name);
            wait 5;
            player setroomgun("remington700_mp",undefined);
            level.activ setroomgun("remington700_mp",undefined);
            player freezecontrols(0);
            level.activ freezecontrols(0);
        }
        else
        {
            player freezecontrols(1);
            player setorigin(jump.origin);
            player setplayerangles(jump.angles);
            player takeallweapons();
            wait 5;
            player setroomgun("remington700_mp",undefined);
            player freezecontrols(0);
        }
        while(isalive(player)&&isdefined(player))
            wait 1;
        iprintln("^5"+player.name+"^7 has been killed");
    }
}

old_r()
{
    level.old=getent("oldroom","targetname");
    jump=getent("old","targetname");
    acti=getent("actiold","targetname");
    level.roomsong=true;
    while(1)
    {
        level.old waittill("trigger",player);

		// ====== Part for Queue Plugin ========
        if(!plugins\_queue::checkQueueRoom(player))
            continue;
	    // =====================================

        if(level.roomsong==true)
        {
            level.roomsong=false;
            iprintlnbold("^5"+player.name+"^7 has choosen ^5Old Fight^7!");
            level.knife delete();
            level.sniper delete();
            level.jump delete();
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
            player setorigin(jump.origin);
            player setplayerangles(jump.angles);
        }
    }
}

jump_r()
{
    level.jump=getent("jumproom","targetname");
    jump=getent("jump","targetname");
    acti=getent("actijump","targetname");
    level.roomsong=true;
    while(1)
    {
        level.jump waittill("trigger",player);
        if(!isdefined(level.jump))
            return;

		// ====== Part for Queue Plugin ========
        if(!plugins\_queue::checkQueueRoom(player))
            continue;
	    // =====================================

        if(level.roomsong==true)
        {
            level.roomsong=false;
            iprintlnbold("^5"+player.name+"^7 has choosen ^5Jump Fight^7!");
            level.knife delete();
            level.old delete();
            level.snip delete();
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
            thread room_msg(player.name+" vs "+level.activ.name);
            wait 5;
            player setroomgun("g36c_gl_mp",undefined);
            level.activ setroomgun("g36c_gl_mp",undefined);
            player freezecontrols(0);
            level.activ freezecontrols(0);
        }
        else
        {
            player freezecontrols(1);
            player setorigin(jump.origin);
            player setplayerangles(jump.angles);
            player takeallweapons();
            wait 5;
            player setroomgun("g36c_gl_mp",undefined);
            player freezecontrols(0);
        }
        while(isalive(player)&&isdefined(player))
            wait 1;
        iprintln("^5"+player.name+"^7 has been killed");
    }
}

room_msg(text)
{
    announce=addTextHud(level,320,280,0,"center","middle",2);
    announce settext(text);
    announce.glowcolor=level.randomcolor;
    announce.glowalpha=1;
    announce.alpha = 1;
    announce setpulsefx(30,100000,700);
    wait 3;
    announce destroy();
}

setroomgun(weap,weap2)
{
    if(isdefined(weap))
    {
        self giveweapon(weap);
        self givemaxammo(weap);
    }
    if(isdefined(weap2))
    {
        self giveweapon(weap2);
        self givemaxammo(weap2);
    }
    self switchtoweapon(weap);
}

// Acti Ports
activator1()
{
	trig=getent("teleport1","targetname");
	targ=getent("actiteleport1","targetname");
	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

activator2()
{
	trig=getent("teleport2","targetname");
	targ=getent("actiteleport2","targetname");
	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

activator3()
{
	trig=getent("teleport3","targetname");
	targ=getent("actiteleport3","targetname");
	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

activator4()
{
	trig=getent("teleport4","targetname");
	targ=getent("actiteleport4","targetname");
	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

activator5()
{
	trig=getent("teleport5","targetname");
	targ=getent("actiteleport5","targetname");
	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

activator6()
{
	trig=getent("teleport6","targetname");
	targ=getent("actiteleport6","targetname");
	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

activator7()
{
	trig=getent("teleport7","targetname");
	targ=getent("actiteleport7","targetname");
	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

activator8()
{
	trig=getent("teleport8","targetname");
	targ=getent("actiteleport8","targetname");
	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

activator9()
{
	trig=getent("teleport9","targetname");
	targ=getent("actiteleport9","targetname");
	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

activator10()
{
	trig=getent("teleport10","targetname");
	targ=getent("actiteleport10","targetname");
	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

// Jump Ports
jumproompod1()
{
	trig=getent("jumpfail","targetname");
	targ=getent("jumprespawn","targetname");
	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

jumproompod2()
{
	trig=getent("jumpfail2","targetname");
	targ=getent("jumprespawn2","targetname");
	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

tpto(target)
{
	self setorigin(target.origin);
	self setplayerangles(target.angles);
}

// Traps
trap0()
{
	trig=getent("trig_trap0","targetname");
	object=getent("trap0","targetname");

	trig waittill("trigger");
	trig delete();
	 
	while(1)
	{
		object movez(1344, 5);
		wait(15);
		object movez(-1344, 5);
		wait(15); 
	}
}

trap1()
{
	trig=getent("trig_trap1","targetname");
	object=getent("trap1","targetname");

	trig waittill ("trigger");
	trig delete();
	 
	while(1)
	{
		object movez(2624, 5);
		wait(15);
		object movez(-2624, 5);
		wait(15);
	}
}

trap2()
{
	trig = getEnt( "trig_trap2", "targetname" );
	object1 = getent("trap2a","targetname");
	object2 = getent("trap2b","targetname");
	object3 = getent("trap2c","targetname");
	object4 = getent("trap2d","targetname");

	trig waittill ("trigger");
	trig delete();
	 
	while(1)
	{
		object1 rotateyaw(-720, 3);
		object2 rotateyaw(-720, 3);
		object3 rotateyaw(-720, 3);
		object4 rotateyaw(-720, 3);
		wait(5);
		object1 rotateyaw(720, 3);
		object2 rotateyaw(720, 3);
		object3 rotateyaw(720, 3);
		object4 rotateyaw(720, 3);
		wait(3); 
	}
}

trap3()
{
	trig = getEnt( "trig_trap3", "targetname" );
	object1 = getent("trap3a","targetname");
	object2 = getent("trap3b","targetname");
	object3 = getent("trap3c","targetname");
	 
	trig waittill ("trigger");
	trig delete();
	 
	while(1)
	{
		object1 rotateroll(360, 1);
		wait(2);
		object1 rotateroll(-360, 1);
		wait(1);
		object2 rotateroll(360, 1);
		wait(2);
		object2 rotateroll(-360, 1);
		wait(1);
		object3 rotateroll(360, 1);
		wait(2);
		object3 rotateroll(-360, 1);
		wait(1);
	}
}

trap4()
{
	trig = getEnt( "trig_trap4", "targetname" );
	object1 = getent("trap4a","targetname");
	object2 = getent("trap4b","targetname");

	trig waittill ("trigger");
	trig delete();
	 
	while(1)
	{
		object1 rotateroll(360, 1);
		object2 rotateroll(360, 1);
		wait(2);
		object1 rotateroll(-360, 1);
		object2 rotateroll(-360, 1);
		wait(2);
	}
}

trap5()
{
	trig = getEnt( "trig_trap5", "targetname" );
	object1 = getent("trap5a","targetname");
	object2 = getent("trap5b","targetname");
	object3 = getent("trap5c","targetname");
	object4 = getent("trap5d","targetname");
	object5 = getent("trap5e","targetname");
	object6 = getent("trap5f","targetname");

	trig waittill ("trigger");
	trig delete();
	 
	while(1)
	{
		object1 rotateyaw(-720, 3);
		object2 rotateyaw(-720, 3);
		wait(5);
		object1 rotateyaw(720, 3);
		object2 rotateyaw(720, 3);
		wait(5);
		object3 rotateyaw(-720, 3);
		object4 rotateyaw(-720, 3);
		wait(5);
		object3 rotateyaw(720, 3);
		object4 rotateyaw(720, 3);
		wait(5);
		object5 rotateyaw(-720, 3);
		object6 rotateyaw(-720, 3);
		wait(5);
		object5 rotateyaw(720, 3);
		object6 rotateyaw(720, 3);
		wait(5);
	}
}

trap6()
{
	trig = getEnt( "trig_trap6", "targetname" );
	object1 = getent("trap6a","targetname");
	object2 = getent("trap6b","targetname");
	object3 = getent("trap6c","targetname");
	object4 = getent("trap6d","targetname");
	object5 = getent("trap6e","targetname");
	object6 = getent("trap6f","targetname");

	trig waittill ("trigger");
	trig delete();
	 
	while(1)
	{
		object1 rotatepitch(720, 1);
		object2 rotatepitch(-720, 1);
		object3 rotatepitch(720, 1);
		object4 rotatepitch(-720, 1);
		object5 rotatepitch(720, 1);
		object6 rotatepitch(-720, 1);
		wait(5);
		object1 rotatepitch(-720, 1);
		object2 rotatepitch(720, 1);
		object3 rotatepitch(-720, 1);
		object4 rotatepitch(720, 1);
		object5 rotatepitch(-720, 1);
		object6 rotatepitch(720, 1);
		wait(5);
	}
}

trap7()
{
	trig = getEnt( "trig_trap7", "targetname" );
	object = getent("trap7","targetname");

	trig waittill ("trigger");
	trig delete();
	 
	while(1)
	{
		object rotateyaw(360, 1);
		wait(2);
		object rotateyaw(-360, 1);
		wait(2);
	}
}

trap8()
{
	trig = getEnt( "trig_trap8", "targetname" );
	object1 = getent("trap8a","targetname");
	object2 = getent("trap8b","targetname");

	trig waittill ("trigger");
	trig delete();
	 
	while(1)
	{
		object1 movey(128, 1);
		object2 movey(-136, 1);
		wait(2);
		object1 movey(-128, 1);
		object2 movey(136, 1);
		wait(2);
	}
}

trap9()
{
	trig = getEnt( "trig_trap9", "targetname" );
	object = getent("trap9","targetname");

	trig waittill ("trigger");
	trig delete();
	 
	while(1)
	{
		object rotateroll(360, 1);
		wait(2);
		object rotateroll(-360, 1);
		wait(2);
	}
}

trap10()
{
	trig = getEnt( "trig_trap10", "targetname" );
	object1 = getent("trap10a","targetname");
	object2 = getent("trap10b","targetname");
	object3 = getent("trap10c","targetname");
	object4 = getent("trap10d","targetname");
	object5 = getent("trap10e","targetname");
	object6 = getent("trap10f","targetname");
	object7 = getent("trap10g","targetname");
	object8 = getent("trap10h","targetname");
	object9 = getent("trap10i","targetname");
	object10 = getent("trap10j","targetname");
 
	trig waittill ("trigger");
	trig delete();
	 
	while(1)
	{
		object1 rotateyaw(-720, 3);
		object2 rotateyaw(-720, 3);
		object3 rotateyaw(-720, 3);
		object4 rotateyaw(-720, 3);
		object5 rotateyaw(-720, 3);
		object6 rotateyaw(-720, 3);
		object7 rotateyaw(-720, 3);
		object8 rotateyaw(-720, 3);
		object9 rotateyaw(-720, 3);
		object10 rotateyaw(-720, 3);
		wait(5);
		object1 rotateyaw(720, 3);
		object2 rotateyaw(720, 3);
		object3 rotateyaw(720, 3);
		object4 rotateyaw(720, 3);
		object5 rotateyaw(720, 3);
		object6 rotateyaw(720, 3);
		object7 rotateyaw(720, 3);
		object8 rotateyaw(720, 3);
		object9 rotateyaw(720, 3);
		object10 rotateyaw(720, 3);
		wait(5);
	}
}

trap11()
{
	trig = getEnt( "trig_trap11", "targetname" );
	object = getent("trap11","targetname");
	 
	trig waittill ("trigger");
	trig delete();
	 
	while(1)
	{
		object rotateroll(360, 1);
		wait(3);
		object rotateroll(-360, 1);
		wait(3);
	}
}

trap12()
{
	trig = getEnt( "trig_trap12", "targetname" );
	object1 = getent("trap12a","targetname");
	object2 = getent("trap12b","targetname");
	object3 = getent("trap12c","targetname");
	object4 = getent("trap12d","targetname");
	 
	trig waittill ("trigger");
	trig delete();
	 
	while(1)
	{
		object1 rotateyaw(360, 1);
		object2 rotateyaw(360, 1);
		object3 rotateyaw(360, 1);
		object4 rotateyaw(360, 1);
		wait(2);
		object1 rotateyaw(-360, 1);
		object2 rotateyaw(-360, 1);
		object3 rotateyaw(-360, 1);
		object4 rotateyaw(-360, 1);
		wait(2); 
	}
}

trap13()
{
	trig = getEnt( "trig_trap13", "targetname" );
	object1 = getent("trap13a","targetname");
	object2 = getent("trap13b","targetname");
	object3 = getent("trap13c","targetname");
	object4 = getent("trap13d","targetname");
	object5 = getent("trap13e","targetname");
	object6 = getent("trap13f","targetname");
	object7 = getent("trap13g","targetname");
	object8 = getent("trap13h","targetname");
	object9 = getent("trap13i","targetname");
	object10 = getent("trap13j","targetname");
	object11 = getent("trap13k","targetname");
	object12 = getent("trap13l","targetname");
	object13 = getent("trap13lj","targetname");
	object14 = getent("trap13m","targetname");
	object15 = getent("trap13n","targetname");
	object16 = getent("trap13nj","targetname");

	trig waittill ("trigger");
	trig delete();
	 
	while(1)
	{
		object1 rotateyaw(-360, 3);
		object2 rotateyaw(-360, 3);
		object3 rotateyaw(-360, 3);
		object4 rotateyaw(-360, 3);
		object5 rotateyaw(-360, 3);
		object6 rotateyaw(-360, 3);
		object7 rotateyaw(-360, 3);
		object8 rotateyaw(-360, 3);
		object9 rotateyaw(-360, 3);
		object10 rotateyaw(-360, 3);
		object11 rotateyaw(-360, 3);
		object12 rotateyaw(-360, 3);
		object13 rotateyaw(-360, 3);
		object14 rotateyaw(-360, 3);
		object15 rotateyaw(-360, 3);
		object16 rotateyaw(-360, 3);
		wait(5);
		object1 rotateyaw(360, 3);
		object2 rotateyaw(360, 3);
		object3 rotateyaw(360, 3);
		object4 rotateyaw(360, 3);
		object5 rotateyaw(360, 3);
		object6 rotateyaw(360, 3);
		object7 rotateyaw(360, 3);
		object8 rotateyaw(360, 3);
		object9 rotateyaw(360, 3);
		object10 rotateyaw(360, 3);
		object11 rotateyaw(360, 3);
		object12 rotateyaw(360, 3);
		object13 rotateyaw(360, 3);
		object14 rotateyaw(360, 3);
		object15 rotateyaw(360, 3);
		object16 rotateyaw(360, 3);
		wait(5);
	}
}

trap14()
{
	trig = getEnt( "trig_trap14", "targetname" );
	object1 = getent("trap14a","targetname");
	object2 = getent("trap14b","targetname");

	trig waittill ("trigger");
	trig delete();
	 
	while(1)
	{
		object1 movey(-88, 1);
		object2 movey(88, 1);
		wait(2);
		object1 movey(88, 1);
		object2 movey(-88, 1);
		wait(2);
	}
}

trap15()
{
	trig = getEnt( "trig_trap15", "targetname" );
	object1 = getent("trap15a","targetname");
	object2 = getent("trap15b","targetname");
	object3 = getent("trap15c","targetname");
	object4 = getent("trap15d","targetname");

	trig waittill ("trigger");
	trig delete();
	 
	while(1)
	{
		object1 rotateroll(360, 1);
		wait(2);
		object1 rotateroll(-360, 1);
		wait(1);
		object2 rotateroll(360, 1);
		wait(2);
		object2 rotateroll(-360, 1);
		wait(1);
		object3 rotateroll(360, 1);
		wait(2);
		object3 rotateroll(-360, 1);
		wait(1);
		object4 rotateroll(360, 1);
		wait(2);
		object4 rotateroll(-360, 1);
		wait(1); 
	}
}

trap16()
{
	trig = getEnt( "trig_trap16", "targetname" );
	object1 = getent("trap16a","targetname");
	object2 = getent("trap16b","targetname");
	object3 = getent("trap16c","targetname");

	trig waittill ("trigger");
	trig delete();

	while(1)
	{
		object1 rotateyaw(360, 1);
		object2 rotateyaw(360, 1);
		object3 rotateyaw(360, 1);
		wait(2);
		object1 rotateyaw(-360, 1);
		object2 rotateyaw(-360, 1);
		object3 rotateyaw(-360, 1);
		wait(2);
	}
}

trap17()
{
	object = getent("trap17","targetname");

	while(1)
	{
		object movez(-40, 1);
		wait(1);
		object movez(40, 1);
		wait(1); 
	}
}


trap18()
{
	trig = getEnt( "trig_trap18a", "targetname" );
	object = getent("trap18b","targetname");
	 
	trig waittill ("trigger");
	trig delete();

	object movez(-128, 5);
}


trap19()
{
	trig = getEnt( "trig_trap19", "targetname" );
	object = getent("trap19b","targetname");

	trig waittill ("trigger");
	trig delete();

	object movez(-128, 5);
}

vrata1()
{
	trig = getEnt( "trig_trap25", "targetname" );
	object = getent("trap25","targetname");

	trig waittill ("trigger");
	trig delete();

	while(1)
	{
		object movez(-120, 5);
		wait(3);
	}
}

vrata2()
{
	trig = getEnt( "trig_trap26", "targetname" );
	object = getent("trap26","targetname");

	trig waittill ("trigger");
	trig delete();
	 
	while(1)
	{
		object movez(-120, 5);
		wait(3);
	}
}

vrata3()
{
	trig = getEnt( "trig_trap27", "targetname" );
	object = getent("trap27","targetname");

	trig waittill ("trigger");
	trig delete();
	 
	while(1)
	{
		object movez(-120, 5);
		wait(3);
	}
}

vrata4()
{
	trig = getEnt( "trig_trap28", "targetname" );
	object = getent("trap28","targetname");

	trig waittill ("trigger");
	trig delete();
	 
	while(1)
	{
		object movez(-120, 5);
		wait(3);
	}
}

// Credits
creator()
{
	while(1)
	{
		iprintln("^5Map ^7made by ^5Mr.Xx");
		wait 20;
		iprintln("^5Scripted^7 by ^5MadLion");
		wait 20;
		iprintln("^5Fixes^7 by ^5Blade");
		wait 20;
		iprintln("Visit ^5vistic^7-^5clan^7.^5com");
		wait 20;
	}
}

printCredits()
{
    if( isDefined( self.logoText ) )
        self.logoText destroy();
     
    self.logoText = newHudElem();
    self.logoText.y = 10;
    self.logoText.alignX = "center";
    self.logoText.alignY = "middle";
    self.logoText.horzAlign = "center_safearea";
    self.logoText.alpha = 0;
    self.logoText.sort = -3;
    self.logoText.fontScale = 1.6;
    self.logoText.archieved = true;
     
    for(;;)
    {
        self.logoText fadeOverTime(1);
        self.logoText.alpha = 1;
        self.logoText setText("^5Map ^7made by ^5Mr.Xx");
        wait 3;
        self.logoText fadeOverTime(1);
        self.logoText.alpha = 0;
        wait 1;
       	self.logoText fadeOverTime(1);
        self.logoText.alpha = 1;
        self.logoText setText("^5Scripted^7 by ^5MadLion");
        wait 3;
        self.logoText fadeOverTime(1);
        self.logoText.alpha = 0;
        wait 1;
        self.logoText fadeOverTime(1);
        self.logoText.alpha = 1;
        self.logoText setText("^5Fixes^7 by ^5Blade");
        wait 3;
        self.logoText fadeOverTime(1);
        self.logoText.alpha = 0;
        wait 1;
        self.logoText fadeOverTime(1);
        self.logoText.alpha = 1;
        self.logoText setText("Visit ^5vistic^7-^5clan^7.^5com");
        wait 3;
        self.logoText fadeOverTime(1);
        self.logoText.alpha = 0;
        wait 1;
        self.logoText fadeOverTime(1);
        self.logoText.alpha = 1;
        self.logoText setText("Deathrun ^5Apollo ^7(Final)");
        wait 3;
        self.logoText fadeOverTime(1);
        self.logoText.alpha = 0;
        wait 1;
    }      
}

// Secret
secretroom()
{
	trig=getEnt("secretdoortrig","targetname");
	object=getEnt("secretdoor","targetname");
	 
	trig waittill("trigger");
	if(level.trapsdisabled)
	{
		iprintlnbold("^5Something^7 seems broken");
		trig delete();
	}
	else
	{
		trig delete();
		wait 1;
		iPrintlnBold("^5Something^7 has been fixed");
		wait 60;
		ambientPlay("song2");
		object movez(-120,3);
		wait 2;  
	}
}

secret()
{
	trig = getEnt( "fuckingsecret", "targetname"); 
	targ = getEnt( "fuckingsecretroom", "targetname");
	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

// Others 
pad1()
{
  	trig = getEnt( "pod1", "targetname"); 
  	targ = getEnt( "povrat1", "targetname");

  	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

pad2()
{
  	trig = getEnt( "pod27", "targetname"); 
  	targ = getEnt( "povrat27", "targetname");

  	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

pad3()
{
  	trig = getEnt( "pod26", "targetname"); 
  	targ = getEnt( "povrat26", "targetname");

  	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

pad4()
{
  	trig = getEnt( "pod2", "targetname"); 
  	targ = getEnt( "povrat2", "targetname");

  	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

pad5()
{
 	trig = getEnt( "pod3", "targetname"); 
  	targ = getEnt( "povrat3", "targetname");

  	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

pad6()
{
  	trig = getEnt( "pod4", "targetname"); 
  	targ = getEnt( "povrat4", "targetname");

  	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

pad7()
{
  	trig = getEnt( "pod5", "targetname"); 
  	targ = getEnt( "povrat5", "targetname");

  	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

pad8()
{
  	trig = getEnt( "pod6", "targetname"); 
  	targ = getEnt( "povrat6", "targetname");

  	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

pad9()
{
  	trig = getEnt( "pod7", "targetname"); 
  	targ = getEnt( "povrat7", "targetname");

  	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

pad10()
{
  	trig = getEnt( "pod8", "targetname"); 
  	targ = getEnt( "povrat8", "targetname");

  	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

pad11()
{
  	trig = getEnt( "pod9", "targetname"); 
  	targ = getEnt( "povrat9", "targetname");

  	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

pad12()
{
  	trig = getEnt( "pod10", "targetname"); 
  	targ = getEnt( "povrat10", "targetname");

  	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

pad13()
{
  	trig = getEnt( "pod11", "targetname"); 
  	targ = getEnt( "povrat11", "targetname");

 	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

pad14()
{
  	trig = getEnt( "pod12", "targetname"); 
  	targ = getEnt( "povrat12", "targetname");

  	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

pad15()
{
  	trig = getEnt( "pod13", "targetname"); 
  	targ = getEnt( "povrat13", "targetname");

  	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

pad16()
{
  	trig = getEnt( "pod14", "targetname"); 
  	targ = getEnt( "povrat14", "targetname");

  	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

pad17()
{
  	trig = getEnt( "pod15", "targetname"); 
  	targ = getEnt( "povrat15", "targetname");

  	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

pad18()
{
  	trig = getEnt( "pod16", "targetname"); 
  	targ = getEnt( "povrat16", "targetname");

  	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

pad19()
{
 	trig = getEnt( "pod17", "targetname"); 
  	targ = getEnt( "povrat17", "targetname");

  	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

pad20()
{
  	trig = getEnt( "pod18", "targetname"); 
  	targ = getEnt( "povrat18", "targetname");

  	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

pad21()
{
  	trig = getEnt( "pod19", "targetname"); 
  	targ = getEnt( "povrat19", "targetname");

 	 for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

pad22()
{
  	trig = getEnt( "pod20", "targetname"); 
  	targ = getEnt( "povrat20", "targetname");

  	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

pad23()
{
  	trig = getEnt( "pod21", "targetname"); 
  	targ = getEnt( "povrat21", "targetname");

  	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

pad24()
{
  	trig = getEnt( "pod22", "targetname"); 
  	targ = getEnt( "povrat22", "targetname");

  	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

mapmusic()
{
	object1 = getent("trap23","targetname");
	level waittill("round_started");
	iprintln("^5Start Door^7 is opening");
	ambientplay("mapsong");
	wait 2;
	object1 movez(168, 7);
}

addTextHud( who, x, y, alpha, alignX, alignY, fontScale )
{
    if( isPlayer( who ) )
        hud = newClientHudElem( who );
    else
        hud = newHudElem();

    hud.x = x;
    hud.y = y;
    hud.alpha = alpha;
    hud.alignX = alignX;
    hud.alignY = alignY;
    hud.fontScale = fontScale;
    return hud;
}

automove1()
{
	object1 = getent("trap20a","targetname");
	object2 = getent("trap20b","targetname");
	object3 = getent("trap20c","targetname");
	object4 = getent("trap20d","targetname");
	object5 = getent("trap20e","targetname");
	object6 = getent("trap20f","targetname");
	object7 = getent("trap20g","targetname");
	object8 = getent("trap20h","targetname");
	object9 = getent("trap20i","targetname");
	object10 = getent("trap20j","targetname");
	object11 = getent("trap20k","targetname");
	object12 = getent("trap20l","targetname");

	while(1)
	{
		object1 rotateyaw(-720, 7);
		object2 rotateyaw(-720, 7);
		object3 rotateyaw(-720, 7);
		object4 rotateyaw(-720, 7);
		object5 rotateyaw(-720, 7);
		object6 rotateyaw(-720, 7);
		object7 rotateyaw(-720, 7);
		object8 rotateyaw(-720, 7);
		object9 rotateyaw(-720, 7);
		object10 rotateyaw(-720, 7);
		object11 rotateyaw(-720, 7);
		object12 rotateyaw(-720, 7);
		wait(3);
		object1 rotateyaw(720, 7);
		object2 rotateyaw(720, 7);
		object3 rotateyaw(720, 7);
		object4 rotateyaw(720, 7);
		object5 rotateyaw(720, 7);
		object6 rotateyaw(720, 7);
		object7 rotateyaw(720, 7);
		object8 rotateyaw(720, 7);
		object9 rotateyaw(720, 7);
		object10 rotateyaw(720, 7);
		object11 rotateyaw(720, 7);
		object12 rotateyaw(720, 7);
		wait(3);
	}
}

automove2()
{
	object1 = getent("trap21a","targetname");
	object2 = getent("trap21b","targetname");
	object3 = getent("trap21c","targetname");
	object4 = getent("trap21d","targetname");
	object5 = getent("trap21e","targetname");
	object6 = getent("trap21f","targetname");
	object7 = getent("trap21g","targetname");
	object8 = getent("trap21h","targetname");
	object9 = getent("trap21i","targetname");
	object10 = getent("trap21j","targetname");
	object11 = getent("trap21k","targetname");
	object12 = getent("trap21l","targetname");
	object13 = getent("trap21lj","targetname");
	object14 = getent("trap21m","targetname");
	object15 = getent("trap21n","targetname");
	object16 = getent("trap21nj","targetname");

	while(1)
	{
		object1 rotatepitch(720, 8);
		object2 rotatepitch(720, 8);
		object3 rotatepitch(720, 8);
		object4 rotatepitch(720, 8);
		object5 rotatepitch(720, 8);
		object6 rotatepitch(720, 8);
		object7 rotatepitch(720, 8);
		object8 rotatepitch(720, 8);
		object9 rotatepitch(720, 8);
		object10 rotatepitch(720, 8);
		object11 rotatepitch(720, 8);
		object12 rotatepitch(720, 8);
		object13 rotatepitch(720, 8);
		object14 rotatepitch(720, 8);
		object15 rotatepitch(720, 8);
		object16 rotatepitch(720, 8);
		wait(1);
		object1 rotatepitch(720, 8);
		object2 rotatepitch(720, 8);
		object3 rotatepitch(720, 8);
		object4 rotatepitch(720, 8);
		object5 rotatepitch(720, 8);
		object6 rotatepitch(720, 8);
		object7 rotatepitch(720, 8);
		object8 rotatepitch(720, 8);
		object9 rotatepitch(720, 8);
		object10 rotatepitch(720, 8);
		object11 rotatepitch(720, 8);
		object12 rotatepitch(720, 8);
		object13 rotatepitch(720, 8);
		object14 rotatepitch(720, 8);
		object15 rotatepitch(720, 8);
		object16 rotatepitch(720, 8);
		wait(1);
	}
}

automove3()
{
	object1 = getent("trap24a","targetname");
	object2 = getent("trap24b","targetname");
	object3 = getent("trap24c","targetname");
	object4 = getent("trap24d","targetname");

	while(1)
	{
		object1 movey(-40, 5);
		object4 movey(40, 5);
		wait(3);
		object1 movey(40, 5);
		object4 movey(-40, 5);
		wait(3);
		object3 movey(40, 5);
		object4 movey(-40, 5);
		wait(3);
		object1 movey(-40, 5);
		object2 movey(40, 5);
		wait(3);
	}
}

rooms()
{
	trig = getEnt( "finalroom", "targetname"); 
	targ = getEnt( "final", "targetname");

	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

rooms2()
{
  	trig = getEnt( "back", "targetname"); 
  	targ = getEnt( "back1", "targetname");

  	for(;;)
	{
		trig waittill("trigger",player);
			player tpto(targ);
	}
}

specialroomdisable()
{
	thread move1();
	thread move2();
	thread move3();
	thread move4();
	thread move5();
	thread move6();
	thread move7();
}

move1()
{
	object = getEnt( "special1a", "targetname" );
	wait 1;
	object delete();
}

move2()
{
	object1 = getEnt( "special2a", "targetname" );
	object2 = getEnt( "special2b", "targetname" );
	object3 = getEnt( "special2c", "targetname" );
	object4 = getEnt( "special2d", "targetname" );
	object5 = getEnt( "special2e", "targetname" );
	object6 = getEnt( "special2f", "targetname" );
	object7 = getEnt( "special2g", "targetname" );
	object8 = getEnt( "special2h", "targetname" );
	object9 = getEnt( "special2i", "targetname" );
	object10 = getEnt( "special2j", "targetname" );
	object11 = getEnt( "special2k", "targetname" );
	object12 = getEnt( "special2l", "targetname" );
	wait 1;
	object1 movez(-56, 1 );
	object2 movez(-40, 1 );
	object3 movez(-64, 1 );
	object4 movez(-80, 2 );
	object5 movez(-120, 2 );
	object6 movez(-96, 2 );
	object7 movez(-48, 3 );
	object8 movez(-72, 3 );
	object9 movez(-32, 3 );
	object10 movez(-104, 4 );
	object11 movez(-128, 4 );
	object12 movez(-152, 4 );
}

move3()
{
	object = getEnt( "special3a", "targetname" );
	wait 1;
	object delete();
}

move4()
{
	object = getEnt( "special4a", "targetname" );
	wait 1;
	object delete();
}

move5()
{
	object = getEnt( "special5a", "targetname" );
	wait 1;
	object delete();
}

move6()
{
	object = getEnt( "special6a", "targetname" );
	wait 1;
	object delete();
}

move7()
{
	object1 = getEnt( "special7a", "targetname" );
	object2 = getEnt( "special7b", "targetname" );
	object3 = getEnt( "special7c", "targetname" );
	object4 = getEnt( "special7d", "targetname" );
	wait 1;
	object1 movez(-88, 1 );
	object2 movez(-120, 2 );
	object3 movez(-96, 3 );
	object4 movez(-136, 4 );
}