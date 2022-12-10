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
#include braxi\_common;

init()
{
	precachemenu("menu_challenges");
	precachemenu("menu_challenges2");

	if ( !mayProcessChallenges() )
		return;

	level.ch_unstoppable = 0;

	braxi\_rank::registerScoreInfo( "challenge", 250 );

	buildChallegeInfo();

	thread playerSpawned();
	thread onEndRound();
}

mayProcessChallenges()
{
	return true;
}

test()
{
	while( self.sessionstate == "playing" )
	{
		if(self usebuttonpressed())
			self process_challenge( "ch_zombie" );

		if(self fragbuttonpressed())
		{
			self setstat(level.challengeInfo["ch_zombie"]["state"],0);
			self setstat(level.challengeInfo["ch_zombie"]["stat"],0);
		}

		if(self secondaryoffhandbuttonpressed())
			self iprintlnbold("ch_zombie: "+level.challengeInfo["ch_zombie"]["state"]+" State: "+self getstat(level.challengeInfo["ch_zombie"]["state"]));

		wait 1;
	}
}

playerSpawned()
{
	while( 1 )
	{
		level waittill( "player_spawn", player );
		player.challengeAnnouncer = false;
		player thread ch_spray();
		//player thread test();
	}
}

onEndRound()
{
	level waittill( "round_ended", reasonText, winningTeam );

	players = getAllPlayers();
	for( i = 0; i < players.size; i++ )
	{
		if( !players[i] isReallyAlive() )
			continue;

		if(!level.freerun)
			players[i] process_challenge( "ch_survivor" ); // Survive 250 Rounds
	}

	if( !level.jumpers && level.activators )
	{
		if(isDefined( level.activ ) && level.activ isReallyAlive())
			level.activ process_challenge( "ch_real" ); // Kill all Jumpers and win 20 Rounds
	}
}

ch_spray()
{
	self endon( "disconnect" );
	self endon( "death" );

	wait 0.2;
	while( self.sessionstate == "playing" )
	{
		self waittill( "spray", sprayNum, sprayPos );

		ents = getEntArray( "dr_deadbody", "targetname" );
		for( i = 0; i < ents.size; i++ )
		{
			if( distance( ents[i].origin, sprayPos ) < 64 )
			{
				self process_challenge( "ch_artist" ); // Spray your Logo to the Acti 3 times
				break;
			}
		}
	}
}

buildChallegeInfo()
{
	level.challengeInfo = [];
	
	tableName = "mp/challengeTable.csv";

	for( idx = 1; isdefined( tableLookup( tableName, 0, idx, 0 ) ) && tableLookup( tableName, 0, idx, 0 ) != ""; idx++ )
	{
		refString = tableLookup( tableName, 0, idx, 6 );

		level.challengeInfo[refString]["state"] = int(tableLookup( tableName, 0, idx, 1 ));
		level.challengeInfo[refString]["required"] = int(tableLookup( tableName, 0, idx, 2 ));
		level.challengeInfo[refString]["stat"] = int(tableLookup( tableName, 0, idx, 3 ));
		level.challengeInfo[refString]["name"] = tableLookupIString(tableName, 0, idx, 4 );
		level.challengeInfo[refString]["desc"] = tableLookupIString(tableName, 0, idx, 5 );
		level.challengeInfo[refString]["reward"] =  tableLookup( tableName, 0, idx, 7 );

		//5,505,250,2505,DRCHALLENGE_SENSE,DRCHALLENGE_SENSE_DESC,ch_sense,
		//0, 1, 2,  3,   4,                 5,                    6,        7,
	}
}

process_challenge( baseName, progressInc )
{
	if ( !mayProcessChallenges() )
		return;

	if ( !isDefined( progressInc ) )
		progressInc = 1;

	refString = baseName;
	//iprintlnbold(refstring);

	progress = self getStat( level.challengeInfo[refString]["stat"] );
	progress += progressInc;
	
	self setStat( level.challengeInfo[refString]["stat"], progress );

	if( progress >= level.challengeInfo[refString]["required"] )
	{
		// prevent bars from running over
		self setStat( level.challengeInfo[refString]["stat"], level.challengeInfo[refString]["required"] );

		if(self getstat(level.challengeInfo[refString]["state"]) != 1)
		{
			self setStat( level.challengeInfo[refString]["state"], 1 );

			self thread challengeNotify( level.challengeInfo[refString]["name"]/*, level.challengeInfo[refString]["desc"]*/ );

			if(find_nonxp(level.challengeInfo[refString]["reward"]))
				self iprintlnbold("Unlocked: "+level.challengeInfo[refString]["reward"]);
			else 
				self braxi\_rank::giveRankXP( undefined, find_xp(level.challengeInfo[refString]["reward"]) );

			/*if(level.challengeInfo[refString]["reward"] != "")
				self braxi\_rank::giveRankXP( "challenge", int(level.challengeInfo[refString]["reward"]) );
			else 
				self iprintlnbold("Unlocked: "+level.challengeInfo[refString]["reward"]);*/
		}
	}
}

find_nonxp(string)
{
	switch(string)
	{
		case "Depression":
		case "Golden Knife":
		case "Steady Aim":
		case "Smoke":
		case "Hexagon":
		case "Ninja Fox":
		case "Fast Reload":
		case "Golden Tomahawk":
		case "XanaX":
			return true;
		default:
			return false;
	}
	return false;
}

