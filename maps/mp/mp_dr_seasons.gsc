/*

   Made by ShazzY
			
			Contact me on steam :
									
									http://steamcommunity.com/id/shazzy017 
   
   
   
   
*/   
main()
{
 maps\mp\_load::main();

 
 game["allies"] = "marines";
 game["axis"] = "opfor";
 game["attackers"] = "axis";
 game["defenders"] = "allies";
 game["allies_soldiertype"] = "desert";
 game["axis_soldiertype"] = "desert";
 setdvar( "r_specularcolorscale", "1" );

	setdvar("r_glowbloomintensity0",".1");
	setdvar("r_glowbloomintensity1",".1");
	setdvar("r_glowskybleedintensity0",".1");
	setdvar("compassmaxrange","1500");
	setdvar("bg_fallDamageMinHeight","100000000");  // add this line to your server.cfg if you want disable the falldamage.
	level.dvar["bunnyhoop"] = false;
	
	precacheitem("usp_silencer_mp");
	precacheitem("uzi_silencer_mp");
	precacheItem("m40a3_mp");
	precacheItem("remington700_mp");
	precacheItem("ak74u_mp");
	precacheItem("deserteaglegold_mp");
	precacheItem("deserteagle_mp");
	precacheItem("rpg_mp");
	precacheItem("g3_mp");
	precacheItem("winchester1200_mp");
	precacheItem("winchester1200_reflex_mp");
	precacheItem("ak47_mp");
	precacheItem("rpd_mp");
	precacheItem("tomahawk_mp");
	
	addTriggerToList( "trap1_trigger" );
	addTriggerToList( "trap2_trigger" );
	addTriggerToList( "trap3_trigger" );
	addTriggerToList( "trap4_trigger" );
	addTriggerToList( "trap5_trigger" );
	

//thread music();
thread door();
thread traplist();
thread initialize();
thread bounceback();
thread secret100();
}
//////////////////////////////////////////////////////////////////////////
secret100()
{
	thread secretopen();
	thread secret();
	thread secretbe();
	thread secretend();
	thread sniperteleport();
}
bounceback()
{
	thread jump1();
	thread jump2();
	thread akti1();
	thread akti2();
	thread jump3();
	thread akti3();
	thread jumpend();
	thread aktiend();
	thread aktikill();
	thread jumperkill();
	thread secret();
	thread secretbe();
	}
initialize()
{
	thread jukeBox();
	thread jukeBox2();
	thread cheater();
	thread nyil();
	thread bouncew();
	thread creators();
	thread aktitele();
	thread endtrig();
	thread sniper();
	thread weapon();
	thread knife();
	thread bounce();
	
	//thread addTestClients();
	//thread lift();
	level waittill("round_ended");
	AmbientStop();
}
///////////////////////////////////////////////////////////////
traplist()
{
	thread trap1();
	thread trap2();
	thread trap3();
	thread trap4();
	thread trap5();
	thread trap6();
	thread trap7();
	//thread trap8();
	
	}
//////////////////////////////////////////////////////////////////////
bouncew()
{
level endon("bounced");
b1 = getent("bounce01","targetname");
for(;;)
{
	b1 waittill("trigger", player);
	player thread bounce_watch();
	}
}

bounce_watch()
{
self endon("death");
self endon("disconected");
level endon("bounced");
b2 = getent("bounce02","targetname");
for(;;)
{
	if(self istouching(b2))
	{
		
		IPrintLnbold("^3Nice ^6job ^1" + self.name + "^7!!.");
		level notify("bounced");
		}
	wait .001;
	}
}


endmusic(music, time, playing)
{
level notify("endmusic");
AmbientStop();
wait 1;
for(;;)
{
	AmbientPlay(music);
	iprintln(playing);
	iprintln(playing);
	iprintln(playing);
	wait time;
	AmbientStop();
	wait 1;
	}
}


///////////////////////////////
secretopen()
{
	trig1 = getEnt("music_1", "targetname");
	trig2 = getEnt("music_2", "targetname");
	musicajto = getEnt("musicroom", "targetname");
	
	musicajto solid();
	
	trig2 hide();
	
	
	trig1 waittill ("trigger", player);
	iPrintLnBold("^5 Secret Step ^31 ^7 :^4 Done.");
	trig2 show();
	trig2 waittill("trigger", player);
	iPrintLnBold("^5 Secret Step ^32 ^7 :^4 Done.");
	
	musicajto notsolid();
	
	
}
////////////////////////////////////////////////

door()
{
trig = getent("door_trig","targetname");
door = getent("door","targetname");
trig waittill ("trigger");
//thread music();
wait 0.1;
{
//IPrintLnbold("Door Is ^2Opening^7!..");
thread createhud("Door Is Opening^7!!");
	door movez(-176,2.5);
	door waittill ("movedone");

	}
}




