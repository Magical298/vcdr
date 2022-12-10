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

maplist_setup()
{
    level.radius = undefined;
    level.playeroffset = undefined;
    level.triggeroffset = (0,0,100);

    if(!isdefined(level.queue_triggers))
    {
        level.queue_triggers = [];

        switch(level.mapName)
        {
            case "mp_dr_underwater":
                level.queue_triggers[level.queue_triggers.size] = getEnt("knif_trig","targetname"); 
                level.queue_triggers[level.queue_triggers.size] = getEnt("snip_trig","targetname"); 
                level.queue_triggers[level.queue_triggers.size] = getEnt("trig_old","targetname"); 
                break;

            case "mp_dr_sm_world":
                level.queue_triggers[level.queue_triggers.size] = getEnt("trigg_old","targetname"); 
                level.queue_triggers[level.queue_triggers.size] = getEnt("trigg_sniper","targetname"); 
                level.queue_triggers[level.queue_triggers.size] = getEnt("trigg_weapons","targetname"); 
                break;

            case "mp_dr_disco":
                level.queue_triggers[level.queue_triggers.size] = getEnt("trig_end_bush","targetname"); 
                level.queue_triggers[level.queue_triggers.size] = getEnt("trig_end_marine","targetname"); 
                level.queue_triggers[level.queue_triggers.size] = getEnt("trig_end_sniper","targetname"); 
                level.queue_triggers[level.queue_triggers.size] = getEnt("trig_end_ice","targetname"); 
                level.queue_triggers[level.queue_triggers.size] = getEnt("trig_end_heavy","targetname"); 
                level.queue_triggers[level.queue_triggers.size] = getEnt("trig_end_flash","targetname"); 
                level.queue_triggers[level.queue_triggers.size] = getEnt("trig_end_earthquake","targetname"); 
                level.queue_triggers[level.queue_triggers.size] = getEnt("trig_end_fall","targetname"); 
                level.queue_triggers[level.queue_triggers.size] = getEnt("trig_end_old","targetname"); 
                break;

            case "mp_dr_stonerun":
                level.queue_triggers[level.queue_triggers.size] = getEnt("sniper_trigger","targetname"); 
                level.queue_triggers[level.queue_triggers.size] = getEnt("bounce_trigger","targetname"); 
                level.queue_triggers[level.queue_triggers.size] = getEnt("old_jumper_trigger","targetname"); 
                break;

            case "mp_dr_skypower":
                level.queue_triggers[level.queue_triggers.size] = getEnt("jump_trig","targetname"); 
                level.queue_triggers[level.queue_triggers.size] = getEnt("sniper_trig","targetname"); 
                level.queue_triggers[level.queue_triggers.size] = getEnt("teleport1_trigger","targetname"); 
                break;

            case "mp_deathrun_minecraft":
                level.queue_triggers[level.queue_triggers.size] = getEnt("finishdoor","targetname"); 
                break;

            case "mp_deathrun_skypillar":
                level.queue_triggers[level.queue_triggers.size] = getEnt("jump_teleport","targetname"); 
                level.queue_triggers[level.queue_triggers.size] = getEnt("trigger_sniperroom","targetname"); 
                level.queue_triggers[level.queue_triggers.size] = getEnt("trigger_finish","targetname"); 
                break;

            case "mp_dr_zvr_dimensions":
                level.queue_triggers[level.queue_triggers.size] = getEnt("endroom_trigger","targetname"); 
                break;

            case "mp_deathrun_gold":
                level.queue_triggers[level.queue_triggers.size] = getEnt("snipe_trig","targetname"); 
                level.queue_triggers[level.queue_triggers.size] = getEnt("knife_trig","targetname"); 
                break;

            case "mp_dr_holyshiet":
                level.queue_triggers[level.queue_triggers.size] = getent("endport","targetname");
                break;

            case "mp_deathrun_horror":
                level.queue_triggers[level.queue_triggers.size] = getent("sniper","targetname");
                level.queue_triggers[level.queue_triggers.size] = getent("jump","targetname");
                level.queue_triggers[level.queue_triggers.size] = getent("virus","targetname");
                level.queue_triggers[level.queue_triggers.size] = getent("weapon","targetname");
                level.queue_triggers[level.queue_triggers.size] = getent("old_trig","targetname");
                break;

            case "mp_deathrun_diehard":
                level.queue_triggers[level.queue_triggers.size] = getent("trigger_gamedoor_sniper","targetname");
                level.queue_triggers[level.queue_triggers.size] = getent("teleportjumproom","targetname");
                level.queue_triggers[level.queue_triggers.size] = getent("lastdoor","targetname");
                break;

            case "mp_deathrun_iceops":
                level.queue_triggers[level.queue_triggers.size] = getent("sniper_trig","targetname");
                level.queue_triggers[level.queue_triggers.size] = getent("weapons_trigger","targetname");
                level.queue_triggers[level.queue_triggers.size] = getent("jump_trig","targetname");
                break;
        }
    }

    if(isdefined(level.queue_triggers))
    {
        for(i=0; i<level.queue_triggers.size; i++)
            plugins\_queue::checkQueueRoom(level.queue_triggers[i]);
    }


    /*
    switch(getdvar("mapname"))
    {
   


        case "mp_dr_ax":

        room_trigs[0] = getent("old_trig","targetname");

        room_trigs[1] = getent("sniper_trig","targetname");

        room_trigs[2] = getent("knife_trig","targetname");

        room_trigs[3] = getent("jump_trig","targetname");

        room_trigs[4] = getent("rpg_trig","targetname");

        break;



        case "mp_deathrun_storm":

        room_trigs[0] = getent("final_sniper_trig","targetname");

        room_trigs[1] = getent("final_jump_trig","targetname");

        room_trigs[2] = getent("final_knife_trig","targetname");

        break;



        case "mp_dr_tron":

        room_trigs[0] = getent("minigames","targetname");

        room_trigs[1] = getent("oldtrig","targetname");

        level.radius = 100;

        level.playeroffset = (0,0,-130);

        break;



        case "mp_dr_volpe3":

        room_trigs[0] = getent("trig_knife","targetname");

        room_trigs[1] = getent("trig_bounce","targetname");

        room_trigs[2] = getent("trig_race","targetname");

        room_trigs[3] = getent("trig_sniper","targetname");

        room_trigs[4] = getent("trig_wep","targetname");

        room_trigs[5] = getent("trig_shot","targetname");

        level.playeroffset = (0,0,-100);

        break;

        

        case "mp_dr_volpe2":

        room_trigs[0] = getent("bounce_room","targetname");

        room_trigs[1] = getent("knife_room","targetname");

        room_trigs[2] = getent("hop_room","targetname");

        room_trigs[3] = getent("sniper_room","targetname");

        room_trigs[4] = getent("shotgun_room","targetname");

        room_trigs[5] = getent("wep_room","targetname");

        room_trigs[6] = getent("rpg_room","targetname");

        break;



        case "mp_dr_volpe":

        room_trigs[0] = getent("trig_knife","targetname");

        room_trigs[1] = getent("sniper_room","targetname");

        room_trigs[2] = getent("bounce_room","targetname");

        room_trigs[3] = getent("rpg_room","targetname");

        break;

        

        case "mp_vc_above":

        room_trigs[0] = getent("trig_knife","targetname");

        room_trigs[1] = getent("trig_maze","targetname");

        room_trigs[2] = getent("trig_lmg","targetname");

        room_trigs[3] = getent("trig_rpg","targetname");

        room_trigs[4] = getent("trig_sniper","targetname");

        break;



        case "mp_vc_nightmare":

        room_trigs[0] = getent("trig_shotgun","targetname");

        room_trigs[1] = getent("trig_sniper","targetname");

        room_trigs[2] = getent("trig_mark","targetname");

        room_trigs[3] = getent("trig_rpg","targetname");

        break;



        case "mp_vc_obscure":

        room_trigs[0] = getent("trig_knife","targetname");

        room_trigs[1] = getent("trig_garand","targetname");

        room_trigs[2] = getent("trig_sniper","targetname");

        break;



        case "mp_dr_vistic_castle_w":

        room_trigs[0] = getent("jumproom_ent","targetname");

        room_trigs[1] = getent("sniproom_ent","targetname");

        room_trigs[2] = getent("rpgroom_ent","targetname");

        room_trigs[3] = getent("sgunroom_ent","targetname");

        room_trigs[4] = getent("kniferoom_ent","targetname");

        room_trigs[5] = getent("oldroom_ent","targetname");

        break;



        case "mp_dr_prison_escape":

        room_trigs[0] = getent("old_trig","targetname");

        room_trigs[1] = getent("snip_trig","targetname");

        room_trigs[2] = getent("rpg_trig","targetname");

        room_trigs[3] = getent("knife_trig","targetname");

        room_trigs[4] = getent("weapon_trig","targetname");

        room_trigs[5] = getent("bounce_trig","targetname");

        level.playeroffset = (100,0,0);

        break;



        case "mp_deathrun_mall":

        room_trigs[0] = getent("final_trig","targetname");

        level.radius = 100;

        break;



        case "mp_deathrun_qube":

        room_trigs[0] = getent("teleportjumproom","targetname");

        room_trigs[1] = getent("teleportbounceroom","targetname");

        room_trigs[2] = getent("teleportkniferoom","targetname");

        room_trigs[3] = getent("teleportsniperroom","targetname");

        room_trigs[4] = getent("trigger_oldopen","targetname");

        level.radius = 60;

        break;



        case "mp_deathrun_winter":

        room_trigs[0] = getent("knifetpr","targetname");

        room_trigs[1] = getent("sniptp","targetname");

        room_trigs[2] = getent("lavatpr","targetname");

        break;



        case "mp_dr_asu":

        room_trigs[0] = getent("trig_endroomtp","targetname");

        level.radius = 100;

        break;



        case "mp_vc_heavy":

        room_trigs[0] = getent("trig_endroomtp","targetname");

        level.radius = 100;

        break;



        case "mp_dr_bigfall":

        room_trigs[0] = getent("old_enter","targetname");

        room_trigs[1] = getent("bounce_enter","targetname");

        room_trigs[2] = getent("sniper_enter","targetname");

        room_trigs[3] = getent("shotgun_enter","targetname");

        break;



        case "mp_dr_digital":

        room_trigs[0] = getent("trigger_sniper","targetname");

        room_trigs[1] = getent("trigger_knife","targetname");

        room_trigs[2] = getent("trigger_ak","targetname");

        room_trigs[3] = getent("trigger_aku","targetname");

        room_trigs[4] = getent("trigger_bounce","targetname");

        break;



        case "mp_dr_laboratory":

        room_trigs[0] = getent("sniper_trigger","targetname");

        room_trigs[1] = getent("knife_trigger","targetname");

        room_trigs[2] = getent("bounce_trigger","targetname");

        room_trigs[3] = getent("randomweap_trigger","targetname");

        room_trigs[4] = getent("oldway_trigger","targetname");

        break;



        case "mp_vc_nebula":

        room_trigs[0] = getent("trig_sniper","targetname");

        room_trigs[1] = getent("wep_room","targetname");

        room_trigs[2] = getent("trig_bounce","targetname");

        room_trigs[3] = getent("trig_race","targetname");

        level.radius = 120;

        break;



        case "mp_dr_something":

        room_trigs[0] = getent("trig_old","targetname");

        room_trigs[1] = getent("trig_sniper","targetname");

        room_trigs[2] = getent("trig_bounce","targetname");

        room_trigs[3] = getent("trig_ladder","targetname");

        room_trigs[4] = getent("trig_knife","targetname");

        break;



        case "mp_dr_pipe_w":

        room_trigs[0] = getent("sniproom_ent","targetname");

        room_trigs[1] = getent("kniferoom_ent","targetname");

        room_trigs[2] = getent("bounceroom_ent","targetname");

        break;



        case "mp_vc_nike":

        room_trigs[0] = getent("knife_room_trigger","targetname");

        room_trigs[1] = getent("snipe_room_trigger","targetname");

        room_trigs[2] = getent("jump_room_trigger","targetname");

        break;



        case "mp_vc_astral":

        room_trigs[0] = getent("knife_tp","targetname");

        room_trigs[1] = getent("jumper_tp","targetname");

        room_trigs[2] = getent("old_enter","targetname");

        break;



        case "mp_vc_platinumv2":

        room_trigs[0] = getent("sniper","targetname");

        room_trigs[1] = getent("jump","targetname");

        break;



        case "mp_deathrun_liferun":

        room_trigs[0] = getent("enddoor_trig","targetname");

        level.radius = 40;

        level.playeroffset = (100,0,0);

        break;



        case "mp_fnrp_iceland_v2":

        room_trigs[0] = getent("finaldoor","targetname");

        level.radius = 130;

        break;



        case "mp_dr_deadzone":

        room_trigs[0] = getent("final_sniper_trig","targetname");

        room_trigs[1] = getent("final_rpg_trig","targetname");

        room_trigs[2] = getent("final_pistol_trig","targetname");

        room_trigs[3] = getent("final_old_trig","targetname");

        room_trigs[4] = getent("final_jump_trig","targetname");

        room_trigs[5] = getent("final_shotgun_trig","targetname");

        room_trigs[6] = getent("final_knife_trig","targetname");

        room_trigs[7] = getent("final_crazy_trig","targetname");

        level.radius = 120;

        break;



        case "mp_dr_freakyland":

        room_trigs[0] = getent("old_room","targetname");

        room_trigs[1] = getent("knife_room","targetname");

        room_trigs[2] = getent("sniper_room","targetname");

        level.radius = 100;

        break;



        case "mp_dr_rock":

        room_trigs[0] = getent("trig_old","targetname");

        room_trigs[1] = getent("trig_maze","targetname");

        room_trigs[2] = getent("trig_sniper","targetname");

        level.radius = 100;

        break;



        case "mp_dr_blackandwhite":

        room_trigs[0] = getent("sniper_trigger","targetname");

        room_trigs[1] = getent("old_trigger","targetname");

        room_trigs[2] = getent("knife_trigger","targetname");

        room_trigs[3] = getent("jump_trigger","targetname");

        level.radius = 150;

        break;



        case "mp_dr_blade":

        room_trigs[0] = getent("trig_sniper","targetname");

        room_trigs[1] = getent("trig_deagle","targetname");

        room_trigs[2] = getent("trig_old","targetname");

        room_trigs[3] = getent("trig_jump","targetname");

        break;



        case "mp_dr_steelv2":

        room_trigs[0] = getent("sniper_trigger","targetname");

        room_trigs[1] = getent("bounce_trigger","targetname");

        room_trigs[2] = getent("knife_trigger","targetname");

        room_trigs[3] = getent("knife_rotate_trigger","targetname");

        room_trigs[4] = getent("old_jumper_trigger","targetname");

        break;



        case "mp_dr_beach":

        room_trigs[0] = getent("s_trig","targetname");

        room_trigs[1] = getent("b_trig","targetname");

        room_trigs[2] = getent("o_trig","targetname");

        room_trigs[3] = getent("k_trig","targetname");

        room_trigs[4] = getent("r_trig","targetname");

        break;



        case "mp_deathrun_coyote":

        room_trigs[0] = getent("knife_room_end","targetname");

        room_trigs[1] = getent("sniper_room_end","targetname");

        room_trigs[2] = getent("jump_room_end","targetname");

        break;



        case "mp_deathrun_coyote_v2":

        room_trigs[0] = getent("jumproom_ent","targetname");

        room_trigs[1] = getent("sniproom_ent","targetname");

        room_trigs[2] = getent("rpgroom_ent","targetname");

        room_trigs[3] = getent("kniferoom_ent","targetname");

        room_trigs[4] = getent("sgunroom_ent","targetname");

        room_trigs[5] = getent("akroom_ent","targetname");

        room_trigs[6] = getent("oldroom_ent","targetname");

        break;



        case "mp_deathrun_cookie_v3":

        room_trigs[0] = getent("finaldoor_trig","targetname");

        break;



        case "mp_dr_xm3":

        room_trigs[0] = getent("room_selection","targetname");

        break;

        

        case "mp_dr_discovery":

        room_trigs[0] = getent("trig_endroom","targetname");

        break;



        case "mp_dr_xm2":

        room_trigs[0] = getent("sniper","targetname");

        room_trigs[1] = getent("knife","targetname");

        room_trigs[2] = getent("weapon","targetname");

        room_trigs[3] = getent("bounce","targetname");

        break;



        case "mp_dr_xm":

        room_trigs[0] = getent("sniper","targetname");

        room_trigs[1] = getent("knife","targetname");

        room_trigs[2] = getent("weapon","targetname");

        room_trigs[3] = getent("bounce","targetname");

        break;



        case "mp_dr_lazyriver":

        room_trigs[0] = getent("endgame","targetname");

        room_trigs[1] = getent("sniper_trig","targetname");

        room_trigs[2] = getent("shot_trig","targetname");

        room_trigs[3] = getent("knife_trig","targetname");

        break;



        case "mp_dr_running_v2":

        room_trigs[0] = getent("sniper_r","targetname");

        room_trigs[1] = getent("deagle_r","targetname");

        room_trigs[2] = getent("knife_r","targetname");

        break;



        case "mp_dr_foggy":

        room_trigs[0] = getent("scope_trigger","targetname");

        room_trigs[1] = getent("knife_trigger","targetname");

        room_trigs[2] = getent("pistol_trigger","targetname");

        break;



        case "mp_dr_rainbow":

        room_trigs[0] = getent("games","targetname");

        break;



        case "mp_dr_lithium":

        room_trigs[0] = getent("minigames","targetname");

        break;


       case "mp_deathrun_cookie":
       room_trigs[0] = getent("door_trigger","targetname");
       level.playeroffset = (0,-125,0);
       break;


        case "mp_dr_caelum":

        room_trigs[0] = getent("end_old_trig","targetname");

        room_trigs[1] = getent("end_sniper_trig","targetname");

        room_trigs[2] = getent("end_deagle_trig","targetname");

        room_trigs[3] = getent("end_knife_trig","targetname");

        room_trigs[4] = getent("end_islands_trig","targetname");

        room_trigs[5] = getent("end_jump_trig","targetname");

        break;



        case "mp_dr_outside":

        room_trigs[0] = getent("sniproom","targetname");

        room_trigs[1] = getent("kniferoom","targetname");

        room_trigs[2] = getent("jumproom","targetname");

        room_trigs[3] = getent("deagleroom","targetname");

        break;

        

        case "mp_dr_nebula":

        room_trigs[0] = getent("trig_knife","targetname");

        room_trigs[1] = getent("trig_bounce","targetname");

        room_trigs[2] = getent("trig_sniper","targetname");

        room_trigs[3] = getent("trig_speed","targetname");

        break;



        case "mp_deathrun_spaceball":

        room_trigs[0] = getent("kniferoom","targetname");

        room_trigs[1] = getent("rpgroom","targetname");

        room_trigs[2] = getent("sniperroom","targetname");

        room_trigs[3] = getent("jumproom","targetname");

        break;



        case "mp_dr_35":

        room_trigs[0] = getent("trigger_sniper","targetname");

        room_trigs[1] = getent("trigger_knife","targetname");

        room_trigs[2] = getent("trigger_pistol","targetname");

        room_trigs[3] = getent("trigger_bounce","targetname");

        break;



        case "mp_dr_guest_list":

        room_trigs[0] = getent("oldroom","targetname");

        room_trigs[1] = getent("trig_sniper","targetname");

        room_trigs[2] = getent("trig_jump","targetname");

        room_trigs[3] = getent("trig_knife","targetname");

        break;



        case "mp_dr_boowie":

        room_trigs[0] = getent("rpg","targetname");

        room_trigs[1] = getent("sniper","targetname");

        room_trigs[2] = getent("old","targetname");

        room_trigs[3] = getent("knife","targetname");

        break;



        case "mp_dr_nitro":

        room_trigs[0] = getent("knife_trig","targetname");

        room_trigs[1] = getent("sniper_trig","targetname");

        room_trigs[2] = getent("jump_trig","targetname");

        break;



        case "mp_dr_darmuhv2":

        room_trigs[0] = getent("Knife","targetname");

        room_trigs[1] = getent("Jump","targetname");

        room_trigs[2] = getent("Classic","targetname");

        room_trigs[3] = getent("sniperoom","targetname");

        break;



        case "mp_dr_nighty":

        room_trigs[0] = getent("minigames","targetname");

        break;



        case "mp_deathrun_semtex":

        room_trigs[0] = getent("utcsodoor","targetname");

        break;



        case "mp_dr_nxs_jump":

        room_trigs[0] = getent("room","targetname");

        break;



        case "mp_dr_heaven":

        room_trigs[0] = getent("jumproom_ent","targetname");

        room_trigs[1] = getent("rpgroom_ent","targetname");

        room_trigs[2] = getent("kniferoom_ent","targetname");

        room_trigs[3] = getent("sniproom_ent","targetname");

        break;



        case "mp_dr_fireball_v2":

        room_trigs[0] = getent("minigames","targetname");

        break;



        case "mp_dr_gooby":

        room_trigs[0] = getent("weapon_trigger","targetname");

        room_trigs[1] = getent("sniper_trigger","targetname");

        room_trigs[2] = getent("jump_trigger","targetname");

        break;



        case "mp_dr_runner":

        room_trigs[0] = getent("trigger_old","targetname");

        room_trigs[1] = getent("trigger_sniper","targetname");

        room_trigs[2] = getent("trigger_bounce","targetname");

        break;



        case "mp_dr_anotherworld":

        room_trigs[0] = getent("minigames","targetname");

        break;



        case "mp_dr_urban":

        room_trigs[0] = getent("end_door","targetname");

        break;



        case "mp_deathrun_epicfail":

        room_trigs[0] = getent("enter_sniper_room","targetname");

        room_trigs[1] = getent("enter_bounce_room","targetname");

        room_trigs[2] = getent("enter_knife_room","targetname");
        
        level.playeroffset = (-250,0,20);

        break;



        case "mp_dr_vistic_castle":

        room_trigs[0] = getent("jumproom_ent","targetname");

        room_trigs[1] = getent("sniproom_ent","targetname");

        room_trigs[2] = getent("rpgroom_ent","targetname");

        room_trigs[3] = getent("sgunroom_ent","targetname");

        room_trigs[4] = getent("kniferoom_ent","targetname");

        room_trigs[5] = getent("oldroom_ent","targetname");

        break;



        

        case "mp_dr_imaginary":

        room_trigs[0] = getent("trigger_bounce","targetname");

        room_trigs[1] = getent("trigger_sniper","targetname");

        room_trigs[2] = getent("trigger_knife","targetname");

        room_trigs[3] = getent("trigger_old","targetname");

        break;
 

        case "mp_dr_up":

        room_trigs[0] = getent("knife_trigger","targetname");

        room_trigs[1] = getent("ak_trigger","targetname");

        room_trigs[2] = getent("trigger_sniper","targetname");

        break;



        case "mp_dr_petrichor":

        room_trigs[0] = getent("endtele","targetname");

        break;



        case "mp_dr_blue":

        room_trigs[0] = getent("sniper_trig","targetname");

        room_trigs[1] = getent("knife_trig","targetname");

        room_trigs[2] = getent("pistol_trig","targetname");

        room_trigs[3] = getent("spec_trig","targetname");

        room_trigs[4] = getent("slick_trig","targetname");

        room_trigs[5] = getent("maze_trig","targetname");

        break;



        case "mp_dr_digitalworld_v2":

        room_trigs[0] = getent("knife_room","targetname");

        room_trigs[1] = getent("jump_room","targetname");

        room_trigs[2] = getent("sniperoom","targetname");

        room_trigs[3] = getent("war_zone","targetname");

        room_trigs[4] = getent("old","targetname");

        break;



        case "mp_deathrun_factory":

        room_trigs[0] = getent("port_finish","targetname");

        break;



        case "mp_dr_nightlight":

        room_trigs[0] = getent("sniper_room","targetname");

        room_trigs[1] = getent("knife_room","targetname");

        break;



        case "mp_vc_nightsky":

        room_trigs[0] = getent("sniper_room","targetname");

        room_trigs[1] = getent("jump_room","targetname");

        room_trigs[2] = getent("knife_room","targetname");

        break;

        

        case "mp_deathrun_dungeon":
        room_trigs[0] = getent("dooropen","targetname");
        level.playeroffset = (0,-250,0);
        break;



        case "mp_dr_shipment":

        room_trigs[0] = getent("endroom","targetname");

        room_trigs[1] = getent("endroom2","targetname");

        room_trigs[2] = getent("endroom3","targetname");

        break;



        case "mp_vc_harrypotter":

        room_trigs[0] = getent("jumper_tp","targetname");

        room_trigs[1] = getent("knife_tp","targetname");

        room_trigs[2] = getent("sniper_tp","targetname");

        break;



        case "mp_dr_jump_hard":

        room_trigs[0] = getent("room_knife_trig","targetname");

        room_trigs[1] = getent("room_raygun_trig","targetname");

        room_trigs[2] = getent("room_ak74u_trig","targetname");

        room_trigs[3] = getent("room_snipe_trig","targetname");

        room_trigs[4] = getent("bounce_trig","targetname");

        break;



        case "mp_dr_jumpv2":
        room_trigs[0] = getent("trig_sniper","targetname");
        room_trigs[1] = getent("trig_jump","targetname");
        room_trigs[2] = getent("trig_knife","targetname");
        room_trigs[3] = getent("trig_porte1","targetname");
        break;

        
        case "mp_dr_blacknight":
        room_trigs[0] = getent("kniferoom","targetname");
        room_trigs[1] = getent("sniproom","targetname");
        room_trigs[2] = getent("jumproom","targetname");
        room_trigs[3] = getent("deagleroom","targetname");
        break;

        case "mp_deathrun_industry":
        room_trigs[0] = getent("sniper","targetname");
        room_trigs[1] = getent("jump","targetname");
        room_trigs[2] = getent("knife","targetname");
        room_trigs[3] = getent("old","targetname");
        break;

        
        case "mp_dr_lolz":
        room_trigs[0] = getent("minigames","targetname");
        break;

        case "mp_deathrun_boss":
        room_trigs[0] = getent("sniper","targetname");
        room_trigs[1] = getent("knife","targetname");
        room_trigs[2] = getent("old","targetname");
        break;

        case "mp_dr_samsara":
        room_trigs[0] = getent("end_door","targetname");
        break;

        case "mp_vc_sky_bounce":
        room_trigs[0] = getent("trig_endrooms","targetname");
        break;

        case "mp_vc_napoca":
        room_trigs[0] = getent("roomselection","targetname");
        break;
        
        case "mp_dr_pandemonium":
        room_trigs[0] = getent("pndm_moloch","targetname");
        room_trigs[1] = getent("pndm_leviathan","targetname");
        room_trigs[2] = getent("pndm_belial","targetname");
        room_trigs[3] = getent("pndm_lucifer","targetname");
	break;

        case "mp_dr_lifes":
        room_trigs[0] = getent("sniper","targetname");
        room_trigs[1] = getent("bounce","targetname");
        room_trigs[2] = getent("knife","targetname");
        room_trigs[3] = getent("old","targetname");
	break;

        case "mp_dr_radical":
        room_trigs[0] = getent("sniper_trig","targetname");
        room_trigs[1] = getent("hunter_trig","targetname");
        room_trigs[2] = getent("knife_trig","targetname");
	break;

        case "mp_deathrun_hop":
        room_trigs[0] = getent("end_tele","targetname");
        break;

        case "mp_vc_autumn_run":
        room_trigs[0] = getent("trig_snip","targetname");
        room_trigs[1] = getent("trig_wep","targetname");
        room_trigs[2] = getent("trig_knife","targetname");
        room_trigs[3] = getent("trig_deagle","targetname");
        room_trigs[4] = getent("trig_old","targetname");
	    break;

        case "mp_dr_corner":
        room_trigs[0] = getent("trig_endrooms","targetname");
        break;

        case "mp_dr_mountain_escape":
        room_trigs[0] = getent("bouncetrig","targetname");
        room_trigs[1] = getent("snipertrig","targetname");
        room_trigs[2] = getent("knifetrig","targetname");
        room_trigs[3] = getent("oldtrig","targetname");
        break;

        case "mp_deathrun_sync":
        room_trigs[0] = getent("sniper_trig","targetname");
        room_trigs[1] = getent("final_trigger_k","targetname");
        break;

        case "mp_dr_slayv2":
        room_trigs[0] = getent("room_snipe_trig","targetname");
        room_trigs[1] = getent("room_jump_trig","targetname");
        room_trigs[2] = getent("room_old_trig","targetname");
        break;

        case "mp_dr_2towers":
        room_trigs[0] = getent("sniproom_ent","targetname");
        room_trigs[1] = getent("kniferoom_ent","targetname");
        room_trigs[2] = getent("bounceroom_ent","targetname");
        break;

        case "mp_dr_harrypotter":
        room_trigs[0] = getent("sniproom_ent","targetname");
        room_trigs[1] = getent("kniferoom_ent","targetname");
        room_trigs[2] = getent("bounceroom_ent","targetname");
        break;

        case "mp_dr_sunset3":
        room_trigs[0] = getent("endroom_selection","targetname");
        break;

        case "mp_dr_detained":
        room_trigs[0] = getent("teleportsniperroom","targetname");
        room_trigs[1] = getent("teleportkniferoom","targetname");
        room_trigs[2] = getent("teleportjumproom","targetname");
        room_trigs[3] = getent("teleportbounceroom","targetname");
        break;

        case "mp_dr_biohazard":
        room_trigs[0] = getent("minigames","targetname");
        break;

        case "mp_deathrun_underworld":
        room_trigs[0] = getent("sniper_room","targetname");
        room_trigs[1] = getent("knife_room","targetname");
        room_trigs[2] = getent("bounce_room","targetname");
        room_trigs[3] = getent("deagle_room","targetname");
        room_trigs[4] = getent("old_way","targetname");
        break;

        case "mp_vc_winter_run":
            room_trigs[0] = getent("trig_sniper","targetname");
            room_trigs[1] = getent("trig_wep","targetname");
            room_trigs[2] = getent("trig_old","targetname");
            break;

        case "mp_dr_holyshiet":
            room_trigs[0] = getent("endport","targetname");
            break;

        case "mp_vc_sam":
            room_trigs[0] = getent("sniper","targetname");
            room_trigs[1] = getent("knife","targetname");
            room_trigs[2] = getent("bounce","targetname");
            break;

        case "mp_dr_alley":
            room_trigs[0] = getent("sniproom_ent","targetname");
            room_trigs[1] = getent("kniferoom_ent","targetname");
            room_trigs[2] = getent("rpgroom_ent","targetname");
            break;

        case "mp_dr_purple_world":
            room_trigs[0] = getent("trig_endrooms","targetname");
            break;

        case "mp_deathrun_islands":
            room_trigs[0] = getent("sniper","targetname");
            room_trigs[1] = getent("knife","targetname");
            room_trigs[2] = getent("bounce","targetname");
            room_trigs[3] = getent("oldtp","targetname");
            room_trigs[4] = getent("invisableman","targetname");
            break;

        case "mp_vc_bounceworld":
            room_trigs[0] = getent("water_trig","targetname");
            room_trigs[1] = getent("sniper_trig","targetname");
            room_trigs[2] = getent("bounce_trig","targetname");
            break;

        case "mp_dr_unreal":
            room_trigs[0] = getent("trig_pistol","targetname");
            room_trigs[1] = getent("trig_knife","targetname");
            room_trigs[2] = getent("trig_sniper","targetname");
            room_trigs[3] = getent("trig_old","targetname");
            room_trigs[4] = getent("trig_dunk","targetname");
            break;

        case "mp_dr_android":
            room_trigs[0] = getent("snipe_trig","targetname");
            room_trigs[1] = getent("jump_trig","targetname");
            room_trigs[2] = getent("knife_trig","targetname");
            break;

        case "mp_deathrun_fluxx":
            room_trigs[0] = getent("sniper","targetname");
            room_trigs[1] = getent("hitman","targetname");
            room_trigs[2] = getent("knife","targetname");
	        break;

        case "mp_dr_h2o":
            room_trigs[0] = getent("knife_trig","targetname");
            room_trigs[1] = getent("jump_trig","targetname");
            room_trigs[2] = getent("snip_trig","targetname");
            room_trigs[3] = getent("wep_trig","targetname");
            room_trigs[4] = getent("old_trigger","targetname");
            break;

        case "mp_deathrun_city":
            room_trigs[0] = getent("door_b_trig","targetname");
            break;

        case "mp_deathrun_dirt":
            room_trigs[0] = getent("door_c_trig","targetname");
            break;


        default: 
            room_trigs = undefined;
            break;
    }*/
}

