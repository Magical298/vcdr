
//Map by #FNRP#ABprice
//Custom Weapons And View Hands By VC' Fox

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
	
	precacheItem( "deserteaglegold_mp" );
	precacheItem("m40a3_mp");
	precacheItem("remington700_mp");
	precacheItem("ak47_acog_mp");
	precacheItem("rpg_mp");
	precacheItem("winchester1200_mp");
	precacheModel("viewhands_mw3_juggernaut_opforce");
	precacheItem("pricedeagle_mp");
	
	thread rope();
	thread messages();
	thread bottomtext();
	thread music();
	thread freegun();
	thread freegun1();
	thread sniper();
    //thread spawn1();
	//Traps easy
	thread trap1();
	thread trap2();
	thread trap3();
	thread trap4();
	thread trap5();
	thread trap6();
	thread trap7();
	thread trap8();
	//traps normal
	thread trap9();
	thread trap10();
	thread trap11();
	thread trap12();
	thread trap13();
	thread trap14();
	thread trap15();
	thread trap16();
	//elevators
	thread ele1();
	thread ele2();
	thread ele3();
	//tele
	thread tele1();
	thread tele2();
	thread tele3();
	thread tele4();
	thread tele5();
	thread tele6();
	thread tele7();
	thread tele8();
	thread tele9();
	thread tele10();
	thread tele11();
	thread secret();
	//rooms
	thread sniper_room();
	thread knife_room();
	thread bounce_room();
	thread shotgun_room();
	thread addTestClients();
	
	
	addTriggerToList( "trig_trap1" );
	addTriggerToList( "trig_trap2" );
	addTriggerToList( "trig_trap3" );
	addTriggerToList( "trig_trap4" );
	addTriggerToList( "trig_trap5" );
	addTriggerToList( "trig_trap6" );
	addTriggerToList( "trig_trap7" );
	addTriggerToList( "trig_trap8" );
	addTriggerToList( "trig_trap9" );
	addTriggerToList( "trig_trap10" );
	addTriggerToList( "trig_trap11" );
	addTriggerToList( "trig_trap12" );
	addTriggerToList( "trig_trap13" );
	addTriggerToList( "trig_trap14" );
	addTriggerToList( "trig_trap15" );
	addTriggerToList( "trig_trap16" );
}



messages()
{
wait 10;
iprintlnBold("^3Welcome To The AB_v2^1, ^5Map By #FNRP#ABprice");
wait 1;
}

bottomtext()
{
	level waittill("round_started");
	while(1)
	{
	wait 10;
	iPrintLn("^3Welcome to mp_dr_AB_V2!");
	wait 10;
	iPrintLn("^5Map By ^3#FNRP#ABprice");
	wait 5;
	iPrintLn("^5Hope You Enjoy");
	wait 5;
	iPrintLn("^5Every Gaps And Bounce Tested");
	wait 5;
	iPrintLn("^5Any Bug? Send Me Pm On FNRP Forms");
	wait 10;
	iPrintLn("^5There is ^11 ^5Secret on this map!");
	wait 10;
	iPrintLn("^6Thanks To ^5VC' Fox ^6For Helping Me");
	wait 10;
	iPrintLn("^6Thanks To Tester ^5Pro_Helper");
	wait 10;
	iPrintLn("^6Thanks To All ^3FNRP ^6Members");
	wait 10;
	iPrintLn("^3www.fnrp-servers.com");
	}
	
}

music()
{
 x = randomInt(3);
    if(x == 2)
    {
    ambientPlay("music1");
    }
    if(x == 1)
    {
    ambientPlay("music2");
    }
     if(x == 0)
    {
    ambientPlay("music3");
    }
}

