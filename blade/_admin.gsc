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

/*
	addScriptCommand( COMMAND_NAME, COMMAND_POWER )
	
	COMMAND_NAME = Command name, this is used to invoke the command ingame with $
	COMMAND_POWER = Power (integer) needed to invoke the command. Set to 1 if you want it to be usable by anyone. 0 will make it rcon only.
	--- commandHandler ---
	self = the player entity invoking the command
	cmd = command name from addScriptCommand
	arg = arguments supplied with command
*/

init()
{
	// All
	addscriptcommand("admintest",1);
	addscriptcommand("onlinetime",1);
	addscriptcommand("fps",1);
	addscriptcommand("fov",1);
	addscriptcommand("afk",1);
	addscriptcommand("restoreme",1);
	addscriptcommand("ammo",1);

	// Vip
	addscriptcommand("msg",20);
	addscriptcommand("msg2",20);
	addscriptcommand("msg3",20);

	// Member
	addscriptcommand("heal",40);
	addscriptcommand("rule",40);

	// Moderator
	addscriptcommand("kill",60);
	addscriptcommand("wtf",60);
	addscriptcommand("spectator",60);
	addscriptcommand("spawnall",60);

	// Admin
	addscriptcommand("spawn",80);
	addscriptcommand("level",80);
	addscriptcommand("finish",80);
	addscriptcommand("wtfall",80);
	addscriptcommand("bounce",80);
	addscriptcommand("setvc",80);

	// Master
	addscriptcommand("addtime",100);
	addscriptcommand("setround",100);
	addscriptcommand("resetall",100);
	addscriptcommand("giveweapon",100);
	addscriptcommand("gift",100);
	addscriptcommand("test",100);
	addscriptcommand("setvip",100);
}

