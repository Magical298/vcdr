// __/\\\________/\\\_______________________________________________________________________/\\\\\\\\\__/\\\\\\_________________________________        
//  _\/\\\_______\/\\\____________________________________________________________________/\\\////////__\////\\\_________________________________       
//   _\//\\\______/\\\___/\\\__________________/\\\_______/\\\___________________________/\\\/______________\/\\\_________________________________      
//   __\//\\\____/\\\___\///___/\\\\\\\\\\__/\\\\\\\\\\\_\///______/\\\\\\\\____________/\\\________________\/\\\_____/\\\\\\\\\_____/\\/\\\\\\___     
//    ___\//\\\__/\\\_____/\\\_\/\\\//////__\////\\\////___/\\\___/\\\//////____________\/\\\________________\/\\\____\////////\\\___\/\\\////\\\__    
//     ____\//\\\/\\\_____\/\\\_\/\\\\\\\\\\____\/\\\______\/\\\__/\\\___________________\//\\\_______________\/\\\______/\\\\\\\\\\__\/\\\__\//\\\_   
//      _____\//\\\\\______\/\\\_\////////\\\____\/\\\_/\\__\/\\\_\//\\\___________________\///\\\_____________\/\\\_____/\\\/////\\\__\/\\\___\/\\\_  
//       ______\//\\\_______\/\\\__/\\\\\\\\\\____\//\\\\\___\/\\\__\///\\\\\\\\______________\////\\\\\\\\\__/\\\\\\\\\_\//\\\\\\\\/\\_\/\\\___\/\\\_ 
//        _______\///________\///__\//////////______\/////____\///_____\////////__________________\/////////__\/////////___\////////\//__\///____\///__