sniper()
{
    trigger = getEnt("trig_sniper", "targetname");
	trigger SetHintString("^1 Press F To Take Gun");
    precacheItem("remington700_mp");	
    while(1)
    {
    trigger waittill("trigger", player);
    player GiveWeapon("remington700_mp");
	player giveMaxAmmo("remington700_mp");
    player SwitchToWeapon( "remington700_mp" );
	
    }
}
rope()
{
 trig = getent ("rope_trig","targetname"); 
 start = getent ("rope_start","targetname"); 
 stop = getent ("rope_end","targetname"); 

 while(true)
 {
  trig waittill ("trigger", player);
  
   link = spawn ("script_model",player.origin);
   player linkTo (link);
   link moveTo (start.origin, 1);
   wait 1;
   link moveTo (stop.origin, 8);
   wait 8;
   player unlink();
 }
}

freegun()
{
    trigger = getEnt("trig_freegun", "targetname");
	trigger SetHintString("^7 Press ^3F ^7To Take ^5Sniper's set");
    precacheItem("deserteagle_mp");
	precacheItem("remington700_mp");
    while(1)
    {
    trigger waittill("trigger", player);
    player GiveWeapon("deserteaglegold_mp");
	player GiveWeapon("remington700_mp");
    player SwitchToWeapon( "deserteaglegold_mp" );
	
    }
}
freegun1()
{
    trigger = getEnt("trig_freegun1", "targetname");
	trigger SetHintString("^7 Press ^3F ^7To Take ^6price deagle");
    precacheItem("pricedeagle_mp");
    while(1)
    {
    trigger waittill("trigger", player);
    player GiveWeapon("pricedeagle_mp");
    player SwitchToWeapon( "pricedeagle_mp" );
	
    }
}

spawn1()
{
    for(;;)
    {
        level waittill("player_spawn", player );
        player setViewModel("viewhands_mw3_juggernaut_opforce");
    }
}

trap1()
{
    platform1 = getent("trap1", "targetname");
    trig = getent("trig_trap1", "targetname");
	trig SetHintString("^2Press ^5[F] ^2To Activate");
	trig waittill("trigger", player);
	
	player braxi\_rank::giveRankXP("", 30);
	trig delete();
	
    for(;;)
	{
	platform1 rotateYaw (90,2);
	wait 3;
	}

	
	
	}

	
trap2()
{
    square = getEnt("square", "targetname");
    trig = getent("trig_trap2", "targetname");
	kill = getEnt("trigger_kill", "targetname");
	kill enablelinkto ();
    kill linkto (square);
	trig SetHintString("^2Press ^5[F] ^2To Activate");
	trig waittill("trigger", player);
	
	player braxi\_rank::giveRankXP("", 30);
	trig delete();
	
	square moveZ (-900,6);
	wait 4;


	
	
	}
	
	
trap3()
{
    platform3 = getent("trap3", "targetname");
    trig = getent("trig_trap3", "targetname");
	trig SetHintString("^2Press ^5[F] ^2To Activate");
	trig waittill("trigger", player);
	
	platform3 moveX (-832,1);
	wait 5;
	platform3 moveX (832,10);
	player braxi\_rank::giveRankXP("", 30);
	
	trig delete();
    }
	
trap4()
{
    platform4 = getent("trap4", "targetname");
    trig = getent("trig_trap4", "targetname");
	trig SetHintString("^2Press ^5[F] ^2To Activate");
	trig waittill("trigger", player);
	
	player braxi\_rank::giveRankXP("", 30);
	
for(;;)
	{
	trig delete();
	platform4 rotatepitch (-360, 3);
	wait 4;
	platform4 rotatepitch (360, 3);
	wait 4;
	}
	
}

trap5()
{
	trig = getent("trig_trap5", "targetname");
	a = getent("trap5_1", "targetname");
	b = getent("trap5_2", "targetname");
	c = getent("trap5_3", "targetname");
	d = getent("trap5_4", "targetname");
    trig SetHintString("^2Press ^5[F] ^2To Activate");
	trig waittill("trigger", player);
	
	player braxi\_rank::giveRankXP("", 30);

	for(;;)
	{
	trig delete();
	a rotateroll (360, 1);
	wait 2;
	b rotateroll (360, 1);
	wait 2;
	c rotateroll (360, 1);
	wait 2;
	d rotateroll (360, 1);
	wait 2;
	}
	
}


