//map by Freek Also visit http://infocrawlers.blogspot.com/ for DR plugins and other Essentials
main()
{
maps\mp\_load::main();
	
        PreCacheItem("deserteaglegold_mp");
        PreCacheItem("winchester1200_mp");
        PreCacheItem("skorpion_mp");
        PreCacheItem("remington700_mp");
        PreCacheItem("knife_mp");
	
	ambientPlay("edward");

	trig = spawn("trigger_radius",(-958,-1913,380),0,150,150);
	trig.radius = 150;
	trig.targetname = "endmap_trig";

	
	addTriggerToList( "t1" );
		addTriggerToList( "t2" );
		addTriggerToList( "t3" );
		addTriggerToList( "t4" );
		addTriggerToList( "t5" );
		addTriggerToList( "t6" );
		addTriggerToList( "t7" );
		addTriggerToList( "t8" );
	
thread rotate();
thread trap1();
thread trap2();
thread trap3();
thread trap4();
thread trap5();
thread trap6();
thread trap7();
thread trap8();
thread givesniper();
thread sniper_room();
thread knife_room();
}


givesniper()
{
        trigger = getEnt("wepsniper", "targetname");
        precacheItem("remington700_mp");    
        while(1)
        {
                trigger waittill("trigger", player);
                player takeallweapons();
                player GiveWeapon("remington700_mp");
                player SwitchToWeapon( "remington700_mp" );
        }
}


addTriggerToList( name )
{
    if( !isDefined( level.trapTriggers ) )
        level.trapTriggers = [];
    level.trapTriggers[level.trapTriggers.size] = getEnt( name, "targetname" );
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
		wait 2;
		}
	
}


trap2()
{
brush = getEnt ("b2", "targetname");
trig = getEnt ("t2", "targetname");
trig waittill ("trigger");
trig delete();

brush moveY (-544,1);
wait 2;
brush moveY (544,1);
}

trap3()
{
brush = getEnt ("b3", "targetname");
trig = getEnt ("t3", "targetname");
trig waittill ("trigger");
trig delete();

brush moveY (280,1);
wait 2;
brush moveY (-280,1);
}

trap4()
{
brush = getEnt ("b4", "targetname");
trig = getEnt ("t4", "targetname");
trig waittill ("trigger");
trig delete();


brush moveX (528,0.1);
wait 2;
brush moveX (-528,0.1);
}


trap5()
{
brush = getEnt ("b5", "targetname");
trig = getEnt ("t5", "targetname");
trig waittill ("trigger");
trig delete();

brush moveZ (-480,1);
wait 1;
brush moveZ (480,1);
}

rotate()
{
brush = getEnt ("rotate", "targetname");

while(1)
{
brush rotateYaw (360,3);
wait 1;
}
}

trap6()
{
brush = getEnt ("b6", "targetname");
trig = getEnt ("t6", "targetname");
trig waittill ("trigger");
trig delete();

brush moveZ (-680,1);
wait 5;
brush moveZ (680,1);

}

trap7()
{
brush = getEnt ("b7", "targetname");
trig = getEnt ("t7", "targetname");
trig waittill ("trigger");
trig delete();

brush moveZ (-480,1);
wait 5;;
brush moveZ (480,1);
}


trap8()
{
brush = getEnt ("b8", "targetname");
trig = getEnt ("t8", "targetname");
trig waittill ("trigger");
trig delete();


brush moveZ (480,1);
wait 5;;
brush moveZ (-480,1);
}


