main()
{

	thread jump_weapon();
	thread secret();
	thread jump_1();
	thread jump_2();
	thread jump_3();
	thread jump_4();
	thread jump_5();
	thread jump_6();
	thread letters_rotate();
	thread endroom_jump();
	thread jump_respawn();
	thread endroom_snipe();
	thread endroom_knife();
	thread endroom_old();
	thread endroom_weapon();
}

brunnen()
{
	brunnen = getEnt ( "brunnen_1", "targetname" );
	
	playFx ( level.brunnen, brunnen.origin );
}

bouncer(who)
{
	oldpos = who.origin;
    playFx ( level.bounce, who.origin );
	strenght = 3;
	for(i=0;i<strenght;i++)
	{
	    who.health += 170;
        who finishPlayerDamage(who, level.jumpattacker, 170, 0, "MOD_FALLING", "jump_mp", who.origin, AnglesToForward((-90,0,0)), "none", 0);
	}
}

bouncer_2(who)
{
	oldpos = who.origin;
	strenght = 1;
	for(i=0;i<strenght;i++)
	{
	    who.health += 100;
        who finishPlayerDamage(who, level.jumpattacker, 100, 0, "MOD_FALLING", "jump_mp", who.origin, AnglesToForward((-90,0,0)), "none", 0);
	}
}

tree()
{
	target = getEnt ( "sniper_tree", "targetname" );
	
	while(1)
	{
		target rotateRoll ( 1, 7);
		wait 7;
		target rotateRoll ( -1, 7);
		wait 7;
	}
}

jump_weapon()
{
	level.jump_trigger = getEnt ( "jump_weapon", "targetname" );
	level.jump_clip = getEnt ( "jump_weapon_clip", "targetname" );
	
	level.jump_trigger enableLinkTo();
	level.jump_trigger LinkTo ( level.jump_clip );
	
	level.Jump_clip moveZ ( 300, 1);
	
	while(1)
	{
		level.jump_trigger waittill ( "trigger", player );
		
		level.Jump_clip moveZ ( 300, 0.5);
	
		player TakeAllWeapons();
		wait 0.05;
	
		if ( RandomIntRange ( 1, 101) > 50 )
		{
			for ( i = 1; i < 5; i++ )
			{
				player giveWeapon ( "remington700_mp" );
				player giveWeapon ( "deserteaglegold_mp" );
				player giveMaxAmmo ( "remington700_mp" );
				player giveMaxAmmo ( "deserteaglegold_mp" );
				player switchToWeapon ( "remington700_mp" );
				wait 0.5;
			}
		}
		else
		{
			for ( i = 5; i < 9; i++ )
			{
				player giveWeapon( "ak47_acog_mp" );
				player giveMaxAmmo( "ak47_acog_mp" );
				player switchToWeapon ( "ak47_acog_mp" );
				wait 0.5;
			}
		}
		wait 0.05;
	}
}

secret()
{
	trigger = getEnt ( "secret_bouncer", "targetname" );
	
	while(1)
	{
		trigger waittill ( "trigger", who );
		thread bouncer_2(who);
	}
}

jump_1()
{
	trigger = getEnt ( "jump_1", "targetname" );
	
	while(1)
	{
		trigger waittill ( "trigger", who );
		thread bouncer(who);
	}
}

jump_2()
{
	trigger = getEnt ( "jump_2", "targetname" );
	
	while(1)
	{
		trigger waittill ( "trigger", who );
		thread bouncer(who);
	}
}

jump_3()
{
	trigger = getEnt ( "jump_3", "targetname" );
	
	while(1)
	{
		trigger waittill ( "trigger", who );
		thread bouncer(who);
	}
}

jump_4()
{
	trigger = getEnt ( "jump_4", "targetname" );
	
	while(1)
	{
		trigger waittill ( "trigger", who );
		thread bouncer(who);
	}
}

jump_5()
{
	trigger = getEnt ( "jump_5", "targetname" );
	
	while(1)
	{
		trigger waittill ( "trigger", who );
		thread bouncer(who);
	}
}