trap6()
{
    platform3 = getent("trap6", "targetname");
    trig = getent("trig_trap6", "targetname");
	trig SetHintString("^2Press ^5[F] ^2To Activate");
	trig waittill("trigger", player);
	
	platform3 rotatepitch (360,3);
	player braxi\_rank::giveRankXP("", 30);
	
	trig delete();
    }
	
	
trap7()
{
    platform1 = getent("trap7", "targetname");
	platform2 = getent("trap7i", "targetname");
    trig = getent("trig_trap7", "targetname");
	trig SetHintString("^2Press ^5[F] ^2To Activate");
	trig waittill("trigger", player);
	
	platform1 delete();
	platform2 delete();
	player braxi\_rank::giveRankXP("", 30);
	
	trig delete();
	}

	
trap8()
{
    platform1 = getent("trap8", "targetname");
    trig = getent("trig_trap8", "targetname");
	trig SetHintString("^2Press ^5[F] ^2To Activate");
	trig waittill("trigger", player);
	
	player braxi\_rank::giveRankXP("", 30);
	trig delete();
	
    for(;;)
	{
	wait 0.1;
	platform1 rotateYaw (360,2);
	wait 0.1;
	}
	

}

trap9()
{
    platform1 = getent("trap9", "targetname");
    trig = getent("trig_trap9", "targetname");
	trig SetHintString("^2Press ^5[F] ^2To Activate");
	trig waittill("trigger", player);
	
	player braxi\_rank::giveRankXP("", 30);
	trig delete();
	
    for(;;)
	{
	platform1 rotateYaw (90,2);
	wait 3;
	}

	
	
	}

	
trap10()
{
    square = getEnt("square2", "targetname");
    trig = getent("trig_trap10", "targetname");
	kill = getEnt("trigger_kill2", "targetname");
	kill enablelinkto ();
    kill linkto (square);
	trig SetHintString("^2Press ^5[F] ^2To Activate");
	trig waittill("trigger", player);
	
	player braxi\_rank::giveRankXP("", 30);
	trig delete();
	
	square moveZ (-900,6);
	wait 4;


	
	
	}
	
trap11()
{
    platform3 = getent("trap11", "targetname");
    trig = getent("trig_trap11", "targetname");
	trig SetHintString("^2Press ^5[F] ^2To Activate");
	trig waittill("trigger", player);
	
	platform3 moveX (800,1);
	wait 5;
	platform3 moveX (-800,1);
	player braxi\_rank::giveRankXP("", 30);
	
	trig delete();
    }
	
	
trap12()
{
    platform4 = getent("trap12", "targetname");
    trig = getent("trig_trap12", "targetname");
	trig SetHintString("^2Press ^5[F] ^2To Activate");
	trig waittill("trigger", player);
	
	player braxi\_rank::giveRankXP("", 30);
	
for(;;)
	{
	trig delete();
	platform4 rotatepitch (-360, 3);
	wait 4;
	platform4 rotatepitch (360, 3);
	wait 4;
	}
	
}


trap13()
{
	trig = getent("trig_trap13", "targetname");
	a = getent("trap13_1", "targetname");
	b = getent("trap13_2", "targetname");
	c = getent("trap13_3", "targetname");
	d = getent("trap13_4", "targetname");
    trig SetHintString("^2Press ^5[F] ^2To Activate");
	trig waittill("trigger", player);
	
	player braxi\_rank::giveRankXP("", 30);

	for(;;)
	{
	trig delete();
	a rotateroll (360, 1);
	wait 2;
	b rotateroll (360, 1);
	wait 2;
	c rotateroll (360, 1);
	wait 2;
	d rotateroll (360, 1);
	wait 2;
	}
	
}


trap14()
{
    platform3 = getent("trap14", "targetname");
    trig = getent("trig_trap14", "targetname");
	trig SetHintString("^2Press ^5[F] ^2To Activate");
	trig waittill("trigger", player);
	
	platform3 rotatepitch (360,3);
	player braxi\_rank::giveRankXP("", 30);
	
	trig delete();
    }
	
