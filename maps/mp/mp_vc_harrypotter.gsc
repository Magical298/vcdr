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
         _   ________   ___       __             _
        | | / / ___( ) / _ | ____/ /_____ ____  (_)
        | |/ / /__ |/ / __ |/ __/  '_/ _ `/ _ \/ /
        |___/\___/   /_/ |_/_/ /_/\_\\_,_/_//_/_/  
                                                                                             
        � Phelix & VC' Blade & VC' Arkani
        Special thanks to Blade and Phelix for teaching and writing some functions for me. -Arkani

        Textures by (C)EA Games
*/
main()
{
    maps\mp\_load::main();

    precacheItem("m60e4_mp");
    precacheItem("rpg_mp");
    
    game["allies"] = "sas";
    game["axis"] = "opfor";
    game["attackers"] = "axis";
    game["defenders"] = "allies";
    game["allies_soldiertype"] = "woodland";
    game["axis_soldiertype"] = "woodland";

    setdvar( "r_specularcolorscale", "1" );
    setdvar("r_glowbloomintensity0",".25");
    setdvar("r_glowbloomintensity1",".25");
    setdvar("r_glowskybleedintensity0",".3");
    setDvar( "compassmaxrange", "1024" );

    precacheItem("m40a3_mp");
    precacheItem("remington700_mp");
    precacheItem("p90_silencer_mp");
    precacheItem("knife_mp");
    precacheItem("deserteaglegold_mp");
    precacheItem("m4_mp");
    precacheItem("g3_silencer_mp");
    precacheItem("c4_mp");
    precacheItem("deserteagle_mp");
    precacheItem("ak74u_mp");

    thread mapperCredit();
    thread teleporter();
    thread treppe();
    thread treppe2();
    thread treppe3();
    thread treppe4();
    thread falle1();
    thread lasttrap();
    thread falle3();
    thread falle4();
    thread falle5();
    thread falle6();
    thread falle7();
    thread falle8();
    thread falle9();
    thread sniperroom();
    thread kniferoom();
    thread jumproom();
    thread secret_open();
    thread secret2();

    addTriggerToList("falle1_trig");
    addTriggerToList("last_trap2");
    addTriggerToList("trap3_trig");
    addTriggerToList("trap4");
    addTriggerToList("trap5_trig");
    addTriggerToList("trap6_trig");
    addTriggerToList("trap7_trig");
    addTriggerToList("trap8_trig");
    addTriggerToList("trap9_trig");
 
}

addTriggerToList(name)
{
    if(!isDefined(level.trapTriggers))
        level.trapTriggers=[];
    level.trapTriggers[level.trapTriggers.size]=getEnt(name,"targetname");
}

mapperCredit()
{
    level waittill("round_started");
    thread showMapper();
    thread showCredits();
    
    ambientplay("harry_main");

    for(;;)
    {
        iprintln("Map by ^1VC' Arkani^7!");
        wait 10;
        iprintln("Made for ^1Vistic^7 Clan!");
        wait 10;
    }
}

teleporter()
{
    tele=getentarray("teleport","targetname");
    if(isdefined(tele))
    {
        for(i=0;i<tele.size;i++)
            tele[i] thread portMe();
    }
}
portMe()
{
    for(;;)
    {
        self waittill("trigger",who);
        targ=getent(self.target,"targetname");
        who freezecontrols(1);
        who setorigin(targ.origin);
        who setplayerangles(targ.angles);
        wait 0.01;
        who freezecontrols(0);
    }
}

showMapper()
{
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
    hud_clock.glowalpha = 1;
    hud_clock.glowcolor = (0,.8,0);
    hud_clock.label = &"Made by Arkani";
    hud_clock SetPulseFX( 40, 5400, 200 );
}

showCredits()
{
    hud_clock = NewHudElem();
    hud_clock.alignX = "center";
    hud_clock.alignY = "middle";
    hud_clock.horzalign = "center";
    hud_clock.vertalign = "middle";
    hud_clock.alpha = 1;
    hud_clock.x = 0;
    hud_clock.y = 20;
    hud_clock.fontscale = 1.8;
    hud_clock.glowalpha = 1;
    hud_clock.glowcolor = (0,.8,0);
    hud_clock.label = &"Special Thanks to VC' Blade & Phelix";
    hud_clock SetPulseFX( 40, 5400, 200 );
}

