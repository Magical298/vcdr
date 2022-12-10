main()
{
	maps\mp\_load::main();
	
	thread door();
    thread credit();
   //Traps
	thread trap1();
    thread trap2();	
    thread trap3();	
	thread trap4();
	thread trap5();
	thread trap7();
	thread IDK();
	thread rs_rotate();
	thread b_secret();
	thread rodnex();
	thread trap8();
	thread trap8_a();
	thread teleportt();
	thread lastmsg();
	thread rpg_secret();
	
	addTriggerToList("trap1_trig");
	addTriggerToList("trap2_trig");
	addTriggerToList("trap3_trig");
	addTriggerToList("trap4_trig");
	addTriggerToList("trap5_trig");
	addTriggerToList("trap6_trig");
	addTriggerToList("trap7_trig");
	addTriggerToList("trap8_trig");
	addTriggerToList("trap9_trig");
	addTriggerToList("trigger_secret");
	
	AmbientPlay("ambient1");
	
	//end games
	thread sniper();
	thread knife();
	//shits
	thread vip_room();
	thread punci();
	thread mappratp();
	thread room_trig();
	PreCacheItem("remington700_mp");
	PreCacheItem("m40a3_mp");
	PreCacheItem("rpg_mp");
}
addTriggerToList( name )
{
    if( !isDefined( level.trapTriggers ) )
        level.trapTriggers = [];
    level.trapTriggers[level.trapTriggers.size] = getEnt( name, "targetname" );
}
door()
{
	door = getEnt ("door", "targetname");
	trig = getEnt ("door_trig", "targetname");
	trig setHintstring ("Press [USE] to open the Door!");
	trig waittill("trigger", player);
	trig delete();
		
	door moveZ (-160, 3);
	wait 3.5;
	door delete();
}
trap1()
{
	trap1_1 = getent ("trap1_1", "targetname");
	trap1_2 = getent ("trap1_2", "targetname");
	trap1_3 = getent ("trap1_3", "targetname");
	trap1_4 = getent ("trap1_4", "targetname");
	trap1_5 = getent ("trap1_5", "targetname");
	trig = getent ("trap1_trig", "targetname");
	trig setHintstring ("Press [USE] to activate!");
	trig waittill("trigger", player);
	trig delete();

	while(1)
	{
		trap1_1 movez (50, 1.5);
		trap1_2 movez (-50, 1.5);
		trap1_3 movez (50, 1.5);
		trap1_4 movez (-50, 1.5);
		trap1_5 movez (50, 1.5);
		wait 1;
		trap1_1 movez (-50, 1.5);
		trap1_2 movez (50, 1.5);
		trap1_3 movez (-50, 1.5);
		trap1_4 movez (50, 1.5);
		trap1_5 movez (-50, 1.5);
		wait 1;
	}
}
trap2() 
{
	trap2 = getent ("trap2", "targetname");
	hurt = getent ("asd_trig", "targetname");
	hurt enablelinkto();
	hurt linkto (trap2);
	trig = getent ("trap2_trig", "targetname");
	trig setHintstring ("Press [USE] to activate!");
	trig waittill("trigger", player);
	trig delete();
	{
		trap2 movez (-420, 0.5);
		trap2 waittill("movedone");
		trap2 movez (420, 2);
	}
}
trap3()
{ 
    trap3 = getEnt ("trap3", "targetname"); 
    trig = getEnt ("trap3_trig", "targetname"); 
    trig setHintstring ("Press [USE] to activate!"); 
    trig waittill("trigger", player);
	trig delete();
	
	trap3 movez (-500, 2);
	trap3 waittill ("movedone");
	trap3 movez (500, 2);
	trap3 waittill ("movedone"); //
}
trap4()
{ 
    trap4 = getEnt ("trap4", "targetname"); 
    while(1)
	{
		trap4 rotateyaw( -360 , 2 );
		trap4 waittill("rotatedone");
		wait 3;
	}
}
trap5()
{ 
    trap5 = getEnt ("trap5", "targetname"); 
    trig = getEnt ("trap5_trig", "targetname"); 
    trig setHintstring ("Press [F] to activate!"); 
    trig waittill("trigger", player);
	trig delete();
	
	while(1)
	{
		trap5 moveY (340, 2.5);
		trap5 waittill ("movedone");
		wait 1.5;
		trap5 moveY (-340, 2.5);
		trap5 waittill ("movedone"); //
		wait 1.5;
	}
}
trap7()
{ 
    trap7 = getEnt ("trap7", "targetname"); 
    trig = getEnt ("trap7_trig", "targetname"); 
    trig setHintstring ("Press [USE] to activate!"); 
    trig waittill("trigger", player);
	trig delete();
	
	while(1)
	{
		trap7 moveX (200, 1.5);
		trap7 waittill ("movedone");
		trap7 moveX (-200, 2);
		trap7 waittill ("movedone"); //
	}
}
IDK()
{
    trap6 = getent ("trap6", "targetname");
    trig = getent ("trap6_trig", "targetname");
    trig setHintstring ("Press [USE] to activate!");
    trig waittill("trigger", player);
    trig delete();

	while(1)
    {
		trap6 movey (-412, 1);
		wait 1.5;
		trap6 movey (412, 1);
		wait 1.5;
    }
}
rs_rotate()
{
	rs_rotate = getEnt ("rs_rotate", "targetname");
	while(1)
	{
		rs_rotate rotateyaw( -360 , 8 );
		rs_rotate waittill("rotatedone");
	}
}
b_secret()
{	
	b_secret = getEnt ("b_secret", "targetname");
	while(1)
	{
		b_secret rotateyaw( -360 , 6 );
		b_secret waittill("rotatedone");
	}
}

