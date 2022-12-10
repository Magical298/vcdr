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

init(modversion)
{
	level waittill("round_started");
	wait 1;
	thread preventacti();
}

preventacti()
{
	player = getEntArray("player","classname");

	if(customSpawnArea())
	{
		while(isdefined(endTrigger))
		{
			getEntArray( "endmap_trig", "targetname" )[0] waittill("trigger",who);

			if(who.pers["team"] == "axis")
			{
				iprintlnbold("^1Activator Tried To Leave Their Area\nBack To Activator Spawn!");
				who setorigin(level.spawn["axis"][randomint(self.pers["team"].size)].origin);
			}
			wait .05;
		}
	}
	else 
	{
		while(game["state"] == "playing")
		{
			if( distance(player.origin, level.area_coord) < 512 && player.pers["team"] == "axis")
			{
				iprintlnbold("^1Activator Tried To Leave Their Area\nBack To Activator Spawn!");
				who setorigin(level.spawn["axis"][randomint(self.pers["team"].size)].origin);
			}
			wait 1;
		}
	}
}

customSpawnArea()
{
	level.area_coord = (0,0,0);

	switch(level.mapName)
	{
		case "mp_deathrun_unreal":
			return true;

		default:
			return false;
	}
}