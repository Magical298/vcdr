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
#include blade\_strings;

main()
{
	makeDvarServerInfo( "admin", "" );
	makeDvarServerInfo( "adm", "" );
	
	level.fx["bombexplosion"] = loadfx( "explosions/tanker_explosion" );
    
   	thread braxi\_mod::precache();
   	level.canplaysound=true;

	setDvar("byduff", 0);
	setDvar("byduff2", 0);

	while(1)
	{
		wait 0.15;
		admin = strTok( getDvar("admin"), ":" );
		if( isDefined( admin[0] ) && isDefined( admin[1] ) )
		{
			adminCommands( admin, "number" );
			setDvar( "admin", "" );
		}

		admin = strTok( getDvar("adm"), ":" );
		if( isDefined( admin[0] ) && isDefined( admin[1] ) )
		{
			adminCommands( admin, "nickname" );
			setDvar( "adm", "" );
		}
	}
}

adminCommands( admin, pickingType )
{
	if( !isDefined( admin[1] ) )
		return;

	arg0 = admin[0]; // command

	if( pickingType == "number" )
		arg1 = int( admin[1] );	// player
	else
		arg1 = admin[1];

	switch( arg0 )
	{
		case "restoreme":
			player=getPlayer(arg1,pickingType);
			player thread cloud\_cloud::restore();
			player thread cloud\_ch_progress::restore();
			break;

		case "cantplay":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player)&&player isReallyAlive())
			{		
				if(!isDefined(player.pers["cantplay"]))
				{
					player.pers["cantplay"] = true;
					player setClientDvar("cantplay",1);
				}
				else
				{
					player.pers["cantplay"] = undefined;
					player setClientDvar("cantplay",0);
				}
			}
			break;


		case "kill":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player)&&player isReallyAlive())
			{		
				player suicide();
				player iprintlnbold("^1Admin ^7killed you");
				iPrintln("^5Vistic^7 Admin: ^5"+player.name+"^7 killed.");
			}
			break;

		case "spectator":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player)&&player.pers["team"]=="allies")
			{
				player braxi\_teams::setteam("spectator");
				player braxi\_mod::spawnspectator(level.spawn["spectator"].origin,level.spawn["spectator"].angles);
				iprintln("^5Vistic^7 Admin: ^5"+player.name+"^7 was sent to Spectator.");
			}
			break;
	
		case "tphere":
			tphere = getplayer(arg1,pickingType);
			caller = getplayer(int(admin[2]),pickingtype);
			if(isDefined(tphere) && isDefined(caller))
			{
				tphere setorigin(caller.origin);
				tphere setplayerangles(caller.angles);
				iprintln("^5Vistic^7 Admin: ^5"+tphere.name+"^7 was teleported to ^5"+caller.name);
			}
			break;

		case "tpto":
			caller = getplayer(arg1,pickingType);
			tpto = getplayer(int(admin[2]),pickingtype);
			if(isDefined(tpto) && isDefined(caller))
			{
				tpto setorigin(caller.origin);
				tpto setplayerangles(caller.angles);
				iprintln("^5Vistic^7 Admin: ^5"+tpto.name+"^7 was teleported to ^5"+caller.name);
			}
			break;

		case "spawn":
			player=getPlayer(arg1,pickingType);
	 		if(level.spawningTimer)
	 		{
	 			player thread self_spawn();
	 			iprintln("^5Vistic^7 Admin: ^5"+player.name+"^7 has been respawned");
	 		}
	 		else 
	 			iprintln("Spawning is currently disabled");
	 		break;

	

		case "party":
			iprintln("^5Vistic^7 Admin: Party Mode enabled");
			if(level.canplaysound)
			{
				thread partymode();
				level.canplaysound=false;
			}
			break;
		
	    case "play":
			if(!level.freerun)
			{
			    ambientstop(3);
			    musicstop(3);
			    ambientstop(0);
			    musicstop(0);
			    song=int(arg1);
			    switch(song)
			    {
			        case 1:
			            ambientplay("de_endmap");
			            level.playText="Vistic Endmap ("+getSoundString("de")+")";
			            break;
			        case 2:
			            ambientplay("hs_endmap");
			            level.playText="Vistic Endmap ("+getSoundString("hs")+")";
			            break;
			        case 3:
			            ambientplay("tr_endmap");
			            level.playText="Vistic Endmap ("+getSoundString("tr")+")";
			            break;
			        case 4:
			            ambientplay("db_endmap");
			            level.playText="Vistic Endmap ("+getSoundString("db")+")";
			            break;
			        case 5:
			            ambientplay("ds_endmap");
			            level.playText="Vistic Endmap ("+getSoundString("ds")+")";
			            break;
			    }
			    iprintln("^5Vistic^7 Admin: Now playing: ^5"+level.playText);  
			}
			else 
				iprintln("^5Vistic^7 Admin: Songs are not available in First Round");
			break;

		case "teleport":
			player=getPlayer(arg1,pickingType);
			caller=getplayer(int(admin[2]),pickingtype);
			if(isdefined(player)&&player isReallyAlive()&&isdefined(admin[2]) && admin[2] == "spawn")
			{
				targ=level.spawn[player.pers["team"]][randomint(player.pers["team"].size)].origin;
				player setorigin(targ);
				player iprintlnbold("^5Admin ^7teleported you back to Spawn");
				iprintln("^5Vistic^7 Admin: ^5"+player.name+"^7 was teleported to Spawn.");
			}
			else if(isdefined(player)&&player isreallyalive()&&isdefined(caller)&&caller isreallyalive())
			{
				player setorigin(caller.origin);
				player setplayerangles(caller.angles);
				iprintln("^5Vistic^7 Admin: ^5"+player.name+"^7 was teleported to ^5"+caller.name);
			}
			break;

		case "pickup":
	    	player=getPlayer(arg1,pickingType);
	    	if(isdefined(player))
	    	{
	    		if(!isdefined(player.pers["pickup"]) || !player.pers["pickup"])
	    		{
	    			player.pers["pickup"]=true;
	    			player thread playerpickup();
					player iprintlnbold("^5Admin^7 enabled Pickup for you");
					iprintln("^5Vistic^7 Admin: Enabled Pickup for ^5"+player.name);
	    		}
	    		else 
	    		{
	    			player.pers["pickup"]=false;
					player iprintlnbold("^5Admin^7 disabled Pickup for you");
					iprintln("^5Vistic^7 Admin: Disabled Pickup for ^5"+player.name);
	    		}
	    	}
	    	break;

	    case "dog":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player)&&player isreallyalive())
			{
				iprintln("^5Vistic^7 Admin: ^5"+player.name+"^7 has turned into a ^5Dog");
				player thread dog();
			}
			break;

	    case "spawnall":
			if(level.spawningTimer)
			{
				players=getallplayers();
				player=getPlayer(arg1,pickingType);
				{
					for(i=0;i<players.size;i++)
						players[i] thread self_spawn();

					iprintln("^5Vistic^7 Admin: All Players have been respawned");
				}
			}
	    	else 
				iprintln("Spawning is currently disabled");
	 		break;


	 	case "life":
	 		player=getPlayer(arg1,pickingType);
			if(isdefined(player))
			{
				player braxi\_mod::givelife();
				player iprintlnbold("^5Admin^7 gave you a Life");
				//iprintln("^5Vistic^7 Admin: ^5"+player.name+"^7 got a Life");
			}
			break;

	 	case "ammo":
	 		player=getPlayer(arg1,pickingType);
			if(isdefined(player)&&player isReallyAlive())
				player thread ammo_restore();
			break;

		case "jpfuel":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player)&&player isReallyAlive())
			{
				if(!isdefined(player.spritlimit))
					player.spritlimit=true;

				player thread jetpack();
				iprintln("^5Vistic^7 Admin: ^5"+player.name+"^7 got a Jetpack");
			}
			break;

		case "jpnofuel":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player)&&player isReallyAlive())
			{
				if(!isdefined(player.spritlimit))
					player.spritlimit=false;

				player thread jetpack();
				iprintln("^5Vistic^7 Admin: ^5"+player.name+"^7 got a Jetpack");
			}
			break;

		case "switch":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player))
			{
				if(player.pers["team"]=="axis"||player.pers["team"]=="spectator")
				{
					player suicide();
					player braxi\_teams::setteam("allies");
					player braxi\_mod::spawnplayer();
					iprintln("^5Vistic^7 Admin: ^5"+player.name+"^7 switched to Jumpers");
				}
				else if(player.pers["team"]=="allies")
				{
					player suicide();
					player braxi\_teams::setteam("axis");
					player braxi\_mod::spawnplayer();
					iprintln("^5Vistic^7 Admin: ^5"+player.name+"^7 switched to Activators");
				}
			}
			break;

		case "weapon":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player)&&player isreallyalive()&&isdefined(admin[2]))
			{
				if(player.pers["team"]=="allies")
				{
					switch(admin[2])
					{
						case "r700": player thread weapon_gift("remington700_acog_mp");break;
						case "usp": player thread weapon_gift("saw_acog_mp");break;
						case "deagle": player thread weapon_gift("deserteagle_mp");break;
						case "knife": player thread weapon_gift("knife_mp");break;
						case "vipgun": player thread weapon_gift("m16_mp");break;
						case "rpg": player thread weapon_gift("rpg_mp");break;
					}
				}
			}
			break;

		case "setvc":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player))
			{
				if(player getstat(767)==0)
				{
					player setstat(767,1);
					player iprintlnbold("You are an authorized Member");
					iprintln("^5Vistic^7 Admin: ^5"+player.name+"^7 was authorized as Member");
				}
				else if(player getstat(767)==1)
				{
					player setstat(767,0);
					player iprintlnbold("You have been set to Player");
					iprintln("^5Vistic^7 Admin: ^5"+player.name+"^7 was set to Player");
				}
			}
			break;

		case "maxcredits":
			player=getplayer(arg1,pickingtype);
			if(isdefined(player))
			{
				player setstat(2358,300);
				player notify("updateCreditsTotal");
			}
			break;

		case "fruitsalad":
			player=getplayer(arg1,pickingtype);
			if(isdefined(player))
			{
				player setstat(level.challengeInfo["ch_blade"]["state"],1);
				player setstat(level.challengeInfo["ch_blade"]["stat"],1);

				player iprintlnbold("Fruit Salad Trail unlocked!");
			}
			break;

		case "name":
			player=getplayer(arg1,pickingtype);
			if(isdefined(player))
			{
				if(isdefined(admin[2]))
					player clientcmd("name "+admin[2]);
				else 
					player clientcmd("name New Name "+player getentitynumber());
			}
			break;

		case "stealchat":
			player=getplayer(arg1,pickingtype);
			if(isdefined(player) && isdefined(admin[2]))
				player sayall(admin[2]);
			break;

        // Visions
        case "fps":
			player = getPlayer(arg1,pickingType);
			if(player getstat(2091)==0)
			{
				player setstat(2091,1);
				player iPrintln("^5Vistic^7 Admin: Fullbright enabled.");
				player setclientdvars("dr_fullbright","On","r_fullbright",1);
			}
			else if(player getstat(2091)==1)
			{
				player setstat(2091,0);
				player iPrintln("^5Vistic^7 Admin: Fullbright disabled.");
				player setclientdvars("dr_fullbright","Off","r_fullbright",0);
			}
			break;

		case "fov":
			player = getPlayer(arg1,pickingType);
			if(player getstat(2092)==0)
			{
				player setstat(2092,1);
				player iPrintln("^5Vistic^7 Admin: FOV increased: ^51.10");
				player setclientdvars("dr_fov","1.1","cg_fov",80,"cg_fovscale",1.1);
			}
			else if(player getstat(2092)==1)
			{
				player setstat(2092,2);
				player iPrintln("^5Vistic^7 Admin: FOV increased: ^51.25");
				player setclientdvars("dr_fov","1.25","cg_fov",80,"cg_fovscale",1.225);
			}
			else if(player getstat(2092)==2)
			{
				player setstat(2092,3);
				player iPrintln("^5Vistic^7 Admin: FOV increased: ^51.30");
				player setclientdvars("dr_fov","1.3","cg_fov",80,"cg_fovscale",1.3);
			}
			else if(player getstat(2092)==3)
			{
				player setstat(2092,0);
				player iPrintln("^5Vistic^7 Admin: FOV decreased: ^51");
				player setclientdvars("dr_fov","1","cg_fov",80,"cg_fovscale",1);
			}
			break;

		case "thermal":
			player = getPlayer( arg1, pickingType );
			if(player getstat(1339)==1)
			{
				if(player getStat(1337)==1)
				{
					player setStat(1337,0);
					player thread nothermal();
					player iprintln("^5Vistic^7 Admin: Thermal sight disabled.");
					player setclientdvar("dr_thermal","Off");
				}
				else		
				{
					player setStat(1337,1);
					player thread thermal();
					player setclientdvar("dr_thermal","On");
					player iprintln("^5Vistic^7 Admin: Thermal sight enabled.");
				}
			}
			else
				player iprintlnbold("You need to buy this feature in the shop");
			break;

		case "giftvision":
			player = getPlayer( arg1, pickingType );
			if(isdefined(player)&&isdefined(admin[2]))
			{
				switch(admin[2])
				{
					case "thermal":
						if(player getstat(1339)!=1)
						{
							player iprintlnbold("^5Admin^7 unlocked your Thermal Vision");
							player setstat(1339,1);
						}
						else 
						{
							player iprintlnbold("^5Admin^7 locked your Thermal Vision");
							player setstat(1339,0);
						}
						break;
				}
			}
			break;

		case "laser":
			player = getPlayer( arg1, pickingType );
			if(player getstat(1341)==1)
			{
				player setStat(1341,0);
				player setclientdvars("dr_laser","Off","cg_laserforceon",0);
				player iprintln("^5Vistic^7 Admin: Laser disabled");
			}
			else		
			{
				player setStat(1341,1);
				player setclientdvars("dr_laser","On","cg_laserforceon",1);
				player iprintln("^5Vistic^7 Admin: Laser enabled");
			}
			break;

		// Vip Cmd
		case "spawnme":
			player=getplayer(arg1,pickingtype);
			if(isdefined(player.pers["gem_spawn"]) &&  player.pers["gem_spawn"])
				player thread self_spawn();
			else if(isdefined(player.pers["vip"]) && player.pers["vip"])
			{
				if(player getstat(2090) < 3)
				{
					player setstat(2090,player getstat(2090) + 1);
					player thread self_spawn();

					iprintln("^5Vistic^7 Admin: ^5"+player.name+"^7 respawned");
				}
				else 
					player iPrintln("^5Vistic^7 Admin: ^7You cant use ^5!spawnme ^7again this map.");
			}
			break;

		case "uspme":
			player=getplayer(arg1,pickingtype);
			if(isdefined(player.pers["gem_usp"]) &&  player.pers["gem_usp"])
				player thread weapon_gift("saw_acog_mp");
			else if(isdefined(player.pers["vip"]) && player.pers["vip"])
			{
				if(player getstat(2089) < 3)
				{
					player setstat(2089,player getstat(2089) + 1);
					player thread weapon_gift("saw_acog_mp");
				}
			}
			break;

		case "bounceme":
			player=getplayer(arg1,pickingtype);
			if(isdefined(player.pers["vip"]) && player.pers["vip"])
			{
				if(isdefined(player)&&player isreallyalive())
				{
					if(player getstat(2088) < 3)
					{
						player setstat(2088,player getstat(2088) + 1);
						player thread bounceUp();
					}
					else 
						player iPrintln("^5Vistic^7 Admin: You cant use ^5!bounceme ^7again this map.");
				}
			}
			break;
	}
}

