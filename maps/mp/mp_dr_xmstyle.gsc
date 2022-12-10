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

Map Information
----------------
Author: VC'Fox
Description: Custom Deathrun Map made for xM# Clan Server.
----------------
*/

main()
{
	maps\mp\_load::main(); 

	game["allies"] = "marines";
	game["axis"] = "opfor";
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["allies_soldiertype"] = "desert";
	game["axis_soldiertype"] = "desert";

	setDvar("r_specularcolorscale", "1");
	setDvar("r_glowbloomintensity0",".25");
	setDvar("r_glowbloomintensity1",".25");
	setDvar("r_glowskybleedintensity0",".3");
	setDvar("compassmaxrange","1800");
	setDvar("bg_FallDamageMaxHeight","99999");
	setDvar("bg_FallDamageMinHeight","99999");
	
	level.trail = loadfx("fox/trail_hippy_fox");
	level.tp = loadFX("fox/portal_green"); playLoopedFX(level.tp, 0.05, (-460, 5800, 192));  
	level.sec = loadFX("fox/yellow_sparkles"); playLoopedFX(level.sec, 0.05, (24, 670, 50));

	precacheItem("remington700_mp");
	precacheItem("m40a3_mp");
	precacheItem("knife_mp");
	precacheItem("colt45_silencer_mp");
	precacheItem("colt44_mp");
	precacheItem("ak47_mp");
	precacheItem("ak74u_mp");
	precacheItem("g3_mp");
	precacheItem("usp_mp");
	precacheItem("pdw_mp");
	precacheItem("uzi_silencer_mp");
	precacheItem("rpd_mp");
	precacheItem("rpg_mp");
	precacheItem("winchester1200_mp");
	
	precacheModel("body_mp_usmc_woodland_sniper");
	precacheModel("head_mp_usmc_ghillie");
	precacheModel("body_mp_arab_regular_engineer");
	precacheModel("head_mp_arab_regular_ski_mask");
	

	thread startdoor();
	thread trap1();
	thread trap2();
	thread trap3();
	thread trap4();
	thread trap5();
	thread trap6();
	thread tp_1();
	thread elev();
	thread acti_tp1();
	thread acti_tp2();
	thread secret_open();
	thread secret_enter();
	thread secret_exit();
	thread secret_fail();
	thread xp_secret();
	thread bounce_wep();
	thread b_fail_1();
	thread b_fail_2();
	thread race_fail_1();
	thread race_fail_2();
	thread random_wepon();
	thread sniper_character();
	thread arab_character();
	thread xm_advertise();
	thread bouncepad1();
	thread door_vip();
	thread vip_leave();
	thread sniper_room();
	thread knife_room();
	thread race_room();
	thread bounce_room();
	thread addTestClients();
	thread hard_enter();
	thread hard_fail();
	thread music();
	thread vip_music();
	thread hard_leave();
	thread acti_jump_fail();
	thread acti_jump_enter();
	thread acti_jump_leave();
	thread rpg_wep();
	thread weapon_room();
	thread xm_trail();
	
	addTriggerToList("trig_trap1"); 
	addTriggerToList("trig_trap2");
	addTriggerToList("trig_trap3");
	addTriggerToList("trig_trap4");
	addTriggerToList("trig_trap5");
	addTriggerToList("trig_trap6");
	
}

addTriggerToList( name ) //Free Run Trap Fix
{
    if( !isDefined(level.trapTriggers) )
        level.trapTriggers = [];
    level.trapTriggers[level.trapTriggers.size] = getEnt(name , "targetname");
}

startdoor()
{
		level waittill( "round_started" );
		door = getEnt("startdoor","targetname");
		platforms = getEnt("start1","targetname");
		iPrintLnBold("^7Welcome to ^3#VC Style!!");
		wait 5;
		iPrintLnBold("^7Map By: ^6VC'Fox");
		wait 15;
		door moveZ(-300, 5);
		iPrintLnBold("Start ^7Door is ^3Open^7!");
		wait 2;
		platforms moveZ(512,1);
		wait 5;
		door delete();
}

