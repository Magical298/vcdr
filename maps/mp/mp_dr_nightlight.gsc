main()
{
        maps\mp\_load::main();
	
        PreCacheItem("deserteaglegold_mp");
        PreCacheItem("winchester1200_mp");
        PreCacheItem("skorpion_mp");
        PreCacheItem("remington700_mp");
	//ambientPlay("fk");

        thread trap1();
        thread trap2();
        thread trap3();
        thread trap4();
        thread trap5();
        thread trap6();
        thread trap7();
        thread trap8();
        thread trap9();
        thread givesniper();
        thread sniper_room();
        thread knife_room();
        thread messages();
        thread music();

        addTriggerToList("t1"); 
	addTriggerToList("t2");
	addTriggerToList("t3");
	addTriggerToList("t4");
	addTriggerToList("t5");
	addTriggerToList("t6");
	addTriggerToList("t7");
	addTriggerToList("t8");
	addTriggerToList("t9");
}

addTriggerToList( name ) 
{
    if( !isDefined( level.trapTriggers ) )
    level.trapTriggers = [];
    level.trapTriggers[level.trapTriggers.size] = getEnt( name , "targetname" );
}

messages()
{
        level waittill("round_started");
        iPrintLn("Map Fixes By: ^3VC'Fox");
}


music()
{
        trig = getEnt ("music1", "targetname");
        level waittill("round_started");
        trig delete();
}

 	 
givesniper()
{
        trig = getEnt("wepsniper", "targetname");
        level waittill("round_started");
        trig delete();
}


trap1()
{
brush = getEnt ("b1", "targetname");
trig = getEnt ("t1", "targetname");
trig waittill ("trigger");
trig delete();

while(1)
{
        brush rotateroll (360, 2);
        wait 4;
        }
	
}


trap2()
{
b = getEnt ("b2a" , "targetname");
b2 = getEnt ("b2b" , "targetname");
trig = getEnt ("t2", "targetname");
trig waittill ("trigger" , player );
trig delete();
while (1)
{
b moveZ (50,1);
wait 1;
b2 moveZ (-50,1);
wait 1;
b moveZ (-50,1);
wait 1;
b2 moveZ (50,1);
wait 1;
}
}

trap3()
{
b = getEnt ("b3a" , "targetname");
b2 = getEnt ("b3b" , "targetname");
trig = getEnt ("t3", "targetname");
trig waittill ("trigger" , player );
trig delete();
while (1)
{
b moveZ (50,1);
wait 1;
b2 moveZ (-50,1);
wait 1;
b moveZ (-50,1);
wait 1;
b2 moveZ (50,1);
wait 1;
}
}

trap4()
{
brush = getEnt ("b4", "targetname");
trig = getEnt ("t4", "targetname");
trig waittill ("trigger" , player);
trig delete();

  brush moveY (512, 2);
  wait 2;
  brush moveY (-512,2);
  wait 2;
			
}

trap5()
{
brush = getEnt ("b5", "targetname");
trig = getEnt ("t5", "targetname");
trig waittill ("trigger");
trig delete();

  brush moveZ (-512, 2);
  wait 2;
  brush moveZ (512,2);
  wait 2;
			
}

trap6()
{
trap1a = getent ("b6a", "targetname");
trap1b = getent ("b6b", "targetname");
trig1 = getent ("t6", "targetname");

trig1 waittill ("trigger");
trig1 delete();

	for(;;)
	{
		trap1a rotateRoll (-360, 3);
		trap1b rotateRoll (360, 3);
		wait 3;
	}
}

trap7()
{
brush = getEnt ("b7", "targetname");
trig = getEnt ("t7", "targetname");
trig waittill ("trigger");
trig delete();

for(;;)
	{
		brush rotateRoll (-360, 3);
		wait 3;
	}
 
}

trap8()
{
brush = getEnt ("b8", "targetname");
trig = getEnt ("t8", "targetname");
trig waittill ("trigger");
trig delete();

for(;;)
	{
		brush rotateRoll (360, 3);
		wait 3;
	}
 
}

trap9()
{
brush = getEnt ("b9", "targetname");
trig = getEnt ("t9", "targetname");
trig waittill ("trigger");
trig delete();

for(;;)
	{
		brush rotateRoll (-360, 3);
		wait 3;
	}
 
}

            


sniper_room()
{
	level.snip = getEnt("sniper_room", "targetname");
	acti = getEnt("sniper_acti", "targetname");
	jumper = getEnt("sniper_jump", "targetname");
	
	while(1)
	{
		level.snip waittill("trigger", player);
		if(!isDefined(level.snip))
		return;

		// ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================

		level.knife delete();

		player SetPlayerAngles(jumper.angles);
		player setOrigin(jumper.origin);
		player TakeAllWeapons();
		player GiveWeapon("remington700_mp");
		player GiveMaxAmmo("remington700_mp");
		player GiveWeapon("m40a3_mp");
		player giveMaxAmmo("m40a3_mp");
		player switchToWeapon("m40a3_mp");

		level.activ setPlayerangles(acti.angles);
		level.activ setOrigin(acti.origin);
		level.activ TakeAllWeapons();
		level.activ GiveWeapon("remington700_mp");
		level.activ GiveMaxAmmo("remington700_mp");
		level.activ GiveWeapon("m40a3_mp");
		level.activ GiveMaxAmmo("m40a3_mp");
		level.activ SwitchToWeapon("m40a3_mp");

		player freezeControls(1);
		level.activ freezeControls(1);
		
  		iPrintlnBold(" ^6" + player.name + " ^4 has chosen ^1snipe room!");
		wait 1;
		player iPrintLnBold("^73");
		level.activ iPrintLnBold("^73");
		wait 1;
		player iPrintLnBold("^52");
		level.activ iPrintLnBold("^52");
		wait 1;
		player iPrintLnBold("^71");
		level.activ iPrintLnBold("^71");
		wait 1;
		player iPrintLnBold("^5FIGHT");
		level.activ iPrintLnBold("^5FIGHT");

		player freezeControls(0);
		level.activ freezeControls(0);

		while(isAlive(player) && isDefined(player))
		wait 1;
	}
}


knife_room()
{
	level.knife = getEnt("knife_room", "targetname");
	acti = getEnt("knife_acti", "targetname");
	jumper = getEnt("knife_jump", "targetname");
	
	while(1)
	{
		level.knife waittill("trigger", player);
		if(!isDefined(level.knife))
		return;

		// ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================

		level.snip delete();

		player SetPlayerAngles(jumper.angles);
		player setOrigin(jumper.origin);
		player TakeAllWeapons();
		player GiveWeapon("knife_mp");
		player switchToWeapon("knife_mp");

		level.activ setPlayerangles (acti.angles);
		level.activ setOrigin(acti.origin);
		level.activ TakeAllWeapons();
		level.activ GiveWeapon("knife_mp");
		level.activ SwitchToWeapon("knife_mp");

		player freezeControls(1);
		level.activ freezeControls(1);
		
  		iPrintlnBold("^6" + player.name + " ^3has chosen ^1knife room");     
		wait 1;
		player iPrintLnBold("^73");
		level.activ iPrintLnBold("^73");
		wait 1;
		player iPrintLnBold("^52");
		level.activ iPrintLnBold("^52");
		wait 1;
		player iPrintLnBold("^71");
		level.activ iPrintLnBold("^71");
		wait 1;
		player iPrintLnBold("^5FIGHT");
		level.activ iPrintLnBold("^5FIGHT");

		player freezeControls(0);
		level.activ freezeControls(0);

		while(isAlive(player) && isDefined(player))
		wait 1;
	}
}