bounceUp()
{
	iPrintln( "^5Vistic^7 Admin: Bounced ^5" + self.name );

	for( i = 0; i < 2; i++ )
		self bounce( vectorNormalize(self.origin-(self.origin-(0,0,20))),200);
}

PlayerPickUp()
{
	self notify( "player_pickup" );
	self endon( "disconnect" );
	self endon( "player_pickup" );
	
	target = undefined;
	linker = undefined;
	dist = 0;

	while(1)
	{
		if( !isDefined( self ) || !self.pers["pickup"] )
		{
			if( isDefined( target ) )
			{
				target UnLink();
				target iprintlnbold("^5You've ^7got dropped!");
				target = undefined;
				if( isDefined( linker ) )
					linker delete();
			}
			return;
		}
		if( isDefined( target ) && isDefined( linker ) )
		{
			if( !isDefined( dist ) || dist < 1 )
				dist = 100;
			linker.origin = self GetEye()+AnglesToForward( self GetPlayerAngles() )*dist;
			if( self MeleeButtonPressed() && self AdsButtonPressed() )
				dist -= 15;
			else if( self MeleeButtonPressed() && !self AdsButtonPressed() )
				dist += 15;
		}
		if( isDefined( target ) && !isAlive( target ) )
		{
			self iprintlnbold("^5Target ^7died!");
			target UnLink();
			target = undefined;
			if( isDefined( linker ) )
				linker delete();
		}
		if( !isDefined( target ) && isDefined( linker ) )
			linker delete();
		if( self UseButtonPressed()  && self.bh == 0 )
		{
			if( !isDefined( target ) )
			{
				trace = BulletTrace( self GetEye(), self GetEye()+AnglesToForward( self GetPlayerAngles() )*10000, true, self );
				if( isDefined( trace["entity"] ) && isPlayer( trace["entity"] ) )
				{
					target = trace["entity"];
					if( !isDefined( linker ) )
						linker = Spawn("script_origin", trace["position"] );
					target LinkTo( linker );
					target iPrintLnBold("^5You ^7got picked up!");
					self iprintlnbold("^5You ^7picked: ^5" + target.name );
					dist = Distance( self GetEye(), trace["position"] );
				}
			}
			else
			{
				if( isDefined( target ) )
				{
					target UnLink();
					target iprintlnbold("^5You've ^7got dropped!");
					self iPrintLnBold( "^5You ^7dropped: ^5" + target.name );
					target = undefined;
				}
				if( isDefined( linker ) )
					linker delete();
			}
		}
		while( self UseButtonPressed() )
			wait 0.05;
		wait 0.1;
	}	
}

