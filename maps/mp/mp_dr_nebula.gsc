/*			  
  /\\  /\\  
  //\\_//\\     ____
  \_     _/    /   /
   / ^ ^ \    /^^^|
   \_\O/_/    |   |
    /   \_    |   /
    \     \_  /  /
    | | | /  \/ _/
    |_| | \__/_/               				  
	By VC' Fox.
	
		___    __  _       _______        
	| | / (_)__/ /_(_)___  / ___/ /__ ____ 
	| |/ / (_-< __/ / __/ / /__/ / _ `/ _ \
	|___/_/___|__/_/\__/  \___/_/\_,_/_//_/ 

	Info:
	I did make a version of Nebula already (mp_vc_nebula) but decided to do a 2nd version
	as a stand-alone release.

	Credits:
	Thanks to VC'Blade for his secret timer script.
	Skybox from CfgFactory by ZeeZ.
	Thanks for VC'Erik and Speedex for helping me test :D

	Music List:
	Frontliner - Im The Melodyman 
	JVNA - First Storm
	Azurity - Million Miles Away 
	Melano - Dont Fight It 
	Zomboy & Eptic - Bop It
	Far Out - Apex
	Delta Heavy - Ghost
	Seven Lions feat. Shaz Sparks - Polarized
	Thoreau & Tina DeCara - Illusion 

	Vistic Disord: https://discord.gg/JKwXV3h
*/
main()
{
	maps\mp\_load::main(); 

	game["allies"] = "sas";
	game["axis"] = "russian";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "woodland";
	game["axis_soldiertype"] = "woodland";
	
	visionSetNaked("mp_vacant",2.0);

	setDvar("r_drawDecals","1");
	setDvar("r_specularcolorscale", "1");
	setDvar("r_glowbloomintensity0",".25");
	setDvar("r_glowbloomintensity1",".25");
	setDvar("r_glowskybleedintensity0",".3");
	setDvar("compassmaxrange","1800");
 	setdvar("bg_fallDamageMaxHeight", "99999"); 
	setDvar("bg_FallDamageMinHeight","99998");

	preCacheModel("playermodel_bo1_pilot");
	preCacheModel("viewhands_bo1_pilot");
	
	precacheShader("gasmask_overlay");
	PrecacheMenu("speedex_music_menu");
	
	precacheItem("remington700_mp"); 
	precacheItem("m40a3_mp"); 
	precacheItem("knife_mp");
	precacheItem("usp_mp");
	precacheItem("colt45_mp");
	precacheItem("deserteagle_mp");
	precacheItem("winchester1200_mp");
	precacheItem("ak74u_mp");

  thread startdoor();
	thread vc_door();
	thread vc_intel();
	thread vc_intel_2();
	thread vc_intel_3();
	thread vc_intel_4();
	thread vc_intel_5();
  thread elev();
	thread distant_planet();
	thread credit();
  thread trap_1();
  thread trap_2();
  thread trap_3();
	thread trap_4();
	thread trap_5();
	thread sec_exit();
	thread trap_6();
	thread trap_7();
	thread trap_8();
	thread trap_9();
	thread trap_10();
	thread acti_tp1();
	thread acti_tp2();
	thread acti_tp3();
	thread jump_tp1();
	thread jump_tp2();
	thread sec_fail1();
	thread sec_fail2();
	thread sec_wep();
	thread secret_step1();
	thread secret_enter();
	thread bounce_room_weapon();
	thread bounce_reset1();
	thread bounce_reset2();
	thread knife_room();
	thread bounce_room();
	thread sniper_room();
	thread speed_room();
	thread music_box();
	thread slide_sec();
	thread slide_exit();
	thread messages();
	thread addTestClients();

	addTriggerToList("trig_trap1"); 
	addTriggerToList("trig_trap2");
	addTriggerToList("trig_trap3");
	addTriggerToList("trig_trap4");
	addTriggerToList("trig_trap5");
	addTriggerToList("trig_trap6");
	addTriggerToList("trig_trap7");
	addTriggerToList("trig_trap8");
	addTriggerToList("trig_trap9");

}

addTriggerToList( name ) 
{
    if( !isDefined( level.trapTriggers ) )
        level.trapTriggers = [];
    level.trapTriggers[level.trapTriggers.size] = getEnt( name , "targetname" );
}

startdoor()
{
	door = getEnt("startdoor","targetname");
	{
		wait 18;
		door delete();
		iPrintLnBold("^1Start ^7Door ^1Opened^7!");
		wait 2;
	}
}

elev()
{
	elev = getEnt("elev", "targetname");
	
	for(;;)
	{
	wait 0.1;
	elev moveY (896, 2);
	wait 5;
	elev moveY (-896, 2);
	wait 4;
	}	
}