commandHandler( cmd, arg )
{
	switch( toLower( cmd ) )
	{
		case "admintest":
			if(self getpower() == 0 || self getpower() == 1)
				exec("say ^8"+self.name+"^7 is in the Admin Group ^8Player");
			else if(self getpower() == 20)
				exec("say ^8"+self.name+"^7 is in the Admin Group ^8ViP");
			else if(self getpower() == 40)
				exec("say ^8"+self.name+"^7 is in the Admin Group ^8Member");
			else if(self getpower() == 60)
				exec("say ^8"+self.name+"^7 is in the Admin Group ^8Moderator");
			else if(self getpower() == 80)
				exec("say ^8"+self.name+"^7 is in the Admin Group ^8Admin");
			else if(self getpower() == 100)
				exec("say ^8"+self.name+"^7 is in the Admin Group ^8Masteradmin");
			break;

		case "onlinetime":
			self thread read_time_played();
			break;

		case "fps":
			if(self getstat(2091) != 1)
			{
				self setstat(2091,1);
				self setclientdvars("dr_fullbright","On","r_fullbright",1);
			}
			else 
			{
				self setstat(2091,0);
				self setclientdvars("dr_fullbright","Off","r_fullbright",0);
			}
			break;

		case "fov":
			if(self getstat(2092) == 0)
			{
				self setstat(2092,1);
				self setclientdvars("dr_fov","1.1","cg_fov",80,"cg_fovscale",1.1);
			}
			else if(self getstat(2092) == 1)
			{
				self setstat(2092,2);
				self setclientdvars("dr_fov","1.25","cg_fov",80,"cg_fovscale",1.225);
			}
			else if(self getstat(2092) == 2)
			{
				self setstat(2092,3);
				self setclientdvars("dr_fov","1.3","cg_fov",80,"cg_fovscale",1.3);
			}
			else if(self getstat(2092) == 3)
			{
				self setstat(2092,0);
				self setclientdvars("dr_fov","1","cg_fov",80,"cg_fovscale",1);
			}
			break;

		case "afk":
			if(self.pers["team"] == "allies")
				setdvar("admin","spectator:"+self getentitynumber());
    		break;

		case "spawnme":
			if(self.pers["vip"])
				setdvar("admin","spawn:"+self getentitynumber());
			break;

		case "uspme":
			if(self.pers["vip"])
				self thread weapon_gift("saw_acog_mp");
			break;

		case "bounceme":
			if(isdefined(self))
			{
				if(self.sessionstate == "playing")
				{
					for(i=0;i<2;i++)
						self braxi\_common::bounce(vectornormalize(self.origin-(self.origin-(0,0,20))),200);

					self iprintlnbold("^5Admin^7 bounced you");
					iprintln("^5Vistic^7 Admin: Bounced ^5"+self.name);
				}
			}
			break;

		case "restoreme":
			self thread cloud\_cloud::restore();
			self thread cloud\_ch_progress::restore();
			break;

		case "ammo":
			if(self getcurrentweapon() == "saw_acog_mp")
			{
				self iprintlnbold("^1disabled for gravity gun");
				break;
			}

			self givemaxammo(self getcurrentweapon());
			self iprintlnbold("ammo restored");
			break;

		// ViP Commands
    	case "msg":
    		if(getdvar("byduff")=="0")
			{
				setdvar("byduff","1");
				thread braxi\_slider::madebyduff(800,0.8,-1,arg);
				thread braxi\_slider::madebyduff(800,0.8,1,arg);
			}
			else if(getdvar("byduff")!="0" && getdvar("byduff2")=="0")
			{
				setdvar("byduff2","1");
				thread braxi\_slider::madebyduff2(800,0.8,-1,arg);
				thread braxi\_slider::madebyduff2(800,0.8,1,arg);
			}
			break;

		case "msg2":
			noti = SpawnStruct();
	    	noti.notifyText = arg;
	    	noti.duration = 6;
	    	noti.glowcolor = (level.randomcolor);
	    	players = getEntArray("player", "classname");
	    	for(i=0;i<players.size;i++)
	        players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
			break;

		case "msg3":
	    	thread braxi\_mod::drawInformationSmall(800,0.8,1,arg);
			thread braxi\_mod::drawInformationSmall(800,0.8,-1,arg);
			break;

		// Member Commands
		case "heal":
			player = getplayerbyname(arg);
			if(isdefined(player))
			{
				if(player.sessionstate == "playing" && player.health != player.maxhealth)
				{
					player.healht = player.maxhealth;
					iprintln(player.name+" health has been restored");
				}
			}
			break;

		case "rule":
			rule = int(arg);
			switch(rule)
			{
				case 1: 
					thread braxi\_slider::madebyduff(800,0.8,-1,"Server Rule ^8#1");
					thread braxi\_slider::madebyduff2(800,0.8,-1,"^7Speak ^5English^7 only!");
					break;

				case 2: 
					thread braxi\_slider::madebyduff(800,0.8,-1,"Server Rule ^8#2");
					thread braxi\_slider::madebyduff2(800,0.8,-1,"^7Do not ^5Flame ^7or ^5Spam^7!");
					break;

				case 3: 
					thread braxi\_slider::madebyduff(800,0.8,-1,"Server Rule ^8#3");
					thread braxi\_slider::madebyduff2(800,0.8,-1,"^7Do not ^5Glitch ^7or ^5Bug use^7!");
					break;

				case 4: 
					thread braxi\_slider::madebyduff(800,0.8,-1,"Server Rule ^8#4");
					thread braxi\_slider::madebyduff2(800,0.8,-1,"^7Do not ^5Cheat ^7or ^5Hack!");
					break;
				
				case 5: 
					thread braxi\_slider::madebyduff(800,0.8,-1,"Server Rule ^8#5");
					thread braxi\_slider::madebyduff2(800,0.8,-1,"^7Always ^5respect^7 other ^5Players ^7and ^5Clan-Members^7!");
					break;

				case 6: 
					thread braxi\_slider::madebyduff(800,0.8,-1,"Server Rule ^8#6");
					thread braxi\_slider::madebyduff2(800,0.8,-1,"^7Do not ^5verbally^7 abuse other ^5Players^7!");
					break;

				case 7: 
					thread braxi\_slider::madebyduff(800,0.8,-1,"Server Rule ^8#7");
					thread braxi\_slider::madebyduff2(800,0.8,-1,"^7Do not ^5constantly ask^7 for ^5Things^7!");
					break;

				case 8: 
					thread braxi\_slider::madebyduff(800,0.8,-1,"Server Rule ^8#8");
					thread braxi\_slider::madebyduff2(800,0.8,-1,"^7Do not ^5knife ^7in ^5Weapon Rooms^7!");
					break;

				case 9: 
					thread braxi\_slider::madebyduff(800,0.8,-1,"Server Rule ^8#9");
					thread braxi\_slider::madebyduff2(800,0.8,-1,"^7Do not ^5Advertise^7!");
					break;

				case 10: 
					thread braxi\_slider::madebyduff(800,0.8,-1,"Server Rule ^8#10");
					thread braxi\_slider::madebyduff2(800,0.8,-1,"^7Do not fake ^5Clan-Membership^7!");
					break;

				default:
					break;
			}
			break;

		case "warn":
			tokens = strtok(arg, " ");
			player = getplayerbyname(tokens[0]);
			if(isdefined(player))
			{
				if(isdefined(tokens[1]))
					player blade\_common::addWarn(1,tokens[1]);
				else 
					player blade\_common::addWarn(1,undefined);
			}
			break;

		// Moderator Commands
    	case "kill":
			player = getplayerbyname(arg);
			if(isdefined(player))
			{
				id = player getentitynumber();
				setdvar("admin","kill:"+id);
			}
			break;

    	case "wtf":
			player = getplayerbyname(arg);
			if(isdefined(player))
			{
				if(player.sessionstate == "playing" && (player.pers["team"] == "allies" || self getpower() == 100))
				{
					player thread cmd_wtf();
    				iprintln(player.name+" has been wtfed");
				}
			}
			break;

		case "spectator":
			player = getplayerbyname(arg);
			if(isdefined(player))
			{
				id = player getentitynumber();
				setdvar("admin","spectator:"+id);
			}
			break;

		case "spawnall":
			setdvar("admin","spawnall:"+self getentitynumber());
			break;

		// Admin
		case "spawn":
			player = getplayerbyname(arg);
			if(isdefined(player))
			{
				id = player getentitynumber();
				setdvar("admin","spawn:"+id);
			}
			break;

		case "level":
			tokens = strtok(arg, " ");

			player = getplayerbyname(tokens[0]);
			rank = tokens[1];

			if(isdefined(rank))
			{
				if(issubstr(rank,"p"))
				{
					rank2 = getsubstr(rank,1 ,3);
					player thread rank_restore(undefined,int(rank2),undefined);

					player iprintlnbold("your prestige was restored to ^8"+rank2);
					iprintln("^8"+player.name+"^7 prestige was restored");
				}
				else 
				{
					player thread rank_restore(int(rank),undefined,braxi\_rank::getRankInfoMaxXP(int(rank)));

					player iprintlnbold("your level was restored to ^8"+rank);
					iprintln("^8"+player.name+"^7 level was restored");
				}
			}
			break;

		case "finish":
			if(0 < int(arg))
				braxi\_mod::endRound("Admin finished","jumpers");
			else
				braxi\_mod::endMap("Admin finished");
			break;

		case "wtfall":
			players = getallplayers();
			for(i=0;i<players.size;i++)
			{
				if(isdefined(players[i]) && players[i].sessionstate == "playing")
				{
	    			if(players[i].pers["team"] == "allies")
	    				players[i] thread cmd_wtf();
				}
			}
			iprintln("All ^5Players^7 have been wtfed.");
			break;

		case "bounce":
			player = getplayerbyname(arg);
			if(isdefined(player))
			{
				if(player.sessionstate == "playing")
				{
					for(i=0;i<2;i++)
						player braxi\_common::bounce(vectornormalize(player.origin-(player.origin-(0,0,20))),200);

					player iprintlnbold("^5Admin^7 bounced you");
					iprintln("^5Vistic^7 Admin: Bounced ^5"+player.name);
				}
			}
			break;

		case "setvc":
			player = getplayerbyname(arg);
			if(isdefined(player))
			{
				if(player getstat(767) != 1)
    			{
					player setstat(767,1);
    				player iprintlnbold("You've been authed as Vistic Member");
    			}
    			else 
    			{
    				player setstat(767,0);
    				player iprintlnbold("You've been deauthed as Vistic Member");
    			}
			}
			break;

		// Masteradmin Commands
		case "addtime":
			level.timeLimit += int(arg);
			iprintln("added +"+arg+" Minutes to Round Time");
			break;

		case "setround":
			game["roundsplayed"] = int(arg);

			players=getAllPlayers();
			for(i=0;i<players.size;i++)
				players[i] setclientdvar("ui_roundNum",game["roundsplayed"]);

			iprintln("changed to Round "+arg);
			break;

		case "resetall":
			player = getplayerbyname(arg);
			if(isdefined(player))
			{
				player thread p_reset();
				player thread v_reset();

				player iprintlnbold("Everything has been reseted");
			}
			break;

		case "giveweapon":
			tokens = strtok(arg, " ");
			player = getplayerbyname(tokens[0]);
			if(isdefined(player) /*&& !level.trapsdisabled*/)
			{
				if(player.sessionstate == "playing")
				{
					player giveweapon(tokens[1]+"_mp");
					player switchtoweapon(tokens[1]+"_mp");
					player givemaxammo(tokens[1]+"_mp");
				}
			}
    		break;

		case "gift":
			tokens = strtok(arg, " ");
			player = getplayerbyname(tokens[0]);
			if(isdefined(player))
			{
				if(player.sessionstate == "playing")
					player blade\_common::vc_rubys(tokens[1]);
			}
			break;

		case "test":
			player = getplayerbyname(arg);
			if(isdefined(player))
				player thread blade\_credits::jewelRain(10);
			break;

		case "setvip":
			player = getplayerbyname(arg);
			if(isdefined(player))
			{
				if(player getstat(764) != 1)
				{
					player setstat(764,1);
					player.pers["vip"] = self getstat(764);
					player iprintlnbold("You got VIP Status");
				}
				else 
				{
					player setstat(764,0);
					player.pers["vip"] = self getstat(764);
					player iprintlnbold("You got VIP Status removed");
				}
			}
			break;

		/*
		case "cloud_save":
			self iprintln("^5Vistic^7 Admin: ^5You^7 saved your Rank in ^5Vistic Cloud!");
			logPrint("VCCLOUD;"+self getguid()+";"+self.pers["rank"]+";"+self.pers["prestige"]+"\n");
			break;

	 	case "ammo":
	 		player = getplayerbynamepart(arguments);
			if(isdefined(player)&&player isReallyAlive())
				player thread ammo_restore();
			break;
		*/

		default:
			break;
	}
}

