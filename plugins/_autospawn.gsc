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

	Plugin by VC' Blade ©
	Version: 1.0
	Website: vistic-clan.com
*/
#include braxi\_common;
#include blade\_strings;

init(vers)
{
	if(!isdefined(vers))
		wait 0.1;
		
	// ======= Setup ======= //
	level.spawningTimeLeft = 180;
	level.spawningTimer = true;

	thread watch_autospawn();
}

watch_autospawn()
{
	level endon("round_ended");
	level endon("game over");

	level waittill("round_started");

	if(level.freerun || getdvar("mapname") == "mp_vc_crpyt" || getdvar("mapname") == "mp_deathrun_highrise" || getdvar("mapname") == "mp_dr_twitch")
		return;

	count = 0;

	while(game["state"] == "playing" && level.spawningTimer)
	{
		iprintln("^5Spawn Timer^7: Spawning will be disabled in ^5"+(3 - count)+" Minutes");
		wait (level.spawningTimeLeft/3);
		count += 1;

		if(count == 3)
		{
			iprintln("^5Spawn Timer^7: Spawning is disabled");
			level.spawningTimer = false;
			break;
		}
	}
}