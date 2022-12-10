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
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["allies_soldiertype"] = "desert";
	game["axis_soldiertype"] = "desert";
	
	level.flare=loadfx("misc/flare_gun");
	level.doorflare=loadfx("misc/flare_end");
	level.explo=loadfx("explosions/aa2_explosion");
	level.ring=loadfx("misc/ui_pickup_available");
	level.carplode=loadfx("explosions/aa_explosion");
	
	if(!isdefined(level.firstDeath))
	level.firstDeath=false;
	
	addTriggerToList("trap1_trig");
	addTriggerToList("trap2_trig");
	addTriggerToList("trap3_trig");
	addTriggerToList("trap4_trig");
	addTriggerToList("trap5_trig");
	addTriggerToList("trap6_trig");
	addTriggerToList("trap7_trig");
	addTriggerToList("trap8_trig");
	
	if(!isdefined(level.music))
	level.music=[];
	level.music[0]["song"]    ="Our Last Night - Common Ground";
	level.music[0]["alias"]    ="cground";
	level.music[1]["song"]    ="Black Bear - IDFC";
	level.music[1]["alias"]    ="idfc";
	level.music[2]["song"]    ="Martin Garrix - Hold On And Believe";
	level.music[2]["alias"]    ="believe";
	level.music[3]["song"]    ="Steve Aoki - Back 2 U";
	level.music[3]["alias"]    ="back2u";
	level.music[4]["song"]    ="Disturbed - Stricken";
	level.music[4]["alias"]    ="stricken";
	thread musicBox();
 
	thread onPlayerKilled();
	
	thread doors();
	thread startdoor();
	thread sniper_room_battle();
	thread knife_room_battle();
	thread bounce_room_battle();
	thread secretwep();
	thread bouenter();
	thread trap1();
	thread trap2();
	thread trap3();
	thread trap4();
	thread trap5();
	thread trap6();
	thread trap7();
	thread trap8();
	thread old_room_battle();
	thread creators();
}
addTriggerToList(name)
{
    if(!isDefined(level.trapTriggers))
    level.trapTriggers=[];
    level.trapTriggers[level.trapTriggers.size]=getEnt(name,"targetname");
}

musicBox()
{
    trig=getent("musictrig","targetname");
    trig sethintstring("Press ^1&&1^7 to select Music");
    trig waittill("trigger",p);
    trig delete();
    
    p freezecontrols(1);
    p musicMenu();
}
musicMenu()
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "spawned" );
    self endon( "joined_spectators" );
    self endon( "music thread terminated" );
 
    self.hud_music = [];
    self.selection = 0;
 
    // create huds
    i = 0;
    self.hud_music[i] = braxi\_mod::addTextHud( self, 160, 200, 0.6, "left", "top", 2 );
    self.hud_music[i].sort = 879;
    self.hud_music[i] setShader( "black", 320, 160 );
    i++;
    self.hud_music[i] = braxi\_mod::addTextHud( self, 167, 204, 0.6, "left", "top", 1.4 );
    self.hud_music[i].sort = 880;
    self.hud_music[i] setShader( "white", 306, 20 );
    self.hud_music[i].color=(1,0,0);
    
    i++;
    self.hud_music[i] = braxi\_mod::addTextHud( self, 210, 204, 0.93, "left", "top", 1.8 );
    self.hud_music[i].sort = 884;
    self.hud_music[i] setText("Heaven's musicbox");
    self.hud_music[i].glowalpha=1;
    if(isdefined(level.randomcolor))
        self.hud_music[i].glowcolor=level.randomcolor;
    else 
        self.hud_music[i].glowcolor=(1,0,0);
    i++;
    self.hud_music[i] = braxi\_mod::addTextHud( self, 250, 360, 1, "center", "bottom", 1.4 );
    self.hud_music[i].sort = 886;
    self.hud_music[i] setText("Scroll: ^3[{+attack}] ^7| Select: ^3[{+activate}] ^7| Close: ^3[{+frag}]");
 
    for( j = 0; j < level.music.size; j++ )
    {
        i++;
        self.hud_music[i] = braxi\_mod::addTextHud( self, 172, 230+(j*16), 0.93, "left", "top", 1.4 );
        self.hud_music[i].sort = 882;
        self.hud_music[i].font = "objective";
        self.hud_music[i].glowalpha=1;
        if(isdefined(level.randomcolor))
            self.hud_music[i].glowcolor=level.randomcolor;
        else 
            self.hud_music[i].glowcolor=(1,0,0);
 
        entry = level.music[j];
        self.hud_music[i] setText(entry["song"]);
    }
 
    i++;
    self.hud_music[self.hud_music.size] = braxi\_mod::addTextHud( self, 167, 230, 0.4, "left", "top", 1.4 );
    self.hud_music[i].sort = 881;
    indicator = self.hud_music[self.hud_music.size-1];
    indicator setShader( "white", 306, 17 );
    indicator.color=(1,0,0);
 
    while(self.sessionstate == "playing")
    {
        wait 0.1;
 
        if(self attackButtonPressed())
        {
            self.hud_music[4+self.selection].alpha = 0.93;
 
            self.selection++;
            if( self.selection >= level.music.size )
                self.selection = 0;
 
            item = self.hud_music[4+self.selection];
            item.alpha = 1;
            indicator.y = item.y;
        }
        else if(self useButtonPressed())
        {
             iprintln("^1>> ^7Now playing: ^1"+level.music[self.selection]["song"]);
            ambientPlay(level.music[self.selection]["alias"]);
            self freezecontrols(0);
            break;
        }
        else if(self fragButtonPressed())
        {
            self freezecontrols(0);
            break;
        }
    }
    
    if(!isdefined(self))
        return;
    if(isdefined(self.hud_music))
    {
        for(i=0;i<self.hud_music.size;i++)
        {
            if(isdefined(self.hud_music[i]))
                self.hud_music[i] destroy();
        }
    }
    self notify( "music thread terminated" );
}

