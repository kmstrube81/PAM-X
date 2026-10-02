isWeaponLimited(weapon)
{
	switch(weapon)
	{
		case "restricted":
			return weapon; //nothing to do, weapon is already restricted
			break;
		case "springfield_mp":
		case "mosin_nagant_sniper_mp":
		case "kar98k_sniper_mp":
			limit = getcvarint("sv_SniperLimit");
			if (limit < 1 || limit == 99)
				limit = 99;
			else 
				limitweapons = true;
			class = "Sniper";
			break;
		case "thompson_mp":
		case "thompson_semi_mp":
		case "sten_mp":
		case "ppsh_mp":
		case "ppsh_semi_mp":
		case "sten_silenced_mp":
		case "mp40_mp":
			limit = getcvarint("sv_SMGLimit");
			if (limit < 1 || limit == 99)
				limit = 99;
			else 
				limitweapons = true;
			class = "SMG";
			break;
		case "bren_mp":
		case "bar_mp":
		case "bar_slow_mp":
		case "mp44_mp":
		case "mp44_semi_mp":
			limit = getcvarint("sv_MGLimit");
			if (limit < 1 || limit == 99)
				limit = 99;
			else 
				limitweapons = true;
			class = "MG";
			break;
		case "dp28_mp":
		case "mg30cal_mp":
		case "mg34_mp":
			limit = getcvarint("sv_DMGLimit");
			if (limit < 1 || limit == 99)
				limit = 99;
			else 
				limitweapons = true;
			class = "LMG";
			break;
	}
	if (isdefined(limitweapons))
	{
		if(limit < self getWeaponsCount(class, self.pers["team"]))
		{
			self iprintln("Team is already at the maximum number of " + class + " players");
			return "restricted";
		}
	}
    self updateWeaponSelectMenu(weapon, class, self.pers["team"]);
	return weapon;
}

getWeaponsCount(weaponClass, team)
{
	count = 0;
	//get weapons counts
	lplayers = getentarray("player", "classname");
	for(i = 0; i < lplayers.size; i++)
	{

		lplayer = lplayers[i];
        if(lplayer == self)
            continue;

		if(isdefined(lplayer.pers["weapon"]))
		{
			switch (lplayer.pers["weapon"])
			{
				case "springfield_mp":
				case "mosin_nagant_sniper_mp":
				case "kar98k_sniper_mp":
					if(team == lplayer.pers["team"] && weaponClass == "Sniper")
						count++;
					break;

				case "thompson_mp":
				case "thompson_semi_mp":
				case "sten_mp":
				case "ppsh_mp":
				case "ppsh_semi_mp":
				case "sten_silenced_mp":
				case "mp40_mp":
					if(team == lplayer.pers["team"] && weaponClass == "SMG")
						count++;				
					break;
				
				case "bren_mp":
				case "bar_mp":
				case "bar_slow_mp":
				case "mp44_mp":
				case "mp44_semi_mp":
					if(team == lplayer.pers["team"] && weaponClass == "MG")
						count++;
					break;
				
				case "dp28_mp":
				case "mg30cal_mp":
				case "mg34_mp":
					if(team == lplayer.pers["team"] && weaponClass == "LMG")
						count++;
					break;
			}
		}
	}
	return count;
}

