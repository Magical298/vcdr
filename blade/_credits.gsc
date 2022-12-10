/*	 _    ___      __  _                               ______  
	| |  / (_)____/ /_(_)____                         / _____\ 
	| | / / / ___/ __/ / ___/                        / / ___/ |
	| |/ / (__  ) /_/ / /__                         / / /__  / 
	|___/_/____/\__/_/\___/  __    ____            |  \___/ /  
	   / __ \___  ____ _/ /_/ /_  / __ \__  ______  \______/   
	  / / / / _ \/ __ `/ __/ __ \/ /_/ / / / / __ \            
	 / /_/ /  __/ /_/ / /_/ / / / _, _/ /_/ / / / /            
	/_____/\___/\__,_/\__/_/ /_/_/ |_|\__,_/_/ /_/             
	                                                           
	Code: 
			Blade #6504
			Legend #9805

	Design & Textures:
			Niko #2926
            EphNey #1431

    Character & Weapon Assets:
            Fox.#0001
            Magical.#9137

	Vistic Clan ©
*/

#include braxi\_common;

init()
{
	thread buildShop();

	level.shopFX = loadfx("vistic/shopfx");
	level.canplaysound = true;

	// === Precache
	precachemodel("worldmodel_cj_inventory_bag");
	precachemodel("dia");
	precachemodel("ruby_fragment_model");
	precachemenu("dr_shop");

	// Jewel Rain
	if(!isdefined(level.portalobjects))
		level.portalobjects = [];

	// === Daily Chest
	level.dailyChest_time = 14400; // 24 Hours = 86400 seconds ; 12 Hours = 43200; 6 Hours = 21600; 4 Hours = 14400
	level.dailyChest_stat = 2602;

	thread findShopPlace();
	
	for(;;)
	{
		level waittill("connected",player);

		player.rubyTotal = 0;
		player.shardTotal = 0;

		//player thread checkvcp_hack();
	}
}

buildShop()
{
	level.shopItem = [];
	level.shopItemsNum = 0;

	table = "mp/shopTable.csv";

	for(idx=1;isdefined(tablelookup(table,0,idx,0)) && tablelookup(table,0,idx,0)!="";idx++)
	{
		id = int(tablelookup(table,0,idx,1));

		level.shopItem[id]["stat"] = int(tablelookup(table,0,idx,2));
		level.shopItem[id]["price"] = int(tablelookup(table,0,idx,3));
		level.shopItem[id]["item"] = tablelookup(table,0,idx,4);

		level.shopItemsNum ++;
	}
}

findShopPlace()
{
	if(!isdefined(level.spots))
		level.spots = [];

	for(i=0;i<level.spawn["allies"].size;i++)
		level.spots[i]=spawn("script_origin",level.spawn["allies"][i] getorigin());

	wait 1;

	x = 0;
	y = 0;
	z = 0;

	for(i=0;i<level.spots.size;i++)
	{
		x = x+level.spots[i].origin[0];
		y = y+level.spots[i].origin[1];
		z = z+level.spots[i].origin[2];
	}

	/*if(level.script == "mp_pizzahut_v2")
		level.spawn_0 = (27692,2682,2108);
	else */
	level.spawn_0 = ( (x/level.spots.size), (y/level.spots.size), (z/level.spots.size) );

	level waittill("round_started");

	if(level.freeRun)
		return;

	circle_0 = spawn("script_model",(level.spawn_0+(0,0,0))); 
	circle_0.angles=(0,0,0);
	
	circle_1 = spawn("script_model",(level.spawn_0+(0,0,25))); 
	circle_1 setmodel("worldmodel_cj_inventory_bag");
	circle_1.angles=(0,0,0);

	wait .5;
	playfx(level.shopFx,circle_0.origin);
	thread rotateObject(circle_1);

	trigger=spawn("trigger_radius",level.spawn_0,0,35,80);
	thread triggerNotify(level.spawn_0,trigger,"Press ^8[{+activate}]^7 to open the Market");

	for(;;)
	{
		trigger waittill("trigger",who);

		if(who usebuttonpressed() && !isdefined(who.inShop))
		{
			who.inShop = true;
			who thread openShop();
		}
		wait .05;
	}
}

