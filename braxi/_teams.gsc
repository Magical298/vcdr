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

setPlayerModel()
{
	self detachAll();
	if( self.pers["team"] == "allies" )
	{
		if(self.pers["vip"] == 1 && self getstat(1212) == 1)
			self setmodel("playermodel_carnage");
		else 
			self setModel( level.characterInfo[self getstat(980)]["model"] );
	}
	else
		self setModel( "playermodel_vistic_mike_myers" );
}

setHealth()
{
	self.maxhealth = 10;
	switch( self.pers["team"] )
	{
	case "allies":
		self.maxhealth = level.dvar["allies_health"];
		break;
	case "axis":
		self.maxhealth = level.dvar["axis_health"];
		break;
	}
	self.health = self.maxhealth;
}

setSpeed()
{
	speed = 1.0;
	switch( self.pers["team"] )
	{
	case "allies":
		speed = level.dvar["allies_speed"];
		break;
	case "axis":
		speed = level.dvar["axis_speed"];
		break;
	}
	self setMoveSpeedScale( speed );
}

setTeam( team )
{
	if( self.pers["team"] == team )
		return;

	if( isAlive( self ) )
		self suicide();
	
	self.pers["weapon"] = "none";
	self.pers["team"] = team;
	self.team = team;
	self.sessionteam = team;

	menu = game["menu_team"];
	if( team == "allies" )
	{
		self.pers["weapon"] = "colt45_mp";
	}
	else if( team == "axis" )
	{
		self.pers["weapon"] = "knife_mp";
	}
	self setClientDvars( "g_scriptMainMenu", menu );
}

setSpectatePermissions()
{
	self allowSpectateTeam( "allies", true );
	self allowSpectateTeam( "axis", true );
	self allowSpectateTeam( "none", false );
}
