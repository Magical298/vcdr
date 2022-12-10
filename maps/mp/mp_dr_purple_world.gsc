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
    _   ________   _______      
    | | / / ___( ) / ___/ /__ ___
    | |/ / /__ |/ / (_ / / -_) _ \
    |___/\___/    \___/_/\__/_//_/
   
    © VC' Glen
*/
 
main()
{
    maps\mp\_load::main();
 
    game["allies"] = "sas";
    game["axis"] = "opfor";
    game["attackers"] = "axis";
    game["defenders"] = "allies";
    game["allies_soldiertype"] = "woodland";
    game["axis_soldiertype"] = "woodland";
	
	if(!isdefined(level.music))
    level.music=[];
    level.music[0]["song"]    ="Mt Eden feat. Albi & the Wolves - Fall With You";
    level.music[0]["alias"]    ="sky1";
    level.music[1]["song"]    ="Pegboard Nerds - Just Like That ft. Johnny Graves (WOLFE Remix)";
    level.music[1]["alias"]    ="sky2";
    level.music[2]["song"]    ="Point Point - All This";
    level.music[2]["alias"]    ="sky3";
    level.music[3]["song"]    ="Taska Black - Leave Me";
    level.music[3]["alias"]    ="sky4";
    level.music[4]["song"]    ="ZHU x Skrillex x THEY. - Working For It (NADERI Remix)";
    level.music[4]["alias"]    ="sky5";
	
	setDvar("bg_falldamagemaxheight", 1 );
	setDvar("bg_falldamageminheight", 2 );
	
	level._effect["water"] = loadfx("misc/watersplash_small");
 
	thread Trap1();
	thread Trap2();
	thread Trap3();
	thread Trap4();
	thread Trap5();
	thread Trap6();
	thread Trap7();
	thread Trap8();
	thread Trap9();
	thread Trap10();
	thread Logo();
	thread MovingPlatform();
	thread Endrooms();
	thread OldRoom();
	thread KnifeRoom();
	thread SniperRoom();
	thread SniperFall();
	thread Startdoor();
	thread Sign();
	thread Messages();
	thread EndroomLetters();
	thread Step1();
	thread musicBox();
	
	/////Trigger-List/////
	addTriggerToList("trig_trap1");
	addTriggerToList("trig_trap2");
	addTriggerToList("trig_trap3");
	addTriggerToList("trig_trap4");
	addTriggerToList("trig_trap5");
	addTriggerToList("trig_trap6");
	addTriggerToList("trig_trap7");
	addTriggerToList("trig_trap8");
	addTriggerToList("trig_trap9");
	addTriggerToList("trig_trap10");
	
	level.birdcage = getEnt("birdcage", "targetname");
	level.secretblock = getEnt("secret_block", "targetname");
	level.hurt = getEnt("hurt_secret", "targetname");
	level.birdcage hide();
	level.secretblock notSolid();
}
 
 addTriggerToList(name)
{
    if(!isDefined(level.trapTriggers))
        level.trapTriggers = [];
    level.trapTriggers[level.trapTriggers.size] = getEnt(name,"targetname");
}
 
 /*
	trap 1 = simple disappearing brush parts
	trap 2 = 4 blocks spin independently (2 at a time)
	trap 3 = rotation larger block (back and forth like in liferun)
	trap 4 = rotating larger block (overleaf like 2nd block in bricky)
	trap 5 = water rises in the lower segment
	trap 6 = small drawbridge style floor trap <-- changed mind
			^ spinner
	trap 7 = some kind of pusher with a flashy animation
	trap 8 = possibly an rpg or missle of sorts to shoot the 'ship' <-- fuck that BRING ON THE WALL
	trap 9 = birdcage? idk im tired - water rises <-- spike
	trap 10 = a cheap disappearing brush for the final trap bcus im a scrub
 
 */

