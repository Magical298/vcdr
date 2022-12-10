///////////////////////////////////////////////////////////////////////////
//  ______  __              __                      ___                 //
// /\__  _\/\ \            /\ \       __          /'___\               //
// \/_/\ \/\ \ \___      __\ \ \     /\_\   __  _/\ \__/   __         //
//    \ \ \ \ \  _ `\  /'__`\ \ \  __\/\ \ /\ \/'\ \ ,__\/'__`\      //
//     \ \ \ \ \ \ \ \/\  __/\ \ \L\ \\ \ \\/>  </\ \ \_/\  __/     //
//      \ \_\ \ \_\ \_\ \____\\ \____/ \ \_\/\_/\_\\ \_\\ \____\   //
//       \/_/  \/_/\/_/\/____/ \/___/   \/_/\//\/_/ \/_/ \/____/  //
//                                                               //
//////////////////////////////////////////////////////////////////                                                        

main()
{
	maps\mp\_load::main();

	game["allies"] = "marines";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "desert";
	game["axis_soldiertype"] = "desert";
	
	level.ring=loadfx("misc/ui_pickup_available");
	level.flare=loadfx("misc/flare_gun");
	level.acti_light=loadfx("misc/2towers_acti_fx");
	level.jewgas=loadfx("misc/jewgas");

	addTriggerToList("trap1_trig");
	addTriggerToList("trap2_trig");
	addTriggerToList("trap3_trig");
	addTriggerToList("trap4_trig");
	addTriggerToList("trap5_trig");
	addTriggerToList("trap6_trig");
	addTriggerToList("trap7_trig");
	addTriggerToList("trap8_trig");
	addTriggerToList("trap9_trig");
	addTriggerToList("trap10_trig");
	addTriggerToList("trap11_trig");
	
	setdvar("r_glowbloomintensity0",".25");
	setdvar("r_glowbloomintensity1",".25");
	setdvar("r_glowskybleedintensity0",".3");

	thread map_mover();
	thread startdoor();
	thread final_plat();
	thread bounce_room_battle();
	thread sniper_room_battle();
	thread knife_room_battle();
	thread actis_fail();
	thread actibousetup();
	thread acti_tele1();
	thread acti_tele1back();
	thread acti_ele();
	thread secret_wep();
	thread trap1();
	thread trap2();
	thread trap3();
	thread trap4();
	thread trap5();
	thread trap6();
	thread trap7();
	thread trap8();
	thread trap9();
	thread trap10();
	thread trap11();
	thread snipmodel_mover();
	thread knifemodel_mover();
	thread bouncemodel_mover();
	thread endmap_trig();
	thread creators();
}
addTriggerToList(name)
{
    if(!isDefined(level.trapTriggers))
    level.trapTriggers=[];
    level.trapTriggers[level.trapTriggers.size]=getEnt(name,"targetname");
}

map_mover()
{
	object = getent("map_mover","targetname");
	while(1)
	{
		object movez (64,5,1,4);
		object waittill ("movedone");
		object movez (-64,5,1,4);
		object waittill ("movedone");
	}
}

trap1()
{
	trigger = getent("trap1_trig","targetname");
	object = getent("trap1","targetname");
	trap1_fx = getent("trap1_fx","targetname");
	trigger waittill ("trigger", player );
	playfx(level.acti_light,trap1_fx.origin);
	trigger SetHintString("^1Activated");
	player braxi\_rank::giveRankXP("", 20);
	object rotateroll (-90, 1,0.2,0.8);
	object waittill ("rotatedone");
	wait 5;
	object  rotateroll (90, 5);
}

