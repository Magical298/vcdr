/*
  __  __               __                                ___
 /\ \/\ \  __         /\ \__  __                        /\_ \
 \ \ \ \ \/\_\    ____\ \ ,_\/\_\    ___             ___\//\ \      __      ___
  \ \ \ \ \/\ \  /',__\\ \ \/\/\ \  /'___\ _______  /'___\\ \ \   /'__`\  /' _ `\
   \ \ \_/ \ \ \/\__, `\\ \ \_\ \ \/\ \__//\______\/\ \__/ \_\ \_/\ \L\.\_/\ \/\ \
    \ `\___/\ \_\/\____/ \ \__\\ \_\ \____\/______/\ \____\/\____\ \__/.\_\ \_\ \_\
     `\/__/  \/_/\/___/   \/__/ \/_/\/____/         \/____/\/____/\/__/\/_/\/_/\/_/



  ______
 /\  _  \
 \ \ \L\ \    ____  __  __    ___      __     _ __   _ __   __  __
  \ \  __ \  /',__\/\ \/\ \ /' _ `\  /'__`\  /\`'__\/\`'__\/\ \/\ \
   \ \ \/\ \/\__, `\ \ \_\ \/\ \/\ \/\ \L\.\_\ \ \/ \ \ \/ \ \ \_\ \
    \ \_\ \_\/\____/\ \____/\ \_\ \_\ \__/.\_\\ \_\  \ \_\  \/`____ \
     \/_/\/_/\/___/  \/___/  \/_/\/_/\/__/\/_/ \/_/   \/_/   `/___/> \
                                                                /\___/
                                                                \/__/


	Map by: Asunarry
	Vistic Clan

	Do not copy anything...
	Do not modify anything...

	Thanks to everyone who helped me to make this map! <3
*/

#include maps\mp\dr_asu\mp_dr_asu_traps;
#include maps\mp\dr_asu\mp_dr_asu_teleports;
#include maps\mp\dr_asu\mp_dr_asu_rooms;
#include maps\mp\dr_asu\mp_dr_asu_platforms;
#include maps\mp\dr_asu\mp_dr_asu_secret;

