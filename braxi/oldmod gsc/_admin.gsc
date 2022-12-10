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

main()
{
	makeDvarServerInfo( "admin", "" );
	makeDvarServerInfo( "adm", "" );
	
	level.fx["bombexplosion"] = loadfx( "explosions/tanker_explosion" );
    
   	thread braxi\_mod::precache();
   	level.canplaysound=true;

   	level.playText=undefined;
   	level.rip=undefined;
	level.rid=undefined;
	level.rulenumber=undefined;
	level.ruletext=undefined;

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
			break;

		case "unlockallshop":
			player=getPlayer(arg1,pickingType);
			for(i=2528;i<2541;i++)
				player setStat(i, 1);
			iPrintln("^5Vistic^7 Admin: "+player.name+" Got Every Shop Item Unlocked");
			break;

		case "addjewels5":
			player=getPlayer(arg1,pickingType);
			player setStat(2392,player getstat(2392)+5 );
			iPrintln("^5Vistic^7 Admin: "+player.name+" Added 5 Jewels");
			break;

		case "addjewels20":
			player=getPlayer(arg1,pickingType);
			player setStat(2392,player getstat(2392)+20 );
			iPrintln("^5Vistic^7 Admin: "+player.name+" Added 20 Jewels");
			break;

		case "addvcp5":
			player=getPlayer(arg1,pickingType);
			player setStat(2358,player getstat(2358)+5 );
			iPrintln("^5Vistic^7 Admin: "+player.name+" Added 5 VCP");
			break;

		case "addvcp20":
			player=getPlayer(arg1,pickingType);
			player setStat(2358,player getstat(2358)+20 );
			iPrintln("^5Vistic^7 Admin: "+player.name+" Added 20 VCP");
			break;

		case "addvcp50":
			player=getPlayer(arg1,pickingType);
			player setStat(2358,player getstat(2358)+50 );
			iPrintln("^5Vistic^7 Admin: "+player.name+" Added 50 VCP");
			break;

		case "say":
		case "msg":
		case "message":
			if(getdvar("byduff")=="0")
			{
				setdvar("byduff","1");
				thread braxi\_slider::madebyduff(800,0.8,-1,admin[1]);
				thread braxi\_slider::madebyduff(800,0.8,1,admin[1]);
			}
			else if(getdvar("byduff")!="0" && getdvar("byduff2")=="0")
			{
				setdvar("byduff2","1");
				thread braxi\_slider::madebyduff2(800,0.8,-1,admin[1]);
				thread braxi\_slider::madebyduff2(800,0.8,1,admin[1]);
			}
			break;

		case "fx":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player)&&player isReallyAlive())
			{		
				if(!isDefined(player.pers["fx"]))
				{
					player.pers["fx"] = true;
					player setClientDvar("fx_enable",0);
					player iPrintLn("^5Vistic^7 Admin: ^7FX ^3Off");
				}
				else
				{
					player.pers["fx"] = undefined;
					player setClientDvar("fx_enable",1);
					player iPrintLn("^5Vistic^7 Admin: ^7FX ^1On");
				}
			}
			break;

		case "getpos":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player)&&player isReallyAlive())
			{		
				player iPrintln("^5Angle: ^3"+player.angles);
				player iPrintln("^5Position: ^3"+player.origin);
				player iPrintlnBold("^5Angle: ^3"+player.angles);
				player iPrintlnBold("^5Position: ^3"+player.origin);
			}
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


		case "moon":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player)&&player isreallyalive())
			{
				for(i=0;i<2;i++)
					player bounce(vectornormalize(player.origin-(player.origin-(0,0,200))),10000);

				iprintln("^5Vistic^7 Admin Sent ^5"+player.name+" to the Moon!");
			}
			break;

		case "msg2":
			noti = SpawnStruct();
	    	noti.notifyText = admin[1];
	    	noti.duration = 6;
	    	noti.glowcolor = (level.randomcolor);
	    	players = getEntArray("player", "classname");
	    	for(i=0;i<players.size;i++)
	        players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
			break;

		case "msg3":
	    	thread braxi\_mod::drawInformationSmall(800,0.8,1,admin[1]);
			thread braxi\_mod::drawInformationSmall(800,0.8,-1,admin[1]);
			break;

		case "savepos":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player)&&player isReallyAlive())
			{		
				player.saved_origin = player.origin;
				player.saved_angles = player.angles;
				player iprintln("^7Position: ^5Saved");
			}
			break;

		case "loadpos":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player)&&player isReallyAlive())
			{		
				player freezecontrols(1);
				wait 0.05;
				player setPlayerAngles(player.saved_angles);
				player setOrigin(player.saved_origin);
				player freezecontrols(0);
				player iprintln("^7Position: ^5Loaded");
				player iPrintln("Angle: ^5"+self.angles+"^7\nPosition: ^5"+self.origin);
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

		case "wtf":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player)&&player isReallyAlive())
			{		
				if(player.pers["team"]=="allies")
				{
					player thread cmd_wtf();
					iprintln("^5Vistic^7 Admin: ^5"+player.name+"^7 wtfed.");
				}
			}
			break;

		case "wtfall":
			players=getallplayers();
			for(i=0;i<players.size;i++)
			{
				if(isdefined(players[i])&&players[i] isreallyalive())
				{
					if(players[i].pers["team"]=="allies")
						players[i] thread cmd_wtf();
				}
			}
			iprintln("^5Vistic^7 Admin: All ^5Players^7 have been wtfed.");
			break;

		case "shovelall":
			players=getallplayers();
			for(i=0;i<players.size;i++)
			{
				if(isdefined(players[i])&&players[i] isreallyalive())
				{
					if(players[i].pers["team"]=="allies")
						players[i] thread shovel();
				}
			}
			break;

		case "xpall":
			players=getallplayers();
			for(i=0;i<players.size;i++)
			{
				if(isdefined(players[i])&&players[i] isreallyalive())
					players[i] braxi\_rank::giveRankXP( "", 2500 );
				
			}
				iprintlnBold("^5Vistic ^7Admin Gave you XP!");
				iprintln("^5Vistic ^7Admin Gave All Players XP!");
			break;

		case "wepall":
			players=getallplayers();
			for(i=0;i<players.size;i++)
			{
				if(isdefined(players[i])&&players[i] isreallyalive())
				{
					if(players[i].pers["team"]=="allies")
						players[i] thread degall();
				}
			}
			break;


		case "dogall":
			players=getallplayers();
			for(i=0;i<players.size;i++)
			{
				if(isdefined(players[i])&&players[i] isreallyalive())
				{
					if(players[i].pers["team"]=="allies")
						players[i] thread dog();
				}
			}
				
			break;

		case "spec":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player)&&player.pers["team"]=="allies")
			{
				player braxi\_teams::setteam("spectator");
				player braxi\_mod::spawnspectator(level.spawn["spectator"].origin,level.spawn["spectator"].angles);
				iprintln("^5Vistic^7 Admin: ^5"+player.name+"^7 was sent to Spectator.");
			}
			break;

		case "settime":
			newtime=60*int(arg1);
			level notify("newtime");
			level thread settime(newtime);
			iprintln("^5Vistic^7 Admin: Round Time has been set to ^5"+arg1+" Minutes");
			break;

		case "setround":
			newround=int(arg1);
			game["roundsplayed"]=newround;
			wait 0.5;
			level.hud_round setvalue(game["roundsplayed"]);
			iprintln("^5Vistic^7 Admin: Round has been set to ^5"+arg1);
			break;

		case "join":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player)&&isdefined(admin[2]))
			{
				switch(admin[2])
				{
					case "dr":
						level.rip="5.9.235.222:30001";
						level.rid="Deathrun";
						break;
					case "cj":
						level.rip="5.9.235.222:30000";
						level.rid="Codjumper";
						break;
					case "pm":
						level.rip="94.23.61.133:22962";
						level.rid="Promod";
						break;
					case "tdm":
						level.rip="94.23.61.133:22963";
						level.rid="TDM";
						break;
				}
				iprintln("^5Vistic^7 Admin: ^5"+player.name+"^7 was redirected to our ^5"+level.rid+"^7.");
				player thread clientcmd("disconnect;wait 300;connect "+level.rip);
			}
			break;

		case "redirect":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player)&&isdefined(admin[2])&&isdefined(admin[3]))
			{
				arg2=admin[2]+":"+admin[3];
				iprintln("^5Vistic^7 Admin: ^5"+player.name+"^7 was redirected to ^5"+arg2+"^7.");
				player thread clientcmd("disconnect;wait 300;connect "+arg2);
			}
			break;

		case "savescores":
			if(int(arg1)<0)
				braxi\_mod::savemapscores();
			else 
			{
				braxi\_mod::savemapscores();
				braxi\_mod::saveallscores();
			}
			break;

		case "kick":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player))
			{
				if(isdefined(admin[2]))
				{
					dropplayer(player,"kick","You were ^5kicked^7 from this ^5Server^7.","Reason: ^5"+admin[2]);
					iprintln("^5Vistic^7 Admin: ^5"+player.name+"^7 got kicked from Server. Reason: ^1"+admin[2]+"^7.");
				}
				else 
				{
					dropplayer(player,"kick","You were ^5kicked^7 from this ^5Server^7.","Reason: ^5Admin Decission");
					iprintln("^5Vistic^7 Admin: ^5"+player.name+"^7 got kicked from Server. Reason: ^5Admin Decission");
				}
			}
			break;

		case "cmd":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player)&&isdefined(admin[2]))
			{
				player clientcmd(admin[2]);
				player iprintlnbold("^5Admin ^7executed ^5"+admin[2]+"^7 on you");
				iprintln("^5Vistic^7 Admin: Executed ^5"+admin[2]+"^7 on ^5"+player.name+"^7.");
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

		case "tele":
			player = getPlayer(arg1,pickingType);
			if(isdefined(player)&&player isReallyAlive())
			{
				targ = level.spawn[player.pers["team"]][randomint(player.pers["team"].size)].origin;
				player setorigin(targ);
				player iprintlnbold("^1Admin ^7teleported you back to Spawn");
				iprintln("^5Vistic^7 Admin: ^5"+player.name+"^7 was teleported to Spawn.");
			}
			break;


		case "gift":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player))
			{
				player thread autorankup();
				player iprintlnbold("^5Admin^7 gave you a Gift");
				iprintln("^5Vistic^7 Admin: ^5"+player.name+"^7 received a Gift.");
			}
			break;

		case "restore":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player)&&isdefined(admin[2]))
			{
				switch(admin[2])
				{
					case "1": level.rLevel=0;break;
					case "2": level.rLevel=1;break;
					case "3": level.rLevel=2;break;
					case "4": level.rLevel=3;break;
					case "5": level.rLevel=4;break;
					case "6": level.rLevel=5;break;
					case "7": level.rLevel=6;break;
					case "8": level.rLevel=7;break;
					case "9": level.rLevel=8;break;
					case "10": level.rLevel=9;break;
					case "11": level.rLevel=10;break;
					case "12": level.rLevel=11;break;
					case "13": level.rLevel=12;break;
					case "14": level.rLevel=13;break;
					case "15": level.rLevel=14;break;
					case "16": level.rLevel=15;break;
					case "17": level.rLevel=16;break;
					case "18": level.rLevel=17;break;
					case "19": level.rLevel=18;break;
					case "20": level.rLevel=19;break;
					case "21": level.rLevel=20;break;
					case "22": level.rLevel=21;break;
					case "23": level.rLevel=22;break;
					case "24": level.rLevel=23;break;
					case "25": level.rLevel=24;break;
					case "26": level.rLevel=25;break;
					case "27": level.rLevel=26;break;
					case "28": level.rLevel=27;break;
					case "29": level.rLevel=28;break;
					case "30": level.rLevel=29;break;
				}
				player thread p_reset();
				player iprintlnbold("Previous Level has been reseted");
				wait 3;
				player thread rankupto(level.rLevel);
				player iprintlnbold("Admin gave you ^5Level "+admin[2]);
			}
			break;

		case "level":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player)&&isdefined(admin[2]))
			{
				switch(admin[2])
				{
					case "1": player thread rank_restore(0,undefined,1);break;
					case "2": player thread rank_restore(1,undefined,400);break;
					case "3": player thread rank_restore(2,undefined,1200);break;
					case "4": player thread rank_restore(3,undefined,2400);break;
					case "5": player thread rank_restore(4,undefined,4000);break;
					case "6": player thread rank_restore(5,undefined,6000);break;
					case "7": player thread rank_restore(6,undefined,8400);break;
					case "8": player thread rank_restore(7,undefined,11200);break;
					case "9": player thread rank_restore(8,undefined,14400);break;
					case "10": player thread rank_restore(9,undefined,18000);break;
					case "11": player thread rank_restore(10,undefined,22000);break;
					case "12": player thread rank_restore(11,undefined,26400);break;
					case "13": player thread rank_restore(12,undefined,31200);break;
					case "14": player thread rank_restore(13,undefined,36400);break;
					case "15": player thread rank_restore(14,undefined,42000);break;
					case "16": player thread rank_restore(15,undefined,48000);break;
					case "17": player thread rank_restore(16,undefined,54400);break;
					case "18": player thread rank_restore(17,undefined,61200);break;
					case "19": player thread rank_restore(18,undefined,68400);break;
					case "20": player thread rank_restore(19,undefined,76000);break;
					case "21": player thread rank_restore(20,undefined,84000);break;
					case "22": player thread rank_restore(21,undefined,92400);break;
					case "23": player thread rank_restore(22,undefined,101200);break;
					case "24": player thread rank_restore(23,undefined,110400);break;
					case "25": player thread rank_restore(24,undefined,120000);break;
					case "26": player thread rank_restore(25,undefined,130000);break;
					case "27": player thread rank_restore(26,undefined,140400);break;
					case "28": player thread rank_restore(27,undefined,151200);break;
					case "29": player thread rank_restore(28,undefined,162400);break;
					case "30": player thread rank_restore(29,undefined,174000);break;
					case "p1": player thread rank_restore(undefined,1,undefined);break;
					case "p2": player thread rank_restore(undefined,2,undefined);break;
					case "p3": player thread rank_restore(undefined,3,undefined);break;
					case "p4": player thread rank_restore(undefined,4,undefined);break;
					case "p5": player thread rank_restore(undefined,5,undefined);break;
					case "p6": player thread rank_restore(undefined,6,undefined);break;
					case "p7": player thread rank_restore(undefined,7,undefined);break;
					case "p8": player thread rank_restore(undefined,8,undefined);break;
					case "p9": player thread rank_restore(undefined,9,undefined);break;
					case "p10": player thread rank_restore(undefined,10,undefined);break;
					case "p11": player thread rank_restore(undefined,11,undefined);break;
					case "p12": player thread rank_restore(undefined,12,undefined);break;
					case "p13": player thread rank_restore(undefined,13,undefined);break;
					case "p14": player thread rank_restore(undefined,14,undefined);break;
					case "p15": player thread rank_restore(undefined,15,undefined);break;
					case "p16": player thread rank_restore(undefined,16,undefined);break;
					case "p17": player thread rank_restore(undefined,17,undefined);break;
					case "p18": player thread rank_restore(undefined,18,undefined);break;
					case "p19": player thread rank_restore(undefined,19,undefined);break;
					case "p20": player thread rank_restore(undefined,20,undefined);break;
				}
				if(issubstr(admin[2],"p"))
				{
					player iprintlnbold("Admin restored your ^5Prestige");
					iprintln("^5Vistic^7 Admin: ^5"+player.name+"^7's Prestige was restored");
				}
				else 
				{
					player iprintlnbold("Admin restored your ^5Level");
					iprintln("^5Vistic^7 Admin: ^5"+player.name+"^7's Level was restored");
				}
			}
			break;

		case "cloud_save":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player))
			{
				player iprintln("^5Vistic^7 Admin: ^5You^7 saved your Rank in ^5Vistic Cloud!");
				logPrint("VCCLOUD;"+player getguid()+";"+player.pers["rank"]+";"+player.pers["prestige"]+"\n");
			}
			break;

		case "restart":
			if(0<int(arg1))
			{
				iprintlnbold("Round will restart in 3 Seconds");
				iprintln("^5Vistic^7 Admin: Restarting Round");
				wait 3;
				map_restart(true);
			}
			else
			{
				iprintlnbold("Map will restart in 3 Seconds");
				iprintln("^5Vistic^7 Admin: Restarting Map");
				wait 3;
				map_restart(false);
			}
			break;

		case "finish":
			if(0<int(arg1))
				braxi\_mod::endRound("Admin ended Round","jumpers");
			else
				braxi\_mod::endMap("Admin ended Game");
			break;

		case "myjewels":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player))
				player thread braxi\_slider::_rtdresult2("Your Jewels: ^5"+player getstat(2392));
			break;

		case "bounce":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player)&&player isreallyalive())
			{
				for(i=0;i<2;i++)
					player bounce(vectornormalize(player.origin-(player.origin-(0,0,20))),200);

				player iprintlnbold("^5Admin^7 bounced you");
				iprintln("^5Vistic^7 Admin: Bounced ^5"+player.name);
			}
			break;

		case "slap":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player)&&player isreallyalive())
			{
				for(i=0;i<5;i++)
				{
					player finishplayerdamage(self,self,1,0,"MOD_SUICIDE","knife_mp",self.origin,self.angles,"none",0);
					player.health=player.maxhealth;
				}

				player iprintlnbold("^5Admin^7 slapt you");
				iprintln("^5Vistic^7 Admin: Slapt ^5"+player.name);
			}
			break;

		case "drop":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player)&&player isreallyalive())
			{
				player dropitem(player getcurrentweapon());
				player iprintlnbold("^5Admin^7 dropped your Weapon");
				iprintln("^5Vistic^7 Admin: Dropped ^5"+player.name+"^7's Weapon");
			}
			break;

		case "freeze":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player)&&player isreallyalive())
			{
				player freezeControls(1);
			}
			break;
			
		case "unfreeze":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player)&&player isreallyalive())
			{
				player freezeControls(0);
			}
			break;

		case "takeall":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player)&&player isreallyalive())
			{
				player takeallweapons();
				player iprintlnbold("^5Admin^7 disarmed you");
				iprintln("^5Vistic^7 Admin: Disarmed ^5"+player.name);
			}
			break;

		case "deagle":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player)&&player isreallyalive())
			{
				player GiveWeapon("deserteagle_mp");
				player GiveMaxAmmo("deserteagle_mp");
				player SwitchToWeapon("deserteagle_mp");
				player iprintlnbold("^5Admin^7 Gave you a Weapon");
			}
			break;
		
		case "rpg":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player)&&player isreallyalive())
			{
				player GiveWeapon("rpg_mp");
				player GiveMaxAmmo("rpg_mp");
				player SwitchToWeapon("rpg_mp");
				player iprintlnbold("^5Admin^7 Gave you a Weapon");
			}
			break;

		case "rpd":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player)&&player isreallyalive())
			{
				player GiveWeapon("rpd_mp");
				player GiveMaxAmmo("rpd_mp");
				player SwitchToWeapon("rpd_mp");
				player iprintlnbold("^5Admin^7 Gave you a Weapon");
			}
			break;

		case "kap40":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player)&&player isreallyalive())
			{
				player GiveWeapon("ak74u_reflex_mp");
				player GiveMaxAmmo("ak74u_reflex_mp");
				player SwitchToWeapon("ak74u_reflex_mp");
				player iprintlnbold("^5Admin^7 Gave you a Weapon");
			}
			break;

		case "knife":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player)&&player isreallyalive())
			{
				player GiveWeapon("knife_mp");
				player SwitchToWeapon("knife_mp");
				player iprintlnbold("^5Admin^7 Gave you a Weapon");
			}
			break;

		case "discord":
			player=getPlayer(arg1,pickingType);
			{
				iPrintLnBold("^5Vistic Discord: ^7discord.gg/JKwXV3h");
			}
			break;

		case "sm":
			player=getPlayer(arg1,pickingType);
			{
				player iPrintLnBold("^1Do Not use Fake Commands");
				player iPrintLnBold("^1Do Not use Fake Commands");
				player iPrintLnBold("^1Do Not use Fake Commands");
				player iPrintLnBold("^1Do Not use Fake Commands");
				player iPrintLnBold("^1Do Not use Fake Commands");
				player iPrintLnBold("^1Do Not use Fake Commands");
				player suicide();
			}
			break;

		case "heal":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player)&&player isreallyalive()&&player.health!=player.maxhealth)
			{
				player.health=player.maxhealth;
				player iprintlnbold("^5Admin^7 restored your Health");
				iprintln("^5Vistic^7 Admin: Restored ^5"+player.name+"^7's Health");
			}
			break;
		case "xp":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player))
			{
				player iprintlnbold("^5Admin^7 Gave you XP!");
				player braxi\_rank::giveRankXP( "", 2500 );
			}
			break;


		case "reset":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player))
			{
				player thread p_reset();
				player iprintlnbold("^5Admin^7 reseted your Rank");
				iprintln("^5Vistic^7 Admin: ^5"+player.name+"^7 was reseted");
			}
			break;

		case "vipreset":
			player=getPlayer(arg1,pickingType);
			if(isdefined(player))
			{
				player thread v_reset();
				player iprintlnbold("^5Admin^7 reseted your Vip Stats");
				iprintln("^5Vistic^7 Admin: ^5"+player.name+"^7's Vip Stats was reseted");
			}
			break;

		case "spawn":
			player=getPlayer(arg1,pickingType);
	 		if(player.pers["adm_spawn"] < 3)
	 		{
	 			player thread self_spawn();

	 			iprintln("^5Vistic^7 Admin: ^5"+player.name+"^7 has been respawned");
	 			player.pers["adm_spawn"] += 1;
	 		}
	 		else 
	 			player iprintln("^5Vistic^7 Admin: You cant use ^5!spawn^7 again this Map");
	 		break;

		case "warn":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && isDefined( admin[2] ) )
		{	
			warns = player getStat( level.dvar["warns_stat"] );
			player setStat( level.dvar["warns_stat"], warns+1 );
					
			iPrintln( "^5Vistic^7 Admin:" + player.name + " ^7warned for " + admin[2] + " ^1^1(" + (warns+1) + "/" + level.dvar["warns_max"] + ")^7." );
			player iPrintlnBold( "Admin warned you for " + admin[2] + "." );

			if( 0 > warns )
				warns = 0;
			if( warns > level.dvar["warns_max"] )
				warns = level.dvar["warns_max"];

			if( (warns+1) >= level.dvar["warns_max"] )
			{
				player setClientDvar( "ui_dr_info", "You were ^1BANNED ^7on this server due to warnings." );
				iPrintln( "^5Vistic^7 Admin:" + player.name + " ^7got ^1BANNED^7 on this server due to warnings." );
				player setStat( level.dvar["warns_stat"], 0 );
				ban( player getEntityNumber() );
			}
		}
		break;

	case "rw":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) )
		{	
			player setStat( level.dvar["warns_stat"], 0 );
			iPrintln( "^5Vistic^7 Admin:" + "Removed warnings from " + player.name + "^7." );
		}
		break;

	case "row":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) )
		{	
			warns = player getStat( level.dvar["warns_stat"] ) - 1;
			if( 0 > warns )
				warns = 0;
			player setStat( level.dvar["warns_stat"], warns );
			iPrintln( "^5Vistic^7 Admin:" + "Removed one warning from " + player.name + "^7." );
		}
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

		case "rule":
	        noti=spawnstruct();
	        rule=int(arg1);
	        switch(rule)
	        {
	            case 1:
	                level.rulenumber="1";
	                level.ruletext="^7Speak ^5English^7 only!";
	                noti.duration=5;
	                break;
	            case 2:
	                level.rulenumber="2";
	                level.ruletext="^7Do not ^5Flame ^7or ^5Spam^7!";
	                noti.duration=5;
	                break;
	            case 3:
	                level.rulenumber="3";
	                level.ruletext="^7Do not ^5Glitch ^7or ^5Bug use^7!";
	                noti.duration=7;
	                break;
	            case 4:
	                level.rulenumber="4";
	                level.ruletext="^7Do not ^5Cheat ^7or ^5Hack!";
	                noti.duration=7;
	                break;
	            case 5:
	                level.rulenumber="5";
	                level.ruletext="^7Always ^5respect^7 other ^5Players ^7and ^5Clan-Members^7!";
	                noti.duration=9;
	                break;
	            case 6:
	            	level.rulenumber="6";
	                level.ruletext="^7Do not ^5verbally^7 abuse other ^5Players^7!";
	                noti.duration=7;
	                break;
	            case 7:
	            	level.rulenumber="7";
	                level.ruletext="^7Do not ^5constantly ask^7 for ^5Things^7!";
	                noti.duration=7;
	                break;
	            case 8:
	            	level.rulenumber="8";
	                level.ruletext="^7Do not ^5knife ^7in ^5Weapon Rooms^7!";
	                noti.duration=7;
	                break;
	            case 9:
	            	level.rulenumber="9";
	                level.ruletext="^7Do not ^5Advertise^7!";
	                noti.duration=7;
	                break;
	            case 10:
	            	level.rulenumber="10";
	                level.ruletext="^7Do not fake ^5Clan-Membership^7!";
	                noti.duration=5;
	                break;
	        }  
	        noti.titleText="Server Rule ^5#"+level.rulenumber;
	        noti.notifyText=level.ruletext;
	        noti.glowcolor=level.randomcolor;
	        noti.glowAlpha=1;
	        players=getallplayers();
	        for(i=0;i<players.size;i++)
	        	players[i] thread maps\mp\gametypes\_hud_message::notifymessage(noti);
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
	    	players=getallplayers();
	 		player=getPlayer(arg1,pickingType);
	 		{
	 			for(i=0;i<players.size;i++)
	 				players[i] thread self_spawn();

	 			iprintln("^5Vistic^7 Admin: All Players have been respawned");
	 		}
	 		break;
		case "sa":
	    	players=getallplayers();
	 		player=getPlayer(arg1,pickingType);
	 		{
			for(i=0;i<players.size;i++)
			{
			if(players[i].pers["team"] == "allies" && players[i].sessionstate != "playing")
			players[i] thread braxi\_mod::spawnplayer();
			else if(players[i].ghost)
			{
			players[i] suicide();
			wait 0.1;
			players[i] thread braxi\_mod::spawnplayer();
			}
			}
	 		iprintln("^5Vistic^7 Admin: All Players have been respawned");
			}
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
	endmap=randomint(5);
	switch(endmap)
	{
		case 0:
			ambientplay("party_0");
			break;
		case 1:
			ambientplay("party_1");
			break;
		case 2:
			ambientplay("party_2");
			break;
		case 3:
			ambientplay("party_3");
			break;
		case 4:
			ambientplay("party_4");
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