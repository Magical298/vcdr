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

	Vistic Clan ©
*/

main()
{

	// === Blade's Plugins
	LoadPlugin( plugins\_clients::init, "Client Scripts", "Blade" );
	LoadPlugin( plugins\_rtd::init, "RTD", "Blade" );
	LoadPlugin( plugins\_autospawn::init, "Auto-respawn", "Blade" );
	LoadPlugin( plugins\_hostname::init, "Dynamic Hostname", "Blade" );

	// === Rycoon's Plugins
	LoadPlugin( plugins\_killcam::init, "Killcam", "Rycoon" );
	LoadPlugin( plugins\_efr::init, "Endless Freerun", "Rycoon" );
	LoadPlugin( plugins\_antiafk::init, "Anti AFK", "Rycoon" );

	// === DuffMan's Plugins
	LoadPlugin( plugins\_fixes::init, "Mismatch Fix", "DuffMan" );

	// === Legend's Plugins
	LoadPlugin( plugins\_queue::init, "Turn Definition", "Legend" );
	LoadPlugin( plugins\_spectating::init, "WASD Space", "Legend" );

	//LoadPlugin( plugins\triggerspawner::init, "Trigger SHIt", "braxi");
	//LoadPlugin( plugins\_pickup::init, "Player pick up", "idk");

	// === Map Fixes
	if(getDvar("mapname") != "mp_deathrun_qube")
		setDvar("g_knockback",1000);
	if(getDvar("mapname") != "mp_deathrun_sick" || getdvar("mapname") != "mp_dr_wealth" || getdvar("mapname") != "mp_vc_glen")
	{
		setDvar("g_speed",210);
		setDvar( "dr_jumpers_speed", "1.1" );
		setDvar( "dr_activators_speed", "1.1" );
	}
}

// ===== DO NOT EDIT ANYTHING UNDER THIS LINE ===== //
LoadPlugin( pluginScript, name, author )
{
	thread [[ pluginScript ]]();
	println( "" + name + " ^7plugin created by " + author + "\n" );
}