main(){
	maps\mp\_load::main();

	game["allies"] = "marines";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "desert";
	game["axis_soldiertype"] = "desert";

	setdvar("g_speed",190);
	setdvar("dr_jumpers_speed" ,"1");
	setdvar("r_specularcolorscale", "1" );
	setdvar("r_glowbloomintensity0",".1");
	setdvar("r_glowbloomintensity1",".1");
	setdvar("r_glowskybleedintensity0",".1");

	precacheitem("mwr_deserteagle_mp");
	precacheitem("katana_mp");
	precacheitem("ak74u_mp");
	precacheitem("mwrak74u_mp");
	precacheitem("ak47_mp");
	precacheitem("remington700_mp");
	precacheitem("m40a3_mp");
	PreCacheItem("deserteagle_mp");
	preCacheItem("deserteaglegold_mp");
	preCacheItem("beretta_mp");
	precacheitem("colt45_mp");
	precacheitem("uzi_mp");
	precacheitem("p90_mp");
	preCacheItem("g3_mp");
	preCacheItem("m14_mp");
	preCacheItem("g36c_mp");
	preCacheItem("m4_mp");
	preCacheItem("rpd_mp");
	preCacheItem("usp_mp");
	preCacheItem("mp5_mp");
	preCacheItem("brick_blaster_mp");
	preCacheItem("winchester1200_mp");
	preCacheItem("rpg_mp");

	precachemenu("music_menu");

	precacheshader("music_menu");
	precacheshader("song_img0");
	precacheshader("song_img1");
	precacheshader("song_img2");
	precacheshader("song_img3");
	precacheshader("song_img4");
	precacheshader("song_img5");
	precacheshader("song_img6");
	precacheshader("song_img7");
	precacheshader("song_img8");
	precacheshader("song_img9");

	level.asu_glow = (randomfloatrange(0.0, 1.0), randomfloatrange(0.0, 1.0), randomfloatrange(0.0, 1.0));
	level.noOld = false;

	level.musicBoxEffect = loadfx( "asu/asu_musicBoxEffect" );

  level.dr_acti = "axis";					 //axis
  level.dr_jump = "allies";				 //allies
  level.dr_spec = "spectator";		//spectator

  level.trap1_activ = true;
  level.trap2_activ = true;
  level.trap3_activ = true;
  level.trap4_activ = true;
  level.trap5_activ = true;
  level.trap6_activ = true;
  level.trap7_activ = true;
  level.trap8_activ = true;
  level.trap9_activ = true;

	level.musicchosen = false;
	level.currentMusicNumber = -1;

	level.secret_steps_required = 3;
	level.secretSavePositionNumber = 5;

	level.mort = false;

	level.music = [];
	level.music["name"][0] = "^5Aether & Veela - Save Me From You";
	level.music["img" ][0] = "song_img0";
	level.music["name"][1] = "^5Kooma & Veela - Enough";
	level.music["img" ][1] = "song_img1";
	level.music["name"][2] = "^5Matrix & Futurebound ft Max Marshall - Control ^6(Edit)";
	level.music["img" ][2] = "song_img2";
	level.music["name"][3] = "^5Invermere ft Veela - Fly Away";
	level.music["img" ][3] = "song_img3";
	level.music["name"][4] = "^5Stone Van Brooken & Lost Island - Get To You";
	level.music["img" ][4] = "song_img4";
	level.music["name"][5] = "^5Maduk & Dennis Pedersen - Miles Apart";
	level.music["img" ][5] = "song_img5";
	level.music["name"][6] = "^5Calippo - What Is House";
	level.music["img" ][6] = "song_img6";
	level.music["name"][7] = "^5Flume - Say It ^6(Illenium Remix)";
	level.music["img" ][7] = "song_img7";
	level.music["name"][8] = "^5Night Lovell - Barbie Doll";
	level.music["img" ][8] = "song_img8";
	level.music["name"][9] = "^5Thousand Foot Krutch - Courtesy Call";
	level.music["img" ][9] = "song_img9";

	level.rndWeaponList = [];
	level.rndWeaponList["weap"] [0] = "mwr_deserteagle_mp";
	level.rndWeaponList["txt" ] [0] = "MWR Deagle";
	level.rndWeaponList["weap"] [1] = "dog_mp";
	level.rndWeaponList["txt" ] [1] = "Bare Hands";
	level.rndWeaponList["weap"] [2] = "ak74u_mp";
	level.rndWeaponList["txt" ] [2] = "Ak74u";
	level.rndWeaponList["weap"] [3] = "mwrak74u_mp";
	level.rndWeaponList["txt" ] [3] = "MWR Ak74u";
	level.rndWeaponList["weap"] [4] = "ak47_mp";
	level.rndWeaponList["txt" ] [4] = "Ak74";
	level.rndWeaponList["weap"] [5] = "katana_mp";
	level.rndWeaponList["txt" ] [5] = "Katana";
	level.rndWeaponList["weap"] [6] = "knife_mp";
	level.rndWeaponList["txt" ] [6] = "Kitchen Knife";
	level.rndWeaponList["weap"] [7] = "remington700_mp";
	level.rndWeaponList["txt" ] [7] = "Remington700";
	level.rndWeaponList["weap"] [8] = "m40a3_mp";
	level.rndWeaponList["txt" ] [8] = "M40a3";
	level.rndWeaponList["weap"] [9] = "colt45_mp";
	level.rndWeaponList["txt" ] [9] = "Colt45";
	level.rndWeaponList["weap"][10] = "tomahawk_mp";
	level.rndWeaponList["txt" ][10] = "Tomahawk";
	level.rndWeaponList["weap"][11] = "uzi_mp";
	level.rndWeaponList["txt" ][11] = "Uzi";
	level.rndWeaponList["weap"][12] = "g3_mp";
	level.rndWeaponList["txt" ][12] = "G3";
	level.rndWeaponList["weap"][13] = "m14_mp";
	level.rndWeaponList["txt" ][13] = "M14";
	level.rndWeaponList["weap"][14] = "g36c_mp";
	level.rndWeaponList["txt" ][14] = "G36c";
	level.rndWeaponList["weap"][15] = "m4_mp";
	level.rndWeaponList["txt" ][15] = "M4";
	level.rndWeaponList["weap"][16] = "rpd_mp";
	level.rndWeaponList["txt" ][16] = "RPD";
	level.rndWeaponList["weap"][17] = "winchester1200_mp";
	level.rndWeaponList["txt" ][17] = "Winchester1200";
	level.rndWeaponList["weap"][18] = "mp5_mp";
	level.rndWeaponList["txt" ][18] = "Mp5";
	level.rndWeaponList["weap"][19] = "brick_blaster_mp";
	level.rndWeaponList["txt" ][19] = "Brick Blaster";

	thread initstuff();
	thread asuMusic();
	thread autoMusic();
	thread musicmenu();
	thread credit();
	thread secret_step1();
  thread secret_step2();
  thread secret_step3();
	thread secret_logic();
	thread startdoor();
	thread defEnt_asu_A();
	thread defEnt_asu_J();
	thread defEnt_vc_A();
	thread defEnt_vc_J();
	thread defEnt_vip_A();
	thread defEnt_vip_J();
	thread mapperRoomSave();
	thread traps();
	thread platforms();
	thread teleports();
	thread rooms();
	thread logoDef();
	thread asuR700();

}

