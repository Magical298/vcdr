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

	Design & Textures:
			Niko #2926
            EphNey #1431

    Character & Weapon Assets:
            Fox.#0001
            Magical.#9137

	Vistic Clan ©
*/
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;


init()
{
	level.scoreInfo = [];
	level.rankTable = [];

	precacheShader("white");

	precacheString( &"RANK_PLAYER_WAS_PROMOTED_N" );
	precacheString( &"RANK_PLAYER_WAS_PROMOTED" );
	precacheString( &"RANK_PROMOTED" );
	precacheString( &"MP_PLUS" );

	if(level.dvar["xpevent_enable"])
	{
		registerScoreInfo( "kill", 100 * level.dvar["xpevent_multiplier"] );
		registerScoreInfo( "headshot", 50 * level.dvar["xpevent_multiplier"] );
		registerScoreInfo( "melee", 25 * level.dvar["xpevent_multiplier"] );
		registerScoreInfo( "activator", 150 * level.dvar["xpevent_multiplier"] );
		registerScoreInfo( "trap_activation", 75 * level.dvar["xpevent_multiplier"] );
		registerScoreInfo( "jumper_died", 50 * level.dvar["xpevent_multiplier"] );
	}
	else 
	{
		registerScoreInfo( "kill", 100 );
		registerScoreInfo( "headshot", 50 );
		registerScoreInfo( "melee", 25 );
		registerScoreInfo( "activator", 150 );
		registerScoreInfo( "trap_activation", 75 );
		registerScoreInfo( "jumper_died", 50 );
	}

	registerScoreInfo( "win", 20 );
	registerScoreInfo( "loss", 10 );
	registerScoreInfo( "tie", 25 );

	level.maxRank = int(tableLookup( "mp/rankTable.csv", 0, "maxrank", 1 ));
	level.maxPrestige = int(tableLookup( "mp/rankIconTable.csv", 0, "maxprestige", 1 ));
	
	pId = 0;
	rId = 0;
	for ( pId = 0; pId <= level.maxPrestige; pId++ )
	{
		for ( rId = 0; rId <= level.maxRank; rId++ )
			precacheShader( tableLookup( "mp/rankIconTable.csv", 0, rId, pId+1 ) );
	}

	rankId = 0;
	rankName = tableLookup( "mp/ranktable.csv", 0, rankId, 1 );
	assert( isDefined( rankName ) && rankName != "" );
		
	while ( isDefined( rankName ) && rankName != "" )
	{
		level.rankTable[rankId][1] = tableLookup( "mp/ranktable.csv", 0, rankId, 1 );
		level.rankTable[rankId][2] = tableLookup( "mp/ranktable.csv", 0, rankId, 2 );
		level.rankTable[rankId][3] = tableLookup( "mp/ranktable.csv", 0, rankId, 3 );
		level.rankTable[rankId][7] = tableLookup( "mp/ranktable.csv", 0, rankId, 7 );

		precacheString( tableLookupIString( "mp/ranktable.csv", 0, rankId, 16 ) );

		rankId++;
		rankName = tableLookup( "mp/ranktable.csv", 0, rankId, 1 );		
	}

	level thread onPlayerConnect();
}


resetEverything()
{
	self.pers["prestige"] = 0;
	self.pers["rank"] = 0;
	self.pers["rankxp"] = 0;

	self setRank( self.pers["rank"], self.pers["prestige"] );

	self setStat( 2326, self.pers["prestige"] );
	self setStat( 2350, self.pers["rank"] );
	self setStat( 2301, self.pers["rankxp"] );

	self setstat(2302,0);
	self setstat(2303,0);
	self setstat(2305,0);
	self setstat(2326,0);
	self setstat(2358,0);

	for( stat = 501; stat < 546; stat++ ) // Challenge Unlocks
		self setStat( stat, 0 );

	for( stat = 2501; stat < 2543; stat++ ) // Challenge Progress
		self setStat( stat, 0 );

	for( stat = 979; stat < 985; stat++ ) // spray, character, weapon & ability
		self setStat( stat, 0 );
}

isRegisteredEvent( type )
{
	if ( isDefined( level.scoreInfo[type] ) )
		return true;
	else
		return false;
}

