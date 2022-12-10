/*
___________.__           .____    .__          _____          ____    __________.__           .__  .__        
\__    ___/|  |__   ____ |    |   |__|__  ____/ ____\____    /  _ \   \______   \  |__   ____ |  | |__|__  ___
  |    |   |  |  \_/ __ \|    |   |  \  \/  /\   __\/ __ \   >  _ </\  |     ___/  |  \_/ __ \|  | |  \  \/  /
  |    |   |   Y  \  ___/|    |___|  |>    <  |  | \  ___/  /  <_\ \/  |    |   |   Y  \  ___/|  |_|  |>    < 
  |____|   |___|  /\___  >_______ \__/__/\_ \ |__|  \___  > \_____\ \  |____|   |___|  /\___  >____/__/__/\_ \
                \/     \/        \/        \/           \/         \/                \/     \/              \/
.:: Map name: mp_dr_urban ::.
.:: Authors: TheLixfe & Phelix ::.
*/

main()
{
	maps\mp\_load::main();	

	// Map dvars
	setdvar( "r_specularcolorscale", "1" );
	setdvar("r_glowbloomintensity0",".25");
	setdvar("r_glowbloomintensity1",".25");
	setdvar("r_glowskybleedintensity0",".3");

    //default variables
    level.in_end_room = false;

	// Threads
	//thread secret();
	thread start();
}

start()
{
    object = getEnt( "startdoor", "targetname" );
    clip = getEnt( "start_clip", "targetname" );

    wait 1;

    ambientPlay("urban");

    wait 21.9;

    iPrintLnBold("^1mp_dr_urban by TheLixfe & Phelix");

    clip delete();
    object rotateRoll(90,2);
}