doors()
{
	trigger = getEnt ( "endmap_trig", "targetname" );
	triggerd1 = getEnt ( "door1_trig", "targetname" );
	triggerd2 = getEnt ( "door2_trig", "targetname" );
	triggerd3 = getEnt ( "door3_trig", "targetname" );
	triggerd4 = getEnt ( "door4_trig", "targetname" );
	triggerd5 = getEnt ( "door5_trig", "targetname" );
	triggerd6 = getEnt ( "door6_trig", "targetname" );
	triggerd7 = getEnt ( "door7_trig", "targetname" );
	trigger waittill ( "trigger", player );
	iPrintlnBold ("^3The doors are now unlocked");
	triggerd1 SetCursorHint("HINT_ACTIVATE");
	triggerd2 SetCursorHint("HINT_ACTIVATE");
	triggerd3 SetCursorHint("HINT_ACTIVATE");
	triggerd4 SetCursorHint("HINT_ACTIVATE");
	triggerd5 SetCursorHint("HINT_ACTIVATE");
	triggerd6 SetCursorHint("HINT_ACTIVATE");
	triggerd7 SetCursorHint("HINT_ACTIVATE");
	thread door_1();
	thread door_2();
	thread door_3();
	thread door_4();
	thread door_5();
	thread door_6();
	thread door_7();
	thread bounce_r7001();
	thread bounce_r7002();
}


onPlayerKilled()
{
	door3_flare = getEnt ( "door3_flare", "targetname" );
	level waittill("activator");
	wait .01;
	level waittill("player_killed",who);

	if(!level.firstDeath && who.pers["team"]=="allies")
	{
		level.firstDeath=true;
		iprintln("^1First blood");
		thread door_3();
		playfx(level.flare,door3_flare.origin);
	}
}

door_1()
{
	trigger = getEnt ( "door1_trig", "targetname" );
	door_1 = getEnt ( "door1", "targetname" );
	trigger waittill ( "trigger", player );
	trigger delete();
	door_1 rotateyaw(100,1);
}

door_2()
{
	trigger = getEnt ( "door2_trig", "targetname" );
	door_2 = getEnt ( "door2", "targetname" );
	trigger waittill ( "trigger", player );
	trigger delete();
	door_2 rotateyaw(100,1);
}

