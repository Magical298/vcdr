//───────────────────────────────────────────────────────────────────────────────────────────────────
//─██████████████─██████████████─████████──████████─██████████████─██████████████─████████████████───
//─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░██──██░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░░░██───
//─██░░██████░░██─██░░██████░░██─████░░██──██░░████─██░░██████████─██░░██████████─██░░████████░░██───
//─██░░██──██░░██─██░░██──██░░██───██░░░░██░░░░██───██░░██─────────██░░██─────────██░░██────██░░██───
//─██░░██████░░██─██░░██──██░░██───████░░░░░░████───██░░██████████─██░░██████████─██░░████████░░██───
//─██░░░░░░░░░░██─██░░██──██░░██─────████░░████─────██░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░░░██───
//─██░░██████████─██░░██──██░░██───────██░░██───────██████████░░██─██░░██████████─██░░██████░░████───
//─██░░██─────────██░░██──██░░██───────██░░██───────────────██░░██─██░░██─────────██░░██──██░░██─────
//─██░░██─────────██░░██████░░██───────██░░██───────██████████░░██─██░░██████████─██░░██──██░░██████─
//─██░░██─────────██░░░░░░░░░░██───────██░░██───────██░░░░░░░░░░██─██░░░░░░░░░░██─██░░██──██░░░░░░██─
//─██████─────────██████████████───────██████───────██████████████─██████████████─██████──██████████─
//───────────────────────────────────────────────────────────────────────────────────────────────────


  
#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

#include braxi\_dvar;
main()
{

    maps\mp\_load::main();
	
	game["allies"] = "sas";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "woodland";
	game["axis_soldiertype"] = "woodland";
	
	setdvar( "r_specularcolorscale", "1" );
	level.tele = LoadFX("up/tele");
	level.exp = LoadFX("up/xp");
	level.p = LoadFX("up/poyser");
	level.tele2 = LoadFX("up/tele2");
	level.trap = LoadFX("up/trap");
	
	precacheItem( "remington700_mp" );
	precacheItem("frag_grenade_mp");
	precacheItem( "ak47_mp" );
	precacheItem( "ak74u_mp" );
	precacheItem( "winchester1200_mp" );
	precacheItem( "rpg_mp" );
	precacheItem( "m40a3_acog_mp" );
	precacheItem( "saw_grip_mp" );
	
	PreCacheShellShock( "teleporter");
	
	thread init();
	setdvar("r_glowbloomintensity0",".25");
	setdvar("r_glowbloomintensity1",".25");
	setdvar("r_glowskybleedintensity0",".3");
	setdvar("compassmaxrange","1800");

	thread s_end();
	thread sb();
	thread logo();
	thread poyser();
	thread hexp();
	thread rpg();
	thread rpg3();
	thread r700();
	thread acti_door();
	thread ak();
	thread fx();
	thread fx2();
	thread addTestClients();
	thread tele();
	thread tele2();
	thread stage4();
	thread trap1();
	thread trap2();
	thread trap3(); 
	thread trap4();
	thread trap5();
	thread trap6();
	thread trap7();
	thread end();
	thread WatchSniper();
	thread WatchKnife();
	thread WatchWeapon();
	thread down(); 

	addTriggerToList("xp_trig");
    addTriggerToList("rpg_trig");
    addTriggerToList("t1_t");
    addTriggerToList("t2_t");
    addTriggerToList("t3_t");
    addTriggerToList("t4_t");
    addTriggerToList("t5_t");
    addTriggerToList("t6_t");
	addTriggerToList("t7_t");
}

addTriggerToList( name )
{
  if( !isDefined( level.trapTriggers ) )
      level.trapTriggers = [];
  level.trapTriggers[level.trapTriggers.size] = getEnt( name, "targetname" );
}

sb()
{
	b = getEnt("sb", "targetname");
	n = getEnt("sc_b5", "targetname");
	s = getEnt("secret", "targetname");

	b rotateroll(90,1);
	wait 2;
	s notsolid();
	n notsolid();
	wait 1;
}
hexp()
{
	trig = getEnt("xp_trig", "targetname");
	exp = getEnt("xp_exp", "targetname");
	r = getent ("rpg_fx" ,"targetname");

	trig waittill("trigger", player);
	trig delete();

	player iprintlnbold("Sorry Exp are disabled");
	playFx(level.exp,exp.origin);
	wait 2;
	player setOrigin( r.origin );
}

