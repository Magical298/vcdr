/*

      _ _            _ _            _ _       
     | (_)          | (_)          | (_)      
   __| |_  ___    __| |_  ___    __| |_  ___  
  / _` | |/ _ \  / _` | |/ _ \  / _` | |/ _ \ 
 | (_| | |  __/ | (_| | |  __/ | (_| | |  __/ 
  \__,_|_|\___|  \__,_|_|\___|  \__,_|_|\___| 
                                              
                                              
=================================================


  _ _____   _  _   _    _    _    ____  _____ 
 (_) ____|_| || |_| |  | |  | |  |___ \| ____|
  _| |__ |_  __  _| | _| | _| | __ __) | |__  
 | |___ \ _| || |_| |/ / |/ / |/ /|__ <|___ \ 
 | |___) |_  __  _|   <|   <|   < ___) |___) |
 |_|____/  |_||_| |_|\_\_|\_\_|\_\____/|____/ 




                                              
	
          _____                                  
         /\    \                 ______          
        /::\    \               |::|   |         
       /::::\    \              |::|   |         
      /::::::\    \             |::|   |         
     /:::/\:::\    \            |::|   |         
    /:::/__\:::\    \           |::|   |         
   /::::\   \:::\    \          |::|   |         
  /::::::\   \:::\    \         |::|   |         
 /:::/\:::\   \:::\    \  ______|::|___|___ ____ 
/:::/  \:::\   \:::\____\|:::::::::::::::::|    |
\::/    \:::\  /:::/    /|:::::::::::::::::|____|
 \/____/ \:::\/:::/    /  ~~~~~~|::|~~~|~~~      
          \::::::/    /         |::|   |         
           \::::/    /          |::|   |         
           /:::/    /           |::|   |         
          /:::/    /            |::|   |         
         /:::/    /             |::|   |         
        /:::/    /              |::|   |         
        \::/    /               |::|___|         
         \/____/                 ~~              
                                                 
This map is created & scripted by i5#kkk35,
Have fun :)
----------------------------------------
Traps: 9							   -
Secrets: 2							   -
Rooms: Sniper, Knife, Jump, RPG, Old   -
Map difficulty: Easy-Medium            -                  
Map size: Small  					   -
----------------------------------------
*/
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
main()
{
	//All of Scripts traps n secrets, all :>
	thread door();
	thread trap1();
	thread trap2();
	thread trap3();
	thread trap4();
	thread trap5();
	thread trap6();
	thread trap7();
	thread trap8();
	thread trap9();

	thread ax();

	thread old_door();
	thread Sniper();
	thread Knife();
	thread kisszar();
	thread Jump();
	thread fail();
	thread jump_snip();
	thread Rpg();
	thread rpg_kell();

	thread music();

	thread vip_aku();
	thread vip_snip();
	thread vip_deagle();
	thread kifele();

	thread secret();
	thread easybe();
	thread hardba();
	thread rpg_h();
	thread hard_fail1();
	thread hard_fail2();
	thread hard_fail3();
	thread hard_fail4();
	thread ez_fail();
	thread ez_finish();
	thread hard_finish();


	PreCacheItem("rpg_mp");
	PreCacheItem("ak74u_mp");


	addTriggerToList("trap1_t");
	addTriggerToList("trap2_t");
	addTriggerToList("trap3_t");
	addTriggerToList("trap4_t");
	addTriggerToList("trap5_t");
	addTriggerToList("trap6_t");
	addTriggerToList("trap7_t");
	addTriggerToList("trap8_t");
	addTriggerToList("trap9_t");
	
}

