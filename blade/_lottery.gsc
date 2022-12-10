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

/*init()
{
	level.lottobind="M";

	for(;;)
	{
		level waittill("connected",player);

		//===================================================
		// ### Setup
		if(!isdefined(player.pers["lottery"]))
			player.pers["lottery"]=false;

		//===================================================
		// ### Binding
		player thread setupBinds();

		//===================================================
		// ### Notifying
		player thread notifyBind();

		//===================================================
		// ### Plugin Usage
		player thread bindusage();
	}
}

notifyBind()
{
	self endon("disconnect");
	for(;;)
	{
		wait 60;
		self iprintln("Press [^1"+level.lottobind+"^7] for ^1Lottery");
	}
}

setupBinds()
{
	wait 1;
	self braxi\_common::clientCmd("bind "+level.lottobind+" openscriptmenu -1 lottery");
}

bindusage()
{
	for(;;)
	{
		self waittill("menuresponse",menu,response);

		switch(response)
		{
			case "lottery":
				if(self.pers["team"]!="allies")
				{
					self iprintlnbold("Lottery is just available as Jumper");
					self.cooldown=60;
					continue;
				}
				else 
				{
					self thread lotto();
					self.cooldown=30;
				}
				self thread lotterycountdown(self.cooldown);
				break;
		}
	}
}*/