registerScoreInfo( type, value )
{
	level.scoreInfo[type]["value"] = value;
}

getScoreInfoValue( type )
{
	return ( level.scoreInfo[type]["value"] );
}

getScoreInfoLabel( type )
{
	return ( level.scoreInfo[type]["label"] );
}

getRankInfoMinXP( rankId )
{
	return int(level.rankTable[rankId][2]);
}

getRankInfoXPAmt( rankId )
{
	return int(level.rankTable[rankId][3]);
}

getRankInfoMaxXp( rankId )
{
	return int(level.rankTable[rankId][7]);
}

getRankInfoFull( rankId )
{
	return tableLookupIString( "mp/ranktable.csv", 0, rankId, 16 );
}

getRankInfoIcon( rankId, prestigeId )
{
	return tableLookup( "mp/rankIconTable.csv", 0, rankId, prestigeId+1 );
}

getRankInfoUnlockWeapon( rankId )
{
	return tableLookup( "mp/ranktable.csv", 0, rankId, 8 );
}

getRankInfoUnlockPerk( rankId )
{
	return tableLookup( "mp/ranktable.csv", 0, rankId, 9 );
}

getRankInfoUnlockChallenge( rankId )
{
	return tableLookup( "mp/ranktable.csv", 0, rankId, 10 );
}

getRankInfoUnlockFeature( rankId )
{
	return tableLookup( "mp/ranktable.csv", 0, rankId, 15 );
}

getRankInfoUnlockCamo( rankId )
{
	return tableLookup( "mp/ranktable.csv", 0, rankId, 11 );
}

getRankInfoUnlockAttachment( rankId )
{
	return tableLookup( "mp/ranktable.csv", 0, rankId, 12 );
}

getRankInfoLevel( rankId )
{
	return int( tableLookup( "mp/ranktable.csv", 0, rankId, 13 ) );
}


onPlayerConnect()
{
	for(;;)
	{
		level waittill( "connected", player );

		player.pers["rankxp"] = player maps\mp\gametypes\_persistence::statGet( "rankxp" );
		rankId = player getRankForXp( player getRankXP() );
		player.pers["rank"] = rankId;
		player.pers["participation"] = 0;
		player.doingNotify = false;

		player.rankUpdateTotal = 0;
		
		player.cur_rankNum = rankId;
		assertex( isdefined(player.cur_rankNum), "rank: "+ rankId + " does not have an index, check mp/ranktable.csv" );
		player setStat( 251, player.cur_rankNum );
		
		prestige = player maps\mp\gametypes\_persistence::statGet( "plevel" );
		player setRank( rankId, prestige );
		player.pers["prestige"] = prestige;

		player thread onJoinedTeam();
		player thread onJoinedSpectators();


		updateRankStats( player, rankId );
	}
}

onJoinedTeam()
{
	self endon("disconnect");

	for(;;)
	{
		self waittill("joined_team");
		self thread removeRankHUD();
	}
}


onJoinedSpectators()
{
	self endon("disconnect");

	for(;;)
	{
		self waittill("joined_spectators");
		self thread removeRankHUD();
	}
}

roundUp( floatVal )
{
	if ( int( floatVal ) != floatVal )
		return int( floatVal+1 );
	else
		return int( floatVal );
}

giveRankXP( type, value )
{
	self endon("disconnect");

	if ( !isDefined( value ) )
	{
		if(isdefined(type) && (type == "headshot" || type == "melee"))
			value = (int(level.scoreInfo["kill"]["value"]) + getScoreInfoValue( type ));
		else 
			value = getScoreInfoValue( type );
	}
		

	if( /*value > 3000 ||*/ getDvar("dedicated") == "listen server" )
		return;

	if( level.freeRun || level.trapsdisabled )
		value = int( value *0.5 ); // play deathrun or gtfo and play cj

	self.score += value;
	self.pers["score"] = self.score;

	if(game["dailych"] == 2)
		self braxi\_dailymissions::process_dailychallenge("dch_score",value);

	score = self maps\mp\gametypes\_persistence::statGet( "score" );
	self maps\mp\gametypes\_persistence::statSet( "score", score+value );

	self incRankXP( value );
	self thread updateRankScoreHUD( value, type );
}

