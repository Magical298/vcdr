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

	Mapper: VC' Blade
    Website: vistic-clan.net

    !DO NOT USE WITHOUT PERMISSIONS!
*/

main()
{	
	maps\mp\_load::main();
	
	game["allies"] = "sas";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "woodland";
	game["axis_soldiertype"] = "woodland";
	
	// Dvars
	setdvar("r_specularcolorscale","1");
	setdvar("r_glowbloomintensity0",".25");
	setdvar("r_glowbloomintensity1",".25");
	setdvar("r_glowskybleedintensity0",".3");

	setdvar("bg_falldamagemaxheight", 20000 );
	setdvar("bg_falldamageminheight", 15000 );

	level.dvar["time_limit"] = 7;

	// Precache
	precacheshader("deathrun");

	// Effects
	level.xm3_fx = [];
	level.xm3_fx["sparkles"] = loadfx("xm/xm_sparkles");
	level.xm3_fx["highlight"] = loadfx("xm/xm_highlight");

	// Global
	thread start_door();
	thread start_respawn();
	thread xm3_sign();
	thread xm3_letters();
	thread acti_room_msg();

	// Traps
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
	thread trap12();
	thread trap13();
	thread trap14();
	thread trap15();
	thread trap16();

	// Activator
	thread acti_port1();
	thread acti_port2();
	thread acti_port3();
	thread acti_port4();
	thread acti_port5();
	thread acti_port6();
	thread acti_port7();
	thread acti_room();
	thread acti_room_fail1();
	thread acti_room_fail2();
	thread acti_room_exit();

	// Secret
	thread easy_enter();
	thread easy_exit();
	thread easy_fail1();
	thread easy_fail2();
	thread hard_enter();
	thread hard_exit();
	thread hard_fail1();
	thread hard_fail2();
	thread hard_fail3();
	thread hard_fail4();
	thread hard_fail5();

	// Rooms
	thread room_selection();
	thread sniper_room();
	thread knife_room();
	thread bounce_room();
	thread simon_room();

	// Free Run Triggers
	addTriggerToList( "trap1_trig" );
	addTriggerToList( "trap2_trig" );
	addTriggerToList( "trap3_trig" );
	addTriggerToList( "trap4_trig" );
	addTriggerToList( "trap5_trig" );
	addTriggerToList( "trap6_trig" );
	addTriggerToList( "trap7_trig" );
	addTriggerToList( "trap8_trig" );
	addTriggerToList( "trap9_trig" );
	addTriggerToList( "trap10_trig" );
	addTriggerToList( "trap11_trig" );
	addTriggerToList( "trap12_trig" );
	addTriggerToList( "trap13_trig" );
	addTriggerToList( "trap14_trig" );
	addTriggerToList( "trap15_trig" );
	addTriggerToList( "trap16_trig" );

	wait 2;

	sparkles = getentarray("xm_sparkles","targetname");
	for(i=0;i<sparkles.size;i++)
		playfx(level.xm3_fx["sparkles"],sparkles[i].origin);

	highlight = getentarray("xm_start_fx","targetname");
	for(i=0;i<highlight.size;i++)
		playfx(level.xm3_fx["highlight"],highlight[i].origin);
}

addTriggerToList( name )
{
    if( !isDefined( level.trapTriggers ) )
        level.trapTriggers = [];
    level.trapTriggers[level.trapTriggers.size] = getEnt( name, "targetname" );
}

start_door()
{
	trig = getent("start_door_trig","targetname");
	door = getent("start_door","targetname");

	trig sethintstring("^7Press ^2[^7&&1^2]^7 to select a ^2[^7Song^2] ^7to open the ^2[^7Start Door^2]");
	trig waittill("trigger",who);
	trig delete();

	who thread music_menu();

	level waittill("xm_music_selected");
	iprintlnbold("^2[^7Start Door^2]^7 has opened");
	door delete();
}

music_menu()
{
	self freezecontrols(1);

	self.music_titles = music_hud(3,"center","middle",1,0,-30,1.8,"objective",1,(0,1,0));
	self.music_titles settext("Nightcore - Infected\nGateway - Drug\nillenium - it's all on u\nLink Park - Numb\nTristam Braken - Flight\nYoung London - Broken");

	self.music_selector = music_hud(2,"center","middle",1,0,-30,undefined,undefined,undefined,undefined);
	self.music_selector setshader("white",320,20);
	self.music_selector.color = (0,1,0);

	self.music_background = music_hud(1,"center","middle",0.8,0,24,undefined,undefined,undefined,undefined);
	self.music_background setshader("deathrun",330,150);

	count = 1;
	self.selecting_music = true;
	wait .5;
	while(self.selecting_music == true)
	{
		if(self attackbuttonpressed())
		{
			count += 1;
			if(count < 7)
				self.music_selector.y += 22;
			else if(count >= 7)
			{
				count = 1;
				self.music_selector.y = -30;
			}
		}

		if(self usebuttonpressed())
		{
			ambientplay("xm_music_"+count);
			level notify("xm_music_selected");

			self.selecting_music = false;
		}
		wait .1;
	}

	self freezecontrols(0);

	self.music_titles destroy();
	self.music_selector destroy();
	self.music_background destroy();
}

