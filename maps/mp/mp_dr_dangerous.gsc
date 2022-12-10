main()

{

maps\mp\_load::main();

	game["allies"] = "marines";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "desert";
	game["axis_soldiertype"] = "desert";

	setDvar("bg_falldamagemaxheight", 20000 );
	setDvar("bg_falldamageminheight", 15000 );

	thread door_opens1();
	thread door_opens2();
	thread start_door();
	thread old();
	thread sniper_f();
	thread sniper();
	thread jump();
	thread jump_port_j();
	thread jump_port_a();
	thread jumpweap();
	thread knife();
	thread t1();
	thread t2_1();
	thread t2_2();
	thread t2_3();
	thread t2_4();
	thread t2_5();
	thread t3_1();
	thread t3_2();
	thread t3_3();
	thread t4_1();
	thread t4_2();
	thread t4_3();
	thread t4_4();
	thread t4_5();
	thread t4_6();
	thread t5_1();
	thread t5_2();
	thread t5_3();
	thread t5_4();
	thread t5_5();
	thread t6_1();
	thread t6_2();
	thread t6_3();
	thread t6_4();
	thread inga_1();
	thread inga_2();
	thread inga_3();
	thread inga_4();
	thread inga_5();
	thread inga_6();
	thread inga_7();
	thread inga_8();
	thread inga_9();
	thread inga_10();
	thread t7_1();
	thread t7_2();
	thread t7_3();
	thread m1();
	thread m2();
	thread m3();
	thread m4();
	thread m5();
	thread m6();
	thread m8();
	thread musicport();
	//thread setupServers();
	//thread server_portal();
	thread back_portal();
	thread lazloo();

	addTriggerToList("trap1_t1");
	addTriggerToList("trap2_t1");
	addTriggerToList("trap3_t1");
	addTriggerToList("trap4_t1");
	addTriggerToList("trap5_t1");
	addTriggerToList("trap6_t1");
	addTriggerToList("trap7_t1");
	addTriggerToList("inga_t");

}

addTriggerToList( name )
{
    if( !isDefined( level.trapTriggers ) )
        level.trapTriggers = [];
    level.trapTriggers[level.trapTriggers.size] = getEnt( name, "targetname" );
}

door_opens1()

{

	brushm = getent( "m_door", "targetname" );
	m_letters = getent( "m_letters", "targetname" );

	level waittill( "player_spawn" );

	wait 5;
	brushm movey( 7, 1, .3, .3 );
	m_letters movey( 7, 1, .3, .3 );
	wait 1.2;
	brushm movex( -88, 2, .7, .7 );
	m_letters movex( -88, 2, .7, .7 );
	brushm waittill ("movedone");
	m_letters waittill ("movedone");
	
}

door_opens2()

{
	brushs = getent( "s_door", "targetname" );
	s_letters = getent( "s_letters", "targetname" );

	level waittill( "player_spawn" );

	wait 5;
	brushs movey( 7, 1, .3, .3 );
	s_letters movey( 7, 1, .3, .3 );
	wait 1.2;
	brushs movex( 88, 2, .7, .7 );
	s_letters movex( 88, 2, .7, .7 );
	brushs waittill ("movedone");
	s_letters waittill ("movedone");
	
}

start_door()
{

	brush1 = getent( "door1", "targetname" );
	brush4 = getent( "door4", "targetname" );
	brush5 = getent( "door5", "targetname" );
	brush7 = getent( "trap7_off", "targetname" );
	sound1 = getent( "door", "targetname" );
	sound2 = getent( "weight", "targetname" );

	level waittill( "player_spawn" );
	brush7 notsolid();

	wait 5;
	sound1 playsound("door");
	brush1 movez( 232, 10, 3, 3 );
	brush4 movez( -128, 5, 1, 1 );
	wait 5;
	sound2 playsound("weight");
	brush5 movez( -128, 5, 1, 1 );
	sound2 playsound("weight");
	wait 5;
	sound2 playsound("weight");
	wait 1;
	//ambientPlay("manafest",0);
}

