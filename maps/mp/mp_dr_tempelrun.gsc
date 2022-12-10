main()
{

	maps\mp\mp_dr_templerun_fx::main();
	maps\createfx\mp_dr_templerun_fx::main();
	maps\mp\_load::main();

	precacheitem("remington700_mp");
	precacheitem("knife_mp");
	ambientplay("music");

	game["allies"] = "sas";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "woodland";
	game["axis_soldiertype"] = "woodland";
	
	setdvar( "r_specularcolorscale", "2" );
	
	setdvar("r_glowbloomintensity0",".25");
	setdvar("r_glowbloomintensity1",".25");
	setdvar("r_glowskybleedintensity0",".3");
	setdvar("compassmaxrange","1800");

	thread teleport();
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

	thread sniperroom();
	thread kniferoom();
	thread bounceroom();

}

teleport()
{       
 	entTransporter = getentarray( "enter", "targetname" );
	if(isdefined(entTransporter))
		for( i = 0; i < entTransporter.size; i++ )
			entTransporter[i] thread transporter();
}
 
transporter()
{
	for(;;)
	{
		self waittill( "trigger", player );
		entTarget = getEnt( self.target, "targetname" );
		wait 0.1;
		player setOrigin( entTarget.origin );
		player setplayerangles( entTarget.angles );
		wait 0.1;
	}
}

rotsaw(angle,time)
{
	for(;;)
	{
		self rotateroll(angle,time);
		wait time;
	}
}

trap1()
{
	doors = getEnt("trap1doors","targetname");

	pusher1 = getEnt("pusher1","targetname");
	pusher2 = getEnt("pusher2","targetname");

	killtrig1 = getEnt("killtrig1","targetname");
	killtrig2 = getEnt("killtrig2","targetname");

	killtrig1 enablelinkto();
	killtrig1 linkto(pusher1);

	killtrig2 enablelinkto();
	killtrig2 linkto(pusher2);

	trig = getEnt("trap1trig","targetname");
	trig waittill("trigger",player);
	trig delete();

	doors movez(-112,1);
	wait 1;
	pusher1 movex(240,3);
	pusher2 movex(-240,3);
	wait 5;
	pusher1 movex(-240,3);
	pusher2 movex(240,3);
	wait 2;
	doors movez(112,1);
	killtrig1 delete();
	killtrig2 delete();
}

trap2()
{
	roter = getEnt("trap2roter","targetname");
	trig = getEnt("trap2trig","targetname");
	trig waittill("trigger",player);
	trig delete();
	for(;;)
	{
		roter rotateyaw(180,3);
		wait 3;
	}
}


trap3()
{
	gunspike = getentarray("gunspike","targetname");
	gunspike_killtrigger = getentarray("gunspikekt","targetname");
	trig = getEnt("trap3trig","targetname");
	trig waittill("trigger",player);
	trig delete();
	for(i=0;i<gunspike.size;i++)
	{
		gunspike_killtrigger[i] enablelinkto();
		gunspike_killtrigger[i] linkto(gunspike[i]);
		gunspike[i] thread trap3doing();
		gunspike[i] notsolid();
	}
}

trap3doing()
{
	for(;;)
	{
		wait randomfloatrange(0.5,2.0);
		self movex(260,0.5);
		wait .5;
		self rotateyaw(180,0.1);
		wait randomfloatrange(0.5,2.0);
		self movex(-260,0.5);
		wait .5;
		self rotateyaw(180,0.1);
	}
}

trap4()
{
	trig = getent("trap4trig","targetname");
	bounce = getEnt("trapbounce","targetname");
	trig waittill("trigger",player);
	trig delete();
	x = randomint(3);
	switch(x)
	{
		case 0:
		bounce hide();
		wait randomint(5);
		bounce show();
		break;

		case 1:
		bounce notsolid();
		wait randomint(5);
		bounce solid();
		break;

		case 2:
		bounce notsolid();
		bounce hide();
		wait randomint(5);
		bounce show();
		bounce solid();
		break;
	}
}

trap5()
{
	trig = getEnt("trap5trig","targetname");
	trig waittill("trigger",player);
	trig delete();
	pillars = getentarray("trap5pillars","targetname");
	saws = getentarray("trap5saws","targetname");
	killtriggers = getentarray("trap5killtrigs","targetname");
	for(i=0;i<saws.size;i++)
	{
		saws[i] thread rotsaw(180,1);
		saws[i] enablelinkto();
		saws[i] linkto(pillars[i]);
		killtriggers[i] enablelinkto();
		killtriggers[i] linkto(saws[i]);
		pillars[i] thread trap5moves();
	}
}

