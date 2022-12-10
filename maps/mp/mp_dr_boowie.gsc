//Map by Night Howl


main()
{
 maps\mp\_load::main();
 
 game["allies"] = "marines";
 game["axis"] = "opfor";
 game["attackers"] = "axis";
 game["defenders"] = "allies";
 game["allies_soldiertype"] = "desert";
 game["axis_soldiertype"] = "desert";
 
	
	setdvar( "r_specularcolorscale", "1" );

	setdvar("r_glowbloomintensity0",".1");
	setdvar("r_glowbloomintensity1",".1");
	setdvar("r_glowskybleedintensity0",".1");

    thread sniper();
	thread music();
	thread knife();
	thread weapon();
	thread rpg();
	thread old();
	thread messages();
	thread trap1();
	thread trap1_1();
	thread trap1_2();
	thread trap1_3();
	thread trap2();
	thread trap3();
	thread trap4();
	thread trap4_1();
	thread trap4_2();
	thread trap5();
	thread trap6();
	thread elevator();
	thread startdoor();
	thread teleport1();
	thread teleport2();
	thread teleport3();
	thread teleport4();

    addTriggerToList("trig_trap1"); 
	addTriggerToList("trig_trap2");
	addTriggerToList("trig_trap3");
	addTriggerToList("trig_trap4");
	addTriggerToList("trig_trap5");
	addTriggerToList("trig_trap6");
 
}

addTriggerToList(name) 
{
    if(!isDefined(level.trapTriggers))
    level.trapTriggers = [];
    level.trapTriggers[level.trapTriggers.size] = getEnt(name , "targetname");
}


messages()
{
wait 10;
iprintlnBold("^2Welcome ^4to ^3the ^5BooWiE");
wait 15;
iprintln("^2This ^4Map ^6Made ^5By ^3Most ^0Faster");
wait 25;
iprintln("^2This ^4Map ^6Made ^5By ^3Most ^0Faster");
wait 25;
iprintln("^2This ^4Map ^6Made ^5By ^3Most ^0Faster");
wait 25;
iprintln("^2This ^4Map ^6Made ^5By ^3Most ^0Faster");
wait 25;
iprintln("^2This ^4Map ^6Made ^5By ^3Most ^0Faster");
wait 25;
iprintln("^2This ^4Map ^6Made ^5By ^3Most ^0Faster");
wait 25;
iprintln("^2This ^4Map ^6Made ^5By ^3Most ^0Faster");
wait 1;
}

music()
{
    level waittill( "round_started" );
    
    wait 1;
    
    ambientPlay( "song6" );
}

startdoor()
{
    door = getEnt("startdoor", "targetname");
	
	{
	wait 10;
	iprintlnBold("^2Start Door Opened^4.");
    door delete();
	}
}	

trap1()
{
        platform = getEnt("trap1", "targetname");
		trig = getEnt("trig_trap1", "targetname");
		trig waittill("trigger", player);

	for(;;)	
    {
	wait 0.1;
	platform rotateRoll(360 , 2);	
	wait 3;
	}
}

trap1_1()
{
        platform = getEnt("trap1_1", "targetname");
		trig = getEnt("trig_trap1", "targetname");
        trig setHintString("[use]");
		trig waittill("trigger", player);

	for(;;)		
    {
	wait 0.5;
	platform rotateRoll(360 , 2);	
	wait 3;
	}
}

trap1_2()
{
        platform = getEnt("trap1_2", "targetname");
		trig = getEnt("trig_trap1", "targetname");
        trig setHintString("[use]");
		trig waittill("trigger", player);

	for(;;)		
    {
	wait 0.9;
	platform rotateRoll(360 , 2);	
	wait 3;
	}
}

trap1_3()
{
        platform = getEnt("trap1_3", "targetname");
		trig = getEnt("trig_trap1", "targetname");
        trig setHintString("[use]");
		trig waittill("trigger", player);

	for(;;)		
    {
	wait 1.3;
	platform rotateRoll(360 , 2);	
	wait 3;
	}
}

trap2()
{
        platform = getEnt("trap2", "targetname");
		trig = getEnt("trig_trap2", "targetname");
        trig setHintString("[use]");
		trig waittill("trigger", player);

	for(;;)		
    {
	wait 0.1;
	platform rotateRoll(360 , 3);	
	wait 4;
	}
}