distant_planet()
{
	planet = getEnt("planet", "targetname");
	
	for(;;)
	{
	wait 0.1;
	planet rotateYaw(360,120);
	}	
}

vc_door()
{
	door = getEnt("vc_door","targetname");
	trig = getEnt("trigger_door","targetname");

	trig waittill("trigger", player);
	
	player playSoundToPlayer("weap_suitcase_button_press_plr",player);
	
	wait 1.5;

	door playSound("open_door");

	door moveZ(56,1.6);
	trig delete();
}

messages()
{
	for(;;)
	{
	wait 0.1;
	iPrintLn("^7Map Made By: ^3VC'Fox");
	wait 30;
	iPrintLn("^7Discord: ^3VC'Fox#0001"); 
	wait 30;
	}
}	

credit()
{
	level waittill("round_started");

		wait 1;
		hud_clock = NewHudElem();
		hud_clock.alignX = "center";
		hud_clock.alignY = "middle";
		hud_clock.horzalign = "center";
		hud_clock.vertalign = "middle";
		hud_clock.alpha = 5;
		hud_clock.x = 0;
		hud_clock.y = 0;
		hud_clock.font = "objective";
		hud_clock.fontscale = 1.4;
		hud_clock.glowalpha = 1;
		hud_clock.glowcolor = (5,6,2);
		hud_clock.label = &"mp_dr_Nebula";
		hud_clock SetPulseFX( 40, 5400, 200 );	
		wait 7;
		hud_clock = NewHudElem();
		hud_clock.alignX = "center";
		hud_clock.alignY = "middle";
		hud_clock.horzalign = "center";
		hud_clock.vertalign = "middle";
		hud_clock.alpha = 5;
		hud_clock.x = 0;
		hud_clock.y = 0;
		hud_clock.font = "objective";
		hud_clock.fontscale = 1.4;
		hud_clock.glowalpha = 1;
		hud_clock.glowcolor = (5,6,2);
		hud_clock.label = &"^7Map By: ^3VC'Fox";
		hud_clock SetPulseFX( 40, 5400, 200 );	
}




music_box()
{
	level.music_trigger = getent( "trig_music","targetname" );			//Gets the music trigger
	level.music_trigger setHintString( "^3> ^7Music ^3<" ); 	//Set the hintstring or message on the trigger when standing in it
	level.music_trigger waittill( "trigger", player );				//Wait till a player opens the menu
	wait 0.1;									//Wait 0.1 sec
	
	player openMenu( "speedex_music_menu" );					//Open the menu itself, make sure your  change this line aswell if you are renaming the .menu file			
	player thread music_function();							//Execute the function which will react on our menu
}

music_function()
{
	self endon( "disconnect" );							//This function will end when the player disconnects
	self endon( "death" );								//This function will end when the player dies

	for(;;)										//Same as while(1), makes the function loop
	{
	   self waittill( "menuresponse", menu, response );				//Wait till we get a response from the menu

	   if(menu == "speedex_music_menu")						//Check if we are using the menu this function is going to react to
	   {
		    if(response == "song1")						//If the script response for the menu is "song1"
		    {
		    	AmbientStop();							//Stop the current ambienttrack if one is playing otherwise we will get 2 tracks playing at the same time!
		    	wait 0.5;
		    	ambientPlay("ghost");						//Change the ambienttrack to the song we chose, make sure this is the same as in the soundalias you are gonna use!
		    	level.music_trigger delete();					//Delete the music trigger as we have chosen a song!				//Print in the left corner which song we chose
		    }
		    if(response == "song2")						//If the script response for the menu is "song2"
		    {
		    	AmbientStop();							//Stop the current ambienttrack if one is playing otherwise we will get 2 tracks playing at the same time!
		    	wait 0.5;
		    	ambientPlay("azu");						//Change the ambienttrack to the song we chose, make sure this is the same as in the soundalias you are gonna use!
		    	level.music_trigger delete();					//Delete the music trigger as we have chosen a song!			//Print in the left corner which song we chose
		    }
		     if(response == "song3")						//If the script response for the menu is "song3"
		    {
		    	AmbientStop();							//Stop the current ambienttrack if one is playing otherwise we will get 2 tracks playing at the same time!
		    	wait 0.5;
		    	ambientPlay("fight");						//Change the ambienttrack to the song we chose, make sure this is the same as in the soundalias you are gonna use!
		    	level.music_trigger delete();					//Delete the music trigger as we have chosen a song!
		    }
		    if(response == "song4")						//If the script response for the menu is "song4"
		    {
		    	AmbientStop();							//Stop the current ambienttrack if one is playing otherwise we will get 2 tracks playing at the same time!
		    	wait 0.5;
		    	ambientPlay("pol");						//Change the ambienttrack to the song we chose, make sure this is the same as in the soundalias you are gonna use!
		    	level.music_trigger delete();					//Delete the music trigger as we have chosen a song!
		    }
		     if(response == "song5")						//If the script response for the menu is "song5"
		    {
		    	AmbientStop();							//Stop the current ambienttrack if one is playing otherwise we will get 2 tracks playing at the same time!
		    	wait 0.5;
		    	ambientPlay("ill");						//Change the ambienttrack to the song we chose, make sure this is the same as in the soundalias you are gonna use!
		    	level.music_trigger delete();					//Delete the music trigger as we have chosen a song!
		    }
	   }
	}

	level waittill("round_ended");							//Wait till the current round is over
	AmbientStop();									//Stop our music track so the endround music can play!
}



