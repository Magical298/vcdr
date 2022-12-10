main()
{
	level._effect["fire"] = loadfx( "survive/trap_fire" );
	level._effect["virus"] = loadfx( "survive/trap_virus" );
	level._effect["trap9visual"] = loadfx( "survive/killing_mover" );
	level._effect["c4_light"] = loadfx("misc/light_c4_blink");
	level._effect["c4_explosion"] = loadfx ("explosions/grenadeExp_metal");
	level._effect["snip_exp"] = loadfx ("survive/exp_shot");

	precachemodel("weapon_c4_mp");

	maps\mp\_load::main();
	
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

	setDvar("bg_falldamagemaxheight", "99999" );
	setDvar("bg_falldamageminheight", "99998" );

	level.trap_time = 15;
	level.play_platform = getentarray("play_platform","targetname");
	level.voice_annoncer = getent("voice","targetname");

	thread trap1();
	thread trap2();
	thread trap3();
	thread trap4();
	thread trap6();
	thread trap7();
	thread trap8();
	level waittill("round_started");
	thread trap5();
	thread trap9();
	thread lastplayeralive();
	thread crazysniper();
	
	thread canactivate_funk();
	thread acti_huds();
}

lastplayeralive()
{
	level endon("acti_time_done");
	players = getentarray("player","classname");
	for(;;)
	{
		for(i=0;i<players.size;i++)
		{
			if(GetTeamPlayersAlive("allies") == 1 && players[i].sessionstate == "playing")
			{
				level waittill("trap_moves_done");
				open_rooms();
				level.actihud[0] destroy();
				level.actihud[1] destroy();	
				level notify("acti_time_done");
			}
		}
		wait 1;
	}
}

open_rooms()
{
	door = getent("open_rooms","targetname");
	door delete();
}

createhud( who, x, y, alpha, alignX, alignY, fontScale )//braxi
{
	if( isPlayer( who ) )
		hud = newClientHudElem( who );
	else
		hud = newHudElem();

	hud.x = x;
	hud.y = y;
	hud.alpha = alpha;
	hud.alignX = alignX;
	hud.alignY = alignY;
	hud.fontScale = fontScale;
	return hud;
}

acti_huds()
{
	level endon("acti_time_done");

	level.actihud = [];
	level.actihud[0] = createhud(level,0,0,1,"left","center",2);
	level.actihud[0] setTimer(180);

	level.actihud[1] = createhud(level,0,20,1,"left","center",2);

	wait 180;
	thread open_rooms();
	level.can_activate = false;
	level.actihud[0] destroy();
	level.actihud[1] destroy();
	level notify("acti_time_done");
}

canactivate_funk()
{
	level endon("acti_time_done");
	level.can_activate = false;
	for(;;)
	{
		for(i=level.trap_time;i>0;i--)
		{
			level.actihud[1] settext("Trap Cooldown: "+i);
			wait 1;
		}

		level.actihud[1] settext("Traps Can Be Activated");
		level.can_activate = true;
		level waittill("trap_moves_done");
	}
}

trap1()// spinner trap
{
	level endon("acti_time_done");

	trig = getent("trap1trig","targetname");
	trig sethintstring("^1>>^7 Activate The Spinner^1 <<");
	obj = getent("trap1","targetname");

	dmgtrig = getentarray("dmgtrig_trap1","targetname");
	for(i=0;i<dmgtrig.size;i++)
	{
		dmgtrig[i] enablelinkto();
		dmgtrig[i] maps\mp\_utility::triggerOff();
	}

	obj hide();
	obj notsolid();
	for(;;)
	{
		trig waittill("trigger",player);

		if(level.can_activate == true)
		{
			level.can_activate = false;
			level.voice_annoncer playsound("spinner");
			wait 1;

			for(i=0;i<level.play_platform.size;i++)
			{
				if(i!=1)
				{
					level.play_platform[i] hide();
					level.play_platform[i] notsolid();
				}

				else
					continue;

				wait 0.5;
			}

			wait 2;

			for(i=0;i<dmgtrig.size;i++)
			{
				dmgtrig[i] maps\mp\_utility::triggerOn();
				dmgtrig[i] linkto(obj);
			}

			obj show();
			obj solid();

			wait 1;

			repeat = randomintrange(3,6);
			time = randomfloatrange(0.8,1.5);
			for(i=0;i<repeat;i++)
			{
				obj rotateyaw(180,time);
				wait time+0.1;
			}

			for(i=0;i<dmgtrig.size;i++)
			{
				dmgtrig[i] unlink();
				dmgtrig[i] maps\mp\_utility::triggerOff();
			}

			wait 2;

			obj hide();
			obj notsolid();

			for(i=0;i<level.play_platform.size;i++)
			{
				if(i!=1)
				{
					level.play_platform[i] show();
					level.play_platform[i] solid();
				}
				else
					continue;

				wait 0.5;
			}

			level notify("trap_moves_done");
		}
		wait 0.1;
	}
}