trap15()
{
    platform1 = getent("trap15", "targetname");
    trig = getent("trig_trap15", "targetname");
	trig SetHintString("^2Press ^5[F] ^2To Activate");
	trig waittill("trigger", player);
	
	platform1 delete();
	player braxi\_rank::giveRankXP("", 30);
	
	trig delete();
	}
	
	
trap16()
{
    platform1 = getent("trap16", "targetname");
    trig = getent("trig_trap16", "targetname");
	trig SetHintString("^2Press ^5[F] ^2To Activate");
	trig waittill("trigger", player);
	
	player braxi\_rank::giveRankXP("", 30);
	trig delete();
	
    for(;;)
	{
	wait 0.1;
	platform1 rotateYaw (360,2);
	wait 0.1;
	}
	

}
//elevators

ele1()
{
    platform1 = getent("ele1", "targetname");
    trig = getent("trig_ele1", "targetname");
	trig waittill("trigger", player);
	
for(;;)
	{
	trig delete();
	wait 2;
	platform1 moveY (688, 2);
	wait 4;
	platform1 moveY (-688, 2);
	wait 4;
	}
	
}


ele2()
{
    platform1 = getent("ele2", "targetname");
    trig = getent("trig_ele2", "targetname");
	trig waittill("trigger", player);
	
for(;;)
	{
	trig delete();
	wait 2;
	platform1 moveY (-688, 2);
	wait 4;
	platform1 moveY (688, 2);
	wait 4;
	}
	
}


ele3()
{
    platform1 = getent("ele3", "targetname");
    trig = getent("trig_ele3", "targetname");
	trig waittill("trigger", player);
	
for(;;)
	{
	trig delete();
	wait 2;
	platform1 moveY (-688, 2);
	wait 4;
	platform1 moveY (688, 2);
	wait 4;
	}
	
}

tele1()
{    
     trig = getEnt("trig_tele1", "targetname");
	 tele = getEnt("origin_tele1", "targetname");
	 
	 for(;;)
	 {
		 trig waittill("trigger", player);
		 player setorigin(tele.origin);
		 player freezeControls(1);
         wait 0.02;
         player freezeControls(0);
	 }
}


tele2()
{    
     trig = getEnt("trig_tele2", "targetname");
	 tele = getEnt("origin_tele2", "targetname");
	 
	 for(;;)
	 {
		 trig waittill("trigger", player);
		 player setorigin(tele.origin);
		 player freezeControls(1);
         wait 0.02;
         player freezeControls(0);
	 }
}


tele3()
{    
     trig = getEnt("trig_tele3", "targetname");
	 tele = getEnt("origin_tele3", "targetname");
	 
	 for(;;)
	 {
		 trig waittill("trigger", player);
		 player setorigin(tele.origin);
		 player freezeControls(1);
         wait 0.02;
         player freezeControls(0);
	 }
}


tele4()
{    
     trig = getEnt("trig_tele4", "targetname");
	 tele = getEnt("origin_tele4", "targetname");
	 
	 for(;;)
	 {
		 trig waittill("trigger", player);
		 player setorigin(tele.origin);
		  player freezeControls(1);
         wait 0.02;
         player freezeControls(0);
	 }
}


tele5()
{    
     trig = getEnt("trig_tele5", "targetname");
	 tele = getEnt("origin_tele5", "targetname");
	 
	 for(;;)
	 {
		 trig waittill("trigger", player);
		 player setorigin(tele.origin);
		 player freezeControls(1);
         wait 0.02;
         player freezeControls(0);
	 }
}

tele6()
{    
     trig = getEnt("trig_tele6", "targetname");
	 tele = getEnt("origin_tele6", "targetname");
	 
	 for(;;)
	 {
		 trig waittill("trigger", player);
		 player setorigin(tele.origin);
		 player freezeControls(1);
         wait 0.02;
         player freezeControls(0);
	 }
}