treppe()
{
    trig=getent("treppe1_trig","targetname");
    targ=getent("treppe1","targetname");

    trig waittill("trigger");
    wait 0.5;
  for(;;)
  {
    targ moveto((160,-368,488),6);
    targ rotateyaw(-90,4);
    targ waittill("movedone");
    wait 4;
    targ moveto((416,-64,264),6);
    targ rotateyaw(90,4);
    targ waittill("movedone");
    wait 3;
  }
}

treppe2()
{
    trig=getent("treppe2_trig","targetname");
    targ=getent("treppe2","targetname");

    trig waittill("trigger");
    wait 0.5;
  for(;;)
  {
    targ moveto((-368,-48,760),6);
    targ rotateyaw(-90,4);
    targ waittill("movedone");
    wait 4;
    targ moveto((-224,-368,584),6);
    targ rotateyaw(90,4);
    targ waittill("movedone");
    wait 3;
  }
}

treppe3()
{
    trig=getent("treppe3_trig","targetname");
    targ=getent("treppe3","targetname");

    trig waittill("trigger");
    wait 0.5;
  for(;;)
  {
    targ moveto((320,384,984),6);
    wait 6;
    targ rotateyaw(-90,4);
    targ moveto((320,-100,984),6);
    wait 6;
    targ rotateyaw(-90,4);
    targ moveto((-176,-368,1112),6);
    targ waittill("movedone");
    wait 4;
    targ moveto((320,-100,984),6);
    targ rotateyaw(90,4);
    wait 6;
    targ moveto((-176,384,856),6);
    targ rotateyaw(90,4);
    targ waittill("movedone");
    wait 3;
  }
}

treppe4()
{
    trig=getent("treppe4_trig","targetname");
    targ=getent("treppe4","targetname");

    trig waittill("trigger");
    wait 0.5;
  for(;;)
  {
    targ moveto((336,160,1320),6);
    targ rotateyaw(90,4);
    targ waittill("movedone");
    wait 4;
    targ moveto((-176,-16,1208),6);
    targ rotateyaw(-90,4);
    targ waittill("movedone");
    wait 3;
  }
}

falle1()
{
    falle1=getent("falle1","targetname");
    falle1_trig=getent("falle1_trig","targetname");

    falle1_trig waittill("trigger", who);
    falle1_trig delete();
    who braxi\_rank::giverankxp(undefined,40);
    falle1 movey(-272, 1);
    wait 3;
    falle1 movey(272, 3);
}

lasttrap()
{
    last_trap1=getent("last_trap1","targetname");
    last_trap2=getent("last_trap2","targetname");

    while(1)
    {
        last_trap1 movex(-524, 3);
        wait 3;
        last_trap1 movex(524, 3);
        wait 3;
    }
}
falle3()
{
    trap3=getent("trap3","targetname");
    t1_trig=getent("trap3_trig","targetname");

    t1_trig waittill("trigger", who);
    t1_trig delete();
    who braxi\_rank::giverankxp(undefined,40);
    trap3 movez(272, 1);
    wait 3;
    trap3 movez(-272, 3);
}
falle4()
{
    part1 = getentarray ("t4_1" ,"targetname");
    part2 = getentarray ("t4_2" ,"targetname");
    trap4 = getent ("trap4" , "targetname");
 
    trap4 waittill ("trigger", who);
    trap4 delete ();
    who braxi\_rank::giverankxp(undefined,40);
 
    rdm=randomint(6);
    if(rdm==3||rdm==1||rdm==0)
        part2[randomInt(part2.size)] notsolid();
    else
        part1[randomInt(part1.size)] notsolid();
}
falle5()
{
    trap5 = getent("trap5" ,"targetname");

    trap5_trig = getent("trap5_trig" , "targetname");

    trap5_trig waittill("trigger", who);
    trap5_trig delete();
    who braxi\_rank::giverankxp(undefined,40);

    trap5 notsolid();
}
falle6()
{
    trap6 = getent("trap6" ,"targetname");

    trap6_trig = getent("trap6_trig" , "targetname");

    trap6_trig waittill("trigger", who);
    trap6_trig delete();
    who braxi\_rank::giverankxp(undefined,40);
    trap6 movez(-64, 1);
}
falle7()
{
    trap7 = getent("trap7" ,"targetname");

    trap7_trig = getent("trap7_trig" , "targetname");

    trap7_trig waittill("trigger", who);
    trap7_trig delete();
    who braxi\_rank::giverankxp(undefined,40);
    while(1)
    {
        trap7 movez(300, 4);
        wait 4;
        trap7 movez(-300, 4);
        wait 4;
    }
}
falle8()
{
    trap8 = getent("trap8" ,"targetname");

    trap8_trig = getent("trap8_trig" , "targetname");

    trap8_trig waittill("trigger", who);
    trap8_trig delete();
    who braxi\_rank::giverankxp(undefined,40);
    while(1)
    {
    trap8 movex(-300, 3);
    wait 2;
    trap8 movex(300, 3);
    wait 2; 
    }
}
falle9()
{
    trap9_1 = getent("trap9_1" ,"targetname");
    trap9_2 = getent("trap9_2" ,"targetname");

    trap9_trig = getent ("trap9_trig" , "targetname");

    trap9_trig waittill("trigger", who);
    trap9_trig delete();
    who braxi\_rank::giverankxp(undefined,40);
    

    while(1)
    {
        trap9_2 movez(50, 1);
        trap9_1 movez(-50, 1);
        wait 1;
        trap9_2 movez(-100, 2);
        trap9_1 movez(100, 2);
        wait 2;
        trap9_2 movez(50, 1);
        trap9_1 movez(-50, 1);
        wait 1;
    }
    
}