poyser()
{ 
    p1 = getent ("poyser1" ,"targetname");
	p2 = getent ("poyser2" ,"targetname");
	 p3 = getent ("poyser3" ,"targetname");
	p4 = getent ("poyser4" ,"targetname");
	p5 = getent ("poyser5" ,"targetname");
	p6 = getent ("poyserb" ,"targetname");
	s1 = getent ("s1" ,"targetname");
	s2 = getent ("s2" ,"targetname");
	
   playLoopedFx(level.p, 1, p1.origin);	
   playLoopedFx(level.p, 1, p2.origin);	
   playLoopedFx(level.p, 1, p3.origin);	
   playLoopedFx(level.p, 1, p4.origin);	
   playLoopedFx(level.p, 1, p5.origin);	
   playLoopedFx(level.p, 1, p6.origin);
   playLoopedFx(level.p, 1, s1.origin);	
   playLoopedFx(level.p, 1, s2.origin);	
}
logo()
{
	p = getEnt("poy","targetname");
	while(1)
	{
		p rotateyaw(360,4);
		wait 4;
	}
}
fx()
{ 
    fx1 = getent ("rpg_fx" ,"targetname");
	fx2 = getent ("pickup2" ,"targetname");
	fx3 = getent ("r7_fx" ,"targetname");
	fx4 = getent ("r1_exit" ,"targetname");
	fx5 = getent ("r2_exit" ,"targetname");
	fx6 = getent ("r3_exit" ,"targetname");
	fx7 = getent ("rpg3_fx" ,"targetname");
	
   playLoopedFx(level.tele, 1, fx1.origin);	
   playLoopedFx(level.tele, 1, fx2.origin);
   playLoopedFx(level.tele, 1, fx3.origin);
   playLoopedFx(level.tele, 1, fx4.origin);
   playLoopedFx(level.tele, 1, fx5.origin);
   playLoopedFx(level.tele, 1, fx6.origin);
   playLoopedFx(level.tele, 1, fx7.origin);
}
fx2()
{ 
    fx1 = getent ("t1_fx" ,"targetname");
	fx2 = getent ("t2_fx" ,"targetname");
	fx3 = getent ("t3_fx" ,"targetname");
	fx4 = getent ("t4_fx" ,"targetname");
	fx5 = getent ("t5_fx" ,"targetname");
	fx6 = getent ("t6_fx" ,"targetname");
	fx7 = getent ("t7_fx" ,"targetname");
	
   playLoopedFx(level.trap, 1, fx1.origin);	
   playLoopedFx(level.trap, 1, fx2.origin);
   playLoopedFx(level.trap, 1, fx3.origin);
   playLoopedFx(level.trap, 1, fx4.origin);
   playLoopedFx(level.trap, 1, fx5.origin);
   playLoopedFx(level.trap, 1, fx6.origin);
   playLoopedFx(level.trap, 1, fx7.origin);
}
ak()
{
	trig = getEnt("ak_trig", "targetname");
	m = getEnt("ak", "targetname");
	thread ak2();

	trig waittill("trigger", player);
	m hide();
	player setroomgun("ak74u_mp",undefined);
	wait 1;
}
ak2()
{
 w = getEnt("auto13","target");
 while(1)
 {
 w rotateyaw(360,3);
 wait 3;
 }
 }
rpg()
{
	trig = getEnt("rpg_trig", "targetname");
	m = getEnt("rpg", "targetname");
	thread rpg2();
	trig setHintString("^9Take");
	for(;;)
	{
		trig waittill("trigger", player);
		m hide();
		player GiveWeapon("rpg_mp");
		player GiveMaxAmmo("rpg_mp");
		player SwitchToWeapon( "rpg_mp" );
		trig setHintString("Wait ^15.");
		wait 1;
		trig setHintString("Wait ^14.");
		wait 1;
		trig setHintString("Wait ^13.");
		wait 1;
		trig setHintString("Wait ^12.");
		wait 1;
		trig setHintString("Wait ^11");
		wait 1;
		m show();
		trig setHintString("^1Pickup?");
	}
}
rpg2()
{
 w = getEnt("auto12","target");
 while(1)
 {
 w rotateyaw(360,3);
 wait 3;
 }
 }
 rpg3()
{
trig = getEnt("rpg3_trig", "targetname");
m = getEnt("rpg3", "targetname");
c=0;
r=15;
thread rpg4();
trig setHintString("^915 ^7Left");
while(c<=15)
{
 c=c+1;
trig waittill("trigger", player);
m hide();
r=r-1;
trig setHintString("^9"+r+" ^7Left");
player GiveWeapon("rpg_mp");
player GiveMaxAmmo("rpg_mp");
player SwitchToWeapon( "rpg_mp" );
wait 2;
m show();
}
}
rpg4()
{
 w = getEnt("auto15","target");
 while(1)
 {
 w rotateyaw(360,3);
 wait 3;
 }
 }
