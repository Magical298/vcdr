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
#include braxi\_common;

init()
{
	game["menu_team"] = "team_select";
	game["menu_callvote"] = "callvote";
	game["menu_muteplayer"] = "muteplayer";
	game["menu_quickstuff"] = "quickmessage";
	game["menu_droptions"] = "dr_options";
	game["menu_mapvote"] = "dr_mapvote";

	precacheMenu(game["menu_callvote"]);
	precacheMenu(game["menu_muteplayer"]);
	precacheMenu("scoreboard");
	precacheMenu(game["menu_team"]);
	precacheMenu(game["menu_quickstuff"]);
	precacheMenu( game["menu_droptions"] );
	precacheMenu(game["menu_mapvote"]);

	precacheMenu( "dr_characters" );
	precacheMenu( "dr_sprays" );
	precacheMenu( "dr_weapons" );
	precacheMenu( "dr_weapons2" );
	precacheMenu( "dr_trails");
	precacheMenu("vip");

	precacheString( &"MP_HOST_ENDED_GAME" );
	precacheString( &"MP_HOST_ENDGAME_RESPONSE" );

	level thread onPlayerConnect();
}

onPlayerConnect()
{
	for(;;)
	{
		level waittill("connecting", player);
		
		player setClientDvar("ui_3dwaypointtext", "1");
		player.enable3DWaypoints = true;
		player setClientDvar("ui_deathicontext", "1");
		player.enableDeathIcons = true;
		player.classType = undefined;
		player.selectedClass = false;
		
		player thread onMenuResponse();
	}
}

