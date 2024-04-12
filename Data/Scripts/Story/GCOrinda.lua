--********************************************
--******  Campaign: Orinda Campaign  *********
--********************************************

require("PGBase")
require("PGStoryMode")
require("PGSpawnUnits")
require("PGStateMachine")
require("SetFighterResearch")
require("eawx-util/ChangeOwnerUtilities")
require("deepcore/std/class")
StoryUtil = require("eawx-util/StoryUtil")
UnitUtil = require("eawx-util/UnitUtil")
require("deepcore/crossplot/crossplot")

function Definitions()
	DebugMessage("%s -- In Definitions", tostring(Script))

	StoryModeEvents = {
		-- Generic
		Delayed_Initialize = Delayed_Initialize_Lua,
		Trigger_Orinda_Campaign_Adumar = State_Orinda_Campaign_Adumar,

		-- IR
		Trigger_IR_Player_Checker = State_IR_Player_Checker,
		Trigger_IR_Orinda_Campaign_SSD_Arrival = State_IR_Orinda_Campaign_SSD_Arrival,

		-- NR
		Trigger_NR_Player_Checker = State_NR_Player_Checker,
		Trigger_NR_Orinda_Campaign_Lusankya = State_NR_Orinda_Campaign_Lusankya,
		Trigger_NR_Areta_Bell_Destroyed = State_NR_Areta_Bell_Destroyed,
	}

	p_newrep = Find_Player("Rebel")
	p_empire = Find_Player("Empire")
end

-- Generic

function Delayed_Initialize_Lua(message)
	if message == OnEnter then
		crossplot:galactic()
		crossplot:publish("INITIALIZE_AI", "empty")
		crossplot:publish("NR_ADMIRAL_DECREMENT", 4, 1)
		crossplot:publish("NR_ADMIRAL_DECREMENT", 1, 3)
		crossplot:publish("NR_ADMIRAL_LOCKIN", {"Bell"}, 1)

		Set_Fighter_Hero("TYCHO_CELCHU_ROGUE_TEAM", "WEDGE_LUSANKYA")
		
		Clear_Fighter_Hero("WEDGE_ANTILLES_ROGUE_TEAM")

		p_empire.Lock_Tech(Find_Object_Type("TURR_PHENNIR_TIE_INTERCEPTOR_LOCATION_SET"))
        Upgrade_Fighter_Hero("TURR_PHENNIR_TIE_INTERCEPTOR_181ST_SQUADRON","TURR_PHENNIR_TIE_DEFENDER_181ST_SQUADRON")
        Set_To_First_Extant_Host("TURR_PHENNIR_TIE_DEFENDER_LOCATION_SET", p_empire, true)
		p_empire.Unlock_Tech(Find_Object_Type("TURR_PHENNIR_TIE_DEFENDER_LOCATION_SET"))
	else
		crossplot:update()
	end
end

function State_Orinda_Campaign_Adumar(message)
	if message == OnEnter then
		if p_empire.Is_Human() then
			Story_Event("IR_ADUMAR_UNLOCKED")
		else
			Story_Event("NR_ADUMAR_UNLOCKED")
		end
		
		StoryUtil.SetPlanetRestricted("ADUMAR", 0)
	end
end

-- Imperial Remnant

function State_IR_Player_Checker(message)
    if message == OnEnter then
		crossplot:galactic()
		if p_empire.Is_Human() then
			local Safe_House_Planet = StoryUtil.GetSafePlanetTable()
			StoryUtil.SpawnAtSafePlanet("BILBRINGI", p_newrep, Safe_House_Planet, {"Wedge_Lusankya"})
			crossplot:publish("NR_FILTER_ADD", {"Tycho_Rogues_Location_Set"}, 2)

			Story_Event("IR_STORY_START")

			StoryUtil.SetPlanetRestricted("ADUMAR", 1)

			Sleep(4.0)
			gc_start = true
		end
	else
		crossplot:update()
    end
end

function State_IR_Orinda_Campaign_SSD_Arrival(message)
	if message == OnEnter then
		local Safe_House_Planet = StoryUtil.GetSafePlanetTable()
		StoryUtil.SpawnAtSafePlanet("YAGA_MINOR", p_empire, Safe_House_Planet, {"Rogriss_Dominion"})
		StoryUtil.SpawnAtSafePlanet("AGAMAR", p_empire, Safe_House_Planet, {"Megador"})

		Story_Event("IR_ROGRISS_JOINS")
	end
end

-- New Republic

function State_NR_Player_Checker(message)
    if message == OnEnter then
		if p_newrep.Is_Human() then
			local Safe_House_Planet = StoryUtil.GetSafePlanetTable()
			StoryUtil.SpawnAtSafePlanet("YAGA_MINOR", p_empire, Safe_House_Planet, {"Rogriss_Dominion"})
			StoryUtil.SpawnAtSafePlanet("AGAMAR", p_empire, Safe_House_Planet, {"Megador"})

			Story_Event("NR_STORY_START")

			StoryUtil.SetPlanetRestricted("ADUMAR", 1)

			Sleep(4.0)
			gc_start = true
		end
    end
end

function State_NR_Orinda_Campaign_Lusankya(message)
	if message == OnEnter then
		crossplot:galactic()
		local Safe_House_Planet = StoryUtil.GetSafePlanetTable()
		StoryUtil.SpawnAtSafePlanet("BILBRINGI", p_newrep, Safe_House_Planet, {"Wedge_Lusankya"})
		crossplot:publish("NR_FILTER_ADD", {"Tycho_Rogues_Location_Set"}, 2)

		Story_Event("NR_WEDGE_JOINS")
	else
		crossplot:update()
	end
end

function State_NR_Areta_Bell_Destroyed(message)
	if message == OnEnter then
		Story_Event("NR_BELL_DESTROYED")
	end
end
