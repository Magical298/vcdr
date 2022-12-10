/* 
	MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
	MI             O     M      M    8MM.      MMM        MMM.     MMM         7MMMM
	MI             O     M      M    8M        MMM        MM        MM          MMMM
	MMM.  N    M OMMM   MMM~    .M7 MM8   +M+  MMM 8M    MMM   IM    MM.  MMM   MMMM
	MMM   ..   . MMMM   MMM=     NI MM   .MMMMMMMM OD   .MM=   MM8  .MM.  MM8   MMMM
	MMM$         MMMM   MMM= M    I MM   .M......MMM    MMM.   MMM   MM.       MMMMM
	MMMM        ,MMMM   MMM= M.   I MM    M      MMO    Z=I    MMM  .MM.        MMMM
	MMMM    D   MMMMM   MMM= MN     MM.   MM   MMMM,   MI ~N   NM:  .MM.  MMI   7MMM
	MMMM,  ZM   MMMO     M. ..7     MMM        MMM+    .. ~M        ?M..  . M    MMM
	MMMMM  MM   MMM8     M    7M    MMM~       MMM.       ~MM       MM      M   .MMM
	MMMMM  MMN MMMM8     M    7M    MMMMM.  M  MM.        ~MMM.   7MMM      M.  =MMM
	MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM 
	MMMMMMMMMMMM XFIRE=EVILPHINAL MMMMMMMMMMMMMMMMMM WINGZOR.COM MMMMMMMMMMMMMMMMMMM

	Script fixed by Blade
	Website: vistic-clan.com
*/
#include braxi\_common;
main()
{
	//===================================================
	// ### Script Loads
	maps\mp\_load::main();

	//===================================================
	// ### Game Setup
	game["allies"] = "sas";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "woodland";
	game["axis_soldiertype"] = "woodland";

	//===================================================
	// ### Effects
	level.abovehuman["powerzone_idle"] = LoadFX("dball/powerzone");
	level.fx_airstrike_contrail = loadfx ("smoke/jet_contrail");
	level.abovehuman["fireball_charge"] = LoadFX("dball/kishotcharge");
	level.abovehuman["fireball_tracer"] = LoadFX("dball/kamehamehatracer");
	level.abovehuman["fireball_explosion"] = LoadFX("dball/kishotimpact");
	level.abovehuman["nuke_explosion"] = LoadFX("explosions/nuke_explosion");	
	level.abovehuman["fireball_charge_big"] = LoadFX("dball/kishotcharge_big");
	level.burn_fx = LoadFX("dball/ssjglow");
	level.glow = LoadFX("dball/playerburst");
	level.abovehuman["fireball_tracer_small"] = LoadFX("dball/kamehamehatracer_small");
	level.abovehuman["fireball_charge_small"] = LoadFX("dball/kishotcharge_small");
	level.abovehuman["fireball_explosion_small"] = LoadFX("dball/kishotimpact_small");
	level.fx_shenron["sheron"] = loadFx("dball/shenron_spawn");

	//===================================================
	// ### Dvars
	setdvar( "r_specularcolorscale", "1" );
	setdvar("r_glowbloomintensity0",".25");
	setdvar("r_glowbloomintensity1",".25");
	setdvar("r_glowskybleedintensity0",".3");

	//===================================================
	// ### Precaches
	precacheShellShock( "frag_grenade_mp" );

	//===================================================
	// ### Threads
	thread mapsong();
	thread brushes();
	thread enemey_low();
	thread supersaiyan();
	thread traps();
	thread shortcutmove1();
	thread logo();
	thread dballs();
	thread dragonballsfound();
	thread hud();
	thread pillars();
	thread kniferoom();

	//===================================================
	// ### Traps Disable
	addTriggerToList( "trigger1" );
    addTriggerToList( "trigger2" );
    addTriggerToList( "trigger3" );
    addTriggerToList( "trigger4" );
    addTriggerToList( "trigger5" );
    addTriggerToList( "trigger6" );
}

addTriggerToList(name)
{
    if(!isDefined(level.trapTriggers))
        level.trapTriggers=[];
    level.trapTriggers[level.trapTriggers.size]=getEnt(name,"targetname");
}