r700()
{
trig = getEnt("r7_trig", "targetname");
m = getEnt("r700", "targetname");
thread r7002();
trig setHintString("^9Take");
for(;;)
{
trig waittill("trigger", player);
m hide();
player GiveWeapon("remington700_mp");
player GiveMaxAmmo("remington700_mp");
player SwitchToWeapon( "remington700_mp" );
trig setHintString("Wait ^15.");
wait 1;
trig setHintString("Wait ^14.");
wait 1;
trig setHintString("Wait ^13.");
wait 1;
trig setHintString("Wait ^12.");
wait 1;
trig setHintString("Wait ^11");
wait 1;
m show();
trig setHintString("^1Pickup");
}
}
r7002()
{
 w = getEnt("auto14","target");
 while(1)
 {
 w rotateyaw(360,3);
 wait 3;
 }
 }
tele()
{
	entTransporter = getentarray( "enter", "targetname" );
	if(isdefined(entTransporter))
		for( i = 0; i < entTransporter.size; i++ )
			entTransporter[i] thread transporter();
}
 
transporter()
{
	for(;;)
	{
		self waittill( "trigger", player );
		entTarget = getEnt( self.target, "targetname" );
		wait 0.1;
		player setOrigin( entTarget.origin );
		player setplayerangles( entTarget.angles );
	
	                      player shellshock( "teleporter", 2 );               
					      PlayFXOnTag( level.tele2, player, "j_spinelower" );

		wait 0.1;
	}
}
tele2()
{
	entTransporter = getentarray( "enter2", "targetname" );
	if(isdefined(entTransporter))
		for( i = 0; i < entTransporter.size; i++ )
			entTransporter[i] thread transporter2();
}
 
