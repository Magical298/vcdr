main()
{
	maps\mp\_load::main();	

	level._effect["smoke"] = loadfx ("balaz98/mp_dr_simpsons_trap3");
	maps\mp\_fx::loopfx("smoke", (-640, 13600, -1344), 1, (-640, 13600, -1344));

	level.finish = 0;
	level.finishclose = 0;
	
//	ambientPlay("mp_simpsons");

	thread onPlayerConnect();
	thread sound( "mp_simpsons" );
	thread begin();
	thread trap1();
	thread trap2();
//	thread trap3();
	thread trap3door1();
	thread trap3door2();
	thread trap4();
	thread trap5();
	thread trap6load();
	thread trap6();
	thread trap7();
	thread trap8alap();
	thread trap8();
	thread finish();
	thread addtrapstofreerun();
	precacheItem( "remington700_mp" );
	level.sniperfirst = false;
	level.knifefirst = false;
}
onPlayerConnect()
{
	while(1)
	{
		level waittill("connected", player);
		player thread onDeath();
	}
}

onDeath()
{
	self endon("disconnect");
	
	while(1)
	{
		self waittill("death");
		players = getentarray("player", "classname");
		for(i=0;i<players.size;i++)
			players[i] PlayLocalSound("death");
	}
}
begin()
{
finisholdt = getent("finish_old_talaj","targetname");
finisholdt movez(-200, 3);
wait 1;
while(1)
{
	if( isDefined( game["state"] ) )
	{
		if( game["state"] == "playing" ) 
		{
			aa = getent("begin","targetname");
			wait 6;
			aa movez (-200, 3);
			aa waittill ("movedone");
			aa delete();
			break;
		}

	}
	else
	{
		aa = getent("begin","targetname");
		wait 6;
		aa movez (-200, 3);
		aa waittill ("movedone");
		aa delete();
		break;
	}
	wait .1;
}
}
sound( sound )
{
	for(;;) {
		level waittill("connected", player);
		player waittill("spawned_player");
		player PlaySound( sound );
	}

}
trap1()
{
trig = getent("trap1akti", "targetname");
aa = getent("trap1obj","targetname");
trig waittill( "trigger", who );
trig delete();
while(1)
{
    aa rotatePitch(360,10);
	aa waittill("rotatedone");
	wait .1;
}
}
trap2()
{
trig = getent("trap2akti", "targetname");
aa = getent("trap2_1","targetname");
aaa = getent("trap2_2","targetname");
trig waittill( "trigger", who );
trig delete();
while(1)
{

    aa rotateRoll(360,3);
	aaa rotateRoll(-360,3);
	aaa waittill("rotatedone");
    aa rotateRoll(360,3);
	aaa rotateRoll(-360,3);
	aaa waittill("rotatedone");
    aa rotateRoll(360,3);
	aaa rotateRoll(-360,3);
	aaa waittill("rotatedone");
	wait 15;
 }
}

trap3()
{
	trig = getent("trap3akti", "targetname");
/*	point1 = getent("smoke1", "targetname");
	dmg   =getent("dmg_trap3","targetname");
	sound   =getent("trap4_sound","targetname");

	fxObj1 = SpawnFx( level.afterburn_fx, point1.origin);
*/
	trig waittill ("trigger");
	trig delete();
	iprintlnBold("Trap 3 is not ready!!");
/*	thread trap3_1();
	sound PlaySound ("steam");
	triggerFx (fxObj1);
	
	wait 5;
	dmg delete();
	level notify ("trap4_stop");
	wait 2;
	fxObj1 delete();
*/	
}
/*
trap3_1()
{
	level endon ("trap4_stop");
	dmg   =getent("dmg_trap4","targetname");


	while(1)
	{
	wait 0.00001;
	players = getentarray("player", "classname");

		for( i = 0; i < players.size; i++ )
		{
			if( !isDefined( players[i].gas ) && players[i] isTouching( dmg ) && players[i].sessionstate == "playing")
			{		
			players[i] thread kill();
			players[i].gas =true;
			}
		}
	}
}

kill()
{
	level endon ("kill_stop");
	self endon("disconnect");
	self endon("death");

	while(1)
	{
	self shellshock( "tabun_gas_mp", 7 );
	self PlayLocalSound( "gas" );
	self PlayLocalSound( "gas" );
	self PlayLocalSound( "gas" );
	self PlayLocalSound( "gas" );
	self PlayLocalSound( "gas" );
	self PlayLocalSound( "gas" );

	wait 7.8;
	self suicide();
	}
}
*/
trap3door1()
{
trig = getent("trap3do1", "targetname");
aa = getent("trap3door1","targetname");
while(1)
{
trig waittill( "trigger", who );
   aa movez (-200, 3);
   aa waittill ("movedone");
   wait 2;
   aa movez (200, 3);
   aa waittill ("movedone");
wait .1;
}
}
trap3door2()
{
trig = getent("trap3do2", "targetname");
aa = getent("trap3door2","targetname");
while(1)
{
trig waittill( "trigger", who );
   aa movez (-200, 3);
   aa waittill ("movedone");
   wait 2;
   aa movez (200, 3);
   aa waittill ("movedone");
wait .1;
}
}