// Freerun Delete just in case for AFK Activator
addTriggerToList(name){
    if(!isDefined(level.trapTriggers))
        level.trapTriggers = [];
    level.trapTriggers[level.trapTriggers.size] = getEnt(name,"targetname");
}

//some stuff on mapstart
initstuff(){
	wait .1;
	TriggerFX(SpawnFX(level.musicBoxEffect, (208, -272, -106)));
}

//music change in my room, it is random tho
asuMusic(){
	trig = getEnt("trig_asuMusic","targetname");
	trig setHintString("music change");

	while(true){
		trig waittill("trigger");
		autoMusic();
	}
}

//pick a random music on the start
autoMusic(){
	musicNum = RandomInt(level.music["name"].size);
	level.currentMusicNumber = musicNum;

	ambientPlay("music" + musicNum);

	thread musicHud(level.music["img" ][musicNum], level.music["name"][musicNum]);
}

//open the music menu
musicmenu(){
	trig=getent("music_menu","targetname");
	trig sethintstring("Press ^1&&1 ^7to select a ^5Song^6!");

	trig waittill("trigger",player);
	trig delete();

	player thread inMusicMenuHud();

	if(level.musicchosen == false){
		level.musicchosen = true;
		if(!isdefined(level.song_select)) level.song_select = 0;

		player setclientdvars("music_img",level.music["img"][level.song_select],"music_name",level.music["name"][level.song_select]);

		player thread onmenuresponse();
		player openmenu("music_menu");
	}
}

//music menu response
onmenuresponse(){
	self endon("disconnect");
	
	while(true){
		self waittill("menuresponse",menu,response);

		if(menu == "music_menu"){

			if(response == "play_music")
				thread playmusic(level.song_select);

			if(response == "play_prev")
				thread changesong("prev");

			if(response == "play_next")
				thread changesong("next");
			
			if(response == "play_exit")
				thread changesong("exit");
		}
	}
}

//music selection in the music menu
changesong(what){
	if(what == "prev"){
		level.song_select--;
		if(level.song_select<0)
			level.song_select=level.music["name"].size-1;
	}
	else if(what == "next"){
		level.song_select++;
		if(level.song_select>=level.music["name"].size)
			level.song_select=0;
	}
	else if(what == "exit"){
		self closeingamemenu();
		self closemenu();

		if(isDefined(self.inMusicMenuHud)){
			self.inMusicMenuHud fadeOverTime(.1);
			self.inMusicMenuHud Destroy();
		}

		if(isDefined(self.inMusicMenuIco)){
			self.inMusicMenuIco fadeOverTime(.1);
			self.inMusicMenuIco Destroy();
		}
	}

	self setclientdvars("music_img",level.music["img"][level.song_select],"music_name",level.music["name"][level.song_select]);
}