mapsong()
{
	level waittill("round_started");
	ambientPlay("zor");

	thread braxi\_mod::drawinformationsmall( 800, 0.8, 1, "Dragonball GT" );
	wait 4;
	thread braxi\_mod::drawinformationsmall( 800, 0.8, 1, "� Wingzor" );
}

pillars()
{
	pillars = getent( "pillars", "targetname" );
	while(1)
	{
		pillars rotateYaw(360,10);
		wait 9.9;
	}
}

dballs()
{
	rotation = 80;
	triggers_per_ball = 4;
	
	time = 3;
	
	balls_spinpoint = getent( "ball_origin", "targetname" );
	level.dbz_balls = [];
	
	i = 0;
	while( isDefined( getEnt( "dbzball_" + i, "targetname" ) ) )
	{
		level.dbz_balls[ i ] = getEnt( "dbzball_" + i, "targetname" );
		level.dbz_balls[ i ] linkTo( balls_spinpoint );
		
		i++;
	}
	
	level.balls_left = level.dbz_balls.size;
	
	wait 3;
	balls_spinpoint rotateYaw(3600,1);
	balls_spinpoint moveZ( 400, time * 3, time / 5, time / 5 );
	balls_spinpoint rotateVelocity( ( 0, rotation, 0 ), time * 3 );
	
	wait time * 3;
	
	level.dbz_triggers = [];
	
	for( i = 0; i < level.dbz_balls.size; i++ )
	{
		trigger_num = randomInt( triggers_per_ball );
		
		level.dbz_triggers[ i ] = getEnt( "ball_" + i + "_trigger_" + trigger_num, "targetname" );
		
		level.dbz_balls[i] unLink();
		level.dbz_balls[i] moveTo( ( level.dbz_triggers[i].origin[0], level.dbz_triggers[i].origin[1], level.dbz_balls[i].origin[2] ), time, time / 5, time / 5 );
	}
	
	wait time;
	
	for( i = 0; i < level.dbz_balls.size; i++ )
	{
		level.dbz_balls[i] moveTo( level.dbz_triggers[i].origin, time, time / 5, time / 5 );
		level.dbz_balls[i] rotateVelocity( ( 0, rotation, 0 ), time );
	}
	
	wait time;
	
	for( i = 0; i < level.dbz_triggers.size; i++ )
	{
		level.dbz_balls[i] thread ballHover();
		level.dbz_triggers[i] thread waitTillTrigger( i );
	}
}

waitTillTrigger( number )
{
	real = number + 1;
	
	self waittill( "trigger", player );
	
	place = level.found + 1;
	dballpoint = getEnt( "dballpoint" + place ,"targetname");
	
	height = 300; // 

	level.dbz_balls[ number ] notify( "stop_hover" );
	level.dbz_balls[ number ] unLink();
	level.dbz_balls[ number ].origin = dballpoint.origin;
	
	self delete();
	
	level.balls_left--;
	
	iPrintLnBold( "^1"+player.name+"^7 found the ^1"+real+"-Star^7 Dragonball" );

	level.found++;
	
	level.dbz_balls[ number ] moveTo(dballpoint.origin,1);
}

//ball_3_trigger_3
dragonballsfound()
{
	level.found = 0;
	triggered = false;
	trigger=getent("spawndragon","targetname");
	while(level.found<7)
	{
		wait(5);
		if(level.found == 7 && triggered == false)
		{
			trigger SetHintString( "Call the ^1Dragon Shenlong^7 and make your ^1Wish^7!" );
			trigger waittill("trigger",player);
			iPrintLnBold( "^1"+player.name+"^7 has called ^1Shenlong^7!" );
			thread grantxp();
			thread spawn_s();
			ent = spawn( "script_model", (0,0,0));
			ent PlaySound( "yourwish" );
			triggered = true;
			wait(12);
		}
		else
			trigger SetHintString("Not all ^1Dragonballs^7 have been found yet!");
	}
}

grantxp()
{
	players=getAllPlayers();
	for(i=0;i<=players.size;i++)
	{
        if(isAlive(players[i]))
        {
			players[i] braxi\_rank::giveRankXp(undefined,500);
			wait.1;
		}
		wait.1;
	}
}

