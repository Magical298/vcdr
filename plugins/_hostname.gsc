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
	Website: vistic-clan.net

*/

init()
{
	setdvar("sv_hostname","^5VC' ^7DeathRun ^7| Version: ^51.32^7 | Round: ^5"+game["roundsplayed"]+"/"+level.dvar["round_limit"]+ "^7| Discord: ^^5discord.gg/JKwXV3h");
	wait 1;
	thread hostname();
}

hostname()
{
	while(1)
	{
		if(game["roundsplayed"]>level.dvar["round_limit"])
			setdvar("sv_hostname","^5VC' ^7DeathRun ^7| Version: ^51.32^7 | Round: ^5"+level.dvar["round_limit"]+"/"+level.dvar["round_limit"]+ "^7| Discord: ^5discord.gg/JKwXV3h");
		else 
			setdvar("sv_hostname","^5VC' ^7DeathRun ^7| Version: ^51.32^7 | Round: ^5"+game["roundsplayed"]+"/"+level.dvar["round_limit"]+ "^7| Discord: ^5discord.gg/JKwXV3h");
		wait 5;
	}
}