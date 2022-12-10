//map made by Lifezor.
//Map made exclusively for boss deathrun.
//Many thanks for Sheep Wizard (for the secret) Blade for some fx c;
//Thanks to eBc|Legend for finishing map and fixing scripts

main()

{
	
	addTriggerToList( "trap1_trig" );
	addTriggerToList( "trap2_trig" );
	addTriggerToList( "solid_trig" );
	addTriggerToList( "spinbrush_trig" );
	addTriggerToList( "spinbounce_trig" );
	addTriggerToList( "trap3_trig" );
	addTriggerToList( "trap4_trig" );
	
	
	maps\mp\_load::main();
	maps\mp\_teleport1::main();
	maps\mp\_teleport2::main();
	maps\mp\_teleport3::main();
	maps\mp\_teleport4::main();
	maps\mp\_teleport5::main();
	maps\mp\_teleport6::main();
	
	
	
	game["allies"] = "marines";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "desert";
	game["axis_soldiertype"] = "desert";
	
	thread credits();
    thread ShowMapper();
	thread ShowSheepi();
	thread spawndoor();
	thread trap1();
	thread trap2();
	thread ufoarea();
    thread acti1tele();
	thread sniper();
	thread knife();
	thread old();
	thread solidtrap1();
    thread spinbrush();
	thread actidoor();
	thread spinningbounce();
	thread updown();
	thread disappearingbrush();

		addQueueTrigger("sniper");
	addQueueTrigger("knife");
	addQueueTrigger("old");
	addQueueTrigger("final_knife_trig");
	addQueueTrigger("final_wep_trig");

	
}


addTriggerToList( name )
{
    if( !isDefined( level.trapTriggers ) )
		level.trapTriggers = [];
    level.trapTriggers[level.trapTriggers.size] = getEnt( name, "targetname" );
}



credits()
{
 for(;;)
             {
             iPrintLn ("^3>>^1Map By ^2Lifezor");
             wait 10;
             iPrintLn ("^3>>^1Youtube ^2http://www.youtube.com/IH8LifesSucks");
             wait 10;
             iPrintLn ("^3>>^1Xfire ^2xhdkillerhdx");
             wait 10;
             iPrintLn (">>Map exclusively made for ^5Boss'^7 deathrun!<<");
			 wait 10;
             iPrintLn ("^3>>^1Thanks for playing ^2mp_deathrun_boss");
			 wait 10;
			 iPrintLn ("Song: Adam Lambert - Runnin");
			 wait 10;
             }
}

ShowMapper()
{
            wait 5;
        hud_clock = NewHudElem();
            hud_clock.alignX = "center";
            hud_clock.alignY = "middle";
            hud_clock.horzalign = "center";
            hud_clock.vertalign = "middle";
            hud_clock.alpha = 1;
            hud_clock.x = 0;
            hud_clock.y = 0;
            hud_clock.font = "objective";
            hud_clock.fontscale = 2;
            hud_clock.glowalpha = 5;
            hud_clock.glowcolor = (0.0,0.8,0.0);
            hud_clock.label = &"Made by Lifezor";
                       hud_clock SetPulseFX( 40, 5400, 200 );
                       wait 5;
}

ShowSheepi()
{
            wait 13;
        hud_clock = NewHudElem();
            hud_clock.alignX = "center";
            hud_clock.alignY = "middle";
            hud_clock.horzalign = "center";
            hud_clock.vertalign = "middle";
            hud_clock.alpha = 1;
            hud_clock.x = 0;
            hud_clock.y = 0;
            hud_clock.font = "objective";
            hud_clock.fontscale = 2;
            hud_clock.glowalpha = 5;
            hud_clock.glowcolor = (0.0,0.8,0.0);
            hud_clock.label = &"Thank Sheep Wizard for the secret!";
                       hud_clock SetPulseFX( 40, 5400, 200 );
                       wait 5;
}

spawndoor()
{
	door=getent("spawndoor","targetname");
	wait(10);
	ambientplay("music");
    wait(16);
    iPrintLnBold("^4Door is opening to the Boss deathrun map!"); //Change the message if you want
    door movez(-256,10,1,9);
    door waittill ("movedone");
}