trap5moves()
{
	x = randomint(2);
	if(x == 0)
	{
		for(;;)
		{
			self rotateroll(-20,2);
			wait 2;
			self rotateroll(20,2);
			wait 2;
			self rotateroll(20,2);
			wait 2;
			self rotateroll(-20,2);
			wait 2;
		}
	}
	if(x == 1)
	{
		for(;;)
		{
			self rotateroll(20,2);
			wait 2;
			self rotateroll(-20,2);
			wait 2;
			self rotateroll(-20,2);
			wait 2;
			self rotateroll(20,2);
			wait 2;
		}
	}
}

trap6()
{
	trig = getEnt("trap6trig","targetname");
	killtriger = getEnt("trap6killtrig","targetname");
	plat = getEnt("trap6","targetname");
	killtriger enablelinkto();
	killtriger linkto(plat);
	trig waittill("trigger",player);
	trig delete();
	plat movez(-144,2);
	wait 4;
	plat movez(144,2);
}

trap7()
{
	trig = getEnt("trap7trig","targetname");
	plat = getentarray("trap7plat","targetname");
	trig waittill("trigger",player);
	trig delete();
	for(i=0;i<plat.size;i++)
	{
		if(randomint(2) == 0)
			plat[i] notsolid();

		else
			plat[i] hide();
	}
}

trap8() //auto trigger trap
{
	spkiller = getentarray("spkiller","targetname");
	spkilltrig = getentarray("spkilltrig","targetname");
	for(i=0;i<spkiller.size;i++)
	{
		spkilltrig[i] enablelinkto();
		spkilltrig[i] linkto(spkiller[i]);

		x=randomint(3);

		if(x == 0)
		{
			//stays in place
		}
		if(x == 1)
		{
			spkiller[i] movey(64,1);
		}
		if(x == 2)
		{
			spkiller[i] movey(128,1);
		}
	}

	trig = getent("trap8trig","targetname");
	trig waittill("trigger",player);
	for(i=0;i<spkiller.size;i++)
	{
		spkiller[i] movez(208,1);
	}
}

trap9()
{
	window1 = getEnt("wind1","targetname");
	window2 = getEnt("wind2","targetname");
	killer1 = getEnt("killer1trig","targetname");
	killer2 = getEnt("killer2trig","targetname");

	window1 hide();
	window1 notsolid();
	window2 hide();
	window2 notsolid();

	killer1.origin = killer1.origin-(0,0,10000);
	killer2.origin = killer2.origin-(0,0,10000);

	trig = getEnt("trap9trig","targetname");
	trig waittill("trigger",player);

	killer1.origin = killer1.origin+(0,0,10000);
	killer2.origin = killer2.origin+(0,0,10000);
	window1 show();
	window1 solid();
	window2 show();
	window2 solid();

	wait randomint(10);

	killer1 delete();
	killer2 delete();
	window1 delete();
	window2 delete();
}

trap10()
{
	rocks = getentarray("rocks","targetname");
	killers = getentarray("r_killers","targetname");
	pos = getentarray("endpos","targetname");
	for(i=0;i<rocks.size;i++)
	{
		killers[i] enablelinkto();
		killers[i] linkto(rocks[i]);
	}

	trig = getent("trap10trig","targetname");
	trig waittill("trigger",player);

	for(i=0;i<rocks.size;i++)
	{
		rocks[i] movez(-160,2);
	}

	wait 2;

	for(i=0;i<rocks.size;i++)
	{
		x = randomint(3);
		rocks[i] moveto(pos[x].origin,7);
		rocks[i] thread rot();
	}
	wait 7;

	for(i=0;i<rocks.size;i++)
	{
		x = randomfloatrange(32,208);
		rocks[i] movey(x,1);
	}

	wait 1;

	for(i=0;i<rocks.size;i++)
	{
		rocks[i] movez(-96,1);
	}
}

rot()
{
	for(i=0;i<4;i++)
	{
		self rotateroll(180,3);
		wait 3;
	}
}

