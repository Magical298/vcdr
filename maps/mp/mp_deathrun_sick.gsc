main()
{

    maps\mp\_load::main();
    maps\mp\sick\_music::main();
	
	level.fx["bombexplosion"] = loadfx( "explosions/tanker_explosion" );
	level.fireball_incomming = LoadFX("shiet/fire_incomming");
	level.fireball_impact = LoadFX("shiet/fire_impact");
	level.fire_blue = LoadFX("shiet/fire_blue");
	level.laser_center = LoadFX("shiet/laser_center");
	level.magic_orbs = LoadFX("shiet/magic_orbs");
	level.orb_center = LoadFX("shiet/orb_center");
	level.orb_explosion = LoadFX("shiet/orb_explosion");
	level.exp = LoadFX("explosions/tanker_explosion");
	level.colours = LoadFX("vistic/rainbow_funken");
	level.deagle_fx = LoadFX("vistic/dance_floor");
	level.snip_fx = LoadFX("flys/flys");
	level.sick1="f0909b6a1c65356edf1cbaaac409ae43";
	level.sick2="38cf1b4001a07fd860fd3382d2d57204";
	level.creditTime = 3.5;

	
	game["allies"] = "sas";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "woodland";
	game["axis_soldiertype"] = "woodland";
	
	setdvar( "r_specularcolorscale", "1" );
	setdvar("r_glowbloomintensity0",".25");
	setdvar("r_glowbloomintensity1",".25");
	setdvar("r_glowskybleedintensity0",".3");
	setdvar("compassmaxrange","1800");
	setDvar("bg_falldamagemaxheight", 20000 );
	setDvar("bg_falldamageminheight", 15000 );
	setDvar("g_speed",220);

	thread fx_player();
	thread addTestClients();
	thread minefields();
	thread trap1();
	thread information();
	thread trap2();
    thread speed();
    thread trap22();
    thread trap3();
    thread trap4();
    thread trap5();
    thread slider();
    thread pakourdone();
    thread failer1();
    thread failer2();
    thread r_old();
    thread r_deagle();
    thread r_sniper();
    thread r_jump();
    thread door1();
    thread door2();
    thread door3();
    thread time1();
    thread time2();
    thread jump_fail();
	thread jumpgun();
	thread mysticdoor();
	thread mysticbox();
	thread sick_vip();

	addtriggertolist("trap1_trig");
	addtriggertolist("trap3_trig");
	addtriggertolist("crusher_trig");
	addtriggertolist("spinner_trig");
	addtriggertolist("spinner2_trig");
	addtriggertolist("trap22_trig");
}

addTriggerToList( name )
{
   if( !isDefined( level.trapTriggers ) )
      level.trapTriggers = [];
   level.trapTriggers[level.trapTriggers.size] = getEnt( name, "targetname" );
}

flash_player()
{
	self endon("death");
	while(1)
	{
		wait 1;
		playfxontag(level.colours,self,"j_knee_ri");
	}
}

fx_player()
{
	trig = getEnt ("fx_player", "targetname");
	trig waittill("trigger", player);
	trig delete();
	thread sick();
}

information()
{
 
    level endon( "intermission" );
 
    colour = randomInt(5);
    switch(colour)
            {
            case 0:
            level.hudcolour = (0, 0.9, 2);
            break;
            case 1:
            level.hudcolour = (0, 1, 1);
            break;
            case 2:
            level.hudcolour = (0.8 ,1 ,0.1);
            break;
            case 3:
            level.hudcolour = (1, 0, 0);
            break;
            case 4:
            level.hudcolour = (0.9, 0.1, 0.9);
            break;
            }
 
    if( isDefined( level.icomarhud ) )
        level.icomarhud destroy();
 
    level.icomarhud = newHudElem();
    level.icomarhud.foreground = true;
    level.icomarhud.alignX = "center";
    level.icomarhud.alignY = "top";
    level.icomarhud.horzAlign = "center";
    level.icomarhud.vertAlign = "top";
    level.icomarhud.x = 4;
    level.icomarhud.y = 0;
    level.icomarhud.sort = 0;
    level.icomarhud.fontScale = 2;
    level.icomarhud.color = (1.0, 1.0, 1.0);
    level.icomarhud.font = "objective";
    level.icomarhud.glowColor = (level.hudcolour);
    level.icomarhud.glowAlpha = 1;
    level.icomarhud.hidewheninmenu = true;
    level.icomarhud setText( "mp_deathrun_sick" );
    wait 10;
	level.icomarhud setText( "map by Poyser" );
	wait 10;
	level.icomarhud setText( "remake by Blade" );
	wait 10;
	level.icomarhud setText( "Vistic Clan" );
	wait 10;
	level.icomarhud destroy();
}

