// Scripted by Amitoz
// Clear script! and optimized for cod4 deathrun with free run functions.
// Do not Change anything please if you want to change ask me before! xfire: theamitoz
main()
{
	//Cod4 Stuff
	maps\mp\_load::main();  
	

	game["allies"] = "marines";
	game["axis"] = "opfor";
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["allies_soldiertype"] = "desert";
	game["axis_soldiertype"] = "desert";
	
	thread trap1();
	thread trap2();
	thread sniper();
	thread trap3();
	thread credit();
	thread knife();
    thread trap4();
	thread trap5();

	addTriggerToList("trap1_trigger"); 
	addTriggerToList("trap2_trigger");
	addTriggerToList("trap3_trigger");
	addTriggerToList("trap4_trigger");
	addTriggerToList("trap5_trigger");
}

addTriggerToList( name ) 
{
    if( !isDefined( level.trapTriggers ) )
        level.trapTriggers = [];
    level.trapTriggers[level.trapTriggers.size] = getEnt( name , "targetname" );
}

/////////////Trap 1/////////////
trap1()
{
	trigger = getEnt("trap1_trigger","targetname");
	brush = getEntArray("trap1_brush","targetname");

	trigger setHintString("Activate");

	trigger waittill("trigger");
	trigger delete();

	random = randomInt(brush.size);
	brush[random] moveZ(-200,.2);
	wait 2.5;
	brush[random] moveZ(200,.7);
	wait 2.5;

}

/////////////Trap 2/////////////
trap2()
{
	trig = getEnt( "trap2_trigger", "targetname" );
	brush = getEnt( "trap2_brush", "targetname" );

	trig setHintString("Activate");

	trig waittill( "trigger", who );
	trig delete();

	while( isDefined( brush ) )
	{
		brush rotateRoll( 180, 2 );
		wait 2;
	}
}

/////////////Trap 3/////////////
trap3()
{
	trig = getEnt( "trap3_trigger", "targetname" );
	brush = getEnt( "trap3_brush", "targetname" );

	trig setHintString("Activate");

	trig waittill( "trigger", who );
	trig delete();
	

	while( isDefined( brush ) )
	{
		brush rotateRoll( 180, 4 );
		wait 4;
	}
}

/////////////Trap 4/////////////
trap4()
{
    trigger = getEnt("trap4_trigger","targetname");
	brush = getEnt("trap4_brush","targetname");
	trigger setHintString("Activate");

	trigger waittill("trigger");

	wait 1;
	brush delete();
	trigger delete();
}

/////////////Trap 5/////////////
trap5()
{
    trig = getEnt( "trap5_trigger", "targetname" );
	brush = getEnt( "trap5_brush", "targetname" );

	trig setHintString("Activate");

	trig waittill( "trigger", who );
	trig delete();
	brush delete();
}

/////////////Other Stuff/////////////
credit()
{
	wait(10);
	thread drawInformation( 800, 0.8, 1, "Sync" );
	wait(4);
	thread drawInformation( 800, 0.8, 1, "� Amitoz" );
	wait(4);
	thread drawInformation( 800, 0.8, 1, "Made For Sync Deathrun" );
	wait(4);
}

drawInformation( start_offset, movetime, mult, text )
{
	start_offset *= mult;
	hud = new_ending_hud( "center", 0.1, start_offset, 90 );
	hud setText( text );
	hud moveOverTime( movetime );
	hud.x = 0;
	wait( movetime );
	wait( 3 );
	hud moveOverTime( movetime );
	hud.x = start_offset * -1;

	wait movetime;
	hud destroy();
}

new_ending_hud( align, fade_in_time, x_off, y_off )
{
	hud = newHudElem();
    hud.foreground = true;
	hud.x = x_off;
	hud.y = y_off;
	hud.alignX = align;
	hud.alignY = "middle";
	hud.horzAlign = align;
	hud.vertAlign = "middle";

 	hud.fontScale = 3;

	hud.color = (0.0, 1.1, 1.1);
	hud.font = "objective";
	hud.glowColor = (0.3, 0.6, 0.3);
	hud.glowAlpha = 1;

	hud.alpha = 0;
	hud fadeovertime( fade_in_time );
	hud.alpha = 1;
	hud.hidewheninmenu = true;
	hud.sort = 10;
	return hud;
}


sniper()
{
    level.sniper_trig = getEnt( "sniper_trig", "targetname");
    jump = getEnt( "jumper_sniper", "targetname" );
    acti = getEnt( "activator_sniper", "targetname" );
    
    while(1)
    {
        level.sniper_trig waittill( "trigger", player );
		
        if( !isDefined( level.sniper_trig ) )
            return;

			// ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================

		level.final_trigger_k delete();

        
        player SetPlayerAngles( jump.angles );
        player setOrigin( jump.origin );
        player TakeAllWeapons();
        player GiveWeapon( "m40a3_mp" );
		player GiveWeapon( "remington700_mp" );
        level.activ setPlayerangles( acti.angles );
        level.activ setOrigin( acti.origin );
        level.activ TakeAllWeapons();
        level.activ GiveWeapon( "m40a3_mp" );
		level.activ GiveWeapon( "remington700_mp" ); 
        wait 0.05;
        player switchToWeapon( "m40a3_mp" ); //activator weapon
        level.activ SwitchToWeapon( "m40a3_mp" );
        player FreezeControls(1);
		level.activ FreezeControls(1);
		noti = SpawnStruct();
		noti.titleText = "Sniper Room";
		noti.notifyText = level.activ.name + " ^3VS^7 " + player.name;
		noti.glowcolor = (0.5,0.9,0.5);
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

knife()
{
   
	level.final_trigger_k = getEnt( "final_trigger_k", "targetname");
    jump = getEnt( "enter_jumper_k", "targetname" );
    acti = getEnt( "activator_enter_k", "targetname" );
	
     while(1)
    {
        level.final_trigger_k waittill( "trigger", player );
        if( !isDefined( level.final_trigger_k ) )
            return;

			// ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================
        
		level.sniper_trig delete();

      
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
		noti.notifyText = level.activ.name + " ^3VS^7 " + player.name;
		noti.glowcolor = (0,0.1,0.9);
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