hud()
{
	level.xxx = newHudElem();
	level.xxx.x = 0;
	level.xxx.y = -7;
	level.xxx.horzAlign = "center";	
	level.xxx.vertAlign = "bottom";
	level.xxx.alignX = "center";
	level.xxx.alignY = "bottom";
	level.xxx.foreground = 1;
	level.xxx.archived = false;
	level.xxx.alpha = 1;
	level.xxx.fontScale = 1.6;
	level.xxx.hidewheninmenu = true;
	level.xxx.color = (1,1,1);
	level.xxx.glowcolor = (1,0,0);
	level.xxx.glowalpha = 1;
	level.xxx.label = &"Collected Dragonballs: &&1/7";
	
	while(1)
	{
		level.xxx setValue(level.found);
		wait 1;
	}
}

spawn_s()
{
	level._effect["spawnz"] = loadfx("dball/shenron_spawn");
	playFx(level._effect["spawnz"], (3240,-18312,-10840));
}

ballHover()
{
	self endon( "stop_hover" );
	
	while( isDefined( self ) )
	{
		time = 2;
		
		self movez( 5, time);
		self waittill("movedone");
		self movez( -5, time);
		self waittill("movedone");
	}
}

logo()
{
	wingzor=getent("wingzor","targetname");
	wingzor_h=getent("wingzor_horizontal","targetname");
	wingzor_v=getent("wingzor_vertical","targetname");
	
	thread logo_spin(wingzor,"y");
	thread logo_spin(wingzor_h,"x");
	thread logo_spin(wingzor_v,"z");
	thread logo_spin(wingzor,"z");
	thread logo_spin(wingzor_h,"z");
}

logo_spin(brush,script_noteworthy)
{
	rand = 3;
	if (!isdefined(brush.speed))
		brush.speed = rand;
	if (!isdefined(script_noteworthy))
		brush.script_noteworthy = "z";

	while(true)
	{
		if (script_noteworthy == "z")
			brush rotateYaw(360,brush.speed);
		else if (script_noteworthy == "x")
			brush rotateRoll(360,brush.speed);
		else if (script_noteworthy == "y")
			brush rotatePitch(360,brush.speed);
		wait ((brush.speed));
	}
}

shortcutmove1()
{
	brush=getent("shortcut1_mover","targetname");
	brush_org = brush.origin;
	while(1)
	{
		randx = RandomIntRange(-300, 300 );
		randy = RandomIntRange(-300, 300 );
		randz = RandomIntRange(-300, 300 );
		randmovetime = RandomIntRange( 2, 5 );
		spot=(brush_org[0]+randx,brush_org[1]+randy,brush_org[2]+randz);				
		brush moveTo(spot,randmovetime);
		brush waittill("movedone");
		brush moveTo(brush_org,randmovetime);
		brush waittill("movedone");
	}	
}

traps()
{
	thread trap1();
	thread trap2();
	thread trap3();
	thread trap4();
	thread trap5();
	thread trap6();
	thread trap7();
}

trap7()
{
	brush=getent("trap_spin","targetname");

	if (!isdefined(brush.speed))
		brush.speed = 10;
	if (!isdefined(brush.script_noteworthy))
		brush.script_noteworthy = "x";

	level.trigger6 waittill("trigger");

	brush thread movedat();
	while(true)
	{
		rand1 = RandomIntRange( 1, 10 );
		brush.speed=rand1;
		if (brush.script_noteworthy == "z")
		{
			brush rotateYaw(360,brush.speed);
			brush.script_noteworthy = "x";
		}
		else if (brush.script_noteworthy == "x")
		{
			brush rotateRoll(360,brush.speed);
			brush.script_noteworthy = "y";
		}
		else if (brush.script_noteworthy == "y")
		{
			brush rotatePitch(360,brush.speed);
			brush.script_noteworthy = "z";
		}
		wait ((brush.speed));
		wait 3*rand1;
	}
}

movedat()
{
	while(1)
	{
		self movez(-200,3);
		wait 3;
		self movez(200,3);
		wait 3;
		self movez(200,3);
		wait 3;
		self movez(-200,3);
		wait 3;
	}
}

