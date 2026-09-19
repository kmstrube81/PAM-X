/* This PAM public code will allow you to set up your match style in a config file
rather than having one hard-coded set of public settings.  In case the settings 
are unacceptable, the server will still run with a scorelimit of 7 (assigned below).  
Please note that it is advised to change the pam_mode to "pub" and do a 
map_restart INSIDE the config file as well.  Thus, to change from a league mode
to pub mode you would ONLY exec the config file.

/rcon exec public.cfg (for example)

You could even have multiple config files such as a rifles only config, a config 
that uses halftime, and a normal everyday config.  A sample config file is
included. Edit and rename the config files at will. 

worm                                                                          */

Rules()
{
	// Logo
	game["leaguestring"] = &"Pub Mode";

    //Shared Settings
    maps\mp\uox\_uox_vars::updateCvar("scr","warmup", "0");
    maps\mp\uox\_uox_vars::updateCvar("scr","halftime", "0");
    maps\mp\uox\_uox_vars::updateCvar("scr","overtime", "0");

    maps\mp\uox\_uox_vars::updateCvar("scr","timelimit", "20");
    maps\mp\uox\_uox_vars::updateCvar("scr","score_rounds", "0");
    maps\mp\uox\_uox_vars::updateCvar("scr","roundreset", "1");
    maps\mp\uox\_uox_vars::updateCvar("scr","countdraws", "1");
    maps\mp\uox\_uox_vars::updateCvar("scr","roundlimit", "1");
    
    maps\mp\uox\_uox_vars::updateCvar("sv","showScoreboard", true);
    maps\mp\uox\_uox_vars::updateCvar("sv","showScoreboardScorelimit", true);
    maps\mp\uox\_uox_vars::updateCvar("scr","teamscorepenalty", "0");
    maps\mp\uox\_uox_vars::updateCvar("scr","graceperiod", "5");

    switch(getCvar("g_gametype"))
    {
        case "dm":
            maps\mp\uox\_uox_vars::updateCvar("scr","scorelimit", "50", "dm");
            maps\mp\uox\_uox_vars::updateCvar("scr", "respawn_mode", "dm", "dm");
            maps\mp\uox\_uox_vars::updateCvar("scr", "spawn_type", "deathmatch", "dm");
            maps\mp\uox\_uox_vars::updateCvar("scr", "spawnpoints", "dm", "dm");
            maps\mp\uox\_uox_vars::updateCvar("scr", "reinforcements", "-1", "dm");
            break;
        case "tdm":
            maps\mp\uox\_uox_vars::updateCvar("scr","scorelimit", "150", "tdm");
            maps\mp\uox\_uox_vars::updateCvar("scr", "respawn_mode", "dm", "tdm");
            maps\mp\uox\_uox_vars::updateCvar("scr", "spawn_type", "near_team", "tdm");
            maps\mp\uox\_uox_vars::updateCvar("scr", "spawnpoints", "tdm", "tdm");
            maps\mp\uox\_uox_vars::updateCvar("scr", "reinforcements", "-1", "tdm");
            break;
        case "bel":
            maps\mp\uox\_uox_vars::updateCvar("scr","scorelimit", "50", "bel");
            maps\mp\uox\_uox_vars::updateCvar("scr", "respawn_mode", "bel", "bel");
            maps\mp\uox\_uox_vars::updateCvar("scr", "spawn_type", "middle", "bel");
            maps\mp\uox\_uox_vars::updateCvar("scr", "spawnpoints", "tdm", "bel");
            maps\mp\uox\_uox_vars::updateCvar("scr", "reinforcements", "-1", "bel");
            maps\mp\uox\_uox_vars::updateCvar("scr", "playerratio", "3", "bel");
            maps\mp\uox\_uox_vars::updateCvar("scr", "spawn_delay_time", "7", "bel");
            //BEL VARS
            maps\mp\uox\_uox_vars::updateCvar("scr", "alivepointtime", "10", "bel");
        	maps\mp\uox\_uox_vars::updateCvar("scr", "positiontime", "10", "bel");
        	maps\mp\uox\_uox_vars::updateCvar("scr", "showoncompass", true, "bel");
            maps\mp\uox\_uox_vars::updateCvar("scr", "survivalHealthBonus", "3", "bel");

            break;
        case "sd":
            maps\mp\uox\_uox_vars::updateCvar("scr","timelimit", "45", "sd");
            maps\mp\uox\_uox_vars::updateCvar("scr","scorelimit", "7", "sd");
            maps\mp\uox\_uox_vars::updateCvar("scr","score_rounds", "1", "sd");
            maps\mp\uox\_uox_vars::updateCvar("scr","roundlimit", "7", "sd");
            maps\mp\uox\_uox_vars::updateCvar("scr","roundlength", "4", "sd");
            maps\mp\uox\_uox_vars::updateCvar("scr", "respawn_mode", "obj", "sd");
            maps\mp\uox\_uox_vars::updateCvar("scr", "spawn_type", "random", "sd");
            maps\mp\uox\_uox_vars::updateCvar("scr", "spawnpoints", "sd", "sd");
            maps\mp\uox\_uox_vars::updateCvar("scr", "reinforcements", "1", "sd");
            //SD VARS
        	maps\mp\uox\_uox_vars::updateCvar("scr", "bombplanttime", "10", "sd");
        	maps\mp\uox\_uox_vars::updateCvar("scr", "bombdefusetime", "10", "sd");
        	maps\mp\uox\_uox_vars::updateCvar("scr", "bombtimer", "60", "sd");
        	maps\mp\uox\_uox_vars::updateCvar("scr", "bombplantmode", "0", "sd");
        	maps\mp\uox\_uox_vars::updateCvar("scr", "bombplantbonuspoints", "3", "sd");
            maps\mp\uox\_uox_vars::updateCvar("scr", "bombdefusebonuspoints", "3", "sd");
        	maps\mp\uox\_uox_vars::updateCvar("scr", "bombbonustime", "0", "sd");
        	maps\mp\uox\_uox_vars::updateCvar("scr", "bombbonuspoints", "3", "sd");
        	maps\mp\uox\_uox_vars::updateCvar("sv", "showbombtimer", true, "sd");
            break;
        case "re":
            maps\mp\uox\_uox_vars::updateCvar("scr","timelimit", "45", "re");
            maps\mp\uox\_uox_vars::updateCvar("scr","scorelimit", "7", "re");
            maps\mp\uox\_uox_vars::updateCvar("scr","roundlimit", "7", "re");
            maps\mp\uox\_uox_vars::updateCvar("scr","score_rounds", "1", "re");
            maps\mp\uox\_uox_vars::updateCvar("scr","roundlength", "4", "re");
            maps\mp\uox\_uox_vars::updateCvar("scr", "respawn_mode", "obj", "re");
            maps\mp\uox\_uox_vars::updateCvar("scr", "spawn_type", "random", "re");
            maps\mp\uox\_uox_vars::updateCvar("scr", "spawnpoints", "re", "re");
            maps\mp\uox\_uox_vars::updateCvar("scr", "reinforcements", "1", "re");
            //RE VARS
            maps\mp\uox\_uox_vars::updateCvar("scr", "showcarrier", false, "re");
        	maps\mp\uox\_uox_vars::updateCvar("scr", "objpickupbonuspoints", "3", "re");
        	maps\mp\uox\_uox_vars::updateCvar("scr", "objscorebonuspoints", "3", "re");
        	maps\mp\uox\_uox_vars::updateCvar("scr", "objcarrierkillbonuspoints", "0", "re");
            break;
        case "dom":
            maps\mp\uox\_uox_vars::updateCvar("scr","scorelimit", "3", "dom");
            maps\mp\uox\_uox_vars::updateCvar("scr","roundlimit", "0", "dom");
            maps\mp\uox\_uox_vars::updateCvar("scr","roundlength", "20", "dom");
            maps\mp\uox\_uox_vars::updateCvar("scr","score_rounds", "1", "dom");
            maps\mp\uox\_uox_vars::updateCvar("scr","timelimit", "0", "dom");
            maps\mp\uox\_uox_vars::updateCvar("scr", "respawn_mode", "wave", "dom");
            maps\mp\uox\_uox_vars::updateCvar("scr", "spawn_type", "near_team", "dom");
            maps\mp\uox\_uox_vars::updateCvar("scr", "spawnpoints", "uo", "dom");
            maps\mp\uox\_uox_vars::updateCvar("scr", "reinforcements", "-1", "dom");
            maps\mp\uox\_uox_vars::updateCvar("scr", "respawn_wave_time", "10", "dom");
            //DOM VARS
            maps\mp\uox\_uox_vars::updateCvar("scr", "domination_points", "0", "dom");
            maps\mp\uox\_uox_vars::updateCvar("scr", "domination_endround", true, "dom");
            maps\mp\uox\_uox_vars::updateCvar("scr", "capture_points", "1", "dom");
            maps\mp\uox\_uox_vars::updateCvar("scr", "hold_points", "0", "dom");
            maps\mp\uox\_uox_vars::updateCvar("scr", "hold_timer", "0", "dom");
            maps\mp\uox\_uox_vars::updateCvar("scr", "defensebonus", "3", "dom");
            maps\mp\uox\_uox_vars::updateCvar("scr", "capturebonus", "3", "dom");
            maps\mp\uox\_uox_vars::updateCvar("scr", "capturepenalty", "1", "dom");
            maps\mp\uox\_uox_vars::updateCvar("scr", "showicons", true, "dom");
            maps\mp\uox\_uox_vars::updateCvar("scr", "flagcapturetime", "10", "dom");
            maps\mp\uox\_uox_vars::updateCvar("scr", "customflags", "", "dom");
            break;
        case "ctf":
            maps\mp\uox\_uox_vars::updateCvar("scr","scorelimit", "7", "ctf");
            maps\mp\uox\_uox_vars::updateCvar("scr","roundlimit", "0", "ctf");
            maps\mp\uox\_uox_vars::updateCvar("scr","roundlength", "0", "ctf");
            maps\mp\uox\_uox_vars::updateCvar("scr", "respawn_mode", "spawndelay", "ctf");
            maps\mp\uox\_uox_vars::updateCvar("scr", "spawn_type", "near_team", "ctf");
            maps\mp\uox\_uox_vars::updateCvar("scr", "spawnpoints", "uo", "ctf");
            maps\mp\uox\_uox_vars::updateCvar("scr", "reinforcements", "-1", "ctf");
            maps\mp\uox\_uox_vars::updateCvar("scr", "spawn_delay_time", "7", "ctf");
            //CTF VARS
            maps\mp\uox\_uox_vars::updateCvar("scr", "showoncompass", "0", "ctf");
            maps\mp\uox\_uox_vars::updateCvar("scr", "positionTime", "6", "ctf");
            maps\mp\uox\_uox_vars::updateCvar("scr", "showicons", "small", "ctf");
            maps\mp\uox\_uox_vars::updateCvar("scr", "defensebonus", "3", "ctf");
            maps\mp\uox\_uox_vars::updateCvar("scr", "assistbonus", "3", "ctf");
            maps\mp\uox\_uox_vars::updateCvar("scr", "capturebonus", "5", "ctf");
            maps\mp\uox\_uox_vars::updateCvar("scr", "pickupbonus", "0", "ctf");
            maps\mp\uox\_uox_vars::updateCvar("scr", "returnbonus", "0", "ctf");
            maps\mp\uox\_uox_vars::updateCvar("scr", "flagtimeout", "20", "ctf" );
            break;
        case "hq":
            maps\mp\uox\_uox_vars::updateCvar("scr","scorelimit", "450", "hq");
            maps\mp\uox\_uox_vars::updateCvar("scr", "respawn_mode", "hq", "hq");
            maps\mp\uox\_uox_vars::updateCvar("scr", "spawn_type", "hq", "hq");
            maps\mp\uox\_uox_vars::updateCvar("scr", "spawnpoints", "tdm", "hq");
            maps\mp\uox\_uox_vars::updateCvar("scr", "reinforcements", "-1", "hq");
            maps\mp\uox\_uox_vars::updateCvar("scr", "wavetimer", "45", "hq");
            //HQ VARS
            maps\mp\uox\_uox_vars::updateCvar("scr", "radiocapturetime", "10", "hq");
        	maps\mp\uox\_uox_vars::updateCvar("scr", "radiodestroytime", "10", "hq");
            maps\mp\uox\_uox_vars::updateCvar("scr", "radiomaxhold", "6", "hq");
        	maps\mp\uox\_uox_vars::updateCvar("scr", "radiocapturebonuspoints", "3", "hq");
        	maps\mp\uox\_uox_vars::updateCvar("scr", "radiodestroybonuspoints", "3", "hq");
            maps\mp\uox\_uox_vars::updateCvar("scr", "radioholdbonuspoints", "0", "hq");
            break;
        case "bas":
            maps\mp\uox\_uox_vars::updateCvar("scr","timelimit", "0", "bas");
            maps\mp\uox\_uox_vars::updateCvar("scr","scorelimit", "3", "bas");
            maps\mp\uox\_uox_vars::updateCvar("scr","roundlimit", "0", "bas");
            maps\mp\uox\_uox_vars::updateCvar("scr","roundlength", "30", "bas");
            maps\mp\uox\_uox_vars::updateCvar("scr", "showicons", true, "bas");
            maps\mp\uox\_uox_vars::updateCvar("scr", "respawn_mode", "wave", "bas");
            maps\mp\uox\_uox_vars::updateCvar("scr", "spawn_type", "near_team", "bas");
            maps\mp\uox\_uox_vars::updateCvar("scr", "spawnpoints", "bas", "bas");
            maps\mp\uox\_uox_vars::updateCvar("scr", "reinforcements", "-1", "bas");
            maps\mp\uox\_uox_vars::updateCvar("scr", "respawn_wave_time", "10", "bas");
            maps\mp\uox\_uox_vars::updateCvar("scr", "basehealth", "24500", "bas");
            maps\mp\uox\_uox_vars::updateCvar("scr", "basedefensebonus", "1", "bas");
            maps\mp\uox\_uox_vars::updateCvar("scr", "bombplanttime", "10", "bas");
        	maps\mp\uox\_uox_vars::updateCvar("scr", "bombdefusetime", "10", "bas");
        	maps\mp\uox\_uox_vars::updateCvar("scr", "bombtimer", "60", "bas");
            maps\mp\uox\_uox_vars::updateCvar("scr", "bombplantbonuspoints", "2", "bas");
            maps\mp\uox\_uox_vars::updateCvar("scr", "bombdefusebonuspoints", "4", "bas");
        	maps\mp\uox\_uox_vars::updateCvar("scr", "bombbonustime", "0", "bas");
        	maps\mp\uox\_uox_vars::updateCvar("scr", "bombbonuspoints", "3", "bas");
            break;
    }

    // Team Icons 
    maps\mp\uox\_uox_vars::updateCvar("scr", "drawfriend", "1");
	// Friendly Fire 
	maps\mp\uox\_uox_vars::updateCvar("scr", "friendlyfire", "0");
	// Kill Cam & Spectate
    maps\mp\uox\_uox_vars::updateCvar("scr", "killcam", "0");
    maps\mp\uox\_uox_vars::updateCvar("scr", "final_killcam", "1");
    // Auto Team Balance
    maps\mp\uox\_uox_vars::updateCvar("scr", "teambalance", "1");
    //spectate Settings
	maps\mp\uox\_uox_vars::updateCvar("scr","freelook" , "0");
	maps\mp\uox\_uox_vars::updateCvar("scr","spectateenemy" , "0");
	maps\mp\uox\_uox_vars::updateCvar("g","deadChat" , "1");

    //SERVER VARS
    // Shellshock 
	maps\mp\uox\_uox_vars::updateCvar("scr","shellshock" , "1");

	// Health Drop 
	maps\mp\uox\_uox_vars::updateCvar("scr","drophealth" , "1");

	// Battleranks 
	maps\mp\uox\_uox_vars::updateCvar("scr","battlerank" , "1");
	maps\mp\uox\_uox_vars::updateCvar("scr","forcerank", "0");
	maps\mp\uox\_uox_vars::updateCvar("scr","rank_ppr" , "10"); //Sets the Points Per Rank

    // *****************************************************
	// ************ Vehicle Settings ***********************
	// *****************************************************
	
	// Vehicle Explosion Timer
	setcvar("g_vehicleBurnTime" , "10"); // Time in seconds a vehicle burns before blowing up


	// Jeeps
	setcvar("scr_allow_jeeps" , "0");
	setcvar("scr_allow_jeep_gunner" , "1");

	setcvar("scr_jeep_spawn_limit", "0"); // 0 is disabled. Each vehicle will only spawn this number of times
	setcvar("scr_vehicle_limit_jeep", "0"); // Limits the number of jeeps available on the map at any given time (0 = disabled)

	setcvar("scr_allow_horch" , "0");
	setcvar("scr_allow_gaz67b" , "0"); 
	setcvar("scr_allow_willyjeep" , "0");

	setcvar("scr_jeep_respawn_wait" , "5");


	//Tanks
	setcvar("scr_allow_tanks" , "0");

	setcvar("scr_tank_spawn_limit", "0"); // 0 is disabled. Each vehicle will only spawn this number of times
	setcvar("scr_vehicle_limit_medium_tank", "0"); // Limits the number of medium tanks available on the map at any given time (0 = disabled)
	setcvar("scr_vehicle_limit_heavy_tank", "0"); // Limits the number of heavy tanks available on the map at any given time (0 = disabled)

	setcvar("scr_allow_su152" , "0");
	setcvar("scr_allow_elefant" , "0");
	setcvar("scr_allow_panzeriv" , "0");
	setcvar("scr_allow_t34" , "0");
	setcvar("scr_allow_sherman" , "0");

	setcvar("scr_tank_respawn_wait" , "300");
	
	// Vehicle Self Destruct Times
	setCvar("scr_selfDestructTankTime", "180");
	setCvar("scr_selfDestructJeepTime", "90");


	// *****************************************************
	// ************ Weapon Settings ************************
	// *****************************************************

	// Map-Placed Weapon Respawns
	setcvar("g_weaponrespawn", "5"); // Weapons on the ground in maps will respawn after this many seconds

	// Force Bolt-Action Rifles Only
	//setcvar("scr_force_bolt_rifles" , "0"); -- Not implemented in CODUOX

	// Rifles 
	setcvar("scr_allow_enfield" , "1");
	setcvar("scr_allow_kar98k" , "1");
	setcvar("scr_allow_m1garand" , "1");
	setcvar("scr_allow_nagant" , "1");
	setcvar("scr_allow_gewehr43" , "1");


	//Snipers
	//setcvar("sv_noDropSniper", "1");	// 1=can't drop sniper rifle, 0=Sniper Rifle Drops -- Not implemented in CODUOX
	//setcvar("sv_alliedSniperLimit", "1");	// allied sniper limit
	//setcvar("sv_axisSniperLimit", "1");	// axis sniper limit

	setcvar("scr_allow_kar98ksniper" , "1");
	setcvar("scr_allow_nagantsniper" , "1");
	setcvar("scr_allow_springfield" , "1");
	setcvar("scr_allow_svt40" , "1");
	setcvar("scr_allow_fg42" , "0");

	// MGs
	//setcvar("sv_alliedMGLimit", "99");	// allied mg limit -- Not implemented in CODUOX
	//setcvar("sv_axisMGLimit", "99");	// axis mg limit -- Not implemented in CODUOX

	setcvar("scr_allow_bar" , "1");
	setcvar("scr_allow_bren" , "1");
	setcvar("scr_allow_mp44" , "1");
	setcvar("scr_allow_ppsh" , "1");

	//SMGs
	//setcvar("sv_alliedSMGLimit", "99");	// allied smg limit -- Not implemented in CODUOX
	//setcvar("sv_axisSMGLimit", "99");	// axis smg limit -- Not implemented in CODUOX

	setcvar("scr_allow_sten" , "1");
	setcvar("scr_allow_mp40" , "1");
	setcvar("scr_allow_thompson" , "1");
	setcvar("scr_allow_m1carbine" , "1");

	// Rockets
	setcvar("scr_allow_panzerfaust" , "0");
	setcvar("scr_allow_panzerschreck", "0");
	setcvar("scr_allow_bazooka" , "0");

	// Deployable Machine Guns
	//setcvar("sv_noDropDMG", "0");	// 1=can't drop Deployable MG, 0=DMG Drops -- Not implemented in CODUOX
	//setcvar("sv_alliedDMGLimit", "99"); // allied deployable mg limit
	//setcvar("sv_axisDMGLimit", "99"); // axis deployable mg limit

	setcvar("scr_allow_mg34" , "1");
	setcvar("scr_allow_dp28" , "1");
	setcvar("scr_allow_mg30cal" , "1");

	// Pistols
	setcvar("scr_allow_pistols" , "1");

	// Nades and Satchels
	setcvar("scr_allow_smoke" , "1");
	setcvar("scr_allow_grenades" , "1");
	setcvar("scr_allow_satchel" , "1");

	// Artillery Settings
	setcvar("scr_allow_artillery" , "1");
	setcvar("scr_artillery_first_interval" , "45"); // How long after spawn the Artillery Strike becomes available?
	setcvar("scr_artillery_interval" , "120"); // How long between artillery stikes
	setcvar("scr_artillery_interval_range" , "15"); // Random number of seconds added to scr_artillery_interval

	// Flamethrower
	setcvar("scr_allow_flamethrower" , "1");

	// Flak Canons
	setcvar("scr_allow_flak88" , "1");

	// MG42 (Stationary MG positions)
	setCvar("scr_allow_mg42", "1");


	// *****************************************************
	// ****************** Timeouts *************************
	// *****************************************************
	setcvar("g_timeoutsAllowed", "0"); //The number of timeouts allowed per side. 
	setcvar("g_timeoutLength", "0"); //The length of each timeout. 
	setcvar("g_timeoutRecovery", "0"); //The length of the preparation period which occurs after a time-in is called, or after a timeout expires.  This recovery period is used to alert all players that play is about to begin. 
	setcvar("g_timeoutBank", "0"); //The total amount of time a team can spend in timeout.


	// *****************************************************
	// *********** PAM UO Auto Demo/Screenshots ************
	// *****************************************************
	setcvar("g_autoscreenshot" , "0");

	// *****************************************************
	// *********** PAM UO Auto Console Lock ****************
	// *****************************************************
	setcvar("sv_consolelock" , "0");



	// ************************************************
	// *********** CVARs NOT Liekly to change *********
	// ************************************************

	//SV Pure
	setcvar("sv_pure", "1");

	// Allow Voting 
	setcvar("scr_allow_vote" , "1");
	setcvar("g_allowvote" , "1");
	setcvar("g_allowvotetempbanuser" , "0");
	setcvar("g_allowvotetempbanclient" , "0");
	setcvar("g_allowvotekick" , "0");
	setcvar("g_allowvoteclientkick" , "0");
	setcvar("g_allowvotegametype" , "0");
	setcvar("g_allowvotetypemap" , "1");
	setcvar("g_allowvotemap" , "0");
	setcvar("g_allowvotemaprotate" , "0");
	setcvar("g_allowvotemaprestart" , "0");

	//Misc
	setcvar("sv_reconnectlimit", "5");
	setcvar("sv_minPing", "0");			
	setcvar("sv_maxPing", "0");
	setcvar("g_inactivity", "0");

	/* Do NOT Touch These */
	game["mode"] = "pub";
}