tele7()
{    
     trig = getEnt("trig_tele7", "targetname");
	 tele = getEnt("origin_tele7", "targetname");
	 
	 for(;;)
	 {
		 trig waittill("trigger", player);
		 player setorigin(tele.origin);
		 player freezeControls(1);
         wait 0.02;
         player freezeControls(0);
	 }
}

tele8()
{    
     trig = getEnt("trig_tele8", "targetname");
	 tele = getEnt("origin_tele8", "targetname");
	 
	 for(;;)
	 {
		 trig waittill("trigger", player);
		 player setorigin(tele.origin);
		 player freezeControls(1);
         wait 0.02;
         player freezeControls(0);
	 }
}

tele9()
{    
     trig = getEnt("trig_tele9", "targetname");
	 tele = getEnt("origin_tele9", "targetname");
	 
	 for(;;)
	 {
		 trig waittill("trigger", player);
		 player setorigin(tele.origin);
		 player freezeControls(1);
         wait 0.02;
         player freezeControls(0);
	 }
}

tele10()
{    
     trig = getEnt("trig_tele10", "targetname");
	 tele = getEnt("origin_tele10", "targetname");
	 
	 for(;;)
	 {
		 trig waittill("trigger", player);
		 player setorigin(tele.origin);
		 player freezeControls(1);
         wait 0.02;
         player freezeControls(0);
		 player braxi\_rank::giveRankXP("", 300);
		 iPrintlnBold( " ^5" + player.name + " ^3 Finish The Secret!" );
	 }
}

tele11()
{    
     trig = getEnt("trig_tele11", "targetname");
	 tele = getEnt("origin_sec", "targetname");
	 
	 for(;;)
	 {
		 trig waittill("trigger", player);
		 player setorigin(tele.origin);
		 player freezeControls(1);
         wait 0.02;
         player freezeControls(0);
		 iPrintlnBold( " ^5" + player.name + " ^3 Enter The Secret!" );
	 }
}

secret()
{
    secretdmg = getent("sec", "targetname");
    trig = getent("trig_sec", "targetname");
	trig waittill("trigger", player);
	{
	iPrintlnBold( " ^5" + player.name + " ^3 Opened The Secret!" );
	secretdmg NotSolid();
	}
	trig delete();
}

sniper_room()
{
	while(1)
	{
	level.trigsniper = getEnt("sniper_room", "targetname");
	level.trigknife = getEnt("knife_room", "targetname");
	level.trigbounce = getEnt("bounce_room", "targetname");
	level.trigshotgun = getEnt("shotgun_room", "targetname");
	
	jumporigin = getEnt("sf_1", "targetname");
	actiorigin = getEnt("sf_2", "targetname");
	
	level.trigsniper waittill("trigger", player);

	// ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================
	
	level.trigknife delete();
	level.trigshotgun delete();
	level.trigbounce delete();
	
	iPrintLnBold("^2 " + player.name + " ^3Entered The ^5Sniper ^5Room^2!");
	player.health = player.maxhealth;
	level.activ.health = level.activ.maxhealth;
	
	
	player takeAllWeapons();
	level.activ takeAllWeapons();
	
	player giveWeapon("m40a3_mp");
	player giveWeapon("remington700_mp");
	player giveMaxAmmo("remington700_mp");
	player giveMaxAmmo("m40a3_mp");
	level.activ giveWeapon("m40a3_mp");
	level.activ giveWeapon("remington700_mp");
	level.activ giveMaxAmmo("remington700_mp");
	level.activ giveMaxAmmo("m40a3_mp");
	
	
	player switchToWeapon("m40a3_mp");
	player switchToWeapon("remington700_mp");
	level.activ switchToWeapon("m40a3_mp");
	player switchToWeapon("remington700_mp");
	
	player freezeControls(1);
	level.activ freezeControls(1);
	
	player setOrigin (jumporigin.origin);
	player setPlayerAngles (jumporigin.angles);

	level.activ setOrigin (actiorigin.origin);
	level.activ setPlayerAngles (actiorigin.angles);
	wait 2;
	
	player iPrintLnBold("^13");
	level.activ iPrintLnBold("^13");
	wait 1;
	player iPrintLnBold("^52");
	level.activ iPrintLnBold("^52");
	wait 1;
	player iPrintLnBold("^21");
	level.activ iPrintLnBold("^21");
	wait 1;
	player iPrintLnBold("^5Shoot That Activator^2!");
	level.activ iPrintLnBold("^5Shoot That Jumper^2!");
	
	player freezeControls(0);
	level.activ freezeControls(0);
	while( isAlive( player ) && isDefined( player ) )
    wait 1;
	

	}
}


