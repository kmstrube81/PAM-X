PAM_handleDraftMenuResponse(response, optional)
{
    if(level.pam_draft == -1)
        return;
    if(self != level.pam_draft_picking && self != level.pam_draft_waiting)
        return;

    // either captain may confirm their team during player selection (bug 2)
    if(response == "readyup")
    {
        if(level.pam_draft < 2 || isDefined(self.teamReady))
            return;

        if(level.objective == "bel")
            self setClientCvar("g_scriptMainMenu", game["menu_weapon_all"]);
        else if(self.pers["team"] == "allies")
            self setClientCvar("g_scriptMainMenu", game["menu_weapon_allies"]);
        else if(self.pers["team"] == "axis")
            self setClientCvar("g_scriptMainMenu", game["menu_weapon_axis"]);
        self.teamReady = 1;

        if(self == level.pam_draft_picking)
            PAM_DraftPassTurn();
        else
            PAM_DraftUpdateUI();
        return;
    }

    // everything else is only for the captain whose turn it is
    if(self != level.pam_draft_picking)
        return;

    switch(level.pam_draft)
    {
        case 0:
        case 1:
            // side can only be chosen by a captain who doesn't have one yet (bug 4)
            if(self.pers["team"] != "spectator")
                return;

            if(response == "option1")
                PAM_DraftSetSides("allies");
            else if(response == "option2")
                PAM_DraftSetSides("axis");
            else if(response == "option3" && level.pam_draft == 0)
                level.pam_draft = 1; // team 1 picks first, team 2 picks side
            break;

        default:
            if(response == "next" || response == "previous")
            {
                if(level.pam_draftees.size > 10)
                    PAM_DraftRotateDraftees(response);
                return;
            }
            if(response == "skip")
            {
                PAM_DraftPassTurn();
                return;
            }
            if(maps\mp\uox\_uox_utils::findStr("option", response, "start") > -1)
                PAM_DraftPick((int)maps\mp\uox\_uox_utils::subStr(response, 6) - 1);
            else if(maps\mp\uox\_uox_utils::findStr("cut", response, "start") > -1)
                PAM_DraftCut((int)maps\mp\uox\_uox_utils::subStr(response, 3) - 1);
            break;
    }
}

PAM_DraftTeams()
{
    level waittill("postround");

    if(![[ level.getVars ]]("pam_draft_teams") || game["matchstarted"] || isDefined(game["drafted"]))
    {
        maps\mp\uox\_uox_debug::debugLog("info", "No draft, starting game");
        return;
    }
    maps\mp\uox\_uox_debug::debugLog("info", "Starting draft");
    level notify("kill_endround"); //interrupt roundend for draft
    level endon("pam_draft_abort"); //a captain disconnected (bug 6)

    //check that team captains are valid
    players = getentarray("player", "classname");
    for(i = 0; i < players.size; i++)
    {
        isCaptain = PAM_DraftIsCaptain(players[i]);
        if(isCaptain == 1)
            team1captain = players[i];
        else if(isCaptain == 2)
            team2captain = players[i];
    }
    if(!isDefined(team1captain) || !isDefined(team2captain))
    {
        iprintlnbold("Captains not present. Game will start without draft");
        PAM_DraftClearRosters();
        PAM_DraftStartGame(false);
        return;
    }

    //set team names and rosters
    setCvar("pam_team1_name", team1captain.name);
    setCvar("pam_team2_name", team2captain.name);
    setCvar("pam_team1_roster", "");
    setCvar("pam_team2_roster", "");
    PAM_DraftAddPlayerToRoster(team1captain, team1captain);
    PAM_DraftAddPlayerToRoster(team2captain, team2captain);

    iprintlnbold("Captains picking teams. Game will start shortly");
    level.lockteams = true;
    for(i = 0; i < players.size; i++) //kick everyone (captains included) to spec
        players[i] PAM_DraftKickToSpec();

    //---- stage 0: team 1 chooses a side or first pick ----
    level.pam_draft = 0;
    level.pam_draft_picking = team1captain;
    level.pam_draft_waiting = team2captain;
    level.pam_draftees = [];
    PAM_DraftRefreshSlots(); //clear slots left over from a previous draft
    PAM_DraftUpdateUI();
    team1captain PAM_DraftOpenDraftMenu();
    team2captain PAM_DraftOpenDraftMenu();

    while(level.pam_draft == 0)
        wait level.frametime;

    //---- stage 1: team 2 chooses a side if team 1 took first pick ----
    pickFirst = (team1captain.pers["team"] == "spectator");
    level.pam_draft_picking = team2captain;
    level.pam_draft_waiting = team1captain;
    PAM_DraftUpdateUI();

    while(team2captain.pers["team"] == "spectator")
        wait level.frametime;

    //both captains choose a weapon, whichever path was taken (bug 1)
    team1captain PAM_DraftOpenWeaponMenu();
    team2captain PAM_DraftOpenWeaponMenu();
    while(!isDefined(team1captain.pers["weapon"]) || !isDefined(team2captain.pers["weapon"]))
        wait level.frametime;

    //---- stage 2: player selection ----
    if(pickFirst) //team 1 took first pick (bug 1)
    {
        level.pam_draft_picking = team1captain;
        level.pam_draft_waiting = team2captain;
    }
    else //team 1 took side, team 2 picks first
    {
        level.pam_draft_picking = team2captain;
        level.pam_draft_waiting = team1captain;
    }
    level.pam_draft = 2;
    PAM_DraftUpdateDraftees(); //builds the list (includes anyone who joined during stages 0-1)
    PAM_DraftUpdateUI();
    team1captain PAM_DraftOpenDraftMenu();
    team2captain PAM_DraftOpenDraftMenu();

    //poll so draftees' weapon icons update when they pick in their own menu
    while(!isDefined(team1captain.teamReady) || !isDefined(team2captain.teamReady))
    {
        PAM_DraftRefreshSlots();
        wait 0.5;
    }

    //the drafted sides become team1/team2 for the match (rosters, scores, team names)
    game["team1"] = team1captain.pers["team"];
    game["team2"] = team2captain.pers["team"];

    iprintlnbold("Both Teams Ready. Game Starting...");
    PAM_DraftStartGame(true);
}