trap2()
{
	trigger = getEnt ( "trap2_trig", "targetname" );
	trap2_fx = getent("trap2_fx","targetname");
	kill1 = getEnt ( "trap2_1", "targetname" );
	kill2 = getEnt ( "trap2_2", "targetname" );
	kill1 maps\mp\_utility::triggeroff();
	kill2 maps\mp\_utility::triggeroff();
	trigger waittill ("trigger", player);
	playfx(level.acti_light,trap2_fx.origin);
	trigger SetHintString("^1Activated");
	player braxi\_rank::giveRankXP("", 20);
	i = randomintrange( 0, 2 );
	if(i == 0)
	{
	kill1 maps\mp\_utility::triggeron();
	}
	else if(i == 1)
	{
	kill2 maps\mp\_utility::triggeron();
	}
}

trap3()
{
	trigger = getEnt ( "trap3_trig", "targetname" );
	trap3_fx = getent("trap3_fx","targetname");
	trigger waittill ("trigger", player);
	playfx(level.acti_light,trap3_fx.origin);
	trigger SetHintString("^1Activated");
	player braxi\_rank::giveRankXP("", 20);
	thread trap3_1();
	thread trap3_2();
	thread trap3_3();
	
}
trap3_1()
{
	object1 = getent("trap3_1","targetname");
	while(1)
	{
		object1 movey (-151,1);
		object1 waittill ("movedone");
		wait 2;
		object1 movey (151,1,0.1,0.5);
		object1 waittill ("movedone");
		wait 2;
	}
}
trap3_2()
{
	object2 = getent("trap3_2","targetname");
	while(1)
	{
		wait 1;
		object2 movey (-151,1);
		object2 waittill ("movedone");
		wait 2;
		object2 movey (151,1,0.1,0.5);
		object2 waittill ("movedone");
		wait 1;
	}
}
trap3_3()
{
	object3 = getent("trap3_3","targetname");
	while(1)
	{
		wait 2;
		object3 movey (-151,1);
		object3 waittill ("movedone");
		wait 2;
		object3 movey (151,1,0.1,0.5);
		object3 waittill ("movedone");
	}
}

trap4()
{
	trigger = getEnt ( "trap4_trig", "targetname" );
	object = getEnt ( "trap4", "targetname" );
	trap4_fx = getent("trap4_fx","targetname");
	trigger waittill ("trigger", player);
	playfx(level.acti_light,trap4_fx.origin);
	trigger SetHintString("^1Activated");
	player braxi\_rank::giveRankXP("", 20);
	while(1)
	{
		object rotateroll (-1080, 4,1,3);
		object waittill ("rotatedone");
		wait 2;
		object rotateroll (1080, 4,1,3);
		object waittill ("rotatedone");
		wait 2;
	}
}

trap5()
{
	trigger = getEnt ( "trap5_trig", "targetname" );
	object = getEnt ( "trap5", "targetname" );
	trap5_fx = getent("trap5_fx","targetname");
	trigger waittill ("trigger", player);
	playfx(level.acti_light,trap5_fx.origin);
	trigger SetHintString("^1Activated");
	player braxi\_rank::giveRankXP("", 20);
	while(1)
	{
		object rotatepitch (180, 4);
		object waittill ("rotatedone");
		object rotatepitch (180, 1,0.1,0.9);
		object waittill ("rotatedone");
		
	}
}

trap6()
{
	trigger = getEnt ( "trap6_trig", "targetname" );
	object1 = getEnt ( "trap6_1", "targetname" );
	object2 = getEnt ( "trap6_2", "targetname" );
	kill1 = getEnt ( "trap6_1kill", "targetname" );
	trap6_fx = getent("trap6_fx","targetname");
	
	kill1 maps\mp\_utility::triggeroff();
	
	trigger waittill ("trigger", player);
	playfx(level.acti_light,trap6_fx.origin);
	trigger SetHintString("^1Activated");
	player braxi\_rank::giveRankXP("", 20);
	i = randomintrange( 0, 2 );
	if(i == 0)
	{
	object2 delete();
	}
	else if(i == 1)
	{
	kill1 maps\mp\_utility::triggeron();
	wait 0.1;
	kill1 enablelinkto ();
	kill1 linkto (object1);
	wait 0.1;
	object1 movez(-128,1);
	kill1 delete();
	}
}

