/*
___________.__           .____    .__          _____          ____    __________.__           .__  .__        
\__    ___/|  |__   ____ |    |   |__|__  ____/ ____\____    /  _ \   \______   \  |__   ____ |  | |__|__  ___
  |    |   |  |  \_/ __ \|    |   |  \  \/  /\   __\/ __ \   >  _ </\  |     ___/  |  \_/ __ \|  | |  \  \/  /
  |    |   |   Y  \  ___/|    |___|  |>    <  |  | \  ___/  /  <_\ \/  |    |   |   Y  \  ___/|  |_|  |>    < 
  |____|   |___|  /\___  >_______ \__/__/\_ \ |__|  \___  > \_____\ \  |____|   |___|  /\___  >____/__/__/\_ \
                \/     \/        \/        \/           \/         \/                \/     \/              \/
.:: Map name: mp_dr_urban ::.
.:: Authors: TheLixfe & Phelix ::.
*/

main()
{
	maps\mp\_load::main();	

	// Map dvars
	setdvar( "r_specularcolorscale", "1" );
	setdvar("r_glowbloomintensity0",".25");
	setdvar("r_glowbloomintensity1",".25");
	setdvar("r_glowskybleedintensity0",".3");

	// Precaches

	PreCacheItem("remington700_acog_mp");
	PreCacheItem("urbangun_mp");
	PreCacheItem("ak47_mp");
	PreCacheItem("remington700_mp");
	PreCacheItem("m40a3_mp");
	PreCacheItem("deserteagle_mp");
	PreCacheItem("deserteaglegold_mp");
	PreCacheItem("knife_mp");
    PreCacheItem("dragunov_mp");
    PreCacheItem("p90_mp");
    PreCacheItem("mp5_mp");
    PreCacheItem("saw_mp");
    PreCacheItem("uzi_mp");
    PreCacheItem("ak74u_mp");
    PreCacheItem("mp44_mp");

	level.barrelplode=loadfx("explosions/default_explosion");
	level.groundplode=loadfx("explosions/urbangroundy");
	level.urbanfaller=loadfx("explosions/urbanfaller");

    //Trigger list
    level.deagle_trig = getEnt("deagleroom_ent", "targetname");
    level.knife_trig = getEnt("kniferoom_ent", "targetname");
    level.snip_trig = getEnt("sniproom_ent", "targetname");
    level.ak_trig = getEnt("akroom_ent", "targetname");
    level.random_trig = getEnt("randomroom_ent", "targetname");

    level.triggerlist = [];
    level.triggerlist[level.triggerlist.size] = level.deagle_trig;
    level.triggerlist[level.triggerlist.size] = level.knife_trig;
    level.triggerlist[level.triggerlist.size] = level.snip_trig;
    level.triggerlist[level.triggerlist.size] = level.ak_trig;
    level.triggerlist[level.triggerlist.size] = level.random_trig;
    level.triggerlist[level.triggerlist.size] = level.rooms_trig;

	addTriggerToList("trig_drift");
	addTriggerToList("trig_rotate");
	addTriggerToList("trig_floor1");
	addTriggerToList("trig_faller");
	addTriggerToList("trig_roller");
	addTriggerToList("trig_platfall");
	addTriggerToList("trig_platdrop");
	addTriggerToList("trig_ladders");
	addTriggerToList("trig_barrel");

    //random room array
    level.weaponList = [];
    level.weaponList[level.weaponList.size] = "dragunov_mp";
    level.weaponList[level.weaponList.size] = "p90_mp";
    level.weaponList[level.weaponList.size] = "mp5_mp";
    level.weaponList[level.weaponList.size] = "saw_mp";
    level.weaponList[level.weaponList.size] = "uzi_mp";
    level.weaponList[level.weaponList.size] = "ak74u_mp";
    level.weaponList[level.weaponList.size] = "mp44_mp";
    level.random = randomInt(level.weaponList.size);

    //default variables
    level.in_end_room = false;

	// Threads
	thread secret();
	thread start();
	thread vc_urbangun();
	thread secretwep();
	thread a_nothing();
	thread old_room();
	thread end_tp_rooms();
    thread endroom_deagle();
    thread endroom_knife();
    thread endroom_snip();
    thread endroom_ak();
    thread endroom_random();
    thread old_room();
    thread creators();
	thread trap_drift();
	thread trap_rotate();
	thread trap_floor1();
	thread trap_faller();
	thread trap_roller();
	thread trap_platfall();
	thread trap_platdrop();
	thread trap_ladders();
	thread trap_barrel();
}

