#include maps\mp\_utility;
#include common_scripts\utility;
main()
{
	///External scripts///
	maps\mp\_load::main();
	maps\mp\mp_dr_tropical_traps::main();
	maps\mp\mp_dr_tropical_endrooms::main();
	
	///Team Setup///
	game["allies"] = "sas";
	game["axis"] = "spetsnaz";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "woodland";
	game["axis_soldiertype"] = "woodland";

	
	///Set Dvars///
	VisionSetNaked( "mp_dr_tropical");
	setdvar( "r_gamma", "1" );
	setdvar( "r_specularcolorscale", "1" );
	setdvar("r_glowbloomintensity0","1");
	setdvar("r_glowbloomintensity1","1");
	setdvar("r_glowskybleedintensity0","1");
	setdvar("compassmaxrange","1800");
	setDvar("bg_fallDamageMinHeight", "9999");
	setDvar("bg_fallDamageMaxHeight", "99999");

	///Precache///
	PrecacheMenu("speedex_music_menu");
	PreCacheModel("com_laptop_generic_open");
	PreCacheModel("vehicle_mig29_desert");
	preCacheRumble("artillery_rumble");
	PreCacheModel("vehicle_blackhawk_sas");
	PreCacheItem("ak74u_reflex_mp");
	preCacheItem("artillery_mp");

	///PrecacheFX///
	///Ambient///
	level._fx["Ambient"]["Speedex_Portal_FX"] = loadfx ("speedex/speedex_portal_fx"); 
	level._fx["Ambient"]["Speedex_Startdoor_FX"] = loadfx ("speedex/speedex_start_door"); 
	level._effect[ "beacon_glow" ] = loadfx( "misc/ui_pickup_available" );

	///Course Threads///
	thread onPlayerConnect();
	thread player_water_splash();
	thread ambientfx();
	thread startdoor();
	thread secret_enter();
	thread secret_exit();
	thread secret_respawn();
	//thread devtest();
	thread add_trap_to_triggers();
	thread wait_for_endroom();
	thread secret_music();

	level.secret_music_active = 0;
}

onPlayerConnect()
{
	while(1)
	{
		level waittill("connected", player);
		wait 4;
		speedGUID = "b276bb78c4d2acc0df58171306d4766c";
		tempGuid = player getGUID();
		if(tempGuid == speedGUID)
		{
			player.headicon = "headicon_russian";
		}
	}
}

secret_music()
{
	secret_music_trigger = getent("secret_music","targetname");

	secret_music_trigger waittill("trigger", player);
	level.secret_music_active = 1;
	AmbientStop();
	wait 0.1;
	ambientPlay("secret_music");
}

wait_for_endroom()
{
	wait_trigger = getent("wait_trigger","targetname");

	wait_trigger SetHintString("^2Press ^3&&1 ^2to enter the secret while waiting!");
	wait_trigger waittill("trigger", player);

	level.secret_enter_trig UseBy(player);
	wait 0.1;
	player thread secret_tele_back();
	wait 0.1;
	thread wait_for_endroom();
}

secret_tele_back()
{
	self endon("death");
	self endon("joined_spectators");
	self endon("spawn");
	self endon("disconnect");
	self endon("secret_exit");

	self iPrintLnBold("^3Crouch ^2and press ^3F ^2to teleport back!");

	while(1)
	{
		if (self getStance() == "crouch") {
			if(self UseButtonPressed())
			{
				self.checkpoint = 0;
				self SetPlayerAngles(level.secret_exit_orig.angles);
				self SetOrigin(level.secret_exit_orig.origin);
				self FreezeControls(true);
				wait 0.1;
				self FreezeControls(false);
				break;
			}
		}
		wait 0.1;
	}
}

add_trap_to_triggers()
{
	addTriggerToList("trap1_trigger");
	addTriggerToList("trap2_trigger");
	addTriggerToList("trap3_trigger");
	addTriggerToList("trap4_trigger");
	addTriggerToList("trap5_trigger");
	addTriggerToList("trap6_trigger");
	addTriggerToList("trap7_trigger");
	addTriggerToList("trap9_trigger");
	addTriggerToList("trap10_trigger");
	//addTriggerToList("trap11_trigger");
}

addTriggerToList( name )
{
    if( !isDefined( level.trapTriggers ) )
        level.trapTriggers = [];
    level.trapTriggers[level.trapTriggers.size] = getEnt( name, "targetname" );
}