//rooms
sniperroom()
{
    level.sniper=getent("sniper_tp","targetname");   // trigger
    acti=getent("acti_sniper","targetname");           // activator origin
    jump=getent("jump_sniper","targetname");           // jumper origin
 
    while(1)
    {
        level.sniper waittill("trigger",who);
        if(!isdefined(level.sniper))
            return;

             // ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================
 
        if(!level.roomEntered)
        {
            level.roomEntered=true;
            iprintlnbold("^1"+who.name+"^7 entered ^1Sniper Fight");
            level.knife delete();
            level.jump delete();
            ambientplay("sniper");
        }
 
        if(isdefined(level.activ))
        {
            who endroomsetup(jump.origin,jump.angles,"m40a3_mp","remington700_mp",1);
            level.activ endroomsetup(acti.origin,acti.angles,"m40a3_mp","remington700_mp",1);
            wait 5;
            who freezecontrols(0);
            level.activ freezecontrols(0);
        }
        else
        {
            who iprintlnbold("^1no activator defined");
            return;
        }
 
        while(isalive(who)&&isdefined(who))
            wait 1;
 
        iprintlnbold("^1"+who.name+"^7 has been killed");
        who braxi\_rank::giverankxp(undefined,100);
    }
}
 
kniferoom()
{
    level.knife=getent("knife_tp","targetname");   // trigger
    acti=getent("acti_knife","targetname");           // activator origin
    jump=getent("jump_knife","targetname");           // jumper origin
 
    while(1)
    {
        level.knife waittill("trigger",who);
        if(!isdefined(level.knife))
            return;

             // ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================
 
        if(!level.roomEntered)
        {
            level.roomEntered=true;
            iprintlnbold("^1"+who.name+"^7 opened ^1Knife Fight");
            level.sniper delete();
            level.jump delete();
            ambientplay("knife");
        }
 
        if(isdefined(level.activ))
        {
            who endroomsetup(jump.origin,jump.angles,"knife_mp",undefined,1);
            level.activ endroomsetup(acti.origin,acti.angles,"knife_mp",undefined,1);
            wait 5;
            who freezecontrols(0);
            level.activ freezecontrols(0);
        }
        else
        {
            who iprintlnbold("^1no activator defined");
            return;
        }
 
        while(isalive(who)&&isdefined(who))
            wait 1;
 
        iprintlnbold("^1"+who.name+"^7 has been killed");
        who braxi\_rank::giverankxp(undefined,100);
    }
}
secret_open()
{
    brush=getent("secret_brush_open","targetname");
    brush2=getent("question","targetname");
    s1trig=getent("lamp1","targetname");
    s2trig=getent("lamp2","targetname");
    s3trig=getent("lamp3","targetname");
    s4trig=getent("lamp4","targetname");
 
    s1trig waittill("trigger");
    s1trig delete();
    //iprintln("lamp 1 has been shot");
    s2trig waittill("trigger");
    s2trig delete();
    //iprintln("lamp 2 has been shot");
    s3trig waittill("trigger");
    s3trig delete();
    //iprintln("lamp 3 has been shot");
    s4trig waittill("trigger");
    s4trig delete();
    //iprintln("lamp 4 has been shot");
 
    brush movez(-55, 3);
    brush2 notsolid();
    wait 3;
    iprintln("Secret has been opened!");
 
    thread secret_enter();
    thread secret_leave();
}