trap7()
{
	trigger = getEnt ( "trap7_trig", "targetname" );
	trap7_fx = getent("trap7_fx","targetname");
	trigger waittill ("trigger", player);
	playfx(level.acti_light,trap7_fx.origin);
	trigger SetHintString("^1Activated");
	player braxi\_rank::giveRankXP("", 20);
	thread trap7_1();
	thread trap7_2();
	thread trap7_3();
	thread trap7_4();
}
trap7_1()
{
	object1 = getent("trap7_1","targetname");
	while(1)
	{
		object1 rotateyaw (360,2);
		object1 waittill ("rotatedone");
		wait 2;
	}
}
trap7_2()
{
	object2 = getent("trap7_2","targetname");
	while(1)
	{
		wait 2;
		object2 rotateyaw (-360,2);
		object2 waittill ("rotatedone");
	}
}
trap7_3()
{
	object3 = getent("trap7_3","targetname");
	while(1)
	{
		wait 2;
		object3 rotateyaw (360,2);
		object3 waittill ("rotatedone");
	}
}
trap7_4()
{
	object4 = getent("trap7_4","targetname");
	while(1)
	{
		object4 rotateyaw (-360,2);
		object4 waittill ("rotatedone");
		wait 2;
	}
}

trap8()
{
	trigger = getEnt ( "trap8_trig", "targetname" );
	object = getEnt ( "trap8", "targetname" );
	trap8_fx = getent("trap8_fx","targetname");
	trigger waittill ("trigger", player);
	playfx(level.acti_light,trap8_fx.origin);
	trigger SetHintString("^1Activated");
	player braxi\_rank::giveRankXP("", 20);
	object notSolid();
}

trap9()
{
	trigger = getEnt ( "trap9_trig", "targetname" );
	object = getEnt ( "trap9", "targetname" );
	kill = getEnt ( "trap9_kill", "targetname" );
	trap9_fx = getent("trap9_fx","targetname");
	
	kill maps\mp\_utility::triggeroff();
	object notSolid();
	object hide();
	
	trigger waittill ("trigger", player);
	playfx(level.acti_light,trap9_fx.origin);
	trigger SetHintString("^1Activated");
	player braxi\_rank::giveRankXP("", 20);
	object Solid();
	object show();
	kill maps\mp\_utility::triggeron();
}

trap10()
{
	trigger = getEnt ( "trap10_trig", "targetname" );
	kill = getEnt ( "trap_10kill", "targetname" );
	trap10_fx = getent("trap10_fx","targetname");
	g1 = getent("trap10g1","targetname");
	g2 = getent("trap10g2","targetname");
	g3 = getent("trap10g3","targetname");
	g4 = getent("trap10g4","targetname");
	g5 = getent("trap10g5","targetname");
	g6 = getent("trap10g6","targetname");
	kill maps\mp\_utility::triggeroff();
	
	trigger waittill ("trigger", player);
	playfx(level.acti_light,trap10_fx.origin);
	trigger SetHintString("^1Activated");
	player braxi\_rank::giveRankXP("", 20);
	kill maps\mp\_utility::triggeron();
	playfx(level.jewgas,g1.origin);
	playfx(level.jewgas,g2.origin);
	playfx(level.jewgas,g3.origin);
	wait 0.1;
	playfx(level.jewgas,g4.origin);
	playfx(level.jewgas,g5.origin);
	playfx(level.jewgas,g6.origin);
	wait 5;
	kill delete();
}

trap11()
{
	trigger = getEnt ( "trap11_trig", "targetname" );
	object = getEnt ( "trap11", "targetname" );
	trap11_fx = getent("trap11_fx","targetname");
	trigger waittill ("trigger", player);
	playfx(level.acti_light,trap11_fx.origin);
	trigger SetHintString("^1Activated");
	player braxi\_rank::giveRankXP("", 20);
	object movez(152,1);
}

