// __/\\\________/\\\_______________________________________________________________________/\\\\\\\\\__/\\\\\\_________________________________        
//  _\/\\\_______\/\\\____________________________________________________________________/\\\////////__\////\\\_________________________________       
//   _\//\\\______/\\\___/\\\__________________/\\\_______/\\\___________________________/\\\/______________\/\\\_________________________________      
//   __\//\\\____/\\\___\///___/\\\\\\\\\\__/\\\\\\\\\\\_\///______/\\\\\\\\____________/\\\________________\/\\\_____/\\\\\\\\\_____/\\/\\\\\\___     
//    ___\//\\\__/\\\_____/\\\_\/\\\//////__\////\\\////___/\\\___/\\\//////____________\/\\\________________\/\\\____\////////\\\___\/\\\////\\\__    
//     ____\//\\\/\\\_____\/\\\_\/\\\\\\\\\\____\/\\\______\/\\\__/\\\___________________\//\\\_______________\/\\\______/\\\\\\\\\\__\/\\\__\//\\\_   
//      _____\//\\\\\______\/\\\_\////////\\\____\/\\\_/\\__\/\\\_\//\\\___________________\///\\\_____________\/\\\_____/\\\/////\\\__\/\\\___\/\\\_  
//       ______\//\\\_______\/\\\__/\\\\\\\\\\____\//\\\\\___\/\\\__\///\\\\\\\\______________\////\\\\\\\\\__/\\\\\\\\\_\//\\\\\\\\/\\_\/\\\___\/\\\_ 
//        _______\///________\///__\//////////______\/////____\///_____\////////__________________\/////////__\/////////___\////////\//__\///____\///__

/*
	 _   ________   ___  __        __   
	| | / / ___( ) / _ )/ /__ ____/ /__ 
	| |/ / /__ |/ / _  / / _ `/ _  / -_)
	|___/\___/   /____/_/\_,_/\_,_/\__/ 

	© VC' Blade
	Website: vistic-clan.com

*/

#include braxi\_common;
init()
{	
	level.fx["dust"] = loadFx( "props/crateexp_dust" );
	
	string = strTok( "ak47_mp;skorpion_reflex_mp;winchester1200_mp;saw_acog_mp;barrett_mp;mp44_mp;remington700_acog_mp;smoke_grenade_mp;frag_grenade_mp", ";" );
	for(i=0;i<string.size;i++)
		precacheItem( string[i] );
	precacheShellshock( "frag_grenade_mp" );
	precacheShader("compass_objpoint_satallite");
	
	//rtd
	thread onPlayerSpawned();
}

onPlayerSpawned()
{
	for(;;)
    {
        level waittill("player_spawn",player);
        if(!player.ghost)
        {
        	if(!level.freerun && player.pers["team"] == "allies")
        	{
				if(!level.trapsdisabled || !isdefined(player.finishedMap) && !isdefined(player.rtded))
				{
					player giveweapon("radar_mp");
        			player SetActionSlot( 1, "weapon","radar_mp" );

					player thread watchWeapon("radar_mp");
				}
        	}
        }
    }
}

watchWeapon(weap)
{
	level endon ( "endmap" );

	self endon("death");
	self endon("disconnect");
	self endon( "joined_spectators" );

	for(;;)
	{
		if(self getcurrentweapon() == weap)
		{
			blade\_common::switchWeaponBack(self,weap);

			if(!isdefined(self.finishedMap) && !isdefined(self.rtded))
			{
				//self iprintlnbold("^8Roll the Dice^7 activated");
				self.rtded = true;
				self thread rtd();
			}
		}
		wait .05;
	}
}

rtd()
{
	self endon("disconnect");
	self endon("death");
	self endon( "spawned_player" );
	self endon( "joined_spectators" );

	self playlocalsound("rtd");

	wait 4.5;
	random = randomint(20);
	if(random == 0 || random == 7 || random == 4 || random == 12 || random == 16 || random == 17 || random == 19 || random == 1 || random == 9 || random == 10 )
		self thread weapons();
	else
		self thread perk();

}

