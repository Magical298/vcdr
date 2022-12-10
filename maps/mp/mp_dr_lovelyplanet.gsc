//   ________  ___  ___  _______   _______   ________   
//  |\   ____\|\  \|\  \|\  ___ \ |\  ___ \ |\   __  \  
//  \ \  \___|\ \  \\\  \ \   __/|\ \   __/|\ \  \|\  \ 
//   \ \_____  \ \   __  \ \  \_|/_\ \  \_|/_\ \   ____\
//    \|____|\  \ \  \ \  \ \  \_|\ \ \  \_|\ \ \  \___|
//      ____\_\  \ \__\ \__\ \_______\ \_______\ \__\   
//     |\_________\|__|\|__|\|_______|\|_______|\|__|   
//     \|_________|                                     
//  
/*
Map made by Sheep Wizard
youtube: http://www.youtube.com/user/paap15
RIP xf
Traps: 7
Difficulty: easy
Time to make: Forever
1 secret

Feel free to edit + take stuff from gsc

activation method
loadscreen

*/
#include maps\mp\_utility;

main()
{
    maps\mp\_load::main();

	 
	game["allies"] = "sas";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "woodland";
	game["axis_soldiertype"] = "woodland";
	
	//setdvar("g_speed" ,"190");
	//setdvar("dr_jumpers_speed" ,"1");
	
	level.fx_blue_star = loadFx( "lovely/bluestar" );
	level.fx_heart = loadFx( "lovely/heart" );
	level.fx_cloud1 = loadFx( "lovely/cloud1" );
	level.fx_cloud2 = loadFx( "lovely/cloud2" );
	level.fx_cloud3 = loadFx( "lovely/cloud3" );
	level.fx_cloud4 = loadFx( "lovely/cloud4" );

	precacheItem( "brick_blaster_mp" );

	setDvar("g_knockback", "1000");

	thread end();
	thread secret();
	thread rocket();
	thread onconnect();
	thread music();
	thread hearts();
	thread clouds();
	thread tele();
    thread actitele();
	thread bounce();
    thread trap_1();
	//thread trap_2(); Combined with trap 1
	thread trap_3();
	thread trap_4();
	thread trap_5();
	thread trap_6();
	thread trap_7();
	thread trap_8();

   if(!isdefined(level.vcQueueCustom))
   level.vcQueueCustom = (-9958,4294,494);

	level.tpdone = false;

	addTriggerToList( "trap1_trig" );
	addTriggerToList( "trap3_trig" );
	addTriggerToList( "trap4_trig" );
	addTriggerToList( "trap5_trig" );
	addTriggerToList( "trap6_trig" );
	addTriggerToList( "trap7_trig" );
	addTriggerToList( "trap8_trig" );

}

addTriggerToList( name )
{
   if( !isDefined( level.trapTriggers ) )
      level.trapTriggers = [];
   level.trapTriggers[level.trapTriggers.size] = getEnt( name, "targetname" );
}

end()
{
	trig = getEnt("end", "targetname");
	spot1 = getEnt("endorigin1", "targetname");
	spot2 = getEnt("endorigin2", "targetname");
	spot3 = getEnt("endorigin3", "targetname");
	spot4 = getEnt("endorigin4", "targetname");
	while(1)
	{
		trig waittill("trigger", player);
		player PlayLocalSound("ending");
		random = randomInt(4);
		switch(random)
		{
			case 0:
			player setOrigin(spot1.origin);
			break;
			case 1:
			player setOrigin(spot2.origin);
			break;
			case 2:
			player setOrigin(spot3.origin);
			break;
			case 3:
			player setOrigin(spot4.origin);
			break;
		}
		if(level.tpdone == false)
		{
			level.activ setOrigin(level.target.origin);
			level.tpdone = true;
		}
	}
}

secret()//Disable if you want
{
	brush = getEnt("secret_brush", "targetname");
	gettrigger("secret", "Swamp");
	ambientStop(2);
	wait 2;
	ambientPlay("secret");
	setExpFog(150, 200, 174/255, 174/255, 174/255, 3);
	while(1)
	{
		brush rotateYaw(360, 4);
		wait 4;
	}
}

rocket()
{
	brush = getEnt("rocket", "targetname");
	for(;;)
	{
		brush rotateroll(360, 120);
		wait 120;
	}
}

onconnect()
{
	level endon("game_ended");

	for(;;)
	{
		level waittill("connected", player);
		player setClientDvar("r_drawdecals", 1);
	}
}

music()
{
	song = [];
	song[0] = "lovelymusic1";
	song[1] = "lovelymusic2";
	song[2] = "lovelymusic3";
	random = randomInt(3);
	ambientPlay(song[random]);
}

hearts()//load fx
{	
	wait 3;
	origin = getEntArray("heart_origin", "targetname");
	for(i=0; i<origin.size; i++)
	{
	playFx( level.fx_heart, (origin[i].origin + (0,0,8)) );
	}
}