trap1()
{
	trig = getent("trap1_trigger","targetname");
	a = getent("trap1_a","targetname");
	b = getent("trap1_b","targetname");
	c = getent("trap1_c","targetname");
	trig SetHintString("^1Press &&1 !..");
	trig waittill ("trigger");
	
	trig sethintstring(" ^6Activated ");
		
	c moveZ(-20,1);
	wait 0.1;
	while (1)
	
	{
		a moveZ(-36,0.4);
		b moveZ(36,0.4);
			wait 0.8;
			a moveZ(36,0.4);
		b moveZ(-36,0.4);
		wait 0.8;
	}
}

trap2()
{
			trig = getent("trap2_trigger","targetname");
			hurt = getEnt ("hurt", "targetname");
			spikes = getent("tuske","targetname");
			c = getent("trap2_c","targetname");
			
		  trig SetHintString("^1Press &&1 !..");
		  trig waittill ("trigger");
	
	trig sethintstring(" ^6Activated ");
	c moveZ(-20,1);
	wait 0.1;
	hurt enablelinkto(); 
	hurt linkto (spikes);
	
	while (1)
			{
			
			spikes moveX(540,3.5);
			 wait 4;
			spikes rotatepitch(180, 0.5);
			 wait 1;
			spikes moveX(-540,3.5);
			 wait 4;
			spikes rotatepitch(-180, 0.5);
			 wait 1;
		}
}
trap3()
{
			trig = getent("trap3_trigger","targetname");
			b = getent("trap3_b","targetname");
			a = getent("trap3_a","targetname");
			c = getent("trap3_c","targetname");
			
		  trig SetHintString("^1Press &&1 !..");
		  trig waittill ("trigger");
		  trig sethintstring(" ^6Activated ");
		  wait 0.1;
		  c moveZ(-20,1);
	
	
	
			{
			
			a notsolid();
			wait 0.1;
			b notsolid();
			wait 0.1;
			
			
		}
}
trap4()
{
	trig = getent("trap4_trigger","targetname");
	trap4	= getent( "trap4_a", "targetname" );
	//b = getent("trap4_b", "targetname" );
	c = getent("trap4_c","targetname");
		  trig SetHintString("^1Press &&1 !..");
		  trig waittill ("trigger");
		  trig sethintstring(" ^6Activated ");
		  wait 0.1;
		  c moveZ(-20,1);
		 // b notsolid();

	while (1)
	{
		trap4 rotatepitch (360, 2);
		wait 2;
	}
}
trap5()
{
	trig = getent("trap5_trigger","targetname");
	trap5	= getent( "trap5_a", "targetname" );
	c = getent("trap5_c","targetname");
	d = getent("trap5_d","targetname");
	e = getent("trap5_e","targetname");
		  trig SetHintString("^1Press &&1 !..");
		  trig waittill ("trigger");
		  trig sethintstring(" ^6Activated ");
		  wait 0.1;
		  c moveZ(-20,1);

	trap5 delete();
	e delete();
	while (1)
	{
		d moveX (15,0.6);
		wait 1.5;
		d moveX (-15,0.6);
		wait 1.5;
		}
}
cheater()
{
self endon("death");
self endon("disconected");
trig = getEnt("cheater", "targetname");
while (1)
{
trig waittill("trigger", p);
//wait 0.1;
	IPrintLnbold("^1" + p.name + "^3 is ^1an ^6sucker ^2^^. ^7!!.");
	wait 1;
	p iprintlnbold(" ^3You ^4will  ^6die. ");
	wait 1;
	p iprintlnbold(" ^3He ^6He. ");
	wait 1;
	
	
p suicide();


	}
}
creators()
{
wait 20;
iprintln("^6>> ^7Map made by ^5ShazzY .");
wait 30;
iprintln("^6>> ^7If you found any bug please report it.");
wait 0.5;
iprintln("^6>> ^7Steam : ^1shazzy017");
wait 10;
iprintln("^6>> ^7Special thank for ^6nukaa ^7^^");

}
///////////////////////////////////////////////////////////
lift()
{
trig = getent("lift_trigger","targetname");
lift = getent("lift","targetname");
trig waittill("trigger", p);

	wait 0.1;

	while (1)

{

	lift moveY(-290,5.5);
	wait 6;
	lift moveY (290,5.5);
	wait 6;

	}
}

nyil ()
{
	nyil = getent("nyil","targetname");
	nyil_trigger = getent("nyil_trigger","targetname");
	nyil_trigger waittill ("trigger", p);
	wait 0.1;
	while (1)
	{
		nyil moveX(6,1);
		wait 1.1;
		nyil moveX(-6,1);
		wait 1.1;
		}
	}
