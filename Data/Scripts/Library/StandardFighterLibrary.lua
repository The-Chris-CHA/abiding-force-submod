--******************************************************************************
--     _______ __
--    |_     _|  |--.----.---.-.--.--.--.-----.-----.
--      |   | |     |   _|  _  |  |  |  |     |__ --|
--      |___| |__|__|__| |___._|________|__|__|_____|
--     ______
--    |   __ \.-----.--.--.-----.-----.-----.-----.
--    |      <|  -__|  |  |  -__|     |  _  |  -__|
--    |___|__||_____|\___/|_____|__|__|___  |_____|
--                                    |_____|
--*   @Author:              [TR]Jorritkarwehr
--*   @Date:                2021-03-20T01:27:01+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            StandardFighterLibrary.lua
--*   @Last modified by:    [TR]Jorritkarwehr
--*   @Last modified time:  2021-03-26T09:58:14+02:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************

require("SetFighterResearch")

function Get_Standard_Entry(fighterType, player, era, region, influence)
	local gameConstants = ModContentLoader.get("GameConstants")
    local alias = gameConstants.ALIASES[player]
	
	if fighterType == "STANDARD_GARRISON_FIGHTER" then
		Universal_Regional_Table = {
			[5] = "HLAF_SQUADRON",
			[7] = "RIHKXYRK_SQUADRON",
			[8] = "TRIFOIL_SQUADRON",
			[9] = "MIYTIL_FIGHTER_SQUADRON",
			[11] = "STARVIPER_SQUADRON",
			[12] = "MANKVIM_SQUADRON",
			[14] = "CHIRDAKI_SQUADRON",			
			[15] = "IRDA_SQUADRON",
			[18] = "N1_SQUADRON",
			[20] = "STARWING_SQUADRON",
			[21] = "AGGRESSOR_ASSAULT_FIGHTER_SQUADRON",
			[22] = "T-WING_SQUADRON",
		}
		if Universal_Regional_Table[region] then
			return Universal_Regional_Table[region]
		end
		if region == 1 then
			if influence >= 8 then
				return "V38_SQUADRON"
			else
				return "SHIELDED_INTERCEPTOR_SQUADRON"
			end
		elseif region == 2 then
			if era >= 4 then
				return "A9_SQUADRON"
			else
				return "V-WING_SQUADRON"
			end
		elseif region == 4 then
			if influence >= 8 then
				return "ARC_170_SQUADRON"
			else
				return "Z95_HEADHUNTER_SQUADRON"
			end
		elseif region == 6 then
			if influence >= 9 then
				return "PREYBIRD_SQUADRON"
			else
				return "DREXL_SQUADRON"
			end
		elseif region == 10 and alias == "IMPERIAL" then
			return "TIE_RAPTOR_SQUADRON"
		elseif region == 23 and alias == "IMPERIAL" then
			return "SUPER_TIE_SQUADRON"
		end
		--Default load if no regional pick was made
		if player == "REBEL" then
			if era > 4 then
				return "E-WING_SQUADRON"
			else
				return "REBEL_X-WING_SQUADRON"
			end
		elseif player == "CORPORATE_SECTOR" then
			return "T-WING_SQUADRON"
		elseif player == "ZSINJ_EMPIRE" then
			return "Z95_HEADHUNTER_SQUADRON"
		else
			return "TIE_INTERCEPTOR_SQUADRON"
		end
	elseif fighterType == "STANDARD_CIVILIAN_FIGHTER" then
		local civvies = {"R22_SPEARHEAD_SQUADRON", "ATL_INTERCEPTOR_SQUADRON", "Z95_HEADHUNTER_SQUADRON", "CLOAKSHAPE_SQUADRON", "CLOAKSHAPE_STOCK_SQUADRON", "SHIELDED_TIE_SQUADRON", "TIE_LIGHT_DUTY_SQUADRON", "HOWLRUNNER_SQUADRON", "TIE_FIGHTER_SQUADRON", "TIE_STARFIGHTER_SQUADRON", "MANKVIM_SQUADRON", "V-WING_SQUADRON"}
		if player == "REBEL" then
			table.insert(civvies, "DEFENDER_STARFIGHTER_SQUADRON")
		else
			table.insert(civvies, "CLUTCH_SQUADRON")	
		end
		return civvies[GameRandom(1, table.getn(civvies))]
	elseif fighterType == "STANDARD_PIRATE_FIGHTER" then
		local civvies = {"PREYBIRD_SQUADRON", "ARC_170_SQUADRON", "RIHKXYRK_SQUADRON", "AGGRESSOR_ASSAULT_FIGHTER_SQUADRON", "STARVIPER_SQUADRON", "N1_SQUADRON", "T-WING_SQUADRON", "CLOAKSHAPE_NEW_SQUADRON", "I_BEAM_SQUADRON", "DREXL_SQUADRON", "STARVIPER_II_SQUADRON"}
		return civvies[GameRandom(1, table.getn(civvies))]
	elseif fighterType == "STANDARD_CIVILIAN_BOMBER" then
		local civvies = {"BTLB_Y-WING_SQUADRON", "BTLS1_Y-WING_SQUADRON", "Y-WING_SQUADRON", "2_WARPOD_SQUADRON", "H60_Tempest_SQUADRON", "STARWING_SQUADRON", "GENERIC_Z95_BOMBER_SQUADRON"}
		return civvies[GameRandom(1, table.getn(civvies))]
	end
	
	return fighterType
end