secret_enter()
{
    trig=getent("secret_in","targetname");
    for(;;)
    {
        trig waittill("trigger",who);
        who thread secret_leave_back();
        who secretTimer();
    }
}
secret_leave_back()
{
    trig = getent("secret_leave_behind", "targetname");

    trig waittill("trigger", who);

    who iPrintLnBold("You've left the ^1Secret^7!");
    who notify("secret_completed");
    if(isdefined(who.secretTimer))
        who.secretTimer destroy();
    wait 0.1;
    who iPrintLnBold("Now you ^1can't^7 enter it anymore");
    thread secret_enter_block();
}
secret_enter_block()
{
    trig = getent("secret_block", "targetname");
    new_origin = getent("secret_block_tp", "targetname");
    for(;;)
    {
        trig waittill("trigger", who);

        who iPrintLnBold("You left the ^1Secret^7!");
        who iPrintLnBold("You ^1can't ^7enter it anymore!");
        wait 0.1;
        who tp(new_origin.origin,new_origin.angles,1);
        wait 0.1;
        who freezecontrols(0);
    }
}
secret_leave()
{
    trig=getent("secret_out_trig","targetname");
    targ=getent("secret_out","targetname");
    for(;;)
    {
        trig waittill("trigger",who);
        who notify("secret_completed");
 
        if(isdefined(who.secretTimer))
            who.secretTimer destroy();

        who endroomsetup(targ.origin,targ.angles,"ak74u_mp",undefined,1);
        wait 0.1;
        who freezecontrols(0);
        iprintlnbold("^1"+who.name+"^7 finished the ^1Secret^7.");
        who braxi\_rank::giverankxp(undefined,300);

    }
}

secretTimer()
{
    self endon("secret_completed");

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
    self.secretTimer.label = &"Time in left: &&1";
       
    if(isdefined(level.randomcolor))
        self.secretTimer.glowColor=level.randomcolor;
    else
        self.secretTimer.glowColor=(1,0,0);
 
    for(i=0;i<120;i++)
    {
        self.secretTimer setvalue(120-i);
        wait 1;
    }
    self.secretTimer setvalue(0);
    self suicide();
 
    if(isdefined(self.secretTimer))
        self.secretTimer destroy();
}
jump_pick()
{
    trig = getent("jump_Pick", "targetname");

    for(;;)
    {
        trig waittill("trigger", who);
        if(self getcurrentweapon()!="m60e4_mp")
            {
                self giveWeapon( "m60e4_mp"); //
                self giveMaxammo("m60e4_mp");
                wait 0.1;
                self switchToWeapon("m60e4_mp");
                who iprintlnbold("^1You have got the ^1M60^7!");
            }
        else
            who iprintlnbold("^1You already have got the ^1M60^7!");
    }
}
jumproom()
{
    level.jump=getent("jumper_tp","targetname");   // trigger
    acti=getent("acti_jump","targetname");           // activator origin
    jump=getent("jump_jump","targetname");           // jumper origin
    level.roomEntered=false; 

    while(1)
    {
        level.jump waittill("trigger",who);
        if(!isdefined(level.jump))
            return;

             // ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================
 
        if(!level.roomEntered)
        {
            level.roomEntered=true;
            iprintlnbold("^1"+who.name+"^7 opened the ^1Bounce Room");
            level.sniper delete();
            level.knife delete();
            who thread jump_pick();
            ambientplay("bounce");
        }
 
        if(isdefined(level.activ))
        {
            who endroomsetup(jump.origin,jump.angles,"c4_mp",undefined,1);
            level.activ endroomsetup(acti.origin,acti.angles,"c4_mp",undefined,1);
            wait 5;
            who freezecontrols(0);
            level.activ freezecontrols(0);
            level.activ thread jump_pick();
            
        }
        else
        {
            who iprintlnbold("^1no activator defined");
            return;
        }
 
        while(isalive(who)&&isdefined(who))
            wait 1;
 
        iprintlnbold("^1"+who.name+"^7 has been killed");
        who braxi\_rank::giverankxp(undefined,100);
    }
}