trap6()
{
	trig = getent("trap6_trigger","targetname");
	trap6	= getent( "trap6_a", "targetname" );
	
	
	
		  
		  trig waittill("trigger", p);
		  
		  wait 0.01;
		  

	while (1)
	{
		trap6 moveY (68, 2);
		wait 2.5;
		trap6 moveY (-68, 2.0);
		wait 2.5;
	}
}
trap7()
{
	trig = getent("trap7_trigger","targetname");
	a	= getent( "trap7_a", "targetname" );
	b	= getent( "trap7_b", "targetname" );
	
	
	
		  
		  trig waittill("trigger", p);
		  
		  wait 0.01;
		  

	while (1)
	{
		a moveY (-64, 1.2);
		b moveY (64, 1.2);
		wait 1.5;
		a moveX (-214, 2.5);
		b moveX (214, 2.5);
		wait 3;
		a moveY (64, 1.2);
		b moveY (-64, 1.2);
		wait 1.5;
		a moveX (214, 2.5);
		b moveX (-214, 2.5);
		wait 3.0;
		
	}
}
aktitele()
{
trig = getEnt("akti_trigger","targetname");
tele1 = getEnt("akti_origin","targetname");

for(;; )
   {
    trig waittill("trigger", player);
    player setOrigin(tele1.origin);


   }
}

endtrig()
{
level.jatekosend = 0;
org = getent("end_origin","targetname");
trig = getent("end_trigger","targetname");
//trig SetHintString("^1Press ^3 &&1 ^1!..");
for(;;)
{
    trig waittill("trigger", player);

	// ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================
		
    if(level.jatekosend == 0)
    {
        level.jatekosend = 1;
        trig SetHintString("^1Wait ^3your ^1turn!");
        player thread endtrigantibug(trig);
        air = Spawn("script_origin", player.origin);
        player linkto(air);
        air moveto(org.origin, 1.5);
        air waittill ("movedone");
        player unlink();
        air delete();
    }
}
}
 
endtrigantibug(trig)
{
self common_scripts\utility::waittill_any("death","disconnect");
level.jatekosend = 0;
trig SetHintString("^1Press &&1 !..");
}
////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////
addTestClients()
{
     setDvar("scr_testclients", "");
     wait 1;
     for(;;)
     {
         if(getdvarInt("scr_testclients") > 0)
             break;
         wait 1;
     }
     testclients = getdvarInt("scr_testclients");
     setDvar( "scr_testclients", 0 );
     for(i=0;i<testclients;i++)
     {
         ent[i] = addtestclient();

         if (!isdefined(ent[i]))
         {
             println("Could not add test client");
             wait 1;
             continue;
         }
         ent[i].pers["isBot"] = true;
         ent[i].pers["registered"] = 0;
         ent[i] thread TestClient("autoassign");
     }
     thread addTestClients();
}

TestClient(team)
{
     self endon( "disconnect" );

     while(!isdefined(self.pers["team"]))
         wait .05;
         
     self notify("menuresponse", game["menu_team"], team);
     wait 0.5;
}
/////////////////////////////////////////////////////////////////////

//////////////////////////////////////////

ammo()
{
self endon("round_ended");
self endon("death");
self endon("disconected");
wait 1;
for(;;)
{
	weapon = self GetCurrentWeapon();
	ammo = self GetWeaponAmmoStock(weapon);
	if(weapon == "none")
	{
		wait 1;
	}
	else if(0 >= ammo)
	{
		self IPrintLnbold("^2Max Ammo!");
		self givemaxammo(weapon);
		}
	wait .1;
	}
}
////////////////////////////////////////////
createhud(messages)
{
hud_start = NewHudElem();
hud_start.alignX = "center";
hud_start.alignY = "middle";
hud_start.horzalign = "center";
hud_start.vertalign = "middle";
hud_start.alpha = 1;
hud_start.x = -3;
hud_start.y = -150;
hud_start.font = "default";
hud_start.fontscale = 2.0;
hud_start.glowalpha = 1;
hud_start.glowcolor = (1,0,0);
hud_start setText(messages);
hud_start SetPulseFX( 100, 4000, 500 );
wait 7;
if(isdefined(hud_start))
	hud_start destroy();
}
////////////////////////////////////////////////

