main()
{
	level._effect["map"] = loadfx( "xm/start" );
	
	maps\mp\_load::main();

	precacheItem("ak47_mp");
	precacheItem("ak74u_mp");
	precacheItem("g3_mp");
	precacheItem("m21_mp");
	precacheItem("mp5_mp");
	precacheItem("p90_mp");
	precacheItem("rpg_mp");
	precacheItem("deserteagle_mp");
	precacheItem("remington700_mp");
	precacheItem("m40a3_mp");
	precacheshader("deathrun");
	
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
	setdvar("compassmaxrange","1800");
	setDvar("bg_falldamagemaxheight", "99999" );
	setDvar("bg_falldamageminheight", "99998" );

	addTriggerToList( "trap1_trig" );
	addTriggerToList( "trap2_trig" );
	addTriggerToList( "trap3_trig" );
	addTriggerToList( "trap4_trig" );
	addTriggerToList( "trap5trig" );
	addTriggerToList( "trap6trig" );
	addTriggerToList( "trap7trig" );
	addTriggerToList( "trap8trig" );
	addTriggerToList( "trap9trig" );
	addTriggerToList( "trap10trig" );
	addTriggerToList( "trap11trig" );
	addTriggerToList( "trap12trig" );
	addTriggerToList( "trap13trig" );
	addTriggerToList( "trap14trig" );
	addTriggerToList( "trap15trig" );

	thread teleporter();

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
	thread trap14();
	thread trap15();
	thread spiner1();
	thread spiner2();
	thread startele();
	thread sniperoom();
	thread kniferoom();
	thread bounceroom();
	thread weaponroom();
	thread musictrig();
	thread exitsecret();

	level waittill("round_started");
	PlayFX(level._effect["map"],(-224, 288, 520));
	PlayFX(level._effect["map"],(-896, -384, 104));
	PlayFX(level._effect["map"],(-896, 896, 104));
	PlayFX(level._effect["map"],(448, 896, 104));
	PlayFX(level._effect["map"],(448, -384, 104));
	x = randomint(4);
	switch(x)
	{
		case 0:
		ambientplay("music1");
		break;
		case 1:
		ambientplay("music2");
		break;
		case 2:
		ambientplay("music3");
		break;
		case 3:
		ambientplay("music4");
		break;
	}
}

spiner1()
{
	object1 = getent("up","targetname");
	for(;;)
	{
		object1 moveZ(560,5);
		object1 waittill("movedone");
		wait .1;
		object1 moveZ(-560,5);
		object1 waittill("movedone");
		wait .1;
	}
}

spiner2()
{
	object2 = getent("down","targetname");
	while(1)
	{
		object2 moveZ(-560,5);
		object2 waittill("movedone");
		wait .1;
		object2 moveZ(560,5);
		object2 waittill("movedone");
		wait .1;
	}
}

teleporter()
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



addTriggerToList( name )
{
    if( !isDefined( level.trapTriggers ) )
        level.trapTriggers = [];
    level.trapTriggers[level.trapTriggers.size] = getEnt( name, "targetname" );
}

startele()
{
	object = getent("startele","targetname");
	for(;;)
	{
		wait 15;
		object moveZ(-1016,4);
		object waittill("movedone");
		wait 6;
		object moveZ(1016,4);
		object waittill("movedone");
	}
}

trap1()
{
trigger = getent("trap1_trig","targetname");
trigger sethintstring("Press ^1[USE]^7 To Activate");
level.wallpush = getent("trap1","targetname");
killtrigger = getent ("trap1_killtrig" , "targetname");
trigger waittill ("trigger" , player );
trigger delete();
{
killtrigger enablelinkto ();
killtrigger linkto (level.wallpush);
level.wallpush moveY(-672, 1);
level.wallpush waittill("movedone");
level.wallpush delete();
killtrigger delete();
}
}

trap2()
{
	trig = getent("trap2_trig","targetname");
	trig sethintstring("Press ^1[USE]^7 To Activate");
	object = getent("trap2","targetname");
	trig waittill("trigger", user );
	trig delete();
	{
		object notsolid();
		object hide();
		wait 3;
		object show();
		object solid();
		wait 1;
		object notsolid();
		object hide();
		wait 4;
		object show();
		object solid();
	}
}

