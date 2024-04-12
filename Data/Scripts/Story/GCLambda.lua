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
--*   @Author:              Corey
--*   @Date:                2017-11-24T12:43:51+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            GCLambda.lua
--*   @Last modified by:
--*   @Last modified time:  2018-02-03T12:22:17-05:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



require("PGBase")
require("PGStateMachine")
require("PGStoryMode")
require("PGSpawnUnits")
require("eawx-util/ChangeOwnerUtilities")
StoryUtil = require("eawx-util/StoryUtil")
require("deepcore/crossplot/crossplot")
require("SetFighterResearch")

function Definitions()

  DebugMessage("%s -- In Definitions", tostring(Script))
  
  crossplot:galactic()
  crossplot:subscribe("JENN_SMEEL_DEATH", Storm_Sad)

  StoryModeEvents =
    {
	  Determine_Faction_LUA = Find_Faction,
	  Delayed_Initialize = Initialize,
	  Nantz_B_Here = Tyrs_Flame,
	  Got_Storm_Commando_Debounce = Storm_Glad
    }

	Panaka = nil
	Lose_Storms = true
end

function Find_Faction(message)
  if message == OnEnter then

    local p_newrep = Find_Player("Rebel")
    local p_empire = Find_Player("Empire")
	local p_eriadu = Find_Player("Eriadu_Authority")
	local p_csa = Find_Player("Corporate_Sector")
	local p_hutts = Find_Player("Hutt_Cartels")
	local p_kamino = Find_Player("Zsinj_Empire")
	
	credits = p_empire.Get_Credits()
	p_newrep.Give_Money(8000-credits)
	p_empire.Give_Money(8000-credits)
	p_eriadu.Give_Money(8000-credits)
	p_csa.Give_Money(20000-credits)
	p_hutts.Give_Money(8000-credits)
	p_hutts.Give_Money(8000-credits)
	
	Set_Fighter_Hero("JAG_127TH_SQUADRON", "TOULER_KORASA_MAZE")
   
	Panaka = FindPlanet("Naboo").Get_Owner()
	if Panaka == p_empire then
		local tech_unit = Find_Object_Type("IMPERIAL_STORM_COMMANDO_SQUAD")
		p_empire.Unlock_Tech(tech_unit)
	else
		local tech_unit = Find_Object_Type("IMPERIAL_COMPFORCE_ASSAULT_SQUAD")
		p_empire.Unlock_Tech(tech_unit)
		tech_unit = Find_Object_Type("IMPERIAL_ISB_INFILTRATOR_SQUAD")
		p_empire.Unlock_Tech(tech_unit)
		tech_unit = Find_Object_Type("IMPERIAL_STORMTROOPER_SQUAD")
		p_empire.Lock_Tech(tech_unit)
	end
	
	local tech_unit = Find_Object_Type("KAMINO_MOFFPALACE")
	p_kamino.Unlock_Tech(tech_unit)
	tech_unit = Find_Object_Type("KAMINO_CAPITAL")
	p_kamino.Unlock_Tech(tech_unit)
	tech_unit = Find_Object_Type("IMPERIAL_STORMTROOPER_SQUAD")
	p_kamino.Unlock_Tech(tech_unit)
	tech_unit = Find_Object_Type("IMPERIAL_INCINERATOR_STORMTROOPER_SQUAD")
	p_kamino.Unlock_Tech(tech_unit)
	tech_unit = Find_Object_Type("IMPERIAL_MODIFIED_LAAT_GROUP")
	p_kamino.Unlock_Tech(tech_unit)
	--tech_unit = Find_Object_Type("IMPERIAL_JUMPTROOPER_SQUAD")
	--p_kamino.Unlock_Tech(tech_unit)
	tech_unit = Find_Object_Type("ZSINJ_MOFFPALACE")
	p_kamino.Lock_Tech(tech_unit)
	tech_unit = Find_Object_Type("RANCOR_BASE")
	p_kamino.Lock_Tech(tech_unit)
	tech_unit = Find_Object_Type("ZSINJ_RAPTOR_SQUAD")
	p_kamino.Lock_Tech(tech_unit)
	tech_unit = Find_Object_Type("ZSINJ_74Z_BIKE_COMPANY")
	p_kamino.Lock_Tech(tech_unit)
	tech_unit = Find_Object_Type("IMPERIAL_IDT_GROUP")
	p_kamino.Lock_Tech(tech_unit)
	tech_unit = Find_Object_Type("PIRATE_BASE")
	p_kamino.Lock_Tech(tech_unit)
	tech_unit = Find_Object_Type("TETRAN_COWALL_LOCATION_SET")
	p_kamino.Lock_Tech(tech_unit)

    if p_newrep.Is_Human() then
      Story_Event("ENABLE_BRANCH_NEWREP_FLAG")
    elseif p_empire.Is_Human() then
		if Panaka.Is_Human() then
			Story_Event("ENABLE_BRANCH_NABOO_FLAG")
		else
			Story_Event("ENABLE_BRANCH_EMPIRE_FLAG")
		end
	elseif p_eriadu.Is_Human() then
      Story_Event("ENABLE_BRANCH_ERIADU_FLAG")
	elseif p_csa.Is_Human() then
      Story_Event("ENABLE_BRANCH_CSA_FLAG")
	elseif p_hutts.Is_Human() then
      Story_Event("ENABLE_BRANCH_HUTT_FLAG")
	elseif p_kamino.Is_Human() then
      Story_Event("ENABLE_BRANCH_KAMINO_FLAG")
    end
  end