door()
{
	brush = GetEnt("door_s","targetname");

	wait 15;
	IPrintLnBold("Door is opening in ^55 ^7seconds...");
	wait 2;
	IPrintLnBold("Door is opening in ^53 ^7seconds...");
	wait 1;
	IPrintLnBold("Door is opening in ^52 ^7seconds...");
	wait 1;
	IPrintLnBold("Door is opening in ^51 ^7seconds...");
	wait 1;
	brush moveZ(-242, 2);
	IPrintLnBold("^5GO GO GO^7!");
	wait 3;
	brush delete();

}
trap1()
{
	trig = GetEnt("trap1_t","targetname");
	brush1=getEnt("trap1_1","targetname");
	brush2=getEnt("trap1_2","targetname");

	trig sethintstring("Press ^5[USE] ^7to activate");
	trig waittill ("trigger", player);
	trig sethintstring("Activated^5!");

	brush1 RotateRoll(360,3);
	brush2 RotatePitch(360,3);
}

trap2()
{
	trig = GetEnt("trap2_t","targetname");
	brush1=getEnt("trap2_1","targetname");
	brush2=getEnt("trap2_2","targetname");

	trig sethintstring("Press ^5[USE] ^7to activate");
	trig waittill ("trigger", player);
	trig sethintstring("Activated^5!");

	while(1)
	{
		brush1 RotateRoll(-720, 1.5);
		wait 0.1;
		brush2 RotateRoll(720, 1.5);
		wait 5;
	}
}
trap3()
{
	trig = getEnt("trap3_t","targetname");
	brush = getEnt("trap3", "targetname");

	trig sethintstring("Press ^5[USE] ^7to activate");
	trig waittill ("trigger", player);
	trig sethintstring("Activated^5!");

	while(1)
	{
		brush RotateYaw(360,1.8);
		wait 0.1;
	}
}
trap4()
{
	trig = getEnt("trap4_t","targetname");

	brush=getEnt("trap4","targetname");
	dmg=getEnt("trap4_dmg","targetname");

	brush NotSolid();
	brush Hide();
	dmg TriggerOff();

	trig sethintstring("Press ^5[USE] ^7to activate");
	trig waittill ("trigger", player);
	trig sethintstring("Activated^5!");

	while(1)
	{
		brush Solid();
		brush Show();
		dmg TriggerOn();

		wait 3;

		brush NotSolid();
		brush Hide();
		dmg TriggerOff();

		wait 3;
	}

}

trap5()
{
	trig = getEnt("trap5_t","targetname");
	brush = getEnt("trap5","targetname");
	dmg = getEnt("trap5_dmg","targetname");

	dmg enablelinkto();
	dmg linkto(brush);

	trig sethintstring("Press ^5[USE] ^7to activate");
	trig waittill ("trigger", player);
	trig sethintstring("Activated^5!");


	brush moveZ(60, 0.5);
	wait 2;
	brush moveZ(-60, 1.5);
}

trap6()
{
	trig = getEnt("trap6_t","targetname");
	brush1 = getEnt("trap6_1","targetname");
	brush2 = getEnt("trap6_2","targetname");
	dmg = getEnt("trap6_dmg","targetname");

	dmg TriggerOff();
	brush1 NotSolid();
	brush1 Hide();

	dmg enablelinkto();

	trig sethintstring("Press ^5[USE] ^7to activate");
	trig waittill ("trigger", player);
	trig sethintstring("Activated^5!");

	dmg TriggerOn();
	dmg linkto(brush1);
	brush1 Solid();
	brush1 Show();

	brush2 RotateYaw(360,2);
	brush1 moveX(700, 3);
	wait 5;
	brush1 moveX(-700,3);
	wait 5;


	brush1 Delete();
	dmg delete();
}
trap7()
{
	trig =getEnt("trap7_t","targetname");

	b1=getEnt("trap7_1","targetname");
	b2=getEnt("trap7_2","targetname");
	b3=getEnt("trap7_3","targetname");
	b4=getEnt("trap7_4","targetname");
	b5=getEnt("trap7_5","targetname");
	b6=getEnt("trap7_6","targetname");
	b7=getEnt("trap7_7","targetname");

	trig sethintstring("Press ^5[USE] ^7to activate");
	trig waittill ("trigger", player);
	trig sethintstring("Activated^5!");

	while(1)
	{
		b1 RotateYaw(360,1.5);
		wait 0.01;
		b2 RotateYaw(-360,1.5);
		wait 0.01;
		b3 RotateYaw(360,1.5);
		wait 0.01;
		b4 RotateYaw(-360,1.5);
		wait 0.01;
		b5 RotateYaw(360,1.5);
		wait 0.01;
		b6 RotateYaw(-360,1.5);
		wait 0.01;
		b7 RotateYaw(360, 1.5);
		wait 0.01;
	}
}