Messages()
{
    wait 10;
	iPrintLnBold("Welcome to ^1"+getDvar("mapname")+"^7!");
	
    while(1)
    {
		iPrintLn("^1>>^7 Map tested on speed: [190/1.0]");
		iPrintLn("^1>>^7 Your speed is [^1"+getDvar("g_speed")+"/"+getDvar("dr_jumpers_speed")+"^7]");
        wait 10;
		iPrintLn("Map created by ^1VC' Glen :D^7!");
		wait 10;
        iPrintLn("^1>>^7 Visit: ^1vistic-clan.com");
        wait 10;
        iPrintLn("^1>>^7 Thanks for playing ^1"+getDvar("mapname"));
        wait 10;
        iPrintLn("^1>>^7 Feedback is ^1appreciated^7!");
        wait 10;
		iPrintLn("^1>>^7 My Clan is better than your clan!");
		wait 10;
       
    }
}
 
 Startdoor()
 {
	trig = getEnt("trig_startdoor", "targetname");
	door = getEnt("startdoor", "targetname");
	button1 = getEnt("doorbutton1", "targetname");
	button2	= getEnt("doorbutton2", "targetname");
	trig setHintString("^1>>^7 Press ^1&&1 ^7 to Open the Door!");
	
	trig waittill("trigger", player);
	
	button1 moveX(-6, 1);
	button2 moveX(6, 1);
	wait 1;
	button1 delete();
	button2 delete();
	trig delete();
	iPrintLnBold("StartDoor Opening!");
	wait 3;
	
	door moveZ(-250, 2);
	wait 2;
	door delete();
	wait 3;
	
	hud_clock = NewHudElem();
	hud_clock.alignX = "center";
	hud_clock.alignY = "middle";
	hud_clock.horzalign = "center";
	hud_clock.vertalign = "middle";
	hud_clock.alpha = 1;
	hud_clock.x = 0;
	hud_clock.y = 0;
	hud_clock.font = "objective";
	hud_clock.fontscale = 2;
	hud_clock.glowalpha = 5;
	hud_clock.glowcolor = (0.0,0.8,0.0);
	hud_clock.label = &"^1Map by ^7VC' Glen :D";
    hud_clock SetPulseFX( 40, 5400, 200 );
    wait 3;
 
 }
 
 Trap1()
 {
	trig = getEnt("trig_trap1", "targetname");
	trig setHintString("^1>>^7 Press ^1&&1 ^7 to Delete Part of the Floor!");
	floor1 = getEnt("trap1a", "targetname");
	floor2 = getEnt("trap1b", "targetname");
	
	num = randomInt(10);
	
	trig waittill("trigger", player);
	trig delete();
	
	if (num >= 5) {
	floor1 delete();
	}
	else {
	floor2 delete();
	}
 }
 
 Trap2()
 {
	trig = getEnt("trig_trap2", "targetname");
	trig setHintString("^1>>^7 Press ^1&&1 ^7 to Spin the Squares!");
 
	s1 = getEnt("trap2a", "targetname");
	s2 = getEnt("trap2b", "targetname");
	s3 = getEnt("trap2c", "targetname");
	s4 = getEnt("trap2d", "targetname");
 
	trig waittill("trigger", player);
	trig delete();
 
	while(1)
	{
	s1 rotateYaw(720, 2);
	s4 rotateYaw(720, 2);
	wait 2.5;
	s2 rotateYaw(720, 2);
	s3 rotateYaw(720, 2);
	wait 2.5;
	}
	
 }
 
 Trap3()
 {
	trig = getEnt("trig_trap3", "targetname");
	block = getEnt("trap3", "targetname");
	trig setHintString("^1>>^7 Press ^1&&1 ^7 to Spin the Recangle!");
 
	trig waittill("trigger", player);
	trig delete();
	
	while(1)
	{
	block rotateYaw(90, 1.5);
	wait 1.5;
	block rotateYaw(-90, 1.5);
	wait 1.5;
	block rotateYaw(-90, 1.5);
	wait 1.5;
	block rotateYaw(90, 1.5);
	wait 1.5;
	}
	
 }
 
 Trap4()
 {
	trig = getEnt("trig_trap4", "targetname");
	block = getEnt("trap4", "targetname");
	trig setHintString("^1>>^7 Press ^1&&1 ^7 to Flip the Recangle!");
	
	trig waittill("trigger", player);
	trig delete();
	
	while(1)
	{
	block rotatePitch(360, 3);
	wait 6;
	}
 }
 
 Trap5()
 {
	trig = getEnt("trig_trap5", "targetname");
	water = getEnt("trap5", "targetname");
	hurt = getEnt("trap5a", "targetname");
	
	trig setHintString("^1>>^7 Press ^1&&1 ^7 to Raise the Water!");
	hurt enableLinkTo();
	hurt linkTo(water);
	
	trig waittill("trigger", player);
	trig delete();
	
	water moveZ(180, 3);
	wait 5;
	water moveZ(-180, 3);
	wait 3;
 }
 
 Trap6()
 {
	trig = getEnt("trig_trap6", "targetname");
	spinner = getEnt("trap6", "targetname");
	
	trig setHintString("^1>>^7 Press ^1&&1 ^7 to Activate the Spinner!");
	trig waittill("trigger", player);
	trig delete();
	
	spinner moveZ(40, 1);
	wait 1;
	spinner rotateYaw(1080, 6);
	wait 5;
	spinner moveZ(-40, 1);
	wait 1;
 }
 
 Trap7()
 {
	trig = getEnt("trig_trap7", "targetname");
	trig setHintString("^1>>^7 Press ^1&&1 ^7 to Block the Path!");
	block1 = getEnt("trap7a", "targetname");
	block2 = getEnt("trap7b", "targetname");
 
	trig waittill("trigger", player);
	trig delete();
	
	block1 moveZ(90, 0.5);
	block2 moveZ(90, 0.5);
	block2 rotateRoll(90, 0.5);
	wait 5;
	
	block1 moveZ(-90, 0.5);
	block2 moveZ(-90, 0.5);
	block2 rotateRoll(-90, 0.5);
	wait 0.5;
 }
 
 Trap8()
 {
	trig = getEnt("trig_trap8", "targetname");
	trig setHintString("^1>>^7 Press ^1&&1 ^7 to Block the Path!");
	
	trap8a = getEnt("trap8a", "targetname");
	trap8b = getEnt("trap8b", "targetname");
	trap8c = getEnt("trap8c", "targetname");
	trap8d = getEnt("trap8d", "targetname");
	
	num = randomInt(10);
	
	trig waittill("trigger", player);
	trig delete();
	
	if (num <= 2) {
		trap8a moveZ(208, 0.5);
		wait 0.5;
	}
	if ((num >= 3) && (num <= 5)) {
		trap8b moveZ(208, 0.5);
	}
	if ((num >= 6) && (num <= 8)) {
		trap8c moveZ(208, 0.5);
	}
	if (num > 8) {
		trap8d moveZ(208, 0.5);
	}
 }
 
