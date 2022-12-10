/* 
 MM  MMM  MM IMM. MMM  MM   ~MMMMM  MMMMMM   MMMMMZ   MMMMMN                    
 MM. MMM MM  OMM  MMMM MM  MMM         MMM  MM~  MMM  MM .MM                    
  MMMMMM MM  MMM  MMMMMMM  MM  MMM   :MM    MM    MM .MMMMM                     
  MMM,DMMM   MMM  MM MMMM  MMM  MM  MMM     MM7  MMM  MM MM                     
  MMM  MMM   MMM  MM  MMM   NMMMMM  MMMMMM   NMMMM .  MM MMM                    
*/
main()
{
	//maps\mp\_load::main();
	
	//setExpFog(800, 2500, 255/255, 250/255, 250/255, 0.0);
	//ambientPlay("soundalias");

	game["allies"] = "sas";
	game["axis"] = "russian";
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["allies_soldiertype"] = "woodland";
	game["axis_soldiertype"] = "woodland";

	
	//////////dvars/////////////////////////////
	setdvar( "r_specularcolorscale", "1" );
	setdvar("r_glowbloomintensity0",".25");
	setdvar("r_glowbloomintensity1",".25");
	setdvar("r_glowskybleedintensity0",".3");
	
	///////////variable////////////////////
	level.magicfx = LoadFX( "magictrap" );
	level.magicfx2 = LoadFX( "etherion_1" );
	level.cloudbank = LoadFX( "weather/cloud_bank" );
	level.fireworks = LoadFX( "fireworks/mainfirework" );
	level.dragonbreath = LoadFX( "dragonbreath" );
	level.memorymake = LoadFX( "memorymake" );
	
	PlayLoopedFX( level.cloudbank, 3, (16,-15056,40));
	PlayLoopedFX( level.cloudbank, 3, (0,-15200,40));
	PlayLoopedFX( level.cloudbank, 3, (200,-15200,40));
	PlayLoopedFX( level.cloudbank, 3, (-200,-15200,40));
	
	level.trap_trigger_1 = getent("trigger_1","targetname");
	level.trap_trigger_2 = getent("trigger_2","targetname");
	level.trap_trigger_3 = getent("trigger_4","targetname");
	level.trap_trigger_4 = getent("trigger_3","targetname");
	level.trap_trigger_5 = getent("trigger_5","targetname");
	level.trap_trigger_6 = getent("trigger_6","targetname");
	

	thread mapstart();
	
	thread trap1();//bridge
	thread trap2();//magic dmg
	thread trap3();//spinner
	
	thread trap5(); //canon fx
	thread trap6(); //rand drop
	thread trap7(); //spinners2
	
	thread mover();
	thread fireworks();
	thread memorymake();
	
	//thread powers();
	thread endgame();
	thread trap4(); //below acti
	thread addtriggers();
}

addtriggers()
{
addTriggerToList("trigger_1");
addTriggerToList("trigger_2");
addTriggerToList("trigger_3");
addTriggerToList("trigger_4");
addTriggerToList("trigger_5");
addTriggerToList("trigger_6");
}

addTriggerToList( name )
{
  if( !isDefined( level.trapTriggers ) )
      level.trapTriggers = [];
  level.trapTriggers[level.trapTriggers.size] = getEnt( name, "targetname" );
}

endgame()
{
	level.endgame = getent("end_game","targetname");
		
	level.acti_enemy = undefined;
	level.turn = 1;
	level.jumper_turn = [];
	while(1)
	{
		level.endgame waittill("trigger", player );
		
		if( getTeamPlayersAlive("axis") < 1 )
		{
			player iprintlnbold("^1You can't fight alone.");
			return;
		}

		// ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================
		
		iprintlnbold( player.name + " finished first!");
		iprintlnbold("^11 VS 1 Fight!");

		thread StartFinalFight(level.activ,player);
	}
}