music_hud(sort,alignx,aligny,alpha,x,y,fontscale,font,galpha,gcolor)
{
	hud = newclienthudelem(self);
	hud.sort = sort;
	hud.alignx = alignx;
	hud.aligny = aligny;
	hud.horzalign = alignx;
	hud.vertalign = aligny;
	hud.alpha = alpha;
	hud.x = x;
	hud.y = y;

	if(isdefined(galpha))
	{
		hud.glowalpha = galpha;
		hud.glowcolor = gcolor;
	}

	if(isdefined(fontscale))
		hud.fontscale = fontscale;

	if(isdefined(font))
		hud.font = font;

	return hud;
}

start_respawn()
{
	trig = getent("start_respawn","targetname");
	targ = getent("start_respawn_targ","targetname");

	for(;;)
	{
		trig waittill("trigger",who);
		who thread teleport_init(targ);
	}
}

xm3_sign()
{
	xm3 = getent("xm3","targetname");
	xm3_sign = getent("xm3_sign","targetname");

	while(isdefined(xm3))
	{
		xm3_sign rotateyaw(-360,5);
		xm3 rotateyaw(360,5);
		wait 5;
	}
}

xm3_letters()
{
	x = getent("xm_letters","targetname");
	m = getent("xm_chicken","targetname"); 
	d = getent("xm_melon","targetname");
	xm3_door = getent("secret_wall","targetname");

	x waittill("trigger");
	iprintln("x");
	m waittill("trigger");
	iprintln("M");
	d waittill("trigger");
	iprintln("3");

	x delete();
	m delete();
	d delete();

	wait 2;

	iprintlnbold("Secret Entrance opened");
	xm3_door delete();
}

acti_room_msg()
{
	level waittill( "activator", player );
	player thread do_message();
}

do_message()
{
	if(isdefined(self.acti_room_msg))
		self.acti_room_msg destroy();

    self.acti_room_msg = newclienthudElem(self);	
	self.acti_room_msg.x = 0;	
	self.acti_room_msg.y = -220;	
	self.acti_room_msg.horzAlign = "center";	
	self.acti_room_msg.vertAlign = "bottom";
	self.acti_room_msg.alignX = "center";
	self.acti_room_msg.alignY = "bottom";
	self.acti_room_msg.font = "objective";
	self.acti_room_msg.sort = 102;	
	self.acti_room_msg.alpha = 1;	
	self.acti_room_msg.fontScale = 1.6; // Change Size from 1.4 - 3
	self.acti_room_msg settext("Turn around to enter the Activator Fun Room\n(Located in Activator Spawn)"); // Change Message to whatever you want

	wait 10;

	if(isdefined(self.acti_room_msg))
		self.acti_room_msg destroy();
}

// Traps
trap1()
{
	trig = getent("trap1_trig","targetname");
	trap = getent("trap1","targetname");

	trig sethintstring("^7Press ^2[^7&&1^2] ^7to ^2[^7activate^2]^7!");
	trig waittill("trigger");
	trig delete();

	while(isdefined(trap))
	{
		trap notsolid();
		trap hide();
		wait 5;
		trap show();
		trap solid();
		wait 5;
	}
}

trap2()
{
	trig = getent("trap2_trig","targetname");
	trapa = getent("trap2a","targetname");
	trapb = getent("trap2b","targetname");

	trig sethintstring("^7Press ^2[^7&&1^2] ^7to ^2[^7activate^2]^7!");
	trig waittill("trigger");
	trig delete();

	while(isdefined(trapa) && isdefined(trapb))
	{
		trapa rotatepitch(360,3);
		trapb rotateroll(-360,3);
		wait 3;
	}
}

trap3()
{
	trig = getent("trap3_trig","targetname");
	trap = getent("trap3","targetname");
	hurt = getent("trap3_hurt","targetname");

	trig sethintstring("^7Press ^2[^7&&1^2] ^7to ^2[^7activate^2]^7!");
	trig waittill("trigger");
	trig delete();

	hurt enablelinkto();
	hurt linkto(trap);

	while(isdefined(trap))
	{
		trap rotateroll(360,4);
		wait 4;
	}
}