trap8()
{
	trig =getEnt("trap8_t","targetname");
	brush =getEnt("trap8","targetname");

	trig sethintstring("Press ^5[USE] ^7to activate");
	trig waittill ("trigger", player);
	trig sethintstring("Activated^5!");

	brush delete();
}

trap9()
{
	trig =getEnt("trap9_t","targetname");
	brush =getEnt("trap9","targetname");

	brush NotSolid();
	brush Hide();

	trig sethintstring("Press ^5[USE] ^7to activate");
	trig waittill ("trigger", player);
	trig sethintstring("Activated^5!");

	brush Show();
	brush Solid();

	brush moveY(-256, 1);
	wait 3;
	brush delete();

}

addTriggerToList( name )
{
	if( !isDefined( level.trapTriggers ) )
	level.trapTriggers = [];
	level.trapTriggers[level.trapTriggers.size] = getEnt( name, "targetname" );
}

ax()
{
	for(;;)
	{
	wait 10;
	iprintln ("Visit: ^5ax-servers.hu");
	wait 10;
	iprintln ("Thanks for playing on ^5our ^7map^5!");
	wait 10;
	IPrintLn("Map created for ^1[^3AX^1] ^7Community!");
	wait 10;
	IPrintLn("Have Fun^5! :>");
	}
}

old_door()
{
	level.old_trig =getEnt("old_trig","targetname");
	door_e =getent("old_door","targetname");

	level.old_trig sethintstring("^5OLD ^7WAY For nub Activator! :>");
	level.old_trig waittill ("trigger", player);
	level.old_trig delete();

	level.sniper_trig delete();
	level.knife_trig delete();
	level.jump_trig delete();
	level.rpg_trig delete();

	wait 1;
	iPrintLnBold("^5" + player.name + " ^7has choosen OLD");
	door_e Delete();
}