triggerNotify(targ,who,msg)
{
	self endon("disconnect");
	
	while(isdefined(who))
	{
		player=getentarray("player","classname");
		for(i=0;i<player.size;i++)
		{	
			if(distance(player[i].origin,targ)<=50 && player[i].sessionstate == "playing")
				player[i] maps\mp\_utility::setLowerMessage(msg);
			else if(distance(player[i].origin,targ)>=50 && player[i].sessionstate == "playing")
				player[i] maps\mp\_utility::clearLowerMessage();
		}
		wait .05;
	}
	player=getentarray("player","classname");
	for(i=0;i<player.size;i++)	
	{
		if(player[i].sessionstate == "playing")
			player[i] maps\mp\_utility::clearLowerMessage();
	}
}

openShop()
{
	if(!self.inShop)
		return;

	self giveweapon("briefcase_bomb_mp");
	self switchtoweapon("briefcase_bomb_mp");

	wait 2;

	self openMenu("dr_shop");

	while(isdefined(self.inShop))
	{
		self waittill("menuresponse",menu,response);

		if(response == "market_close")
		{
			if(isdefined(self.inShop))
				self.inShop = undefined;

			self closemenu();
			self closeingamemenu();

			wait .4;
			self braxi\_common::clientcmd("weapprev");
			wait .6;
			self takeweapon("briefcase_bomb_mp");
		}

		if(response == "market_open")
			self thread dailyBoxTimer();

		if(issubstr(response,"shop_"))
		{
			pattern = "shop_";
			shopItem = int(getsubstr(response, pattern.size));

			switch(shopItem)
			{
				case 0:
					self thread purchaseMarketItem(shopItem,"shards",false);
					break;
				case 1:
				case 2:
				case 3:
					self thread purchaseMarketItem(shopItem,"rubys",false);
					break;
				case 4:
				case 5:
				case 6:
					self thread purchaseMarketItem(shopItem,"shards",false);
					break;
				case 7:
				case 8:
					self thread purchaseMarketItem(shopItem,"rubys",false);
					break;
				case 9:
				case 10:
				case 11:
				case 12:
				case 13:
				case 14:
				case 15:
				case 16:
					self thread purchaseMarketItem(shopItem,"rubys",true);
					break;
				case 17:
					if((self getstat(level.dailyChest_stat) + level.dailyChest_time) < getRealTime())
					{
						self setstat(level.dailyChest_stat,getRealTime());

						self closemenu();
						self closeingamemenu();

						if(isdefined(self.inShop))
							self.inShop = undefined;

						self thread openChest("iron");
					}
					else 
						self playlocalsound("dudum");
					break;
			}
		}
	}
}

purchaseMarketItem(id,currency,permanent)
{
	if(permanent && self getstat(level.shopItem[id]["stat"]) == 1)
	{
		self closemenu();
		self closeingamemenu();

		self iprintlnbold("You already own this Item");
		return;
	}

	if(currency == "shards")
	{
		if(self getstat(2358) >= level.shopItem[id]["price"])
		{
			if(permanent)
				self setstat(level.shopItem[id]["stat"],1);

			self setstat(2358, (self getstat(2358) - level.shopItem[id]["price"]));

			self playlocalsound("kaching");

			self thread giveShopItem(level.shopItem[id]["item"]);
		}
		else 
			self playlocalsound("no_credits");
	}
	else 
	{
		if(self getstat(2392) >= level.shopItem[id]["price"])
		{
			if(permanent)
				self setstat(level.shopItem[id]["stat"],1);

			self setstat(2392, (self getstat(2392) - level.shopItem[id]["price"]));
			self playlocalsound("kaching");

			self thread giveShopItem(level.shopItem[id]["item"]);
		}
		else 
			self playlocalsound("no_credits");
	}
}