PAM_DraftRotateDraftees(dir, offset)
{
    if(!isDefined(offset))
        offset = 10;
    if(dir == "previous")
        offset = offset * -1;

    if(offset != 0 && level.pam_draftees.size > 0)
        level.pam_draftees = maps\mp\uox\_uox_arrays::arrayOffset(level.pam_draftees, offset);

    PAM_DraftRefreshSlots();
}

PAM_DraftUpdateDraftees()
{
    level.pam_draftees = [];
    players = getentarray("player", "classname");
    for(i = 0; i < players.size; i++)
    {
        if(players[i] == level.pam_draft_picking || players[i] == level.pam_draft_waiting)
            continue;
        level.pam_draftees[level.pam_draftees.size] = players[i];
    }
    PAM_DraftRefreshSlots();
}

PAM_DraftIsCaptain(player)
{
    team1id = getCvar("pam_team1_captain");
    team2id = getCvar("pam_team2_captain");
    
    dedicated = (int)getCvar("dedicated");
    //check if captain
    switch(dedicated)
    {
        case 0:
        case 1:
            pid = player getEntityNumber();
            maps\mp\uox\_uox_debug::debugLog("info", player.name + " checking if captain via ent number, player ent number is: "
                                              + pid + ". captain 1 ent number is: " + team1id + ". captain 2 ent number is: "
                                             + team2id + ".");
            break;
        default:
            pid = player getGuid();
            maps\mp\uox\_uox_debug::debugLog("info", player.name + " checking if captain via guid, player guid is: "
                                              + pid + ". captain 1 guid is: " + team1id + ". captain 2 guid is: "
                                             + team2id + ".");
    }
    if(pid == team1id && pid != team2id)
        return 1;
    else if(pid != team1id && pid == team2id) 
        return 2;
    else
        return 0;
}

PAM_DraftAddPlayerToRoster(captain, player)
{
    team = PAM_DraftIsCaptain(captain);
    if(team == 0)
        return;
    roster = "pam_team" + team + "_roster";

    currentroster = getCvar(roster);

    dedicated = (int)getCvar("dedicated");
    switch(dedicated)
    {
        case 0:
        case 1:
            pid = player getEntityNumber() + ";";
            break;
        default:
            pid = player getGuid() + ";";
    }

    currentroster = currentroster + pid;

    setCvar(roster, currentroster);
}

PAM_DraftCutPlayerFromRoster(captain, player)
{
    team = PAM_DraftIsCaptain(captain);
    if(team == 0)
        return;
    roster = "pam_team" + team + "_roster";

    currentroster = getCvar(roster);

    dedicated = (int)getCvar("dedicated");
    switch(dedicated)
    {
        case 0:
        case 1:
            pid = player getEntityNumber() + ";";
            break;
        default:
            pid = player getGuid() + ";";
    }
    psize = pid.size;
    //find where
    start = maps\mp\uox\_uox_utils::findStr(";" + pid, ";" + currentroster, "anywhere");
    beg = "";
    end = "";
    if(start == -1)
        return; //nothing to change
    if(start != 0)
        beg = maps\mp\uox\_uox_utils::subStr( currentroster, 0, start );
    end = maps\mp\uox\_uox_utils::subStr( currentroster, start + psize );
    newroster = beg + end;

    setCvar(roster, newroster);
}

