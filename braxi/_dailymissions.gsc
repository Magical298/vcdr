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
*/

init()
{
	level endon("game over");
	self endon("death");
	self endon("disconnect");

	buildDailyChallenges();

	if(!isdefined(game["dailych"]))
		game["dailych"] = 0;

	path = "cloud/dailyChallenges.txt";
	if(FS_TestFile(path))
	{
		info = blade\_common::cloud_read(path);
		game["dailych"] = int(info[0]);
	}

	wait .5;

	players = getentarray("player","classname");
	for(i=0;i<players.size;i++)
	{
		if(players[i] getstat(2499) != game["dailych"])
		{
			players[i] setstat(2499,game["dailych"]);
			players[i] resetChallenges();
		}
		wait .5;

		players[i] setclientdvar("uiDRChallenge",game["dailych"]);
		players[i] thread loadDailyChallenges();
	}
}

buildDailyChallenges()
{
	level.dchInfo = [];
	
	tableName = "mp/dchallengeTable.csv";

	for( idx = 1; isdefined( tableLookup( tableName, 0, idx, 0 ) ) && tableLookup( tableName, 0, idx, 0 ) != ""; idx++ )
	{
		refString = tableLookup( tableName, 0, idx, 6 );

		level.dchInfo[refString]["state"] = int(tableLookup( tableName, 0, idx, 1 ));
		level.dchInfo[refString]["required"] = int(tableLookup( tableName, 0, idx, 2 ));
		level.dchInfo[refString]["stat"] = int(tableLookup( tableName, 0, idx, 3 ));
		level.dchInfo[refString]["name"] = tableLookupIString(tableName, 0, idx, 4 );
		level.dchInfo[refString]["desc"] = tableLookupIString(tableName, 0, idx, 5 );
		level.dchInfo[refString]["reward"] =  tableLookup( tableName, 0, idx, 7 );
	}
}

loadDailyChallenges()
{
	level waittill("round_started");

	if(isDefined(level.freeRun) && level.freeRun)
		return;

	if(game["dailych"] == 0)
	{
		self thread countShots();
		self thread countDistance();
	}
	else if(game["dailych"] == 1)
	{
		self thread countRounds();
		self thread countStance();
	}
	else if(game["dailych"] == 2)
		self thread countJumps();
}

  /////////////////
 ////STAT RESET///
/////////////////

resetchallenges()
{
	for(i=528;i<543;i++)
		self setstat(i,0);
	
	for(i=2528;i<2543;i++)
		self setstat(i,0);
}

mayProcessChallenges()
{
	return true;
}

process_dailychallenge( baseName, progressInc )
{
	if ( !mayProcessChallenges() )
		return;

	if ( !isDefined( progressInc ) )
		progressInc = 1;

	refString = baseName;

	progress = self getStat( level.dchInfo[refString]["stat"] );
	progress += progressInc;
	
	self setStat( level.dchInfo[refString]["stat"], progress );

	if( progress >= level.dchInfo[refString]["required"] )
	{
		// prevent bars from running over
		self setStat( level.dchInfo[refString]["stat"], level.dchInfo[refString]["required"] );

		if(self getstat(level.dchInfo[refString]["state"]) != 1)
		{
			self setStat( level.dchInfo[refString]["state"], 1 );
			self braxi\_missions::process_challenge( "ch_daily" );

			if(refString == "dch_blade" || refString == "dch_fox" || refString == "dch_mort")
				self braxi\_missions::process_challenge( "ch_vistic" );

			self thread braxi\_missions::challengeNotify( level.dchInfo[refString]["name"]/*, level.challengeInfo[refString]["desc"]*/ );

			tokens = strtok(level.dchInfo[refString]["reward"]," ");
			if(tokens[1] == "XP")
				self braxi\_rank::giveRankXP( undefined, int(tokens[0]) );
			else if(tokens[1] == "Shards")
				self blade\_common::vc_coins(int(tokens[0]));
			else if(tokens[1] == "Rubys")
				self blade\_common::vc_rubys(int(tokens[0])); 
		}
	}
}

  //////////////////
 ////CHALLANGES////
//////////////////

countShots()
{
	self endon("disconnect");
	self endon("death");

	shots = 0;

	while(isdefined(self) && self.sessionstate == "playing")
	{
		self waittill("weapon_fired");
		shots++;

		self process_dailychallenge("dch_shots");
	}
}

countDistance()
{
	self endon( "disconnect" );
	self endon( "death" );

	oldpos = [];
	oldpos[0] = self.origin;
	bla = false;

	while(isalive(self) && self.pers["team"] == "allies")
	{
		wait 1;

		for(i=0;i<oldpos.size;i++)
		{
			if( Distance( self.origin, oldpos[i] ) < 50 )
			{
				bla = true;
			}
		}

		if( bla || !self isOnGround() )
		{
			bla = false;
			continue;
		}
		oldpos[oldpos.size] = self.origin;
		self process_dailychallenge("dch_travel",50);
	}
}

countDeaths()
{
	self endon("disconnect");

	death = self.pers["deaths"];
	while(isdefined(self))
	{
		if(death != self.pers["deaths"])
		{
			death = self.pers["deaths"]-death;
			self process_dailychallenge("dch_dead");
			wait .1;
			death = self.pers["deaths"];
		}
		wait 1;
	}
}

countRounds()
{
	self endon("disconnect");
	self endon("death");

	level waittill("round_ended");

	if(isdefined(self) && self.sessionstate == "playing")
		self process_dailychallenge("dch_drawer");
}

countStance()
{
	self endon("disconnect");
	self endon("death");

	stance = "stand";

	while(isdefined(self) && self.sessionstate == "playing")
	{
		if(self getstance() != stance)
		{
			stance = self getstance();
			self process_dailychallenge("dch_standin");
		}
		wait 1;
	}
}

countJumps()
{
	self endon("disconnect");
	self endon("death");

	jumped = false;
	while(isdefined(self) && self.sessionstate == "playing")
	{
		if(!self isonground() && jumped == false)
		{
			jumped = true;
			self process_dailychallenge("dch_bunny");
		}
		else if(self isonground() && jumped == true)
			jumped = false;

		wait 0.01;
	}
}

vcMemberChallenge(type,weap)
{
	if(type == "pistol")
	{
		switch(weap)
		{
			case "beretta_mp":
			case "usp_mp":
			case "deserteagle_mp": 
			case "colt44_mp":
				self process_dailychallenge("dch_blade");
				break;
		}
	}
	else if(type == "sniper")
	{
		switch(weap)
		{
			case "m40a3_mp":
			case "remington700_mp":
			case "dragunov_acog_mp":
			case "barrett_acog_mp":
				self process_dailychallenge("dch_fox");
				break;
		}
	}
	else if(type == "knife")
	{
		switch(weap)
		{
			case "g36c_gl_mp":
			case "knife_mp":
			case "tomahawk_mp":
				self process_dailychallenge("dch_mort");
				break;
		}
	}
}