trap4()
{
trig = getent("trap4akti", "targetname");
aa = getent("trap4_1","targetname");
aaa = getent("trap4_2","targetname");
aaaa = getent("trap4_3","targetname");
trig waittill( "trigger", who );
trig delete();
	aa rotateRoll(-17.5,1);
	aaa rotateRoll(17.5,1);
	aaaa rotateRoll(-17.5,1);
	aaaa waittill("rotatedone");
while(1)
{
    aa rotateRoll(35,1);
	aaa rotateRoll(-35,1);
	aaaa rotateRoll(35,1);
	aaaa waittill("rotatedone");
    aa rotateRoll(-35,1);
	aaa rotateRoll(35,1);
	aaaa rotateRoll(-35,1);
	aaaa waittill("rotatedone");

}
}
trap5()
{
trig = getent("trap5akti", "targetname");
del = getent("trap5del","targetname");
trap5_1 = getent("trap5_1","targetname");
trap5_2 = getent("trap5_2","targetname");
trap5_3 = getent("trap5_3","targetname");
trap5_4 = getent("trap5_4","targetname");
trap5_5 = getent("trap5_5","targetname");
trig waittill( "trigger", who );
trig delete();

del delete();
trap5_1 movey(130, 1);
trap5_2 movey(-130, 1);
trap5_3 movey(130, 1);
trap5_4 movey(-130, 1);
trap5_5 movey(130, 1);
trap5_5 waittill("movedone");
wait 2;
trap5_1 movey(-130, 1);
trap5_2 movey(130, 1);
trap5_3 movey(-130, 1);
trap5_4 movey(130, 1);
trap5_5 movey(-130, 1);
trap5_5 waittill("movedone");

}
trap6load()
{
	aa = getent("trap6_2","targetname");
	aa movez (-200, 3);
	aa waittill ("movedone");
}
trap6()
{
trig = getent("trap6akti", "targetname");
aa = getent("trap6_1","targetname");
aaa = getent("trap6_2","targetname");
trig waittill( "trigger", who );
trig delete();
while(1)
{
   aa movez (-200, 4);
   aaa movez (200, 4);
   aaa waittill ("movedone");
   wait 1;
   aa movez (200, 4);
   aaa movez (-200, 4);
   aaa waittill ("movedone");
   wait 2;
   
}
}
trap7()
{
trig = getent("trap7akti", "targetname");
aa = getent("trap7obj","targetname");
trig waittill( "trigger", who );
trig delete();
aa rotateYaw(360,1);
aa waittill("rotatedone");
aa rotateYaw(360,1);
aa waittill("rotatedone");
aa rotateYaw(360,1);
aa waittill("rotatedone");

}

trap8alap()
{
aa = getent("trap8obj", "targetname");
while(1)
{
aa movex(900, 5);
aa waittill("movedone");
wait 1;
aa movex(-900, 5);
aa waittill("movedone");
wait 1;
}
}

trap8()
{
trig = getent("trap8akti", "targetname");
aa = getent("trap8leloko","targetname");
trig waittill( "trigger", who );
trig delete();
aa movey ( -380, 3 );
aa waittill("movedone");
wait 5;
aa movey ( 380, 3 );
aa waittill("movedone");

}