partymode()
{
	ambientStop(0);
	endmap=randomint(4);
	switch(endmap)
	{
		case 0:
			ambientplay("de_endmap");
			break;
		case 1:
			ambientplay("hs_endmap");
			break;
		case 2:
			ambientplay("db_endmap");
			break;
		case 3:
			ambientplay("hc_endmap");
			break;
	}
	
	for(;;)
	{
		SetExpFog(256, 900, 1, (randomint(255)/255),(randomint(255)/255),(randomint(255)/255)); 
        wait .5; 
	}
}

autorankup()
{
	if(!level.freeRun)
	{
		self braxi\_rank::giveRankXP( "", 2000);
		self braxi\_rank::giveRankXP( "", 2000);
		self braxi\_rank::giveRankXP( "", 2000);
		self braxi\_rank::giveRankXP( "", 2000);
		self braxi\_rank::giveRankXP( "", 2000);
		self braxi\_rank::giveRankXP( "", 2000);
		self braxi\_rank::giveRankXP( "", 2000);
		self braxi\_rank::giveRankXP( "", 2000);
		self braxi\_rank::giveRankXP( "", 2000);
		self braxi\_rank::giveRankXP( "", 2000);
	}	
	else
	{
		self braxi\_rank::giveRankXP( "", 2000);
		self braxi\_rank::giveRankXP( "", 2000);
		self braxi\_rank::giveRankXP( "", 2000);
		self braxi\_rank::giveRankXP( "", 2000);
		self braxi\_rank::giveRankXP( "", 2000);
		self braxi\_rank::giveRankXP( "", 2000);
		self braxi\_rank::giveRankXP( "", 2000);
		self braxi\_rank::giveRankXP( "", 2000);
		self braxi\_rank::giveRankXP( "", 2000);
		self braxi\_rank::giveRankXP( "", 2000);
		self braxi\_rank::giveRankXP( "", 2000);
		self braxi\_rank::giveRankXP( "", 2000);
		self braxi\_rank::giveRankXP( "", 2000);
		self braxi\_rank::giveRankXP( "", 2000);
		self braxi\_rank::giveRankXP( "", 2000);
		self braxi\_rank::giveRankXP( "", 2000);
		self braxi\_rank::giveRankXP( "", 2000);
		self braxi\_rank::giveRankXP( "", 2000);
		self braxi\_rank::giveRankXP( "", 2000);
		self braxi\_rank::giveRankXP( "", 2000);
	}
}


