#include maps\mp\gametypes\_hud_util;

init()
{
	if( game["roundsplayed"] >= level.dvar[ "round_limit" ] || level.freerun )
		return;
	
	level.killcamWatch=true;

	level waittill("activator");
	
	setArchive(true);
	self thread WatchForKillcam();
}

WatchForKillcam()
{
	if( game["roundsplayed"] >= level.dvar[ "round_limit" ] || level.freeRun )
		return;
	
	while(level.killcamWatch)
	{
		level waittill( "player_killed", who, eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration );
		if( isDefined( who ) && isPlayer( who ) && isDefined( level.activ ) && game["state"] != "readyup")
		{
			wait .45;
			if( !level.activators || !level.jumpers )
			{
				if( isDefined( attacker ) && isDefined( eInflictor ) && isPlayer( attacker ) && who != attacker && sMeansOfDeath != "MOD_FALLING" )
				{
					level.killcamWatch=false;
					wait 0.5;
					thread StartKillcam( attacker, sWeapon );
					return;
				}
			}
		}
		else 
			continue;
	}
}

StartKillcam( attacker, sWeapon )
{
	wait 2;
	players = getEntArray( "player", "classname" );
	for(i=0;i<players.size;i++)
		players[i] thread killcam( attacker GetEntityNumber(), -1, sWeapon, 0, 0, 0, 10, undefined, attacker );
}

killcam(attackerNum,killcamentity,sWeapon,predelay,offsetTime,respawn,maxtime,perks,attacker)
{
	self endon("disconnect");
	self endon("spawned");
	level endon("game_ended");

	if(attackerNum < 0)
		return;

	camtime = 8;
	
	if (isdefined(maxtime)) 
	{
		if (camtime > maxtime)
			camtime = maxtime;
		if (camtime < .05)
			camtime = .05;
	}
	
	if (getdvar("scr_killcam_posttime") == "")
		postdelay = 2;
	else 
	{
		postdelay = getdvarfloat("scr_killcam_posttime");
		if (postdelay < 0.05)
			postdelay = 0.05;
	}

	killcamlength = camtime + postdelay;
	
	if (isdefined(maxtime) && killcamlength > maxtime)
	{
		if (maxtime < 2)
			return;

		if (maxtime - camtime >= 1) 
		{
			postdelay = maxtime - camtime;
		}
		else 
		{
			postdelay = 2;
			camtime = maxtime - 1;
		}
		killcamlength = camtime + postdelay;
	}
	killcamoffset = camtime + predelay;
	
	self notify ( "begin_killcam", getTime() );
	
	self.sessionstate = "spectator";
	self.spectatorclient = attackerNum;
	self.killcamentity = killcamentity;
	self.archivetime = killcamoffset;
	self.killcamlength = killcamlength;
	self.psoffsettime = offsetTime;

	// ignore spectate permissions
	self allowSpectateTeam("allies", true);
	self allowSpectateTeam("axis", true);
	self allowSpectateTeam("freelook", true);
	self allowSpectateTeam("none", true);

	wait 0.05;

	if ( self.archivetime <= predelay )
	{
		self.sessionstate = "dead";
		self.spectatorclient = -1;
		self.killcamentity = -1;
		self.archivetime = 0;
		self.psoffsettime = 0;
		
		return;
	}
	self.killcam = true;
	
	self thread waitKillcamTime();

	self waittill("end_killcam");

	self endKillcam();

	self.sessionstate = "dead";
	self.spectatorclient = -1;
	self.killcamentity = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
}

waitKillcamTime()
{
	self endon("disconnect");
	self endon("end_killcam");

	wait 9;
	self notify("end_killcam");
}

endKillcam()
{
	self.killcam = undefined;
}