knife_room()
{
	while(1)
	{
	level.trigknife = getEnt("knife_room", "targetname");
	level.trigsniper = getEnt("sniper_room", "targetname");
	level.trigbounce = getEnt("bounce_room", "targetname");
	level.trigshotgun = getEnt("shotgun_room", "targetname");
	
	jumporigin = getEnt("sf_3", "targetname");
	actiorigin = getEnt("sf_4", "targetname");
	
	level.trigknife waittill("trigger", player);

	// ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================
	
	level.trigsniper delete();
	level.trigbounce delete();
	level.trigshotgun delete();
	
	iPrintLnBold("^2 " + player.name + " ^3Entered The ^5knife ^5Room^2!");
	player.health = player.maxhealth;
	level.activ.health = level.activ.maxhealth;
	
	
	player takeAllWeapons();
	level.activ takeAllWeapons();
	
	player giveWeapon("knife_mp");
	player giveWeapon("knife_mp");
	player giveMaxAmmo("knife_mp");
	player giveMaxAmmo("knife_mp");
	level.activ giveWeapon("knife_mp");
	level.activ giveWeapon("knife_mp");
	level.activ giveMaxAmmo("knife_mp");
	level.activ giveMaxAmmo("knife_mp");
	
	
	player switchToWeapon("knife_mp");
	player switchToWeapon("knife_mp_mp");
	level.activ switchToWeapon("knife_mp");
	player switchToWeapon("knife_mp");
	
	player freezeControls(1);
	level.activ freezeControls(1);
	
	player setOrigin (jumporigin.origin);
	player setPlayerAngles (jumporigin.angles);

	level.activ setOrigin (actiorigin.origin);
	level.activ setPlayerAngles (actiorigin.angles);
	wait 2;
	
	player iPrintLnBold("^13");
	level.activ iPrintLnBold("^13");
	wait 1;
	player iPrintLnBold("^52");
	level.activ iPrintLnBold("^52");
	wait 1;
	player iPrintLnBold("^21");
	level.activ iPrintLnBold("^21");
	wait 1;
	player iPrintLnBold("^5Kill That Activator^2!");
	level.activ iPrintLnBold("^5Kill That Jumper^2!");
	
	player freezeControls(0);
	level.activ freezeControls(0);
	while( isAlive( player ) && isDefined( player ) )
    wait 1;
	

	}
}


bounce_room()
{
	while(1)
	{
	level.trigbounce = getEnt("bounce_room", "targetname");
    level.trigsniper = getEnt("sniper_room", "targetname");
	level.trigknife = getEnt("knife_room", "targetname");
	level.trigshotgun = getEnt("shotgun_room", "targetname");
	
	
	jumporigin = getEnt("sf_5", "targetname");
	actiorigin = getEnt("sf_6", "targetname");
	
	level.trigbounce waittill("trigger", player);

	// ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================
	
	level.trigsniper delete();
	level.trigknife delete();
	level.trigshotgun delete();
	
	iPrintLnBold("^2 " + player.name + " ^3Entered The ^5bounce ^5Room^2!");
	player.health = player.maxhealth;
	level.activ.health = level.activ.maxhealth;
	
	
	player takeAllWeapons();
	level.activ takeAllWeapons();
	
	player giveWeapon("knife_mp");
	player giveWeapon("knife_mp");
	player giveMaxAmmo("knife_mp");
	player giveMaxAmmo("knife_mp");
	level.activ giveWeapon("knife_mp");
	level.activ giveWeapon("knife_mp");
	level.activ giveMaxAmmo("knife_mp");
	level.activ giveMaxAmmo("knife_mp");
	
	
	player switchToWeapon("knife_mp");
	player switchToWeapon("knife_mp");
	level.activ switchToWeapon("knife_mp");
	player switchToWeapon("knife_mp");
	
	player freezeControls(1);
	level.activ freezeControls(1);
	
	player setOrigin (jumporigin.origin);
	player setPlayerAngles (jumporigin.angles);

	level.activ setOrigin (actiorigin.origin);
	level.activ setPlayerAngles (actiorigin.angles);
	wait 2;
	
	player iPrintLnBold("^13");
	level.activ iPrintLnBold("^13");
	wait 1;
	player iPrintLnBold("^52");
	level.activ iPrintLnBold("^52");
	wait 1;
	player iPrintLnBold("^21");
	level.activ iPrintLnBold("^21");
	wait 1;
	player iPrintLnBold("^5Kill That Activator^2!");
	level.activ iPrintLnBold("^5Kill That Jumper^2!");
	
	player freezeControls(0);
	level.activ freezeControls(0);
	while( isAlive( player ) && isDefined( player ) )
    wait 1;
	

	}
}