updateWeaponSelectMenu(weapon, class, team)
{
	//check weapon limits
	sniperlimit = getcvarint("sv_SniperLimit");
	if (sniperlimit < 1 || sniperlimit == 99)
		sniperlimit = 99;
	else 
		limitsnipers = true;

	alliedSniperLimit = sniperlimit;
	axisSniperLimit = sniperlimit;
	ialliedSniperCount = 0;
	iaxisSniperCount = 0;

	smglimit = getcvarint("sv_SMGLimit");
	if (smglimit < 1 || smglimit == 99)
		smglimit = 99;
	else
		limitsmgs = true;
	alliedSMGLimit = smglimit;
	axisSMGLimit = smglimit;
	ialliedSMGCount = 0;
	iaxisSMGCount = 0;

	mglimit = getcvarint("sv_MGLimit");
	if (mglimit < 1 || mgslimit == 99)
		mglimit = 99;
	else
		limitmgs = true;
	alliedMGLimit = mglimit;
	axisMGLimit = mglimit;
	ialliedMGCount = 0;
	iaxisMGCount = 0;

	dmglimit = getcvarint("sv_DMGLimit");
	if (dmglimit < 1 || dmglimit == 99)
		dmglimit = 99;
	else
		limitdmgs = true;
	alliedDMGLimit = dmglimit;
	axisDMGLimit = dmglimit;
	ialliedDMGCount = 0;
	iaxisDMGCount = 0;

	//get weapon counts
	lplayers = getentarray("player", "classname");
	for(i = 0; i < lplayers.size; i++)
	{
		lplayer = lplayers[i];
        if(lplayer == self || lplayer.pers["team"] == "spectator")
            continue;

		take_away_weap = 0;

		if(isdefined(lplayer.pers["weapon"]))
		{
			switch (lplayer.pers["weapon"])
			{
				case "springfield_mp":
				case "mosin_nagant_sniper_mp":
				case "kar98k_sniper_mp":
					if(player.pers["team"] == "allies")
						ialliedSniperCount++;
                    else
                        iaxisSniperCount++;
					break;

				case "thompson_mp":
				case "thompson_semi_mp":
				case "sten_mp":
				case "ppsh_mp":
				case "ppsh_semi_mp":
				case "sten_silenced_mp":
				case "mp40_mp":
					if(player.pers["team"] == "allies")
						ialliedSMGCount++;
                    else
                        iaxisSMGCount++;			
					break;
				
				case "bren_mp":
				case "bar_mp":
				case "bar_slow_mp":
				case "mp44_mp":
				case "mp44_semi_mp":
					if(player.pers["team"] == "allies")
						ialliedMGCount++;
                    else
                        iaxisMGCount++;
					break;
				
				case "dp28_mp":
				case "mg30cal_mp":
				case "mg34_mp":
					if(player.pers["team"] == "allies")
						ialliedDMGCount++;
                    else
                        iaxisDMGCount++;
					break;
			}
		}

    }

    switch (weapon)
    {
        case "springfield_mp":
        case "mosin_nagant_sniper_mp":
        case "kar98k_sniper_mp":
            if(team == "allies")
                ialliedSniperCount++;
            else if(team == "axis")
                iaxisSniperCount++;
            break;

        case "thompson_mp":
        case "thompson_semi_mp":
        case "sten_mp":
        case "ppsh_mp":
        case "ppsh_semi_mp":
        case "sten_silenced_mp":
        case "mp40_mp":
            if(team == "allies")
                ialliedSMGCount++;
            else if(team == "axis")
                iaxisSMGCount++;			
            break;
        
        case "bren_mp":
        case "bar_mp":
        case "bar_slow_mp":
        case "mp44_mp":
        case "mp44_semi_mp":
            if(team == "allies")
                ialliedMGCount++;
            else if(team == "axis")
                iaxisMGCount++;
            break;
        
        case "dp28_mp":
        case "mg30cal_mp":
        case "mg34_mp":
            if(team == "allies")
                ialliedDMGCount++;
            else if(team == "axis")
                iaxisDMGCount++;
            break;
    }

	//Limit Snipers
	if (isdefined(limitsnipers))
	{
		if(ialliedSniperCount < alliedSniperLimit)
		{ 
			//turn on sniper weapon select
			setcvar("ui_allow_springfield", "1");
			setcvar("scr_allow_nagantsniper", "1");
		}
		else
		{
			//turn off sniper weapon select
			setcvar("ui_allow_springfield", "0");
			setcvar("ui_allow_nagantsniper", "0");	
		}

		if(iaxisSniperCount < axisSniperLimit)
		{ 
			//turn on sniper weapon select
			setcvar("ui_allow_kar98ksniper", "1");
		}
		else
		{
			//turn off sniper weapon select
			setcvar("ui_allow_kar98ksniper", "0");	
		}
	}

	//Limit SMGs
	if (isdefined(limitsmgs))
	{
		if(ialliedSMGCount < alliedSMGLimit)
		{ 
			//turn on SMG weapon select
			setcvar("ui_allow_thompson", "1");
			setcvar("ui_allow_sten", "1");
			setcvar("ui_allow_ppsh", "1");
		}
		else
		{
			//turn off SMG weapon select
			setcvar("ui_allow_thompson", "0");
			setcvar("ui_allow_sten", "0");
			setcvar("ui_allow_ppsh", "0");	
		}

		if(iaxisSMGCount < axisSMGLimit)
		{ 
			//turn on SMG weapon select
			setcvar("ui_allow_MP40", "1");
		}
		else
		{
			//turn off SMG weapon select
			setcvar("ui_allow_MP40", "0");	
		}
	}

	// Limit MGs
	if (isdefined(limitmgs))
	{
		if(ialliedMGCount < alliedMGLimit)
		{ 
			//turn on MG weapon select
			setcvar("ui_allow_bren", "1");
			setcvar("ui_allow_bar", "1");
		}
		else
		{
			//turn off MG weapon select
			setcvar("ui_allow_bren", "0");
			setcvar("ui_allow_bar", "0");
		}

		if(iaxisMGCount < axisMGLimit)
		{ 
			//turn on MG weapon select
			setcvar("ui_allow_MP44", "1");
		}
		else
		{
			//turn off MG weapon select
			setcvar("ui_allow_MP44", "0");
		}
	}

	// Limit DMGs
	if (isdefined(limitdmgs))
	{
		if(ialliedDMGCount < alliedDMGLimit)
		{ 
			//turn on DMG weapon select
			setcvar("ui_allow_dp28", "1");
			setcvar("ui_allow_mg30cal", "1");
		}
		else
		{
			//turn off DMG weapon select
			setcvar("ui_allow_dp28", "0");
			setcvar("ui_allow_mg30cal", "0");
		}

		if(iaxisDMGCount < axisDMGLimit)
		{ 
			//turn on DMG weapon select
			setcvar("ui_allow_mg34", "1");
		}
		else
		{
			//turn off DMG weapon select
			setcvar("ui_allow_mg34", "0");
		}
	}
}

NoDropWeapon()
{
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
	}

	if(!drop)
		self takeWeapon(self getcurrentweapon());
	
}