secret_step1()
{
	trig = getEnt("sec_step1","targetname");
	brush = getEnt("brush_sec", "targetname");

	brush hide();

	trig waittill ("trigger", player);
	
	player iPrintLnBold("^31/4");
	trig delete();
	thread secret_step2();
}

secret_step2()
{
	trig = getEnt("sec_step2","targetname");
	trig waittill ("trigger", player);
	
	player iPrintLnBold("^32/4");
	trig delete();
	thread secret_step3();
}

secret_step3()
{
	trig = getEnt("sec_step3","targetname");
	trig waittill ("trigger", player);
	
	player iPrintLnBold("^33/4");
	trig delete();
	thread secret_step4();
}

secret_step4()
{
	trig = getEnt("sec_step4","targetname");
	trig waittill ("trigger", player);
	
	player iPrintLnBold("^34/4");
	trig delete();
	thread secret_open();
}

secret_open()
{	
	brush = getEnt("brush_sec", "targetname");
	trig_tp = getEnt("sec_enter", "targetname");	
	
	trig_tp enableLinkTo ();
  trig_tp linkTo (brush);
	brush moveZ(580, 2);
	wait 1.2;
	brush show();
}

secret_enter() 
{
	trig = getEnt("sec_enter", "targetname");
	tele1 = getEnt("sr_1", "targetname");

	for(;;)
		{
			trig waittill("trigger", player);
			player thread secret_timer();
			player setOrigin(tele1.origin);
			player setPlayerAngles(tele1.angles);
			player freezeControls(1);
			wait 0.01;
			player freezeControls(0);
		}
}

secret_timer() //VC'Blades Timer
{
	self endon("secret_done");
	self endon ("death");
  self endon("joined_spectators");
	

	if(isdefined(self.secretTimer))
	self.secretTimer destroy();

	self.secretTimer=newclienthudelem(self);
	self.secretTimer.foreground = true;
	self.secretTimer.alignX = "center";
	self.secretTimer.alignY = "bottom";
	self.secretTimer.horzAlign = "center";
  self.secretTimer.vertAlign = "bottom";
  self.secretTimer.x = 0;
  self.secretTimer.y = -7;
  self.secretTimer.sort = 5;
  self.secretTimer.fontScale = 1.6;
  self.secretTimer.font = "default";
  self.secretTimer.glowAlpha = 0;
  self.secretTimer.hidewheninmenu = true;
  self.secretTimer.label = &"^7Time in Secret: ^1&&1";
  if(isdefined(level.randomcolor))
	self.secretTimer.glowColor=level.randomcolor;
	else 
	self.secretTimer.glowColor=(5,6,2);

	time=90;
	for(i=0;i<time;i++)
		{
		self.secretTimer setvalue(time-i);
		wait 1;
		}
	self.secretTimer setvalue(0);
	self suicide();

	if(isdefined(self.secretTimer))
	self.secretTimer destroy();
}

vc_intel()
{
	intel = getEnt("vc_intel","targetname");
	trig = getEnt("trig2","targetname");

	trig setHintString("Press ^3[&&1] ^7To Collect Alien Intel");

	trig waittill("trigger", player);

	player thread hud_text("Alien Intel ^3#1 ^7Acquired.",2.0, 6); 

	player braxi\_rank::giveRankXP( "", 250 );

	player PlaySoundToPlayer("intelligence_pickup", player);
	iPrintLn("^3"+ player.name + " ^7Has Secured Alien Intel #1");

	intel delete();
	trig delete();
}

vc_intel_2()
{
	intel = getEnt("vc_intel2","targetname");
	trig = getEnt("trig_intel2","targetname");

	trig setHintString("Press ^3[&&1] ^7To Collect Alien Intel");

	trig waittill("trigger", player);

	player thread hud_text("Alien Intel ^3#3 ^7Acquired.",2.0, 6); 

	player braxi\_rank::giveRankXP( "", 250 );

	player PlaySoundToPlayer("intelligence_pickup", player);
	iPrintLn("^3"+ player.name + " ^7Has Secured Alien Intel #3");

	intel delete();
	trig delete();
}