StartFinalFight(acti,jumper)
{
	level notify("killinstances");
	
	spawnorigin = getEnt("endgame_jumper", "targetname");
	level.actspawnorigin = getEnt("endgame_acti", "targetname");
	
	acti SetPlayerAngles( level.actspawnorigin.angles );
	acti SetOrigin( level.actspawnorigin.origin );
	jumper SetPlayerAngles( spawnorigin.angles );
	jumper SetOrigin( spawnorigin.origin );
	
	acti takeallweapons();
	acti giveweapon("knife_mp");
	acti switchtoweapon("knife_mp");

	jumper takeallweapons();
	jumper giveweapon("knife_mp");
	jumper switchtoweapon("knife_mp");


	acti FreezeControls(1);
	jumper FreezeControls(1);
	

	wait 2;

	noti = SpawnStruct();
	noti.titleText = "=|BATTLE|=";
	noti.notifyText = "1 VS 1 ";
	noti.duration = 5;
	noti.glowcolor = (1,0,0);
	players = getentarray("player", "classname");
	for(i=0;i<players.size;i++)
		players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
	
	wait 2;
	
	noti = SpawnStruct();
	noti.titleText = acti.name + " ^3VS ^7" + jumper.name;
	noti.notifyText = "GET READY!";
	noti.duration = 5;
	noti.glowcolor = (1,0,0);
	players = getentarray("player", "classname");
	for(i=0;i<players.size;i++)
		players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
	
	wait 2;
	
	jumper FreezeControls(0);
	acti FreezeControls(0);
	jumper enableWeapons();
	acti enableWeapons();
	iprintlnbold("^3F  I  G  H  T !");
}


dragonslayerbreath()
{
	
	level endon("killinstances");
	self endon("disconnect");
	self endon("death");
	level endon("game over");
	self.attack="breath";
	delay = 0;
	
	self takeallweapons();
	self giveweapon( "knife_mp" );
	self SwitchToWeapon( "knife_mp" );
	
	while(1)
	{
		
		
		if( self AttackButtonPressed() && delay < 1 )
		{
				if(self.attack=="breath"){
					self thread cast_slayermagic();
					delay = 2;
					}
				
		}
		
		if( delay > 0 )
			delay --;
		
		while( self AttackButtonPressed() || self FragButtonPressed() )
			wait 0.1;
		
		wait 0.1;
	}
	
}


cast_slayermagic()
{
    self endon("death");
	
    self iprintlnbold("start");
	self PlaySoundToPlayer( "ndb", self );
	wait 1;
	self.breath = Spawn("script_model", self GetEye()+AnglesToForward( self GetPlayerAngles() )*50 );
	self.breath_dmg = Spawn("script_model", self GetEye()+AnglesToForward( self GetPlayerAngles() )*400 );
	self.breath setModel("tag_origin");
	self.breath.angles = self GetPlayerAngles();
	forward = AnglesToForward(self GetPlayerAngles());
	up = AnglesToUp( forward );

	PlayFX(level.dragonbreath,self.breath.origin,up,forward);
	RadiusDamage( self.breath_dmg, 200, 40, 10, self );
	iprintln("spawn");
	
	

}


memorymake()
{
	xmin = -136;
	xmax = 136;
	ymax = -2568;
	ymin = -2840;
	zmin = 40;
	zmax = 280;
	level.memorymaketrig = false;
	thread mm_trig();
	while(1)
	{
		level.memorymaketrig = true;
		for(i=0;i<60;i++)
			{
				spawn_memorymake(xmin,xmax,ymax,ymin,zmin,zmax);
				wait 0.05;
			}
		level.memorymaketrig = false;
		wait 10;
	}
		
}

mm_trig()
{	
	trig = getent("memorymaketrigger","targetname");
	loc[0]= (trig.origin);
	loc[1] = (8,-4616,-472);
	loc[2] = (8,-6536,-472);
	loc[3] = (8,-7480,-472);
	loc[4] = (8,-8648,-472);
	
	while(1)
	{
		trig waittill("trigger", player);
		if(level.memorymaketrig == true && player.mm == false)
		{
			player.mm = true;
			player PlaySoundToPlayer( "mmsfx", player );
			player freezecontrols(1);
			wait 1;
			rand = randomintrange(0,4);
			player SetOrigin( loc[rand] );
			player freezecontrols(0);
			player.mm = true;
		}
		
		
	}
}