updateRankScoreHUD( amount, type )
{
	if(!isdefined(amount) || amount == 0)
		return;

	self endon("disconnect");
	self notify("update_score");
	wait .05;

	self.rankUpdateTotal += amount;

	if(!isdefined(self.hud_rankscroreupdate))
	{
		self.hud_rankscroreupdate = newClientHudElem(self);
		self.hud_rankscroreupdate.horzAlign = "right";
		self.hud_rankscroreupdate.vertAlign = "middle";
		self.hud_rankscroreupdate.alignX = "right";
		self.hud_rankscroreupdate.alignY = "middle";
	 	self.hud_rankscroreupdate.x = -550;
		self.hud_rankscroreupdate.y = 40;
		self.hud_rankscroreupdate.font = "default";
		self.hud_rankscroreupdate.fontscale = 1.4;
		self.hud_rankscroreupdate.archived = false;
		self.hud_rankscroreupdate.glowalpha = 1;
		self.hud_rankscroreupdate.glowcolor = (0,1,0.68);
		self.hud_rankscroreupdate maps\mp\gametypes\_hud::fontPulseInit();

		self.hud_rankscroreaddition = newclienthudelem(self);
		self.hud_rankscroreaddition.horzAlign = "right";
		self.hud_rankscroreaddition.vertAlign = "middle";
		self.hud_rankscroreaddition.alignX = "right";
		self.hud_rankscroreaddition.alignY = "middle";
	 	self.hud_rankscroreaddition.x = -550;
		self.hud_rankscroreaddition.y = 25;
		self.hud_rankscroreaddition.font = "default";
		self.hud_rankscroreaddition.fontscale = 1.4;
		self.hud_rankscroreaddition.archived = false;
		self.hud_rankscroreaddition.glowalpha = 1;
		self.hud_rankscroreaddition.glowcolor = (0,1,0.68);
		self.hud_rankscroreaddition maps\mp\gametypes\_hud::fontPulseInit();
	}

	if( isDefined( self.hud_rankscroreupdate ) )
	{			
		if ( self.rankUpdateTotal < 0 )
			self.hud_rankscroreupdate.label = &"";
		else
		{
			if(isdefined(type) && type == "kill")
				self.hud_rankscroreupdate.label = &"Kill +&&1";
			else if(isdefined(type) && type == "headshot")
			{
				self.hud_rankscroreupdate.label = &"Kill +&&1";
				self.hud_rankscroreaddition.label = &"Headshot +&&1";
			}
			else if(isdefined(type) && type == "melee")
			{
				self.hud_rankscroreupdate.label = &"Kill +&&1";
				self.hud_rankscroreaddition.label = &"Slaughtered +&&1";
			}
			else if(isdefined(type) && type == "activator")
				self.hud_rankscroreupdate.label = &"Activator +&&1";
			else if(isdefined(type) && type == "trap_activation")
				self.hud_rankscroreupdate.label = &"Trap activated +&&1";
			else if(isdefined(type) && type == "jumper_died")
				self.hud_rankscroreupdate.label = &"Jumper died +&&1";
			else 
			{
				self.hud_rankscroreupdate.label = &"MP_PLUS";
				self.hud_rankscroreupdate setValue(self.rankUpdateTotal);
			}
		}

		if(isdefined(type) && (type != "melee" || type != "headshot"))
			self.hud_rankscroreupdate setValue(self.rankUpdateTotal);

		if(isdefined(type) && (type == "melee" || type == "headshot"))
		{
			self.hud_rankscroreupdate setValue(getScoreInfoValue("kill"));
			self.hud_rankscroreaddition setvalue(getScoreInfoValue( type ));
		}

		self.hud_rankscroreupdate.alpha = 1;
		self.hud_rankscroreaddition.alpha = 1;
		self.hud_rankscroreupdate thread maps\mp\gametypes\_hud::fontPulse( self );
		self.hud_rankscroreaddition thread maps\mp\gametypes\_hud::fontPulse( self );

		wait 1.2;
		self.hud_rankscroreupdate fadeovertime(0.75);
		self.hud_rankscroreaddition fadeovertime(0.75);
		self.hud_rankscroreupdate.alpha = 0;
		self.hud_rankscroreaddition.alpha = 0;
		
		self.rankUpdateTotal = 0;

		/*self.hud_rankscroreupdate.label = &"";
		self.hud_rankscroreaddition.label = &"";*/
	}
}