end

function Initialize(message)
    if message == OnEnter then
		crossplot:publish("INITIALIZE_AI", "empty")
		crossplot:publish("NR_ADMIRAL_DECREMENT", 2, 1)
		crossplot:publish("NR_ADMIRAL_DECREMENT", 1, 2)
		crossplot:publish("NR_ADMIRAL_DECREMENT", 2, 3)

		crossplot:publish("NR_FILTER_REMOVE", {"Wedge_Rogues_Location_Set", "SalmY_Location_Set"}, 2)
		Clear_Fighter_Hero("WEDGE_ANTILLES_ROGUE_TEAM")
		Clear_Fighter_Hero("SALM_Y-WING_SQUADRON")

		--Cut heroes known to be elsewhere to play up the theme of the NR being busy elsewhere and not really trying here
		crossplot:publish("NR_ADMIRAL_STORYLOCK", {"Ackbar","Nantz","Sovv","Drayson","Ragab","Kalback","Burke"}, 1)
		crossplot:publish("NR_ADMIRAL_STORYLOCK", {"Calrissian", "Kryll","Cracken","Taskeen","Tantor","Veertag","Tulon"}, 2)
		crossplot:publish("NR_ADMIRAL_LOCKIN", {"Garret"}, 2)
	else
		crossplot:update()
    end
end

function Tyrs_Flame(message)
    if message == OnEnter then
		crossplot:publish("NR_ADMIRAL_RETURN", {"Nantz"}, 1)
		crossplot:publish("NR_ADMIRAL_RETURN", {"Taskeen"}, 2)
		
		local p_newrep = Find_Player("Rebel")
		if p_newrep.Is_Human() then
			StoryUtil.Multimedia("TEXT_CONQUEST_LAMBDASECTOR_NR_NANTZ", 20, nil, "Leia_Loop", 0)
		end
	else
		crossplot:update()
    end
end

function Storm_Sad()
		local p_empire = Find_Player("Empire")
		if Lose_Storms and Panaka == p_empire then
			local tech_unit = Find_Object_Type("IMPERIAL_STORM_COMMANDO_SQUAD")
			p_empire.Lock_Tech(tech_unit)
			if p_empire.Is_Human() then
				StoryUtil.Multimedia("TEXT_CONQUEST_LAMBDASECTOR_NABOO_SMEEL", 20, nil, "Panaka_Loop", 0)
			end
		end
end

function Storm_Glad(message)
    if message == OnEnter then
		local p_empire = Find_Player("Empire")
		Weir = Find_First_Object("Weir").Get_Owner()
		if Weir == p_empire then
			Lose_Storms = false
		end
	else
		crossplot:update()
    end
end