trap3()
{
	trig = getent("trap3_trig","targetname");
	trig sethintstring("Press ^1[USE]^7 To Activate");
	object1 = getent("trap3_1","targetname");
	object2 = getent("trap3_2","targetname");
	object3 = getent("trap3_3","targetname");
	object4 = getent("trap3_4","targetname");
	trig waittill("trigger", user );
	trig delete();
	while(1)
	{
		object1 rotatePitch(360, 3);
		object2 rotatePitch(-360, 3);
		object3 rotatePitch(360, 3);
		object4 rotatePitch(-360, 3);
		wait .05;
	}
}

trap4()
{
	trig = getent("trap4_trig","targetname");
	trig sethintstring("Press ^1[USE]^7 To Activate");
	object = getent("trap4","targetname");
	killtrigger = getent ("trap4_killtrig" , "targetname");
	trig waittill("trigger", user );
	trig delete();
	{
		killtrigger enablelinkto ();
		killtrigger linkto (object);
		object rotateRoll(360, 4);
		wait 4.1;
		object rotateRoll(360, 4);
	}
}

trap5()
{
	wall = getent("trap5wall","targetname");
	killtrig = getent("killtrig5","targetname");
	trig = getent("trap5trig","targetname");
	trig waittill("trigger",player);
	trig delete();
	killtrig enablelinkto();
	killtrig linkto(wall);
	wall movex(-944,3);
	wait 4;
	wall delete();
	killtrig delete();
}

trap6()
{
	plat1 = getent("plat1","targetname");
	plat2 = getent("plat2","targetname");
	trig = getent("trap6trig","targetname");
	trig waittill("trigger",player);
	trig delete();
	plat1 rotateyaw(180,2);
	plat2 rotateyaw(-180,2);
	wait 3;
	plat1 movez(80,1);
	plat2 movez(80,1);
}

trap7()
{
	plat = getent("trap7","targetname");
	trig = getent("trap7trig","targetname");
	trig waittill("trigger",player);
	trig delete();
	for(;;)
	{
		plat rotateyaw(360,2);
		wait 3;
		plat rotateyaw(-360,2);
		wait 3;
	}
}

trap8()
{
	plat = getent("trap8","targetname");
	trig = getent("trap8trig","targetname");
	trig waittill("trigger",player);
	trig delete();
	for(;;)
	{
		x = randomint(2);
		if( x == 1)
		{
			plat rotatePitch(360,4);
		}
		else
		{
			plat rotatePitch(-360,4);
		}
		wait 4;
	}
}

trap9()
{
	plat1 = getent("trap91","targetname");
	plat2 = getent("trap92","targetname");
	plat3 = getent("trap93","targetname");
	trig = getent("trap9trig","targetname");
	trig waittill("trigger",player);
	trig delete();
	x = randomint(5);
	switch(x)
	{
		case 0:
		plat1 delete();
		break;

		case 1:
		plat2 delete();
		break;

		case 2:
		plat3 delete();
		break;

		case 3:
		plat1 delete();
		plat2 delete();
		break;

		case 4:
		plat2 delete();
		plat3 delete();
		break;
	}
}

trap10()
{
	pillar1 = getent("pillar1","targetname");
	pillar2 = getent("pillar2","targetname");
	trig = getent("trap10trig","targetname");
	trig waittill("trigger",player);
	trig delete();
	x = randomint(2);
	if(x == 1)
	{
		pillar1 delete();
	}
	else
	{
		pillar2 delete();
	}
}

trap11()
{
	way1 = getent("way1","targetname");
	way2 = getent("way2","targetname");
	trig = getent("trap11trig","targetname");
	trig waittill("trigger",player);
	trig delete();
	x = randomint(2);
	if(x == 1)
	{
		way1 delete();
	}
	else
	{
		way2 delete();
	}
}

trap12()
{
	roter = getent("trap12","targetname");
	kill = getent("trap12kill","targetname");
	kill enablelinkto();
	kill linkto(roter);
	trig = getent("trap12trig","targetname");
	trig waittill("trigger",player);
	trig delete();
	for(;;)
	{
		x = randomint(2);
		if(x == 1)
		{
			roter rotateyaw(360,2);
		}
		else
		{
			roter rotateyaw(-360,2);
		}
		wait 2;
	}
}

trap13()
{
	flor1 = getent("flor1","targetname");
	flor2 = getent("flor2","targetname");
	trig = getent("trap13trig","targetname");
	trig waittill("trigger",player);
	trig delete();
	flor1 delete();
	flor2 delete();
}

movingbrick()
{
	level.brick = getent("movingbrick","targetname");
	for(;;)
	{
		level.brick movey(640,3);
		wait 3;
		level.brick movey(-640,3);
		wait 3;
	}
}