jump_6()
{
	trigger = getEnt ( "jump_6", "targetname" );
	
	while(1)
	{
		trigger waittill ( "trigger", who );
		thread bouncer(who);
	}
}

letters_rotate()
{
	k = getEnt ( "endroom_k", "targetname" );
	s = getEnt ( "endroom_s", "targetname" );
	j = getEnt ( "endroom_j", "targetname" );
	w = getEnt ( "endroom_w", "targetname" );
	
	while(1)
	{
		k rotateYaw ( 360, 6);
		s rotateYaw ( 360, 6);
		j rotateYaw ( 360, 6);
		w rotateYaw ( 360, 6);
		wait 6;
	}
}

endroom_jump()
{
    level.jump = getent ( "endroom_jump_trigger", "targetname" );
	level.acti_respawn = getent ("jump_acti_respawn","targetname");
	level.jumper_respawn = getent ("jump_jumper_respawn","targetname");
	
	while( 1 )
    {
        level.jump waittill( "trigger", player );
        if( !isDefined( level.jump ) )
            return;

		// ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================
			
		level.old delete();
		level.snipe delete();
		level.knife delete();
		level.weap delete();
			
		player freezeControls(1);
		level.activ freezeControls(1);
		
		player disableWeapons(1);
		level.activ disableWeapons(1);
		
		level.Jump_clip moveZ ( -300, 1);
			
		noti = SpawnStruct();
		noti.titleText = "^2Jump Room";
		noti.notifyText = "^2" + player.name + "^7 has choosen the Jump Room";
		noti.duration = 5;
		noti.glowcolor = (0, 0.9, 2);
		players = getEntArray( "player", "classname" );
		for( i=0;i<players.size;i++ )
		players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
		wait 3;
        
        player setOrigin( level.jumper_respawn.origin );
		player setPlayerangles( level.jumper_respawn.angles );
		
		player TakeAllWeapons();
		wait 0.05;
		player GiveWeapon( "knife_mp" );
		
		level.activ setOrigin( level.acti_respawn.origin );
		level.activ setPlayerangles( level.acti_respawn.angles );	
		
		level.activ TakeAllWeapons();
		wait 0.05;
		level.activ GiveWeapon( "knife_mp" );
		wait 1;
		
		start = NewHudElem();
		start.alignX = "center";
		start.alignY = "middle";
		start.horzalign = "center";
		start.vertalign = "middle";
		start.alpha = 1;
		start.x = 0;
		start.y = -50;
		start.font = "objective";
		start.fontscale = 3;
		start.glowalpha = 1;
		start.glowcolor = ( 0, 1, 0 );
		start setText( "^2[ ^73 ^2]" );
		start SetPulseFX( 100, 4000, 500 );
		wait 1.6;
		start setText( "^2[ ^72 ^2]" );
		start SetPulseFX( 100, 4000, 500 );
		wait 1.6;
		
		player enableWeapons(1);
		level.activ enableWeapons(1);
		player switchToWeapon( "knife_mp" );
		level.activ switchToWeapon( "knife_mp" );
		
		start setText( "^2[ ^71 ^2]" );
		start SetPulseFX( 100, 4000, 500 );
		wait 1.8;
		start setText( "^2[ ^7GO ^2]" );
		start SetPulseFX( 100, 4000, 500 );
		
		player freezeControls(0);
		level.activ freezeControls(0);
		
		wait 4;
		
		start destroy();
		
		while( isAlive( player ) && isDefined( player ) )
			wait 1;
    }
    wait 0.05;
}

jump_respawn()
{
	trigger = getent ( "jump_respawn", "targetname" );
	for(;;)
	{
		trigger waittill ( "trigger", player );
	
		if( player.pers[ "team" ] != "spectator" )
		{
			if( player.pers[ "team" ] == "allies" )
			{
				player SetPlayerAngles ( level.pj.angles );
				player SetOrigin ( level.jumper_respawn.origin );
			}
			if( player.pers[ "team" ] == "axis" )
			{
				player SetPlayerAngles ( level.aj.angles );
				player SetOrigin ( level.acti_respawn.origin );
			}
		}
	}
}

