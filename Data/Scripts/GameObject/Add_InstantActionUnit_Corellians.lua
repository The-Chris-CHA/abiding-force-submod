--//////////////////////////////////////////////////////////////////////////////////////
-- Add Units to the reinforcement pool// This script is part of the Survival Mode
-- � Pox
--//////////////////////////////////////////////////////////////////////////////////////

require("IA_Spawn_Generic")

function Definitions()
	
	DebugMessage("%s -- In Definitions", tostring(Script))

	-- possible units to spawn
	unit_table = {
		"CEC_LIGHT_CRUISER",
		"STARBOLT",
		"PROFICIENT_TENDER",
		"PROFICIENT",
		-- "STRIDENT",
		"WURRIF_CRUISER",
		"LWHEKK_MANUFACTURING_SHIP",
		"SHREE_CRUISER"
	}

	Define_State("State_Init", State_Init);


end


function State_Init(message)
	if message == OnEnter then
		IA_Spawn(Object.Get_Type().Get_Name(), "INSTANTACTION_MARKER_CORELLIANS", "Empire", unit_table)
		ScriptExit()
		
	end
end