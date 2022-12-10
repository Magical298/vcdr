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
#include braxi\_common;

init()
{
	level waittill("round_started");
	level thread antiglitch();
}

antiglitch()
{
	glitch_positions = [];

	switch(level.mapName)
	{
		case "mp_deathrun_city":
			glitch_positions[glitch_positions.size] = (689,3051,11);

			for(i=0; i<glitch_positions.size; i++)
				thread map_glitchsystem(glitch_positions[i],30);

			iprintln("^9Anti-Glitch v2.14^7 running on ^8"+getMapNameString(level.mapName));
			break;

		case "mp_dr_skypower":
    		glitch_positions[glitch_positions.size] = (1103, -1775, -649);
    		glitch_positions[glitch_positions.size] = (1103, -1375, -649);
    		glitch_positions[glitch_positions.size] = (1103, -1075, -649);
    		glitch_positions[glitch_positions.size] = (1103, -775, -649);
    		glitch_positions[glitch_positions.size] = (1103, -475, -649);
    		glitch_positions[glitch_positions.size] = (1365.08, -961.527, -678.092);

			for(i=0; i<glitch_positions.size; i++)
				thread map_glitchsystem(glitch_positions[i],200);

			iprintln("^9Anti-Glitch v2.14^7 running on ^8"+getMapNameString(level.mapName));
			break;

		case "mp_deathrun_framey_v2":
			glitch_positions[glitch_positions.size] = (2802,-467,633);	
			glitch_positions[glitch_positions.size] = (2174,1450,700);
			glitch_positions[glitch_positions.size] = (2174,1300,700);
			
			for(i=0; i<glitch_positions.size; i++)
				thread map_glitchsystem(glitch_positions[i],200);

			iprintln("^9Anti-Glitch v2.14^7 running on ^8"+getMapNameString(level.mapName));
			break;

		case "mp_dr_darmuhv2":
			glitch_positions[glitch_positions.size] = (2022,0,-700);
			
			for(i=0; i<glitch_positions.size; i++)
				thread map_glitchsystem(glitch_positions[i],200);

			iprintln("^9Anti-Glitch v2.14^7 running on ^8"+getMapNameString(level.mapName));
			break;

		case "mp_deathrun_wipeout_v2":
			glitch_positions[glitch_positions.size] = (2680,3744,97);
			glitch_positions[glitch_positions.size] = (2680,3400,97);
			glitch_positions[glitch_positions.size] = (2680,4000,97);
			glitch_positions[glitch_positions.size] = (2941,3744,97);
			glitch_positions[glitch_positions.size] = (2941,3400,97);
			glitch_positions[glitch_positions.size] = (2941,4000,97);
			
			for(i=0; i<glitch_positions.size; i++)
				thread map_glitchsystem(glitch_positions[i],200);

			iprintln("^9Anti-Glitch v2.14^7 running on ^8"+getMapNameString(level.mapName));
			break;

		case "mp_deathrun_saw":
			glitch_positions[glitch_positions.size] = (-289,-1175,381);
			
			for(i=0; i<glitch_positions.size; i++)
				thread map_glitchsystem(glitch_positions[i],100);

			iprintln("^9Anti-Glitch v2.14^7 running on ^8"+getMapNameString(level.mapName));
			break;

		case "mp_deathrun_mine":
			glitch_positions[glitch_positions.size] = (167,789,450);
			glitch_positions[glitch_positions.size] = (167,603,450);
			
			for(i=0; i<glitch_positions.size; i++)
				thread map_glitchsystem(glitch_positions[i],200);

			iprintln("^9Anti-Glitch v2.14^7 running on ^8"+getMapNameString(level.mapName));
			break;

		case "mp_dr_bananaphone_v2":
			glitch_positions[glitch_positions.size] = (2249,1570,345);
			glitch_positions[glitch_positions.size] = (2249,1490,345);
			glitch_positions[glitch_positions.size] = (2249,1410,345);
			glitch_positions[glitch_positions.size] = (2249,1330,345);
			
			for(i=0; i<glitch_positions.size; i++)
				thread map_glitchsystem(glitch_positions[i],50);

			iprintln("^9Anti-Glitch v2.14^7 running on ^8"+getMapNameString(level.mapName));
			break;

		case "mp_dr_indipyramid":
			glitch_positions[glitch_positions.size] = (-1440,-361,-100);
			
			for(i=0; i<glitch_positions.size; i++)
				thread map_glitchsystem(glitch_positions[i],120);

			iprintln("^9Anti-Glitch v2.14^7 running on ^8"+getMapNameString(level.mapName));
			break;

		case "mp_deathrun_wipeout":
			glitch_positions[glitch_positions.size] = (1938,1922,227);
			
			for(i=0; i<glitch_positions.size; i++)
				thread map_glitchsystem(glitch_positions[i],200);

			iprintln("^9Anti-Glitch v2.14^7 running on ^8"+getMapNameString(level.mapName));
			break;

		case "mp_deathrun_backlot":
			glitch_positions[glitch_positions.size] = (1040,-1159,396);
			glitch_positions[glitch_positions.size] = (682,-1315,183);

			for(i=0; i<glitch_positions.size; i++)
				thread map_glitchsystem(glitch_positions[i],115);

			iprintln("^9Anti-Glitch v2.14^7 running on ^8"+getMapNameString(level.mapName));
			break;

		case "mp_deathrun_godfather":
			glitch_positions[glitch_positions.size] = (693, 871, 585);
			
			for(i=0; i<glitch_positions.size; i++)
				thread map_glitchsystem(glitch_positions[i],120);

			iprintln("^9Anti-Glitch v2.14^7 running on ^8"+getMapNameString(level.mapName));
			break;

		case "mp_dr_stronghold":
			glitch_positions[glitch_positions.size] = (-440,-1030,88);
			
			for(i=0; i<glitch_positions.size; i++)
				thread map_glitchsystem(glitch_positions[i],200);

			iprintln("^9Anti-Glitch v2.14^7 running on ^8"+getMapNameString(level.mapName));
			break;

		case "mp_dr_watercity":
			glitch_positions[glitch_positions.size] = (877,1255,420);
			
			for(i=0; i<glitch_positions.size; i++)
				thread map_glitchsystem(glitch_positions[i],130);

			iprintln("^9Anti-Glitch v2.14^7 running on ^8"+getMapNameString(level.mapName));
			break;

		case "mp_deathrun_mirroredge":
			glitch_positions[glitch_positions.size] = ( -5633, 294, -2241);
			
			for(i=0; i<glitch_positions.size; i++)
				thread map_glitchsystem(glitch_positions[i],130);

			iprintln("^9Anti-Glitch v2.14^7 running on ^8"+getMapNameString(level.mapName));
			break;
		case "mp_dr_blue":
			glitch_positions[glitch_positions.size] = (4423,-1075,-824);
			glitch_positions[glitch_positions.size] = (10699,2477,-1267);
			
			for(i=0; i<glitch_positions.size; i++)
				thread map_glitchsystem(glitch_positions[i],350);

			iprintln("^9Anti-Glitch v2.14^7 running on ^8"+getMapNameString(level.mapName));
			break;

		case "mp_dr_apocalypse_v2":
			glitch_positions[glitch_positions.size] = (511,2859,594);
			glitch_positions[glitch_positions.size] = (511,3136,594);
			
			for(i=0; i<glitch_positions.size; i++)
				thread map_glitchsystem(glitch_positions[i],100);

			iprintln("^9Anti-Glitch v2.14^7 running on ^8"+getMapNameString(level.mapName));
			break;

		case "mp_deathrun_supermario":
			glitch_positions[glitch_positions.size] = (-160,200,530);
			glitch_positions[glitch_positions.size] = (240,-1210,260);
			
			for(i=0; i<glitch_positions.size; i++)
				thread map_glitchsystem(glitch_positions[i],250);

			iprintln("^9Anti-Glitch v2.14^7 running on ^8"+getMapNameString(level.mapName));
			break;

		case "mp_dr_something":
			glitch_positions[glitch_positions.size] = (3224.74, -393.404, -474.274);
			glitch_positions[glitch_positions.size] = (3225.82, -715.71, -335.875);
			
			for(i=0; i<glitch_positions.size; i++)
				thread map_glitchsystem(glitch_positions[i],30);

			iprintln("^9Anti-Glitch v2.14^7 running on ^8"+getMapNameString(level.mapName));
			break;

        case "mp_deathrun_cookie":
            glitch_positions[glitch_positions.size] = (-150, 879, 22);
            
			for(i=0; i<glitch_positions.size; i++)
				thread map_glitchsystem(glitch_positions[i],30);

			iprintln("^9Anti-Glitch v2.14^7 running on ^8"+getMapNameString(level.mapName));
            break;

        case "mp_dr_bouncev2":
			level.callbackPlayerDamage = ::Callback_PlayerDamage;
        	glitch_positions[glitch_positions.size] = (4134, 256, 218);
        	
            for(i=0; i<glitch_positions.size; i++)
				thread map_glitchsystem(glitch_positions[i],130);

			iprintln("^9Anti-Glitch v2.14^7 running on ^8"+getMapNameString(level.mapName));
            break;

		case "mp_dr_sm_world":
		case "mp_dr_up":
		case "mp_deathrun_glass":
		case "mp_dr_glass2":
		case "mp_dr_glass3":
		case "mp_dr_terror":
		case "mp_dr_trikx":
		case "mp_dr_h2o":
		case "mp_deathrun_diehard":
		case "mp_dr_free":
		case "mp_deathrun_horror":
		case "mp_dr_jump_hard":
		case "mp_deathrun_bricky":
		case "mp_dr_deadzone":
		case "mp_dr_underground":
			level.callbackPlayerDamage = ::Callback_PlayerDamage;
			iprintln("^9Anti-Glitch v2.14^7 running on ^8"+getMapNameString(level.mapName));
			break;

		case "mp_deathrun_ruin":
			iprintln("^9Anti-Glitch v2.14^7 running on ^8"+getMapNameString(level.mapName));
			break;

		default: 
			glitch_positions = undefined;
			break;
	}
}

map_glitchsystem(pos,dis)
{
	while(1)
	{
		players = getentarray("player","classname");
		for(i=0;i<players.size;i++)
		{
			if( players[i].pers["team"] == "allies" && distance(players[i].origin , pos ) <= dis && isAlive(players[i]) )
			{
				if(!isDefined(players[i].iscaught))
					players[i].iscaught = false;

				if(!players[i].iscaught)
					players[i] thread punish();
			}
		}
		wait 0.01;
	}
}

punish()
{
	self.iscaught=true;
	self freezecontrols(1);
	wait 1;
	self.iscaught=false;
	self suicide();


	iprintln("^9Anti-Glitch v2.14^7: ^8"+self.name+"^7 was caught glitching.");
}

// ====================================================
// ### Vikings Anti Wallbang

Callback_PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime)
{
	if(isDefined(eAttacker) && isPlayer(eAttacker))
	{
		if(!SightTracePassed( eAttacker Geteye(), self.origin + (0, 0, getHitLocHeight(sHitloc)), false, undefined))
			return;
	}
	
	self braxi\_mod::PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime);
}