/*	 _    ___      __  _                               ______  
	| |  / (_)____/ /_(_)____                         / _____\ 
	| | / / / ___/ __/ / ___/                        / / ___/ |
	| |/ / (__  ) /_/ / /__                         / / /__  / 
	|___/_/____/\__/_/\___/  __    ____            |  \___/ /  
	   / __ \___  ____ _/ /_/ /_  / __ \__  ______  \______/   
	  / / / / _ \/ __ `/ __/ __ \/ /_/ / / / / __ \            
	 / /_/ /  __/ /_/ / /_/ / / / _, _/ /_/ / / / /            
	/_____/\___/\__,_/\__/_/ /_/_/ |_|\__,_/_/ /_/             
	                                                           
	Code: 
			Blade #6504
			Legend #9805
			BraXi #????

	Design & Textures:
			Niko #2926
            EphNey #1431

    Character & Weapon Assets:
            Fox.#0001
            Magical.#9137

	Vistic Clan ©

	Used stats for daily challenges; 2522 - 2527
	Used stats for characters in shop; 2528 - 2535
	Used stats for knifes in shop; 2536, 2537
	Used stats for weapons in shop; 2538 - 2540
	Used stats for new graphic dvars; 2542 - 2543
	Used stats for new challenges; 2544 - 2553

	- in stat table -
	Used stat for online time; 2541
	Used stat for killcards; 2554
	Used stat for emblems; 2555
	
*/
#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

#include braxi\_common;
#include braxi\_dvar;

main()
{	
	braxi\_dvar::setupDvars();
	precache();
	init_spawns();
	braxi\_cod4stuff::main();

	game["DeathRunVersion"] = 12;
	level.mapName = toLower(getDvar("mapname"));
	level.jumpers = 0;
	level.activators = 0;
	level.activatorKilled = false;
	level.freeRun = false;
	level.allowSpawn = true;
	level.tempEntity = spawn( "script_model", (0,0,0) );
	level.colliders = [];
	level.trapsDisabled = false;
	level.canCallFreeRun = true;
	level.hudYOffset = 10;
	level.firstBlood = false;
	level.lastJumper = false;
	level.mapHasTimeTrigger = false;
	level.announcer_inuse = false;

	if(!isdefined(game["roundsplayed"]))
		game["roundsplayed"]=1;

	game["roundStarted"]=false;
	game["state"]="readyup";
	
	if(game["roundsplayed"]==1)
	{
		game["playedmaps"]=strtok(level.dvar["playedmaps"],";");
		addMap=true;
		if(game["playedmaps"].size)
		{
			for(i=0;i<game["playedmaps"].size;i++)
			{
				if(game["playedmaps"][i]==level.mapName)
				{
					addMap=false;
					break;
				}
			}
		}

		if(addMap)
		{
			appendToDvar("dr_playedmaps",level.mapName+";");
			level.dvar["playedmaps"]=getDvar("dr_playedmaps");
			game["playedmaps"]=strTok(level.dvar["playedmaps"],";");
		}

		if(level.dvar["freerun"])
			level.freerun=true;
	}

	setDvar( "jump_slowdownEnable", 0 );
	setDvar( "bullet_penetrationEnabled", 0 );
	//setDvar( "g_playerCollisionEjectSpeed", 1 );
	setDvar( "mod_author", "BraXi" );
	makeDvarServerInfo( "mod_author", "BraXi" );

	buildSprayInfo();
	buildCharacterInfo();
	buildItemInfo();
	buildItem2Info();
	buildTrailInfo();

	thread maps\mp\gametypes\_hud::init();
	thread maps\mp\gametypes\_hud_message::init();
	thread maps\mp\gametypes\_damagefeedback::init();
	thread maps\mp\gametypes\_clientids::init();
	thread maps\mp\gametypes\_gameobjects::init();
	thread maps\mp\gametypes\_spawnlogic::init();
	thread maps\mp\gametypes\_oldschool::deletePickups();
	thread maps\mp\gametypes\_hud::init();
	thread maps\mp\gametypes\_quickmessages::init();

	thread braxi\_admin::main();
	thread braxi\_menus::init();
	thread braxi\_scoreboard::init();
	thread braxi\_rank::init();
	thread braxi\_maps::init();
	thread braxi\_bots::init();
	thread braxi\_missions::init();
	thread braxi\_dailymissions::init();
	thread braxi\_mapvote::init();

	thread blade\_antiglitch::init();
	thread blade\_ghostrun::init();
	thread blade\_credits::init();

	level thread gameLogic();
	level thread serverMessages();
	level thread mapRecords();

	level thread firstBlood();
	level thread fastestTime();

	thread plugins\_plugins::main();

	thread cloud\_cloud::init();
	thread cloud\_ch_progress::ai();

	thread daily_challanges_timer();

	visionSetNaked( level.mapName, 0 );
}

precache()
{
	level.text = [];
	level.fx = [];

	// Models
	precacheModel( "german_sheperd_dog" );
	precacheModel( "tag_origin" );
	precacheModel( "playermodel_vistic_mike_myers" );
	precacheModel( "mil_frame_charge" );
	precacheModel( "static_insertion_final" );
	precacheModel( "playermodel_carnage" );

	// Gloves 
	precacheModel("viewmodel_hands_zombie");
	precacheModel("viewmodel_base_viewhands");
	precacheModel("viewhands_desert_opfor");
	precacheModel("viewhands_black_kit");
	preCacheModel("viewhands_usmc");

	// Weapons
	precacheItem( "colt45_mp" );
	precacheItem( "tomahawk_mp" );
	precacheItem( "claymore_mp" );
	precacheItem( "knife_mp" );
    precacheItem( "m60e4_acog_mp" );
    precacheItem( "remington700_mp" );
    precacheItem( "remington700_acog_mp" );
    precacheItem( "m40a3_mp" );
    precacheItem( "g3_mp" );
    precacheItem( "g3_gl_mp" );
    precacheItem( "m60e4_mp" );
    precacheItem( "saw_mp" );
    precacheItem( "saw_acog_mp" );
    precacheItem( "rpd_mp" );;
    precacheItem( "ak74u_mp" );
    precacheItem( "skorpion_mp" );
    precacheItem( "skorpion_reflex_mp" );
    precacheItem( "skorpion_silencer_mp" );
    precacheItem( "uzi_mp" );
    precacheItem( "uzi_silencer_mp" );
    precacheItem( "p90_mp" );
    precacheItem( "mp5_mp" );
    precacheItem( "m1014_mp" );
    precacheItem( "winchester1200_mp" );
    precacheItem( "m21_mp" );
    precacheItem( "dragunov_mp" );
    precacheItem( "deserteaglegold_mp" );
    precacheItem( "deserteagle_mp" );
    precacheItem( "defaultweapon_mp" );
    precacheItem( "usp_mp" );
    precacheItem( "m16_mp" );
    precacheItem( "ak47_mp" );
    precacheItem( "m4_mp" );
    precacheItem( "g36c_mp" );
    precacheItem( "g36c_gl_mp" );
    precacheItem( "m14_mp" );
    precacheItem( "m14_silencer_mp" );
    precacheItem( "m14_reflex_mp" );
    precacheItem( "mp44_mp" );
    precacheItem( "barrett_mp" );
    precacheItem( "rpg_mp" );
    precacheItem( "brick_blaster_mp" );
    precacheItem( "beretta_mp" );
    precacheItem( "colt44_mp" );
    precacheItem( "c4_mp" );
    precacheItem( "airstrike_mp" );
    precacheItem( "radar_mp" );
	precacheitem( "dog_mp" );
	precacheitem( "g36c_silencer_mp" );
	precacheitem( "concussion_grenade_mp" );
	precacheitem( "dragunov_mp" );
	precacheitem( "g36c_reflex_mp");
	precacheitem( "g36c_mp");
	precacheitem( "odin_mp" );

	// Vip Content
	
	precacheMenu( "clientcmd" );
	precacheShader( "black" );
	precacheShader( "white" );
	precacheShader( "killiconsuicide" );
	precacheShader( "killiconmelee" );
	precacheShader( "killiconheadshot" );
	precacheShader( "killiconfalling" );
	precacheShader( "stance_stand" );
	precacheShader( "hudstopwatch" );
	precacheShader( "score_icon" );
	precacheShader( "vc_rubys");
	precacheShader( "vc_rubyfragments");

	precacheStatusIcon( "hud_status_ghostp" );
	precacheStatusIcon( "hud_status_connecting" );
	precacheStatusIcon( "hud_status_dead" );
	precacheStatusIcon( "hudicon_american" );
	precacheStatusIcon( "hudicon_opfor" );
	precacheHeadIcon( "headicon_admin" );

	preCacheModel("chicken");

	level.fx["gib_splat"] = loadFx( "deathrun/gib_splat" );
	level.fx["light_blink"] = loadFx( "misc/light_c4_blink" );
	level.fx["insertion"] = loadfx("deathrun/vc_flare");
	level.fx["vc_endgame"] = loadfx("deathrun/fx_endgame");
	level.fx["bombexplosion"] = loadfx( "explosions/tanker_explosion" );
	level.fx["vc_mvp"] = loadfx("vistic/rainbow_funken");
	level.fx["queue_trig"] = loadfx("vistic/queue");
 
	level.fx[6] = loadfx("explosions/aerial_explosion");
	level.fx[7] = loadfx("fire/tank_fire_engine");
	level.fx[8] = loadfx("smoke/smoke_trail_black_heli");

	dr_randomcolor = randomint(6);
	if(dr_randomcolor == 1 || dr_randomcolor == 3 || dr_randomcolor == 5)
		level.randomcolor = (0,0.84,1);
	else 
		level.randomcolor = (0,1,0.68);
}