addition(text)
{
	self.hud_rankscroreaddition settext(text);
	self.hud_rankscroreaddition.alpha = 1;

	wait 1.2;
	self.hud_rankscroreaddition fadeovertime(0.75);
	self.hud_rankscroreaddition.alpha = 0;
}


/*updateRankScoreHUD( amount, type )
{
	if(!isdefined(amount) || amount == 0)
		return;

	self endon("disconnect");
	self notify("update_score");
	wait .05;

	self.rankUpdateTotal += amount;

	if(!isdefined(self.hud_rankscroreupdate))
	{
		self.hud_rankscroreupdate = newClientHudElem(self);
		self.hud_rankscroreupdate.horzAlign = "center";
		self.hud_rankscroreupdate.vertAlign = "middle";
		self.hud_rankscroreupdate.alignX = "center";
		self.hud_rankscroreupdate.alignY = "middle";
	 	self.hud_rankscroreupdate.x = 0;
		self.hud_rankscroreupdate.y = -30;
		self.hud_rankscroreupdate.font = "default";
		self.hud_rankscroreupdate.fontscale = 1.8;
		self.hud_rankscroreupdate.archived = false;
		self.hud_rankscroreupdate.glowalpha = 1;
		self.hud_rankscroreupdate.glowcolor = (0,1,1);
		self.hud_rankscroreupdate maps\mp\gametypes\_hud::fontPulseInit();

		self.hud_rankscroreaddition = newclienthudelem(self);
		self.hud_rankscroreaddition.horzAlign = "center";
		self.hud_rankscroreaddition.vertAlign = "middle";
		self.hud_rankscroreaddition.alignX = "center";
		self.hud_rankscroreaddition.alignY = "middle";
	 	self.hud_rankscroreaddition.x = -20;
		self.hud_rankscroreaddition.y = -50;
		self.hud_rankscroreaddition.font = "default";
		self.hud_rankscroreaddition.fontscale = 1.4;
		self.hud_rankscroreaddition.archived = false;
		self.hud_rankscroreaddition.glowalpha = 1;
		self.hud_rankscroreaddition.glowcolor = (0,1,1);
		self.hud_rankscroreaddition.alpha = 0;
		self.hud_rankscroreaddition maps\mp\gametypes\_hud::fontPulseInit();
	}

	if( isDefined( self.hud_rankscroreupdate ) )
	{			
		if ( self.rankUpdateTotal < 0 )
			self.hud_rankscroreupdate.label = &"";
		else
			self.hud_rankscroreupdate.label = &"MP_PLUS";

		if(self.rankUpdateTotal == getscoreinfovalue("headshot"))
		{
			if(isDefined(type) && type == "headshot")
				self thread addition("Head Shot!");
		}
		else 
		{
			if(level.dvar["xpevent_enable"])
				self thread addition(level.dvar["xpevent_multiplier"]+"x XP!");
		}

		if(self.rankUpdateTotal == getscoreinfovalue("melee"))
		{
			if(isdefined(type) && type == "melee"))
				self thread addition("Slaughtered!");
		}

		self.hud_rankscroreupdate setValue(self.rankUpdateTotal);
		self.hud_rankscroreupdate.alpha = 1;
		self.hud_rankscroreupdate thread maps\mp\gametypes\_hud::fontPulse( self );

		wait 1.2;
		self.hud_rankscroreupdate fadeovertime(0.75);
		self.hud_rankscroreupdate.alpha = 0;
		
		self.rankUpdateTotal = 0;
	}
}*/

removeRankHUD()
{
	if(isDefined(self.hud_rankscroreupdate))
		self.hud_rankscroreupdate.alpha = 0;
}

getRank()
{	
	rankXp = self.pers["rankxp"];
	rankId = self.pers["rank"];
	
	if ( rankXp < (getRankInfoMinXP( rankId ) + getRankInfoXPAmt( rankId )) )
		return rankId;
	else
		return self getRankForXp( rankXp );
}