startdoor()
{
	object = getent("startdoor","targetname");
	i = randomintrange( 0, 3 );
	if(i == 0)
	{
		ambientplay("towers1");
		wait 15;
		object movez(144,4);
	}
	else if(i == 1)
	{
		ambientplay("towers2");
		wait 15;
		object movez(144,4);
	}
	else if(i == 2)
	{
		ambientplay("towers3");
		wait 15;
		object movez(144,4);
	}
}

final_plat()
{
	trigger = getEnt ("trig_final_plat","targetname");
	mover = getEnt ("final_plat", "targetname");
	trigger waittill ("trigger", player);
	player braxi\_rank::giveRankXP("", 20);
	wait 0.1;
	while(1)
	{
		mover moveTo ((-192,3264,-584),1,0.5);
		mover waittill ("movedone");
		mover rotateyaw (-90,1);
		mover waittill ("rotatedone");
		mover moveTo ((-192,3808,-728),1,0.5);
		mover waittill ("movedone");
		wait 2;
		mover moveTo ((-192,3264,-584),1,0.5);
		mover waittill ("movedone");
		mover rotateyaw (90,1);
		mover waittill ("rotatedone");
		mover moveTo ((480,3264,-584),1,0.5);
		mover waittill ("movedone");
		wait 2;
	}
}

createroomport(weapon,weapon2,freeze,where,health)
{
    self takeallweapons();
    self giveweapon(weapon);
    if(isdefined(weapon2))
    	self giveweapon(weapon2);
    self switchtoweapon(weapon);
 
    self freezecontrols(freeze);
    self setorigin(where.origin);
    self setplayerangles(where.angles);
 
    self.health=health;
}

countdown()
{
    self iprintlnbold("^53");
    wait 1;
    self iprintlnbold("^52");
    wait 1;
    self iprintlnbold("^51");
    wait 1;
    self iprintlnbold("^5Fight!");
    wait 1;
    self freezecontrols(0);
}

bounce_room_battle()
{
    level.bounce_trig=getent("bounceroom_ent","targetname");
 
    jump=getent("bounce_jt_go","targetname");
    acti=getent("bounce_at_go","targetname");
 
    while(1)
    {
       level.bounce_trig waittill("trigger",player);

	   // ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================
	   

	   thread bounce_fail();
	   thread bounceroom_gun();
		thread bounce_r7001();
		thread bounce_r7002();

        if(!isdefined(level.bounce_trig)) return;
 
        if(!isdefined(level.entertext)||!level.entertext)
        {
            level.entertext=true;
           
            ambientstop();
            ambientplay("shrike");
            level.canPlaySound=false;

            iprintln("^1Now playing: Crywolf - Shrike");
 
			level.sniper_trig delete();
			level.knife_trig delete();

            iprintlnbold("^5"+player.name+" ^7entered Bounce room.");
        }
 
        player createroomport("knife_mp","",1,jump,100);
        level.activ createroomport("knife_mp","",1,acti,100);
 
        player thread countdown();
        level.activ thread countdown();
 
       	while(isalive(player)&&isdefined(player))
            wait 1;

        iPrintlnBold("^1"+self.name+" ^5died^1!");
    }
}

bounce_fail()
{
        level.bouncefail = getent ("bounce_alltp","targetname");
        level.js = getent ("bounce_jt_go","targetname");
        level.as = getent ("bounce_at_go","targetname");
        while(1)
        {
                level.bouncefail waittill ("trigger",player);
                if( player.pers["team"] == "allies" )
                {
                        player SetPlayerAngles(level.js.angles);
                        player SetOrigin(level.js.origin);
                }
                else
                {
                        player SetPlayerAngles(level.as.angles);
                        player SetOrigin(level.as.origin);
                }
        }
}