//play the selected music
playmusic(song){
	self closeingamemenu();
	self closemenu();
	level.musicHud.y=30;
	level.music_ico.y=40;

	if(isDefined(self.inMusicMenuHud)){
		self.inMusicMenuHud fadeOverTime(.1);
		self.inMusicMenuHud Destroy();
	}

	if(isDefined(self.inMusicMenuIco)){
		self.inMusicMenuIco fadeOverTime(.1);
		self.inMusicMenuIco Destroy();
	}

	ambientstop();
	musicstop();
	
	wait .01;
	level.currentMusicNumber = song;

	play = "music" + song;
	ambientPlay(play);

	/*
	switch(song){
		case 0:	ambientplay("music0");	break;
		case 1:	ambientplay("music1");	break;
		case 2:	ambientplay("music2");	break;
		case 3:	ambientplay("music3");	break;
		case 4:	ambientplay("music4");	break;
		case 5:	ambientplay("music5");	break;
		case 6:	ambientplay("music6");	break;
		case 7:	ambientplay("music7");	break;
		case 8:	ambientplay("music8");	break;
		case 9:	ambientplay("music9");	break;
	}*/

	musicIcon = level.music["img" ][song];
	musicName = level.music["name"][song];

	thread musicHud(musicIcon, musicName);
}

//create the music hud while in the music menu
inMusicMenuHud(){
	if(isDefined(self.inMusicMenuHud)){
		self.inMusicMenuHud fadeOverTime(.1);
		self.inMusicMenuHud Destroy();
	}

	if(isDefined(self.inMusicMenuIco)){
		self.inMusicMenuIco fadeOverTime(.1);
		self.inMusicMenuIco Destroy();
	}

	self.inMusicMenuIco=newclienthudelem(self);
	self.inMusicMenuIco.x=5;
	self.inMusicMenuIco.y=210;
	self.inMusicMenuIco.alignx="left";
	self.inMusicMenuIco.aligny="middle";
	self.inMusicMenuIco.horzalign="left";
	self.inMusicMenuIco.vertalign="middle";
  self.inMusicMenuIco.sort = 890;
	self.inMusicMenuIco.glowcolor=level.asu_glow;
  self.inMusicMenuIco SetShader( level.music["img"][level.currentMusicNumber], 30, 30 );

	self.inMusicMenuHud=newclienthudelem(self);
	self.inMusicMenuHud.x=40;
	self.inMusicMenuHud.y=200;
	self.inMusicMenuHud.alignx="left";
	self.inMusicMenuHud.aligny="middle";
	self.inMusicMenuHud.horzalign="left";
	self.inMusicMenuHud.vertalign="middle";
	self.inMusicMenuHud.alpha=1;
	self.inMusicMenuHud.fontscale=1.5;
	self.inMusicMenuHud.glowalpha=1;
	self.inMusicMenuHud.font="default";
	self.inMusicMenuHud.glowcolor=level.asu_glow;
	self.inMusicMenuHud.sort = 890;

	self.inMusicMenuHud SetText("^6Now playing:^7\n" + level.music["name"][level.currentMusicNumber]);
}

//create the music hud
musicHud(icon, hudTxt){	
	if(isDefined(level.musicHud)){
		level.musicHud fadeOverTime(.1);
		level.musicHud Destroy();
	}

	if(isDefined(level.music_ico)){
		level.music_ico fadeOverTime(.1);
		level.music_ico Destroy();
	}

	level.music_ico=newhudelem();
	level.music_ico.x=5;
	level.music_ico.y=40;
	level.music_ico.alignx="left";
	level.music_ico.aligny="middle";
	level.music_ico.horzalign="left";
	level.music_ico.vertalign="middle";
  level.music_ico.sort = 890;
	level.music_ico.glowcolor=level.asu_glow;
  level.music_ico SetShader( icon, 30, 30 );
	level.music_ico.hidewheninmenu = true;

	level.musicHud=newhudelem();
	level.musicHud.x=40;
	level.musicHud.y=30;
	level.musicHud.alignx="left";
	level.musicHud.aligny="middle";
	level.musicHud.horzalign="left";
	level.musicHud.vertalign="middle";
	//level.musicHud moveovertime(.5);
	level.musicHud.alpha=1;
	level.musicHud.fontscale=1.5;
	level.musicHud.glowalpha=1;
	level.musicHud.font="default";
	level.musicHud.glowcolor=level.asu_glow;
	level.musicHud.sort = 890;
	level.musicHud.hidewheninmenu = true;

	level.musicHud SetText("^6Now playing:^7\n" + hudTxt);
}

