--//////////////////////////////////////////////////////////////////////////////////////
-- Add Units to the reinforcement pool// This script is part of the Survival Mode
-- � Pox
--//////////////////////////////////////////////////////////////////////////////////////

require("IA_Spawn_Generic")

function Definitions()
	
	DebugMessage("%s -- In Definitions", tostring(Script))

	-- possible units to spawn
	unit_table = {
		"RAPTOR_GUNSHIP_SQUADRON",
		"BAIDAM",
		"FLARE",
		"BETA_CRUISER",
		"NOVA_CRUISER_REFIT",
		"NOVA_CRUISER",
		"STELLA",
		"CHARUBAH_FRIGATE",
		"OLANJI_FRIGATE",
		"MAGNETAR",
		"PULSAR",
		"BATTLEDRAGON",
		"CORONAL",
		"TEREPHON_CRUISER",
		"MIST_CARRIER",
		"NEUTRON_CRUISER",
		"STAR_HOME"
	}

	Define_State("State_Init", State_Init);


end


function State_Init(message)
	if message == OnEnter then
		IA_Spawn(Object.Get_Type().Get_Name(), "INSTANTACTION_MARKER_HAPANS", "Hapes_Consortium", unit_table)
		ScriptExit()
		
	end
end