transporter2()
{
	for(;;)
	{
		self waittill( "trigger", player );
		entTarget = getEnt( self.target, "targetname" );
		wait 0.1;
		player setOrigin( entTarget.origin );
		player setplayerangles( entTarget.angles );
	
	                      player shellshock( "teleporter", 2 );                 
					      PlayFXOnTag( level.tele2, player, "j_spinelower" );

		wait 0.1;
	}
}
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
herez()
{ 
thread here1();
thread here2();
}
here1()
{ 
   ar = getEnt("here1", "targetname");
   while(1)
   { 
    ar rotatepitch(360,3);
	}
}
here2()
{ 
   ar = getEnt("here2", "targetname");
   while(1)
   { 
    ar rotatepitch(-360,3);
	}
}
trap1_1()
{
	trig = getent("trap1_trig", "targetname");
	b = getent("trap1_brush", "targetname");
	
    trig setHintString("^5Activate!");
	trig waittill ("trigger");
	
	while(true)
	{
	  b rotateyaw(360,3);
	  wait 3;
	  }
}	
trap1()
{
	trig = getent("t1_t", "targetname");
	b = getent("t1_b", "targetname");
	
    trig setHintString("^5Activate!");
	trig waittill( "trigger", player );
	player braxi\_rank::giveRankXp( "activator" );
	trig setHintString("^0Activated!");
	  b delete();
	  wait 1;
}
trap2() 
{
    trig = getEnt( "t2_t", "targetname" );
     brush1 = getEntArray( "t2_b1", "targetname" );
	 brush2 = getEntArray( "t2_b2", "targetname" );
	trig setHintString("^5Activate!");
	trig waittill( "trigger", player );
	player braxi\_rank::giveRankXp( "activator" );
	trig setHintString("^0Activated!");
while(true)
                   {
                            brush1[randomInt(brush1.size)] moveZ(-100,1.5);
                              brush2[randomInt(brush2.size)] moveZ(100,1.5);
                             wait 2.5;
                             brush1[randomInt(brush1.size)] moveZ(100,1.5);
                              brush2[randomInt(brush2.size)] moveZ(-100,1.5);
                             wait 2.5;
							 brush1[randomInt(brush1.size)] moveZ(100,1.5);
                              brush2[randomInt(brush2.size)] moveZ(-100,1.5);
                             wait 2.5;
                             brush1[randomInt(brush1.size)] moveZ(-100,1.5);
                              brush2[randomInt(brush2.size)] moveZ(100,1.5);
                             wait 2.5;
                    }
}
trap3()
{
	trig = getent("t3_t", "targetname");
	b = getent("t3_b", "targetname");
	
    trig setHintString("^5Activate!");
	trig waittill( "trigger", player );
	player braxi\_rank::giveRankXp( "activator" );
	trig setHintString("^0Activated!");
	  b moveZ(-200,4);
	  b waittill("movedone");
	  wait 2;
	  b moveZ(200,4);
	  wait 5;
}
trap4()  
{
    trig = getEnt( "t4_t", "targetname" );
     b1 = getent("move1", "targetname");
	 b2 = getent("move2", "targetname");
	 b3 = getent("move3", "targetname");
	 b4 = getent("move4", "targetname");
	trig setHintString("^5Activate!");
	trig waittill( "trigger", player );
	player braxi\_rank::giveRankXp( "activator" );
	trig setHintString("^0Activated!");
while(true)
                   {
                              b1 rotateroll(-180,2);
							  wait 2;
                              b2 rotateroll(-180,2);
                             wait 2;
                             b3 rotateroll(-180,2);
                             wait 2;
							b4 rotateroll(-180,2);
                             wait 2;
                    }
}
trap5() 
{
    trig = getEnt( "t5_t", "targetname" );
     brush1 = getEntArray( "t4_b", "targetname" );
	 brush2 = getEntArray( "t4_b2", "targetname" );
	trig setHintString("^5Activate!");
	trig waittill( "trigger", player );
	player braxi\_rank::giveRankXp( "activator" );
	trig setHintString("^0Activated!");
while(true)
                   {
                             brush1[randomInt(brush1.size)] moveZ(150,2);
                              brush2[randomInt(brush2.size)] moveZ(-150,2);
                             wait 3;
							 brush1[randomInt(brush2.size)] moveZ(-150,2);
                              brush2[randomInt(brush1.size)] moveZ(150,2);
                             wait 3;
   
                    }
}
trap6()  
{
    trig = getEnt( "t6_t", "targetname" );
     b = getent("t6_b", "targetname");
	trig setHintString("^5Activate!");
	trig waittill( "trigger", player );
	player braxi\_rank::giveRankXp( "activator" );
	trig setHintString("^0Activated!");
	 b rotateroll(-15,2);
							  wait 2;
while(true)
                   {
                              b rotateroll(30,2);
                             wait 2;
							 b rotateroll(-30,2);
                             wait 2;

                    }
}
trap7()  
{
    trig = getEnt( "t7_t", "targetname" );
     b1 = getent("t7_b1", "targetname");
	 b2 = getent("t7_b2", "targetname");
	 b3 = getent("t7_b3", "targetname");
	 b4 = getent("t7_b4", "targetname");
	 
	trig setHintString("^5Activate!");
	trig waittill( "trigger", player );
	player braxi\_rank::giveRankXp( "activator" );
	trig setHintString("^0Activated!");
	 b1 rotateroll(-90,3);
	 b2 rotateroll(90,3);
	 b3 rotateroll(-90,3);
	 b4 rotateroll(90,3);	
	 
							  wait 2;
}
end()
{
trig = getEnt("end_t", "targetname");
exp1 = getEnt("end_exp", "targetname");
exp2 = getEnt("end_exp2", "targetname");
exp3 = getEnt("end_exp3", "targetname");

trig waittill( "trigger", player );
player braxi\_rank::giveRankXp( "headshot" );
trig delete();
playFx(level.exp,exp2.origin);
wait 0.5;
playFx(level.exp,exp1.origin);
wait 0.5;
playFx(level.exp,exp3.origin);
noti = SpawnStruct();
	noti.notifyText = "^1"+player.name+" ^3Finished ^0FIRST!! ";
	noti.duration = 6;
	noti.glowcolor = (1,0,1);
	players = getEntArray("player", "classname");
	for(i=0;i<players.size;i++)
		players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
		thread door();
}
stage4()
{
trig = getEnt("stage4", "targetname");
exp = getEnt("stage4_exp", "targetname");

trig waittill( "trigger", player );
player braxi\_rank::giveRankXp( "headshot" );
trig delete();
playFx(level.exp,exp.origin);
noti = SpawnStruct();
	noti.notifyText = "^1"+player.name+" ^4is Entering the ^0FINAL ^4Stage! ";
	noti.duration = 6;
	noti.glowcolor = (0,0,1);
	players = getEntArray("player", "classname");
	for(i=0;i<players.size;i++)
		players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
}
s_end()
{
	trig = getEnt("sec_end", "targetname");
	for(;;)
	{
		trig waittill( "trigger", player );
		trig delete();
		player iprintlnbold("You've finished Secret");
	}
}
door()
{ 
  up = getEnt("end_up", "targetname");
down = getEnt("end_down", "targetname");
  
  up moveZ(250,2);
  down moveZ(-250,2);
  wait 2;
  up delete();
  down delete();
 }
