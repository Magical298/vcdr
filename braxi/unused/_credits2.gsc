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
	Created by Sheep Wizard

	Original Files: BraXi

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

	thread showCredit( "Mod created by", 2, -150, 50 );
	wait 0.3;
	thread showCredit( "Artwork by", 2, -150, 100 );
	wait 0.3;
	thread showCredit( "Effects by", 2, 150, 50 );
	wait 0.3;
	thread showCredit( "Characters by", 2, 150, 100 );
	wait 1.5;
	thread showCredit( "Blade", 1.4, -150, 70 );
	wait 0.3;
	thread showCredit( "Niko", 1.4, -150, 120 );
	wait 0.3;
	thread showCredit( "Aria", 1.4, -150, 140 );
	wait 0.3;
	thread showCredit( "Sheep Wizard", 1.4, 150, 70 );
	wait 0.3;
	thread showCredit( "ERIK", 1.4, 150, 120 );
	wait 1.5;
	thread showCredit( "Vistic Mappers", 2, 0, 200 );
	wait 0.3;
	thread showCredit( "Icomar", 1.4, 0, 220 );
	wait 0.3;
	thread showCredit( "Sam.", 1.4, 0, 240 );
	wait 0.3;
	thread showCredit( "Glen", 1.4, 0, 260 );
	wait 0.3;
	thread showCredit( "Erik", 1.4, 0, 280 );
	wait 0.3;
	thread showCredit( "Legend", 1.4, 0, 300 );
	wait 0.3;
	thread showCredit( "TheLixfe", 1.4, 0, 320 );
	wait 0.3;
	thread showCredit( "Wingzor", 1.4, 0, 340 );
	wait 0.3;
	thread showCredit( "Asu", 1.4, 0, 360 );
	wait 1.5;
	thread showCredit( "Special Thanks", 2, 0, 400 );
	wait 0.3;
	thread showCredit( "BraXi", 1.6, 0, 425 );
	wait 4;
	thread showCredit("Thanks for playing ^5VC'^7 Deathrun",2.2,0,200);
	wait 0.3;
	
	wait level.creditTime + 1;
}


showCredit( text, scale, x, y )
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