giveShopItem(item)
{
	if(item == "Unknown")
	{
		self iprintlnbold("This Item is coming soon");
		return;
	}

	switch(item)
	{
		case "Shards -> Ruby":
			self setstat(2392,(self getstat(2392) + 4));
			self iprintlnbold("^84 Rubys^7 obtained");
			break;

		case "Bronze Chest":
			self closeMenu();
			self closeingameMenu();

			self thread openChest("bronze");
			break;

		case "Silver Chest":
			self closeMenu();
			self closeingameMenu();

			self thread openChest("silver");
			break;

		case "Gold Chest":
			self closeMenu();
			self closeingameMenu();

			self thread openChest("gold");
			break;

		case "Party Mode":
			self closeMenu();
			self closeingameMenu();

			if(level.canplaysound)
			{
				thread braxi\_admin::partyMode();
				iprintlnbold("^8"+self.name+"^7 throws a ^1P^2A^3R^4T^5Y^6 !!");
			}
			else
				self iprintlnbold("There is already a ^1P^2A^3R^4T^5Y^7 running");
			break;

		case "HP Boost":
			self closeMenu();
			self closeingameMenu();
			
			if(!isdefined(self.shopHP))
			{
				self.shopHP = true;

				self.maxhealth = self.maxhealth*2;
				self.health = self.maxhealth;

				self iprintlnbold("Health Potion obtained");
			}
			else 
				self iprintlnbold("Only Once per Round");
			break;

		case "Lottery":
			self closeMenu();
			self closeingameMenu();

			self thread blade\_lottery::lotto();
			break;

		case "Gold Lottery":
			self closeMenu();
			self closeingameMenu();

			self thread blade\_lottery::premiumLottery();
			break;

		case "Jewel Rain":
			self closeMenu();
			self closeingameMenu();

			if(!isdefined(self.shopJewelRain))
			{
				self.shopJewelRain = true;
				self thread jewelRain(5);
			}
			else 
				self iprintlnbold("Only once per Round");
			break;

		default:
			self iprintlnbold("You unlocked "+item);
			break;
	}
}

dailyBoxTimer()
{
	if(!isdefined(self.dailyChestTimer))
		self.dailyChestTimer = "";

	while(isdefined(self.inShop))
	{
		calculate = (self getstat(level.dailyChest_stat) + level.dailyChest_time) - getRealTime();
		self.dailyChestTimer = TimeToString( calculate, 1, "%H:%M:%S");
		
		if((self getstat(level.dailyChest_stat) + level.dailyChest_time) < getRealTime())
		{
			self setclientdvar("uidr_dailyChest","Open");
			wait .05;
		}
		else 
		{
			self setclientdvar("uidr_dailyChest",self.dailyChestTimer);
			wait 1;
		}
	}
}

checkvcp_hack()
{
	self endon("disconnect");
	while(1)
	{
		if(self getstat(2358) > 5001)
		{
			self setstat(2358,0);
			self setstat(2392,0);
			self blade\_common::addWarn(1,"You tried to hack Currency Cap");
		}
		wait 1;
	}
}

