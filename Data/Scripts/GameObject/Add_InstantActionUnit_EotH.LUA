--//////////////////////////////////////////////////////////////////////////////////////
-- Add Units to the reinforcement pool// This script is part of the Survival Mode
-- � Pox
--//////////////////////////////////////////////////////////////////////////////////////

require("IA_Spawn_Generic")

function Definitions()
	
	DebugMessage("%s -- In Definitions", tostring(Script))

	-- possible units to spawn
	unit_table = {
	"MUQARAEA",
	"SYZYGOS",
	"FRUORO",
	"ORMOS",
	"ROHKEA",
	"KUURO",
	"BAOMU",
	"KYNIGOS",
	"PROLIPSI",
	"CHAF_DESTROYER",
	"PHALANX_DESTROYER",
	"INTEGO_DESTROYER",
	"SYNDIC_DESTROYER",
	"CHISS_STAR_DESTROYER",
	"PELTAST",
	"EFODIO_FLEET_TENDER",
	}

	Define_State("State_Init", State_Init);


end

function State_Init(message)
	if message == OnEnter then
		IA_Spawn(Object.Get_Type().Get_Name(), "INSTANTACTION_MARKER_EOTH", "EmpireoftheHand", unit_table)
		ScriptExit()
		
	end
end