trap4()
{
	trig = getent("trap4_trig","targetname");
	trap = getent("trap4","targetname");
	hurt = getent("trap4_hurt","targetname");

	trig sethintstring("^7Press ^2[^7&&1^2] ^7to ^2[^7activate^2]^7!");
	trig waittill("trigger");
	trig delete();

	hurt enablelinkto();
	hurt linkto(trap);

	trap movex(-400,4);
	wait 5;
	trap movez(-200,2);
	wait 2;
	trap delete(); 
}

trap5()
{
	trig = getent("trap5_trig","targetname");
	trapa = getent("trap5a","targetname");
	trapb = getent("trap5b","targetname");

	trig sethintstring("^7Press ^2[^7&&1^2] ^7to ^2[^7activate^2]^7!");
	trig waittill("trigger");
	trig delete();

	while(isdefined(trapa) && isdefined(trapb))
	{
		trapa rotateRoll(120,1,.5);
		trapb rotateRoll(-120,1,.5);
		wait 1;
		trapa rotateRoll(-120,1,.5);
		trapb rotateRoll(120,1,.5);
		wait 1;
	}
}

trap6()
{
	trig = getent("trap6_trig","targetname");
	trap = getent("trap6","targetname");

	trig sethintstring("^7Press ^2[^7&&1^2] ^7to ^2[^7activate^2]^7!");
	trig waittill("trigger");
	trig delete();

	while(isdefined(trap))
	{
		trap hide();
		trap notsolid();
		wait 5;
		trap show();
		trap solid();
		wait 5;
	}
}

trap7()
{
	trig = getent("trap7_trig","targetname");
	trapa = getent("trap7a","targetname");
	trapb = getent("trap7b","targetname");

	trig sethintstring("^7Press ^2[^7&&1^2] ^7to ^2[^7activate^2]^7!");
	trig waittill("trigger");
	trig delete();

	trapa rotateyaw(180,2);
	trapb rotateyaw(-180,2);
	wait 3;
	trapa movez(80,1);
	trapb movez(80,1);
}

trap8()
{
	trig = getent("trap8_trig","targetname");
	trap = getent("trap8","targetname");

	trig sethintstring("^7Press ^2[^7&&1^2] ^7to ^2[^7activate^2]^7!");
	trig waittill("trigger");
	trig delete();

	while(isdefined(trap))
	{
		trap rotateyaw(360,2);
		wait 3;
		trap rotateyaw(-360,2);
		wait 3;
	}
}

trap9()
{
	trig = getent("trap9_trig","targetname");
	trap = getent("trap9","targetname");

	trig sethintstring("^7Press ^2[^7&&1^2] ^7to ^2[^7activate^2]^7!");
	trig waittill("trigger");
	trig delete();

	way = undefined;
	xm = randomint(2);
	if(xm == 1)
		way = 360;
	else 
		way = -360;

	while(isdefined(trap))
	{
		trap rotateroll(way,4);
		wait 6;
	}
}

trap10()
{
	trig = getent("trap10_trig","targetname");
	trap = getent("trap10","targetname");

	trig sethintstring("^7Press ^2[^7&&1^2] ^7to ^2[^7activate^2]^7!");
	trig waittill("trigger");
	trig delete();

	while(isdefined(trap))
	{
		trap hide();
		trap notsolid();
		wait 5;
		trap show();
		trap solid();
		wait 5;
	}
}

trap11()
{
	trig = getent("trap11_trig","targetname");
	trapa = getent("trap11a","targetname");
	trapb = getent("trap11b","targetname");

	trig sethintstring("^7Press ^2[^7&&1^2] ^7to ^2[^7activate^2]^7!");
	trig waittill("trigger");
	trig delete();

	xm = randomint(2);
	if(xm == 1)
		trapa delete();
	else 
		trapb delete();
}

trap12()
{
	trig = getent("trap12_trig","targetname");
	trapa = getent("trap12a","targetname");
	trapb = getent("trap12b","targetname");
	trapc = getent("trap12c","targetname");

	trig sethintstring("^7Press ^2[^7&&1^2] ^7to ^2[^7activate^2]^7!");
	trig waittill("trigger");
	trig delete();

	trapa thread trap12_rotate(360,3);
	trapb thread trap12_rotate(-360,3);
	trapc thread trap12_rotate(360,3);
}

trap12_rotate(num,time)
{
	while(isdefined(self))
	{
		self rotateyaw(num,time);
		wait time;
	}
}

trap13()
{
	trig = getent("trap13_trig","targetname");
	trapa = getent("trap13a","targetname");
	trapb = getent("trap13b","targetname");
	trapc = getent("trap13c","targetname");

	trig sethintstring("^7Press ^2[^7&&1^2] ^7to ^2[^7activate^2]^7!");
	trig waittill("trigger");
	trig delete();

	xm = randomint(3);
	if(xm == 2)
		trapa delete();
	else if(xm == 1)
		trapb delete();
	else 
		trapc delete();
}