trap6()
{
	brush=getent("obj_move","targetname");
	level.trigger6 = getent("trigger6", "targetname");

	if (!isdefined(brush.speed))
		brush.speed = 10;
	if (!isdefined(brush.script_noteworthy))
		brush.script_noteworthy = "x";

	level.trigger6 waittill("trigger");
	level.trigger6 delete();

	brush thread movedat();
	while(true)
	{
		rand1 = RandomIntRange( 1, 10 );
		brush.speed=rand1;
		if (brush.script_noteworthy == "z")
		{
			brush rotateYaw(360,brush.speed);
			brush.script_noteworthy = "x";
		}
		else if (brush.script_noteworthy == "x")
		{
			brush rotateRoll(360,brush.speed);
			brush.script_noteworthy = "y";
		}
		else if (brush.script_noteworthy == "y")
		{
			brush rotatePitch(360,brush.speed);
			brush.script_noteworthy = "z";
		}
		wait ((brush.speed));
		wait 3*rand1; 
	}
}

trap5()
{
	brush=getent("trap_sway","targetname");
	trigger = getent("trigger5", "targetname");

	if (!isdefined(brush.speed))
		brush.speed = 3;
	if (!isdefined(brush.script_noteworthy))
		brush.script_noteworthy = "x";

	trigger waittill("trigger");
	trigger delete();

	while(true)
	{
		if (brush.script_noteworthy == "z")
			brush rotateYaw(360,brush.speed);
		else if (brush.script_noteworthy == "x")
		{
			brush rotateRoll(360,brush.speed);
			brush.script_noteworthy = "y";
		}
		else if (brush.script_noteworthy == "y")
		{
			brush rotatePitch(360,brush.speed);
			brush.script_noteworthy = "x";
		}
		wait ((brush.speed));
		wait 3; 
	}	
}

trap3()
{
	trigger = getent("trigger3", "targetname");
	rotator1 = getent("rotator1", "targetname");
	rotator2 = getent("rotator2", "targetname");

	trigger waittill("trigger");
	trigger delete();

	thread spin3(rotator1);
	thread spin3(rotator2);
}

spin3(brush)
{
	if (!isdefined(brush.speed))
		brush.speed = 3;
	if (!isdefined(brush.script_noteworthy))
		brush.script_noteworthy = "z";

	while(true)
	{
		if (brush.script_noteworthy == "z")
			brush rotateYaw(360,brush.speed);
		else if (brush.script_noteworthy == "x")
			brush rotateRoll(360,brush.speed);
		else if (brush.script_noteworthy == "y")
			brush rotatePitch(360,brush.speed);
		wait ((brush.speed)-0.1);
		wait 3;
	}
}

trap1()
{
	trigger = getent("trigger1", "targetname");
	brush = getentarray("trap1_block", "targetname");

	trigger waittill("trigger");
	trigger delete();

	while(1)
	{
		rand1 = RandomIntRange( 0, brush.size );
		rand2 = RandomIntRange( 0, brush.size );
		rand3 = RandomIntRange( 0, brush.size );
		rand4 = RandomIntRange( 0, brush.size );
		
		brush[rand1] hide();
		brush[rand2] hide();
		brush[rand3] hide();
		brush[rand4] hide();
		brush[rand1] notsolid();
		brush[rand2] notsolid();
		brush[rand3] notsolid();
		brush[rand4] notsolid();
		
		wait Randomint(5);
		
		brush[rand1] show();
		brush[rand2] show();
		brush[rand3] show();
		brush[rand4] show();
		brush[rand1] solid();
		brush[rand2] solid();
		brush[rand3] solid();
		brush[rand4] solid();			
	}
}

trap2()
{
	spinner=getent("trap2_spinner","targetname");
	trigger = getent("trigger2", "targetname");

	trigger waittill("trigger");
	trigger delete();

	thread spin(spinner);

	while(1)
	{
		spinner movez(-200,2);
		wait 2;
		spinner movez(200,1);
		wait 1;
		spinner movez(200,2);
		wait 2;
		spinner movez(-200,1);
		wait 1;
	}
}