Sniper()
{
	level.sniper_trig = getEnt( "sniper_trig", "targetname");
	jump = getEnt( "sniper_j", "targetname" );
	acti = getEnt( "sniper_a", "targetname" );
	
	while(1)
	{
		level.sniper_trig SetHintstring ("^5Snipah ^7Fight");
		level.sniper_trig waittill( "trigger", player );
		level.sniper_trig SetHintstring ("^5Wait...");
		if( !isDefined( level.sniper_trig ) )
			return;

		// ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================

		level.knife_trig delete();
		level.jump_trig delete();
		level.rpg_trig delete();
		level.old_trig delete();

		player SetPlayerAngles( jump.angles );
		player setOrigin( jump.origin );
		player TakeAllWeapons();
		player GiveWeapon( "remington700_mp" );
		player GiveWeapon( "m40a3_mp" );
		player giveMaxAmmo( "remington700_mp" );
		player giveMaxAmmo( "m40a3_mp" );
		level.activ setPlayerangles( acti.angles );
		level.activ setOrigin( acti.origin );
		level.activ TakeAllWeapons();
		level.activ GiveWeapon( "remington700_mp" );
		level.activ GiveWeapon( "m40a3_mp" );
		level.activ GiveMaxAmmo( "remington700_mp" );
		level.activ GiveMaxAmmo( "m40a3_mp" );
		player freezeControls(1);
		level.activ freezeControls(1);
		wait 0.05;
		player switchToWeapon( "remington700_mp" );
		player switchToWeapon( "m40a3_mp" );
		level.activ SwitchToWeapon( "remington700_mp" );
		level.activ switchToWeapon( "m40a3_mp" );
		//level.activ setclientDvar("cg_fovscale", 1.3);
		//player setclientDvar("cg_fovscale", 1.3);
  		iPrintLnBold("^5" + player.name + " ^7has choosen Sniper!");
		wait 1;
		player iPrintLnBold("^53");
		level.activ iPrintLnBold("^53");
		wait 1;
		player iPrintLnBold("^52");
		level.activ iPrintLnBold("^52");
		wait 1;
		player iPrintLnBold("^51");
		level.activ iPrintLnBold("^51");
		wait 1;
		player iPrintLnBold("^5FIGHT^3!");
		level.activ iPrintLnBold("^5FIGHT^3!");
		player freezeControls(0);
		level.activ freezeControls(0);
		while( isAlive( player ) && isDefined( player ) )
		wait 1;
	}
}
Knife()
{
	level.knife_trig = getEnt( "knife_trig", "targetname");
	jump = getEnt( "knife_j", "targetname" );
	acti = getEnt( "knife_a", "targetname" );
	
	while(1)
	{
		level.knife_trig SetHintstring ("^5Knife ^7Fight");
		level.knife_trig waittill( "trigger", player );
		level.knife_trig SetHintstring ("^5Wait...");
		if( !isDefined( level.knife_trig ) )
			return;

		// ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================

		level.sniper_trig delete();
		level.jump_trig delete();
		level.rpg_trig delete();
		level.old_trig delete();

		player SetPlayerAngles( jump.angles );
		player setOrigin( jump.origin );
		player TakeAllWeapons();
		player GiveWeapon( "knife_mp" );
		player giveMaxAmmo( "knife_mp" );
		level.activ setPlayerangles( acti.angles );
		level.activ setOrigin( acti.origin );
		level.activ TakeAllWeapons();
		level.activ GiveWeapon( "knife_mp" );
		level.activ GiveMaxAmmo( "knife_mp" );
		player freezeControls(1);
		level.activ freezeControls(1);
		wait 0.05;
		player switchToWeapon( "knife_mp" );
		level.activ SwitchToWeapon( "knife_mp" );
		//level.activ setclientDvar("cg_fovscale", 1.3);
		//player setclientDvar("cg_fovscale", 1.3);
  		iPrintLnBold("^5" + player.name + " ^7has choosen Knife!");
		wait 1;
		player iPrintLnBold("^53");
		level.activ iPrintLnBold("^53");
		wait 1;
		player iPrintLnBold("^52");
		level.activ iPrintLnBold("^52");
		wait 1;
		player iPrintLnBold("^51");
		level.activ iPrintLnBold("^51");
		wait 1;
		player iPrintLnBold("^5FIGHT^3!");
		level.activ iPrintLnBold("^5FIGHT^3!");
		player freezeControls(0);
		level.activ freezeControls(0);
		while( isAlive( player ) && isDefined( player ) )
		
		wait 1;
		
	}
}
kisszar()
{
	kocka=getent("kocka","targetname");

	while(1)
	{
		kocka RotateYaw(360, 3);
		wait 0.01;
	}
}

