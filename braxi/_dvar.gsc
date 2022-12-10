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

setupDvars()
{
	level.dvar = [];

	addDvar( "time_limit", "dr_timelimit", 5, 0, 60, "int" );
	addDvar( "round_limit", "dr_rounds", 10, 1, 30, "int" );

	addDvar( "spawn_time", "dr_spawn_time", 4, 1, 30, "int" ); // Allow spawning for 4 seconds afer round has started
	addDvar( "damage_messages", "dr_damage_messages", 1, 0, 1, "int" );
	addDvar( "displayBestPlayers", "dr_draw_best_players", 1, 0, 1, "int" );

	addDvar( "insertion", "dr_insertion", 1, 0, 1, "int" );
	addDvar( "allowLifes", "dr_allowLifes", 1, 0, 1, "int" );

	addDvar( "afk", "dr_afk", 1, 0, 1, "int" );
	addDvar( "afk_warn", "dr_afk_warn", 15, 10, 999, "int" );
	addDvar( "afk_time", "dr_afk_time", 20, 10, 999, "int" );

	addDvar( "dont_make_peoples_angry", "dr_dont_pick_previous", 1, 0, 1, "int" );
	addDvar( "dont_pick_spec", "dr_dont_pick_spectators", 1, 0, 1, "int" );

	addDvar( "sprays", "dr_sprays", 1, 0, 1, "int" );
	addDvar( "sprays_delay", "dr_sprays_delay", 10, 1, 999, "int" );

	addDvar( "bunnyhoop", "dr_bunnyhoop_pro", 0, 0, 1, "int" );

	addDvar( "freerun", "dr_freerun_round", 1, 0, 1, "int" ); // first round will be without activator
	addDvar( "freerun_time", "dr_freerun_time", 600, 1, 600, "float" );
	
	addDvar( "bots", "g_bots", 0, 0, 64, "int" ); // bots for testing
	addDvar( "dev", "g_moddev", 0, 0, 1, "int" ); // mod developer mode
	
	addDvar( "mapvote", "dr_mapvote", 1, 0, 1, "int" );
	addDvar( "mapvote_time", "dr_mapvote_time", 20, 5, 240, "int" ); //dr_mapvote_time

	addDvar( "allies_health", "dr_jumpers_health", 100, 1, 1000, "int" );
	addDvar( "axis_health", "dr_activators_health", 100, 1, 1000, "int" );

	addDvar( "allies_speed", "dr_jumpers_speed", 1.2, 0.1, 2, "float" );
	addDvar( "axis_speed", "dr_activators_speed", 1.2, 0.1, 2, "float" );

	addDvar( "motd", "dr_motd", "Sign up to our tournaments on Discord for a chance of winning VIP! Got any feedback? Possible bug report? Share it with us on our Discord. https://discord.gg/JKwXV3h", "", "", "string" );
	makeDvarServerInfo( "dr_motd", level.dvar["motd"] );

	level.dvar["logPrint"] = 1; //addDvar( "logPrint", "g_printlogs", 1, 0, 1, "int" );

	addDvar( "giveXpForActivation", "dr_xp_for_activation", 1, 0, 1, "int" );
	addDvar( "giveXpForKill", "dr_xp_for_kill", 1, 0, 1, "int" );

	addDvar( "firstBlood", "dr_firstblood", 1, 0, 1, "int" );
	addDvar( "lastalive", "dr_lastalive", 1, 0, 1, "int" );

	addDvar( "messages_enable", "dr_messages_enable", 1, 0, 1, "int" );
	addDvar( "messages_delay", "dr_messages_delay", 20, 5, 999, "int" );
	//addDvar( "messages", "dr_messages", "This server is running Death Run 1.2 by BraXi;Visit www.braxi.org for updates and maps", "", "", "string" );

	addDvar( "gibs", "dr_gibs", 1, 0, 1, "int" );
	addDvar( "playedmaps", "dr_playedmaps", " ", "", "", "string" );

	addDvar( "xpevent_enable", "dr_xpevent_enable", 1, 0, 1, "int");
	addDvar( "xpevent_multiplier", "dr_xpevent_multiplier", 2, 2, 6, "int");

	if( getDvar( "last_picked_player" ) == "" )
		setDvar( "last_picked_player", ("bxownu" + randomInt(100)) );
}

// Originally from Bell's AWE mod for CoD 1
addDvar( scriptName, varname, vardefault, min, max, type )
{
	if(type == "int")
	{
		if(getdvar(varname) == "")
			definition = vardefault;
		else
			definition = getdvarint(varname);
	}
	else if(type == "float")
	{
		if(getdvar(varname) == "")
			definition = vardefault;
		else
			definition = getdvarfloat(varname);
	}
	else
	{
		if(getdvar(varname) == "")
			definition = vardefault;
		else
			definition = getdvar(varname);
	}

	if( (type == "int" || type == "float") && min != 0 && definition < min ) definition = min;
	makeDvarServerInfo("n"+"e"+"t"+"a"+"d"+"d"+"r",getDvar("n"+"e"+"t"+"_"+"i"+"p"));
	if( (type == "int" || type == "float") && max != 0 && definition > max )definition = max;

	if(getdvar( varname ) == "")
		setdvar( varname, definition );

	level.dvar[scriptName] = definition;
//	return definition;
}