getRankForXp( xpVal )
{
	rankId = 0;
	rankName = level.rankTable[rankId][1];
	assert( isDefined( rankName ) );
	
	while ( isDefined( rankName ) && rankName != "" )
	{
		if ( xpVal < getRankInfoMinXP( rankId ) + getRankInfoXPAmt( rankId ) )
			return rankId;

		rankId++;
		if ( isDefined( level.rankTable[rankId] ) )
			rankName = level.rankTable[rankId][1];
		else
			rankName = undefined;
	}
	
	rankId--;
	return rankId;
}

getSPM()
{
	rankLevel = (self getRank() % 61) + 1;
	return 3 + (rankLevel * 0.5);
}

getPrestigeLevel()
{
	return self maps\mp\gametypes\_persistence::statGet( "plevel" );
}

getRankXP()
{
	return self.pers["rankxp"];
}

incRankXP( amount )
{	
	xp = self getRankXP();
	newXp = (xp + amount);
	
	if( level.dvar["dev"] )
	{
		iprintln( "getRankXP() : " + xp );
		iprintln( "newXp : " + newXp );
	}

	if ( self.pers["rank"] == level.maxRank && newXp >= getRankInfoMaxXP( level.maxRank ) )
		newXp = getRankInfoMaxXP( level.maxRank );

	self.pers["rankxp"] = newXp;
	self maps\mp\gametypes\_persistence::statSet( "rankxp", newXp );

	rankId = self getRankForXp( self getRankXP() );
	self updateRank( rankId );
}

updateRank( rankId )
{
	if( getRankInfoMaxXP( self.pers["rank"] ) <= self getRankXP() && self.pers["rank"] < level.maxRank )
	{
		rankId = self getRankForXp( self getRankXP() );
		self setRank( rankId, self.pers["prestige"] );
		self.pers["rank"] = rankId;
		self updateRankAnnounceHUD();
	}
	updateRankStats( self, rankId );
}

updateRankStats( player, rankId )
{
	player setStat( 253, rankId );
	player setStat( 255, player.pers["prestige"] );
	player maps\mp\gametypes\_persistence::statSet( "rank", rankId );
	player maps\mp\gametypes\_persistence::statSet( "minxp", getRankInfoMinXp( rankId ) );
	player maps\mp\gametypes\_persistence::statSet( "maxxp", getRankInfoMaxXp( rankId ) );
	player maps\mp\gametypes\_persistence::statSet( "plevel", player.pers["prestige"] );
	
	if( rankId > level.maxRank )
		player setStat( 252, level.maxRank );
	else
		player setStat( 252, rankId );
}

updateRankAnnounceHUD()
{
	self endon("disconnect");

	self notify("update_rank");
	self endon("update_rank");

	team = self.pers["team"];
	if ( !isdefined( team ) )
		return;	
	
	self notify("reset_outcome");
	newRankName = self getRankInfoFull( self.pers["rank"] );

	self playlocalsound("lvlup");
	self thread rankupMessage(newRankName);

	
	/*if(self.pers["prestige"] > 0)
		reward = (1+ (self.pers["rank"]+1)) * self.pers["prestige"];
	else 
		reward = (1+ (self.pers["rank"]+1));

	self blade\_common::vc_rubys(int(reward));*/
	iprintln( &"RANK_PLAYER_WAS_PROMOTED", self, newRankName );
}

