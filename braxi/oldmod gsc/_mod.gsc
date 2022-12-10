// __/\\\________/\\\_______________________________________________________________________/\\\\\\\\\__/\\\\\\_________________________________        
//  _\/\\\_______\/\\\____________________________________________________________________/\\\////////__\////\\\_________________________________       
//   _\//\\\______/\\\___/\\\__________________/\\\_______/\\\___________________________/\\\/______________\/\\\_________________________________      
//   __\//\\\____/\\\___\///___/\\\\\\\\\\__/\\\\\\\\\\\_\///______/\\\\\\\\____________/\\\________________\/\\\_____/\\\\\\\\\_____/\\/\\\\\\___     
//    ___\//\\\__/\\\_____/\\\_\/\\\//////__\////\\\////___/\\\___/\\\//////____________\/\\\________________\/\\\____\////////\\\___\/\\\////\\\__    
//     ____\//\\\/\\\_____\/\\\_\/\\\\\\\\\\____\/\\\______\/\\\__/\\\___________________\//\\\_______________\/\\\______/\\\\\\\\\\__\/\\\__\//\\\_   
//      _____\//\\\\\______\/\\\_\////////\\\____\/\\\_/\\__\/\\\_\//\\\___________________\///\\\_____________\/\\\_____/\\\/////\\\__\/\\\___\/\\\_  
//       ______\//\\\_______\/\\\__/\\\\\\\\\\____\//\\\\\___\/\\\__\///\\\\\\\\______________\////\\\\\\\\\__/\\\\\\\\\_\//\\\\\\\\/\\_\/\\\___\/\\\_ 
//        _______\///________\///__\//////////______\/////____\///_____\////////__________________\/////////__\/////////___\////////\//__\///____\///__