old()
{
	brush1 = getent( "door1_1", "targetname" );
	brush2 = getent( "door1_2", "targetname" );
	brush3 = getent( "door1_3", "targetname" );
	brush4 = getent( "door1_4", "targetname" );
	knife_off = getEnt( "knife_off", "targetname" );
	jump_off = getEnt( "jump_off", "targetname" );
	snip_off = getEnt( "snip_off", "targetname" );
	level.old_trig = getent( "door1_t", "targetname" );

		level.old_trig waittill( "trigger" );
		
		level.old_trig delete();
		level.final_sniper_trig delete();
		level.final_knife_trig delete();
		level.final_jump_trig delete();

		knife_off movez( -150, 6, 1, 1 );
		jump_off movez( -150, 6, 1, 1 );
		snip_off movez( -150, 6, 1, 1 );
		knife_off notsolid();
		jump_off notsolid();
		snip_off notsolid();
	
		brush1 rotatepitch( -360, 0.4, 0, 0.2 );
		brush2 rotatepitch( -360, 0.4, 0, 0.2 );
		brush3 rotatepitch( -360, 0.4, 0, 0.2 );
		brush4 rotatepitch( -360, 0.4, 0, 0.2 );
		wait 0.5;
		brush1 movez ( 44, 0.7, 0.2, 0.2 );
		brush2 movex ( 44, 0.7, 0.2, 0.2 );
		brush3 movez ( -44, 0.7, 0.2, 0.2 );
		brush4 movex ( -44, 0.7, 0.2, 0.2 );
		wait 0.7;
		brush1 notsolid();
		brush2 notsolid();
		brush3 notsolid();
		brush4 notsolid();
}

sniper_f()
{

	brush1 = getent( "snip_f_1", "targetname" );
	brush2 = getent( "snip_f_2", "targetname" );
	brush3 = getent( "snip_f_3", "targetname" );
	brush4 = getent( "snip_f_4", "targetname" );

	level waittill( "player_spawn" );
	wait 5;

	while(1)
	{
	brush1 movez( -88, 3, 1, 1 );
	wait 5;
	brush1 movez( 88, 3, 1, 1 );
	brush2 movez( -88, 3, 1, 1 );
	wait 5;
	brush3 movez( -88, 4, 1, 1 );
	brush2 movez( 88, 3, 1, 1 );
	wait 5;
	brush4 movez( -88, 3, 1, 1 );
	brush3 movez( 88, 3, 1, 1 );
	wait 5;
	brush4 movez( 88, 3, 1, 1 );
	}
}

sniper()
{

	level.final_sniper_trig = getEnt( "final_sniper_trig", "targetname");
	jump = getEnt( "sniper_j", "targetname" );
	acti = getEnt( "sniper_a", "targetname" );
	knife_off = getEnt( "knife_off", "targetname" );
	jump_off = getEnt( "jump_off", "targetname" );
	

	while(1)
	{
	level.final_sniper_trig waittill( "trigger", player );
	if( !isDefined( level.final_sniper_trig ) )
            return;

			// ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================
        
		level.final_knife_trig delete();
		level.final_jump_trig delete();
		level.old_trig delete();

	knife_off movez( -150, 6, 1, 1 );
	jump_off movez( -150, 6, 1, 1 );
	jump_off notsolid();
	knife_off notsolid();
		
        player.health = player.maxhealth;
	level.activ.health = level.activ.maxhealth;
	player SetPlayerAngles( jump.angles );
	player setOrigin( jump.origin );
	player TakeAllWeapons();
	player GiveWeapon( "remington700_mp" );
	player GiveWeapon( "m40a3_mp" );        
	level.activ setPlayerangles( acti.angles );
	level.activ setOrigin( acti.origin );
	level.activ TakeAllWeapons();
	level.activ GiveWeapon( "remington700_mp" );
	level.activ GiveWeapon( "m40a3_mp" );         
        wait 0.05;
        player switchToWeapon( "remington700_mp" ); 
        level.activ SwitchToWeapon( "remington700_mp" );
        player FreezeControls(1);
		level.activ FreezeControls(1);
		noti = SpawnStruct();
				noti.titleText = "Sniper Room";
				noti.notifyText = level.activ.name + " ^4VS^7 " + player.name;
				noti.glowcolor = (3,7,0.9);
				noti.duration = 5;
				players = getentarray("player", "classname");
				for(i=0;i<players.size;i++)
					players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
				wait 5;
				player FreezeControls(0);
				level.activ FreezeControls(0);
	while( isAlive( player ) && isDefined( player ) )
	wait 1;
			
    }

}

jump_port_j()
{
port_t = getent("port_j", "targetname");
to = getent("to1", "targetname");
	for(;;)
	{
	port_t waittill("trigger", player);
	wait(0.05);
	player setOrigin( to.origin );
	player setplayerangles( to.angles );	
	wait(0.05);
	}
}

jump_port_a()
{
port_t = getent("port_a", "targetname");
to = getent("to2", "targetname");
	for(;;)
	{
	port_t waittill("trigger", player);
	wait(0.05);
	player setOrigin( to.origin );
	player setplayerangles( to.angles );	
	wait(0.05);
	}
}