spawn_memorymake(xmin,xmax,ymax,ymin,zmin,zmax)
{
	rand1 = randomintrange(xmin,xmax);
	rand2 = randomintrange(ymin,ymax);
	rand3 = randomintrange(zmin,zmax);
	PlayFX( level.memorymake,  (rand1,rand2,rand3));
	rand1 = randomintrange(xmin,xmax);
	rand2 = randomintrange(ymin,ymax);
	rand3 = randomintrange(zmin,zmax);
	PlayFX( level.memorymake,  (rand1,rand2,rand3));
}

fireworks()
{
	trig = getent("fireworks","targetname");
	
	trig waittill("trigger",player);
	iprintlnbold(player.name+" has arrived at the guild !");
	PlayLoopedFX( level.fireworks, 3, (0,0,40));
	
}

mapstart()
{
	city = getent("city","targetname");
	door = getent("startdoor","targetname");
	fences = getent("track_fences","targetname");
	
	fences hide();
	city movex(2048,0.05);
	
	wait 15;
	
	//mover sound here
	city movex(-2048,8);
	Earthquake( 0.3, 9, city.origin, 8500 );
	wait 6;
	fences show();
	wait 0.05;
	//fairytail zenkai sound here
	ambientplay("ftzenkai");
	wait 0.05;
	door movez(-200,4);
	Earthquake( 0.3, 4, door.origin, 200 );
	wait 4;
	ambientstop();
	
	rand = RandomIntRange( 100, 500 );
	if(rand>100 && rand<200)
		ambientplay("ftds");
	else if(rand>200 && rand<300)
		ambientplay("ftfl");
	else if(rand>300 && rand<400)
		ambientplay("ftmh");
	else if(rand>400 && rand<500)
		ambientplay("ftts");
	else
		ambientplay("ftts");
	//ambientstart here
}

trap1()
{

	

bridge=getent("bridgemain","targetname");
rswings=getent("bridgerightswings","targetname");
bridgeturn=getent("bridgerightpin","targetname");
swingturn=getent("bridgerightmainpin","targetname");
lswings=getent("bridgeleftswings","targetname");

level.trap_trigger_1 waittill("trigger");

lswings delete();

rswings linkto(swingturn);
bridgeturn linkto(rswings);
bridge linkto(bridgeturn);

swingturn rotatePitch(35,1);
wait 1.05;
bridgeturn unlink();
bridgeturn rotatePitch(-125,1);
wait 1.05;
bridge unlink();
rswings unlink();

}

trap2()
{
	level.trap_trigger_2 waittill("trigger");	
	while(1)
	{
		rand1 = randomintrange(0,100);
		rand2 = randomintrange(0,100);
		rand3 = randomintrange(0,100);
		
		if(rand1<50)
		{
			PlayFX( level.magicfx,  (-480,-9888,-510));
			RadiusDamage( (-480,-9888,-510), 250, 80, 15 );//need set level.activ as attacker (last comma)
		}
		if(rand2<50)
		{
			PlayFX( level.magicfx,  (-32,-9888,-510));
			RadiusDamage( (-32,-9888,-510), 250, 80, 15 );
		}
		if(rand3<50)
		{
			PlayFX( level.magicfx,  (480,-9888,-510));
			RadiusDamage( (480,-9888,-510), 250, 80, 15 );
		}
		
		wait 1;
	}
}

trap3()
{
	spinner =getent("trap3_spinner","targetname");
	hurt=getent("trap3_spinner_dmg1","targetname");
	hurt2=getent("trap3_spinner_dmg2","targetname");
	hurt.dmg = 0;
	hurt2.dmg = 0;
	
	level.trap_trigger_3 waittill("trigger");	
	
	hurt EnableLinkTo();
	hurt2 EnableLinkTo();
	hurt linkto(spinner);
	hurt2 linkto(spinner);
	hurt.dmg = 9999;
	hurt2.dmg = 9999;
	while(1)
	{
		spinner rotateYaw(360,5);
		wait 5;
	}
}

