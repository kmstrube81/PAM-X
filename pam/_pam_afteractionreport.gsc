onConnected()
{
	self.round_report_array = [];
	self.round_report_myKill = undefined;

}

/*
Called when player has taken damage.
self is the player that took damage.
*/
onPlayerDamaged(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc)
{
	
	if(iDamage < 1) {
		iDamage = 1;
	}
	
	if (isDefined(eAttacker) && isPlayer(eAttacker) && eAttacker != self && level.roundstarted && !level.roundended)
	{
		updateIndex = -1;
		for (i = eAttacker.round_report_array.size-1; i >= 0; i--)
		{
			lastRecord = eAttacker.round_report_array[i];

			timeAgo = gettime() - lastRecord.rawtime;

			if (timeAgo > 5000) break; // look only for hits in last 5 sec

			// Find record with the same guy
			if (isDefined(lastRecord.enemy) && lastRecord.enemy == self)
			{
				// Grenade hits save as separated records
				if (lastRecord.sMeansOfDeath == "MOD_GRENADE_SPLASH")
					continue;

				updateIndex = i;
				break;
			}
		}

		// Update previus record
		if (updateIndex != -1)
		{
			eAttacker.round_report_array[updateIndex].hitLoc = sHitLoc;
			eAttacker.round_report_array[updateIndex].sMeansOfDeath = sMeansOfDeath;
			eAttacker.round_report_array[updateIndex].sWeapon = sWeapon;
			eAttacker.round_report_array[updateIndex].objectiveStatus = getObjectiveStatus();
			eAttacker.round_report_array[updateIndex].rawtime = gettime();
			if(eAttacker.round_report_array[updateIndex].objectiveStatus == "Bomb Planted")
			{
				eAttacker.round_report_array[updateIndex].time = "B " + formatTime((int)(level.countdowntime - (int)((eAttacker.round_report_array[updateIndex].rawtime - level.objectivetime)/1000));
			}
			else
			{
				eAttacker.round_report_array[updateIndex].time = (int)((level.roundlength * 60) - (int)((eAttacker.round_report_array[updateIndex].rawtime - level.roundresumetime)/1000));
			}

			// Hits that came in same time (shotgun) count together
			if (eAttacker.round_report_array[updateIndex].firstTime == gettime())
			{
				eAttacker.round_report_array[updateIndex].firstDamageValue += iDamage;
			}
			else
			{
				eAttacker.round_report_array[updateIndex].multipleDamage = true; // different time, it means its second shot
			}

		}
		// Add new record
		else
		{
			
			lastDamage = spawnstruct();
			lastDamage.enemy = self;
			lastDamage.hitLoc = sHitLoc;
			lastDamage.sMeansOfDeath = sMeansOfDeath;
			lastDamage.sWeapon = sWeapon;
			lastDamage.firstHitLoc = sHitLoc;
			lastDamage.sFirstMeansOfDeath = sMeansOfDeath;
			lastDamage.sFirstWeapon = sWeapon;
			lastDamage.firstDamageValue = iDamage;
			lastDamage.multipleDamage = false;
			lastDamage.wasKilled = false;
			lastDamage.teamkill = (self != eAttacker) && (self.pers["team"] == eAttacker.pers["team"]);
			lastDamage.objectiveStatus = getObjectiveStatus();
			lastDamage.rawtime = gettime();
			lastDamage.firstTime = gettime();
			if(lastDamage.objectiveStatus == "Bomb Planted")
			{
				lastDamage.time = "B " + formatTime((int)(level.countdowntime - (int)((lastDamage.rawtime - level.objectivetime)/1000));
			}
			else
			{
				lastDamage.time = (int)((level.roundlength * 60) - (int)((lastDamage.rawtime - level.roundresumetime)/1000));
			}

			eAttacker.round_report_array[eAttacker.round_report_array.size] = lastDamage;
		}
	}
}

onPlayerKilled(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc)
{
	if (isDefined(eAttacker) && isPlayer(eAttacker) && eAttacker != self && level.roundstarted && !level.roundended)
	{
		// Remove this player if was hited 5 sec before
		for (i = eAttacker.round_report_array.size-1; i >= 0; i--)
		{
			if (isDefined(eAttacker.round_report_array[i].enemy) && eAttacker.round_report_array[i].enemy == self && (eAttacker.round_report_array[i].time + 5000) > gettime())
			{
				// Set as kill
				eAttacker.round_report_array[i].wasKilled = true;
				eAttacker.round_report_array[i].sWeapon = sWeapon; // update also weapon, because its different when using MG
				break;
			}
		}
	}

	// If there was some hits/kills in this round, add also my death info
	if (self.round_report_array.size > 0)
	{
		myKill = spawnstruct();

		myKill.hitLoc = sHitLoc;
		myKill.sMeansOfDeath = sMeansOfDeath;
		myKill.sWeapon = sWeapon;
		myKill.rawtime = gettime();
		myKill.objectiveStatus = getObjectiveStatus();
		if(myKill.objectiveStatus == "Bomb Planted")
			{
				myKill.time = "B " + formatTime((int)(level.countdowntime - (int)((myKill.rawtime - level.objectivetime)/1000));
			}
			else
			{
				myKill.time = (int)((level.roundlength * 60) - (int)((myKill.rawtime - level.roundresumetime)/1000));
			}

		self.round_report_myKill = myKill;
	}
}

printToAll()
{
	if (!level.afteractionreport)
		return;

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
		players[i] thread print();
}

print()
{
	self endon("disconnect");
	
	//logprint(self.name + " print dmg ingress\n");

	hitLocTexts["head"] = "Head";
	hitLocTexts["neck"] = "Neck";

	hitLocTexts["torso_upper"] = "Torso Upper";
	hitLocTexts["torso_lower"] = "Torso Lower";

	hitLocTexts["left_arm_upper"] = "Shoulder";
	hitLocTexts["left_arm_lower"] = "Arm";
	hitLocTexts["left_hand"] = "Hand";

	hitLocTexts["right_arm_upper"] = "Shoulder";
	hitLocTexts["right_arm_lower"] = "Arm";
	hitLocTexts["right_hand"] = "Hand";

	hitLocTexts["left_leg_upper"] = "Leg";
	hitLocTexts["left_leg_lower"] = "Leg";
	hitLocTexts["left_foot"] = "Foot";

	hitLocTexts["right_leg_upper"] = "Leg";
	hitLocTexts["right_leg_lower"] = "Leg";
	hitLocTexts["right_foot"] = "Foot";

	wait 1 * 1;

	//self thread sendDebugInfo();


	if (self.round_report_array.size > 0)
	{
		self iprintln(" ");
		self iprintln(" ");
		self iprintln(" ");
		self iprintln(" ");
		self iprintln(" ");
		self iprintln(" ");
		self iprintln(" ");
		self iprintln(" ");
		self iprintln("PAM-X Round report:");
	}


	killNum = 1;
	for (i = 0; i < self.round_report_array.size; i++)
	{
		if (isDefined(self.round_report_array[i].enemy))
		{
			log = self.round_report_array[i];

			string = getObjectiveShort(log.objectiveStatus) + log.time + " ^9"; //getTimeString(log.time, log.objectiveStatus) + " ^9";

			if (log.wasKilled)
			{
				// Kill
				if (log.teamkill)
					string += "^1team kill " + killNum + "^9";
				else
					string += "^2kill " + killNum + "^9";
				killNum++;

				if (log.multipleDamage == false)
				{
					damage = (int)log.firstDamageValue; // damage = int(log.firstDamageValue);
					if (damage == 0) damage = 1;
					string += " " + damage + "hp";
				}

				// To
				/*if (log.sWeapon == "shotgun_mp" && log.sMeansOfDeath == "MOD_PISTOL_BULLET")
				{
					string += " with " + log.pellets + " pellet";
					if (log.pellets > 1) string += "s";
				}
				else
				{
					if (isDefined(hitLocTexts[log.hitLoc]))
						string += " to " + hitLocTexts[log.hitLoc];
					else if (log.hitLoc != "none")
						string += " to " + log.hitLoc;
				}*/
				
				if (isDefined(hitLocTexts[log.hitLoc]))
					string += " to " + hitLocTexts[log.hitLoc];
				else if (log.hitLoc != "none")
					string += " to " + log.hitLoc;

				// [Weapon]
				weapon = getWeapon(log.sMeansOfDeath, log.sWeapon);
				if (weapon != "")
					string += " ("+weapon+")";

				// Separate hit part in case of multiple damage
				if (log.multipleDamage)
					string += ", first ";
			}

			// Mutiple hit (damage+damage; damage+kill) | single damage without kill
			if (log.multipleDamage || (!log.multipleDamage && !log.wasKilled))
			{
				if (log.teamkill)
					string += "^1team^9 ";
				string += "hit";

				damage = (int)log.firstDamageValue;
				if (damage == 0) damage = 1;
				string += " " + damage + "hp";

				/*
				if (log.sFirstWeapon == "shotgun_mp" && log.sFirstMeansOfDeath == "MOD_PISTOL_BULLET")
				{
					string += " " + log.pellets + " pellet";
					if (log.pellets > 1) string += "s";

					if (log.shotgun_distance > 0)
					{
						string += " " + (((log.shotgun_distance) / 10) / 10) + "m";
					}

					if (log.adjustedBy == "consistent_shotgun_1_kill" || log.adjustedBy == "consistent_shotgun_1_hit")
						string += " range-1";
					else if (log.adjustedBy == "consistent_shotgun_2")
						string += " range-2";
					else if (log.adjustedBy == "consistent_shotgun_3")
						string += " range-3";
					else if (log.adjustedBy == "consistent_shotgun_4")
						string += " range-4";
				}
				*/

				if (log.sFirstWeapon != "shotgun_mp")
				{
					if (isDefined(hitLocTexts[log.firstHitLoc]))
						string += " to " + hitLocTexts[log.firstHitLoc];
					else if (log.firstHitLoc != "none")
						string += " to " + log.firstHitLoc;
				}

				// Show weapon if only hit is showed or weapons are different
				if (!log.wasKilled || log.sWeapon != log.sFirstWeapon)
				{
					weapon = getWeapon(log.sFirstMeansOfDeath, log.sFirstWeapon);
					if (weapon != "")
						string += " ("+weapon+")";
				}

			}

			/*
			// Hit was adjusted by fixes
			if (log.adjustedBy == "hand_hitbox_fix" || log.adjustedBy == "torso_hitbox_fix")
			{
				string += " ^1*";
			}
			*/


			string += " ^7" + log.objectiveStatus;

			self iprintln("" + string);
		}
	}

	if (self.round_report_array.size > 0 && isDefined(self.round_report_myKill))
	{
		string = getObjectiveShort(self.round_report_myKill.objectiveStatus) + log.time +  "^1killed"; //getTimeString(self.round_report_myKill.time, self.round_report_myKill.objectiveStatus) + " ^1killed";

		if (isDefined(hitLocTexts[self.round_report_myKill.hitLoc]))
			string += " to " + hitLocTexts[self.round_report_myKill.hitLoc];
		else if (self.round_report_myKill.hitLoc != "none")
			string += " to " + self.round_report_myKill.hitLoc;

		weapon = getWeapon(self.round_report_myKill.sMeansOfDeath, self.round_report_myKill.sWeapon);
		if (weapon != "")
			string += " via "+weapon+"";

		string += " ^7" + self.round_report_myKill.objectiveStatus;
		self iprintln("" + string);
	}

	//logprint(self.name + " print dmg egress\n");
}

getObjectiveStatus()
{
	switch(level.objective)
	{
		case "bomb":
			if(level.bombsites["A"]["planted"] || level.bombsites["B"]["planted"])
				return "Bomb Planted";
			break;
		case "radio":
			if(self.pers["team"] == level.defenseTeam)
				return "HQ Defense";
			else if(level.defenseTeam != "none")
				return "HQ Capture";
			else
				return "HQ Destroy";
			break;
		default:
			return "";
	}
}

getObjectiveShort(objective)
{
	switch(objective)
	{
		case "Bomb Planted":
			return "B";
		default:
			return "";
	}
}

/*
getTimeString(time, objectiveStatus)
{
	switch(objectiveStatus)
	{
		case "Bomb Planted":
			return "B " + formatTime((int)(level.countdowntime - (int)((time - level.bombtimerstart)/1000)));
		default:
			return formatTime((int)((level.roundlength * 60) - (int)((time - level.roundstarttime)/1000)));
	}
	//if (objectiveStatus)
	//	return "B " + formatTime((int)(level.countdowntime - (int)((time - level.bombtimerstart)/1000)));
	//else
	//return formatTime((int)((level.roundlength * 60) - (int)((time - level.roundstarttime)/1000)));
		//return formatTime(level.z_rpam_strat_time + (int)((level.roundlength * 60) - (int)((time - level.starttime)/1000)));
		//return formatTime(level.strat_time + ((level.roundlength * 60) - ((time - level.starttime)/1000)));
}
*/
// Prints second in format 00:00:00 (hours are printed only if > 0)
formatTime(timeSec, separator)
{
	if (!isDefined(separator)) separator = ":";
	_timeSec = (int)timeSec; // to avoid unmatching types 'float' and 'int'
	str = "";
	min = (int)(_timeSec / 60);
	hour = (int)(min / 60);
	sec = _timeSec % 60;
	if (hour > 0)
	{
		if (hour < 10) hour = "0" + hour;
		min = min % 60;
		str += hour + separator;
	}
	if (min < 10) min = "0" + min;
	if (sec < 10) sec = "0" + sec;

	str += min + separator;
	str += sec;

	return str;
}

getWeapon(sMeansOfDeath, sWeapon)
{
	if (sMeansOfDeath == "MOD_MELEE")
		return "Bash";
	if (sMeansOfDeath == "MOD_GRENADE_SPLASH")
		return "Grenade";

	weaponsTexts["m1carbine_mp"] = "M1 Carbine";
	weaponsTexts["m1garand_mp"] = "M1 Garand";
	weaponsTexts["thompson_mp"] = "Thompson";
	weaponsTexts["bar_mp"] = "Bar";
	weaponsTexts["springfield_mp"] = "Springfield";
	weaponsTexts["enfield_mp"] = "Enfield";
	weaponsTexts["sten_mp"] = "Sten";
	weaponsTexts["bren_mp"] = "Bren";
	weaponsTexts["mosin_nagant_mp"] = "Mosin Nagant";
	weaponsTexts["SVT40_mp"] = "SVT40";
	weaponsTexts["ppsh_mp"] = "PPSH";
	weaponsTexts["mosin_nagant_sniper_mp"] = "Mosin Nagant Scoped";
	weaponsTexts["kar98k_mp"] = "Kar98k";
	weaponsTexts["g43_mp"] = "Gewehr";
	weaponsTexts["mp40_mp"] = "MP40";
	weaponsTexts["mp44_mp"] = "MP44";
	weaponsTexts["kar98k_sniper_mp"] = "Kar98k Scoped";
	weaponsTexts["colt_mp"] = "Pistol";
	weaponsTexts["webley_mp"] = "Pistol";
	weaponsTexts["luger_mp"] = "Pistol";
	weaponsTexts["TT30_mp"] = "Pistol";
	weaponsTexts["mg42_bipod_stand_mp"] = "MG";
	weaponsTexts["30cal_stand_mp"] = "MG";

	if (isDefined(weaponsTexts[sWeapon]))
		return weaponsTexts[sWeapon];
	return "";
}