vc_intel_3()
{
	intel = getEnt("vc_intel3","targetname");
	trig = getEnt("trig_intel3","targetname");

	trig setHintString("Press ^3[&&1] ^7To Collect Alien Intel");

	trig waittill("trigger", player);

	player thread hud_text("Alien Intel ^3#4 ^7Acquired.",2.0, 6); 

	player braxi\_rank::giveRankXP( "", 250 );

	player PlaySoundToPlayer("intelligence_pickup", player);
	iPrintLn("^3"+ player.name + " ^7Has Secured Alien Intel #4");

	intel delete();
	trig delete();
}

vc_intel_4()
{
	intel = getEnt("vc_intel4","targetname");
	trig = getEnt("trig_intel4","targetname");

	trig setHintString("Press ^3[&&1] ^7To Collect Alien Intel");

	trig waittill("trigger", player);

	player thread hud_text("Alien Intel ^3#5 ^7Acquired.",2.0, 6); 

	player braxi\_rank::giveRankXP( "", 250 );

	player PlaySoundToPlayer("intelligence_pickup", player);
	iPrintLn("^3"+ player.name + " ^7Has Secured Alien Intel #5");

	intel delete();
	trig delete();
}

vc_intel_5()
{
	intel = getEnt("vc_intel5","targetname");
	trig = getEnt("trig_intel5","targetname");

	trig setHintString("Press ^3[&&1] ^7To Collect Alien Intel");

	trig waittill("trigger", player);

	player thread hud_text("Alien Intel ^3#2 ^7Acquired.",2.0, 6); 

	player braxi\_rank::giveRankXP( "", 250 );

	player PlaySoundToPlayer("intelligence_pickup", player);
	iPrintLn("^3"+ player.name + " ^7Has Secured Alien Intel #2");

	intel delete();
	trig delete();
}


bounce_room_weapon()
{
	trig = getEnt("b_wep", "targetname");
	
	trig setHintString("^7Press [^3&&1^7] For R700");
	
		for(;;)
		{	
			trig waittill ("trigger",player );
			player takeAllWeapons();
			player giveWeapon("remington700_mp");
			player giveMaxAmmo("remington700_mp");
			player switchToWeapon("remington700_mp");
			wait 0.1;
		}
}

trap_1()
{
    trig = getEnt("trig_trap1", "targetname");
    brush = getEnt("trap1","targetname");

    	
	trig setHintString("Press ^7[^3&&1^7] ^7To Activate");
	
	trig waittill("trigger", player);
	
	player braxi\_rank::giveRankXP( "", 20 );
	
	trig delete();

	brush delete();
}

trap_2()
{
    trig = getEnt("trig_trap2", "targetname");
    brush = getEnt("trap2_brush","targetname");

	trig setHintString("Press ^7[^3&&1^7] ^7To Activate");
	
	trig waittill("trigger", player);
	
	player braxi\_rank::giveRankXP( "", 20 );
	
	trig delete();

    for(;;)
	{
    brush rotateYaw(90,1);
    wait 4;
	}

}

trap_3()
{
    trig = getEnt("trig_trap3", "targetname");
    brush = getEnt("trap3_brush","targetname");

	trig setHintString("Press ^7[^3&&1^7] ^7To Activate");
	
	trig waittill("trigger", player);
	
	player braxi\_rank::giveRankXP( "", 20 );
	
	trig delete();
  brush delete();


}

trap_4()
{
    trig = getEnt("trig_trap4", "targetname");
    brush1 = getEnt("trap4_brush1","targetname");
    brush2 = getEnt("trap4_brush2","targetname");
    brush3 = getEnt("trap4_brush3","targetname");
	
		brush1 hide();
		brush1 notSolid();	
		brush2 hide();
		brush2 notSolid();	
		brush3 hide();
		brush3 notSolid();
		

		trig setHintString("Press ^7[^3&&1^7] ^7To Activate");
		
		trig waittill("trigger", player);
		
		player braxi\_rank::giveRankXP( "", 20 );
		
		trig delete();

		brush1 show();
		brush1 solid();	
		
		brush1 moveX(-96,1);
		brush1 rotatePitch(720,1);
		wait 0.2;
		brush2 show();
		brush2 solid();	
		brush2 moveX(96,1);
		brush2 rotatePitch(720,1);
		wait 0.2;
		brush3 show();
		brush3 solid();
		brush3 moveX(96,1);
		brush3 rotatePitch(720,1);

}