/*
	 _   ________   ___  __        __   
	| | / / ___( ) / _ )/ /__ ____/ /__ 
	| |/ / /__ |/ / _  / / _ `/ _  / -_)
	|___/\___/   /____/_/\_,_/\_,_/\__/ 

	© VC' Blade
	Website: vistic-clan.com

	Original Files: BraXi
	
	Used stats for daily challenges; 2522 - 2527
	Used stats for characters in shop; 2528 - 2535
	Used stats for knifes in shop; 2536, 2537
	Used stats for weapons in shop; 2538 - 2540
	Used stat for online time; 2541
	Used stats for new graphic dvars; 2542 - 2543
	Used stats for new challenges; 2544 - 2553
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

	//thread braxi\_bots::addTestClients();

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
	level.hudYOffset = 10;
	level.firstBlood = false;
	level.lastJumper = false;
	level.mapHasTimeTrigger = false;

	if(!isdefined(game["roundsplayed"]))
		game["roundsplayed"]=1;

	if(!isdefined(game["dailych"]))
		game["dailych"] = 0;

	cheaker = undefined;
	line = "";
	cheaker = FS_FOpen( "legend/dch_cheaker.txt", "read" );
    line = FS_ReadLine(cheaker);

	if(game["dailych"] != int(line) )
		game["dailych"] = int(line);

	FS_FClose(cheaker);

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
	buildAbilityInfo();
	buildTrailInfo();
	buildkillcardInfo();
	bestMapScores();
	buildemblemInfo();

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

	thread blade\_antiglitch::init();
	thread blade\_ghostrun::init();
	thread blade\_credits::init();

	level thread gameLogic();
	level thread doHud();
	level thread blade\_shaders::doHud_shader();
	level thread serverMessages();
	level thread fastestTimes();

	level thread firstBlood();
	level thread fastestTime();

	thread plugins\_plugins::main();

	thread legend\admin_cmds::onconnectp();
	thread legend\_casino::init();
	thread legend\nomusic_maps::init();

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

	// Gloves 
	precacheModel("viewmodel_hands_zombie");
	precacheModel("viewmodel_base_viewhands");
	precacheModel("viewhands_desert_opfor");
	precacheModel("viewhands_black_kit");

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
	precacheitem( "bananagun_mp" );
	precacheitem( "g36c_silencer_mp" );
	precacheitem( "concussion_grenade_mp" );
	precacheitem( "dragunov_mp" );
	precacheitem( "g36c_reflex_mp");
	precacheitem( "g36c_mp");

	// Vip Content

	precacheModel( "playermodel_mw2_vip_pres" );
	precacheModel( "playermodel_bo2_nikolai" );
	precacheModel( "viewmodel_golden_wrench" );
	precacheModel( "playermodel_vc_zachaev" );
	precacheModel( "viewhands_vc_zachaev" );
	precacheModel( "viewhands_bo2_nikolai" );
	precacheModel("viewmodel_mw_knife");
	preCacheModel("playermodel_vc_makarov");
	preCacheModel("viewhands_vc_makarov");

	precacheitem( "ak74u_reflex_mp" );
	precacheitem( "uzi_reflex_mp" );
	precacheItem("ac130_105mm_mp");

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
	precacheShader( "casinochip_head");
	precacheShader( "casinochip_trail");

	precacheStatusIcon( "hud_status_ghostp" );
	precacheStatusIcon( "hud_status_connecting" );
	precacheStatusIcon( "hud_status_dead" );
	precacheStatusIcon( "hudicon_american" );
	precacheStatusIcon( "hudicon_opfor" );
	precacheHeadIcon( "headicon_admin" );

	precacheModel("body_mp_usmc_woodland_sniper");
	precacheModel("head_mp_usmc_ghillie");
	precacheModel("viewhands_marine_sniper");
	precacheModel("body_mp_usmc_woodland_recon");
	precacheModel("head_mp_usmc_nomex");
	precacheModel("viewhands_sas_woodland");
	precacheModel("body_mp_arab_regular_cqb");
	precacheModel("head_mp_arab_regular_headwrap");
	precacheModel("viewhands_desert_opfor");
	precacheModel("body_mp_opforce_cqb");
	precacheModel("head_mp_opforce_gasmask");
	precacheModel("viewhands_op_force");
	preCacheModel("viewhands_force_recon");
	preCacheModel("viewhands_usmc");
	preCacheModel("chicken");
	preCacheModel("vistic_coin1");

	level.fx["gib_splat"] = loadFx( "deathrun/gib_splat" );
	level.fx["light_blink"] = loadFx( "misc/light_c4_blink" );
	level.fx["insertion"] = loadfx("deathrun/vc_flare");
	level.fx["vc_endgame"] = loadfx("deathrun/fx_endgame");

	// Vip Trails
	level.fx[1] = loadfx("trails/vip1");
	level.fx[2] = loadfx("trails/vip2");
	level.fx[3] = loadfx("trails/vip3");
	level.fx[4] = loadfx("trails/vip4");
	level.fx[5] = loadfx("trails/vip5");
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

buildAbilityInfo()
{
	level.abilityInfo = [];
	level.numAbilities = 0;
	
	tableName = "mp/abilityTable.csv";

	for( idx = 1; isdefined( tableLookup( tableName, 0, idx, 0 ) ) && tableLookup( tableName, 0, idx, 0 ) != ""; idx++ )
	{
		id = int( tableLookup( tableName, 0, idx, 1 ) );
		level.abilityInfo[id]["prestige"] = int(tableLookup( tableName, 0, idx, 2 ));
		level.abilityInfo[id]["codeName"] = tableLookup( tableName, 0, idx, 3 );
		level.abilityInfo[id]["shader"] = tableLookup( tableName, 0, idx, 4 );
		level.abilityInfo[id]["name"] = tableLookup( tableName, 0, idx, 5 );
		level.abilityInfo[id]["cl_stat"] = int(tableLookup( tableName, 0, idx, 6 ));
		
		precacheShader( level.abilityInfo[id]["shader"] );
		level.numAbilities++;
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
		level.characterinfo[id]["rank"]=(int(tablelookup(table,0,idx,2))-1);
		level.characterinfo[id]["model"]=tablelookup(table,0,idx,3);
		level.characterinfo[id]["name"]=tablelookup(table,0,idx,4);
		level.characterinfo[id]["prestige"]=int(tablelookup(table,0,idx,5));
		level.characterinfo[id]["cl_stat"]=int(tablelookup(table,0,idx,6));

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
		level.item2Info[id]["prestige"] = int(tableLookup( tableName, 0, idx, 2 ));
		level.item2Info[id]["item"] = (tableLookup( tableName, 0, idx, 3 ) + "_mp");
		level.item2Info[id]["name"] = tableLookup( tableName, 0, idx, 4 );
		level.item2Info[id]["cl_stat"] = int(tableLookup( tableName, 0, idx, 5 ));
		
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
		level.trailInfo[id]["prestige"] = int(tableLookup( tableName, 0, idx, 2 ));
		level.trailInfo[id]["shader"] = tableLookup( tableName, 0, idx, 3 );
		level.trailInfo[id]["effect"] = loadFx(tableLookup( tableName, 0, idx, 4 ));
		level.trailInfo[id]["name"] = tableLookup( tableName, 0, idx, 5 );
		level.trailInfo[id]["cl_stat"] = int(tableLookup( tableName, 0, idx, 6 ));

		precacheShader( level.trailInfo[id]["shader"] );
		level.numTrails++;
	}
}

buildkillcardInfo()
{
	level.killcardinfo=[];
	level.numkillcards=0;

	table="mp/killcardTable.csv";

	for(idx=1;isdefined(tablelookup(table,0,idx,0)) && tablelookup(table,0,idx,0)!="";idx++)
	{
		id=int(tablelookup(table,0,idx,1));
		level.killcardinfo[id]["rank"]=(int(tablelookup(table,0,idx,2))-1);
		level.killcardinfo[id]["shader"]=tablelookup(table,0,idx,3);
		level.killcardinfo[id]["prestige"]=int(tablelookup(table,0,idx,4));

		precacheShader(level.killcardinfo[id]["shader"]);
		level.numkillcards++;
	}
}

buildemblemInfo()
{
	level.embleminfo=[];
	level.numemblems=0;

	table="mp/emblemTable.csv";

	for(idx=1;isdefined(tablelookup(table,0,idx,0)) && tablelookup(table,0,idx,0)!="";idx++)
	{
		id=int(tablelookup(table,0,idx,1));
		level.embleminfo[id]["rank"]=(int(tablelookup(table,0,idx,2))-1);
		level.embleminfo[id]["shader"]=tablelookup(table,0,idx,3);
		level.embleminfo[id]["prestige"]=int(tablelookup(table,0,idx,4));

		precacheShader(level.embleminfo[id]["shader"]);
		level.numemblems++;
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

	self setClientDvars( "show_hud", "true", "ip", getDvar("net_ip"), "port", getDvar("net_port") );
	if( !isDefined( self.pers["team"] ) )
	{
		iprintln("^5"+self.name+"^7 entered ^5Vistic ^7DeathRun");

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
		self.pers["time"] = 99999999;
		self.pers["isDog"] = false;
		self.pers["ability"] = "specialty_null";

		self.pers["vc_killstreak"] = 0;

		// Admin Definitions
		self.pers["adm_spawnall"] = 0;
		self.pers["adm_spawn"] = 0;
	}
	else
	{
		self.score = self.pers["score"];
		self.kills = self.pers["kills"];
		self.assists = self.pers["assists"];
		self.deaths = self.pers["deaths"];
	}

	self thread SetupLives();

	self thread timeplayed();

	self thread modBanned();

	if( game["state"] == "endmap" )
	{
		self spawnSpectator( level.spawn["spectator"].origin, level.spawn["spectator"].angles );
		self.sessionstate = "intermission";
		return;
	}

	if( isDefined( self.pers["weapon"] ) && self.pers["team"] != "spectator" )
	{
		self.pers["weapon"] = "colt_mp";
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


playerDisconnect() // Called when player disconnect from server
{
	level notify( "disconnected", self );

	//if(isDefined(self) && isdefined(self.pers["vip"]) && self.pers["vip"] == true )
		//self thread plugins\_vip::statresetzr();

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
		self iprintlnbold("you took too much ^5Damage^7, you've been set to ^5Spawn");
		self setorigin(level.spawn["allies"][randomint(self.pers["team"].size)].origin);
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
		if( isPlayer( eAttacker ) && eAttacker.pers["ability"] == "specialty_bulletdamage" )
			iDamage = int( iDamage * 1.1 );

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

			if( sMeansOfDeath == "MOD_HEAD_SHOT" )
				attacker braxi\_missions::process_challenge( "ch_headhunter" ); // Kill 20 Enemies by Headshot

			if( !attacker isOnGround() && !self isOnGround() )
				attacker braxi\_missions::process_challenge( "ch_airkill" ); // Kill 25 enemies while both of You are in air

			attacker braxi\_missions::find_weapon_challenge(sWeapon);

			if( self.pers["team"] == "axis" )
			{
				if(isdefined( attacker.usedLife ))
					attacker braxi\_missions::process_challenge( "ch_zombie" ); // Kill an Activator after respawning with a Life

				if(level.lastJumper && level.ch_lastJumper == attacker)
					attacker braxi\_missions::process_challenge( "ch_oneoone" ); // Kill an Activator while youre the last Jumper

				if(!level.trapsdisabled)
					attacker braxi\_missions::process_challenge( "ch_dare" ); // Kill 150 Activators while Traps are enabled

				attacker giveLife();
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

			}
		}
	}

	if( !level.freeRun && !self.ghost )
	{
		deaths = self maps\mp\gametypes\_persistence::statGet( "deaths" );
		self maps\mp\gametypes\_persistence::statSet( "deaths", deaths+1 );
		self.deaths++;
		self.pers["deaths"]++;

		self braxi\_missions::process_challenge( "ch_tryhard", 1 ); // Die 250 Times
	}
	self.died = true;

	if(isdefined(self.ghost) && self.ghost) 
		self.ghost=false;

	self thread cleanUp();

	obituary( self, attacker, sWeapon, sMeansOfDeath );

	
	if( self.pers["team"] == "axis" )
	{
		if( isPlayer( attacker ) && attacker.pers["team"] == "allies" )
		{
			thread drawInformationsmall( 800, 0.8, 1, attacker.name+" ^7killed Activator" );
			thread drawInformationsmall( 800, 0.8, -1, attacker.name+" ^7killed Activator" );
		}

		level.activatorKilled = true;
		self thread braxi\_teams::setTeam( "allies" );
	}
	if( self.pers["team"] != "axis" )
		self thread respawn();

	wait .45;
	if( self.pers["team"] == "allies" && !level.jumpers && level.activators )
	{
		if( isPlayer( attacker ) && attacker.pers["team"] == "axis" )
		{
			thread drawInformationsmall( 800, 0.8, 1, "Activator claimed Victory" );
			thread drawInformationsmall( 800, 0.8, -1, "Activator claimed Victory" );
		}
	}
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

	if(self.pers["vip"])
	{
		self.statusicon="hudicon_opfor";
		if(self getstat(764)==1)
			self.headicon="headicon_admin";
	} 
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

	if(self.pers["team"] == "allies")//vip weapons
	{
		if(self.pers["vip"] && self getstat(1214) != 0)
		{
			switch(self getstat(1214))
			{
				case 1: self.pers["weapon"]="bananagun_mp"; break;
				case 2: self.pers["weapon"]="ak74u_reflex_mp"; break;
				case 3: self.pers["weapon"]="g36c_silencer_mp"; break;
			}
		}
		else 
			self.pers["weapon"] = level.itemInfo[self getStat(981)]["item"];
	}
	
	if(self.pers["team"] == "axis")
		self.pers["weapon"] = "tomahawk_mp";

	if(self.pers["vip"])//vip knifes
	{
		switch(self getstat(1213))
		{
			case 0: self.pers["knife"] = level.item2Info[self getStat(984)]["item"]; break;
			case 1: self.pers["knife"] = "ak47_silencer_mp"; break;
			case 2: self.pers["knife"] = "ac130_105mm_mp"; break;
			case 3: self.pers["knife"] = "uzi_reflex_mp"; break;
			case 4: self.pers["knife"] = "claymore_mp"; break;
		}
	}
	else
		self.pers["knife"] = level.item2Info[self getStat(984)]["item"];

	//shop weapons cheak if stats got reseted
	if(self.pers["knife"] == "m21_acog_mp" && self getstat(2536) != 1 || self.pers["knife"] == "ak74u_acog_mp" && self getStat(2537) != 1)
		self.pers["knife"] = "knife_mp";

	if(self.pers["weapon"] == "g36c_reflex_mp" && self getstat(2538) != 1 || self.pers["weapon"] == "g36c_mp" && self getStat(2539) != 1 || self.pers["weapon"] == "briefcase_bomb_mp" && self getstat(2540) == 0)
		self.pers["weapon"] = "beretta_mp";

	if(!level.trapsdisabled)
	{
		self giveWeapon( self.pers["weapon"] );
		self giveweapon( self.pers["knife"] );
		self setSpawnWeapon( self.pers["weapon"] );
		self giveMaxAmmo( self.pers["weapon"] );
	}
	else 
	{
		self.pers["weapon"] = "knife_mp";

		self giveWeapon( self.pers["weapon"] );
		self setSpawnWeapon( self.pers["weapon"] );
		self giveMaxAmmo( self.pers["weapon"] );
	}

	if(self.pers["vip"])
	{
		switch(self getstat(765))
		{
			case 0:
				self setviewmodel("viewhands_black_kit");
				break;
			case 1:
				self setviewmodel("viewhands_desert_opfor");
				break;
			case 2:
				self setviewmodel("viewhands_vc_zachaev");
				break;
			case 3:
				self setviewmodel("viewhands_bo2_nikolai");
				break;
			case 4:
				self setviewmodel("viewhands_vc_makarov");
				break;
		}
	}
	else
		self setviewmodel("viewhands_black_kit");

	self thread braxi\_teams::setHealth();
	self thread braxi\_teams::setSpeed();
	self thread afterFirstFrame();

	self thread legend\daily_challanges::init();

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

	/*if( self.pers["team"] == "axis" && !melon_disabled(getdvar("mapname")) )
		self thread watch_watermelon();*/

	//self thread bunnyHoop();
	if(!self.ghost)
	{
		self clearPerks();
		self.pers["ability"] = level.abilityInfo[self getStat(982)]["codeName"];
		if( self.pers["ability"] != "specialty_null" && self.pers["ability"] != "" )
		{
			self setPerk( self.pers["ability"] );
			self thread showAbility();

			if( self.pers["ability"] == "specialty_armorvest"  )
			{
				self.maxhealth = self.health + int( self.health/10 );
				self.health = self.maxhealth;
			}
		}

		self thread watch_flare();
		self thread playerTimer();
		self thread sprayLogo();
		self thread userTrail();

		/*if( self.pers["team"] == "allies")
			self thread MovingReward();*/

		if(getdvar("mapname") == "mp_dr_dball_gt")
			self thread bunnyHoop();
	}
}