/*
  _   ________   ___  __        __   
 | | / / ___( ) / _ )/ /__ ____/ /__ 
 | |/ / /__ |/ / _  / / _ `/ _  / -_)
 |___/\___/   /____/_/\_,_/\_,_/\__/ 

 © VC' Blade

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

	setdvar( "r_specularcolorscale", "1" );
	setdvar("r_glowbloomintensity0",".1");
	setdvar("r_glowbloomintensity1",".1");
	setdvar("r_glowskybleedintensity0",".1");
	setdvar("compassmaxrange","1500");

	precachemodel("com_laptop_open");
	precachemodel("com_laptop_open_obj");
	precachemodel("weapon_c4_mp");
	precachemodel("weapon_c4_obj");
	precachemodel("vehicle_small_hatchback_blue_static");
	precachemodel("vehicle_small_hatchback_d_blue_static");

	level.explo = loadfx("explosions/exp_pack_doorbreach"); 
	level.komet = loadfx("vistic/light_up");
	level.komet_explo = loadfx("vistic/light_explosion");
	level.gas = loadfx("vistic/green_smoke");
	level.laser_center = LoadFX("shiet/laser_center");
	level.magic_orbs = LoadFx("shiet/magic_orbs");
	level.orb_center = LoadFX("shiet/orb_center");
	level.orb_explosion = LoadFX("shiet/orb_explosion");
	level.flys = loadfx("flys/flys");
	level.fireball_incomming = LoadFX("shiet/fire_incomming");
	level.fireball_impact = LoadFX("shiet/fire_impact");
	level.fire_blue = LoadFX("shiet/fire_blue");

	level.kz_doors=getent("kz_doors","targetname");
		level.kz_doors hide();
		level.kz_doors notsolid();
	level.smash_doors=getent("smash_doors","targetname");
		level.smash_doors hide();
		level.smash_doors notsolid();

	scripts=[];
	scripts[scripts.size] = ::trap_spikes;
	scripts[scripts.size] = ::trap_cars;
	scripts[scripts.size] = ::trap_comet;
	scripts[scripts.size] = ::trap_kz;
	scripts[scripts.size] = ::trap_hallway;
	scripts[scripts.size] = ::trap_smash;
	scripts[scripts.size] = ::mapCredits;
	scripts[scripts.size] = ::modelsetups;
	scripts[scripts.size] = ::fake_secret;
	scripts[scripts.size] = ::knife_door;
	scripts[scripts.size] = ::knife_room;
	scripts[scripts.size] = ::snipe_door;
	scripts[scripts.size] = ::snipe_room;
	scripts[scripts.size] = ::check_for_keys;
	scripts[scripts.size] = ::secret_keys;
	scripts[scripts.size] = ::secret_stuff;
	scripts[scripts.size] = ::teleport;
	scripts[scripts.size] = ::music;

	for(i=0;i<scripts.size;i++)
	{
		thread [[scripts[i]]]();
	}
}

music()
{
	musik = randomint(7);
	if(musik==2||musik==6||musik==02||musik==3)
		ambientplay("map_1");
	else
		ambientplay("map_2");
}

mapCredits()
{
	level waittill("round_started");
	wait 4;
	thread drawInformation(800,0.8, 1, "Deathrun Vacant");
	thread drawInformationSmall(800,0.8, 1, "Made by VC' Blade");
	wait 4;
	thread drawInformationSmall(800,0.8, -1, "Visit: vistic-clan.com");
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
	hud.color = (1,1,1);
	hud.font = "objective";
	hud.glowColor = (0,1,0);
	hud.glowAlpha = 1;
	hud.alpha = 0;
	hud fadeovertime( fade_in_time );
	hud.alpha = 1;
	hud.hidewheninmenu = true;
	hud.sort = 10;
	return hud;
}

drawInformationSmall( start_offset, movetime, mult, text )
{
	start_offset *= mult;
	hud = new_smaller_ending_hud( "center", 0.1, start_offset, 54 );
	hud setText( text );
	hud moveOverTime( movetime );
	hud.fontscale = 2;
	hud.x = 0;
	wait( movetime );
	wait( 3 );
	hud moveOverTime( movetime );
	hud.x = start_offset * -1;

	wait movetime;
	hud destroy();
}

new_smaller_ending_hud( align, fade_in_time, x_off, y_off )
{
	hud = newHudElem();
    hud.foreground = true;
	hud.x = x_off;
	hud.y = y_off;
	hud.alignX = align;
	hud.alignY = "middle";
	hud.horzAlign = align;
	hud.vertAlign = "middle";
 	hud.fontScale = 1.5;
	hud.color = (1,1,1);
	hud.font = "objective";
	hud.glowColor = (0,1,0);
	hud.glowAlpha = 1;

	hud.alpha = 0;
	hud fadeovertime( fade_in_time );
	hud.alpha = 1;
	hud.hidewheninmenu = true;
	hud.sort = 10;
	return hud;
}

fake_secret()
{
	sec_1=getent("fake_secret_1","targetname");
	sec_2=getent("fake_secret_2","targetname");
	sec_3=getent("fake_secret_3","targetname");

	step=0;

	sec_1 waittill("trigger",p);
	{
		step++;
		p iprintlnbold("^1Step "+step+" ^7done");
		p.fake_1=true;
	}

	sec_2 waittill("trigger",p);
	{
		step++;
		p iprintlnbold("^1Step "+step+" ^7done");
		p.fake_2=true;
	}

	sec_3 waittill("trigger",p);
	{
		step++;
		p iprintlnbold("^1Step "+step+" ^7done");
		p.fake_3=true;
	}
	
	if(p.fake_1==true  && p.fake_2==true && p.fake_3==true)
	{
		p iprintlnbold("Your reward for doing secret is a free death");
		wait 1;
		p suicide();
	}
}

trap_spikes()
{
	trig=getent("trig_spikes","targetname");
	setdvar("trap_spikes","0");
	for(;;)
	{
		trig waittill("trigger",p);
		if(!level.trapsdisabled)
		{
			if(getdvar("trap_spikes")!="1")
			{
				thread spikes_funktion();
				p braxi\_rank::giverankxp(undefined,20);
				setdvar("trap_spikes","1");
			}
			else if(getdvar("trap_spikes")=="1")
			{
				p iprintlnbold("Trap has already been used.");
			}
		}
		else
			iprintlnbold("^1"+p.name+"^7 tried to activate in Free Run");
	}
}
spikes_funktion()
{
	spikes=getent("trap_spikes","targetname");
	level.icon1 setmodel("com_laptop_open");
	spikes movez(-50,2);
	wait 7+randomint(5);
	spikes movez(50,2);
}

trap_cars()
{
	trig=getent("trig_cars","targetname");
	setdvar("trap_cars","0");
	for(;;)
	{
		trig waittill("trigger",p);
		if(!level.trapsdisabled)
		{
			if(getdvar("trap_cars")!="1")
			{
				thread auto_funktion();
				p braxi\_rank::giverankxp(undefined,20);
				setdvar("trap_cars","1");
			}
			else if(getdvar("trap_cars")=="1")
			{
				p iprintlnbold("Trap has already been used.");
			}
		}
		else
			iprintlnbold("^1"+p.name+"^7 tried to activate in Free Run");
	}
}
auto_funktion()
{
	level.icon3 setmodel("com_laptop_open");
	Earthquake(0.4,3,(1151.99,1550.45,7),300);
	Earthquake(0.4,3,(936.251,1518.82,7),300);
	Earthquake(0.4,3,(937.24,1669.12,7),300);
	playFx(level.explo,(936.251,1518.82,7));
	playFx(level.explo,(1151.99,1550.45,7));
	playFx(level.explo,(937.24,1669.12,7));
	level.car1 setmodel("vehicle_small_hatchback_d_blue_static");
	level.car2 setmodel("vehicle_small_hatchback_d_blue_static");
	level.car3 setmodel("vehicle_small_hatchback_d_blue_static");

	players = getEntArray( "player", "classname" );	
    for(k=0;k<players.size;k++)
    {
	    dist = Distance2D(players[k].origin,(1040,1584,32));
	    if(dist<150)
	    {
		    players[k] suicide();
	    }
	    else if(dist<200)
	    {
		    RadiusDamage( players[k].origin, 10, 60, 40);
	    }
	    else if(dist<250)
	    {
		    RadiusDamage( players[k].origin, 10, 30, 10);
		}
	}
}

trap_comet()
{
	trig=getent("trig_comet","targetname");
	setdvar("trap_comet","0");
	for(;;)
	{
		trig waittill("trigger",p);
		if(!level.trapsdisabled)
		{
			if(getdvar("trap_comet")!="1")
			{
				thread komet_funktion();
				p braxi\_rank::giverankxp(undefined,20);
				setdvar("trap_comet","1");
			}
			else if(getdvar("trap_comet")=="1")
			{
				p iprintlnbold("Trap has already been used.");
			}
		}
		else
			iprintlnbold("^1"+p.name+"^7 tried to activate in Free Run");
	}
}
komet_funktion()
{
	level.icon2 setmodel("com_laptop_open");
	level.come=getent("komet","targetname");
	thread komet_fx();

	level.come moveto((1038,1227,16),2,0.5,1.5);
	wait 2;
	level.effect=false;
	Earthquake(1,3,(1038,1227,16),800);
	playfx(level.komet_explo,(1038,1227,16));
	wait 0.05;
	players = getEntArray( "player", "classname" );	
	for(k=0;k<players.size;k++)
	{
		dist = Distance2D( players[k].origin,(1038,1227,16));
		if(dist < 200)
		{
			players[k] suicide();
		}
		else if(dist < 310)
		{
			RadiusDamage( players[k].origin, 10, 60, 40);
		}
	}
	level.come delete();
}
komet_fx()
{
	level.effect=true;
	while(level.effect)
	{
		playFx(level.komet,level.come.origin);
		Earthquake(1,3,level.come.origin,800);
		wait 0.05;
	}
}

trap_kz()
{
	trig=getent("trig_kz","targetname");
	setdvar("trap_kz","0");
	for(;;)
	{
		trig waittill("trigger",p);
		if(!level.trapsdisabled)
		{
			if(getdvar("trap_kz")!="1")
			{
				thread kz_funktion();
				p braxi\_rank::giverankxp(undefined,20);
				setdvar("trap_kz","1");
			}
			else if(getdvar("trap_kz")=="1")
			{
				p iprintlnbold("Trap has already been used.");
			}
		}
		else
			iprintlnbold("^1"+p.name+"^7 tried to activate in Free Run");
	}
}
kz_funktion()
{
	level.icon4 setmodel("com_laptop_open");
	level.kz_doors show();
	level.kz_doors solid();
	kz=getent("kz_origin","targetname");
	kz_hurt=getent("kz_hurt","targetname");
	kz_clip=getent("kz_clip","targetname");
	playfx(level.gas,kz.origin);
	kz_hurt enablelinkto();
	kz_hurt linkto(kz_clip);
	kz_clip movez(40,1);
	wait 12+randomint(4);	
	kz delete();
	kz_hurt delete();
	kz_clip delete();
	level.kz_doors delete();
}

trap_hallway()
{
	trig=getent("trig_hallway","targetname");
	setdvar("trap_hallway","0");
	for(;;)
	{
		trig waittill("trigger",p);
		if(!level.trapsdisabled)
		{
			if(getdvar("trap_hallway")!="1")
			{
				thread hallway_funktion();
				p braxi\_rank::giverankxp(undefined,20);
				setdvar("trap_hallway","1");
			}
			else if(getdvar("trap_hallway")=="1")
			{
				p iprintlnbold("Trap has already been used.");
			}
		}
		else
			iprintlnbold("^1"+p.name+"^7 tried to activate in Free Run");
	}
}
hallway_funktion()
{
	level.icon5 setmodel("com_laptop_open");
	hw=getent("hallway_trap","targetname");
	hw delete();
}

trap_smash()
{
	trig=getent("trig_smash","targetname");
	setdvar("trap_smash","0");
	for(;;)
	{
		trig waittill("trigger",p);
		if(!level.trapsdisabled)
		{
			if(getdvar("trap_smash")!="1")
			{
				thread smash_funktion();
				p braxi\_rank::giverankxp(undefined,20);
				setdvar("trap_smash","1");
			}
			else if(getdvar("trap_smash")=="1")
			{
				p iprintlnbold("Trap has already been used.");
			}
		}
		else
			iprintlnbold("^1"+p.name+"^7 tried to activate in Free Run");
	}
}
smash_funktion()
{
	level.icon6 setmodel("com_laptop_open");
	level.smash_doors show();
	level.smash_doors solid();
	smash_hurt=getent("smash_hurt","targetname");
	smash_clip=getent("smash_clip","targetname");
	smash_hurt enablelinkto();
	smash_hurt linkto(smash_clip);
	smash_clip movez(-350,5);
	wait 12;	
	smash_hurt delete();
	smash_clip delete();
	level.smash_doors delete();
}

modelsetups()
{
	level.icon1 = spawn("script_model",(72,1488,96.5)); 
	level.icon1.angles=(0,90,0);
	level.icon1 setModel("com_laptop_open_obj"); 

	level.icon2 = spawn("script_model",(684,1196,96.5)); 
	level.icon2.angles=(0,180,0);
	level.icon2 setModel("com_laptop_open_obj"); 

	level.icon3 = spawn("script_model",(684,1592,96.5)); 
	level.icon3.angles=(0,180,0);
	level.icon3 setModel("com_laptop_open_obj");

	level.icon4 = spawn("script_model",(684,1800,96.5)); 
	level.icon4.angles=(0,180,0);
	level.icon4 setModel("com_laptop_open_obj");

	level.icon5 = spawn("script_model",(40,2020,96.5)); 
	level.icon5.angles=(0,270,0);
	level.icon5 setModel("com_laptop_open_obj"); 

	level.icon6 = spawn("script_model",(136,2504,96.5)); 
	level.icon6.angles=(0,360,0);
	level.icon6 setModel("com_laptop_open_obj"); 

	level.icon7 = spawn("script_model",(-695,3050,116)); 
	level.icon7.angles=(270,360,0);
	level.icon7 setModel("weapon_c4_obj"); 

	level.icon8 = spawn("script_model",(66.4698,3263.52,114)); 
	level.icon8.angles=(270,92,0);
	level.icon8 setModel("weapon_c4_obj"); 

	level.sec_ic = spawn("script_model",(-274,1162,112)); 
	level.sec_ic.angles=(0,180,0);
	level.sec_ic setModel("com_laptop_open_obj");

	level.car1 = spawn("script_model",(1151.99,1550.45,7)); 
	level.car1.angles=(0,163.8,0);
	level.car1 setModel("vehicle_small_hatchback_blue_static"); 

	level.car2 = spawn("script_model",(936.251,1518.82,7)); 
	level.car2.angles=(0,33.3,0);
	level.car2 setModel("vehicle_small_hatchback_blue_static");

	level.car3 = spawn("script_model",(937.24,1669.12,7)); 
	level.car3.angles=(0,327.9,0);
	level.car3 setModel("vehicle_small_hatchback_blue_static");
}

knife_door()
{
	level.action_trig1 = getEnt("knife_door","targetname");
	door = getent("door_knife_open","targetname");
	level.action_trig1 waittill("trigger",player);

	if(!level.freerun)
	{
		level.icon8 setmodel("weapon_c4_mp");
		wait 2;
		door delete();
		level.action_trig1 delete();
		level.snipe delete();
		level.action_trig2 delete();
		Earthquake(0.4,3,(66.4698,3263.52,114),300);
		playFx(level.explo,(66.4698,3263.52,114));
		level.icon8 delete();
		level.icon7 delete();

		iprintlnbold("^1"+player.name+"^7 has opened Knife Game");
	}
	else
		player iprintlnbold("^1Rooms ^7are deactivated in First Round");
}

knife_room()
{
	level.knife=getEnt("knife_room","targetname");
	acti_o = (49,4062,35);
	acti_a = (0,270,0);
	jump_o = (50,3511,35);
	jump_a = (0,90,0);

	while(1)
	{
		level.knife waittill("trigger",player);

		if(!isDefined(level.knife))
			return;

// ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================

		player FreezeControls(1);
		level.activ FreezeControls(1);

		player SetPlayerAngles(jump_a);
        player setOrigin(jump_o);
        level.activ setPlayerangles(acti_a);
        level.activ setOrigin(acti_o);

        player takeallweapons();
        level.activ takeallweapons();

        if(getTeamPlayersAlive("allies")<2)
		{
			level.room_time=10;
			thread last_jump_knife();
			thread roomcountdown();
        	wait 10;
		}
		else
		{
			level.room_time=5;
			thread roomcountdown();
        	wait 5;
		}

        player setroomgun("knife_mp");
        level.activ setroomgun("knife_mp");

		player FreezeControls(0);
		level.activ FreezeControls(0);

        while(isAlive(player)&&isDefined(player))
            wait 1;
	}
}

snipe_door()
{
	level.action_trig2 = getEnt("sniper_door","targetname");
	door = getent("door_sniper_open","targetname");
	level.action_trig2 waittill("trigger",player);

	if(!level.freerun)
	{
		level.icon7 setmodel("weapon_c4_mp");
		wait 2;
		door delete();
		level.action_trig2 delete();
		level.action_trig1 delete();
		level.knife delete();
		Earthquake(0.4,3,(-695,3050,116),300);
		playFx(level.explo,(-695,3050,116));
		level.icon7 delete();
		level.icon8 delete();
		iprintlnbold("^1"+player.name+"^7 has opened Snipe Game");
	}
	else
		player iprintlnbold("^1Rooms ^7are deactivated in First Round");
}

snipe_room()
{
	level.snipe=getEnt("snipe_room","targetname");
	acti_o = (-952,2936,128);
	acti_a = (0,270,0);
	jump_o = (-952,1960,128);
	jump_a = (0,90,0);

	while(1)
	{
		level.snipe waittill("trigger",player);

		if(!isDefined(level.snipe))
			return;

		// ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================

		player FreezeControls(1);
		level.activ FreezeControls(1);

		player SetPlayerAngles(jump_a);
        player setOrigin(jump_o);
        level.activ setPlayerangles(acti_a);
        level.activ setOrigin(acti_o);

        player takeallweapons();
        level.activ takeallweapons();

        if(getTeamPlayersAlive("allies")<2)
		{
			level.room_time=10;
			thread last_jump_snipe();
			thread roomcountdown();
        	wait 10;
		}
		else
		{
			level.room_time=5;
			thread roomcountdown();
        	wait 5;
		}

        player setroomgun("m40a3_mp");
        level.activ setroomgun("m40a3_mp");

		player FreezeControls(0);
		level.activ FreezeControls(0);

        while(isAlive(player)&&isDefined(player))
            wait 1;
	}
}

setroomgun( gun )
{
	self takeallweapons();
	self giveweapon(gun);
	self switchtoweapon(gun);
}

roomcountdown()
{
	level.countdown = NewHudElem();
	level.countdown.alignX = "center";
	level.countdown.alignY = "middle";
	level.countdown.horzalign = "center";
	level.countdown.vertalign = "middle";
	level.countdown.alpha = 1;
	level.countdown.x = 0;
	level.countdown.y = 0;
	level.countdown.font = "default";
	level.countdown.fontscale = 2;
	level.countdown.glowalpha = 1;
	level.countdown.glowcolor = (1, 0.5, 0);
	level.countdown.label = &"Room starts in: ^1&&1";
    level.countdown settimer(level.room_time);
    wait level.room_time;
	level.countdown destroy();
}

// Secret 
secret_keys()
{
	level.secret_keys=[];
	i=0;
	level.secret_keys[i]=getEnt("key_1","targetname");
	i++;
	level.secret_keys[i]=getEnt("key_2","targetname");
	i++;
	level.secret_keys[i]=getEnt("key_3","targetname");

	for(i=0;i<level.secret_keys.size;i++)
	{
		level.secret_keys[i] thread waitTillTrigger(i);
	}
}

waitTillTrigger(number)
{
	real=number+1;
	self waittill("trigger",player);
	self delete();
	iPrintLnBold(player.name+" found the Keypart ^1"+real);
	level.found++;
}

check_for_keys()
{
	trig=getent("secret_trig","targetname");
	targ=getent("secret_destroy","targetname");
	triggered=false;
	level.found = 0;
	while(level.found<3)
	{
		wait 5;
		if(level.found==3 && triggered==false)
		{
			trig sethintstring("Use Keyparts to unlock the Door");
			trig waittill("trigger",player);
			iPrintLnBold(player.name+" has opened the Secret Room");
			wait 1;
			targ delete();
			triggered = true;
		}
		else
		trig sethintstring("Door is locked");
	}
}

secret_stuff()
{
	thread secret_credits();
	thread secret_pistols();
}

secret_credits()
{
	trig=getent("secret_credits","targetname");
	trig waittill("trigger");
	level.sec_ic setmodel("com_laptop_open");
	trig delete();
    level.system_miss = addTextHud( self, 0, -200, 1, "center", "middle", 1.6 );
    level.system_miss.horzAlign = "center";
    level.system_miss.vertAlign = "middle";
    level.system_miss.glowAlpha = 1;
    level.system_miss.glowColor = (0,1,1);
    level.system_miss.sort = 105;
    level.system_miss.font = "objective";
    level.system_miss.label = &"Special Thanks to:";
    level.system_miss SetPulseFX(40,5400,200);
    
    level.system_miss2 = addTextHud( self, 0, -170, 1, "center", "middle", 1.6 );
    level.system_miss2.horzAlign = "center";
    level.system_miss2.vertAlign = "middle";
    level.system_miss2.glowAlpha = 1;
    level.system_miss2.glowColor = (0,1,1);
    level.system_miss2.sort = 105;
    level.system_miss2.label = &"uNI for doing Graphics <3";
    level.system_miss2 SetPulseFX(40,5400,200);

    level.system_o2 = addTextHud( self, 0, -140, 1, "center", "middle", 1.6 );
    level.system_o2.horzAlign = "center";
    level.system_o2.vertAlign = "middle";
    level.system_o2.glowAlpha = 1;
    level.system_o2.glowColor = (0,1,1);
    level.system_o2.sort = 105;
    level.system_o2.label = &"rocco for teaching me <3";
    level.system_o2 SetPulseFX(40,5400,200);
    
    level.system_o22 = addTextHud( self, 0, -110, 1, "center", "middle", 1.6 );
    level.system_o22.horzAlign = "center";
    level.system_o22.vertAlign = "middle";
    level.system_o22.glowAlpha = 1;
    level.system_o22.glowColor = (0,1,1);
    level.system_o22.sort = 105;
    level.system_o22.label = &"Icomar for doing Fx for me <3";
    level.system_o22 SetPulseFX(40,5400,200);

    level.system_tem = addTextHud( self, 0, -80, 1, "center", "middle", 1.6 );
    level.system_tem.horzAlign = "center";
    level.system_tem.vertAlign = "middle";
    level.system_tem.glowAlpha = 1;
    level.system_tem.glowColor = (0,1,1);
    level.system_tem.sort = 105;
    level.system_tem.label = &"Sheep Wizard just cause <3";
    level.system_tem SetPulseFX(40,5400,200);
    
    level.system_tem2 = addTextHud( self, 0, -50, 1, "center", "middle", 1.6 );
    level.system_tem2.horzAlign = "center";
    level.system_tem2.vertAlign = "middle";
    level.system_tem2.glowAlpha = 1;
    level.system_tem2.glowColor = (0,1,1);
    level.system_tem2.sort = 105;
    level.system_tem2.label = &"Snitch for helping with Music <3";
    level.system_tem2 SetPulseFX(40,5400,200);

    level.system_tim = addTextHud( self, 0, -20, 1, "center", "middle", 1.6 );
    level.system_tim.horzAlign = "center";
    level.system_tim.vertAlign = "middle";
    level.system_tim.glowAlpha = 1;
    level.system_tim.glowColor = (0,1,1);
    level.system_tim.sort = 105;
    level.system_tim.font = "objective";
    level.system_tim.label = &"Vistic Community for being Awesome <3";
    level.system_tim SetPulseFX(40,5400,200);
}

addTextHud( who, x, y, alpha, alignX, alignY, fontScale )
{
    if( isPlayer( who ) )
        hud = newClientHudElem( who );
    else
        hud = newHudElem();

    hud.x = x;
    hud.y = y;
    hud.alpha = alpha;
    hud.alignX = alignX;
    hud.alignY = alignY;
    hud.fontScale = fontScale;
    return hud;
}

secret_pistols()
{
	trig = getent("secret_pistols","targetname");
	for(;;)
	{
		trig waittill("trigger",player);

		player giveweapon("deserteagle_mp");
		player giveweapon("colt44_mp");
		player giveweapon("usp_mp");
		player giveweapon("deserteaglegold_mp");
		player switchtoweapon("deserteagle_mp");
	}
}

last_jump_snipe()
{
	SetExpFog(256,768,0,0,0,3);

	orb = Spawn("script_model",(-960,2568,72));
	orb SetModel("tag_origin");
	wait 0.05;
	PlayFXOnTag( level.orb_center,orb,"tag_origin");
	orb MoveZ(150,2,1,1);
	wait 6;
	PlayFX(level.orb_explosion,orb.origin);
	EarthQuake(1.5,1.5,orb.origin,1600);
	orb delete();
	wait 3;
	PlayFX(level.flys,(-960,2568,50));
}

last_jump_knife()
{
	SetExpFog(128,768,0,0,0,3);

	center = (48,3776,24);
	ang = 0;
	fire_pos = undefined;
	fireball = undefined;
	
	for(i=0;i<5;i++)
	{
		fire_pos[i] = center+AnglesToForward( (0,ang,0) )*420;
		thread CreateFireball( fire_pos[i]+(0,0,300) );
		ang += 72;
		wait 1;
	}
	wait 1;
	fireball = getentarray("fireball", "targetname");
	for(i=0;i<fireball.size;i++)
	{
		trace = BulletTrace( fireball[i].origin, fireball[i].origin-(0,0,3000), false, fireball[i] );
		fireball[i] MoveTo( fireball[i].origin-(0,0,300), 1, 1, 0 );
	}
	wait 1;
	for(i=0;i<fireball.size;i++)
	{
		EarthQuake( 1, 1, fireball[i].origin, 700 );
		PlayFX( level.finalfight2_fireball_impact, fireball[i].origin );
		PlayFX( level._effect["fire_blue"], fireball[i].origin );
		fireball[i] delete();
	}
	wait 2;
	PlayFX( level.laser_center, (48,3776,24) );
	wait 1;
	
	orb = Spawn("script_model", (48,3776,24) );
	orb SetModel("tag_origin");
	wait 0.05;
	PlayFXOnTag( level.orb_center, orb, "tag_origin" );
	orb MoveZ( 600, 5, 1, 1 );
	
	wait 2;
	
	PlayFX( level.orb_explosion, orb.origin );
	EarthQuake( 1.5, 1.5, orb.origin, 1600 );
	orb delete();
	
	spawns = getentarray("mp_tdm_spawn", "classname");
	for(i=0;i<spawns.size;i++)
		PlayFX( level.fireball_impact, spawns[i].origin+(48,3776,50) );
	
	wait 2;
	
	PlayFX( level.magic_orbs, (48,3776,250) );
}

CreateFireball( pos )
{
	fireball = spawn("script_model", pos );
	fireball SetModel("tag_origin");
	fireball.targetname = "fireball";
	wait 0.05;
	PlayFXOnTag( level.fireball_incomming, fireball, "tag_origin" );
}

teleport()
{
	trig = getEnt("teleport_1", "targetname");
	targ_o = (712,2520,104);
	targ_a = (0,180,0);

	trig setHintString("Press ^1USE^7 for Teleport");

	while(1)
	{
		trig waittill ("trigger", player);
		
		{
		  player SetOrigin(targ_o);
		  player SetPlayerAngles(targ_a);
		}
	}
}