music()
{
	x = randomInt(4);
	if(x == 3)
    {
		level waittill("round_started");
		ambientPlay("ark");
	}
    if(x == 0)
    {
		level waittill("round_started");
		ambientPlay("feint");
    }
	 if(x == 2)
    {
		level waittill("round_started");
		ambientPlay("north");
    }
	if(x == 1)
    {
		level waittill("round_started");
		ambientPlay("free");
    }
}

bouncepad1()
{
	trig = getent("trig_hop", "targetname");
	
	while(1)
	{
    	trig waittill ( "trigger", player );
    	 
	    player thread bounce2();
	}
}

bounce2()
{	
    for(i = 0; i < 4; i++)
	{
	    self.health += 160;
        self finishPlayerDamage(self, level.jumpattacker, 160, 0, "MOD_FALLING", "jump_mp", self.origin, AnglesToForward((-90,0,0)), "head", 0);
	}
}

door_vip()
{
	while(1)
	{
    trig = getEnt("vip_door","targetname");
	trig setHintString("Press [USE] to Enter VC Vault");
	tele1 = getEnt("vip1", "targetname");

    trig waittill("trigger",player);

    if(player getStat(767)==1)
    {
        player iprintlnBold("^1Authorized ^7Vistic Member!");
		player PlaySoundToPlayer("oldschool_return", player);
		player.vip = true;
		player setOrigin(tele1.origin);
		player setPlayerAngles(tele1.angles);
		player freezeControls(1);
		wait 0.01;
		player freezeControls(0);
		wait 0.1;
    }
	if(player getStat(767)==0)
        player iprintlnbold("^1Access Denied");
		wait 0.1;
	}
}


rpg_wep()
{
	trig = getEnt("trig_rpg", "targetname");
	rpg = getEnt("model_rpg","targetname");
	
	trig setHintString("Press [USE] For RPG");
	
	trig waittill("trigger", player);
	
	player giveWeapon("rpg_mp");
	player giveMaxAmmo("rpg_mp");
	player switchToWeapon("rpg_mp");
	wait 0.1;
	
	trig delete();
	rpg delete();
}


bounce_wep()
{
	trig = getEnt("trig_b_wep", "targetname");
	
	trig setHintString("Press [USE] For M40A3");
	
	while(1)
	{
	trig waittill("trigger", player);
	
	player giveWeapon("m40a3_mp");
	player giveMaxAmmo("m40a3_mp");
	player switchToWeapon("m40a3_mp");
	wait 0.1;
	}
}
	

trap1()
{
	brush = getEnt("trap1", "targetname");
	trig = getEnt("trig_trap1", "targetname");
	
	trig setHintString("Press [USE] To Activate");
	
	trig waittill("trigger", player);
	
	player braxi\_rank::giveRankXP( "", 50 );
	trig delete();
	
	for(;;)
	{
	wait 0.1;
	brush rotatePitch(360, 2);
	wait 4;
	}
}


trap2()
{
	brush = getEnt("trap2", "targetname");
	trig = getEnt("trig_trap2", "targetname");
	
	trig setHintString("Press [USE] To Activate");
	
	trig waittill("trigger", player);
	
	player braxi\_rank::giveRankXP( "", 50 );
	trig delete();
	
	for(;;)
	{
	wait 0.1;
	brush rotatePitch(-360, 3);
	wait 5;
	}
}


trap3()
{
	brush = getEnt("brush_kill", "targetname");
	kill_trig = getEnt("trig_kill", "targetname");
	trig = getEnt("trig_trap3", "targetname");
	
	trig setHintString("Press [USE] To Activate");
	
	trig waittill("trigger", player);
	
	player braxi\_rank::giveRankXP( "", 50 );
	trig delete();
	
	kill_trig enableLinkTo();
	kill_trig linkTo(brush);
	
	brush moveZ(88, 2);
	wait 5;
	brush moveZ(-88, 2);
}




trap4()
{
	brush = getEnt("trap4", "targetname");
	brush2 = getEnt("trap4a", "targetname");
	trig = getEnt("trig_trap4", "targetname");
	
	trig setHintString("Press [USE] To Activate");
	
	trig waittill("trigger", player);
	
	player braxi\_rank::giveRankXP( "", 50 );
	trig delete();
	brush2 notSolid();
	brush notSolid();
}