Jump()
{
	level.jump_trig = getEnt( "jump_trig", "targetname");
	jump = getEnt( "jump_j", "targetname" );
	acti = getEnt( "jump_a", "targetname" );
	
	while(1)
	{
		level.jump_trig SetHintstring ("^5Jump ^7Fight");
		level.jump_trig waittill( "trigger", player );
		level.jump_trig SetHintstring ("^5Wait...");
		if( !isDefined( level.jump_trig ) )
			return;

		// ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================

		level.sniper_trig delete();
		level.knife_trig delete();
		level.rpg_trig delete();
		level.old_trig delete();

		player SetPlayerAngles( jump.angles );
		player setOrigin( jump.origin );
		player TakeAllWeapons();
		player GiveWeapon( "knife_mp" );
		player giveMaxAmmo( "knife_mp" );
		level.activ setPlayerangles( acti.angles );
		level.activ setOrigin( acti.origin );
		level.activ TakeAllWeapons();
		level.activ GiveWeapon( "knife_mp" );
		level.activ GiveMaxAmmo( "knife_mp" );
		player freezeControls(1);
		level.activ freezeControls(1);
		wait 0.05;
		player switchToWeapon( "knife_mp" );
		level.activ SwitchToWeapon( "knife_mp" );
		//level.activ setclientDvar("cg_fovscale", 1.3);
		//player setclientDvar("cg_fovscale", 1.3);
  		iPrintLnBold("^5" + player.name + " ^7has choosen Jump!");
		wait 1;
		player iPrintLnBold("^53");
		level.activ iPrintLnBold("^53");
		wait 1;
		player iPrintLnBold("^52");
		level.activ iPrintLnBold("^52");
		wait 1;
		player iPrintLnBold("^51");
		level.activ iPrintLnBold("^51");
		wait 1;
		player iPrintLnBold("^5FIGHT^3!");
		level.activ iPrintLnBold("^5FIGHT^3!");
		player freezeControls(0);
		level.activ freezeControls(0);
		while( isAlive( player ) && isDefined( player ) )
		
		wait 1;
		
	}
}
jump_snip()
{
	trig=getEnt("snip_jump","targetname");
	while(1)
	{
	trig waittill("trigger", player);
	player GiveWeapon("remington700_mp");
	player GiveMaxAmmo("remington700_mp");
	wait 0.01;
	player SwitchToWeapon("remington700_mp");
	}
}

fail()
{
	hit = getEnt("jump_fail", "targetname");
	tp1 = getEnt("jumpinak", "targetname");
	tp2 = getEnt("actinak", "targetname");
	while(1)
	{
		hit waittill("trigger", player);
		if (player.pers["team"] == "axis")
		{
		player setOrigin( tp2.origin );
		player setplayerangles( tp2.angles );
		}
		else if( player.pers["team"] == "allies")
		{
		player setOrigin( tp1.origin );
		player setplayerangles( tp1.angles );
		}
	}
}

Rpg()
{
	level.rpg_trig = getEnt( "rpg_trig", "targetname");
	jump = getEnt( "rpg_j", "targetname" );
	acti = getEnt( "rpg_a", "targetname" );
	
	while(1)
	{
		level.rpg_trig SetHintstring ("^5RPG ^7Fight");
		level.rpg_trig waittill( "trigger", player );
		level.rpg_trig SetHintstring ("^5Wait...");
		if( !isDefined( level.rpg_trig ) )
			return;

		// ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================

		level.sniper_trig delete();
		level.jump_trig delete();
		level.knife_trig delete();
		level.old_trig delete();

		player SetPlayerAngles( jump.angles );
		player setOrigin( jump.origin );
		player TakeAllWeapons();
		player GiveWeapon( "rpg_mp" );
		player giveMaxAmmo( "rpg_mp" );
		level.activ setPlayerangles( acti.angles );
		level.activ setOrigin( acti.origin );
		level.activ TakeAllWeapons();
		level.activ GiveWeapon( "rpg_mp" );
		level.activ GiveMaxAmmo( "rpg_mp" );
		player freezeControls(1);
		level.activ freezeControls(1);
		wait 0.05;
		player switchToWeapon( "rpg_mp" );
		level.activ SwitchToWeapon( "rpg_mp" );
		//level.activ setclientDvar("cg_fovscale", 1.3);
		//player setclientDvar("cg_fovscale", 1.3);
  		iPrintLnBold("^5" + player.name + " ^7has choosen RPG!");
		wait 1;
		player iPrintLnBold("^53");
		level.activ iPrintLnBold("^53");
		wait 1;
		player iPrintLnBold("^52");
		level.activ iPrintLnBold("^52");
		wait 1;
		player iPrintLnBold("^51");
		level.activ iPrintLnBold("^51");
		wait 1;
		player iPrintLnBold("^5FIGHT^3!");
		level.activ iPrintLnBold("^5FIGHT^3!");
		player freezeControls(0);
		level.activ freezeControls(0);
		while( isAlive( player ) && isDefined( player ) )
		
		wait 1;
		
	}
}
rpg_kell()
{
	trig =getEnt("rpg_ammo","targetname");
	trig sethintstring("Ammo for ^5RPG, ^7not works in sniper");
	while(1)
	{
		trig waittill("trigger",player);
		player giveMaxAmmo("rpg_mp");
	}

}

