/*
I am also leaving this custome challanges to every server owner, who ever wants it can remake them and add some of his ideas, same gouse for the random suprise :P! Hope u enjoy :D
*/
main()
{
	PreCacheShellShock("flashbang");
	precachemodel("weapon_ak47");
	precachemodel("weapon_beretta");
	precachemodel("weapon_remington700");
	precachemodel("weapon_g3");
	precachemodel("weapon_rpg7");

	precacheitem("ak47_mp");
	precacheitem("beretta_mp");
	precacheitem("rpg_mp");
	precacheitem("g3_mp");

	thread secret_steps();
	thread watchsteps();
	thread secretbounce();
	thread secretfailtele();
	thread secretendtele();
}

secret_steps()
{
		trig1 = getent("step1","targetname");
		trig2 = getent("step2","targetname");
		trig3 = getent("step3","targetname");
		secretorigin = getent("secretspot","targetname");

		for(;;)
		{
			trig1 waittill("trigger", user );
			{
				user.step1 = 1;
				user.counter++;
				user iprintln("Step ^1"+user.counter+"/3^7 Done");
			}
			trig2 waittill("trigger", user );
			{
				user.step2 = 1;
				user.counter++;
				user iprintln("Step ^1"+user.counter+"/3^7 Done");
			}
			trig3 waittill("trigger", user );
			{
				user.step3 = 1;
				user.counter++;
				user iprintln("Step ^1"+user.counter+"/3 ^7Done");
			}
			if (user.step1 == 1 && user.step2 == 1 && user.step3 == 1 && user.pers["rank"]>=15)
			{
				user setOrigin( secretorigin.origin );
				user setplayerangles( secretorigin.angles );
				user iprintlnBold("^5* * ^2Welcome To The ^3Secret^1!^5 * *");
				user.counter = 0;
			}
			else if (user.pers["rank"]<15)
			{
				user iprintlnBold("You need to be at least level ^115^7 to enter the secret");
			}
		}
}

watchsteps()
{
	while(1)
	{
		level waittill("player_spawn", user );
		
		user.step1 = 0;
		user.step2 = 0;
		user.step3 = 0;
		user.counter = 0;
	}
}

secretbounce()
{	  
	  level.knockback = getDvarInt("g_knockback");

	bounce   = getEntArray("bounce", "targetname");
	for(i = 0;i < bounce.size;i++)
		bounce[i] thread bounce();

}

bounce()
{
	for(;;)
	{
		self waittill("trigger", p);

		if(!isDefined(p.bouncing))
			p thread player_bounce(self);
	}
}

player_bounce(trigger)
{
	self.bouncing = true;

	vel = self getVelocity();

	temp0 = (((vel[0] < 350 && vel[0] > 0) || (vel[0] > -350 && vel[0] < 0)));
	temp1 = (((vel[1] < 350 && vel[1] > 0) || (vel[1] > -350 && vel[1] < 0)));

	if((!temp0 && !temp1) || vel[2] > -350)
	{
		wait 1;

		self.bouncing = undefined;
		return;
	}

	health    = self.health;
	maxHealth = self.maxHealth;
	self.health    = 1000000;
	self.maxhealth = 1000000;

	setDvar("g_knockback", (vel[2]*-9)-500);
	self finishPlayerDamage(self, self, 1000, 0, "MOD_UNKNOWN", "bounce", self.origin, (0,0,1) , "none", 0);

	wait 0.05;
	setDvar("g_knockback", level.knockback);

	self.health    = health;
	self.maxhealth = maxHealth;

	while(self isTouching(trigger))
		wait 0.05;

	self.bouncing = undefined;
}

secretfailtele()
{
	level.secretspot = getent("secretfail","targetname");
	trig = getEnt("secretfailtrig","targetname");
	for(;;)
	{
		trig waittill("trigger", failer);
		failer setOrigin( level.secretspot.origin );
		failer setplayerangles( level.secretspot.angles );
		wait .0005;
	}
}

secretendtele()
{
	secretendtrig = getEnt("secretendtrig","targetname");
	level.telesend = getent("telesend","targetname");
	for(;;)
	{
		secretendtrig waittill("trigger", player );
		player iprintlnBold("Teleporting in 5 secounds!");
		player thread teletoendsecret();
		player.health += 50;
		player thread secretcheack();
	}
}

secretcheack()
{
	if (isDefined(self.pers["secret"]))
		return;

		self braxi\_rank::giverankxp(undefined, 200);
		self.pers["secret"] = true;
}
teletoendsecret()
{
	wait 5;
	self setOrigin( level.telesend.origin );
	self setplayerangles( level.telesend.angles );
}

Bouncer()
{
	self endon("death");
	{
	self bounceran( vectorNormalize( self.origin - (self.origin - (0,0,50)) ), 10000 );
	}
}

bounceran( pos, power )
{
	oldhp = self.health;
	self.health = self.health + power;
	self setClientDvars( "bg_viewKickMax", 0, "bg_viewKickMin", 0, "bg_viewKickRandom", 0, "bg_viewKickScale", 0 );
	self finishPlayerDamage( self, self, power, 0, "MOD_PROJECTILE", "none", undefined, pos, "none", 0 );
	self.health = oldhp;
	self thread bounce2();
}
bounce2()
{
	self endon( "disconnect" );
	wait .05;
	self setClientDvars( "bg_viewKickMax", 90, "bg_viewKickMin", 5, "bg_viewKickRandom", 0.4, "bg_viewKickScale", 0.2 );
}