jump()
{

	level.final_jump_trig = getEnt( "final_jump_trig", "targetname");
	jump = getEnt( "jump_j", "targetname" );
	acti = getEnt( "jump_a", "targetname" );
	knife_off = getEnt( "knife_off", "targetname" );
	snip_off = getEnt( "snip_off", "targetname" );
	

	while(1)
	{
	level.final_jump_trig waittill( "trigger", player );
	if( !isDefined( level.final_jump_trig ) )
            return;

			// ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================

		level.old_trig delete();
		level.final_sniper_trig delete();
		level.final_knife_trig delete();

	knife_off movez( -150, 6, 1, 1 );
	snip_off movez( -150, 6, 1, 1 );
	knife_off notsolid();
	snip_off notsolid();
		
        player.health = player.maxhealth;
	level.activ.health = level.activ.maxhealth;
	player SetPlayerAngles( jump.angles );
	player setOrigin( jump.origin );
	player TakeAllWeapons();
	player GiveWeapon( "knife_mp" );  
	level.activ setPlayerangles( acti.angles );
	level.activ setOrigin( acti.origin );
	level.activ TakeAllWeapons();
	level.activ GiveWeapon( "knife_mp" );      
        wait 0.05;
        player switchToWeapon( "knife_mp" );    
        level.activ SwitchToWeapon( "knife_mp" );    
        player FreezeControls(1);
		level.activ FreezeControls(1);
		noti = SpawnStruct();
				noti.titleText = "Jump Room";
				noti.notifyText = level.activ.name + " ^4VS^7 " + player.name;
				noti.glowcolor = (2,7,0.9);
				noti.duration = 5;
				players = getentarray("player", "classname");
				for(i=0;i<players.size;i++)
					players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
				wait 5;
				player FreezeControls(0);
				level.activ FreezeControls(0);
	while( isAlive( player ) && isDefined( player ) )
	wait 1;
			
    }

}

jumpweap()
{

	level.jump_weapon = getEnt( "jump_weapon", "targetname");

	while(1)
	{
	level.jump_weapon waittill( "trigger", player );
		
	player GiveWeapon( "remington700_mp" );       
	player GiveWeapon( "remington700_mp" );        
        wait 0.05;
        player switchToWeapon( "remington700_mp" ); 
        player SwitchToWeapon( "remington700_mp" );
    }

}

knife()
{

	level.final_knife_trig = getEnt( "final_knife_trig", "targetname");
    	jump = getEnt( "knife_j", "targetname" );
    	acti = getEnt( "knife_a", "targetname" );
	jump_off = getEnt( "jump_off", "targetname" );
	snip_off = getEnt( "snip_off", "targetname" );
	
     while(1)
    {
        level.final_knife_trig waittill( "trigger", player );
        if( !isDefined( level.final_knife_trig ) )
            return;

			// ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================

		level.old_trig delete();
		level.final_sniper_trig delete();
        	level.final_jump_trig delete();

		jump_off movez( -150, 6, 1, 1 );
		snip_off movez( -150, 6, 1, 1 );
		jump_off notsolid();
		snip_off notsolid();
      
         player.health = player.maxhealth;
		 level.activ.health = level.activ.maxhealth;
		player SetPlayerAngles( jump.angles );
        player setOrigin( jump.origin );
        player TakeAllWeapons();
        player GiveWeapon( "knife_mp" );
		player GiveWeapon( "knife_mp" );        
        level.activ setPlayerangles( acti.angles );
        level.activ setOrigin( acti.origin );
        level.activ TakeAllWeapons();
        level.activ GiveWeapon( "knife_mp" );
        level.activ GiveWeapon( "knife_mp" );         
        wait 0.05;
        player switchToWeapon( "knife_mp" ); 
        level.activ SwitchToWeapon( "knife_mp" );
        player FreezeControls(1);
		level.activ FreezeControls(1);
		noti = SpawnStruct();
				noti.titleText = "Knife Room";
				noti.notifyText = level.activ.name + " ^4VS^7 " + player.name;
				noti.glowcolor = (4,7,0.9);
				noti.duration = 5;
				players = getentarray("player", "classname");
				for(i=0;i<players.size;i++)
					players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
				wait 5;
				player FreezeControls(0);
				level.activ FreezeControls(0);
        while( isAlive( player ) && isDefined( player ) )
            wait 1;
    }
}