// send a client cvar only when its value changed (keeps the reliable command buffer clear)
PAM_DraftSetCvar(name, value)
{
    value = value + "";
    if(!isDefined(self.draftCvars))
        self.draftCvars = [];
    if(isDefined(self.draftCvars[name]) && self.draftCvars[name] == value)
        return;
    self.draftCvars[name] = value;
    self setClientCvar(name, value);
}

// writes the 10 visible slots for both captains from level.pam_draftees
PAM_DraftRefreshSlots()
{
    pickTeam = level.pam_draft_picking.pers["team"];

    for(index = 0; index < 10; index++)
    {
        name = "";
        team = "";
        weapon = "";
        cut = "0";
        if(index < level.pam_draftees.size)
        {
            player = level.pam_draftees[index];
            name = (index + 1) + ". " + player.pers["pam_shortname"];
            if(player.pers["team"] == "allies")
                team = game["allies"];
            else if(player.pers["team"] == "axis")
                team = "german";
            else
                team = "spectator";

            if(team != "spectator" && isDefined(player.pers["weapon"]))
                weapon = "1";
            else
                weapon = "2";

            //a spectator captain has no players to cut
            if(pickTeam != "spectator" && player.pers["team"] == pickTeam)
                cut = "1";
        }
        level.pam_draft_picking PAM_DraftSetCvar("ui_scoreboard" + index + "_name", name);
        level.pam_draft_picking PAM_DraftSetCvar("ui_scoreboard" + index + "_c", team);
        level.pam_draft_picking PAM_DraftSetCvar("ui_scoreboard" + index + "_d", weapon);
        level.pam_draft_picking PAM_DraftSetCvar("ui_scoreboard" + index + "_b", cut);
        level.pam_draft_waiting PAM_DraftSetCvar("ui_scoreboard" + index + "_name", name);
        level.pam_draft_waiting PAM_DraftSetCvar("ui_scoreboard" + index + "_c", team);
        level.pam_draft_waiting PAM_DraftSetCvar("ui_scoreboard" + index + "_d", weapon);
        level.pam_draft_waiting PAM_DraftSetCvar("ui_scoreboard" + index + "_b", "0");
    }
}

// sets ui_draftphase + banner for both captains from the current stage/turn
PAM_DraftUpdateUI()
{
    picking = level.pam_draft_picking;
    waiting = level.pam_draft_waiting;

    if(level.pam_draft == 0)
    {
        picking PAM_DraftSetCvar("ui_draftphase", "0");
        picking PAM_DraftSetCvar("ui_draftbanner", "Pick First or Pick Side?");
        waiting PAM_DraftSetCvar("ui_draftphase", "5");
        waiting PAM_DraftSetCvar("ui_draftbanner", "Other Captain Choosing Pick or Side...");
        return;
    }
    if(level.pam_draft == 1)
    {
        if(picking.pers["team"] == "spectator")
        {
            picking PAM_DraftSetCvar("ui_draftphase", "4");
            picking PAM_DraftSetCvar("ui_draftbanner", "Pick Side.");
            waiting PAM_DraftSetCvar("ui_draftphase", "5");
            waiting PAM_DraftSetCvar("ui_draftbanner", "Other Captain is Choosing Side...");
        }
        else
        {
            picking PAM_DraftSetCvar("ui_draftphase", "5");
            picking PAM_DraftSetCvar("ui_draftbanner", "Please Wait...");
            waiting PAM_DraftSetCvar("ui_draftphase", "5");
            waiting PAM_DraftSetCvar("ui_draftbanner", "Please Wait...");
        }
        return;
    }
    picking PAM_DraftCaptainUI();
    waiting PAM_DraftCaptainUI();
    PAM_DraftRefreshSlots();
}

PAM_DraftCaptainUI()
{
    if(isDefined(self.teamReady))
    {
        self PAM_DraftSetCvar("ui_draftphase", "3");
        self PAM_DraftSetCvar("ui_draftbanner", "Team Confirmed. Waiting for Other Captain...");
    }
    else if(self == level.pam_draft_picking)
    {
        self PAM_DraftSetCvar("ui_draftphase", "1");
        self PAM_DraftSetCvar("ui_draftbanner", "Pick Next Player.");
    }
    else
    {
        self PAM_DraftSetCvar("ui_draftphase", "2");
        self PAM_DraftSetCvar("ui_draftbanner", "Other Captain is Picking...");
    }
}

// hand the turn to the other captain unless they have already confirmed their team
PAM_DraftPassTurn()
{
    if(!isDefined(level.pam_draft_waiting.teamReady))
    {
        temp = level.pam_draft_waiting;
        level.pam_draft_waiting = level.pam_draft_picking;
        level.pam_draft_picking = temp;
    }
    PAM_DraftUpdateUI();
}