startdoor()
{
	start_door = getent("start_door","targetname");
	start_door_trig = getent("startdoor_open","targetname");

	start_door_trig SetHintString("^2Press ^3&&1 ^2to open the startdoor!");
	start_door_trig waittill("trigger", player);

 	start_door_trig Delete();

 	wait 1;

 	noti = SpawnStruct();
	noti.titleText = "\n\n^1Map made by"; 
	noti.notifyText = "\n\n\n^3 Speedex";
	noti.glowcolor = (0,0.1,0.9);
	noti.duration = 4; 
	players = getentarray("player", "classname"); 
	for(i=0;i<players.size;i++) 
	players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti ); 

	wait 0.1;
	thread music_random();

	start_door MoveZ(-600, 3, 1, 0);
	start_door waittill("movedone"); 
}

music_random()
{
	if(level.secret_music_active == 1)
		return;

	switch(randomint(4))
	{
		case 0:
			ambientPlay("song1");
			wait 2;
			iprintln( " ^3Star Driver - Eyes on you" );
			break;
		case 1:
			ambientPlay("song2");
			wait 2;
			iprintln( " ^2Dynoro & Gigi D’Agostino - In My Mind" );
			break;
		case 2:
			ambientPlay("song3");
			wait 2;
			iprintln( " ^3Shawn Mendes - Stitches (SeeB Remix)" );
			break;
		case 3:
			ambientPlay("song4");
			wait 2;
			iprintln( " ^2Armin van Buuren - Waiting for the Night" );
			break;
		case 4:
			ambientPlay("song5");
			wait 2;
			iprintln( " ^3Myst - Fire and Ice" );
			break;
	}
}

ambientfx()
{
	secret_fx = getent("secret_fx", "targetname");
	endmap_fx = getent("endmap_fx", "targetname");
	room_fx1 = getent("room_fx1", "targetname");
	room_fx2 = getent("room_fx2", "targetname");
	room_fx3 = getent("room_fx3", "targetname");
	room_fx4 = getent("room_fx4", "targetname");
	room_fx5 = getent("room_fx5", "targetname");
	room_fx6 = getent("room_fx6", "targetname");
	room_fx7 = getent("room_fx7", "targetname");

	playLoopedFX(level._effect[ "beacon_glow" ],3,secret_fx.origin,0);
	playLoopedFX(level._effect[ "beacon_glow" ],3,endmap_fx.origin,0);
	playLoopedFX(level._effect[ "beacon_glow" ],3,room_fx1.origin,0);
	playLoopedFX(level._effect[ "beacon_glow" ],3,room_fx2.origin,0);
	playLoopedFX(level._effect[ "beacon_glow" ],3,room_fx3.origin,0);
	playLoopedFX(level._effect[ "beacon_glow" ],3,room_fx4.origin,0);
	playLoopedFX(level._effect[ "beacon_glow" ],3,room_fx5.origin,0);
	playLoopedFX(level._effect[ "beacon_glow" ],3,room_fx6.origin,0);
	playLoopedFX(level._effect[ "beacon_glow" ],3,room_fx7.origin,0);
}

player_water_splash()
{
	player_watersplash_trig = getent("water_splash", "targetname");

	while(true)
	{
		player_watersplash_trig waittill ("trigger", player);	
		player PlaySound ("player_water_splash_sound");
		PlayFX( level._fx["Water"]["Splash"], player.origin );
		wait 1;
	}
}

secret_enter()
{
	level.secret_enter_trig = getent("secret_enter_trig", "targetname");
	secret_enter_orig = getent("secret_enter_orig", "targetname");

	level.secret_enter_trig SetHintString("^2Press ^3&&1 ^2to enter the secret!");
	level.secret_enter_trig waittill ("trigger", player);	

	player giveWeapon("deserteaglegold_mp");
    player switchToWeapon("deserteaglegold_mp");


	player.checkpoint = 0;
	player SetPlayerAngles(secret_enter_orig.angles);
	player SetOrigin(secret_enter_orig.origin);
	wait 0.1;
	thread secret_enter();
}


secret_exit()
{
	level.secret_exit_trig = getent("secret_exit", "targetname");
	level.secret_exit_orig = getent("secret_exit_orig", "targetname");

	while(true)
	{
		level.secret_exit_trig waittill ("trigger", player);	
		if(player.checkpoint == 6)
		{
			player thread braxi\_rank::giveRankXP("trap_activation");
			player.checkpoint = 0;
		}
		player.checkpoint = 0;
		player notify("secret_exit");
		player SetPlayerAngles(level.secret_exit_orig.angles);
		player SetOrigin(level.secret_exit_orig.origin);
		iPrintlnBold( " ^3" + player.name + " ^2finished the secret!" );
		wait 0.1;
	}
}

