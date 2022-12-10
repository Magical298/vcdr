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
   __        _        
   \ \  __ _| | _____ 
    \ \/ _` | |/ / _ \
 /\_/ / (_| |   <  __/
 \___/ \__,_|_|\_\___|
                      
    © VC' Jake

    Credits to Blade for teaching me Mapping
*/
#include braxi\_slider;
main()
{
	game["allies"] = "marines";
    game["axis"] = "opfor";
    game["attackers"] = "axis";
    game["defenders"] = "allies";
    game["allies_soldiertype"] = "desert";
    game["axis_soldiertype"] = "desert";

    level.explosion=loadfx("vistic/big_explosion");

    thread onConnected();
    thread startdoor();
    thread secret_enter();
    thread secret_exit();
    thread final_stage();
    thread runTraps();
    thread runRooms();



    addTriggerToList( "trap1_trig" );
    addTriggerToList( "trap2_trig" );
    addTriggerToList( "trap3_trig" );
    addTriggerToList( "trap4_trig" );
    addTriggerToList( "trap5_trig" );
    addTriggerToList( "trap6_trig" );
    addTriggerToList( "trap7_trig" );
    addTriggerToList( "trap8_trig" );
    addTriggerToList( "trap9_trig" );

}

addTriggerToList(name)
{
    if(!isDefined(level.trapTriggers))
        level.trapTriggers=[];
    level.trapTriggers[level.trapTriggers.size]=getEnt(name,"targetname");
}

startdoor()
{
    trig=getent("startdoor_trig","targetname");
    door=getent("startdoor","targetname");

    trig setHintString("Press [^3USE^7] to open the ^3Door");
    trig setCursorHint("HINT_ACTIVATE");

    trig waittill("trigger");
    ambientplay("run");
    trig delete();

    wait 5;
    door movez(130,3);
    wait 3;
    door delete();

    mapper_an = NewHudElem();
    mapper_an.alignX = "center";
    mapper_an.alignY = "middle";
    mapper_an.horzalign = "center";
    mapper_an.vertalign = "middle";
    mapper_an.alpha = 1;
    mapper_an.x = 0;
    mapper_an.y = 0;
    mapper_an.font = "objective";
    mapper_an.fontscale = 2;
    mapper_an.glowalpha = 5;
    mapper_an.glowcolor = (0.0,0.8,0.0);
    mapper_an.label = &"Map by ^3VC' Jake";
    mapper_an SetPulseFX( 40, 5400, 200 );
    wait 3;
    iprintlnbold("^3Infinity ^7has FreeZer syndrome...");
}

runTraps()
{
    thread trap1();
    thread trap2();
    thread trap3();
    thread trap4();
    thread trap5();
    thread trap6();
    thread trap7();
    thread trap8();
    thread trap9();
}

trap1()
{
    trig=getent("trap1_trig","targetname");
    trapa=getent("trap1","targetname");
    trapb=getent("trap1_fx","targetname");
    trapa maps\mp\_utility::triggerOff();

    trig setHintString("Press [^3USE^7] to Activate the Trap");
    trig setCursorHint("HINT_ACTIVATE");

    trig waittill("trigger");
    trig delete();

    if(isdefined(level.activ))
        //iprintln("^3Activator "+level.activ.name+"^7 has activated Trap ^31");

    trapa maps\mp\_utility::triggerOn();
    playfx(level.explosion,trapb.origin);
    wait 3+randomint(2);
    trapa maps\mp\_utility::triggerOff();
}

trap2()
{
    trig=getent("trap2_trig","targetname");
    trapa=getent("trap2a","targetname");
    trapb=getent("trap2b","targetname");

    trig setHintString("Press [^3USE^7] to Activate the Trap");
    trig setCursorHint("HINT_ACTIVATE");

    trig waittill("trigger");
    trig delete();

    if(isdefined(level.activ))
        //iprintln("^3Activator "+level.activ.name+"^7 has activated Trap ^32");

    while(1)
    {
        trapa movex(224,1);
        trapb movex(-224,1);
        wait 1.1;
        trapa movex(-224,1);
        trapb movex(224,1);
        wait 1.1;
    }
}
/*
trap3()
{
    trig=getent("trap3_trig","targetname");
    trapa=getent("trap3a","targetname");
    trapb=getent("trap3b","targetname");

    trig setHintString("Press [^3USE^7] to Activate the Trap");
    trig setCursorHint("HINT_ACTIVATE");

    trig waittill("trigger");
    trig delete();

    if(isdefined(level.activ))
        //iprintln("^3Activator "+level.activ.name+"^7 has activated Trap ^33");

    i=randomint(8);
    if(i==0||i==3||i==7||i==1)
        trapa delete();
    else
        trapb delete();
}
*/

trap3()
{
    trig=getent("trap3_trig","targetname");
    trapa=getent("trap3a","targetname");
    trapb=getent("trap3b","targetname");

    trig setHintString("Press [^3USE^7] to Activate the Trap");
    trig setCursorHint("HINT_ACTIVATE");

    trig waittill("trigger");
    trig delete();

    if(isdefined(level.activ))
       
    i = 0;
    i=randomint(8);
    if(i==0||i==3||i==7||i==1)
        trapa delete();
    else
        trapb delete();
}

trap4()
{
    trig=getent("trap4_trig","targetname");
    trap=getent("trap4","targetname");

    trig setHintString("Press [^3USE^7] to Activate the Trap");
    trig setCursorHint("HINT_ACTIVATE");

    trig waittill("trigger");
    trig delete();

    if(isdefined(level.activ))
        //iprintln("^3Activator "+level.activ.name+"^7 has activated Trap ^34");

    while(1)
    {
        trap rotatepitch(360,2);
        wait 4;
    }
}

trap5()
{
    trig=getent("trap5_trig","targetname");
    trap=getent("trap5","targetname");

    trig setHintString("Press [^3USE^7] to Activate the Trap");
    trig setCursorHint("HINT_ACTIVATE");

    trig waittill("trigger");
    trig delete();

    if(isdefined(level.activ))
        //iprintln("^3Activator "+level.activ.name+"^7 has activated Trap ^35");

    while(1)
    {
        trap hide();
        trap notsolid();
        wait randomintrange(1,4);
        trap show();
        trap solid();
        wait randomintrange(1,4);
    }
}

trap6()
{
    trig=getent("trap6_trig","targetname");
    trapa=getent("trap6a","targetname");
    trapb=getent("trap6b","targetname");

    trig setHintString("Press [^3USE^7] to Activate the Trap");
    trig setCursorHint("HINT_ACTIVATE");

    trig waittill("trigger");
    trig delete();

    if(isdefined(level.activ))
        //iprintln("^3Activator "+level.activ.name+"^7 has activated Trap ^36");

    while(1)
    {
        trapa rotatepitch(360,2);
        trapb rotatepitch(-360,2);
        wait 2;
        trapa rotatepitch(-360,2);
        trapb rotatepitch(360,2);
        wait 2;
    }
}

trap7()
{
    trig=getent("trap7_trig","targetname");
    trap=getent("trap7","targetname");

    trig setHintString("Press [^3USE^7] to Activate the Trap");
    trig setCursorHint("HINT_ACTIVATE");

    trig waittill("trigger");
    trig delete();

    if(isdefined(level.activ))
        //iprintln("^3Activator "+level.activ.name+"^7 has activated Trap ^37");

    while(1)
    {
        trap rotateyaw(360,2);
        wait 5;
    }
}

trap8()
{
    trig=getent("trap8_trig","targetname");
    trapa=getent("trap8a","targetname");
    trapb=getent("trap8b","targetname");

    trig setHintString("Press [^3USE^7] to Activate the Trap");
    trig setCursorHint("HINT_ACTIVATE");

    trig waittill("trigger");
    trig delete();

    if(isdefined(level.activ))
        //iprintln("^3Activator "+level.activ.name+"^7 has activated Trap ^38");

    while(1)
    {
        trapa rotateyaw(360,2);
        trapb rotateyaw(-360,2);
        wait 2;
    }
}

trap9()
{
    trig=getent("trap9_trig","targetname");
    trap=getent("trap9","targetname");

    trig setHintString("Press [^3USE^7] to Activate the Trap");
    trig setCursorHint("HINT_ACTIVATE");

    trig waittill("trigger");
    trig delete();

    if(isdefined(level.activ))
        //iprintln("^3Activator "+level.activ.name+"^7 has activated Trap ^39");

    trap delete();
}

onConnected()
{
    level endon("game_ended");
    for(;;)
    {
        level waittill("connecting",player);
        player thread hud();
    }
}

hud()
{
    self.hud_creator = newClientHudElem(self);
    self.hud_creator.x = 4;
    self.hud_creator.y = 0;
    self.hud_creator.alignX = "center";
    self.hud_creator.alignY = "top";
    self.hud_creator.horzAlign = "center";
    self.hud_creator.vertAlign = "top";
    self.hud_creator.fontScale = 1.6;
    self.hud_creator.color = (1.0, 1.0, 1.0);
    self.hud_creator.font = "objective";
    self.hud_creator.glowColor = (randomint(50)/50,randomint(50)/50,randomint(50)/50);
    self.hud_creator.glowAlpha = 1;
    self.hud_creator.hideWhenInMenu = false;
    self.hud_creator setText("^3Map ^7exclusivly made for ^3Vistic");
}

secret_enter()
{
    trig=getent("secret_enter","targetname");
    targ=getent("secret_enter_o","targetname");

    for(;;)
    {
        trig waittill("trigger",player);
        player loadteleport(targ.origin,targ.angles);
    }
}

secret_exit()
{
    trig=getent("secret_exit","targetname");
    targ=getent("secret_exit_o","targetname");

    for(;;)
    {
        trig waittill("trigger",player);
        player loadteleport(targ.origin,targ.angles);
    }
}

final_stage()
{
    trig=getent("laststage_trig","targetname");
    targ=getent("final_o","targetname");

    for(;;)
    {
        trig waittill("trigger",player);
        player loadteleport(targ.origin,targ.angles);
    }
}

loadteleport(origin,angles)
{
    self setorigin(origin);
    self setplayerangles(angles);
}

runRooms()
{
    thread deagle();
    thread sniper();
    thread knife();
}

sniper()
{
    level.sniper=getent("sniper_r","targetname");
    level.jump_snip=getent("snip_j","targetname");
    level.acti_snip=getent("snip_a","targetname");
    level.roomsong=true;
    level.sniper sethintstring("Press [^3USE^7] to enter ^3Sniper");
    while(1)
    {
        level.sniper waittill("trigger",player);

        // ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================

        if(!isdefined(level.sniper))
            return;
        level.sniper sethintstring("Wait your ^3Turn");
        if(level.roomsong==true)
        {
            ambientstop();
            ambientplay("run_room");
            level.knife delete();
            level.deagle delete();
            level.roomsong = false;
        }
        if(isdefined(level.activ))
        {
            player freezecontrols(1);
            level.activ freezecontrols(1);
            player loadteleport(level.jump_snip.origin,level.jump_snip.angles);
            level.activ loadteleport(level.acti_snip.origin,level.acti_snip.angles);
            player takeallweapons();
            level.activ takeallweapons();
            noti = SpawnStruct();
            noti.titleText = "SNIPER ROOM";
            noti.notifyText = player.name+" ^1vs "+level.activ.name;
            noti.duration = 6;
            noti.glowcolor = (1,1,0);
            players = getentarray("player", "classname");
            for(i=0;i<players.size;i++)
                players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
            wait 1;
            player thread countdown();
            level.activ thread countdown();
        }
        else
        {
            player freezecontrols(1);
            player loadteleport(level.jump_snip.origin,level.jump_snip.angles);
            player takeallweapons();
            wait 1;
            player thread countdown();
        }
        while(isalive(player)&&isdefined(player))
            wait 1;
        iprintln("^3"+player.name+"^7 has been killed");
        level.sniper sethintstring("Press [^3USE^7] to enter ^3Sniper");
    }
}

deagle()
{
    level.deagle=getent("deagle_r","targetname");
    jump=getent("deagle_j","targetname");
    acti=getent("deagle_a","targetname");
    level.roomsong=true;
    level.deagle sethintstring("Press [^3USE^7] to enter ^3Deagle");
    while(1)
    {
        level.deagle waittill("trigger",player);

        // ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================

        if(!isdefined(level.deagle))
            return;
        level.deagle sethintstring("Wait your ^3Turn");
        if(level.roomsong==true)
        {
            ambientstop();
            ambientplay("run_room");
            level.knife delete();
            level.sniper delete();
            level.roomsong = false;
        }
        if(isdefined(level.activ))
        {
            player freezecontrols(1);
            level.activ freezecontrols(1);
            player loadteleport(jump.origin,jump.angles);
            level.activ loadteleport(acti.origin,acti.angles);
            player takeallweapons();
            level.activ takeallweapons();
            noti = SpawnStruct();
            noti.titleText = "DEAGLE ROOM";
            noti.notifyText = player.name+" ^1vs "+level.activ.name;
            noti.duration = 6;
            noti.glowcolor = (1,1,0);
            players = getentarray("player", "classname");
            for(i=0;i<players.size;i++)
                players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
            wait 1;
            player thread countdown();
            level.activ thread countdown();
        }
        else
        {
            player freezecontrols(1);
            player loadteleport(jump.origin,jump.angles);
            player takeallweapons();
            wait 1;
            player thread countdown();
        }
        while(isalive(player)&&isdefined(player))
            wait 1;
        iprintln("^3"+player.name+"^7 has been killed");
        level.deagle sethintstring("Press [^3USE^7] to enter ^3Deagle");
    }
}

knife()
{
    level.knife=getent("knife_r","targetname");
    jump=getent("knife_j","targetname");
    acti=getent("knife_a","targetname");
    level.roomsong=true;
    level.knife sethintstring("Press [^3USE^7] to enter ^3Knife");
    while(1)
    {
        level.knife waittill("trigger",player);

        // ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================

        if(!isdefined(level.knife))
            return;
        level.knife sethintstring("Wait your ^3Turn");
        if(level.roomsong==true)
        {
            ambientstop();
            ambientplay("run_room");
            level.deagle delete();
            level.sniper delete();
            level.roomsong = false;
        }
        if(isdefined(level.activ))
        {
            player freezecontrols(1);
            level.activ freezecontrols(1);
            player loadteleport(jump.origin,jump.angles);
            level.activ loadteleport(acti.origin,acti.angles);
            player takeallweapons();
            level.activ takeallweapons();
            noti = SpawnStruct();
            noti.titleText = "KNIFE ROOM";
            noti.notifyText = player.name+" ^1vs "+level.activ.name;
            noti.duration = 6;
            noti.glowcolor = (1,1,0);
            players = getentarray("player", "classname");
            for(i=0;i<players.size;i++)
                players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
            wait 1;
            player thread countdown();
            level.activ thread countdown();
        }
        else
        {
            player freezecontrols(1);
            player loadteleport(jump.origin,jump.angles);
            player takeallweapons();
            wait 1;
            player thread countdown();
        }
        while(isalive(player)&&isdefined(player))
            wait 1;
        iprintln("^3"+player.name+"^7 has been killed");
        level.knife sethintstring("Press [^3USE^7] to enter ^3Knife");
    }
}


countdown()
{
    thread oben(self,"3",level.randomcolor);
    wait 1;
    thread oben(self,"2",level.randomcolor);
    wait 1;
    thread oben(self,"1",level.randomcolor);
    wait 3;
    thread unten(self,"FIGHT!!",level.randomcolor);
    self freezeControls(0);

    if(isdefined(level.sniper))
        self setroomgun("m40a3_mp","remington700_mp");

    if(isdefined(level.knife))
        self setroomgun("knife_mp","g36c_gl_mp");

    if(isdefined(level.deagle))
        self setroomgun("deserteagle_mp","deserteaglegold_mp");
}

setroomgun(weap,weap2)
{
    if(isdefined(weap))
    {
        self giveweapon(weap);
        self givemaxammo(weap);
    }
    if(isdefined(weap2))
    {
        self giveweapon(weap2);
        self givemaxammo(weap2);
    }
    self switchtoweapon(weap);
}