t1()
{

	brush1 = [];
    	brush1[0] = getent( "trap1_1", "targetname" );
	brush1[1] = getent( "trap1_2", "targetname" );
	sound = getent( "warning_s_1", "targetname" );

	brush2 = [];
    	brush2[0] = getent( "trap1_3", "targetname" );
	brush2[1] = getent( "trap1_4", "targetname" );

	trig = getent( "trap1_t1", "targetname" );

	trig waittill( "trigger" );

	sound playsound("warning1");
	sound movez( -2, .4 );

	trig setHintString( "^4Trap Activated!" );
	
		brush1[randomint( brush1.size )] movez ( -492, 1, .1, .2 );

		brush2[randomint( brush2.size )] movez ( -492, 1, .1, .2 );
}


t2_1()
{
	brush = getent( "trap2_1", "targetname" );
	trig = getent( "trap2_t1", "targetname" );
	sound = getent( "warning_s_2", "targetname" );

	trig waittill( "trigger" );

	sound playsound("warning1");
	sound movez( -2, .4 );

	while(1)
	{
		brush movex( 376, 1, .1, .1 );
		brush waittill ("movedone");
		wait .1;
		brush movex( -376, 1, .1, .1 );
		brush waittill ("movedone");
		wait .1;
	}
}

t2_2()
{
	brush = getent( "trap2_2", "targetname" );
	trig = getent( "trap2_t1", "targetname" );

	trig waittill( "trigger" );

	while(1)
	{
		brush movex( -376, 1, .1, .1 );
		brush waittill ("movedone");
		brush movex( 376, 1, .1, .1 );
		brush waittill ("movedone");
	}
}

t2_3()
{
	brush = getent( "trap2_3", "targetname" );
	trig = getent( "trap2_t1", "targetname" );

	trig waittill( "trigger" );

	while(1)
	{
		brush movex( 376, 1.1, .1, .1 );
		brush waittill ("movedone");
		brush movex( -376, 1, .1, .1 );
		brush waittill ("movedone");
	}
}

t2_4()
{
	brush = getent( "trap2_4", "targetname" );
	trig = getent( "trap2_t1", "targetname" );

	trig waittill( "trigger" );

	while(1)
	{
		brush movex( -376, 1, .1, .1 );
		brush waittill ("movedone");
		brush movex( 376, .9, .1, .1 );
		brush waittill ("movedone");
	}
}

t2_5()
{
	brush = getent( "trap2_5", "targetname" );
	trig = getent( "trap2_t1", "targetname" );

	trig waittill( "trigger" );
	trig setHintString("^4Trap Activated!");

	while(1)
	{
		brush movey( -1088, 3, .1, .1 );
		brush waittill ("movedone");
		brush movey( 1088, 3, .1, .1 );
		brush waittill ("movedone");
		brush movey( -1088, 2.5, .1, .1 );
		brush waittill ("movedone");
		brush movey( 1088, 2.5, .1, .1 );
		brush waittill ("movedone");
		brush movey( -1088, 5, .1, .1 );
		brush waittill ("movedone");
		brush movey( 1088, 2.5, .1, .1 );
		brush waittill ("movedone");
		brush movey( -1088, 2.5, .1, .1 );
		brush waittill ("movedone");
		brush movey( 1088, 5, .1, .1 );
		brush waittill ("movedone");
	}
}

t3_1()
{
	brush = getent( "trap3_1", "targetname" );
	trig = getent( "trap3_t1", "targetname" );
	sound = getent( "warning_s_3", "targetname" );

	trig waittill( "trigger" );

	sound playsound("warning1");
	sound movez( -2, .4 );

	while(1)
	{
		brush movex( -264, 1.5, .1, .1 );
		brush waittill ("movedone");
		brush movex( 264, 1.5, .1, .1 );
		brush waittill ("movedone");
		brush movex( -264, 1.8, .1, .1 );
		brush waittill ("movedone");
		brush movex( 264, 1.5, .1, .1 );
		brush waittill ("movedone");
		brush movex( -264, 1.6, .1, .1 );
		brush waittill ("movedone");
		brush movex( 264, 1.7, .1, .1 );
		brush waittill ("movedone");
		brush movex( -264, 1.5, .1, .1 );
		brush waittill ("movedone");
		brush movex( 264, 1.4, .1, .1 );
		brush waittill ("movedone");
	}
}

t3_2()
{
	brush = getent( "trap3_2", "targetname" );
	trig = getent( "trap3_t1", "targetname" );

	trig waittill( "trigger" );

	while(1)
	{
		brush movex( 264, 1.5, .1, .1 );
		brush waittill ("movedone");
		brush movex( -264, 1.5, .1, .1 );
		brush waittill ("movedone");
		brush movex( 264, 1.4, .1, .1 );
		brush waittill ("movedone");
		brush movex( -264, 1.4, .1, .1 );
		brush waittill ("movedone");
		brush movex( 264, 1.8, .1, .1 );
		brush waittill ("movedone");
		brush movex( -264, 1.8, .1, .1 );
		brush waittill ("movedone");
		brush movex( 264, 1.4, .1, .1 );
		brush waittill ("movedone");
		brush movex( -264, 1.4, .1, .1 );
		brush waittill ("movedone");
	}
}

