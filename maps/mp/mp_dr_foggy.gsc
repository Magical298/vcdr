main()
{
	maps\mp\_load::main();
	
	game["allies"] = "marines";
    game["axis"] = "opfor";
    game["attackers"] = "axis";
    game["defenders"] = "allies";
    game["allies_soldiertype"] = "desert";
    game["axis_soldiertype"] = "desert";
	
	ambientPlay( "foggy" );
	
	setdvar( "r_specularcolorscale", "1" );
    setdvar( "r_glowbloomintensity0", ".25" );
    setdvar( "r_glowbloomintensity1", ".25" );
    setdvar( "r_glowskybleedintensity0", ".3" );
    setdvar( "compassmaxrange", "1800" );
	setDvar("bg_falldamagemaxheight", 1000 );
	setDvar("bg_falldamageminheight", 900 );
	
	level._effect["blood_1"] = loadFx("custom/blood");
	level._effect["blood_2"] = loadFx("custom/blood_2");
	level._effect["clusterbomb"] = loadFx("custom/clusterbomb");
	level._effect["splash"] = loadFx("custom/water_splash");
	
	precacheItem ( "uzi_silencer_mp" );
	precacheItem( "colt45_silencer_mp" );
	
	thread fog();
	thread water();
	thread startbridge();
	thread moveup();
	thread secret_bounce();
	thread secret();
	thread addTestClients();
	//thread map();
	
	thread trap1();
	thread trap2();
	thread trap3();
	thread trap4();
	thread trap4_death();
	thread trap5();
	thread trap6();
	thread trap7();
	
	thread endgame_snipe();
	thread endgame_knife();
	thread endgame_pistol();
	thread old();
}

fog()
{
	SetExpFog( 1000, 1000, 1, 1, 1, 0 );
}

water()
{
	trigger = getEnt ( "water", "targetname" );
	
	while(1)
	{
		trigger waittill ( "trigger", player );
		
		player thread drown();
	}
}

drown()
{
	playFx( level._effect["splash"], self.origin );
	wait 0.05;
	self suicide();
}

addTestClients()
{
	setDvar("scr_testclients", "");
	wait 1;
	for(;;)
	{
		if(getdvarInt("scr_testclients") > 0)
			break;
		wait 1;
	}
	testclients = getdvarInt("scr_testclients");
	setDvar( "scr_testclients", 0 );
	for(i=0;i<testclients;i++)
	{
		ent[i] = addtestclient();

		if (!isdefined(ent[i]))
		{
			println("Could not add test client");
			wait 1;
			continue;
		}
		ent[i].pers["isBot"] = true;
		ent[i] thread TestClient("autoassign");
	}
	thread addTestClients();
}

TestClient(team)
{
	self endon( "disconnect" );

	while(!isdefined(self.pers["team"]))
	wait .05;
		
	self notify("menuresponse", game["menu_team"], team);
	wait 0.5;
}

startbridge()
{
	bridge = getent ( "startbridge", "targetname" );
	
	wait 0.05;
	bridge moveZ ( -160, 0.5 );
	wait 10;
	bridge moveZ ( 160, 10 );
	wait 10;
}

secret()
{
	trigger = getent ( "secret_step", "targetname" );
	secret = getent ( "secret", "targetname" );
	
	secret hide();
	secret notSolid();
	
	trigger waittill ( "trigger", player );
	iprintLnBold ( "^5"+player.name +" ^7opened the ^5secret ^7way" );
	
	secret show();
	secret Solid();
}

secret_bounce()
{
	trigger = getent ( "secret_bounce", "targetname" );
	
	trigger waittill ( "trigger", player );
	wait 0.5;
	player braxi\_rank::giveRankXp(undefined,20);
	player GiveWeapon( "colt45_mp" );
	player switchtoweapon("colt45_mp");
	iprintLn( "^5"+player.name +" ^7finished the ^5secret ^7first" );
	trigger delete();
}

