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

main(){
	maps\mp\_load::main();

	game["allies"] = "marines";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "desert";
	game["axis_soldiertype"] = "desert";

	//setdvar("g_speed",190);
	//setdvar("dr_jumpers_speed" ,"1");
	setdvar("r_specularcolorscale", "1" );
	setdvar("r_glowbloomintensity0",".1");
	setdvar("r_glowbloomintensity1",".1");
	setdvar("r_glowskybleedintensity0",".1");

  level.bounceWeapon = "ak74u_mp";
  level.secretWeapon = "deserteagle_mp";

  precacheitem(level.bounceWeapon);
  PreCacheItem(level.secretWeapon);

  level.knifeFight = false;

  level.secretTimer = 60;

  level.trapActive = [];
  level.trapsize = 5;

  level.pickedMusic = -1;

  level.music = [];
  level.music[0]["file"] = "music0";
  level.music[0]["title"] = "^5Excision x Wooli x Trivecta - ^6Oxygen (ft. Julianne Hope)";
  level.music[1]["file"] = "music1";
  level.music[1]["title"] = "^5Yoste - ^6Chihiro";
  level.music[2]["file"] = "music2";
  level.music[2]["title"] = "^5AK ft Veela - ^6Parallel Worlds";
  level.music[3]["file"] = "heavy";
  level.music[3]["title"] = "^5Linkin Park (feat. Kiiara) - ^6Heavy";


  thread startGate();
  thread music();
  thread traps();
  thread teleports();
  thread rooms();
  thread actiSecret();
  thread secret();
}

// Freerun Delete just in case for AFK Activator
addTriggerToList(name){
    if(!isDefined(level.trapTriggers))
        level.trapTriggers = [];
    level.trapTriggers[level.trapTriggers.size] = getEnt(name,"targetname");
}

startGate(){
  level waittill("round_started");
  
  wait 5;
  IPrintLnBold("^53");
  wait 1;
  IPrintLnBold("^52");
  wait 1;
  IPrintLnBold("^51");
  wait 1;

  getEnt("start_gate", "targetname") Delete();
}

music(){
  level waittill("round_started");
  level.pickedMusic = RandomInt(3);

  ambientstop();
	musicstop();
  IPrintLn("^5Music:\n" + level.music[level.pickedMusic]["title"] + "\n");
  ambientPlay(level.music[level.pickedMusic]["file"]);

  while(true){
    wait 40;
    IPrintLn("^5Music:\n" + level.music[level.pickedMusic]["title"] + "\n");
  }
}

traps(){
  addtriggertolist("tirg_trap1");
  addtriggertolist("tirg_trap2");
  addtriggertolist("tirg_trap3");
  addtriggertolist("tirg_trap4");
  addtriggertolist("tirg_trap5");

  thread trapIslands();

  thread trap1();
  thread trap2();
  thread trap3();
  thread trap4();
  thread trap5();
}

teleports(){
  thread mapTeleports();
  thread actiTeleports();
}

rooms(){
  thread endroom();
  thread sniper();
  thread knife();
  thread bounce();

  thread bounce_f();
  thread bounce_weapon();
}

bounce_weapon(){
  trig = getEnt("trig_bounceWeapon", "targetname");
  trig SetHintString("Press ^5&&1^7 to pickup the weapon!");

  while(true){
    trig waittill("trigger", player);

    if(!player HasWeapon(level.bounceWeapon)){
      player GiveWeapon(level.bounceWeapon);
      player GiveMaxAmmo(level.bounceWeapon);
      player SwitchToWeapon(level.bounceWeapon);
      IPrintLnBold(player.name + " got the ^5weapon^7!");
    } else {
      player GiveMaxAmmo(level.bounceWeapon);
    }
  }
}

actiSecret(){
  trigs = [];
  trigCount = 7;

  for(i = 0; i < trigCount; i++){
    trigs[i] = getEnt("trig_actisecret" + (i+1), "targetname");
  }

  for(i = 0; i < trigCount - 1; i++){
    trigs[i] waittill("trigger", player);
    player IPrintLn("^5Found a step!");
    trigs[i] Delete();
  }

  trigs[trigCount - 1] waittill("trigger", player);
  player IPrintLn("^5Found a the activator secret!");
  trigs[trigCount - 1] Delete();

  org = getEnt("targ_actifail4", "targetname");
  player SetOrigin(org.origin);
  player SetPlayerAngles(org.angles);

  player thread actiSecFinish();
  player thread actiSecGiveUp();
}