weapons()
{	
	self endon( "disconnect" );
	self endon( "death" );
	
	wait 1;
	if(level.trapsDisabled)
		return;

	randomwep = randomint(26);
		
	weapon = undefined;
	name = "";

	switch(randomwep)
	{
		case 0:	
			name = "Naked Hands";
			weapon = "g36c_gl_mp";
			break;

		case 1:	
			name = "Combat Knife";
			weapon = "knife_mp";
			break;

		case 2:	
			name = "Cleaver";
			weapon = "m4_gl_mp";
			break;

		case 3:	
			name = "Tactical Knife";
			weapon = "m4_acog_mp";
			break;
		
		case 4:	
			name = "Katana";
			weapon = "ak47_gl_mp";
			break;

		case 5:	
			name = "Machete";
			weapon = "ak47_acog_mp";
			break;

		case 6:	
			name = "Wakizashi";
			weapon = "g36c_acog_mp";
			break;

		case 7:	
			name = "Glaive";
			weapon = "g3_acog_mp";
			break;
		
		case 8:	
			name = "Axe";
			weapon = "g3_gl_mp";
			break;

		case 9:	
			name = "Shovel";
			weapon = "g3_reflex_mp";
			break;

		case 10:	
			name = "Sledgehammer";
			weapon = "m14_gl_mp";
			break;

		case 11:	
			name = "Gut Knife";
			weapon = "m14_silencer_mp";
			break;

		case 12:	
			name = "Butterfly";
			weapon = "m14_acog_mp";
			break;

		case 13:	
			name = "Baseball Bat";
			weapon = "ak74u_silencer_mp";
			break;

		case 14:	
			name = "Zombie Sword";
			weapon = "g36c_reflex_mp";
			break;

		case 15:	
			name = "Duel Katana";
			weapon = "ak47_reflex_mp";
			break;

		case 16:	
			name = "M9 Beretta";
			weapon = "beretta_mp";
			break;

		case 17:	
			name = "USP .45";
			weapon = "usp_mp";
			break;

		case 18:	
			name = "Colt .45";
			weapon = "colt45_mp";
			break;

		case 19:	
			name = "Desert Eagle";
			weapon = "deserteagle_mp";
			break;

		case 20:	
			name = "Lynx";
			weapon = "dragunov_acog_mp";
			break;

		case 21:	
			name = "Desert Eagle Gold";
			weapon = "deserteaglegold_mp";
			break;

		case 22:	
			name = "Walter P226";
			weapon = "g36c_silencer_mp";
			break;

		case 23:	
			name = "Colt .44";
			weapon = "colt44_mp";
			break;

		case 24:	
			name = "Kamchatka";
			weapon = "m1014_mp";
			break;

		case 25:	
			name = "PSG 1";
			weapon = "barrett_acog_mp";
			break;
		
		default: 
			return;
	}

	if(isdefined(name))
		self thread rtdResult(name);

	wait 1;

	if(isdefined(weapon))
	{
		self takeweapon(self getcurrentweapon());

		self giveweapon(weapon);
		self switchtoweapon(weapon);
	}
}

perk()
{
	self endon( "disconnect" );
	self endon( "death" );

	wait 1;
	if(level.trapsDisabled)
		return;
		
	randomperk = randomint(9);

	name = "";

	switch(randomperk)
	{
		case 0:
			name = "Clone";
			self thread Clone();
			break;		
				
		case 1:	
			name = "Random XP";
			self thread letroll();
			break;		
				
		case 2:	
			rand=RandomInt( 60 );
			if( rand > 30 )
			{
				name = "Double Health Points";
				self.maxhealth = 200;
				self.health = self.maxhealth;
			}
			else if(rand <30) 
			{
				if(getdvar("mapname") != "mp_deathrun_dragonball")
				{
					name = "x10 Health Points";
					self thread potionOutrun();
				}
				else 
				{
					name = "Double Health Points";
					self.maxhealth = 200;
					self.health = self.maxhealth;
				}
			}
			break;
				
		case 3:	
			name = "WTF Boom?!";
			self thread low();
			break;
				
		case 4:	
			name = "Life";
			self braxi\_mod::giveLife();
			break;
				
		case 5:	
			name = "Speed";
			self thread Speed();
			break;

		case 6:	
			name = "Twisted-Mind";
			self thread DoAnti();
			break;		
					
		case 7:	
			name = "Ninja (60 sec.)";
			self thread highasfuck();
			break;
		
		case 8:
			ghost = randomint(2);
			if(ghost == 1)
			{
				name = "Dishonored Ghost";
				self thread dishonored_ghost();
			}
			else
			{
				name = "Matrix Mode";
				self thread matrix_mode();			
			}
			break;				
					
		default: 
			return;
	}
	
	if(isdefined(name))
		self thread rtdResult(name);
}

