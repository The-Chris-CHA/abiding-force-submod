--//////////////////////////////////////////////////////////////////////////////////////
-- Add Units to the reinforcement pool// This script is part of the Survival Mode
-- � Pox
--//////////////////////////////////////////////////////////////////////////////////////

require("IA_Spawn_Generic")

function Definitions()
	
	DebugMessage("%s -- In Definitions", tostring(Script))

	-- possible units to spawn
	unit_table = {
	"CORELLIAN_CORVETTE",
	"CORELLIAN_GUNBOAT",
	"SACHEEN",
	"ENDURANCE",
	"NEBULA",
	"DAUNTLESS",
	"HOME_ONE_TYPE",
	"MAJESTIC",
	"DEFENDER_CARRIER",
	"MC80B",
	"MC90",
	"CORONA",
	"MC30C",
	"MC40A",
	"QUASAR",
	"NEBULON_B_FRIGATE",
	"CALAMARI_CRUISER",
	"ALLIANCE_ASSAULT_FRIGATE_II",
	"ALLIANCE_ASSAULT_FRIGATE",
	"BAC",
	"MINI_VISCOUNT",
	"VISCOUNT",
	"CC7700_E",
	"MEDIATOR",
	"BLUEDIVER",
	"NEBULON_B_TENDER",
	"HAJEN",
	"MC30A",
	"REPUBLIC_SD",
	"MOTHMA_STAR_DESTROYER",
	"AGAVE_CORVETTE",
	"WARRIOR_GUNSHIP",
	"BELARUS",
	"LIBERATOR_CRUISER"
	}

	Define_State("State_Init", State_Init);


end


function State_Init(message)
	if message == OnEnter then
		IA_Spawn(Object.Get_Type().Get_Name(), "INSTANTACTION_MARKER_NEWREP", "Rebel", unit_table)
		ScriptExit()
		
	end
end