endroom_snipe()
{
    level.snipe = getent ( "endroom_snipe_trigger", "targetname" );
	level.snipe_acti_respawn = getent ("snipe_acti_respawn","targetname");
	level.snipe_jumper_respawn = getent ("snipe_jumper_respawn","targetname");
	
	while( 1 )
    {
        level.snipe waittill( "trigger", player );
        if( !isDefined( level.snipe ) )
            return;

		// ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================
			
		level.jump delete();
		level.old delete();
		level.knife delete();
		level.weap delete();
		
		player freezeControls(1);
		level.activ freezeControls(1);
		wait 0.5;
		
		player disableWeapons(1);
		level.activ disableWeapons(1);
		
		noti = SpawnStruct();
		noti.titleText = "^2Sniper Room";
		noti.notifyText = "^2" + player.name + "^7 has choosen the Sniper Room";
		noti.duration = 5;
		noti.glowcolor = (0, 0.9, 2);
		players = getEntArray( "player", "classname" );
		for( i=0;i<players.size;i++ )
		players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
		wait 3;
		
		while(1)
		{
			thread tree();
				break;
		}
        
        player setOrigin( level.snipe_jumper_respawn.origin );
		player setPlayerangles( level.snipe_jumper_respawn.angles );
		
		player TakeAllWeapons();
		wait 0.05;
		player GiveWeapon( "m40a3_mp" );
		player GiveWeapon( "remington700_mp" );
		player GiveMaxAmmo( "m40a3_mp" );
		player GiveMaxAmmo( "remington700_mp" );
		
		level.activ setOrigin( level.snipe_acti_respawn.origin );
		level.activ setPlayerangles( level.snipe_acti_respawn.angles );	
		
		level.activ TakeAllWeapons();
		wait 0.05;
		level.activ GiveWeapon( "m40a3_mp" );
		level.activ GiveWeapon( "remington700_mp" );
		level.activ GiveMaxAmmo( "m40a3_mp" );
		level.activ GiveMaxAmmo( "remington700_mp" );
		wait 1;
		
		start = NewHudElem();
		start.alignX = "center";
		start.alignY = "middle";
		start.horzalign = "center";
		start.vertalign = "middle";
		start.alpha = 1;
		start.x = 0;
		start.y = -50;
		start.font = "objective";
		start.fontscale = 3;
		start.glowalpha = 1;
		start.glowcolor = ( 0, 1, 0 );
		start setText( "^2[ ^73 ^2]" );
		start SetPulseFX( 100, 4000, 500 );
		wait 1.6;
		start setText( "^2[ ^72 ^2]" );
		start SetPulseFX( 100, 4000, 500 );
		wait 1.6;
		
		player enableWeapons(1);
		level.activ enableWeapons(1);
		player switchToWeapon( "m40a3_mp" );
		level.activ switchToWeapon( "m40a3_mp" );
		
		start setText( "^2[ ^71 ^2]" );
		start SetPulseFX( 100, 4000, 500 );
		wait 1.8;
		start setText( "^2[ ^7GO ^2]" );
		start SetPulseFX( 100, 4000, 500 );
		
		player freezeControls(0);
		level.activ freezeControls(0);
		
		wait 4;
		
		start destroy();
		
		while( isAlive( player ) && isDefined( player ) )
			wait 1;
    }
    wait 0.05;
}