trap4()
{
	brush = getentarray("trap4_block", "targetname");
	trigger = getent("trigger4", "targetname");

	trigger waittill("trigger");
	trigger delete();

	while(1)
	{
		rand1 = RandomIntRange( 0, brush.size );
		rand2 = RandomIntRange( 0, brush.size );
		rand3 = RandomIntRange( 0, brush.size );
		rand4 = RandomIntRange( 0, brush.size );
		
		brush[rand1] hide();
		brush[rand2] hide();
		brush[rand3] hide();
		brush[rand4] hide();
		brush[rand1] notsolid();
		brush[rand2] notsolid();
		brush[rand3] notsolid();
		brush[rand4] notsolid();
		
		wait Randomint(5);
		
		brush[rand1] show();
		brush[rand2] show();
		brush[rand3] show();
		brush[rand4] show();
		brush[rand1] solid();
		brush[rand2] solid();
		brush[rand3] solid();
		brush[rand4] solid();		
	}
}


/////////////////////
enemey_low()
{
	trigger=getent("activate_ghost","targetname");
	trigger waittill("trigger");

	if(isdefined(level.activ))
	{
		if(!level.trapsdisabled)
		{
			iprintlnbold("^1Buu's^7 Ghost has escaped!");
			wait 5;
			level.brush = getent("enemy_low","targetname");
			linker = getent("ghostlinker1","targetname");
			level.brush linkto(linker);
			linker thread attackPlayer();
			trigger delete();
		}
		else
		{
			iprintlnbold("^1Buu's^7 Ghost is banned by God.");
			trigger delete();
		}
	}
}

attackPlayer()
{
	players=getAllPlayers();
	maxplayers=0;
	for(i=0;i<players.size;i++)
		maxplayers++;

	rand = randomintrange(0,maxplayers);
	self.angles = (0,360,0);

	while(1)
	{
		if(isdefined(players[rand]) && isalive(players[rand]) && players[rand] != level.activ)
		{
			newLocation = players[rand] getorigin();
			currentLocation = self getorigin();

			dist = distance(currentLocation,newLocation);
			if(dist<150)
				radiusdamage(self.origin,150,35,15);

			self moveto(newlocation,(dist/100));
			self.angles =(vectortoangles((players[rand].origin)-(self.origin)));
		}
		else
			rand = randomintrange( 0, maxplayers );
		wait .05;
	}
}

brushes()
{
	randbrush = getentarray("randbrush", "targetname");
	for(i = 0; i < randbrush.size; i++)
        randbrush[i] delete();
}

spin(brush)
{
	rand = RandomIntRange( 8, 12 );
	if (!isdefined(brush.speed))
		brush.speed = rand;
	if (!isdefined(brush.script_noteworthy))
		brush.script_noteworthy = "z";

	while(true)
	{
		if (brush.script_noteworthy == "z")
			brush rotateYaw(360,brush.speed);
		else if (brush.script_noteworthy == "x")
			brush rotateRoll(360,brush.speed);
		else if (brush.script_noteworthy == "y")
			brush rotatePitch(360,brush.speed);
		wait ((brush.speed)-0.1);
		wait 0.05;
	}
}

spinx(brush)
{
	rand = RandomIntRange( 8, 12 );
	if (!isdefined(brush.speed))
		brush.speed = rand;
	if (!isdefined(brush.script_noteworthy))
	 	brush.script_noteworthy = "z";

	while(true)
	{
		if (brush.script_noteworthy == "z")
		{
			brush rotateYaw(360,brush.speed);
			brush.script_noteworthy = "x";
		}
		else if (brush.script_noteworthy == "x")
		{
			brush rotateRoll(360,brush.speed);
			brush.script_noteworthy = "y";
		}
		else if (brush.script_noteworthy == "y")
		{
			brush rotatePitch(360,brush.speed);
			brush.script_noteworthy = "z";
		}
		wait ((brush.speed)-0.1);
	}
}

spots(brush)
{
	while(1)
	{
		randx = RandomIntRange(-7000, 23500 );
		randy = RandomIntRange(-15000, 5000 );
		randz = RandomIntRange(-16000, 5000 );
		randmovetime = RandomIntRange( 18, 25 );
		spot=(randx,randy,randz);				
		brush moveTo(spot,randmovetime);
		brush waittill("movedone");
		wait 1;
	}
}