init_spawns()
{
	level.spawn = [];
	level.spawn["allies"] = getEntArray( "mp_jumper_spawn", "classname" );
	level.spawn["axis"] = getEntArray( "mp_activator_spawn", "classname" );
	level.spawn["spectator"] = getEntArray( "mp_global_intermission", "classname" )[0];

	if( !level.spawn["allies"].size )
		level.spawn["allies"] = getEntArray( "mp_dm_spawn", "classname" );
		
	if( !level.spawn["axis"].size )
		level.spawn["axis"] = getEntArray( "mp_tdm_spawn", "classname" );

	if(getEntArray( "mp_global_intermission", "classname" ).size>0)
		level.spawn["spectator"] = getEntArray( "mp_global_intermission", "classname" )[0];
	else
		level.spawn["spectator"]=getentarray("mp_jumper_spawn","classname")[0];

	for( i = 0; i < level.spawn["allies"].size; i++ )
		level.spawn["allies"][i] placeSpawnPoint();

	for( i = 0; i < level.spawn["axis"].size; i++ )
		level.spawn["axis"][i] placeSpawnPoint();
}

buildSprayInfo()
{
	level.sprayInfo = [];
	level.numSprays = 0;
	
	tableName = "mp/sprayTable.csv";

	for( idx = 1; isdefined( tableLookup( tableName, 0, idx, 0 ) ) && tableLookup( tableName, 0, idx, 0 ) != ""; idx++ )
	{
		id = int( tableLookup( tableName, 0, idx, 1 ) );
		level.sprayInfo[id]["rank"] = (int(tableLookup( tableName, 0, idx, 2 )) - 1);
		level.sprayInfo[id]["shader"] = tableLookup( tableName, 0, idx, 3 );
		level.sprayInfo[id]["effect"] = loadFx( tableLookup( tableName, 0, idx, 4 ) );
		level.sprayInfo[id]["cl_stat"] = int(tableLookup( tableName, 0, idx, 5 ));
		
		precacheShader( level.sprayInfo[id]["shader"] );
		level.numSprays++;
	}
}

buildcharacterinfo()
{
	level.characterinfo=[];
	level.numcharacters=0;

	table="mp/characterTable.csv";

	for(idx=1;isdefined(tablelookup(table,0,idx,0)) && tablelookup(table,0,idx,0)!="";idx++)
	{
		id=int(tablelookup(table,0,idx,1));
		level.characterinfo[id]["rank"] = (int(tablelookup(table,0,idx,2))-1);
		level.characterinfo[id]["model"] = tablelookup(table,0,idx,3);
		level.characterinfo[id]["name"] = tablelookup(table,0,idx,4);
		level.characterinfo[id]["prestige"] = int(tablelookup(table,0,idx,5));
		level.characterinfo[id]["cl_stat"] = int(tablelookup(table,0,idx,6));

		precachemodel(level.characterinfo[id]["model"]);
		level.numcharacters++;
	}
}

buildItemInfo()
{
	level.iteminfo=[];
	level.numitems=0;

	table="mp/itemTable.csv";

	for(idx=1;isdefined(tablelookup(table,0,idx,0)) && tablelookup(table,0,idx,0)!="";idx++)
	{
		id=int(tablelookup(table,0,idx,1));
		level.iteminfo[id]["rank"]=(int(tablelookup(table,0,idx,2))-1);
		level.iteminfo[id]["item"]=(tablelookup(table,0,idx,3)+"_mp");
		level.iteminfo[id]["name"]=tablelookup(table,0,idx,4);
		level.iteminfo[id]["prestige"]=int(tablelookup(table,0,idx,5));
		level.iteminfo[id]["cl_stat"]=int(tablelookup(table,0,idx,6));

		precacheitem(level.iteminfo[id]["item"]);
		level.numitems++;
	}
}

buildItem2Info()
{
	level.item2Info = [];
	level.numItems2 = 0;
	
	tableName = "mp/item2Table.csv";

	for( idx = 1; isdefined( tableLookup( tableName, 0, idx, 0 ) ) && tableLookup( tableName, 0, idx, 0 ) != ""; idx++ )
	{
		id = int( tableLookup( tableName, 0, idx, 1 ) );
		level.item2info[id]["rank"]=(int(tablelookup(tableName,0,idx,2))-1);
		level.item2Info[id]["item"] = (tableLookup( tableName, 0, idx, 3 ) + "_mp");
		level.item2Info[id]["name"] = tableLookup( tableName, 0, idx, 4 );
		level.item2Info[id]["prestige"] = int(tableLookup( tableName, 0, idx, 5 ));
		level.item2Info[id]["cl_stat"] = int(tableLookup( tableName, 0, idx, 6 ));
		
		precacheItem( level.item2Info[id]["item"] );
		level.numItems2++;
	}
}

buildTrailInfo()
{
	level.trailInfo = [];
	level.numTrails = 0;
	
	tableName = "mp/trailTable.csv";

	for( idx = 1; isdefined( tableLookup( tableName, 0, idx, 0 ) ) && tableLookup( tableName, 0, idx, 0 ) != ""; idx++ )
	{
		id = int( tableLookup( tableName, 0, idx, 1 ) );
		level.trailInfo[id]["rank"] = int(tableLookup( tableName, 0, idx, 2 ));
		level.trailInfo[id]["shader"] = tableLookup( tableName, 0, idx, 3 );
		level.trailInfo[id]["effect"] = loadFx(tableLookup( tableName, 0, idx, 4 ));
		level.trailInfo[id]["name"] = tableLookup( tableName, 0, idx, 5 );
		level.trailInfo[id]["prestige"] = int(tableLookup( tableName, 0, idx, 6 ));
		level.trailInfo[id]["cl_stat"] = int(tableLookup( tableName, 0, idx, 7 ));

		precacheShader( level.trailInfo[id]["shader"] );
		level.numTrails++;
	}
}

playerConnect() // Called when player is connecting to server
{
	level notify( "connected", self );

	self thread cleanUp();
	self.guid = self getGuid();
	self.number = self getEntityNumber();
	self.statusicon = "hud_status_connecting";
	self.died = false;
	self.doingNotify = false; //for hud logic

	self.ghost=false;

	if( !isDefined( self.name ) )
		self.name = "undefined name";
	if( !isDefined( self.guid ) )
		self.guid = "undefined guid";

	self thread updateHealthbar();
	
	self setclientdvars("ui_roundNum",game["roundsplayed"],"ui_mapName",blade\_strings::getMapNameString(getdvar("mapname")));

	self setClientDvars( "show_hud", "true", "ip", getDvar("net_ip"), "port", getDvar("net_port"), "show_xpevent", level.dvar["xpevent_enable"], "show_xpmultiplier", level.dvar["xpevent_multiplier"]);
	if( !isDefined( self.pers["team"] ) )
	{
		//self execClientCommand("setfromdvar temp0 com_maxfps; setu com_maxfps 125; setfromdvar com_maxfps temp0");
		self thread do_welcome();

		self.sessionstate = "spectator";
		self.team = "spectator";
		self.pers["team"] = "spectator";

		self.pers["score"] = 0;
		self.pers["kills"] = 0;
		self.pers["deaths"] = 0;
		self.pers["assists"] = 0;
		self.pers["lifes"] = 0;
		self.pers["headshots"] = 0;
		self.pers["knifes"] = 0;
		self.pers["activator"] = 0;
		//self.pers["time"] = 99999999;
		self.pers["isDog"] = false;
		self.pers["ability"] = "specialty_null";

		// Vip Definitions
		if(self getstat(764) == 1)
			self.pers["vip"] = true;
		else 
			self.pers["vip"] = false;

		// Cloud Time
		self thread blade\_cloud::loadPBtime();
	}
	else
	{
		self.score = self.pers["score"];
		self.kills = self.pers["kills"];
		self.assists = self.pers["activator"];
		self.deaths = self.pers["deaths"];
	}

	self thread SetupLives();
	self thread count_time_played();

	if( game["state"] == "endmap" )
	{
		self spawnSpectator( level.spawn["spectator"].origin, level.spawn["spectator"].angles );
		self.sessionstate = "intermission";
		return;
	}

	if( isDefined( self.pers["weapon"] ) && self.pers["team"] != "spectator" )
	{
		self.pers["weapon"] = "colt45_mp";
		self.pers["knife"] = "knife_mp";
		self thread braxi\_teams::setTeam( "allies" ); //just keep in case... i saw player in new round that shouldnt be opfor but was (v0.3)
		spawnPlayer();
		return;
	}
	else
	{
		self spawnSpectator( level.spawn["spectator"].origin, level.spawn["spectator"].angles );
		self thread delayedMenu();
		logPrint("J;" + self.guid + ";" + self.number + ";" + self.name + "\n");
	}

	self setClientDvars( "cg_drawSpectatorMessages", 1, "ui_hud_hardcore", 1, "player_sprintTime", 4, "ui_uav_client", 0, "g_scriptMainMenu", game["menu_team"] );
}

do_welcome()
{
	if(!isdefined(self.pers["isBot"]) || isdefined(self.pers["isBot"]) && !self.pers["isBot"] )
	{
		switch(self getpower())
		{
			case 0:
			case 1:
				self setclientdvar("vc_tablet_rank","^7[^91^7]");
				iprintln("^1>> ^8"+self.name+"^7 from ^8"+self getgeolocation(2)+"^7 connected");
				break;
			case 20:
				self setclientdvar("vc_tablet_rank","^7[^920^7]");
				iprintln("^1>> ^8ViP "+self.name+" ^7[^920^7] from ^8"+self getgeolocation(2)+"^7 connected");
				if(self getstat(764) != 1)
				{
					self setstat(764,1);
					self.pers["vip"] = self getstat(764);
					self iprintlnbold("You got VIP Status");
				}
				break;
			case 40:
				self setclientdvar("vc_tablet_rank","^7[^940^7]");
				iprintln("^1>> ^8"+self.name+" ^7[^940^7] from ^8"+self getgeolocation(2)+"^7 connected");
				break;
			case 60:
				self setclientdvar("vc_tablet_rank","^7[^960^7]");
				iprintln("^1>> ^8"+self.name+" ^7[^960^7] from ^8"+self getgeolocation(2)+"^7 connected");
				break;
			case 80:
				self setclientdvar("vc_tablet_rank","^7[^980^7]");
				iprintln("^1>> ^8"+self.name+" ^7[^980^7] from ^8"+self getgeolocation(2)+"^7 connected");
				break;
			case 100:
				self setclientdvar("vc_tablet_rank","^7[^9100^7]");
				iprintln("^1>> ^8"+self.name+" ^7[^9100^7] from ^8"+self getgeolocation(2)+"^7 connected");
				break;
		}
	}
}