trap3()
{
    platform = getEnt("trap3", "targetname");
	trig = getEnt("trig_trap3", "targetname");
    trig setHintString("[use]");
	trig waittill("trigger", player);
	
	platform delete();
	
	trig delete();
}	

trap4()
{
        platform = getEnt("trap4", "targetname");
		trig = getEnt("trig_trap4", "targetname");
        trig setHintString("[use]");
		trig waittill("trigger", player);

	for(;;)		
    {
	wait 0.1;
	platform rotateRoll(360 , 3);	
	wait 4;
	}
}

trap4_1()
{
        platform = getEnt("trap4_1", "targetname");
		trig = getEnt("trig_trap4", "targetname");
        trig setHintString("[use]");
		trig waittill("trigger", player);

	for(;;)		
    {
	wait 1;
	platform rotateYaw(360 , 3);	
	wait 4;
	}
}

trap4_2()
{
        platform = getEnt("trap4_2", "targetname");
		trig = getEnt("trig_trap4", "targetname");
        trig setHintString("[use]");
		trig waittill("trigger", player);

	for(;;)		
    {
	wait 2;
	platform rotatePitch(360 , 3);	
	wait 4;
	}
}

trap5()
{
    platform = getEnt("trap5", "targetname");
	trig = getEnt("trig_trap5", "targetname");
    trig setHintString("[use]");
	trig waittill("trigger", player);
	
	platform delete();
	
	trig delete();
}	

trap6()
{
        platform = getEnt("trap6", "targetname");
		trig = getEnt("trig_trap6", "targetname");
        trig setHintString("[use]");
		trig waittill("trigger", player);

	for(;;)		
    {
	wait 0.1;
	platform rotateYaw(360 , 3);	
	wait 4;
	}
}

elevator()
{
    platform = getEnt("elevator1", "targetname");
    trig = getEnt("elevator", "targetname");
	
	for(;;)	
	{
	wait 0.5;
	platform moveZ(965 , 4);
	wait 5;
	platform moveZ(-965 , 4);
	wait 5;
	}
}	

teleport1()
{
    trig = getEnt("trigger_teleport1", "targetname");
	telel = getEnt("origin_teleport1","targetname");
	
	for(;;)
	{
	    trig waittill("trigger", player);
		player setOrigin(telel.origin);
		player iprintlnBold("^3Respawned^5.");
	}
}

teleport2()
{
    trig = getEnt("trigger_teleport2", "targetname");
	telel = getEnt("origin_teleport2","targetname");
	
	for(;;)
	{
	    trig waittill("trigger", player);
		player setOrigin(telel.origin);
		player iPrintlnBold( " ^4" + player.name + " ^7has Finished ^4Secret ^7Room!" ); 
	}
}

teleport3()
{
    trig = getEnt("trigger_teleport3", "targetname");
	telel = getEnt("origin_teleport3","targetname");
	
	for(;;)
	{
	    trig waittill("trigger", player);
		player setOrigin(telel.origin);
	}
}

teleport4()
{
    trig = getEnt("trigger_teleport4", "targetname");
	telel = getEnt("origin_teleport4","targetname");
	
	for(;;)
	{
	    trig waittill("trigger", player);
		player setOrigin(telel.origin);
		player iPrintlnBold( " ^4" + player.name + " ^7has Entered ^4Secret ^7Room!" ); 
	}
}	

