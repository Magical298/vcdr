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
#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

init()
{
	if(!isdefined(level.ghostrun))
		level.ghostrun=true;

	thread ghostMonitor();
	for(;;)
	{
		level waittill("connected",player);
			player thread onspawned();
	}
}

ghostMonitor()
{
	level waittill("round_started");

	if(!level.maphastimetrigger)
	{
		level.ghostrun=false;
		iprintln("^5Ghostrun^7: No ^5Endtrigger^7 found (^5disabled^7)");
	}
}

onspawned()
{
	for(;;)
	{
		level waittill("player_spawn",ghost);
		ghost thread watchGhost();
	}
}

watchGhost()
{
	self endon("disconnect");
	for(;;)
	{
		if(self.pers["team"] != "allies")
		{
			if(self.ghost)
			{
				self iprintlnbold("^1WARNING: REPORT THIS TO BLADE");
				self suicide();
				self.ghost=false;
			}
		}
		wait 3;
	}
}

ghostCheck()
{
	if(!level.ghostrun || issubstr(self.name,"bot"))
		return;

	self clearLowerMessage();
	self thread spawnGhost();
}
		
spawnGhost()
{
	if(game["state"]=="endmap")
		return;

	self.team=self.pers["team"];
	self.sessionteam=self.team;
	self.sessionstate="playing";
	self.spectatorclient=-1;
	self.killcamentity=-1;
	self.archivetime=0;
	self.psoffsettime=0;
	self.statusicon="hud_status_ghostp";

	self braxi\_teams::setplayermodel();

	spawnPoint=level.spawn[self.pers["team"]][randomInt(level.spawn[self.pers["team"]].size)];
	self spawn(spawnPoint.origin,spawnPoint.angles);

	self giveweapon("g36c_gl_mp");
	self setspawnweapon("g36c_gl_mp");
	self setviewmodel("viewmodel_hands_zombie");

	self braxi\_teams::sethealth();
	self braxi\_teams::setspeed();

	self notify("spawned_player");
	level notify("player_spawn",self);

	self.ghost=true;
	self hide();

	self braxi\_mod::afterfirstframe();
}