bounceroom_gun()
{
	trigger = getEnt ( "bounceroom_gun", "targetname" );
	while(1)
    {
		trigger waittill ( "trigger", player );
		wait 0.05;
		player giveWeapon ( "remington700_mp" );
		player giveMaxAmmo ( "remington700_mp" );
		player switchToWeapon ( "remington700_mp" );
		wait 1;
	}
}

bounce_r7001()
{
	object = getEnt("bounce_r700","targetname");
	bouncering = getEnt ( "bouncering", "targetname" );
	playfx(level.ring,bouncering.origin);
	while(1)
	{
		object rotateyaw(720,6);
		object waittill ("rotatedone");
	}
}
bounce_r7002()
{
	object = getEnt("bounce_r700","targetname");
	object movez(4,1.5);
	while(1)
	{
		object movez(-8,1.5);
		object waittill ("movedone");
		object movez(8,1.5);
		object waittill ("movedone");
	}
}

sniper_room_battle()
{
    level.sniper_trig=getent("sniproom_ent","targetname");
 
    jump=getent("sniproom_go","targetname");
    acti=getent("sniproom_acti","targetname");
 
    while(1)
    {
       level.sniper_trig waittill("trigger",player);

	   // ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================
	   
	   
	   thread snip_fail();


        if(!isdefined(level.sniper_trig)) return;
 
        if(!isdefined(level.entertext)||!level.entertext)
        {
            level.entertext=true;
           
            ambientstop();
            ambientplay("breath");
            level.canPlaySound=false;

            iprintln("^1Now playing: Pluto x ye. - Breath");
 
			level.knife_trig delete();
			level.bounce_trig delete();

            iprintlnbold("^5"+player.name+" ^7entered Sniper room.");
        }
 
        player createroomport("remington700_mp","m40a3_mp",1,jump,100);
        level.activ createroomport("remington700_mp","m40a3_mp",1,acti,100);
 
        player thread countdown2();
        level.activ thread countdown2();
 
       	while(isalive(player)&&isdefined(player))
            wait 1;

        iPrintlnBold("^1"+self.name+" ^5died^1!");
    }
}
countdown2()
{
	wait 8;
    self iprintlnbold("^53");
    wait 1;
    self iprintlnbold("^52");
    wait 1;
    self iprintlnbold("^51");
    wait 1;
    self iprintlnbold("^5Fight!");
    wait 1;
    self freezecontrols(0);
}
snip_fail()
{
	trig = getEnt ("snip_alltp", "targetname");
	end = getEnt ("snip_alltp_go", "targetname");
	while(1)
    {
        trig waittill ("trigger", player);
		player freezecontrols(true);
		iprintlnbold("^5"+player.name+" is freezed middle of the sniper room");
		player SetOrigin(end.origin);
        player SetPlayerAngles( end.angles );
	}
}

knife_room_battle()
{
    level.knife_trig=getent("kniferoom_ent","targetname");
 
    jump=getent("kniferoom_go","targetname");
    acti=getent("kniferoom_acti","targetname");
 
    while(1)
    {
       level.knife_trig waittill("trigger",player);

	   // ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================
	   
				
        if(!isdefined(level.knife_trig)) return;
 
        if(!isdefined(level.entertext)||!level.entertext)
        {
            level.entertext=true;
           
            ambientstop();
            ambientplay("ready");
            level.canPlaySound=false;

            iprintln("^1Now playing: WiDE AWAKE - Ready");
 
			level.sniper_trig delete();
			level.bounce_trig delete();

            iprintlnbold("^5"+player.name+" ^7entered Knife room.");
        }
 
        player createroomport("knife_mp","tomahawk_mp",1,jump,100);
        level.activ createroomport("knife_mp","tomahawk_mp",1,acti,100);
 
        player thread countdown();
        level.activ thread countdown();
 
       	while(isalive(player)&&isdefined(player))
            wait 1;

        iPrintlnBold("^1"+self.name+" ^5died^1!");
    }
}