actiSecFinish(){
  self endon("actisecover");

  trig = getEnt("trig_actiSecFinish", "targetname");
  trig waittill("trigger", player);

  org = getEnt("targ_actifail1", "targetname");
  player SetOrigin(org.origin);
  player SetPlayerAngles(org.angles);
  IPrintLnBold("^5" + player.name + " ^7finished the ^5activator ^7secret!");
  player braxi\_rank::giveRankXp( undefined, 500 );
  self notify("actisecover");
}

actiSecGiveUp(){
  self endon("actisecover");

  trig = getEnt("trig_actiSecGiveUp", "targetname");
  trig SetHintString("Press ^5&&1^7 to leave the secret!");
  trig waittill("trigger", player);

  org = getEnt("targ_actifail1", "targetname");
  player SetOrigin(org.origin);
  player SetPlayerAngles(org.angles);
  player IPrintLnBold("You left the ^5secret^7, no reward were given!");
  self notify("actisecover");
}

secret(){
  trigs = [];
  trigCount = 3;

  for(i = 0; i < trigCount; i++){
    trigs[i] = getEnt("trig_sec" + (i+1), "targetname");
  }

  trigs[0] waittill("trigger");

  if(RandomInt(3) == 0){
     level.pickedMusic = 3;

    ambientstop();
    musicstop();
    IPrintLn("^5Music:\n" + level.music[level.pickedMusic]["title"] + "\n");
    ambientPlay(level.music[level.pickedMusic]["file"]);
  }
 

  trigs[1] waittill("trigger");

  thread secFin();
  thread secFail();
  thread secSave();
  
  while(true){
    trigs[2] waittill("trigger", player);

    player thread doSecret();
  }
}

secSave(){
  saveCount = 3;
  
  for(i = 0; i < saveCount; i++){
    thread secSavePoints(i);
  }
}

secSavePoints(i){
  trig = getEnt("trig_secSave" + i, "targetname");

  while(true){
    trig waittill("trigger", player);

    if(i != player.secPos){
      player.secPos = i;
      player IPrintLn("^5Savepoint saved!");
    }
  }
}

secFail(){
  orgCount = 3;
  orgs = [];

  for(i = 0; i < orgCount; i++){
    orgs[i] = getEnt("targ_secFail" + i, "targetname");
  }

  trig = getEnt("trig_secFail", "targetname");

  while(true){
    trig waittill("trigger", player);

    player thread teleportPlayer(orgs[player.secPos], .1);
    player IPrintLn("^5Savepoint loaded!");
  }
}

secFin(){
  targ = getEnt("targ_secFin", "targetname");
  trig = getEnt("trig_SecFinish", "targetname");

  while(true){
    trig waittill("trigger", player);

    player notify("secret_done");
    player thread teleportPlayer(targ, .1);
    player braxi\_rank::giveRankXp( undefined, 500 );
    player.secPos = 0;
    IPrintLn("^5" + player.name + " has finished the secret!");
  }
}

doSecret(){
  if(!isDefined(self.secStep)){
      self.secStep = 0;
  }

  if(self.secStep < 4){
    self.secStep++;
    return;
  }

  self.secPos = 0;

  org = getEnt("targ_secFail0", "targetname");
  self GiveWeapon(level.secretWeapon);
  self GiveMaxAmmo(level.secretWeapon);
  self SwitchToWeapon(level.secretWeapon);
  self thread teleportPlayer(org, .1);
  wait .1;
  IPrintLn("^5" + self.name + " has entered the secret!");
  self IPrintLn("^5Savepoint saved!");
  self thread secret_timer(level.secretTimer);
}

