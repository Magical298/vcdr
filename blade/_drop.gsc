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

randomDrop()
{
	self endon("disconnect");
	switch(randomintrange(0,100))
	{
		case 0:
			self thread xpDrop(25);
			break;
		case 1:
			self thread xpDrop(10);
			break;
		case 2:
			self thread xpDrop(20);
			break;
		case 3:
			self thread xpDrop(50);
			break;
		case 4:
			self thread xpDrop(35);
			break;
		case 5:
			self thread xpDrop(40);
			break;
		case 6:
			self thread xpDrop(100);
			break;
		case 7:
			self thread xpDrop(120);
			break;
		case 8:
			self thread xpDrop(80);
			break;
		case 9:
			self thread xpDrop(65);
			break;
		case 10:
			self thread xpDrop(150);
			break;
		case 11:
			self thread jewelDrop(1);
			break;
		case 12:
			self thread xpDrop(200);
			break;
		case 13:
			self thread xpDrop(250);
			break;
		case 14:
			self thread xpDrop(210);
			break;
		case 15:
			self thread xpDrop(120);
			break;
		case 16:
			self thread xpDrop(105);
			break;
		case 17:
			self thread xpDrop(5);
			break;
		case 18:
			self thread xpDrop(85);
			break;
		case 19:
			self thread xpDrop(90);
			break;
		case 20:
			self thread xpDrop(25);
			break;
		case 21:
			self thread xpDrop(10);
			break;
		case 22:
			self thread jewelDrop(1);
			break;
		case 23:
			self thread xpDrop(50);
			break;
		case 24:
			self thread xpDrop(35);
			break;
		case 25:
			self thread xpDrop(40);
			break;
		case 26:
			self thread xpDrop(100);
			break;
		case 27:
			self thread xpDrop(120);
			break;
		case 28:
			self thread xpDrop(80);
			break;
		case 29:
			self thread xpDrop(65);
			break;
		case 30:
			self thread jewelDrop(3);			
			break;
		case 31:
			self thread xpDrop(180);
			break;
		case 32:
			self thread xpDrop(200);
			break;
		case 33:
			self thread xpDrop(250);
			break;
		case 34:
			self thread xpDrop(210);
			break;
		case 35:
			self thread xpDrop(120);
			break;
		case 36:
			self thread xpDrop(105);
			break;
		case 37:
			self thread xpDrop(5);
			break;
		case 38:
			self thread xpDrop(85);
			break;
		case 39:
			self thread xpDrop(90);
			break;
		case 40:
			self thread vcpDrop(10);
			break;
		case 41:
			self thread vcpDrop(2);
			break;
		case 42:
			self thread vcpDrop(5);
			break;
		case 43:
			self thread vcpDrop(3);
			break;
		case 44:
			self thread vcpDrop(1);
			break;
		case 45:
			self thread vcpDrop(4);
			break;
		case 46:
			self thread vcpDrop(10);
			break;
		case 47:
			self thread vcpDrop(5);
			break;
		case 48:
			self thread vcpDrop(1);
			break;
		case 49:
			self thread vcpDrop(1);
			break;
		case 50:
			self thread jewelDrop(1);
			break;
		case 51:
			self thread xpDrop(10);
			break;
		case 52:
			self thread xpDrop(20);
			break;
		case 53:
			self thread xpDrop(50);
			break;
		case 54:
			self thread xpDrop(35);
			break;
		case 55:
			self thread xpDrop(40);
			break;
		case 56:
			self thread jewelDrop(2);
			break;
		case 57:
			self thread xpDrop(120);
			break;
		case 58:
			self thread xpDrop(80);
			break;
		case 59:
			self thread xpDrop(65);
			break;
		case 60:
			self thread xpDrop(150);
			break;
		case 61:
			self thread xpDrop(180);
			break;
		case 62:
			self thread xpDrop(200);
			break;
		case 63:
			self thread xpDrop(250);
			break;
		case 64:
			self thread jewelDrop(1);
			break;
		case 65:
			self thread xpDrop(120);
			break;
		case 66:
			self thread xpDrop(105);
			break;
		case 67:
			self thread xpDrop(5);
			break;
		case 68:
			self thread xpDrop(85);
			break;
		case 69:
			self thread xpDrop(90);
			break;
		case 70:
			self thread xpDrop(25);
			break;
		case 71:
			self thread xpDrop(10);
			break;
		case 72:
			self thread xpDrop(20);
			break;
		case 73:
			self thread xpDrop(50);
			break;
		case 74:
			self thread jewelDrop(3);
			break;
		case 75:
			self thread xpDrop(40);
			break;
		case 76:
			self thread xpDrop(100);
			break;
		case 77:
			self thread xpDrop(120);
			break;
		case 78:
			self thread jewelDrop(1);
			break;
		case 79:
			self thread xpDrop(65);
			break;
		case 80:
			self thread xpDrop(150);
			break;
		case 81:
			self thread xpDrop(180);
			break;
		case 82:
			self thread xpDrop(200);
			break;
		case 83:
			self thread xpDrop(250);
			break;
		case 84:
			self thread jewelDrop(5);
			break;
		case 85:
			self thread xpDrop(120);
			break;
		case 86:
			self thread xpDrop(105);
			break;
		case 87:
			self thread xpDrop(5);
			break;
		case 88:
			self thread xpDrop(85);
			break;
		case 89:
			self thread xpDrop(90);
			break;
		case 90:
			self thread jewelDrop(1);
			break;
		case 91:
			self thread vcpDrop(2);
			break;
		case 92:
			self thread vcpDrop(5);
			break;
		case 93:
			self thread vcpDrop(3);
			break;
		case 94:
			self thread vcpDrop(1);
			break;
		case 95:
			self thread vcpDrop(4);
			break;
		case 96:
			self thread vcpDrop(10);
			break;
		case 97:
			self thread vcpDrop(5);
			break;
		case 98:
			self thread vcpDrop(1);
			break;
		case 99:
			self thread vcpDrop(1);
			break;
		case 100:
			self thread jewelDrop(3);
			break;
	}
}

xpDrop(xp)
{
	self braxi\_rank::giverankxp(undefined,xp);
	self iprintlnbold("^5"+xp+" XP^7 dropped");
}

vcpDrop(vcp)
{
	//self blade\_credits::claimReward(vcp);
	self iprintlnbold("^5"+vcp+" VCP^7 dropped");
}

jewelDrop(jewel)
{
	pstat = self getstat(2392)+jewel;
	self setstat(2392,pstat);

	if(jewel==1)
		self iprintlnbold("^51 Jewel^7 Earned");
	else 
		self iprintlnbold("^5"+jewel+" Jewels^7 Earned");
}