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

getWeapString(weap) 
{
	switch(toLower(weap)) 
	{
		// Mod Internal weaps
		case "ak47_acog_mp":
			weap = "BO2 Knife";
			break;
		case "ak47_gl_mp":
			weap = "AW Knife";
			break;	
		case "ak47_reflex_mp":
			weap = "P226";
			break;
		case "bananagun_mp":
			weap = "^3Banana Gun";
			break;
		case "barrett_acog_mp":
			weap = "S-Tac Aggressor";
			break;	
		case "claymore_mp":
			weap = "Tactical Insertion";
			break;	
		case "colt44_mp":
			weap = "Colt .44";
			break;	
		case "colt45_mp":
			weap = "Colt .45";
			break;	
		case "deserteagle_mp":
			weap = "Desert Eagle";
			break;	
		case "deserteaglegold_mp":
			weap = "Blade's Deagle";
			break;	
		case "dog_mp":
			weap = "Dog";
			break;	
		case "g3_acog_mp":
			weap = "Crowbar";
			break;	
		case "g3_gl_mp":
			weap = "Butterfly Knife";
			break;	
		case "g36c_acog_mp":
			weap = "Desert Eagle Tac.Knife";
			break;	
		case "g36c_gl_mp":
			weap = "Hands";
			break;	
		case "g36c_silencer_mp":
			weap = "Watermelon";
			break;	
		case "m14_acog_mp":
			weap = "Karambit Knife";
			break;	
		case "m14_gl_mp":
			weap = "M9 Bayonet Knife";
			break;	
		case "m14_silencer_mp":
			weap = "M93 Raffica";
			break;	
		case "m16_acog_mp":
			weap = "MP412";
			break;	
		case "m16_gl_mp":
			weap = "PM-9";
			break;			
		case "m16_silencer_mp":
			weap = "M1911 Dual Wield";
			break;	
		case "m40a3_mp":
			weap = "M40A3";
			break;	
		case "remington700_mp":
			weap = "Remington 700";
			break;	
		case "tomahawk_mp":
			weap = "Tomahawk";
			break;	
		case "knife_mp":
			weap = "Knife";
			break;	
		// Stock weaps

		case "m16_mp": // Assault Rifles
			weap = "M16";
			break;
		case "ak47_mp":
			weap = "AK-47";
			break;
		case "m4_mp":
		case "m4_acog_mp":
		case "m4_silencer_mp":
			weap = "M4 Carabine";
			break;
		case "g3_mp":
			weap = "G3";
			break;
		case "m14_mp":
			weap = "M14";
			break;
		case "mp44_mp":
			weap = "MP44";
			break;
		case "g36c_mp":
			weap = "G36C";
			break;
		case "mp5_mp": // MPS
			weap = "MP5";
			break;
		case "skorpion_mp":
			weap = "Skorpion";
			break;
		case "uzi_mp":
			weap = "Mini Uzi";
			break;
		case "ak74u_mp":
			weap = "AK-74u";
			break;
		case "p90_mp":
			weap = "P90";
			break;
		case "winchester1200_mp": // Shotgun & MGs
			weap = "W-1200";
			break;
		case "m1014_mp":
			weap = "M1014";
			break;
		case "saw_mp":
			weap = "Saw";
			break;
		case "rpd_mp":
			weap = "RPD";
			break;
		case "m60e4_mp":
			weap = "M60e4";
			break;
		case "m21_mp":
			weap = "M21";
			break;
		case "dragunov_mp":
			weap = "Dragunov";
			break;
		case "barret_mp":
			weap = "Barret Cal.50";
			break;
		case "beretta_mp": // Pistol
			weap = "M9";
			break;
		case "usp_mp":
		case "usp_silencer_mp":
			weap = "USP.45";
			break;
		case "defaultweap_mp": // Others
			weap = "Default weap";
			break;
		case "frag_grenade_mp":
			weap = "Frag Grenade";
			break;
		case "flash_grenade_mp":
			weap = "Flash Grenade";
			break;
		case "concussion_grenade_mp":
			weap = "Stun Grenade";
			break;
		case "smoke_grenade_mp":
			weap = "Smoke Grenade";
			break;
		case "rpg_mp":
			weap = "RPG";
			break;
		case "c4_mp":
			weap = "C4";
			break;
		case "remington700_acog_mp":
			weap = "Pulsegun";
			break;
		case "saw_acog_mp":
			weap = "Gravity Gun";
			break;
		default:
			weap = weap;
			break;
	}
	return weap;
}

getGameTypeString(gt) 
{
	switch(toLower(gt))
	 {
		case "deathrun":
			gt = "Deathrun";
			break;	
		case "cj":
			gt = "Codjumper";
			break;
		case "hns":
			gt = "Hide & Seek";
			break;
		case "kc":
			gt = "Kill Confirmed";
			break;
		case "dm":
			gt = "Free for All";
			break;
		case "war":
			gt = "Team Death Match";
			break;
		case "sd":
			gt = "Promod";
			break;		
		case "dom":
			gt = "Domination";
			break;
		case "ctf":
			gt = "Capture the Flag";
			break;
		case "sab":
			gt = "Sabotage";
			break;
		case "zb":
			gt = "Zombie";
			break;
		case "surv":
			gt = "RotU-R";
			break;
		case "hg":
			gt = "Hunger Games";
			break;
		default:
			gt = gt;
			break;
	}
	return gt;
}