rpg_secret()
{
   trigger = getent("trigger_secret","targetname");
   trigger waittill( "trigger", player );

		if( player isReallyAlive())
		{
			player GiveWeapon("rpg_mp"); 
			player givemaxammo ("rpg_mp");  
			player switchtoweapon("rpg_mp");
		}
}
 
rodnex()
{
	rodnex = getEnt ("rodnex", "targetname");
	while(1)
	{
		rodnex rotateyaw( -360 , 8 );
		rodnex waittill("rotatedone");
	}
}
trap8() 
{ 
	trap8 = getEnt ("trap8", "targetname"); 

	for(;;) 
	{ 
		trap8 moveX (-705,2); 
		trap8 waittill ("movedone"); 
		trap8 moveX (705,2); 
		trap8 waittill ("movedone"); 
		wait(0.5); 
	} 
}
trap8_a() 
{ 
	trap8_a = getEnt ("trap8_a", "targetname"); 
	for(;;) 
	{ 
		trap8_a moveX (-705,2); 
		trap8_a waittill ("movedone"); 
		trap8_a moveX (705,2); 
		trap8_a waittill ("movedone"); 
		wait(0.5); 
	} 
}

lastmsg ()
	{
	ms = getent ("ms","targetname");
	ms waittill ("trigger",player );
	ms delete ();

	
	iprintlnbold ("Gratz" + "." + "^2"+ player.name + "^7."+ "finished Short map at 1st place");
	wait 1 ;
	}
	