trap14()
{
	trig = getent("trap14_trig","targetname");
	trapa = getent("trap14a","targetname");
	trapb = getent("trap14b","targetname");

	trig sethintstring("^7Press ^2[^7&&1^2] ^7to ^2[^7activate^2]^7!");
	trig waittill("trigger");
	trig delete();

	xm = randomint(2);
	if(xm == 1)
		trapa delete();
	else 
		trapb delete();
}

trap15()
{
	trig = getent("trap15_trig","targetname");
	trapa = getent("trap15a","targetname");
	trapb = getent("trap15b","targetname");

	trig sethintstring("^7Press ^2[^7&&1^2] ^7to ^2[^7activate^2]^7!");
	trig waittill("trigger");
	trig delete();

	xm = randomint(2);
	if(xm == 1)
		trapa delete();
	else 
		trapb delete();
}

trap16()
{
	trig = getent("trap16_trig","targetname");
	trap = getent("trap16","targetname");

	trig sethintstring("^7Press ^2[^7&&1^2] ^7to ^2[^7activate^2]^7!");
	trig waittill("trigger");
	trig delete();

	while(isdefined(trap))
	{
		trap hide();
		trap notsolid();
		wait 5;
		trap show();
		trap solid();
		wait 5;
	}
}

// Activator
acti_port1()
{
	trig = getent("acti_port_1","targetname");
	targ = getent("acti_targ_1","targetname");

	for(;;)
	{
		trig sethintstring("^7Press ^2[^7&&1^2] ^7to ^2[^7teleport^2]^7!");
		trig waittill("trigger",who);
		who setorigin(targ.origin);
		who setplayerangles(targ.angles);
		who freezecontrols(1);
		wait .5;
		who freezecontrols(0);
	}
}

acti_port2()
{
	trig = getent("acti_port_2","targetname");
	targ = getent("acti_targ_2","targetname");

	for(;;)
	{
		trig sethintstring("^7Press ^2[^7&&1^2] ^7to ^2[^7teleport^2]^7!");
		trig waittill("trigger",who);
		who setorigin(targ.origin);
		who setplayerangles(targ.angles);
		who freezecontrols(1);
		wait .5;
		who freezecontrols(0);
	}
}

acti_port3()
{
	trig = getent("acti_port_3","targetname");
	targ = getent("acti_targ_3","targetname");

	for(;;)
	{
		trig sethintstring("^7Press ^2[^7&&1^2] ^7to ^2[^7teleport^2]^7!");
		trig waittill("trigger",who);
		who setorigin(targ.origin);
		who setplayerangles(targ.angles);
		who freezecontrols(1);
		wait .5;
		who freezecontrols(0);
	}
}

acti_port4()
{
	trig = getent("acti_port_4","targetname");
	targ = getent("acti_targ_4","targetname");

	for(;;)
	{
		trig sethintstring("^7Press ^2[^7&&1^2] ^7to ^2[^7teleport^2]^7!");
		trig waittill("trigger",who);
		who setorigin(targ.origin);
		who setplayerangles(targ.angles);
		who freezecontrols(1);
		wait .5;
		who freezecontrols(0);
	}
}

acti_port5()
{
	trig = getent("acti_port_5","targetname");
	targ = getent("acti_targ_5","targetname");

	for(;;)
	{
		trig sethintstring("^7Press ^2[^7&&1^2] ^7to ^2[^7teleport^2]^7!");
		trig waittill("trigger",who);
		who setorigin(targ.origin);
		who setplayerangles(targ.angles);
		who freezecontrols(1);
		wait .5;
		who freezecontrols(0);
	}
}

acti_port6()
{
	trig = getent("acti_port_6","targetname");
	targ = getent("acti_targ_6","targetname");

	for(;;)
	{
		trig sethintstring("^7Press ^2[^7&&1^2] ^7to ^2[^7teleport^2]^7!");
		trig waittill("trigger",who);
		who setorigin(targ.origin);
		who setplayerangles(targ.angles);
		who freezecontrols(1);
		wait .5;
		who freezecontrols(0);
	}
}

acti_port7()
{
	trig = getent("acti_port_7","targetname");
	targ = getent("acti_targ_7","targetname");

	for(;;)
	{
		trig sethintstring("^7Press ^2[^7&&1^2] ^7to ^2[^7teleport^2]^7!");
		trig waittill("trigger",who);
		who setorigin(targ.origin);
		who setplayerangles(targ.angles);
		who freezecontrols(1);
		wait .5;
		who freezecontrols(0);
	}
}