getMapNameString(mapname)
{
	string = "";
	tokens = strtok(tolower(mapname),"_");
	if(tokens[1] == "vc" || tokens[1] == "vistic")
		string = "^5Vistic's^7 ";

	switch(tolower(mapname))
	{
		case "mp_deathrun_abandoned":
			mapname = "Abandoned";
			break;
		case "mp_deathrun_amazon":
			mapname = "Amazon";
			break;
		case "mp_deathrun_apollo":
			mapname = "Apollo";
			break;
		case "mp_deathrun_arbase":
			mapname = "Arbase";
			break;
		case "mp_deathrun_backlot":
			mapname = "Backlot";
			break;
		case "mp_deathrun_bangarang":
			mapname = "Bangarang";
			break;
		case "mp_deathrun_beastmode":
			mapname = "Beast Mode";
			break;
		case "mp_deathrun_boss":
			mapname = "Boss";
			break;
		case "mp_deathrun_boss_v2":
			mapname = "Boss v2";
			break;
		case "mp_deathrun_bounce_v3":
			mapname = "Bounce v3";
			break;
		case "mp_deathrun_bricky":
			mapname = "Bricky";
			break;
		case "mp_deathrun_bunker":
			mapname = "Bunker";
			break;
		case "mp_deathrun_cage":
			mapname = "Cage";
			break;
		case "mp_deathrun_cave":
			mapname = "Cave";
			break;
		case "mp_deathrun_chamber01":
			mapname = "Chamber 01";
			break;
		case "mp_deathrun_cherry":
			mapname = "Cherry";
			break;
		case "mp_deathrun_chunk":
			mapname = "Chunk";
			break;
		case "mp_deathrun_city":
			mapname = "City";
			break;
		case "mp_deathrun_clear":
			mapname = "Clear";
			break;
		case "mp_deathrun_clockwork":
			mapname = "Clockwork";
			break;
		case "mp_deathrun_colourful":
			mapname = "Colourful";
			break;
		case "mp_deathrun_control":
			mapname = "Control";
			break;
		case "mp_deathrun_cookie":
			mapname = "Cookie";
			break;
		case "mp_deathrun_cookie_v3":
			mapname = "Cookie v3";
			break;
		case "mp_deathrun_cosmic":
			mapname = "Cosmic";
			break;
		case "mp_deathrun_coyote":
			mapname = "Coyote";
			break;
		case "mp_deathrun_coyote_v2":
			mapname = "Coyote v2";
			break;
		case "mp_deathrun_crazy":
			mapname = "Crazy";
			break;
		case "mp_deathrun_crystal":
			mapname = "Crystal";
			break;
		case "mp_deathrun_crystal_v2":
			mapname = "Crystal v2";
			break;
		case "mp_deathrun_curt":
			mapname = "Curt";
			break;
		case "mp_deathrun_cyber":
			mapname = "Cyber";
			break;
		case "mp_deathrun_darkness":
			mapname = "Darkness";
			break;
		case "mp_deathrun_death":
			mapname = "Death";
			break;
		case "mp_deathrun_destroyedv3":
			mapname = "Destroyed v3";
			break;
		case "mp_deathrun_diehard":
			mapname = "Diehard";
			break;
		case "mp_deathrun_dirt":
			mapname = "dirt";
			break;
		case "mp_deathrun_dragonball":
			mapname = "Dragonball";
			break;
		case "mp_deathrun_dungeon":
			mapname = "Dungeon";
			break;
		case "mp_deathrun_easy":
			mapname = "Easy";
			break;
		case "mp_deathrun_electory":
			mapname = "Electory";
			break;
		case "mp_deathrun_empire":
			mapname = "Empire";
			break;
		case "mp_deathrun_epicfail":
			mapname = "Epicfail";
			break;
		case "mp_deathrun_escape2":
			mapname = "Escape 2";
			break;
		case "mp_deathrun_eudora":
			mapname = "Eudora";
			break;
		case "mp_deathrun_factory":
			mapname = "Factory";
			break;
		case "mp_deathrun_fairytail":
			mapname = "Fairy Tail";
			break;
		case "mp_deathrun_fall":
			mapname = "Fall";
			break;
		case "mp_deathrun_familyguy":
			mapname = "Family Guy";
			break;
		case "mp_deathrun_fearful":
			mapname = "Fearful";
			break;
		case "mp_deathrun_flow":
			mapname = "Flow";
			break;
		case "mp_deathrun_fluxx":
			mapname = "Fluxx";
			break;
		case "mp_deathrun_forest":
			mapname = "Forest";
			break;
		case "mp_deathrun_forgoten":
			mapname = "Forgotten";
			break;
		case "mp_deathrun_framey_v2":
			mapname = "Framey v2";
			break;
		case "mp_deathrun_framey_v3":
			mapname = "Framey v3";
			break;
		case "mp_deathrun_freefall":
			mapname = "Freefall";
			break;
		case "mp_deathrun_fusion":
			mapname = "Fusion";
			break;
		case "mp_deathrun_glow":
			mapname = "Glow";
			break;
		case "mp_deathrun_godfather":
			mapname = "Godfather";
			break;
		case "mp_deathrun_godfather2":
			mapname = "Godfather 2";
			break;
		case "mp_deathrun_gold":
			mapname = "Gold";
			break;
		case "mp_deathrun_grassy_v4":
			mapname = "Grassy v4";
			break;
		case "mp_deathrun_greenland":
			mapname = "Greenland";
			break;
		case "mp_deathrun_haunted":
			mapname = "Haunted";
			break;
		case "mp_deathrun_highrise":
			mapname = "Highrise";
			break;
		case "mp_deathrun_highup":
			mapname = "Highup";
			break;
		case "mp_deathrun_hop":
			mapname = "Hop";
			break;
		case "mp_deathrun_horror":
			mapname = "Horror";
			break;
		case "mp_deathrun_iceops":
			mapname = "Iceops";
			break;
		case "mp_deathrun_idk":
			mapname = "IDK";
			break;
		case "mp_deathrun_illusion":
			mapname = "Illusion";
			break;
		case "mp_deathrun_industry":
			mapname = "Industry";
			break;
		case "mp_deathrun_industryv2":
			mapname = "Industry v2";
			break;
		case "mp_deathrun_inferno":
			mapname = "Inferno";
			break;
		case "mp_deathrun_islands":
			mapname = "Islands";
			break;
		case "mp_deathrun_jailhouse":
			mapname = "Jailhouse";
			break;
		case "mp_deathrun_jam":
			mapname = "Jam";
			break;
		case "mp_deathrun_legend":
			mapname = "Legend";
			break;
		case "mp_deathrun_life":
			mapname = "Life";
			break;
		case "mp_deathrun_liferun":
			mapname = "Liferun";
			break;
		case "mp_deathrun_long":
			mapname = "Long";
			break;
		case "mp_deathrun_mall":
			mapname = "Mall";
			break;
		case "mp_deathrun_max":
			mapname = "Max";
			break;
		case "mp_deathrun_mc_class":
			mapname = "MC Class";
			break;
		case "mp_deathrun_mecha":
			mapname = "Mecha";
			break;
		case "mp_deathrun_metal":
			mapname = "Metal";
			break;
		case "mp_deathrun_metal2":
			mapname = "Metal 2";
			break;
		case "mp_deathrun_mine":
			mapname = "Mine";
			break;
		case "mp_deathrun_minecraft":
			mapname = "Minecraft";
			break;
		case "mp_deathrun_mirroredge":
			mapname = "Mirroredge";
			break;
		case "mp_deathrun_moustache":
			mapname = "Moustache";
			break;
		case "mp_deathrun_night":
			mapname = "Night";
			break;
		case "mp_deathrun_nightrun":
			mapname = "Nightrun";
			break;
		case "mp_deathrun_nukebase":
			mapname = "Nuke Base";
			break;
		case "mp_deathrun_omega":
			mapname = "Omega";
			break;
		case "mp_deathrun_oreo":
			mapname = "Oreo";
			break;
		case "mp_deathrun_oss":
			mapname = "OSS";
			break;
		case "mp_deathrun_pacman":
			mapname = "Pac Man";
			break;
		case "mp_deathrun_ponies":
			mapname = "Ponies";
			break;
		case "mp_deathrun_portal_v3":
			mapname = "Portal v3";
			break;
		case "mp_deathrun_qube":
			mapname = "Qube";
			break;
		case "mp_deathrun_revolution":
			mapname = "Revolution";
			break;
		case "mp_deathrun_rainy_v2":
			mapname = "Rainy v2";
			break;
		case "mp_deathrun_rocky":
			mapname = "Rocky";
			break;
		case "mp_deathrun_royals":
			mapname = "Royals";
			break;
		case "mp_deathrun_ruin":
			mapname = "Ruin";
			break;
		case "mp_deathrun_ruin2":
			mapname = "Ruin 2";
			break;
		case "mp_deathrun_sanctuary":
			mapname = "Sanctuary";
			break;
		case "mp_deathrun_sao":
			mapname = "Sword Art Online";
			break;
		case "mp_deathrun_sapphire":
			mapname = "Sapphire";
			break;
		case "mp_deathrun_saw":
			mapname = "Saw";
			break;
		case "mp_deathrun_scary":
			mapname = "Scary";
			break;
		case "mp_deathrun_scoria":
			mapname = "Scoria";
			break;
		case "mp_deathrun_semtex":
			mapname = "Semtex";
			break;
		case "mp_deathrun_sg1":
			mapname = "SG 1";
			break;
		case "mp_deathrun_shadow":
			mapname = "Shadow";
			break;
		case "mp_deathrun_shadow_v2":
			mapname = "Shadow v2";
			break;
		case "mp_deathrun_shelter":
			mapname = "Shelter";
			break;
		case "mp_deathrun_short_v4":
			mapname = "Short v4";
			break;
		case "mp_deathrun_sick":
			mapname = "Sick";
			break;
		case "mp_deathrun_sick_v2":
			mapname = "Sick v2";
			break;
		case "mp_deathrun_skypillar":
			mapname = "Skypillar";
			break;
		case "mp_deathrun_slender":
			mapname = "Slender";
			break;
		case "mp_deathrun_slow":
			mapname = "Slow";
			break;
		case "mp_deathrun_sm_v2":
			mapname = "Super Mario v2";
			break;
		case "mp_deathrun_smooth":
			mapname = "Smooth";
			break;
		case "mp_deathrun_snowic":
			mapname = "Snowic";
			break;
		case "mp_deathrun_sonic":
			mapname = "Sonic";
			break;
		case "mp_deathrun_spaceball":
			mapname = "Spaceball";
			break;
		case "mp_deathrun_spacetunnel":
			mapname = "Spacetunnel";
			break;
		case "mp_deathrun_stages":
			mapname = "Stages";
			break;
		case "mp_deathrun_star":
			mapname = "Star";
			break;
		case "mp_deathrun_storm":
			mapname = "Storm";
			break;
		case "mp_deathrun_supermario":
			mapname = "Super Mario";
			break;
		case "mp_deathrun_takecare":
			mapname = "Take Care";
			break;
		case "mp_deathrun_thechoice":
			mapname = "The Choice";
			break;
		case "mp_deathrun_trans":
			mapname = "Trans";
			break;
		case "mp_deathrun_tribute":
			mapname = "Tribute";
			break;
		case "mp_deathrun_tropic":
			mapname = "Tropic";
			break;
		case "mp_deathrun_uncharted":
			mapname = "Uncharted";
			break;
		case "mp_deathrun_under":
			mapname = "Under";
			break;
		case "mp_deathrun_underworld":
			mapname = "Underworld";
			break;
		case "mp_deathrun_vacant":
			mapname = "Vacant";
			break;
		case "mp_deathrun_watchit_v3":
			mapname = "Watch it v3";
			break;
		case "mp_deathrun_water":
			mapname = "Water";
			break;
		case "mp_deathrun_waterwork":
			mapname = "Waterwork";
			break;
		case "mp_deathrun_waterworld":
			mapname = "Waterworld";
			break;
		case "mp_deathrun_wicked":
			mapname = "Wicked";
			break;
		case "mp_deathrun_wicked2":
			mapname = "Wicked 2";
			break;
		case "mp_deathrun_winter":
			mapname = "Winter";
			break;
		case "mp_deathrun_wipeout":
			mapname = "Wipeout";
			break;
		case "mp_deathrun_wipeout_v2":
			mapname = "Wipeout v2";
			break;
		case "mp_deathrun_wood_v3":
			mapname = "Wood v3";
			break;
		case "mp_deathrun_zero":
			mapname = "Zero";
			break;
		case "mp_dr_2towers":
			mapname = "2 Towers";
			break;
		case "mp_dr_35":
			mapname = "35";
			break;
		case "mp_dr_420":
			mapname = "420";
			break;
		case "mp_dr_ab_v2":
			mapname = "AB v2";
			break;
		case "mp_dr_adamx_hell":
			mapname = "Adamx Hell";
			break;
		case "mp_dr_alley":
			mapname = "Alley";
			break;
		case "mp_dr_android":
			mapname = "Android";
			break;
		case "mp_dr_anime_world":
			mapname = "Anime World";
			break;
		case "mp_dr_anotherworld":
			mapname = "Another World";
			break;
		case "mp_dr_antichamber":
			mapname = "Antichamber";
			break;
		case "mp_dr_anubis":
			mapname = "Anubis";
			break;
		case "mp_dr_apocalypse":
			mapname = "Apocalypse";
			break;
		case "mp_dr_apocalypse_v2":
			mapname = "Apocalypse v2";
			break;
		case "mp_dr_arctic":
			mapname = "Arctic";
			break;
		case "mp_dr_around":
			mapname = "Around";
			break;
		case "mp_dr_asu":
			mapname = "Asu";
			break;
		case "mp_dr_asylum":
			mapname = "Asylum";
			break;
		case "mp_dr_atlantis":
			mapname = "Atlantis";
			break;
		case "mp_dr_away":
			mapname = "Away";
			break;
		case "mp_dr_ax":
			mapname = "AX";
			break;
		case "mp_dr_bananaphone":
			mapname = "Bananaphone";
			break;
		case "mp_dr_bananaphone_v2":
			mapname = "Bananaphone v2";
			break;
		case "mp_dr_beach":
			mapname = "Beach";
			break;
		case "mp_dr_bigfall":
			mapname = "Bigfall";
			break;
		case "mp_dr_biohazard":
			mapname = "Bio Hazard";
			break;
		case "mp_dr_blackandwhite":
			mapname = "Black & White";
			break;
		case "mp_dr_blackandwhite2":
			mapname = "Black & White 2";
			break;
		case "mp_dr_blacknight":
			mapname = "Black Night";
			break;
		case "mp_dr_blacknight2":
			mapname = "Black Night 2";
			break;
		case "mp_dr_blade":
			mapname = "Blade";
			break;
		case "mp_dr_bladev2":
			mapname = "Blade v2";
			break;
		case "mp_dr_bleak":
			mapname = "Bleak";
			break;
		case "mp_dr_blue":
			mapname = "Blue";
			break;
		case "mp_dr_boowie":
			mapname = "Boowie";
			break;
		case "mp_dr_bounce":
			mapname = "Bounce";
			break;
		case "mp_dr_bouncev2":
			mapname = "Bounce v2";
			break;
		case "mp_dr_boxroom":
			mapname = "Box Room";
			break;
		case "mp_dr_brainfuck":
			mapname = "Brainfuck";
			break;
		case "mp_dr_break":
			mapname = "Break";
			break;
		case "mp_dr_bro":
			mapname = "Bro";
			break;
		case "mp_dr_buggedlikehell":
			mapname = "Bugged Like Hell";
			break;
		case "mp_dr_caelum":
			mapname = "Caelum";
			break;
		case "mp_dr_catherine":
			mapname = "Catherine";
			break;
		case "mp_dr_caution":
			mapname = "Caution";
			break;
		case "mp_dr_cliffjumper":
			mapname = "Cliffjumper";
			break;
		case "mp_dr_clifside":
			mapname = "Clifside";
			break;
		case "mp_dr_color":
			mapname = "Color";
			break;
		case "mp_dr_commando":
			mapname = "Commando";
			break;
		case "mp_dr_corner":
			mapname = "Corner";
			break;
		case "mp_dr_crawl":
			mapname = "Crawl";
			break;
		case "mp_dr_crackshot":
			mapname = "Crack Shot";
			break;
		case "mp_dr_creepy2":
			mapname = "Creepy 2";
			break;
		case "mp_dr_crosscode":
			mapname = "Cross Code";
			break;
		case "mp_dr_cyber":
			mapname = "Cyber";
			break;
		case "mp_dr_dangerous":
			mapname = "Dangerous";
			break;
		case "mp_dr_darmuh":
			mapname = "Darmuh";
			break;
		case "mp_dr_darmuhv2":
			mapname = "Darmuh v2";
			break;
		case "mp_dr_dawn":
			mapname = "Dawn";
			break;
		case "mp_dr_dball_gt":
			mapname = "Dragonball GT";
			break;
		case "mp_dr_deadzone":
			mapname = "Dead Zone";
			break;
		case "mp_dr_deepwind":
			mapname = "Deep Wind";
			break;
		case "mp_dr_deathyard":
			mapname = "Deathyard";
			break;
		case "mp_dr_destiny":
			mapname = "Destiny";
			break;
		case "mp_dr_detained":
			mapname = "Detained";
			break;
		case "mp_dr_digital":
			mapname = "Digital";
			break;
		case "mp_dr_digitalworld_v2":
			mapname = "Digital World v2";
			break;
		case "mp_dr_dimensionsv2":
			mapname = "Dimensions v2";
			break;
		case "mp_dr_disco":
			mapname = "Disco";
			break;
		case "mp_dr_discovery":
			mapname = "Discovery";
			break;
		case "mp_dr_dova":
			mapname = "Dova";
			break;
		case "mp_dr_dusk":
			mapname = "Dusk";
			break;
		case "mp_dr_easy_v2":
			mapname = "Easy v2";
			break;
		case "mp_dr_edgeville":
			mapname = "Edgeville";
			break;
		case "mp_dr_epicfail_v2":
			mapname = "Epicfail v2";
			break;
		case "mp_dr_ethereal":
			mapname = "Ethereal";
			break;
		case "mp_dr_evangelion":
			mapname = "Evangelion";
			break;
		case "mp_dr_experts":
			mapname = "Experts";
			break;
		case "mp_dr_fallguys":
			mapname = "Fall Guys";
			break;
		case "mp_dr_fallrun":
			mapname = "Fallrun";
			break;
		case "mp_dr_famous":
			mapname = "Famous";
			break;
		case "mp_dr_fireball_v2":
			mapname = "Fireball v2";
			break;
		case "mp_dr_foggy":
			mapname = "Foggy";
			break;
		case "mp_dr_freakyland":
			mapname = "Freaky Land";
			break;
		case "mp_dr_free":
			mapname = "Free";
			break;
		case "mp_dr_frenchtoast":
			mapname = "French Toast";
			break;
		case "mp_dr_frost":
			mapname = "Frost";
			break;
		case "mp_dr_gasline":
			mapname = "Gasline";
			break;
		case "mp_dr_geno":
			mapname = "Geno";
			break;
		case "mp_dr_getspooky":
			mapname = "Get Spooky";
			break;
		case "mp_dr_glass2":
			mapname = "Glass 2";
			break;
		case "mp_dr_glass3":
			mapname = "Glass 3";
			break;
		case "mp_dr_gooby":
			mapname = "Gooby";
			break;
		case "mp_dr_guest_list":
			mapname = "Guest List";
			break;
		case "mp_dr_h2o":
			mapname = "H2O";
			break;
		case "mp_dr_hardest_game":
			mapname = "Hardest Game";
			break;
		case "mp_dr_hardstyle":
			mapname = "Hardstyle";
			break;
		case "mp_dr_harrypotter":
			mapname = "Harry Potter";
			break;
		case "mp_dr_hazard":
			mapname = "Hazard";
			break;
		case "mp_dr_headdy":
			mapname = "Headdy";
			break;
		case "mp_dr_heat":
			mapname = "Heat";
			break;
		case "mp_dr_heaven":
			mapname = "Heaven";
			break;
		case "mp_dr_hilly_v2":
			mapname = "Hilly v2";
			break;
		case "mp_dr_hoa":
			mapname = "Hoa";
			break;
		case "mp_dr_holyshiet":
			mapname = "Holyshiet";
			break;
		case "mp_dr_holyshiet_v2":
			mapname = "Holyshiet v2";
			break;
		case "mp_dr_imaginary":
			mapname = "Imaginary";
			break;
		case "mp_dr_india":
			mapname = "India";
			break;
		case "mp_dr_indipyramid":
			mapname = "Indipyramid";
			break;
		case "mp_dr_inside":
			mapname = "Inside";
			break;
		case "mp_dr_iwillrockyou":
			mapname = "I will rock You";
			break;
		case "mp_dr_jump":
			mapname = "Jump";
			break;
		case "mp_dr_jump_hard":
			mapname = "Jump Hard";
			break;
		case "mp_dr_jumpv2":
			mapname = "Jump v2";
			break;
		case "mp_dr_jungletemple":
			mapname = "Jungle Temple";
			break;
		case "mp_dr_jurapark":
			mapname = "Jura Park";
			break;
		case "mp_dr_kris":
			mapname = "Kris";
			break;
		case "mp_dr_kris_v2":
			mapname = "Kris v2";
			break;
		case "mp_dr_laboratory":
			mapname = "Laboratory";
			break;
		case "mp_dr_latenight":
			mapname = "Late Night";
			break;
		case "mp_dr_lava_world":
			mapname = "Lava World";
			break;
		case "mp_dr_lazyriver":
			mapname = "Lazy River";
			break;
		case "mp_dr_legion":
			mapname = "Legion";
			break;
		case "mp_dr_levels":
			mapname = "Levels";
			break;
		case "mp_dr_lifes":
			mapname = "Lifes";
			break;
		case "mp_dr_light":
			mapname = "Light";
			break;
		case "mp_dr_likeaboss":
			mapname = "Like a Boss";
			break;
		case "mp_dr_lithium":
			mapname = "Lithium";
			break;
		case "mp_dr_littlemap":
			mapname = "Little Map";
			break;
		case "mp_dr_lolz":
			mapname = "LoLz";
			break;
		case "mp_dr_lovelyplanet":
			mapname = "Lovely Planet";
			break;
		case "mp_dr_lxury":
			mapname = "Lxury";
			break;
		case "mp_dr_magical":
			mapname = "Magical";
			break;
		case "mp_dr_mountain_escape":
			mapname = "Mountain Escape";
			break;
		case "mp_dr_mario_land":
			mapname = "Mario Land";
			break;
		case "mp_dr_meatboy":
			mapname = "Meat Boy";
			break;
		case "mp_dr_merry_xmas":
			mapname = "Merry Xmas";
			break;
		case "mp_dr_mew":
			mapname = "Mew";
			break;
		case "mp_dr_minerun":
			mapname = "Minerun";
			break;
		case "mp_dr_mineshaft":
			mapname = "Mineshaft";
			break;
		case "mp_dr_minibounce_v2":
			mapname = "'Mini Bounce v2";
			break;
		case "mp_dr_mirrors_edge":
			mapname = "Mirrors Edge";
			break;
		case "mp_dr_moonsday":
			mapname = "Moons Day";
			break;
		case "mp_dr_mycastle":
			mapname = "My Castle";
			break;
		case "mp_dr_mystic":
			mapname = "Mystic";
			break;
		case "mp_dr_nebula":
			mapname = "Nebula";
			break;
		case "mp_dr_neon":
			mapname = "Neon";
			break;
		case "mp_dr_neuschwanstein":
			mapname = "Neu Schwanstein";
			break;
		case "mp_dr_nightlight":
			mapname = "Nightlight";
			break;
		case "mp_dr_nighty":
			mapname = "Nighty";
			break;
		case "mp_dr_nimble":
			mapname = "Nimble";
			break;
		case "mp_dr_nitro":
			mapname = "Nitro";
			break;
		case "mp_dr_nuka2":
			mapname = "Nuka 2";
			break;
		case "mp_dr_nxs_jump":
			mapname = "NXS Jump";
			break;
		case "mp_dr_omg":
			mapname = "OMG";
			break;
		case "mp_dr_old_factory":
			mapname = "Old Factory";
			break;
		case "mo_dr_omar2":
			mapname = "Omar 2";
			break;
		case "mp_dr_omar3":
			mapname = "Omar 3";
			break;
		case "mp_dr_orbit":
			mapname = "Orbit";
			break;
		case "mp_dr_onsea":
			mapname = "Onsea";
			break;
		case "mp_dr_outside":
			mapname = "Outside";
			break;
		case "mp_dr_overgrown":
			mapname = "Overgrown";
			break;
		case "mp_dr_owl":
			mapname = "Owl";
			break;
		case "mp_dr_oxidation":
			mapname = "Oxidation";
			break;
		case "mp_dr_pacman":
			mapname = "Pac Man";
			break;
		case "mp_dr_pandemonium":
			mapname = "Pandemonium";
			break;
		case "mp_dr_periglo":
			mapname = "Periglo";
			break;
		case "mo_dr_petrichor":
			mapname = "Petrichor";
			break;
		case "mp_dr_phantasy":
			mapname = "Phantasy";
			break;
		case "mp_dr_pipe":
			mapname = "Pipe";
			break;
		case "mp_dr_pipe_w":
			mapname = "Winter Pipe";
			break;
		case "mp_dr_pluvious":
			mapname = "Pluvious";
			break;
		case "mp_dr_pool":
			mapname = "Pool";
			break;
		case "mp_dr_poseidon":
			mapname = "Poseidon";
			break;
		case "mp_dr_prison_escape":
			mapname = "Prison Escape";
			break;
		case "mp_dr_prisonv2":
			mapname = "Prison v2";
			break;
		case "mp_dr_pro":
			mapname = "Pro";
			break;
		case "mp_dr_pro_v2":
			mapname = "Pro v2";
			break;
		case "mp_dr_progression":
			mapname = "Progression";
			break;
		case "mp_dr_purple_world":
			mapname = "Purple World";
			break;
		case "mp_dr_purple_worldv2":
			mapname = "Purple World v2";
			break;
		case "mp_dr_pyramid":
			mapname = "Pyramid";
			break;
		case "mp_dr_qube_evolved":
			mapname = "Qube Evolved";
			break;
		case "mp_dr_radical":
			mapname = "Radical";
			break;
		case "mp_dr_rage":
			mapname = "Rage";
			break;
		case "mp_dr_rainbow":
			mapname = "Rainbow";
			break;
		case "mp_dr_raindrops":
			mapname = "Raindrops";
			break;
		case "mp_dr_raky":
			mapname = "Raky";
			break;
		case "mp_dr_ravine":
			mapname = "Ravine";
			break;
		case "mp_dr_riverbed":
			mapname = "Riverbed";
			break;
		case "mp_dr_rock":
			mapname = "Rock";
			break;
		case "mp_dr_royals":
			mapname = "Royals";
			break;
		case "mp_dr_run":
			mapname = "Run";
			break;
		case "mp_dr_running":
			mapname = "Running";
			break;
		case "mp_dr_running_v2":
			mapname = "Running v2";
			break;
		case "mp_dr_rushoween":
			mapname = "Rushoween";
			break;
		case "mp_dr_samsara":
			mapname = "Samsara";
			break;
		case "mp_dr_sand":
			mapname = "Sand";
			break;
		case "mp_dr_saw_evolved":
			mapname = "Saw Evolved";
			break;
		case "mp_dr_sean":
			mapname = "Sean";
			break;
		case "mp_dr_sean2":
			mapname = "Sean 2";
			break;
		case "mp_dr_sewers":
			mapname = "Sewers";
			break;
		case "mp_dr_sheox":
			mapname = "Sheox";
			break;
		case "mp_dr_shield":
			mapname = "Shield";
			break;
		case "mp_dr_shipment":
			mapname = "Shipment";
			break;
		case "mp_dr_short":
			mapname = "Short";
			break;
		case "mp_dr_simple":
			mapname = "Simple";
			break;
		case "mp_dr_simpsons":
			mapname = "Simpsons";
			break;
		case "mp_dr_skii":
			mapname = "Skii";
			break;
		case "mp_dr_skydeath":
			mapname = "Skydeath";
			break;
		case "mp_dr_skypower":
			mapname = "Skypower";
			break;
		case "mp_dr_slay":
			mapname = "Slay";
			break;
		case "mp_dr_slayv2":
			mapname = "Slay v2";
			break;
		case "mp_dr_sm64":
			mapname = "Mario 64";
			break;
		case "mp_dr_sm_world":
			mapname = "Mario World";
			break;
		case "mp_dr_snip":
			mapname = "Snip";
			break;
		case "mp_dr_something":
			mapname = "Something";
			break;
		case "mp_dr_spaceball_v2":
			mapname = "Spaceball v2";
			break;
		case "mp_dr_spacelab":
			mapname = "Space Lab";
			break;
		case "mp_dr_spacetrip":
			mapname = "Space Trip";
			break;
		case "mp_dr_spacetunnel":
			mapname = "Space Tunnel";
			break;
		case "mp_dr_spedex":
			mapname = "Spedex";
			break;
		case "mp_dr_spider":
			mapname = "Spider";
			break;
		case "mp_dr_spirit":
			mapname = "Spirit";
			break;
		case "mp_dr_squidy":
			mapname = "Squidy";
			break;
		case "mp_dr_steelv2":
			mapname = "Steel v2";
			break;
		case "mp_dr_stonerun":
			mapname = "Stone Run";
			break;
		case "mp_dr_stormyascent":
			mapname = "Story Ascent";
			break;
		case "mp_dr_storyhouse":
			mapname = "Story House";
			break;
		case "mp_dr_street":
			mapname = "Street";
			break;
		case "mp_dr_stronghold":
			mapname = "Stronghold";
			break;
		case "mp_dr_style":
			mapname = "Style";
			break;
		case "mp_dr_sub":
			mapname = "Sub";
			break;
		case "mp_dr_sucatraps":
			mapname = "Sucatraps";
			break;
		case "mp_dr_sunset":
			mapname = "Sunset";
			break;
		case "mp_dr_sunset2":
			mapname = "Sunset 2";
			break;
		case "mp_dr_sunset3":
			mapname = "Sunset 3";
			break;
		case "mp_dr_survive":
			mapname = "Survive";
			break;
		case "mp_dr_takeshi":
			mapname = "Takeshi";
			break;
		case "mp_dr_templerun":
			mapname = "Temple Run";
			break;
		case "mp_dr_terror":
			mapname = "Terror";
			break;
		case "mp_dr_theshack":
			mapname = "The Shack";
			break;
		case "mp_dr_thewar":
			mapname = "The War";
			break;
		case "mp_dr_the_void":
			mapname = "The Void";
			break;
		case "mp_dr_timetravel":
			mapname = "Time Travel";
			break;
		case "mp_dr_trapntrance":
			mapname = "Trap & Trance";
			break;
		case "mp_dr_trapntrance_v2":
			mapname = "Trap & Trance v2";
			break;
		case "mp_dr_trapz":
			mapname = "Trapz";
			break;
		case "mp_dr_trens":
			mapname = "Trens";
			break;
		case "mp_dr_trikx":
			mapname = "Trikx";
			break;
		case "mp_dr_tron":
			mapname = "Tron";
			break;
		case "mp_dr_tropical":
			mapname = "Tropical";
			break;
		case "mp_dr_turnabout":
			mapname = "Turnabout";
			break;
		case "mp_dr_twitch":
			mapname = "Twitch";
			break;
		case "mp_dr_un_named":
			mapname = "Un Named";
			break;
		case "mp_dr_underground":
			mapname = "Underground";
			break;
		case "mp_dr_undertale":
			mapname = "Under Tale";
			break;
		case "mp_dr_underwater":
			mapname = "Under Water";
			break;
		case "no_dr_universe":
			mapname = "Universe";
			break;
		case "mp_dr_unreal":
			mapname = "Unreal";
			break;
		case "mp_dr_unusual":
			mapname = "Unusual";
			break;
		case "mp_dr_up":
			mapname = "uP";
			break;
		case "mp_dr_urban":
			mapname = "Urban";
			break;
		case "mp_dr_vector":
			mapname = "Vector";
			break;
		case "mp_dr_vistic_castle":
			mapname = "Vistic Castle";
			break;
		case "mp_dr_vistic_castle_w":
			mapname = "Winter Vistic Castle";
			break;
		case "mp_dr_volpe":
			mapname = "Volpe";
			break;
		case "mp_dr_volpe2":
			mapname = "Volpe 2";
			break;
		case "mp_dr_volpe3":
			mapname = "Volpe 3";
			break;
		case "mp_dr_volpe4":
			mapname = "Volpe 4";
			break;
		case "mp_dr_watercity":
			mapname = "Watercity";
			break;
		case "mp_dr_wayout":
			mapname = "Way Out";
			break;
		case "mp_dr_western":
			mapname = "Western";
			break;
		case "mp_dr_windwaker":
			mapname = "Wind Waker";
			break;
		case "mp_dr_winter_wipeout":
			mapname = "Winter Wipeout";
			break;
		case "mp_dr_wipeout":
			mapname = "Wipeout";
			break;
		case "mp_dr_workplease":
			mapname = "Work Please";
			break;
		case "mp_dr_world":
			mapname = "World";
			break;
		case "mp_dr_worldofmetal":
			mapname = "World of Metal";
			break;
		case "mp_dr_wtf":
			mapname = "WTF";
			break;
		case "mp_dr_xm":
			mapname = "xM";
			break;
		case "mp_dr_xm2":
			mapname = "xM 2";
			break;
		case "mp_dr_xm3":
			mapname = "xM 3";
			break;
		case "mp_dr_xmstyle":
			mapname = "xM Style";
			break;
		case "mp_dr_xplosive":
			mapname = "Xplosive";
			break;
		case "mp_dr_zvr_dimensions2_w":
			mapname = "Winter Dimvensions 2";
			break;
		case "mp_dr_zvr_dimensions":
			mapname = "Dimensions";
			break;
		case "mp_dr_rubyshore":
			mapname = "Ruby Shore";
			break;
		case "mp_dr_cloudeye":
			mapname = "Cloudeye";
			break;

		// Vistic Exclusive
		case "mp_vc_above":
			mapname = "Above";
			break;
		case "mp_vc_astral":
			mapname = "Astral";
			break;
		case "mp_vc_autumn_run":
			mapname = "Autumn Run";
			break;
		case "mp_vc_bounceworld":
			mapname = "Bounce World";
			break;
		case "mp_vc_bouncezor":
			mapname = "Bouncezor";
			break;
		case "mp_vc_bridge":
			mapname = "Bridge";
			break;
		case "mp_vc_bridge_v2":
			mapname = "Bridge v2";
			break;
		case "mp_vc_catjumper":
			mapname = "Cat Jumper";
			break;
		case "mp_vc_crypt":
			mapname = "Crypt";
			break;
		case "mp_vc_desert":
			mapname = "Desert";
			break;
		case "mp_vc_downed":
			mapname = "Downed";
			break;
		case "mp_vc_evangelion":
			mapname = "Evangelion";
			break;
		case "mp_vc_garage":
			mapname = "Garage";
			break;
		case "mp_vc_glen":
			mapname = "Glen";
			break;
		case "mp_vc_halloween_run":
			mapname = "Halloween Run";
			break;
		case "mp_vc_harrypotter":
			mapname = "Harry Potter";
			break;
		case "mp_vc_haunted":
			mapname = "Haunted";
			break;
		case "mp_vc_hayaya":
			mapname = "Hayaya";
			break;
		case "mp_vc_heavy":
			mapname = "Heavy";
			break;
		case "mp_vc_high":
			mapname = "High";
			break;
		case "mp_vc_jungle":
			mapname = "Jungle";
			break;
		case "mp_vc_lounge":
			mapname = "Lounge";
			break;
		case "mp_vc_napoca":
			mapname = "Napoca";
			break;
		case "mp_vc_nebula":
			mapname = "Nebula";
			break;
		case "mp_vc_nebula_v2":
			mapname = "Nebula v2";
			break;
		case "mp_vc_nightmare":
			mapname = "Nightmare";
			break;
		case "mp_vc_nightsky":
			mapname = "Night Sky";
			break;
		case "mp_vc_nike":
			mapname = "Nike";
			break;
		case "mp_vc_nuri":
			mapname = "Nuri";
			break;
		case "mp_vc_obscure":
			mapname = "Obscure";
			break;
		case "mp_vc_originals":
			mapname = "Originals";
			break;
		case "mp_vc_paradise":
			mapname = "Paradise";
			break;
		case "mp_vc_platinumv2":
			mapname = "Platinum v2";
			break;
		case "mp_vc_sam":
			mapname = "Sam";
			break;
		case "mp_vc_sick_ev":
			mapname = "Sick Evolved";
			break;
		case "mp_vc_sjsm":
			mapname = "SJSM";
			break;
		case "mp_vc_skylight":
			mapname = "Sky Light";
			break;
		case "mp_vc_spacepath":
			mapname = "Space Path";
			break;
		case "mp_vc_tunnels":
			mapname = "Tunnels";
			break;
		case "mp_vc_twosteps":
			mapname = "Two Steps";
			break;
		case "mp_vc_unnatural":
			mapname = "Unnatural";
			break;
		case "mp_vc_widow":
			mapname = "Widow";
			break;
		case "mp_vc_winter_run":
			mapname = "Winter Run";
			break;
		case "mp_vc_woodland":
			mapname = "Woodland";
			break;
	
		// if nothing matches
		default:
			mapname = mapname;
			iprintln("string db entry missing for "+mapname);
			break;
	}
	return (string + mapname);
}