addTriggerToList( name )
{
   if( !isDefined( level.trapTriggers ) )
      level.trapTriggers = [];
   level.trapTriggers[level.trapTriggers.size] = getEnt( name, "targetname" );
}

secret()
{
	wall = getEnt( "secret_wtf", "targetname" );
	wall notSolid();
}

start()
{
    object = getEnt( "startdoor", "targetname" );
    clip = getEnt( "start_clip", "targetname" );

    wait 1;

    ambientPlay("urban");

    wait 21.9;

    iPrintLnBold("^1mp_dr_urban by TheLixfe & Phelix");

    clip delete();
    object rotateRoll(90,2);
}

vc_urbangun()
{
	trigger = getEnt( "trig_vc_urbangun", "targetname" );
	object = getEnt( "vc_urbangun", "targetname" );

	trigger waittill ( "trigger", player );
	object delete();

	player giveWeapon( "urbangun_mp" );
	player giveMaxAmmo( "urbangun_mp" );
	player switchToWeapon( "urbangun_mp" );
	trigger setHintString( "Someone has already taken the gun!" );
}

old_room()
{
    trigger = getEnt("oldroom_ent", "targetname");
    doors1 = getEnt("old_doors1", "targetname");
    doors2 = getEnt("old_doors2", "targetname");
    doors1_2 = getEnt("old2_doors1", "targetname");
    doors2_2 = getEnt("old2_doors2", "targetname");
    clip = getEnt("old_clip", "targetname");
    rotplank = getEnt("rotplank", "targetname");
    plank = getEnt("old_plank", "targetname");
    trigger waittill("trigger" , player);
    
    for(i = 0; i < level.triggerlist.size; i++)
    {
        level.triggerlist[i] delete();
    }

    doors1 moveY(-52, 2);
    doors2 moveY(52, 2);
    doors1_2 moveX(52, 2);
    doors2_2 moveX(-52, 2);
    plank moveX(-68, 2);
    rotplank rotateRoll(52, 2, 2);
    wait 2;

    clip delete();
    trigger delete();
    
}

end_tp_rooms()
{
    endroom_door = getEnt ("end_door", "targetname");
	jumper = getEnt("end_go", "targetname");

	while(1)
	{
   		endroom_door waittill("trigger", player);

         // ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================
        
        if(!isDefined(endroom_door) || level.in_end_room)
            return;

        level.in_end_room = true;
        endroom_door setHintString("Someone is already in there");
		player setPlayerAngles(jumper.angles);
        player setOrigin(jumper.origin);

        while(isAlive(player) && isDefined(player))
            wait 1;
        endroom_door setHintString("Press ^3[USE] ^7to enter Rooms-section");
        level.in_end_room = false;
	}
}

died()
{
        self endon("disconnect");
 
        self waittill("death");
        iPrintlnBold("^2"+self.name+" ^5died^1!");
}