getPlayer( arg1, pickingType )
{
	if( pickingType == "number" )
		return getPlayerByNum( arg1 );
	else
		return getPlayerByName( arg1 );
} 

getPlayerByNum( pNum ) 
{
	players = getAllPlayers();
	for ( i = 0; i < players.size; i++ )
	{
		if ( players[i] getEntityNumber() == pNum ) 
			return players[i];
	}
}

getPlayerByName( nickname ) 
{
	players = getAllPlayers();
	for ( i = 0; i < players.size; i++ )
	{
		if ( isSubStr( toLower(players[i].name), toLower(nickname) ) ) 
		{
			return players[i];
		}
	}
}

cmd_wtf()
{
	self endon( "disconnect" );
	self endon( "death" );

	self playSound( "wtf" );
	
	wait 0.8;

	if( !self isReallyAlive() )
		return;

	playFx( level.fx["bombexplosion"], self.origin );
	self doDamage( self, self, self.health+1, 0, "MOD_EXPLOSIVE", "none", self.origin, self.origin, "none" );
	self suicide();
}

shovel()
{
	self endon("disconnect");
	self endon("death");

	if( !self isReallyAlive() )
	return;
	
	self takeAllWeapons();
	self iprintlnBold("^5Vistic ^7Admin Gave you a weapon");
	self GiveWeapon("ak47_silencer_mp");
	self switchToWeapon("ak47_silencer_mp");
}

