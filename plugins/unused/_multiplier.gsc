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
	precacheshader("dtimer_6");

	thread monitorevent();
	thread hud();
}

monitorevent()
{
	for(;;)
	{
		wait 3;
		level.valid_amount=countvalidteam();
		level verifyamount();
	}
}

countvalidteam()
{
	p=getallplayers();
	valid=0;

	for(i=0;i<p.size;i++)
	{
		if(p[i].pers["team"]=="allies" || p[i].pers["team"]=="axis" || p[i].pers["team"]=="spectator")
			valid+=1;
	}
	return valid;
}

verifyamount()
{
	if(level.valid_amount>=2)
	{
		if(isdefined(level.hud_xpevent[0]))
			level.hud_xpevent[0] setText("XP BOOST >> ^5X3");
		thread setmultiplier("x3");
	}
	else if(level.valid_amount<2)
	{
		if(isdefined(level.hud_xpevent[0]))
			level.hud_xpevent[0] setText("XP BOOST: ^5"+level.valid_amount+"/5");
		thread setmultiplier("x1");
	}
}

setmultiplier(what)
{
	amount=undefined;
	switch(what)
	{
		case "x1":	amount=1;	break;
		case "x2":	amount=2;	break;
		case "x3":	amount=3;	break;
		case "x4":	amount=4;	break;
	}
	wait .05;

	braxi\_rank::registerScoreInfo( "kill", (200*amount) );
	braxi\_rank::registerScoreInfo( "headshot", (300*amount) );
	braxi\_rank::registerScoreInfo( "melee", (250*amount) );
	braxi\_rank::registerScoreInfo( "activator", (300*amount) );
	braxi\_rank::registerScoreInfo( "trap_activation", (50*amount) );
	braxi\_rank::registerScoreInfo( "jumper_died", (60*amount) );
	braxi\_rank::registerScoreInfo( "win", (20*amount) );
	braxi\_rank::registerScoreInfo( "loss", (10*amount) );
	braxi\_rank::registerScoreInfo( "tie", (25*amount) );
}

Hud()
{
	if(!isdefined(level.hud_xpevent))
		level.hud_xpevent = [];

	wait 3;

 	level.hud_xpevent[0] = newHudElem();
	level.hud_xpevent[0].x = 0;
	level.hud_xpevent[0].y = 80;
	level.hud_xpevent[0].alignx = "center";
	level.hud_xpevent[0].aligny = "top";
	level.hud_xpevent[0].horzalign = "center";
	level.hud_xpevent[0].vertalign = "top";
	level.hud_xpevent[0].sort = 1002;
	level.hud_xpevent[0].alpha = 1;
	level.hud_xpevent[0].glowalpha = 1;
	level.hud_xpevent[0].glowcolor = level.randomcolor;
	level.hud_xpevent[0].fontscale = 1.4;
	level.hud_xpevent[0].foreground = false;
	level.hud_xpevent[0].hidewheninmenu = true;
	
	level.hud_xpevent[1] = newHudElem();
	level.hud_xpevent[1].x = 0;
	level.hud_xpevent[1].y = 30;
	level.hud_xpevent[1].alignx = "center";
	level.hud_xpevent[1].aligny = "top";
	level.hud_xpevent[1].horzalign = "center";
	level.hud_xpevent[1].vertalign = "top";
	level.hud_xpevent[1].sort = 1001;
	level.hud_xpevent[1] setShader("dtimer_6", 150, 70);
	level.hud_xpevent[1].alpha = 0.5;
	level.hud_xpevent[1].foreground = false;
	level.hud_xpevent[1].hidewheninmenu = true;

	fader(level.hud_xpevent[0],1,2);
	fader(level.hud_xpevent[1],0.5,2);
	
	wait 8;

	fader(level.hud_xpevent[0],0,2);
	fader(level.hud_xpevent[1],0,2);
	
	wait 2.5;

	level.hud_xpevent[0] destroy();
	level.hud_xpevent[1] destroy();
}

fader(hud, alpha, time)
{
    hud fadeOverTime(time); 
    hud.alpha = alpha;
}