low()
{
	self endon( "disconnect" );
	self endon( "death" );

	self playSound( "wtf" );
	
	wait 0.8;
	playFx( level.fx["bombexplosion"], self.origin );
	self suicide();
}


highasfuck()
{
	self endon( "disconnect" );
	self endon( "death" );

		self hide();
		for(i=0;i<120;i++)
		{
			if(self getStance() == "stand")
			{
				playfx(level.fx[7], self.origin); 
			}
			wait .5;			
		}
		self show();
		self iPrintlnBold("^1You are visible");
}

DoAnti()
{
	self iprintlnbold("^1THE RTD-MASTER GOT A SURPRISE FOR YOU!!");
	wait 3;
	self iprintlnbold("^3Wanna see something cool ?");
	//self SetClientDvar("cg_thirdperson", 1 );
	wait 3;
	self thread flipzor();
	wait 2;
	self iprintlnbold("^2Little Notice: ^1Your turn XD !");
	wait 0.5;
	//self SetClientDvar("cg_thirdperson", 0 );
}

flipzor()
{
	self endon("disconnect");
	self endon("death");
	self endon("joined_spectators");

		while(isalive(self) && !isdefined(self.finishedMap))
		{
		i = 0;
		angles = self GetPlayerAngles();
		angles1 = self GetPlayerAngles();
		while(i<3)
				{
				wait 0.01;
		 		i+=0.09;
				angles+=(0,11,11);
				self SetPlayerAngles(angles);
	         		}
		if(i>2.8)
		self SetPlayerAngles(angles1);
		
		rand = RandomFloatRange( 0.1, 10 );
		wait rand;
	}
}


dishonored_ghost()
{
self endon ( "disconnect" );
self endon ( "death" );

	while(isalive(self) && !isdefined(self.finishedMap))
	{
	self show();
	playFx( level.fx["dust"] , self.origin );
	wait 1;
	self hide();
	wait 3;
	}
}

matrix_mode()
{
	self endon ( "disconnect" );
	self endon ( "death" );

	i = 0;

	while(i < 15)
	{
		self hide();
		i += 0.05;
		wait 0.05;
		self show();
		wait 0.05;
	}

	self iprintlnbold("matrix mode off");
}


ShootNukeBullet()
{
    self endon("death");
	i=0;
    while(i<3)
    {
        self waittill ( "weapon_fired" );
			if( self getCurrentWeapon() == "m1014_grip_mp" )
			{
				self playsound("rocket_explode_default");
					vec = anglestoforward(self getPlayerAngles());
					end = (vec[0] * 200000, vec[1] * 200000, vec[2] * 200000);
					SPLOSIONlocation = BulletTrace( self gettagorigin("tag_eye"), self gettagorigin("tag_eye")+end, 0, self)[ "position" ];
					playfx(level.chopper_fx["explode"]["medium"], SPLOSIONlocation); 
					RadiusDamage( SPLOSIONlocation, 200, 500, 60, self ); 
					earthquake (0.3, 1, SPLOSIONlocation, 400); 
					i++;
					wait 1;
			}
       }
		self TakeWeapon( "m1014_grip_mp");
		self GiveWeapon("knife_mp");
		self switchToWeapon( "knife_mp" );
		
}


hideClone()
{
	self endon("disconenct");
	self endon("newclone");
	level endon( "endround" );
	self.clon = [];
	
	for(k=0;k<8;k++)
		self.clon[k] = self cloneplayer(10);
				
	while( self.sessionstate == "playing" )
	{
		if(isDefined(self.clon[0]))
		{
			self.clon[0].origin = self.origin + (0, 60, 0);
			self.clon[1].origin = self.origin + (-41.5, 41.5, 0);
			self.clon[2].origin = self.origin + (-60, 0, 0);
			self.clon[3].origin = self.origin + (-41.5, -41.5, 0);
			self.clon[4].origin = self.origin + (0, -60, 0);
			self.clon[5].origin = self.origin + (41.5, -41.5, 0);
			self.clon[6].origin = self.origin + (60, 0, 0);
			self.clon[7].origin = self.origin + (41.5, 41.5, 0);
			
			for(j=0;j<8;j++)
				self.clon[j].angles = self.angles;
		}
		wait .05;
	}
	
	for(i=0;i<8;i++)
	{
		if(isDefined(self.clon[i]))
			self.clon[i] delete();
	}
}