trap14()
{
	trig = getent("trap14trig","targetname");
	thread movingbrick();
	trig waittill("trigger",player);
	trig delete();
	level.brick notsolid();
	wait randomint(5);
	level.brick solid();
}

trap15()
{
	trig = getent("trap15trig","targetname");
	flor1 = getent("flor151","targetname");
	flor2 = getent("flor152","targetname");
	flor3 = getent("flor153","targetname");
	flor4 = getent("flor154","targetname");
	trig waittill("trigger",player);
	trig delete();
	x = randomint(9);
	switch(x)
	{
		case 0:
		flor1 notsolid();
		break;

		case 1:
		flor2 notsolid();
		break;

		case 2:
		flor3 notsolid();
		break;

		case 3:
		flor4 notsolid();
		break;

		case 4:
		flor1 notsolid();
		flor2 notsolid();
		break;

		case 5:
		flor2 notsolid();
		flor3 notsolid();
		break;

		case 6:
		flor3 notsolid();
		flor4 notsolid();
		break;

		case 7:
		flor1 notsolid();
		flor4 notsolid();
		break;

		case 8:
		flor2 notsolid();
		flor4 notsolid();
		break;
	}
}

sniperoom()
{
	level.snipe_trig = getent("sniper","targetname");
	level.snipe_trig sethintstring("^1> Sniper Room <");
	jump = getent ("jump_sniper","targetname");
	acti = getent ("acti_sniper","targetname");
	while(1)
	{
		level.snipe_trig waittill( "trigger", player );
			
        if( !isDefined( level.snipe_trig ) )
            return;

		 // ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================

        if(level.firstenter==true)
		{
 		level.bounce_trig delete();
		level.weapon_trig delete();
		level.knife_trig delete();
		level.firstenter=false;
		}
		player thread roomanauncer("Sniper Room");
			player freezeControls(true);
			level.activ freezeControls(true);
			player setPlayerangles( jump.angles );
			player setOrigin ( jump.origin );
			player TakeAllWeapons();
			player GiveWeapon("remington700_mp");
			player GiveMaxAmmo("remington700_mp");
			player GiveWeapon("m40a3_mp");
			player GiveMaxAmmo("m40a3_mp");
			wait .05;
			level.activ setPlayerangles( acti.angles );
			level.activ setOrigin( acti.origin );
			level.activ TakeAllWeapons();
			level.activ GiveWeapon("remington700_mp");
			level.activ GiveMaxAmmo("remington700_mp");
			level.activ GiveWeapon("m40a3_mp");
			level.activ GiveMaxAmmo("m40a3_mp");
			wait 4;
			player switchToWeapon("remington700_mp");
			level.activ switchToWeapon("remington700_mp");
			player freezeControls(false);
			level.activ freezeControls(false);
			while( isAlive( player ) && isDefined( player ) )
			wait .05;
	}
}

kniferoom()
{
	level.knife_trig = getent("knife","targetname");
	level.knife_trig sethintstring("^1> Knife Room <");
	jump = getent ("jump_knife","targetname");
	acti = getent ("acti_knife","targetname");
	while(1)
	{
		level.knife_trig waittill( "trigger", player );
				
        if( !isDefined( level.knife_trig ) )
            return;

		 // ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================

        if(level.firstenter==true)
		{
 		level.bounce_trig delete();
		level.weapon_trig delete();
		level.snipe_trig delete();
		level.firstenter=false;
		}
		player thread roomanauncer("Knife Room");
			player freezeControls(true);
			level.activ freezeControls(true);
			player setPlayerangles( jump.angles );
			player setOrigin ( jump.origin );
			player TakeAllWeapons();
			player GiveWeapon("knife_mp");
			wait .05;
			level.activ setPlayerangles( acti.angles );
			level.activ setOrigin( acti.origin );
			level.activ TakeAllWeapons();
			level.activ GiveWeapon("knife_mp");
			wait 3;
			player switchToWeapon("knife_mp");
			level.activ switchToWeapon("knife_mp");
			player freezeControls(false);
			level.activ freezeControls(false);
			while( isAlive( player ) && isDefined( player ) )
			wait .05;
	}
}