acti_room()
{
	trig = getent("acti_room","targetname");
	targ = getent("acti_room_targ1","targetname");

	for(;;)
	{
		trig sethintstring("^7Press ^2[^7&&1^2] ^7to ^2[^7teleport^2] to Activator Fun Room^7!");
		trig waittill("trigger",who);
		who setorigin(targ.origin);
		who setplayerangles(targ.angles);
		who freezecontrols(1);
		wait .5;
		who freezecontrols(0);
	}
}

acti_room_fail1()
{
	trig = getent("acti_room_fail1","targetname");
	targ = getent("acti_room_targ1","targetname");

	for(;;)
	{
		trig waittill("trigger",who);
		who setorigin(targ.origin);
		who setplayerangles(targ.angles);
		who freezecontrols(1);
		wait .5;
		who freezecontrols(0);
	}
}

acti_room_fail2()
{
	trig = getent("acti_room_fail2","targetname");
	targ = getent("acti_room_targ2","targetname");

	for(;;)
	{
		trig waittill("trigger",who);
		who setorigin(targ.origin);
		who setplayerangles(targ.angles);
		who freezecontrols(1);
		wait .5;
		who freezecontrols(0);
	}
}

acti_room_exit()
{
	trig = getent("acti_room_exit","targetname");
	targ = getent("acti_targ_7","targetname");

	for(;;)
	{
		trig waittill("trigger",who);
		who iprintlnbold("You have finished the ^2[^7Activator Fun Room^2]");
		who setorigin(targ.origin);
		who setplayerangles(targ.angles);
		who freezecontrols(1);
		wait .5;
		who freezecontrols(0);
	}
}

// Secret
easy_enter()
{
	trig = getent("easy_enter","targetname");
	targ = getent("easy_target_1","targetname");

	for(;;)
	{
		trig waittill("trigger",who);
		who thread teleport_init(targ);
	}
}

easy_exit()
{
	trig = getent("easy_exit","targetname");
	targ = getent("easy_exit_targ","targetname");

	for(;;)
	{
		trig waittill("trigger",who);
		who thread teleport_init(targ);

		if(!isdefined(level.xm3_easy_finished))
		{
			level.xm3_easy_finished = true;
			iprintlnbold("^2[^7"+who.name+"^2] ^7finished the ^2[^7Easy Secret^2]^7 first!");

			who braxi\_rank::giverankxp(undefined,200);
		}
		else 
			iprintlnbold("^2[^7"+who.name+"^2] ^7finished the ^2[^7Easy Secret^2]");
	}
}

easy_fail1()
{
	trig = getent("easy_respawn_1","targetname");
	targ = getent("easy_target_1","targetname");

	for(;;)
	{
		trig waittill("trigger",who);
		who thread teleport_init(targ);
	}
}

easy_fail2()
{
	trig = getent("easy_respawn_2","targetname");
	targ = getent("easy_target_2","targetname");

	for(;;)
	{
		trig waittill("trigger",who);
		who thread teleport_init(targ);
	}
}

hard_enter()
{
	trig = getent("hard_enter","targetname");
	targ = getent("hard_target_1","targetname");

	for(;;)
	{
		trig waittill("trigger",who);
		who thread teleport_init(targ);
	}
}

hard_exit()
{
	trig = getent("hard_exit","targetname");
	targ = getent("hard_exit_targ","targetname");

	for(;;)
	{
		trig waittill("trigger",who);
		who thread teleport_init(targ);

		if(!isdefined(level.xm3_hard_finished))
		{
			level.xm3_hard_finished = true;
			iprintlnbold("^2[^7"+who.name+"^2] ^7finished the ^2[^7Hard Secret^2]^7 first!");

			who braxi\_rank::giverankxp(undefined,400);
		}
		else 
			iprintlnbold("^2[^7"+who.name+"^2] ^7finished the ^2[^7Hard Secret^2]");
	}
}

hard_fail1()
{
	trig = getent("hard_respawn_1","targetname");
	targ = getent("hard_target_1","targetname");

	for(;;)
	{
		trig waittill("trigger",who);
		who thread teleport_init(targ);
	}
}

hard_fail2()
{
	trig = getent("hard_respawn_2","targetname");
	targ = getent("hard_target_2","targetname");

	for(;;)
	{
		trig waittill("trigger",who);
		who thread teleport_init(targ);
	}
}

hard_fail3()
{
	trig = getent("hard_respawn_3","targetname");
	targ = getent("hard_target_3","targetname");

	for(;;)
	{
		trig waittill("trigger",who);
		who thread teleport_init(targ);
	}
}

hard_fail4()
{
	trig = getent("hard_respawn_4","targetname");
	targ = getent("hard_target_4","targetname");

	for(;;)
	{
		trig waittill("trigger",who);
		who thread teleport_init(targ);
	}
}