trap5()
{
	brush = getEnt("trap5", "targetname");
	brush1 = getEnt("trap5a", "targetname");
	trig = getEnt("trig_trap5", "targetname");
	
	trig setHintString("Press [USE] To Activate");
	
	trig waittill("trigger", player);
	
	player braxi\_rank::giveRankXP( "", 50 );
	trig delete();
	
	for(;;)
	{
	wait 0.1;
	brush rotateYaw(-720, 3);
	brush1 rotateYaw(720, 3);
	wait 4;
	brush rotateYaw(720, 2);
	brush1 rotateYaw(-720, 2);
	wait 4;
}
}

trap6()
{
	brush = getEnt("trap6", "targetname");
	trig = getEnt("trig_trap6", "targetname");
	
	trig setHintString("Press [USE] To Activate");
	
	trig waittill("trigger", player);
	
	player braxi\_rank::giveRankXP( "", 50 );
	trig delete();
	
	brush MoveX(-952, 1);
	wait 3;
	brush delete();
}

secret_open()
{
	brush = getEnt("sec_block", "targetname");
	trig = getEnt("trig_sec_open", "targetname");
	clip = getEnt("sec_clip", "targetname");
	
	trig setHintString("?????");
	
	trig waittill("trigger", player);
	
	iPrintLnBold("^7Secret is open!");
	
	trig delete();
	clip delete();
	brush delete();
}


secret_enter()
{
	trig = getEnt("trig_sec_enter", "targetname");
	tele1 = getEnt("here4", "targetname");

	for(;;)
		{
			trig waittill("trigger", player);
			player thread secret_timer_easy();
			player setOrigin(tele1.origin);
			player setPlayerAngles(tele1.angles);
			player freezeControls(1);
			wait 0.01;
			player freezeControls(0);
		}
}