t3_3()
{
	brush = getent( "trap3_3", "targetname" );
	trig = getent( "trap3_t1", "targetname" );

	trig waittill( "trigger" );
	trig setHintString("^4Trap Activated!");

	while(1)
	{
		brush rotateyaw( 720, 10, 1, 1 );
		brush waittill ("rotatedone");
		brush rotateyaw( -720, 10, 1, 1 );
		brush waittill ("rotatedone");
		brush rotateyaw( 360, 5, 1, 1 );
		brush waittill ("rotatedone");
		brush rotateyaw( -360, 5, 1, 1 );
		brush waittill ("rotatedone");
		brush rotateyaw( 360, 5, 1, 1 );
		brush waittill ("rotatedone");
		brush rotateyaw( -720, 10, 1, 1 );
		brush waittill ("rotatedone");
	}
}


t4_1()
{
	brush = getent( "trap4_1", "targetname" );
	trig = getent( "trap4_t1", "targetname" );
	sound = getent( "warning_s_4", "targetname" );

	trig waittill( "trigger" );

	sound playsound("warning1");
	sound movez( -2, .4 );

	while(1)
	{
		brush rotateyaw( 360, 3.1 );
		brush waittill ("rotatedone");
		brush rotateyaw( -360, 6 );
		brush waittill ("rotatedone");
	}
}

t4_2()
{
	brush = getent( "trap4_2", "targetname" );
	trig = getent( "trap4_t1", "targetname" );

	trig waittill( "trigger" );

	while(1)
	{
		brush rotateyaw( -360, 3 );
		brush waittill ("rotatedone");
		brush rotateyaw( 720, 6 );
		brush waittill ("rotatedone");
	}
}

t4_3()
{
	brush = getent( "trap4_3", "targetname" );
	trig = getent( "trap4_t1", "targetname" );

	trig waittill( "trigger" );

	while(1)
	{
		brush rotateyaw( 360, 3.5 );
		brush waittill ("rotatedone");
		brush rotateyaw( -720, 6 );
		brush waittill ("rotatedone");
	}
}

t4_4()
{
	brush = getent( "trap4_4", "targetname" );
	trig = getent( "trap4_t1", "targetname" );

	trig waittill( "trigger" );

	while(1)
	{
		brush rotateyaw( -360, 2.5 );
		brush waittill ("rotatedone");
		brush rotateyaw( 360, 2.5 );
		brush waittill ("rotatedone");
	}
}

t4_5()
{
	brush = getent( "trap4_5", "targetname" );
	trig = getent( "trap4_t1", "targetname" );

	trig waittill( "trigger" );

	while(1)
	{
		brush rotateyaw( 360, 2.6 );
		brush waittill ("rotatedone");
		brush rotateyaw( -720, 5.5 );
		brush waittill ("rotatedone");
	}
}

t4_6()
{
	brush = getent( "trap4_6", "targetname" );
	trig = getent( "trap4_t1", "targetname" );

	trig waittill( "trigger" );
	trig setHintString("^4Trap Activated!");

	while(1)
	{
		brush rotateyaw( 360, 3 );
		brush waittill ("rotatedone");
		brush rotateyaw( -360, 2.7 );
		brush waittill ("rotatedone");
	}
}

t5_1()
{
	brush = getent( "trap5_1", "targetname" );
	trig = getent( "trap5_t1", "targetname" );
	sound = getent( "warning_s_5", "targetname" );

	trig waittill( "trigger" );

	sound playsound("warning1");
	sound movez( -2, .4 );

	while(1)
	{
		brush movex( 64, .5 );
		brush waittill ("movedone");
		wait .5;
		brush movex( -64, .5 );
		brush waittill ("movedone");
		wait .5;
	}
}

t5_2()
{
	brush = getent( "trap5_2", "targetname" );
	trig = getent( "trap5_t1", "targetname" );

	trig waittill( "trigger" );

	while(1)
	{
		brush movex( 64, .4 );
		brush waittill ("movedone");
		brush movex( -64, .4 );
		brush waittill ("movedone");
		wait .5;
	}
}

t5_3()
{
	brush = getent( "trap5_3", "targetname" );
	trig = getent( "trap5_t1", "targetname" );

	trig waittill( "trigger" );

	while(1)
	{
		brush movex( 64, .6 );
		brush waittill ("movedone");
		wait .2;
		brush movex( -64, .4 );
		brush waittill ("movedone");
		wait .5;
	}
}