Trap9()
{
	trig = getEnt("trig_trap9", "targetname");
	hurt = getEnt("hurt_bird", "targetname");
	spike = getEnt("birdspike", "targetname");
	
	hurt enableLinkTo();
	hurt linkTo(spike);

	trig setHintString("^1>>^7 Press ^1&&1 ^7 to Drop Birdcage!");
	trig waittill("trigger", player);
	trig delete();
	
	level.birdcage show();
	wait 0.5;
	level.birdcage moveZ(-160,0.5);
	wait 1;
	
	spike moveZ(150,3);
	wait 4;
	
	spike delete();
	level.birdcage delete();
	hurt delete();
	
}

Trap10()
{
	trig = getEnt("trig_trap10", "targetname");
	trig setHintString("^1>>^7 Press ^1&&1 ^7 to Remove part of the Floor!");
	block = getEnt("trap10", "targetname");
	
	trig waittill("trigger", player);
	trig delete();
	
	block delete();
}

Logo()
{
	logo = getEnt("logo", "targetname");
	
	while(1)
	{
		logo rotateYaw(360, 10, 2, 2);
		wait 10;
	}

}

MovingPlatform()
{
	trig = getEnt("trig_move","targetname");
	plat = getEnt("plat_move", "targetname");
	
	trig waittill("trigger", player);
	
	wait 1;
	while(1)
	{
	plat moveX(1880, 4);
	wait 6;
	plat moveX(-1880, 4);
	wait 6;
	}
}