/*
sniper_room()
{
    level.sniper_trig = getEnt( "sniper_room", "targetname");
        jump = getEnt( "sniper_jump", "targetname" );
        acti = getEnt( "sniper_acti", "targetname");
   
        while(1)
        {
                level.sniper_trig waittill( "trigger", player );

                

                if( !isDefined( level.sniper_trig ) )
                level.wall_trig delete();
                level.knife_trig delete();
                                 
                                     
                player SetPlayerAngles( jump.angles );
                player setOrigin( jump.origin );
                player TakeAllWeapons();
                player GiveWeapon( "remington700_mp" );        
                level.activ setPlayerangles( acti.angles );
                level.activ setOrigin( acti.origin );
                level.activ TakeAllWeapons();
                level.activ GiveWeapon( "remington700_mp" );          
                wait 0.05;
                player switchToWeapon( "remington700_mp" );
                level.activ SwitchToWeapon( "remington700_mp" );
                iPrintlnBold( " ^6" + player.name + " has chosen snipe room!" );               
                while( isAlive( player ) && isDefined( player ) )
                wait 1;
        }
}     

*/
/*
knife_room()
{
    level.knife_trig = getEnt( "kroom", "targetname");
        jump = getEnt( "knife_jump", "targetname");
        acti = getEnt( "knife_acti", "targetname");
   
        while(1)
        {
                level.knife_trig waittill( "trigger", player );
                if( !isDefined( level.knife_trig ) )

               
                level.sniper_trig delete();
                level.wall_trig delete();
                                 
                                     
                player SetPlayerAngles( jump.angles );
                player setOrigin( jump.origin );
                player TakeAllWeapons();
                player GiveWeapon( "tomahawk_mp" );            
                level.activ setPlayerangles( acti.angles );
                level.activ setOrigin( acti.origin );
                level.activ TakeAllWeapons();
                level.activ GiveWeapon( "tomahawk_mp" );              
                wait 0.05;
                player switchToWeapon( "tomahawk_mp" );
                level.activ SwitchToWeapon( "tomahawk_mp" );
                iPrintlnBold( " ^6" + player.name + " has chosen knife room" );                
                while( isAlive( player ) && isDefined( player ) )
                wait 1;
        }
}
 

*/


sniper_room()
{
	while(1)
	{
		level.trigsniper = getEnt("sniper_room","targetname");
		acti = getEnt("sniper_jump","targetname");
		jump = getEnt("sniper_acti","targetname");
		
		
		level.trigsniper waittill("trigger", player);

		// ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================

		
		level.trigknife delete();
                level.wall_trig delete();
		
		player setOrigin (jump.origin);
		player setPlayerAngles (jump.angles);

		level.activ setOrigin (acti.origin);
		level.activ setPlayerAngles (acti.angles);
	
		player takeAllWeapons();
		level.activ takeAllWeapons();

		player.maxhealth = 100;
		player.health = player.maxhealth;
		level.activ.maxhealth = 100;
		level.activ.health = level.activ.maxhealth;  
		
		player takeAllWeapons();
		player giveWeapon("remington700_mp");
		player giveMaxAmmo("remington700_mp");
		player giveWeapon("m40a3_mp");
		player giveMaxAmmo("m40a3_mp");
		player switchToWeapon("m40a3_mp");
		
		level.activ takeAllWeapons();
		level.activ giveWeapon("remington700_mp");
		level.activ giveMaxAmmo("remington700_mp");
		level.activ giveWeapon("m40a3_mp");
		level.activ giveMaxAmmo("m40a3_mp");
		level.activ switchToWeapon("m40a3_mp");

		while( isAlive( player ) && isDefined( player ) && player.sessionstate == "playing" )
		wait 0.5;
		player = undefined;	
	}
}



 knife_room()
{
	while(1)
	{
		level.trigknife = getEnt("kroom","targetname");
		acti = getEnt("knife_jump","targetname");
		jump = getEnt("knife_jump","targetname");
		
		
		level.trigknife waittill("trigger", player);

		// ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================
		
		
		level.trigsniper delete();
                level.wall_trig delete();
		
		player setOrigin (jump.origin);
		player setPlayerAngles (jump.angles);

		level.activ setOrigin (acti.origin);
		level.activ setPlayerAngles (acti.angles);
	
		player takeAllWeapons();
		level.activ takeAllWeapons();
		
		player.maxhealth = 100;
		player.health = player.maxhealth;
		level.activ.maxhealth = 100;
		level.activ.health = level.activ.maxhealth;  
		
		player takeAllWeapons();
		player giveWeapon("knife_mp");
		player switchToWeapon("knife_mp");
		
		level.activ takeAllWeapons();
		level.activ giveWeapon("knife_mp");
		level.activ switchToWeapon("knife_mp");

		while( isAlive( player ) && isDefined( player ) && player.sessionstate == "playing" )
		wait 0.5;
		player = undefined;	
	}
}
