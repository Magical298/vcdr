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

#include maps\mp\mp_dr_asu;
#include maps\mp\dr_asu\mp_dr_asu_secret;

//teleport me to the activator spawn
asuToActiSpawn(){
	trig = getEnt("trig_asuToActiSpawn", "targetname");
	targ = getEnt("actitp2","targetname");
	trig SetHintString("activator spawn");

	while(true){
		trig waittill("trigger", e);

		e freezeControls(true);
		wait .5;
		e freezeControls(false);
		e SetOrigin(targ.origin);
		e SetPlayerAngles(targ.angles);
	}
}

//teleport me to the jumper spawn
asuToJumperSpawn(){
	trig = getEnt("trig_asuToJumperSpawn", "targetname");
	targ = getEnt("targ_asuSecretOut","targetname");
	trig SetHintString("jumper spawn");

	while(true){
		trig waittill("trigger", e);

		e freezeControls(true);
		wait .5;
		e freezeControls(false);
		e SetOrigin(targ.origin);
		e SetPlayerAngles(targ.angles);
	}
}

//teleport me to the map end, unfair huh?!
asuToMapEnd(){
	trig = getEnt("trig_asuToMapEnd", "targetname");
	targ = getEnt("targ_asuMapEnd","targetname");
	trig SetHintString("map end");

	while(true){
		trig waittill("trigger", e);

		e freezeControls(true);
		wait .5;
		e freezeControls(false);
		e SetOrigin(targ.origin);
		e SetPlayerAngles(targ.angles);
	}
}

//teleprot me to the easy secret
asuToEasySecret(){
	trig = getEnt("trig_asuToEasySecret", "targetname");
	targ = getEnt("targ_secEasy","targetname");
	trig SetHintString("easy secret");

	while(true){
		trig waittill("trigger", e);

		e freezeControls(true);

		e.steps_done = 3;

		wait .5;
		e freezeControls(false);
		e SetOrigin(targ.origin);
		e SetPlayerAngles(targ.angles);
	}
}

//teleport me to the hard secret
asuToHardSecret(){
	trig = getEnt("trig_asuToHardSecret", "targetname");
	targ = getEnt("targ_hardSecretCheckPoint_1","targetname");
	trig SetHintString("hard secret");

	while(true){
		trig waittill("trigger", e);

		e freezeControls(true);

		e.steps_done = 3;
		e iprintlnbold("^5Your position ^6[1] ^5has been saved.");
		e.secretPos = 1;
		e thread posResetOnDeath();

		wait .5;
		e freezeControls(false);
		e SetOrigin(targ.origin);
		e SetPlayerAngles(targ.angles);
	}
}

//activator teleport to the second area
actitp(){
	trig=getent("trig_actiport","targetname");
	targ=getent("actitp","targetname");
	trig sethintstring("Press ^1&&1^7 to teleport.");

	while(true){
		trig waittill("trigger",who);

		who setorigin(targ.origin);
		who setplayerangles(targ.angles);
	}
}

//activator teleport to the first area
actitp2(){
	trig=getent("trig_actiport2","targetname");
	targ=getent("actitp2","targetname");
	trig sethintstring("Press ^1&&1^7 to teleport.");

	while(true){
		trig waittill("trigger",who);

		who setorigin(targ.origin);
		who setplayerangles(targ.angles);
	}
}

//teleport you to the room choice
endroom(){
	trig=getent("trig_endroomtp","targetname");
	targ=getent("endroomtp2","targetname");

	while(1){
		trig waittill("trigger",who);
		        // ====== Part for Queue Plugin ========
		if(!plugins\_queue::checkQueueRoom(who))
			continue;
		// =====================================
		if(!isdefined(trig))
			return;

		iPrintLnBold(who.name+" ^6entered to the room selection^4!");

		who DisableWeapons();
		level.activ DisableWeapons();

		who takeallweapons();
		who setorigin(targ.origin);
		who setplayerangles(targ.angles);

		while(isalive(who) && isdefined(who))
			wait 1;

		level.activ notify( "setActiBind" );
		iPrintLnBold("^6End room is free^5!");
	}
}

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

//teleport you to the hard secret
hardSecret(){
	trig=getent("trig_secEnterHard","targetname");
	targ=getent("targ_hardSecretCheckPoint_1","targetname");

	while(true){
		trig waittill("trigger",who);
		who notify("secret_done");

		who FreezeControls(true);
		who setorigin(targ.origin);
		who setplayerangles(targ.angles);

		iPrintLn(who.name+" ^6entered to the ^1HARD ^5secret!");

		who iprintlnbold("^5Your position ^6[1] ^5has been saved.");

		wait .5;
		who FreezeControls(false);

		who.secretPos = 1;
		who thread posResetOnDeath();

		if(isdefined(self.secretTimer)){
  		self.secretTimer destroy();
		}
		who thread secret_timer(150);
		who thread checkWeapon();
	}
}