Endrooms() 
{
	trig = getEnt("trig_endrooms", "targetname");
	tele1 = getEnt("origin_endrooms", "targetname");
	trig setHintString("^1>>^7 Press ^1&&1 ^7 to Enter Endroom Selection!");

	while(1)
	{
	trig waittill("trigger", player);
			
	if(!isDefined(trig))
	return;

	player setPlayerAngles(tele1.angles);
	player setOrigin(tele1.origin);
	iPrintLnBold( " ^6" + player.name + " ^7has entered the ^6game selection ^7!!!" );
	player RoomDeath();

	while(isAlive(player) && isDefined(player))
	if(isDefined(level.activ) && isAlive(level.activ))
	wait 1;
	}
}

RoomDeath() 
{ 
	self common_scripts\utility::waittill_any("death","disconnect");
	iPrintLnBold("^6"+self.name+" ^7is dead ^6!"); 
	iPrintLnBold("^6Selection Room ^7is now ^7open^6!!!"); 
}

OldRoom()
{
	while(1)
	{
	trig = getEnt("trig_old", "targetname");
	trig setHintString("^1>>^7 Press ^1&&1 ^7 to Enter The ^6Old ^7Room!");
	jumporigin = getEnt("origin_old", "targetname");
	
	trig waittill("trigger", player);

	// ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================
	
	iPrintLnBold("^1>>^7 " + player.name + " Has Chosen The ^1Old ^7 Room");
	
	player setOrigin (jumporigin.origin);
	player setPlayerAngles (jumporigin.angles);
	}
}

SniperRoom()
{
	while(1)
	{
	trig = getEnt("trig_sniper","targetname");
	
	tele1 = getEnt("origin_actisniper", "targetname");
	tele2 = getEnt("origin_jumpersniper", "targetname");

	trig setHintString("^1>>^7 Press ^1&&1 ^7 to Enter The ^6Sniper ^7Room!");
	
	trig waittill("trigger", player);

	// ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================
	
	player setOrigin(tele2.origin);
	player setPlayerAngles(tele2.angles);
	
	player takeAllWeapons();
	player giveWeapon("m40a3_mp");
	player giveWeapon( "remington700_mp" ); 
	player giveMaxAmmo("m40a3_mp");
	player giveMaxAmmo( "remington700_mp" );
	
	player switchToWeapon("m40a3_mp"); 
	
	level.activ setOrigin (tele1.origin);
	level.activ setPlayerAngles (tele1.angles);
	
	level.activ takeAllWeapons();
	level.activ giveWeapon("m40a3_mp");
	level.activ giveWeapon("remington700_mp");
	level.activ giveMaxAmmo("m40a3_mp");
	level.activ giveMaxAmmo("remington700_mp");
	wait (0.05);
	level.activ switchToWeapon("m40a3_mp"); 
	
	player.health = player.maxhealth;
	level.activ.health = level.activ.maxhealth;
	
	iPrintLnBold("^1>>^7 " + player.name + " Has Chosen The ^1Sniper ^7 Room");
	
	player freezeControls(1);
	level.activ freezeControls(1);
	
	player iPrintLnBold("^63");
	level.activ iPrintLnBold("^63");
	wait 1;
	player iPrintLnBold("^62");
	level.activ iPrintLnBold("^62");
	wait 1;
	player iPrintLnBold("^61");
	level.activ iPrintLnBold("^61");
	wait 1;
	player iPrintLnBold("^1FIGHT!");
	level.activ iPrintLnBold("^1FIGHT!");
	
	player freezeControls(0);
	level.activ freezeControls(0);
	
	player switchToWeapon("m40a3_mp");
	level.activ switchToWeapon("m40a3_mp");
	}
}