endroom_deagle()
{
    trigger = getEnt("deagleroom_ent", "targetname");
    jumper = getEnt("2ndfloor_go", "targetname");
    acti = getEnt("2ndfloor_go", "targetname");

    while(1)
    {
        trigger waittill("trigger", player);

        player setPlayerAngles(jumper.angles);
        player setOrigin(jumper.origin);
        player TakeAllWeapons();
        player giveWeapon("deserteagle_mp");
        player giveMaxAmmo("deserteagle_mp");
        player switchToWeapon("deserteagle_mp");

        level.activ setPlayerAngles(acti.angles);
        level.activ setOrigin(acti.origin);
        level.activ TakeAllWeapons();
        level.activ giveWeapon("deserteagle_mp");
        level.activ giveMaxAmmo("deserteagle_mp");
        level.activ switchToWeapon("deserteagle_mp");

	 	ambientstop();
        ambientplay("imlay");
        level.canPlaySound=false;

        iPrintlnBold( " ^7" + player.name + " Entered The ^1Deagle ^7room." );
        wait 0.05;
        player freezecontrols(1);
        level.activ freezecontrols(1);
        wait 1;
        player iPrintlnBold("^13");
        level.activ iPrintlnBold("^13");
        wait 1;
        player iPrintlnBold("^12");
        level.activ iPrintlnBold("^12");
        wait 1;
        player iPrintlnBold("^11");
        level.activ iPrintlnBold("^11");
        wait 1;
        player iPrintlnBold("^1FIGHT^7!");
        level.activ iPrintlnBold("^1FIGHT^7!");
        player freezecontrols(0);
        level.activ freezecontrols(0);

        while(isAlive(player) && isDefined(player))
            wait 1;
    }
}

endroom_knife()
{
    trigger = getEnt("kniferoom_ent", "targetname");
    jumper = getEnt("2ndfloor_go", "targetname");
    acti = getEnt("2ndfloor_go", "targetname");

    while(1)
    {
        trigger waittill("trigger", player);

        player setPlayerAngles(jumper.angles);
        player setOrigin(jumper.origin);
        player TakeAllWeapons();
        player giveWeapon("knife_mp");
        player switchToWeapon("knife_mp");

        level.activ setPlayerAngles(acti.angles);
        level.activ setOrigin(acti.origin);
        level.activ TakeAllWeapons();
        level.activ giveWeapon("knife_mp");
        level.activ switchToWeapon("knife_mp");

	 	ambientstop();
        ambientplay("imlay");
        level.canPlaySound=false;

        iPrintlnBold( " ^7" + player.name + " Entered The ^1Knife ^7room." );
        wait 0.05;
        player freezecontrols(1);
        level.activ freezecontrols(1);
        wait 1;
        player iPrintlnBold("^13");
        level.activ iPrintlnBold("^13");
        wait 1;
        player iPrintlnBold("^12");
        level.activ iPrintlnBold("^12");
        wait 1;
        player iPrintlnBold("^11");
        level.activ iPrintlnBold("^11");
        wait 1;
        player iPrintlnBold("^1FIGHT^7!");
        level.activ iPrintlnBold("^1FIGHT^7!");
        player freezecontrols(0);
        level.activ freezecontrols(0);

        while(isAlive(player) && isDefined(player))
            wait 1;
    }
}

endroom_snip()
{
    trigger = getEnt("sniproom_ent", "targetname");
    jumper = getEnt("3rdfloor_go", "targetname");
    acti = getEnt("3rdfloor_acti", "targetname");

    while(1)
    {
        trigger waittill("trigger", player);

        player setPlayerAngles(jumper.angles);
        player setOrigin(jumper.origin);
        player TakeAllWeapons();
        player giveWeapon("remington700_mp");
		player giveMaxAmmo("remington700_mp");
        player switchToWeapon("remington700_mp");

        level.activ setPlayerAngles(acti.angles);
        level.activ setOrigin(acti.origin);
        level.activ TakeAllWeapons();
        level.activ giveWeapon("remington700_mp");
		level.activ giveMaxAmmo("remington700_mp");
        level.activ switchToWeapon("remington700_mp");

	 	ambientstop();
        ambientplay("imlay");
        level.canPlaySound=false;

        iPrintlnBold( " ^7" + player.name + " Entered The ^1Sniper ^7room." );
        wait 0.05;
        player freezecontrols(1);
        level.activ freezecontrols(1);
        wait 1;
        player iPrintlnBold("^13");
        level.activ iPrintlnBold("^13");
        wait 1;
        player iPrintlnBold("^12");
        level.activ iPrintlnBold("^12");
        wait 1;
        player iPrintlnBold("^11");
        level.activ iPrintlnBold("^11");
        wait 1;
        player iPrintlnBold("^1FIGHT^7!");
        level.activ iPrintlnBold("^1FIGHT^7!");
        player freezecontrols(0);
        level.activ freezecontrols(0);

        while(isAlive(player) && isDefined(player))
            wait 1;
    }
}

