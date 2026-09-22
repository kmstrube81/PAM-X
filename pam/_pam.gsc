PAM_Init()
{
    pam_enabled = maps\mp\uox\_uox_vars::varDef("pam", "enabled", "bool", false, false, "", "", "PAM");
    
    if(!pam_enabled)
        return;

    //run pam before regular start game callback
    level.StartGametype_Callbacks = maps\mp\uox\_uox_arrays::arrayUnshift(level.StartGametype_Callbacks, ::PAM_StartGameType);
    //run pam routines before regular player damage callback
    level.PlayerDamage_Callbacks = maps\mp\uox\_uox_arrays::arrayUnshift(level.PlayerDamage_Callbacks, ::PAM_PlayerDamage);
    //run pam routines before regular player killed callback
    level.PlayerKilled_Callbacks = maps\mp\uox\_uox_arrays::arrayUnshift(level.PlayerKilled_Callbacks, ::PAM_PlayerKilled);
    //run pam routines after regular player connect callback
    level.PlayerConnect_Callbacks = maps\mp\uox\_uox_arrays::arrayPush(level.PlayerConnect_Callbacks, ::PAM_PlayerConnect);

}

PAM_Vars()
{
    //set up PAM version string
    game["headerR"] = &"PAM-X 20260901";
    maps\mp\uox\_uox_vars::varDef("pam", "mode", "string", true, "pub", "", "", "PAM Mode", ::PAM_Restart);
    maps\mp\uox\_uox_vars::varDef("pam", "blackoutspectators", "bool", true, false, "", "", "Black Out Spectators");
    maps\mp\uox\_uox_vars::varDef("pam", "custom_maps", "string", true, "", "", "", "Server Custom Maps");
    maps\mp\uox\_uox_vars::varDef("pam", "afteractionreport", "bool", true, false, "", "", "After Action Report");
}

