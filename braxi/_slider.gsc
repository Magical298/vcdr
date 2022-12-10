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
#include maps\mp\gametypes\_hud_util;

_rtd(text)
{
    rtd=createText("default",1.5,"","",-250,120,1,10,text);

    rtd.alignX = "left";
	rtd.alignY = "top";
	rtd.horzAlign = "left";
    rtd.vertAlign = "top";

	rtd welcomeMove(0.25,7,undefined);
	wait 6;
	rtd welcomeMove(0.25,-250,undefined);
	wait 1;
	rtd destroy();
}

_rtdresult(text)
{
    rtd2=createText("default",1.5,"","",-250,140,1,10,text);
    
    rtd2.alignX = "left";
	rtd2.alignY = "top";
	rtd2.horzAlign = "left";
    rtd2.vertAlign = "top";

	rtd2 welcomeMove(0.25,7,undefined);
	wait 3;
	rtd2 welcomeMove(0.25,-250,undefined);
	wait 1;
	rtd2 destroy();
}

_rtdresult2(text)
{
    rtd2=createText("default",1.5,"","",-250,250,1,10,text);
    
    rtd2.alignX = "left";
	rtd2.alignY = "top";
	rtd2.horzAlign = "left";
    rtd2.vertAlign = "top";

	rtd2 welcomeMove(0.25,7,undefined);
	wait 3;
	rtd2 welcomeMove(0.25,-250,undefined);
	wait 1;
	rtd2 destroy();
}

oben(player,text1)
{
	//player endon("death");
	player endon("disconnect");
	links = createText("default",1.8,"","",-600,-70,1,10,text1);
	//links setPulseFX(200,4900,600);
	links welcomeMove(1,-90);
	wait 1.1;
	links welcomeMove(6,90);
	wait 6;
	links welcomeMove(3,1000);
	wait 3;
	links destroy();
}

unten(player,text2)
{
	//player endon("death");
	player endon("disconnect");
	rechts = createText("default",1.8,"","",600,-50,1,10,text2);
	rechts.alignX = "right";
	//rechts setPulseFX(200,4900,600);
	rechts welcomeMove(1,90);
	wait 1.1;
	rechts welcomeMove(4,-90);
	wait 4;
	rechts welcomeMove(3,-1000);
	wait 3;
	rechts destroy();
}

unten2(player,text2)
{
	//player endon("death");
	player endon("disconnect");
	rechts = createText("default",1.8,"","",100,-50,1,10,text2);
	rechts.alignX = "left";
	rechts setPulseFX(200,4900,600);
	rechts welcomeMove(4,-80);
	wait 4;
	rechts welcomeMove(3,-990);
	wait 3;
	rechts welcomeMove(3,-1293.33);
	wait 1;
	rechts setPulseFX(0,0,0);
	rechts destroy();
}

unten3(player,text3)
{
//player endon("death");
player endon("disconnect");
rechts = createText("default",1.8,"","",100,-50,1,10,text3);
rechts.alignX = "right";
rechts setPulseFX(90,4900,3000);
rechts welcomeMove(1,500);
wait 1.1;
rechts welcomeMove(4,100);
wait 4;
rechts welcomeMove(3,-1000);
wait 3;
rechts destroy();
}

welcomeMove(time,x,y)
{
	self moveOverTime(time);
	if(isDefined(x))
		self.x = x;
		
	if(isDefined(y))
		self.y = y;
}

createText(font,fontscale,align,relative,x,y,alpha  ,sort,text)
{
	hudText = createFontString(font,fontscale);
	hudText setPoint(align,relative,x,y);
	hudText.alpha = alpha;
	hudText.sort = sort;
	hudText.glowalpha=1;
	hudText.glowcolor=level.randomcolor;
	hudText setText(text);
	return hudText;
}

//Special Slider 

madebyduff( start_offset, movetime, mult, text ) 
{
	start_offset *= mult;
	hud = schnitzel( "center", 0.1, start_offset, -130 );
	hud setText( text );
	hud moveOverTime( movetime );
	hud.x = 0;
	wait( movetime );
	wait( 3 );
	setDvar( "byduff", "0" );
	hud moveOverTime( movetime );
	hud.x = start_offset * -1;
	wait movetime;
	hud destroy();
}

madebyduff2( start_offset, movetime, mult, text ) 
{
	start_offset *= mult;
	hud = schnitzel( "center", 0.1, start_offset, -105 );
	hud setText( text );
	hud moveOverTime( movetime );
	hud.x = 0;
	wait( movetime );
	wait( 3 );
	setDvar( "byduff2", "0" );
	hud moveOverTime( movetime );
	hud.x = start_offset * -1;
	wait movetime;
	hud destroy();
}

schnitzel( align, fade_in_time, x_off, y_off ) 
{
	hud = newHudElem();
    	hud.foreground = true;
	hud.x = x_off;
	hud.y = y_off;
	hud.alignX = align;
	hud.alignY = "middle";
	hud.horzAlign = align;
	hud.vertAlign = "middle";
 	hud.fontScale = 1.8;
	hud.color = (1, 1, 1);
	hud.font = "objective";
	hud.glowColor = level.randomcolor;
	hud.glowAlpha = 1;
	hud.alpha = 1;
	hud fadeovertime( fade_in_time );
	hud.alpha = 1;
	hud.hidewheninmenu = true;
	hud.sort = 10;
	return hud;
}