/////////////////////////////////////////////////////////////
sniper()
{

	level.final_sniper_trig = getEnt( "sniper_trig", "targetname");
    jump = getEnt( "j_sniper", "targetname" );
    acti = getEnt( "a_sniper", "targetname" );
	 level.final_sniper_trig SetHintString("^1Press^3 &&1 ^1to enter Sniper room.");
	

     while(1)
    {
        level.final_sniper_trig waittill( "trigger", player );
        if( !isDefined( level.final_sniper_trig ) )
            return;
        
		
		level.final_knife_trig delete();
        level.final_wep_trig delete();
		level.jump_trig delete();
		
		
         player.health = player.maxhealth;
		 level.activ.health = level.activ.maxhealth;
		player SetPlayerAngles( jump.angles );
        player setOrigin( jump.origin );
        player TakeAllWeapons();
        player GiveWeapon( "remington700_mp" );
		player GiveWeapon( "m40a3_mp" );        
        level.activ setPlayerangles( acti.angles );
        level.activ setOrigin( acti.origin );
        level.activ TakeAllWeapons();
        level.activ GiveWeapon( "remington700_mp" );
        level.activ GiveWeapon( "m40a3_mp" );         
        wait 0.05;
        player switchToWeapon( "remington700_mp" ); 
        level.activ SwitchToWeapon( "remington700_mp" );
        player FreezeControls(1);
		level.activ FreezeControls(1);
			player thread ammo();
			level.activ thread ammo();
		noti = SpawnStruct();
				noti.titleText = "Sniper Room";
				noti.notifyText = level.activ.name + " ^3VS^7 " + player.name;
				noti.glowcolor = (1,0,0.9);
				noti.duration = 5;
				players = getentarray("player", "classname");
				for(i=0;i<players.size;i++)
					players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
				wait 5;
				player FreezeControls(0);
				level.activ FreezeControls(0);
        while( isAlive( player ) && isDefined( player ) )
            wait 1;
			
    }

}
/////////////////////////////////////////////////////////////////

weapon()
{	
	
	level.final_wep_trig = getEnt( "wep_trig", "targetname");
    jump = getEnt ("j_weapon", "targetname");
    acti = getEnt ("a_weapon", "targetname");
	level.final_wep_trig SetHintString("^1Press^3 &&1 ^1to enter Weapon room.");
	
     while(1)
    {
        level.final_wep_trig waittill( "trigger", player );
        if( !isDefined( level.final_wep_trig ) )
            return;
			
			level.final_sniper_trig delete();
			level.final_knife_trig delete();
			level.jump_trig delete();
        
		

      
         player.health = player.maxhealth;
		 level.activ.health = level.activ.maxhealth;
		player SetPlayerAngles( jump.angles );
        player setOrigin( jump.origin );
        player TakeAllWeapons();
		
	
            
        level.activ setPlayerangles( acti.angles );
        level.activ setOrigin( acti.origin );
        level.activ TakeAllWeapons();
		
                 
        wait 0.05;
       
		
        player FreezeControls(1);
		level.activ FreezeControls(1);
		player thread ammo();
	level.activ thread ammo();
		noti = SpawnStruct();
				noti.titleText = "^7Weapon Room";
				noti.notifyText = level.activ.name + " ^3VS^7 " + player.name;
				noti.glowcolor = (0.9,0,0.9);
				noti.duration = 5;
				players = getentarray("player", "classname");
				for(i=0;i<players.size;i++)
					players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
				wait 5;
				player FreezeControls(0);
				level.activ FreezeControls(0);
        while( isAlive( player ) && isDefined( player ) )
            wait 1;
			
    }
}

knife()
{

	level.final_knife_trig = getEnt( "knife_trig", "targetname");
    jump = getEnt( "knife_jumper", "targetname" );
    acti = getEnt( "knife_activator", "targetname" );
	level.final_knife_trig	SetHintString("^1Press^3 &&1 ^1to enter Knife room.");
	
     while(1)
    {
        level.final_knife_trig waittill( "trigger", player );
        if( !isDefined( level.final_knife_trig ) )
            return;
        
				level.final_sniper_trig delete();
				level.final_wep_trig delete();
				level.jump_trig delete();
		
      
         player.health = player.maxhealth;
		 level.activ.health = level.activ.maxhealth;
		player SetPlayerAngles( jump.angles );
        player setOrigin( jump.origin );
        player TakeAllWeapons();
        player GiveWeapon( "tomahawk_mp" );
		player GiveWeapon( "tomahawk_mp" );        
        level.activ setPlayerangles( acti.angles );
        level.activ setOrigin( acti.origin );
        level.activ TakeAllWeapons();
        level.activ GiveWeapon( "tomahawk_mp" );
        level.activ GiveWeapon( "tomahawk_mp" );         
        wait 0.05;
        player switchToWeapon( "tomahawk_mp" ); 
        level.activ SwitchToWeapon( "tomahawk_mp" );
        player FreezeControls(1);
		level.activ FreezeControls(1);
		noti = SpawnStruct();
				noti.titleText = "^7 Knife Room";
				noti.notifyText = level.activ.name + " ^3VS^7 " + player.name;
				noti.glowcolor = (0.9,0,0.9);
				noti.duration = 5;
				players = getentarray("player", "classname");
				for(i=0;i<players.size;i++)
					players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
				wait 5;
				player FreezeControls(0);
				level.activ FreezeControls(0);
        while( isAlive( player ) && isDefined( player ) )
            wait 1;
    }
}
/////////////////////////////////////////////////////////////////////////////////////////
addTriggerToList( name )
{
    if( !isDefined( level.trapTriggers ) )
        level.trapTriggers = [];
    level.trapTriggers[level.trapTriggers.size] = getEnt( name, "targetname" );
}
////////////////////////////////////////////////////////////////////////////////////////
	