secret_timer(time){
  self endon("secret_done");
  self endon( "disconnect" );
  self endon( "death" );
  self endon( "spawned" );
  self endon( "joined_spectators" );

  if(isdefined(self.secretTimer)){
    self.secretTimer destroy();
  }

  self thread timerRemoveWhenDead();
  self thread timerRemoveWhenFinish();

  self.secretTimer=newclienthudelem(self);
  self.secretTimer.foreground = true;
  self.secretTimer.alignX = "center";
  self.secretTimer.alignY = "bottom";
  self.secretTimer.horzAlign = "center";
  self.secretTimer.vertAlign = "bottom";
  self.secretTimer.x = 0;
  self.secretTimer.y = -7;
  self.secretTimer.sort = 5;
  self.secretTimer.fontScale = 1.6;
  self.secretTimer.font = "default";
  self.secretTimer.glowAlpha = 1;
  self.secretTimer.hidewheninmenu = true;
  self.secretTimer.label = &"Time in left: ^1&&1";
  if(isdefined(level.randomcolor))
  self.secretTimer.glowColor=level.randomcolor;
  else
  self.secretTimer.glowColor=(0,0,1);

  for(i=0;i<time;i++){
    self.secretTimer setvalue(time-i);
    wait 1;
  }


  self iPrintLnBold("^5Sadly you ran out of time!^7");
  self.secretTimer setvalue(0);
  self suicide();

  if(isdefined(self.secretTimer)){
    wait 0.1;
    self.secretTimer = 0;
    self.secretTimer destroy();
  }
}

//remove the secret timer on your dead
timerRemoveWhenDead(){
  self waittill("death");
  self.secPos = 0;
  if(isdefined(self.secretTimer)){
    self.secretTimer destroy();
  }
}

//remove the secret timer when you finish the secret
timerRemoveWhenFinish(){
  self waittill("secret_done");

  if(isdefined(self.secretTimer)){
    self.secretTimer destroy();
  }
}

/////////////////
//    Traps    //
/////////////////
trapIslands(){
  //level waittill("round_started");

  level.trapActive[0] = false;
  for(i = 1; i <= level.trapsize; i++){
    level.trapActive[i] = true;
    thread floatingIslands(i);
  }
}

floatingIslands(num){
  ent = getEnt("island_trap" + num, "targetname");

  ent thread islandRotate(num);
  ent thread islandFloat(num);
}

islandRotate(num){
  time = 5;
  _time = time / 4;
  rot = 360;

  while(level.trapActive[num]){
    self RotateYaw(rot, time, _time, _time);
    self waittill("rotatedone");
    rot *= -1;
  }
}

islandFloat(num){
  time = 5;
  _time = time / 4;
  
  while(level.trapActive[num]){
    self MoveZ(20, time, _time, _time);
    self waittill("movedone");
    self MoveZ(-20, time, _time, _time);
    self waittill("movedone");
  }

  self MoveZ(-15, time, _time, _time);
}

trap1(){
  ents = [];
  ents = GetEntArray("trap1", "targetname");
  trig = GetEnt("trig_trap1", "targetname");

  trig SetHintString("Press ^5&&1^7 to activate^5!^7");
  trig waittill("trigger", player);

  level.trapActive[1] = false;

  player braxi\_rank::giveRankXp( undefined, 100 );

  dist = 1000;

  for(i = 0; i < 3; i++){
    ents[i] thread trap1Move(dist);
    dist *= -1;
  }

  trig SetHintString("You ^5activated ^7this trap^5!^7");
}

trap1Move(n){
  self Movex(n/2, 1, .2, .2);
  self waittill("movedone");
  n *= -1;
  wait 1;

  while(isDefined(self)){
    self MoveX(n, 2, .4, .4);
    self waittill("movedone");
    n *= -1;
    wait 1;
  }
}

trap2(){
  ent = getEnt("trap2", "targetname");
  trig = GetEnt("trig_trap2", "targetname");

  trig SetHintString("Press ^5&&1^7 to activate^5!^7");
  trig waittill("trigger", player);

  level.trapActive[2] = false;

  player braxi\_rank::giveRankXp( undefined, 100 );

  rot = 360;

  if(RandomInt(2) == 0){
    rot *= -1;
  }

  ent thread trap2Rot(rot);
  ent thread trap2Visible();

  trig SetHintString("You ^5activated ^7this trap^5!^7");
}