acti_jump_fail()
{
	trig = getEnt("acti_fail", "targetname");
	tele1 = getEnt("acti_jump", "targetname");

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

acti_jump_enter()
{
	trig = getEnt("acti_enter", "targetname");
	tele1 = getEnt("acti_jump", "targetname");
	
			trig setHintString("Press [USE] To Enter Acti Jump Room");
	
			trig waittill("trigger", player);
			
			
			player setOrigin(tele1.origin);
			player setPlayerAngles(tele1.angles);
			player freezeControls(1);
			wait 0.01;
			player freezeControls(0);
			
			trig delete();

}

acti_jump_leave()
{
	trig = getEnt("acti_leave", "targetname");
	tele1 = getEnt("acti_back", "targetname");
	
			trig waittill("trigger", player);
			
			iPrintLnBold("^3 " + player.name + " ^7Has Finished Activator Jump Room!");
			
			player braxi\_rank::giveRankXP( "", 750 );
			player setOrigin(tele1.origin);
			player setPlayerAngles(tele1.angles);
			player freezeControls(1);
			wait 0.01;
			player freezeControls(0);
			
			trig delete();

}

hard_enter()
{
	trig = getEnt("hard_enter", "targetname");
	tele1 = getEnt("sec_hard", "targetname");
	
	trig setHintString("Press [USE] to enter Hard Secret!");

	while(1)
		{
			trig waittill("trigger", player);
			player thread secret_timer_hard();
			player setOrigin(tele1.origin);
			player setPlayerAngles(tele1.angles);
			player freezeControls(1);
			wait 0.01;
			player freezeControls(0);
		}
}

hard_fail()
{
	trig = getEnt("hard_fail", "targetname");
	tele1 = getEnt("sec_hard", "targetname");

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

hard_leave()
{
	trig = getEnt("hard_leave", "targetname");
	tele1 = getEnt("here1", "targetname");

	for(;;)
		{
			trig waittill("trigger", player);
			player braxi\_rank::giveRankXP( "", 550 );
			iPrintLnBold("^7"+ player.name + " ^7Has Finished the ^1Hard ^7Secret");	
			player notify("sec2_done");
			player.secretTimer destroy();
			player setOrigin(tele1.origin);
			player setPlayerAngles(tele1.angles);
			player freezeControls(1);
			wait 0.01;
			player freezeControls(0);
		}
}


vip_leave()
{
	trig = getEnt("trig_leave", "targetname");
	tele1 = getEnt("here_leave", "targetname");
	
	trig setHintString("Press [USE] to Leave VCVault");

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



secret_timer_easy() //VC'Blade Timer
{
	self endon("sec1_done");

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
        self.secretTimer.glowAlpha = 1;
        self.secretTimer.hidewheninmenu = true;
        self.secretTimer.label = &"Time in Secret: &&1";
        if(isdefined(level.randomcolor))
	self.secretTimer.glowColor=level.randomcolor;
	else 
	self.secretTimer.glowColor=(1,0,0);

	time=80;
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


secret_timer_hard() //VC'Blade Timer
{
	self endon("sec2_done");

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
        self.secretTimer.glowAlpha = 1;
        self.secretTimer.hidewheninmenu = true;
        self.secretTimer.label = &"Time in Secret: &&1";
        if(isdefined(level.randomcolor))
	self.secretTimer.glowColor=level.randomcolor;
	else 
	self.secretTimer.glowColor=(1,0,0);

	time=120;
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

secret_exit()
{
	trig = getEnt("sec_exit", "targetname");
	tele1 = getEnt("here_easy", "targetname");

	for(;;)
		{
			trig waittill("trigger", player);
			player braxi\_rank::giveRankXP( "", 200 );
			iPrintLnBold("^7"+ player.name + " ^7Has Finished the ^5Easy ^7Secret");	
			player notify("sec1_done");
			player.secretTimer destroy();
			player setOrigin(tele1.origin);
			player setPlayerAngles(tele1.angles);
			player freezeControls(1);
			wait 0.01;
			player freezeControls(0);
		}
}


xp_secret()
{
	trig = getEnt("sec_xp", "targetname");
	
	trig setHintString("Press [USE] ^7For XP");
	
	trig waittill("trigger", player);
	
	player braxi\_rank::giveRankXP( "", 250 );
	iPrintLnBold("^7"+ player.name + " ^7Has Found Some XP!");	
	trig delete();
}


race_fail_1()
{
	trig = getEnt("r_f_1", "targetname");
	tele1 = getEnt("r_r_1", "targetname");

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

race_fail_2()
{
	trig = getEnt("r_f_2", "targetname");
	tele1 = getEnt("r_r_2", "targetname");

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

b_fail_1()
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

b_fail_2()
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

secret_fail()
{
	trig = getEnt("sec_fail", "targetname");
	tele1 = getEnt("here4", "targetname");

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

tp_1()
{
	trig = getEnt("tp1", "targetname");
	tele1 = getEnt("here1", "targetname");

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

acti_tp1()
{
	trig = getEnt("acti_tp1", "targetname");
	tele1 = getEnt("here2", "targetname");

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

acti_tp2()
{
	trig = getEnt("acti_tp2", "targetname");
	tele1 = getEnt("here3", "targetname");

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

elev()
{
	plat = getEnt("elev", "targetname");
	trig = getEnt("trig_elev", "targetname");
	
	trig waittill ("trigger",player);
	
	trig delete();
	
	for(;;)
	{
	wait 0.1;
	plat moveY (1088, 4);
	wait 6;
	plat moveY (-1088, 4);
	wait 6;
	}	
}


/////////////////////////////
////////////// vip area /////

random_wepon()
{
	trig = getEnt("trig_rand_wep", "targetname");
	
	trig setHintString("Press [USE] ^7For PDW");
	
	while(1)
	{
	
	trig waittill("trigger", player);
	
	random_weapon = [];
	random_weapon[random_weapon.size] = "pdw_mp";
		
	x = randomInt(random_weapon.size);
		
	wep = random_weapon[x];

	player giveWeapon(wep);
	player giveMaxAmmo(wep);	
	player switchToWeapon(wep);
	
	}	
}


sniper_character()
{
	trig = getEnt("trig_snip_char", "targetname");
	
	while(1)
	{
	
	trig setHintString("Press [USE] ^7To Be Sniper Ghillie");
	
	trig waittill("trigger", player);
	
	player detachAll();
	player setModel("body_mp_usmc_woodland_sniper");
	player attach("head_mp_usmc_ghillie", "", true);
	player iPrintLnBold("Model Changed to ^3Sniper Ghillie");
	wait 0.1;
	}
}

arab_character()
{
	trig = getEnt("trig_arab", "targetname");
	
	while(1)
	{
	
	trig setHintString("Press [USE] ^7To Be Arab Engineer");
	
	trig waittill("trigger", player);
	
	player detachAll();
	player setModel("body_mp_arab_regular_engineer");
	player attach("head_mp_arab_regular_ski_mask", "", true);
	player iPrintLnBold("Model Changed to ^3Arab Engineer");
	wait 0.1;
	}
}

xm_advertise()
{
	trig = getEnt("trig_adv", "targetname");
	
	while(1)
	{
	
	trig setHintString("Press [USE] ^7To Advertise Clan");
	
	trig waittill("trigger", player);
	player iPrintLnBold("lmao im too lazy to add shit here ^6=^.^=");
	}
}


xm_trail()
{
	trig = getEnt("trig_trail", "targetname");
	
	while(1)
	{
	trig setHintString("Press [USE] ^7For VIP Trail");
	
	trig waittill("trigger", player);
	
	player thread vip_trail();
	wait 2;
	}
}

vip_trail()
{ 
    while(isAlive(self))
  {
    PlayFX(level.trail,self.origin);  
    wait .2;
  }
}


vip_music()
{
	trig = getEnt("trig_music", "targetname");
	
	trig setHintString("Press [USE] Change Music!");
	
	trig waittill("trigger", player);
	
	iPrintLnBold("^6 " + player.name + " ^7Changed the Music!");
	
	ambientStop();
	wait 0.1;
	ambientPlay("vip");
	wait 0.1;
	
	trig delete();

}

//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
bounce_room()
{
	while(1)
	{
	level.trigbounce = getEnt("trig_bounce", "targetname");
	
	jumporigin = getEnt("b_r_1", "targetname");
	actiorigin = getEnt("b_r_2", "targetname");
	
	level.trigbounce setHintString("Bounce room");
	
	level.trigbounce waittill("trigger", player);

	 // ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================
	
	level.trigrace delete();
	level.trigsniper delete();
	level.trigknife delete();
	level.trigwep delete();

	
	iPrintLnBold("^3" + player.name + " ^7Entered The Bounce ^7Room");
	player.health = player.maxhealth;
	level.activ.health = level.activ.maxhealth;
	
	
	player takeAllWeapons();
	level.activ takeAllWeapons();
	
	player giveWeapon("knife_mp");
	level.activ giveWeapon("knife_mp");
	
	player switchToWeapon("knife_mp");
	level.activ switchToWeapon("knife_mp");
	
	player freezeControls(1);
	level.activ freezeControls(1);
	
	player setOrigin (jumporigin.origin);
	player setPlayerAngles (jumporigin.angles);

	level.activ setOrigin (actiorigin.origin);
	level.activ setPlayerAngles (actiorigin.angles);
	wait 2;
	
	player iPrintLnBold("^23");
	level.activ iPrintLnBold("^23");
	wait 1;
	player iPrintLnBold("^72");
	level.activ iPrintLnBold("^72");
	wait 1;
	player iPrintLnBold("^21");
	level.activ iPrintLnBold("^21");
	wait 1;
	player iPrintLnBold("^7FIGHT^2!");
	level.activ iPrintLnBold("^7FIGHT^2!");
	
	player freezeControls(0);
	level.activ freezeControls(0);
	while( isAlive( player ) && isDefined( player ) )
    wait 1;
	

	}
}


race_room()
{
	while(1)
	{
	level.trigrace = getEnt("trig_race", "targetname");
	
	jumporigin = getEnt("r_r_1", "targetname");
	actiorigin = getEnt("r_r_2", "targetname");
	
	level.trigrace setHintString("race room");
	
	level.trigrace waittill("trigger", player);

	 // ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================
	
	level.trigbounce delete();
	level.trigsniper delete();
	level.trigknife delete();
	level.trigwep delete();
	
	thread race_ends();
	level.race_jumper = player;

	
	iPrintLnBold("^3" + player.name + " ^7Entered The Race ^7Room");
	player.health = player.maxhealth;
	level.activ.health = level.activ.maxhealth;
	
	
	player takeAllWeapons();
	level.activ takeAllWeapons();
	
	player giveWeapon("knife_mp");
	level.activ giveWeapon("knife_mp");
	
	player switchToWeapon("knife_mp");
	level.activ switchToWeapon("knife_mp");
	
	player freezeControls(1);
	level.activ freezeControls(1);
	
	player setOrigin (jumporigin.origin);
	player setPlayerAngles (jumporigin.angles);

	level.activ setOrigin (actiorigin.origin);
	level.activ setPlayerAngles (actiorigin.angles);
	wait 2;
	
	player iPrintLnBold("^23");
	level.activ iPrintLnBold("^23");
	wait 1;
	player iPrintLnBold("^72");
	level.activ iPrintLnBold("^72");
	wait 1;
	player iPrintLnBold("^21");
	level.activ iPrintLnBold("^21");
	wait 1;
	player iPrintLnBold("^7FIGHT^2!");
	level.activ iPrintLnBold("^7FIGHT^2!");
	
	player freezeControls(0);
	level.activ freezeControls(0);
	while( isAlive( player ) && isDefined( player ) )
    wait 1;
	

	}
}


race_ends() //here i have the trigger to win/loos the race
{
	level.race_winner = getent("race_winner","targetname");
	level.race_loser = getent("race_loser","targetname");
	
	wait 1;

	thread ifactiwin();
	thread ifjumperwin();
}

ifactiwin() 
{
	trig = getent("race_end_acti","targetname");
	
	for(;;)
	{
		trig waittill("trigger",who);
		
		if(who.pers["team"] == "axis")
		{
			level.activ setorigin(level.race_winner.origin);
			level.activ setplayerangles(level.race_winner.angles);
			
			level.activ giveWeapon("deserteagle_mp");
			level.activ switchToWeapon("deserteagle_mp");
			level.activ giveMaxAmmo("deserteagle_mp");
			wait .2;
			
			level.race_jumper setorigin(level.race_loser.origin);
			level.race_jumper setplayerangles(level.race_loser.angles);
			level.race_jumper freezecontrols(1);
		}
	}
}

ifjumperwin() 
{
	trig = getent("race_end_jumper","targetname");
	
	for(;;)
	{
		trig waittill("trigger",who);
		
		if(who.pers["team"] == "allies")
		{
			level.race_jumper setorigin(level.race_winner.origin);
			level.race_jumper setplayerangles(level.race_winner.angles);

				level.race_jumper giveWeapon("deserteagle_mp");
				level.race_jumper switchToWeapon("deserteagle_mp");
				level.race_jumper giveMaxAmmo("deserteagle_mp");
			wait .2;
			
			level.activ setorigin(level.race_loser.origin);
			level.activ setplayerangles(level.race_loser.angles);
			level.activ freezecontrols(1);
		}
	}
}


knife_room()
{
	while(1)
	{
	level.trigknife = getEnt("trig_knife", "targetname");
	
	jumporigin = getEnt("knife_1", "targetname");
	actiorigin = getEnt("knife_2", "targetname");
	
	level.trigknife setHintString("knife room");
	
	level.trigknife waittill("trigger", player);

	 // ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================
	
	level.trigbounce delete();
	level.trigrace delete();
	level.trigsniper delete();
	level.trigwep delete();

	
	iPrintLnBold("^3" + player.name + " ^7Entered The Knife ^7Room");
	player.health = player.maxhealth;
	level.activ.health = level.activ.maxhealth;
	
	
	player takeAllWeapons();
	level.activ takeAllWeapons();
	
	player giveWeapon("knife_mp");
	level.activ giveWeapon("knife_mp");
	
	player switchToWeapon("knife_mp");
	level.activ switchToWeapon("knife_mp");
	
	player freezeControls(1);
	level.activ freezeControls(1);
	
	player setOrigin (jumporigin.origin);
	player setPlayerAngles (jumporigin.angles);

	level.activ setOrigin (actiorigin.origin);
	level.activ setPlayerAngles (actiorigin.angles);
	wait 2;
	
	player iPrintLnBold("^23");
	level.activ iPrintLnBold("^23");
	wait 1;
	player iPrintLnBold("^72");
	level.activ iPrintLnBold("^72");
	wait 1;
	player iPrintLnBold("^21");
	level.activ iPrintLnBold("^21");
	wait 1;
	player iPrintLnBold("^7FIGHT^2!");
	level.activ iPrintLnBold("^7FIGHT^2!");
	
	player freezeControls(0);
	level.activ freezeControls(0);
	while( isAlive( player ) && isDefined( player ) )
    wait 1;
	

	}
}


sniper_room()
{
	while(1)
	{
	level.trigsniper = getEnt("trig_sniper", "targetname");
	
	jumporigin = getEnt("snip_1", "targetname");
	actiorigin = getEnt("snip_2", "targetname");
	
	level.trigsniper setHintString("sniper room");
	
	level.trigsniper waittill("trigger", player);

	 // ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================
	
	level.trigknife delete();
	level.trigrace delete();
	level.trigbounce delete();
	level.trigwep delete();
	
	iPrintLnBold(" " + player.name + " ^7Entered The Sniper ^7Room");
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
	
	player iPrintLnBold("^23");
	level.activ iPrintLnBold("^23");
	wait 1;
	player iPrintLnBold("^72");
	level.activ iPrintLnBold("^72");
	wait 1;
	player iPrintLnBold("^21");
	level.activ iPrintLnBold("^21");
	wait 1;
	player iPrintLnBold("^7FIGHT^2!");
	level.activ iPrintLnBold("^7FIGHT^2!");
	
	player freezeControls(0);
	level.activ freezeControls(0);
	while( isAlive( player ) && isDefined( player ) )
    wait 1;
	

	}
}


weapon_room()
{
	while(1)
	{
	level.trigwep = getEnt("trig_ak47", "targetname");
	
	jumporigin = getEnt("snip_1", "targetname");
	actiorigin = getEnt("snip_2", "targetname");
	
	level.trigwep setHintString("weapon room");
	
	level.trigwep waittill("trigger", player);

	 // ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================
	
	level.trigknife delete();
	level.trigrace delete();
	level.trigbounce delete();
	level.trigsniper delete();
	
	iPrintLnBold(" " + player.name + " ^7Entered The Weapon ^7Room");
	player.health = player.maxhealth;
	level.activ.health = level.activ.maxhealth;
	
	
	player takeAllWeapons();
	level.activ takeAllWeapons();
	
	player giveWeapon("ak47_mp");
	player giveMaxAmmo("ak47_mp");

	level.activ giveWeapon("ak47_mp");
	level.activ giveMaxAmmo("ak47_mp");
	
	
	player switchToWeapon("ak47_mp");
	
	level.activ switchToWeapon("ak47_mp");
	
	player freezeControls(1);
	level.activ freezeControls(1);
	
	player setOrigin (jumporigin.origin);
	player setPlayerAngles (jumporigin.angles);

	level.activ setOrigin (actiorigin.origin);
	level.activ setPlayerAngles (actiorigin.angles);
	wait 2;
	
	player iPrintLnBold("^23");
	level.activ iPrintLnBold("^23");
	wait 1;
	player iPrintLnBold("^72");
	level.activ iPrintLnBold("^72");
	wait 1;
	player iPrintLnBold("^21");
	level.activ iPrintLnBold("^21");
	wait 1;
	player iPrintLnBold("^7FIGHT^2!");
	level.activ iPrintLnBold("^7FIGHT^2!");
	
	player freezeControls(0);
	level.activ freezeControls(0);
	while( isAlive( player ) && isDefined( player ) )
    wait 1;
	

	}
}
	
//////////////////////////////////////////////////////////


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