bounce()
{
    level.jump_trig = getEnt( "bounce_trig", "targetname");
    jump = getEnt( "bounce_1_jumper", "targetname" );
    acti = getEnt( "bounce_1_activator", "targetname" );
	level.jump_trig SetHintString("^1Press^3 &&1 ^1to enter Bounce room.");
	
    while(1)
    {
        level.jump_trig waittill( "trigger", player );
        if( !isDefined( level.jump_trig ) )
            return;
        
				level.final_sniper_trig delete();
				level.final_wep_trig delete();
				level.final_knife_trig delete();
		
        
        player.health = player.maxhealth;
		 level.activ.health = level.activ.maxhealth;
		player SetPlayerAngles( jump.angles );
        player setOrigin( jump.origin );
        player TakeAllWeapons();
        player GiveWeapon( "tomahawk_mp" );
		player GiveWeapon( "tomahawk_mp" );        
        level.activ setPlayerangles( acti.angles );
        level.activ setOrigin( acti.origin );
        level.activ TakeAllWeapons();
        level.activ GiveWeapon( "tomahawk_mp" );
        level.activ GiveWeapon( "tomahawk_mp" );         
        wait 0.05;
        player switchToWeapon( "tomahawk_mp" ); 
        level.activ SwitchToWeapon( "tomahawk_mp" );
        player FreezeControls(1);
		level.activ FreezeControls(1);
		noti = SpawnStruct();
				noti.titleText = "^7 Bounce Room";
				noti.notifyText = level.activ.name + " ^3VS^7 " + player.name;
				noti.glowcolor = (0.9,0,0.9);
				noti.duration = 5;
				players = getentarray("player", "classname");
				for(i=0;i<players.size;i++)
					players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
				wait 5;
				player FreezeControls(0);
				level.activ FreezeControls(0);
        while( isAlive( player ) && isDefined( player ) )
            wait 1;
    }
}

jump1()
{
    trig = getEnt ("jump1_trig", "targetname");
    end = getEnt ("bounce_1_jumper", "targetname");

    
    while(1)
    {
        trig waittill ("trigger", player);  
        player SetOrigin(end.origin);
        player SetPlayerAngles( end.angles );
	}
}

jump2()
{
    trig = getEnt ("jump2_trig", "targetname");
    end = getEnt ("jump2_origin", "targetname");

    
    while(1)
    {
        trig waittill ("trigger", player);  
        player SetOrigin(end.origin);
        player SetPlayerAngles( end.angles );
	}
}

akti1()
{
    trig = getEnt ("akti1_trig", "targetname");
    end = getEnt ("bounce_1_activator", "targetname");

    
    while(1)
    {
        trig waittill ("trigger", player);  
        player SetOrigin(end.origin);
        player SetPlayerAngles( end.angles );
	}
}

akti2()
{
    trig = getEnt ("akti2_trig", "targetname");
    end = getEnt ("akti2_origin", "targetname");

    
    while(1)
    {
        trig waittill ("trigger", player);  
        player SetOrigin(end.origin);
        player SetPlayerAngles( end.angles );
	}
}

aktiend()
{
    trig = getEnt ("activator_end_trig", "targetname");
    end = getEnt ("activator_end", "targetname");
		
		

    
    while(1)
    {
        trig waittill ("trigger", player);  
       level.activ SetOrigin(end.origin);
        level.activ SetPlayerAngles( end.angles );
		
	}
}

jumpend()
{
    trig = getEnt ("jump_end_trig", "targetname");
    end = getEnt ("jump_end", "targetname");
	

    
    while(1)
    {
        trig waittill ("trigger", player);  
        player SetOrigin(end.origin);
        player SetPlayerAngles( end.angles );
		
		
	}
}