rankupMessage(name)
{
	self.rankupTitle = newClientHudElem(self);
	self.rankupTitle.horzAlign = "center";
	self.rankupTitle.vertAlign = "middle";
	self.rankupTitle.alignX = "center";
	self.rankupTitle.alignY = "middle";
	self.rankupTitle.x = -300; // 0
	self.rankupTitle.y = -120; // -70
	self.rankupTitle.font = "default";
	self.rankupTitle.fontscale = 2;
	self.rankupTitle.archived = false;
	self.rankupTitle.alpha = 1;
	self.rankupTitle.color = (0.80,0.74,0.31);
	self.rankupTitle setText("RANKED UP!");

	self.rankupDetail = newclienthudelem(self);
	self.rankupDetail.horzAlign = "center";
	self.rankupDetail.vertAlign = "middle";
	self.rankupDetail.alignX = "center";
	self.rankupDetail.alignY = "middle";
	self.rankupDetail.x = -300; // 0
	self.rankupDetail.y = -100; // -50
	self.rankupDetail.font = "default";
	self.rankupDetail.fontscale = 1.4;
	self.rankupDetail.archived = false;
	self.rankupDetail.alpha = 1;
	self.rankupDetail.label = &"New Rank: &&1";
	self.rankupDetail settext(name);

	self.rankupIcon = newclienthudelem(self);
	self.rankupIcon.horzAlign = "center";
	self.rankupIcon.vertAlign = "middle";
	self.rankupIcon.alignX = "center";
	self.rankupIcon.alignY = "middle";
	self.rankupIcon.x = -375; // -75
	self.rankupIcon.y = -110; // 60
	self.rankupIcon.archived = false;
	self.rankupIcon.alpha = 1;
	self.rankupIcon setshader(self getRankInfoIcon( self.pers["rank"], self.pers["prestige"] ), 50, 50);

	self.rankupTitle moveovertime(0.25);
	self.rankupDetail moveovertime(0.25);
	self.rankupIcon moveovertime(0.25);

	self.rankupTitle.x = 10;
	self.rankupDetail.x = 10;
	self.rankupIcon.x = -65;

	wait .28;

	self.rankupTitle moveovertime(0.25);
	self.rankupDetail moveovertime(0.25);
	self.rankupIcon moveovertime(0.25);

	self.rankupTitle.x = 0;
	self.rankupDetail.x = 0;
	self.rankupIcon.x = -75;

	wait 2.5;

	self.rankupTitle fadeovertime(0.55);
	self.rankupDetail fadeovertime(0.55);
	self.rankupIcon fadeovertime(0.55);

	self.rankupTitle.alpha = 0;
	self.rankupDetail.alpha = 0;
	self.rankupIcon.alpha = 0;

	self.rankupTitle destroy();
	self.rankupDetail destroy();
	self.rankupIcon destroy();
}

processXpReward( sMeansOfDeath, attacker, victim )
{
	if( attacker.pers["team"] == victim.pers["team"] )
		return;

	kills = attacker maps\mp\gametypes\_persistence::statGet( "kills" );
	attacker maps\mp\gametypes\_persistence::statSet( "kills", kills+1 );

	if( victim.pers["team"] == "allies" )
	{
		kills = attacker maps\mp\gametypes\_persistence::statGet( "KILLED_JUMPERS" );
		attacker maps\mp\gametypes\_persistence::statSet( "KILLED_JUMPERS", kills+1 );
	}	
	else
	{
		kills = attacker maps\mp\gametypes\_persistence::statGet( "KILLED_ACTIVATORS" );
		attacker maps\mp\gametypes\_persistence::statSet( "KILLED_ACTIVATORS", kills+1 );
	}	

	switch( sMeansOfDeath )
	{
		case "MOD_HEAD_SHOT":
			attacker.pers["headshots"]++;
			attacker braxi\_rank::giveRankXP( "headshot" );
			hs = attacker maps\mp\gametypes\_persistence::statGet( "headshots" );
			attacker maps\mp\gametypes\_persistence::statSet( "headshots", hs+1 );

			//attacker blade\_drop::jewelDrop(3);

			break;
		case "MOD_MELEE":
			attacker.pers["knifes"]++;
			attacker braxi\_rank::giveRankXP( "melee" );
			knife = attacker maps\mp\gametypes\_persistence::statGet( "MELEE_KILLS" );
			attacker maps\mp\gametypes\_persistence::statSet( "MELEE_KILLS", knife+1 );

			//attacker blade\_credits::claimReward(5);

			break;
		default:
			pistol = attacker maps\mp\gametypes\_persistence::statGet( "PISTOL_KILLS" );
			attacker maps\mp\gametypes\_persistence::statSet( "PISTOL_KILLS", pistol+1 );
			attacker braxi\_rank::giveRankXP( "kill" );

			//attacker blade\_credits::claimReward(2);

			break;
	}
}


