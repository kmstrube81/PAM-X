Rules()
{
    // Hostname and MOTD 
	setcvar("sv_hostname" , "MGL League Match | www.multigamingleague.com"); 
	setcvar("scr_motd" , "^9Welcome to the ^1MGL^9, enjoy the match. ^1www.multigamingleague.com"); 

	//Logo
	game["leaguestring"] = &"MultiGamingLeague Match Mode";  //NOTE!!! NEVER REMOVE THE & SYMBOL OR SERVER WILL CRASH

	/* Match Setup Options */
    maps\mp\uox\_uox_vars::updateCvar("scr","warmup", "2", "sd");
    maps\mp\uox\_uox_vars::updateCvar("scr","halftime", "1", "sd");
    maps\mp\uox\_uox_vars::updateCvar("scr","overtime", "0", "sd");

	// SD Settings 
    maps\mp\uox\_uox_vars::updateCvar("scr","timelimit", "0", "sd");
    aps\mp\uox\_uox_vars::updateCvar("scr","ot_roundlimit", "0", "sd");
    maps\mp\uox\_uox_vars::updateCvar("scr","roundlimit", "0", "sd");
    maps\mp\uox\_uox_vars::updateCvar("scr","score_rounds", "0", "sd");
    maps\mp\uox\_uox_vars::updateCvar("scr","scorelimit", "11", "sd");
    maps\mp\uox\_uox_vars::updateCvar("scr","ot_scorelimit", "0", "sd");
    maps\mp\uox\_uox_vars::updateCvar("scr","roundlength", "4", "sd");
    maps\mp\uox\_uox_vars::updateCvar("scr","ot_roundlength", "4", "sd");
    maps\mp\uox\_uox_vars::updateCvar("scr","roundreset", "0", "sd");
    maps\mp\uox\_uox_vars::updateCvar("scr","countdraws", "0", "sd");

    maps\mp\uox\_uox_vars::updateCvar("scr", "respawn_mode", "obj", "sd");
    maps\mp\uox\_uox_vars::updateCvar("scr", "spawn_type", "random", "sd");
    maps\mp\uox\_uox_vars::updateCvar("scr", "spawnpoints", "sd", "sd");
    maps\mp\uox\_uox_vars::updateCvar("scr", "reinforcements", "1", "sd");
	
	maps\mp\uox\_uox_vars::updateCvar("sv","showEndRoundScoreboard", true, "sd");
    maps\mp\uox\_uox_vars::updateCvar("sv","showScoreboard", false, "sd");
    maps\mp\uox\_uox_vars::updateCvar("sv","showScoreboardScorelimit", false, "sd");
    maps\mp\uox\_uox_vars::updateCvar("sv","showPlayersLeft", false, "sd");
    maps\mp\uox\_uox_vars::updateCvar("scr","teamscorepenalty", "1", "sd");
    maps\mp\uox\_uox_vars::updateCvar("scr","graceperiod", "15", "sd");

	//Auto-Screenies
	setcvar("g_autoscreenshot" , "1");

	//Disable Client Console During Matches
	setcvar("sv_consolelock" , "0");

	//SV Pure
	setcvar("sv_pure", "1");
	
	/* PAM cvars */
	// Bomb Settings
	maps\mp\uox\_uox_vars::updateCvar("scr", "bombplanttime", "10", "sd");
    maps\mp\uox\_uox_vars::updateCvar("scr", "bombdefusetime", "10", "sd");
    maps\mp\uox\_uox_vars::updateCvar("scr", "bombtimer", "60", "sd");
    maps\mp\uox\_uox_vars::updateCvar("scr", "bombplantmode", "0", "sd");
    maps\mp\uox\_uox_vars::updateCvar("scr", "bombplantbonuspoints", "3", "sd");
    maps\mp\uox\_uox_vars::updateCvar("scr", "bombdefusebonuspoints", "3", "sd");
    maps\mp\uox\_uox_vars::updateCvar("scr", "bombbonustime", "0", "sd");
    maps\mp\uox\_uox_vars::updateCvar("scr", "bombbonuspoints", "3", "sd");
    maps\mp\uox\_uox_vars::updateCvar("sv", "showbombtimer", true, "sd");

	// Timers
	setcvar("scr_artillery_first_interval" , "45"); // How long after spawn the Artillery Strike becomes available?
	setcvar("scr_artillery_interval" , "120"); // How long between artillery stikes
	setcvar("scr_artillery_interval_range" , "15"); // Random number of seconds added to scr_artillery_interval
	setcvar("g_roundwarmuptime", "5");	// round warmup time

	//Timeouts
	setcvar("g_timeoutsAllowed", "0"); //The number of timeouts allowed per side. 
	setcvar("g_timeoutLength", "0"); //The length of each timeout. 
	setcvar("g_timeoutRecovery", "0"); //The length of the preparation period which occurs after a time-in is called, or after a timeout expires.  This recovery period is used to alert all players that play is about to begin. 
	setcvar("g_timeoutBank", "0"); //The total amount of time a team can spend in timeout.

	// Score Settings
	setcvar("scr_sd_clearscoreeachhalf", "1");	// Re-set Players Score at halftime? 1=Yes 0=No  Used to reset battlerank if it is on.

	// Weapon Settings
	/* setcvar("sv_noDropSniper", "0");	// 1=can't drop sniper rifle, 0=Sniper Rifle Drops
	setcvar("sv_noDropDMG", "0");	// 1=can't drop Deployable MG, 0=DMG Drops
	setcvar("sv_alliedSniperLimit", "2");	// allied sniper limit
	setcvar("sv_alliedSMGLimit", "99");	// allied smg limit
	setcvar("sv_alliedMGLimit", "99");	// allied mg limit
	setcvar("sv_alliedDMGLimit", "2"); // allied deployable mg limit
	setcvar("sv_axisSniperLimit", "2");	// axis sniper limit
	setcvar("sv_axisSMGLimit", "99");	// axis smg limit
	setcvar("sv_axisMGLimit", "99");	// axis mg limit
	setcvar("sv_axisDMGLimit", "2"); // axis deployable mg limit
    */
	setcvar("sv_warmupmines", "1"); //Leave this on for now. Mines need to be re-worked.

	// Allow Voting 
	setcvar("scr_allow_vote" , "0");
	setcvar("g_allowvote" , "0");
	setcvar("g_allowvotetempbanuser" , "0");
	setcvar("g_allowvotetempbanclient" , "0");
	setcvar("g_allowvotekick" , "0");
	setcvar("g_allowvoteclientkick" , "0");
	setcvar("g_allowvotegametype" , "0");
	setcvar("g_allowvotetypemap" , "0");
	setcvar("g_allowvotemap" , "0");
	setcvar("g_allowvotemaprotate" , "0");
	setcvar("g_allowvotemaprestart" , "0");

	// Team Icons 
    maps\mp\uox\_uox_vars::updateCvar("scr", "drawfriend", "0", "sd");
	// Friendly Fire 
	maps\mp\uox\_uox_vars::updateCvar("scr", "friendlyfire", "1", "sd");
	// Kill Cam & Spectate
    maps\mp\uox\_uox_vars::updateCvar("scr", "killcam", "0", "sd");
    maps\mp\uox\_uox_vars::updateCvar("scr", "final_killcam", "0", "sd");

    // Auto Team Balance
    maps\mp\uox\_uox_vars::updateCvar("scr", "teambalance", "0", "sd");
    //spectate Settings
	maps\mp\uox\_uox_vars::updateCvar("scr","freelook" , "0");
	maps\mp\uox\_uox_vars::updateCvar("scr","spectateenemy" , "0");
	maps\mp\uox\_uox_vars::updateCvar("g","deadChat" , "0");

    //SERVER VARS
    // Shellshock 
	maps\mp\uox\_uox_vars::updateCvar("scr","shellshock" , "1");

	// Health Drop 
	maps\mp\uox\_uox_vars::updateCvar("scr","drophealth" , "0", "sd");

	// Battleranks 
	maps\mp\uox\_uox_vars::updateCvar("scr","battlerank" , "1");
	maps\mp\uox\_uox_vars::updateCvar("scr","forcerank", "0");
	maps\mp\uox\_uox_vars::updateCvar("scr","rank_ppr" , "10"); //Sets the Points Per Rank

	// Weapon Respawns
	setcvar("g_weaponrespawn", "5");

	// Force Bolt-Action Rifles Only
	//setcvar("scr_force_bolt_rifles" , "0");

	// Weapons 
	setcvar("scr_allow_bar" , "1");
	setcvar("scr_allow_bren" , "1");
	setcvar("scr_allow_enfield" , "1");
	setcvar("scr_allow_kar98k" , "1");
	setcvar("scr_allow_kar98ksniper" , "1");
	setcvar("scr_allow_m1carbine" , "1");
	setcvar("scr_allow_m1garand" , "1");
	setcvar("scr_allow_mp40" , "1");
	setcvar("scr_allow_mp44" , "1");
	setcvar("scr_allow_nagant" , "1");
	setcvar("scr_allow_nagantsniper" , "1");
	setcvar("scr_allow_panzerfaust" , "1");
	setcvar("scr_allow_ppsh" , "1");
	setcvar("scr_allow_springfield" , "1");
	setcvar("scr_allow_sten" , "1");
	setcvar("scr_allow_thompson" , "1");
	setcvar("scr_allow_fg42" , "0");
	setcvar("scr_allow_pistols" , "1");
	setcvar("scr_allow_satchel" , "1");
	setcvar("scr_allow_smoke" , "1");
	setcvar("scr_allow_grenades" , "1");
	setcvar("scr_allow_flamethrower" , "1");
	setcvar("scr_allow_artillery" , "1");
	setcvar("scr_allow_bazooka" , "1");
	setcvar("scr_allow_mg34" , "1");
	setcvar("scr_allow_dp28" , "1");
	setcvar("scr_allow_mg30cal" , "1");
	setcvar("scr_allow_gewehr43" , "1");
	setcvar("scr_allow_svt40" , "1");
	setcvar("scr_allow_panzerschreck", "1");

	// Vehicles 
	setcvar("scr_allow_jeeps" , "1");
	setcvar("scr_allow_jeep_gunner" , "1");
	setcvar("scr_allow_tanks" , "1");

	setcvar("scr_allow_flak88" , "1");
	setcvar("scr_allow_su152" , "1");
	setcvar("scr_allow_elefant" , "1");
	setcvar("scr_allow_panzeriv" , "1");
	setcvar("scr_allow_t34" , "1");
	setcvar("scr_allow_sherman" , "1");
	setcvar("scr_allow_horch" , "1");
	setcvar("scr_allow_gaz67b" , "1");
	setcvar("scr_allow_willyjeep" , "1");

	//Vehicle Limits & Timers
	setcvar("scr_jeep_spawn_limit", "0"); // 0 is disabled
	setcvar("scr_tank_spawn_limit", "0"); // 0 is disabled
	setcvar("scr_vehicle_limit_jeep", "50");
	setcvar("scr_vehicle_limit_medium_tank", "50");
	setcvar("scr_vehicle_limit_heavy_tank", "50");
	setcvar("scr_jeep_respawn_wait" , "5");
	setcvar("scr_tank_respawn_wait" , "5");

	// Vehicle Self Destruct Times
	setCvar("scr_selfDestructTankTime", "180");
	setCvar("scr_selfDestructJeepTime", "90");

	setcvar("g_vehicleBurnTime" , "10"); // Time in seconds a vehicle burns before blowing up

	// MG42 (Stationary MG positions)
	setCvar("scr_allow_mg42", "1");
	
	//Misc
	setcvar("sv_reconnectlimit", "5");
	setcvar("sv_minPing", "0");			
	setcvar("sv_maxPing", "0");
	setcvar("g_inactivity", "0");

	/* Do NOT Touch These */
	game["mode"] = "match";
}