jump3()
{
    trig = getEnt ("jump3_trig", "targetname");
    end = getEnt ("jump3_origin", "targetname");

    
    while(1)
    {
        trig waittill ("trigger", player);  
        player SetOrigin(end.origin);
        player SetPlayerAngles( end.angles );
	}
}

akti3()
{
    trig = getEnt ("akti3_trig", "targetname");
    end = getEnt ("akti3_origin", "targetname");

    
    while(1)
    {
        trig waittill ("trigger", player);  
        player SetOrigin(end.origin);
        player SetPlayerAngles( end.angles );
	}
}


aktikill()
{
    trig = getEnt ("aktikiller", "targetname");
    acti = getEnt ("winner", "targetname");
	jump = getEnt ("loser", "targetname");

    trig waittill ("trigger", player); 
		noti = SpawnStruct();
				
				noti.notifyText = level.activ.name + " ^3Fucks^7 " + player.name;
				
				noti.glowcolor = (1,0,0.0);
				noti.duration = 5;
				players = getentarray("player", "classname");
				for(i=0;i<players.size;i++)
					players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
   
    {
         
        level.activ setPlayerangles( acti.angles );
        level.activ setOrigin( acti.origin );
		player SetPlayerAngles( jump.angles );
        player setOrigin( jump.origin );
		wait 0.1;
		player freezeControls(1);
		player takeallweapons();
		 player  IPrintLnbold("^3You ^2will ^1be ^4fucked");
		 wait 3;
		 player freezeControls(0);

		}
            {
			
			level.activ giveWeapon("deserteagle_mp");
			level.activ switchToWeapon("deserteagle_mp");
			
			level.activ thread ammo();
			level.activ IPrintLnbold("^1You Win! ^7now kill the ^1Jumper");
			
			}
		}
jumperkill()
{
    trig = getEnt ("jumperkiller", "targetname");
    acti = getEnt ("loser", "targetname");
	jump = getEnt ("winner", "targetname");

    trig waittill ("trigger", player); 
		
		noti = SpawnStruct();
				
				noti.notifyText =  player.name + " ^3Fucks^7 " + level.activ.name;
				noti.glowcolor = (1,0,0.0);
				noti.duration = 5;
				players = getentarray("player", "classname");
				for(i=0;i<players.size;i++)
					players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
   
    {
         
        level.activ setPlayerangles( acti.angles );
        level.activ setOrigin( acti.origin );
		player SetPlayerAngles( jump.angles );
        player setOrigin( jump.origin );
		wait 0.1;
		level.activ freezeControls(1);
		level.activ takeallweapons();
		level.activ  IPrintLnbold("^3You ^2will ^1be ^4fucked");
		 
		 wait 3;
		 level.activ freezeControls(0);

		}
            {
			
			level.activ giveWeapon("deserteagle_mp");
			level.activ switchToWeapon("deserteagle_mp");
			player thread ammo();
			player  IPrintLnbold("^1You Win! ^7now kill the ^1Activator");
			
			
			}
		}
		