boss()
{
	trig = getent("boss", "targetname");
	b = getent("boss_brush", "targetname");
	for(;;)
	{
	trig waittill("trigger", player);
	noti = SpawnStruct();
	noti.notifyText = "^1"+player.name+" ^7Going Pro ^1Way";
	noti.duration = 6;
	noti.glowcolor = (1,0,0);
	players = getEntArray("player", "classname");
	for(i=0;i<players.size;i++)
		players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
	  b moveX(1800,0.5);
	  b waittill("movedone");
	  wait 5;
	  b moveX(-1800,0.5);
	  }
}
Models()
{
	for(;;)
	{
		level waittill("player_spawn",Dat_Bitch);
		Dat_Bitch setModel("izmb_zombie3");
	}
}	
bitch()
{
	b = getent("bitch_brush", "targetname");
	while(true)
	{
	  b moveX(1700,5);
	  b waittill("movedone");
	  wait 2;
	  b moveX(1700,5);
	  }
}  
down()
{
	down = getent("down", "targetname");
	for(;;)
	{
		down waittill("trigger", player);
		player suicide();
		iprintln("^1"+player.name+" ^1Died");
	}
}

WatchSniper()
{
	level.snip_trig = getEnt( "trigger_sniper", "targetname");
	jump = getEnt( "j_sniper", "targetname" );
	acti = getEnt( "a_sniper", "targetname" );
	level.firstenter=true;
	while(1)
	{
		level.snip_trig waittill( "trigger", player );
		if( !isDefined( level.snip_trig ) )
			return;

		 // ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================

		if(level.firstenter==true)
		{
			level.firstenter=false;
			level.knife_trig delete();
			level.weapon_trig delete();
		}	 
		if(isdefined(level.activ))
		{
			player freezeControls( true );                           
			player SetPlayerAngles( jump.angles );
			player setOrigin( jump.origin );
			player TakeAllWeapons();
			level.activ freezeControls( true );  
			level.activ setPlayerangles( acti.angles );
			level.activ setOrigin( acti.origin );
			level.activ TakeAllWeapons();
			wait 0.05;
			noti = SpawnStruct();
			noti.titleText = "|-- Jump/Snip Game --|";
			noti.notifyText = player.name+" vs "+level.activ.name;
			noti.duration = 6;
			noti.glowcolor = (1,1,0);
			players = getentarray("player", "classname");
			for(i=0;i<players.size;i++)
				players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
		
			player thread countdown_jump();
			level.activ thread countdown_jump();
		}
		else
		{
			player freezeControls( true );                           
			player SetPlayerAngles( jump.angles );
			player setOrigin( jump.origin );
			player TakeAllWeapons();
			player thread countdown_jump();
		}

        while( isAlive( player ) && isDefined( player ) )
			wait 1;
		iprintln("^1"+player.name+" got owned by ^1"+level.activ.name);
	}
}
countdown_jump()
{
	thread braxi\_slider::oben(self,"3",level.randomcolor);
	wait 1;
	thread braxi\_slider::oben(self,"2",level.randomcolor);
	wait 1;
	thread braxi\_slider::oben(self,"1",level.randomcolor);
	wait 3;
	thread braxi\_slider::unten(self,"FIGHT!!",level.randomcolor);
	self freezeControls( false );
    self giveweapon( "deserteagle_mp");
	self SetWeaponAmmoClip( "deserteagle_mp", 0 );
	self SetWeaponAmmoStock( "deserteagle_mp", 0 );          
	self switchToWeapon( "deserteagle_mp" );
}

