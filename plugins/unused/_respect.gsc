init()
{
	level.finishPosition = [];

	level.playerEnterNum = 0;

	level.inRoomPlugin = false;

	level.disableRoomPlugin = false;

	thread watchEndTrig();

	level.orderHud = addHud(level, 0, 25, 0.8, "right", "top", 1.4);
	level.orderHud setText("^5Queue : ");
	level.queueHud = addHud(level, 0, 25, 0.8, "right", "top", 1.4);
	level.queueHud.color = (1,1,1);

}


//check player is till alive while in a room
onRoomDeath()
{
	while( isAlive( self ) && isDefined( self ) )
		wait 0.1;
	level.playerEnterNum++;
	level.inRoomPlugin = false;
	upDateQueueHud();
}

//while player is in queue check they are still alive
onQueueDeath()
{
	self endon("romm_enter_plugin");

	//save there id so if they disconnect we can still use it
	id = self.guid;

	while( isAlive( self ) && isDefined( self ) )
		wait 0.1;

	//find players position in queue array and remove it
	for(i = level.playerEnterNum; i<level.finishPosition.size; i++)
	{
		if(level.finishPosition[i].guid == id)
		{
			level.finishPosition = removeFromArray(level.finishPosition, i);
			upDateQueueHud();
			return;
		}
	}
	upDateQueueHud();
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

watchEndTrig()
{
	level.endmaptriggerplugin = getEntArray( "endmap_trig", "targetname" );

	//if no trigger disable plugin
	if( !level.endmaptriggerplugin.size || level.endmaptriggerplugin.size > 1 )
	{
		iPrintln("^1NO END TRIG!! CREATE ONE!");
		level.disableRoomPlugin = true;
		return;
	}
    level.endmaptriggerplugin = level.endmaptriggerplugin[0];

    while(1)
    {
    	found = false;
    	level.endmaptriggerplugin waittill("trigger", player);

    	//check if player already has place in queue
    	for(i = level.playerEnterNum; i<level.finishPosition.size; i++)
    	{
    		if(level.finishPosition[i].guid == player.guid)
    			found = true;
    	}

    	//if they do dont add them to it again
    	if(found)
    		continue;

    	//no ghosts in queue
		if(isDefined(player.ghost) && player.ghost)
	    {
	        player Suicide();
	        continue;
	    }

	    //no acti in queue
	    if( player.pers["team"] == "axis" )
	    	continue;

	    //add player to queue
	    level.finishPosition[level.finishPosition.size] = player;

	    player IPrintLnBold("Queue Postion " + level.finishPosition.size);
	    player thread onQueueDeath();

	    upDateQueueHud();
	}
}

//called from map gsc
roomCheck(player)
{
	//no ghosts in room
	if(isDefined(player.ghost) && player.ghost)
    {
        player Suicide();
        return false;
    }

    if(player.pers["team"] == "axis")
    	return false;

    if(level.disableRoomPlugin)
    	return true;

    //check player entering with next in queue id
    if(level.finishPosition[level.playerEnterNum].guid != player.guid || level.inRoomPlugin)
    {
        player IPrintLnBold("^1Wait your turn");
        player setOrigin(level.endmaptriggerplugin.origin);
        return false;
    }
    player notify("romm_enter_plugin");
    level.inRoomPlugin = true;
    player thread plugins\_respect::onRoomDeath();
    upDateQueueHud();
    return true;
}

//queue hud
upDateQueueHud()
{
	string = "";
	if(isDefined(level.finishPosition[level.playerEnterNum]))
	{
		string = "\n" + level.finishPosition[level.playerEnterNum].name + "\n";
	}
	level.queueHud SetText(string);
}

addHud( who, x, y, alpha, alignX, alignY, fontScale )
{
	if( isPlayer( who ) )
		hud = newClientHudElem( who );
	else
		hud = newHudElem();

	hud.x = x;
	hud.y = y;
	hud.alpha = alpha;
	hud.alignX = alignX;
	hud.alignY = alignY;
	hud.horzAlign = alignX;
    hud.vertAlign = alignY;
	hud.fontScale = fontScale;
	return hud;
}