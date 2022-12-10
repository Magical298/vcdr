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
	Website: vistic-clan.net

*/

init()
{
	level.drStatsTable = "mp/drStatsTable.csv";

	for(;;)
	{
		level waittill("connected",player);
		player thread useConfig();
	}
}

// Stat Usage
get_drstat(dataName)
{
	return self getstat(int(tablelookup(level.drStatsTable,1,dataName,0)));
}

set_drstat(dataName,value)
{
	self setstat(int(tablelookup(level.drStatsTable,1,dataName,0)),value);
	return value;
}

add_drstat(dataName,value)
{
	current=self getstat(int(tablelookup(level.drStatsTable,1,dataName,0)));
	self setstat(int(tablelookup(level.drStatsTable,1,dataName,0)),value+current); 
}

use_drstat(dataName)
{
	if(get_drstat(dataName)==0)
		return int(set_drstat(dataName,1));
	else 
		return int(set_drstat(dataName,0));
}

setGraphicsDvar(name,dvar)
{
	if(self get_drstat(name))
		self setClientDvar(dvar, "^8Enabled");
	else
		self setClientDvar(dvar, "^9Disabled");
}
// End Stats Usage


useConfig()
{
	self endon("disconnect");

	self setgraphicsdvar("DR_BRIGHT","ui_fullbright");
	self setgraphicsdvar("DR_FPS","dr_fps");
	self setgraphicsdvar("DR_WASD","dr_wasd");
	self setGraphicsDvar("DR_DECALS","ui_drawdecals");
	self setGraphicsDvar("DR_FX","ui_fxenable");
	self setGraphicsDvar("DR_FOG","ui_fogenable");
	self setGraphicsDvar("DR_COMPASS","dr_compass");

	switch(self get_drstat("DR_FOVSCALE"))
	{
		case 0:	self.dr_fov = 1;		break;
		case 1: self.dr_fov = 1.05;		break;
		case 2: self.dr_fov = 1.1;		break;
		case 3: self.dr_fov = 1.15;		break;
		case 4: self.dr_fov = 1.2;		break;
		case 5: self.dr_fov = 1.25;     break;
		case 6: self.dr_fov = 1.3;		break;
		case 7: self.dr_fov = 1.35;		break;
		case 8: self.dr_fov = 1.4;		break;
	}

	switch(self get_drstat("DR_FOV"))
	{
		case 0:	self.dr_realfov = 65;	break;
		case 1:	self.dr_realfov = 70;	break;
		case 2:	self.dr_realfov = 75;	break;
		case 3:	self.dr_realfov = 80;	break;
		case 4:	self.dr_realfov = 85;	break;
		case 5:	self.dr_realfov = 90;	break;
	}

	switch(self get_drstat("DR_GENRE"))
	{
		case 0: self.music_genre = "^8Default"; break;
		case 1: self.music_genre = "^8Original"; break;
		case 2: self.music_genre = "^8Hardstyle"; break;
		case 3: self.music_genre = "^8Drum & Bass"; break;
		case 4: self.music_genre = "^8Hardcore"; break;
	}

	self setclientdvars("r_fullbright",self get_drstat("DR_BRIGHT"),
						"cg_fov",self.dr_realfov,
						"cg_fovscale",self.dr_fov,
						"r_drawdecals", self get_drstat("DR_DECALS"), 
						"fx_enable", self get_drstat("DR_FX"), 
						"r_fog", self get_drstat("DR_FOG"),
						"drhidecompass",self get_drstat("DR_COMPASS"),
						"dr_genre",self.music_genre
						);				
}

graphics(response)
{
	switch(response)
	{
		case "0":
			self setclientdvar("r_fullbright",self use_drstat("DR_BRIGHT"));
			self setgraphicsdvar("DR_BRIGHT","ui_fullbright");
			break;

		case "1":
			switch(self get_drstat("DR_FOV"))
			{
				case 0:
					self set_drstat("DR_FOV",1);
					self.dr_realfov = 70;
					break;

				case 1:
					self set_drstat("DR_FOV",2);
					self.dr_realfov = 75;
					break;

				case 2:
					self set_drstat("DR_FOV",3);
					self.dr_realfov = 80;
					break;

				case 3:
					self set_drstat("DR_FOV",4);
					self.dr_realfov = 85;
					break;

				case 4:
					self set_drstat("DR_FOV",5);
					self.dr_realfov = 90;
					break;

				case 5:
					self set_drstat("DR_FOV",0);
					self.dr_realfov = 65;
					break;
			}

			self setclientdvar("cg_fov",self.dr_realfov);
			break;

		case "2":
			switch(self get_drstat("DR_FOVSCALE"))
			{
				case 0:
					self set_drstat("DR_FOVSCALE",1);	
					self.dr_fov = 1.05;
					break;

				case 1:
					self set_drstat("DR_FOVSCALE",2);	
					self.dr_fov = 1.1;
					break;

				case 2:
					self set_drstat("DR_FOVSCALE",3);	
					self.dr_fov = 1.15;
					break;

				case 3:
					self set_drstat("DR_FOVSCALE",4);
					self.dr_fov = 1.2;
					break;

				case 4:
					self set_drstat("DR_FOVSCALE",5);
					self.dr_fov = 1.25;
					break;

				case 5:
					self set_drstat("DR_FOVSCALE",6);
					self.dr_fov = 1.3;
					break;

				case 6:
					self set_drstat("DR_FOVSCALE",7);
					self.dr_fov = 1.35;
					break;

				case 7:
					self set_drstat("DR_FOVSCALE",8);
					self.dr_fov = 1.4;
					break;

				case 8:
					self set_drstat("DR_FOVSCALE",0);
					self.dr_fov = 1.0;
					break;
			}

			self setclientdvars("dr_fovscale",self.dr_fov,"cg_fovscale",self.dr_fov);
			break;

		case "3":
			self setclientdvar("dr_fps",self use_drstat("DR_FPS"));
			self setgraphicsdvar("DR_FPS","dr_fps");
			break;

		case "4":
			self setclientdvar("dr_wasd",self use_drstat("DR_WASD"));
			self setgraphicsdvar("DR_WASD","dr_wasd");
			break;

		case "5":
			self setclientdvar("r_drawdecals",self use_drstat("DR_DECALS"));
			self setgraphicsdvar("DR_DECALS","ui_drawdecals");
			break;

		case "6":
			self setclientdvar("fx_enable",self use_drstat("DR_FX"));
			self setgraphicsdvar("DR_FX","ui_fxenable");
			break;

		case "7":
			self setclientdvar("r_fog",self use_drstat("DR_FOG"));
			self setgraphicsdvar("DR_FOG","ui_fogenable");
			break;

		case "8":
			self setclientdvar("drhidecompass",self use_drstat("DR_COMPASS"));
			self setgraphicsdvar("DR_COMPASS","dr_compass");
			break;
	
		case "9":
			switch(self get_drstat("DR_GENRE"))
			{
				case 0:
					self set_drstat("DR_GENRE",1);
					self.music_genre = "^8Original";
					break;
				case 1:
					self set_drstat("DR_GENRE",2);
					self.music_genre = "^8Hardstyle";
					break;
				case 2:	
					self set_drstat("DR_GENRE",3);
					self.music_genre = "^8Drum & Bass";
					break;
				case 3:	
					self set_drstat("DR_GENRE",4);
					self.music_genre = "^8Hardcore";
					break;
				case 4:	
					self set_drstat("DR_GENRE",0);
					self.music_genre = "^8Default";
					break;
			}
			self setclientdvar("dr_genre",self.music_genre);
			break;
	}
}