moveup()
{
	trigger = getent ( "moveup_trigger", "targetname" );
	mover = getent ( "moveup_mover", "targetname" );
	
	while(1)
	{
		trigger waittill ( "trigger", player );
		wait 1;
		mover moveTo (( 2112, -1696, -136 ), 2, 0.5, 1.5);
		wait 5;
		mover moveTo (( 2112, -1568, -392 ), 2, 0.5, 1.5);
		wait 2;
	}
}

trap1()
{
	trigger = getent ( "trap1_trigger", "targetname" );
	pusher = getent ( "trap1_pusher", "targetname" );
	
	pusher hide();
	trigger setHintstring ( "Press ^2<use> ^7to activate this trap" );
	trigger waittill ( "trigger", player );
	trigger delete();
	wait 0.05;
	player braxi\_rank::giveRankXP( "", 20 );
	
	pusher show();
	wait 0.1;
	pusher moveY ( -512, 1 );
	wait 1;
	pusher hide();
}

trap2()
{
	trigger = getent ( "trap2_trigger", "targetname" );
	rotate = getent ( "trap2_rotate", "targetname" );
	
	trigger setHintstring ( "Press ^2<use> ^7to activate this trap" );
	trigger waittill ( "trigger", player );
	trigger delete();
	player braxi\_rank::giveRankXp( "", 20 );
	
	while(1)
	{
		rotate rotatePitch ( -360, 6 );
		wait 6;
	}
}

trap3()
{
	trigger = getent ( "trap3_trigger", "targetname" );
	platform = getent ( "trap3_platform", "targetname" );
	
	trigger setHintstring ( "Press ^2<use> ^7to activate this trap" );
	trigger waittill ( "trigger", player );
	trigger delete();
	player braxi\_rank::giveRankXP( "", 20 );
	
	platform moveZ ( -175, 10 );
	wait 10;
	platform hide();
}

trap4()
{
	trigger = getent ( "trap4_trigger", "targetname" );
	spikes = getent ( "trap4_spikes", "targetname" );
	level.spikeshurt = getent ( "spikeshurt", "targetname" );
	
	level.spikeshurt enablelinkto();
	level.spikeshurt linkto(spikes);
	
	trigger setHintstring ( "Press ^2<use> ^7to activate this trap" );
	spikes notSolid();
	spikes moveZ ( -160, 1 );
	trigger waittill ( "trigger", player );
	trigger delete();
	player braxi\_rank::giveRankXP( "", 20 );
	
	spikes moveZ ( 160, 0.2 );
	wait 4;
	spikes moveZ ( -160, 4 );
	wait 4;
	spikes hide();
}

trap4_death()
{
	for(;;)
	{
		level.spikeshurt waittill ( "trigger", player );
		player thread trap4_fx();
	}
}

trap4_fx()
{
	playFx( level._effect["blood_1"], self.origin );
	wait 0.05;
	self suicide();
}

trap5()
{
	trigger = getent ( "trap5_trigger", "targetname" );
	bounce = getent ( "trap5_bounce", "targetname" );
	
	trigger setHintstring ( "Press ^2<use> ^7to activate this trap" );
	trigger waittill ( "trigger", player );
	trigger delete();
	player braxi\_rank::giveRankXP( "", 20 );
	
	bounce hide();
	wait 0.1;
	bounce notSolid();
	wait 7;
	bounce show();
	bounce Solid();
	wait 1;
}

trap6()
{
	trigger = getent ( "trap6_trigger", "targetname" );
	target = getent ( "trap6_target", "targetname" );
	
	trigger setHintstring ( "Press ^2<use> ^7to activate this trap" );
	trigger waittill ( "trigger", player );
	trigger delete();
	player braxi\_rank::giveRankXP( "", 20 );
	target moveY ( -192, 5 );
	wait 5;
	
	while(1)
	{
		target moveY ( 384, 12, 5, 7 );
		wait 12;
		target moveY ( -384, 12, 5, 7 );
		wait 12;
	}
}

movetext(time,x,y)
{
	self moveOverTime(time);
	if(isDefined(x))
		self.x = x;
		
	if(isDefined(y))
		self.y = y;
}