sick()
{

	wait 3;
	thread StartMassEffect();
}

StartMassEffect()
{
	SetExpFog( 128, 768, 0, 0, 0, 3 );
	wait 1;
	ambientplay("sick_fx");
	
	center = (0,0,350);
	ang = 0;
	fire_pos = undefined;
	fireball = undefined;
	
	for(i=0;i<5;i++)
	{
		fire_pos[i] = center+AnglesToForward( (0,ang,0) )*830;
		thread CreateFireball( fire_pos[i]+(0,0,1000) );
		ang += 72;		//5*72 = 360
		wait 1;
	}
	wait 4;
	fireball = getentarray("fireball", "targetname");
	for(i=0;i<fireball.size;i++)
	{
		trace = BulletTrace( fireball[i].origin, fireball[i].origin-(0,0,3000), false, fireball[i] );
		fireball[i] MoveTo( (trace["position"][0],trace["position"][1],250), 1, 1, 0 );
	}
	wait 1;
	for(i=0;i<fireball.size;i++)
	{
		EarthQuake( 1, 1, fireball[i].origin, 700 );
		PlayFX( level.fireball_impact, fireball[i].origin );
		PlayFX( level.fire_blue, fireball[i].origin );
		fireball[i] delete();
	}
	thread DoRandomFog();
	//thread DoEarthQuaking();
	
	wait 5;
	
	height = 250;
	for(i=0;i<3;i++)
	{
		PlayFX( level.laser_center, (0,0,height) );
		height += 150;
		wait 1;
	}
	wait 1;
	
	orb = Spawn("script_model", (0,0,250) );
	orb SetModel("tag_origin");
	wait 0.05;
	PlayFXOnTag( level.orb_center, orb, "tag_origin" );
	orb MoveZ( 600, 5, 1, 1 );
	
	wait 6;
	
	PlayFX( level.orb_explosion, orb.origin );
	EarthQuake( 1.5, 1.5, orb.origin, 1600 );
	orb delete();
	
	spawns = getentarray("mp_tdm_spawn", "classname");
	for(i=0;i<spawns.size;i++)
		PlayFX( level.fireball_impact, spawns[i].origin+(0,0,50) );
	
	wait 3;
	
	PlayFX( level.magic_orbs, (0,0,500) );
}

CreateFireball( pos )
{
	fireball = spawn("script_model", pos );
	fireball SetModel("tag_origin");
	fireball.targetname = "fireball";
	wait 0.05;
	PlayFXOnTag( level.fireball_incomming, fireball, "tag_origin" );
}

DoRandomFog()
{
	while(1)
	{
		time = 1+RandomInt(3);
		SetExpFog( 64+RandomInt(256), 256+RandomInt(768), RandomFloat(1), RandomFloat(1), RandomFloat(1), time );
		wait time;
	}
}

DoEarthQuaking()
{
	EarthQuake( 0.1, 1, self.origin, 500 );
		wait 0.5;
}

sick_body()
{
	self endon("death");
	while(1)
	{
	    PlayFXOnTag( level.sick_body, self, "j_spinelower" );
		wait 1;
	}							  			  
}
							  			  
colours()
{ 
    col = getent ("gi" ,"targetname");
	
    playLoopedFx(level.colours, 1, col.origin);	
}

