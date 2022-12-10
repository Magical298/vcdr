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

main()
{
	players = getAllPlayers();
	for( i = 0; i < players.size; i++ )
	{
		players[i] closeMenu();
		players[i] closeInGameMenu();
	}

	level.creditTime = 6;
	braxi\_common::cleanScreen();

	thread show_credit_title("^5Vistic^7 DeathRun Creators",2,-150,50);
	thread show_credit_title("^5Vistic^7 Graphic Artist",2,150,50);
	wait .3;
	thread show_credit_left("Blade - Legend",1.4,-150,70);
	thread show_credit_right("Niko",1.4,150,70);
	wait .5;
	thread show_credit_title("Characters Rigger",2,-150,100);
	thread show_credit_title("Effects Creator",2,150,100);
	wait .3;
	thread show_credit_left("Fox",1.4,-150,120);
	//thread show_credit_left("ERIK",1.4,-150,140);
	thread show_credit_right("Sheep Wizard",1.4,150,120);
	thread show_credit_right("Legend",1.4,150,140);
	thread show_credit_right("Blade",1.4,150,160);
	thread show_credit_right("Fox",1.4,150,180);
	wait .5;
	thread show_credit_title("^5Vistic^7 Mappers",2,0,200);
	wait .3;
	thread show_credit_left("Blade",1.4,-150,220);
	thread show_credit_left("Sam.",1.4,-150,240);
	thread show_credit_left("Fox",1.4,-150,260);
	thread show_credit_left("Wingzor",1.4,-150,280);
	thread show_credit_left("Koling",1.4,-150,300);
	thread show_credit_right("Icomar",1.4,150,220);
	thread show_credit_right("DazE",1.4,150,240);
	thread show_credit_right("Legend",1.4,150,260);
	thread show_credit_right("Asunarry",1.4,150,280);
	thread show_credit_right("Lixfe",1.4,150,300);
	wait .5;
	thread show_credit_title("Special Thanks",2,0,340);
	wait .3;
	thread show_credit_left("BraXi",1.4,-150,360);
	thread show_credit_left("Scobalula",1.4,-150,380);
	thread show_credit_left("Thomas cat",1.4,-150,400);
	thread show_credit_left("DTZxPorter",1.4,-150,420);
	thread show_credit_right("^5Vistic^7 Community",1.4,150,360);

	wait level.creditTime + 4;
}

show_credit_title(text,scale,x,y)
{
	end_text = newHudElem();
	end_text.font = "default";
	end_text.fontScale = scale;
	end_text SetText(text);
	end_text.alignX = "center";
	end_text.alignY = "top";
	end_text.horzAlign = "center";
	end_text.vertAlign = "top";
	end_text.x = x;
	end_text.y = y;
	end_text.sort = -1; 
	end_text.foreground = true;
	end_text.alpha = 0;
	end_text.glowColor = level.randomcolor;
	end_text.glowAlpha = 1;
	end_text fadeOverTime(2);
	end_text.alpha = 1;
	wait level.creditTime;
	end_text fadeOverTime(2);
	end_text.alpha = 0;
	wait 2;
	end_text destroy();
}

show_credit_left(text,scale,x,y)
{
	end_text = newHudElem();
	end_text.font = "default";
	end_text.fontScale = scale;
	end_text SetText(text);
	end_text.alignX = "center";
	end_text.alignY = "top";
	end_text.horzAlign = "center";
	end_text.vertAlign = "top";
	end_text.x = -640;
	end_text.y = y;
	end_text.sort = -1; 
	end_text.foreground = true;
	end_text.alpha = 0;
	end_text.glowColor = level.randomcolor;
	end_text.glowAlpha = 1;
	end_text moveOverTime(2);
	end_text.alpha = 1;
	end_text.x = x;
	wait level.creditTime;
	end_text fadeOverTime(2);
	end_text.alpha = 0;
	wait 2;
	end_text destroy();
}

show_credit_right(text,scale,x,y)
{
	end_text = newHudElem();
	end_text.font = "default";
	end_text.fontScale = scale;
	end_text SetText(text);
	end_text.alignX = "center";
	end_text.alignY = "top";
	end_text.horzAlign = "center";
	end_text.vertAlign = "top";
	end_text.x = 640;
	end_text.y = y;
	end_text.sort = -1; 
	end_text.foreground = true;
	end_text.alpha = 0;
	end_text.glowColor = level.randomcolor;
	end_text.glowAlpha = 1;
	end_text moveOverTime(2);
	end_text.alpha = 1;
	end_text.x = x;
	wait level.creditTime;
	end_text fadeOverTime(2);
	end_text.alpha = 0;
	wait 2;
	end_text destroy();
}