trap7()
{
	trigger = getent ( "trap7_trigger", "targetname" );
	blade1 = getent ( "trap7_blade1", "targetname" );
	blade2 = getent ( "trap7_blade2", "targetname" );
	level.blade1_hurt = getent ( "trap7_blade1_hurt", "targetname" );
	level.blade2_hurt = getent ( "trap7_blade2_hurt", "targetname" );
	asd1 = getent ( "asd1", "targetname" );
	asd2 = getent ( "asd2", "targetname" );
	
	level.blade1_hurt enablelinkto();
	level.blade2_hurt enablelinkto();
	level.blade1_hurt linkto(blade1);
	level.blade2_hurt linkto(blade2);
	
	blade1 rotateRoll ( 70, 1 );
	blade2 rotateRoll ( 70, 1 );
	blade1 notSolid();
	blade2 notSolid();
	
	trigger setHintstring ( "Press ^2<use> ^7to activate this trap" );
	trigger waittill ( "trigger", player );
	trigger delete();
	player braxi\_rank::giveRankXP( "", 20 );
	wait 0.05;
	
	thread trap7_death1();
	thread trap7_death2();
	
	blade1 rotateRoll ( -140, 2, 1, 1 );
	playFx( level._effect["clusterbomb"], ( -352, -1152, -104 ) );
	asd1 hide();
	wait 2;
	playFx( level._effect["clusterbomb"], ( -128, -1152, -104 ) );
	asd2 hide();
	
	while(1)
	{
		blade2 rotateRoll ( -140, 2, 1, 1 );
		blade1 rotateRoll ( 140, 2, 1, 1 );
		wait 2;
		blade2 rotateRoll ( 140, 2, 1, 1 );
		blade1 rotateRoll ( -140, 2, 1, 1 );
		wait 2;
	}
}

trap7_death1()
{
	for(;;)
	{
		level.blade1_hurt waittill ( "trigger", player );
		player thread trap7_fx();
	}
}

trap7_death2()
{
	for(;;)
	{
		level.blade2_hurt waittill ( "trigger", player );
		player thread trap7_fx();
	}
}

trap7_fx()
{
	playFx( level._effect["blood_2"], self.origin );
	wait 0.05;
	self suicide();
}

/*
map()
{
	trigger = getEnt ( "whomademap", "targetname" );
	
	while(1)
	{
		trigger waittill ( "trigger", player );
		
		map = NewHudElem();
		map1 = NewHudElem();
		map.alignX = "center";
		map1.alignX = "center";
		map.alignY = "middle";
		map1.alignY = "middle";
		map.horzalign = "center";
		map1.horzalign = "center";
		map.vertalign = "middle";
		map1.vertalign = "middle";
		map.alpha = 1;
		map1.alpha = 1;
		map.font = "objective";
		map1.font = "objective";
		map.fontscale = 4;
		map1.fontscale = 4;
		map.glowalpha = 1;
		map1.glowalpha = 1;
		map.glowcolor = ( 0, 1, 1 );
		map1.glowcolor = ( 0, 1, 1 );
		map.x = 0;
		map1.x = 0;
		map.y = -250;
		map1.y = -200;
		map setText( "VC' Icomar" );
		map1 setText( "Map by:" );
		map SetPulseFX( 100, 4000, 500 );
		map1 SetPulseFX( 100, 4000, 500 );
		map movetext( 5, 0, 250 );
		map1 movetext( 5, 0, 300 );
		wait 6;
		map destroy();
		map1 destroy();
		wait 1;
	}
}
*/