t5_4()
{
	brush = getent( "trap5_4", "targetname" );
	trig = getent( "trap5_t1", "targetname" );

	trig waittill( "trigger" );

	while(1)
	{
		brush movex( 64, .3 );
		brush waittill ("movedone");
		wait .2;
		brush movex( -64, .3 );
		brush waittill ("movedone");
		wait .5;
	}
}

t5_5()
{
	brush = getent( "trap5_5", "targetname" );
	trig = getent( "trap5_t1", "targetname" );

	trig waittill( "trigger" );
	trig setHintString("^4Trap Activated!");

	while(1)
	{
		brush movex( 64, .4 );
		brush waittill ("movedone");
		brush movex( -64, .5 );
		brush waittill ("movedone");
		wait .4;
	}
}

t6_1()
{
	brush = getent( "trap6_1", "targetname" );
	trig = getent( "trap6_t1", "targetname" );
	sound = getent( "warning_s_6", "targetname" );

	trig waittill( "trigger" );

	sound playsound("warning1");
	sound movez( -2, .4 );

	while(1)
	{
		brush rotateyaw( 720, 6 );
		wait 6;
	}
}

t6_2()
{
	brush = getent( "trap6_2", "targetname" );
	trig = getent( "trap6_t1", "targetname" );

	trig waittill( "trigger" );

	while(1)
	{
		brush rotateyaw( -360, 3.1 );
		wait 3;
	}
}

t6_3()
{
	brush = getent( "trap6_3", "targetname" );
	trig = getent( "trap6_t1", "targetname" );

	trig waittill( "trigger" );

	while(1)
	{
		brush rotateyaw( -720, 5.4 );
		wait 5.4;
	}
}

t6_4()
{
	brush = getent( "trap6_4", "targetname" );
	trig = getent( "trap6_t1", "targetname" );

	trig waittill( "trigger" );
	trig setHintString("^4Trap Activated!");

	while(1)
	{
		brush rotateyaw( 360, 4.5);
		wait 4.5;
	}
}

inga_1()
{
	brush = getent( "inga1", "targetname" );
	trig = getent( "inga_t", "targetname" );
	sound = getent( "warning_s_inga", "targetname" );

	trig waittill( "trigger" );

	sound playsound("warning1");
	sound movez( -2, .4 );

	while(1)
	{
		brush rotateroll( 90, 1.2, 0.5, 0.5);
		brush waittill ("rotatedone");
		brush rotateroll( -90, 1.2, 0.5, 0.5);
		brush waittill ("rotatedone");
	}
}

inga_2()
{
	brush = getent( "inga2", "targetname" );
	trig = getent( "inga_t", "targetname" );

	trig waittill( "trigger" );

	wait .1;
	while(1)
	{
		brush rotateroll( 90, 1.2, 0.5, 0.5);
		brush waittill ("rotatedone");
		brush rotateroll( -90, 1.2, 0.5, 0.5);
		brush waittill ("rotatedone");
	}
}

inga_3()
{
	brush = getent( "inga3", "targetname" );
	trig = getent( "inga_t", "targetname" );

	trig waittill( "trigger" );

	wait .2;
	while(1)
	{
		brush rotateroll( 90, 1.2, 0.5, 0.5);
		brush waittill ("rotatedone");
		brush rotateroll( -90, 1.2, 0.5, 0.5);
		brush waittill ("rotatedone");
	}
}

inga_4()
{
	brush = getent( "inga4", "targetname" );
	trig = getent( "inga_t", "targetname" );

	trig waittill( "trigger" );

	wait .3;
	while(1)
	{
		brush rotateroll( 90, 1.2, 0.5, 0.5);
		brush waittill ("rotatedone");
		brush rotateroll( -90, 1.2, 0.5, 0.5);
		brush waittill ("rotatedone");
	}
}

inga_5()
{
	brush = getent( "inga5", "targetname" );
	trig = getent( "inga_t", "targetname" );

	trig waittill( "trigger" );

	wait .4;
	while(1)
	{
		brush rotateroll( 90, 1.2, 0.5, 0.5);
		brush waittill ("rotatedone");
		brush rotateroll( -90, 1.2, 0.5, 0.5);
		brush waittill ("rotatedone");
	}
}

inga_6()
{
	brush = getent( "inga6", "targetname" );
	trig = getent( "inga_t", "targetname" );

	trig waittill( "trigger" );

	wait .5;
	while(1)
	{
		brush rotateroll( 90, 1.2, 0.5, 0.5);
		brush waittill ("rotatedone");
		brush rotateroll( -90, 1.2, 0.5, 0.5);
		brush waittill ("rotatedone");
	}
}