hard_fail5()
{
	trig = getent("hard_respawn_5","targetname");
	targ = getent("hard_target_5","targetname");

	for(;;)
	{
		trig waittill("trigger",who);
		who thread teleport_init(targ);
	}
}

// Rooms
room_selection()
{
	trig = getent("room_selection","targetname");
	targ = getent("room_selection_targ","targetname");

	while(1)
	{
		trig sethintstring("^7Press ^2[^7&&1^2] ^7to enter ^2[^7Room Selection^2]^7!");
		trig waittill("trigger",player);

		if(!isdefined(trig))
			return;

		 // ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================

        player takeallweapons();
        player thread teleport_init(targ);

        while(isalive(player) && isdefined(player))
			wait .05;

		if(isdefined(level.simon_started) && level.simon_started)
			level.simon_started = false;

		iprintlnbold("^2[^7"+player.name+"^2]^7 has died!");
	}
}

sniper_room()
{
	level.sniper = getent("sniper_room","targetname");
	jump = getent("jump_sniper","targetname");
	acti = getent("acti_sniper","targetname");

	thread sniper_push();
	thread sniper_fail();

	while(1)
	{
		level.sniper sethintstring("^7Press ^2[^7&&1^2] ^7for ^2[^7Sniper Room^2]^7!");
		level.sniper waittill("trigger",player);

		if(!isdefined(level.sniper))
			return;

		if(isdefined(level.activ) && isalive(level.activ))
		{
			player thread end_room_init(jump,"m40a3_mp","remington700_mp",1);
        	level.activ thread end_room_init(acti,"m40a3_mp","remington700_mp",1);

        	thread end_room_annouce("Sniper Room",level.activ.name + " ^1VS^7 " + player.name);

        	wait 5;

        	player freezecontrols(0);
			level.activ freezecontrols(0);
		}
		else 
		{
			player thread end_room_init(jump,"m40a3_mp","remington700_mp",1);
			wait 5;
        	player freezecontrols(0);
		}
	}
}

sniper_fail()
{
	trig = getent("snip_fail","targetname");
	jump = getent("jump_sniper","targetname");
	acti = getent("acti_sniper","targetname");

	for(;;)
	{
		trig waittill("trigger",who);
		if(who.pers["team"] != "spectator")
		{
			if(who.pers["team"] == "allies")
			{
				who setorigin(jump.origin);
				who setplayerangles(jump.angles);
			}
			else
			{
				who setorigin(acti.origin);
				who setplayerangles(acti.angles);
			}
		}
	}
}

sniper_push()
{
	thread sniper_push1();
	thread sniper_push2();
	thread sniper_push3();
	thread sniper_push4();
	thread sniper_push5();
	thread sniper_push6();
}

sniper_push1()
{
	trig = getent("snip_push1","targetname");

	while(isdefined(trig))
	{
		trig waittill("trigger",who);
		who thread push_up(130);
	}
}

sniper_push2()
{
	trig = getent("snip_push2","targetname");

	while(isdefined(trig))
	{
		trig waittill("trigger",who);
		who thread push_up(130);
	}
}

sniper_push3()
{
	trig = getent("snip_push3","targetname");

	while(isdefined(trig))
	{
		trig waittill("trigger",who);
		who thread push_up(130);
	}
}

sniper_push4()
{
	trig = getent("snip_push4","targetname");

	while(isdefined(trig))
	{
		trig waittill("trigger",who);
		who thread push_up(130);
	}
}

sniper_push5()
{
	trig = getent("snip_push5","targetname");

	while(isdefined(trig))
	{
		trig waittill("trigger",who);
		who thread push_up(130);
	}
}

sniper_push6()
{
	trig = getent("snip_push6","targetname");

	while(isdefined(trig))
	{
		trig waittill("trigger",who);
		who thread push_up(130);
	}
}

knife_room()
{
	level.knife = getent("knife_room","targetname");
	jump = getent("jump_knife","targetname");
	acti = getent("acti_knife","targetname");

	thread knife_push();

	while(1)
	{
		level.knife sethintstring("^7Press ^2[^7&&1^2] ^7for ^2[^7Knife Room^2]^7!");
		level.knife waittill("trigger",player);
		if(!isdefined(level.knife))
			return;

		if(isdefined(level.activ) && isalive(level.activ))
		{
			player thread end_room_init(jump,"knife_mp",undefined,1);
        	level.activ thread end_room_init(acti,"knife_mp",undefined,1);

        	thread end_room_annouce("Knife Room",level.activ.name + " ^1VS^7 " + player.name);

        	wait 5;

        	player freezecontrols(0);
			level.activ freezecontrols(0);
		}
		else 
		{
			player thread end_room_init(jump,"knife_mp",undefined,1);
			wait 5;
        	player freezecontrols(0);
		}
	}
}