PAM_Rules()
{

    ruleset = [[level.getVars]]("pam_mode");

    switch(ruleset)
    {
    case "twl_ladder":
        if(getCvar("g_gametype") == "sd")
            thread pam\rules\_twl_ladder_sd_rules::Rules();
        else
        {
            thread pam\rules\_public_rules::Rules();
                setCvar("pam_mode", "pub");
        }
        break;
    case "twl_rifles":
         switch(getCvar("g_gametype"))
         {
             case "ctf":
                 thread pam\rules\_twl_rifles_ctf_rules::Rules();
                 break;
             case "sd":
                thread pam\rules\_twl_rifles_sd_rules::Rules();
                break;
             default:
                thread pam\rules\_public_rules::Rules();
                setCvar("pam_mode", "pub");
        }
        break;
    case "twl_classic_ladder":
        switch(getCvar("g_gametype"))
        {
            case "ctf":
                thread pam\rules\_twl_classic_ladder_ctf_rules::Rules();
                break;
            default:
                thread pam\rules\_public_rules::Rules();
                setCvar("pam_mode", "pub");
        }
        break;
    case "twl_league":
        switch(getCvar("g_gametype"))
         {
             case "ctf":
                 thread pam\rules\_twl_league_ctf_rules::Rules();
                 break;
             case "sd":
                thread pam\rules\_twl_league_sd_rules::Rules();
                break;
             default:
                thread pam\rules\_public_rules::Rules();
                setCvar("pam_mode", "pub");
        }
        break;
    case "twl":
        switch(getCvar("g_gametype"))
        {
            case "bas":
                thread pam\rules\_twl_bas_rules::Rules();
                break;
            case "tdm":
                thread pam\rules\_twl_tdm_rules::Rules();
                break;
            default:
                thread pam\rules\_public_rules::Rules();
                setCvar("pam_mode", "pub");
        }
        break;
    case "ogl":
        if(getCvar("g_gametype") == "sd")
            thread pam\rules\_ogl_sd_rules::Rules();
        else
        {
            thread pam\rules\_public_rules::Rules();
                setCvar("pam_mode", "pub");
        }
        break;
    case "cb":
        switch(getCvar("g_gametype"))
        {
            case "tdm":
                thread pam\rules\_cb_tdm_rules::Rules();
                break;
            case "ctf":
                thread pam\rules\_cb_ctf_rules::Rules();
                break;
            case "sd":
                thread pam\rules\_cb_sd_rules::Rules();
                break;
            default:
                thread pam\rules\_public_rules::Rules();
                setCvar("pam_mode", "pub");
        }
        break;
    case "cal":
        switch(getCvar("g_gametype"))
        {
            case "ctf":
                thread pam\rules\_cal_sd_rules::Rules();
                break;
            case "sd":
                thread pam\rules\_cal_sd_rules::Rules();
                break;
            default:
                thread pam\rules\_public_rules::Rules();
                setCvar("pam_mode", "pub");
        }
        break;
    case "bl":
        switch(getCvar("g_gametype"))
        {
            case "tdm":
                thread pam\rules\_britleague_tdm_rules::Rules();
                break;
            case "ctf":
                thread pam\rules\_britleague_ctf_rules::Rules();
                break;
            case "sd":
                thread pam\rules\_britleague_sd_rules::Rules();
                break;
            default:
                thread pam\rules\_public_rules::Rules();
                setCvar("pam_mode", "pub");
        }
        break;
    case "ccodl":
        if(getCvar("g_gametype") == "ctf")
            thread pam\rules\_ccodl_ctf_rules::Rules();
        else
        {
            thread pam\rules\_public_rules::Rules();
                setCvar("pam_mode", "pub");
        }
        break;
    case "ga":
        if(getCvar("g_gametype") == "ctf")
            thread pam\rules\_ga_ctf_rules::Rules();
        else
        {
            thread pam\rules\_public_rules::Rules();
                setCvar("pam_mode", "pub");
        }
        break;
    case "mgl":
        if(getCvar("g_gametype") == "sd")
            thread pam\rules\_mgl_sd_rules::Rules();
        else
        {
            thread pam\rules\_public_rules::Rules();
                setCvar("pam_mode", "pub");
        }
        break;
    case "kw":
        if(getCvar("g_gametype") == "sd")
            thread pam\rules\_kw_sd_rules::Rules();
        else
        {
            thread pam\rules\_public_rules::Rules();
            setCvar("pam_mode", "pub");
        }
        break;
    case "bl_classic":
        if(getCvar("g_gametype") == "sd")
            thread pam\rules\_britleague_classic_sd_rules::Rules();
        else
        {
            thread pam\rules\_public_rules::Rules();
            setCvar("pam_mode", "pub");
        }
        break;
    case "na_comp":
        thread pam\rules\_na_comp_rules::Rules();
        break;
    case "na_comp_pub":
        thread pam\rules\_na_comp_pub_rules::Rules();
        break;
    case "lan":
        thread pam\rules\_lan_rules::Rules();
        break;
    case "dev":
        thread pam\rules\_dev_rules::Rules();
        break;
    default:
        thread pam\rules\_public_rules::Rules();
        setCvar("pam_mode", "pub");
    }

}

PAM_GetStockPK3()
{
	// List all Allowed PK3 file names HERE separated by a space.  DO NOT include '.pk3'
	stockPK3 = "uomappack00 pakuo07 pakuo06 pakuo05 pakuo04 pakuo03 pakuo02 pakuo01 pakuo00 pakb paka pak9 pak8 pak6 pak5 pak4 pak3 pak2 pak1 pak0 z_svr_pamx_20260901 z_svr_modtypes z_svr_uox";

    return stockPK3;
}

PAM_GetCustomMapPK3()
{
    // List all Allowed PK3 file names HERE separated by a space.  DO NOT include '.pk3'
    customPK3 = [[level.getVars]]("pam_custom_maps");
    
    return customePK3; 
}

