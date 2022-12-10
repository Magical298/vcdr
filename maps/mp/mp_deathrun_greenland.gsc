main()
{
	maps\mp\_load::main();
	maps\mp\_compass::setupMiniMap("compass_map_mp_deathrun_greenland");
	
	game["allies"] = "sas";
	game["axis"] = "russian";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "woodland";
	game["axis_soldiertype"] = "woodland";

	setdvar( "r_specularcolorscale", "1" );

	setdvar("r_glowbloomintensity0",".1");
	setdvar("r_glowbloomintensity1",".1");
	setdvar("r_glowskybleedintensity0",".1");
	setdvar("compassmaxrange","1500");
	
	//this loads all traps as soon as the activator got picked
	//level waittill("activator");
	thread trap1();
	thread trap2();
	thread trap3();
	thread trap4();
	thread trap5();
	thread door();
	thread credits();
}
addTriggerToList( name )
{
   if( !isDefined( level.trapTriggers ) )
      level.trapTriggers = [];
   level.trapTriggers[level.trapTriggers.size] = getEnt( name, "targetname" );
}
addtrapstofreerun()
{
	addTriggerToList("trap1_trig");
	addTriggerToList("trap2_trig");
	addTriggerToList("trap3_trig");
	addTriggerToList("trap4_trig");
	addTriggerToList("trap5_trig");
}
trap1()
{
	platform = getEnt("trap1", "targetname");
	trigger = getEnt("trap1_trig", "targetname");
	distance = 204; //change this change the distance the platform will travel
	time = 0.5; //change this to make the platform faster or slower
	
	
	trigger waittill("trigger");
	trigger delete();
	
	platform moveX(distance*-1, time);
	platform waittill("movedone");
	platform moveX(distance, time);
}

trap2()
{
	platform = getEnt("trap2", "targetname");
	trigger = getEnt("trap2_trig", "targetname");
	angle = 1080; //change this change the angle the platform will rotate
	time = 3; //change this to make the platform faster or slower
	
	trigger waittill("trigger");
	trigger delete();
	
	platform rotateyaw(angle, time);
	wait time+0.5;
	platform rotateyaw(angle*-1, time);
}

trap3()
{
	platforms = getEntArray("trap3", "targetname");
	trigger = getEnt("trap3_trig", "targetname");
	
	trigger waittill("trigger");
	trigger delete();
	
	for(i=0; i<2; i++)
	{
	wait .1;
		platforms[randomInt(platforms.size)] notsolid();
	}
}

trap4()
{
	spikes = getEnt("trap4", "targetname");
	hurt = getEnt("trap4_hurt", "targetname");
	trigger = getEnt("trap4_trig", "targetname");
	distance = 40; //change this to change the distance the spikes will travel
	time = 1; //change this to make the spikes faster or slower
	
	trigger waittill("trigger");
	trigger delete();
	
	spikes moveZ(distance, time);
	hurt.origin += (0,0,distance);
	spikes waittill("movedone");
	spikes moveZ(distance*-1, time);
	hurt delete();
}

trap5()
{
	platform = getEnt("trap5", "targetname");
	trigger = getEnt("trap5_trig", "targetname");
	distance = 250; //change this change the distance the platform will travel
	time = 2; //change this to make the platform faster or slower
	
	thread trap5_movement(platform, distance, time);
	
	trigger waittill("trigger");
	trigger delete();
	
	platform.triggered = true;
	platform notsolid();
	wait 1;
	thread trap5_movement(platform, distance, time);
}

trap5_movement(platform, distance, time)
{
	platform.triggered = false;
	platform solid();

	while(!platform.triggered)
	{
		platform moveY( distance*-1, time);
		platform waittill("movedone");
		platform moveY( distance, time);
		platform waittill("movedone");
	}
}

door()
{
	door = getEnt("door", "targetname");
	trigger = getEnt("door_trig", "targetname");
	
	trigger waittill("trigger", player);
	trigger delete();
	
	door moveZ( 90, 1);
	
	iPrintLnBold(player.name + " ^2has reached the door first!"); //Change the message if you want
}

credits()
{
	time = 30; //change this to change the time between the messages

	while(1)
	{
		iprintln("^1Map created by ^2Destroyer");
		wait time;
		iprintln("^1Traps scripted by ^2iNext.Viking");
		wait time;		
	}
}