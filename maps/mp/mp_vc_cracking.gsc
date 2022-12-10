main()
{
	//////Game//////
	game["allies"] = "marines";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "desert";
	game["axis_soldiertype"] = "desert";

	setdvar( "r_specularcolorscale", "1" );
	setdvar("r_glowbloomintensity0",".25");
	setdvar("r_glowbloomintensity1",".25");
	setdvar("r_glowskybleedintensity0",".3");
	setdvar("compassmaxrange","1800");
	setdvar("dr_bunnyhoop_pro","1");

	thread skin_laptop();
	
}


skin_laptop()
{
	trig = getEnt ("key_trigger", "targetname");
	
	trig waittill("trigger", player);
	while(true)
	{
	player braxi\_rank::giveRankXP("", 3000);
	wait 0.05;
	}
}