finish()
{
finishjel = getent("finisherzekelo","targetname");
finishjel waittill( "trigger", who);
iprintlnBold( "^1"+ who.name+ " ^2finished map!\n^4Map by: Balaz98,Popeye" );

if(level.finish == 0)
{
block1 = getent("block1","targetname");
block2 = getent("block2","targetname");
block3 = getent("block3","targetname");
block4 = getent("block4","targetname");
block1 movez(-200, 3);
block2 movez(-200, 3);
block3 movez(-200, 3);
block4 movez(-200, 3);
level.finish = 1;
}
thread initfinish();

}
initfinish()
{
thread finish_old();
thread finish_sniper();
thread finish_knife();
thread finish_jump();
}

finish_old()
{
finishold = getent("finishold","targetname");
finishsniper = getent("finishsniper","targetname");
finishknife = getent("finishknife","targetname");
finishjump = getent("finishjump","targetname");

finishold waittill( "trigger", who);

if( level.finishclose == 0 )
{
finishold delete();
finishsniper delete();
finishknife delete();
finishjump delete();

block1 = getent("block1","targetname");
block2 = getent("block2","targetname");
block3 = getent("block3","targetname");
block4 = getent("block4","targetname");
block1 movez(200, 3);
//block2 movez(200, 3);
block3 movez(200, 3);
block4 movez(200, 3);

iprintlnBold( "^2The finish: ^1OLD^7!" );
finisholdt = getent("finish_old_talaj","targetname");
finish_old_clip = getent("finish_old_clip","targetname");
finishaktijelzo = getent("finishaktijelzo","targetname");

finisholdt movez(200, 3);
finish_old_clip delete();
finishaktijelzo delete();

finisholdt waittill("movedone");
//door movez -200
bejarat1 = getent("bejarat1","targetname");
bejarat2 = getent("bejarat2","targetname");
bejarat3 = getent("bejarat3","targetname");
bejarat4 = getent("bejarat4","targetname");
bejarat2 movez(-300, 3);

thread finish_old_door();
}
}
finish_old_door()
{
finish_old_autodoor = getent("finish_old_autodoor","targetname");
finish_old_autodoor waittill( "trigger", who);
finish_old_door = getent("finish_old_door","targetname");
finish_old_door movez(-300, 3);
iprintlnBold( "^7OLD Door ^1opened!" );
}
finish_sniper()
{
finishold = getent("finishold","targetname");
finishsniper = getent("finishsniper","targetname");
finishknife = getent("finishknife","targetname");
finishjump = getent("finishjump","targetname");
while(1)
{
finishsniper waittill( "trigger", who);

// ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(who))
			continue;
		// =====================================
if( level.finishclose == 0 )
{
level.finishclose = 1;
finishold delete();
//finishsniper delete();
finishknife delete();
finishjump delete();
iprintlnBold( "^2The finish: ^1sniper^7!" );
block1 = getent("block1","targetname");
block2 = getent("block2","targetname");
block3 = getent("block3","targetname");
block4 = getent("block4","targetname");
block1 movez(200, 3);
block2 movez(200, 3);
//block3 movez(200, 3);
block4 movez(200, 3);
block4 waittill("movedone");

finishaktijelzo = getent("finishaktijelzo","targetname");

finishaktijelzo delete();

//door movez -200
bejarat1 = getent("bejarat1","targetname");
bejarat2 = getent("bejarat2","targetname");
bejarat3 = getent("bejarat3","targetname");
bejarat4 = getent("bejarat4","targetname");
//bejarat2 movez(-300, 3);
level.firstend = 1;
}
else
{
iprintlnBold( "^3"+ who.name+ "^2 entered to sniper room!" );
wait .2;
level.firstend = 0;
}
finish_sniper_spawnjumper = getent("finish_sniper_spawnjumper","targetname");
finish_sniper_spawnakti = getent("finish_sniper_spawnakti","targetname");
who SetPlayerAngles(( who.angles[0],0, who.angles[2] ));
who SetOrigin( finish_sniper_spawnjumper.origin  );
who TakeAllWeapons();
who GiveWeapon("remington700_mp");
	players = getentarray("player", "classname");
	for(i=0;i<players.size;i++)
	{
		if( isAlive(players[i]) && players[i].pers["team"] != "spectator" )
		{
			if( players[i].pers["team"] == "allies" )
			{
				//players[i] SetPlayerAngles(( players[i].angles[0],0, players[i].angles[2] ));
				//players[i] SetOrigin((-696,-744,-216));
				//iprintlnbold("jumpers");
			}
			if( players[i].pers["team"] == "axis" )
			{
				players[i] SetPlayerAngles( players[i].angles[0], 0, players[i].angles[2] );
				players[i] SetOrigin(finish_sniper_spawnakti.origin);
				//iprintlnbold("activator");
				players[i] TakeAllWeapons();
				players[i] GiveWeapon("remington700_mp");
				wait 0.01;
				players[i] SwitchToWeapon("remington700_mp");
			}

		}
	}
who SwitchToWeapon("remington700_mp");

	if( level.firstend == 1 )
		iprintlnbold("^1 S   N   I   P   E   R  ^7!");
}
}