/////////////////////////////////////////////////////////////////////////////////////////////////////
jukeBox()
{
	level endon("song_picked");
	trigger1 = getEnt("jukebox","targetname");
	trigger2 = getEnt("jukebox2","targetname");
	
	while(1)
	{
		trigger1 waittill("trigger",player);
		if(!level.juke["open"])
		{
			level.juke["open"] = true;
			player thread createJuke();
			player thread jukeDeath();
			player thread jukeDeath2();
			//trigger2 delete();
			trigger1 delete();
		}
		wait .05;
	}
}
createJuke()
{
	level.juke["background"] = createRectangle("","",0,0,1000,720,(0,0,0),"white",10,1);
	level.juke["center_line"] = createRectangle("","",0,0,3,720,(1,1,1),"white",20,.6);
	level.juke["top_option"][0] = createText("default",2.3,"RIGHT","",-10,-135,1,100,"Artists");
	level.juke["top_option"][1] = createText("default",2.3,"LEFT","",10,-135,1,100,"Song Names");
	for(k = 0; k < level.juke["top_option"].size; k++)
	{
		level.juke["top_option"][k].glowAlpha = 1;
		level.juke["top_option"][k].glowColor = (0,0,1);
	}
	level.juke["curs"] = 0;
	
	level.options = strTok("Tara Trumpet;Ujhazi veretos;We want some Pussy vs Deep...;Eurythmics vs YellowClaw..;The Spook vs Freaks vs Hocus;Tremor vs Lala vs I like to move it;Bounce Generation vs Turn down;Stay the night vs BAD;Turn up vs All of me",";");
	level.artists = strTok("Manu Da Bass;Dj Totottcigi;Timmy Trumpet Mashup;Dimitri Vegas & Like Mashup;KSHMR,TimmyT,W&W;Dimitri Vegas & Like Mike;Vinai & Dj Snake;Zedd &David Guetta;Afrojack & Martin Garrix",";");
	level.actions = strTok("song1;song2;song3;song4;song5;song6;song7;song8;song9",";");
	for(k = 0; k < level.options.size; k++)
	{
		level.juke["options"][k] = createText("default",1.6,"LEFT","",10,((k*22)-100),1,100,level.options[k]);
		level.juke["options"][k].glowColor = (1,0,0);
		
		level.juke["artists"][k] = createText("default",1.6,"RIGHT","",-10,((k*22)-100),1,100,level.artists[k]);
		level.juke["artists"][k].glowAlpha = 1;
		level.juke["artists"][k].glowColor = (0,1,0);
	}
	level.juke["options"][0].glowAlpha = 1;
	wait .2;
	thread runJuke();
}
runJuke()
{
	self endon("death");
	while(level.juke["open"])
	{
		self freezeControls(true);
		if(self attackButtonPressed() || self adsButtonPressed())
		{
			level.juke["curs"] -= self adsButtonPressed();
			level.juke["curs"] += self attackButtonPressed();
			if(level.juke["curs"] >= level.options.size)
				level.juke["curs"] = 0;
				
			if(level.juke["curs"] < 0)
				level.juke["curs"] = level.options.size-1;
				
			for(k = 0; k < level.juke["options"].size; k++)
				if(k != level.juke["curs"])
					level.juke["options"][k].glowAlpha = 0;
				else
					level.juke["options"][k].glowAlpha = 1;
					
			wait .15;
		}
		if(self useButtonPressed())
		{
			iPrintlnBold(self.name+" Has Picked ^2"+level.options[level.juke["curs"]]);
			ambientPlay(level.actions[level.juke["curs"]]);
			level notify("song_picked");
			getEnt("jukebox","targetname") setHintString("");
			break;
		}
		if(self meleeButtonPressed())
			break;
			
		wait .05;
	}
	self notify("left_menu");
	level.juke["open"] = false;
	level.juke["background"] destroy();
	level.juke["center_line"] destroy();
	for(k = 0; k < level.juke["options"].size; k++)
	{
		level.juke["options"][k] destroy();
		level.juke["artists"][k] destroy();
	}
	for(k = 0; k < level.juke["top_option"].size; k++)
		level.juke["top_option"][k] destroy();
		
	self freezeControls(false);
}
jukeDeath()
{
	self endon("left_menu");
	self waittill("death");
	level.juke["open"] = false;
}
///////////////////////////////////////////////////////////////////////////////
createText(font,fontscale,align,relative,x,y,alpha,sort,text)
{
	hudText = maps\mp\gametypes\_hud_util::createFontString(font,fontscale);
	hudText maps\mp\gametypes\_hud_util::setPoint(align,relative,x,y);
	hudText.alpha = alpha;
	hudText.sort = sort;
	hudText setText(text);
	hudText.hideWhenInMenu = true;
	thread destroyElemOnDeath(hudText);
	return hudText;
}
createRectangle(align,relative,x,y,width,height,color,shader,sort,alpha)
{
	barElem = newClientHudElem(self);
	barElem.elemType = "bar";
	barElem.width = width;
	barElem.height = height;
	barElem.align = align;
	barElem.relative = relative;
	barElem.children = [];
	barElem.sort = sort;
	barElem.color = color;
	barElem.alpha = alpha;
	barElem maps\mp\gametypes\_hud_util::setParent(level.uiParent);
	barElem setShader(shader,width,height);
	barElem.hideWhenInMenu = true;
	barElem maps\mp\gametypes\_hud_util::setPoint(align,relative,x,y);
	thread destroyElemOnDeath(barElem);
	return barElem;
}
destroyElemOnDeath(elem)
{
	self waittill("death");
	self freezeControls(false);
	elem destroy();
}
/////////////////////////////////////////////////////////////////

secret()
{
    trig = getEnt ("secretback", "targetname");
    end = getEnt ("secretstart", "targetname");

    
    while(1)
    {
        trig waittill ("trigger", player);  
        player SetOrigin(end.origin);
        player SetPlayerAngles( end.angles );
	}
}

secretbe()
{
    trig = getEnt ("secretbe", "targetname");
    end = getEnt ("secretstart", "targetname");

    
    while(1)
    {
        trig waittill ("trigger", player);  
        player SetOrigin(end.origin);
        player SetPlayerAngles( end.angles );
	}
}

secretend()
{
    trig = getEnt ("secretend", "targetname");
    end = getEnt ("secretbol", "targetname");

    
    while(1)
    {
        trig waittill ("trigger", player);
		player freezeControls(1);		
        player SetOrigin(end.origin);
        player SetPlayerAngles( end.angles );
		wait 1.5;
		player freezeControls(0);
	}
}