glow()
{
	glower = getEntArray("glower","targetname");
	while(1)
	{
		for(k = 0; k < glower.size; k++)
			playFx(level.colours,glower[k].origin);
			
		wait .5;
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
minefields()
{
	minefields = getentarray("minefield", "targetname");
	if (minefields.size > 0)
	{
		level.fx["bombexplosion"] = loadfx( "explosions/tanker_explosion" );
	}
	
	for(i = 0; i < minefields.size; i++)
	{
		minefields[i] thread minefield_think();
	}	
}

minefield_think()
{
	while (1)
	{
		self waittill ("trigger",other);
		
		if(isPlayer(other))
			other thread minefield_kill(self);
	}
}

minefield_kill(trigger)
{
	if(isDefined(self.minefield))
		return;
		
	self.minefield = true;

	wait(.01);
	wait(randomFloat(.01));

	if(isdefined(self) && self istouching(trigger))
	{
		origin = self getorigin();
		range = 300;
		maxdamage = 2000;
		mindamage = 50;

		playfx(level.fx["bombexplosion"], origin);
		radiusDamage(origin, range, maxdamage, mindamage);
	}
	
	self.minefield = undefined;
}

trap1()
{
	trig = getEnt ("trap1_trig", "targetname");
	trig setHintString("^2Faster^7!!");
	trig waittill("trigger", player);
	trig setHintString("^2Activated!");
	
	wait .05;
	thread move1();
	thread move2();
	thread move3();
	thread move4();
	
}
move1()
{
	brush = getEnt ("trap1_1", "targetname");

		while(1)
	    {
		brush rotateroll( 360,3);
		wait 3;
	    }
	 
}
move2()
{
	brush = getEnt ("trap1_2", "targetname");

		while(1)
	    {
		brush rotateroll( -360,3);
		wait 3;
	    }
	 
}
move3()
{
	brush = getEnt ("trap1_3", "targetname");

		while(1)
	    {
		brush rotateroll( 360,3);
		wait 3;
	    }
	 
}
move4()
{
	brush = getEnt ("trap1_4", "targetname");

		while(1)
	    {
		brush rotateroll( -360,3);
		wait 3;
	    }
	 
}

trap3()
{
    trig = getEnt( "trap3_trig", "targetname" );
	brush = getEnt( "exp_brush", "targetname" );
	rotate = getent("trap4_rotate","targetname");
	exp = getent ("exp" ,"targetname");
	trig setHintString("^1Explode^7!");
	trig waittill("trigger", player);
	trig setHintString("^2Activated!");
	playFx(level.exp,exp.origin);
	EarthQuake( 1.9, 1.9, exp.origin, 2600 );
	wait 1;
	brush delete();
	while(1)
	{
		rotate rotatepitch(360,3);
		wait .1;
	}
}
trap4()
{
    trig = getEnt( "crusher_trig", "targetname" );
	brush = getEnt( "crusher", "targetname" );
	hurt = getEnt( "hurt", "targetname" );
	trig setHintString("^1Activate");
	trig waittill("trigger", player);
	trig setHintString("^2Activated!");
	hurt enablelinkto ();
	hurt linkto (brush);
	brush moveY(-880,5);
	brush waittill("movedone");
	brush moveY(880,5);
	wait 1;
}

trap5()
{
    trig = getEnt( "spinner_trig", "targetname" );
	brush = getEnt( "spinner", "targetname" );
	hurt = getEnt( "hurt2", "targetname" );
	trig setHintString("^1Activate!");
	trig waittill("trigger", player);
	trig setHintString("^2Activated!");
	hurt playsound("spinnerr");
	hurt enablelinkto ();
	hurt linkto (brush);
	while(1)
	{
	brush rotateyaw(360,3.5);
	wait 2;
	}
	
}
trap2()
{
    trig = getEnt("spinner2_trig","targetname");
    trap = getent("spinner2","targetname");
    help = getent("spinner2_help","targetname");
	trig setHintString("[^1USE^7] ^2Trap 2 ^7[^1USE^7]");
	trig waittill("trigger");
	trig delete();
	help delete();
	wait 1.5;
	while(1)
	{
		trap rotateyaw(360,3.5);
		wait 2;
	}
}

trap22()
{
    trig = getEnt( "trap22_trig", "targetname" );
	brush = getEnt( "trap2", "targetname" );
	trig setHintString("^1Activate");
	trig waittill("trigger", player);
	trig setHintString("^2Activated!");

	brush moveZ(-250,3);
	brush waittill("movedone");	
	brush delete();
	
}

slider()
{
	sli = getEnt("slider", "targetname");
	trig = getEnt("slider_trig", "targetname");
	level.isFirst = 0;
	for(;;)
	{
		trig waittill("trigger", player );
		if(level.isFirst==0)
		{
			level.isFirst = 1;
			player GiveWeapon("deserteagle_mp");
    		player SwitchToWeapon( "deserteagle_mp" );
			iPrintln("^2"+player.name+" ^1got a sick deagle");
		}
		sli moveX(-820,2);
		sli waittill("movedone");
		sli moveX(820,2);
	}
}

speed()
{
trig = getent ("faster", "targetname");
while(1)
{
trig waittill ("trigger",user);
trig delete();
user SetMoveSpeedScale( 1.3 );
user thread flash_player();
}
}
flasher()
{
    trig = getEnt("flash_trig", "targetname");
	sc = getEnt("flash", "targetname");
	for(;;)
	{
	trig waittill("trigger", player );
	playFx(level.flash,sc.origin);
	}
}

eye5()
{
	eye = self.origin + (0, 0, 60);

	if(self getStance() == "crouch")
		eye = self.origin + (0, 0, 40);

	else if(self getStance() == "prone")
		eye = self.origin + (0, 0, 11);

	return eye;
}

getPlayerEyePosition5()
{
        if(self getStance() == "prone")
	        eye = self.origin + (0, 0, 11);
        else if(self getStance() == "crouch")
	        eye = self.origin + (0, 0, 40);
	else
	        eye = self.origin + (0, 0, 60);

        return eye;
}

pakourdone()
{
	target = getent("finishparkour","targetname");
	trig = getent("pakourdone","targetname");
	for(;;)
	{
		trig waittill("trigger", player );
		//playFx(level.flash,target.origin);
		player setorigin(target.origin);
		player setplayerangles(target.angles);
	}
}

failer1()
{
	target = getent("fail_origin1","targetname");
	trig = getent("fail_trig1","targetname");
	for(;;)
	{
		trig waittill("trigger", player );
		player freezecontrols(1);
		player setorigin(target.origin);
		player setplayerangles(target.angles);
		wait 1;
		player freezecontrols(0);
	}
}

failer2()
{
	target = getent("fail_origin2","targetname");
	trig = getent("fail_trig2","targetname");
	for(;;)
	{
		trig waittill("trigger", player );
		player freezecontrols(1);
		player setorigin(target.origin);
		player setplayerangles(target.angles);
		wait 1;
		player freezecontrols(0);
	}
}

r_old()
{
  	level.old = getEnt("old", "targetname");
    brush = getent("old_door","targetname");
    level.old waittill("trigger",player);
    EarthQuake( 1, 1, (1056,-768,592), 700 );
    brush delete();
    level.old delete();

    noti = SpawnStruct();
            noti.titleText = "^1Old ^2opened !";
            noti.notifyText = "^1"+player.name+" ^2opened the Door";
            noti.duration = 6;
            noti.glowcolor = (0, 0, 1.0);
            players = getEntArray("player", "classname");
            for(i=0;i<players.size;i++)
            players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
            wait 2;

    level.snip delete();
    level.deagle delete();
    level.jump delete();
}

r_sniper()
{
	level.snip = getEnt("snip", "targetname");
	fx = getent("snip_fx","targetname");
    jump = getEnt( "jump_snip", "targetname" );
	acti = getEnt( "acti_snip", "targetname" );
	level.firstenter=false;

	while(1)
	{
		level.snip waittill("trigger",player);
		if(!isDefined(level.snip))
			return;

		// ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================

		if(level.firstenter==false)
		{
			noti = SpawnStruct();
	            noti.titleText = "^1Sniper ^2opened !";
	            noti.notifyText = "^1"+player.name+" ^2opened the Door";
	            noti.duration = 6;
	            noti.glowcolor = (0, 0, 1.0);
	            players = getEntArray("player", "classname");
	            for(i=0;i<players.size;i++)
	            players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
	        playloopedfx(level.snip_fx,0.5,fx.origin);
			level.old delete();
    		level.deagle delete();
    		level.jump delete();
			level.firstenter = true;
		}

		player FreezeControls(1);
		level.activ FreezeControls(1);

		player SetPlayerAngles( jump.angles );
        player setOrigin( jump.origin );
        level.activ setPlayerangles( acti.angles );
        level.activ setOrigin( acti.origin );

        player takeallweapons();
        level.activ takeallweapons();
        player giveWeapon( "remington700_mp" );
		level.activ giveWeapon( "remington700_mp" );
        /*player thread jumper_sick();
        level.activ acti_sick();*/

        thread showCredit( "^2.:^13^2:.", 2.3 );
        wait 0.5;
        thread showCredit( "^2.:^12^2:.", 2.3 );
        wait 0.5;
		thread showCredit( "^2.:^11:.", 2.3 );
		wait 0.5;
		thread showCredit( "^2.:^1Sick Him^2:.", 2.3 );
	    wait 5;

	    player switchToWeapon( "remington700_mp" );
		level.activ SwitchToWeapon( "remington700_mp" );

		player FreezeControls(0);
		level.activ FreezeControls(0);

		while( isAlive( player ) && isDefined( player ) )
			wait 1;
	}
}

r_deagle()
{
	level.deagle = getEnt("deagle", "targetname");
	fx = getent("deagle_fx","targetname");
    jump = getEnt( "jump_deagle", "targetname" );
	acti = getEnt( "acti_deagle", "targetname" );
	level.firstenter=false;

	while(1)
	{
		level.deagle waittill("trigger",player);
		if(!isDefined(level.deagle))
			return;

		// ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================

		if(level.firstenter==false)
		{
			noti = SpawnStruct();
	            noti.titleText = "^1Deagle ^2opened !";
	            noti.notifyText = "^1"+player.name+" ^2opened the Door";
	            noti.duration = 6;
	            noti.glowcolor = (0, 0, 1.0);
	            players = getEntArray("player", "classname");
	            for(i=0;i<players.size;i++)
	            players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
	        playloopedfx(level.deagle_fx,0.5,fx.origin);
			level.old delete();
    		level.snip delete();
    		level.jump delete();
			level.firstenter = true;
		}

		player FreezeControls(1);
		level.activ FreezeControls(1);

		player SetPlayerAngles( jump.angles );
        player setOrigin( jump.origin );
        level.activ setPlayerangles( acti.angles );
        level.activ setOrigin( acti.origin );

        player takeallweapons();
        level.activ takeallweapons();
        player giveWeapon( "deserteagle_mp" );
		level.activ giveWeapon( "deserteagle_mp" );
        /*player thread jumper_sick();
        level.activ acti_sick();*/

        thread showCredit( "^2.:^13^2:.", 2.3 );
        wait 0.5;
        thread showCredit( "^2.:^12^2:.", 2.3 );
        wait 0.5;
		thread showCredit( "^2.:^11:.", 2.3 );
		wait 0.5;
		thread showCredit( "^2.:^1Sick Him^2:.", 2.3 );
	    wait 3;

	    player switchToWeapon( "deserteagle_mp" );
		level.activ SwitchToWeapon( "deserteagle_mp" );

		player FreezeControls(0);
		level.activ FreezeControls(0);

		while( isAlive( player ) && isDefined( player ) )
			wait 1;
	}
}

r_jump()
{
	level.jump = getEnt("jump", "targetname");
	fx = getent("jump_fx","targetname");
    jump = getEnt( "jumpi_jump", "targetname" );
	acti = getEnt( "acti_jump", "targetname" );
	level.firstenter=false;

	while(1)
	{
		level.jump  waittill("trigger",player);
		if(!isDefined(level.jump ))
			return;

		// ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================

		if(level.firstenter==false)
		{
			noti = SpawnStruct();
	            noti.titleText = "^1Jump ^2opened !";
	            noti.notifyText = "^1"+player.name+" ^2opened the Door";
	            noti.duration = 6;
	            noti.glowcolor = (0, 0, 1.0);
	            players = getEntArray("player", "classname");
	            for(i=0;i<players.size;i++)
	            players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
	        playloopedfx(level.colours,0.5,fx.origin);
			level.old delete();
    		level.snip delete();
    		level.deagle delete();
			level.firstenter = true;
		}

		player FreezeControls(1);
		level.activ FreezeControls(1);

		player SetPlayerAngles( jump.angles );
        player setOrigin( jump.origin );
        level.activ setPlayerangles( acti.angles );
        level.activ setOrigin( acti.origin );

        player takeallweapons();
        level.activ takeallweapons();
        player giveWeapon( "knife_mp" );
		level.activ giveWeapon( "knife_mp" );
        /*player thread jumper_sick();
        level.activ acti_sick();*/

        thread showCredit( "^2.:^13^2:.", 2.3 );
        wait 0.5;
        thread showCredit( "^2.:^12^2:.", 2.3 );
        wait 0.5;
		thread showCredit( "^2.:^11:.", 2.3 );
		wait 0.5;
		thread showCredit( "^2.:^1Sick Him^2:.", 2.3 );
	    wait 3;

	    player switchToWeapon( "knife_mp" );
		level.activ SwitchToWeapon( "knife_mp" );

		player FreezeControls(0);
		level.activ FreezeControls(0);

		while( isAlive( player ) && isDefined( player ) )
			wait 1;
	}
}

jump_fail()
{
	acti = getEnt("acti_jump","targetname");
	jump = getEnt("jumpi_jump","targetname");
	trigger = getent("jump_fail","targetname");
	for(;;)
	{
		trigger waittill("trigger",player);
	
		if(player.pers["team"] != "spectator")
		{
			if(player.pers["team"] == "allies")
			{
				player SetPlayerAngles(jump.angles);
				player SetOrigin(jump.origin);
			}
			if(player.pers["team"] == "axis")
			{
				player SetPlayerAngles(acti.angles);
				player SetOrigin(acti.origin);
			}
		}
	}
}

showCredit( text, scale )
{
	end_text = newHudElem();
	end_text.font = "objective";
	end_text.fontScale = scale;
	end_text SetText(text);
	end_text.alignX = "center";
	end_text.alignY = "top";
	end_text.horzAlign = "center";
	end_text.vertAlign = "top";
	end_text.x = 0;
	end_text.y = 540;
	end_text.sort = -1; //-3
	end_text.alpha = 1;
	end_text.glowColor = (.1,.8,0);
	end_text.glowAlpha = 1;
	end_text moveOverTime(level.creditTime);
	end_text.y = -60;
	end_text.foreground = true;
	wait level.creditTime;
	end_text destroy();
}

door1()
{
	trig = getent("door1_trig","targetname");
	doora = getent("door1a","targetname");
	doorb = getent("door1b","targetname");
	trig waittill("trigger");
	trig delete();
	doora movex(65,2);
	doorb movex(-65,2);
}

door2()
{
	trig = getent("door2_trig","targetname");
	doora = getent("door2a","targetname");
	doorb = getent("door2b","targetname");
	trig waittill("trigger");
	trig delete();
	doora movez(-70,2);
	doorb movez(70,2);
}

door3()
{
	trig = getent("door3_trig","targetname");
	doora = getent("door3a","targetname");
	doorb = getent("door3b","targetname");
	trig waittill("trigger");
	trig delete();
	doora movez(-60,2);
	doorb movez(60,2);
}

time1()
{
	trig = getent("time1_trig","targetname");
	time = getent("time1","targetname");
	trig waittill("trigger",player);
	iprintlnbold("^2Aint nobody got time for ^1"+player.name);
	trig delete();
	time movez(-770,5);
	time waittill("movedone");
	time delete();
}

time2()
{
	trig = getent("time2_trig","targetname");
	time = getent("time2","targetname");
	trig waittill("trigger",player);
	iprintlnbold("^2Aint nobody got time for ^1"+player.name);
	trig delete();
	time movez(-770,5);
	time waittill("movedone");
	time delete();
}

jumpgun()
{
	trig = getent("jump_gun","targetname");	
	trig sethintstring("^2Pickup ^1Weapon");
	trig waittill("trigger",player);
	iprintlnbold(player.name+" ^2picked the weapon");
	player takeallweapons();
	player giveweapon("m40a3_mp");
	player switchtoweapon("m40a3_mp");
}

mysticdoor()
{
	door1 = getEnt("mysticd1","targetname");
	door2 = getEnt("mysticd2","targetname");
	door3 = getEnt("mysticd3","targetname");
	door4 = getEnt("mysticd4","targetname");

	doort = getent("mysticd","targetname");
	doort sethintstring("[^1USE^7] ^2Mystic Door ^7[^1USE^7]");
	doort waittill("trigger");
	doort delete();

	door1 movez(-50,2);
	door2 movez(-50,2);
	door3 movez(-50,2);
	door4 movez(-50,2);
	wait 2;
	door1 movex(-145,3);
	wait 3;
	door2 movex(145,3);
	wait 3;
	door3 movex(145,3);
	wait 3;
	door4 movex(-145,3);
}

mysticbox()
{
	trig = getent("mysticbox","targetname");
	trig sethintstring("[^1USE^7] ^2Mystic Box ^7[^1USE^7]");
	trig waittill("trigger",player);
	trig delete();
	
	vc = randomint(5);
	if(vc==0)
	{
		player iprintlnbold("^2You got ^1M40A3");
		player takeallweapons();
		player giveweapon("m40a3_mp");
		player switchtoweapon("m40a3_mp");
	}
	if(vc==1)
	{
		player iprintlnbold("^2You got ^1Intervention");
		player takeallweapons();
		player giveweapon("m14_silencer_mp");
		player switchtoweapon("m14_silencer_mp");
	}
	if(vc==2)
	{
		player iprintlnbold("^2You got ^1Deagle");
		player takeallweapons();
		player giveweapon("deserteagle_mp");
		player switchtoweapon("deserteagle_mp");
	}
	if(vc==3)
	{
		player iprintlnbold("^2You got ^1Mauser96");
		player takeallweapons();
		player giveweapon("g36c_mp");
		player switchtoweapon("g36c_mp");
	}
	if(vc==4)
	{
		player iprintlnbold("^2You got ^1Colt .44");
		player takeallweapons();
		player giveweapon("colt44_mp");
		player switchtoweapon("colt44_mp");
	}
}

sick_vip()
{
	sick=getent("nico","targetname");
	while(1)
	{
		sick waittill("trigger",vc);
		code=vc getguid();
		if(vc useButtonPressed())
		{
			if((code==level.sick1)||(code==level.sick2))
			{
				vc iprintlnbold("^5W^6e^5l^6c^5o^6m^5e");
				vc thread vip_stuff();
			}
			else
			{
				vc iprintlnbold("^5You are not a ^6VIP");
			}
		}
		else
        wait .5;
    }
}

vip_stuff()
{
	self setModel("playermodel_GTA_IV_NICO");
	self setViewModel("viewmodel_base_viewhands");
	self takeallweapons();
	self giveweapon("colt44_mp");
	self switchtoweapon("colt44_mp");
	self setperk("specialty_fastreload");
}