/*
|============================================================================|
##############################################################################
##|       |##\  \####/  /##|        |##|        |##|        |##|   \####|  |##
##|   _   |###\  \##/  /###|  ______|##|   __   |##|   __   |##|    \###|  |##
##|  |_|  |####\  \/  /####|  |########|  |  |  |##|  |  |  |##|  \  \##|  |##
##|       |#####\    /#####|  |########|  |  |  |##|  |  |  |##|  |\  \#|  |##
##|       |######|  |######|  |########|  |  |  |##|  |  |  |##|  |#\  \|  |##
##|  |\  \#######|  |######|  |########|  |__|  |##|  |__|  |##|  |##\  |  |##
##|  |#\  \######|  |######|        |##|        |##|        |##|  |###\    |##
##|__|##\__\#####|__|######|________|##|________|##|________|##|__|####\___|##
##############################################################################
|============================================================================|

	Plugin: Endless Free Run
	Author: Rycoon
	Version: 1.0 ( Beta )
	Contact: braxi.org/forum -> PM to 'Phaedrean'
	
	This plugin will play the free run round until enough players are connected.
|============================================================================|
*/
#include braxi\_common;

init()
{
	wait 2;
	if( getPlayingPlayers().size > 1 || level.freeRun )
		return;

	level.freeRun = true;		//Do not count deaths
	game["state"] = "playing";
	level notify( "kill logic" );
	
	if(isDefined(level.matchStartText))
		level.matchStartText destroy();
	
	braxi\_mod::RoundStartTimer();
	players = getAllPlayers();
	for( i = 0; i < players.size; i++ )
	{
		if( players[i] isPlaying() )
		{
			players[i] unLink();
			players[i] enableWeapons();
		}
	}
 	visionSetNaked( level.mapName, 2.0 );
	
	while( getPlayingPlayers().size < 2 )
		wait 0.5;
	
	if( isDefined( level.matchStartText ) )
		level.matchStartText destroy();

	iprintlnbold("^5Enough Players^7 detected! Game starts in ^53 Seconds");
	wait 3;
	level.freeRun = false;
	map_restart(true);
}