KnifeRoom()
{
	while(1)
	{
	trig = getEnt("trig_knife", "targetname");
	trig setHintString("^1>>^7 Press ^1&&1 ^7 to Enter The ^6Knife ^7Room!");
	jumporigin = getEnt("origin_jknife", "targetname");
	actiorigin = getEnt("origin_aknife", "targetname");
	
	trig waittill("trigger", player);

	// ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(player))
			continue;
		// =====================================
	
	iPrintLnBold("^1>>^7 " + player.name + " Has Chosen The ^1Knife ^7 Room");
	
	player takeAllWeapons();
	level.activ takeAllWeapons();
	
	player giveWeapon("tomahawk_mp");
	level.activ giveWeapon("tomahawk_mp");
	
	player freezeControls(1);
	level.activ freezeControls(1);
	
	player setOrigin (jumporigin.origin);
	player setPlayerAngles (jumporigin.angles);

	level.activ setOrigin (actiorigin.origin);
	level.activ setPlayerAngles (actiorigin.angles);
	
	player iPrintLnBold("^63");
	level.activ iPrintLnBold("^63");
	wait 1;
	player iPrintLnBold("^62");
	level.activ iPrintLnBold("^62");
	wait 1;
	player iPrintLnBold("^61");
	level.activ iPrintLnBold("^61");
	wait 1;
	player iPrintLnBold("^1FIGHT!");
	level.activ iPrintLnBold("^1FIGHT!");
	
	player freezeControls(0);
	level.activ freezeControls(0);
	
	player switchToWeapon("tomahawk_mp");
	level.activ switchToWeapon("tomahawk_mp");
	}
}

SniperFall()
{
	trig = getEnt("sniperroomfall", "targetname");
	tele1 = getEnt("origin_sniperfall", "targetname");

	for(;;)
		{
			trig waittill("trigger", player);
			player setOrigin(tele1.origin);
			player setPlayerAngles(tele1.angles);
		}
}

Sign()
{
	signname = getEnt("sign_name", "targetname");
	ring1 = getEnt("sign_ring1", "targetname");
	ring2 = getEnt("sign_ring2", "targetname");
	
	while(1)
	{
		signname rotateRoll(-360, 5, 1, 1);
		ring1 rotateRoll(360, 5, 1, 1);
		ring2 rotateYaw(-360, 5, 0.5, 0.5);
		wait 6;
	
	}
}

EndroomLetters()
{
	letterS = getEnt("letterS", "targetname");
	letterK = getEnt("letterK", "targetname");
	letterO = getEnt("letterO", "targetname");
	
	while(1)
	{
	letterS moveZ(20, 2, 0.5, 0.5);
	letterS rotateYaw(180, 2);
	letterK moveZ(20, 2, 0.5, 0.5);
	letterK rotateYaw(180, 2);
	letterO moveZ(20, 2, 0.5, 0.5);
	letterO rotateYaw(180, 2);
	wait 2;
	letterS moveZ(-20, 2, 0.5, 0.5);
	letterS rotateYaw(180, 2);
	letterK moveZ(-20, 2, 0.5, 0.5);
	letterK rotateYaw(180, 2);
	letterO moveZ(-20, 2, 0.5, 0.5);
	letterO rotateYaw(180, 2);
	wait 2;
	}
}

Step1()
{
	trig = getEnt("trig_step1", "targetname");
	
	trig waittill("trigger", player);
	
	iPrintLn("Step ^11^7/3 Complete");
	thread Step2();
}

Step2()
{
	trig = getEnt("trig_step2", "targetname");
	
	trig waittill("trigger", player);
	
	iPrintLn("Step ^12^7/3 Complete");
	thread Step3();
}

Step3()
{
	trig = getEnt("trig_step3", "targetname");
	
	trig waittill("trigger", player);
	
	level.secretblock solid();
	iPrintLn("Step ^23^7/3 Complete");
	iPrintLn("^6Secret Opened^7!");
	level.hurt moveZ(-144, 0.5);
	thread SecretTeleport();
}

SecretTeleport()
{	
	trig = getEnt("secret_enter", "targetname");
	secretorigin = getEnt("origin_secret", "targetname");
	
	trig waittill("trigger", player);
	player setOrigin(secretorigin.origin);
	player setPlayerAngles(secretorigin.angles);
	iPrintLn("^6Secret Closed^7!");
	
	trig delete();
	level.hurt moveZ(144, 0.5);
	level.secretblock notSolid();
	thread SecretEnd();
	
}