secret_respawn()
{
	secret_respawn_trig = getent("secret_reset", "targetname");

	secret_checkpoint1 = getent("secret_checkpoint1", "targetname");
	secret_checkpoint1_orig = getent("secret_checkpoint1_orig", "targetname");

	secret_checkpoint2 = getent("secret_checkpoint2", "targetname");
	secret_checkpoint2_orig = getent("secret_checkpoint2_orig", "targetname");

	secret_checkpoint3 = getent("secret_checkpoint3", "targetname");
	secret_checkpoint3_orig = getent("secret_checkpoint3_orig", "targetname");

	secret_checkpoint4 = getent("secret_checkpoint4", "targetname");
	secret_checkpoint4_orig = getent("secret_checkpoint4_orig", "targetname");

	secret_checkpoint5 = getent("secret_checkpoint5", "targetname");
	secret_checkpoint5_orig = getent("secret_checkpoint5_orig", "targetname");

	secret_checkpoint6 = getent("secret_checkpoint6", "targetname");
	secret_checkpoint6_orig = getent("secret_checkpoint6_orig", "targetname");

	secret_enter_trig = getent("secret_enter_trig", "targetname");
	secret_enter_orig = getent("secret_enter_orig", "targetname");

	secret_checkpoint1 thread checkpoint1_check();
	secret_checkpoint2 thread checkpoint2_check();
	secret_checkpoint3 thread checkpoint3_check();
	secret_checkpoint4 thread checkpoint4_check();
	secret_checkpoint5 thread checkpoint5_check();
	secret_checkpoint6 thread checkpoint6_check();

	while(true)
	{
		secret_respawn_trig waittill ("trigger", player);	
		if(player.checkpoint == 0)
		{
			player SetPlayerAngles(secret_enter_orig.angles);
			player SetOrigin(secret_enter_orig.origin);
			wait 0.2;
		}
		if(player.checkpoint == 1)
		{
			player SetPlayerAngles(secret_checkpoint1_orig.angles);
			player SetOrigin(secret_checkpoint1_orig.origin);
			wait 0.2;
		}
		if(player.checkpoint == 2)
		{
			player SetPlayerAngles(secret_checkpoint2_orig.angles);
			player SetOrigin(secret_checkpoint2_orig.origin);
			wait 0.2;
		}
		if(player.checkpoint == 3)
		{
			player SetPlayerAngles(secret_checkpoint3_orig.angles);
			player SetOrigin(secret_checkpoint3_orig.origin);
			wait 0.2;
		}
		if(player.checkpoint == 4)
		{
			player SetPlayerAngles(secret_checkpoint4_orig.angles);
			player SetOrigin(secret_checkpoint4_orig.origin);
			wait 0.2;
		}
		if(player.checkpoint == 5)
		{
			player SetPlayerAngles(secret_checkpoint5_orig.angles);
			player SetOrigin(secret_checkpoint5_orig.origin);
			wait 0.2;
		}
		if(player.checkpoint == 6)
		{
			player SetPlayerAngles(secret_checkpoint6_orig.angles);
			player SetOrigin(secret_checkpoint6_orig.origin);
			wait 0.2;
		}
	}
}

checkpoint1_check()
{
	while(true)
	{
		self waittill ("trigger", player);
		player.checkpoint = 1;	
		wait 0.2;
	}
}

checkpoint2_check()
{
	while(true)
	{
		self waittill ("trigger", player);
		player.checkpoint = 2;	
		wait 0.2;
	}
}

checkpoint3_check()
{
	while(true)
	{
		self waittill ("trigger", player);
		player.checkpoint = 3;	
		wait 0.2;
	}
}

checkpoint4_check()
{
	while(true)
	{
		self waittill ("trigger", player);
		player.checkpoint = 4;	
		wait 0.2;
	}
}

checkpoint5_check()
{
	while(true)
	{
		self waittill ("trigger", player);
		player.checkpoint = 5;	
		wait 0.2;
	}
}

checkpoint6_check()
{
	while(true)
	{
		self waittill ("trigger", player);
		player.checkpoint = 6;	
		wait 0.2;
	}
}

addTestClients()
{
	ent = [];
	testclients = 1;
	for(i = 0; i < testclients; i++)
	{
		ent[i] = addTestClient();
		wait .05;
		if( isDefined( ent[i] ) )
			ent[i] thread TestClient();
		wait 0.5;
	}
}

TestClient()
{
	while(!isdefined(self.pers["team"]))
		wait .05;

//	level waittill( "game started" );
	wait 0.05;
	self notify( "menuresponse", game["menu_team"], "axis" );
//	wait 0.5;
}

devtest()
{
	wait 5;
	if(game["roundsplayed"] == 1)
		thread addTestClients();

	devorig = getent("bounce_jumper_orig","targetname"); 

	endroom_bounce = getEnt("endroom_bounce", "targetname");

	devtest_trig = getent("startdoor_open","targetname"); 
	devtest_trig waittill ("trigger",player);
	//player SetOrigin(devorig.origin);

	//player.bcheckpoint = 0;
	//level.activ.bcheckpoint = 0;

	if(game["roundsplayed"] == 1)
	{
   	 	braxi\_mod::endRound( "Speedex ending round..", "jumpers" );
	}
}