trap2Rot(n){
  self waittill("trap2visibilityready");
  wait .01;
  while(isDefined(self)){
    self notify("trap2rotatebegin");
    self RotatePitch(n, 3, 1, 1);
    self waittill("rotatedone");
    
    if(RandomInt(2) == 0){
      n *= -1;
    }
    
    wait 1;
  }
}

trap2Visible(){
  self notify("trap2visibilityready");
  while(isDefined(self)){
    self waittill("trap2rotatebegin");
    wait .7;
    self Hide();
    wait 1.6;
    self Show();
  }
}

trap3(){
  ent = getEnt("trap3", "targetname");
  hurt = getEnt("hurt_trap3", "targetname");
  trig = GetEnt("trig_trap3", "targetname");

  hurt EnableLinkTo();
  hurt LinkTo(ent);

  trig SetHintString("Press ^5&&1^7 to activate^5!^7");
  trig waittill("trigger", player);

  level.trapActive[3] = false;

  player braxi\_rank::giveRankXp( undefined, 100 );

  rot = 360;

  if(RandomInt(2) == 0){
    rot *= -1;
  }

  ent thread trap3Rot(rot);

  trig SetHintString("You ^5activated ^7this trap^5!^7");
}

trap3Rot(n){
  wait .01;
  while(isDefined(self)){
    self RotateYaw(n, 2);
    self waittill("rotatedone");
    
    if(RandomInt(2) == 0){
      n *= -1;
    }
  }
}

trap4(){
  //ents = [];
  obj = [];
  hurts = [];
  obj = GetEntArray("trap4", "targetname");
  hurts = GetEntArray("hurt_trap4", "targetname");
  trig = GetEnt("trig_trap4", "targetname");

  dist = -600;

  for(i = 0; i < obj.size; i++){
    //ents[i]["obj"] = obj[i];
    //ents[i]["hurt"] = hurts[i];

    //hurts[i] EnableLinkTo();
    //hurts[i] LinkTo(obj[i]);
    
    obj[i] NotSolid();
    obj[i] Hide();

    x = RandomInt(3);

    switch(x) {
      case 0:
        obj[i].align = "right";
        break;
    
      case 1:
        obj[i].align = "middle";
        obj[i] MoveX(dist, .1);
        break;
    
      case 2:
        obj[i].align = "left";
        obj[i] MoveX(dist * 2, .1);
        break;
    }

    //hurts[i] Unlink();
    hurts[i] maps\mp\_utility::triggerOff();
  }

  trig SetHintString("Press ^5&&1^7 to activate^5!^7");
  trig waittill("trigger", player);

  level.trapActive[4] = false;

  player braxi\_rank::giveRankXp( undefined, 100 );

  for(i = 0; i < obj.size; i++){
    obj[i] Solid();
    obj[i] Show();
    //hurts[i] maps\mp\_utility::triggerOn();

    //hurts[i] EnableLinkTo();
    //hurts[i] LinkTo(obj[i]);

    switch(obj[i].align) {
      case "left":
        obj[i].align = "right";
        obj[i] thread trap4Move(dist * -2, dist);
        break;
    
      case "middle":
        if(RandomInt(2) == 0){
          obj[i].align = "right";
          obj[i] thread trap4Move(dist * -1, dist);
        } else {
          obj[i].align = "left";
          obj[i] thread trap4Move(dist, dist);
        }
        break;
    
      case "right":
        obj[i].align = "left";
        obj[i] thread trap4Move(dist * 2, dist);
        break;
    }
  }

  trig SetHintString("You ^5activated ^7this trap^5!^7");
}

trap4Move(n, _n){
  while(isDefined(self)){
    self MoveX(n, 2, .4, .4);
    self waittill("movedone");

    n = _n;

    switch(self.align) {
      case "left":
        if(RandomInt(2) == 0){
          self.align = "right";
          n *= -2;
        } else {
          self.align = "middle";
          n *= -1;
        }
        break;
    
      case "middle":
        if(RandomInt(2) == 0){
          self.align = "right";
          n *= -1;
        } else {
          self.align = "left";
        }
        break;
    
      case "right":
        if(RandomInt(2) == 0){
          self.align = "left";
          n *= 2;
        } else {
          self.align = "middle";
        }
        break;
    }

    wait RandomFloatRange(.1, 1);
  }
}

