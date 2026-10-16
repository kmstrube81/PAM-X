PAM_Init()
{
    pam_enabled = maps\mp\uox\_uox_vars::varDef("pam", "enabled", "bool", false, false, "", "", "PAM");
    
    if(!pam_enabled)
        return;

    //run pam before regular start game callback
    level.StartGametype_Callbacks = maps\mp\uox\_uox_arrays::arrayUnshift(level.StartGametype_Callbacks, ::PAM_StartGameType);
    //define menus after regular start game callback
    level.StartGametype_Callbacks = maps\mp\uox\_uox_arrays::arrayPush(level.StartGametype_Callbacks, ::PAM_DefineMenus);
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
    maps\mp\uox\_uox_vars::varDef("pam", "exploitblocker", "bool", false, false, "", "", "Fix Exploits");
    level.pam_dropweapon = maps\mp\uox\_uox_vars::varDef("pam", "dropweapon", "bool", true, false, "", "",
                                                         "Allow Manual Weapon Drop", ::PAM_UpdateDropWeapon);
    maps\mp\uox\_uox_vars::varDef("pam", "draft_teams", "bool", false, false, "", "", "Draft Teams at Start"); 
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
    
    return customPK3; 
}

PAM_NonstockPK3Check()
{
	stockmaxxing = PAM_GetStockPK3();

    maps\mp\uox\_uox_debug::debugLog("info", maps\mp\uox\_uox_utils::stringSplit(stockmaxxing, " ").size + " total stock pak files. stock server pak files: " + stockmaxxing);   

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

    maps\mp\uox\_uox_debug::debugLog("info", "found " + foundCount + " total non stock pak files");

    return PK3check;
}