rpg()
{
        level.rpg_trig = getEnt( "rpg", "targetname"); //trigger 
        jump = getEnt( "c", "targetname" ); //jumper origin
        acti = getEnt( "d", "targetname" ); //acti origin
        ambientPlay( "song1" );

 
        while(1) 
{
                level.rpg_trig waittill( "trigger", player ); 
                if( !isDefined( level.rpg_trig ) ) 
                return;  

                // ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================
            
              level.knife_trig delete(); //deletes all other rooms from being used.
              level.old_trig delete();
              level.weapon_trig delete();
              level.sniper_trig delete();
            
            player SetPlayerAngles( jump.angles );
                player setOrigin( jump.origin ); 
                player TakeAllWeapons(); 
                player GiveWeapon( "rpg_mp" ); //Gives player weapon
                player giveMaxAmmo( "rpg_mp" ); //Gives player ammo  
            player switchToWeapon( "rpg_mp" ); //Makes player switch to weapon.
                player.maxhealth = 100; //Sets players health to normal.
               
                
                if( isDefined( level.activ ) && isAlive( level.activ ) ) 
{
 
               level.activ setPlayerangles( acti.angles );
                    level.activ setOrigin( acti.origin ); 
                    level.activ TakeAllWeapons(); 
                    level.activ GiveWeapon( "rpg_mp" ); 
                    level.activ giveMaxAmmo( "rpg_mp" ); 
               level.activ SwitchToWeapon( "rpg_mp" );
                    level.activ.maxhealth = 100; 
                    
}
                 
                wait 0.05;
               
            iPrintlnBold( " ^4" + player.name + " ^7has chosen ^4RpG ^7Room!" ); 
            player freezecontrols(true); //Freeze the players when someone enters the room for three seconds.
            level.activ freezecontrols(true);
            wait 1;
            player iPrintlnBold( "^13" );
            level.activ iPrintlnBold( "^13" );
            wait 1;
            player iPrintlnBold( "^32" );
            level.activ iPrintlnBold( "^32" );
            wait 1;
            player iPrintlnBold( "^51" );
            level.activ iPrintlnBold( "^51" );
            wait 1;
            player iPrintlnBold( "^6Fight^7!" );
            level.activ iPrintlnBold( "^6Fight^6!" );
            player freezecontrols(false); //Disables the freeze.
            level.activ freezecontrols(false);
                while( isAlive( player ) && isDefined( player ) ) 
                        wait 1;
}
}	

sniper()
{
        level.sniper_trig = getEnt( "sniper", "targetname"); //trigger 
        jump = getEnt( "enter_sniper_room", "targetname" ); //jumper origin
        acti = getEnt( "activator_enter_sniper", "targetname" ); //acti origin
        ambientPlay( "song2" );
        while(1) 
{
                level.sniper_trig waittill( "trigger", player ); 
                if( !isDefined( level.sniper_trig ) ) 
                return;  

                // ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================
            
              level.knife_trig delete(); //deletes all other rooms from being used.
              level.old_trig delete();
              level.weapon_trig delete();
              level.rpg_trig delete();
            
            player SetPlayerAngles( jump.angles );
                player setOrigin( jump.origin ); 
                player TakeAllWeapons(); 
                player GiveWeapon( "m40a3_mp" ); //Gives player weapon
                player giveMaxAmmo( "m40a3_mp" ); //Gives player ammo
                player GiveWeapon( "remington700_mp" );
                player giveMaxAmmo( "remington700_mp" );   
            player switchToWeapon( "m40a3_mp" ); //Makes player switch to weapon.
                player.maxhealth = 100; //Sets players health to normal.
               
                
                if( isDefined( level.activ ) && isAlive( level.activ ) ) 
{
 
               level.activ setPlayerangles( acti.angles );
                    level.activ setOrigin( acti.origin ); 
                    level.activ TakeAllWeapons(); 
                    level.activ GiveWeapon( "m40a3_mp" ); 
                    level.activ giveMaxAmmo( "m40a3_mp" ); 
                    level.activ GiveWeapon( "remington700_mp" );
                    level.activ giveMaxAmmo( "remington700_mp" );
               level.activ SwitchToWeapon( "m40a3_mp" );
                    level.activ.maxhealth = 100; 
                    
}
                 
                wait 0.05;
               
            iPrintlnBold( " ^4" + player.name + " ^7has chosen ^4Sniper ^7Room!" ); 
            player freezecontrols(true); //Freeze the players when someone enters the room for three seconds.
            level.activ freezecontrols(true);
            wait 1;
            player iPrintlnBold( "^13" );
            level.activ iPrintlnBold( "^13" );
            wait 1;
            player iPrintlnBold( "^32" );
            level.activ iPrintlnBold( "^32" );
            wait 1;
            player iPrintlnBold( "^51" );
            level.activ iPrintlnBold( "^51" );
            wait 1;
            player iPrintlnBold( "^6Fight^7!" );
            level.activ iPrintlnBold( "^6Fight^6!" );
            player freezecontrols(false); //Disables the freeze.
            level.activ freezecontrols(false);
                while( isAlive( player ) && isDefined( player ) ) 
                        wait 1;
}
}