/////////////////////////
////////////FIGHT/////////////

supersaiyan()
{
	trigger=getent("activate_power","targetname");
	while(1)
	{
		trigger waittill("trigger", player);
		player thread superpower();
		wait 1;
	}
}

superpower()
{
	self.maxhealth = 120;
	self.health = self.maxhealth;
	self thread ki_attacks();
	self thread instanttransmission();
}

instanttransmission()
{
	self endon("disconnect");
	self endon("death");
	level endon("game over");
	vertraging = 0;
	
	while(1)
	{
		if( self adsButtonPressed() && vertraging < 1 )
		{
			self thread transmit();
			self PlaySoundToPlayer( "tele", self );
			vertraging = 4;
		}
		if( vertraging > 0 )
			vertraging --;
		while( self adsButtonPressed())
			wait 0.1;
		wait 0.1;
	}
}

transmit_x()
{
	Obj = Spawn("script_model", self GetEye()+AnglesToForward( self GetPlayerAngles() )*75 );
	Obj setModel("tag_origin");
	Obj.angles = self GetPlayerAngles();
	
	target = obj.origin+AnglesToForward( obj.angles )*2000;
	obj MoveTo( target, 0.05);
	wait 0.2;
	self SetOrigin( obj.origin );
	self setplayerangles(obj.angles );

	obj delete();
}

transmit()
{
	self.origin = self getorigin();

	self.bh += 60000;	

	bounceFrom = (self.origin - vector_scal( anglesToForward( self.angles ), 10 )) - (0,0,42);
	bounceFrom = vectorNormalize( self.origin - bounceFrom );
	self bounce( bounceFrom, self.bh );
	self bounce( bounceFrom, self.bh );
	self bounce( bounceFrom, self.bh );
	self bounce( bounceFrom, self.bh );
	self bounce( bounceFrom, self.bh );
	self bounce( bounceFrom, self.bh );
	self bounce( bounceFrom, self.bh );
	wait 0.05;			
}

vector_scal(vec, scale)
{
    vec = (vec[0] * scale, vec[1] * scale, vec[2] * scale);
   		return vec;
} 

ki_attacks() // Rycoons Ruin2 Final Fight
{
	self endon("disconnect");
	self endon("death");
	level endon("game over");
	
	delay = 0;
	self.cur_spell = 1;
	while(1)
	{
		if( self AttackButtonPressed() && delay < 1 )
		{
			if( self.cur_spell == 1 )
				self thread CastFireBall();
			else if( self.cur_spell == 2 )
				self thread CastFireBall_small();
			delay = 5;
		}
		if ( self FragButtonPressed() && delay < 1 )
		{
			self thread CastFireBall_big();
			delay = 60;
		}
		if( self meleeButtonPressed() )
		{
			self.cur_spell++;
			if( self.cur_spell > 2 )
				self.cur_spell = 1;
			self iprintln("Current KI-Attack: ^1"+yourPower(self.cur_spell));
		}
		if( delay > 0 )
			delay --;
		while( self AttackButtonPressed() || self FragButtonPressed() )
			wait 0.1;
		wait 0.1;
	}
}

yourPower(num)
{
	if( num == 1 )
		return "Kame Hame Ha";
	else if( num == 2 )
		return "Death Rain";
}

CastFireBall_small()
{
	self endon("disconnect");
	self endon("death");
	level endon("game over");
	
	Obj = Spawn("script_model", self GetEye()+AnglesToForward( self GetPlayerAngles() )*75 );
	Obj setModel("tag_origin");
	Obj.angles = self GetPlayerAngles();
	obj linkTo(self);
	wait 0.05;
	PlayFXOnTag( level.abovehuman["fireball_charge_small"], Obj, "tag_origin" );
	obj Unlink();
	while(1)
	{
		target = obj.origin+AnglesToForward( obj.angles )*550;
		obj MoveTo( target, 0.1);
		PlayFX( level.abovehuman["fireball_tracer_small"], obj.origin );
		if( !BulletTracePassed( obj.origin, target, true, self ) )
			break;
		wait 0.1;
	}
	Obj PlaySound("explo_metal_rand");
	PlayFX( level.abovehuman["fireball_explosion_small"], obj.origin );
	EarthQuake( 1, 1, obj.origin, 600 );
	RadiusDamage( obj.origin, 400, 100, 30, self );
	obj delete();
}