openChest(type)
{
	if(!isdefined(type) || type == "")
		return;

	vc = randomfloatrange(0.0,100.0);

	switch(type)
	{
		case "iron":
			if(vc <= 1.0)
			{
				self blade\_common::vc_rubys(150);
				self braxi\_rank::giverankxp(undefined,2500);
				// 100 Rubys
				// 1000 XP
			}
			else if(vc <= 10.0 && vc > 1.0)
			{
				self blade\_common::vc_rubys(100);
				self braxi\_rank::giverankxp(undefined,2000);
			}
			else if(vc <= 40.0 && vc > 10.0)
			{
				self blade\_common::vc_coins(200);
				self braxi\_rank::giverankxp(undefined,1500);
			}
			else if(vc > 40.0)
			{
				self blade\_common::vc_coins(200);
				self braxi\_rank::giverankxp(undefined,1000);
			}
			break;

		case "bronze":
			if(vc <= 1.0)
			{
				if(self getstat(level.shopItem[10]["stat"]) != 1)
				{
					self setstat(level.shopItem[10]["stat"],1);
					self blade\_common::vc_coins(200);
				}
				else 
				{
					self blade\_common::vc_rubys(300);
					self braxi\_rank::giverankxp(undefined,2000);
				}
			}
			else if(vc <= 10.0 && vc > 1.0)
			{
				self blade\_common::vc_rubys(175);
				self braxi\_rank::giverankxp(undefined,1500);
			}
			else if(vc <= 25.0 && vc > 10.0)
			{
				self blade\_common::vc_coins(150);
				self blade\_common::vc_rubys(100);
			}
			else if(vc <= 50.0 && vc > 25.0)
			{
				self blade\_common::vc_rubys(70);
			}
			else if(vc <= 75.0 && vc > 50.0)
			{
				self blade\_common::vc_coins(300);
				self braxi\_rank::giverankxp(800);
			}
			else if(vc > 75.0)
			{
				self blade\_common::vc_coins(150);
				self braxi\_rank::giverankxp(500);
			}
			break;

		case "silver":
			if(vc <= 5.0)
			{
				if(self getstat(level.shopItem[10]["stat"]) != 1)
				{
					self setstat(level.shopItem[10]["stat"],1);
					self blade\_common::vc_coins(200);
				}
				else 
				{
					self blade\_common::vc_rubys(300);
					self braxi\_rank::giverankxp(undefined,2000);
				}
			}
			else if(vc <= 10.0 && vc > 5.0)
			{
				self blade\_common::vc_rubys(175);
				self braxi\_rank::giverankxp(undefined,1500);
			}
			else if(vc <= 25.0 && vc > 10.0)
			{
				self blade\_common::vc_coins(150);
				self blade\_common::vc_rubys(100);
			}
			else if(vc <= 50.0 && vc > 25.0)
			{
				self blade\_common::vc_rubys(70);
			}
			else if(vc <= 75.0 && vc > 50.0)
			{
				self blade\_common::vc_coins(300);
				self braxi\_rank::giverankxp(800);
			}
			else if(vc > 75.0)
			{
				self blade\_common::vc_coins(150);
				self braxi\_rank::giverankxp(500);
			}
			break;

		case "gold":
			if(vc <= 1.0)
			{
				if(self getstat(level.shopItem[9]["stat"]) != 1)
				{
					self setstat(level.shopItem[9]["stat"],1);
					self blade\_common::vc_coins(200);
				}
				else 
				{
					self blade\_common::vc_rubys(300);
					self braxi\_rank::giverankxp(undefined,2000);
				}
			}
			else if(vc <= 5.0 && vc > 1.0)
			{
				if(self getstat(level.shopItem[10]["stat"]) != 1)
				{
					self setstat(level.shopItem[10]["stat"],1);
					self blade\_common::vc_coins(200);
				}
				else 
				{
					self blade\_common::vc_rubys(300);
					self braxi\_rank::giverankxp(undefined,2000);
				}
			}
			else if(vc <= 10.0 && vc > 5.0)
			{
				self blade\_common::vc_rubys(175);
				self braxi\_rank::giverankxp(undefined,1500);
			}
			else if(vc <= 25.0 && vc > 10.0)
			{
				self blade\_common::vc_coins(150);
				self blade\_common::vc_rubys(100);
			}
			else if(vc <= 50.0 && vc > 25.0)
			{
				self blade\_common::vc_rubys(70);
			}
			else if(vc <= 75.0 && vc > 50.0)
			{
				self blade\_common::vc_coins(300);
				self braxi\_rank::giverankxp(800);
			}
			else if(vc > 75.0)
			{
				self blade\_common::vc_coins(150);
				self braxi\_rank::giverankxp(500);
			}
			break;
	}
}