trap2()//platform trap
{
	level endon("acti_time_done");

	trig = getent("trap2trig","targetname");
	trig sethintstring("^1>> ^7Remove The Platforms ^1<<");
	for(;;)
	{
		trig waittill("trigger",player);
		if(level.can_activate == true)
		{
			level.can_activate = false;
			level.voice_annoncer playsound("platforms");
			wait 1;

			repeat = randomintrange(5,7);
			time = randomfloatrange(0.7,2.0);
			for(i=0;i<repeat;i++)
			{
				x = randomint(level.play_platform.size);
				level.play_platform[x] notsolid();
				level.play_platform[x] hide();
				wait time;
				level.play_platform[x] solid();
				level.play_platform[x] show();
				wait time/2;
			}

			level notify("trap_moves_done");
		}
		wait 0.1;
	}
}


trap3()//fire trap
{
	level endon("acti_time_done");

	trig = getent("trap3trig","targetname");
	trig sethintstring("^1>> ^7Light Them Up ^1<<");
	flameorg = getentarray("fireorg","targetname");
	killtrigs = getentarray("trap3killtrigs","targetname");

	killtrigs_orgpos = [];

	for(i=0;i<killtrigs.size;i++)
	{
		killtrigs[i] maps\mp\_utility::triggerOff();
		killtrigs_orgpos[i] = killtrigs[i].origin;
	}

	for(;;)
	{
		trig waittill("trigger",player);

		if(level.can_activate == true)
		{
			level.can_activate = false;
			level.voice_annoncer playsound("fire");
			wait 2;

			for(i=0;i<level.play_platform.size;i++)
			{
				if(i!=2)
				{
					level.play_platform[i] hide();
					level.play_platform[i] notsolid();
				}

				else
					continue;

				wait 0.5;
			}

			for(i=0;i<6;i++)
			{
				x = randomint(12);
				killtrigs[x] maps\mp\_utility::triggerOn();
				PlayFX(level._effect["fire"],flameorg[i].origin);
				wait 0.01;
			}

			wait 3;

			for(i=0;i<killtrigs.size;i++)
			{
				if(killtrigs[i].origin != killtrigs_orgpos[i])
					killtrigs[i].origin = killtrigs_orgpos[i];
			}

			wait 3;
		}

		for(i=0;i<level.play_platform.size;i++)
		{
			if(i!=2)
			{
				level.play_platform[i] show();
				level.play_platform[i] solid();
			}
			else
				continue;

			wait 0.5;
		}

		level notify("trap_moves_done");
	}
		wait 0.1;
}

trap4()
{
	level endon("acti_time_done");

	trig = getent("trap4trig","targetname");
	plats = getentarray("trap4plats","targetname");
	killtrigs = getentarray("trap4killtrigs","targetname");
	trig sethintstring("^1>> ^7Drop The Platforms^1 <<");

	plats_orgpos = [];
	for(i=0;i<plats.size;i++)
		plats_orgpos[i] = plats[i].origin;

	for(i=0;i<killtrigs.size;i++)
	{
		killtrigs[i] enablelinkto();
		killtrigs[i] linkto(plats[i]);
	}

	for(;;)
	{
		trig waittill("trigger",player);

		if(level.can_activate == true)
		{
			level.can_activate = false;
			level.voice_annoncer playsound("dropplat");
			wait 2;

			level.play_platform[2] notsolid();
			level.play_platform[2] hide();
			level.play_platform[3] notsolid();
			level.play_platform[3] hide();
			level.play_platform[1] movez(32,1);

			wait 2;

			for(j=0;j<2;j++)
			{
				x = randomint(4);
				switch(x)
				{
					case 0:
					plats[0] movez(-320,0.5);
					plats[1] movez(-320,0.5);
					break;

					case 1:
					plats[2] movez(-320,0.5);
					plats[3] movez(-320,0.5);
					break;

					case 2:
					plats[0] movez(-320,0.5);
					plats[2] movez(-320,0.5);
					break;

					case 3:
					plats[1] movez(-320,0.5);
					plats[3] movez(-320,0.5);
					break;
				}

				wait 2;

				for(i=0;i<plats.size;i++)
				{
					if (plats[i].origin != plats_orgpos[i])
						plats[i] moveto(plats_orgpos[i],0.5);
				}
				wait 2;
			}

			wait 2;

			level.play_platform[2] solid();
			level.play_platform[2] show();
			level.play_platform[3] solid();
			level.play_platform[3] show();
			level.play_platform[1] movez(-32,1);

			level notify("trap_moves_done");
		}
		wait 0.5;
	}
}