life1(player,textlife1,glowColor)
{
	//player endon("death");
	player endon("disconnect");
	links = createText("objective",1.5,"","",-600,-70,1,10,textlife1);
	links.glowAlpha = 1;
	links.glowColor = glowColor;
	links setPulseFX(90,4900,3000);
	links welcomeMove(1,-90);
	wait 1.1;
	links welcomeMove(6,90);
	wait 6;
	links welcomeMove(3,1000);
	wait 3;
	links destroy();
}

life2(player,textlife2,glowColor)
{
	//player endon("death");
	player endon("disconnect");
	links = createText("objective",1.5,"","",-600,-50,1,10,textlife2);
	links.glowAlpha = 1;
	links.glowColor = glowColor;
	links setPulseFX(90,4900,3000);
	links welcomeMove(1,-90);
	wait 1.1;
	links welcomeMove(6,90);
	wait 6;
	links welcomeMove(3,1000);
	wait 3;
	links destroy();
}

life3(player,textlife3,glowColor)
{
	//player endon("death");
	player endon("disconnect");
	links = createText("objective",1.5,"","",-600,-30,1,10,textlife3);
	links.glowAlpha = 1;
	links.glowColor = glowColor;
	links setPulseFX(90,4900,3000);
	links welcomeMove(1,-90);
	wait 1.1;
	links welcomeMove(6,90);
	wait 6;
	links welcomeMove(3,1000);
	wait 3;
	links destroy();
}

life4(player,textlife4,glowColor)
{
	//player endon("death");
	player endon("disconnect");
	links = createText("objective",1.5,"","",-600,-10,1,10,textlife4);
	links.glowAlpha = 1;
	links.glowColor = glowColor;
	links setPulseFX(90,4900,3000);
	links welcomeMove(1,-90);
	wait 1.1;
	links welcomeMove(6,90);
	wait 6;
	links welcomeMove(3,1000);
	wait 3;
	links destroy();
}

life5(player,textlife5,glowColor)
{
	//player endon("death");
	player endon("disconnect");
	rechts = createText("objective",1.5,"","",1000,-70,1,10,textlife5);
	rechts.alignX = "right";
	rechts.glowAlpha = 1;
	rechts.glowColor = glowColor;
	rechts setPulseFX(90,4900,3000);
	rechts welcomeMove(1,500);
	wait 1.1;
	rechts welcomeMove(4,100);
	wait 4;
	rechts welcomeMove(3,-1000);
	wait 3;
	rechts destroy();
}

life6(player,textlife6,glowColor)
{
	//player endon("death");
	player endon("disconnect");
	rechts = createText("objective",1.5,"","",1000,-50,1,10,textlife6);
	rechts.alignX = "right";
	rechts.glowAlpha = 1;
	rechts.glowColor = glowColor;
	rechts setPulseFX(90,4900,3000);
	rechts welcomeMove(1,500);
	wait 1.1;
	rechts welcomeMove(4,100);
	wait 4;
	rechts welcomeMove(3,-1000);
	wait 3;
	rechts destroy();
}

life7(player,textlife7,glowColor)
{
	//player endon("death");
	player endon("disconnect");
	rechts = createText("objective",1.5,"","",1000,-30,1,10,textlife7);
	rechts.alignX = "right";
	rechts.glowAlpha = 1;
	rechts.glowColor = glowColor;
	rechts setPulseFX(90,4900,3000);
	rechts welcomeMove(1,500);
	wait 1.1;
	rechts welcomeMove(4,100);
	wait 4;
	rechts welcomeMove(3,-1000);
	wait 3;
	rechts destroy();
}

life8(player,textlife8,glowColor)
{
	//player endon("death");
	player endon("disconnect");
	rechts = createText("objective",1.5,"","",1000,-10,1,10,textlife8);
	rechts.alignX = "right";
	rechts.glowAlpha = 1;
	rechts.glowColor = glowColor;
	rechts setPulseFX(90,4900,3000);
	rechts welcomeMove(1,500);
	wait 1.1;
	rechts welcomeMove(4,100);
	wait 4;
	rechts welcomeMove(3,-1000);
	wait 3;
	rechts destroy();
}

snake1(player,text1,glowColor)
{
	//player endon("death");
	player endon("disconnect");
	links = createText("objective",1.7,"","",-600,-70,1,10,text1);
	links.glowAlpha = 1;
	links.glowColor = level.randomcolor;
	//links setPulseFX(200,4900,600);
	links welcomeMove(1,-90);
	wait 1.1;
	links welcomeMove(6,90);
	wait 6;
	links welcomeMove(3,1000);
	wait 3;
	links destroy();
}

snake2(player,text2,glowColor)
{
	//player endon("death");
	player endon("disconnect");
	rechts = createText("objective",1.7,"","",600,-50,1,10,text2);
	rechts.alignX = "right";
	rechts.glowAlpha = 1;
	rechts.glowColor = level.randomcolor;
	rechts welcomeMove(1,90);
	wait 1.1;
	rechts welcomeMove(4,-90);
	wait 4;
	rechts welcomeMove(3,-1000);
	wait 3;
	rechts destroy();
}


// Re-Edited DuffMan Slider by Blade 
messageSlider(msg)
{
	if(getdvar("byduff")=="0")
	{
		setdvar("byduff","1");
		thread madebyduff(800,0.8,-1,msg);
		thread madebyduff(800,0.8,1,msg);
	}
	else if(getdvar("byduff")!="0" && getdvar("byduff2")=="0")
	{
		setdvar("byduff2","1");
		thread madebyduff2(800,0.8,-1,msg);
		thread madebyduff2(800,0.8,1,msg);
	}
}