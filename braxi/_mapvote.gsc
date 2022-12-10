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
#include blade\_strings;

init()
{
	//precachemenu(game["menu_mapvote"]);

	if(!isdefined(level.vc_mapvoting))
		level.vc_mapvoting = [];

	if(!isdefined(level.vc_mapvotes))
		level.vc_mapvotes = [];
}

//===================================================
// ### Vote Logic
startMapVote()
{
	rotation = strtok(getdvar("sv_maprotation")," ");
	level.drRotationMaps = [];

	for(i=0;i<rotation.size;i++)
	{
		if(rotation[i] != "map")
			level.drRotationMaps[level.drRotationMaps.size] = rotation[i];
	}

	if(int(level.drRotationMaps.size) < 1)
	{
		iprintlnbold("sv_maprotation contains not enough maps");
		return;
	}

	used = "";
	for(i=1;i<6;i++)
	{
		selected = "";
		mapChoosing = false;

		while(!mapChoosing)
		{
			selected = level.drRotationMaps[randomint(level.drRotationMaps.size)];
			if(!issubstr(used, selected) && getdvar("mapname") != selected)
			{
				if(getdvar("last_map1") != selected || getdvar("last_map2") != selected || getdvar("last_map3") != selected || getdvar("last_map4") != selected)
				{
					used += selected;
					mapChoosing = true;
				}
			}
			wait .05;
		}

		if(mapChoosing)
		{
			level.vc_mapvoting[i] = selected;
			level.vc_mapvotes[i] = 0;
		}
		wait .05;
	}

	level.vc_mapvoting[6] = makerandommap();
	level.vc_mapvotes[6] = 0;

	wait 1;

	level.voterunning = true;
	level thread votetimer(level.dvar["mapvote_time"]);

	level.players=getentarray("player","classname");

	if(!level.players.size)
	{
		level.vc_mapvotes[6] = 1;
		return;
	}


	for(i=0;i<level.players.size;i++)
	{
		level.players[i] setclientdvars("vc_votemap1",getMapNameString(level.vc_mapvoting[1]),
										"vc_votemap2",getMapNameString(level.vc_mapvoting[2]),
										"vc_votemap3",getMapNameString(level.vc_mapvoting[3]),
										"vc_votemap4",getMapNameString(level.vc_mapvoting[4]),
										"vc_votemap5",getMapNameString(level.vc_mapvoting[5]));

		level.players[i] thread updateVotes();
		level.players[i] thread enableVotes();

		level.players[i].lastvoted = 0;

		if(level.players[i].sessionstate != "playing")
			level.players[i] notify("menuresponse", game["menu_team"], "autoassign");
		wait 0.05;

		if(!isdefined(level.players[i].pers["isBot"]) || isdefined(level.players[i].pers["isBot"]) && !level.players[i].pers["isBot"] )
			level.players[i] openMenu(game["menu_mapvote"]);
	}
}

makerandommap()
{
	rmap = "";
	randommap=false;
	while(!randommap)
	{
		selected = level.drRotationMaps[randomint(level.drRotationMaps.size)];
		if(getdvar("mapname") != selected || level.vc_mapvoting[1] != selected || level.vc_mapvoting[2] != selected || level.vc_mapvoting[3] != selected || level.vc_mapvoting[4] != selected || level.vc_mapvoting[5] != selected)
		{
			if(getdvar("last_map1") != selected || getdvar("last_map2") != selected || getdvar("last_map3") != selected || getdvar("last_map4") != selected)
			{
				rmap = selected;
				randommap=true;
			}
		}
		wait .05;
	}

	return rmap;
}

votetimer(time)
{
	if(!isdefined(time))
		time = 20;

	level.vc_votetimer = time;

	wait 1;

	while(level.voterunning && level.vc_votetimer > 0)
	{
		level.vc_votetimer -= 1;
		wait 1;
	}

	level.voterunning = false;
	wait 1;

	level notify("mapvote_over");
}

updateVotes()
{
	self endon("disconnect");

	while(level.voterunning && level.vc_votetimer > 0)
	{
		if(isdefined(self))
		{
			self setclientdvars("vc_vote1",level.vc_mapvotes[1],
							"vc_vote2",level.vc_mapvotes[2],
							"vc_vote3",level.vc_mapvotes[3],
							"vc_vote4",level.vc_mapvotes[4],
							"vc_vote5",level.vc_mapvotes[5],
							"vc_vote6",level.vc_mapvotes[6],
							"vote_timer",level.vc_votetimer);
		}
		wait .2;
	}

	self closemenu();
	self closeingamemenu();
}