Clone()
{	
	self endon("death");
	level endon( "endround" );
	
	while( self.sessionstate == "playing")
	{
		if(self getStance() == "stand" && isDefined( self.clon ))
		{
			for(j=0;j<8;j++)
			{
				if(isDefined( self.clon[j] ))
					self.clon[j] hide();
			}
				
			self notify("newclone");
		}
		else
		{
			self notify("newclone");
			self thread hideClone();

			while(self getStance() != "stand")
				wait .05;
		}
		wait .05;
	}
}

Speed()
{
	self endon("disconnect");
	
	self SetMoveSpeedScale(1.4);
	self setClientDvar("g_gravity", 70 );
	
	while(isalive(self) && !isdefined(self.finishedMap))
	{
		if(!self isOnGround() && !self.doingBH)
		{
			while(!self isOnGround())
				wait 0.05;
				
			playfx(level.fx[8], self.origin - (0, 0, 10)); 
			earthquake (0.3, 1, self.origin, 100); 
		}
		wait .2;
	}
	
	if(isDefined(self))
	{
		self setClientDvar("g_gravity", 70 );
		self SetMoveSpeedScale(1);
	}
}

letroll()
{
	self endon( "disconnect" );
	self endon( "death" );

	xp = randomint(6);

	if(xp == 0 || xp == 1)
		self braxi\_rank::giveRankXP(undefined,100);
	else if(xp == 2 || xp == 3)
		self braxi\_rank::giveRankXP(undefined,250);
	else if(xp == 4 || xp == 5)
		self braxi\_rank::giveRankXP(undefined,50);
}

potionOutrun()
{
	self endon( "disconnect" );
	self endon( "death" );

	self.maxhealth = 1000;
	self.health = self.maxhealth;

	dmg = 10;
	wait 10;

	self iprintlnbold("^1Your body cant resist this 1000hp potion !");
	wait 0.5;
	self iprintlnbold("^1Finish before your body is worn out");

	while(isalive(self) && !isdefined(self.finishedMap))
	{
		self finishPlayerDamage( self, self, dmg, 0, "MOD_PROJECTILE", "rpg_mp", self.origin, self.angles, "none", 0 );
		self PlayLocalSound("breathing_hurt");
		wait 1;
	}
}

rtdResult(item)
{
	shader=createhud(self,0,303,"center","bottom");
	shader.alpha=0.4;
	shader.archived = 0;
	shader.sort = -1;
	shader.hidewheninmenu=true;
	shader setshader("black",200,45);

	iconbg=createhud(self,-77,308,"center","bottom");
	iconbg.alpha=0.4;
	iconbg.sort = 0;
	iconbg.archived = 0;
	iconbg.hidewheninmenu=true;
	iconbg setshader("black",40,40);

	icon=createhud(self,-77,308,"center","bottom");
	icon.alpha=1;
	icon.archived = 0;
	icon.foreground = true;
	icon.hidewheninmenu=true;
	icon setshader("compass_objpoint_satallite",45,45);

	name=createhud(self,16,320,"center","bottom","default",1.6,undefined,level.randomcolor);
	name.foreground = true;
	name.alpha=1;
	name.archived = 0;
	name.hidewheninmenu=true;
	name settext(item);

	// Move in
	shader moveovertime(0.35);
	icon moveovertime(0.35);
	iconbg moveovertime(0.35);
	name moveovertime(0.35);

	shader.y = -5; 
	iconbg.y = -8;
	icon.y = -8;
	name.y = -20;

	wait 3;

	// Move out
	shader moveovertime(0.35);
	icon moveovertime(0.35);
	iconbg moveovertime(0.35);
	name moveovertime(0.35);

	shader.y = 303; 
	iconbg.y = 308;
	icon.y = 308;
	name.y = 320;

	wait .5;

	shader destroy();
	icon destroy();
	iconbg destroy();
	name destroy();
}

createhud(what,x,y,alignx,aligny,font,scale,color,glow)
{
	if(isplayer(what))
		hud=newclienthudelem(what);
	else 
		hud=newhudelem();
	hud.alignx=alignx;
	hud.aligny=aligny;
	hud.horzalign=alignx;
	hud.vertalign=aligny;
	hud.x=x;
	hud.y=y;

	if(isdefined(font))
		hud.font=font;

	if(isdefined(scale))
		hud.fontscale=scale;

	if(isdefined(color))
		hud.color=color;

	if(isdefined(glow))
	{
		hud.glowalpha=1;
		hud.glowcolor=glow;
	}

	return hud;
}