trap5()// one time use trap
{
	level endon("acti_time_done");

	playerfound = false;
	players = getentarray("player","classname");
	trig = getent("trap5trig","targetname");
	trig sethintstring("^1>> ^7Releas The Virus (one time use)^1 <<");


	while(isdefined(trig))
	{
		trig waittill("trigger",player);
		if(level.can_activate == true)
		{
			level.voice_annoncer playsound("virus");
			trig delete();
			level.can_activate = false;
			while(playerfound == false)
			{
				x = randomint(players.size);
				for(i=0;i<players.size;i++)
				{
					if(i == x && players[i].pers["team"] == "allies" && players[i].sessionstate == "playing")
					{
						players[i] takeallweapons();
						players[i].pers["team"] = "axis";
						players[i].team = "axis";
						players[i].sessionteam = "axis";
						players[i] thread trap5funk();
						playerfound = true;
						iprintlnbold(players[i].name+" Is Infected");
					}
				}
				wait 0.05;
			}
		}
	}
}

trap5funk()
{
	PlayFXOnTag( level._effect["virus"], self, "tag_origin" );
	while(self.sessionstate == "playing")
	{
		self RadiusDamage( self.origin+(0,0,20), 200, 60, 5, self );
		wait randomfloatrange(0.5,1.5);
	}

	level notify("trap_moves_done");
}

trap6()
{
	level endon("acti_time_done");

	trig = getent("trap6trig","targetname");
	trig sethintstring("^1>>^7 Push Platform ^1<<");
	obj = getent("trap6pusher","targetname");

	obj notsolid();
	obj hide();

	for(;;)
	{
		trig waittill("trigger",player);
		if(level.can_activate == true)
		{
			level.can_activate = false;
			level.voice_annoncer playsound("pusher");
			for(i=0;i<level.play_platform.size;i++)
			{
				if(i != 0)
					level.play_platform[i] movez(32*i,1);
			}

			wait 2;

			time = randomfloatrange(0.5,2.0);
			obj show();
			obj solid();

			obj movex(1120,time);
			wait time*2;
			obj movex(-1120,time);
			wait time*2;

			obj notsolid();
			obj hide();

			for(i=0;i<level.play_platform.size;i++)
			{
				if(i != 0)
					level.play_platform[i] movez(-32*i,1);
			}

			wait 2;

			level notify("trap_moves_done");
		}
		wait 0.5;
	}
}

trap7() //c4 spawn and fall down
{
	level endon("acti_time_done");

	trig = getent("trap7trig","targetname");
	trig sethintstring("^1>> ^7Drop The C4s ^1<<");
	locations = getentarray("c4_loc","targetname");
	c4s = [];
	for(;;)
	{
		trig waittill("trigger",player);
		if(level.can_activate == true)
		{
			level.can_activate = false;
			level.voice_annoncer playsound("c4s");
			wait 2;

			for(i=0;i<level.play_platform.size;i++)
			{
				if(i != 0)
					level.play_platform[i] movez(32*i,1);
			}

			wait 2;

			for(i=0;i<locations.size;i++)
			{
				c4s[i] = spawn("script_model",locations[i].origin);
				c4s[i] setmodel("weapon_c4_mp");
				c4s[i] movez(-216,1,0.2);
				wait 0.1;
				playFXOnTag( level._effect["c4_light"], c4s[i], "tag_fx" );
			}

			wait 2;

			for(i=0;i<c4s.size;i++)
			{
				PlayFX(level._effect["c4_explosion"],c4s[i].origin);
				c4s[i] RadiusDamage( c4s[i].origin+(0,0,20), 150, 150, 70, c4s[i] );
				c4s[i] delete();
				wait 0.25;
			}

			wait 2;

			for(i=0;i<level.play_platform.size;i++)
			{
				if(i != 0)
					level.play_platform[i] movez(-32*i,1);
			}

			wait 2;

			level notify("trap_moves_done");	
		}

		wait 0.5;
	}
}

trap8()
{
	level endon("acti_time_done");
	
	trig = getent("trap8trig","targetname");
	trig sethintstring("^1>> ^7Move the Spikes ^1<<");
	obj = getentarray("trap8spikes","targetname");
	killtrigs = getentarray("trap8killtrigs","targetname");
	prev = -1;
	orgpos = [];

	for(i=0;i<killtrigs.size;i++)
	{
		killtrigs[i] enablelinkto();
		killtrigs[i] linkto(obj[i]);
		orgpos[i] = obj[i].origin;
	}

	for(;;)
	{
		trig waittill("trigger",player);
		if(level.can_activate == true)
		{
			level.can_activate = false;
			level.voice_annoncer playsound("spikes");
			wait 2;

			for(j=0;j<8;j++)
			{
				x = randomint(16);
				if(prev == x)
					x++;
				prev = x;

				if(x <= 7)
					obj[x] movey(1136,2);
				else if(x > 7)
					obj[x] movey(-1136,2);
			}

			wait 4;

			for(i=0;i<obj.size;i++)
				obj[i] moveto(orgpos[i],1);

			wait 2;

			level notify("trap_moves_done");
		}
		wait 0.5;
	}
}