endroomsetup(origin,angles,weap,weap2,freeze)
{
    self setorigin(origin);
    self setplayerangles(angles);
 
    self takeallweapons();
    self giveweapon(weap);
    if(isdefined(weap2))
        self giveweapon(weap2);
    self switchtoweapon(weap);
 
    self freezecontrols(freeze);
}
tp(origin,angles,freeze)
{
    self setorigin(origin);
    self setplayerangles(angles);
    self freezecontrols(freeze);
}

secret2()
{
    trig = getent("sec2_open", "targetname");

    trig waittill("trigger", who);
    trig delete();
    who iprintln("old men have feelings :(");

    thread secret_enter2();
    thread secret_leave2();
    thread secret_leave_shot(); 
}
secret_enter2()
{
    trig = getent("sec2_enter", "targetname"); 
    origin = getent("secret2_origin","targetname"); 

    for(;;)
    {
        trig waittill("trigger", who);
        who endroomsetup(origin.origin,origin.angles,"deserteagle_mp","rpg_mp",1);
        who iPrintLnBold("You've entered the ^1Secret ^7and have ^13^7 minutes to finish it!");
        wait 3;
        who freezecontrols(0);
        who secretTimer2();
    }

}

secret_leave_shot()
{
    trig = getent("secret_leave_shot", "targetname");
    new_origin = getent("tp_sec_start", "targetname");
    for(;;)
    {
        trig waittill("trigger", who);

        who iPrintLnBold("You left the ^1Secret^7!");
        who notify("secret_completed2");
        if(isdefined(who.secretTimer2))
            who.secretTimer2 destroy();
        who tp(new_origin.origin,new_origin.angles,1);
        wait 0.1;
        who freezecontrols(0);
    }
}
secret_leave2()
{
    trig=getent("sec2_fin","targetname");
    targ=getent("secret_out","targetname");
    for(;;)
    {
        trig waittill("trigger",who);
        who notify("secret_completed2");
 
        if(isdefined(who.secretTimer2))
            who.secretTimer2 destroy();
        who freezecontrols(1);
        who setorigin(targ.origin);
        who setplayerangles(targ.angles);
        wait 0.1;
        who freezecontrols(0);
        iprintlnbold("^1"+who.name+"^7 finished the ^1HARD ^7Secret!!");
        who braxi\_rank::giverankxp(undefined,500);
    }
}
secretTimer2()
{
    self endon("secret_completed2");

    if(isdefined(self.secretTimer2))
        self.secretTimer2 destroy();
 
    self.secretTimer2=newclienthudelem(self);
    self.secretTimer2.foreground = true;
    self.secretTimer2.alignX = "center";
    self.secretTimer2.alignY = "bottom";
    self.secretTimer2.horzAlign = "center";
    self.secretTimer2.vertAlign = "bottom";
    self.secretTimer2.x = 0;
    self.secretTimer2.y = -7;
    self.secretTimer2.sort = 5;
    self.secretTimer2.fontScale = 1.6;
    self.secretTimer2.font = "default";
    self.secretTimer2.glowAlpha = 1;
    self.secretTimer2.hidewheninmenu = true;
       self.secretTimer2.label = &"Time in left: &&1";
       
    if(isdefined(level.randomcolor))
        self.secretTimer2.glowColor=level.randomcolor;
    else
        self.secretTimer2.glowColor=(1,0,0);
 
    for(i=0;i<120;i++)
    {
        self.secretTimer2 setvalue(180-i);
        wait 1;
    }
    self.secretTimer2 setvalue(0);
    self suicide();
 
    if(isdefined(self.secretTimer2))
        self.secretTimer2 destroy();
}