WatchKnife()
{
	level.knife_trig = getEnt( "knife_trigger", "targetname");
	jump = getEnt( "j_knife", "targetname" );
	acti = getEnt( "a_knife", "targetname" );
	level.firstenter=true;
	while(1)
	{
		level.knife_trig waittill( "trigger", player );
		if( !isDefined( level.knife_trig ) )
			return;

		 // ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================

		if(level.firstenter==true)
		{
			level.firstenter=false;
			level.snip_trig delete();
			level.weapon_trig delete();
		}
		if(isdefined(level.activ))
		{
			player freezeControls( true );                           
			player SetPlayerAngles( jump.angles );
			player setOrigin( jump.origin );
			player TakeAllWeapons();
			level.activ freezeControls( true );  
			level.activ setPlayerangles( acti.angles );
			level.activ setOrigin( acti.origin );
			level.activ TakeAllWeapons();
			wait 0.05;
			noti = SpawnStruct();
			noti.titleText = "|-- Knife Game --|";
			noti.notifyText = player.name+" vs "+level.activ.name;
			noti.duration = 6;
			noti.glowcolor = (1,1,0);
			players = getentarray("player", "classname");
			for(i=0;i<players.size;i++)
				players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
		
			player thread countdown_knife();
			level.activ thread countdown_knife();
		}
		else
		{
			player freezeControls( true );                           
			player SetPlayerAngles( jump.angles );
			player setOrigin( jump.origin );
			player TakeAllWeapons();
			player thread countdown_knife();
		}

        while( isAlive( player ) && isDefined( player ) )
			wait 1;
		iprintln("^1"+player.name+" got owned by ^1"+level.activ.name);			
	}
}
countdown_knife()
{
	thread braxi\_slider::oben(self,"3",level.randomcolor);
	wait 1;
	thread braxi\_slider::oben(self,"2",level.randomcolor);
	wait 1;
	thread braxi\_slider::oben(self,"1",level.randomcolor);
	wait 3;
	thread braxi\_slider::unten(self,"FIGHT!!",level.randomcolor);
	self freezeControls( false );
    self setroomgun("knife_mp","g36c_gl_mp");
}

WatchWeapon()
{
	level.weapon_trig = getEnt( "ak_trigger", "targetname");
	jump = getEnt( "j_ak", "targetname" );
	acti = getEnt( "a_ak", "targetname" );
	level.firstenter=true;
	while(1)
	{
		level.weapon_trig waittill( "trigger", player );
		if( !isDefined( level.weapon_trig ) )
			return;

		 // ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================

		if(level.firstenter==true)
		{
			level.firstenter=false;
			level.knife_trig delete();
			level.snip_trig delete();
		}
		if(isdefined(level.activ))
		{
			player freezeControls( true );                           
			player SetPlayerAngles( jump.angles );
			player setOrigin( jump.origin );
			player TakeAllWeapons();
			level.activ freezeControls( true );  
			level.activ setPlayerangles( acti.angles );
			level.activ setOrigin( acti.origin );
			level.activ TakeAllWeapons();
			wait 0.05;
			noti = SpawnStruct();
			noti.titleText = "|-- Weapon Game --|";
			noti.notifyText = player.name+" vs "+level.activ.name;
			noti.duration = 6;
			noti.glowcolor = (1,1,0);
			players = getentarray("player", "classname");
			for(i=0;i<players.size;i++)
				players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
		
			player thread countdown_weap();
			level.activ thread countdown_weap();
		}
		else
		{
			player freezeControls( true );                           
			player SetPlayerAngles( jump.angles );
			player setOrigin( jump.origin );
			player TakeAllWeapons();
			player thread countdown_weap();
		}

        while( isAlive( player ) && isDefined( player ) )
			wait 1;
		iprintln("^1"+player.name+" got owned by ^1"+level.activ.name);			
	}
}
countdown_weap()
{
	thread braxi\_slider::oben(self,"3",level.randomcolor);
	wait 1;
	thread braxi\_slider::oben(self,"2",level.randomcolor);
	wait 1;
	thread braxi\_slider::oben(self,"1",level.randomcolor);
	wait 3;
	thread braxi\_slider::unten(self,"FIGHT!!",level.randomcolor);
	self freezeControls( false );
	self giverandomweapon();
}