actis_fail()
{
	trig = getEnt ("actis_fail", "targetname");
	end = getEnt ("actis_fail_go", "targetname");
	while(1)
    {
        trig waittill ("trigger", player);          
		player SetOrigin(end.origin);
        player SetPlayerAngles( end.angles );
	}
}

actibousetup()
{
	trigger = getEnt ( "actibousetup", "targetname" );
	object = getEnt ( "actibou", "targetname" );
	object hide();
	trigger waittill ("trigger", player );
	object show();
	thread acti_chest();
}

acti_chest()
{
	trigger = getEnt ( "acti_chest_trig", "targetname" );
	object = getEnt ( "acti_chest", "targetname" );
	trigger waittill ("trigger", player );
	player braxi\_rank::giveRankXP("", 100);
	iprintlnbold("^5Activator found the secret chest!");
	object rotateroll (-120,2);
	trigger SetHintString("^5 Now jump down and get back to the acti track");
}

acti_tele1()
{
	trig = getEnt ("acti_tele1", "targetname");
	end = getEnt ("acti_tele1_go", "targetname");
	while(1)
    	{
        trig waittill ("trigger", player);          
	player SetOrigin(end.origin);
        player SetPlayerAngles( end.angles );
	}

}

	acti_tele1back()
{
	trig = getEnt ("acti_tele1back", "targetname");
	end = getEnt ("acti_tele1back_go", "targetname");
	while(1)
    	{
        trig waittill ("trigger", player);          
	player SetOrigin(end.origin);
        player SetPlayerAngles( end.angles );
	}

}

acti_ele()
{
	trigger = getEnt ( "acti_ele_trig", "targetname" );
	object = getEnt ( "acti_ele", "targetname" );
	while(1)
	{
		trigger waittill ("trigger", player );
		trigger maps\mp\_utility::triggeroff();
		object movez (712,1,0.5);
		object waittill ("movedone");
		wait 3;
		object movez (-712,0.5);
		object waittill ("movedone");
		trigger maps\mp\_utility::triggeron();
	}
}

secret_wep()
{
	trig = getEnt ("secret_gun", "targetname");
	end = getEnt ("secret_gun_go", "targetname");
	s_flare = getEnt ("secret_flare", "targetname");
	while(1)
    	{
        trig waittill ("trigger", player);
		playfx(level.flare,s_flare.origin);
		wait 0.05;
		player giveWeapon ( "remington700_mp" );
		player giveMaxAmmo ( "remington700_mp" );
		player switchToWeapon ( "remington700_mp" );
		wait 1;
		player SetOrigin(end.origin);
        player SetPlayerAngles( end.angles );
	}

}

snipmodel_mover()
{
	object = getEnt ("snipmodel_mover", "targetname");
	while(1)
	{
		object movez (-24,4);
		object waittill ("movedone");
		object movez (24,4);
		object waittill ("movedone");
	}
}
bouncemodel_mover()
{
	object = getEnt ("bouncemodel_mover", "targetname");
	while(1)
	{
		object movez (-24,4);
		object waittill ("movedone");
		object movez (24,4);
		object waittill ("movedone");
	}
}
knifemodel_mover()
{
	object = getEnt ("knifemodel_mover", "targetname");
	while(1)
	{
		object movez (-24,4);
		object waittill ("movedone");
		object movez (24,4);
		object waittill ("movedone");
	}
}

endmap_trig()
{
	trigger = getEnt ("endmap_trig","targetname");
	trigger waittill ("trigger", player);
	iPrintlnBold ("^3"+player.name+" ^5Finished First!");
	player braxi\_rank::giveRankXP("", 20);
}

creators()
{
	wait 9;
	iPrintlnBold("^7Map by ^5TheLixfe");
	wait 2;
	iprintln("^7Thanks to ^5Vistic Clan");
	wait 15;
	iprintln("^6steam: TheLixfe");
	wait 5;
	iprintln("^7Map by ^5TheLixfe");
}