playerDisconnect() // Called when player disconnect from server
{
	level notify( "disconnected", self );
		
	self thread cleanUp();
	self thread destroyLifeIcons();

	if( !isDefined( self.name ) )
		self.name = "no name";

	iprintln("^5"+self.name+"^7 left.");

	logPrint("Q;" + self getGuid() + ";" + self getEntityNumber() + ";" + self.name + "\n");
}

PlayerLastStand( eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration )
{
	self suicide();
}

PulsePush( attacker )
{
	self endon( "disconnect" );
	
	for(i=0;i<5;i++)
	{
		self.health += 500;
		self FinishPlayerDamage( attacker, attacker, 500, 0, "MOD_PROJECTILE", "remington700_acog_mp", attacker.origin, AnglesToForward( (-30,attacker.angles[1],0), -80 ), "none", 0 );
	}
	
	self.gotpulse = attacker;
	wait 1.5;
	self.gotpulse = undefined;
}

PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime)
{
	if( self.sessionteam == "spectator" || game["state"] == "endmap" )
		return;

	level notify( "player_damage", self, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime );

	if( isPlayer( eAttacker ) && eAttacker.pers["team"] == self.pers["team"] )
		return;

	if( isPlayer( eAttacker ) && sMeansOfDeath == "MOD_MELEE" && isWallKnifing( eAttacker, self ) )
		return;

	if( isPlayer(eAttacker) && isdefined(eAttacker.ghost) && eAttacker.ghost && self==level.activ )
		return;
		
	if( isPlayer(self) && isdefined(self.ghost) && self.ghost && isDefined(eAttacker) && eAttacker==level.activ )
		return;

	if(isPlayer(self) && isdefined(self.ghost) && self.ghost && iDamage >= self.health )
	{
		self iprintlnbold("Too much ^8damage^7 taken, reseting to ^8Spawn");
		self setorigin(level.spawn[self.pers["team"]][randomint(self.pers["team"].size)].origin);
		return;
	}

	if(isDefined(eAttacker) && isPlayer(eAttacker) && self!=eAttacker && isDefined(level.activ) && (level.activ==self||level.activ==eAttacker) && !eAttacker.ghost)
	{
		eAttacker playlocalsound("MP_hit_alert");
		eAttacker.hud_damagefeedback.alpha = 1;
		eAttacker.hud_damagefeedback fadeOverTime(1);
		eAttacker.hud_damagefeedback.alpha = 0;
	}

	/*if( sWeapon == "remington700_acog_mp" && sMeansOfDeath != "MOD_MELEE" && iDamage < self.health )
        self thread PulsePush( eAttacker );*/

    //if( sMeansOfDeath == "MOD_MELEE" )
	//	eAttacker thread AddBloodHud();

	if( sMeansOfDeath != "MOD_MELEE" )
	{
		modifier = getDvarFloat( "dr_damageMod_" + sWeapon );
		if( modifier <= 2.0 && modifier >= 0.1 && sMeansOfDeath != "MOD_MELEE" )
			iDamage = int( iDamage * modifier );
	}

	if( level.dvar["damage_messages"] && isPlayer( eAttacker ) && eAttacker != self )
	{	
		eAttacker thread Showdmghud(iDamage+" Hit");
		self thread Showdmghud("^1-"+iDamage+" Hit");			
	}

	if(!isDefined(vDir))
		iDFlags |= level.iDFLAGS_NO_KNOCKBACK;

	if(!(iDFlags & level.iDFLAGS_NO_PROTECTION))
	{
		if(iDamage < 1)
			iDamage = 1;

		self finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime );
	}
}

Showdmghud( text )
{
    self endon("disconnect");
    //self endon("death");

    hud_dmg = NewClientHudElem(self);
    hud_dmg.alpha = 0;
    hud_dmg.fontscale = 1.6;
    hud_dmg.x = 0;
    hud_dmg.y = 0;
    hud_dmg.glowAlpha = 1;
    hud_dmg.hideWhenInMenu = false;
    hud_dmg setText(text);
    hud_dmg.archived = false;
    hud_dmg.alignX = "center";
    hud_dmg.alignY = "middle";
    hud_dmg.horzAlign = "center";
    hud_dmg.vertAlign = "middle";
    hud_dmg.hideWhenInMenu = true;  
    hud_dmg.glowcolor = level.randomcolor;
    hud_dmg maps\mp\gametypes\_hud::fontPulseInit();        
    hud_dmg maps\mp\gametypes\_hud::fontPulse( self );  
    
    direction = randomint(360);
    
    hud_dmg FadeOverTime(.5);
    hud_dmg.alpha = 1;
    
    hud_dmg MoveOverTime(1.5);
    hud_dmg.x = cos(direction)*64;
    hud_dmg.y = sin(direction)*64;
    wait 1.3;
    hud_dmg FadeOverTime(.3);
    hud_dmg.alpha = 0;
    wait .3;
    hud_dmg destroy();
}

PlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration )
{
	self endon("spawned");
	self notify("killed_player");
	self notify("death");

	if(self.sessionteam == "spectator" || game["state"] == "endmap" )
		return;

	level notify( "player_killed", self, eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration );

	if( level.dvar[ "giveXpForKill" ] && !level.trapsDisabled || !self.ghost )		
	{
		if( isDefined( level.activ ) && level.activ != self && level.activ isReallyAlive() )	
		{
			if( sMeansOfDeath == "MOD_UNKNOWN" || sMeansOfDeath == "MOD_FALLING" || sMeansOfDeath == "MOD_SUICIDE" )
			{
				if(!self.ghost)
					level.activ braxi\_rank::giveRankXP( "jumper_died" );
			}
		}
	}

	if(sHitLoc == "head" && sMeansOfDeath != "MOD_MELEE")
		sMeansOfDeath = "MOD_HEAD_SHOT";

	body = self clonePlayer( deathAnimDuration );
	body.targetname = "dr_deadbody";

	if( level.dvar["gibs"] && iDamage >= self.maxhealth && sMeansOfDeath != "MOD_MELEE" && sMeansOfDeath != "MOD_RIFLE_BULLET" && sMeansOfDeath != "MOD_PISTOL_BULLET" && sMeansOfDeath != "MOD_SUICIDE" && sMeansOfDeath != "MOD_HEAD_SHOT" )
		body gib_splat();
	//else
		//playfx( level.kill_effect, self.origin+(0,0,20));

	if( isDefined( body ) )
	{
		if ( self isOnLadder() || self isMantling() )
			body startRagDoll();
		thread delayStartRagdoll( body, sHitLoc, vDir, sWeapon, eInflictor, sMeansOfDeath );
	}

	self.statusicon = "hud_status_dead";
	self.sessionstate =  "spectator";

	if( isPlayer( attacker ) )
	{
		if( attacker != self )
		{
			braxi\_rank::processXpReward( sMeansOfDeath, attacker, self );

			attacker.kills++;
			attacker.pers["kills"]++;

			if(game["dailych"] == 0)
			{
				attacker braxi\_dailymissions::process_dailychallenge("dch_killer");
				if(self getstat(767) == 1)
					attacker braxi\_dailymissions::vcMemberChallenge("pistol",sWeapon);
			}

			if(game["dailych"] == 1)
			{
				if(self getstat(767) == 1)
					attacker braxi\_dailymissions::vcMemberChallenge("sniper",sWeapon);
			}

			if(game["dailych"] == 2)
			{
				if(self getstat(767) == 1)
					attacker braxi\_dailymissions::vcMemberChallenge("knife",sWeapon);
			}

			if( sMeansOfDeath == "MOD_HEAD_SHOT" )
			{
				attacker braxi\_missions::process_challenge( "ch_headhunter" ); // Kill 20 Enemies by Headshot
				if(game["dailych"] == 2)
					attacker braxi\_dailymissions::process_dailychallenge("dch_reaper");
			}

			if( !attacker isOnGround() && !self isOnGround() )
				attacker braxi\_missions::process_challenge( "ch_airkill" ); // Kill 25 enemies while both of You are in air

			attacker braxi\_missions::find_weapon_challenge(sWeapon);

			if(attacker getstat(980) == 3)
				attacker braxi\_missions::process_challenge( "ch_spiderman" );

			if(attacker getstat(980) == 12)
				attacker braxi\_missions::process_challenge( "ch_kratos" );

			if( self.pers["team"] == "axis" )
			{
				if(isdefined( attacker.usedLife ))
					attacker braxi\_missions::process_challenge( "ch_zombie" ); // Kill an Activator after respawning with a Life

				if(level.lastJumper && level.ch_lastJumper == attacker)
					attacker braxi\_missions::process_challenge( "ch_oneoone" ); // Kill an Activator while youre the last Jumper

				if(!level.trapsdisabled)
					attacker braxi\_missions::process_challenge( "ch_dare" ); // Kill 150 Activators while Traps are enabled

				if(game["dailych"] == 0)
					attacker braxi\_dailymissions::process_dailychallenge("dch_cuisine");

				attacker giveLife();
				attacker blade\_common::vc_coins(10);
			}
			if( self.pers["team"] == "allies" )
			{
				level.ch_unstoppable += 1;
				if(level.ch_unstoppable == 5)
					attacker braxi\_missions::process_challenge( "ch_unstoppable" ); // Kill 5 Jumpers in a row

				if(isdefined(self.usedLife))
					attacker braxi\_missions::process_challenge( "ch_again" ); // Kill a Jumper who respawned with a Life

				if(level.trapsdisabled)
					attacker braxi\_missions::process_challenge( "ch_tricky" ); // Kill 100 Jumpers while its Free Run Round

				attacker blade\_common::vc_coins(5);
			}
		}
	}

	if( !level.freeRun && !self.ghost )
	{
		deaths = self maps\mp\gametypes\_persistence::statGet( "deaths" );
		self maps\mp\gametypes\_persistence::statSet( "deaths", deaths+1 );
		self.deaths++;
		self.pers["deaths"]++;
		self.pers["killstreak"] = 0;

		self braxi\_missions::process_challenge( "ch_tryhard", 1 ); // Die 250 Times
		if(game["dailych"] == 1)
			self braxi\_dailymissions::process_dailychallenge("dch_dead");
	}
	self.died = true;

	if(isdefined(self.ghost) && self.ghost) 
		self.ghost=false;

	self thread cleanUp();

	obituary( self, attacker, sWeapon, sMeansOfDeath );

	
	if( self.pers["team"] == "axis" )
	{
		/*if( isPlayer( attacker ) && attacker.pers["team"] == "allies" )
		{
			thread drawInformationsmall( 800, 0.8, 1, attacker.name+" ^7killed Activator" );
			thread drawInformationsmall( 800, 0.8, -1, attacker.name+" ^7killed Activator" );
		}*/

		level.activatorKilled = true;
		self thread braxi\_teams::setTeam( "allies" );
	}
	if( self.pers["team"] != "axis" )
		self thread respawn();

	/*wait .45;
	if( self.pers["team"] == "allies" && !level.jumpers && level.activators )
	{
		if( isPlayer( attacker ) && attacker.pers["team"] == "axis" )
		{
			thread drawInformationsmall( 800, 0.8, 1, "Activator claimed Victory" );
			thread drawInformationsmall( 800, 0.8, -1, "Activator claimed Victory" );
		}
	}*/
	level waittill("end_killcam");
}

