Rules()
{
    // Hostname and MOTD 
	setcvar("sv_hostname" , "CAL Match in Progress"); 
	setcvar("scr_motd" , "CAL Match - www.caleague.com"); 

	// Logo
	game["leaguestring"] = &"CAL Match Mode";  //NOTE!!! NEVER REMOVE THE & SYMBOL OR SERVER WILL CRASH

	/* Match Setup Options */
	maps\mp\uox\_uox_vars::updateCvar("scr","score_rounds", "0", "ctf");
    maps\mp\uox\_uox_vars::updateCvar("scr","warmup", "2", "ctf");
    maps\mp\uox\_uox_vars::updateCvar("scr","halftime", "1", "ctf");
    maps\mp\uox\_uox_vars::updateCvar("scr","overtime", "1", "ctf");

	// *****************************************************
	// *********** Stock Match Config Cvars ****************
	// *****************************************************
	
	// CTF Settings 
    // Standard CTF Settings 
    maps\mp\uox\_uox_vars::updateCvar("scr","scorelimit", "0", "ctf");
    maps\mp\uox\_uox_vars::updateCvar("scr","ot_scorelimit", maps\mp\uox\_uox::getTeam1Score() + 1, "ctf");
    maps\mp\uox\_uox_vars::updateCvar("scr","timelimit", "0", "ctf");
    maps\mp\uox\_uox_vars::updateCvar("scr","roundlimit", "2", "ctf");
    maps\mp\uox\_uox_vars::updateCvar("scr","roundlength", "20", "ctf");
    maps\mp\uox\_uox_vars::updateCvar("scr","ot_roundlimit", "2", "ctf");
    maps\mp\uox\_uox_vars::updateCvar("scr","ot_roundlength", "10", "ctf");
    maps\mp\uox\_uox_vars::updateCvar("sv","endRoundScoreboardTime","10", "ctf");
    maps\mp\uox\_uox_vars::updateCvar("scr","roundreset", "0", "ctf");
    maps\mp\uox\_uox_vars::updateCvar("scr", "showoncompass", "0", "ctf");
    maps\mp\uox\_uox_vars::updateCvar("scr", "positionTime", "6", "ctf");

    maps\mp\uox\_uox_vars::updateCvar("scr", "respawn_mode", "spawndelay", "ctf");
    maps\mp\uox\_uox_vars::updateCvar("scr", "spawn_type", "near_team", "ctf");
    maps\mp\uox\_uox_vars::updateCvar("scr", "spawnpoints", "uo", "ctf");
    maps\mp\uox\_uox_vars::updateCvar("scr", "reinforcements", "-1", "ctf");
    maps\mp\uox\_uox_vars::updateCvar("scr", "spawn_delay_time", "15", "ctf");
    //CTF VARS 
    maps\mp\uox\_uox_vars::updateCvar("scr", "showicons", "big", "ctf");
    maps\mp\uox\_uox_vars::updateCvar("scr", "defensebonus", "0", "ctf");
    maps\mp\uox\_uox_vars::updateCvar("scr", "assistbonus", "0", "ctf");
    maps\mp\uox\_uox_vars::updateCvar("scr", "capturebonus", "0", "ctf");
    maps\mp\uox\_uox_vars::updateCvar("scr", "pickupbonus", "0", "ctf");
    maps\mp\uox\_uox_vars::updateCvar("scr", "returnbonus", "0", "ctf");
    maps\mp\uox\_uox_vars::updateCvar("scr", "flagtimeout", "20", "ctf" );

    maps\mp\uox\_uox_vars::updateCvar("sv","showEndRoundScoreboard", true, "ctf");
    maps\mp\uox\_uox_vars::updateCvar("sv","showScoreboard", true, "ctf");
    maps\mp\uox\_uox_vars::updateCvar("sv","showScoreboardScorelimit", true, "ctf");
    maps\mp\uox\_uox_vars::updateCvar("sv","showPlayersLeft", true, "ctf");

	// Team Icons 
    maps\mp\uox\_uox_vars::updateCvar("scr", "drawfriend", "1");
	// Friendly Fire 
	maps\mp\uox\_uox_vars::updateCvar("scr", "friendlyfire", "1");
	// Kill Cam & Spectate
    maps\mp\uox\_uox_vars::updateCvar("scr", "killcam", "0");
    maps\mp\uox\_uox_vars::updateCvar("scr", "final_killcam", "0");
    // Auto Team Balance
    maps\mp\uox\_uox_vars::updateCvar("scr", "teambalance", "0");
    //spectate Settings
	maps\mp\uox\_uox_vars::updateCvar("scr","freelook" , "0");
	maps\mp\uox\_uox_vars::updateCvar("scr","spectateenemy" , "0");
	maps\mp\uox\_uox_vars::updateCvar("g","deadChat" , "0");

    //SERVER VARS
    // Shellshock 
	maps\mp\uox\_uox_vars::updateCvar("scr","shellshock" , "1");

	// Health Drop 
	maps\mp\uox\_uox_vars::updateCvar("scr","drophealth" , "0");

	// Battleranks 
	maps\mp\uox\_uox_vars::updateCvar("scr","battlerank" , "0");
	maps\mp\uox\_uox_vars::updateCvar("scr","forcerank", "0");
	maps\mp\uox\_uox_vars::updateCvar("scr","rank_ppr" , "10"); //Sets the Points Per Rank

	// *****************************************************
	// ********** PAM UO Match Config Cvars ****************
	// *****************************************************
	// OT settings
	setCvar("scr_randomsides", "0");	// Choose Random Sides for us if we need OT - Not implemented in SD yet

	// Death Penalty
	setcvar("scr_ctf_respawnpenalty", "10"); // Respawn Timer Penalty for a player that was TKed or Suicided. Does not work in 'pub' mode

	// Round Draw Setting
	maps\mp\uox\_uox_vars::updateCvar("scr","countdraws", "1", "ctf");

	// Timers
	setcvar("scr_ctf_strattime", "5");	// round warmup time

	// Score Settings
	setcvar("scr_ctf_clearscoreeachhalf", "1");	// Re-set Players Score / Battlerank at halftime? 1=Yes 0=No

	// Flag Return Options
	setcvar("scr_ctf_allowflagreturn", "1");	// Determines whether a team can return a flag to its base by touching it. When this is on AND scr_ctf_flagresettime is set to -1 (NEVER), your flag does NOT need to be at your base to capture the enemies flag.

	// Warm-up Mines
	setcvar("sv_warmupmines", "1"); //Leave this on for now. Mines need to be re-worked.


	// *****************************************************
	// ************ Vehicle Settings ***********************
	// *****************************************************
	
	// Vehicle Explosion Timer
	setcvar("g_vehicleBurnTime" , "10"); // Time in seconds a vehicle burns before blowing up


	// Jeeps
	setcvar("scr_allow_jeeps" , "1");
	setcvar("scr_allow_jeep_gunner" , "1");

	setcvar("scr_jeep_spawn_limit", "0"); // 0 is disabled. Each vehicle will only spawn this number of times
	setcvar("scr_vehicle_limit_jeep", "0"); // Limits the number of jeeps available on the map at any given time (0 = disabled)

	setcvar("scr_allow_horch" , "1");
	setcvar("scr_allow_gaz67b" , "1"); 
	setcvar("scr_allow_willyjeep" , "1");

	setcvar("scr_jeep_respawn_wait" , "5");
	setCvar("scr_selfDestructJeepTime", "90");


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
	setCvar("scr_selfDestructTankTime", "180");



	// *****************************************************
	// ************ Weapon Settings ************************
	// *****************************************************

	// Map-Placed Weapon Respawns
	setcvar("g_weaponrespawn", "5"); // Weapons on the ground in maps will respawn after this many seconds

	// Force Bolt-Action Rifles Only
	//setcvar("scr_force_bolt_rifles" , "0");

	// Rifles 
	setcvar("scr_allow_enfield" , "1");
	setcvar("scr_allow_kar98k" , "1");
	setcvar("scr_allow_m1garand" , "1");
	setcvar("scr_allow_nagant" , "1");
	setcvar("scr_allow_gewehr43" , "1");


	//Snipers
	//setcvar("sv_noDropSniper", "0");	// 1=can't drop sniper rifle, 0=Sniper Rifle Drops
	//setcvar("sv_alliedSniperLimit", "99");	// allied sniper limit
	//setcvar("sv_axisSniperLimit", "99");	// axis sniper limit

	setcvar("scr_allow_kar98ksniper" , "1");
	setcvar("scr_allow_nagantsniper" , "1");
	setcvar("scr_allow_springfield" , "1");
	setcvar("scr_allow_svt40" , "1");
	setcvar("scr_allow_fg42" , "0");

	// MGs
	//setcvar("sv_alliedMGLimit", "99");	// allied mg limit
	//setcvar("sv_axisMGLimit", "99");	// axis mg limit

	setcvar("scr_allow_bar" , "1");
	setcvar("scr_allow_bren" , "1");
	setcvar("scr_allow_mp44" , "1");
	setcvar("scr_allow_ppsh" , "1");

	//SMGs
	//setcvar("sv_alliedSMGLimit", "99");	// allied smg limit
	//setcvar("sv_axisSMGLimit", "99");	// axis smg limit

	setcvar("scr_allow_sten" , "1");
	setcvar("scr_allow_mp40" , "1");
	setcvar("scr_allow_thompson" , "1");
	setcvar("scr_allow_m1carbine" , "1");

	// Rockets
	setcvar("scr_allow_panzerfaust" , "1");
	setcvar("scr_allow_panzerschreck", "1");
	setcvar("scr_allow_bazooka" , "1");

	// Deployable Machine Guns
	//setcvar("sv_noDropDMG", "1");	// 1=can't drop Deployable MG, 0=DMG Drops
	//setcvar("sv_alliedDMGLimit", "1"); // allied deployable mg limit
	//setcvar("sv_axisDMGLimit", "1"); // axis deployable mg limit

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
	setcvar("scr_artillery_first_interval" , "150"); // How long after spawn the Artillery Strike becomes available?
	setcvar("scr_artillery_interval" , "120"); // How long between artillery stikes
	setcvar("scr_artillery_interval_range" , "15"); // Random number of seconds added to scr_artillery_interval

	// Flamethrower
	setcvar("scr_allow_flamethrower" , "1");

	// Flak Canons
	setcvar("scr_allow_flak88" , "0");

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
	setcvar("g_autoscreenshot" , "1");

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

	//Misc
	setcvar("sv_reconnectlimit", "5");
	setcvar("sv_minPing", "0");			
	setcvar("sv_maxPing", "0");
	setcvar("g_inactivity", "0");

	/* Do NOT Touch These */
	game["mode"] = "match";
}
