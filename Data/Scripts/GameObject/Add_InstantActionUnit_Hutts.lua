--//////////////////////////////////////////////////////////////////////////////////////
-- Add Units to the reinforcement pool// This script is part of the Survival Mode
-- � Pox
--//////////////////////////////////////////////////////////////////////////////////////

require("IA_Spawn_Generic")

function Definitions()
	
	DebugMessage("%s -- In Definitions", tostring(Script))

	-- possible units to spawn
	unit_table = {
		"WARLORD_CRUISER",
		"HEAVY_MINSTREL_YACHT",
		"RAKA_FREIGHTER_TENDER",
		"UBRIKKIAN_FRIGATE",
		"KALOTH_BATTLECRUISER",
		"JUVARD_FRIGATE",
		"BARABBULA_FRIGATE",
		"KOSSAK_FRIGATE",
		"TARRADA_FRIGATE",
		"UBRIKKIAN_CRUISER_GCW",
		"TEMPEST_CRUISER",
		"BATIL_CARRIER",
		"SZAJIN_CRUISER",
		"KARAGGA_DESTROYER",
		"CHELANDION_CRUISER",
		"VONTOR_DESTROYER",
		"VORACIOUS_CARRIER",
		"KARABOS_DESTROYER",
		"DORBULLA_WARSHIP",
		"DARKSABER"
	}

	Define_State("State_Init", State_Init);


end


function State_Init(message)
	if message == OnEnter then
		IA_Spawn(Object.Get_Type().Get_Name(), "INSTANTACTION_MARKER_HUTTS", "Hutt_Cartels", unit_table)
		ScriptExit()
		
	end
end