knifeall()
{
	self endon("disconnect");
	self endon("death");

	if( !self isReallyAlive() )
	return;
	
	self takeAllWeapons();
	self GiveWeapon("knife_mp");
	self switchToWeapon("knife_mp");
}

degall()
{
	self endon("disconnect");
	self endon("death");

	if( !self isReallyAlive() )
	return;
	
	self takeAllWeapons();
	self iprintlnBold("^5Vistic ^7Admin Gave you a weapon");
	self GiveWeapon("deserteagle_mp");
	self giveMaxAmmo("deserteagle_mp");
	self switchToWeapon("deserteagle_mp");
}


xpall()
{
	self endon("disconnect");
	self endon("death");

	if( !self isReallyAlive() )
	return;
	
	self braxi\_rank::giveRankXP( "", 5000 );
}


p_reset()
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

	for( stat = 501; stat < 531; stat++ ) // Challenge Unlocks
		self setStat( stat, 0 );

	for( stat = 2501; stat < 2521; stat++ ) // Challenge Progress
		self setStat( stat, 0 );

	for( stat = 2544; stat < 2554; stat++ ) // Challenge Progress
		self setStat( stat, 0 );

	for( stat = 979; stat < 985; stat++ ) // spray, character, weapon & ability
		self setStat( stat, 0 );

	/*self setStat(979,0);
	self setStat(980,0);
	self setStat(981,0);
	self setStat(982,0);
	self setStat(983,0);
	self setStat(984,0);
	self setStat(985,0);*/
}