door_3()
{
	trigger = getEnt ( "door3_trig", "targetname" );
	door_3 = getEnt ( "door3", "targetname" );
	thread secret_enter();
	thread shf();
	thread shend();
	trigger waittill ( "trigger", player );
	trigger delete();
	door_3 rotateyaw(100,1);
}

door_4()
{
	trigger = getEnt ( "door4_trig", "targetname" );
	door_4 = getEnt ( "door4", "targetname" );
	trigger waittill ( "trigger", player );
	trigger delete();
	door_4 rotateyaw(100,1);
}

door_5()
{
	trigger = getEnt ( "door5_trig", "targetname" );
	door_5 = getEnt ( "door5", "targetname" );
	trigger waittill ( "trigger", player );
	trigger delete();
	door_5 rotateyaw(-120,1);
}

door_6()
{
	trigger = getEnt ( "door6_trig", "targetname" );
	door_6 = getEnt ( "door6", "targetname" );
	trigger waittill ( "trigger", player );
	trigger delete();
	door_6 rotateyaw(-100,1);
}

door_7()
{
	trigger = getEnt ( "door7_trig", "targetname" );
	door_7 = getEnt ( "door7", "targetname" );
	trigger waittill ( "trigger", player );
	trigger delete();
	door_7 rotateyaw(100,1);
}

startdoor()
{
	object = getent("startdoor","targetname");
	wait 20;
	iPrintlnBold ("^5The door is opening");
	object movex(156,4);
}

secret_enter()
{
	trig = getEnt ("she", "targetname");
	end = getEnt ("shf_go", "targetname");
	while(1)
    {
        trig waittill ("trigger", player);
		player iPrintlnBold ("^1You have 5 tries!");
		player.secretTries=0;
		player SetOrigin(end.origin);
        player SetPlayerAngles( end.angles );
	}
}

shf()
{
	trig=getent("shf","targetname");
	targ=getent("shf_go","targetname");

	for(;;)
	{
		trig waittill("trigger",player);
		if(player.secretTries<5)
		{
			player.secretTries++;
			player setorigin(targ.origin);
			player setplayerangles(targ.angles);
		}
		else 
		player suicide();
	}
}


shend()
{
	trig = getEnt ("shend", "targetname");
	end = getEnt ("shend_go", "targetname");
	while(1)
    {
        trig waittill ("trigger", player);
		player braxi\_rank::giveRankXP("", 100);
		player SetOrigin(end.origin);
        player SetPlayerAngles( end.angles );
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
    self iprintlnbold("^33");
    wait 1;
    self iprintlnbold("^32");
    wait 1;
    self iprintlnbold("^31");
    wait 1;
    self iprintlnbold("^5Fight!");
    wait 1;
    self freezecontrols(0);
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


        if(!isdefined(level.sniper_trig)) return;
 
        if(!isdefined(level.entertext)||!level.entertext)
        {
            level.entertext=true;
           
            ambientstop();
            ambientplay("losemind");
            level.canPlaySound=false;

            iprintln("^1Now playing: Brennan Heart & Wildstylez - Lose My Mind");
 
            level.old_trig delete();
			level.knife_trig delete();
			level.bounce_trig delete();

            iprintlnbold("^1"+player.name+" ^7entered Sniper room.");
        }
 
        player createroomport("remington700_mp","m40a3_mp",1,jump,100);
        level.activ createroomport("remington700_mp","m40a3_mp",1,acti,100);
 
        player thread countdown();
        level.activ thread countdown();
 
       	while(isalive(player)&&isdefined(player))
            wait 1;

        iPrintlnBold("^1"+self.name+" ^7died^1!");
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
            ambientplay("manneq");
            level.canPlaySound=false;

            iprintln("^1Now playing: Rae Sremmurd - Black Beatles");
 
            level.old_trig delete();
			level.sniper_trig delete();
			level.bounce_trig delete();

            iprintlnbold("^1"+player.name+" ^7entered Knife room.");
        }
 
        player createroomport("knife_mp","tomahawk_mp",1,jump,100);
        level.activ createroomport("knife_mp","tomahawk_mp",1,acti,100);
 
        player thread countdown();
        level.activ thread countdown();
 
       	while(isalive(player)&&isdefined(player))
            wait 1;

        iPrintlnBold("^1"+self.name+" ^7died^1!");
    }
}