shotgun_room()
{
	while(1)
	{
	level.trigshotgun = getEnt("shotgun_room", "targetname");
	level.trigsniper = getEnt("sniper_room", "targetname");
	level.trigknife = getEnt("knife_room", "targetname");
	level.trigbounce = getEnt("bounce_room", "targetname");
	
	
	jumporigin = getEnt("sf_7", "targetname");
	actiorigin = getEnt("sf_8", "targetname");
	
	level.trigshotgun waittill("trigger", player);

	// ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================
	
	level.trigknife delete();
	level.trigsniper delete();
	level.trigbounce delete();
	
	iPrintLnBold("^2 " + player.name + " ^3Entered The ^5Shotgun ^5Room^2!");
	player.health = player.maxhealth;
	level.activ.health = level.activ.maxhealth;
	
	
	player takeAllWeapons();
	level.activ takeAllWeapons();
	
	player giveWeapon("winchester1200_mp");
	player giveWeapon("winchester1200_mp");
	player giveMaxAmmo("winchester1200_mp");
	player giveMaxAmmo("winchester1200_mp");
	level.activ giveWeapon("winchester1200_mp");
	level.activ giveWeapon("winchester1200_mp");
	level.activ giveMaxAmmo("winchester1200_mp");
	level.activ giveMaxAmmo("winchester1200_mp");
	
	
	player switchToWeapon("winchester1200_mp");
	player switchToWeapon("winchester1200_mp");
	level.activ switchToWeapon("winchester1200_mp");
	player switchToWeapon("winchester1200_mp");
	
	player freezeControls(1);
	level.activ freezeControls(1);
	
	player setOrigin (jumporigin.origin);
	player setPlayerAngles (jumporigin.angles);

	level.activ setOrigin (actiorigin.origin);
	level.activ setPlayerAngles (actiorigin.angles);
	wait 2;
	
	player iPrintLnBold("^13");
	level.activ iPrintLnBold("^13");
	wait 1;
	player iPrintLnBold("^52");
	level.activ iPrintLnBold("^52");
	wait 1;
	player iPrintLnBold("^21");
	level.activ iPrintLnBold("^21");
	wait 1;
	player iPrintLnBold("^5Shoot That Activator^2!");
	level.activ iPrintLnBold("^5Shoot That Jumper^2!");
	
	player freezeControls(0);
	level.activ freezeControls(0);
	while( isAlive( player ) && isDefined( player ) )
    wait 1;
	

	}
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

addTriggerToList( name, positionOfIconAboveTrap )
{
    if( !isDefined( level.trapTriggers ) )
        level.trapTriggers = [];
    level.trapTriggers[level.trapTriggers.size] = getEnt( name, "targetname" );

    if( !isDefined( level.icon_origins ) )
        level.icon_origins = [];
    level.icon_origins[level.icon_origins.size] = positionOfIconAboveTrap;
}
