inga_7()
{
	brush = getent( "inga7", "targetname" );
	trig = getent( "inga_t", "targetname" );

	trig waittill( "trigger" );

	wait .6;
	while(1)
	{
		brush rotateroll( 90, 1.2, 0.5, 0.5);
		brush waittill ("rotatedone");
		brush rotateroll( -90, 1.2, 0.5, 0.5);
		brush waittill ("rotatedone");
	}
}

inga_8()
{
	brush = getent( "inga8", "targetname" );
	trig = getent( "inga_t", "targetname" );

	trig waittill( "trigger" );

	wait .7;
	while(1)
	{
		brush rotateroll( 90, 1.2, 0.5, 0.5);
		brush waittill ("rotatedone");
		brush rotateroll( -90, 1.2, 0.5, 0.5);
		brush waittill ("rotatedone");
	}
}

inga_9()
{
	brush = getent( "inga9", "targetname" );
	trig = getent( "inga_t", "targetname" );

	trig waittill( "trigger" );

	wait .8;
	while(1)
	{
		brush rotateroll( 90, 1.2, 0.5, 0.5);
		brush waittill ("rotatedone");
		brush rotateroll( -90, 1.2, 0.5, 0.5);
		brush waittill ("rotatedone");
	}
}

inga_10()
{
	brush = getent( "inga10", "targetname" );
	trig = getent( "inga_t", "targetname" );

	trig waittill( "trigger" );
	trig setHintString("^4Trap Activated!");

	wait .9;
	while(1)
	{
		brush rotateroll( 90, 1.2, 0.5, 0.5);
		brush waittill ("rotatedone");
		brush rotateroll( -90, 1.2, 0.5, 0.5);
		brush waittill ("rotatedone");
	}
}


t7_1()
{
	trig = getent( "trap7_t1", "targetname" );
	brush = getent( "trap7_1", "targetname" );
	sound = getent( "warning_s_7", "targetname" );

	trig waittill( "trigger" );

	sound playsound("warning1");
	sound movez( -2, .4 );

	while(1)
	{
		brush movey( 104, 1.2, 0.5, 0.5);
		brush waittill ("movedone");
		brush movey( -104, 1.2, 0.5, 0.5);
		brush waittill ("movedone");
	}
}

t7_2()
{
	trig = getent( "trap7_t1", "targetname" );
	brush = getent( "trap7_2", "targetname" );

	trig waittill( "trigger" );

	while(1)
	{
		brush movey( -96, 1.1, 0.5, 0.5);
		brush waittill ("movedone");
		brush movey( 96, 1.1, 0.5, 0.5);
		brush waittill ("movedone");
	}
}

t7_3()
{
	trig = getent( "trap7_t1", "targetname" );
	brush = getent( "trap7_3", "targetname" );

	trig waittill( "trigger" );
	trig setHintString("^4Trap Activated!");

	while(1)
	{
		brush movey( -130, 1.3, 0.5, 0.5);
		brush waittill ("movedone");
		brush movey( 130, 1.3, 0.5, 0.5);
		brush waittill ("movedone");
	}
}

m1()
{
	trig = getent ("music_7", "targetname");
	brush = getent ("music_b", "targetname");

	trig waittill ( "trigger" );
	brush notsolid();
	//ambientStop(0);
	ambientPlay("minor");
	iprintlnbold("^9Started music: ^4Fort Minor - Remember The Name");
	trig delete();
}

m2()
{
	level.music_0 = getent ("music_0", "targetname");
	brush = getent ("music_b", "targetname");

	level.music_0 waittill ( "trigger" );
	brush notsolid();
	ambientPlay("manafest");
	iprintlnbold("^9Started music: ^4Manafest - No Plan B");
	level.music_0 delete();
}

m3()
{
	trig = getent ("music_3", "targetname");
	brush = getent ("music_b", "targetname");

	trig waittill ( "trigger" );
	brush notsolid();
	//ambientStop(0);
	ambientPlay("beast");
	iprintlnbold("^9Started music: ^4BEAST by Rob Bailey & The Hustle Standard");
	trig delete();
}
	
m4()
{
	trig = getent ("music_4", "targetname");
	brush = getent ("music_b", "targetname");

	trig waittill ( "trigger" );
	brush notsolid();
	trig delete();
	//ambientStop(0);
	ambientPlay("vlegel");
	iprintlnbold("^9Started music: ^4Vlegel - After Night in Ibiza");
}

