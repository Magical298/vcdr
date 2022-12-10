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
			BraXi #????

	Design & Textures:
			Niko #2926
            EphNey #1431

    Character & Weapon Assets:
            Fox.#0001
            Magical.#9137

	Vistic Clan ©
*/

/*
    // ====== Part for Queue Plugin ========
    if(!plugins\_queue::checkQueueRoom(who))
        continue;
	// =====================================
*/

init()
{
    level.queue_list = [];
    level.queue_enter = 0;
    level.queue_room = false;
    level.queue_disabled = false;

    thread create_order();
    thread queue_hud();
}

create_order()
{
    trig = getentarray("endmap_trig","targetname");
    if(!trig.size || trig.size > 1)
    {
        iprintln("Endmap Trigger is missing (^5"+getdvar("mapname")+"^7) Queue disabled");
        level.queue_disabled = true;
		return;
    }
    level.vc_queue_trig = trig[0];
    createTrigFx(level.vc_queue_trig,undefined);

    while(1)
    {
        found = false;
        level.vc_queue_trig waittill("trigger",who);

        for(i=level.queue_enter;i<level.queue_list.size;i++)
        {
            if(level.queue_list[i].guid == who.guid)
                found = true;
        }

        if(found)
            continue;

        if(isDefined(who.ghost) && who.ghost)
	    {
	        who Suicide();
			who iprintlnbold( "^5You've^7 finished the Map in ^5GhostRun" );

			who braxi\_missions::process_challenge( "ch_ghost" ); // Finish a Map 30 Times while being in Train Mode

	        continue;
	    }

	    if( who.pers["team"] == "axis" )
	    	continue;

        level.queue_list[level.queue_list.size] = who;

		who iprintlnbold("Queue Place: ^9"+level.queue_list.size);
        who thread onQueueDeath();
    }
}

queue_hud()
{
    level endon("round_ended");
    level endon("game over");

    level waittill("round_started");

    thread kill_queue_huds();

    if(!isdefined(level.queue_hud))
        level.queue_hud = [];

    level.queue_hud[0] = huds(5,5,"default",1.4);
    level.queue_hud[0].label = &"^7Queue:\n&&1";

   /* level.queue_hud[1] = huds(5,5,"default",1.4);
    level.queue_hud[1].label = &"&&1";*/
	
	string = "";

    while(game["state"] == "playing")
    {
       /* if(isdefined(level.queue_list[level.queue_enter]))
        {
            level.queue_hud[0].alpha = 1;
            level.queue_hud[0] settext("^7"+level.queue_list[level.queue_enter].name);
        }
        else 
            level.queue_hud[0].alpha = 0;

        if(queueList() != "")
        {
            level.queue_hud[1].alpha = 1;
            level.queue_hud[1] settext(queueList());
        }
        else 
            level.queue_hud[1].alpha = 0;*/

		if(isdefined(level.queue_list[level.queue_enter]))
		{
			string = "^5"+level.queue_list[level.queue_enter].name+"^7";
			if(queueList() != "")
				string = (string + queueList());

			wait .5;
			level.queue_hud[0].alpha = 1;
			level.queue_hud[0] settext(string);
		}
		else 
			level.queue_hud[0].alpha = 0;

        wait 1;
    }

    if(isdefined(level.queue_hud))
    {
        for(i=0;i<level.queue_hud.size;i++)
        {
            if(isdefined(level.queue_hud[i]))
                level.queue_hud[i] destroy();
        }
    }
}

queueList()
{
    list = "";

    for(i=level.queue_enter+1; i<level.queue_enter+4; i++)
    {
        if(isdefined(level.queue_list[i]))
            list += ", "+level.queue_list[i].name;
    }
    return list;
}

kill_queue_huds()
{
    level common_scripts\utility::waittill_any("round_ended","game over");

    if(isdefined(level.queue_hud))
    {
        for(i=0;i<level.queue_hud.size;i++)
        {
            if(isdefined(level.queue_hud[i]))
                level.queue_hud[i] destroy();
        }
    }
}

huds(x, y, font, fontscale)
{
    quehuds = NewHudElem();
    quehuds.alignX = "left";
    quehuds.alignY = "top";
    quehuds.horzAlign = "left";
    quehuds.vertAlign = "top";
    quehuds.alpha = 1;
    quehuds.archived = 0;
    quehuds.foreground = false;
    quehuds.hidewheninmenu = true;
    quehuds.x = x;
    quehuds.y = y;
    quehuds.font = font;
    quehuds.fontscale = fontscale;
    quehuds.glowalpha = 1;
    quehuds.glowcolor = level.randomcolor;
    return quehuds;
}

onRoomDeath()
{
	while( isAlive( self ) && isDefined( self ) )
		wait 0.1;

	level.queue_enter++;
	level.queue_room = false;
}

onQueueDeath()
{
	self endon("romm_enter_plugin");

	id = self.guid;

	while( isAlive( self ) && isDefined( self ) )
		wait 0.1;

	//find players position in queue array and remove it
	for(i = level.queue_enter; i<level.queue_list.size; i++)
	{
		if(level.queue_list[i].guid == id)
		{
			level.queue_list = removeFromArray(level.queue_list, i);
			return;
		}
	}
}