userTrail()
{
	self endon("disconnect");

	self.pers["trail"] = level.trailInfo[self getStat(986)]["effect"];

	if(self.pers["vip"] && self getstat(1220) != 0)
	{
		switch(self getstat(1220))
		{
			case 1:
				playfxontag(level.fx[1],self,"tag_origin");
				break;
			case 2:
				playfxontag(level.fx[2],self,"tag_origin");
				break;
			case 3:
				playfxontag(level.fx[3],self,"tag_origin");
				break;
			case 4:
				playfxontag(level.fx[4],self,"tag_origin");
				break;
			case 5:
				playfxontag(level.fx[5],self,"tag_origin");
				break;
		}
	}
	else 
	{
		if(self getstat(986) == 0)
			return;

		while(self isReallyAlive())
		{
			playFx(self.pers["trail"],self.origin+(0,0,10));
			wait 0.25;
		}
	}
}

/*MovingReward()
{
	self endon( "disconnect" );
	self endon( "death" );

	waittillframeend;

	if(isDefined(level.freeRun) && level.freeRun)
		return;

	oldpos = [];
	oldpos[0] = self.origin;
	count = 5;
	bla = false;

	while(isalive(self) && count>0 && self.pers["team"]=="allies" && (!isDefined(level.freeRun)||!level.freeRun))
	{
		wait 1;
		for(i=0;i<oldpos.size;i++)
		{
			if( Distance( self.origin, oldpos[i] ) < 3000 )
			{
				bla = true;
				break;
			}
		}
		if( bla || !self isOnGround() )
		{
			bla = false;
			continue;
		}
		oldpos[oldpos.size] = self.origin;
		self braxi\_rank::giveRankXp(undefined,5);

		if(self getstat(2358)<300)
			self blade\_credits::claimReward(1);

		count--;
	}
}*/