trap1()
{
			trig = getEnt("trap1_trig", "targetname");
            brusha = getEnt("notsolid1", "targetname");
            brushb = getEnt("notsolid2", "targetname");
            brushc = getEnt("notsolid3", "targetname");
           
            trig waittill("trigger");
            trig delete();
           
            x = randomInt(3);
            if(x == 0)
            {      
                    brusha Solid();
                    brushc notSolid();
                    brushb Solid();
            }
            else if(x == 1)
            {
                    brushc notSolid();
                    brushb Solid();
                    brusha notSolid();
            }
			
			if(x == 2)
			{
				brusha notSolid();
				brushb notSolid();
				brushc Solid();
			}
}

trap2()
{
      trig = getEnt("trap2_trig", "targetname");
      brush1 = getEnt("spinning1", "targetname");
      brush2 = getEnt("spinning2", "targetname");
     
      trig waittill("trigger");
      trig delete();
     
      while(1)
      {
        brush1 rotatePitch(720,4);
        brush1 rotatePitch(-720,4);
        wait 5;
		brush2 rotatePitch(720,4);
		brush2 rotatePitch(-720,4);
		wait 10;
      }
}

ufoarea()
{
trigger = getEnt("ufoarea", "targetname");
trigger waittill("trigger", player);
iPrintLnBold(player.name+ "^2 Has left UFO as first!");
}

acti1tele()
{
	trig = getEnt("acti1tele_trig", "targetname");
	target = getEnt("acti1tele_origin", "targetname");
	
	for(;;)
	{
		trig waittill("trigger", player);
		player setOrigin( target.origin );
		player setPlayerAngles( target.angles );
	}
}

sniper()
{
     level.sniper_trig = getEnt( "sniper", "targetname");
     sjump = getEnt( "sniperplayer", "targetname" );
     sacti = getEnt( "sniperacti", "targetname" );
	 
	 if( !isDefined( level.sniper_trig ) )
         return;
		 
	 while(1)
	 {
		level.sniper_trig waittill( "trigger", player );

		// ====== Part for Queue Plugin ========
        if(!plugins\_queue::checkQueueRoom(player))
            continue;
	    // =====================================
		
		if(!isdefined(level.firstenter))
			level.firstenter=false;
			
		if(level.firstenter==false)
		{
		 level.old_trig delete();
		 level.knife_trig delete();
		 level.firstenter=true;
		}
			level.activ freezeControls(1);
			player FreezeControls(1);
			
			player SetPlayerAngles( sjump.angles );
			player setOrigin( sjump.origin );
			level.activ setPlayerangles( sacti.angles );
			level.activ setOrigin( sacti.origin );
			level.activ TakeAllWeapons();
			player TakeAllWeapons();
			
			level.activ giveweapon( "m40a3_mp");
			player giveweapon( "m40a3_mp");
			player switchToWeapon( "m40a3_mp" );
			level.activ SwitchToWeapon( "m40a3_mp" );
			player giveMaxAmmo( "m40a3_mp" );
			level.activ giveMaxAmmo( "m40a3_mp" );
			
			level.activ giveweapon( "remington700_mp");
			player giveweapon( "remington700_mp");
			player switchToWeapon( "remington700_mp" );
			level.activ SwitchToWeapon( "remington700_mp" );
			player giveMaxAmmo( "remington700_mp" );
			level.activ giveMaxAmmo( "remington700_mp" );
			
			level.activ freezeControls(1.5);
			player FreezeControls(1.5);
			
					noti = SpawnStruct();
					noti.titleText = (player.name+"^3Has ^6Chosen ^5Sniper ^2Fight!");
					noti.notifyText = level.activ.name + " ^1VS^5 " + player.name;
					noti.duration = 6;
					noti.glowcolor = (0, 0, 1.0);
					
					players = getEntArray("player", "classname");
					for(i=0;i<players.size;i++)
						players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
					
			wait 2;
			
			level.activ FreezeControls(0);
			player FreezeControls(0);
			
			wait 0.1;
                     
			while(isAlive(player))
				wait 1;

		}
}