trap9()
{
	level endon("acti_time_done");

	trig = getent("trap9trig","targetname");
	trig sethintstring("^1>> ^7Freeze Them ^1<< (one time use)");
	killtrig = getent("killtrig9","targetname");
	killtrig enablelinkto();
	killtrig maps\mp\_utility::triggerOff();
	spots = getentarray("trap9spots","targetname");
	orgattack = getent("orgattack","targetname");
	temporg = spawn("script_model",orgattack.origin);
	players = getentarray("player","classname");

	while(isdefined(trig))
	{
		trig waittill("trigger",player);

		if(level.can_activate == true)
		{
			trig delete();
			level.voice_annoncer playsound("freez");
			temporg setmodel("tag_origin");

			wait 2;
			
			killtrig maps\mp\_utility::triggerOn();
			level.can_activate = false;

			for(i=0;i<players.size;i++)
			{
				if(players[i].pers["team"] == "allies")
					players[i] freezeControls(true);
 			}

			thread killfunk(killtrig);
			PlayFXOnTag( level._effect["trap9visual"], temporg, "tag_origin" );
			
			killtrig linkto(temporg);
			for(i=0;i<5;i++)
			{
				x = randomint(16);
				temporg moveto(spots[x].origin,1);
				wait 1;
			}

			wait 2;

			killtrig delete();
			temporg delete();
			orgattack delete();

			wait 1;

			for(i=0;i<players.size;i++)
			{
				if(players[i].pers["team"] == "allies")
					players[i] freezeControls(false);
 			}

 			wait 1;

 			level notify("trap_moves_done");
		}
		wait 0.5;
	}
}

killfunk(trig)
{
	level endon("trap_moves_done");
	for(;;)
	{
		trig waittill("trigger",player);
		player suicide();
	}
}

crazysniper()
{
	level.crazysniper = getent("crazysniper","targetname");
	jumperspots = getentarray("jumperspots_sniper","targetname");
	actispot = getent("actispot","targetname");
	players = getentarray("player","classname");

	level.crazysniper waittill("trigger",player);
	for(i=0;i<players.size;i++)
	{
		if(players[i].pers["team"] == "allies" && players[i].sessionstate == "playing")
		{
			x = randomint(jumperspots.size);
			players[i] setorigin(jumperspots[x].origin);
			players[i] thread megajump();
			players[i] thread nukebullets();
			players[i] giveweap("remington700_mp");
			players[i] SetMoveSpeedScale(2);
		}
		else
		{
			level.activ setorigin(actispot.origin);
			level.activ thread megajump();
			level.activ thread nukebullets();
			level.activ giveweap("remington700_mp");
			level.activ SetMoveSpeedScale(2);
		}
	}
}

megajump() //wingzor script
{
	self endon("disconnect");
	self endon("death");
	level endon("game over");
	
	oldpos = self.origin;
	jumped = false;
	
	while(1)
	{
		if((self.origin[2] - oldpos[2] ) > 10  && !self IsOnGround() && !jumped)
		{
			if(jumped)
				continue;
			for(i=0;i<7;i++)
			{
				self.health += 100;
				self finishPlayerDamage(self, level.jumpattacker, 100, 0, "MOD_FALLING", "shock_mp", self.origin, AnglesToForward((-90,0,0)), "none", 0);
			}
			jumped = true;
		}
		else if(oldpos[2] > self.origin[2] && self IsOnGround() && jumped)
			jumped = false;
		oldpos = self.origin;
		wait 0.1;
	}
}

nukebullets()
{
    self endon("death");
    for(;;)
    {
        self waittill ( "weapon_fired" );
		self playsound("rocket_explode_default");
		vec = anglestoforward(self getPlayerAngles());
		end = (vec[0] * 200000, vec[1] * 200000, vec[2] * 200000);
		SPLOSIONlocation = BulletTrace( self gettagorigin("tag_eye"), self gettagorigin("tag_eye")+end, 0, self)[ "position" ];
		playfx(level._effect["snip_exp"], SPLOSIONlocation); 
		RadiusDamage( SPLOSIONlocation, 200, 500, 60, self ); 
		earthquake (0.3, 1, SPLOSIONlocation, 400); 
		wait 1;
	
       }	
}

giveweap(name)
{
	self takeallweapons();
	self giveweapon(name);
	self switchtoweapon(name);
	self givemaxammo(name);
}