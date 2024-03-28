--//////////////////////////////////////////////////////////////////////////////////////
-- Add Units to the reinforcement pool// This script is part of the Survival Mode
-- � Pox
--//////////////////////////////////////////////////////////////////////////////////////

require("IA_Spawn_Generic")

function Definitions()
	
	DebugMessage("%s -- In Definitions", tostring(Script))

	-- possible units to spawn
	unit_table = {
	"MUNIFICENT",
	"GENERIC_VENATOR",
	"GENERIC_BELLATOR",
	"GENERIC_GLADIATOR_TWO",
	"GENERIC_SECUTOR",
	"GENERIC_PROCURSATOR",
	"GENERIC_PRAETOR",
	"GENERIC_ACCLAMATOR_ASSAULT_SHIP_I",
	"ARQUITENS",
	"GENERIC_ACCLAMATOR_ASSAULT_SHIP_LEVELER",
	"RAIDER_CORVETTE",
	"ENFORCER",
	"GENERIC_VENGEANCE",
	"GENERIC_IMPERIAL_II_FRIGATE",
	"NEUTRON_STAR",
	"BROADSIDE_CRUISER",
	"VICTORY_II_FRIGATE",
	"ADZ",
	"INTERCEPTOR_FRIGATE",
	"TARTAN_PATROL_CRUISER",
	"COMBAT_ESCORT_CARRIER",
	"DECIMATOR_SQUADRON",
	"EX_F",
	"GENERIC_AGGRESSOR"
	}

	Define_State("State_Init", State_Init);


end


function State_Init(message)
	if message == OnEnter then
		IA_Spawn(Object.Get_Type().Get_Name(), "INSTANTACTION_MARKER_PENTASTAR", "Pentastar", unit_table)
		ScriptExit()
		
	end
end