knife()
{
     level.knife_trig = getEnt( "knife", "targetname");
     kjump = getEnt( "knifeplayer", "targetname" );
     kacti = getEnt( "knifeacti", "targetname" );
	 
	if( !isDefined( level.knife_trig ) )
         return;
		 
	 while(1)
	 {
		level.knife_trig waittill( "trigger", player );

		// ====== Part for Queue Plugin ========
        if(!plugins\_queue::checkQueueRoom(player))
            continue;
	    // =====================================
		
		if(!isdefined(level.firstenter))
			level.firstenter=false;
			
		if(level.firstenter==false)
		{
		 level.old_trig delete();
		 level.sniper_trig delete();
		 level.firstenter=true;
		}
			level.activ freezeControls(1);
			player FreezeControls(1);
			
			player SetPlayerAngles( kjump.angles );
			player setOrigin( kjump.origin );
			level.activ setPlayerangles( kacti.angles );
			level.activ setOrigin( kacti.origin );
			level.activ TakeAllWeapons();
			player TakeAllWeapons();
			
			level.activ giveweapon( "tomahawk_mp");
			player giveweapon( "tomahawk_mp");
			player switchToWeapon( "tomahawk_mp" );
			level.activ SwitchToWeapon( "tomahawk_mp" );
			
			level.activ freezeControls(1);
			player FreezeControls(1);
			
					noti = SpawnStruct();
					noti.titleText = (player.name+"^3Has ^6Chosen ^5Knife ^2Fight!");
					noti.notifyText = level.activ.name + " ^1VS^7 " + player.name;
					noti.duration = 6;
					noti.glowcolor = (0, 0, 1.0);
					
					players = getEntArray("player", "classname");
					for(i=0;i<players.size;i++)
						players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
					
			wait 2;
			
			level.activ FreezeControls(0);
			player FreezeControls(0);
			
			wait 0.1;
                     
			while(isAlive(player))
				wait 1;

		}
}

old()
{
     level.old_trig = getEnt( "old", "targetname");
     kjump = getEnt( "oldplayer", "targetname" );
     kacti = getEnt( "oldacti", "targetname" );
	 
	if( !isDefined( level.old_trig ) )
         return;
		 
	 while(1)
	 {
		level.old_trig waittill( "trigger", player );

		// ====== Part for Queue Plugin ========
        if(!plugins\_queue::checkQueueRoom(player))
            continue;
	    // =====================================
		
		if(!isdefined(level.firstenter))
			level.firstenter=false;
			
		if(level.firstenter==false)
		{
		 level.knife_trig delete();
		 level.sniper_trig delete();
		 level.firstenter=true;
		}
			level.activ freezeControls(1);
			player FreezeControls(1);
			
			player SetPlayerAngles( kjump.angles );
			player setOrigin( kjump.origin );
			level.activ setPlayerangles( kacti.angles );
			level.activ setOrigin( kacti.origin );
			level.activ TakeAllWeapons();
			player TakeAllWeapons();
			
			level.activ giveweapon( "tomahawk_mp");
			player giveweapon( "tomahawk_mp");
			player switchToWeapon( "tomahawk_mp" );
			level.activ SwitchToWeapon( "tomahawk_mp" );
			
			
					noti = SpawnStruct();
					noti.titleText = (player.name+"^3Has ^6Chosen ^5Old ^2Room!");
					noti.duration = 6;
					noti.glowcolor = (0, 0, 1.0);
					
					players = getEntArray("player", "classname");
					for(i=0;i<players.size;i++)
						players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
						wait 3;
					level.activ freezeControls(0);
			        player FreezeControls(0);
					
			
			wait 0.1;
                     
			while(isAlive(player))
				wait 1;

		}
}

solidtrap1()
{
        trig = getEnt("solid_trig", "targetname");
        brusha = getEnt("solid1", "targetname");
        brushb = getEnt("solid2", "targetname");
        brushc = getEnt("solid3", "targetname");
        brushd = getEnt("solid4", "targetname");
                           
        trig waittill("trigger");
        trig delete();
               
        x = randomInt(4);
        if(x == 0)
        {      
            brusha Solid();
            brushc notSolid();
            brushb Solid();
            brushd Solid();
        }
        if(x == 1)
        {
            brushc notSolid();
            brushb Solid();
            brusha notSolid();
            brushd notSolid();
        }
            if(x == 2)
            {
            brusha notSolid();
            brushb notSolid();
			brushc Solid();
            brushd Solid();
            }
            if(x == 3)
            {
                brusha solid();
                brushb solid();
                brushc notsolid();
                brushd notSolid();
            }
			
}