bounce_room_battle()
{
    level.bounce_trig=getent("bounceroom_ent","targetname");
 
    jump=getent("bounce_jt_go","targetname");
    acti=getent("bounce_at_go","targetname");
 
    while(1)
    {
       level.bounce_trig waittill("trigger",player);

	   thread bounce_fail();
	   thread bounceroom_gun();

        if(!isdefined(level.bounce_trig)) return;

		// ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================
 
        if(!isdefined(level.entertext)||!level.entertext)
        {
            level.entertext=true;
           
            ambientstop();
            ambientplay("urmind");
            level.canPlaySound=false;

            iprintln("^1Now playing: Martin Garrix - Make Up Your Mind");
 
            level.old_trig delete();
			level.sniper_trig delete();
			level.knife_trig delete();

            iprintlnbold("^1"+player.name+" ^7entered Bounce room.");
        }
 
        player createroomport("knife_mp","",1,jump,100);
        level.activ createroomport("knife_mp","",1,acti,100);
 
        player thread countdown();
        level.activ thread countdown();
 
       	while(isalive(player)&&isdefined(player))
            wait 1;

        iPrintlnBold("^1"+self.name+" ^7died^1!");
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

secretwep()
{
	trig=getent("secretwep","targetname");
	for(;;)
	{
		trig waittill("trigger",who);
		who giveweapon("remington700_mp");
		who givemaxammo("remington700_mp");
		who switchtoweapon("remington700_mp");
		who thread jump_open();
		wait 1;
	}
}

jump_open()
{
	trigger = getEnt ( "bounceroom_trig", "targetname" );
	wall = getEnt ( "bounceroom_wall", "targetname" );
	ladder = getEnt ( "bounceroom_ladder", "targetname" );
	bounce_flare = getEnt ( "bounce_flare", "targetname" );
	trigger waittill("trigger",player);
	player braxi\_rank::giveRankXP("", 100);
	playfx(level.flare,bounce_flare.origin);
	wall notSolid();
	ladder movex(-32,1);
}

bouenter()
{
	trigger = getEnt ( "bounceroom_entertrig", "targetname" );
	wall = getEnt ( "bounceroom_wall", "targetname" );
	metal = getEnt ( "bounceroom_ladder_metal", "targetname" );
	wallfx = getEnt ( "bounce_wallfx", "targetname" );
	trigger waittill("trigger",player);
	wall delete();
	playfx(level.explo,wallfx.origin);
	metal movex(-32,1);
}

trap1()
{
	trigger = getEnt ( "trap1_trig", "targetname" );
	object1 = getEnt ( "trap1_1", "targetname" );
	object2 = getEnt ( "trap1_2", "targetname" );
	object3 = getEnt ( "trap1_3", "targetname" );
	trigger waittill("trigger",player);
	player braxi\_rank::giveRankXP("", 20);
	trigger SetHintString("^1Activated");
	object1 movez (-357,1);
	object2 movez (-357,1);
	object3 movez (-357,1);
	thread trap1_1();
	thread trap1_2();
	thread trap1_3();
	object3 waittill ("movedone");
	wait 3;
	object1 rotateroll(-180,1);
	object2 rotateroll(-180,1);
	object3 rotateroll (-180,1);
}
trap1_1()
{
	object1 = getEnt ( "trap1_1", "targetname" );
	object1 rotateroll (180,1);
	object1 waittill ("rotatedone");
	wait 4;
	object1 movez(357,3);
	object1 waittill ("movedone");
	while(1)
	{
		object1 movez (-260,3);
		object1 waittill ("movedone");
		object1 movez (260,3);
		object1 waittill ("movedone");
	}
}
trap1_2()
{
	object2 = getEnt ( "trap1_2", "targetname" );
	object2 rotateroll (180,1);
	object2 waittill ("rotatedone");
	wait 5;
	object2 movez(357,3);
	object2 waittill ("movedone");
	while(1)
	{
		object2 movez (-260,3);
		object2 waittill ("movedone");
		object2 movez (260,3);
		object2 waittill ("movedone");
	}
}
trap1_3()
{
	object3 = getEnt ( "trap1_3", "targetname" );
	object3 rotateroll (180,1);
	object3 waittill ("rotatedone");
	wait 6;
	object3 movez(357,3);
	object3 waittill ("movedone");
	while(1)
	{
		object3 movez (-260,3);
		object3 waittill ("movedone");
		object3 movez (260,3);
		object3 waittill ("movedone");
	}
}

trap2()
{
	trigger = getEnt ( "trap2_trig", "targetname" );
	car1 = getEnt ( "trap2_1_car", "targetname" );
	car2 = getEnt ( "trap2_2_car", "targetname" );
	clip1 = getEnt ( "trap2_1_clip", "targetname" );
	clip2 = getEnt ( "trap2_2_clip", "targetname" );
	wreck1 = getEnt ( "trap2_1_wreck", "targetname" );
	wreck2 = getEnt ( "trap2_2_wreck", "targetname" );
	boom1 = getEnt ( "trap2_1_fx", "targetname" );
	boom2 = getEnt ( "trap2_2_fx", "targetname" );
	wreck1 movez (-200,0.1);
	wreck2 movez (-200,0.1);
	trigger waittill ("trigger", player);
	player braxi\_rank::giveRankXP("", 20);
	trigger SetHintString("^1Activated");
	i = randomintrange( 0, 2 );
	if(i == 0)
	{
	playfx(level.carplode,boom1.origin);
	boom1 playSound("carboom");
	clip1 delete();
	car1 movez (-200,0.1);
	wreck1 movez (200,0.1);
	}
	else if(i == 1)
	{
	playfx(level.carplode,boom2.origin);
	boom2 playSound("carboom");
	clip2 delete();
	car2 movez (-200,0.1);
	wreck2 movez (200,0.1);
	}
}

trap3()
{
	trigger = getEnt ( "trap3_trig", "targetname" );
	car1 = getEnt ( "trap3_1_car", "targetname" );
	car2 = getEnt ( "trap3_2_car", "targetname" );
	clip1 = getEnt ( "trap3_1_clip", "targetname" );
	clip2 = getEnt ( "trap3_2_clip", "targetname" );
	wreck1 = getEnt ( "trap3_1_wreck", "targetname" );
	wreck2 = getEnt ( "trap3_2_wreck", "targetname" );
	boom1 = getEnt ( "trap3_1_fx", "targetname" );
	boom2 = getEnt ( "trap3_2_fx", "targetname" );
	wreck1 movez (-200,0.1);
	wreck2 movez (-200,0.1);
	trigger waittill ("trigger", player);
	player braxi\_rank::giveRankXP("", 20);
	trigger SetHintString("^1Activated");
	i = randomintrange( 0, 2 );
	if(i == 0)
	{
	playfx(level.carplode,boom1.origin);
	boom1 playSound("carboom");
	clip1 delete();
	car1 movez (-200,0.1);
	wreck1 movez (200,0.1);
	}
	else if(i == 1)
	{
	playfx(level.carplode,boom2.origin);
	boom2 playSound("carboom");
	clip2 delete();
	car2 movez (-200,0.1);
	wreck2 movez (200,0.1);
	}
}

trap4()
{
	trigger = getEnt ( "trap4_trig", "targetname" );
	trigger waittill ("trigger", player);
	player braxi\_rank::giveRankXP("", 20);
	trigger SetHintString("^1Activated");
	thread trap4_1();
	thread trap4_2();
	thread trap4_3();
	thread trap4_4();
	thread trap4_1rot();
	thread trap4_2rot();
	thread trap4_3rot();
	thread trap4_4rot();
}
trap4_1()
{
	object1 = getEnt ( "trap4_1", "targetname" );
	object1 movez(-25,0.25);
	object1 waittill ("movedone");
	while(1)
	{
		object1 movez (50,0.5);
		object1 waittill ("movedone");
		object1 movez (-50,0.5);
		object1 waittill ("movedone");
	}
}
trap4_2()
{
	object2 = getEnt ( "trap4_2", "targetname" );
	object2 movez(25,0.25);
	object2 waittill ("movedone");
	while(1)
	{
		object2 movez (-50,0.5);
		object2 waittill ("movedone");
		object2 movez (50,0.5);
		object2 waittill ("movedone");
	}
}
trap4_3()
{
	object3 = getEnt ( "trap4_3", "targetname" );
	object3 movez(-25,0.25);
	object3 waittill ("movedone");
	while(1)
	{
		object3 movez (50,0.5);
		object3 waittill ("movedone");
		object3 movez (-50,0.5);
		object3 waittill ("movedone");
	}
}
trap4_4()
{
	object4 = getEnt ( "trap4_4", "targetname" );
	object4 movez(25,0.25);
	object4 waittill ("movedone");
	while(1)
	{
		object4 movez (-50,0.5);
		object4 waittill ("movedone");
		object4 movez (50,0.5);
		object4 waittill ("movedone");
	}
}
trap4_1rot()
{
	object1 = getEnt ( "trap4_1", "targetname" );
	object1 rotateyaw(-45,0.5);
	object1 waittill ("rotatedone");
	while(1)
	{
		object1 rotateyaw (90,1);
		object1 waittill ("rotatedone");
		object1 rotateyaw (-90,1);
		object1 waittill ("rotatedone");
	}
}
trap4_2rot()
{
	object2 = getEnt ( "trap4_2", "targetname" );
	object2 rotateyaw(45,0.5);
	object2 waittill ("rotatedone");
	while(1)
	{
		object2 rotateyaw (-90,1);
		object2 waittill ("rotatedone");
		object2 rotateyaw (90,1);
		object2 waittill ("rotatedone");
	}
}
trap4_3rot()
{
	object3 = getEnt ( "trap4_3", "targetname" );
	object3 rotateyaw(-45,0.5);
	object3 waittill ("rotatedone");
	while(1)
	{
		object3 rotateyaw (90,1);
		object3 waittill ("rotatedone");
		object3 rotateyaw (-90,1);
		object3 waittill ("rotatedone");
	}
}
trap4_4rot()
{
	object4 = getEnt ( "trap4_4", "targetname" );
	object4 rotateyaw(45,0.5);
	object4 waittill ("rotatedone");
	while(1)
	{
		object4 rotateyaw (-90,1);
		object4 waittill ("rotatedone");
		object4 rotateyaw (90,1);
		object4 waittill ("rotatedone");
	}
}

trap5()
{
	trigger = getEnt ( "trap5_trig", "targetname" );
	object1 = getEnt ( "trap5_1", "targetname" );
	object2 = getEnt ( "trap5_2", "targetname" );
	object1 movey(228,0.1);
	object2 movey(228,0.1);
	trigger waittill ("trigger", player);
	player braxi\_rank::giveRankXP("", 20);
	trigger SetHintString("^1Activated");
	thread trap5_1();
	thread trap5_2();
}
trap5_1()
{
	object1 = getEnt ( "trap5_1", "targetname" );
	object1 movey(-228,0.25);
	object1 waittill ("movedone");
	wait 3;
	object1 movey (228,1);
	object1 waittill ("movedone");
	wait 14.25;
	while(1)
	{
		object1 movey(-228,0.25);
		object1 waittill ("movedone");
		wait 3;
		object1 movey(228,1);
		object1 waittill ("movedone");
		wait 10;
		object1 movey(-228,0.25);
		object1 waittill ("movedone");
		wait 3;
		object1 movey(228,1);
		object1 waittill ("movedone");
		wait 14.25;
	}
}
trap5_2()
{
	object2 = getEnt ( "trap5_2", "targetname" );
	wait 3.75;
	object2 movey(-228,0.25);
	object2 waittill ("movedone");
	wait 3;
	object2 movey(228,1);
	object2 waittill ("movedone");
	wait 10.5;
	while(1)
	{
		wait 18;
		object2 movey(-228,0.25);
		object2 waittill ("movedone");
		wait 3;
		object2 movey(228,1);
		object2 waittill ("movedone");
		wait 10.5;
	}
}

trap6()
{
	trigger = getEnt ( "trap6_trig", "targetname" );
	kill1 = getEnt ( "trap6_1", "targetname" );
	kill2 = getEnt ( "trap6_2", "targetname" );
	kill1 maps\mp\_utility::triggeroff();
	kill2 maps\mp\_utility::triggeroff();
	trigger waittill ("trigger", player);
	player braxi\_rank::giveRankXP("", 20);
	trigger SetHintString("^1Activated");
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

trap7()
{
		trigger = getEnt ( "trap7_trig", "targetname" );
		object1 = getEnt ( "trap7_1", "targetname" );
		object2 = getEnt ( "trap7_2", "targetname" );
		object3 = getEnt ( "trap7_3", "targetname" );
		object4 = getEnt ( "trap7_4", "targetname" );
		wall = getEnt ( "trap7_wall", "targetname" );
		wall movez (-146,0.1);
		trigger waittill ("trigger",player);
		player braxi\_rank::giveRankXP("", 20);
		trigger SetHintString("^1Activated");
		wall movez(146,0.25);
		object1 movez (146,1);
		object2 movez (146,1);
		object3 movez (146,1);
		object4 movez (146,1);
		object4 waittill ("movedone");
		wait 3;
		object1 movez (-146,1);
		object2 movez (-146,1);
		object3 movez (-146,1);
		object4 movez (-146,1);
		object4 waittill ("movedone");
		thread trap7_1();
		thread trap7_2();
		thread trap7_3();
		thread trap7_4();
}
trap7_1()
{
	object1 = getEnt ( "trap7_1", "targetname" );
	while(1)
	{
		object1 movez (146,0.5);
		object1 waittill ("movedone");
		wait 2;
		object1 movez(-146,1);
		object1 waittill ("movedone");
		wait 3.5;
	}
}
trap7_2()
{
	object2 = getEnt ( "trap7_2", "targetname" );
	while(1)
	{
		wait 3.5;
		object2 movez (146,0.5);
		object2 waittill ("movedone");
		wait 2;
		object2 movez(-146,1);
		object2 waittill ("movedone");
	}
}
trap7_3()
{
	object3 = getEnt ( "trap7_3", "targetname" );
	while(1)
	{
		object3 movez (146,0.5);
		object3 waittill ("movedone");
		wait 2;
		object3 movez(-146,1);
		object3 waittill ("movedone");
		wait 3.5;
	}
}
trap7_4()
{
	object4 = getEnt ( "trap7_4", "targetname" );
	while(1)
	{
		wait 3.5;
		object4 movez (146,0.5);
		object4 waittill ("movedone");
		wait 2;
		object4 movez(-146,1);
		object4 waittill ("movedone");
	}
}

trap8()
{
	trigger = getEnt ( "trap8_trig", "targetname" );
	trigger waittill ("trigger", player);
	player braxi\_rank::giveRankXP("", 20);
	trigger SetHintString("^1Activated");
	thread trap8_1();
	thread trap8_2();
}
trap8_1()
{
	object1 = getEnt ( "trap8_1", "targetname" );
	while(1)
	{
		object1 movey(169,0.5);
		object1 waittill ("movedone");
		object1 movey(-169,0.5);
		object1 waittill ("movedone");
	}
}
trap8_2()
{
	object2 = getEnt ( "trap8_2", "targetname" );
	while(1)
	{
		object2 movey(-169,0.5);
		object2 waittill ("movedone");
		object2 movey(169,0.5);
		object2 waittill ("movedone");
	}
}

old_room_battle()
{
    level.old_trig=getent("oldroom_ent","targetname");
    door=getent("old_door","targetname");
    door2=getent("oldfight_door","targetname");

        level.old_trig waittill("trigger",player);


            level.knife_trig delete();
			level.bounce_trig delete();
			level.sniper_trig delete();

			door delete();
 
 
         iprintlnbold("^1"+player.name+" ^7entered Old room.");
		 level.old_trig delete();
		 wait 5;
		 door2 movez(-111,4);
		 
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