weaponroom()
{
    level.weapon_trig = getEnt( "weapon", "targetname");
    jump = getEnt( "jumper_wep", "targetname" );
    acti = getEnt( "acti_wep", "targetname" );
    level.weapon_trig sethintstring("^1> Weapon Room <");
    
    while(1)
    {
        level.weapon_trig waittill( "trigger", player );
				
        if( !isDefined( level.weapon_trig ) )
            return;

		 // ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================

			
		if(level.firstenter==true)
		{
		level.bounce_trig delete();
		level.snipe_trig delete();
		level.knife_trig delete();
		level.firstenter=false;
		}
		player thread roomanauncer("Weapon Room");
        player SetPlayerAngles( jump.angles );
        player setOrigin( jump.origin );
		player TakeAllWeapons();
        level.activ setPlayerangles( acti.angles );
        level.activ setOrigin( acti.origin );
		level.activ TakeAllWeapons();
	 	player freezeControls(true);
		level.activ freezeControls(true);
        player thread weaponromo_weapons();
        level.activ thread weaponromo_weapons();
        wait 4;
        player freezeControls(false);
		level.activ freezeControls(false);
        while( isAlive( player ) && isDefined( player ) )
        wait 1;
    }
}

weaponromo_weapons()
{
	random = randomint(10);

	switch(random)
	{
		case 0:
				self giveWeapon("ak47_mp");
				self switchToWeapon("ak47_mp");
				break;	
		case 1:	
				self giveWeapon("ak74u_mp");
				self switchToWeapon("ak74u_mp");
				break;
		case 2:
				self giveWeapon("g3_mp");
				self switchToWeapon("g3_mp");
				break;
		case 3:
				self giveWeapon("m21_mp");
				self switchToWeapon("m21_mp");
				break;
		case 4:
				self giveWeapon("mp5_mp");
				self switchToWeapon("mp5_mp");
				break;
		case 5:
				self giveWeapon("deserteagle_mp");
				self switchToWeapon("deserteagle_mp");
				break;
		case 6:
				self giveWeapon("remington700_mp");
				self switchToWeapon("remington700_mp");
				break;
		case 7:
				self giveWeapon("knife_mp");
				self switchToWeapon("knife_mp");
				break;
		case 8:
				self giveWeapon("p90_mp");
				self switchToWeapon("p90_mp");
				break;
		case 9:
				self giveWeapon("rpg_mp");
				self switchToWeapon("rpg_mp");
				break;
	}

}

bounceroom()
{
	level.bounce_trig = getent("bounce","targetname");
	level.bounce_trig sethintstring("^1> Bounce Room <");
	jump = getent ("jump_bounce","targetname");
	acti = getent ("acti_bounce","targetname");
	thread bouncefailtrig();
	thread bouncesniper();
	while(1)
	{
		level.bounce_trig waittill( "trigger", player );
				
        if( !isDefined( level.bounce_trig ) )
            return;

		 // ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================
		
        if(level.firstenter==true)
		{
		level.knife_trig delete();
		level.weapon_trig delete();
		level.snipe_trig delete();
		level.firstenter=false;
		}
			player thread roomanauncer("Bounce Room");
			player freezeControls(true);
			level.activ freezeControls(true);
			player setPlayerangles( jump.angles );
			player setOrigin ( jump.origin );
			player TakeAllWeapons();
			player GiveWeapon("knife_mp");
			wait .05;
			level.activ setPlayerangles( acti.angles );
			level.activ setOrigin( acti.origin );
			level.activ TakeAllWeapons();
			level.activ GiveWeapon("knife_mp");
			wait 4;
			player switchToWeapon("knife_mp");
			level.activ switchToWeapon("knife_mp");
			player freezeControls(false);
			level.activ freezeControls(false);
			while( isAlive( player ) && isDefined( player ) )
			wait .05;
	}
}

bouncefailtrig()
{
	trig = getent("bft","targetname");
	jump = getent ("jump_bounce","targetname");
	acti = getent ("acti_bounce","targetname");
	for(;;)
	{
		trig waittill("trigger",player);
		if(player == player)
		{
			player setOrigin(jump.origin);
			player setPlayerangles(jump.angles);
		}
		if(player == level.activ)
		{
			level.activ setOrigin(acti.origin);
			level.activ setPlayerangles(acti.angles);
		}
		wait .1;
	}
}

bouncesniper()
{
	model = getent("bs","targetname");
	model thread rot();
	trig = getent("bst","targetname");
	trig sethintstring("^2Press [&&1]");
	for(;;)
	{
		trig sethintstring("Press [&&1]");
		trig waittill("trigger",player);
		player giveWeapon("remington700_mp");
		player switchToWeapon("remington700_mp");
		player GiveMaxAmmo("remington700_mp");
		for(i=5;i>=1;i--)
		{
			trig sethintstring("^1[Wait]: "+i);
			wait 1;
		}
		wait .1;
	}
}

rot()
{
	for(;;)
	{
		self rotateyaw(360,3);
		wait 3;
	}
}