bunnyHoop()
{
	self endon( "disconnect" );
    self endon( "spawned_player" );
    self endon( "joined_spectators" );
    self endon( "death" );

    while(game["state"]!="playing")
		wait 0.05;

	if(getDvar("mapname") == "mp_deathrun_qube")
        return;
    
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

		/*sprayNum = self getStat( 979 );
		
		if( sprayNum < 0 )	
			sprayNum = 0;
		else if(sprayNum> level.numSprays )
			sprayNum = level.numSprays;*/

		playFx( level.sprayInfo[sprayNum]["effect"], position, forward, up );
		self playSound( "sprayer" );

		self notify( "spray", sprayNum, position, forward, up ); // ch_sprayit

		wait level.dvar["sprays_delay"];
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

	if(isdefined(level.hud_time))		level.hud_time destroy();
	if(isdefined(level.hud_jumpers))	level.hud_jumpers destroy();
	if(isdefined(level.hud_round))		level.hud_round destroy();

	thread blade\_shaders::destroyhuds();

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
			players[i] thread blade\_shaders::destroyclienthuds();
			players[i] thread blade\_endround::main();
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
	level.matchStartText setText("Waiting for more Players to start the Round...");
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
		level.hud_time setTimer( level.dvar["freerun_time"] );
		thread freeRunTimer();
		
		thread drawInformationSmall( 800, 0.8, 1, "First Round" );
		thread drawInformationSmall( 800, 0.8, -1, "First Round" );
		return;
	}
	else
	{
		level thread restrictSpawnAfterTime( level.dvar["spawn_time"] );
		level thread checkTimeLimit();

		level.hud_jumpers fadeOverTime( 2 );
		level.hud_jumpers.alpha = 1;
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
				pickRandomActivator();
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
			players[i] thread antiAFK();
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
	thread braxi\_slider::messageSlider(guy.name+" was picked to be Activator");
		
	guy thread braxi\_teams::setTeam( "axis" );
	guy spawnPlayer();
	guy braxi\_rank::giveRankXp( "activator" );
		
	setDvar( "last_picked_player", guy getEntityNumber() );
	level notify( "activator", guy );
	level.activ = guy;
}