printClient( ent, str )
{
	exec( "tell " + ent getEntityNumber() + " " + str );
}

getAllPlayers()
{
	return getEntArray( "player", "classname" );
}

bounceUp()
{
	iPrintln( "^5Vistic^7 Admin: Bounced ^5" + self.name );

	for( i = 0; i < 2; i++ )
		self braxi\_common::bounce( vectorNormalize(self.origin-(self.origin-(0,0,20))),200);
}

cmd_wtf()
{
	self endon( "disconnect" );
	self endon( "death" );

	self playSound( "wtf" );
	
	wait 0.8;

	if( self.sessionstate != "playing" )
		return;

	playFx( level.fx["bombexplosion"], self.origin );
	self doDamage( self, self, self.health+1, 0, "MOD_EXPLOSIVE", "none", self.origin, self.origin, "none" );
	self suicide();
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
	self setstat(2356,0);
	self setstat(2357,0);
	self setstat(2358,0);
	self setstat(2360,0);

	for( stat = 501; stat < 546; stat++ ) // Challenge Unlocks
		self setStat( stat, 0 );

	for( stat = 2501; stat < 2543; stat++ ) // Challenge Progress
		self setStat( stat, 0 );

	for( stat = 979; stat < 985; stat++ ) // spray, character, weapon & ability
		self setStat( stat, 0 );
}