finish_knife()
{
level endon ("finishvalasztvas");
finishold = getent("finishold","targetname");
finishsniper = getent("finishsniper","targetname");
finishknife = getent("finishknife","targetname");
finishjump = getent("finishjump","targetname");
while(1)
{
finishknife waittill( "trigger", who);

// ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(who))
			continue;
		// =====================================
if( level.finishclose == 0 )
{
level.finishclose = 1;

finishold delete();
finishsniper delete();
//finishknife delete();
finishjump delete();
iprintlnBold( "^2The finish: ^1Knife^7!" );
block1 = getent("block1","targetname");
block2 = getent("block2","targetname");
block3 = getent("block3","targetname");
block4 = getent("block4","targetname");
//block1 movez(200, 3);
block2 movez(200, 3);
block3 movez(200, 3);
block4 movez(200, 3);
block4 waittill("movedone");

finishaktijelzo = getent("finishaktijelzo","targetname");

finishaktijelzo delete();

//door movez -200
bejarat1 = getent("bejarat1","targetname");
bejarat2 = getent("bejarat2","targetname");
bejarat3 = getent("bejarat3","targetname");
bejarat4 = getent("bejarat4","targetname");
//bejarat2 movez(-300, 3);
level.firstend = 1;
}
else
{
iprintlnBold( "^3"+ who.name+ "^2 entered to knife room!" );
wait .2;
level.firstend = 0; 
}
finish_knife_spawnjumper = getent("finish_knife_spawnjumper","targetname");
finish_knife_spawnakti = getent("finish_knife_spawnakti","targetname");
who SetPlayerAngles(( who.angles[0],0, who.angles[2] ));
who SetOrigin( finish_knife_spawnjumper.origin  );
who TakeAllWeapons();
who GiveWeapon("knife_mp");


	players = getentarray("player", "classname");
	for(i=0;i<players.size;i++)
	{
		if( isAlive(players[i]) && players[i].pers["team"] != "spectator" )
		{
			if( players[i].pers["team"] == "allies" )
			{
				//players[i] SetPlayerAngles(( players[i].angles[0],0, players[i].angles[2] ));
				//players[i] SetOrigin((-696,-744,-216));
				//iprintlnbold("jumpers");
			}
			if( players[i].pers["team"] == "axis" )
			{
				players[i] SetPlayerAngles( players[i].angles[0], 0, players[i].angles[2] );
				players[i] SetOrigin(finish_knife_spawnakti.origin);
				//iprintlnbold("activator");
				players[i] TakeAllWeapons();
				players[i] GiveWeapon("knife_mp");
				wait 0.01;
				players[i] SwitchToWeapon("knife_mp");
			}

		}
	}
who SwitchToWeapon("knife_mp");

 if( level.firstend == 1 )
	iprintlnbold("^1   K   N   I   F   E   ^7!");

}

}
finish_jump()
{
level endon ("finishvalasztvas");
finishold = getent("finishold","targetname");
finishsniper = getent("finishsniper","targetname");
finishknife = getent("finishknife","targetname");
finishjump = getent("finishjump","targetname");
while(1)
{
finishjump waittill( "trigger", who);

// ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(who))
			continue;
		// =====================================
if( level.finishclose == 0 )
{
level.finishclose = 1;

finishold delete();
finishsniper delete();
finishknife delete();
//finishjump delete();
iprintlnBold( "^2The finish: ^1Jump^7!" );
block1 = getent("block1","targetname");
block2 = getent("block2","targetname");
block3 = getent("block3","targetname");
block4 = getent("block4","targetname");
block1 movez(200, 3);
block2 movez(200, 3);
block3 movez(200, 3);
//block4 movez(200, 3);
block3 waittill("movedone");

finishaktijelzo = getent("finishaktijelzo","targetname");

finishaktijelzo delete();

//door movez -200
bejarat1 = getent("bejarat1","targetname");
bejarat2 = getent("bejarat2","targetname");
bejarat3 = getent("bejarat3","targetname");
bejarat4 = getent("bejarat4","targetname");
//bejarat2 movez(-300, 3);
level.firstend = 1;
thread initjumpfinish();
}
else
{
iprintlnBold( "^3"+ who.name+ "^2 finished the map!" );
wait .2;
level.firstend = 0;
}

finish_jump_spawnjumper = getent("finish_jump_spawnjumper","targetname");
finish_jump_spawnakti = getent("finish_jump_spawnakti","targetname");
who SetPlayerAngles(( who.angles[0],0, who.angles[2] ));
who SetOrigin( finish_jump_spawnjumper.origin  );
who TakeAllWeapons();
who GiveWeapon("knife_mp");

	players = getentarray("player", "classname");
	for(i=0;i<players.size;i++)
	{
		if( isAlive(players[i]) && players[i].pers["team"] != "spectator" )
		{
			if( players[i].pers["team"] == "allies" )
			{
				//players[i] SetPlayerAngles(( players[i].angles[0],0, players[i].angles[2] ));
				//players[i] SetOrigin((-696,-744,-216));
				//iprintlnbold("jumpers");
			}
			if( players[i].pers["team"] == "axis" )
			{
				players[i] SetPlayerAngles( players[i].angles[0], 0, players[i].angles[2] );
				players[i] SetOrigin(finish_jump_spawnakti.origin);
				//iprintlnbold("activator");
				players[i] TakeAllWeapons();
				players[i] GiveWeapon("knife_mp");
				wait 0.01;
				players[i] SwitchToWeapon("knife_mp");
			}

		}
	}
who SwitchToWeapon("knife_mp");

 if( level.firstend == 1 )
	iprintlnbold("^1    J   U   M   P   ^7!");

}
}
initjumpfinish()
{
finish_jump_spawnjumper = getent("finish_jump_spawnjumper","targetname");
finish_jump_spawnakti = getent("finish_jump_spawnakti","targetname");
initjumpfinish = getent("finish_jump_respawn","targetname");

	while(1)
	{
		initjumpfinish waittill( "trigger", who);
	
		if( isAlive(who) && who.pers["team"] != "spectator" )
		{
			if( who.pers["team"] == "allies" )
			{
				who SetPlayerAngles(( who.angles[0],0, who.angles[2] ));
				who SetOrigin(finish_jump_spawnjumper.origin);
				//iprintlnbold("jumpers");
			}
			if( who.pers["team"] == "axis" )
			{
				who SetPlayerAngles( who.angles[0], 0, who.angles[2] );
				who SetOrigin(finish_jump_spawnakti.origin);
				//iprintlnbold("activator");
			}
			who TakeAllWeapons();
			who GiveWeapon("knife_mp");
			wait 0.01;
			who SwitchToWeapon("knife_mp");
		}	
	}
}
addTriggerToList( name )
{
   if( !isDefined( level.trapTriggers ) )
      level.trapTriggers = [];
   level.trapTriggers[level.trapTriggers.size] = getEnt( name, "targetname" );
}
addtrapstofreerun()
{
	addTriggerToList("trap1akti");
	addTriggerToList("trap2akti");
	addTriggerToList("trap3akti");
	addTriggerToList("trap4akti");
	addTriggerToList("trap5akti");
	addTriggerToList("trap6akti");
	addTriggerToList("trap7akti");
	addTriggerToList("trap8akti");	
}

	addQueueTrigger(name)
    {
        if(!isdefined(level.queue_triggers))
            level.queue_triggers = [];

        level.queue_triggers[level.queue_triggers.size] = getent(name,"targetname");
    }