checkTimeLimit()
{
	level endon( "endround" );
	level endon( "game over" );

	if( !level.dvar["time_limit"] )
		return;

	time = 60 * level.dvar["time_limit"];	
	level.hud_time setTimer( time );
	wait time;	
	level thread endRound( "Time limit reached", "activators" );
}

endMap( winningteam )
{
	game["state"] = "endmap";
	level notify( "intermission" );
	level notify( "game over" );

	setDvar( "g_deadChat", 1 );

	if(isdefined(level.hud_time))		level.hud_time destroy();
	if(isdefined(level.hud_jumpers))	level.hud_jumpers destroy();
	if(isdefined(level.hud_round))		level.hud_round destroy();

	thread blade\_shaders::destroyhuds();

	players = getAllPlayers();
	for( i = 0; i < players.size; i++ )
	{
		players[i] closeMenu();
		players[i] closeInGameMenu();
		players[i] thread blade\_endround::end_map();
		players[i] freezeControls( true );
		players[i] cleanUp();
		players[i] destroyLifeIcons();
		players[i] thread blade\_shaders::destroyclienthuds();

		if(players[i].pers["vip"])
			players[i] thread plugins\_vip::statresetzr();
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
			braxi\_scoreboard::showBestStats();

	saveMapScores();
	saveAllScores();

	wait 0.5;

	teddysOrigin = level.spawn["spectator"].origin + vector_scale( anglesToForward( level.spawn["spectator"].angles ), 120 ) + vector_scale( anglesToUp( level.spawn["spectator"].angles ), 180 );
	playFx( level.fx["vc_endgame"], teddysOrigin );
	playFx( level.fx["vc_endgame"], level.spawn["spectator"].origin + (0,0,100) );

	players = getAllPlayers();

	if(players.size > 0)
	{
		braxi\_mapvote::startMapVote();
		level waittill("mapvote_over");
	}
	else if(players.size == 0 || players == undefined)
	{
		braxi\_mapvote::startMapVote();
		level.map["vc_votes6"]=1;
	}

	braxi\_credits::main();
	
	players = getAllPlayers();
	for( i = 0; i < players.size; i++ )
	{
		players[i] thread blade\_drop::randomDrop();
		players[i] spawnSpectator( level.spawn["spectator"].origin, level.spawn["spectator"].angles );
		players[i].sessionstate = "intermission";
	}

	//for saveing daily challenge
	dch_db = FS_FOpen( "legend/dch_cheaker.txt", "write" );
    FS_WriteLine(dch_db, game["dailych"]);
    FS_FClose(dch_db);

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
		self maps\mp\_utility::setLowerMessage("Press ^5[{+activate}]^7 for ^5Train Mode");
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
			setDvar("admin", "afk:" + self getEntityNumber());
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

doHud()
{
	level endon("round_ended");
	level endon("game over");
	level endon( "intermission" );

	level.randomcolor = (randomint(100)/100,randomint(100)/100,randomint(100)/100);

	level.hud_round = newHudElem();
    level.hud_round.foreground = true;
	level.hud_round.alignX = "left";
	level.hud_round.alignY = "top";
	level.hud_round.horzAlign = "left";
    level.hud_round.vertAlign = "top";
    level.hud_round.x = 6;
    level.hud_round.y = 47;
    level.hud_round.archived = 0;
    level.hud_round.sort = 0;
  	level.hud_round.fontScale = 1.6;
	level.hud_round.glowColor = level.randomcolor;
	level.hud_round.glowAlpha = 1;
 	level.hud_round.hidewheninmenu = true;
	level.hud_round settext("Round: ^5"+game["roundsplayed"]+" ^7/ ^5"+level.dvar["round_limit"]);

	level.hud_time = newHudElem();
    level.hud_time.foreground = true;
	level.hud_time.alignX = "left";
	level.hud_time.alignY = "top";
	level.hud_time.horzAlign = "left";
    level.hud_time.vertAlign = "top";
    level.hud_time.x = 6;
    level.hud_time.y = 71;
    level.hud_time.archived = 0;
    level.hud_time.sort = 0;
  	level.hud_time.fontScale = 1.6;
	level.hud_time.glowColor = level.randomcolor;
	level.hud_time.glowAlpha = 1;
	level.hud_time.label = &"Time Left: ^5";
 	level.hud_time.hidewheninmenu = true;

	level.hud_jumpers = newHudElem();
    level.hud_jumpers.foreground = true;
	level.hud_jumpers.alignX = "left";
	level.hud_jumpers.alignY = "top";
	level.hud_jumpers.horzAlign = "left";
    level.hud_jumpers.vertAlign = "top";
    level.hud_jumpers.x = 6;
    level.hud_jumpers.y = 94;
    level.hud_jumpers.archived = 0;
    level.hud_jumpers.sort = 0;
  	level.hud_jumpers.fontScale = 1.6;
	level.hud_jumpers.glowColor = level.randomcolor;
	level.hud_jumpers.glowAlpha = 1;
 	level.hud_jumpers.hidewheninmenu = true;

 	if( level.freeRun )
		level.hud_jumpers.label = &"Free Run Round";
	else 
	{
		level.hud_jumpers.label = &"Jumpers alive: ^5";

		while( 1 )
		{
			wait 1;
			level.hud_jumpers setValue( level.jumpers );
		}
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

	messages = strTok( level.dvar["messages"], ";" );
	lastMessage = messages.size-1;
	if( !isDefined( game["msg_time"] ) )	game["msg_time"] = 0;
	if( !isDefined( game["msg"] ) )			game["msg"] = 0;

	while( 1 )
	{
		if( game["msg_time"] == level.dvar["messages_delay"] )
		{
			game["msg_time"] = 0;
			iPrintln( "^1>>^7 " + messages[game["msg"]] );
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

 	hud.fontScale = 1.8;

	hud.color = (0.8, 1.0, 0.8);
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
 	hud.fontScale = 1.5;
	hud.font = "objective";
	hud.glowColor = level.randomcolor;
	hud.glowAlpha = 1;
	hud.alpha = 0;
	hud fadeovertime( fade_in_time );
	hud.alpha = 1;
	hud.hidewheninmenu = true;
	hud.sort = 10;
	hud.archived = false;
	return hud;
}


drawInformation( start_offset, movetime, mult, text )
{
	start_offset *= mult;
	hud = new_ending_hud( "center", 0.1, start_offset, 54 );
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

drawInformationSmall( start_offset, movetime, mult, text )
{
	start_offset *= mult;
	hud = new_smaller_ending_hud( "center", 0.1, start_offset, 220 );
	hud setText( text );
	hud moveOverTime( movetime );
	hud.fontscale = 1.6;
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
	
	self addLifeIcon(0,-20,100);
	self addLifeIcon(1,-5,100);
	self addLifeIcon(2,10,100);

	wait .05;
	
	if( !self.pers["lifes"] )
		return;

	for(i=0;i!=self.pers["lifes"];i++)
	{
		self.hud_lifes[i] fadeovertime(1);
		self.hud_lifes[i].alpha=1;
	}
}

addLifeIcon(num,x,y)
{

	hud = newClientHudElem( self );
    hud.foreground = true;
	hud.x = x;
	hud.y = y;
	hud setShader( "stance_stand", 64, 64 );
	hud.alignX = "left";
	hud.alignY = "top";
	hud.horzAlign = "left";
	hud.vertAlign = "top";
	hud.sort = 10;
	hud.alpha = 0;
	hud.archived = 0;
 	hud.hidewheninmenu = true;
 	self.hud_lifes[num] = hud;
}

giveLife()
{
	if(self.pers["lifes"]>=3)
		return;

	self.pers["lifes"]++;
	//self setstat(983,self.pers["lifes"]);
	hud = self.hud_lifes[ self.pers["lifes"]-1 ];
	hud fadeovertime(1);
	hud.alpha=1;
	hud SetPulseFX( 30, 100000, 700 );
}

useLife()
{
	if( !self.pers["lifes"] || self.sessionstate == "playing" || !level.dvar["allowLifes"] )
		return; 

	hud = self.hud_lifes[ self.pers["lifes"]-1 ];
	hud fadeOverTime( 1 );
	hud.alpha = 0;
	hud.glowAlpha = 0;

	self.pers["lifes"]--;
	//self setstat(983,self.pers["lifes"]);

	if( !self.pers["lifes"] )
		self iPrintlnbold( "^7This was your last ^5Life^7, don't ^5waste ^7it" );

	iprintln("^5"+self.name+ "^7 has used a ^5Life");

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

		if( !user isReallyAlive() || user.pers["team"] == "axis" )
			continue;

		if(user.ghost)
		{
			user suicide();
			user iprintlnbold( "^5You've^7 finished the Map in ^5Train Mode" );

			user blade\_credits::claimReward(5);
			user braxi\_missions::process_challenge( "ch_ghost" ); // Finish a Map 30 Times while being in Train Mode
		}
		else
		{
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
}

endTimer()
{
	if( isDefined( self.finishedMap ) )
		return;

	self.finishedMap = true;

	time = getTime() - self.timerStartTime;

	if(!level.freerun)
		saveTimes(self, time);

	time = (getTime() - self.timerStartTime) / 1000;

	self.hud_time destroy();
	self.hud_time = addTextHud( self, 7, -22, 1, "left", "bottom", 1.4 );
	self.hud_time.horzAlign = "left";
    self.hud_time.vertAlign = "bottom";
	self.hud_time.glowAlpha = 0.5;
	self.hud_time.foreground = true;
	self.hud_time.glowColor = level.randomcolor;
	self.hud_time.archived = 0;
	self.hud_time.hidewheninmenu = true;

	self.hud_time setText( "Your Time: ^5" + time );

	self iprintlnbold( "^5You've^7 finished the Map in ^5" + time + " ^7Seconds" );

	if( time < self.pers["time"] )
		self.pers["time"] = time;
}

fastestTimes()
{
	level.playerTimes = [];

	for(i=0; i<5; i++)
	{
		level.playerTimes[i]["time"] = 999999999;
		level.playerTimes[i]["name"] = "---";
		level.playerTimes[i]["guid"] = "123";
	}

	wait 1;

    if(getDvar("dr_fastesttimes_" + level.mapName) != "")
    {
    	Print(getDvar("dr_fastesttimes_" + level.mapName));
    	oldscores = getDvar("dr_fastesttimes_" +level.mapName);
    	token = strTok(oldscores, "\n");
    	count = 0;

    	for(x=0; x<5;x++)
        {
        	placement = strTok(token[count], "\\");
        	if(placement[0] != " " && isDefined(placement[0]))
        		level.playerTimes[x]["name"] = placement[0];
        	if(placement[1] != "999999999" && isDefined(placement[1]))
        		level.playerTimes[x]["time"] = int(placement[1]);
        	if(placement[2] != "123" && isDefined(placement[2]))
        		level.playerTimes[x]["guid"] = placement[2];
        	count++;
        }
    }
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

	self.hud_time = addTextHud( self, 7, -22, 1, "left", "bottom", 1.4 );
	self.hud_time.horzAlign = "left";
    self.hud_time.vertAlign = "bottom";
	self.hud_time.glowAlpha = 0.5;
	self.hud_time.foreground = true;
	self.hud_time.glowColor = level.randomcolor;
	self.hud_time.archived = 0;
	self.hud_time.hidewheninmenu = true;

	self.hud_time.label = &"Your Time: ^5&&1";
	self.hud_time setTenthsTimerUp( 1 );

	self.timerStartTime = getTime();
}

initScoresStat( num, name )
{
	level.bestScores[num]["name"] = name;
	level.bestScores[num]["value"] = 0;
	level.bestScores[num]["player"] = " ";
	level.bestScores[num]["guid"] = "123";
}

bestMapScores()
{
	level.statDvar = ("dr_info_" + level.mapName);
	level.bestScores = [];

	initScoresStat( 0, "kills" );
	initScoresStat( 1, "deaths" );
	initScoresStat( 2, "headshots" );
	initScoresStat( 3, "score" );
	initScoresStat( 4, "knifes" );
	initScoresStat( 5, "time" );

	addDvar( "best_scores", level.statDvar, "", "", "", "string" );
	
	data = strTok( level.dvar["best_scores"], ";" );
	if( !data.size ) return;

	for( i = 0; i < data.size; i++ )
	{
		stat = strTok( data[i], "," );
		if( !isDefined( stat[0] ) || !isDefined( stat[1] ) || !isDefined( stat[2] ) || !isDefined( stat[3] ) )
		{
			iprintln( "Error reading " + level.statDvar + " (" + i + "), stat size is " + stat.size );
			continue;
		}
		for( x = 0; x < level.bestScores.size; x++ )
		{
			if( level.bestScores[x]["name"] == stat[0] )
			{
				level.bestScores[x]["value"] = stat[1];
				level.bestScores[x]["guid"] = stat[2];
				level.bestScores[x]["player"] = stat[3];
			}
		}
	}

	logPrint( "COPY TO CFG: set dr_info_"+level.mapName+" \""+level.dvar["best_scores"]+"\"\n" );
}

appendToDvar( dvar, string )
{
	setDvar( dvar, getDvar( dvar ) + string );
}

saveMapScores()
{
	setDvar( level.statDvar, "" );
	for( i = 0; i < level.bestScores.size; i++ )
	{
		var = ";" + level.bestScores[i]["name"] + "," + level.bestScores[i]["value"];
		var = var + "," + level.bestScores[i]["guid"];
		var = var + "," + level.bestScores[i]["player"];

		appendToDvar( level.statDvar, var );
		level.dvar["best_scores"] = getDvar( level.statDvar );
	}
	logPrint( "MAP_STATS: set dr_info_"+level.mapName+" \""+level.dvar["best_scores"]+"\"\n" );
}

saveAllScores()
{
	logPrint( "===== BEGIN SCORES =====\n");
	for( i = 0; i < game["playedmaps"].size; i++ )
	{
		logPrint( "set dr_info_" + game["playedmaps"][i] + " \"" + getDvar( "dr_info_"+game["playedmaps"][i] )  + "\"\n" );
	}
	logPrint( "===== END SCORES =====\n");
}

updateRecord( num, player )
{
	level.bestScores[num]["value"] = player.pers[level.bestScores[num]["name"]];
	level.bestScores[num]["player"] = player.name;
	level.bestScores[num]["guid"] = player getGuid();

	if( level.bestScores[num]["player"] == "" )
		level.bestScores[num]["player"] = " ";

	if( level.bestScores[num]["guid"] == "" )
		level.bestScores[num]["guid"] = "123";
}

saveTimes(player, time)
{
	if(isdefined(player.usedLife))
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

			saveToDvar();
			return;
		}
	}
}

saveToDvar()
{
	string = "";
    setDvar("dr_fastesttimes_" + level.mapName, "" );
    for(i=0; i<5; i++)
    {
    	string = level.playerTimes[i]["name"]+"\\";
    	string = string + level.playerTimes[i]["time"] +"\\";
    	string = string + level.playerTimes[i]["guid"] + "\n";

    	addToDvar("dr_fastesttimes_" + level.mapName, string); 
    } 
}

addToDvar(dvar, var)
{
    setDvar(dvar, getDvar(dvar) + var);
}

realtime(number)
{
    if(number == 999999999)
    {
        playertime = "00:00:00";
        return playertime;
    }

    miliseconds = number;
    minutes = int(miliseconds/60000);
    miliseconds = miliseconds % 60000;
    seconds = int(miliseconds/1000);
    miliseconds = miliseconds % 1000;

    if(miliseconds <= 9)
        miliseconds = "0" + miliseconds;
    if(minutes <= 9)
        minutes = "0" + minutes;
    if(seconds <= 9)
       seconds = "0" + seconds;

    playertime =  "" + minutes + ":" + seconds + ":"  + miliseconds;

    return playertime;
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

	hud = addTextHud( level, 320, 600, 0, "center", "middle", 2 );
	hud setText("First victim of this round is "+who.name+"!");

	hud.glowColor = level.randomcolor;
    hud.fontscale = 1.4;
    hud.glowAlpha = 1;
	hud.alpha = 1;
	hud.y = 600;
	
	hud moveOverTime( 1 );
	hud.y = 420;
	
	wait 4;

	hud moveOverTime( 1 );
    hud.y = 600;
	
	wait 1.5;
	
	hud destroy();
}

lastJumper()
{
	if( !level.dvar["lastalive"] || level.lastJumper )
		return;
	   
	level.lastJumper = true;
	what = randomintrange(1,5);
	level thread playSoundOnAllPlayers( "last_alive"+what );

	level.ch_lastJumper = self;

	hud = addTextHud( level, 320, 240, 0, "center", "middle", 2 );
	hud setText(self.name+" is the last jumper alive!");

    hud.glowColor = level.randomcolor;
    hud.fontscale = 1.4;
    hud.glowAlpha = 1;
	hud.alpha = 1;
    hud.y = 600;
	
	hud moveOverTime( 1 );
	hud.y = 435;
	
	wait 4;

	hud moveOverTime( 1 );
    hud.y = 600;
	wait 1.5;

	hud destroy();
}

watch_watermelon()
{
	if( self.pers["team"] == "allies" )
		return;

	self endon( "spawned_player" );
	self endon( "disconnect" );


	insertionItem = "g36c_silencer_mp";
	self giveWeapon( insertionItem );
	self giveMaxAmmo( insertionItem );
	self setActionSlot( 3, "weapon", insertionItem );
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

		if( !self isOnGround() || distance( self.origin, pos ) > 48 )
		{
			self iPrintlnBold( "^1You can't use insertion here" );
			entity delete();
			continue;
		}

		self cleanUpInsertion();
		self.insertion = entity;

		self.flare_fx = spawnfx(level.fx["insertion"],self.insertion.origin+(0,0,10));
		triggerfx(self.flare_fx);

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

showAbility()
{
	self notify( "show ability" );
	self endon( "show ability" );
	self endon( "disconnect" );

	if( isDefined( self.abilityHud ) )
		self.abilityHud destroy();

	self.abilityHud = newClientHudElem( self );
	self.abilityHud.x = 299.5;
	self.abilityHud.y = 370;
	self.abilityHud.alpha = 0.3;
	self.abilityHud setShader( self.pers["ability"], 55, 48 );
	self.abilityHud.sort = 985;
	
	self.abilityHud fadeOverTime( 0.3 );
	self.abilityHud.alpha = 1;
	wait 1;
	self.abilityHud fadeOverTime( 0.2 );
	self.abilityHud.alpha = 0;
	wait 0.2;
	self.abilityHud destroy();
}

daily_challanges_timer()
{
	for(;;)
	{
		players=getAllPlayers();

		gettime = getRealTime();
		dailyhours = 86400;
		calc = dailyhours-gettime;

		timeleft = TimeToString(calc, 1, "%H:%M:%S");

		if(timeleft == "00:00:00")
		{
			game["dailych"]++;

			if(game["dailych"] > 3)
				game["dailych"] = 0;

			dch_db = FS_FOpen( "legend/dch_cheaker.txt", "write" );
    		FS_WriteLine(dch_db, game["dailych"]);
    		FS_FClose(dch_db);

    		plugins\vip_hudmenu\_addvip::remove_oneday_vip();
    		plugins\vip_hudmenu\_addvip::vip_removeplayerifzero();

		}

		for(i=0;i<players.size;i++)
		{
			if(isDefined(players[i]))
				players[i] setClientDvar("dch_timer",timeleft);

		}

		wait 1;
	}
}

timeplayed()
{
	level endon("game over");
	self endon("disconnect");

	wait 1;

	sec = 0;
	min = 0;
	hours = 0;
	days = 0;
	for(i=0;i<(self getstat(2541)+1);i++)
	{
		sec++;
		if(sec >= 60)
		{
			sec = 0;
			min++;
		}
		if(min >= 60)
		{
			min = 0;
			hours++;
		}
		if(hours >= 24)
		{
			days++;
			hours = 0;
		}
	}

	for(;;)
	{
		sec++;
		if(sec >= 60)
		{
			sec = 0;
			min++;
		}
		if(min >= 60)
		{
			min = 0;
			hours++;
		}
		if(hours >= 24)
		{
			days++;
			hours = 0;
		}

		if(self getStat(2544)<3601)
			self braxi\_missions::process_challenge( "ch_online1" );
		if(self getStat(2545)<18001)
			self braxi\_missions::process_challenge( "ch_online2" );
		if(self getStat(2546)<86401)
			self braxi\_missions::process_challenge( "ch_online3" );
		if(self getStat(2547)<432001)
			self braxi\_missions::process_challenge( "ch_online4" );
		if(self getStat(2548)<1296001)
			self braxi\_missions::process_challenge( "ch_online5" );

		self setStat(2541,(self getStat(2541)+1));
		self setClientDvar("ui_onlinetime","D:"+days+" H:"+hours+" M:"+min+" S:"+sec);
		//self iPrintlnbold("D:"+days+" | H:"+hours+" | M:"+min+" | S:"+sec);
		wait 1;
	}
}