trap_5()
{
    trig = getEnt("trig_trap5", "targetname");
    brush = getEnt("trap5","targetname");

	trig setHintString("Press ^7[^3&&1^7] ^7To Activate");
	
	trig waittill("trigger", player);
	
	player braxi\_rank::giveRankXP( "", 20 );
	
	trig delete();

    for(;;)
	{
    brush rotateYaw(180,1);
    wait 4;
	brush moveZ(-200,1);
	brush rotateYaw(-180,1);
	wait 4;
	brush moveZ(200,1);
	brush rotateYaw(180,1);
	wait 4;
	}

}

trap_6()
{
    trig = getEnt("trig_trap6", "targetname");
    brush1 = getEnt("trap6_1","targetname");
	brush2 = getEnt("trap6_2","targetname");

	trig setHintString("Press ^7[^3&&1^7] ^7To Activate");
	
	trig waittill("trigger", player);
	
	player braxi\_rank::giveRankXP( "", 20 );
	
	trig delete();

    brush1 moveX(512,0.3);
	brush2 moveX(-512,0.3);
	wait 4;
	brush1 moveX(-512,1);
	brush2 moveX(512,1);

}

trap_7()
{
    trig = getEnt("trig_trap7", "targetname");
    safe = getEnt("trap7_1","targetname");
	trap = getEnt("trap7_2","targetname");

	trig setHintString("Press ^7[^3&&1^7] ^7To Activate");

	trap hide();
	trap notSolid();
	
	trig waittill("trigger", player);
	
	player braxi\_rank::giveRankXP( "", 20 );
	
	trig delete();

    for(;;)
	{
    safe hide();
		safe notSolid();
		trap show();
		wait 2;
		safe show();
		safe Solid();
		trap hide();
		wait 4;
		safe hide();
		safe notSolid();
		trap show();
		wait 1;
	}

}

trap_8()
{
	trig = getEnt ("trig_trap8","targetname");
	trap1 = getEnt ("trap8_1","targetname");
	trap2 = getEnt ("trap8_2","targetname");

	trig setHintString("Press ^7[^3&&1^7] ^7To Activate");

	trig waittill ("trigger", player);

	player braxi\_rank::giveRankXP("", 20);

	trig delete();

	x = randomintrange(0, 2);
	if(x == 0)
	{
		trap1 moveZ(104,1);
	}
	else if(x == 1)
	{
		trap2 moveZ(104,1);
	}
}


trap_9()
{
    trig = getEnt("trig_trap9", "targetname");
    brush = getEnt("trap9","targetname");

	trig setHintString("Press ^7[^3&&1^7] ^7To Activate");
	
	trig waittill("trigger", player);
	
	player braxi\_rank::giveRankXP( "", 20 );
	
	trig delete();

    for(;;)
	{
  brush rotateRoll(180,1);
  wait 4;
	brush rotateRoll(-180,1);
	wait 2;
	brush rotateRoll(180,1);
	wait 2;
	}

}


trap_10()
{
    brush = getEnt("trap_10","targetname");

    for(;;)
	{
	wait 0.1;
    brush rotateYaw(360,2);
	}

}

sec_wep()
{
    
	trig = getEnt("trig_sec_wep", "targetname");

	trig waittill("trigger", player);

	player giveWeapon("winchester1200_mp");
	player giveMaxAmmo("winchester1200_mp");
	player switchToWeapon("winchester1200_mp");

	player iPrintLnBold("You Found a Hidden Weapon!");

	trig delete();

}

acti_tp1()
{
	trig = getEnt("acti_tp1", "targetname");
	tele1 = getEnt("acti_here1", "targetname");

	trig setHintString("Press ^7[^3&&1^7] ^7To Teleport");

	for(;;)
		{
			trig waittill("trigger", player);
			player setOrigin(tele1.origin);
			player setPlayerAngles(tele1.angles);
			player freezeControls(1);
			wait 0.01;
			player freezeControls(0); 
		}
}


slide_sec()
{
	trig = getEnt("trig_slide", "targetname");
	tele1 = getEnt("slide_here", "targetname");


			trig waittill("trigger", player);
			player setOrigin(tele1.origin);
			player setPlayerAngles(tele1.angles);
			player freezeControls(1);
			wait 0.5;
			player freezeControls(0);
			trig delete();
}

slide_exit()
{
	trig = getEnt("trig_exit", "targetname");
	tele1 = getEnt("slide_exit", "targetname");

	for(;;)
		{
			trig waittill("trigger", player);
			player braxi\_rank::giveRankXP( "", 500 );
			player setOrigin(tele1.origin);
			player setPlayerAngles(tele1.angles);
			player freezeControls(1);
			wait 0.5;
			player freezeControls(0);
		}
}


