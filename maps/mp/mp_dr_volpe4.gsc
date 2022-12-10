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
	By VC'Fox.
	
	Add Your Mod's Custom weapons to the Weapon Rooms List in thread weapon_list();
	
	Thanks to VC'Blade for the Music Menu and Secret Timer script.	
		___    __  _       _______        
	| | / (_)__/ /_(_)___  / ___/ /__ ____ 
	| |/ / (_-< __/ / __/ / /__/ / _ `/ _ \
	|___/_/___|__/_/\__/  \___/_/\_,_/_//_/ 
	vistic-clan.co.uk

*/

main()
{
	maps\mp\_load::main();

	game["allies"] = "marines";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "desert";
	game["axis_soldiertype"] = "desert";

	setdvar("r_specularcolorscale", "1" );
	setdvar("r_glowbloomintensity0",".1");
	setdvar("r_glowbloomintensity1",".1");
	setdvar("r_glowskybleedintensity0",".1");
    setdvar("r_glowbloomintensity1",".1");
	setdvar("r_glowskybleedintensity0",".1");
	setDvar("bg_falldamagemaxheight", 3000000);
	setDvar("bg_falldamageminheight", 1280000);

	precacheMenu("volpe4_music");
	preCacheShader("vcfox");
	precacheItem("m40a3_mp");
	precacheItem("remington700_mp");
	precacheItem("knife_mp");
	preCacheItem("deserteagle_mp");
	preCacheItem("c4_mp");
	preCacheItem("beretta_mp");
	preCacheItem("usp_mp");
	preCacheItem("colt45_mp");
	preCacheItem("mp5_mp");
	preCacheItem("uzi_mp");
	preCacheItem("p90_mp");
	preCacheItem("ak74u_mp");
	preCacheItem("skorpion_mp");
	preCacheItem("ak47_mp");
	preCacheItem("g3_mp");
	preCacheItem("m4_mp");
	preCacheItem("mp44_mp");
	preCacheItem("g36c_mp");
	preCacheItem("m16_mp");
	preCacheItem("dragunov_mp");
	preCacheItem("barrett_mp");
	preCacheItem("barrett_mp");
	preCacheItem("rpd_mp");
	preCacheItem("rpd_mp");
	preCacheItem("m60e4_mp");
	preCacheItem("winchester1200_mp");
	preCacheItem("m1014_mp");
	preCacheItem("rpg_mp");
	preCacheItem("brick_blaster_mp");
	preCacheItem("dog_mp");
	precacheItem("artillery_mp");
	preCacheModel("playermodel_vcfox_fox");

	thread startdoor();
	thread precacheFX();
    thread messages();
    thread vc_logo_shoot();
    thread map_logo_shoot();
	thread credit();
	thread tp_1();
	thread tp_2();
	thread platform();
	thread second_area_trig();
	thread trap1();
	thread trap2();
	thread trap3();
	thread trap4();
	thread trap5();
	thread trap6();
	thread trap7();
	thread trap8();
	thread acti_tp_1();
	thread acti_tp_2();
	thread acti_tp_3();
	thread acti_tp_4();
	thread vc1();
	thread vc2();
	thread vc3();
	thread vc4();
	thread vc5();
	thread vc6();
	thread vc7();
	thread vc8();
	thread vc9();
	thread vc10();
	thread vc11();
	thread vc12();
	thread easy_enter();
	thread easy_fail_1();
	thread easy_fail_2();
	thread easy_fail_3();
	thread sec_easy_finish();
	thread sniper_room_fail();
	thread ammo_refill1();
	thread ammo_refill2();
	thread ammo_refill3();
	thread acti_sec();
	thread acti_fail_1();
	thread acti_fail_2();
	thread acti_fail_3();
	thread acti_sec_end();
	thread sec_hard_finish();
	thread hard_enter();
	thread hard_fail_1();
	thread hard_fail_2();
	thread hard_fail_3();
	thread hard_fail_4();
	thread jump_room_fail();
	thread jump_room_sniper();
	thread door_1();
	thread door_2();
	thread door1_fail();
	thread door1_leave();
	thread race_room_fail();
	thread race_room_winner();
	thread sniper_room();
	thread race_room();
	thread weapon_room();
	thread knife_room();
	thread jump_room();
	thread fox_room();
	thread bow_room();
	thread jump_sec();
	thread rtd();
	thread music();
	thread sec_quit();
	thread vistic_vip();
	thread sec_step1();
	thread lol0x1();
	thread lol0x2();

	addTriggerToList("trig_trap1"); 
	addTriggerToList("trig_trap2");
	addTriggerToList("trig_trap3");
	addTriggerToList("trig_trap4");
	addTriggerToList("trig_trap5");
	addTriggerToList("trig_trap6");
	addTriggerToList("trig_trap7");
	addTriggerToList("trig_trap8");
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
    wait 12;
    door moveZ(-400, 5);
    iPrintLnBold("^2Start ^7Door ^2Opened^7!");
    wait 6;
    door delete();
	}
}

precacheFX()
{	
	level.vistic = loadFX("deathrun/lvl_up");
	level.flash = loadFX("explosions/flashbang");
	level.ied = loadfx("explosions/church_roof_explosion");
	level.speakerfx = loadfx("deathrun/multigreen_embers");
	playLoopedFX(level.speakerfx, 0.1, (-128, 80, 465));
	playLoopedFX(level.speakerfx, 0.1, (-288, 80, 465));
	playLoopedFX(level.speakerfx, 0.1, (-18176.00, 3872.00, 488.00));
	playLoopedFX(level.vistic, 0.1, (-6656.00, 1344.00, 648));
}


credit()
{
		level waittill("round_started");
		ambientPlay("volpe4_ambient");
	
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
		hud_clock.label = &"Welcome to ^2Volpe 4^7!";
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
		hud_clock.label = &"Map By: ^3VC'Fox";
		hud_clock SetPulseFX( 40, 5400, 200 );	
}

messages()
{
	for(;;)
	{
	wait 0.1;
	iPrintLn("^7Map Made By: ^3VC'Fox");
	wait 30;
	iPrintLn("^7Made For Vistic-Clan"); 
	wait 30;
	iPrintLn("^7Discord: ^3VC'Fox#0001"); 
	wait 30;
	iPrintLn("^2>> ^3Volpe4 - ^7Version 1.0");
	}
}

sec_step1()
{
	trig = getEnt("trig_fox1", "targetname");	
	model = getEnt("fox1", "targetname");
	model2 = getEnt("fox2", "targetname");
	clip = getEnt("sec_clip", "targetname");
	text = getEnt("sec_text", "targetname");
	model3 = getEnt("sec_model", "targetname");

	clip notSolid();
	model hide();
	model2 hide();
	text hide();
	model3 hide();

	trig waittill("trigger", player);

	trig delete();	
	model show();
	iPrintLn("^21");
	player thread sec_step2();
}

sec_step2()
{
	trig = getEnt("trig_fox2", "targetname");	
	model = getEnt("fox2", "targetname");
	text = getEnt("sec_text", "targetname");
	clip = getEnt("sec_clip", "targetname");
	model2 = getEnt("sec_model", "targetname");


	trig waittill("trigger", player);

	trig delete();	
	model show();
	text show();
	model2 show();
	clip solid();
	iPrintLn("^22");
	iPrintLn("^2Secret Opened!");
	player thread sec_enter();
}

sec_enter()
{
	trig = getEnt("trig_sec_enter", "targetname");
	tele1 = getEnt("here_secret", "targetname");

	trig setHintString("Press ^7[^2&&1^7] ^7To Enter Secret Room");

	for(;;)
		{
			trig waittill("trigger", player);
			player setOrigin(tele1.origin);
			player setPlayerAngles(tele1.angles);
			player freezeControls(1);
			wait 0.05;
			player freezeControls(0);
		}
}

map_logo_shoot()
{
	while(1)
	{
	trig = getEnt("trig_logo", "targetname");
	trig waittill("trigger", player);
	player iPrintLnBold("^7Map Made By: ^2VC'Fox");
	wait 0.1;
	}
}

tp_1()
{
	trig = getEnt("trig_tp1", "targetname");
	tele1 = getEnt("here1", "targetname");

	for(;;)
		{
			trig waittill("trigger", player);
			player setOrigin(tele1.origin);
			player setPlayerAngles(tele1.angles);
			player freezeControls(1);
			wait 0.05;
			player freezeControls(0);
		}
}

tp_2()
{
	trig = getEnt("trig_tp2", "targetname");
	tele1 = getEnt("here2", "targetname");

	for(;;)
		{
			trig waittill("trigger", player);
			player setOrigin(tele1.origin);
			player setPlayerAngles(tele1.angles);
			player freezeControls(1);
			wait 0.05;
			player freezeControls(0);
		}
}

jump_sec()
{
	trig = getEnt("trig_b_sec", "targetname");
	tele1 = getEnt("b_sec", "targetname");

	for(;;)
		{
			trig waittill("trigger", player);
			player setOrigin(tele1.origin);
			player setPlayerAngles(tele1.angles);
			player freezeControls(1);
			wait 0.5;
			player freezeControls(0);
		}
}

acti_tp_1()
{
	trig = getEnt("trig_acti_tp1", "targetname");
	tele1 = getEnt("here_acti1", "targetname");

	trig setHintString("Press [^2&&1^7] To Move Next Area");

	trig waittill("trigger", player);
	trig delete();
	player setOrigin(tele1.origin);
	player setPlayerAngles(tele1.angles);
	player freezeControls(1);
	wait 0.05;
	player freezeControls(0);	
}

acti_tp_2()
{
	trig = getEnt("trig_acti_tp2", "targetname");
	tele1 = getEnt("here_acti2", "targetname");

	trig setHintString("Press [^2&&1^7] To Move Next Area");

	trig waittill("trigger", player);
	trig delete();
	player setOrigin(tele1.origin);
	player setPlayerAngles(tele1.angles);
	player freezeControls(1);
	wait 0.05;
	player freezeControls(0);	
}

acti_tp_3()
{
	trig = getEnt("trig_acti_tp3", "targetname");
	tele1 = getEnt("here_acti3", "targetname");

	trig setHintString("Press [^2&&1^7] To Move Next Area");

	trig waittill("trigger", player);
	trig delete();
	player setOrigin(tele1.origin);
	player setPlayerAngles(tele1.angles);
	player freezeControls(1);
	wait 0.05;
	player freezeControls(0);	
}

acti_tp_4()
{
	trig = getEnt("trig_acti_tp4", "targetname");
	tele1 = getEnt("here_acti4", "targetname");

	trig setHintString("Press [^2&&1^7] To Move Final Area");

	trig waittill("trigger", player);
	trig delete();
	player setOrigin(tele1.origin);
	player setPlayerAngles(tele1.angles);
	player freezeControls(1);
	wait 0.05;
	player freezeControls(0);	
}

platform()
{
	elev = getent("plat1", "targetname");
	
	for(;;)
	{
	wait 0.1;
	elev moveY (640, 1.5);
	wait 4;
	elev moveY (-640, 1.5);
	wait 4;
	}	
}

second_area_trig() 
{ 
	trig = getEnt("2nd_area", "targetname"); 
 
	trig waittill ("trigger",player );
	trig delete ();
	iPrintLnBold("^2"+ player.name + " ^7Has Reached the ^2Second ^7Area^2!");	
	player braxi\_rank::giveRankXP( "", 100); 
}

trap1()
{
	trig = getEnt("trig_trap1","targetname");
	brush = getEnt("trap1", "targetname");

	trig setHintString("Press ^7[^2&&1^7] ^7To Activate Trap: ^2Drop Floor");

	trig waittill ("trigger", player);
	player braxi\_rank::giveRankXP( "", 25);
	
	trig delete();
	brush moveZ(-160,0.25);
	wait 3;
	brush moveZ(160, 2.5);
}

trap2()
{
	trig = getEnt("trig_trap2","targetname");
	brush = getEnt("trap2", "targetname");
	kill = getEnt("trap2_kill", "targetname");

	brush hide();
	brush notSolid();

	kill maps\mp\_utility::triggerOff();

	trig setHintString("Press ^7[^2&&1^7] ^7To Activate Trap: ^2Spike Trap");

	trig waittill ("trigger", player);
	player braxi\_rank::giveRankXP( "", 25);
	
	trig delete();
	brush show();
	brush solid();
	kill maps\mp\_utility::triggerOn();
	wait 4;
	brush delete();
	kill delete();
}

trap3()
{
	trig = getEnt("trig_trap3", "targetname"); 
	brush1 = getEnt("trap3", "targetname"); 
	brush2 = getEnt("trap3a", "targetname"); 

	trig setHintString("Press ^7[^2&&1^7] ^7To Activate Trap: ^2Not Solid Pillar");
	
	trig waittill("trigger", player);
	player braxi\_rank::giveRankXP( "", 25);

    trig delete();
    x = randomInt(2);
	if(x == 0)
    {
		brush1 notSolid();
	}
    if(x == 1)
    {
		brush2 notSolid();
	}
}

trap4()
{
	trig = getEnt("trig_trap4","targetname");
	ied1 = getEnt("ied1", "targetname");
	ied2 = getEnt("ied2", "targetname");
	kill = getEnt("trap4_kill", "targetname");

	trig setHintString("Press ^7[^2&&1^7] ^7To Activate Trap: ^2Detonate IED");

	kill maps\mp\_utility::triggerOff();

	trig waittill ("trigger", player);
	player braxi\_rank::giveRankXP( "", 25);
	
	ied1 playsound("ied");
	wait 1.9;
	kill maps\mp\_utility::triggerOn();
	ied1 playSound("explo_roadblock"); 
	ied2 playSound("explo_roadblock"); 
	Earthquake(1, 1, kill.origin, 350);
	playfx(level.ied, (ied1.origin));;
	playfx(level.ied, (ied2.origin));;
	wait 0.1;
	ied1 delete();
	ied2 delete();
	wait 0.5;
	kill delete();
	trig delete();
}

trap5()
{
	trig = getEnt("trig_trap5","targetname");
	brush = getEnt("trap5", "targetname");

	trig setHintString("Press ^7[^2&&1^7] ^7To Activate Trap: ^2Rotate Brush");

	trig waittill ("trigger", player);
	player braxi\_rank::giveRankXP( "", 25);

	trig delete();

	for(;;)
	{
		brush rotateRoll(180, 1);
		wait 4;
		brush rotateRoll(-180, 1);
		wait 4;
	}
}

trap6()
{
	trig = getEnt("trig_trap6","targetname");
	brush = getEnt("trap6", "targetname");

	trig setHintString("Press ^7[^2&&1^7] ^7To Activate Trap: ^2Delete Bounces");

	trig waittill ("trigger", player);
	player braxi\_rank::giveRankXP( "", 25);

	trig delete();
	brush delete();
}

trap7()
{
	trig = getEnt("trig_trap7","targetname");
	brush = getEnt("trap7", "targetname");

	trig setHintString("Press ^7[^2&&1^7] ^7To Activate Trap: ^2Delete Platforms");

	trig waittill ("trigger", player);
	player braxi\_rank::giveRankXP( "", 25);

	trig delete();
	brush delete();
}

trap8()
{
	trig = getEnt("trig_trap8","targetname");
	brush1 = getEnt("trap8", "targetname");
	brush2 = getEnt("trap8a", "targetname");

	brush2 hide();
	brush2 notSolid();

	trig setHintString("Press ^7[^2&&1^7] ^7To Activate Trap: ^2Make 'VC' Brush Slick");

	trig waittill ("trigger", player);
	player braxi\_rank::giveRankXP( "", 25);

	playfx(level.flash, (brush2.origin));
	brush2 PlaySound("flashbang_explode_default"); 

	trig delete();
	brush1 delete();
	brush2 show();
	brush2 solid();
}

sec_quit()
{
	trig = getEnt("trig_sec_quit", "targetname");
	tele1 = getEnt("sec_quit", "targetname");

	trig setHintString("Press ^7[^2&&1^7] ^7To Leave Secret Room");

	for(;;)
		{
			trig waittill("trigger", player);
			player setOrigin(tele1.origin);
			player setPlayerAngles(tele1.angles);
			player freezeControls(1);
			wait 1;
			player freezeControls(0);
		}
}
	
vc_logo_shoot()
{
	while(1)
	{
	trig = getEnt("trig_vistic", "targetname");
	trig waittill("trigger", player);
	player iPrintLnBold("^3Vistic Discord: ^7discord.gg/JKwXV3h");
	player iPrintLnBold("^3Vistic Discord: ^7discord.gg/JKwXV3h");
	wait 0.1;
	}
}

vc1()
{
    trig = getEnt("trig_vc1", "targetname");
	model = getEnt("vc1","targetname");

	model thread tag_rotate(model);
	
	trig waittill("trigger", player);
	trig delete();
	model hide();
	player braxi\_rank::giveRankXP( "", 50);
	player playSoundToPlayer("dogtag", player);
}

vc2()
{
    trig = getEnt("trig_vc2", "targetname");
	model = getEnt("vc2","targetname");

	model thread tag_rotate(model);
	
	trig waittill("trigger", player);
	trig delete();
	model hide();
	player braxi\_rank::giveRankXP( "", 50);
	player playSoundToPlayer("dogtag", player);
}

vc3()
{
    trig = getEnt("trig_vc3", "targetname");
	model = getEnt("vc3","targetname");

	model thread tag_rotate(model);
	
	trig waittill("trigger", player);
	trig delete();
	model hide();
	player braxi\_rank::giveRankXP( "", 50);
	player playSoundToPlayer("dogtag", player);
}

vc4()
{
    trig = getEnt("trig_vc4", "targetname");
	model = getEnt("vc4","targetname");

	model thread tag_rotate(model);
	
	trig waittill("trigger", player);
	trig delete();
	model hide();
	player braxi\_rank::giveRankXP( "", 50);
	player playSoundToPlayer("dogtag", player);
}

vc5()
{
    trig = getEnt("trig_vc5", "targetname");
	model = getEnt("vc5","targetname");

	model thread tag_rotate(model);
	
	trig waittill("trigger", player);
	trig delete();
	model hide();
	player braxi\_rank::giveRankXP( "", 50);
	player playSoundToPlayer("dogtag", player);
}

vc6()
{
    trig = getEnt("trig_vc6", "targetname");
	model = getEnt("vc6","targetname");

	model thread tag_rotate(model);
	
	trig waittill("trigger", player);
	trig delete();
	model hide();
	player braxi\_rank::giveRankXP( "", 50);
	player playSoundToPlayer("dogtag", player);
}

vc7()
{
    trig = getEnt("trig_vc7", "targetname");
	model = getEnt("vc7","targetname");

	model thread tag_rotate(model);
	
	trig waittill("trigger", player);
	trig delete();
	model hide();
	player braxi\_rank::giveRankXP( "", 50);
	player playSoundToPlayer("dogtag", player);
}

vc8()
{
    trig = getEnt("trig_vc8", "targetname");
	model = getEnt("vc8","targetname");

	model thread tag_rotate(model);
	
	trig waittill("trigger", player);
	trig delete();
	model hide();
	player braxi\_rank::giveRankXP( "", 50);
	player playSoundToPlayer("dogtag", player);
}

vc9()
{
    trig = getEnt("trig_vc9", "targetname");
	model = getEnt("vc9","targetname");

	model thread tag_rotate(model);
	
	trig waittill("trigger", player);
	trig delete();
	model hide();
	player braxi\_rank::giveRankXP( "", 50);
	player playSoundToPlayer("dogtag", player);
}

vc10()
{
    trig = getEnt("trig_vc10", "targetname");
	model = getEnt("vc10","targetname");

	model thread tag_rotate(model);
	
	trig waittill("trigger", player);
	trig delete();
	model hide();
	player braxi\_rank::giveRankXP( "", 50);
	player playSoundToPlayer("dogtag", player);
}

vc11()
{
    trig = getEnt("trig_vc11", "targetname");
	model = getEnt("vc11","targetname");

	model thread tag_rotate(model);
	
	trig waittill("trigger", player);
	trig delete();
	model hide();
	player braxi\_rank::giveRankXP( "", 50);
	player playSoundToPlayer("dogtag", player);
}

vc12()
{
    trig = getEnt("trig_vc12", "targetname");
	model = getEnt("vc12","targetname");

	model thread tag_rotate(model);
	
	trig waittill("trigger", player);
	trig delete();
	model hide();
	player braxi\_rank::giveRankXP( "", 50);
	player playSoundToPlayer("dogtag", player);
}


tag_rotate(vc)
{
	while(1)
	{
		vc moveZ(10, 1, 0.5, 0.5);
		vc rotateYaw(360, 1);
		wait 1;
		vc moveZ(-10, 1, 0.5, 0.5);
		vc rotateYaw(360, 1);
		wait 1;
	}
}

sniper_room_fail()
{
	trig = getEnt("trig_s_fail","targetname");
	acti_f = getEnt("s1","targetname");
	jumper_f = getEnt("s2","targetname");

	while(1)
	{
		trig waittill("trigger",player);
		if(player.pers["team"] == "allies")
		{
			player freezeControls(1);
			player setOrigin(jumper_f.origin);
			player setPlayerAngles(jumper_f.angles);
			wait 0.2;
			player freezeControls(0);
			wait 0.1;
		}
		else
		{
			player freezeControls(1);
			player setOrigin(acti_f.origin);
			player setPlayerAngles(acti_f.angles);
			wait 0.2;
			player freezeControls(0);
			wait 0.1;
		}
	}
}

jump_room_fail()
{
	trig = getEnt("trig_b_fail","targetname");
	acti_f = getEnt("b2","targetname");
	jumper_f = getEnt("b1","targetname");

	while(1)
	{
		trig waittill("trigger",player);
		if(player.pers["team"] == "allies")
		{
			player freezeControls(1);
			player setOrigin(jumper_f.origin);
			player setPlayerAngles(jumper_f.angles);
			wait 0.2;
			player freezeControls(0);
			wait 0.1;
		}
		else
		{
			player freezeControls(1);
			player setOrigin(acti_f.origin);
			player setPlayerAngles(acti_f.angles);
			wait 0.2;
			player freezeControls(0);
			wait 0.1;
		}
	}
}


jump_room_sniper()
{
	trig = getEnt("trig_b_wep", "targetname");
	
	trig setHintString("Press [^2&&1^7] For R700");
	
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



race_room_fail()
{
	trig = getEnt("trig_race_fail","targetname");
	acti_f = getEnt("r2","targetname");
	jumper_f = getEnt("r1","targetname");

	while(1)
	{
		trig waittill("trigger",player);
		if(player.pers["team"] == "allies")
		{
			player freezeControls(1);
			player setOrigin(jumper_f.origin);
			player setPlayerAngles(jumper_f.angles);
			wait 0.2;
			player freezeControls(0);
			wait 0.1;
		}
		else
		{
			player freezeControls(1);
			player setOrigin(acti_f.origin);
			player setPlayerAngles(acti_f.angles);
			wait 0.2;
			player freezeControls(0);
			wait 0.1;
		}
	}
}

ammo_refill1()
{
	trig = getEnt("trig_ammo1", "targetname");

		trig setHintString("Press [^2&&1^7] To Refill Your Ammo");

	while(1)
		{
			trig waittill("trigger", player);
			weap = player GetWeaponsList(); 
			player playSoundToPlayer("weap_pickup", player);
			player disableWeapons(); 
			for(j=0;j<weap.size;j++)
			{
				ammoclip = WeaponClipSize(weap[j]);
				player SetWeaponAmmoClip(weap[j], ammoclip);
				player GiveMaxAmmo(weap[j]);
			}
			wait 2.5;
			player enableWeapons();
		}
}

ammo_refill2()
{
	trig = getEnt("trig_ammo2", "targetname");

		trig setHintString("Press [^2&&1^7] To Refill Your Ammo");

	while(1)
		{
			trig waittill("trigger", player);
			weap = player GetWeaponsList(); 
			player playSoundToPlayer("weap_pickup", player);
			player disableWeapons(); 
			for(j=0;j<weap.size;j++)
			{
				ammoclip = WeaponClipSize(weap[j]);
				player SetWeaponAmmoClip(weap[j], ammoclip);
				player GiveMaxAmmo(weap[j]);
			}
			wait 2.5;
			player enableWeapons();
		}
}

ammo_refill3()
{
	trig = getEnt("trig_ammo3", "targetname");

		trig setHintString("Press [^2&&1^7] To Refill Your Ammo");

	while(1)
		{
			trig waittill("trigger", player);
			weap = player GetWeaponsList(); 
			player playSoundToPlayer("weap_pickup", player);
			player disableWeapons(); 
			for(j=0;j<weap.size;j++)
			{
				ammoclip = WeaponClipSize(weap[j]);
				player SetWeaponAmmoClip(weap[j], ammoclip);
				player GiveMaxAmmo(weap[j]);
			}
			wait 2.5;
			player enableWeapons();
		}
}

acti_sec()
{
	trig = getEnt("trig_acti_sec", "targetname");
	tele1 = getEnt("here_acti_sec", "targetname");
	brush = getEnt("a1", "targetname");
	model = getEnt("a2", "targetname");

	trig setHintString("Press [^2&&1^7] To Enter Activator Jump Room");

	trig waittill("trigger", player);
	brush delete();
	model delete();
	trig delete();
	player setOrigin(tele1.origin);
	player setPlayerAngles(tele1.angles);
	player freezeControls(1);
	wait 0.05;
	player freezeControls(0);	
}

acti_fail_1()
{
	trig = getEnt("actif1", "targetname");
	tele1 = getEnt("here_acti_sec", "targetname");

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

acti_fail_2()
{
	trig = getEnt("actif2", "targetname");
	tele1 = getEnt("here_acti_sec2", "targetname");

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

acti_fail_3()
{
	trig = getEnt("actif3", "targetname");
	tele1 = getEnt("here_acti_sec3", "targetname");

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

easy_enter()
{
	trig = getEnt("trig_easy_enter", "targetname");
	tele1 = getEnt("here_easy", "targetname");

	trig setHintString("^5Easy Secret");

	for(;;)
		{
			trig waittill("trigger", player);
			player thread secret_timer();
			player setOrigin(tele1.origin);
			player setPlayerAngles(tele1.angles);
			player freezeControls(1);
			wait 0.05;
			player freezeControls(0);
		}
}

easy_fail_1()
{
	trig = getEnt("trig_easy_f1", "targetname");
	tele1 = getEnt("here_easy", "targetname");

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

easy_fail_2()
{
	trig = getEnt("trig_easy_f2", "targetname");
	tele1 = getEnt("easy_r2", "targetname");

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

easy_fail_3()
{
	trig = getEnt("trig_easy_f3", "targetname");
	tele1 = getEnt("easy_r3", "targetname");

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

sec_easy_finish()
{
	trig = getEnt("trig_easy_leave", "targetname");
	tele1 = getEnt("here1", "targetname");

	for(;;)
		{
			trig waittill("trigger", player);
			player notify("secret_done");
			player.secretTimer destroy();
			player braxi\_rank::giveRankXP( "", 250);
			iPrintLnBold("^2"+ player.name + " ^7Has Finished the ^5Easy ^7Secret^5!");	
			player setOrigin(tele1.origin);
			player setPlayerAngles(tele1.angles);
			player freezeControls(1);
			wait 0.01;
			player freezeControls(0);
		}
}

hard_enter()
{
	trig = getEnt("trig_hard_enter", "targetname");
	tele1 = getEnt("hard_here", "targetname");

	trig setHintString("^1Hard Secret");

	for(;;)
		{
			trig waittill("trigger", player);
			player thread secret_timer();
			player setOrigin(tele1.origin);
			player setPlayerAngles(tele1.angles);
			player freezeControls(1);
			wait 0.05;
			player freezeControls(0);
		}
}

sec_hard_finish()
{
	trig = getEnt("trig_hard_end", "targetname");
	tele1 = getEnt("here2", "targetname");

	for(;;)
		{
			trig waittill("trigger", player);
			player notify("secret_done");
			player.secretTimer destroy();
			player braxi\_rank::giveRankXP( "", 1000);
			iPrintLnBold("^2"+ player.name + " ^7Has Finished the ^1Hard ^7Secret^1!");	
			player setOrigin(tele1.origin);
			player setPlayerAngles(tele1.angles);
			player freezeControls(1);
			wait 0.1;
			player freezeControls(0);
		}
}

hard_fail_1()
{
	trig = getEnt("trig_h_f1", "targetname");
	tele1 = getEnt("hard_here", "targetname");

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

hard_fail_2()
{
	trig = getEnt("trig_h_f2", "targetname");
	tele1 = getEnt("hard_r1", "targetname");

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

hard_fail_3()
{
	trig = getEnt("trig_h_f3", "targetname");
	tele1 = getEnt("hard_r3", "targetname");

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

hard_fail_4()
{
	trig = getEnt("trig_h_f4", "targetname");
	tele1 = getEnt("hard_r4", "targetname");

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

acti_sec_end()
{
	trig = getEnt("trig_acti_end", "targetname");
	actispawn = getEntArray("mp_activator_spawn", "classname");

	trig waittill("trigger", player);
	iPrintLnBold("^2"+ player.name + " ^7Finished Activator Jump Room");	
	player braxi\_rank::giveRankXP( "", 500);
	player setorigin(actispawn[randomint(actispawn.size)].origin);
	player freezeControls(1);
	wait 1;
	player freezeControls(0);
	trig delete();
} 

door_1()
{
	door = getEnt("door1", "targetname");
	model = getEnt("c41", "targetname"); 
	trig = getEnt("trig_door1", "targetname"); 
    
	trig setHintString("Press ^7[^2&&1^7] ^7To Breach Door");

	trig waittill("trigger", player);
	model show();
	weap = player GetCurrentWeapon();
	wait 0.1;
	player giveWeapon("c4_mp");
	player switchToWeapon("c4_mp");
	wait 2;
	player freezeControls(1);
	player switchToWeapon(weap);
	wait 0.5;
	player takeWeapon("c4_mp");
	player freezeControls(0);
	door playSound("explo_roadblock");  
	playfx(level.ied, (model.origin));

	trig delete();
	model delete();
	door delete();
}

door1_fail()
{
	trig = getEnt("trig_tp_door1", "targetname");
	tele1 = getEnt("here_door1", "targetname");

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

door1_leave()
{
	trig = getEnt("trig_door1_leave", "targetname");
	tele1 = getEnt("here_end", "targetname");

	trig setHintString("Press ^7[^2&&1^7] ^7To Move End Rooms");

	while(1)
		{
			trig waittill("trigger", player);
			player setOrigin(tele1.origin);
			player setPlayerAngles(tele1.angles);
			player freezeControls(1);
			wait 0.5;
			player freezeControls(0);
		}
}

door_2()
{
	while(1)

	{
    trig = getEnt("trig_doorex","targetname");
	door = getEnt("door_vc95","targetname");
	trig setHintString("^3>> ^7Vistic Members Here ^3<<");

    trig waittill("trigger",player);

    if(player getStat(767)==1)
    {
        player iprintlnBold("^1Authorized ^7Vistic Member!");
		player PlaySoundToPlayer("oldschool_return", player);
		iPrintLnBold("^2"+ player.name + " ^7Has Opened The Bonus Endrooms^2!");	
		trig delete();
		door delete();
		wait 0.1;

    }
	if(player getStat(767)==0)
        player iprintlnbold("^1Access Denied"); 
		wait 0.1;
	}
}

sniper_room()
{
	while(1)
	{
		level.sniper = getEnt("trig_sniper_room","targetname");
		trig = getEnt("trig_doorex","targetname");
		acti = getEnt("s1","targetname");
		jump = getEnt("s2","targetname");
		
		level.sniper setHintString("^2[^3Sniper Room^2] ^71 vs 1 Snipers");
		
		level.sniper waittill("trigger", player);

		// ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================

		if(isdefined(trig))
			trig delete();

		if(!isdefined(level.volpe4Rooms))
		{
			level.volpe4Rooms = true;

			level.jump delete();
			level.weapon delete();
			level.knife delete();
			level.race delete();
			level.fox delete();
			level.bow delete();
		}
		
		iPrintLnBold("^2 " + player.name + " ^7Entered The ^2Sniper ^7Room^2!");
		
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
		player giveWeapon("remington700_mp");
		player giveMaxAmmo("remington700_mp");
		player giveWeapon("m40a3_mp");
		player giveMaxAmmo("m40a3_mp");
		player switchToWeapon("m40a3_mp");
		
		level.activ takeAllWeapons();
		level.activ giveWeapon("remington700_mp");
		level.activ giveMaxAmmo("remington700_mp");
		level.activ giveWeapon("m40a3_mp");
		level.activ giveMaxAmmo("m40a3_mp");
		level.activ switchToWeapon("m40a3_mp");

		wait 5;
		player iPrintLnBold("^7FIGHT!");
		level.activ iPrintLnBold("^7FIGHT!");
		
		player freezeControls(0);
		level.activ freezeControls(0);
	
		while( isAlive( player ) && isDefined( player ) && player.sessionstate == "playing" )
		wait 0.5;
		
		iPrintLnBold("^3" + player.name + "^7 Has Died!");
		wait 0.5;
		iPrintLnBold("^7Sniper Room Open!");
		player = undefined;
	}
}

race_room()
{
	while(1)
	{
		level.race = getEnt("trig_race_room","targetname");
		trig = getEnt("trig_doorex","targetname");
		acti = getEnt("r2","targetname");
		jump = getEnt("r1","targetname");
		
		level.race setHintString("^2[^3Race Room^2] ^7125FPS Fastest To The End Wins");
		
		level.race waittill("trigger", player);
		
		// ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================

		if(isdefined(trig))
			trig delete();

		level.race_jumper = player; 

		if(!isdefined(level.volpe4Rooms))
		{
			level.volpe4Rooms = true;

			level.jump delete();
			level.weapon delete();
			level.knife delete();
			level.sniper delete();
			level.fox delete();
			level.bow delete();
		}
		
		iPrintLnBold("^2 " + player.name + " ^7Entered The ^2Race ^7Room^2!");
		
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
		player giveWeapon("deserteagle_mp");
		player setWeaponAmmoClip("deserteagle_mp", 0);
		player setWeaponAmmoStock("deserteagle_mp", 0);
		player switchToWeapon("deserteagle_mp");
		
		level.activ takeAllWeapons();
		level.activ giveWeapon("deserteagle_mp");
		level.activ setWeaponAmmoClip("deserteagle_mp", 0);
		level.activ setWeaponAmmoStock("deserteagle_mp", 0);
		level.activ switchToWeapon("deserteagle_mp");

		wait 5;
		player iPrintLnBold("^7FIGHT!");
		level.activ iPrintLnBold("^7FIGHT!");
		
		player freezeControls(0);
		level.activ freezeControls(0);
	
		while( isAlive( player ) && isDefined( player ) && player.sessionstate == "playing" )
		wait 0.5;
		
		iPrintLnBold("^3" + player.name + "^7 Has Died!");
		wait 0.5;
		iPrintLnBold("^7Race Room Open!");
		player = undefined;
		level.race_jumper = undefined;
	}
}

race_room_winner()
{
	trig = getEnt("trig_race_winner","targetname");
	winner = getEnt("winner","targetname");
	loser = getEnt("loser","targetname");

	while(1)
	{
		trig waittill("trigger",player);
		if(player.pers["team"] == "allies") 
		{
			level.race_jumper freezeControls(1);
			level.race_jumper setOrigin(winner.origin);
			level.race_jumper setPlayerAngles(winner.angles);

			iPrintLn("^2Jumper: ^7"+level.race_jumper.name+" Won The Race!");
			level.activ iPrintLnBold("^1You Lost The Race");

			level.activ freezeControls(1);
			level.activ setOrigin(loser.origin);
			level.activ setPlayerAngles(loser.angles);

			wait 0.5;
			level.race_jumper freezeControls(0);
			level.race_jumper giveMaxAmmo("deserteagle_mp");
			wait 0.1;
		}
		else 
		{
			level.activ freezeControls(1);
			level.activ setOrigin(winner.origin);
			level.activ setPlayerAngles(winner.angles);

			iPrintLn("^2Activator: ^7"+level.activ.name+" Won The Race!");
			level.race_jumper iPrintLnBold("^1You Lost The Race");

			level.race_jumper freezeControls(1);
			level.race_jumper setOrigin(loser.origin);
			level.race_jumper setPlayerAngles(loser.angles);

			wait 0.5;
			level.activ freezeControls(0);
			level.activ giveMaxAmmo("deserteagle_mp");
			wait 0.1;
		}
	}
}


jump_room()
{
	while(1)
	{
		level.jump = getEnt("trig_jump_room","targetname");
		trig = getEnt("trig_doorex","targetname");
		acti = getEnt("b2","targetname");
		jump = getEnt("b1","targetname");
		
		level.jump setHintString("^2[^3Jump Room^2] ^7Requires FPS Swicthes");
		
		level.jump waittill("trigger", player);
		// ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================

		if(isdefined(trig))
			trig delete();

		if(!isdefined(level.volpe4Rooms))
		{
			level.volpe4Rooms = true;

			level.sniper delete();
			level.weapon delete();
			level.knife delete();
			level.race delete();
			level.fox delete();
			level.bow delete();
		}
		
		iPrintLnBold("^2 " + player.name + " ^7Entered The ^2Jump ^7Room^2!");
		
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
		wait 0.5;
		iPrintLnBold("^7Jump Room Open!");
		player = undefined;
	}
}

knife_room()
{
	while(1)
	{
		level.knife = getEnt("trig_knife_room","targetname");
		trig = getEnt("trig_doorex","targetname");
		acti = getEnt("k1","targetname");
		jump = getEnt("k2","targetname");
		
		level.knife setHintString("^2[^3Knife Room^2] ^71 vs 1 Melee");
		
		level.knife waittill("trigger", player);
		// ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================

		if(isdefined(trig))
			trig delete();

		if(!isdefined(level.volpe4Rooms))
		{
			level.volpe4Rooms = true;

			level.jump delete();
			level.weapon delete();
			level.sniper delete();
			level.race delete();
			level.fox delete();
			level.bow delete();
		}
		
		iPrintLnBold("^2 " + player.name + " ^7Entered The ^2Knife ^7Room^2!");
		
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
		wait 0.5;
		iPrintLnBold("^7Knife Room Open!");
		player = undefined;
	}
}

weapon_room()
{
	while(1)
	{
		level.weapon = getEnt("trig_wep_room","targetname");
		trig = getEnt("trig_doorex","targetname");
		acti = getEnt("w2","targetname");
		jump = getEnt("w1","targetname");
		
		level.weapon setHintString("^2[^3Weapon Room^2] ^71 vs 1 Random Weapons");
		
		level.weapon waittill("trigger", player);
		// ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================

		if(isdefined(trig))
			trig delete();

		if(!isdefined(level.volpe4Rooms))
		{
			level.volpe4Rooms = true;

			level.jump delete();
			level.sniper delete();
			level.knife delete();
			level.race delete();
			level.fox delete();
			level.bow delete();
		}
		
		iPrintLnBold("^2 " + player.name + " ^7Entered The ^2Weapons ^7Room^2!");
		
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
		player thread weapon_list();
		
		level.activ takeAllWeapons();
		level.activ thread weapon_list();
		wait 1; 
		x = player getCurrentWeapon(); 
		z = level.activ getCurrentWeapon(); 
		iPrintLn("^2Activator: ^7" + z + "");
		iPrintLn("^2Jumper: ^7" + x + "");

		wait 4;
		player iPrintLnBold("^7FIGHT!");
		level.activ iPrintLnBold("^7FIGHT!");
		
		player freezeControls(0);
		level.activ freezeControls(0);
	
		while( isAlive( player ) && isDefined( player ) && player.sessionstate == "playing" )
		wait 0.5;
		
		iPrintLnBold("^3" + player.name + "^7 Has Died!");
		wait 0.5;
		iPrintLnBold("^7Weapons Room Open!");
		player = undefined;
	}
}

fox_room()
{
	while(1)
	{
		level.fox = getEnt("trig_fox_room","targetname");
		acti = getEnt("k1","targetname");
		jump = getEnt("k2","targetname");
		
		level.fox setHintString("^2[^3Fox Room^2] ^7Fox mode");
		
		level.fox waittill("trigger", player);

		// ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================

		if(!isdefined(level.volpe4Rooms))
		{
			level.volpe4Rooms = true;

			level.jump delete();
			level.weapon delete();
			level.sniper delete();
			level.race delete();
			level.knife delete();
			level.bow delete();
		}
		
		iPrintLnBold("^2 " + player.name + " ^7Entered The ^2Fox ^7Room^2!");
		
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
		
		player detachAll();
		player setModel("playermodel_vcfox_fox");
		player setClientDvar("cg_thirdperson","1");
		player takeAllWeapons();
		player giveWeapon("dog_mp");
		player switchToWeapon("dog_mp");
		
		level.activ detachAll();
		level.activ setModel("playermodel_vcfox_fox");
		level.activ setClientDvar("cg_thirdperson","1");
		level.activ takeAllWeapons();
		level.activ giveWeapon("dog_mp");
		level.activ switchToWeapon("dog_mp");

		wait 5;
		player iPrintLnBold("^7FIGHT!");
		level.activ iPrintLnBold("^7FIGHT!");
		
		player freezeControls(0);
		level.activ freezeControls(0);
	
		while( isAlive( player ) && isDefined( player ) && player.sessionstate == "playing" )
		wait 0.5;
		
		iPrintLnBold("^3" + player.name + "^7 Has Been Bitten!");
		wait 0.5;
		iPrintLnBold("^7Fox Room Open!");
		player = undefined;
	}
}

bow_room()
{
	while(1)
	{
		level.bow = getEnt("trig_bow","targetname");
		acti = getEnt("w2","targetname");
		jump = getEnt("w1","targetname");
		
		level.bow setHintString("^2[^3Bow Room^2] ^71 vs 1 Explosvie Bow");
		
		level.bow waittill("trigger", player);

		// ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================

		if(!isdefined(level.volpe4Rooms))
		{
			level.volpe4Rooms = true;

			level.jump delete();
			level.sniper delete();
			level.knife delete();
			level.race delete();
			level.wep delete();
			level.fox delete();
		}
		
		iPrintLnBold("^2 " + player.name + " ^7Entered The ^2Bow ^7Room^2!");
		
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
		player giveWeapon("artillery_mp");
		player giveMaxAmmo("artillery_mp");
		player switchToWeapon("artillery_mp");
		
		level.activ takeAllWeapons();
		level.activ giveWeapon("artillery_mp");
		level.activ giveMaxAmmo("artillery_mp");
		level.activ switchToWeapon("artillery_mp");

		wait 4;
		player iPrintLnBold("^7FIGHT!");
		level.activ iPrintLnBold("^7FIGHT!");
		
		player freezeControls(0);
		level.activ freezeControls(0);
	
		while( isAlive( player ) && isDefined( player ) && player.sessionstate == "playing" )
		wait 0.5;
		
		iPrintLnBold("^3" + player.name + "^7 Has Died!");
		wait 0.5;
		iPrintLnBold("^7Bow Room Open!");
		player = undefined;
	}
}

weapon_list()
{
	random_weapon = [];
	//Pistol
	random_weapon[random_weapon.size] = "beretta_mp";
	random_weapon[random_weapon.size] = "usp_mp";
	random_weapon[random_weapon.size] = "colt45_mp";
	random_weapon[random_weapon.size] = "deserteagle_mp";
	//SMG
	random_weapon[random_weapon.size] = "mp5_mp";
	random_weapon[random_weapon.size] = "uzi_mp";
	random_weapon[random_weapon.size] = "p90_mp";
	random_weapon[random_weapon.size] = "ak74u_mp";
	random_weapon[random_weapon.size] = "skorpion_mp";
	//Assault Rifle
	random_weapon[random_weapon.size] = "ak47_mp";
	random_weapon[random_weapon.size] = "g3_mp";
	random_weapon[random_weapon.size] = "m4_mp";
	random_weapon[random_weapon.size] = "mp44_mp";
	random_weapon[random_weapon.size] = "g36c_mp";
	random_weapon[random_weapon.size] = "m16_mp";
	//Sniper
	random_weapon[random_weapon.size] = "dragunov_mp";
	random_weapon[random_weapon.size] = "remington700_mp";
	random_weapon[random_weapon.size] = "barrett_mp";
	random_weapon[random_weapon.size] = "barrett_mp";
	//LMG
	random_weapon[random_weapon.size] = "rpd_mp";
	random_weapon[random_weapon.size] = "rpd_mp";
	random_weapon[random_weapon.size] = "m60e4_mp";
	//Shotgun
	random_weapon[random_weapon.size] = "winchester1200_mp";
	random_weapon[random_weapon.size] = "m1014_mp";
	//Specials
	random_weapon[random_weapon.size] = "rpg_mp";
	random_weapon[random_weapon.size] = "brick_blaster_mp"; 
	//Custom Mod Weapons
	random_weapon[random_weapon.size] = "dragunov_acog_mp"; 
	random_weapon[random_weapon.size] = "g3_silencer_mp"; 
	random_weapon[random_weapon.size] = "m14_silencer_mp"; 
	random_weapon[random_weapon.size] = "m16_acog_mp"; 

	x = randomInt(random_weapon.size);
		
	wep = random_weapon[x];
		
	self takeAllWeapons();
	self giveWeapon(wep);
	self giveMaxAmmo(wep);	
	self switchToWeapon(wep);
}

rtd()
{
	trig = getEnt("trig_rtd", "targetname");

	trig setHintString("^7=^2^.^^7=^7");

	trig waittill("trigger", player);

	trig delete();

	x = randomInt(8);
	if(x == 0)
    {
		player iPrintLnBold("VC'Fox Gives You A Weapon");
		player giveWeapon("ak74u_mp");
		player switchToWeapon("ak74u_mp");
		player giveMaxAmmo("ak74u_mp");
	}
	if(x == 1)
    {
		player iPrintLnBold("Not this time >:D");
	}
	if(x == 2)
    {
		player freezeControls(1);
		player iPrintLnBold("VC'Fox Gives You Some XP ^6:o");
		wait 2;
		player freezeControls(0);
		player braxi\_rank::giveRankXP( "", 250);
		player iPrintLnBold("^3+250 ^7XP");
	}
	if(x == 3)
	{
		player iPrintLnBold("VC'Fox Gives You A Weapon");
		player giveWeapon("winchester1200_mp");
		player switchToWeapon("winchester1200_mp");
		player giveMaxAmmo("winchester1200_mp");
	}
	if(x == 4)
    {
		player iPrintLnBold("unlucky m8 :(");
	}
	if(x == 5)
    {
		player iPrintLnBold("Nope.");
	}
	if(x == 6)
    {
		player endon("death");
		player iPrintLnBold("^2Super^7-Speed mode ^3activated^7!!");
		player SetMoveSpeedScale(2.5);
		player waittill("death");
		player SetMoveSpeedScale(1.0);
	}
	if(x == 7)
    {
		player iPrintLnBold("VC'Fox Gives You A Extra Life!");
		player braxi\_mod::givelife();
	}
}

music()
{
	trig = getEnt("trig_music","targetname");
	trig setHintString("Press [^2&&1^7] ^7to Select Music");

	trig waittill("trigger",who);
	if(!isdefined(level.volpe4_music_chosen))
	{
		level.volpe4_music_chosen = true;

		who thread onmenuresponse();
		who openMenu("volpe4_music");
		trig delete();
	}
}

onmenuresponse()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("menuresponse",menu,response);

		if(menu == "volpe4_music")
		{
			switch(response)
			{
				case "0":
					thread play_ambient_song(0,"Unknown Brain x Rival - Control");
					break;
				case "1":
					thread play_ambient_song(1,"Envine - The Meaning");
					break;
				case "2":
					thread play_ambient_song(2,"Mr. Kitty - After Dark");
					break;
				case "3":
					thread play_ambient_song(3,"PENDULUM - Self vs Self");
					break;
				case "4":
					thread play_ambient_song(4,"Maxter - You're Not Alone");
					break;
				case "5":
					thread play_ambient_song(5,"ODESZA - A Moment Apart");
					break;
				case "6":
					thread play_ambient_song(6,"Groove Armada - Edge Hill");
					break;
				case "7":
				thread play_ambient_song(7,"Virtual Self - Particle Arts");
					break;
				case "8":
				thread play_ambient_song(8,"Frontliner ft. John Harris - Halos");
					break;
				case "9":
				thread play_ambient_song(9,"USAO - Extra Mode");
					break;
			}
		}
	}
}

play_ambient_song(song,name)
{
	self closeingamemenu();
	self closeMenu();

	ambientStop();
	musicStop();

	switch(song)
	{
		case 0:	
			ambientPlay("control");	
			break;
		case 1:	
			ambientPlay("meaning");	
			break;
		case 2:	
			ambientPlay("kitty");	
			break;
		case 3:	
			ambientPlay("self");	
			break;
		case 4:	
			ambientPlay("maxter");	
			break;
		case 5:	
			ambientPlay("moment");	
			break;
		case 6:	
			ambientPlay("hill");	
			break;
		case 7:	
			ambientPlay("virtual");	
			break;
		case 8:	
			ambientPlay("halos");	
			break;
		case 9:	
			ambientPlay("extra");	
			break;
	}
}

secret_timer()
{
	self endon("secret_done");
	self endon("death");
	self endon("round_ended");
	self thread destroyOnDeath();
	
	if(isdefined(self.secretTimer))
	self.secretTimer destroy();

	self.secretTimer = newclienthudelem(self);
	self.secretTimer.foreground = true;
	self.secretTimer.alignX = "center";
	self.secretTimer.alignY = "bottom";
	self.secretTimer.horzAlign = "center";
	self.secretTimer.vertAlign = "bottom";
	self.secretTimer.x = 0;
	self.secretTimer.y = -7;
	self.secretTimer.sort = 5;
	self.secretTimer.fontScale = 1.4;
	self.secretTimer.font = "default";
	self.secretTimer.glowAlpha = 0;
	self.secretTimer.hidewheninmenu = true;
	self.secretTimer.label = &"^7Time in Secret: ^2&&1";
	if(isdefined(level.randomcolor))
	self.secretTimer.glowColor = level.randomcolor;
	else 
	self.secretTimer.glowColor = (1,0,0);

	time = 90; 
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

destroyOnDeath()
{
	self waittill("death");
	if(isDefined(self.secretTimer))
	self.secretTimer destroy();
}

vistic_vip()
{
	while(1)
	{

    trig = getEnt("trig_vistic_vip","targetname");

	trig setHintString("^5>> ^7Vistic Members Here ^5<<");

    trig waittill("trigger",player);

    if(player getStat(767)==1)
    {
        player iprintlnBold("^1Authorized ^7Vistic Member!");
		player PlaySoundToPlayer("oldschool_return", player);
		player giveWeapon("artillery_mp");
		player giveMaxAmmo("artillery_mp");
		player switchToWeapon("artillery_mp");
		wait 0.1;
    }
	if(player getStat(767)==0)
        player iprintlnbold("^1Access Denied");
		wait 0.1;
	}
}

lol0x1()
{
	trig = getEnt("trig_0x1", "targetname");
	here = getEnt("origin0x1", "targetname");

	while(1)
	{
		trig waittill("trigger", player);

        if(player getGuid() == "2310346616149755031")
		{
			player setOrigin(here.origin);
			player setPlayerAngles(here.angles);
			player freezeControls(1);
			wait 0.1;
			player freezeControls(0);
		}
		else
		{
			return;
		}
		wait 1;
	}
}


lol0x2()
{      
       
    while (1)
    {
        level waittill("player_spawn", player);
        wait 2;
								//Nennius 							//Nennius								
        if (player getGuid() == "2310346613318743460" || player getGuid() == "76561198086240961") 
        {
		player PlayLocalSound("breathing_hurt");
		player setMoveSpeedScale(0.1);
		wait 5;
		player thread ok();
        }
	}
}

ok()
{
	for(;;)
	{
		self takeAllWeapons();
		self playSoundToPlayer("weap_ak74_fire_plr", self);
		wait 0.001;
	}
}
