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

	Design & Textures:
			Niko #2926
            EphNey #1431

    Character & Weapon Assets:
            Fox.#0001
            Magical.#9137

	Vistic Clan ©
*/

#include braxi\_common;

getMapNameString( mapName ) 
{
	tokens = strTok( toLower( mapName ), "_" ); // mp 0, deathrun/dr 1, name 2, (optional)version 3

	if( tokens.size < 2  || !tokens.size )
		return mapName;	
	return tokens[2];
}

init()
{
	switch ( level.mapName )
	{
		// ===== Added by BraXi ===== //
		case "mp_deathrun_cave":
			trigger = spawn( "trigger_radius", (2226.29, 3548.81, 4.125), 0, 55, 55 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_supermario":
			trigger = spawn( "trigger_radius", (293.538, -1472, 8.12501), 0, 40, 50 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_glass":
			trigger = spawn( "trigger_radius", (106.077, 2241.14, 64.125), 0, 55, 50 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_azteca":
			trigger = spawn( "trigger_radius", (6.59441, -808.602, 32.125), 0, 60, 50 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_colourful":
			trigger = spawn( "trigger_radius", (350.749, 197.533, 688.125), 0, 65, 40 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_escape2":
			trigger = spawn( "trigger_radius", (-6464.2, -2495.73, 184.125), 0, 60, 60 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_ruin2":
			trigger = spawn( "trigger_radius", (9329.7, 380.853, 128.125), 0, 255, 140 );
			trigger.targetname = "endmap_trig";
			break;
		// ===== Added by DuffMan ===== //
		case "mp_dr_bigfall":
			trigger = spawn( "trigger_radius", (-5484.02, -123.487, -12273.5), 0, 96, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_scary":
			trigger = spawn( "trigger_radius", (1.12299, -4825.81, 624.125), 0, 96, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_apocalypse_v2":
			trigger = spawn( "trigger_radius", (-7.09212, 3671.36, 976.125), 0, 96, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_framey_v2":
			trigger = spawn( "trigger_radius", (-2423.35, 794.684, 4.90718), 0, 96, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_backlot":
			trigger = spawn( "trigger_radius", (-939.774, 222.606, 106.125), 0, 96, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_max":
			trigger = spawn( "trigger_radius", (671.125, 13371.2, 0.125002), 0, 96, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_terror":
			trigger = spawn( "trigger_radius", (26.0624, 1312.15, 202.402), 0, 96, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_pool":
			trigger = spawn( "trigger_radius", (-876.881, 678.355, 184.125), 0, 96, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_skypillar":
			trigger = spawn( "trigger_radius", (-2044.31, -338.131, 1057.13), 0, 96, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_ssc_nothing":
			trigger = spawn( "trigger_radius", (228.711, -81.1929, 243.998), 0, 96, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_diehard":
			trigger = spawn( "trigger_radius", (-1095.76, -2331.43, 643.575), 0, 96, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_metal2":
			trigger = spawn( "trigger_radius", (-465.821, 975.085, 16.125), 0, 96, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_greenland":
			trigger = spawn( "trigger_radius", (175.547, -756.876, 144.125), 0, 96, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_sm_world":
			trigger = spawn( "trigger_radius", (-3499.54, -2704.88, 64.125), 0, 96, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_palm":
			trigger = spawn( "trigger_radius", (251.21, -256.368, 384.125), 0, 96, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_watchit_v3":
			trigger = spawn( "trigger_radius", (393.125, 1254.06, 640.125), 0, 96, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_city":
			trigger = spawn( "trigger_radius", (1271.56, -847.444, 0.124998), 0, 96, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_jailhouse":
			trigger = spawn( "trigger_radius", (-4908.72, 447.658, 218.524), 0, 96, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_crazy":
			trigger = spawn( "trigger_radius", (757.689, -2349.56, 1040.13), 0, 96, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_finalshuttle":
			trigger = spawn( "trigger_radius", (339.854, 2194.73, 428.125), 0, 96, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_indipyramid":
			trigger = spawn( "trigger_radius", (-273.908, 87.884, -229.875), 0, 196, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_bananaphone_v2":
			trigger = spawn( "trigger_radius", (2445.84, -424.875, 176.125), 0, 96, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_zero":
			trigger = spawn( "trigger_radius", (-1860.46, -8.91591, 16.125), 0, 96, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_wood_v3":
			trigger = spawn( "trigger_radius", (2884.08, 1041.26, 1024.06), 0, 96, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_takecare":
			trigger = spawn( "trigger_radius", (-701.125, 931.948, 192.125), 0, 96, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_portal_v3":
			trigger = spawn( "trigger_radius", (-4041, 1598.28,-4), 0, 96, 48);
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_minecraft":
			trigger = spawn( "trigger_radius", (-656.331, 1533.39, -31.875), 0, 96, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_liferun":
			trigger = spawn( "trigger_radius", (-279.875, 4833.46, 168.125), 0, 96, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_grassy":
			trigger = spawn( "trigger_radius", (2917.52, -1518.72, 64.125), 0, 96, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_dungeon":
			trigger = spawn( "trigger_radius", (1855.13, -2200.61, -183.875), 0, 96, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_dirt":
			trigger = spawn( "trigger_radius", (-30.625, -839.474, 768.125), 0, 96, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_destroyed":
			trigger = spawn( "trigger_radius", (-9224.88, 125.72, 484.125), 0, 96, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_darkness":
			trigger = spawn( "trigger_radius", (985.723, -587.125, 16.125), 0, 96, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_clear":
			trigger = spawn( "trigger_radius", (-771.999, 520.011, 48.125), 0, 96, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_pacman":
			trigger = spawn( "trigger_radius", (41.1631, 600.943, 1033.63), 0, 96, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_jurapark":
			trigger = spawn( "trigger_radius", (1001.44, 2104.73, -60.875), 0, 96, 48 );
			trigger.targetname = "endmap_trig";
			break;
		//======= Added by Blade =======//
		case "mp_deathrun_long":
			trigger = spawn( "trigger_radius", (1779.07, 6200.37, 32.125), 0, 80, 80 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_gooby":
			trigger = spawn( "trigger_radius", (328, 1018, -211), 0, 300, 300 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_skypower":
			trigger = spawn( "trigger_radius", (1507, -871, -896), 0, 300, 300 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_wtf":
			trigger = spawn( "trigger_radius", (553, -611, 92), 0, 300, 300 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_watercity":
			trigger = spawn( "trigger_radius", (1491, 1096, 444), 0, 300, 300 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_levels":
			trigger = spawn( "trigger_radius", (4, 16672, -1917), 0, 300, 300 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_mirroredge":
			trigger = spawn( "trigger_radius", (-8191, -5991, -2968), 0, 300, 300 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_easy_v2":
			trigger = spawn( "trigger_radius", (12701.4, 2072.74, -143.875), 0, 300, 300 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_moustache":
			trigger = spawn( "trigger_radius", (-235, 475, 90), 0, 300, 300 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_ruin":
			trigger = spawn( "trigger_radius", (409, 1538, -2820), 0, 300, 300 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_wipeout":
			trigger = spawn( "trigger_radius", (2687, 2503, 92), 0, 300, 300 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_wipeout_v2":
			trigger = spawn( "trigger_radius", (1687, 3765, 524), 0, 300, 300 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_blue":
			trigger = spawn( "trigger_radius", (4582, 2556, -1714), 0, 300, 300 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_sm_v2":
			trigger = spawn( "trigger_radius", (1156, -1447, 68), 0, 300, 300 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_detained":
			trigger = spawn( "trigger_radius", (-171, -14776, -678), 0, 300, 300 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_blackandwhite":
			trigger = spawn( "trigger_radius", (13590, 133, 36), 0, 300, 300 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_hilly_v2":
			trigger = spawn( "trigger_radius", (7401, 2571, 54), 0, 300, 300 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_neon":
			trigger = spawn( "trigger_radius", (1394, -2105, 188), 0, 300, 300 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_rock":
			trigger = spawn( "trigger_radius", (6840, 506, -821), 0, 300, 300 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_running":
			trigger = spawn( "trigger_radius", (3093, -992, 381), 0, 300, 300 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_takeshi":
			trigger = spawn( "trigger_radius", (-929, -14, 600), 0, 300, 300 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_up":
			trigger = spawn( "trigger_radius", (14991, -2500, -14), 0, 300, 300 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_vector":
			trigger = spawn( "trigger_radius", (-410, -3992, -2244), 0, 300, 300 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_mine":
			trigger = spawn( "trigger_radius", (856.534, 5721.54, -985.875), 0, 90, 90 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_ponies":
			trigger = spawn( "trigger_radius", (7767.31, -295.282, 352.125), 0, 300, 300 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_rainy_v2":
			trigger = spawn( "trigger_radius", (9679.06, -1678.88, -391.875), 0, 175, 130 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_short_v4":
			trigger = spawn( "trigger_radius", (181.322, -654.961, 72.125), 0, 40, 90 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_storm":
			trigger = spawn( "trigger_radius", (-383.474, 9841.98, 464.125), 0, 65, 120 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_tribute":
			trigger = spawn( "trigger_radius", (473.171, 390.95, -288.875), 0, 80, 125 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_color":
			trigger = spawn( "trigger_radius", (-104.861, -418.832, -1483.88), 0, 300, 300 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_electric":
			trigger = spawn( "trigger_radius", (71.6143, 3940.71, -47.875), 0, 300, 300 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_free":
			trigger = spawn( "trigger_radius", (948.234, 2095.15, -2159.88), 0, 300, 300 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_lithium":
			trigger = spawn( "trigger_radius", (6899.93, -2205.18, -223.875), 0, 120, 185 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_mario_land":
			trigger = spawn( "trigger_radius", (4406.08, 1638.91, 32.125), 0, 300, 300 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_spedex":
			trigger = spawn( "trigger_radius", (1183.8, -1292.02, -139.875), 0, 300, 300 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_mystic":
			trigger = spawn( "trigger_radius", (4264.28, 10.09, -191.875), 0, 300, 300 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_stronghold":
			trigger = spawn( "trigger_radius", (2936.97, -1045.97, 688.125), 0, 40, 105 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_worldofmetal":
			trigger = spawn( "trigger_radius", (-912.793, 5635.9, -31.875), 0, 300, 300 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_sick":
			trigger = spawn( "trigger_radius", (2045, -696, 360), 0, 300, 300 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_vc_nike":
			trigger = spawn( "trigger_radius", (1728.66, -4615.94, -15.875), 0, 255, 80 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_fearful":
			trigger = spawn( "trigger_radius", (-3178.56, 11949.5, -479.875), 0, 70, 125 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_foggy":
			trigger = spawn( "trigger_radius", (-437.046, -382.462, -127.875), 0, 75, 85 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_saw":
			trigger = spawn( "trigger_radius", (-2173, -2035, 210), 0, 300, 300 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_coyote":
			trigger = spawn( "trigger_radius", (3095.41, 9865.41, -1115.88), 0, 300, 300 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_sick_v2":
			trigger = spawn( "trigger_radius", (1868.27, -140.207, 704.125), 0, 160, 105 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_dball_gt":
			trigger = spawn( "trigger_radius", (21162.5, -13456.9, -14991.9), 0, 300, 300 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_chamber01":
			trigger = spawn( "trigger_radius", (1000.35, -639.125, 16.125), 0, 75, 85 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_onsea":
			trigger = spawn( "trigger_radius", (-421.556, -5972.46, -446.875), 0, 300, 300 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_omega":
			trigger = spawn( "trigger_radius", (2549.43, 2334.54, -1311.88), 0, 300, 300);
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_glass2":
			trigger = spawn( "trigger_radius", (3466.36, 3145.01, 32.125), 0, 50, 120 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_35":
			trigger = spawn( "trigger_radius", (-725.092, 732.49, 72.125), 0, 300, 150 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_bounce":
			trigger = spawn( "trigger_radius", (-706, 6642, 22), 0, 96, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_fallguys":
			trigger = spawn( "trigger_radius", (-177.125, 4443.12, 631.125), 0, 200, 48 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_fallrun":
			trigger = spawn( "trigger_radius", (5641.67, -1646.87, -8190.88), 0, 80, 80 );
			trigger.targetname = "endmap_trig";
			break;
		//======= Added by Sheep =======//
		case "mp_deathrun_islands":
			trigger = spawn( "trigger_radius", (-612.406, -2376.85, -2087.88), 0, 75, 95 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_fluxx":
			trigger = spawn( "trigger_radius", (-1663.35, 16682.4, -143.875), 0, 210, 75 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_oreo":
			trigger = spawn( "trigger_radius", (14345.2, 520.546, -13671.9), 0, 160, 70 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_antichamber":
			trigger = spawn( "trigger_radius", (346.666, 2394.72, -2815.88), 0, 230, 10 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_crystal":
			trigger = spawn( "trigger_radius", (5852.35, -3361.35, 96.125), 0, 315, 55 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_qube":
			trigger = spawn( "trigger_radius", (-3658.48, -1024.13, 2818.13), 0, 510, 10 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_dragonball":
			trigger = spawn( "trigger_radius", (-19136.2, 13545.1, 256.125), 0, 325, 110 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_arbase":
			trigger = spawn( "trigger_radius", (297.55, -197.924, -500.915), 0, 145, 60 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_boss":
			trigger = spawn( "trigger_radius", (172.227, 12035.6, -3967.88), 0, 250, 25 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_bounce_v3":
			trigger = spawn( "trigger_radius", (10772.8, 317.258, 928.125), 0, 105, 55 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_bricky":
			trigger = spawn( "trigger_radius", (-430.65, 1659.48, 416.125), 0, 220, 150 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_bunker":
			trigger = spawn( "trigger_radius", (3531.79, 1671.2, -141.875), 0, 130, 80 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_clockwork":
			trigger = spawn( "trigger_radius", (16593.9, -0.335908, 16.125), 0, 160, 135 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_cookie":
			trigger = spawn( "trigger_radius", (-2.43295, -301.38, 128.125), 0, 40, 120 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_cosmic":
			trigger = spawn( "trigger_radius", (6869.81, 512.292, 544.125), 0, 315, 80 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_easy":
			trigger = spawn( "trigger_radius", (8311.36, -192.61, 16.125), 0, 90, 60 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_empire":
			trigger = spawn( "trigger_radius", (1295.09, 1986.1, -632.477), 0, 200, 20 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_epicfail":
			trigger = spawn( "trigger_radius", (3539.41, -142.366, 93.437), 0, 305, 30 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_factory":
			trigger = spawn( "trigger_radius", (803.975, -1479.65, 135.125), 0, 75, 25 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_fusion":
			trigger = spawn( "trigger_radius", (1648.16, -392.413, 3712.13), 0, 220, 145 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_illusion":
			trigger = spawn( "trigger_radius", (1537.73, 19611.5, 671.113), 0, 150, 20 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_metal":
			trigger = spawn( "trigger_radius", (-4164, 3753.78, 16.125), 0, 35, 105 );
			trigger.targetname = "endmap_trig";
			break;
		case "mp_deathrun_fluky":
			trigger = spawn( "trigger_radius", (1381, 17003, 116 ), 0, 600, 600 );
			trigger.targetname = "endmap_trig";
			break;
	//======= Added by Fox =======//
		case "mp_dr_outside":
			trigger = spawn("trigger_radius", (-3706.34, 15067.4, 15.125), 0, 500, 500);
			trigger.targetname = "endmap_trig";
			break;
		case "mp_dr_nxs_jump":
			trigger = spawn("trigger_radius", (393, -944, 382), 0, 300, 500);
			trigger.targetname = "endmap_trig";
			break;
	}

	//===//
	if( !isDefined( level.trapTriggers ) )
	{
		level.trapTriggers = [];
		switch ( level.mapName )
		{
			// BraXi's MAPS
			case "mp_deathrun_darkness":
				level.trapTriggers[level.trapTriggers.size] = getEnt( "t1", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "t2", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "t3", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "t4", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "t5", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "t6", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "t7", "targetname" );
				break;
			case "mp_deathrun_long":
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger1", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger2", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger3", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger4", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger5", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger7", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger8", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger9", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger10", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger11", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger12", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger13", "targetname" );
				spawnCollision( (112,3440,24), 70, 16 );
				spawnCollision( (16,3696,28), 70, 16 );
				spawnCollision( (-112,3440,28), 70, 16 );
				spawnCollision( (-112,3440,28), 70, 16 );
				spawnCollision( (1136,3936,28), 110, 16 );
				spawnCollision( (304,-352,20), 110, 48 );
				break;

			// Viking's MAPS
			case "mp_deathrun_watchit_v2":
			case "mp_deathrun_watchit_v3":
				level.trapTriggers[level.trapTriggers.size] = getEnt( "t1", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "t2", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "t3", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "t4", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "t5", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "t6", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "t7", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "t8", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "t9", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "t10", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "t11", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "t12", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "t13", "targetname" );
				break;

			// MR-X's MAPS
			case "mp_deathrun_takecare":
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trig_1", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trig_2", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trig_3", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trig_4", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trig_5", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trig_6", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trig_7", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trig_8", "targetname" );
				break;
			case "mp_deathrun_glass":
			case "mp_deathrun_dungeon":
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trig_1", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trig_2", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trig_3", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trig_4", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trig_5", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trig_6", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trig_7", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trig_8", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trig_9", "targetname" );
				break;
			case "mp_deathrun_supermario":

				level.trapTriggers[level.trapTriggers.size] = getEnt( "trig1", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trig2", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trig3", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trig4", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trig5", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trig6", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trig7", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trig8", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trig9", "targetname" );
				break;

			// Patrick's MAPS
			case "mp_deathrun_short":
			case "mp_deathrun_short_v2":
				level.trapTriggers[level.trapTriggers.size] = getEnt( "t1", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "t2", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "t3", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "t4", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "t5", "targetname" );
				break;
			
			// Rednose's MAPS
			case "mp_deathrun_grassy":
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger1", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger2", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger3", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger4", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger5", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger6", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger7", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger8", "targetname" );
				break;
			case "mp_deathrun_portal":
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger1", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger2", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger3", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger4", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger5", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger6", "targetname" );
				level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger7", "targetname" );
				break;
		}
	}

	if(isdefined(level.trapTriggers))
		level thread checkTrapUsage();
}

checkTrapUsage()
{
	if(!level.trapTriggers.size)
		return;

	for(i=0;i<level.trapTriggers.size;i++)
	{
		if(level.dvar["giveXpForActivation"])
			level.trapTriggers[i] thread activateXp();

		level.trapTriggers[i] thread processTrapChallenge();
	}
}

processTrapChallenge()
{
	level endon( "death" );
	level endon( "delete" );
	level endon( "deleted" );

	while( isDefined( self ) )
	{
		self waittill( "trigger", who );
		if( who.pers["team"] == "axis" )
		{
			if( game["state"] != "playing" )
				return;
			who braxi\_missions::process_challenge( "ch_sense", 1 );
			break;
		}
	}
}
		
activateXp()
{
	level endon("death");
	level endon("delete");
	level endon("deleted");

	while(isdefined(self))
	{
		self waittill("trigger",who);
		if(who.pers["team"]=="axis")
		{
			if(game["state"]!="playing")
				return;

			who braxi\_rank::giverankxp("trap_activation");
			break;
		}
	}
}