sniper()
{

	level.final_sniper_trig = getEnt( "final_sniper_trig", "targetname");
    jump = getEnt( "sniper_j", "targetname" );
    acti = getEnt( "sniper_a", "targetname" );
	
	while(1)
    {
        level.final_sniper_trig waittill( "trigger", player );

		// ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================

        if( !isDefined( level.final_sniper_trig ) )
            return;

		level.final_jump_trig delete();
		level.final_knife_trig delete();
		player.health = player.maxhealth;
		level.activ.health = level.activ.maxhealth;
		player SetPlayerAngles( jump.angles );
        player setOrigin( jump.origin );
        player TakeAllWeapons();
        player GiveWeapon( "remington700_mp" );
		player GiveWeapon( "m40a3_mp" );
		player giveMaxammo("remington700_mp");
		player giveMaxammo("m40a3_mp");
        level.activ setPlayerangles( acti.angles );
        level.activ setOrigin( acti.origin );
        level.activ TakeAllWeapons();
        level.activ GiveWeapon( "remington700_mp" );
        level.activ GiveWeapon( "m40a3_mp" );
        wait 0.05;
        player switchToWeapon( "remington700_mp" );
        level.activ SwitchToWeapon( "remington700_mp" );
        player FreezeControls(1);
		level.activ FreezeControls(1);
		noti = SpawnStruct();
		noti.titleText = "Sniper Room";
		noti.notifyText = level.activ.name + " ^3VS^7 " + player.name;
		noti.glowcolor = (0,0.2,0.9);
		noti.duration = 5;
		players = getentarray("player", "classname");
		for(i=0;i<players.size;i++)
		players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
		wait 3;
		player FreezeControls(0);
		level.activ FreezeControls(0);
        
		
		while( isAlive( player ) && isDefined( player ) )
            wait 1;
    }
}
knife()
{

	level.final_knife_trig = getEnt( "final_knife_trig", "targetname");
    jump = getEnt( "knife_j", "targetname" );
    acti = getEnt( "knife_a", "targetname" );

	while(1)
    {
        level.final_knife_trig waittill( "trigger", player );

		// ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================
		
        if( !isDefined( level.final_knife_trig ) )
            return;


		level.final_jump_trig delete();
		level.final_sniper_trig delete();


		player.health = player.maxhealth;
		level.activ.health = level.activ.maxhealth;
		player SetPlayerAngles( jump.angles );
        player setOrigin( jump.origin );
        player TakeAllWeapons();
        player GiveWeapon( "knife_mp" );
		player GiveWeapon( "knife_mp" );
        level.activ setPlayerangles( acti.angles );
        level.activ setOrigin( acti.origin );
        level.activ TakeAllWeapons();
        level.activ GiveWeapon( "knife_mp" );
        level.activ GiveWeapon( "knife_mp" );
        wait 0.05;
        player switchToWeapon( "knife_mp" );
        level.activ SwitchToWeapon( "knife_mp" );
        player FreezeControls(1);
		level.activ FreezeControls(1);
		noti = SpawnStruct();
		noti.titleText = "^7Knife Room";
		noti.notifyText = level.activ.name + " ^3VS^7 " + player.name;
		noti.glowcolor = (0.9,0,0.9);
		noti.duration = 5;
		players = getentarray("player", "classname");
		for(i=0;i<players.size;i++)
			players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
		wait 5;
		player FreezeControls(0);
		level.activ FreezeControls(0);
        while( isAlive( player ) && isDefined( player ) )
            wait 1;
    }
}

credit()
{
	if( isDefined( self.logoText ) )
	self.logoText destroy();

	self.logoText = newHudElem();
	self.logoText.y = 10;
	self.logoText.alignX = "center";
	self.logoText.alignY = "middle";
	self.logoText.horzAlign = "center_safearea";

	self.logoText.alpha = 0;
	self.logoText.sort = -3;
	self.logoText.fontScale = 1.45;
	self.logoText.archieved = true;

	for(;;)
	{
		self.logoText fadeOverTime(1);
		self.logoText.alpha = 1;
		self.logoText setText("^1>>^3Map made by ^1|RS|^3RodneX.");
		wait 5;
		self.logoText fadeOverTime(1);
		self.logoText.alpha = 0;
		wait 5;
		self.logoText fadeOverTime(1);
		self.logoText.alpha = 0;
		wait 1;
		self.logoText fadeOverTime(1);
		self.logoText.alpha = 1;
		self.logoText setText("^5x^1F^5i^7re ^3rodnexx^1");
		wait 5;
		self.logoText fadeOverTime(1);
		self.logoText.alpha = 0;
		wait 1;
		self.logoText fadeOverTime(1);
		self.logoText.alpha = 1;
		self.logoText setText("^5D^7eathrun ^5S^7hort");
		wait 5;
		self.logoText fadeOverTime(1);
		self.logoText.alpha = 0;
		wait 1;
		self.logoText fadeOverTime(1);
		self.logoText.alpha = 1;
		self.logoText setText("^3Thanks to ^5Hellkiller22^7!^9:)");
		wait 5;
		self.logoText fadeOverTime(1);
		self.logoText.alpha = 0;
		wait 1;
		self.logoText fadeOverTime(1);
		self.logoText.alpha = 1;
		self.logoText setText("^5Map ^3create ^5for ^1|RS|");
		wait 5;
	    self.logoText fadeOverTime(1);
		self.logoText.alpha = 0;
		wait 1;
		self.logoText fadeOverTime(1);
		self.logoText.alpha = 1;
		self.logoText setText("^1>>^3Thanks to ^1|RS|^3ShocK for helping test map");
		wait 5;
	    self.logoText fadeOverTime(1);
		self.logoText.alpha = 0;
		wait 1;
		self.logoText fadeOverTime(1);
		self.logoText.alpha = 1;
		self.logoText setText("^1>>Youtube: ^3Jirka Mrzena(RodneX)");
		wait 5;
	    self.logoText fadeOverTime(1);
		self.logoText.alpha = 0;
		wait 1;
		self.logoText fadeOverTime(1);
		self.logoText.alpha = 1;
		self.logoText setText("^1>>^3Thanks to ^1|RS|^3CrazY for helping with scripts");
		wait 5;
	}
}