trap5(){
  ents = [];
  ents = GetEntArray("trap5", "targetname");
  trig = GetEnt("trig_trap5", "targetname");

  trig SetHintString("Press ^5&&1^7 to activate^5!^7");
  trig waittill("trigger", player);

  level.trapActive[5] = false;

  player braxi\_rank::giveRankXp( undefined, 100 );

  dist = -3;
  x = RandomInt(2);

  if(x == 0){
    for(i = 0; i < ents.size; i++){
      if(i % 2 == 0){
        ents[i] NotSolid();
        ents[i] MoveY(dist, .1);
      }  
    }
  } else {
    for(i = 0; i < ents.size; i++){
      if(i % 2 != 0){
        ents[i] NotSolid();
        ents[i] MoveY(dist, .1);
      }  
    }
  }

  trig SetHintString("You ^5activated ^7this trap^5!^7");
}

/////////////////
//  Teleports  //
/////////////////
//bounce room fail teleport your bounce room spawn
bounce_f(){
    trig = getEnt( "bounce_fail", "targetname" ); //trigger
    jump = getEnt( "bounce_jumper", "targetname" ); //jumper origin
    acti = getEnt( "bounce_activator", "targetname" ); //acti origin

    while(true){
    	trig waittill("trigger",player);
    	if(player.pers["team"]!="spectator"){
    		if(player.pers["team"]=="allies"){
    			player setplayerangles(jump.angles);
          player setorigin(jump.origin);
    		}
    		else{
    			player setplayerangles(acti.angles);
          player setorigin(acti.origin);
    		}
    	}
    }
}

mapTeleports(){
  teleNum = 2;

  for(i = 1; i <= teleNum; i++){
    thread setTeleports("mapTp", i, .1);
  }
}

actiTeleports(){
  teleNum = 4;

  for(i = 1; i <= teleNum; i++){
    thread setTeleports("actifail", i, .1);
  }

  teleNum = 4;

  for(i = 1; i <= teleNum; i++){
    thread setTeleports("actiTp", i, .1);
  }
}

setTeleports(name, num, time){
  trig = getEnt("trig_" + name + num, "targetname");
  targ = getEnt("targ_" + name + num, "targetname");

  while(true){
    trig waittill("trigger", player);

    player thread teleportPlayer(targ, time);
  }
}

teleportPlayer(targ, time){
  self FreezeControls(true);
  self SetOrigin(targ.origin);
  self SetPlayerAngles(targ.angles);
  wait(time);
  self FreezeControls(false);
}

//create the room
createRoom(origin,angles,weapon,weapon2,health,freeze){
	self setorigin(origin);
	self setplayerangles(angles);

  self EnableWeapons();

	self takeallweapons();
	self giveweapon(weapon);
	self givemaxammo(weapon);
	self switchtoweapon(weapon);

	if(isdefined(weapon2)){
		self giveweapon(weapon2);
		self givemaxammo(weapon2);
	}

	self.health=health;
  self.maxhealth = health;
	self freezecontrols(freeze);
}

endroom(){
	trig=getent("trig_endroomtp","targetname");
	targ=getent("endroomtp","targetname");
  
  trig SetHintString("Press ^5&&1^7 to enter the ^5room selection^7!");

	while(true){
		trig waittill("trigger",who);
		if(!isdefined(trig))
			return;

       // ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(who))
			continue;
		// =====================================

		iPrintLnBold("^5" + who.name + " entered to the room selection!");

		who DisableWeapons();
		if(isDefined(level.activ)) level.activ DisableWeapons();

		who giveweapon("knife_mp");
		who switchtoweapon("knife_mp");
		who setorigin(targ.origin);
		who setplayerangles(targ.angles);

		while(isalive(who) && isdefined(who))
			wait .01;

    if(level.knifeFight){

      if(isDefined(level.activ)){
        level.activ thread teleportPlayer(getent("targ_actifail3","targetname"), .1);
      }

      wait .15;

      level.knifeFight = false;
      level.knife_trigger maps\mp\_utility::triggerOn();
      level.sniper_trigger maps\mp\_utility::triggerOn();
      level.bounce_trigger maps\mp\_utility::triggerOn();
    }

		iPrintLnBold("^5End room is free!");
	}
}