CastFireBall()
{
	self endon("disconnect");
	self endon("death");
	level endon("game over");
	
	Obj = Spawn("script_model", self GetEye()+AnglesToForward( self GetPlayerAngles() )*75 );
	Obj setModel("tag_origin");
	Obj.angles = self GetPlayerAngles();
	obj linkTo(self);
	wait 0.05;
	PlayFXOnTag( level.abovehuman["fireball_charge"], Obj, "tag_origin" );
	
	obj PlaySound("kamehameha");
	
	wait 0.5;
	PlayFXOnTag( level.abovehuman["fireball_charge"], Obj, "tag_origin" );
	wait 0.5;
	PlayFXOnTag( level.abovehuman["fireball_charge"], Obj, "tag_origin" );
	wait 0.5;
	PlayFXOnTag( level.abovehuman["fireball_charge"], Obj, "tag_origin" );
	wait 0.5;
	PlayFXOnTag( level.abovehuman["fireball_charge"], Obj, "tag_origin" );
	wait 0.5;
	PlayFXOnTag( level.abovehuman["fireball_charge"], Obj, "tag_origin" );
	wait 0.5;
	PlayFXOnTag( level.abovehuman["fireball_charge"], Obj, "tag_origin" );
	wait 0.5;
	PlayFXOnTag( level.abovehuman["fireball_charge"], Obj, "tag_origin" );		
	wait(0.5);
	obj Unlink();
	while(1)
	{
		Obj.angles = self GetPlayerAngles();
		target = obj.origin+AnglesToForward( obj.angles )*550;
		obj MoveTo( target, 0.05);
		PlayFX( level.abovehuman["fireball_tracer"], obj.origin );
		if( !BulletTracePassed( obj.origin, target, true, self ) )
			break;
		wait 0.1;
	}
	Obj PlaySound("explo_metal_rand");
	PlayFX( level.abovehuman["fireball_explosion"], obj.origin );
	EarthQuake( 2, 2, obj.origin, 1500 );
	RadiusDamage( obj.origin, 800, 300, 100, self );
	obj delete();
}

CastFireBall_big()
{
	self endon("disconnect");
	self endon("death");
	level endon("game over");
	
	self freezecontrols(true);
	Obj = Spawn("script_model", self GetEye()+AnglesToForward( self GetPlayerAngles() )*500 );
	Obj setModel("tag_origin");
	Obj.angles = self GetPlayerAngles();
	obj linkTo(self);
	wait 0.05;
	PlayFXOnTag( level.abovehuman["fireball_charge_big"], Obj, "tag_origin" );
	wait 1;
	PlayFXOnTag( level.abovehuman["fireball_charge_big"], Obj, "tag_origin" );
	wait 0.5;                                     
	PlayFXOnTag( level.abovehuman["fireball_charge_big"], Obj, "tag_origin" );
	wait 0.5;                                     
	PlayFXOnTag( level.abovehuman["fireball_charge_big"], Obj, "tag_origin" );
	wait 1;                                     
	PlayFXOnTag( level.abovehuman["fireball_charge_big"], Obj, "tag_origin" );
	wait 0.5;                                     
	PlayFXOnTag( level.abovehuman["fireball_charge_big"], Obj, "tag_origin" );
	wait 0.5;                                     
	PlayFXOnTag( level.abovehuman["fireball_charge_big"], Obj, "tag_origin" );
	wait 1;                                     
	PlayFXOnTag( level.abovehuman["fireball_charge_big"], Obj, "tag_origin" );		
	wait(0.5);
	obj Unlink();
	self freezecontrols(false);
	while(1)
	{
		Obj.angles = self GetPlayerAngles();
		target = obj.origin+AnglesToForward( obj.angles )*550;
		obj MoveTo( target, 0.05);
		PlayFX( level.abovehuman["fireball_tracer"], obj.origin );
		if( !BulletTracePassed( obj.origin, target, true, self ) )
			break;
		wait 0.1;
	}
	Obj PlaySound("explo_metal_rand");
	PlayFX( level.abovehuman["nuke_explosion"], obj.origin );
	EarthQuake( 2, 5, obj.origin, 4500 );
	RadiusDamage( obj.origin, 800, 300, 100, self );
	obj delete();
}