roomanauncer(room)
{
	r = randomfloatrange(0.0,1.0);
	g = randomfloatrange(0.0,1.0);
	b = randomfloatrange(0.0,1.0);

	roomanauncer = NewHudElem();
	roomanauncer.alignX = "center";
	roomanauncer.alignY = "middle";
	roomanauncer.horzalign = "center";
	roomanauncer.vertalign = "middle";
	roomanauncer.alpha = 1;
	roomanauncer.x = 0;
	roomanauncer.y = -200;
	roomanauncer.font = "default";
	roomanauncer.fontscale = 2.5;
	roomanauncer.glowalpha = 1;
	roomanauncer.glowcolor = (r,g,b);
	roomanauncer settext(room);
	roomanauncer SetPulseFX( 40, 6800, 200 );

	roomanauncernames = NewHudElem();
	roomanauncernames.alignX = "center";
	roomanauncernames.alignY = "middle";
	roomanauncernames.horzalign = "center";
	roomanauncernames.vertalign = "middle";
	roomanauncernames.alpha = 1;
	roomanauncernames.x = 0;
	roomanauncernames.y = -150;
	roomanauncernames.font = "default";
	roomanauncernames.fontscale = 1.8;
	roomanauncernames.glowalpha = 1;
	roomanauncernames.glowcolor = (r,g,b);
	roomanauncernames settext(self.name);
	roomanauncernames SetPulseFX( 40, 1500, 200 );	
	wait 1.6;
	roomanauncernames settext("^1VS");
	roomanauncernames SetPulseFX( 40, 1000, 200 );
	wait 1.1;
	roomanauncernames settext(level.activ.name);
	roomanauncernames SetPulseFX( 40, 1500, 200 );
	wait 1.6;
	roomanauncernames destroy();
	roomanauncer destroy();

}

musictrig()
{
	trig = getent("musictrig","targetname");
	trig waittill("trigger",player);
	trig delete();
	player thread musictmenu();
}

musictmenu()
{
	self  freezeControls(true);

	choice = hud(0,0,"Tristam & Braken - Flight\nNightcore - Alive\nAvici - Levels\nBooty Bitch");

	sel = selector();
	back = background();
	count = 1;
	self.inmenu = true;
	wait 0.5;
	while(self.inmenu == true)
	{
		if(self AttackButtonPressed())
		{
			if(count <= 4)
			{
				count++;
				self.selector.y += 24;
			}
			if( count == 5)
			{
			count = 1;
			self.selector.y = 0;
			}
		}
		if(self UseButtonPressed())
		{
			ambientplay("music"+count);
			self iprintln(count);
			self.inmenu = false;
		}
		wait .1;
	}
	self freezeControls(false);
	self.music destroy();
	self.selector destroy();
	self.background destroy();

}

hud(x,y,text)
{
	self.music = NewClientHudElem(self);
	self.music.alignX = "center";
	self.music.alignY = "middle";
	self.music.horzalign = "center";
	self.music.vertalign = "middle";
	self.music.alpha = 1;
	self.music.x = x;
	self.music.y = y;
	self.music.font = "objective";
	self.music.fontscale = 2;
	self.music.glowalpha = 1;
	self.music.glowcolor = (1,0,0);
	self.music settext(text);
	self.music.sort = 3;
}

selector()
{
    self.selector = NewClientHudElem(self);
	self.selector.alignX = "center";
	self.selector.alignY = "middle";
	self.selector.horzalign = "center";
	self.selector.vertalign = "middle";
	self.selector.alpha = 0.5;
	self.selector.x = 0;
	self.selector.y = 0;
	self.selector.fontscale = 2;
	self.selector.glowalpha = 1;
	self.selector setshader("white",320, 20);
	self.selector.sort = 2;
	self.selector.color = (1,0,0.4);
}

background()
{
	self.background = NewClientHudElem(self);
	self.background.alignX = "center";
	self.background.alignY = "middle";
	self.background.horzalign = "center";
	self.background.vertalign = "middle";
	self.background.alpha = 0.8;
	self.background.x = 0;
	self.background.y = 24;
	self.background setshader("deathrun",330, 150);
	self.background.sort = 1;
}

exitsecret()
{
	trig = getent("exits","targetname");
	pos = getent("tomap","targetname");
	for(;;)
	{
		trig waittill("trigger",player);
		player setOrigin(pos.origin);
		player setPlayerangles(pos.angles);
		player braxi\_rank::giveRankXp( undefined, 250 );
		iprintln(player.name+" ^5Finished Secret");
		wait .1;
	}
}