removeFromArray(b, num)
{
	temp = [];
	for(i=0; i<b.size; i++)
	{
		if(i != num)
			temp[temp.size] = b[i];
	}
	return temp;
}

checkQueueRoom(who)
{
    if(isDefined(who.ghost) && who.ghost)
	{
	    who Suicide();
	    return false;
	}

    if(who.pers["team"] == "axis" || who.pers["team"] == "spectator")
    	return false;

    if(level.queue_disabled)
    	return true;

    if(level.queue_list[level.queue_enter].guid != who.guid /*|| level.queue_room*/)
    {
        who iprintlnbold("^1Wait your Turn!");

		who freezecontrols(1);

        if(isdefined(level.vcQueueCustom))
            who setorigin(level.vcQueueCustom);
        else 
            who setorigin(level.vc_queue_trig.origin);

		who freezecontrols(0);

        return false;
    }

    who notify("romm_enter_plugin");
    who thread onRoomDeath();

    level.queue_room = true;

    return true;
}

// WHOLE FX THING =========================================================================================
createTrigFx(trigger, fx)
{
	if(!isDefined(trigger))
		return;

    if(!isdefined(fx))
        fx = level.fx["queue_trig"];
    else 
        fx = level.fx["queue_trig"];

	wait 5;

	type = trigger.classname;	
	z = getfloor(trigger)[2];

	if(type == "trigger_radius")
	{
		if(!isDefined(trigger.radius))
			trigger.radius = 150;

		if(isDefined(trigger.inAir) && trigger.inAir)
			z = trigger.origin[2];

		width = trigger.radius;
		points = circlePoints(trigger, z, width);
		wait 0.1;

		thread moveFxcir(points, fx);
	}
	else
	{
		width = getTrigsize(trigger)[0];
		length = getTrigsize(trigger)[1];
		height_bottom = getTrigsize(trigger)[2];
		points = [];
		if(isDefined(trigger.inAir) && trigger.inAir)
			z = trigger.origin[2]+height_bottom;

		x = trigger.origin[0]+width;
		y = trigger.origin[1]+length;
		points[points.size] = (x,y,z);
		x = trigger.origin[0]+width;
		y = trigger.origin[1]-length;
		points[points.size] = (x,y,z);
		x = trigger.origin[0]-width;
		y = trigger.origin[1]-length;
		points[points.size] = (x,y,z);
		x = trigger.origin[0]-width;
		y = trigger.origin[1]+length;
		points[points.size] = (x,y,z);

		thread moveFxrect(points, fx);
	}
}

moveFxcir(a, fx)
{
	level endon("game over");
	while(1)
	{
		tag = spawn("script_model", a[0]);
		tag setmodel("tag_origin");
		wait 0.1;
		PlayFXOnTag(fx, tag, "tag_origin");
		for(i=0; i<a.size+1; i++)
		{
			if(i >= a.size)
				tag MoveTo(a[0], 0.1);
			else
				tag MoveTo(a[i], 0.1);
			wait 0.1;
		}
		tag delete();
		wait 0.05;
	}
}

moveFxrect(a, fx)
{
	level endon("game over");

	while(1)
	{
		tag = spawn("script_model", a[0]);
		tag setmodel("tag_origin");
		wait 0.1;
		PlayFXOnTag(fx, tag, "tag_origin");
		for(i=0; i<a.size+1; i++)
		{
			if(i >= a.size)
				tag MoveTo(a[0], 5, 0.5, 0.5);
			else
				tag MoveTo(a[i], 5, 0.5, 0.5);
			wait 5;
		}
		tag delete();
		wait 1;
	}
}

getfloor(a)
{
	trace = BulletTrace(a.origin, a.origin - (0,0,999999), false, undefined);
	if(trace["fraction"] != 1)
		return trace["position"];
	else
		return a;
}

getTrigsize(a)
{
	arr = [];
	tag = spawn("script_origin", a.origin);
	ori1 = tag GetOrigin();
	x = 0;
	while(tag IsTouching(a))
	{	
		tag.origin = (tag.origin + (x,0,0));
		wait 0.05;
		x++;
	}
	ori2 = tag GetOrigin();
	x = ori2[0] - ori1[0];
	arr[arr.size] = x;

	tag.origin = a.origin - (0,0,0);
	ori1 = tag GetOrigin();
	y = 0;
	while(tag IsTouching(a))
	{	
		tag.origin = (tag.origin + (0,y,0));
		wait 0.05;
		y++;
	}
	ori2 = tag GetOrigin();
	y = ori2[1] - ori1[1];

	arr[arr.size] = y;
	tag.origin = a.origin - (0,0,0);
    ori1 = tag GetOrigin();
    z = 0;
    while(tag IsTouching(a))
    {    
        tag.origin = (tag.origin + (0,0,z));
        wait 0.05;
        z--;
    }
    ori2 = tag GetOrigin();
    z = ori2[2] - ori1[2];

    arr[arr.size] = z;
	tag Delete();

	return arr;
}

circlePoints(a, floor, radius)
{
	points = [];
	r = radius;
	z = floor;
	idx = 0;

	h = a.origin[0];
	k = a.origin[1];
	for(i = 0; i< 360; i++)
	{
		x = h + r*Cos(i);
		y = k - r*Sin(i);
		points[idx] = (x,y,z);
		if(i%2 == 0)	
			idx++;
	}

	return points;
}