endroom_knife()
{
    level.knife = getent ( "endroom_knife_trigger", "targetname" );
	level.knife_acti_respawn = getent ("knife_acti_respawn","targetname");
	level.knife_jumper_respawn = getent ("knife_jumper_respawn","targetname");
	
	while( 1 )
    {
        level.knife waittill( "trigger", player );
        if( !isDefined( level.knife ) )
            return;

		// ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================
			
		level.jump delete();
		level.snipe delete();
		level.old delete();
		level.weap delete();
			
		player freezeControls(1);
		level.activ freezeControls(1);
		
		player disableWeapons(1);
		level.activ disableWeapons(1);
		
		while(1)
		{
			thread brunnen();
				break;
		}
			
		noti = SpawnStruct();
		noti.titleText = "^2Knife Room";
		noti.notifyText = "^2" + player.name + "^7 has choosen the Knife Room";
		noti.duration = 5;
		noti.glowcolor = (0, 0.9, 2);
		players = getEntArray( "player", "classname" );
		for( i=0;i<players.size;i++ )
		players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
		wait 3;
        
        player setOrigin( level.knife_jumper_respawn.origin );
		player setPlayerangles( level.knife_jumper_respawn.angles );
		
		player TakeAllWeapons();
		wait 0.05;
		player GiveWeapon( "knife_mp" );
		
		level.activ setOrigin( level.knife_acti_respawn.origin );
		level.activ setPlayerangles( level.knife_acti_respawn.angles );	
		
		level.activ TakeAllWeapons();
		wait 0.05;
		level.activ GiveWeapon( "knife_mp" );
		
		wait 0.05;
		player switchToWeapon( "knife_mp" );
		level.activ switchToWeapon( "knife_mp" );
		
		start = NewHudElem();
		start.alignX = "center";
		start.alignY = "middle";
		start.horzalign = "center";
		start.vertalign = "middle";
		start.alpha = 1;
		start.x = 0;
		start.y = -50;
		start.font = "objective";
		start.fontscale = 3;
		start.glowalpha = 1;
		start.glowcolor = ( 0, 1, 0 );
		start setText( "^2[ ^73 ^2]" );
		start SetPulseFX( 100, 4000, 500 );
		wait 1.6;
		start setText( "^2[ ^72 ^2]" );
		start SetPulseFX( 100, 4000, 500 );
		wait 1.6;
		
		player enableWeapons(1);
		level.activ enableWeapons(1);
		player switchToWeapon( "knife_mp" );
		level.activ switchToWeapon( "knife_mp" );
		
		start setText( "^2[ ^71 ^2]" );
		start SetPulseFX( 100, 4000, 500 );
		wait 1.8;
		start setText( "^2[ ^7GO ^2]" );
		start SetPulseFX( 100, 4000, 500 );
		
		player freezeControls(0);
		level.activ freezeControls(0);
		
		wait 4;
		
		start destroy();
		
		while( isAlive( player ) && isDefined( player ) )
			wait 1;
    }
    wait 0.05;
}

endroom_old()
{
	level.old = getEnt ( "endroom_old_trigger", "targetname" );
	target_1 = getEnt ( "endroom_old_door_1", "targetname" );
	blocker = getEnt ( "endroom_old_blocker", "targetname" );
	
	level.old waittill ( "trigger", player );
	level.old delete();
	
	level.jump delete();
	level.snipe delete();
	level.knife delete();
	level.weap delete();
	
	iPrintlnBold( " ^2" + player.name + " ^7 has choosen the old way" );
	
	blocker delete();
	target_1 moveZ ( -100, 4, 2, 0.5);
	wait 0.5;
	thread endroom_old_ground();
	wait 3.5;
}

endroom_old_ground()
{
	target = getEnt ( "endroom_old_ground", "targetname" );
	target_1 = getEnt ( "endroom_old_door_2", "targetname" );
	
	target moveZ ( -144, 4);
	target_1 moveZ ( -100, 4, 2, 0.5);
	wait 4;
}

