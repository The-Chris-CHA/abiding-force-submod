--//////////////////////////////////////////////////////////////////////////////////////
-- Add Units to the reinforcement pool// This script is part of the Survival Mode
-- � Pox
--//////////////////////////////////////////////////////////////////////////////////////

require("IA_Spawn_Generic")

function Definitions()
	
	DebugMessage("%s -- In Definitions", tostring(Script))

	-- possible units to spawn
	unit_table = {
	"GOZANTI_CRUISER_SQUADRON",
	"CITADEL_CRUISER_SQUADRON",
	"ETTI_LIGHTER",
	"CC7700",
	"MARAUDER_CRUISER",
	"MARAUDER_MISSILE_CRUISER",
	"DREADNAUGHT_CARRIER",
	"RECUSANT",
	"INVINCIBLE_CRUISER",
	"BULWARK_III",
	"BULWARK_II",
	"BULWARK_I",
	"LUCREHULK_CSA",
	"MTC_COMBAT",
	"CAPTOR",
	"LUCREHULK_CORE_DESTROYER",
	"GENERIC_PROVIDENCE",
	"GENERIC_TAGGE_BATTLECRUISER_CSA",
	"GENERIC_MANDATOR_II"
	}

	Define_State("State_Init", State_Init);


end


function State_Init(message)
	if message == OnEnter then
		IA_Spawn(Object.Get_Type().Get_Name(), "INSTANTACTION_MARKER_CSA", "Corporate_Sector", unit_table)
		ScriptExit()
		
	end
end