lotto()
{
	if(isalive(self))
	{
		result=undefined;
		vc=randomintrange(1,200);
		switch(vc)
		{
			case 1:
				result="+500 XP";
				self braxi\_rank::giverankxp(undefined,500);
				break;
			case 2:
				result="+250 XP";
				self braxi\_rank::giverankxp(undefined,250);
				break;
			case 3:
				result="+250 XP";
				self braxi\_rank::giverankxp(undefined,250);
				break;
			case 4:
				result="-250 XP";
				self braxi\_rank::giverankxp(undefined,-250);
				break;
			case 5:
				result="+300 XP";
				self braxi\_rank::giverankxp(undefined,300);
				break;
			case 6:
				result="-100 XP";
				self braxi\_rank::giverankxp(undefined,-100);
				break;
			case 7:
				result="+350 XP";
				self braxi\_rank::giverankxp(undefined,350);
				break;
			case 8:
				result="-200 XP";
				self braxi\_rank::giverankxp(undefined,-200);
				break;
			case 9:
				result="+400 XP";
				self braxi\_rank::giverankxp(undefined,400);
				break;
			case 10:
				result="+250 XP";
				self braxi\_rank::giverankxp(undefined,250);
				break;
			case 11:
				result="+450 XP";
				self braxi\_rank::giverankxp(undefined,450);
				break;
			case 12:
				result="-250 XP";
				self braxi\_rank::giverankxp(undefined,-250);
				break;
			case 13:
				result="+200 XP";
				self braxi\_rank::giverankxp(undefined,200);
				break;
			case 14:
				result="-200 XP";
				self braxi\_rank::giverankxp(undefined,-200);
				break;
			case 15:
				result="+150 XP";
				self braxi\_rank::giverankxp(undefined,150);
				break;
			case 16:
				result="-150 XP";
				self braxi\_rank::giverankxp(undefined,-150);
				break;
			case 17:
				result="+300 XP";
				self braxi\_rank::giverankxp(undefined,300);
				break;
			case 18:
				result="-100 XP";
				self braxi\_rank::giverankxp(undefined,-100);
				break;
			case 19:
				result="+250 XP";
				self braxi\_rank::giverankxp(undefined,250);
				break;
			case 20:
				result="-50 XP";
				self braxi\_rank::giverankxp(undefined,-50);
				break;
			case 21:
				result="-50 XP";
				self braxi\_rank::giverankxp(undefined,-50);
				break;
			case 22:
				result="+250 XP";
				self braxi\_rank::giverankxp(undefined,250);
				break;
			case 23:
				result="+250 XP";
				self braxi\_rank::giverankxp(undefined,250);
				break;
			case 24:
				result="-250 XP";
				self braxi\_rank::giverankxp(undefined,-250);
				break;
			case 25:
				result="+300 XP";
				self braxi\_rank::giverankxp(undefined,300);
				break;
			case 26:
				result="-150 XP";
				self braxi\_rank::giverankxp(undefined,-150);
				break;
			case 27:
				result="+350 XP";
				self braxi\_rank::giverankxp(undefined,350);
				break;
			case 28:
				result="+350 XP";
				self braxi\_rank::giverankxp(undefined,350);
				break;
			case 29:
				result="+400 XP";
				self braxi\_rank::giverankxp(undefined,400);
				break;
			case 30:
				result="+250 XP";
				self braxi\_rank::giverankxp(undefined,250);
				break;
			case 31:
				result="+450 XP";
				self braxi\_rank::giverankxp(undefined,450);
				break;
			case 32:
				result="+400 XP";
				self braxi\_rank::giverankxp(undefined,400);
				break;
			case 33:
				result="+200 XP";
				self braxi\_rank::giverankxp(undefined,200);
				break;
			case 34:
				result="-50 XP";
				self braxi\_rank::giverankxp(undefined,-50);
				break;
			case 35:
				result="+150 XP";
				self braxi\_rank::giverankxp(undefined,150);
				break;
			case 36:
				result="-150 XP";
				self braxi\_rank::giverankxp(undefined,-150);
				break;
			case 37:
				result="+100 XP";
				self braxi\_rank::giverankxp(undefined,100);
				break;
			case 38:
				result="-100 XP";
				self braxi\_rank::giverankxp(undefined,-100);
				break;
			case 39:
				result="+50 XP";
				self braxi\_rank::giverankxp(undefined,50);
				break;
			case 40:
				result="-50 XP";
				self braxi\_rank::giverankxp(undefined,-50);
				break;
			case 41:
				result="-50 XP";
				self braxi\_rank::giverankxp(undefined,-50);
				break;
			case 42:
				result="-150 XP";
				self braxi\_rank::giverankxp(undefined,-150);
				break;
			case 43:
				result="+450 XP";
				self braxi\_rank::giverankxp(undefined,450);
				break;
			case 44:
				result="+450 XP";
				self braxi\_rank::giverankxp(undefined,450);
				break;
			case 45:
				result="+200 XP";
				self braxi\_rank::giverankxp(undefined,200);
				break;
			case 46:
				result="-200 XP";
				self braxi\_rank::giverankxp(undefined,-200);
				break;
			case 47:
				result="+150 XP";
				self braxi\_rank::giverankxp(undefined,150);
				break;
			case 48:
				result="+100 XP";
				self braxi\_rank::giverankxp(undefined,100);
				break;
			case 49:
				result="-100 XP";
				self braxi\_rank::giverankxp(undefined,-100);
				break;
			case 50:
				result="+50 XP";
				self braxi\_rank::giverankxp(undefined,50);
				break;
			case 51:
				result="-50 XP";
				self braxi\_rank::giverankxp(undefined,-50);
				break; 
			case 52:
				result="-100 XP";
				self braxi\_rank::giverankxp(undefined,-100);
				break;
			case 53:
				result="-50 XP";
				self braxi\_rank::giverankxp(undefined,-50);
				break;
			case 54:
				result="-250 XP";
				self braxi\_rank::giverankxp(undefined,-250);
				break;
			case 55:
				result="+300 XP";
				self braxi\_rank::giverankxp(undefined,300);
				break;
			case 56:
				result="-200 XP";
				self braxi\_rank::giverankxp(undefined,-200);
				break;
			case 57:
				result="+350 XP";
				self braxi\_rank::giverankxp(undefined,350);
				break;
			case 58:
				result="+100 XP";
				self braxi\_rank::giverankxp(undefined,100);
				break;
			case 59:
				result="+400 XP";
				self braxi\_rank::giverankxp(undefined,400);
				break;
			case 60:
				result="-200 XP";
				self braxi\_rank::giverankxp(undefined,-200);
				break;
			case 61:
				result="+450 XP";
				self braxi\_rank::giverankxp(undefined,450);
				break; 
			case 62:
				result="-100 XP";
				self braxi\_rank::giverankxp(undefined,-100);
				break;
			case 63:
				result="+200 XP";
				self braxi\_rank::giverankxp(undefined,200);
				break;
			case 64:
				result="-1500 XP";
				self braxi\_rank::giverankxp(undefined,-1500);
				break;
			case 65:
				result="-50 XP";
				self braxi\_rank::giverankxp(undefined,-50);
				break;
			case 66:
				result="-150 XP";
				self braxi\_rank::giverankxp(undefined,-150);
				break;
			case 67:
				result="+150 XP";
				self braxi\_rank::giverankxp(undefined,150);
				break;
			case 68:
				result="-100 XP";
				self braxi\_rank::giverankxp(undefined,-100);
				break;
			case 69:
				result="+50 XP";
				self braxi\_rank::giverankxp(undefined,50);
				break;
			case 70:
				result="-50 XP";
				self braxi\_rank::giverankxp(undefined,-50);
				break;
			case 71:
				result="-50 XP";
				self braxi\_rank::giverankxp(undefined,-50);
				break; 
			case 72:
				result="+200 XP";
				self braxi\_rank::giverankxp(undefined,200);
				break;
			case 73:
				result="+450 XP";
				self braxi\_rank::giverankxp(undefined,450);
				break;
			case 74:
				result="-200 XP";
				self braxi\_rank::giverankxp(undefined,-200);
				break;
			case 75:
				result="+200 XP";
				self braxi\_rank::giverankxp(undefined,200);
				break;
			case 76:
				result="-200 XP";
				self braxi\_rank::giverankxp(undefined,-200);
				break;
			case 77:
				result="-50 XP";
				self braxi\_rank::giverankxp(undefined,-50);
				break;
			case 78:
				result="+1000 XP";
				self braxi\_rank::giverankxp(undefined,1000);
				break;
			case 79:
				result="-100 XP";
				self braxi\_rank::giverankxp(undefined,-100);
				break;
			case 80:
				result="+50 XP";
				self braxi\_rank::giverankxp(undefined,50);
				break;
			case 81:
				result="+250 XP";
				self braxi\_rank::giverankxp(undefined,250);
				break; 
			case 82:
				result="+500 XP";
				self braxi\_rank::giverankxp(undefined,500);
				break;
			case 83:
				result="+250 XP";
				self braxi\_rank::giverankxp(undefined,250);
				break;
			case 84:
				result="-250 XP";
				self braxi\_rank::giverankxp(undefined,-250);
				break;
			case 85:
				result="+300 XP";
				self braxi\_rank::giverankxp(undefined,300);
				break;
			case 86:
				result="-300 XP";
				self braxi\_rank::giverankxp(undefined,-300);
				break;
			case 87:
				result="-50 XP";
				self braxi\_rank::giverankxp(undefined,-50);
				break;
			case 88:
				result="-350 XP";
				self braxi\_rank::giverankxp(undefined,-350);
				break;
			case 89:
				result="+400 XP";
				self braxi\_rank::giverankxp(undefined,400);
				break;
			case 90:
				result="-400 XP";
				self braxi\_rank::giverankxp(undefined,-400);
				break;
			case 91:
				result="+450 XP";
				self braxi\_rank::giverankxp(undefined,450);
				break; 
			case 92:
				result="-50 XP";
				self braxi\_rank::giverankxp(undefined,-50);
				break;
			case 93:
				result="+1000 XP";
				self braxi\_rank::giverankxp(undefined,1000);
				break;
			case 94:
				result="-200 XP";
				self braxi\_rank::giverankxp(undefined,-200);
				break;
			case 95:
				result="+150 XP";
				self braxi\_rank::giverankxp(undefined,150);
				break;
			case 96:
				result="-150 XP";
				self braxi\_rank::giverankxp(undefined,-150);
				break;
			case 97:
				result="-50 XP";
				self braxi\_rank::giverankxp(undefined,-50);
				break;
			case 98:
				result="-100 XP";
				self braxi\_rank::giverankxp(undefined,-100);
				break;
			case 99:
				result="+50 XP";
				self braxi\_rank::giverankxp(undefined,50);
				break;
			case 100:
				result="-50 XP";
				self braxi\_rank::giverankxp(undefined,-50);
				break;
			case 101:
				result="-200 XP";
				self braxi\_rank::giverankxp(undefined,-200);
				break;
			case 102:
				result="-50 XP";
				self braxi\_rank::giverankxp(undefined,-50);
				break;
			case 103:
				result="-50 XP";
				self braxi\_rank::giverankxp(undefined,-50);
				break;
			case 104:
				result="-250 XP";
				self braxi\_rank::giverankxp(undefined,-250);
				break;
			case 105:
				result="+300 XP";
				self braxi\_rank::giverankxp(undefined,300);
				break;
			case 106:
				result="-300 XP";
				self braxi\_rank::giverankxp(undefined,-300);
				break;
			case 107:
				result="+350 XP";
				self braxi\_rank::giverankxp(undefined,350);
				break;
			case 108:
				result="-50 XP";
				self braxi\_rank::giverankxp(undefined,-50);
				break;
			case 109:
				result="-400 XP";
				self braxi\_rank::giverankxp(undefined,-400);
				break;
			case 110:
				result="+450 XP";
				self braxi\_rank::giverankxp(undefined,450);
				break;
			case 111:
				result="+450 XP";
				self braxi\_rank::giverankxp(undefined,450);
				break;
			case 112:
				result="+250 XP";
				self braxi\_rank::giverankxp(undefined,250);
				break;
			case 113:
				result="+200 XP";
				self braxi\_rank::giverankxp(undefined,200);
				break;
			case 114:
				result="-200 XP";
				self braxi\_rank::giverankxp(undefined,-200);
				break;
			case 115:
				result="+150 XP";
				self braxi\_rank::giverankxp(undefined,150);
				break;
			case 116:
				result="-150 XP";
				self braxi\_rank::giverankxp(undefined,-150);
				break;
			case 117:
				result="+500 XP";
				self braxi\_rank::giverankxp(undefined,500);
				break;
			case 118:
				result="-100 XP";
				self braxi\_rank::giverankxp(undefined,-100);
				break;
			case 119:
				result="-50 XP";
				self braxi\_rank::giverankxp(undefined,-50);
				break;
			case 120:
				result="-50 XP";
				self braxi\_rank::giverankxp(undefined,-50);
				break;
			case 121:
				result="-50 XP";
				self braxi\_rank::giverankxp(undefined,-50);
				break;
			case 122:
				result="+250 XP";
				self braxi\_rank::giverankxp(undefined,250);
				break;
			case 123:
				result="+250 XP";
				self braxi\_rank::giverankxp(undefined,250);
				break;
			case 124:
				result="Jackpot";
				self.jackpot = true;
				self thread jackpot();
				break;
			case 125:
				result="+300 XP";
				self braxi\_rank::giverankxp(undefined,300);
				break;
			case 126:
				result="-150 XP";
				self braxi\_rank::giverankxp(undefined,-150);
				break;
			case 127:
				result="+350 XP";
				self braxi\_rank::giverankxp(undefined,350);
				break;
			case 128:
				result="+350 XP";
				self braxi\_rank::giverankxp(undefined,350);
				break;
			case 129:
				result="+400 XP";
				self braxi\_rank::giverankxp(undefined,400);
				break;
			case 130:
				result="+250 XP";
				self braxi\_rank::giverankxp(undefined,250);
				break;
			case 131:
				result="+450 XP";
				self braxi\_rank::giverankxp(undefined,450);
				break;
			case 132:
				result="+400 XP";
				self braxi\_rank::giverankxp(undefined,400);
				break;
			case 133:
				result="+200 XP";
				self braxi\_rank::giverankxp(undefined,200);
				break;
			case 134:
				result="-50 XP";
				self braxi\_rank::giverankxp(undefined,-50);
				break;
			case 135:
				result="+150 XP";
				self braxi\_rank::giverankxp(undefined,150);
				break;
			case 136:
				result="-150 XP";
				self braxi\_rank::giverankxp(undefined,-150);
				break;
			case 137:
				result="+100 XP";
				self braxi\_rank::giverankxp(undefined,100);
				break;
			case 138:
				result="-100 XP";
				self braxi\_rank::giverankxp(undefined,-100);
				break;
			case 139:
				result="+50 XP";
				self braxi\_rank::giverankxp(undefined,50);
				break;
			case 140:
				result="-50 XP";
				self braxi\_rank::giverankxp(undefined,-50);
				break;
			case 141:
				result="-50 XP";
				self braxi\_rank::giverankxp(undefined,-50);
				break;
			case 142:
				result="-150 XP";
				self braxi\_rank::giverankxp(undefined,-150);
				break;
			case 143:
				result="+450 XP";
				self braxi\_rank::giverankxp(undefined,450);
				break;
			case 144:
				result="+450 XP";
				self braxi\_rank::giverankxp(undefined,450);
				break;
			case 145:
				result="+200 XP";
				self braxi\_rank::giverankxp(undefined,200);
				break;
			case 146:
				result="-200 XP";
				self braxi\_rank::giverankxp(undefined,-200);
				break;
			case 147:
				result="+150 XP";
				self braxi\_rank::giverankxp(undefined,150);
				break;
			case 148:
				result="+100 XP";
				self braxi\_rank::giverankxp(undefined,100);
				break;
			case 149:
				result="-100 XP";
				self braxi\_rank::giverankxp(undefined,-100);
				break;
			case 150:
				result="+50 XP";
				self braxi\_rank::giverankxp(undefined,50);
				break;
			case 151:
				result="-50 XP";
				self braxi\_rank::giverankxp(undefined,-50);
				break; 
			case 152:
				result="-100 XP";
				self braxi\_rank::giverankxp(undefined,-100);
				break;
			case 153:
				result="-50 XP";
				self braxi\_rank::giverankxp(undefined,-50);
				break;
			case 154:
				result="-250 XP";
				self braxi\_rank::giverankxp(undefined,-250);
				break;
			case 155:
				result="+300 XP";
				self braxi\_rank::giverankxp(undefined,300);
				break;
			case 156:
				result="-200 XP";
				self braxi\_rank::giverankxp(undefined,-200);
				break;
			case 157:
				result="+350 XP";
				self braxi\_rank::giverankxp(undefined,350);
				break;
			case 158:
				result="+100 XP";
				self braxi\_rank::giverankxp(undefined,100);
				break;
			case 159:
				result="+400 XP";
				self braxi\_rank::giverankxp(undefined,400);
				break;
			case 160:
				result="-200 XP";
				self braxi\_rank::giverankxp(undefined,-200);
				break;
			case 161:
				result="+450 XP";
				self braxi\_rank::giverankxp(undefined,450);
				break; 
			case 162:
				result="-100 XP";
				self braxi\_rank::giverankxp(undefined,-100);
				break;
			case 163:
				result="+200 XP";
				self braxi\_rank::giverankxp(undefined,200);
				break;
			case 164:
				result="-1500 XP";
				self braxi\_rank::giverankxp(undefined,-1500);
				break;
			case 165:
				result="-50 XP";
				self braxi\_rank::giverankxp(undefined,-50);
				break;
			case 166:
				result="-150 XP";
				self braxi\_rank::giverankxp(undefined,-150);
				break;
			case 167:
				result="+150 XP";
				self braxi\_rank::giverankxp(undefined,150);
				break;
			case 168:
				result="-100 XP";
				self braxi\_rank::giverankxp(undefined,-100);
				break;
			case 169:
				result="+50 XP";
				self braxi\_rank::giverankxp(undefined,50);
				break;
			case 170:
				result="-50 XP";
				self braxi\_rank::giverankxp(undefined,-50);
				break;
			case 171:
				result="-50 XP";
				self braxi\_rank::giverankxp(undefined,-50);
				break; 
			case 172:
				result="+200 XP";
				self braxi\_rank::giverankxp(undefined,200);
				break;
			case 173:
				result="+450 XP";
				self braxi\_rank::giverankxp(undefined,450);
				break;
			case 174:
				result="-200 XP";
				self braxi\_rank::giverankxp(undefined,-200);
				break;
			case 175:
				result="+200 XP";
				self braxi\_rank::giverankxp(undefined,200);
				break;
			case 176:
				result="-200 XP";
				self braxi\_rank::giverankxp(undefined,-200);
				break;
			case 177:
				result="-50 XP";
				self braxi\_rank::giverankxp(undefined,-50);
				break;
			case 178:
				result="+1000 XP";
				self braxi\_rank::giverankxp(undefined,1000);
				break;
			case 179:
				result="-100 XP";
				self braxi\_rank::giverankxp(undefined,-100);
				break;
			case 180:
				result="+50 XP";
				self braxi\_rank::giverankxp(undefined,50);
				break;
			case 181:
				result="+250 XP";
				self braxi\_rank::giverankxp(undefined,250);
				break; 
			case 182:
				result="+500 XP";
				self braxi\_rank::giverankxp(undefined,500);
				break;
			case 183:
				result="+250 XP";
				self braxi\_rank::giverankxp(undefined,250);
				break;
			case 184:
				result="-250 XP";
				self braxi\_rank::giverankxp(undefined,-250);
				break;
			case 185:
				result="+300 XP";
				self braxi\_rank::giverankxp(undefined,300);
				break;
			case 186:
				result="-300 XP";
				self braxi\_rank::giverankxp(undefined,-300);
				break;
			case 187:
				result="-50 XP";
				self braxi\_rank::giverankxp(undefined,-50);
				break;
			case 188:
				result="-350 XP";
				self braxi\_rank::giverankxp(undefined,-350);
				break;
			case 189:
				result="+400 XP";
				self braxi\_rank::giverankxp(undefined,400);
				break;
			case 190:
				result="-400 XP";
				self braxi\_rank::giverankxp(undefined,-400);
				break;
			case 191:
				result="+450 XP";
				self braxi\_rank::giverankxp(undefined,450);
				break; 
			case 192:
				result="-50 XP";
				self braxi\_rank::giverankxp(undefined,-50);
				break;
			case 193:
				result="+1000 XP";
				self braxi\_rank::giverankxp(undefined,1000);
				break;
			case 194:
				result="-200 XP";
				self braxi\_rank::giverankxp(undefined,-200);
				break;
			case 195:
				result="+150 XP";
				self braxi\_rank::giverankxp(undefined,150);
				break;
			case 196:
				result="-150 XP";
				self braxi\_rank::giverankxp(undefined,-150);
				break;
			case 197:
				result="-50 XP";
				self braxi\_rank::giverankxp(undefined,-50);
				break;
			case 198:
				result="-100 XP";
				self braxi\_rank::giverankxp(undefined,-100);
				break;
			case 199:
				result="+50 XP";
				self braxi\_rank::giverankxp(undefined,50);
				break;
			case 200:
				result="-50 XP";
				self braxi\_rank::giverankxp(undefined,-50);
				break;
	
		}
		iprintln("^5Lottery^7: ^5"+self.name+"^7 got ^5"+result);
	}
}