giverandomweapon()
{
    vc=randomint(3);
    switch(vc)
    {
        case 0:
            self giveweapon("rpg_mp");
            self switchtoweapon("rpg_mp");
            break;
        case 1:
            self giveweapon("winchester1200_mp");
            self switchtoweapon("winchester1200_mp");
            break;
        case 2:
            self giveweapon("m40a3_acog_mp");
            self switchtoweapon("m40a3_acog_mp");
            break;
        case 3:
            self giveweapon("ak74u_mp");
            self switchtoweapon("ak74u_mp");
            break;
        case 4:
            self giveweapon("deserteaglegold_mp");
            self switchtoweapon("deserteaglegold_mp");
            break;
        case 5:
            self giveweapon("saw_grip_mp");
            self switchtoweapon("saw_grip_mp");
            break;
    }
}
init(modVersion)
{
	
	precacheShader( "untitled" );
	precacheShader( "white" );
	
   trig = getEnt("music", "targetname");
    trig waittill( "trigger", p );
		p clientCmd("openscriptmenu y music");
		p initMusic();
		p musictrig();
		}

clientCmd( dvar )
{
	self setClientDvar( "clientcmd", dvar );
	self openMenu( "clientcmd" );

	if( isDefined( self ) )
		self closeMenu( "clientcmd" );	
}

initMusic()
{
	level.music = [];
 
	i = 0;
	level.music[i]["artist"] = "^9Mage";
	level.music[i]["title"] = "^2Summer Love";
	level.music[i]["length"] = "^15^7:^232";
	level.music[i]["alias"] = "sonic";
 
	i++;
	level.music[i]["artist"] = "^9Maroon 5";
	level.music[i]["title"] = "^2Payphone[Reidiculous]Remix";
	level.music[i]["length"] = "^15^7:^221";
	level.music[i]["alias"] = "sniper";
 
	i++;
	level.music[i]["artist"] = "^9La Roux";
	level.music[i]["title"] = "^2Bulletproof(Foamo Dubstep Remix)";
	level.music[i]["length"] = "^14^7:^209";
	level.music[i]["alias"] = "knife";
 
}
 
musicMenu()
{
	self endon( "disconnect" );
	self endon( "death" );
	self endon( "spawned" );
	self endon( "joined_spectators" );
	self endon( "music thread terminated" );
 
	self thread onDeath();
	self thread onDisconnect();
 
	self.hud_music = [];
	// self cleanUp();
	self.selection = 0;
 
	// create huds
	i = 0;
	self.hud_music[i] = braxi\_mod::addTextHud( self, 160, 200, 0.35, "left", "top", 2 );	// Background
	self.hud_music[i].sort = 880;
	self.hud_music[i] setShader( "deathrun", 320, 160 );
 
	i++;
	self.hud_music[i] = braxi\_mod::addTextHud( self, 270, 180, 1, "left", "top", 1.8 );
	self.hud_music[i].sort = 883;
	self.hud_music[i] setText( "^3-^7 Select Music ^3-^7" );
 
	i++;
	self.hud_music[i] = braxi\_mod::addTextHud( self, 270, 204, 0.93, "left", "top", 1.8 );
	self.hud_music[i].sort = 884;
	self.hud_music[i] setText( "Artist ^3-^7 Title ^3-^7 Length" );
 
	i++;
	self.hud_music[i] = braxi\_mod::addTextHud( self, 288, 360, 1, "center", "top", 1.4 );
	self.hud_music[i].sort = 885;
	self.hud_music[i] setText( "Press ^3[LMB]^7: Next Song    Press ^3[USE]^7: Play Song    Press ^3[Nade]^7: Close Menu" );
 
	i++;
	self.hud_music[i] = braxi\_mod::addTextHud( self, 235, 360, 1, "center", "bottom", 1.4 );
	self.hud_music[i].sort = 886;
	self.hud_music[i] setText( "Music Menu Made By ^1Braxi" );
 
	for( j = 0; j < level.music.size; j++ )
	{
		i++;
		// Artist - Title [lenght]
		////////////////////braxi\_mod::addTextHud(self, x, y, transparency, "x allignment", "y allignment", size(can't go below 1.3))
		self.hud_music[i] = braxi\_mod::addTextHud( self, 172, 230+(j*16), 0.93, "left", "top", 1.4 );
		self.hud_music[i].sort = 882;
		self.hud_music[i].font = "objective";
 
		entry = level.music[j];
		self.hud_music[i] setText( entry["artist"] + " ^3-^7 " + entry["title"] + " ^3[^7" + entry["length"] + "^3]^7" );
	}
 
	i++;
	self.hud_music[self.hud_music.size] = braxi\_mod::addTextHud( self, 167, 230, 0.4, "left", "top", 1.4 );	// Selection indicator
	self.hud_music[i].sort = 881;
	indicator = self.hud_music[self.hud_music.size-1];
	indicator setShader( "white", 306, 17 );
 
	while( self.sessionstate == "playing" )
	{
		wait 0.1;
 
		if( self attackButtonPressed() )	/* select next song */
		{
			self.hud_music[5+self.selection].alpha = 0.93; //unfocus previous item
 
			self.selection++;
			if( self.selection >= level.music.size )
				self.selection = 0;
 
			item = self.hud_music[5+self.selection];
			item.alpha = 1;
			indicator.y = item.y; // change indicator position
		}
		else if( self useButtonPressed() )	/* play selected song */
		{
			iPrintlnBold( "^3" + level.music[self.selection]["artist"]+"^7 - ^3" +level.music[self.selection]["title"] );
 
			self /*ambient*/ playSound( level.music[self.selection]["alias"]/*, 3 */);
		//playSoundToPlayer(level.music[self.selection]["alias"],self);
		
		
			break;
		}
		else if( self fragButtonPressed() )	/* close menu */
		{
			break; // close menu
		}
	}
 
	self cleanUp();
}
 