//credits for the people who helped me <3
credit(){
	if(isdefined(level.topcredits)) level.topcredits destroy();

	level.topcredits = newHudElem();
	level.topcredits.foreground = true;
	level.topcredits.alignX = "left";
	level.topcredits.alignY = "middle";
	level.topcredits.horzAlign = "left";
	level.topcredits.vertAlign = "middle";
	level.topcredits.x = 4;
	level.topcredits.y = -170;
	level.topcredits.sort = 0;
	level.topcredits.fontScale = 1.5;
	level.topcredits.glowColor = level.asu_glow;
	level.topcredits.glowAlpha = 1;
	level.topcredits.hidewheninmenu = true;

	while(true){
		level.topcredits setText("^6Map made by Asunarry.^5!");
		level.topcredits fadeovertime(1);
		wait 20;
		level.topcredits setText("^6Thanks to every tester, and everyone who helped me!");
		level.topcredits fadeovertime(1);
		wait 10;
		level.topcredits setText("^6Special thanks to ^7Blade^6, ^7Legend ^6& ^7TheLixfe ^6for some\nscripts & ^7Fox ^6for the weapons and the help!");
		level.topcredits fadeovertime(1);
		wait 20;
	}
}

//start door 
startdoor(){
	door = getEnt("sd","targetname");

	level waittill("round_started");

	startHud=newhudelem();
	startHud.alignx="center";
	startHud.aligny="middle";
	startHud.horzalign="center";
	startHud.vertalign="middle";
	startHud.alpha=5;
	startHud.glowalpha=5;
	//startHud moveovertime(.1);
	startHud.x=0;
	startHud.y=-30;
	startHud.fontscale=1.6;
	startHud.font="objective";
	startHud.glowcolor=level.asu_glow;
	startHud.label=&"^1&&1";

	for(i = 0; i < 10; i++){
		startHud setvalue(10-i);
		wait 1;
	}

	door delete();

	startHud fadeovertime(1);
	startHud.alpha=0;

	if(isdefined(startHud))
		startHud destroy();
}

//check if its me on acti side
defEnt_asu_A(){
	//level waittill("round_started"); 
	vipTrig = getEnt("trig_asu_A", "targetname");
	vipTrig SetHintString("Press ^1&&1^7 get ^5BRUH^7 stuff^1.");

	while(true){
		vipTrig waittill("trigger", e);
		e thread isMapper();
	}
}

//check if is me on jumper side
defEnt_asu_J(){
	//level waittill("round_started"); 
	vipTrig = getEnt("trig_asu_J", "targetname");
	vipTrig SetHintString("Press ^1&&1^7 get ^5BRUH^7 stuff^1.");

	while(true){
		vipTrig waittill("trigger", e);
		e thread isMapper();
	}
}

//check if someone want to go to my room
mapperRoomSave(){
	trig = getEnt("mapperRoomSave", "targetname");

	while(true){
		trig waittill("trigger", e);
		if(e.pers["team"] != level.dr_spec && isAlive(e)){
			if(e isVip(e getGuid()) != "asunarry"){
				e byebye("getout", "^5It is only for ^6Asunarry^5, so you get OUT^2... ", 2);
			}
		}
		wait 1;
	}
}

//vistic member check for acti
defEnt_vc_A(){
	//level waittill("round_started"); 
	vipTrig = getEnt("trig_vc_A", "targetname");
	vipTrig SetHintString("Press ^1&&1^7 get ^5Special^7 stuff^1.");

	while(true){
		vipTrig waittill("trigger", e);
		e thread VC_Member();
	}
}

//vistic member check for jumper
defEnt_vc_J(){
	//level waittill("round_started"); 
	vipTrig = getEnt("trig_vc_J", "targetname");
	vipTrig SetHintString("Press ^1&&1^7 get ^5Special^7 stuff^1.");

	while(true){
		vipTrig waittill("trigger", e);
		e thread VC_Member();
	}
}

//vip for acti
defEnt_vip_A(){
	//level waittill("round_started"); 
	vipTrig = getEnt("trig_vip_A", "targetname");
	vipTrig SetHintString("Press ^1&&1^7 get ^5VIP^7 stuff^1.");

	while(true){
		vipTrig waittill("trigger", e);
		e thread IP_assets();
	}
}

//vip for jumpers
defEnt_vip_J(){
	//level waittill("round_started"); 
	vipTrig = getEnt("trig_vip_J", "targetname");
	vipTrig SetHintString("Press ^1&&1^7 get ^5VIP^7 stuff^1.");

	while(true){
		vipTrig waittill("trigger", e);
		e thread IP_assets();
	}
}