spawnPlayer( origin, angles )
{
	if( game["state"] == "endmap" ) 
		return;

	level notify( "jumper", self );
	self thread cleanUp();
	resettimeout();

	self.team = self.pers["team"];
	self.sessionteam = self.team;
	self.sessionstate = "playing";
	self.spectatorclient = -1;
	self.killcamentity = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
	self.statusicon = "";

	if(self.pers["vip"] == 1)
		self.statusicon="hudicon_opfor";

	if(self getstat(767)==1)
		self.statusicon="hudicon_american";
	
	self braxi\_teams::setPlayerModel();

	if(isdefined(origin) && isdefined(angles))
		self spawn(origin,angles);
	else
	{
		spawnpoint=level.spawn[self.pers["team"]][randomint(level.spawn[self.pers["team"]].size)];
		self spawn( spawnpoint.origin,spawnpoint.angles);
	}

	if(self.pers["team"] == "allies")
	{
		if(self.pers["vip"] == 1 && self getstat(1214) == 1)
			self.pers["weapon"] = "odin_mp";
		else 
			self.pers["weapon"] = level.itemInfo[self getStat(981)]["item"];
	}
	
	if(self.pers["team"] == "axis")
		self.pers["weapon"] = "tomahawk_mp";

	if(self.pers["vip"] == 1 && self getstat(1213) == 1)
		self.pers["knife"] = "claymore_mp";
	else 
		self.pers["knife"] = level.item2Info[self getStat(984)]["item"];


	if(!level.trapsdisabled)
	{
		self giveweapon(self.pers["weapon"]);
		self setspawnweapon(self.pers["weapon"]);
		self givemaxammo(self.pers["weapon"]);

		if(self.pers["team"] == "allies")
			self giveweapon(self.pers["knife"]);
	}
	else 
	{
		if(self.pers["team"] == "axis")
		{
			self giveweapon(self.pers["weapon"]);
			self setspawnweapon(self.pers["weapon"]);
		}
		else 
		{
			self giveweapon(self.pers["knife"]);
			self setspawnweapon(self.pers["knife"]);
		}
	}

	if(self.pers["vip"] == 1 && self getstat(1215) == 1)
		self setviewmodel("viewmodel_base_viewhands");
	else 
	{
		if(self blade\_common::isBlade())
			self setviewmodel("viewhands_desert_opfor");
		else 
			self setviewmodel("viewhands_black_kit");
	}

	self thread braxi\_teams::setHealth();
	self thread braxi\_teams::setSpeed();
	self thread afterFirstFrame();

	self notify( "spawned_player" );
	level notify( "player_spawn", self );

	self.ghost = false;
	self show();
}

afterFirstFrame()
{
	self endon( "disconnect" );
    self endon( "joined_spectators" );
    self endon( "death" );
	waittillframeend;
	wait 0.1;

	if( !self isPlaying() )
		return;

	if( game["state"] == "readyup" )
	{
		self linkTo( level.tempEntity );
		self disableWeapons();
	}
	else
		self thread antiAFK();

	if(self.pers["team"] == "axis")
		self thread freeRunChoice();

	if(!self.ghost)
	{
		self clearPerks();

		if(self getstat(level.challengeInfo["ch_zombie"]["state"]) == 1)
			self setperk("specialty_fastreload");

		if(self getstat(level.challengeInfo["ch_airkill"]["state"]) == 1)
			self setperk("specialty_bulletaccuracy");

		self thread watch_flare();
		self thread playerTimer();
		self thread sprayLogo();
		self thread userTrail();

		if(getdvar("mapname") == "mp_dr_dball_gt")
			self thread bunnyHoop();
	}
}

userTrail()
{
	self endon("disconnect");

	if(self.pers["vip"] == 1 && self getstat(1216) == 1)
		self.pers["trail"] = level.trailInfo[16]["effect"];
	else 
		self.pers["trail"] = level.trailInfo[self getStat(986)]["effect"];

	if(self getstat(986) == 0)
			return;

	if(self getstat(986) >= 8 && self getstat(986) <= 13 && self getstat(1216) != 1)
		playfxontag(self.pers["trail"],self,"tag_origin");
	else 
	{
		while(self isReallyAlive())
		{
			playFx(self.pers["trail"],self.origin+(0,0,10));
			wait 0.25;
		}
	}
}

bunnyHoop()
{
	self endon( "disconnect" );
    self endon( "spawned_player" );
    self endon( "joined_spectators" );
    self endon( "death" );

    while(game["state"]!="playing")
		wait 0.05;
    
    lastBH = 0;
    lastCount = 0;

    while(self isreallyalive())
    {          
        lastBH = self.doingBH;        
        wait 0.1;

        stance = self getStance();
        useButton = self useButtonPressed();
        onGround = self isOnGround();
        fraction = bulletTrace( self getEye(), self getEye() + vector_scale(anglesToForward(self.angles), 32 ), true, self )["fraction"];
        
        if( !self.doingBH && useButton && !onGround && fraction == 1 )
        {
            self setClientDvars( "bg_viewKickMax", 0, "bg_viewKickMin", 0, "bg_viewKickRandom", 0, "bg_viewKickScale", 0 );
            self.doingBH = true;
            lastCount = 0;
        }

        if( self.doingBH && useButton && onGround && stance != "prone" && fraction == 1 )
        {
            lastCount++;
            if( self.bh < 120 )
                self.bh += 30;
        }

        if( self.doingBH && !useButton || self.doingBH && stance == "prone" || self.doingBH && fraction < 1 )
        {
            self setClientDvars( "bg_viewKickMax", 90, "bg_viewKickMin", 5, "bg_viewKickRandom", 0.4, "bg_viewKickScale", 0.2 );
            self.doingBH = false;
            self.bh = 0;
            lastCount = 0;
            continue;
        }

        if( self.bh && self.doingBH && onGround && fraction == 1 )
        {
            bounceFrom = (self.origin - vector_scale( anglesToForward( self.angles ), 50 )) - (0,0,42);
            bounceFrom = vectorNormalize( self.origin - bounceFrom );
            self bounce( bounceFrom, self.bh );
            self bounce( bounceFrom, self.bh );
            wait 0.1;
        }
    }
}

sprayLogo()
{
	self endon( "disconnect" );
	self endon( "spawned_player" );
	self endon( "joined_spectators" );
	self endon( "death" );

	if( !level.dvar["sprays"] )
		return;

	while( game["state"] != "playing" )
		wait 0.05;

	sprayNum = self getStat( 979 );
		
	if( sprayNum < 0 )	
		sprayNum = 0;
	else if(sprayNum> level.numSprays )
		sprayNum = level.numSprays;

	while( self isReallyAlive() )
	{
		while( !self fragButtonPressed() )
			wait .2;

		if( !self isOnGround() )
		{
			wait 0.2;
			continue;
		}

		angles = self getPlayerAngles();
		eye = self getTagOrigin( "j_head" );
		forward = eye + vector_scale( anglesToForward( angles ), 70 );
		trace = bulletTrace( eye, forward, false, self );
		
		if( trace["fraction"] == 1 )
		{
			wait 0.1;
			continue;
		}

		position = trace["position"] - vector_scale( anglesToForward( angles ), -2 );
		angles = vectorToAngles( eye - position );
		forward = anglesToForward( angles );
		up = anglesToUp( angles );

		playFx( level.sprayInfo[sprayNum]["effect"], position, forward, up );
		self playSound( "sprayer" );

		self notify( "spray", sprayNum, position, forward, up ); // ch_sprayit

		if(game["dailych"] == 1)
			self braxi\_dailymissions::process_dailychallenge("dch_picassot");

		wait level.dvar["sprays_delay"];
	}
}