weapon()
{
        level.weapon_trig = getEnt( "weapon", "targetname"); //trigger 
        jump = getEnt( "a", "targetname" ); //jumper origin
        acti = getEnt( "b", "targetname" ); //acti origin
        ambientPlay( "song3" );
        while(1) 
{
                level.weapon_trig waittill( "trigger", player ); 
                if( !isDefined( level.weapon_trig ) ) 
                return;  

                // ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================
            
              level.knife_trig delete(); //deletes all other rooms from being used.
              level.old_trig delete();
              level.sniper_trig delete();
              level.rpg_trig delete();
            
            player SetPlayerAngles( jump.angles );
                player setOrigin( jump.origin ); 
                player TakeAllWeapons(); 
                player GiveWeapon( "deserteagle_mp" ); //Gives player weapon
                player giveMaxAmmo( "deserteagle_mp" ); //Gives player ammo
                player GiveWeapon( "deserteaglegold_mp" );
                player giveMaxAmmo( "deserteaglegold_mp" );   
            player switchToWeapon( "deserteaglegold_mp" ); //Makes player switch to weapon.
                player.maxhealth = 100; //Sets players health to normal.
               
                
                if( isDefined( level.activ ) && isAlive( level.activ ) ) 
{
 
               level.activ setPlayerangles( acti.angles );
                    level.activ setOrigin( acti.origin ); 
                    level.activ TakeAllWeapons(); 
                    level.activ GiveWeapon( "deserteaglegold_mp" ); 
                    level.activ giveMaxAmmo( "deserteaglegold_mp" ); 
                    level.activ GiveWeapon( "deserteagle_mp" );
                    level.activ giveMaxAmmo( "deserteagle_mp" );
               level.activ SwitchToWeapon( "deserteaglegold_mp" );
                    level.activ.maxhealth = 100; 
                    
}
                 
                wait 0.05;
               
            iPrintlnBold( " ^4" + player.name + " ^7has chosen ^4Deagle ^7Room!" ); 
            player freezecontrols(true); //Freeze the players when someone enters the room for three seconds.
            level.activ freezecontrols(true);
            wait 1;
            player iPrintlnBold( "^13" );
            level.activ iPrintlnBold( "^13" );
            wait 1;
            player iPrintlnBold( "^32" );
            level.activ iPrintlnBold( "^32" );
            wait 1;
            player iPrintlnBold( "^51" );
            level.activ iPrintlnBold( "^51" );
            wait 1;
            player iPrintlnBold( "^6Fight^7!" );
            level.activ iPrintlnBold( "^6Fight^6!" );
            player freezecontrols(false); //Disables the freeze.
            level.activ freezecontrols(false);
                while( isAlive( player ) && isDefined( player ) ) 
                        wait 1;
}
}