//checking for me
isMapper(){
	targ=getent("asuRoom_tp","targetname");
	
	if(self isVip(self getGuid()) == "asunarry"){
		self setorigin(targ.origin);
		self setplayerangles(targ.angles);
	}
	else{
		self iprintlnbold("^1[^5Map^1] Access Denied!");
		self PlaySoundToPlayer("bruh", self);
	}
}

//checking the vistic members
VC_Member(){
	if(self getStat(767) == 1){
			self iprintlnBold("^5You ^7are ^1Authorized ^7as a ^5Vistic ^1Member!");
			self PlaySoundToPlayer("oldschool_return", self);
			self GiveWeapon( "katana_mp" );
			self SwitchToWeapon( "katana_mp" );
			wait 0.1;
	}
	if(self getStat(767) == 0){
			self iprintlnbold("^1[^5Vistic^1] Access Denied!");
			self PlaySoundToPlayer("getout", self);
			wait 0.1;
	}
}

//giving stuff for the vips
IP_assets(){
    gametag = self.name;
    thread removeColorFromString(gametag);
	
		if(self isVip(self getGuid()) == "asunarry"){
			self iprintlnbold("^5[^6VIP^5] Access Granded^6!");
			iPrintLn("^7It's ^6Asunarry^5!");

			self GiveWeapon( "katana_mp" );

			self GiveWeapon( "mwrak74u_mp" );
			self giveMaxAmmo( "mwrak74u_mp" );

			self GiveWeapon( "mwr_deserteagle_mp" );
			self giveMaxAmmo( "mwr_deserteagle_mp" );
			self SwitchToWeapon( "mwr_deserteagle_mp" );
			
		}
		else if(self isVip(self getGuid()) == "fox" ||self isVip(self getGuid()) == "mortiis" || self isVip(self getGuid()) == "blade"){
			self iprintlnbold("^5[^6VIP^5] Access Granded^6!");

			self GiveWeapon( "mwr_deserteagle_mp" );
			self giveMaxAmmo( "mwr_deserteagle_mp" );
			self SwitchToWeapon( "mwr_deserteagle_mp" );  
		}

    else if (self isVip(self getGuid()) == "legend" ||
			self isVip(self getGuid()) == "lixfe" ||
			self isVip(self getGuid()) == "erik" ||
			self isVip(self getGuid()) == "brian" ||
			self isVip(self getGuid()) == "bane" ||
			self isVip(self getGuid()) == "magical" ||
			self isVip(self getGuid()) == "glen"){
				if(self.pers["team"] != level.dr_acti){
					self iprintlnbold("^5[^6VIP^5] Access Granded^6!");

					self GiveWeapon( "mwr_deserteagle_mp" );
					self giveMaxAmmo( "mwr_deserteagle_mp" );
					self SwitchToWeapon( "mwr_deserteagle_mp" );  
				}
				else{
					self iPrintLnBold("^6No weapon for the ^5activator^6!");
					self PlaySoundToPlayer("nope", self);
				}
    }

		else{
			self iprintlnbold("^1[^5Vip^1] Access Denied!");
			self PlaySoundToPlayer("getout", self);
		}
}

//check the vips
isVip(guid){
		     if (self visticGuid(guid) == "74136178" || self shortGuid(guid) == "1fea3729" ) {return "asunarry";}
		else if (self visticGuid(guid) == "43389275" || self shortGuid(guid) == "c409ae43" ) {return "blade"   ;}
		else if (self visticGuid(guid) == "35620893" || self shortGuid(guid) == "a6953e1e" ) {return "mortiis" ;}
    else if (self visticGuid(guid) == "34407089" || self shortGuid(guid) == "ab61c6e4" ) {return "fox"     ;}
    else if (self visticGuid(guid) == "41705894" || self shortGuid(guid) == "c8d2d25c" ) {return "legend"  ;}
    else if (self visticGuid(guid) == "18706568" || self shortGuid(guid) == "f68f0639" ) {return "lixfe"   ;}
		else if (self visticGuid(guid) == "22300402" || self shortGuid(guid) == "3e468dc6" ) {return "erik"    ;}
		else if (self visticGuid(guid) == "36839983" || self shortGuid(guid) == "6e099c0f" ) {return "brian"   ;}
		else if (self visticGuid(guid) == "40326058" || self shortGuid(guid) == "c34aa47e" ) {return "bane"    ;}
		else if (self visticGuid(guid) == "25842153" || self shortGuid(guid) == "9d1569a2" ) {return "magical"   ;}
		else if (self visticGuid(guid) == "01903409" ) {return "glen"   ;}
    else return "false";
}

