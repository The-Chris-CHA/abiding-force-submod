--********************************************
--******  Campaign: Final Imperial Push  *****
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

		-- IR
		Trigger_IR_Player_Checker = State_IR_Player_Checker,
		Trigger_IR_Daala_Destroyed = State_IR_Daala_Destroyed,
		Trigger_IR_Rogriss_Destroyed = State_IR_Rogriss_Destroyed,

		-- NR
		Trigger_NR_Player_Checker = State_NR_Player_Checker,
		Trigger_NR_Daala_Destroyed = State_NR_Daala_Destroyed,
	}

	p_empire = Find_Player("Empire")
	p_newrep = Find_Player("Rebel")
	Safe_House_Planet = StoryUtil.GetSafePlanetTable()
end

function Delayed_Initialize_Lua(message)
	if message == OnEnter then
		crossplot:galactic()
		crossplot:publish("INITIALIZE_AI", "empty")
		crossplot:publish("NR_ADMIRAL_DECREMENT", 3, 1)
		crossplot:publish("NR_ADMIRAL_DECREMENT", 1, 3)
		crossplot:publish("NR_ADMIRAL_EXIT", {"Bell"}, 1)
		crossplot:publish("NR_ADMIRAL_EXIT", {"Ackbar"}, 1)
		
		crossplot:publish("NR_FILTER_REMOVE", {"Wedge_Rogues_Location_Set"}, 2)
		Clear_Fighter_Hero("WEDGE_ANTILLES_ROGUE_TEAM")
		Set_Fighter_Hero("TYCHO_CELCHU_ROGUE_TEAM", "BRAND_INDOMITABLE")
		crossplot:publish("NR_FILTER_ADD", {"Tycho_Rogues_Location_Set"}, 2)
		
		p_newrep.Lock_Tech(Find_Object_Type("WEDGE_LUSANKYA"))

		p_empire.Lock_Tech(Find_Object_Type("TURR_PHENNIR_TIE_INTERCEPTOR_LOCATION_SET"))
		Clear_Fighter_Hero("TURR_PHENNIR_TIE_INTERCEPTOR_181ST_SQUADRON")
		Set_Fighter_Hero("MAAREK_STELE_181ST_SQUADRON", "PELLAEON_GRAND_CHIMAERA")
		p_empire.Unlock_Tech(Find_Object_Type("MAAREK_STELE_181ST_LOCATION_SET"))
	else
		crossplot:update()
	end
end

-- Imperial Remnant

function State_IR_Player_Checker(message)
    if message == OnEnter then
		if p_empire.Is_Human() then
			StoryUtil.SpawnAtSafePlanet("BILBRINGI", p_newrep, Safe_House_Planet, {"Ackbar_Guardian"})

			p_empire.Unlock_Tech(Find_Object_Type("PellaeonUpgrade2"))
		
			Story_Event("IR_STORY_START")
			
			Sleep(4.0)
			gc_start = true
		end
    end
end

function State_IR_Daala_Destroyed(message)
	if message == OnEnter then
		Story_Event("IR_DAALA_DESTROYED")
	end
end

function State_IR_Rogriss_Destroyed(message)
	if message == OnEnter then
		Story_Event("IR_ROGRISS_DESTROYED")
	end
end

-- New Republic

function State_NR_Player_Checker(message)
    if message == OnEnter then
		if p_newrep.Is_Human() then
			StoryUtil.SpawnAtSafePlanet("AGAMAR", p_empire, Safe_House_Planet, {"Megador"})

			p_newrep.Unlock_Tech(Find_Object_Type("Ackbar_Guardian"))
			
			Story_Event("NR_STORY_START")
			
			Sleep(4.0)
			gc_start = true
			p_newrep.Lock_Tech(Find_Object_Type("Wedge_Lusankya"))
		end
    end
end

function State_NR_Daala_Destroyed(message)
	if message == OnEnter then
		Story_Event("NR_DAALA_DESTROYED")
	end
end