sniperroom()
{
	level.sniper_trig = getEnt("sniperroom","targetname");
	actiorigin = getEnt("s_and_k_acti","targetname");
	jumperorigin = getEnt("s_and_k_jumper","targetname");
	snipermodel = getEnt("snipermodel","targetname");
	knifemodel = getEnt("knifemodel","targetname");

	snipermodel thread rotmodel();
	knifemodel thread rotmodel();

	for(;;)
	{
		level.sniper_trig waittill("trigger",player);

		 // ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================

		if(isdefined(level.knife_trig) || isdefined(level.bounce_trig))
		{
			level.knife_trig delete();
			level.bounce_trig delete();
		}

		player freezeControls(true);
		player setOrigin(jumperorigin.origin);
		player setplayerangles(jumperorigin.angles);
		player takeallweapons();
		player giveweapon("remington700_mp");
		player switchtoweapon("remington700_mp");
		player givemaxammo("remington700_mp");
		if(isdefined(level.activ))
		{
			level.activ freezeControls(true);
			level.activ setOrigin(actiorigin.origin);
			level.activ setplayerangles(actiorigin.angles);
			level.activ takeallweapons();
			level.activ giveweapon("remington700_mp");
			level.activ switchtoweapon("remington700_mp");
			level.activ givemaxammo("remington700_mp");
		}

		wait 2;

		level.activ freezeControls(false);
		player freezeControls(false);

		while(player.sessionstate == "playing" && isalive(player) && isdefined(player))
			wait .01;

	}
}

kniferoom()
{
	level.knife_trig = getEnt("kniferoom","targetname");
	actiorigin = getEnt("s_and_k_acti","targetname");
	jumperorigin = getEnt("s_and_k_jumper","targetname");

	for(;;)
	{
		level.knife_trig waittill("trigger",player);

		 // ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================

		if(isdefined(level.sniper_trig) || isdefined(level.bounce_trig))
		{
			level.sniper_trig delete();
			level.bounce_trig delete();
		}

		player freezeControls(true);
		player setOrigin(jumperorigin.origin);
		player setplayerangles(jumperorigin.angles);
		player takeallweapons();
		player giveweapon("knife_mp");
		player switchtoweapon("knife_mp");
		if(isdefined(level.activ))
		{
			level.activ freezeControls(true);
			level.activ setOrigin(actiorigin.origin);
			level.activ setplayerangles(actiorigin.angles);
			level.activ takeallweapons();
			level.activ giveweapon("knife_mp");
			level.activ switchtoweapon("knife_mp");
		}

		wait 2;

		level.activ freezeControls(false);
		player freezeControls(false);

		while(player.sessionstate == "playing" && isalive(player) && isdefined(player))
			wait .01;

	}
}

rotmodel()
{
	for(;;)
	{
		self rotateyaw(180,2);
		wait 2;
	}
}

bounceroom()
{
	level.bounce_trig = getEnt("bounceroom","targetname");
	actiorigin = getEnt("bounce_acti_enter","targetname");
	jumperorigin = getEnt("bounce_jumper_enter","targetname");
	snipmodel = getEnt("bsnipmodel","targetname");
	snipmodel thread rotmodel();
	thread bounce_failtrigger();
	thread bounce_weapon();
	for(;;)
	{
		level.bounce_trig waittill("trigger",player);

		 // ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================

		if(isdefined(level.sniper_trig) || isdefined(level.knife_trig))
		{
			level.sniper_trig delete();
			level.knife_trig delete();
		}

		player freezeControls(true);
		player setOrigin(jumperorigin.origin);
		player setplayerangles(jumperorigin.angles);
		player takeallweapons();
		player giveweapon("knife_mp");
		player switchtoweapon("knife_mp");
		if(isdefined(level.activ))
		{
			level.activ freezeControls(true);
			level.activ setOrigin(actiorigin.origin);
			level.activ setplayerangles(actiorigin.angles);
			level.activ takeallweapons();
			level.activ giveweapon("knife_mp");
			level.activ switchtoweapon("knife_mp");
		}

		wait 2;

		level.activ freezeControls(false);
		player freezeControls(false);

		while(player.sessionstate == "playing" && isalive(player) && isdefined(player))
			wait .01;

	}
}

bounce_failtrigger()
{
	trig = getEnt("bounce_failtrigger","targetname");
	actiorigin = getEnt("bounce_acti","targetname");
	jumperorigin = getEnt("bounce_jumper","targetname");
	for(;;)
	{
		trig waittill("trigger",player);
		if(player.pers["team"] != "spectator")
		{
			if(player.pers["team"] == "allies")
			{
				player setOrigin(jumperorigin.origin);
				player setplayerangles(jumperorigin.angles);
			}
			else
			{
				player setOrigin(actiorigin.origin);
				player setplayerangles(actiorigin.angles);
			}
		}
		wait .1;
	}
}

bounce_weapon()
{
	trig = getEnt("bounce_weapon","targetname");
	for(;;)
	{
		trig waittill("trigger",player);
		player giveweapon("remington700_mp");
		player switchtoweapon("remington700_mp");
		player givemaxammo("remington700_mp");
		wait 1;
	}
}