////rooms
kniferoom()
{
    level.kniferoom=getent("kniferoomtrigger","targetname");
	acti=getent("kniferoomtrigger_activatorteleport","targetname");
	jump=getent("kniferoomtrigger_jumperteleport","targetname");

    while(1)
    {
        level.kniferoom waittill("trigger",player);
        if(!isdefined(level.kniferoom))
            return;

			// ====== Part for Queue Plugin ========
			if(!plugins\_queue::checkQueueRoom(player))
				continue;
			// =====================================

        if(isdefined(level.activ))
        {
            player freezecontrols(1);
            level.activ freezecontrols(1);
            player setorigin(jump.origin);
            level.activ setorigin(acti.origin);
            player setplayerangles(jump.angles);
            level.activ setplayerangles(acti.angles);
            player PlaySoundToPlayer( "tele", player );
            level.activ PlaySoundToPlayer( "tele", level.activ );
           	player thread findburner();
			player thread superpower();
			iPrintLnBold(player.name+ " has entered the ^1End Fight");
			level.activ thread findburner();
			level.activ thread superpower();
			player thread countdown();
			level.activ thread countdown();
        }
        else
        {
          	player freezecontrols(1);
            player setorigin(jump.origin);
            player setplayerangles(jump.angles);
            player PlaySoundToPlayer( "tele", player );
           	player thread findburner();
			player thread superpower();
			player thread countdown();
        }
        while(isalive(player)&&isdefined(player))
            wait 1;
        iprintln("^1"+player.name+"^7 has been killed");
    }
}

findburner()
{
    self thread playfxonbody();
    self thread playfxonbody2();
	self thread playersetup();		  
}

countdown()
{
	self iprintlnbold("Fight will start in:");
	wait .5;
	self iprintlnbold("^13");
	wait 1;
	self iprintlnbold("^12");
	wait 1;
	self iprintlnbold("^11");
	wait 1;
	self freezecontrols(0);

	while(1)
	{
		self iPrintLn("Press ^1Fire ^7to use your ^1KI-Attacks^7!");
		wait 5;
		self iPrintLn("Press ^1Knife ^7to change your ^1KI-Attacks^7!");
		wait 5;
		self iPrintLn("Press ^1Right Mouse ^7to transmit");
		wait 5;
	}
}

playersetup()
{
	self TakeAllWeapons();
	self giveWeapon("knife_mp");
	self switchToWeapon("knife_mp");
	self iPrintLnBold("You have become an ^3Super ^1Saiyan");
}

playfxonbody2()
{      
	while(self isReallyAlive())                  
	{	                                    
		PlayFXOnTag( level.glow, self, "j_head" );	                                      
		PlayFXOnTag( level.glow, self, "j_neck" );	                                      
		PlayFXOnTag( level.glow, self, "j_shoulder_le" );					     
		PlayFXOnTag( level.glow, self, "j_shoulder_ri" );	                                      
		PlayFXOnTag( level.glow, self, "j_spinelower" );	                                      
		PlayFXOnTag( level.glow, self, "j_knee_ri" );					      
		PlayFXOnTag( level.glow, self, "j_knee_le" );
			
		wait .1;		      
    }
}

playfxonbody()
{      
	while(self isReallyAlive())                  
	{
	    PlayFXOnTag( level.burn_fx, self, "j_head" );					      
	    PlayFXOnTag( level.burn_fx, self, "j_neck" );					      
	    PlayFXOnTag( level.burn_fx, self, "j_shoulder_le" );					      
		PlayFXOnTag( level.burn_fx, self, "j_shoulder_ri" );					      
	    PlayFXOnTag( level.burn_fx, self, "j_spinelower" );				      
	    PlayFXOnTag( level.burn_fx, self, "j_knee_ri" );					     
		PlayFXOnTag( level.burn_fx, self, "j_knee_le" );
					      					      
		wait .1;
    }
}