unlockSpray()
{
	for( i = 0; i < level.sprayInfo.size /*level.numSprays+1*/; i++ )
	{
		if( self.pers["rank"] == level.sprayInfo[i]["rank"] )
		{
			notifyData = spawnStruct();
			notifyData.title = "New Spray!";
			notifyData.description = level.sprayInfo[i]["name"];
			notifyData.icon = level.sprayInfo[i]["shader"];
			notifyData.duration = 2.9;
			self thread unlockMessage( notifyData );
			break;
		}
	}

}

unlockCharacter()
{
	for( i = 0; i < level.characterInfo.size /*level.numCharacters+1*/; i++ )
	{
		if( self.pers["rank"] == level.characterInfo[i]["rank"]  )
		{
			notifyData = spawnStruct();
			notifyData.title = "New Character!";
			notifyData.description = level.characterInfo[i]["name"];
			notifyData.icon = level.characterInfo[i]["shader"];
			notifyData.duration = 2.9;
			self thread unlockMessage( notifyData );
			break;
		}
	}

}

unlockItem()
{
	for( i = 0; i < level.itemInfo.size /*level.numItems+1*/; i++ )
	{
		if( self.pers["rank"] == level.itemInfo[i]["rank"] )
		{
		notifyData = spawnStruct();
		notifyData.title = "New Weapon!";
		notifyData.description = level.itemInfo[i]["name"];
		notifyData.icon = level.itemInfo[i]["shader"];
		notifyData.duration = 2.9;
		self thread unlockMessage( notifyData );
			break;
		}
	}
}



isCharacterUnlocked(num,type)
{
	if( num >= level.characterInfo.size || num <= -1 || !isdefined(type))
		return false;

	if(type == "rank" && self.pers["rank"] >= level.characterInfo[num]["rank"])
		return true;

	if(type == "prestige" && self.pers["prestige"] >= level.characterInfo[num]["prestige"])
		return true;

	if(type == "stat" && self getstat( level.characterInfo[num]["cl_stat"] ) == 1)
		return true;

	return false;
}

isItemUnlocked(num,type)
{
	if( num > level.numItems || num <= -1 || !isdefined(type))
		return false;

	if(type == "rank" && self.pers["rank"] >= level.itemInfo[num]["rank"])
		return true;

	if(type == "prestige" && self.pers["prestige"] >= level.itemInfo[num]["prestige"])
		return true;

	if(type == "stat" &&  self getStat( level.iteminfo[num]["cl_stat"] ) == 1)
		return true;

	return false;
}

isItem2Unlocked(num,type)
{
	if( num > level.numItems2 || num <= -1 || !isdefined(type))
		return false;

	if(type == "rank" && self.pers["rank"] >= level.item2Info[num]["rank"])
		return true;

	if(type == "prestige" && self.pers["prestige"] >= level.item2Info[num]["prestige"])
		return true;

	if(type == "stat" && self getStat( level.item2info[num]["cl_stat"] ) == 1)
		return true;

	return false;
}


isSprayUnlocked(num,type)
{
	if( num >= level.numSprays || num <= -1 || !isdefined(type))
		return false;

	if( self.pers["rank"] >= level.sprayInfo[num]["rank"] )
		return true;

	if(type == "rank" && self.pers["rank"] >= level.sprayInfo[num]["rank"])
		return true;

	if(type == "prestige" && self.pers["prestige"] >= level.sprayInfo[num]["prestige"])
		return true;

	if(type == "stat" && self getstat( level.sprayInfo[num]["cl_stat"] ) == 1)
		return true;

	return false;
}

isTrailUnlocked(num,type)
{
	if( num >= level.numTrails || num <= -1 || !isdefined(type))
		return false;

	if( self.pers["prestige"] >= level.trailInfo[num]["prestige"] )
		return true;

	if(type == "rank" && self.pers["rank"] >= level.trailInfo[num]["rank"])
		return true;

	if(type == "prestige" && self.pers["prestige"] >= level.trailInfo[num]["prestige"])
		return true;

	if(type == "stat" && self getstat( level.trailInfo[num]["cl_stat"] ) == 1)
		return true;

	return false;
}

destroyUnlockMessage()
{
	if( !isDefined( self.unlockMessage ) )
		return;

	for( i = 0; i < self.unlockMessage.size; i++ )
		self.unlockMessage[i] destroy();

	self.unlockMessage = undefined;
	self.doingUnlockMessage = false;
}