PAM_NoncustomPK3Check(nonstockPK3s)
{
	customs = PAM_GetCustomMapPK3();
	
	foundCount = 0;
	PK3check = [];
	PK3check[0] = "none";

    if(!isDefined(nonstockPK3s[1]))
        return PK3check;

	for (i=1; i < nonstockPK3s.size ; i++)
	{
		found = maps\mp\uox\_uox_utils::findStr(nonstockPK3s[i], customs, "anywhere");
		if (found != -1)
			continue;
		else
		{
			foundCount++;
			PK3check[foundCount] = nonstockPK3s[i];
		}
	}

    maps\mp\uox\_uox_debug::debugLog("info", "found " + PK3check.size + " pak files not specified in config");

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

    maps\mp\uox\_uox_debug::debugLog("info", "found " + foundPK3.size + " total pak files");

    stockmaxxing = PAM_NonstockPK3Check();

    PK3check = PAM_NoncustomPK3Check(stockmaxxing);

	// Print Unknown PK3 Files
	if (PK3check.size > 1)
	{
		iprintln("^1Unknown PK3 files:");
        maps\mp\uox\_uox_debug::debugLog("info", "unknown server pak files:");
		for (index = 1;index < PK3check.size; index++ )
		{
			iprintln("^1" + PK3check[index]);
            maps\mp\uox\_uox_debug::debugLog("info", PK3check[index]);
			wait level.frametime;
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

PAM_DefineMenus()
{
    if(!isDefined(game["PAM_gamestarted"]))
    {
        game["menu_draft"] = "menu_draft";
        precacheMenu(game["menu_draft"]);
        game["PAM_gamestarted"] = true;
    }

    PAM_SetupMenuHandlers();
}

PAM_SetupMenuHandlers()
{
    //set up menu handlers
    if(!isDefined(level.menuHandlers))
        level.menuHandlers = maps\mp\uox\_uox_arrays::superArray();

    maps\mp\uox\_uox_menus::registerMenu(game["menu_draft"], ::handleDraftMenuResponse, true);
    //override weapon select handling
    //handle weapons - all
    maps\mp\uox\_uox_menus::registerMenu(game["menu_weapon_all"], ::PAM_handleWeaponMenu, false);
    //handle weapons - allies
    maps\mp\uox\_uox_menus::registerMenu(game["menu_weapon_allies"], ::PAM_handleWeaponMenu, false);
    //hande weapons - axis
    maps\mp\uox\_uox_menus::registerMenu(game["menu_weapon_axis"], ::PAM_handleWeaponMenu, false);
}

PAM_handleWeaponMenu(response, weapon)
{

    if(!isDefined(self.pers["team"]) || (self.pers["team"] != "allies" && self.pers["team"] != "axis"))
        return;

    if(isDefined(weapon))
        maps\mp\uox\_uox_debug::debugLog("info", self.name + " PAM handleWeaponMenu passed in weapon is " + weapon);

    if(!isDefined(weapon) || weapon != "restricted") 
        weapon = self maps\mp\gametypes\_pam_teams::restrict(response);

    return weapon;
}

handleDraftMenuResponse(response, optional)
{
    if(level.pam_draft_picking != self)
        return;
        
    switch(level.pam_draft) //response depends on stage
    {
        case 0:
        case 1:
            if(response == "option1")
            { //chose allies
                level.pam_draft_picking.pers["team"] = "allies";
                level.pam_draft_picking.pers["teamTime"] = (gettime() / 1000);
                level.pam_draft_picking.pers["weapon"] = undefined;
                level.pam_draft_picking.pers["weapon1"] = undefined;
                level.pam_draft_picking.pers["weapon2"] = undefined;
                level.pam_draft_picking.pers["spawnweapon"] = undefined;
                level.pam_draft_picking.pers["savedmodel"] = undefined;
                
                if(level.uox_teamplay) // update spectator permissions immediately on change of team
                    level.pam_draft_picking maps\mp\gametypes\_teams::SetSpectatePermissions();
                level.pam_draft_waiting.pers["team"] = "axis";
                level.pam_draft_waiting.pers["teamTime"] = (gettime() / 1000);
                level.pam_draft_waiting.pers["weapon"] = undefined;
                level.pam_draft_waiting.pers["weapon1"] = undefined;
                level.pam_draft_waiting.pers["weapon2"] = undefined;
                level.pam_draft_waiting.pers["spawnweapon"] = undefined;
                level.pam_draft_waiting.pers["savedmodel"] = undefined;
                
                if(level.uox_teamplay) // update spectator permissions immediately on change of team
                    level.pam_draft_waiting maps\mp\gametypes\_teams::SetSpectatePermissions();
                level.pam_draft++; //advance draft stage
            }
            else if(response == "option2")
            { //chose defense
                level.pam_draft_picking.pers["team"] = "axis";
                level.pam_draft_picking.pers["teamTime"] = (gettime() / 1000);
                level.pam_draft_picking.pers["weapon"] = undefined;
                level.pam_draft_picking.pers["weapon1"] = undefined;
                level.pam_draft_picking.pers["weapon2"] = undefined;
                level.pam_draft_picking.pers["spawnweapon"] = undefined;
                level.pam_draft_picking.pers["savedmodel"] = undefined;
                
                if(level.uox_teamplay) // update spectator permissions immediately on change of team
                    level.pam_draft_picking maps\mp\gametypes\_teams::SetSpectatePermissions();
                level.pam_draft_waiting.pers["team"] = "allies";
                level.pam_draft_waiting.pers["teamTime"] = (gettime() / 1000);
                level.pam_draft_waiting.pers["weapon"] = undefined;
                level.pam_draft_waiting.pers["weapon1"] = undefined;
                level.pam_draft_waiting.pers["weapon2"] = undefined;
                level.pam_draft_waiting.pers["spawnweapon"] = undefined;
                level.pam_draft_waiting.pers["savedmodel"] = undefined;
                
                if(level.uox_teamplay) // update spectator permissions immediately on change of team
                    level.pam_draft_waiting maps\mp\gametypes\_teams::SetSpectatePermissions();
                level.pam_draft++; //advance draft stage
            }
            else if(response == "option3")
            {
                if(level.pam_draft == 0)
                    level.pam_draft++; //advance draft stage
            }
            break;
        default:
            switch(response)
            {
                case "readyUp":
                case "skip":
                    if(response == "readyUp")
                    {
                        if(level.objective == "bel")
                            level.pam_draft_picking setClientCvar("g_scriptMainMenu", game["menu_weapon_all"]);
                        else if(level.pam_draft_picking.pers["team"] == "allies")
                            level.pam_draft_picking setClientCvar("g_scriptMainMenu", game["menu_weapon_allies"]);
                        else if(level.pam_draft_picking.pers["team"] == "axis")
                            level.pam_draft_picking setClientCvar("g_scriptMainMenu", game["menu_weapon_axis"]);
                        level.pam_draft_picking.teamReady = 1; 
                    }
                    temp1 = level.pam_draft_waiting;
                    level.pam_draft_waiting = level.pam_draft_picking;
                    level.pam_draft_picking = temp1;
                    level.pam_draft_picking setClientCvar("ui_draftbanner", "Pick Next Player.");
                    level.pam_draft_waiting setClientCvar("ui_draftbanner", "Other Captain is Picking...");
                    break;
                default:
                    //if chose option
                    
                    
                    //if chose cut 
            } 
    } 
}

PAM_StartGameType()
{
    PAM_Vars();
    PAM_Rules();
    PAM_FixExploits();

    game["headerL"] = game["leaguestring"];

    thread PAM_CheckPK3Files();
    thread PAM_AfterActionReport();
    thread PAM_DraftTeams();
}

PAM_AfterActionReport()
{

    afteractionreport = [[level.getVars]]("pam_afteractionreport");
    if(!afteractionreport || level.respawn_mode != "obj" || [[level.getVars]]("scr_reinforcements") != 1)
        level.afteractionreport = false;
    else
        level.afteractionreport = afteractionreport;

    if(!level.afteractionreport)
        return;

    level waittill("postround");

    pam\_pam_afteractionreport::printToAll();
}

PAM_DraftTeams()
{
    level waittill("postround");
    
    if([[ level.getVars ]]("pam_draft_teams") && !game["matchstarted"]
        && !isDefined(game["drafted"]))
        level notify("kill_endround"); //interrupt roundend for draft
    else
        return;
        
    //check that team captains are valid
    team1guid = getCvar("pam_team1_captain");
    team2guid = getCvar("pam_team2_captain");
    
    //find captains
    players = getentarray("player", "classname");
    for( i = 0; i < players.size; i++)
    {
        player = players[i];
        guid = player getGuid();
        
        if(guid != team1guid && guid != team2guid)
            continue;
        else if(guid == team1guid && guid != team2guid)
            team1captain = player;
        else if(guid != team1guid && guid == team2guid)
            team2captain = player;
    }
    //if one of the captains are invalid
    if(!isDefined(team1captain) || !isDefined(team2captain))
    {
        level iprintlnbold("Captains not present. Game will start without draft");
        //clear team names
        setCvar("pam_team1_name", "");
        setCvar("pam_team2_name", "");
        //clear team players
        setCvar("pam_team1_roster", "");
        setCvar("pam_team2_roster", "");
        game["drafted"] = false;
        level.roundended = false;
        maps\mp\uox\_uox::endRound("reset");
    }
    else
    {
        //set team names
        setCvar("pam_team1_name", team1captain.name);
        setCvar("pam_team2_name", team2captain.name);
        //set team players
        setCvar("pam_team1_roster", team1guid);
        setCvar("pam_team2_roster", team2guid);
        //kick others to spec
        level iprintlnbold("Captains picking teams. Game will start shortly");
        level.lockteams = true;
        for( i = 0; i < players.size; i++) //kick all others to spec
        {
            player = players[i];
            if(player == team1captain || player == team2captain)
                continue;
            else
            {
                self.pers["team"] = "spectator";
                self.pers["teamTime"] = 1000000;
                self.pers["weapon"] = undefined;
                self.pers["weapon1"] = undefined;
                self.pers["weapon2"] = undefined;
                self.pers["spawnweapon"] = undefined;
                self.pers["savedmodel"] = undefined;
                
                self.sessionteam = "spectator";
                self setClientCvar("g_scriptMainMenu", game["menu_team"]);
                self setClientCvar("ui_weapontab", "0");
                self maps\mp\uox\_uox_respawns::spawnSpectator();
                
            } 
        }
        //set draft stage
        level.pam_draft = 0;
        level.pam_draft_picking = team1captain;
        level.pam_draft_waiting = team2captain;
        //open draft menu for captains
        team1captain openMenu(game["menu_draft"]);
        team1captain setClientCvar("g_scriptMainMenu", game["menu_draft"]);
        team2captain openMenu(game["menu_draft"]);
        team2captain setClientCvar("g_scriptMainMenu", game["menu_draft"]);
        //team gets asked pick or side first, set banner ui cvar
        team1captain setClientCvar("ui_draftbanner", "Pick First or Pick Side?");
        team2captain setClientCvar("ui_draftbanner", "Other Captain Choosing Pick or Side...");
        
        //wait until draft stage 0 is done (team 1 chooses pick or side)
        while(level.pam_draft == 0)
            wait level.frametime;
        //draft stage 1 (team 2 choose team if team 1 chose pick)
        level.pam_draft_picking = team2captain;
        level.pam_draft_waiting = team1captain;
        if(level.pam_draft_picking.pers["team"] != "spectator") //team 1 chose side
        {   //make both players pick a weapon
            // if there are weapons the user can select then open the weapon menu      
            if(level.objective == "bel" && ( maps\mp\gametypes\_teams::isweaponavailable("axis")
                || maps\mp\gametypes\_teams::isweaponavailable("allies") ))
            {
                menu = game["menu_weapon_all"];
                level.pam_draft_picking setClientCvar("ui_weapontab", "1");
                level.pam_draft_picking openMenu(menu);
                level.pam_draft_waiting setClientCvar("ui_weapontab", "1");
                level.pam_draft_waiting openMenu(menu);
            }
            if(level.pam_draft_picking.pers["team"] == "allies" && maps\mp\gametypes\_teams::isweaponavailable(level.pam_draft_picking.pers["team"]))
            {
                menu = game["menu_weapon_allies"];
                level.pam_draft_picking setClientCvar("ui_weapontab", "1");
                level.pam_draft_picking openMenu(menu);
            if(maps\mp\gametypes\_teams::isweaponavailable(level.pam_draft_waiting.pers["team"]))
                {
                    menu = game["menu_weapon_axis"];
                    level.pam_draft_waiting setClientCvar("ui_weapontab", "1");
                    level.pam_draft_waiting openMenu(menu);
                }
                else
                {
                    level.pam_draft_waiting setClientCvar("ui_weapontab", "0");
                    level.pam_draft_waiting maps\mp\uox\_uox_respawns::menu_spawn("none");
                }
            }
            else if(level.pam_draft_picking.pers["team"] == "axis" && maps\mp\gametypes\_teams::isweaponavailable(self.pers["team"])) 
            {
                menu = game["menu_weapon_axis"];
                level.pam_draft_picking setClientCvar("ui_weapontab", "1");
                level.pam_draft_picking openMenu(menu);
                if(maps\mp\gametypes\_teams::isweaponavailable(level.pam_draft_waiting.pers["team"]))
                {
                    menu = game["menu_weapon_allies"];
                    level.pam_draft_waiting setClientCvar("ui_weapontab", "1");
                    level.pam_draft_waiting openMenu(menu);
                }
                else
                {
                    level.pam_draft_waiting setClientCvar("ui_weapontab", "0");
                    level.pam_draft_waiting maps\mp\uox\_uox_respawns::menu_spawn("none");
                }
            }
            else
            {
                level.pam_draft_picking setClientCvar("ui_weapontab", "0");
                level.pam_draft_picking maps\mp\uox\_uox_respawns::menu_spawn("none");
                level.pam_draft_waiting setClientCvar("ui_weapontab", "0");
                level.pam_draft_waiting maps\mp\uox\_uox_respawns::menu_spawn("none");
            }

            if(!isDefined(menu))
                menu = game["menu_team"];
            self setClientCvar("g_scriptMainMenu", menu);
            
            while(!isDefined(level.pam_draft_picking.pers["weapon"]) || !isDefined(level.pam_draft_waiting.pers["weapon"]))
            wait level.frametime;
            //set main menu back to draft menu
            //open draft menu for captains
            team1captain openMenu(game["menu_draft"]);
            team1captain setClientCvar("g_scriptMainMenu", game["menu_draft"]);
            team2captain openMenu(game["menu_draft"]);
            team2captain setClientCvar("g_scriptMainMenu", game["menu_draft"]);
            //team gets asked pick or side first, set banner ui cvar
            team2captain setClientCvar("ui_draftbanner", "Please Wait...");
            team1captain setClientCvar("ui_draftbanner", "Please Wait...");
            level.pam_draft++;
        }
        else //team 1 chose pick
        {
            team2captain setClientCvar("ui_draftbanner", "Pick Side.");
            team1captain setClientCvar("ui_draftbanner", "Other Captain is Choosing Side...");
        }
        //wait until next draft stage
        while(level.pam_draft == 1)
            wait level.frametime;
        //wait until both teams are ready
        while(!isDefined(team1captain.teamReady) || !isDefined(team2captain.teamReady))
            wait level.frametime;
            
        level iprintlnbold("Both Teams Ready. Game Starting...");
        game["drafted"] = true;
        level.roundended = false;
        maps\mp\uox\_uox::endRound("reset"); 
    }        
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

	self pam\_pam_checksnipers::NoDropWeapon();
}

PAM_PlayerConnect()
{

    self maps\mp\uox\_uox_loops::addToLoop(self, "fast", ::PAM_BlackoutSpectator, "PAM_BlackoutSpectator");

    if(level.afteractionreport)
        pam\_pam_afteractionreport::onConnected();

    if(level.pam_dropweapon)
       self maps\mp\uox\_uox_inputs::addHoldUse("drop weapon", true, 0, 1, ::PAM_CanDrop, ::PAM_DropWeapon, undefined, false);

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

PAM_FixExploits()
{
    if(![[level.getVars]]("pam_exploitblocker"))
        return;

    mapname = getcvar("mapname");

    switch(mapname)
    {
        case "mp_berlin":
            pam\exploits\mp_berlin::fixExploits();
            break;
        case "mp_cassino":
            pam\exploits\mp_cassino::fixExploits();
            break;
        case "mp_foy":
            pam\exploits\mp_foy::fixExploits();
            break;
        case "mp_kursk":
            pam\exploits\mp_kursk::fixExploits();
            break;
        case "mp_ponyri":
            pam\exploits\mp_ponyri::fixExploits();
            break;
        case "mp_rhinevalley":
            pam\exploits\mp_rhinevalley::fixExploits();
            break;
        case "mp_sicily":
            pam\exploits\mp_sicily::fixExploits();
            break;
        case "mp_streets":
            pam\exploits\mp_streets::fixExploits();
            break;
        case "mp_uo_powcamp":
            pam\exploits\mp_uo_powcamp::fixExploits();
            break;
        case "mp_uo_stanjel":
            pam\exploits\mp_uo_stanjel::fixExploits();
            break;
    }
}

PAM_UpdateDropWeapon(update)
{
    level.pam_dropweapon = update;

    if(level.pam_dropweapon)
    {
        players = getentarray("player", "classname");
        for( i = 0; i < players.size; i++)
        {
            player = players[i];
            
            player maps\mp\uox\_uox_inputs::addHoldUse("drop weapon", true, 0, 1, ::PAM_CanDrop, ::PAM_DropWeapon, undefined, false);
        }
    }
    else
    {
        players = getentarray("player", "classname");
        for( i = 0; i < players.size; i++)
        {
            player = players[i];
            
            player maps\mp\uox\_uox_inputs::removeHoldUse("drop weapon");
        }
    }
}

PAM_CanDrop(weapon)
{
    if(!isAlive(self) || self.pers["team"] == "spectator")
        return false;
        
    if (getcvar("sv_noDropDMG") == "")
		setcvar("sv_noDropDMG", "0");
	noDropDMG = getcvarint("sv_noDropDMG");

	if (getcvar("sv_noDropSniper") == "")
		setcvar("sv_noDropSniper", "0");
	noDropSniper = getcvarint("sv_noDropSniper");

	drop = true;

	switch (self getcurrentweapon())
	{
		case "springfield_mp":
		case "kar98k_sniper_mp":
		case "mosin_nagant_sniper_mp":
			if (noDropSniper)
				drop = false;
			break;
		
		case "dp28_mp":
		case "mg30cal_mp":
		case "mg34_mp":
			if (noDropDMG)
				drop = false;
			break;
        //don't drop pistols, grenades, smokes or satchel
        case "colt_mp":
        case "luger_mp":
        case "tt34_mp":
        case "webley_mp":
        case "fraggrenade_mp":
		case "mk1britishfrag_mp":
		case "rgd-33russianfrag_mp":
		case "stielhandgranate_mp":
		case "smokegrenade_mp":
	    case "flashgrenade_mp":
	    case "binoculars_mp":
	    case "binoculars_artillery_mp":
	    case "satchelcharge_mp":
    		    drop = false;
    		    break;
	}
	return drop; 
}

PAM_DropWeapon()
{
    if(!( self PAM_CanDrop()))
        return;

    self dropItem(self getcurrentweapon());
    
    secondary = self getWeaponSlotWeapon("primaryb");
    if(secondary != "none")
        self switchToWeapon(secondary);
    else 
        self switchToWeapon(self getWeaponSlotWeapon("pistol"));
}