endroom_ak()
{
    trigger = getEnt("akroom_ent", "targetname");
    jumper = getEnt("3rdfloor_go", "targetname");
    acti = getEnt("3rdfloor_acti", "targetname");

    while(1)
    {
        trigger waittill("trigger", player);

        player setPlayerAngles(jumper.angles);
        player setOrigin(jumper.origin);
        player TakeAllWeapons();
        player giveWeapon("ak47_mp");
		player giveMaxAmmo("ak47_mp");
        player switchToWeapon("ak47_mp");

        level.activ setPlayerAngles(acti.angles);
        level.activ setOrigin(acti.origin);
        level.activ TakeAllWeapons();
        level.activ giveWeapon("ak47_mp");
		level.activ giveMaxAmmo("ak47_mp");
        level.activ switchToWeapon("ak47_mp");

	 	ambientstop();
        ambientplay("imlay");
        level.canPlaySound=false;

        iPrintlnBold( " ^7" + player.name + " Entered The ^1AK ^7room." );
        wait 0.05;
        player freezecontrols(1);
        level.activ freezecontrols(1);
        wait 1;
        player iPrintlnBold("^13");
        level.activ iPrintlnBold("^13");
        wait 1;
        player iPrintlnBold("^12");
        level.activ iPrintlnBold("^12");
        wait 1;
        player iPrintlnBold("^11");
        level.activ iPrintlnBold("^11");
        wait 1;
        player iPrintlnBold("^1FIGHT^7!");
        level.activ iPrintlnBold("^1FIGHT^7!");
        player freezecontrols(0);
        level.activ freezecontrols(0);

        while(isAlive(player) && isDefined(player))
            wait 1;
    }
}

endroom_random()
{
    trigger = getEnt("randomroom_ent", "targetname");
    jumper = getEnt("3rdfloor_go", "targetname");
    acti = getEnt("3rdfloor_acti", "targetname");

    while(1)
    {
        trigger waittill("trigger", player);

        player setPlayerAngles(jumper.angles);
        player setOrigin(jumper.origin);
        player TakeAllWeapons();
        player giveWeapon(level.weaponList[level.random]);
		player giveMaxAmmo(level.weaponList[level.random]);
        player switchToWeapon(level.weaponList[level.random]);

        level.activ setPlayerAngles(acti.angles);
        level.activ setOrigin(acti.origin);
        level.activ TakeAllWeapons();
        level.activ giveWeapon(level.weaponList[level.random]);
		level.activ giveMaxAmmo(level.weaponList[level.random]);
        level.activ switchToWeapon(level.weaponList[level.random]);

	 	ambientstop();
        ambientplay("imlay");
        level.canPlaySound=false;

        iPrintlnBold( " ^7" + player.name + " Entered The ^1Random weapon" );
        wait 0.05;
        player freezecontrols(1);
        level.activ freezecontrols(1);
        wait 1;
        player iPrintlnBold("^13");
        level.activ iPrintlnBold("^13");
        wait 1;
        player iPrintlnBold("^12");
        level.activ iPrintlnBold("^12");
        wait 1;
        player iPrintlnBold("^11");
        level.activ iPrintlnBold("^11");
        wait 1;
        player iPrintlnBold("^1FIGHT^7!");
        level.activ iPrintlnBold("^1FIGHT^7!");
        player freezecontrols(0);
        level.activ freezecontrols(0);

        while(isAlive(player) && isDefined(player))
            wait 1;
    }
}

/*
endroom_deagle()
{
    endroom_template("deagleroom_ent", "2ndfloor_go", "2ndfloor_go", "deserteagle_mp", "deserteaglegold_mp", "Deagle");
}


endroom_knife()
{
    endroom_template("kniferoom_ent", "2ndfloor_go", "2ndfloor_acti", "knife_mp", undefined, "Knife");
}


endroom_snip()
{
    endroom_template("sniproom_ent", "3rdfloor_go", "3rdfloor_acti", "remington700_mp", "m40a3_mp", "Sniper");
}

endroom_ak()
{
    endroom_template("akroom_ent", "3rdfloor_go", "3rdfloor_acti", "ak47_mp", undefined, "AK");
}

endroom_random()
{
    endroom_template("randomroom_ent", "3rdfloor_go", "3rdfloor_acti", level.weaponList[level.random], undefined, "Random weapon");
}
*/
creators()
{
    wait(15);
    iPrintlnBold("^7Map by ^3TheLixfe ^7and ^3Phelix");

    wait(30);
    iprintln("^7Map by ^5TheLixfe ^7and ^3Phelix");
}