acti_tp2()
{
	trig = getEnt("acti_tp2", "targetname");
	tele1 = getEnt("acti_here2", "targetname");

	trig setHintString("Press ^7[^3&&1^7] ^7To Teleport");

	for(;;)
		{
			trig waittill("trigger", player);
			player setOrigin(tele1.origin);
			player setPlayerAngles(tele1.angles);
			player freezeControls(1);
			wait 0.01;
			player freezeControls(0);
		}
}

acti_tp3()
{
	trig = getEnt("acti_tp3", "targetname");
	tele1 = getEnt("acti_here3", "targetname");

	trig setHintString("Press ^7[^3&&1^7] ^7To Teleport");

	for(;;)
		{
			trig waittill("trigger", player);
			player setOrigin(tele1.origin);
			player setPlayerAngles(tele1.angles);
			player freezeControls(1);
			wait 0.01;
			player freezeControls(0);
		}
}

jump_tp1()
{
	trig = getEnt("jump_tp1", "targetname");
	tele1 = getEnt("jump_here1", "targetname");

	for(;;)
		{
			trig waittill("trigger", player);
			player setOrigin(tele1.origin);
			player setPlayerAngles(tele1.angles);
			player freezeControls(1);
			wait 0.01;
			player freezeControls(0);
		}
}

jump_tp2()
{
	trig = getEnt("jump_tp2", "targetname");
	tele1 = getEnt("jump_here2", "targetname");

	for(;;)
		{
			trig waittill("trigger", player);
			player setOrigin(tele1.origin);
			player setPlayerAngles(tele1.angles);
			player freezeControls(1);
			wait 0.01;
			player freezeControls(0);
		}
}

bounce_reset1()
{
	trig = getEnt("b_f_1", "targetname");
	tele1 = getEnt("b_r_1", "targetname");

	for(;;)
		{
			trig waittill("trigger", player);
			player setOrigin(tele1.origin);
			player setPlayerAngles(tele1.angles);
			player freezeControls(1);
			wait 0.01;
			player freezeControls(0);
		}
}

bounce_reset2()
{
	trig = getEnt("b_f_2", "targetname");
	tele1 = getEnt("b_r_2", "targetname");

	for(;;)
		{
			trig waittill("trigger", player);
			player setOrigin(tele1.origin);
			player setPlayerAngles(tele1.angles);
			player freezeControls(1);
			wait 0.01;
			player freezeControls(0);
		}
}

sec_fail1()
{
	trig = getEnt("sf_1", "targetname");
	tele1 = getEnt("sr_1", "targetname");

	for(;;)
		{
			trig waittill("trigger", player);
			player setOrigin(tele1.origin);
			player setPlayerAngles(tele1.angles);
			player freezeControls(1);
			wait 0.01;
			player freezeControls(0);
		}
}

sec_exit()
{
	while(1)
	{
			trig = getEnt("sec_exit", "targetname");
			tele1 = getEnt("jump_here2", "targetname");

			trig waittill("trigger", player);

			player braxi\_rank::giveRankXP( "", 750 );
			iPrintLnBold("^3"+ player.name + " ^7Has Finished the Secret");	
			player notify("secret_done");
			player.secretTimer destroy();
			player giveWeapon("ak74u_mp");
			player giveMaxAmmo("ak74u_mp");
			player switchToWeapon("ak74u_mp");
			player detachAll();
			player setModel("playermodel_bo1_pilot");
			player setViewModel("viewhands_bo1_pilot");
			player setOrigin(tele1.origin);
			player setPlayerAngles(tele1.angles);
			player freezeControls(1);
			wait 0.5;
			player freezeControls(0);
		}
}




sec_fail2()
{
	trig = getEnt("sf_2", "targetname");
	tele1 = getEnt("sr_2", "targetname");

	for(;;)
		{
			trig waittill("trigger", player);
			player setOrigin(tele1.origin);
			player setPlayerAngles(tele1.angles);
			player freezeControls(1);
			wait 0.01;
			player freezeControls(0);
		}
}