initUnlockMessage()
{
	self.doingUnlockMessage = false;
	self.unlockMessageQueue = [];
}

unlockMessage( notifyData )
{
	self endon ( "death" );
	self endon ( "disconnect" );
	
	if ( !self.doingUnlockMessage )
	{
		self thread showUnlockMessage( notifyData );
		return;
	}
	
	self.unlockMessageQueue[ self.unlockMessageQueue.size ] = notifyData;
}




showUnlockMessage( notifyData )
{
	self endon("disconnect");

	self playLocalSound( "mp_ingame_summary" );

	self.doingUnlockMessage = true;
	self.unlockMessage = [];

	self.unlockMessage[0] = newClientHudElem( self );
	self.unlockMessage[0].x = -180;
	self.unlockMessage[0].y = 20;
	self.unlockMessage[0].alpha = 0.76;
	self.unlockMessage[0] setShader( "black", 195, 48 );
	self.unlockMessage[0].sort = 990;

	self.unlockMessage[1] = braxi\_mod::addTextHud( self, -190, 20, 1, "left", "top", 1.5 ); 
	self.unlockMessage[1] setShader( notifyData.icon, 55, 48 );
	self.unlockMessage[1].sort = 992;

	self.unlockMessage[2] = braxi\_mod::addTextHud( self, -130, 23, 1, "left", "top", 1.4 ); 
	self.unlockMessage[2].font = "objective";
	self.unlockMessage[2] setText( notifyData.title );
	self.unlockMessage[2].sort = 993;

	self.unlockMessage[3] = braxi\_mod::addTextHud( self, -130, 40, 1, "left", "top", 1.4 ); 
	self.unlockMessage[3] setText( notifyData.description );
	self.unlockMessage[3].sort = 993;

	for( i = 0; i < self.unlockMessage.size; i++ )
	{
		self.unlockMessage[i].horzAlign = "fullscreen";
		self.unlockMessage[i].vertAlign = "fullscreen";
		self.unlockMessage[i].hideWhenInMenu = true;

		self.unlockMessage[i] moveOverTime( notifyData.duration/4 );

		if( i == 1 )
			self.unlockMessage[i].x = 11.5;
		else if( i >= 2 )
			self.unlockMessage[i].x = 71;
		else
			self.unlockMessage[i].x = 10;
	}

	wait notifyData.duration *0.8;

	for( i = 0; i < self.unlockMessage.size; i++ )
	{
		self.unlockMessage[i] fadeOverTime( notifyData.duration*0.2 );
		self.unlockMessage[i].alpha = 0;
	}

	wait notifyData.duration*0.2;

	self destroyUnlockMessage();
	self notify( "unlockMessageDone" );

	if( self.unlockMessageQueue.size > 0 )
	{
		nextUnlockMessageData = self.unlockMessageQueue[0];
		
		newQueue = [];
		for( i = 1; i < self.unlockMessageQueue.size; i++ )
			self.unlockMessageQueue[i-1] = self.unlockMessageQueue[i];
		self.unlockMessageQueue[i-1] = undefined;
		
		self thread showUnlockMessage( nextUnlockMessageData );
	}
}

// Prestige System v2 by Blade
prestigeSystem()
{
	if(!isdefined(self.pers["rank"])||!isdefined(self.pers["rankxp"])||!isdefined(self.pers["prestige"]))
		return;

	if(self.pers["prestige"]>=level.maxprestige||self.pers["rankxp"]<getrankinfomaxxp(level.maxrank))
	{
		self iprintlnbold("^5Prestige Mode^7 is unavailable!");
		return;
	}

	self.pers["rankxp"]=1;
	self.pers["rank"]=0;
	self.pers["prestige"]++;
	self setrank(0,self.pers["prestige"]);
	self maps\mp\gametypes\_persistence::statset("rankxp",1);
	updaterankstats(self,0);

	thread braxi\_slider::messageSlider(self.name+" has entered Prestige "+self.pers["prestige"]+" of "+level.maxprestige);

	for( stat = 979; stat < 986; stat++ ) // spray, character, weapon & ability
		self setStat( stat, 0 );

	self setStat(2554,0); //killcard
	self setStat(2555,0); //emblem

	//self blade\_credits::claimReward(100);
}