sniperteleport()
{
    trig = getEnt ("sniper_teleport", "targetname");
    end = getEnt ("sniper_origin", "targetname");

    
    while(1)
    {
        trig waittill ("trigger", player);
		player freezeControls(1);
		player SetOrigin(end.origin);
        player SetPlayerAngles( end.angles );

			iprintlnbold("^6 "+ self.name +" got freeze 3seconds");
			//IPrintLnbold("" + self.name + "" + self.name + "^7!!.");
			wait 3;
        
		
		player freezeControls(0);
	}
}

jukeBox2()
{
	level endon("zenepick");
	trigger = getEnt("jukebox2","targetname");
	trigger1 = getEnt("jukebox","targetname");
	
	while(1)
	{
		trigger waittill("trigger",player);
		if(!level.juke2["open"])
		{
			level.juke2["open"] = true;
			player thread createJuke2();
			player thread jukeDeath2();
			player thread jukeDeath();
			trigger delete();
			trigger1 delete();
		}
		wait .05;
	}
}
createJuke2()
{
	level.juke2["background"] = createRectangle("","",0,0,1000,720,(0,0,0),"white",10,1);
	level.juke2["center_line"] = createRectangle("","",0,0,3,720,(1,1,1),"white",20,.6);
	level.juke2["top_option"][0] = createText("default",2.3,"RIGHT","",-10,-135,1,100,"Artists");
	level.juke2["top_option"][1] = createText("default",2.3,"LEFT","",10,-135,1,100,"Song Names");
	for(k = 0; k < level.juke2["top_option"].size; k++)
	{
		level.juke2["top_option"][k].glowAlpha = 1;
		level.juke2["top_option"][k].glowColor = (0,0,1);
	}
	level.juke2["curs"] = 0;
	
	level.options2 = strTok("Vedd fel az oltonyod;Elloptak a biciklim;#Lavkoma;Bombashej;Vegem",";");
	level.artists2 = strTok("Kis Grofo;Ham Ko Ham;Kis Grofo;Jolly;Opitz Barbi",";");
	level.actions2 = strTok("song10;song11;song12;song13;song14",";");
	for(k = 0; k < level.options2.size; k++)
	{
		level.juke2["options"][k] = createText("default",1.6,"LEFT","",10,((k*22)-100),1,100,level.options2[k]);
		level.juke2["options"][k].glowColor = (1,0,0);
		
		level.juke2["artists"][k] = createText("default",1.6,"RIGHT","",-10,((k*22)-100),1,100,level.artists2[k]);
		level.juke2["artists"][k].glowAlpha = 1;
		level.juke2["artists"][k].glowColor = (0,1,0);
	}
	level.juke2["options"][0].glowAlpha = 1;
	wait .2;
	thread runJuke2();
}
runJuke2()
{
	self endon("death");
	while(level.juke2["open"])
	{
		self freezeControls(true);
		if(self attackButtonPressed() || self adsButtonPressed())
		{
			level.juke2["curs"] -= self adsButtonPressed();
			level.juke2["curs"] += self attackButtonPressed();
			if(level.juke2["curs"] >= level.options2.size)
				level.juke2["curs"] = 0;
				
			if(level.juke2["curs"] < 0)
				level.juke2["curs"] = level.options2.size-1;
				
			for(k = 0; k < level.juke2["options"].size; k++)
				if(k != level.juke2["curs"])
					level.juke2["options"][k].glowAlpha = 0;
				else
					level.juke2["options"][k].glowAlpha = 1;
					
			wait .15;
		}
		if(self useButtonPressed())
		{
			iPrintlnBold(self.name+" Has Picked ^2"+level.options2[level.juke2["curs"]]);
			ambientPlay(level.actions2[level.juke2["curs"]]);
			level notify("zenepick");
			getEnt("jukebox2","targetname") setHintString("");
			break;
		}
		if(self meleeButtonPressed())
			break;
			
		wait .05;
	}
	self notify("left_menu2");
	level.juke2["open"] = false;
	level.juke2["background"] destroy();
	level.juke2["center_line"] destroy();
	for(k = 0; k < level.juke2["options"].size; k++)
	{
		level.juke2["options"][k] destroy();
		level.juke2["artists"][k] destroy();
	}
	for(k = 0; k < level.juke2["top_option"].size; k++)
		level.juke2["top_option"][k] destroy();
		
	self freezeControls(false);
}
jukeDeath2()
{
	self endon("left_menu2");
	self waittill("death");
	level.juke2["open"] = false;
}
			