spinbrush()
{
      trig = getEnt("spinbrush_trig", "targetname");
      brush1 = getEnt("spinbrush1", "targetname");
      brush2 = getEnt("spinbrush2", "targetname");
	  brush3 = getEnt("spinbrush3", "targetname");
     
      trig waittill("trigger");
      trig delete();
     
      while(1)
      {
        brush1 rotateYaw(720,4);
        brush1 rotateYaw(-720,4);
        wait 5;
		brush2 rotatePitch(720,4);
		brush2 rotatePitch(-720,4);
		wait 5;
		brush3 rotateYaw(720,4);
		brush3 rotateYaw(-720,4);
		wait 10;
      }
}

actidoor()
{
	door=getent("actidoor","targetname");
    wait(16);
    door movez(-256,10,1,9);
    door waittill ("movedone");
}

spinningbounce()
{
      trig = getEnt("spinbounce_trig", "targetname");
      brush1 = getEnt("spinbounce1", "targetname");
      brush2 = getEnt("spinbounce2", "targetname");
     
      trig waittill("trigger");
      trig delete();
     
      while(1)
      {
        brush1 rotatePitch(720,4);
        brush1 rotatePitch(-720,4);
        wait 5;
		brush2 rotatePitch(720,4);
		brush2 rotatePitch(-720,4);
		wait 10;
	  }
}

updown()
{
	brush1 = getEnt("updown1", "targetname");
	brush2 = getEnt("updown2", "targetname");
	brush3 = getEnt("updown3", "targetname");
	brush4 = getEnt("updown4", "targetname");
	trig = getEnt("trap3_trig", "targetname");
	
	trig waittill("trigger");
	trig delete();
	
	for(;;)
	{
		brush1 movez(-60,1);
		wait 4;
		brush1 movez(60,1);
		
		brush3 movez(-60,1);
		wait 4;
		brush3 movez(60,1);
		wait 5;
		brush2 movez(-60,1);
		wait 4;
		brush2 movez(60,1);
		
		brush4 movez(-60,1);
		wait 4;
		brush4 movez(60,1);
		wait 10;
	}
	
	
}

disappearingbrush()
{
	trig = getent("trap4_trig", "targetname");
	brush1 = getent("disappearbrush1", "targetname");
	brush2 = getent("disappearbrush2", "targetname");
	brush3 = getent("disappearbrush3", "targetname");
	brush4 = getent("disappearbrush4", "targetname");
	
	trig waittill("trigger", player);
	trig delete();
	
	x = randomInt(8);
		if(x == 0)
		{
	        brush1 notSolid();
            brush1 hide();
            brush3 notSolid();
            brush3 hide();
        }
        if(x == 1)
        {
            brush1 Solid();
            brush1 show();
            brush3 Solid();
            brush3 show();
        }
            if(x == 2)
            {
            brush2 notSolid();
            brush2 hide();
			brush4 Solid();
            brush4 show();
            }
            if(x == 3)
            {
            brush2 notsolid();
            brush2 hide();
            brush4 Solid();
            brush4 show();
            }
			if(x == 4)
			{
			brush2 notsolid();
			brush2 hide();
			brush3 solid();
			brush3 show();
			}
			if(x == 5)
			{
			brush4 solid();
			brush4 show();
			brush1 notSolid();
			brush1 hide();
			}
			if(x == 6)
			{
			brush3 notSolid();
			brush3 hide();
			brush2 notSolid();
			brush2 hide();
			}
			if(x == 7)
			{
			brush1 notSolid();
			brush1 hide();
			brush4 solid();
			brush4 show();
			}
	
			
			
}


addQueueTrigger(name)
    {
        if(!isdefined(level.queue_triggers))
            level.queue_triggers = [];

        level.queue_triggers[level.queue_triggers.size] = getent(name,"targetname");
    }