knife_push()
{
	trig = getent("knife_push","targetname");

	while(isdefined(trig))
	{
		trig waittill("trigger",who);
		who thread push_up(270);
	}
}

bounce_room()
{
	level.bounce = getent("bounce_room","targetname");
	jump = getent("jump_bounce","targetname");
	acti = getent("acti_bounce","targetname");

	thread bounce_fail();
	thread bounce_weap();

	while(1)
	{
		level.bounce sethintstring("^7Press ^2[^7&&1^2] ^7for ^2[^7Bounce^2]^7!");
		level.bounce waittill("trigger",player);
		if(!isdefined(level.bounce))
			return;

		if(isdefined(level.activ) && isalive(level.activ))
		{
			player thread end_room_init(jump,"knife_mp",undefined,1);
        	level.activ thread end_room_init(acti,"knife_mp",undefined,1);

        	thread end_room_annouce("Bounce Room",level.activ.name + " ^1VS^7 " + player.name);

        	wait 5;

        	player freezecontrols(0);
			level.activ freezecontrols(0);
		}
		else 
		{
			player thread end_room_init(jump,"knife_mp",undefined,1);
			wait 5;
        	player freezecontrols(0);
		}
	}
}

bounce_fail()
{
	trig = getent("bounce_fail","targetname");
	jump = getent("jump_bounce","targetname");
	acti = getent("acti_bounce","targetname");

	for(;;)
	{
		trig waittill("trigger",who);
		if(who.pers["team"] != "spectator")
		{
			if(who.pers["team"] == "allies")
			{
				who setorigin(jump.origin);
				who setplayerangles(jump.angles);
			}
			else
			{
				who setorigin(acti.origin);
				who setplayerangles(acti.angles);
			}
		}
	}
}

bounce_weap()
{
	trig = getent("bounce_weap","targetname");

	for(;;)
	{
		trig waittill("trigger",who);
		if(!who hasweapon("remington700_mp"))
		{
			who giveweapon("remington700_mp");
			who givemaxammo("remington700_mp");
			who switchtoweapon("remington700_mp");
		}
	}
}

simon_room()
{
	level.simon = getent("simon_room","targetname");
	jump = getent("jump_simon","targetname");
	acti = getent("acti_simon","targetname");

	level.simon_started = false;

	while(1)
	{
		level.simon sethintstring("^7Press ^2[^7&&1^2] ^7for ^2[^7Simon Says Room^2]^7!");
		level.simon waittill("trigger",player);
		if(!isdefined(level.simon))
			return;

		level.simon_victim = player;

		if(isdefined(level.activ) && isalive(level.activ))
		{
			player thread end_room_init(jump,undefined,undefined,1);
        	level.activ thread end_room_init(acti,undefined,undefined,1);

        	thread end_room_annouce("Simon Says",level.activ.name + " ^1VS^7 " + player.name);

        	wait 5;

        	player freezecontrols(0);
			level.activ freezecontrols(0);
		}
		else 
		{
			player thread end_room_init(jump,undefined,undefined,1);
			wait 5;
        	player freezecontrols(0);
		}

		wait 3;
		thread simon_logic(player);
		thread simon_check();
	}
}