music()
{
	trig =getEnt("random_music","targetname");

	trig sethintstring("Random ^5Music..?");
	trig waittill("trigger", player);
	trig delete();


		zene = RandomInt( 4 );
		if(zene==1)
		{
		ambientplay("song1");
		IPrintLn("Now Playing: ^5Tove Lo - Habits (Oliver Nelson Remix)");
		}
		else if(zene==2)
		{
		ambientplay("song2");
		IPrintLn("Now Playing: ^5Ed Sheeran - Don't (Netsky Remix)");
		}
		else if(zene==3)
		{
		ambientplay("song3");
		IPrintLn("Now Playing: ^5Aaron Smith - Dancin (KRONO Remix)");
		}
		else
		{
		ambientplay("song4");
		IPrintLn("Now Playing: ^5Debris & Our Psych - Omerta");
		}	
}
vip_aku()
{
	trig=getEnt("vip_aku","targetname");
	while(1)
	{
	trig SetHintstring("Ak74u Brahh :)");
	trig waittill("trigger", player);
	player GiveWeapon("ak74u_mp");
	player GiveMaxAmmo("ak74u_mp");
	wait .05;
	player SwitchToWeapon("ak74u_mp");
	}
}
vip_snip()
{
	trig=getEnt("vip_sniper","targetname");
	while(1)
	{
	trig sethintstring("Snipah Brahh :D");
	trig waittill("trigger", player);
	player GiveWeapon("remington700_mp");
	player GiveMaxAmmo("remington700_mp");
	wait .05;
	player SwitchToWeapon("remington700_mp");
	}
}
vip_deagle()
{
	trig=getEnt("vip_digi","targetname");
	while(1)
	{
	trig sethintstring("A nice Deagle :p");
	trig waittill("trigger", player);
	player GiveWeapon("deserteagle_mp");
	player GiveMaxAmmo("deserteagle_mp");
	wait .05;
	player SwitchToWeapon("deserteagle_mp");
	}
}
kifele()
{
	trig = getEnt("kifele", "targetname");
	ori = getent ("ki", "targetname");
	while( 1 )
	{
	trig waittill("trigger", player);
	player SetOrigin (ori.origin);
	player SetPlayerAngles (ori.angles);
	player FreezeControls(1);
	player IPrintLnBold("Cheater, FuCK YOou.");
	wait 5;
	player iPrintLnBold("Haha, Scared?");
	player freezeControls(0);
	wait 0.01;
	}
}

secret()
{
	step1 = getEnt("egy", "targetname");
	step2 = getEnt("ketto", "targetname");
	step3 = getEnt("harom", "targetname");

	trig = getEnt("szekbe", "targetname");
	ori=getEnt("secret_valaszt","targetname");
	brush = getEnt("lap", "targetname");

	brush NotSolid();
	brush Hide();

	trig Hide();

	step1 waittill("trigger", player);
	step1 delete();
	step2 waittill("trigger", player);
	step2 delete();
	step3 waittill("trigger", player);
	step3 delete();

	trig Show();
	brush Solid();
	brush Show();
	while(1)
	{
		trig waittill("trigger", player);
		player setOrigin( ori.origin );
		player setplayerangles( ori.angles );
		player iprintlnbold("^5Entered The secret - Choose the Way");
		wait 0.01;
	}
}
easybe()
{
	trig = getEnt("ez_secret", "targetname");
	ori = getent ("ez", "targetname");
	while( 1 )
	{
	trig SetHintstring("Press ^5[USE] ^7to enter ^5EASY");
	trig waittill("trigger", player);
	player SetOrigin (ori.origin);
	player SetPlayerAngles (ori.angles);
	wait 0.01;
	}
}


