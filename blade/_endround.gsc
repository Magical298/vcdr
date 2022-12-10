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
	ambientstop();
	musicstop();

	endround = self plugins\_clients::get_drstat("DR_GENRE");
	switch(endround)
	{
		case 0:
			self playlocalsound("de_endround_"+(game["roundsplayed"]-1));
			break;
		case 1:
			self playlocalsound("og_endround_"+(game["roundsplayed"]-1));
			break;
		case 2:
			self playlocalsound("hs_endround_"+(game["roundsplayed"]-1));
			break;
		case 3:
			self playlocalsound("db_endround_"+(game["roundsplayed"]-1));
			break;
		case 4:
			self playlocalsound("hc_endround_"+(game["roundsplayed"]-1));
			break;
	}
}

end_map()
{
	ambientstop();
	musicstop();

	endmap = self plugins\_clients::get_drstat("DR_GENRE");
	switch(endmap)
	{
		case 0:
			self playlocalsound("de_endmap");
			break;
		case 1:
			self playlocalsound("og_endmap");
			break;
		case 2:
			self playlocalsound("hs_endmap");
			break;
		case 3:
			self playlocalsound("db_endmap");
			break;
		case 4:
			self playlocalsound("hc_endmap");
			break;
	}
}

getFinalRound()
{
	wait .05;

	if(game["roundsplayed"]>=level.dvar["round_limit"])
		level thread braxi\_common::playSoundOnAllPlayers("final_round");
}