onMenuResponse()
{
	self endon("disconnect");

	for(;;)
	{
		self waittill("menuresponse", menu, response);

		if( response == "dog" )
		{
			if( !self.pers["isDog"] )
				self.pers["isDog"] = true;
			else
				self.pers["isDog"] = false;
		}

		// client side commands
		if( response == "2doff" )
			self setClientDvar( "cg_draw2d", 0 );

		if( response == "2don" )
			self setClientDvar( "cg_draw2d", 1 );

		if ( response == "back" )
		{
			self closeMenu();
			self closeInGameMenu();
			continue;
		}

		if( response == "load_dch" )
		{
			if(!isdefined(self.pers["dch_timer"]))
				self.pers["dch_timer"] = true;

			self thread braxi\_missions::dchTimer();
		}

		if( response == "close_dch" )
			self.pers["dch_timer"] = undefined;
		
		if( menu == "dr_weapons")
		{
			primary = int(response)-1;
			switch(primary)
			{
				case 0:
				case 1:
				case 2:
				case 3:
				case 4:
				case 5:
				case 6:
					if(self braxi\_rank::isItemUnlocked(primary,"rank"))
					{
						/*self closemenu();
						self closeingamemenu();*/

						self setStat( 981, primary );
						self iprintlnbold("Your ^5Weapon^7 will change next ^5Spawn^7!");
						// playlocalsound("success");
					}
					break;
				case 7:
				case 8:
				case 9:
				case 10:
				case 11:
				case 12:
					if(self braxi\_rank::isItemUnlocked(primary,"prestige"))
					{
						/*self closemenu();
						self closeingamemenu();*/

						self setStat( 981, primary );
						self iprintlnbold("Your ^5Weapon^7 will change next ^5Spawn^7!");
						// playlocalsound("success");
					}
					break;
				case 13:
				case 14:
				case 15:
					if(self braxi\_rank::isItemUnlocked(primary,"stat"))
					{
						/*self closemenu();
						self closeingamemenu();*/

						self setStat( 981, primary );
						self iprintlnbold("Your ^5Weapon^7 will change next ^5Spawn^7!");
						// playlocalsound("success");
					}
					break;
			}
		}
		else if( menu == "dr_weapons2")
		{
			secondary = int(response)-1;
			switch(secondary)
			{
				case 0:
				case 1:
				case 2:
				case 3:
				case 4:
				case 5:
				case 6:
					if(self braxi\_rank::isItem2Unlocked(secondary,"rank"))
					{
						/*self closemenu();
						self closeingamemenu();*/

						self setStat( 984, secondary );
						self iprintlnbold("Your ^5Weapon^7 will change next ^5Spawn^7!");
						// playlocalsound("success");
					}
					break;
				case 7:
				case 8:
				case 9:
				case 10:
				case 11:
				case 12:
					if(self braxi\_rank::isItem2Unlocked(secondary,"prestige"))
					{
						/*self closemenu();
						self closeingamemenu();*/

						self setStat( 984, secondary );
						self iprintlnbold("Your ^5Weapon^7 will change next ^5Spawn^7!");
						// playlocalsound("success");
					}
					break;
				case 13:
				case 14:
				case 15:
					if(self braxi\_rank::isItem2Unlocked(secondary,"stat"))
					{
						/*self closemenu();
						self closeingamemenu();*/

						self setStat( 984, secondary );
						self iprintlnbold("Your ^5Weapon^7 will change next ^5Spawn^7!");
						// playlocalsound("success");
					}
					break;
			}
		}
		else if(menu == "dr_characters")
		{
			model = int(response)-1;
			switch(model)
			{
				case 0:
				case 1:
				case 2:
				case 3:
				case 4:
				case 5:
				case 6:
					if(self braxi\_rank::isCharacterUnlocked(model,"rank"))
					{
						/*self closemenu();
						self closeingamemenu();*/

						self setStat( 980, model );
						self iprintlnbold("Your ^5Model^7 will change next ^5Spawn^7!");
						// playlocalsound("success");
					}
					break;
				case 7:
				case 8:
				case 9:
				case 10:
				case 11:
				case 12:
					if(self braxi\_rank::isCharacterUnlocked(model,"prestige"))
					{
						/*self closemenu();
						self closeingamemenu();*/

						self setStat( 980, model );
						self iprintlnbold("Your ^5Model^7 will change next ^5Spawn^7!");
						// playlocalsound("success");
					}
					break;
				case 13:
				case 14:
				case 15:
					if(self braxi\_rank::isCharacterUnlocked(model,"stat"))
					{
						/*self closemenu();
						self closeingamemenu();*/

						self setStat( 980, model );
						self iprintlnbold("Your ^5Model^7 will change next ^5Spawn^7!");
						// playlocalsound("success");
					}
					break;
			}
		}
		else if(response == "open_challenges")
		{
			if(!isdefined(self.pers["inChallenges"]))
			{
				self.pers["inChallenges"] = true;
				self setclientdvar("vc_challenge",1);
			}
		}
		else if(response == "open_challenges")
		{
			if(!isdefined(self.pers["inChallenges"]))
				self.pers["inChallenges"] = undefined;
		}

		if( menu == "dr_sprays" )
		{
			spray = int(response)-1;
			switch(spray)
			{
				case 0:
				case 1:
				case 2:
				case 3:
				case 4:
				case 5:
				case 6:
					if( self braxi\_rank::isSprayUnlocked(spray,"rank") )
					{
						/*self closemenu();
						self closeingamemenu();*/

						self setStat( 979, spray );
						self iprintlnbold("Your ^5Spray^7 will change next ^5Spawn^7!");
						// playlocalsound("success");
					}
					break;
				case 7:
				case 8:
				case 9:
				case 10:
				case 11:
				case 12:
				case 13:
					if( self braxi\_rank::isSprayUnlocked(spray,"prestige") )
					{
						/*self closemenu();
						self closeingamemenu();*/

						self setStat( 979, spray );
						self iprintlnbold("Your ^5Spray^7 will change next ^5Spawn^7!");
						// playlocalsound("success");
					}
					break;
				case 14:
				case 15:
					if( self braxi\_rank::isSprayUnlocked(spray,"stat") )
					{
						/*self closemenu();
						self closeingamemenu();*/

						self setStat( 979, spray );
						self iprintlnbold("Your ^5Spray^7 will change next ^5Spawn^7!");
						// playlocalsound("success");
					}
					break;
			}
		}
		else if( menu == "dr_trails"  )
		{
			trail = int(response)-1;
			switch(trail)
			{
				case 0:
				case 1:
				case 2:
				case 3:
				case 4:
				case 5:
				case 6:
					if(self braxi\_rank::isTrailUnlocked(trail,"rank"))
					{
						/*self closemenu();
						self closeingamemenu();*/

						self setStat( 986, trail );
						self iprintlnbold("Your ^5Trail^7 will change next ^5Spawn^7!");
						// playlocalsound("success");
					}
					break;
				case 7:
				case 8:
				case 9:
				case 10:
				case 11:
				case 12:
				case 13:
					if(self braxi\_rank::isTrailUnlocked(trail,"prestige"))
					{
						/*self closemenu();
						self closeingamemenu();*/

						self setStat( 986, trail );
						self iprintlnbold("Your ^5Trail^7 will change next ^5Spawn^7!");
						// playlocalsound("success");
					}
					break;
				case 14:
				case 15:
					if(self braxi\_rank::isTrailUnlocked(trail,"stat"))
					{
						/*self closemenu();
						self closeingamemenu();*/

						self setStat( 986, trail );
						self iprintlnbold("Your ^5Trail^7 will change next ^5Spawn^7!");
						// playlocalsound("success");
					}
					break;
			}
		}
		if(response == "vip_menu")
		{
			if(game["state"] == "playing")
			{
				if(self.pers["team"] != "spectator" && self isreallyalive())
				{
					self giveweapon("airstrike_mp");
					self switchtoweapon("airstrike_mp");

					wait 1.5;
					
					self closeMenu();
					self closeInGameMenu();

					self openmenu("vip");
					self setclientdvar("vc_tablet_items",0);
				}
			}
		}
		if(menu == "vip")
		{
			if(response == "vc_tablet_home")
				self setclientdvar("vc_tablet_items",0);
			else if(response == "vc_tablet_vip")
			{
				if(self.pers["vip"])
				{
					self setclientdvar("vc_tablet_items",1);
					self blade\_admin::vip_preset();
				}
			}
			else if(response == "vc_tablet_leaderboard")
			{
				self setclientdvars("vc_tablet_items",2,
									"vc_time1p",level.playerTimes[4]["name"],
									"vc_time1t",blade\_common::convertTimeRecords(int(level.playerTimes[4]["time"])),
									"vc_time2p",level.playerTimes[3]["name"],
									"vc_time2t",blade\_common::convertTimeRecords(int(level.playerTimes[3]["time"])),
									"vc_time3p",level.playerTimes[2]["name"],
									"vc_time3t",blade\_common::convertTimeRecords(int(level.playerTimes[2]["time"])),
									"vc_time4p",level.playerTimes[1]["name"],
									"vc_time4t",blade\_common::convertTimeRecords(int(level.playerTimes[1]["time"])),
									"vc_time5p",level.playerTimes[0]["name"],
									"vc_time5t",blade\_common::convertTimeRecords(int(level.playerTimes[0]["time"])),
									"vc_mvp",getsubstr(level.bestScores[0]["player"], 0, 15));
			}
			else if(response == "vc_tablet_prestige")
			{
				self setclientdvar("vc_tablet_items",3);
			}
			else if(response == "vc_tablet_close")
			{
				wait .4;
				self braxi\_common::clientcmd("weapprev");
			    wait .6;
			    self takeweapon("airstrike_mp");
			}
			else if(issubstr(response,"vip_"))
			{
				if(self.pers["vip"])
					self blade\_admin::vip_response(response);
			}
			else if(response == "prestige_enter")
			{
				if(!game["roundStarted"])
					continue;

				self thread braxi\_rank::prestigeSystem();
			}
			else if(response == "prestige_reset")
			{
				if(!game["roundStarted"])
					continue;

				if(self.pers["rank"] >= level.maxRank || self.pers["prestige"] >= level.maxPrestige)
					self thread braxi\_admin::p_reset();
			}
		}
		else if( menu == "dr_options" )
		{
			self thread plugins\_clients::graphics(response);
		}
		else if( menu == "menu_challenges" || menu == "menu_challenges2" )
		{
			switch(response)
			{
				case "0":
					// Classics
					self setclientdvar("vc_challenge",1);
					break;
				case "1":
					// Vistic
					self setclientdvar("vc_challenge",2);
					break;
				case "2":
					// Jumper
					self setclientdvar("vc_challenge",3);
					break;
				case "3":
					// Activator
					self setclientdvar("vc_challenge",4);
					break;
			}
		}
		else if( menu == game["menu_quickstuff"] )
		{
			switch(response)
			{
				case "suicide":
					if( !game["roundStarted"] )
						continue;
					if( self.pers["team"] == "allies" )
						self suicide();
					else
						self iPrintln( "^5Activator^7 cant suicide" );
					break;

				case "3rdpers":
					if(self getstat(2093) == 1)
						self setStat(2093,0);
					else
						self setStat(2093,1);

					self setClientDvar("cg_thirdPerson",self getstat(2093));
					break;
			}
		}
		else if( menu == game["menu_team"] )
		{
			switch(response)
			{
				case "allies":
				case "axis":
				case "autoassign":
					self closeMenu();
					self closeInGameMenu();
					if(self.pers["team"] == "axis")
					{
						self iPrintln("^5You ^7cant switch your Team as ^5Activator");
						continue;
					}
					self braxi\_teams::setTeam( "allies" );
					if(self.sessionstate == "playing" || game["state"] == "round ended" )
						continue;

					if( self.pers["team"] == "allies" && self.sessionstate != "playing" && self.pers["lifes"] && game["state"] != "readyup")
					{
						self braxi\_mod::useLife();
						continue;
					}
						
					if( self canSpawn() || game["state"] == "readyup")
						self braxi\_mod::spawnPlayer();
					break;

				case "spectator":
					self closeMenu();
					self closeInGameMenu();
					if(self.pers["team"] == "axis")
					{
						self iPrintln("^5You ^7cant switch your Team as ^5Activator");
						continue;
					}
					self braxi\_teams::setTeam( "spectator" );
					self braxi\_mod::spawnSpectator( level.spawn["spectator"].origin, level.spawn["spectator"].angles );
					break;
					
				case "character_menu":
					self closeMenu();
					self closeInGameMenu();
					self openMenu( game["menu_characters"] );
					break;
			}
		}
		else if ( !level.console )
		{
			if(menu == game["menu_quickcommands"])
				maps\mp\gametypes\_quickmessages::quickcommands(response);
			else if(menu == game["menu_quickstatements"])
				maps\mp\gametypes\_quickmessages::quickstatements(response);
			else if(menu == game["menu_quickresponses"])
				maps\mp\gametypes\_quickmessages::quickresponses(response);
		}

	}
}


cheakalive()
{
	if(!self isreallyalive() || isdefined(self.ghost) && self.ghost)
	{
		self closemenu();
		self closeingamemenu();
		self iPrintlnBold( "You've to be ^5Alive^7 to preview your ^5Character^7/^5Weapon" );
		return true;
	}
	else
		return false;
}