freeRunChoice()
{
	self endon( "disconnect" );
	self endon( "spawned_player" );
	self endon( "joined_spectators" );
	self endon( "death" );

	if( level.trapsDisabled )
		return;

	self.hud_freeround = newClientHudElem( self );
	self.hud_freeround.elemType = "font";
	self.hud_freeround.x = 320;
	self.hud_freeround.y = 370;
	self.hud_freeround.alignX = "center";
	self.hud_freeround.alignY = "middle";
	self.hud_freeround.alpha = 1;
	self.hud_freeround.font = "default";
	self.hud_freeround.fontScale = 1.8;
	self.hud_freeround.sort = 0;
	self.hud_freeround.foreground = true;
	self.hud_freeround.label = &"Press ^8[{+attack}]^7 for ^8Free Run";

	self.hud_freeround_time = newClientHudElem( self );
	self.hud_freeround_time.elemType = "font";
	self.hud_freeround_time.x = 320;
	self.hud_freeround_time.y = 390;
	self.hud_freeround_time.alignX = "center";
	self.hud_freeround_time.alignY = "middle";
	self.hud_freeround_time.alpha = 1;
	self.hud_freeround_time.font = "default";
	self.hud_freeround_time.fontScale = 1.8;
	self.hud_freeround_time.sort = 0;
	self.hud_freeround_time.foreground = true;
	self.hud_freeround_time setTimer( 5 );

	wait 1;
	freeRun = false;
	for( i = 0; i < 10*5; i++ ) // time to switch into free run
	{
		if( !level.canCallFreeRun )
		{
			self.hud_freeround destroy();
			self.hud_freeround_time destroy();
			return;
		}
		if( self attackButtonPressed() )
		{
			freeRun = true;
			level endon( "kill_free_run_choice" );
			break;
		}
		wait 0.1;
	}
	level endon( "kill_free_run_choice" );


	if( isDefined( self.hud_freeround ) )
		self.hud_freeround destroy();
	if( isDefined( self.hud_freeround_time ) )
		self.hud_freeround_time destroy();

	if( freeRun )
	{
		thread drawInformationSmall( 800, 0.8, 1, "Free Run" );
		thread drawInformationSmall( 800, 0.8, -1, "Free Run" );

		level disableTraps();
			
		players = getAllPlayers();
		for( i = 0; i < players.size; i++ )
		{
			if( players[i] isPlaying() )
			{
				players[i] takeAllWeapons();

				players[i] giveweapon(players[i].pers["knife"]);
				players[i] switchtoweapon(players[i].pers["knife"]);
			}
		}
		level notify( "round_freerun" );
	}
}

