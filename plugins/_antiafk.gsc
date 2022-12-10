/*===================================================================||
||/|�������\///|��|/////|��|//|���������|//|���������|//\  \/////  //||
||/|  |//\  \//|  |/////|  |//|  |/////////|  |//////////\  \///  ///||
||/|  |///\  \/|  |/////|  |//|  |/////////|  |///////////\  \/  ////||
||/|  |///|  |/|  |/////|  |//|   _____|///|   _____|//////\    /////||
||/|  |////  //|  \/////|  |//|  |/////////|  |/////////////|  |/////||
||/|  |///  ////\  \////  ////|  |/////////|  |/////////////|  |/////||
||/|______ //////\_______/////|  |/////////|  |/////////////|  |/////||
||===================================================================*/
#include braxi\_mod;
#include braxi\_common;

init()
{
	thread playerSpawned();		
}

playerSpawned()
{
	while(1)
	{
		level waittill( "activator", player );
		player thread AFKCheck();
	}
}

AFKCheck()
{
	self endon( "disconnect" );
	self endon( "spawned_player" );
	self endon( "joined_spectators" );
	
	oldOrigin = self.origin - (0,0,5);
	
	wait 10;
	
	if( level.trapsDisabled )
		return;
	
	if( distance(oldOrigin, self.origin) <= 10 )
	{
		thread braxi\_mod::drawInformationSmall( 800, 0.8, 1, "Activator is AFK" );
		thread braxi\_mod::drawInformationSmall( 800, 0.8, -1, "Activator is AFK" );

		level braxi\_mod::disableTraps();
		players = getentarray("player", "classname");
		for(i=0;i<players.size;i++)
		{
			if( players[i] braxi\_common::isPlaying() )
			{
				players[i] takeAllWeapons();

				players[i] giveweapon(players[i].pers["knife"]);
				players[i] switchtoweapon(players[i].pers["knife"]);
			}
		}
		level notify( "round_freerun" );
	}
}