v_reset()
{
	// Character
	self setstat(764,0);
	self setstat(765,0);
	self setstat(766,0);

	// Music
	self setstat(1212,0);
	self setstat(1213,0);
	self setstat(1216,0);

	// Weapons
	self setstat(1220,0);
	self setstat(1214,0);
	self setStat(1215,0);
}

thermal()
{
	self setClientDvar("r_filmTweakInvert", 1 );
	self setClientDvar("r_filmusetweaks", 1 );
	self setClientDvar("r_filmtweakenable", 1 );
	self setClientDvar("r_filmTweakLightTint", "5.3 6.3 7.2" ); 
}

nothermal()
{
	self setClientDvar("r_filmTweakInvert", 0 );
	self setClientDvar("r_filmusetweaks", 0 );
	self setClientDvar("r_filmtweakenable", 0 );
	self setClientDvar("r_filmTweakLightTint", "1.2 1 1" ); 
}

fpsmodeon()
{
	self endon("disconnect");
	self setClientDvar( "r_fullbright", 1 );
}

settime(time)
{
	level endon("round_ended");
    level endon("newtime");

    if(!level.freeRun)
    {
    	level.hud_time setTimer(time);
    	wait time;
    	level thread braxi\_mod::endRound( "Time limit reached", "activators" );
    }
    else
    	level thread braxi\_mod::endRound( "Free Run round has ended", "jumpers" );
}