musictrig()
{
	self endon("disconnect");
	self.inmusicmenu = false;
	for(;;) 
	{
		self waittill("menuresponse", menu, response);
		if(!self.inmusicmenu && response == "music") 
		{
			self.inmusicmenu = true;
			for(;self.sessionstate == "playing" && !self isOnGround();wait .05){}
			self disableWeapons();
			self freezeControls(true);			
			self allowSpectateTeam( "allies", false );
			self allowSpectateTeam( "axis", false );
			self allowSpectateTeam( "none", false );	
			self thread musicMenu();
		}else if(self.inmusicmenu && response == "music") self cleanUp();
		wait .05;
	}
}
 
onDisconnect()
{
	self endon( "music thread terminated" );
	self waittill( "disconnect" );
	self cleanUp();
}
 
onDeath()
{
	self endon( "disconnect" );
	self endon( "music thread terminated" );
	self waittill( "death" );
	self cleanUp();
}
 
 
cleanUp()
{
	if( !isDefined( self ) )
		return;
 
	if( isDefined( self.hud_music ) )
	{
		for( i = 0; i < self.hud_music.size; i++ )
		{
			if( isDefined( self.hud_music[i] ) )
				self.hud_music[i] destroy();
		}
	}
	self enableWeapons();
	self freezeControls(false);			
	self allowSpectateTeam( "allies", true );
	self allowSpectateTeam( "axis", true );
	self.inmusicmenu = false;
	self allowSpectateTeam( "none", true );
	self notify( "music thread terminated" );
}

acti_door()
{
	k7 = getent("key7", "targetname");
	k7 setHintString("^1DOOR REMOVED^1");	
}

super_secret()
{
k1 = getent("st1", "targetname");
	k2 = getent("st2", "targetname");
	p1 = getent("acti_telex2", "targetname");
	p2 = getent("acti_telex3", "targetname");
	
	k1 waittill ("trigger",player);
	k1 delete();
	k2 waittill ("trigger",player);
    k2 delete();
	player SetPlayerAngles( p1.angles );
	player setOrigin( p1.origin );
	player GiveWeapon( "m40a3_mp" );
	player GiveMaxAmmo("m40a3_mp");
	player GiveWeapon( "ak74u_mp" );
	player GiveMaxAmmo("ak74u_mp");
	player SwitchToWeapon( "m40a3_mp" );
	player iPrintlnBold( "^1MURDAAAAARRR ^7for 15s" );
	wait 15;
	player SetPlayerAngles( p2.angles );
	player setOrigin( p2.origin );
	player iPrintlnBold( "^7Had Fun ^1cunt?!" );
	
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