knife_room()
{
	while(1)
	{
		level.trigknife = getEnt("trig_knife","targetname");
		acti = getEnt("k_1","targetname");
		jump = getEnt("k_2","targetname");
		
		level.trigknife setHintString("^3Knife ^7Room");
		
		level.trigknife waittill("trigger", player);

		// ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================
		
		level.trigbounce delete();
	  level.trigsniper delete();
		level.trigspeed delete();

		iPrintLnBold("^3" + player.name + "^7 Choose Knife Room!");

		ambientStop(1);
		ambientPlay("knife");
		
		player setOrigin (jump.origin);
		player setPlayerAngles (jump.angles);

		level.activ setOrigin (acti.origin);
		level.activ setPlayerAngles (acti.angles);
	
		player takeAllWeapons();
		level.activ takeAllWeapons();
		
		player freezeControls(1);
		level.activ freezeControls(1);
		
		player.maxhealth = 100;
		player.health = player.maxhealth;
		level.activ.maxhealth = 100;
		level.activ.health = level.activ.maxhealth;  
		

		player takeAllWeapons();
		player giveWeapon("knife_mp");
		player switchToWeapon("knife_mp");
		
		level.activ takeAllWeapons();
		level.activ giveWeapon("knife_mp");
		level.activ switchToWeapon("knife_mp");

		wait 5;
		player iPrintLnBold("^7FIGHT!");
		level.activ iPrintLnBold("^7FIGHT!");
		
		player freezeControls(0);
		level.activ freezeControls(0);
	
		while( isAlive( player ) && isDefined( player ) && player.sessionstate == "playing" )
		wait 0.5;
		
		iPrintLnBold("^3" + player.name + "^7 Has Died!");
		wait 1;
		iPrintLnBold("^7Knife Room Open!");
		player = undefined;
		
	}
}

bounce_room()
{
	while(1)
	{
		level.trigbounce = getEnt("trig_bounce","targetname");
		acti = getEnt("b_r_1","targetname");
		jump = getEnt("b_r_2","targetname");
		
		level.trigbounce setHintString("^3Bounce ^7Room");
		
		level.trigbounce waittill("trigger", player);

		// ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================
		
		level.trigknife delete();
	  level.trigsniper delete();
		level.trigspeed delete();

		iPrintLnBold("^3" + player.name + "^7 Choose Bounce Room!");

		ambientStop(1);
		ambientPlay("bounce");
		
		player setOrigin (jump.origin);
		player setPlayerAngles (jump.angles);

		level.activ setOrigin (acti.origin);
		level.activ setPlayerAngles (acti.angles);
	
		player takeAllWeapons();
		level.activ takeAllWeapons();
		
		player freezeControls(1);
		level.activ freezeControls(1);
		
		player.maxhealth = 100;
		player.health = player.maxhealth;
		level.activ.maxhealth = 100;
		level.activ.health = level.activ.maxhealth;  
		

		player takeAllWeapons();
		player giveWeapon("knife_mp");
		player switchToWeapon("knife_mp");
		
		level.activ takeAllWeapons();
		level.activ giveWeapon("knife_mp");
		level.activ switchToWeapon("knife_mp");

		wait 5;
		player iPrintLnBold("^7FIGHT!");
		level.activ iPrintLnBold("^7FIGHT!");
		
		player freezeControls(0);
		level.activ freezeControls(0);
	
		while( isAlive( player ) && isDefined( player ) && player.sessionstate == "playing" )
		wait 0.5;
		
		iPrintLnBold("^3" + player.name + "^7 Has Died!");
		wait 1;
		iPrintLnBold("^7Bounce Room Open!");
		player = undefined;
		
	}
}


sniper_room()
{
	while(1)
	{
		level.trigsniper = getEnt("trig_sniper","targetname");
		acti = getEnt("s_1","targetname");
		jump = getEnt("s_2","targetname");
		
		level.trigsniper setHintString("^3Scope ^7Room");
		
		level.trigsniper waittill("trigger", player);

		// ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================
		
		level.trigknife delete();
	  level.trigbounce delete();
		level.trigspeed delete();

		iPrintLnBold("^3" + player.name + "^7 Choose Scope Room!");

		ambientStop(1);
		ambientPlay("sniper");
		
		player setOrigin (jump.origin);
		player setPlayerAngles (jump.angles);

		level.activ setOrigin (acti.origin);
		level.activ setPlayerAngles (acti.angles);
	
		player takeAllWeapons();
		level.activ takeAllWeapons();
		
		player freezeControls(1);
		level.activ freezeControls(1);
		
		player.maxhealth = 100;
		player.health = player.maxhealth;
		level.activ.maxhealth = 100;
		level.activ.health = level.activ.maxhealth;  
		

		player takeAllWeapons();
		player giveWeapon("m40a3_mp");
		player giveMaxAmmo("m40a3_mp");
		player switchToWeapon("m40a3_mp");
		player giveWeapon("remington700_mp");
		player giveMaxAmmo("remington700_mp");
		player switchToWeapon("remington700_mp");
		
		level.activ takeAllWeapons();
		level.activ giveWeapon("m40a3_mp");
		level.activ giveMaxAmmo("m40a3_mp");
		level.activ switchToWeapon("m40a3_mp");
		level.activ giveWeapon("remington700_mp");
		level.activ giveMaxAmmo("remington700_mp");
		level.activ switchToWeapon("remington700_mp");

		wait 5;
		player iPrintLnBold("^7FIGHT!");
		level.activ iPrintLnBold("^7FIGHT!");
		
		player freezeControls(0);
		level.activ freezeControls(0);
	
		while( isAlive( player ) && isDefined( player ) && player.sessionstate == "playing" )
		wait 0.5;
		
		iPrintLnBold("^3" + player.name + "^7 Has Died!");
		wait 1;
		iPrintLnBold("^7Scope Room Open!");
		player = undefined;
		
	}
}