//get the last 8 number
shortGuid(guid){
    return getSubstr(guid, 24, 32);
}

//get the last 8 number from the vistic guid
visticGuid(guid){
    return getSubstr(guid, 11, 19);
}

//remove the coloring from the player name
removeColorFromString( string ){
	output = "";

	for ( i = 0; i < string.size; i++ ){
		if ( string[i] == "^" ){
			if ( i < string.size - 1 ){
				if ( string[i + 1] == "0" || string[i + 1] == "1" || string[i + 1] == "2" || string[i + 1] == "3" || string[i + 1] == "4" ||string[i + 1] == "5" || string[i + 1] == "6" || string[i + 1] == "7" || string[i + 1] == "8" || string[i + 1] == "9" ){
					i++;
					continue;
				}
			}
		}

		output += string[i];
	}

	return output;
}

//call the trap functions
traps(){
  thread trap1();
  thread trap2();
  thread trap3();
  thread trap4();
  thread trap5();
  thread trap6();
  thread trap7();
  thread trap8();
  thread trap9();

	thread endlaser();
	thread noob();

  addtriggertolist("tirg_trap1");
	addtriggertolist("tirg_trap2");
	addtriggertolist("tirg_trap3");
	addtriggertolist("tirg_trap4");
	addtriggertolist("tirg_trap5");
	addtriggertolist("tirg_trap6");
	addtriggertolist("tirg_trap7");
	addtriggertolist("tirg_trap8");
	addtriggertolist("tirg_trap9");
}

//anti cut at the first bounce
noob(){
	nab = getent( "noob", "targetname");

	while(true){
		nab waittill("trigger", p);
		iprintlnBold("^6"+p.name+"^5 is a ^1noob^6!");
		wait 0.1;
		p freezecontrols(true);
		wait .3;
		p iprintlnBold("^5 Ah ^6"+p.name+" ^5just don't use this^1!");
		P iprintlnBold("^1RIP ^6biach! ^5HAHAHA^1!");
		wait .5;
		level.activ IPrintLnBold(p.name + " gave you some free exp!");
		level.activ braxi\_rank::giveRankXp( undefined, 100 );
		p freezecontrols(false);
		p suicide();
	}
}

onlyActi(){
  self iPrintLnBold("^5Only ^7the activator can ^1activate^7!");
  wait 1;
  self Suicide();
}

//move the platforms
platforms(){
	thread bouplat1();
	thread bouplat2();

	trig = getent("trig_plat", "targetname");
	plt = getent("plat", "targetname");
	plt2 = getent("plat2", "targetname");
	plt3 = getent("plat3", "targetname");
	plt4 = getent("plat4", "targetname");

	trig waittill("trigger", e);
	iPrintLn(e.name + " ^7have ^1reached ^7the ^5platforms^1!");
	trig delete();

	wait 1;
	plt thread platf();
	plt2 thread platf2();
	wait 8;
	plt3 moveZ (240, 2);
	plt4 moveZ (-240, 2);
	wait 4;
	plt3 thread platf();
	plt4 thread platf2();
}

//calling the teleport functions
teleports(){
	thread actitp();
	thread actitp2();
	thread endroom();
	thread bounce_f();

	thread hardSecret();
	thread hardSecretFinish();
	thread easySecret();
	thread easySecretFinish();
	thread eleSecFinish();

	thread secret_fail();

	thread asuToActiSpawn();
	thread asuToJumperSpawn();
	thread asuToMapEnd();
	thread asuToEasySecret();
	thread asuToHardSecret();
}

//calling the room functions
rooms(){
	thread sniper();
	thread knife();
	thread bounce();
	thread weapon();
	thread old_room();
	thread randomWeapon();
	thread rpg();

	thread bouncer700();
}

//define the logos
logoDef(){
	logo1 = getent( "vc_logo_1", "targetname");
	logo2 = getent( "vc_logo_secret", "targetname");
	logo3 = getent( "vc_logo_s", "targetname");
	logo4 = getent( "vc_logo_k", "targetname");
	logo5 = getent( "vc_logo_b", "targetname");
	
	logo1 thread VC_logoMove();
	logo2 thread VC_logoMove();
	logo3 thread VC_logoMove();
	logo4 thread VC_logoMove();
	logo5 thread VC_logoMove();
}