find_xp(string)
{
	tokens = strtok(string," ");
	if(isdefined(tokens[0]))
		return int(tokens[0]);

	return false;
}

challengeNotify( challengeName/*, challengeDesc */)
{
	while(isdefined(self.challengeAnnouncer) && self.challengeAnnouncer)
		wait 0.05;

	self.challengeAnnouncer = true;

	if(isdefined(self.challengeHeader))
		self.challengeHeader destroy();

	self.challengeHeader = createhud(self,330,50,"center","top");
	self.challengeHeader.archived = 0;
	self.challengeHeader.alpha = 0;
	self.challengeHeader.hidewheninmenu = true;
	self.challengeHeader setshader("white",140,20);
	self.challengeHeader.color = (0,0.84,1);

	if(isdefined(self.challengeHeaderTx))
		self.challengeHeaderTx destroy();

	self.challengeHeaderTx = createhud(self,330,50,"center","top","default",1.6,undefined,undefined);
	self.challengeHeaderTx.sort = 1;
	self.challengeHeaderTx.alpha = 0;
	self.challengeHeaderTx.archived = 0;
	self.challengeHeaderTx.hidewheninmenu = true;
	self.challengeHeaderTx setText("Challenge completed");

	if(isdefined(self.challengeHeaderTx2))
		self.challengeHeaderTx2 destroy();

	self.challengeHeaderTx2 = createhud(self,330,70,"center","top","default",1.4,undefined,undefined);
	self.challengeHeaderTx2.archived = 0;
	self.challengeHeaderTx2.alpha = 0;
	self.challengeHeaderTx2.hidewheninmenu = true;
	self.challengeHeaderTx2 setText(challengeName);

	if(isdefined(self.challengeHeader) && isdefined(self.challengeHeaderTx) && isdefined(self.challengeHeaderTx2))
	{
		self playlocalsound("chcompl");
		
		self.challengeHeader fadeovertime(0.75);
		self.challengeHeaderTx fadeovertime(0.75);
		self.challengeHeaderTx2 fadeovertime(0.75);

		self.challengeHeader.alpha = 0.6;
		self.challengeHeaderTx.alpha = 1;
		self.challengeHeaderTx2.alpha = 1;

		wait 3.5;

		self.challengeHeader fadeovertime(0.75);
		self.challengeHeaderTx fadeovertime(0.75);
		self.challengeHeaderTx2 fadeovertime(0.75);

		self.challengeHeader.alpha = 0;
		self.challengeHeaderTx.alpha = 0;
		self.challengeHeaderTx2.alpha = 0;

		self.challengeHeader destroy();
		self.challengeHeaderTx destroy();
		self.challengeHeaderTx2 destroy();
	}
	self.challengeAnnouncer = false;

	/*notifyData = spawnStruct();
	notifyData.titleText = "Challenge Completed!";
	notifyData.notifyText = challengeName;
	//notifyData.notifyText2 = challengeDesc;
	notifyData.sound = "mp_challenge_complete";
	notifyData.duration = 5.0;
	
	self maps\mp\gametypes\_hud_message::notifyMessage( notifyData );*/
}

find_weapon_challenge(weap)
{
	switch( weap )
	{
		case "beretta_mp":
		case "usp_mp":
		case "deserteagle_mp":
		case "dragunov_acog_mp":
		case "g36c_silencer_mp":
		case "barrett_acog_mp":
		case "m1014_mp":
		case "winchester1200_mp":
		case "deserteaglegold_mp":
		case "m40a3_acog_mp":
		case "uzi_mp":
		case "m40a3_mp":
		case "remington700_mp":
		case "remington700_acog_mp":
		case "odin_mp":
		case "colt45_silencer_mp":
			self process_challenge( "ch_soldier" ); // Kill 600 Enemies with your Primary
			break;

		case "colt45_mp":
			self process_challenge( "ch_soldier" ); // Kill 600 Enemies with your Primary
			self process_challenge( "ch_m1911" );
			break;

		case "colt44_mp":
			self process_challenge( "ch_soldier" ); // Kill 600 Enemies with your Primary
			self process_challenge( "ch_colt" );
			break;
						
		case "g36c_gl_mp":
		case "knife_mp":
		case "m4_gl_mp":
		case "m4_acog_mp":
		case "ak47_acog_mp":
		case "g36c_acog_mp":
		case "g3_acog_mp":
		case "g3_gl_mp":
		case "g3_reflex_mp":
		case "m14_gl_mp":
		case "m14_silencer_mp":
		case "m14_acog_mp":
		case "ak74u_silencer":
		case "g36c_reflex_mp":
		case "ak47_reflex_mp":
			self process_challenge( "ch_chef" ); // Kill 500 Enemies with your Secondary
			break;

		case "tomahawk_mp":
			self process_challenge( "ch_chef" ); // Kill 500 Enemies with your Secondary
			if(self.pers["team"] == "axis")
				self process_challenge( "ch_axe" ); // Kill 100 Jumpers with your Tomahawk
			break;

		case "ak47_gl_mp":
				self process_challenge( "ch_chef" ); // Kill 500 Enemies with your Secondary
				self process_challenge( "ch_katana" );
			break;				
	}
}


// 
dchTimer()
{
	while(isdefined(self.pers["dch_timer"]))
	{
		self setclientdvar("dchTimer",level.dchTimer);
		wait 1;
	}
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