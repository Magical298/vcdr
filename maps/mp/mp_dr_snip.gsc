main()
{
	maps\mp\_load::main();

	game["allies"] = "sas";
	game["axis"] = "russian";
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["allies_soldiertype"] = "woodland";
	game["axis_soldiertype"] = "woodland";

	thread make_usp_only();
	thread create_on_start();
	thread give_r700_end();
	thread create_boost_end();
	thread snip_traps();
	thread secrets();
	thread jumper();

	entTransporter = getentarray("enter","targetname");
	if(isdefined(entTransporter))
	{
		for( i = 0; i < entTransporter.size; i++ )
			entTransporter[i] thread transporter();
	}
}

transporter()
{
	for(;;)
    {
		self waittill( "trigger", player );
		entTarget = getEnt( self.target, "targetname" );
		wait 0.3;
		player setOrigin( entTarget.origin );
		player setplayerangles( entTarget.angles );
		wait 0.3;
    }
}

make_usp_only()
{
    level endon("endmap");

    trig = spawn( "trigger_radius", (-1062.31, -797.334, -15.375), 0, 200, 200 );

    for(;;)
    {
        trig waittill("trigger",who);
        if(who.pers["team"] != "spectator")
        {   
        	wait 1;
            if(who.pers["team"] == "allies" && !who hasweapon("usp_mp"))
            {
            	who takeallweapons();
            	who giveweapon("usp_mp");
            	who givemaxammo("usp_mp");
            	who switchtoweapon("usp_mp");
            }
        }
    }
}

give_r700_end()
{
	trig = getent("weap1","targetname");

	for(;;)
	{
		trig waittill("trigger",who);
		if(!who hasweapon("remington700_mp"))
        {
            who takeallweapons();
	        who giveweapon("remington700_mp");
	        who switchtoweapon("remington700_mp");
	        who givemaxammo("remington700_mp");
        }
	}
}

create_on_start()
{
	level waittill("round_started");

	p = getentarray("player","classname");
	for(i=0;i<p.size;i++)
	{
		p[i] playlocalsound("joker");
		if(p[i].pers["team"] == "axis")
		{
			p[i].maxhealth = 500;
			p[i].health = p[i].maxhealth;
		}
	}
	iprintlnbold("^3Escape from the ^1Activator^2!");

	while(1)
	{
		iprintln("^1>> ^7Mapname: ^5"+getdvar("mapname"));
		wait 10;
		iprintln("^1>> ^7Map Fixes: ^5Blade");
		wait 10;
		iprintln("^1>> ^7Visit: ^5vistic-clan.net");
		wait 10;
	}
}

create_boost_end()
{
	trig = getent("speed8","targetname");

	for(;;)
	{
		trig waittill("trigger",who);

		// ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(who))
			continue;
		// =====================================

		if(!isdefined(level.snip_first))
		{
			level.snip_first = true;
			who braxi\_rank::giverankxp(undefined,150);
			who setMoveSpeedScale(1.4);
			iprintlnbold("^3"+who.name+" escaped the ^1Activator ^2first!");
		}
		who setmovespeedscale(1.2);
	}
}

snip_traps()
{
	thread trap_1();
	thread trap_2();
	thread trap_3();
}

trap_1()
{
	trig = getent( "trap8trigger", "targetname" );
	brush = getent( "trap8", "targetname" );

	trig waittill("trigger");
	trig delete();

	brush moveX( -8000, 20 );
	iprintlnbold("^3Death Machine detected ^1Movement^2!");
}

trap_2()
{
	trig = getEnt("freeze", "targetname");
	prop1 = getent ("prop1" ,"targetname" );
	prop2 = getent ("prop2" ,"targetname" );

	trig waittill("trigger", player);
	trig delete();

	player iprintlnbold("^3You ran into the ^3Freeze Machine^2!");
	player freezeControls( true );
	prop1 moveZ (-20 , 2);
	prop2 moveZ (-20 , 2);
	wait 2.1;
	prop1 moveY (100 , 2);
	prop2 moveY (-100 , 2);
	wait 5;
	player freezeControls( false );
	prop1 moveY (-100 , 2);
	prop2 moveY (100 , 2);
	wait 2.1;
	prop1 moveZ (20 , 2);
	prop2 moveZ (20 , 2);
}

