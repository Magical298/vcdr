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

*/

#include braxi\_common;
#include blade\_strings;

init()
{
	game["menu_team"] = "team_select";
	game["menu_characters"] = "character_stuff";
	game["menu_quickstuff"] = "quickstuff";
	game["menu_mapvote"] = "dr_mapvote";

	precacheMenu("scoreboard");
	precacheMenu(game["menu_team"]);
	precacheMenu(game["menu_characters"]);
	precacheMenu(game["menu_quickstuff"]);
	precacheMenu(game["menu_mapvote"]);

	precacheMenu( "dr_help" );
	precacheMenu( "dr_graphics" );
	precacheMenu( "dr_characters" );
	precacheMenu( "dr_sprays" );
	precacheMenu( "dr_abilitys" );
	precacheMenu( "dr_weapons" );
	precacheMenu( "dr_trails" );
	precacheMenu( "dr_records" );

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

		if(response=="back")
		{
			self closemenu();
			self closeingamemenu();
			continue;
		}	
		
		// client side commands
		if(response=="2doff")
			self setClientDvar("cg_draw2d",0);

		if(response=="2don")
			self setClientDvar("cg_draw2d",1);

		if(menu=="dr_sprays")
		{
			self closeMenu();
			self closeInGameMenu();

			spray=int(response)-1;
			if(self braxi\_rank::issprayunlocked(spray))
			{
				self iprintlnbold("Your^5 Spray^7 changed to ^5"+level.sprayInfo[spray]["name"]);
				self setstat(979,spray);
			}
		}
		if( response == "dr_characters")
		{
			if( self.pers["team"] != "spectator" )
			{
				self closeMenu();
				self closeInGameMenu();
				self iPrintlnBold( "You've to be ^5Spectator^7 to change your ^5Character" );
				continue;
			}
			self openmenu("dr_characters");

			self allowSpectateTeam( "allies", false );
			self allowSpectateTeam( "axis", false );
			self allowSpectateTeam( "none", true );
		}	

		if( response == "dr_weapons")
		{
			if( self.pers["team"] != "spectator" )
			{
				self closeMenu();
				self closeInGameMenu();
				self iPrintlnBold( "You've to be ^5Spectator^7 to change your ^5Weapon" );
				continue;
			}
			self openmenu("dr_weapons");

			self allowSpectateTeam( "allies", false );
			self allowSpectateTeam( "axis", false );
			self allowSpectateTeam( "none", true );
		}

		if(response == "dr_stats")
		{
			self closeMenu();
			self closeInGameMenu();

			self setclientdvars("vc_time1p",level.playerTimes[4]["name"],
								"vc_time1t",braxi\_mod::realtime(level.playerTimes[4]["time"]),
								"vc_time2p",level.playerTimes[3]["name"],
								"vc_time2t",braxi\_mod::realtime(level.playerTimes[3]["time"]),
								"vc_time3p",level.playerTimes[2]["name"],
								"vc_time3t",braxi\_mod::realtime(level.playerTimes[2]["time"]),
								"vc_time4p",level.playerTimes[1]["name"],
								"vc_time4t",braxi\_mod::realtime(level.playerTimes[1]["time"]),
								"vc_time5p",level.playerTimes[0]["name"],
								"vc_time5t",braxi\_mod::realtime(level.playerTimes[0]["time"]));

			self openmenu("dr_records");
		}

		if(menu=="dr_characters")
			self blade\_character::OnResponse( response );

		if(menu=="dr_weapons")
			self blade\_weapon::OnResponse( response );
			
		else if(menu=="dr_abilitys")
		{
			self closeMenu();
			self closeInGameMenu();

			ability=int(response)-1;
			if(self braxi\_rank::isabilityunlocked(ability))
			{
				self iprintlnbold("Your ^5Ability ^7changed to ^5"+level.abilityInfo[ability]["name"]);
				self setstat(982,ability);
			}
		}
		else if(menu=="dr_trails")
		{
			self closeMenu();
			self closeInGameMenu();

			trail=int(response)-1;
			if(self braxi\_rank::istrailunlocked(trail))
			{
				self iprintlnbold("Your ^5Trail ^7changed to ^5"+level.trailInfo[trail]["name"]);
				self setstat(984,trail);
			}
		}	
		
		else if( menu == "dr_graphics" )
		{
			self thread plugins\_clients::graphics(response);
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
						self iPrintln( "^5Admin^7: ^5Activator^7 cant suicide" );
					break;

				case "nprestige":
					if( !game["roundStarted"] )
						continue;
					self thread braxi\_rank::prestigeSystem();
					break;

				case "self_reset":
					if( !game["roundStarted"] )
						continue;
					if(self.pers["prestige"]>=level.maxprestige)
						self thread braxi\_admin::p_reset();
					else
						self iprintlnbold("You cant ^5reset^7 Yourself yet");
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
						self iPrintln("^5Admin^7: ^5You ^7cant switch your Team as ^5Activator");
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
						self iPrintln("^5Admin^7: ^5You ^7cant switch your Team as ^5Activator");
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
				case "soundpacks":
					if(self getstat(2001)==0)
					{
						self setclientdvar("dr_snd_delay",blade\_strings::getSoundString("hs"));
						self setstat(2001,1);
					}
					else if(self getstat(2001)==1)
					{
						self setclientdvar("dr_snd_delay",blade\_strings::getSoundString("tr"));
						self setstat(2001,2);
					}
					else if(self getstat(2001)==2)
					{
						self setclientdvar("dr_snd_delay",blade\_strings::getSoundString("db"));
						self setstat(2001,3);
					}
					else if(self getstat(2001)==3)
					{
						self setclientdvar("dr_snd_delay",blade\_strings::getSoundString("de"));
						self setstat(2001,0);
					}
					break;
				case "vip_menu":
					self closemenu();
					self closeingamemenu();

					if(self.pers["vip"])
						self openmenu("vip");
					else 
						self iprintlnbold("Unlock this ^5Feature^7 by ^5Donating^7!");
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