simon_logic(player)
{
	blue = getent("simon_1","targetname");
	brown = getent("simon_2","targetname");
	cyan = getent("simon_3","targetname");
	green = getent("simon_4","targetname");
	black = getent("simon_5","targetname");
	orange = getent("simon_6","targetname");
	yellow = getent("simon_7","targetname");
	red = getent("simon_8","targetname");
	purple = getent("simon_9","targetname");

	wall_blue = getent("simon_an1","targetname");
	wall_brown = getent("simon_an2","targetname");
	wall_cyan = getent("simon_an3","targetname");
	wall_green = getent("simon_an4","targetname");
	wall_black = getent("simon_an5","targetname");
	wall_orange = getent("simon_an6","targetname");
	wall_yellow = getent("simon_an7","targetname");
	wall_red = getent("simon_an8","targetname");
	wall_purple = getent("simon_an9","targetname");

	level.simon_started = true;
	rounds = 0;
	time = 3.5;

	to_hide = "";
	to_wall = "";

	while(level.simon_started)
	{
		wall_blue hide();
		wall_brown hide();
		wall_cyan hide();
		wall_green hide();
		wall_black hide();
		wall_orange hide();
		wall_yellow hide();
		wall_red hide();
		wall_purple hide();

		color = randomint(9);
		if( color == 0)
		{
			to_hide = blue;
			to_wall = wall_blue;
		}
		else if( color == 1)
		{
			to_hide = brown;
			to_wall = wall_brown;
		}
		else if( color == 2)
		{
			to_hide = cyan;
			to_wall = wall_cyan;
		}
		else if( color == 3)
		{
			to_hide = green;
			to_wall = wall_green;
		}
		else if( color == 4)
		{
			to_hide = black;
			to_wall = wall_black;
		}
		else if( color == 5)
		{
			to_hide = orange;
			to_wall = wall_orange;
		}
		else if( color == 6)
		{
			to_hide = yellow;
			to_wall = wall_yellow;
		}
		else if( color == 7)
		{
			to_hide = red;
			to_wall = wall_red;
		}
		else if( color == 8)
		{
			to_hide = purple;
			to_wall = wall_purple;
		}

		to_wall show();

		wait time;

		blue hide();
		brown hide();
		cyan hide();
		green hide();
		black hide();
		orange hide();
		yellow hide();
		red hide();
		purple hide();

		blue notsolid();
		brown notsolid();
		cyan notsolid();
		green notsolid();
		black notsolid();
		orange notsolid();
		yellow notsolid();
		red notsolid();
		purple notsolid();

		to_hide show();
		to_hide solid();
		to_wall show();

		wait 3;

		blue show();
		brown show();
		cyan show();
		green show();
		black show();
		orange show();
		yellow show();
		red show();
		purple show();

		blue solid();
		brown solid();
		cyan solid();
		green solid();
		black solid();
		orange solid();
		yellow solid();
		red solid();
		purple solid();

		rounds += 1;
		time -= 0.25;

		if(rounds == 14 && isalive(player))
		{
			winner = getent("ss_winner","targetname");
			loser = getent("ss_loser","targetname");
			iprintlnbold("Simon Says took too long to finish! Knifes given!");

			player giveweapon("knife_mp");
			player switchtoweapon("knife_mp");

			level.activ giveweapon("knife_mp");
			level.activ switchtoweapon("knife_mp");

			player thread teleport_init(winner);
			level.activ thread teleport_init(loser);

			level.simon_started = false;
		}
	}
}

simon_check(player)
{
	trig = getent("ss_fail","targetname");
	winner = getent("ss_winner","targetname");
	loser = getent("ss_loser","targetname");

	trig waittill("trigger",who);
	level.simon_started = false;

	if(who == level.simon_victim)
	{
		level.simon_victim freezecontrols(1);
		level.activ freezecontrols(1);

		level.simon_victim setorigin(loser.origin);
		level.simon_victim setplayerangles(loser.angles);

		level.activ setorigin(winner.origin);
		level.activ setplayerangles(winner.angles);

		level.simon_victim iprintlnbold("^2You ^7have ^1lost ^7against the Activator!");

		level.activ giveweapon("deserteagle_mp");
		level.activ switchtoweapon("deserteagle_mp");
		level.activ iprintlnbold("^1You Win! ^7now kill the ^1Jumper");

		wait 2.5;
		level.activ freezecontrols(0);
	}
	else if(who == level.activ)
	{
		level.simon_victim freezecontrols(1);
		level.activ freezecontrols(1);

		level.simon_victim setorigin(winner.origin);
		level.simon_victim setplayerangles(winner.angles);

		level.activ setorigin(loser.origin);
		level.activ setplayerangles(loser.angles);

		level.activ iprintlnbold("^2You ^7have ^1lost ^7against the Jumper!");

		level.simon_victim giveweapon("deserteagle_mp");
		level.simon_victim switchtoweapon("deserteagle_mp");
		level.simon_victim iprintlnbold("^1You Win! ^7now kill the ^1Activator");

		wait 2.5;
		level.simon_victim freezecontrols(0);
	}
}

push_up(num)
{
	for(i = 0; i < 4; i++) 
	{
		self.health += num;
		self finishPlayerDamage(self, level.jumpattacker, num, 0, "MOD_FALLING", "jump_mp", self.origin, AnglesToForward((-90,0,0)), "head", 0);
	}
}

end_room_init(targ,weap,weap2,freeze)
{
	self setorigin(targ.origin);
	self setplayerangles(targ.angles);

	self takeallweapons();
	if(isdefined(weap))
	{
		self giveweapon(weap);
		self givemaxammo(weap);
		self switchtoweapon(weap);
	}

	if(isdefined(weap2))
	{
		self giveweapon(weap2);
		self givemaxammo(weap2);
	}

	self freezecontrols(freeze);
}

end_room_annouce(room,text)
{
	noti = SpawnStruct();
	noti.titleText = room;
	noti.notifyText = text;
	noti.glowcolor = level.randomcolour;
	noti.duration = 4;
	
	players = getentarray("player", "classname");
	for(i=0;i<players.size;i++)
		players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
}

teleport_init(location)
{
	self setorigin(location.origin);
	self setplayerangles(location.angles);
	self freezecontrols(1);
	wait .5;
	self freezecontrols(0);
}