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

init()
{
	setdvar("g_TeamName_Allies", "^8Jumpers");
	setdvar("g_TeamIcon_Allies", "killiconfalling");
	setDvar( "g_TeamColor_Allies", "0 0.84 1" );
	setDvar( "g_ScoresColor_Allies", "0 0.84 1" );

	setdvar("g_TeamName_Axis", "^9Activator");
	setdvar("g_TeamIcon_Axis", "killiconsuicide");
	setDvar( "g_TeamColor_Axis", "0 1 0.68" );
	setDvar( "g_ScoresColor_Axis", "0 1 0.68" );

	setDvar( "g_ScoresColor_Spectator", ".55 .55 .55" );
	setDvar( "g_ScoresColor_Free", ".55 .55 .55" );
	setDvar( "g_teamColor_MyTeam", "0 0.84 1" );
	setDvar( "g_teamColor_EnemyTeam", "0 1 0.68" );
}

showBestStats()
{	

}

playerdrops()
{
	self.drop_item = addTextHud( self, 0, 180/2-8, 1, "center", "top", "center", "middle", 1.6, 101 );
	self.drop_item.glowalpha=1;
	self.drop_item.glowcolor=level.randomcolor;
	self.drop_item thread fadeIn(.3);
	self.drop_item.label= &"You got ^5";

	self thread blade\_drop::randomDrop();
}

destroyHudAfterTime( time )
{
	self fadeOverTime( time );
	self.alpha = 0;
	wait time;
	self destroy();
}

showHud( hud, X, alpha, movetime, fadetime )
{
	hud moveOverTime( movetime );
	hud.x = x;

	hud fadeOverTime( fadetime );
	hud.alpha = alpha;
}

addIconHud( who, x, y, alpha, shader, scalex, scaley )
{
	if( isPlayer( who ) )
		hud = newClientHudElem( who );
	else
		hud = newHudElem();

	hud.x = x;
	hud.y = y;
	hud.alpha = alpha;
	hud setShader( shader, scalex, scaley );

	return hud;
}

addTextHud( who, x, y, alpha, alignX, alignY, horiz, vert, fontScale, sort ) 
{
	if( isPlayer( who ) )
		hud = newClientHudElem( who );
	else
		hud = newHudElem();

	hud.x = x;
	hud.y = y;
	hud.alpha = alpha;
	hud.sort = sort;
	hud.alignX = alignX;
	hud.alignY = alignY;
	if(isdefined(vert))
		hud.vertAlign = vert;
	if(isdefined(horiz))
		hud.horzAlign = horiz;		
	if(fontScale != 0)
		hud.fontScale = fontScale;
	hud.foreground = 1;
	hud.archived = 0;
	return hud;
}

fadeIn(time) 
{
	alpha = self.alpha;
	self.alpha = 0;
	self fadeOverTime(time);
	self.alpha = alpha;
}

/*create_killcard(player)
{
	scalex = 300;
	scaley = 100;
	shader = "ui_playercard_"+player getStat(2554);
	alpha = 0;
	x = -300;
	y = 200;

	elem = [];
	elem[0] = addIconHud( level, x, y, alpha, shader, scalex, scaley );//top left

}*/