SecretEnd()
{
	trig = getEnt("trig_secretend", "targetname");
	trig setHintString("^1>>^7 Press ^1&&1 ^7 to Exit Secret!");
	
	secretorigin = getEnt("origin_secretend", "targetname");
	
	trig waittill("trigger", player);
	
	player braxi\_rank::giveRankXP("", 500);
	player setOrigin(secretorigin.origin);
	player setPlayerAngles(secretorigin.angles);
	
	player giveWeapon("ak74u_mp");
	player giveMaxAmmo("ak74u_mp");
	player switchToWeapon("ak74u_mp");

}


musicBox()
{
    trig = getEnt("vcmusic","targetname");
    trig setHintString("Press ^1&&1^7 to select Music");
    trig waittill("trigger",p);
	p braxi\_rank::giveRankXP("", 50);
    trig delete();
    
    p freezeControls(1);
    p musicMenu();
}

musicMenu()
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "spawned" );
    self endon( "joined_spectators" );
    self endon( "music thread terminated" );
 
    self.hud_music = [];
    self.selection = 0;
 
    // create huds
    i = 0;
    self.hud_music[i] = braxi\_mod::addTextHud( self, 160, 200, 0.6, "left", "top", 2 );
    self.hud_music[i].sort = 879;
    self.hud_music[i] setShader( "black", 320, 160 );
    i++;
    self.hud_music[i] = braxi\_mod::addTextHud( self, 167, 204, 0.6, "left", "top", 1.4 );
    self.hud_music[i].sort = 880;
    self.hud_music[i] setShader( "white", 306, 20 );
    self.hud_music[i].color=(1,0,0);
    
    i++;
    self.hud_music[i] = braxi\_mod::addTextHud( self, 210, 204, 0.93, "left", "top", 1.8 );
    self.hud_music[i].sort = 884;
    self.hud_music[i] setText("Purple World!");
    self.hud_music[i].glowalpha=1;
    if(isdefined(level.randomcolor))
        self.hud_music[i].glowcolor=level.randomcolor;
    else 
        self.hud_music[i].glowcolor=(1,0,0);
    i++;
    self.hud_music[i] = braxi\_mod::addTextHud( self, 250, 360, 1, "center", "bottom", 1.4 );
    self.hud_music[i].sort = 886;
    self.hud_music[i] setText("Scroll: ^3[{+attack}] ^7| Select: ^3[{+activate}] ^7| Close: ^3[{+frag}]");
 
    for( j = 0; j < level.music.size; j++ )
    {
        i++;
        self.hud_music[i] = braxi\_mod::addTextHud( self, 172, 230+(j*16), 0.93, "left", "top", 1.4 );
        self.hud_music[i].sort = 882;
        self.hud_music[i].font = "objective";
        self.hud_music[i].glowalpha=1;
        if(isdefined(level.randomcolor))
            self.hud_music[i].glowcolor=level.randomcolor;
        else 
            self.hud_music[i].glowcolor=(1,0,0);
 
        entry = level.music[j];
        self.hud_music[i] setText(entry["song"]);
    }
 
    i++;
    self.hud_music[self.hud_music.size] = braxi\_mod::addTextHud( self, 167, 230, 0.4, "left", "top", 1.4 );
    self.hud_music[i].sort = 881;
    indicator = self.hud_music[self.hud_music.size-1];
    indicator setShader( "white", 306, 17 );
    indicator.color=(1,0,0);
 
    while(self.sessionstate == "playing")
    {
        wait 0.1;
 
        if(self attackButtonPressed())
        {
            self.hud_music[4+self.selection].alpha = 0.93;
 
            self.selection++;
            if( self.selection >= level.music.size )
                self.selection = 0;
 
            item = self.hud_music[4+self.selection];
            item.alpha = 1;
            indicator.y = item.y;
        }
        else if(self useButtonPressed())
        {
             iPrintLn("^1>> ^7Now playing: ^1"+level.music[self.selection]["song"]);
			 
            ambientPlay(level.music[self.selection]["alias"]);
            self freezeControls(0);
            break;
        }
        else if(self fragButtonPressed())
        {
            self freezeControls(0);
           break;
        }
    }
    
    if(!isdefined(self))
        return;
    if(isdefined(self.hud_music))
    {
        for(i=0;i<self.hud_music.size;i++)
        {
            if(isdefined(self.hud_music[i]))
                self.hud_music[i] destroy();
        }
    }
    self notify( "music thread terminated" );
}