enableVotes()
{
	self endon("disconnect");
	
	if(!isdefined(self))
		return;

	self closemenu();
	self closeingamemenu();

	while(level.voterunning && level.vc_votetimer > 0)
	{
		self waittill("menuresponse",menu,response);

		if(!isdefined(menu) || !isdefined(response))
		{
			println("Menu or Response missing!");
			continue;
		}

		if(menu == game["menu_mapvote"])
		{
			if(response == "mapvote_01")
			{
				if(self.lastvoted == 0)
				{
					level.vc_mapvotes[1] += 1;
					self.lastvoted = 1;
				}
				else 
				{
					if(self.lastvoted != 1)
					{
						level.vc_mapvotes[self.lastvoted] -= 1;
						level.vc_mapvotes[1] += 1;

						self.lastvoted = 1;
					}
				}
			}
			else if(response == "mapvote_02")
			{
				if(self.lastvoted == 0)
				{
					level.vc_mapvotes[2] += 1;
					self.lastvoted = 2;
				}
				else 
				{
					if(self.lastvoted != 2)
					{
						level.vc_mapvotes[self.lastvoted] -= 1;
						level.vc_mapvotes[2] += 1;

						self.lastvoted = 2;
					}
				}
			}
			else if(response == "mapvote_03")
			{
				if(self.lastvoted == 0)
				{
					level.vc_mapvotes[3] += 1;
					self.lastvoted = 3;
				}
				else 
				{
					if(self.lastvoted != 3)
					{
						level.vc_mapvotes[self.lastvoted] -= 1;
						level.vc_mapvotes[3] += 1;

						self.lastvoted = 3;
					}
				}
			}
			else if(response == "mapvote_04")
			{
				if(self.lastvoted == 0)
				{
					level.vc_mapvotes[4] += 1;
					self.lastvoted = 4;
				}
				else 
				{
					if(self.lastvoted != 4)
					{
						level.vc_mapvotes[self.lastvoted] -= 1;
						level.vc_mapvotes[4] += 1;

						self.lastvoted = 4;
					}
				}
			}
			else if(response == "mapvote_05")
			{
				if(self.lastvoted == 0)
				{
					level.vc_mapvotes[5] += 1;
					self.lastvoted = 5;
				}
				else 
				{
					if(self.lastvoted != 5)
					{
						level.vc_mapvotes[self.lastvoted] -= 1;
						level.vc_mapvotes[5] += 1;

						self.lastvoted = 5;
					}
				}
			}
			else if(response == "mapvote_06")
			{
				if(self.lastvoted == 0)
				{
					level.vc_mapvotes[6] += 1;
					self.lastvoted = 6;
				}
				else 
				{
					if(self.lastvoted != 6)
					{
						level.vc_mapvotes[self.lastvoted] -= 1;
						level.vc_mapvotes[6] += 1;

						self.lastvoted = 6;
					}
				}
			}
		}
	}
}

getMostVotedForMap()
{
	winner = 0;
	found = undefined;

	for(i=1; i<7; i++)
	{
		if(level.vc_mapvotes[i] >= winner)
		{
			winner = level.vc_mapvotes[i];
			found = level.vc_mapvoting[i];
		}
	}

	wait .5;

	last_map = getdvar("mapname");
	if(getdvarint("last_maplimit") == 0)
	{
		setdvar("last_map1",last_map);
		setdvar("last_maplimit",1);
	}
	else if(getdvarint("last_maplimit") == 1)
	{
		setdvar("last_map2",last_map);
		setdvar("last_maplimit",2);
	}
	else if(getdvarint("last_maplimit") == 2)
	{
		setdvar("last_map3",last_map);
		setdvar("last_maplimit",3);
	}
	else if(getdvarint("last_maplimit") == 4)
	{
		setdvar("last_map4",last_map);
		setdvar("last_maplimit",0);
	}
	wait .5;

	return found;
}

changemap(map)
{
	setdvar("sv_maprotationcurrent","gametype deathrun map "+map);
	exitlevel(false);
}

//===================================================
// ### Client Dvaring
clientDvar(dvar,varname)
{
	for(i=0;i<level.players.size;i++)
		level.players[i] setclientdvar(dvar,varname);
}