trap_3()
{
	trig = getEnt( "trigger3", "targetname" );
	brush1 = getEnt( "block1", "targetname" );
	brush2 = getEnt( "block2", "targetname" );
	brush3 = getEnt( "block3", "targetname" );
	brush4 = getEnt( "block4", "targetname" );
	brush5 = getEnt( "block5", "targetname" );
	brush6 = getEnt( "block6", "targetname" );
						
	trig waittill("trigger");
	trig delete();
	
	iprintlnbold ("^3Security Camera detected ^1Movement^2!");
	
	while(1)
	{
		brush1 moveX( -200, 1 );
		brush2 moveX( -200, 1 );
		brush3 moveX( -200, 1 );
		brush4 moveX( 200, 1 );
		brush5 moveX( 200, 1 );
		brush6 moveX( 200, 1 );
		wait 1;
		brush1 moveX( 200, 1 );
		brush2 moveX( 200, 1 );
		brush3 moveX( 200, 1 );
		brush4 moveX( -200, 1 );
		brush5 moveX( -200, 1 );
		brush6 moveX( -200, 1 );
		wait 1;
	}
}

secrets()
{
	thread toggle_speed_1();
	thread toggle_speed_2();
	thread toggle_speed_3();

	thread turbo_boost();
	thread toggle_gravity();
}

toggle_speed_1()
{
	trig = getent("speed","targetname");

	trig waittill("trigger",who);
	trig delete();

	who setmovespeedscale(1.5);
}

toggle_speed_2()
{
	trig = getent("speed2","targetname");

	trig waittill("trigger",who);
	trig delete();

	who setmovespeedscale(0.1);
}

toggle_speed_3()
{
	trig = getent("speed1","targetname");

	trig waittill("trigger",who);
	trig delete();

	who setmovespeedscale(1.1);
}

turbo_boost()
{
	trig = getent("pes","targetname");

	trig waittill("trigger",who);
	trig delete();

	iprintlnbold("^3"+who.name+" has discovered the ^1Turbo Boost^2!");

	wait 5;
	who iprintlnbold("^3Turbo Boost has been ^1activated^2!");
	who setMoveSpeedScale(8);

	wait 3;
	who iprintlnbold("^3Turbo Boost is ^1over^2!");
	who setMoveSpeedScale(1);
}

toggle_gravity()
{
	trig = getent("gravity","targetname");

	trig waittill("trigger",who);
	trig delete();

	iprintlnbold("^3"+who.name+" has discovered the ^1Low Gravity Ladder^2!");
	setdvar("g_gravity",300);
}

jumper()
{
	jumpx = getent ("jump","targetname");
	glow = getent ("glow","targetname");
	air1 = getent ("air1","targetname");
	air2 = getent ("air2","targetname");
	air3 = getent ("air3","targetname");
	air4 = getent ("air4","targetname");

	level._effect[ "beacon_glow" ] = loadfx( "misc/ui_pickup_available" );
	maps\mp\_fx::loopfx("beacon_glow", (glow.origin), 3, (glow.origin) + (0, 0, 90));

	time = 1;
	for(;;)
	{
		jumpx waittill ("trigger",user);
		if (user istouching(jumpx))
		{
			//throw = user.origin + (100, 100, 0);
			air = spawn ("script_model",(0,0,0));
			air.origin = user.origin;
			air.angles = user.angles;
			user linkto (air);
			air moveto (air1.origin, time);
			wait 1;
			air moveto (air2.origin, time);
			wait .5;
			air moveto (air3.origin, time);
			wait .5;
			air moveto (air4.origin, time);
			wait 1;
			user unlink();
			wait 1;
		}
	}
}