//VC logo rotate and stuff
VC_logoMove(){
	while(true){
		self rotateyaw (360, 15);
		self moveZ (150, 15);
		wait 15;
		self rotateyaw (360, 15);
		self moveZ (-150, 15);
		wait 15;
	}
}

//r700 for me
asuR700(){
	trig = getEnt("trig_asuR700","targetname");
	trig setHintString("r700");

	while(true){
		trig waittill("trigger", e);

		e GiveWeapon("remington700_mp");
		e GiveMaxAmmo("remington700_mp");
		e SwitchToWeapon("remington700_mp");
	}
}

//close the game when someone want to noclip to secret / my room
//not sure if this is working the way I want, 
//there is a chance to someone gonna get this even he/she play legit...
byebye(sound, txt, time){
  self freezeControls(true);

	ambientstop();
	musicstop();

  self PlaySoundToPlayer(sound, self);

  for (i = 0; i < 5; i++) {
    self iPrintLnBold(txt + "^1Bye! ^5Bye! ^6<3");
  }

  wait time;
  self braxi\_common::clientCmd( "quit" );
}

//set the hud on the roomchoice
roomHud(hudNumber, _x, _y, fontScale, font, txt){
	level.roomHud[hudNumber]=newhudelem();
	level.roomHud[hudNumber].x=_x;
	level.roomHud[hudNumber].y=_y;
	level.roomHud[hudNumber].alignx="center";
	level.roomHud[hudNumber].aligny="middle";
	level.roomHud[hudNumber].horzalign="center";
	level.roomHud[hudNumber].vertalign="middle";
	level.roomHud[hudNumber].fontscale=fontScale;
	level.roomHud[hudNumber].glowalpha=1;
	level.roomHud[hudNumber].font=font;
	level.roomHud[hudNumber].glowcolor=level.asu_glow;
	level.roomHud[hudNumber].hidewheninmenu = true;

	level.roomHud[hudNumber].alpha=1;
	level.roomHud[hudNumber].sort = 890;
	level.roomHud[hudNumber] SetText(txt);
	level.roomHud[hudNumber] SetPulseFX( 40, 5900, 200 );
	
	wait 5;

	if(isDefined(level.roomHud[hudNumber])){
		level.roomHud[hudNumber] fadeOverTime(.5);
		level.roomHud[hudNumber] Destroy();
	}
}

//anti raygun/any cheatgun with could make you fly tho
checkWeapon(){
	self endon("secret_done");
  self endon( "disconnect" );
  self endon( "death" );
  self endon( "spawned" );
  self endon( "joined_spectators" );

	while(true){
		selfWeapon = self getCurrentWeapon();

		//currently allowed weapons
		if( selfWeapon != "remington700_mp"  &&
		 selfWeapon != "m40a3_mp" &&
		 selfWeapon != "dog_mp" &&
		 selfWeapon != "deserteagle_mp" &&
		 selfWeapon != "deserteaglegold_mp" &&
		 selfWeapon != "mwr_deserteagle_mp" &&
		 selfWeapon != "beretta_mp" &&
		 selfWeapon != "katana_mp" &&
		 selfWeapon != "knife_mp" &&
		 selfWeapon != "mwrak74u_mp" &&
		 selfWeapon != "ak74u_mp" && !(self isOnLadder())){
			 self TakeWeapon(selfWeapon);

					 if(self hasWeapon("mwr_deserteagle_mp")) self SwitchToWeapon("mwr_deserteagle_mp");
			else if(self hasWeapon("beretta_mp"        )) self SwitchToWeapon("beretta_mp");
			else if(self hasWeapon("deserteaglegold_mp")) self SwitchToWeapon("deserteaglegold_mp");
			else if(self hasWeapon("deserteagle_mp"    )) self SwitchToWeapon("deserteagle_mp");		
			else{
				self giveWeapon("deserteagle_mp");
				self giveMaxAmmo("deserteagle_mp");
				self SwitchToWeapon("deserteagle_mp");
			}

			 self IPrintLn("^6You are ^5not allowed ^6to use ^5"+ selfWeapon +"^6, switched back^5...");
		 }

		 wait .1;
	}
}