v_reset()
{
	// VIP Stat
	self setstat(764,0);
	self.pers["vip"] = self getstat(764);

	// Rest
	self setstat(1212,0);
	self setstat(1213,0);
	self setstat(1214,0);
	self setstat(1215,0);
	self setstat(1216,0);
	self setstat(1217,0);
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
	iprintln("^1VC'^3[admin]: ^1"+self.name+"^7 got ^1"+weapon);
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
		iprintln("^1VC'^3[admin]: Ammo restored ");
  	}
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

self_spawn()
{
	if(isdefined(self))
	{
		if(self.sessionstate != "playing")
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

doDamage( eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc )
{
	self finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, 0 );
}

admin_spawnall()
{
	players = getallplayers();
	for(i=0;i<players.size;i++)
	{
		if(isdefined(players[i].pers["team"]) && players[i].pers["team"] == "allies" && players[i].sessionstate != "playing")
			players[i] thread braxi\_mod::spawnplayer();
		else if(players[i].ghost)
		{
			players[i] suicide();
			wait 0.1;
			players[i] thread braxi\_mod::spawnplayer();
		}
		wait .05;
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

read_time_played()
{
	level endon("game over");
    self endon("disconnect");

    total_time = self maps\mp\gametypes\_persistence::statGet("ONLINE_TIME") + 1;
    total_hours = calculate_time(total_time,"hourmin");

    wait .05;

    exec("say ^8"+self.name+"^7 has already played ^9"+total_hours);
}

calculate_time(time,show)
{
   	if(!isDefined(show))
    	show = "hourminsec";

	returnstring = "";
	if(time >= 0 )
	{
      	time = int(time);
      	hours = floor(time / 3600);
	    divisor_for_minutes = time % 3600;
	    minutes = floor(divisor_for_minutes / 60);
	    divisor_for_seconds = divisor_for_minutes % 60;
	    seconds = ceil(divisor_for_seconds);

      	if( hours < 10 )
        	hours = "0" + hours;
         
      	if( minutes < 10 )
         	minutes = "0" + minutes;
   
      	if( seconds < 10 )
         	seconds = "0" + seconds;
         
      	if(isSubStr(show,"hour"))
         	returnstring += hours+"h";

      	if(isSubStr(show,"min"))
         	returnstring += " "+minutes+"min";
         
      	if(isSubStr(show,"sec"))
         	returnstring += ":"+seconds;
    }
   	else 
   		returnstring = "0H 0MIN";

    return returnstring;
}


// VIP
vip_response(response)
{
	if(self.pers["vip"])
	{
		switch(response)
		{
			case "vip_0":
				if(self getstat(1212) != 1)
					self setstat(1212,1);
				else 
					self setstat(1212,0);
				self setVipDvar(1212,"vip_model");
				break;

			case "vip_1":
				if(self getstat(1214) != 1)
					self setstat(1214,1);
				else 
					self setstat(1214,0);
				self setVipDvar(1214,"vip_weapon");
				break;

			case "vip_2":
				if(self getstat(1213) != 1)
					self setstat(1213,1);
				else 
					self setstat(1213,0);
				self setVipDvar(1213,"vip_knife");
				break;

			case "vip_3":
				if(self getstat(1215) != 1)
					self setstat(1215,1);
				else
					self setstat(1215,0);
				self setVipDvar(1215,"vip_gloves");
				break;

			case "vip_4":
				if(self getstat(1216) != 1)
					self setstat(1216,1);
				else 
					self setstat(1216,0);
				self setVipDvar(1216,"vip_trail");
				break;

			case "vip_5":
				if(self getstat(1217) != 1)
				{
					self setstat(1217,1);

					self closemenu();
					self closeingamemenu();

					self setVipDvar2(1217,"vc_rain");
					self thread blade\_credits::jewelRain(10);
				}
				break;
			
		}
	}
}

vip_preset()
{
	self setVipDvar(1212,"vip_model");
	self setVipDvar(1213,"vip_knife");
	self setVipDvar(1214,"vip_weapon");
	self setVipDvar(1215,"vip_gloves");
	self setVipDvar(1216,"vip_trail");
	self setVipDvar2(1217,"vip_rain");
}

setVipDvar(stat,dvar)
{
	if(self getstat(stat) == 1)
		self setClientDvar(dvar, "^8Enabled");
	else
		self setClientDvar(dvar, "^9Disabled");
}
setVipDvar2(stat,dvar)
{
	if(self getstat(stat) == 1)
		self setClientDvar(dvar, "^8Cooldown");
	else
		self setClientDvar(dvar, "^9Use");
}