m5()
{
	trig = getent ("music_5", "targetname");
	brush = getent ("music_b", "targetname");

	trig waittill ( "trigger" );
	brush notsolid();
	//ambientStop(0);
	ambientPlay("hu");
	iprintlnbold("^9Started music: ^4Hollywood Undead - Comin' In Hot");
	trig delete();
}
	
m6()
{
	trig = getent ("music_6", "targetname");
	brush = getent ("music_b", "targetname");

	trig waittill ( "trigger" );
	brush notsolid();
	trig delete();
	//ambientStop(0);
	ambientPlay("control");
	iprintlnbold("^9Started music: ^4Krewella - Can't Control Myself");
}

m8()
{
	trig = getent ("music_8", "targetname");
	brush = getent ("music_b", "targetname");

	trig waittill ( "trigger" );
	brush notsolid();
	trig delete();
	//ambientStop(0);
	ambientPlay("jasper");
	iprintlnbold("^9Started music: ^4Jasper Forks - Another Sleepless Night"); 
}

musicport()
{
	port_t = getent("music_port", "targetname");
	to = getent("to3", "targetname");
	brushm = getent( "m_door", "targetname" );
	m_letters = getent( "m_letters", "targetname" );

	level waittill( "player_spawn" );
	wait 10;

		for(;;)
		{
		port_t waittill("trigger", player);
		port_t delete();
		wait(0.05);
		player setOrigin( to.origin );
		player setplayerangles( to.angles );
		player iPrintLnBold("^4Music room.");	
		wait(0.05);
		brushm notsolid();
		m_letters notsolid();
		brushm movex( 88, 2, .7, .7 );
		m_letters movex( 88, 2, .7, .7 );
		wait 2.2;
		brushm movey( -7, 1, .3, .3 );
		m_letters movey( -7, 1, .3, .3 );
		wait 1.2;
		brushm waittill ("movedone");
		m_letters waittill ("movedone");
		}
}

setupServers()
{
	serv_dr = getEnt( "server_deathrun", "targetname" );
	
	serv_dr thread serverTrigger( "club27.hu:30001", "club^127 D^7eath^1R^7un" );
}

serverTrigger( ip, name )
{
	level endon( "game over" );
	
	while(1)
	{
		self waittill( "trigger", player );
		
		if( !isDefined( player.server_name ) || player.server_name != name  )
		{
			player notify( "change_server" );
			wait 0.05;
			
			player.server_name = name;
			player thread serverMessage( ip, name );

		}
		else
			player notify( "server_choice" );
		
		wait 0.05;
	}
}

serverMessage( ip, name )
{
	level endon( "game over" );
	self endon( "disconnect" );
	self endon( "change_server" );
	
	self iPrintLnBold( "^9WARNING^7! ^9READ IT CAREFULLY^7!" );
	self iPrintLnBold( "If you ^9USE ^7the ^9Hyperspace Gate^7, then you will be" );
	self iPrintLnBold( "teleported to the club^927 D^7eath^9R^7un Server^9!" );
	
	while(1)
	{
		self waittill( "server_choice" );

		if( getDvar( "ip" ) == "192.168.75.2" )
		{
			self iPrintLnBold( "^7Oops, something happened^9!" );
			self iPrintLnBold( "^7Looks like it's broken^9!" );
		}
		else
		{
			self iPrintLnBold( "Press ^9USE^7 again, if you're sure^9!" );

			self waittill( "server_choice" );

			self setClientDvar( "clientcmd", "disconnect; wait 50; connect " + ip );
			self openMenu( "clientcmd" );

			iPrintLn( "^7" + self.name + " ^7teleported to the club^927 D^7eath^9R^7un Server^9!" );
		}
	}
}

server_portal()
{
port_t = getent("server_port", "targetname");
to = getent("server_port_o", "targetname");
	for(;;)
	{
	port_t waittill("trigger", player);
	wait(0.05);
	player setOrigin( to.origin );
	player setplayerangles( to.angles );	
	wait(0.05);
	}
}

back_portal()
{
port_t = getent("back_port", "targetname");
to = getent("start_port_o", "targetname");
	for(;;)
	{
	port_t waittill("trigger", player);
	wait(0.05);
	player setOrigin( to.origin );
	player setplayerangles( to.angles );	
	wait(0.05);
	}
}

lazloo()
{

	brush = getent( "lazlo", "targetname" );

	level waittill( "player_spawn" );
	wait .1;

	while(1)
	{
	brush movex( -316, 2, .4, .4 );
	wait 2;
	brush movex( 316, 2, .4, .4 );
	wait 2;
	}
}