countdown()
{
	cd = NewHudElem();
	cd.alignX = "center";
	cd.alignY = "middle";
	cd.horzalign = "center";
	cd.vertalign = "middle";
	cd.alpha = 1;
	cd.font = "objective";
	cd.fontscale = 4;
	cd.glowalpha = 1;
	cd.glowcolor = ( 0, 1, 1 );
	cd.x = 0;
	cd.y = -250;
	cd setText( "3" );
	cd SetPulseFX( 100, 4000, 500 );
	cd movetext( 1.6, 0, 250 );
	wait 0.7;
	cd.glowcolor = ( 1, 1, 1 );
	wait 0.2;
	cd.glowcolor = ( 0, 1, 1 );
	wait 0.7;
	cd.x = 0;
	cd.y = -250;
	cd setText( "2" );
	cd SetPulseFX( 100, 4000, 500 );
	cd movetext( 1.6, 0, 250 );
	wait 0.7;
	cd.glowcolor = ( 1, 1, 1 );
	wait 0.2;
	cd.glowcolor = ( 0, 1, 1 );
	wait 0.7;
	cd.x = 0;
	cd.y = -200;
	cd setText( "1" );
	cd SetPulseFX( 100, 4000, 500 );
	cd movetext( 1.6, 0, 250 );
	wait 0.7;
	cd.glowcolor = ( 1, 1, 1 );
	wait 0.2;
	cd.glowcolor = ( 0, 1, 1 );
	wait 0.7;
	cd destroy();
}

endgame_snipe()
{
    level.snipe = getent ( "scope_trigger", "targetname" );
	level.snipe_acti_spawn = getent ( "snipe_acti_origin", "targetname" );
	level.snipe_jumper_spawn = getent ( "snipe_jumper_origin", "targetname" );
	level.nothing = getent ( "nothing", "targetname" );
	
	level.snipe sethintstring ( "^5[ ^7Scope ^5]" );
	
	while(1)
	{
		level.snipe waittill( "trigger", player );
		if( !isDefined( level.snipe ) )
			return;

			// ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================
		
		level.pistol delete();
		level.old delete();
		level.knife delete();
		
		player disableWeapons(1);
		level.activ disableWeapons(1);
		wait 0.05;
		
		noti = SpawnStruct();
		noti.titleText = "^5S^7niper ^5R^7oom";
		noti.notifyText ="^7"+player.name +" ^5VS ^7"+level.activ.name+"^7";
		noti.duration = 5;
		players = getEntArray( "player", "classname" );
		for( i=0;i<players.size;i++ )
		players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
		wait 0.05;
        
		player setOrigin( level.snipe_jumper_spawn.origin );
		player setPlayerangles( level.snipe_jumper_spawn.angles );
		level.activ setOrigin( level.snipe_acti_spawn.origin );
		level.activ setPlayerangles( level.snipe_acti_spawn.angles );
		wait 0.05;
		
		player linkto(level.nothing);
		level.activ linkto(level.nothing);
		
		player TakeAllWeapons();
		player GiveWeapon( "m40a3_mp" );
		player GiveWeapon( "remington700_mp" );
		player GiveMaxAmmo( "m40a3_mp" );
		player GiveMaxAmmo( "remington700_mp" );
		level.activ TakeAllWeapons();
		level.activ GiveWeapon( "m40a3_mp" );
		level.activ GiveWeapon( "remington700_mp" );
		level.activ GiveMaxAmmo( "m40a3_mp" );
		level.activ GiveMaxAmmo( "remington700_mp" );
		thread countdown();
		wait 4;
		
		player enableWeapons(1);
		level.activ enableWeapons(1);
	
		player switchToWeapon( "m40a3_mp" );
		level.activ switchToWeapon( "m40a3_mp" );
		
		player unlink();
		level.activ unlink();
		wait 0.5;
	
		while( isAlive( player ) && isDefined( player ) )
		wait 0.5;
	}
}