/*lotterycountdown(time)
{
	if(!isdefined(time))
		time=30;

	for(i=0;i<time;i++)
		wait (30-i);

    self.cooldown=0;
    self.pers["lottery"]=false;
    self iprintln("^1VC'^3[admin]:^7 You can use ^1Lottery ^7again");
}*/

jackpot()
{
	self thread braxi\_mod::drawInformationSmall( 800, 0.8, 1, self.name+" won the Lottery Jackpot" );
	self thread braxi\_mod::drawInformationSmall( 800, 0.8, 1, self.name+" won the Lottery Jackpot" );
	if(self.jackpot==true)
	{
		self braxi\_rank::giverankxp(undefined,2000);
        self braxi\_rank::giverankxp(undefined,2000);
        self braxi\_rank::giverankxp(undefined,2000);
        self braxi\_rank::giverankxp(undefined,2000);
        self braxi\_rank::giverankxp(undefined,2000);
        self braxi\_rank::giverankxp(undefined,2000);
        self braxi\_rank::giverankxp(undefined,2000);
        self braxi\_rank::giverankxp(undefined,2000);
        self braxi\_rank::giverankxp(undefined,2000);
        self braxi\_rank::giverankxp(undefined,2000);
		logPrint("Lotto Jackpot: "+self.name+" (Guid:"+self.guid+")\n");
		self.jackpot=false;
	}
}



premiumLottery()
{
	result=undefined;
	vc=randomfloatrange(0.0,100.0); //1%=5000, 9%=2500,30%=2500,60%=1000
	if(vc <= 1.0)
	{
		result = "+5000 XP";
		self braxi\_rank::giverankxp(undefined,5000);
	}
	else if(vc <= 10.0 && vc > 1.0)
	{
		result = "+2500 XP";
		self braxi\_rank::giverankxp(undefined,2500);
	}
	else if(vc <= 40.0 && vc > 10.0)
	{
		result = "+1500 XP";
		self braxi\_rank::giverankxp(undefined,1500);
	}
	else if(vc > 40.0)
	{
		result = "+1000 XP";
		self braxi\_rank::giverankxp(undefined,1000);
	}
	else
		result = "error?";

	iprintln("^5Premium Lottery^7: ^5"+self.name+"^7 got ^5"+result);
}