endRound( reasonText, team )
{
	level endon ( "endmap" );

	if( game["state"] == "round ended" || !game["roundStarted"] )
		return;

	level notify( "round_ended", reasonText, team );
	level notify( "endround" );
	level notify( "kill logic" );

	game["state"] = "round ended";
	game["roundsplayed"]++;

	if( team == "jumpers" )
	{
		visionSetNaked( "jumpers", 4 );
	}
	else
	{
		visionSetNaked( "activators", 4 );
		
		if( isDefined( level.activ ) && isPlayer( level.activ ) ) 
			level.activ braxi\_rank::giveRankXp( "activator" );
	}

	if( game["roundsplayed"] >= (level.dvar[ "round_limit" ]+1) )
	{
		level endMap( "Game has ended" );
		return;
	}
	else
	{
		level thread endRoundAnnoucement(reasonText);

		players=getAllPlayers();
		for(i=0;i<players.size;i++)
		{
			if(isdefined(players[i].hud_time))  	players[i].hud_time destroy();
			if(isdefined(players[i].hud_lifes[0]))  players[i].hud_lifes[0] destroy();
			if(isdefined(players[i].hud_lifes[1]))  players[i].hud_lifes[1] destroy();

			players[i] thread blade\_endround::main();
			players[i] setclientdvar("ui_roundNum",game["roundsplayed"]);
		}
	}

	wait 10;
	map_restart( true );
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

endRoundAnnoucement(text)
{
	notifyData = spawnStruct();
	notifyData.titleText = text;
	notifyData.notifyText = ("Starting Round: ^5"+game["roundsplayed"]+"/"+level.dvar["round_limit"] );
	notifyData.glowColor = level.randomcolor;
	notifyData.duration = 8.8;

	players = getAllPlayers();
	for( i = 0; i < players.size; i++ )
		players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( notifyData );
}

spawnSpectator( origin, angles )
{
	if( !isDefined( origin ) )
		origin = (0,0,0);
	if( !isDefined( angles ) )
		angles = (0,0,0);

	self notify( "joined_spectators" );

	self thread cleanUp();
	resettimeout();
	self.sessionstate = "spectator";
	self.spectatorclient = -1;
	self.statusicon = "";
	self spawn( origin, angles );
	self braxi\_teams::setSpectatePermissions();

	level notify( "player_spectator", self );
}

cleanUp()
{
	self clearLowerMessage();
	self notify( "kill afk monitor" );
	self setClientDvars( "cg_thirdperson", 0, "cg_thirdpersonrange", 80, "r_blur", 0, "ui_healthbar", 1, "bg_viewKickMax", 90, "bg_viewKickMin", 5, "bg_viewKickRandom", 0.4, "bg_viewKickScale", 0.2 );
	self unLink();

	self closeingamemenu();
	self closemenu();

	self.bh = 0; 
	self.doingBH = false;
	self enableWeapons();

	if( isDefined( self.hud_freeround ) )		self.hud_freeround destroy();
	if( isDefined( self.hud_freeround_time ) )	self.hud_freeround_time destroy();
	if( isDefined( self.hud_time ) )			self.hud_time destroy();

	if(isdefined(self.ghost) && self.ghost) 
		self.ghost=false;
}

gameLogic()
{
	level endon( "endround" );
	level endon( "kill logic" );
	waittillframeend;

	level.allowSpawn = true;
	warning = false;

	visionSetNaked( "mpIntro", 0 );
	if( isDefined( level.matchStartText ) )
		level.matchStartText destroyElem();

	wait 0.2;

	level.matchStartText = createServerFontString( "default", 1.5 );
	level.matchStartText setPoint( "CENTER", "BOTTOM", 0, -10 );
	level.matchStartText.sort = 1001;
	level.matchStartText setText("");
	level.matchStartText.foreground = false;
	level.matchStartText.hidewheninmenu = true;
	level.matchStartText.glowColor = level.randomcolor;
	level.matchStartText.glowalpha = 1;

	min = 2;
	if( level.freeRun )
		min = 1;

	waitForPlayers( min ); // wait for 2 players to start game

	roundStartTimer();
	
	if( !canStartRound( min ) )
	{
		thread restartLogic(); // lets start all over again...
		return;
	}

	level notify( "round_started", game["roundsplayed"] );
	level notify( "game started" );
	game["state"] = "playing";
	game["roundStarted"] = true;

	visionSetNaked( level.mapName, 2.0 );

	thread roundDelay();

	if( level.freeRun )
	{
		//level.hud_time setTimer( level.dvar["freerun_time"] );
		level.startTime = getTime();
		level thread checkTimeLimit();
		
		thread drawInformationSmall( 800, 0.8, 1, "First Round" );
		thread drawInformationSmall( 800, 0.8, -1, "First Round" );
		return;
	}
	else
	{
		level thread restrictSpawnAfterTime( level.dvar["spawn_time"] );
		level.startTime = getTime();
		level thread checkTimeLimit();
	}

	startJumpers = undefined;
	while( game["state"] == "playing" )
	{
		wait 0.2;

		level.jumper = [];
		level.jumpers = 0;
		level.activators = 0;
		level.totalPlayers = 0;
		level.totalPlayingPlayers = 0;

		players = getAllPlayers();
		if(players.size > 0)
		{
			for(i = 0; i < players.size; i++)
			{
				level.totalPlayers++;

				if( isDefined( players[i].pers["team"] ) )	
				{
					if( players[i] isReallyAlive() )
						level.totalPlayingPlayers++;

					if(players[i].pers["team"] == "allies" && players[i] isReallyAlive() && !players[i].ghost )
					{
						level.jumpers++;
						level.jumper[level.jumper.size] = players[i];
					}
					if(players[i].pers["team"] == "axis" && players[i] isReallyAlive() )
						level.activators++;
				}
			}		
			
			if( !isDefined( startJumpers ) )
				startJumpers = level.jumpers;

			if( startJumpers >= 3 && level.jumpers == 1 && !level.freeRun )
				level.jumper[0] thread lastJumper();

			if( level.jumpers > 1 && !level.activators && !level.activatorKilled && !level.freeRun )
			{
				//pickRandomActivator();
				newPickingSystem();
				continue;
			}

			if( level.activators >= 2 && !warning )
			{
				warning( "level.activators >= 2 - report this to BraXi at www.braxi.cba.pl" );
				warning( "level.activators = " + level.activators );
				warning = true;
			}

			if( !level.jumpers && level.activators )
				thread endRound( "Jumpers died", "activators" );
			else if( !level.freeRun && !level.activators && level.jumpers )
				thread endRound( "Activator died", "jumpers" );
			else if( !level.activators && !level.jumpers )
				thread endRound( "Everyone died", "activators" );
		}
	}
}

roundDelay()
{
	if(!level.freerun)
	{
		level waittill("activator");
		wait 1.5;

		thread blade\_endround::getFinalRound();
	}

	players=getAllPlayers();
	for(i=0;i<players.size;i++)
	{
		if(players[i] isPlaying())
		{
			players[i] unLink();
			players[i] enableWeapons();
			//players[i] thread antiAFK();
		}
	}
}

pickRandomActivator()
{
	level notify( "picking activator" );
	level endon( "picking activator" );

	if( game["state"] != "playing" || level.activatorKilled || level.activators )
		return;

	players = getAllPlayers();
	if( !isDefined( players ) || isDefined( players ) && !players.size )
		return;

	num = randomInt( players.size );
	guy = players[num];

	if( level.dvar["dont_make_peoples_angry"] == 1 && guy getEntityNumber() == getDvarInt( "last_picked_player" ) )
	{	
		if( isDefined( players[num-1] ) && isPlayer( players[num-1] ) )
			guy = players[num-1];
		else if( isDefined( players[num+1] ) && isPlayer( players[num+1] ) )
			guy = players[num+1];
	}
	
	if( !isDefined( guy ) && !isPlayer( guy ) || level.dvar["dont_pick_spec"] && guy.sessionstate == "spectator" || isdefined(guy) && guy.ghost )
	{
		level thread pickRandomActivator();
		return;
	}
	bxLogPrint( ("A: " + guy.name + " ; guid: " + guy.guid) );
	//thread braxi\_slider::messageSlider(guy.name+" was picked to be Activator");
	thread announcer((0,1,0.68),&"Activator picked",guy.name,braxi\_rank::getRankInfoIcon(guy.pers["rank"],guy.pers["prestige"]));
		
	guy thread braxi\_teams::setTeam( "axis" );
	guy spawnPlayer();
	guy braxi\_rank::giveRankXp( "activator" );

	guy.pers["activator"]++;
	guy.assists++;
		
	setDvar( "last_picked_player", guy getEntityNumber() );
	level notify( "activator", guy );
	level.activ = guy;
}

NewPickingSystem()
{
	level notify( "picking activator" );
	level endon( "picking activator" );

	if( game["state"] != "playing" || level.activatorKilled || level.activators )
		return;

	players = getAllPlayers();
	if( !isDefined( players ) || isDefined( players ) && !players.size )
		return;

	startValue = 0;
	actiList = [];

	while(1)
	{
		players = getallplayers();
		for(i=0;i<players.size;i++)
		{
			if(players[i] isreallyalive() && players[i].pers["activator"] == int(startValue))
				actiList[actiList.size] = players[i];
		}

		if(!actiList.size)
		{
			startValue += 1;
			continue;
		}
		break;
	}
	
	level.activ = actiList[ randomInt( actiList.size ) ];
	level.activ.pers["activator"]++;
	level.activ.assists++;

	level.activ thread braxi\_teams::setTeam( "axis" );
	level.activ spawnPlayer();
	level.activ thread braxi\_rank::giveRankXp( "activator" );

	level notify( "activator", level.activ );

	bxLogPrint( ("A: " + level.activ.name + " ; guid: " + level.activ.guid) );

	thread announcer((0,1,0.68),&"Activator picked",level.activ.name,braxi\_rank::getRankInfoIcon(level.activ.pers["rank"],level.activ.pers["prestige"]));
}

checkTimeLimit()
{
	level endon( "endround" );
	level endon( "game over" );

	if( !level.dvar["time_limit"] )
		return;

	if(level.freerun)
		level.timeLimit = level.dvar["freerun_time"];
	else 
		level.timeLimit = level.dvar["time_limit"];

	while(game["state"] == "playing")
	{
		thread updatedTimeLimit();
		if (isDefined(level.startTime) && getTimeRemaining() < 3000)
		{
			wait 0.1;
			continue;
		}
		wait 1;
	}
}

updatedTimeLimit()
{
	level endon( "endround" );
	level endon( "game over" );

	if (!isDefined(level.startTime)) 
		return;
		
	timeLeft = getTimeRemaining();

	level.temp_time = int(timeLeft);
	setGameEndTime(getTime() + int(timeLeft));

	if(timeLeft > 0) 
		return;

	if(level.freerun)
		level thread braxi\_mod::endRound( "First Round has ended", "jumpers" );
	else 
		level thread endRound( "Time limit reached", "activators" );
}

getTimeRemaining()
{
	return level.timeLimit * 60000 - getTimePassed();
}
getTimePassed()
{
	if (!isDefined(level.startTime)) 
		return 0;
	return (gettime() - level.startTime);
}

endMap( winningteam )
{
	game["state"] = "endmap";
	level notify( "intermission" );
	level notify( "game over" );

	setDvar( "g_deadChat", 1 );

	players = getAllPlayers();
	for( i = 0; i < players.size; i++ )
	{
		players[i] closeMenu();
		players[i] closeInGameMenu();
		players[i] thread blade\_endround::end_map();
		players[i] freezeControls( true );
		players[i] cleanUp();
		players[i] destroyLifeIcons();

		if(players[i].pers["vip"] == 1)
			players[i] setstat(1217,0);
	}
	wait .05;

	players = getAllPlayers();
	for( i = 0; i < players.size; i++ )
	{
		players[i] spawnSpectator( level.spawn["spectator"].origin, level.spawn["spectator"].angles );
		players[i] allowSpectateTeam( "allies", false );
		players[i] allowSpectateTeam( "axis", false );
		players[i] allowSpectateTeam( "freelook", false );
		players[i] allowSpectateTeam( "none", false ); // true
		wait .05;
	}

	if( level.dvar["displayBestPlayers"] )
		blade\_bestplayer::indicate_mvp();

	wait 12.2;

	teddysOrigin = level.spawn["spectator"].origin + vector_scale( anglesToForward( level.spawn["spectator"].angles ), 120 ) + vector_scale( anglesToUp( level.spawn["spectator"].angles ), 180 );
	playFx( level.fx["vc_endgame"], teddysOrigin );
	playFx( level.fx["vc_endgame"], level.spawn["spectator"].origin + (0,0,100) );

	
	braxi\_mapvote::startMapVote();
	level waittill("mapvote_over");

	//braxi\_credits::main();
	wait 2;

	if(level.dvar["mapvote"])
		braxi\_mapvote::changemap(braxi\_mapvote::getMostVotedForMap());
	else 
		exitlevel(false);
}

respawn()
{
	self endon( "disconnect" );
	self endon( "spawned_player" );
	self endon( "joined_spectators" );

	if( level.freeRun || !game["roundStarted"] )
	{
		wait 0.1;
		self spawnPlayer();
		return;
	}

	if( self.pers["lifes"] && self.pers["team"] == "allies" )
	{
		wait 0.5;

		if( game["state"] != "playing" )
			return;
		self setLowerMessage( &"PLATFORM_PRESS_TO_SPAWN" , 5);
			
		for(i=0;i<100;i++)
		{
			if(self useButtonPressed())
			{
				if( game["state"] != "playing" )
					return;

				self thread useLife();
				return;
			}
			wait .05;
		}

		if(level.ghostrun)
		{
			wait 3;
			self thread canGhostrun();
		}
	}
	else if(self.pers["team"]=="allies")
	{
		if(level.ghostrun)
		{
			wait 3;
			self thread canGhostrun();
		}
	}
}

canGhostrun()
{
	self endon( "disconnect" );
	self endon( "spawned_player" );

	if(self.pers["team"]!="allies")
		return;

	if(isdefined(self.ghost) && self.ghost) 
		self.ghost=false;
	
	if( self.sessionstate != "playing" && self.sessionteam!="spectator" && game["state"] == "playing" )
	{
		self maps\mp\_utility::setLowerMessage("Press ^8[{+activate}]^7 for ^5GhostRun");
		while( !self useButtonPressed() && game["state"] == "playing" )
			wait .05;
		if( self.sessionstate != "playing" && self.sessionteam!="spectator" && game["state"] == "playing" )	
			self thread blade\_ghostrun::ghostCheck();
		else
			self clearLowerMessage();
	}
}


antiAFK()
{
	self endon( "disconnect" );
	self endon( "spawned_player" );
	self endon( "joined_spectators" );
	self endon( "kill afk monitor" );

	if( !level.dvar["afk"] || self.pers["team"] == "axis" )
		return;

	time = 0;
	oldOrigin = self.origin - (0,0,50);
	while( isAlive( self ) )
	{
		wait 0.2;
		if( distance(oldOrigin, self.origin) <= 10 )
			time++;
		else
			time = 0;

		if( time == (level.dvar["afk_warn"]*5) )
			self iPrintlnBold( "Move or you will be sent to ^5Spectator^7!" );

		if( time == (level.dvar["afk_time"]*10) )
		{
			setdvar("admin","spectator:"+self getentitynumber());
			break;
		}
		oldOrigin = self.origin;
	}
}

kickAfterTime( time )
{
	self endon( "disconnect" );
	wait time;

	if( isDefined( self ) )
		kick( self getEntityNumber() );
}

roundStartTimer()
{	
	if( isDefined( level.matchStartText ) )
		level.matchStartText destroyElem();

	level.matchStartText = createServerFontString( "default", 1.5 );
	level.matchStartText setPoint( "CENTER", "CENTER", 0, -20 );
	level.matchStartText.sort = 1001;
	level.matchStartText setText("Round begins in...");
	level.matchStartText.glowalpha = 1;
	level.matchStartText.glowcolor = level.randomcolor;
	level.matchStartText.foreground = false;
	level.matchStartText.hidewheninmenu = true;
	
	time = level.dvar["spawn_time"];
	level.matchStartTimer = createServerTimer( "default", 1.8 );
	level.matchStartTimer setPoint( "CENTER", "CENTER", 0, 10 );
	level.matchStartTimer setValue( time );
	level.matchStartTimer.sort = 1001;
	level.matchStartTimer.foreground = false;
	level.matchStartTimer.glowalpha = 1;
	level.matchStartTimer.glowcolor = level.randomcolor;
	level.matchStartTimer.color = (0,1,1);
	level.matchStartTimer.hideWhenInMenu = true;
	level.matchStartTimer maps\mp\gametypes\_hud::fontPulseInit();

	while( time > 0 )
	{
		wait 1;

		if( time == 3 )
			visionSetNaked( level.mapName, 3 );

		time --;

		level.matchStartTimer setValue( time );
		level.matchStartTimer thread maps\mp\gametypes\_hud::fontPulse( level );
	}
	
	level.matchStartTimer FadeOverTime( 0.5 );
	level.matchStartTimer.alpha = 0;
	level.matchStartText FadeOverTime( 0.5 );
	level.matchStartText.alpha = 0;

	wait 0.5;

	level.matchStartText destroyElem();
	level.matchStartTimer destroyElem();
}

updateHealthBar()
{
	self endon("disconnect");
	wait 0.1;
	self setClientDvar( "ui_healthbar", 1 );

	self thread checkJumpers();
	while( 1 )
	{
		self waittill ( "damage", amount );
		delta = ( self.health / self.maxhealth );
		if( delta > 1 )
			delta = 1;
		self setClientDvar( "ui_healthbar", delta+0.005 );
	}
}

checkJumpers()
{
	self endon("disconnect");
	level endon("game over");

	while(1)
	{
		if(level.freeRun)
		{
			self setclientdvar("ui_jumpersNum","TrainRun");
			break;
		}

		wait 1;
		self setclientdvar("ui_jumpersNum",level.jumpers);
	}
}

disableTraps()
{
	level.trapsDisabled = true;
	for( i = 0; i < level.trapTriggers.size; i++ )
		if( isDefined( level.trapTriggers[i] ) )
			level.trapTriggers[i].origin = level.trapTriggers[i].origin - (0,0,10000);
	level notify( "traps_disabled" ); //for mappers
}

serverMessages()
{
	if( !level.dvar["messages_enable"] )
		return;

	//messages = strTok( level.dvar["messages"], ";" );
	messages = [];
	messages[0] = "Welcome to ^8VC'^7 DeathRun!";
	messages[1] = "Enjoy your Stay!";
	messages[2] = "Discord: ^9discord.gg/JKwXV3h";
	messages[3] = "Open the Tablet by your binded Key (default P)";

	lastMessage = messages.size-1;

	if( !isDefined( game["msg_time"] ) )	game["msg_time"] = 0;
	if( !isDefined( game["msg"] ) )			game["msg"] = 0;

	while( 1 )
	{
		if(game["state"] == "endmap")
			break;

		if( game["msg_time"] == level.dvar["messages_delay"] )
		{
			game["msg_time"] = 0;
			exec("say "+messages[game["msg"]]);
			//iPrintln( "^1>>^7 " + messages[game["msg"]] );
			game["msg"]++;
			if( game["msg"] > lastMessage )
				game["msg"] = 0;
		}
		wait 1;
		game["msg_time"]++;
	}
}

isWallKnifing( attacker, victim )
{
	start = attacker getEye();
	end = victim getEye();

	if( bulletTracePassed( start, end, false, attacker ) == 1 )
	{
		return false;
	}
	return true;
}



new_smaller_ending_hud( align, fade_in_time, x_off, y_off )
{
	hud = newHudElem();
    hud.foreground = true;
	hud.x = x_off;
	hud.y = y_off;
	hud.alignX = align;
	hud.alignY = "middle";
	hud.horzAlign = align;
	hud.vertAlign = "middle";

 	hud.fontScale = 1.8;

	hud.font = "objective";
	hud.glowColor = level.randomcolor;
	hud.glowAlpha = 1;

	hud.alpha = 0;
	hud fadeovertime( fade_in_time );
	hud.alpha = 1;
	hud.hidewheninmenu = true;
	hud.sort = 10;
	return hud;
}

drawInformationSmall( start_offset, movetime, mult, text )
{
	start_offset *= mult;
	hud = new_smaller_ending_hud( "center", 0.1, start_offset, 150 );
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

 	hud.fontScale = 3;

	hud.font = "objective";
	hud.glowColor = level.randomcolor;
	hud.glowAlpha = 1;

	hud.alpha = 0;
	hud fadeovertime( fade_in_time );
	hud.alpha = 1;
	hud.hidewheninmenu = true;
	hud.sort = 10;
	return hud;
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

SetupLives()
{
	self endon( "disconnect" );

	self.hud_lifes = [];

	self.hud_lifes[0] = newclienthudelem(self);
	self.hud_lifes[0].x = 202;
	self.hud_lifes[0].y = -15;
	self.hud_lifes[0].alignx = "left";
	self.hud_lifes[0].aligny = "bottom";
	self.hud_lifes[0].horzalign = "left";
	self.hud_lifes[0].vertalign = "bottom";
	self.hud_lifes[0].sort = 10;
	self.hud_lifes[0].alpha = 0;
	self.hud_lifes[0].archived = 0;
	self.hud_lifes[0].hidewheninmenu = true;
	self.hud_lifes[0] setshader("stance_stand",50,50);

	self.hud_lifes[1] = newclienthudelem(self);
	self.hud_lifes[1].x = 224;
	self.hud_lifes[1].y = -21;
	self.hud_lifes[1].foreground = 1;
	self.hud_lifes[1].alignx = "left";
	self.hud_lifes[1].aligny = "bottom";
	self.hud_lifes[1].horzalign = "left";
	self.hud_lifes[1].vertalign = "bottom";
	self.hud_lifes[1].sort = 10;
	self.hud_lifes[1].alpha = 0;
	self.hud_lifes[1].archived = 0;
	self.hud_lifes[1].hidewheninmenu = true;
	self.hud_lifes[1].fontscale = 1.4;

	wait .05;
	
	if( !self.pers["lifes"] )
		return;

	for(i=0;i<self.hud_lifes.size;i++)
	{
		self.hud_lifes[i] fadeovertime(1);
		self.hud_lifes[i].alpha = 1;

		if(i == 1)
			self.hud_lifes[i] setvalue(self.pers["lifes"]);
	}
}

giveLife()
{
	if(self.pers["lifes"] >= 3)
		return;

	self.pers["lifes"] += 1;

	if(self.pers["lifes"] == 1)
	{
		for(i=0;i<self.hud_lifes.size;i++)
		{
			self.hud_lifes[i] fadeovertime(1);
			self.hud_lifes[i].alpha = 1;
		}
	}
	self.hud_lifes[1] setvalue(self.pers["lifes"]);

	/*if(self.pers["lifes"]>=3)
		return;

	self.pers["lifes"]++;
	//self setstat(983,self.pers["lifes"]);
	hud = self.hud_lifes[ self.pers["lifes"]-1 ];
	hud fadeovertime(1);
	hud.alpha=1;
	hud SetPulseFX( 30, 100000, 700 );*/
}

useLife()
{
	if( !self.pers["lifes"] || self.sessionstate == "playing" || !level.dvar["allowLifes"] )
		return; 

	self.pers["lifes"] -= 1;
	self.hud_lifes[1] setvalue(self.pers["lifes"]);

	iprintln("^5"+self.name+ "^7 has used a ^5Life");

	thread announcer((1,1,0),&"Additional Life",self.name,"stance_stand");

	if(!self.pers["lifes"])
	{
		self iprintlnbold("^7This was your last ^5Life^7, don't ^5waste ^7it");
		
		for(i=0;i<self.hud_lifes.size;i++)
		{
			self.hud_lifes[i] fadeovertime(1);
			self.hud_lifes[i].alpha = 0;
		}
	}

	if(isDefined(self.insertion))
		self spawnPlayer(self.insertion.origin, (0,self.insertion.angles[1],0));
	else
		{
			x = RandomInt( level.spawn["allies"].size );
			self spawnPlayer(level.spawn["allies"][x].origin, (0,level.spawn["allies"][x].angles[1],0) );
		}
	self.usedLife = true;
}

destroyLifeIcons()
{
	if(game["state"] == "endmap")
	{
		if(self.pers["lifes"] != 0)
		{
			self braxi\_rank::giverankxp(undefined,self.pers["lifes"]*200);
			wait 1;
			self.pers["lifes"] = 0;
		}
	}

	if(!isdefined(self.hud_lifes))
		return;

	for(i=0;i<self.hud_lifes.size;i++)
	{
		if(isdefined(self.hud_lifes[i]))
			self.hud_lifes[i] destroy();
	}
}

gib_splat()
{
	self playSound( "gib_splat" );
	playFx( level.fx["gib_splat"], self.origin + (0,0,20) );
	self delete();
}

fastestTime()
{
	trig = getEntArray( "endmap_trig", "targetname" );
	if( !trig.size || trig.size > 1 )
		return;

	level.mapHasTimeTrigger = true;

	trig = trig[0];
	while( 1 )
	{
		trig waittill( "trigger", user );

		if( !user isReallyAlive() || user.pers["team"] == "axis" || user.ghost )
			continue;

		if(!isdefined(level.vc_finish_first) && !level.freerun)
		{
			level.vc_finish_first = true;
			user braxi\_missions::process_challenge( "ch_formula" ); // Finish current Map in first Place

			if(isdefined(level.activ) && level.activ isReallyAlive())
			{
				level.activ closemenu();
				level.activ closeingamemenu();
			}
		}
		user thread endTimer();
	}
}

endTimer()
{
	if(isdefined(self.finishedMap))
		return;

	self.finishedMap = true;

	time = getTime() - self.timerStartTime;
	if(!level.freerun)
		saveTimes(self, time);

	if(isdefined(self.hud_time))
		self.hud_time destroy();

	self.hud_time = addTextHud( self, 207, -5, 1, "left", "bottom", 1.5 );
	self.hud_time.horzAlign = "left";
    self.hud_time.vertAlign = "bottom";
	self.hud_time.foreground = true;
	self.hud_time.archived = 0;
	self.hud_time.hidewheninmenu = true;

	self.hud_time setText( "^9"+blade\_common::convertTimeRecords(time) );

	if(time < self.pers["time"])
	{
		self.pers["time"] = time;
		self thread blade\_cloud::savePBtime();
		self iprintln("^1New Personal Best Time!\n Map finished in ^8"+blade\_common::convertTimeRecords(time)+"^7 seconds.");
	}
	else 
		self iprintln( "Map finished in ^8" + blade\_common::convertTimeRecords(time) + "^7 seconds." );
}

mapRecords()
{
	level.bestScores = [];

	level.bestScores[0]["player"] = " ";
	level.bestScores[0]["guid"] = "123";
	level.bestScores[0]["value"] = 0;
	level.bestScores[0]["model"] = "body_mp_sas_urban_sniper";

	level.playerTimes = [];
	for(i=0; i<5; i++)
	{
		level.playerTimes[i]["time"] = 999999999;
		level.playerTimes[i]["name"] = "---";
		level.playerTimes[i]["guid"] = "123";
	}

	wait 1;

	if(level.mapHasTimeTrigger)
		thread blade\_cloud::loadTimeRecords();
}

playerTimer()
{
	self endon( "disconnect" );
	self endon( "spawned_player" );
	self endon( "joined_spectators" );
	self endon( "death" );

	if( !level.mapHasTimeTrigger || isDefined( self.finishedMap ) || self.pers["team"] == "axis" )
		return;

	while( game["state"] != "playing"  )
		wait 0.05;

	self.hud_time = addTextHud( self, 207, -5, 1, "left", "bottom", 1.5 );
	self.hud_time.horzAlign = "left";
    self.hud_time.vertAlign = "bottom";
	self.hud_time.foreground = true;
	self.hud_time.archived = 0;
	self.hud_time.hidewheninmenu = true;
	self.hud_time setTenthsTimerUp( 1 );

	self.timerStartTime = getTime();
}

appendToDvar( dvar, string )
{
	setDvar( dvar, getDvar( dvar ) + string );
}

saveTimes(player, time)
{
	if(!isdefined(player) || !isdefined(time) || isdefined(player.usedLife))
		return;

	guid = player getGuid();
	for(i=4; i>-1; i--)
	{
		//If players new time is slower then their old time
		if(level.playerTimes[i]["guid"] == guid && level.playerTimes[i]["time"] < time )
			return;

		//If a quicker time is set
		if(level.playerTimes[i]["time"] > time)
		{
			//check player doesnt have old time
			for(x=0; x<i+1; x++)
			{
				if(level.playerTimes[x]["guid"] == guid && level.playerTimes[x]["time"] != time)
				{
					//If they do move all times below up to remove it
					for(z=x; z>0; z--)
					{
						level.playerTimes[z]["time"] = level.playerTimes[z-1]["time"];
						level.playerTimes[z]["name"] = level.playerTimes[z-1]["name"];
						level.playerTimes[z]["guid"] = level.playerTimes[z-1]["guid"];
					}
				}
			}
			//move old times down
			for(p=0; p<i; p++)
			{
				level.playerTimes[p]["time"] = level.playerTimes[p+1]["time"];
				level.playerTimes[p]["name"] = level.playerTimes[p+1]["name"];
				level.playerTimes[p]["guid"] = level.playerTimes[p+1]["guid"];
			}
			//insert new time
			level.playerTimes[i]["time"] = time;
			level.playerTimes[i]["name"] = player.name;
			level.playerTimes[i]["guid"] = guid;

			thread blade\_cloud::saveTimeRecords();
			return;
		}
	}
}

firstBlood()
{
	if( !level.dvar["firstBlood"] )
		return;

	level waittill( "activator" );
	wait 0.1;

	level waittill( "player_killed", who );
	what = randomintrange(1,4);
	level thread playSoundOnAllPlayers( "first_blood"+what );

	thread announcer((0,0.84,1),&"First Blood",who.name,braxi\_rank::getRankInfoIcon(who.pers["rank"],who.pers["prestige"]));
}

lastJumper()
{
	if( !level.dvar["lastalive"] || level.lastJumper )
		return;
	   
	level.lastJumper = true;
	what = randomintrange(1,5);
	level thread playSoundOnAllPlayers( "last_alive"+what );

	level.ch_lastJumper = self;

	thread announcer((0,0.84,1),&"Last Alive",self.name,braxi\_rank::getRankInfoIcon(self.pers["rank"],self.pers["prestige"]));
}

watch_flare()
{
	if( self.pers["team"] == "axis" || !self.pers["lifes"] )
		return;

	self endon( "spawned_player" );
	self endon( "disconnect" );


	insertionItem = "concussion_grenade_mp";
	self giveWeapon( insertionItem );
	self giveMaxAmmo( insertionItem );
	self setActionSlot( 3, "weapon", insertionItem );

	while( self isReallyAlive() )
	{
		self waittill( "grenade_fire", entity, weapName );

		if( weapName != insertionItem )
			continue;

		self giveMaxAmmo( insertionItem );

		entity waitTillNotMoving();
		pos = entity.origin;
		angle = entity.angles;

		if( !self isOnGround() || distance( self.origin, pos ) > 48 || (isdefined(level.vc_queue_trig) && self istouching(level.vc_queue_trig)) )
		{
			self iPrintlnBold( "^1You can't use insertion here" );
			entity delete();
			continue;
		}

		self cleanUpInsertion();
		self.insertion = entity;

		self.flare_fx = spawn("script_model",self.insertion.origin);
		self.flare_fx setmodel("static_insertion_final");
		self.flare_fx.angles = self.insertion.angles;

		wait .1;
		playfxontag(level.fx["insertion"],self.flare_fx,"tag_fx");
		self iPrintlnBold( "^2Insertion at " + pos );
	}
}

cleanUpInsertion()
{
	if(isdefined(self.insertion))
		self.insertion delete();

	if(isdefined(self.flare_fx))
		self.flare_fx delete();
}

daily_challanges_timer()
{
	/*if(!isdefined(level.dchTimer))
		level.dchTimer = "";

	wait .5;*/

	for(;;)
	{
		level.dchTimer = TimeToString(86400 - getRealTime(), 1, "%H:%M:%S");

		if(level.dchTimer == "00:00:00")
		{
			game["dailych"]++;

			if(game["dailych"] > 2)
				game["dailych"] = 0;

			dch_db = FS_FOpen( "cloud/dailyChallenges.txt", "write" );
    		FS_WriteLine(dch_db, game["dailych"]);
    		FS_FClose(dch_db);

		}
		wait 1;
	}
}

count_time_played()
{
    level endon("game over");
    self endon("disconnect");

    while(isdefined(self))
    {
    	wait 1;

    	time = self maps\mp\gametypes\_persistence::statGet( "ONLINE_TIME" );
        self maps\mp\gametypes\_persistence::statSet( "ONLINE_TIME", time+1 );

		if(time >= 3600)
			self braxi\_missions::process_challenge( "ch_online1" );

		if(time >= 86400)
			self braxi\_missions::process_challenge( "ch_online2" );

		if(time >= 604800)
			self braxi\_missions::process_challenge( "ch_online3" );
    }
}

announcer(color,text,who,iconShader)
{
	while(isdefined(level.announcer_inuse) && level.announcer_inuse)
		wait 0.05;

	level.announcer_inuse=true;

	shader=createhud(level,-300,210,"left","top"); // 100
	shader.alpha=0.4;
	shader.archived = 0;
	shader.hidewheninmenu=true;
	shader setshader("black",160,40);

	shader2=createhud(level,-300,210,"left","top"); // 100
	shader2.alpha=1;
	shader2.archived = 0;
	shader2.hidewheninmenu=true;
	shader2 setshader("white",160,3);
	shader2.color = color;

	icon=createhud(level,-295,216,"left","top");
	icon.alpha=1;
	icon.archived = 0;
	icon.foreground = true;
	icon.hidewheninmenu=true;
	icon setshader(iconShader,30,30);

	message=createhud(level,-260,215,"left","top","default",1.5,undefined,level.randomcolor);
	message.alpha=1;
	message.archived = 0;
	message.foreground = true;
	message.hidewheninmenu=true;
	message.label=text;

	name=createhud(level,-260,231,"left","top","default",1.4,undefined,level.randomcolor);
	name.foreground = true;
	name.alpha=1;
	name.archived = 0;
	name.hidewheninmenu=true;
	name settext(who);

	// Move in
	shader moveovertime(0.35);
	shader2 moveovertime(0.35);
	icon moveovertime(0.35);
	message moveovertime(0.35);
	name moveovertime(0.35);

	shader.x=5; 
	shader2.x=5;
	icon.x=7;
	message.x=45;
	name.x=45;

	wait 3;

	// Move out
	shader moveovertime(0.35);
	shader2 moveovertime(0.35);
	icon moveovertime(0.35);
	message moveovertime(0.35);
	name moveovertime(0.35);

	shader.x=-300;
	shader2.x=-300;
	icon.x=-295;
	message.x=-260;
	name.x=-260;

	wait .5;

	shader destroy();
	shader2 destroy();
	icon destroy();
	message destroy();
	name destroy();

	level.announcer_inuse=false;
}

createhud(what,x,y,alignx,aligny,font,scale,color,glow)
{
	if(isplayer(what))
		hud=newclienthudelem(what);
	else 
		hud=newhudelem();
	hud.alignx=alignx;
	hud.aligny=aligny;
	hud.horzalign=alignx;
	hud.vertalign=aligny;
	hud.x=x;
	hud.y=y;

	if(isdefined(font))
		hud.font=font;

	if(isdefined(scale))
		hud.fontscale=scale;

	if(isdefined(color))
		hud.color=color;

	if(isdefined(glow))
	{
		hud.glowalpha=1;
		hud.glowcolor=glow;
	}

	return hud;
}