PAM_DraftPick(slot)
{
    if(slot < 0 || slot > 9 || slot >= level.pam_draftees.size)
        return;
    draftee = level.pam_draftees[slot];
    if(!isDefined(draftee) || draftee.pers["team"] != "spectator")
        return;

    draftee PAM_DraftSetTeam(level.pam_draft_picking.pers["team"]);
    draftee PAM_DraftOpenWeaponMenu();
    PAM_DraftAddPlayerToRoster(level.pam_draft_picking, draftee);
    PAM_DraftPassTurn();
}

PAM_DraftCut(slot)
{
    if(slot < 0 || slot > 9 || slot >= level.pam_draftees.size)
        return;
    draftee = level.pam_draftees[slot];
    if(!isDefined(draftee) || draftee.pers["team"] != level.pam_draft_picking.pers["team"])
        return;

    draftee PAM_DraftKickToSpec();
    PAM_DraftCutPlayerFromRoster(level.pam_draft_picking, draftee);
    PAM_DraftUpdateUI();
}

PAM_DraftSetSides(team)
{
    other = "axis";
    if(team == "axis")
        other = "allies";
    level.pam_draft_picking PAM_DraftSetTeam(team);
    level.pam_draft_waiting PAM_DraftSetTeam(other);
    if(level.pam_draft == 0)
        level.pam_draft = 1;
}

PAM_DraftSetTeam(team)
{
    self.pers["team"] = team;
    self.pers["teamTime"] = (gettime() / 1000);
    self.pers["weapon"] = undefined;
    self.pers["weapon1"] = undefined;
    self.pers["weapon2"] = undefined;
    self.pers["spawnweapon"] = undefined;
    self.pers["savedmodel"] = undefined;

    if(level.uox_teamplay) // update spectator permissions immediately on change of team
        self maps\mp\gametypes\_teams::SetSpectatePermissions();
}

PAM_DraftKickToSpec()
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

// one else-if chain so BEL doesn't open two menus (bug 3)
PAM_DraftOpenWeaponMenu()
{
    menu = undefined;
    if(level.objective == "bel")
    {
        if(maps\mp\gametypes\_teams::isweaponavailable("axis") || maps\mp\gametypes\_teams::isweaponavailable("allies"))
            menu = game["menu_weapon_all"];
    }
    else if(self.pers["team"] == "allies" && maps\mp\gametypes\_teams::isweaponavailable("allies"))
        menu = game["menu_weapon_allies"];
    else if(self.pers["team"] == "axis" && maps\mp\gametypes\_teams::isweaponavailable("axis"))
        menu = game["menu_weapon_axis"];

    if(isDefined(menu))
    {
        self setClientCvar("ui_weapontab", "1");
        self setClientCvar("g_scriptMainMenu", menu);
        self openMenu(menu);
    }
    else
    {
        self setClientCvar("ui_weapontab", "0");
        self maps\mp\uox\_uox_respawns::menu_spawn("none");
    }
}

PAM_DraftOpenDraftMenu()
{
    self setClientCvar("g_scriptMainMenu", game["menu_draft"]);
    self openMenu(game["menu_draft"]);
}

PAM_DraftClearRosters()
{
    setCvar("pam_team1_name", "");
    setCvar("pam_team2_name", "");
    setCvar("pam_team1_roster", "");
    setCvar("pam_team2_roster", "");
}

PAM_DraftStartGame(drafted)
{
    level.pam_draft = -1;
    game["drafted"] = drafted;
    level thread maps\mp\uox\_uox_killcam::finalKillcamListener();
    level.roundended = false;
    maps\mp\uox\_uox::endRound("reset");
}

// a captain left mid-draft: start without a draft (bug 6)
PAM_DraftAbort(leaver)
{
    level notify("pam_draft_abort"); //kills PAM_DraftTeams
    level.pam_draft = -1;            //stops the menu handler
    iprintlnbold("A captain left. Game will start without draft");

    captains = [];
    captains[0] = level.pam_draft_picking;
    captains[1] = level.pam_draft_waiting;
    for(i = 0; i < captains.size; i++)
    {
        if(!isDefined(captains[i]) || captains[i] == leaver)
            continue;
        captains[i] closeMenu(game["menu_draft"]);
        captains[i] setClientCvar("g_scriptMainMenu", game["menu_team"]);
    }
    PAM_DraftClearRosters();
    PAM_DraftStartGame(false);
}

PAM_DraftRemoveDraftee(player)
{
    list = [];
    for(i = 0; i < level.pam_draftees.size; i++)
    {
        if(level.pam_draftees[i] != player)
            list[list.size] = level.pam_draftees[i];
    }
    level.pam_draftees = list;
    PAM_DraftUpdateUI();
}