// Object Movings
rotateObject(obj)
{
	thread hoverObject(obj);
	while(isdefined(obj))
	{
		obj rotateyaw(360,6);
		wait 6;
	}
}

hoverObject(obj)
{
	while(isdefined(obj))
	{
		obj movez(-10,3);
		wait 3;
		obj movez(10,3);
		wait 3;
	}
}

// Jewel Rain
jewelRain(value)
{
	self endon("disconnect");

	if(!isdefined(value))
		object_count = 1;
	else 
		object_count = value;

	fragments = [];

	while(!self isonground())
		wait .5;

	for(i=0;i<object_count;i++)
	{
		position = (self.origin[0]+randomfloat(150), self.origin[1]+randomfloat(150), self.origin[2]+randomfloat(10));
		angles = (randomint(360), randomint(360), randomint(360));

		temp_entity = [];

		treasure = randomint(2);
		if(treasure == 0)
		{
			temp_entity["model"] = spawn_portal_object("ruby_fragment_model", (position[0], position[1], position[2] + 90), angles, "sphere", 10, 0.3, 0.3, true, 0.8);
			temp_entity["type"] = "shards";
		}
		else 
		{
			temp_entity["model"] = spawn_portal_object("dia", (position[0], position[1], position[2] + 90), angles, "sphere", 10, 0.3, 0.3, true, 0.8);
			temp_entity["type"] = "rubys";
		}

		temp_entity["trigger"] = spawn("trigger_radius", position, 0, 10, 100);
		temp_entity["trigger"].radius = 10;
		temp_entity["trigger_looping"] = false;
		temp_entity["trigger_callback"] = ::collect_callback;
		temp_entity["trigger_owner"] = self;

		fragments[fragments.size] = temp_entity;
	}

	for(i=0;i<object_count;i++)
	{
		fragments[i] thread drop_trigger();
		fragments[i]["model"] thread blade\_common::start_physics((0, 0, 0));
	}
}

drop_trigger()
{
	while (isDefined(self) && isDefined(self["trigger"]))
	{
		self["trigger"] waittill("trigger", player);
		if (isDefined(self["trigger_owner"]))
		{
			if (self["trigger_owner"] != player)
			{
				continue;
				wait 0.01;
			}
		}
		if (isDefined(self["trigger_callback"]))
			player thread [[self["trigger_callback"]]](self["type"]);

		if (!self["trigger_looping"])
			break;
	}
	self["model"] blade\_common::stop_physics();
	self["trigger"] delete();
	self["model"] delete();
}

collect_callback(type)
{
	self endon("disconnect");

	if(type == "shards")
	{
		value = randomintrange(10,50);
		self thread blade\_common::vc_coins(value);
	}
	else 
	{
		value = randomintrange(5,25);
		self thread blade\_common::vc_rubys(value);
	}
}

// 
spawn_portal_object(name,pos,angles,colType,colSize,bounce,adhesion,rotate,rot_speed,cyl_height)
{
	model = spawn( "script_model", pos );
	model setmodel( name );
	model.angles = angles;
	
	model.physics = [];
	
	model.physics["name"] = name;
	
	model.physics["colType"] = colType;
	model.physics["colSize"] = colSize;
	model.physics["colHeight"] = cyl_height;
	
	model.physics["bounce"] = bounce;
	model.physics["adhesion"] = adhesion;			
	model.physics["rotate"] = rotate; 				
	model.physics["rotation_speed"] = rot_speed; 	
	
	model.physics["model_parts"] = [];	//all model parts which should be ignored by collision traces should go in here
	
	level.portalobjects[level.portalobjects.size] = model;

	return model;
}

stop_physics()
{
	self notify( "physics_stop" );

	self.origin = self.origin;
	self.angles = self.angles;
}