clouds()
{
	wait 3;
	cloud1 = getEntArray("cloud1_origin", "targetname");
	cloud2 = getEntArray("cloud2_origin", "targetname");
	cloud3 = getEntArray("cloud3_origin", "targetname");
	for(i=0; i<cloud1.size; i++)
	{
	playFx( level.fx_cloud1, cloud1[i].origin );
	}
	for(i=0; i<cloud2.size; i++)
	{
	playFx( level.fx_cloud2, cloud2[i].origin );
	}
	for(i=0; i<cloud3.size; i++)
	{
	playFx( level.fx_cloud3, cloud3[i].origin );
	}
}

tele()
{
    trig = getent("teleport_trig", "targetname");
    target = getent("teleport_target", "targetname");
	for(;;)
	{
	    trig waittill("trigger", player);
		player setOrigin(target.origin);
		//fx + sound
	}
}

actitele()
{
    trig = getent("acti_tele", "targetname");
	level.target = getent("acti_origin", "targetname");
	trig waittill("trigger", player);
	player setOrigin(level.target.origin);
	level.tpdone = true;
}

bounce()
{
	trig = getent("bounce", "targetname");
	
	while(1)
	{
    	trig waittill ( "trigger", player );
    	player playSound("booing");  
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

//Traps\\
gettrigger(trigname, hint)
{
    trig = getent(trigname, "targetname");
    trig setHintString( hint );
    trig waittill("trigger", player);
}

trap_1()
{
    spike = getEntArray("spikes", "targetname");
    spike_dmg0 = getent("spike_dmg0", "targetname");
	spike_dmg1 = getent("spike_dmg1", "targetname");
	spike_dmg2 = getent("spike_dmg2", "targetname");
	spike_dmg3 = getent("spike_dmg3", "targetname");
	wait 0.05;
	for(i=0; i<spike.size; i++)
	{
		spike[i] moveZ(-160, 0.1);
	}
	spike_dmg0 enablelinkto();
    spike_dmg0 linkto (spike[0]);
	spike_dmg1 enablelinkto();
    spike_dmg1 linkto (spike[1]);
    spike_dmg2 enablelinkto();
    spike_dmg2 linkto (spike[2]);
    spike_dmg3 enablelinkto();
    spike_dmg3 linkto (spike[3]);
    gettrigger("trap1_trig", "Trap 1");
    spike[0] moveZ(160, 1); spike[1] moveZ(160, 1); spike[2] moveZ(160, 1); spike[3] moveZ(160, 1);
    spike[0] waittill("movedone"); wait 3;
    spike[0] moveZ(-160, 1); spike[1] moveZ(-160, 1); spike[2] moveZ(-160, 1); spike[3] moveZ(-160, 1);
    spike[0] waittill("movedone");
	for(;;)
	{
	    random = randomInt(4);
		spike[random] moveZ (160, 1);
		spike[random] waittill("movedone");
		wait 1;
		spike[random] moveZ (-160, 1);
		spike[random] waittill("movedone");
		wait 1;
	}
}

trap_3()
{
    gettrigger("trap3_trig", "Trap 2");
    thread trap_3_a();
	thread trap_3_b();
	thread trap_3_c();
}

trap_3_a()
{
    enemy1 = getEnt("enemy1", "targetname");
	enemy1_dmg = getEnt("enemydmg1", "targetname");
	enemy1_origin1 = (2176, -1440, 72);
	enemy1_origin2 = (2276, -1768, 56);
	enemy1_dmg enablelinkto();
    enemy1_dmg linkto (enemy1);
	
    while(1)
	{
	    enemy1 moveTo(enemy1_origin1, 0.8);
		enemy1 rotateYaw (80,0.9);
		enemy1 waittill("movedone");
		wait 0.5;
		enemy1 moveTo(enemy1_origin2, 0.8);
		enemy1 rotateYaw (-80,0.9);
		enemy1 waittill("movedone");
		wait 0.5;
	}	
}

trap_3_b()
{
    enemy2 = getEnt("enemy2", "targetname");
	enemy2_dmg = getEnt("enemydmg2", "targetname");
	enemy2_origin1 = (2040, -1496, 72);
	enemy2_origin2 = (2180, -1816, 56);
	enemy2_dmg enablelinkto();
    enemy2_dmg linkto (enemy2);
    while(1)
	{
	    enemy2 moveTo(enemy2_origin2, 0.8);
		enemy2 rotateYaw (-80,0.9);
		enemy2 waittill("movedone");
		wait 0.2;
		enemy2 moveTo(enemy2_origin1, 0.8);
		enemy2 rotateYaw (80,0.9);
		enemy2 waittill("movedone");
		wait 0.2;
	}	
}

trap_3_c()
{
    enemy3 = getEnt("enemy3", "targetname");
	enemy3_dmg = getEnt("enemydmg3", "targetname");
	enemy3_origin1 = (1912, -1520, 72);
	enemy3_origin2 = (2052, -1856, 56);
	enemy3_dmg enablelinkto();
    enemy3_dmg linkto (enemy3);
    while(1)
	{
	    enemy3 moveTo(enemy3_origin1, 0.8);
		enemy3 rotateYaw (80,0.9);
		enemy3 waittill("movedone");
		wait 0.5;
		enemy3 moveTo(enemy3_origin2, 0.8);
		enemy3 rotateYaw (-80,0.9);
		enemy3 waittill("movedone");
		wait 0.5;
	}
}

trap_4()
{
    redblob = getEnt("redblob", "targetname");
	redblob_dmg = getEnt("redblob_dmg", "targetname");
	origin1 = (2676, -492, 44);
	origin2 = (2372, -916, 44);	
    redblob_dmg enablelinkto();
    redblob_dmg linkto (redblob);
    wait 0.05;
    redblob movex(-250, 0.1);
	gettrigger("trap4_trig", "Trap 3");	
	redblob moveTo(origin1, 1, 0.2, 0);
	redblob waittill("movedone");
	redblob moveTo(origin2, 1, 0, 0.2);
}

trap_5()
{
    level.redball = getEnt("redball", "targetname");
	redball_dmg = getEnt("redball", "targetname");
	sound = getEnt("bang_origin", "targetname");
	gettrigger("trap5_trig", "Trap 4");	
    thread spinball();
	sound playSound("bang");
	playFx( level.fx_blue_star, (redball_dmg.origin - (0,0,55)) );
	level.redball moveZ (452, 0.8, 0.1, 0.4);
	level.redball waittill("movedone");
	level.redball moveZ (-460, 0.7, 0.3, 0.1);
	level.redball waittill("movedone");
	radiusDamage (redball_dmg.origin, 640, 200, 200);//pretty sure this doesnt kill act :P
	wait 0.05;
	level.redball delete();
	sound playSound("splash");
}		
spinball()
{
    level.redball rotateYaw(250, 2.5);
}

trap_6()
{
    brush = getEnt("blue", "targetname");
	brush2 = getEnt("yellow", "targetname");
	brush3 = getEnt("plzno", "targetname");
	plzno_dmg = getEnt("plzno_dmg", "targetname");
	brush2 hide();
	wait 0.05;
	brush3 moveZ (-272, 0.1);
	gettrigger("trap6_trig", "Trap 5");	
	brush hide();
	brush2 show();
	brush3 moveZ (272, 1.6, 0.3, 0.3);
	plzno_dmg playSound("mine");
	brush3 waittill("movedone");
	wait 0.5;
	radiusDamage (plzno_dmg.origin, 288, 200, 200);
	//play fx
	wait 0.05;
	brush3 delete();
}

trap_7()//lame trap
{
	
	gettrigger("trap7_trig", "Trap 6");	
	thread trap_7_a();
	thread trap_7_b();
}
trap_7_a()
{
	brush = getEnt("blob1", "targetname");
	trig = getEnt("blob1_trig", "targetname");
	sound = getEnt("slurp1", "targetname");
	trig waittill("trigger", player);
	wait 2.5;
	sound playSound("slurp");
	brush notSolid();
	brush hide();
	wait 5;
	brush solid();
	brush show();
}
trap_7_b()
{
	brush = getEnt("blob2", "targetname");
	trig = getEnt("blob2_trig", "targetname");
	sound = getEnt("slurp1", "targetname");
	trig waittill("trigger", player);
	wait 2.5;
	sound playSound("slurp");
	brush notSolid();
	brush hide();
	wait 5;
	brush solid();
	brush show();
}

trap_8()
{
    trig = getEnt("bullet_trig", "targetname");
    level.firing = false;
    gettrigger("trap8_trig", "Trap 7");	
    while(1)
    {
        trig waittill("trigger", player);
        if( !isPlayer( player ) )
            continue; 
        if( level.firing == true )
        	return;
        shootbullet( player );
        
    }
}

shootbullet( victim )
{
	bulletorigin = (-8672, 3232, 512);
    bullet = getEnt("bullet", "targetname");
    trig = getEnt("bullet_hurt", "targetname"); 
   
    if(!isDefined(level.linkenabled))
    {
    	trig enableLinkTo();
    	trig linkto(bullet);
    	level.linkenabled = true;
	}
	level.firing = true;
    bullettarget = victim.origin;
    dist = distance(bulletorigin, bullettarget);
    bullet moveTo((bullettarget + (0,0,10)), (dist/1700));
    bullet waittill("movedone");
    bullet hide();
    trig triggerOff();
    bullet moveTo(bulletorigin, 0.1);
    bullet waittill("movedone");
    bullet show();
    trig triggerOn();
    level.firing = false;
}

	addQueueTrigger(name)
    {
        if(!isdefined(level.queue_triggers))
            level.queue_triggers = [];

        level.queue_triggers[level.queue_triggers.size] = getent(name,"targetname");
    }