hardba()
{
	trig = getEnt("hard_secret", "targetname");
	ori = getent ("hard", "targetname");
	while( 1 )
	{
	trig sethintstring("Press ^5[USE] ^7for enter ^1HARD");
	trig waittill("trigger", player);
	player SetOrigin (ori.origin);
	player SetPlayerAngles (ori.angles);
	wait 0.01;
	}
}


rpg_h()
{
	trig=getEnt("rpg_hard","targetname");
	while(1)
	{
	trig waittill("trigger", player);
	player GiveWeapon("rpg_mp");
	player GiveMaxAmmo("rpg_mp");
	wait 0.01;
	player SwitchToWeapon("rpg_mp");
	}
}

hard_fail1()
{
	trig = getEnt("fail", "targetname");
	ori = getent ("failto", "targetname");
	while( 1 )
	{
	trig waittill("trigger", player);
	player SetOrigin (ori.origin);
	player SetPlayerAngles (ori.angles);
	wait 0.01;
	}
}
hard_fail2()
{
	trig = getEnt("fail2", "targetname");
	ori = getent ("fail2to", "targetname");
	while( 1 )
	{
	trig waittill("trigger", player);
	player SetOrigin (ori.origin);
	player SetPlayerAngles (ori.angles);
	wait 0.01;
	}
}
hard_fail3()
{
	trig = getEnt("fail3", "targetname");
	ori = getent ("fail3to", "targetname");
	while( 1 )
	{
	trig waittill("trigger", player);
	player SetOrigin (ori.origin);
	player SetPlayerAngles (ori.angles);
	wait 0.01;
	}
}
hard_fail4()
{
	trig = getEnt("fail4", "targetname");
	ori = getent ("fail4to", "targetname");
	while( 1 )
	{
	trig waittill("trigger", player);
	player SetOrigin (ori.origin);
	player SetPlayerAngles (ori.angles);
	wait 0.01;
	}
}
ez_fail()
{
	trig = getEnt("ez_fail", "targetname");
	ori = getent ("ezfailto", "targetname");
	while( 1 )
	{
	trig waittill("trigger", player);
	player SetOrigin (ori.origin);
	player SetPlayerAngles (ori.angles);
	wait 0.01;
	}
}
ez_finish()
{
	trig = getEnt("ez_finish", "targetname");
	ori = getent ("finish_one", "targetname");
	while( 1 )
	{
	trig sethintstring("Press ^5[USE] ^7to finish ^5EASY!");
	trig waittill("trigger", player);
	IPrintLnBold("" + player.name + " Has finished the ^5EASY ^7secret!");
	wait 0.1;
	player SetOrigin (ori.origin);
	player SetPlayerAngles (ori.angles);
	player braxi\_rank::giveRankXP( "", 200 );
	wait 0.01;
	}
}
hard_finish()
{
	trig = getEnt("hard_finish", "targetname");
	ori = getent ("h_f", "targetname");
	while( 1 )
	{
	trig sethintstring("Press ^5[USE] ^7to finish ^1HARD!");
	trig waittill("trigger", player);
	IPrintLnBold("" + player.name + " Has finished the ^1HARD ^7secret!");
	wait 0.1;
	player SetOrigin (ori.origin);
	player SetPlayerAngles (ori.angles);
	player braxi\_rank::giveRankXP( "", 500 );
	wait 0.01;
	}
}