endgame_knife()
{
    level.knife = getent ( "knife_trigger", "targetname" );
	level.knife_acti_spawn = getent ( "knife_acti_origin", "targetname" );
	level.knife_jumper_spawn = getent ( "knife_jumper_origin", "targetname" );
	
	level.knife sethintstring ( "^5[ ^7Knife ^5]" );
	
	while(1)
	{
		level.knife waittill( "trigger", player );
		if( !isDefined( level.knife ) )
			return;

			// ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================
		
		level.snipe delete();
		level.old delete();
		level.pistol delete();
		
		player disableWeapons(1);
		level.activ disableWeapons(1);
		wait 0.05;
		
		noti = SpawnStruct();
		noti.titleText = "^5K^7nife ^5R^7oom";
		noti.notifyText ="^7"+player.name +" ^5VS ^7"+level.activ.name+"^7";
		noti.duration = 5;
		players = getEntArray( "player", "classname" );
		for( i=0;i<players.size;i++ )
		players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
		wait 0.05;
        
		player setOrigin( level.knife_jumper_spawn.origin );
		player setPlayerangles( level.knife_jumper_spawn.angles );
		level.activ setOrigin( level.knife_acti_spawn.origin );
		level.activ setPlayerangles( level.knife_acti_spawn.angles );
		wait 0.05;
		
		player linkto(level.nothing);
		level.activ linkto(level.nothing);
		
		player TakeAllWeapons();
		player GiveWeapon( "knife_mp" );
		level.activ TakeAllWeapons();
		level.activ GiveWeapon( "knife_mp" );
		thread countdown();
		wait 4;
		
		player enableWeapons(1);
		level.activ enableWeapons(1);
	
		player switchToWeapon( "knife_mp" );
		level.activ switchToWeapon( "knife_mp" );
		
		player unlink();
		level.activ unlink();
		wait 0.5;
	
		while( isAlive( player ) && isDefined( player ) )
		wait 0.5;
	}
}

endgame_pistol()
{
    level.pistol = getent ( "pistol_trigger", "targetname" );
	level.pistol_acti_spawn = getent ( "pistol_acti_origin", "targetname" );
	level.pistol_jumper_spawn = getent ( "pistol_jumper_origin", "targetname" );
	
	level.pistol sethintstring ( "^5[ ^7Pistol ^5]" );
	
	while(1)
	{
		level.pistol waittill( "trigger", player );
		if( !isDefined( level.pistol ) )
			return;

			// ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================
			
		level.snipe delete();
		level.knife delete();
		level.old delete();
		
		player disableWeapons(1);
		level.activ disableWeapons(1);
		wait 0.05;
		
		noti = SpawnStruct();
		noti.titleText = "^5P^7istol ^5R^7oom";
		noti.notifyText ="^7"+player.name +" ^5VS ^7"+level.activ.name+"^7";
		noti.duration = 5;
		players = getEntArray( "player", "classname" );
		for( i=0;i<players.size;i++ )
		players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
		wait 0.05;
        
		player setOrigin( level.pistol_jumper_spawn.origin );
		player setPlayerangles( level.pistol_jumper_spawn.angles );
		level.activ setOrigin( level.pistol_acti_spawn.origin );
		level.activ setPlayerangles( level.pistol_acti_spawn.angles );
		wait 0.05;
		
		player linkto(level.nothing);
		level.activ linkto(level.nothing);
		
		player TakeAllWeapons();
		player GiveWeapon( "colt45_silencer_mp" );
		player GiveMaxAmmo( "colt45_silencer_mp" );
		level.activ TakeAllWeapons();
		level.activ GiveWeapon( "colt45_silencer_mp" );
		level.activ GiveMaxAmmo( "colt45_silencer_mp" );
		thread countdown();
		wait 4;
		
		player enableWeapons(1);
		level.activ enableWeapons(1);
	
		player switchToWeapon( "colt45_silencer_mp" );
		level.activ switchToWeapon( "colt45_silencer_mp" );
		
		player unlink();
		level.activ unlink();
		wait 0.5;
	
		while( isAlive( player ) && isDefined( player ) )
		wait 0.5;
	}
}

old()
{
	level.old = getent ( "old_trigger", "targetname" );
	port = getent ( "old_port", "targetname" );

	for(;;)
	{
		level.old waittill ( "trigger", player );

		if(!isdefined(level.old))
			return;

		// ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================

		level.snipe delete();
		level.knife delete();
		level.pistol delete();

		if(!isdefined(level.oldFoggy))
		{
			level.oldFoggy = true;

			noti = SpawnStruct();
			noti.titleText = "^5O^7ld";
			noti.duration = 5;
			players = getEntArray( "player", "classname" );
			for( i=0;i<players.size;i++ )
			players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
			wait 0.05;
			
			player braxi\_rank::giveRankXP( "", 100 );
		}

		player setOrigin( port.origin );

		while( isAlive( player ) && isDefined( player ) )
			wait 0.5;
	}
}