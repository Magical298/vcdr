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

indicate_mvp()
{
	precachemenu("vistic_mvp");
	
	recordHolder = level.bestScores[0]["player"];
	recordGuid = level.bestScores[0]["guid"];
	scoreValue = level.bestScores[0]["value"];
	recordModel = level.bestScores[0]["model"];

	mvp = findbestplayer();
	if(isdefined(mvp) && isdefined(mvp.pers["score"]) && mvp.pers["score"] > scoreValue)
	{
		dr_mvp = mvp maps\mp\gametypes\_persistence::statGet( "DR_MVP" );
        mvp maps\mp\gametypes\_persistence::statSet( "DR_MVP", dr_mvp+1 );

		level.bestScores[0]["player"] = mvp.name;
		level.bestScores[0]["guid"] = mvp getguid();
		level.bestScores[0]["value"] = mvp.pers["score"];
		level.bestScores[0]["model"] = level.characterInfo[mvp getstat(980)]["model"];

		wait .05;
		thread show_character("^7Most valuable Player", mvp.name, mvp.pers["score"], mvp.pers["kills"], level.characterInfo[mvp getstat(980)]["model"]);
	}
}

findbestplayer()
{
	score = 0;

	found = undefined;

	players = getentarray("player","classname");
	for(i=0;i<players.size;i++)
	{
		if(!isdefined(players[i].pers["isBot"]) || isdefined(players[i].pers["isBot"]) && !players[i].pers["isBot"])
		{
			if(players[i].pers["score"] >= score)
			{
				score = players[i].pers["score"];
				found = players[i];
			}
		}
	}
	return found;

}

show_character(header,text,score,kills,model)
{
	mostvaluableBot = addTestClient();
	mostvaluableBot.pers["isBot"] = true;
	mostvaluableBot.guid = 1337;
	mostvaluableBot thread spawnMVB(model);

	wait .5;

	players = getentarray("player","classname");
	for(i=0;i<players.size;i++)
	{
		if(!isdefined(players[i].pers["isBot"]) || isdefined(players[i].pers["isBot"]) && !players[i].pers["isBot"])
		{
			players[i] closeingamemenu();
			players[i] closemenu();

			wait .05;

			players[i] openmenu("vistic_mvp");

			players[i] setclientdvars("vcmvp_header",header,
										"vcmvp_player",text,
										"vcmvp_score",score,
										"vcmvp_kills",kills);


			real_location = (level.spawn["axis"][0].origin + (80,0,15)); // - (-80,0,15)
			real_angles = (0,(level.spawn["axis"][0].angles[1] + 180),0);

			wait .05;
		}
	}

	wait 10;

	mostvaluableBot hide();

	if(isdefined(level.mvpFx))
		level.mvpFx delete();

	for(i=0;i<players.size;i++)
	{
		if(!isdefined(players[i].pers["isBot"]) || isdefined(players[i].pers["isBot"]) && !players[i].pers["isBot"])
		{
			players[i] closeingamemenu();
			players[i] closemenu();

			wait .05;
		}
	}

	wait 2.2;
}

spawnMVB(model)
{
	while(!isdefined(self.pers["team"]))
        wait .05;
        
    self notify("menuresponse", game["menu_team"], "autoassign");
    wait 0.5;

	level notify( "jumper", self );

	self.team = self.pers["team"];
	self.sessionteam = self.team;
	self.sessionstate = "playing";
	self.spectatorclient = -1;
	self.killcamentity = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
	self.statusicon = "";

	self setModel(model);
	self spawn( level.spawn["axis"][0].origin,level.spawn["axis"][0].angles);

	level.mvpFx = spawnfx(level.fx["vc_mvp"],self.origin);
	triggerfx(level.mvpFx);


	self.pers["weapon"] = "deserteagle_mp";

	self giveweapon(self.pers["weapon"]);
	self setspawnweapon(self.pers["weapon"]);

	self setviewmodel("viewmodel_hands_zombie");

	self thread braxi\_teams::setHealth();
	self thread braxi\_teams::setSpeed();

	self notify( "spawned_player" );
	level notify( "player_spawn", self );
}