speed_room()
{
	while(1)
	{
		level.trigspeed = getEnt("trig_speed","targetname");
		acti = getEnt("s_1","targetname");
		jump = getEnt("s_2","targetname");
		
		level.trigspeed setHintString("^3Pistol ^7Room");
		
		level.trigspeed waittill("trigger", player);

		// ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================
		
		level.trigknife delete();
		level.trigbounce delete();
	  level.trigsniper delete();

		iPrintLnBold("^3" + player.name + "^7 Choose Pistol Room!");

		ambientStop(1);
		ambientPlay("bop");
		
		player setOrigin (jump.origin);
		player setPlayerAngles (jump.angles);

		level.activ setOrigin (acti.origin);
		level.activ setPlayerAngles (acti.angles);
	
		player takeAllWeapons();
		level.activ takeAllWeapons();
		
		player freezeControls(1);
		level.activ freezeControls(1);
		
		player.maxhealth = 100;
		player.health = player.maxhealth;
		level.activ.maxhealth = 100;
		level.activ.health = level.activ.maxhealth;  
		

		player takeAllWeapons();
		player giveWeapon("colt45_mp");
		player giveMaxAmmo("colt45_mp");
		player giveWeapon("usp_mp");
		player giveMaxAmmo("usp_mp");
		player switchToWeapon("usp_mp");
		
		level.activ takeAllWeapons();
		level.activ giveWeapon("colt45_mp");
		level.activ giveMaxAmmo("colt45_mp");
		level.activ giveWeapon("usp_mp");
		level.activ giveMaxAmmo("usp_mp");
		level.activ switchToWeapon("usp_mp");

		wait 5;
		player iPrintLnBold("^7FIGHT!");
		level.activ iPrintLnBold("^7FIGHT!");
		
		player freezeControls(0);
		level.activ freezeControls(0);

	
		while( isAlive( player ) && isDefined( player ) && player.sessionstate == "playing" )
		wait 0.5;
		
		iPrintLnBold("^3" + player.name + "^7 Has Died!");
		wait 1;
		iPrintLnBold("^7Pistol Room Open!");
		player = undefined;
		
	}
}


hud_text( text, scale, alap )
{

if ( alap == 1 )
{
  hud = addTextHud( self, 320, 60, 0, "center", "top", scale );
}
else if( alap == 2 )
{
  hud = addTextHud( self, 320, 95, 0, "center", "top", scale );
}
else if( alap == 3 )
{
  hud = addTextHud( self, 320, 130, 0, "center", "top", scale );
}
else if( alap == 4 )
{
  hud = addTextHud( self, 320, 165, 0, "center", "top", scale );
}
else if( alap == 5 )
{
  hud = addTextHud( self, 320, 200, 0, "center", "top", scale );
}
else if( alap == 6 )
{
  hud = addTextHud( self, 320, 235, 0, "center", "top", scale );
}
else if( alap == 7 )
{
  hud = addTextHud( self, 320, 270, 0, "center", "top", scale );
}
else if( alap == 8 )
{
  hud = addTextHud( self, 320, 305, 0, "center", "top", scale );
}
else if( alap == 9 )
{
  hud = addTextHud( self, 320, 340, 0, "center", "top", scale );
}
else if( alap == 10 )
{
  hud = addTextHud( self, 320, 375, 0, "center", "top", scale );
}
else
{
  hud = addTextHud( self, 320, 60, 0, "center", "top", scale );
}


  hud setText( text );

  hud.glowColor = (0.7,0,0);
  hud.glowAlpha = 1;
  hud SetPulseFX( 30, 100000, 700 );

  hud fadeOverTime(0.8);
  hud.alpha = 1;

  wait 2.6;

  hud fadeOverTime(0.8);
  hud.alpha = 0;
  wait 1;

  hud destroy();
}

addTextHud( who, x, y, alpha, alignX, alignY, fontScale )
{
  hud = newClientHudElem(self);

  hud.x = x;
  hud.y = y;
  hud.alpha = alpha;
  hud.alignX = alignX;
  hud.alignY = alignY;
  hud.fontScale = fontScale;
  return hud;
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
         ent[i].pers["registered"] = 0;
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