endroom_weapon()
{
	level.weap = getent ( "endroom_weap_trigger", "targetname" );
	level.weap_acti_respawn = getent ( "weap_acti_respawn","targetname" );
	level.weap_jumper_respawn = getent ( "weap_jumper_respawn","targetname" );

    level.weap waittill( "trigger", player );

// ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================
			
	level.jump delete();
	level.snipe delete();
	level.old delete();
	level.knife delete();
			
	player freezeControls(1);
	level.activ freezeControls(1);
		
	player disableWeapons(1);
	level.activ disableWeapons(1);
			
	noti = SpawnStruct();
	noti.titleText = "^2Weapon Room";
	noti.notifyText = "^2" + player.name + "^7 has choosen the Weapon Room";
	noti.duration = 5;
	noti.glowcolor = (0, 0.9, 2);
	players = getEntArray( "player", "classname" );
	for( i=0;i<players.size;i++ )
	players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
	wait 3;
        
    player setOrigin( level.weap_jumper_respawn.origin );
	player setPlayerangles( level.weap_jumper_respawn.angles );
		
	player TakeAllWeapons();
	wait 0.05;
	player GiveWeapon( "ak47_mp" );
	player GiveWeapon( "winchester1200_mp" );
	player GiveMaxAmmo( "ak47_mp" );
	player GiveMaxAmmo( "winchester1200_mp" );
		
	level.activ setOrigin( level.weap_acti_respawn.origin );
	level.activ setPlayerangles( level.weap_acti_respawn.angles );	
		
	level.activ TakeAllWeapons();
	wait 0.05;
	level.activ GiveWeapon( "ak47_mp" );
	level.activ GiveWeapon( "winchester1200_mp" );
	level.activ GiveMaxAmmo( "ak47_mp" );
	level.activ GiveMaxAmmo( "winchester1200_mp" );
	
	player.maxhealth = 600;
	player.health = player.maxhealth;
		
	wait 0.05;
	player switchToWeapon( "ak47_mp" );
	level.activ switchToWeapon( "ak47_mp" );
		
	start = NewHudElem();
	start.alignX = "center";
	start.alignY = "middle";
	start.horzalign = "center";
	start.vertalign = "middle";
	start.alpha = 1;
	start.x = 0;
	start.y = -50;
	start.font = "objective";
	start.fontscale = 3;
	start.glowalpha = 1;
	start.glowcolor = ( 0, 1, 0 );
	start setText( "^2[ ^73 ^2]" );
	start SetPulseFX( 100, 4000, 500 );
	wait 1.6;
	start setText( "^2[ ^72 ^2]" );
	start SetPulseFX( 100, 4000, 500 );
	wait 1.6;
		
	player enableWeapons(1);
	level.activ enableWeapons(1);
	player switchToWeapon( "ak47_mp" );
	level.activ switchToWeapon( "ak47_mp" );
		
	start setText( "^2[ ^71 ^2]" );
	start SetPulseFX( 100, 4000, 500 );
	wait 1.8;
	start setText( "^2[ ^7GO ^2]" );
	start SetPulseFX( 100, 4000, 500 );
		
	player freezeControls(0);
	level.activ freezeControls(0);
		
	wait 4;
		
	start destroy();
	thread weap();
}

weap()
{
	while(1)
	{
		level.weap waittill( "trigger", player );
		wait 0.05;
	
		player setOrigin( level.weap_jumper_respawn.origin );
		player setPlayerangles( level.weap_jumper_respawn.angles );
		wait 0.05;
	
		player TakeAllWeapons();
		wait 0.05;
		player GiveWeapon( "ak47_mp" );
		player GiveWeapon( "winchester1200_mp" );
		player GiveMaxAmmo( "ak47_mp" );
		player GiveMaxAmmo( "winchester1200_mp" );
		wait 0.05;
		
		player switchToWeapon( "ak47_mp" );
	
		start = NewHudElem();
		start.alignX = "center";
		start.alignY = "middle";
		start.horzalign = "center";
		start.vertalign = "middle";
		start.alpha = 1;
		start.x = 0;
		start.y = -50;
		start.font = "objective";
		start.glowalpha = 1;
		start.glowcolor = ( 0, 1, 0 );
		start setText( "^2" + player.name + "^7 entered the Weapon Room" );
		start SetPulseFX( 100, 4000, 500 );
		wait 3;
	}
}