old()
{
        level.old_trig = getEnt( "old", "targetname"); //trigger 
        jump = getEnt( "old_jump", "targetname" ); //jumper origin
        acti = getEnt( "old_act", "targetname" ); //acti origin
        ambientPlay( "song4" );
        while(1) 
{
                level.old_trig waittill( "trigger", player ); 
                if( !isDefined( level.old_trig ) ) 
                return;  

                // ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================
            
              level.knife_trig delete(); //deletes all other rooms from being used.
              level.sniper_trig delete();
              level.weapon_trig delete();
              level.rpg_trig delete();
            
            player SetPlayerAngles( jump.angles );
                player setOrigin( jump.origin ); 
                player TakeAllWeapons(); 
                player GiveWeapon( "knife_mp" ); //Gives player weapon
                player giveMaxAmmo( "knife_mp" ); //Gives player ammo
                player GiveWeapon( "knife_mp" );
                player giveMaxAmmo( "knife_mp" );   
            player switchToWeapon( "knife_mp" ); //Makes player switch to weapon.
                player.maxhealth = 100; //Sets players health to normal.
               
                
                if( isDefined( level.activ ) && isAlive( level.activ ) ) 
{
 
               level.activ setPlayerangles( acti.angles );
                    level.activ setOrigin( acti.origin ); 
                    level.activ TakeAllWeapons(); 
                    level.activ GiveWeapon( "knife_mp" ); 
                    level.activ giveMaxAmmo( "knife_mp" ); 
                    level.activ GiveWeapon( "knife_mp" );
                    level.activ giveMaxAmmo( "knife_mp" );
               level.activ SwitchToWeapon( "knife_mp" );
                    level.activ.maxhealth = 100; 
                    
}
                 
                wait 0.05;
               
            iPrintlnBold( " ^4" + player.name + " ^7has chosen ^4OLD ^7Room!" ); 
            player freezecontrols(true); //Freeze the players when someone enters the room for three seconds.
            level.activ freezecontrols(true);
            wait 1;
            player iPrintlnBold( "^13" );
            level.activ iPrintlnBold( "^13" );
            wait 1;
            player iPrintlnBold( "^32" );
            level.activ iPrintlnBold( "^32" );
            wait 1;
            player iPrintlnBold( "^51" );
            level.activ iPrintlnBold( "^51" );
            wait 1;
            player iPrintlnBold( "^6Fight^7!" );
            level.activ iPrintlnBold( "^6Fight^6!" );
            player freezecontrols(false); //Disables the freeze.
            level.activ freezecontrols(false);
                while( isAlive( player ) && isDefined( player ) ) 
                        wait 1;
}
}


knife()
{
        level.knife_trig = getEnt( "knife", "targetname"); //trigger 
        jump = getEnt( "enter_knife", "targetname" ); //jumper origin
        acti = getEnt( "activator_enter_knife", "targetname" ); //acti origin
        ambientPlay( "song5" );
        while(1) 
{
                level.knife_trig waittill( "trigger", player ); 
                if( !isDefined( level.knife_trig ) ) 
                return;  

                // ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================
            
              level.old_trig delete(); //deletes all other rooms from being used.
              level.sniper_trig delete();
              level.weapon_trig delete();
              level.rpg_trig delete();
            
            player SetPlayerAngles( jump.angles );
                player setOrigin( jump.origin ); 
                player TakeAllWeapons(); 
                player GiveWeapon( "knife_mp" ); //Gives player weapon
                player giveMaxAmmo( "knife_mp" ); //Gives player ammo
                player GiveWeapon( "knife_mp" );
                player giveMaxAmmo( "knife_mp" );   
            player switchToWeapon( "knife_mp" ); //Makes player switch to weapon.
                player.maxhealth = 100; //Sets players health to normal.
               
                
                if( isDefined( level.activ ) && isAlive( level.activ ) ) 
{
 
               level.activ setPlayerangles( acti.angles );
                    level.activ setOrigin( acti.origin ); 
                    level.activ TakeAllWeapons(); 
                    level.activ GiveWeapon( "knife_mp" ); 
                    level.activ giveMaxAmmo( "knife_mp" ); 
                    level.activ GiveWeapon( "knife_mp" );
                    level.activ giveMaxAmmo( "knife_mp" );
               level.activ SwitchToWeapon( "knife_mp" );
                    level.activ.maxhealth = 100; 
                    
}
                 
                wait 0.05;
               
            iPrintlnBold( " ^4" + player.name + " ^7has chosen ^4Knife ^7Room!" ); 
            player freezecontrols(true); //Freeze the players when someone enters the room for three seconds.
            level.activ freezecontrols(true);
            wait 1;
            player iPrintlnBold( "^13" );
            level.activ iPrintlnBold( "^13" );
            wait 1;
            player iPrintlnBold( "^32" );
            level.activ iPrintlnBold( "^32" );
            wait 1;
            player iPrintlnBold( "^51" );
            level.activ iPrintlnBold( "^51" );
            wait 1;
            player iPrintlnBold( "^6Fight^7!" );
            level.activ iPrintlnBold( "^6Fight^6!" );
            player freezecontrols(false); //Disables the freeze.
            level.activ freezecontrols(false);
                while( isAlive( player ) && isDefined( player ) ) 
                        wait 1;
}
}
	


	


		