vip_room()
{
    vip_trig = getEnt ("vip_trig", "targetname");
    org = getEnt ("vip_origin", "targetname");
       
	level.accepted1 = "2310346615434407089"; //Fox
    level.accepted2 = "2310346616835620893"; //Mortiis
	level.accepted3 = "ef7e697afcc9ba5affee6a423eef5bc2"; //|RS|RodneX
	level.accepted4 = "3db2e881958e09312032fe7bbd3c9f27"; //|RS|Ali sajjad
    level.accepted5 = "00000000bf7cb645277deb396a0de4c6"; //|RS|one
    level.accepted6 = "0000000046d345d4f5cb706e5b9bfaeb"; //|RS|Guest61
	level.accepted7 = "9da5b1d82364fb35954e250b761e2245"; //|RS|Winnie
	level.accepted8 = "c6ffb70b8c8aa23ee6b89bb2866c76c2"; //|RS|GHOST
	level.accepted9 = "bfe84a021fcb9a63af0f0e1c36681f59"; //|RS|ShocK
	level.accepted10 = "12793e269b17104f63e652475b4fec98"; //|RS|Joker
	while (1)
    {
        vip_trig waittill( "trigger", player );
        tempGuid = player getGUID();
        if(player isTouching(vip_trig) && player useButtonPressed())
        {
            if((tempGuid == level.accepted1) || (tempGuid == level.accepted2) || (tempGuid == level.accepted3) || (tempGuid == level.accepted4) || (tempGuid == level.accepted5) || (tempGuid == level.accepted6) || (tempGuid == level.accepted7) || (tempGuid == level.accepted7) || (tempGuid == level.accepted8) || (tempGuid == level.accepted9) || (tempGuid == level.accepted10))
                        {
                player SetOrigin( org.origin );
                player iprintlnbold("^2<< ^3Hello ^6noob ^1Welcome ^3in ^4vip ^5room ^2>>");
            }
            else
            {
                wait 0.5;
				player iprintlnbold("^1<< Map made by ^2RodneX ^1and helped by ^5Hellkiller22 >>");
            }
        }
        else
        {
            wait 0.5;
        }
    }
}



punci()
{
	punci = getent ("punci", "targetname");
	punci waittill("trigger");
	iprintlnbold ("^8RodneX ^2is ^3faster than ^5you ^6:p");
}

mappratp()
{
    trig = getEnt ("teletrig", "targetname");
    end = getEnt ("mappra", "targetname");    
    while(1)
    {
        trig waittill("trigger", player);     
	
        player SetOrigin(end.origin);
        player SetPlayerAngles( end.angles );
    }
}

room_trig()
{
    trig = getEnt ("room_trig", "targetname");
    end = getEnt ("room", "targetname");    
    while(1)
    {
        trig waittill("trigger", player);     
	
        player SetOrigin(end.origin);
        player SetPlayerAngles( end.angles );
    }
}

teleportt()
{
    trig = getEnt ("teleportt", "targetname");
    end = getEnt ("tele", "targetname");    
    while(1)
    {
        trig waittill("trigger", player);     
	
        player SetOrigin(end.origin);
        player SetPlayerAngles( end.angles );
    }
}

isReallyAlive()
{
	if( self.sessionstate == "playing" )
		return true;
	return false;
}