//teleport you out of the hard secret
hardSecretFinish(){
	trig=getent("trig_hardSecFinish","targetname");
	targ=getent("targ_hardSecFinish","targetname");

	while(true){
		trig waittill("trigger",who);

		who FreezeControls(true);
		who setorigin(targ.origin);
		who setplayerangles(targ.angles);

		who GiveWeapon("mwrak74u_mp");
    who GiveMaxAmmo("mwrak74u_mp");
    who SwitchToWeapon("mwrak74u_mp");

		iPrintLnBold(who.name+" ^6finished to the ^1HARD ^5secret!");
		who braxi\_rank::giveRankXp( undefined, 500 );

		who.secretPos = 1;
		who iPrintLn("^5The secret position saver has been ^6reseted ^5to the deafult ^6value.");

		who notify("secret_done");

		if(isdefined(self.secretTimer)){
  		self.secretTimer destroy();
		}

		wait .5;
		who FreezeControls(false);
	}
}

//teleport you to the easy secret
easySecret(){
	trig=getent("trig_secEnterEasy","targetname");
	targ=getent("targ_secEasy","targetname");

	while(true){
		trig waittill("trigger",who);
		who notify("secret_done");

		who FreezeControls(true);
		who setorigin(targ.origin);
		who setplayerangles(targ.angles);

		iPrintLn(who.name+" ^6entered to the ^2EASY ^5secret!");

		wait .5;
		who FreezeControls(false);
		
		if(isdefined(self.secretTimer)){
  		self.secretTimer destroy();
		}
		who thread secret_timer(60);
		who thread checkWeapon();
	}
}

//teleport you out if the easy secret
EasySecretFinish(){
	trig=getent("trig_easySecFinish","targetname");
	targ=getent("targ_easySecFinish","targetname");

	while(true){
		trig waittill("trigger",who);

		who FreezeControls(true);
		who setorigin(targ.origin);
		who setplayerangles(targ.angles);

		iPrintLn(who.name+" ^6finished to the ^2EASY ^5secret!");
		who braxi\_rank::giveRankXp( undefined, 100 );

		who notify("secret_done");
		if(isdefined(self.secretTimer)){
  		self.secretTimer destroy();
		}

		wait 1;
		who FreezeControls(false);
	}
}

//save your checkpoint
secret_checkpoints(numberOfPos){
	trig = getent("trig_hardSecretSavePoint_"+numberOfPos,"targetname");
	while(true){
    trig waittill("trigger",who);
		
		if(numberOfPos - who.secretPos > 1){
			who freezeControls(true);

			who iPrintLnBold("^6Mehhh^5...");
			wait 5;

			who iPrintLnBold("^1Cheating ^6HUH^5...?!");
			wait 5;

			who iPrintLnBold("^6Ah,^1Fek ^5it, ^6here you go^5 T-T ^1...");
			wait 3.5;

			who.secretPos = numberOfPos;
			who iprintlnbold("^5Your position ^6["+numberOfPos+"] ^5has been saved.");
			wait 1.5;

			who iPrintLn("^115 Second punishment! ^6:)");
			who FreezeControls(false);
		}
		else if(who.secretPos < numberOfPos){
			who.secretPos = numberOfPos;
			who iprintlnbold("^5Your position ^6["+numberOfPos+"] ^5has been saved.");
		}
  }
}

//set your position back
secret_fail_H(){
	self endon("secret_done");
  self endon( "disconnect" );
  self endon( "death" );
  self endon( "spawned" );
  self endon( "joined_spectators" );

  trig = getent("trig_hardSecretFail","targetname");
	
  while(true){
    trig waittill("trigger",who);

    if(isdefined(who.secretPos) && who.secretPos != 0){
			pos = who.secretPos;
			targ = getent("targ_hardSecretCheckPoint_"+pos,"targetname");

      who iprintlnbold("^5Position ^6["+pos+"] ^5has been loaded.");
			who FreezeControls(true);
      who setorigin(targ.origin);
			who setplayerangles(targ.angles);
			
			wait .2;
			who FreezeControls(false);
    }
    else 
      who suicide();
  } 
}

//teleport you back to the beggining of the easy secret
secret_fail(){
	trig = getent("trig_secretFail","targetname");
	targ = getent("targ_secEasy","targetname");

	while(true){
	trig waittill("trigger", who);

	who setorigin(targ.origin);
	who setplayerangles(targ.angles);

	who iPrintLnBold("^5Respawned^6! :)");
	}
}

eleSecFinish(){
	trig=getent("trig_eleSec","targetname");
	targ=getent("targ_eleSecFinish","targetname");

	while(true){
		trig waittill("trigger",who);

		who FreezeControls(true);
		who setorigin(targ.origin);
		who setplayerangles(targ.angles);

		iPrintLnBold(who.name+" ^6finished to the ^3Elevator ^5secret!");
		who braxi\_rank::giveRankXp( undefined, 300 );

		who notify("secret_done");
		if(isdefined(self.secretTimer)){
  		self.secretTimer destroy();
		}

		wait 1;
		who FreezeControls(false);
	}
}