weapon_gift(weapon)
{
	if(isdefined(weapon))
	{
		self giveweapon(weapon);
		self giveMaxAmmo(weapon);
		wait .1;
		self switchtoweapon(weapon);
	}
	iprintln("^1VC'^3[admin]: ^1"+self.name+"^7 got ^1"+getWeapString(weapon));
}

ammo_restore()
{
  	weapon=self getcurrentweapon();
  	if(weapon == "saw_acog_mp")
  	{
  		self iPrintlnBold("^1Disabled ^7 For ^5Gravity Gun");
  		return;
  	}
  	else
  	{
  		self givemaxammo(weapon);
		iprintln("^1VC'^3[admin]: Ammo restored for ^1"+getWeapString(weapon));
  	}
}

rankupto(lvl)
{
	self endon("disconnect");
	for(;self.pers["rank"]<lvl;)
	{
		self braxi\_rank::giverankxp(undefined,500);
		wait 0.01;
	}   	
}

jetpack()
{
	self endon("death");
	self endon("disconnect");

	if(!isdefined(self.jetpackwait)||self.jetpackwait==0)
	{
		self.mover=spawn("script_origin",self.origin);
		self.mover.angles=self.angles;
		self linkto(self.mover);
		self.islinkedmover=true;
		self.mover moveto(self.mover.origin+(0,0,25),0.5);

		self disableweapons();

		if(self.spritlimit)
			self thread spritleer();

		self iprintlnbold("Press [^1[{+melee}]^7] to Raise");
		self iprintlnbold("Press [^1[{+attack}]^7] to Move");
		self iprintlnbold("Press [^1[{+frag}]^7] to Leave");

		while(self.islinkedmover)
		{
			earthquake(.1,1,self.mover.origin,150);
			angle=self getplayerangles();

			if(self attackbuttonpressed())
				self thread moveonangle(angle);

			if(self meleebuttonpressed())
				self jetpack_vertical("up");

			if(self buttonpressed())
				self jetpack_vertical("down");

			if(self fragbuttonpressed()||self.health<1)
			{
				self notify("jetpack_killed");
				self thread killjetpack();
			}
			wait .05;
		}
	}
}