PAM_NonstockPK3Check()
{
	stockmaxxing = PAM_GetStockPK3();

    customs = PAM_GetCustomMapPK3();

	serverPK3 = [];
	serverPK3 = getCvar("sv_pakNames");
	
	foundCount = 0;
	PK3check = [];
	PK3check[0] = "none";

	foundPK3 = maps\mp\uox\_uox_utils::stringSplit(serverPK3, " ");
	for (i=0; i < foundPK3.size ; i++)
	{
		found = maps\mp\uox\_uox_utils::findStr(foundPK3[i], stockmaxxing, "anywhere");
		if (found != -1)
			continue;
		else
		{
			foundCount++;
			PK3check[foundCount] = foundPK3[i];
		}
	}

    return PK3check;
}

PAM_CheckPK3Files()
{

    level waittill("readyup");

    serverPK3 = [];
	serverPK3 = getCvar("sv_pakNames");
	iprintln("^2Server PK3 Files:");
    foundPK3 = maps\mp\uox\_uox_utils::stringSplit(serverPK3, " ");
	for (i=0; i < foundPK3.size ; i++)
	{
        iprintln("^2" + foundPK3[i]);
    }

    PK3check = PAM_NonstockPK3Check();

	// Print Unknown PK3 Files
	if (PK3check.size > 1)
	{
		iprintln("^1Unknown PK3 files:");
		for (index = 1;index < PK3check.size; index++ )
		{
			iprintln("^1" + PK3check[index]);
			wait .05;
		}
	}
	iprintln("^8.");
	iprintln("^8.");
	iprintln("^8.");
	iprintln("^8.");
	iprintln("^2Server PK3 Files in console");
	if (PK3check.size > 1)
	{
			iprintln("^1Warning: Unknown PK3 Files listed in console");
	}

}

PAM_StartGameType()
{
    PAM_Vars();
    PAM_Rules();

    game["headerL"] = game["leaguestring"];

    thread PAM_CheckPK3Files();
    if([[level.getVars]]("pam_afteractionreport"))
    {
        thread PAM_AfterActionReport();
    }
}

PAM_AfterActionReport()
{

    afteractionreport = [[level.getVars]]("pam_afteractionreport");
    if(!afteractionreport || level.respawn_mode != "obj" || [[level.getVars]]("scr_reinforcements") != 1)
        level.afteractionreport = false;
    else
        level.afteractionreport = afteractionreport;

    level waittill("postround");

    pam\_pam_afteractionreport::printToAll();
}

PAM_PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc)
{
    if(level.afteractionreport)
        self thread pam\_pam_afteractionreport::onPlayerDamaged(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc);
}

PAM_PlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc)
{
    if(level.afteractionreport)
        self thread pam\_pam_afteractionreport::onPlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc);
}

PAM_PlayerConnect()
{

    self maps\mp\uox\_uox_loops::addToLoop(self, "fast", ::PAM_BlackoutSpectator, "PAM_BlackoutSpectator");

    if(level.afteractionreport)
        pam\_pam_afteractionreport::onConnected();

}

PAM_BlackoutSpectator()
{
    if(![[level.getVars]]("pam_blackoutspectators")) 
        return;

    if(level.mapended || level.roundended || level.halftime)
    {
        self maps\mp\uox\_uox_hud::clearBlackedoutClientHUD();
        self maps\mp\uox\_uox_loops::removeFromLoop(self, "fast", "PAM_BlackoutSpectator");
        return;
    }

    if(self.pers["team"] != "spectator" && self.sessionstate == "spectator")
    {
        self maps\mp\uox\_uox_hud::blackoutClientHUD();
    }
    else
    {
        self maps\mp\uox\_uox_hud::clearBlackedoutClientHUD();
    }
}

PAM_PreventMapChange()
{
	mapname = getcvar("mapname");
	setcvar("sv_mapRotationCurrent" , mapname);
}

PAM_Restart()
{
    PAM_PreventMapChange();

	pammode = getcvar("pam_mode");
	iprintlnbold("^2PAM UO Mode Changed to ^3" + pammode);
	iprintlnbold("^3Please Wait");

	wait 3;
	exitLevel(false);
}