getMapNameType(type)
{
	toks = strtok(tolower(type), "_");
	switch(toks[1])
	{
		case "dr":
		case "deathrun":
			type = "DeathRun";
			break;

		case "vc":
		case "vistic":
			type = "^5Vistic";
			break;
		case "fnrp":
			type = "^4FNRP";
			break;
		case "sfs":
			type = "^3SFS";
			break;
	}
	return type;
}

getSoundString(sound)
{
	switch(toLower(sound))
	{
		case "de":
			sound = "Default";
			break;
		case "edm":
			sound = "EDM";
			break;
		case "hs":
			sound = "Hardstyle";
			break;
		case "tr":
			sound = "Trapstep";
			break;
		case "db":
			sound = "DnB";
			break;
		case "ds":
			sound = "Dubstep";
			break;
	}
	return sound;
}

getStatString(stat)
{
	switch(toLower(stat))
	{
		case "kills":
			stat = "Precision Soda";
			break;
		case "deaths":
			stat = "Gravity Victim";
			break;
		case "headshots":
			stat = "Hair Stylist";
			break;
		case "score":
			stat = "Shot, Score!";
			break;
		case "knifes":
			stat = "Master Chef";
			break;
		case "time":
			stat = "Speed Love";
			break;
	}
	return stat;
}