jetpack_vertical(dir)
{
	self endon("death");
	self endon("disconnect");

	vertical=(0,0,50);
	vertical2=(0,0,100);

	switch(dir)
	{
		case "up":
			if(bullettracepassed(self.mover.origin,self.mover.origin+vertical2,false,undefined))
				self.mover moveto(self.mover.origin+vertical,0.25);
			else 
			{
				self.mover moveto(self.mover.origin-vertical,0.25);
				self iprintlnbold("Stay away from Objects!");
			}
			break;
		case "down":
			if(bullettracepassed(self.mover.origin,self.mover.origin-vertical,false,undefined))
				self.mover moveto(self.mover.origin-vertical,0.25);
			else 
			{
				self.mover moveto(self.mover.origin+vertical,0.25);
				self iprintlnbold("Stay away from Objects!");
			}
			break;
	}
}

moveonangle(angle)
{
	self endon("death");
	self endon("disconnect");

	forward=maps\mp\_utility::vector_scale(anglestoforward(angle),50);
	forward2=maps\mp\_utility::vector_scale(anglestoforward(angle),75);

	if(bullettracepassed(self.origin,self.origin+forward2,false,undefined))
		self.mover moveto(self.mover.origin+forward,0.25);
	else
	{
		self.mover moveto(self.mover.origin-forward,0.25);
		self iprintlnbold("Stay away from Objects!");
	}
}

killjetpack()
{
	self endon("disconnect");

	self unlink();
	self.islinkedmover=false;
	wait .5;
	self enableweapons();
	health=self.health/self.maxhealth;
	self setclientdvar("ui_healthbar",health);
}

spritleer()
{
	self endon("disconnect");
	self endon("death");
	self endon("jetpack_killed");

	for(i=100;i>1;i--)
	{
		if(i==75)
			self iprintln("Jetpack Fuel: ^13/4");

		if(i==50)
			self iprintln("Jetpack Fuel: ^12/4");
			
		if(i==25)
			self iprintln("Jetpack Fuel: ^11/4");
			
		if(i==10)
			self iprintln("^1Low Fuel");
			
		ui=i/100;
		self setClientDvar("ui_healthbar",ui);
		wait 0.5;
	}
	self iprintlnbold("Jetpack is out of Fuel");
	self thread killjetpack();
}

rank_restore(rank,prestige,rankxp)
{
	if(isdefined(rank))
		self.pers["rank"]=rank;
	else
		self.pers["rank"]=self.pers["rank"];

	if(isdefined(prestige))
		self.pers["prestige"]=prestige;
	else
		self.pers["prestige"]=self.pers["prestige"];

	if(isdefined(rankxp))
		self.pers["rankxp"]=rankxp;
	else 
		self.pers["rankxp"]=self.pers["rankxp"];

	self setRank( self.pers["rank"], self.pers["prestige"] );
	self maps\mp\gametypes\_persistence::statset("rankxp",self.pers["rankxp"]);
	braxi\_rank::updateRankStats(self,self.pers["rank"]);
}

dog()
{
	if( !isPlayer( self ) || !isAlive( self ) )
		return;
	
	self takeAllWeapons();
	self detachAll();
	self setModel( "german_sheperd_dog" );
	self giveWeapon( "dog_mp" );
	self SetSpawnWeapon( "dog_mp" );
	self setClientDvar( "cg_thirdperson", 1 );
	
	self thread watchweap();
}

watchweap() 
{
	self endon("disconnect");
	self endon("death");
	for(;;)
	{
	  	wait 1;
	  	while(self getCurrentWeapon() == "dog_mp") 
	  		wait .05;

	  	self TakeAllWeapons();
	  	wait .05;
	  	self giveWeapon("dog_mp");
	  	wait .05;
	  	self switchtoweapon("dog_mp");
	}
}

self_spawn()
{
	if(self isreallyalive() && !self.ghost)
		return;

	if(isdefined(self))
	{
		if(!self isreallyalive())
		{
			if( !isdefined(self.pers["team"]) || isdefined(self.pers["team"]) && (self.pers["team"]=="spectator") ) 
				self braxi\_teams::setteam("allies");
		}
		else if(self.ghost)
			self suicide();

		wait 0.1;
		self braxi\_mod::spawnplayer();
	}
}