trap_drift()
{
	clip = getent( "drift_clip", "targetname" );
	trigger = getent( "trig_drift", "targetname" );
	car = getent ("drift_model","targetname");
	kill = getent("drift_kill","targetname");
	kill maps\mp\_utility::triggeroff();
	trigger waittill ("trigger", player);
	trigger SetHintString("^1Activated");
	player braxi\_rank::giveRankXP("", 30);
	kill maps\mp\_utility::triggeron();
	kill enablelinkto ();
	kill linkto (clip);
	car linkto (clip);
	while(1)
	{
		clip rotateyaw (-1080,10);
		clip waittill ("rotatedone");
	}
}

trap_rotate()
{
	wait 5;
	object = getent ("trap_rotate","targetname");
	trigger = getent ("trig_rotate","targetname");
	trigger waittill ("trigger", player);
	trigger SetHintString("^1Activated");
	player braxi\_rank::giveRankXP("", 30);
	object movez(-200,1);
	object waittill ("movedone");
	wait 4;
	object movez(200,4);
	thread trap_rotate_yaw();
}
trap_rotate_yaw()
{
	object = getent ("trap_rotate","targetname");
	while(1)
	{
		object rotateyaw(1080,2,1,0.5);
		object waittill ("rotatedone");
		wait 2;
		object rotateyaw(-1080,2,1,0.5);
		object waittill ("rotatedone");
		wait 2;
	}
}
trap_floor1()
{
	wait 5;
	object = getent ("trap_floor1","targetname");
	object2 = getent ("floor1_cracks","targetname");
	groundefx = getent ("floor1_efx","targetname");
	trigger = getent ("trig_floor1","targetname");
	object2 hide();
	trigger waittill ("trigger", player);
	trigger SetHintString("^1Activated");
	player braxi\_rank::giveRankXP("", 30);
	playfx(level.groundplode,groundefx.origin);
	groundefx playSound ("groundplode");
	object2 show();
	object delete();
}
trap_faller()
{
	trig = getEnt ("trig_faller","targetname");
	kill = getEnt ("faller_kill","targetname");
	efx1 = getEnt ("faller_efx1","targetname");
	efx2 = getEnt ("faller_efx2","targetname");
	efx3 = getEnt ("faller_efx3","targetname");
	efx4 = getEnt ("faller_efx4","targetname");
	object = getEnt ("trap_faller","targetname");
	clip = getEnt ("faller_clip","targetname");
	clip notSolid();
	kill maps\mp\_utility::triggeroff();
	trig waittill ("trigger", player);
	trig SetHintString("^1Activated");
	player braxi\_rank::giveRankXP("", 30);
	kill maps\mp\_utility::triggeron();
	kill enablelinkto ();
	kill linkto (object);
	object rotatepitch(-90,1.5,0.5);
	thread faller_clip();
	object waittill ("rotatedone");
	playfx(level.urbanfaller,efx1.origin);
	playfx(level.urbanfaller,efx2.origin);
	playfx(level.urbanfaller,efx3.origin);
	playfx(level.urbanfaller,efx4.origin);
	kill delete();
}
faller_clip()
{
	clip = getEnt ("faller_clip","targetname");
	wait 1.5;
	clip Solid();
}
trap_roller()
{
	object = getent ("trap_roller","targetname");
	trigger = getent ("trig_roller","targetname");
	kill = getent ("roller_kill","targetname");
	kill maps\mp\_utility::triggeroff();
	trigger waittill ("trigger", player);
	trigger SetHintString("^1Activated");
	player braxi\_rank::giveRankXP("", 30);
	kill maps\mp\_utility::triggeron();
	kill enablelinkto ();
	kill linkto (object);
	thread roller_updown();
	thread roller_rotate();
	wait 9;
	kill delete();
}
roller_updown()
{
	object = getent ("trap_roller","targetname");
	object movez(-212,4);
	object waittill ("movedone");
	object movey(-629,3);
}
roller_rotate()
{
	object = getent ("trap_roller","targetname");
	object rotateyaw (270,4);
}
trap_platfall()
{
	trigger = getEnt ("trig_platfall","targetname");
	kill = getEnt ("platfall_kill","targetname");
	efx = getEnt ("platfall_efx","targetname");
	object = getEnt ("trap_platfall","targetname");
	trigger waittill ("trigger", player);
	trigger SetHintString("^1Activated");
	player braxi\_rank::giveRankXP("", 30);
	kill enablelinkto ();
	kill linkto (object);
	object movez(-257,1,0.5);
	object waittill ("movedone");
	playfx(level.urbanfaller,efx.origin);
	kill delete();
}
trap_platdrop()
{
	trigger = getEnt ("trig_platdrop","targetname");
	object = getEnt ("trap_platdrop","targetname");
	trigger waittill ("trigger", player);
	trigger SetHintString("^1Activated");
	player braxi\_rank::giveRankXP("", 30);
	object rotateroll(-80,1,0.2,0.8);
	object waittill ("rotatedone");
	wait 5;
	object rotateroll (80,1,0.2,0.8);
}
trap_ladders()
{
	trigger = getEnt ("trig_ladders","targetname");
	object = getEnt ("trap_ladders","targetname");
	trigger waittill ("trigger", player);
	trigger SetHintString("^1Activated");
	player braxi\_rank::giveRankXP("", 30);
	object delete();
}
trap_barrel()
{
	trigger = getEnt ("trig_barrel","targetname");
	object = getEnt ("trap_barrel","targetname");
	clip = getEnt ("barrel_clip","targetname");
	brlfx = getEnt ("barrel_efx","targetname");
	kill = getEnt ("barrel_kill","targetname");
	kill maps\mp\_utility::triggeroff();
	trigger waittill ("trigger", player);
	trigger SetHintString("^1Activated");
	player braxi\_rank::giveRankXP("", 30);
	kill maps\mp\_utility::triggeron();
	brlfx playSound ("barrelplode");
	playfx(level.barrelplode,brlfx.origin);
	object delete();
	clip delete();
	wait 0.2;
	kill delete();
}
secretwep()
{
	trig=getent("ak_secret","targetname");
	for(;;)
	{
		trig waittill("trigger",who);
		who giveweapon("ak74u_mp");
		who givemaxammo("ak74u_mp");
		who switchtoweapon("ak74u_mp");
		who iprintlnbold("You got ^6ak74u!");
		wait 1;
	}
}
a_nothing()
{
	trig = getEnt ("a_nothing", "targetname");
	end = getEnt ("a_nothing_go", "targetname");
	while(1)
    	{
        trig waittill ("trigger", player);
	player freezecontrols(true);
	player SetOrigin(end.origin);
        player SetPlayerAngles( end.angles );
	player iPrintlnBold("^1u tryin to be cheeky w this ele?");
        wait 1;
	player iPrintlnBold("^1too bad u gotta wait now and dats boring");
        wait 1;
	player iPrintlnBold("^11137");
        wait 1;
	player iPrintlnBold("^169");
        wait 1;
	player iPrintlnBold("^110");
        wait 1;
	player iPrintlnBold("^19");
        wait 1;
	player iPrintlnBold("^18");
        wait 1;
        player iPrintlnBold("^17");
        wait 1;
        player iPrintlnBold("^16");
        wait 1;
	player iPrintlnBold("^15");
        wait 1;
	player iPrintlnBold("^14");
        wait 1;
	player iPrintlnBold("^13");
        wait 1;
        player iPrintlnBold("^12");
        wait 1;
        player iPrintlnBold("^11");
        wait 1;
	player iPrintlnBold("^1cunt ^5l2p");
	player freezecontrols(false);
	player braxi\_rank::giveRankXP("", 1);
	}
}