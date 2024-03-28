--//////////////////////////////////////////////////////////////////////////////////////
-- Add Units to the reinforcement pool// This script is part of the Survival Mode
-- � Pox
--//////////////////////////////////////////////////////////////////////////////////////

require("IA_Spawn_Generic")

function Definitions()
	
	DebugMessage("%s -- In Definitions", tostring(Script))

	-- possible units to spawn
	unit_table = {
        "HEAVY_MINSTREL_YACHT",
        "UBRIKKIAN_FRIGATE",
        "KALOTH_BATTLECRUISER",
        "JUVARD_FRIGATE",
        "BARABBULA_FRIGATE",
        "KOSSAK_FRIGATE",
		"STARBOLT",
		"PROFICIENT_TENDER",
		"PROFICIENT",
		"WURRIF_CRUISER",
		"LWHEKK_MANUFACTURING_SHIP",
		"SHREE_CRUISER"
	}

	Define_State("State_Init", State_Init);


end


function State_Init(message)
	if message == OnEnter then
		IA_Spawn(Object.Get_Type().Get_Name(), "INSTANTACTION_MARKER_HUTTS", "Empire", unit_table)
		ScriptExit()
		
	end
end