//sniper room
sniper(){
  level.sniper_trigger = getEnt( "trig_sniper", "targetname" );
  jump = getEnt( "sniper_jumper", "targetname" );
  acti = getEnt( "sniper_activator", "targetname" );

  while(true){
    level.sniper_trigger SetHintString("Press &&1 to enter the Sniper room.");
    level.sniper_trigger waittill("trigger",player);
    if(!isdefined(level.sniper_trigger)) return;

    if(isdefined(level.activ)){

      if(isdefined(level.activ) && isalive(level.activ)){
        player createRoom(jump.origin,jump.angles,"m40a3_mp","remington700_mp",100,1);
        level.activ createRoom(acti.origin,acti.angles,"m40a3_mp","remington700_mp",100,1);
      }
      else player createRoom(jump.origin,jump.angles,"m40a3_mp","remington700_mp",100,1);

      IPrintLnBold("^5" + player.name + " has chosen sniper!");

      wait 5;

      player iPrintlnBold( "Fight!" );
      level.activ iPrintlnBold( "Fight!" );
      player freezecontrols(0);
      level.activ freezecontrols(0);
    }
    else player iPrintLnBold("^1You can not fight alone!");
	}
}

//knife room
knife(){
  level.knife_trigger = getEnt( "trig_knife", "targetname" );
  jump = getEnt( "knife_jumper", "targetname" );
  acti = getEnt( "knife_activator", "targetname" );

  while(true){
    level.knife_trigger SetHintString("Press &&1 to enter the Knife room.");
    level.knife_trigger waittill("trigger",player);
    if(!isdefined(level.knife_trigger)) return;

    if(isdefined(level.activ)){

      if(!level.knifeFight){
        level.knifeFight = true;
        level.knife_trigger maps\mp\_utility::triggerOff();
        level.sniper_trigger maps\mp\_utility::triggerOff();
        level.bounce_trigger maps\mp\_utility::triggerOff();
      }

      if(isdefined(level.activ) && isalive(level.activ)){
        player createRoom(jump.origin,jump.angles,"knife_mp",undefined,100,1);
        level.activ createRoom(acti.origin,acti.angles,"knife_mp",undefined,100,1);
      }
      else player createRoom(jump.origin,jump.angles,"knife_mp",undefined,100,1);

      IPrintLnBold("^5" + player.name + " has chosen knife!");

      wait 5;
      
      player iPrintlnBold( "Fight!" );
      level.activ iPrintlnBold( "Fight!" );
      player freezecontrols(0);
      level.activ freezecontrols(0);
    }
    else player iPrintLnBold("^1You can not fight alone!");
	}
}

//bounce room
bounce(){
  level.bounce_trigger = getEnt( "trig_bounce", "targetname" );
  jump = getEnt( "bounce_jumper", "targetname" );
  acti = getEnt( "bounce_activator", "targetname" );

  while(true){
    level.bounce_trigger SetHintString("Press &&1 to enter the Bounce room.");
    level.bounce_trigger waittill("trigger",player);
    if(!isdefined(level.bounce_trigger)) return;

    if(isdefined(level.activ)){
      if(isdefined(level.activ) && isalive(level.activ)) {
        player createRoom(jump.origin,jump.angles,"knife_mp",undefined,100,1);
        level.activ createRoom(acti.origin,acti.angles,"knife_mp",undefined,100,1);
      }
      else player createRoom(jump.origin,jump.angles,"knife_mp",undefined,100,1);

      IPrintLnBold("^5" + player.name + " has chosen bounce!");

      wait 5;

      player iPrintlnBold( "Fight!" );
      level.activ iPrintlnBold( "Fight!" );
      player freezecontrols(0);
      level.activ freezecontrols(0);
    }
    else player iPrintLnBold("^1You can not fight alone!");
	}
}