trap4()
{
	rot_left =getent("left_rotator","targetname");
	rot_right =getent("right_rotator","targetname");
	
	
	while(1)
	{
	rot_left rotatePitch(180,2);
	rot_right rotatePitch(-180,2);
	wait 20;
	rot_left rotatePitch(-180,2);
	rot_right rotatePitch(180,2);
	wait 20;
	}

	
}

trap5()
{
	fence = getent("fence_trap","targetname");
	hurt = getent("fence_trap_dmg","targetname");
	clip = getent("fence_trap_clip","targetname");
	
	fence hide();
	clip notsolid();
	fence notsolid();
	
	fence movez(-48,1);
	fence waittill("movedone");
	
	angles = VectorToAngles( (0,-6992,-520) - (0,-6992,0) );
	forward = AnglesToForward(angles);
	hurt.dmg = 0;
	
	level.trap_trigger_4 waittill("trigger");	
	while(1)
	{
	
	fence show();
	fence solid();
	clip solid();
	fence movez(48,2);
	fence waittill("movedone");
	
	PlayFX( level.magicfx2,  (0,-6992,-520));
	PlayFX( level.magicfx2,  (0,-6992,0),forward );
	hurt.dmg = 1;
	
	wait 0.9;
	hurt PlaySound("impact_eth");
	wait 1.1;
	Earthquake( 0.3, 1, (0,-6992,-520), 850 );
	wait 0.2;
	hurt.dmg = 9999;
	
	wait 1;
	hurt.dmg = 0;
	clip notsolid();
	fence movez(-48,2);
	fence waittill("movedone");
	fence hide();
	fence notsolid();
	
	
	wait 10;
	}

	
}

trap6()
{
	turn_left =getent("trap6_left_turn","targetname");
	turn_mid =getent("trap6_mid_turn","targetname");
	turn_right =getent("trap6_right_turn","targetname");
	part_left =getent("trap6_left","targetname");
	part_mid =getent("trap6_mid","targetname");
	part_right =getent("trap6_right","targetname");
	
	part_left linkto(turn_left);
	part_mid linkto(turn_mid);
	part_right linkto(turn_right);
	
	level.trap_trigger_5 waittill("trigger");	
	while(1)
	{
		rand = RandomIntRange( 100, 400 );
		
		if(rand>100 && rand<200){
			turn_left rotateRoll(-90,3);
			wait 3.05;
			turn_left rotateRoll(90,3);
			wait 3.05;
		}
		else if(rand>200 && rand<300)
			{
			turn_mid rotateRoll(-90,3);
			wait 3.05;
			turn_mid rotateRoll(90,3);
			wait 3.05;
		}
		else if(rand>300 && rand<400)
			{
			turn_right rotateRoll(-90,3);
			wait 3.05;
			turn_right rotateRoll(90,3);
			wait 3.05;
		}
		else
		{
			wait 3.05;
		}
		
		wait 3.05;
	}
	
}

trap7()
{
	spinner1=getent("left_spinner","targetname");
	spinner2=getent("right_spinner","targetname");
	
	level.trap_trigger_6 waittill("trigger");	
	spinner1 thread trap7_spin();
	spinner2 thread trap7_spin(true);
	
}

trap7_spin(reverse)
{
	if(!isdefined(reverse))
		reverse=false;
	while(1)
	{
	if(reverse)
		self rotatePitch(-360,2);
	else
		self rotatePitch(360,2);
	wait 2;
	}
}

mover()
{
	mover=getent("mover_last","targetname");
	
	while(1)
	{
		mover movey(1216,8);
		mover waittill("movedone");
		wait 1;
		mover movey(-1216,8);
		mover waittill("movedone");
		wait 1;
	}
	
}