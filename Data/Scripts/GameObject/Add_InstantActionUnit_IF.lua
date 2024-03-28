--//////////////////////////////////////////////////////////////////////////////////////
-- Add Units to the reinforcement pool// This script is part of the Survival Mode
-- � Pox
--//////////////////////////////////////////////////////////////////////////////////////

require("IA_Spawn_Generic")

function Definitions()
	
	DebugMessage("%s -- In Definitions", tostring(Script))

	-- possible units to spawn
	unit_table = {
	"ACTION_VI_SUPPORT",
	"INTERCEPTOR_FRIGATE",
	"SKANDREI_GUNSHIP",
	"SUPER_TRANSPORT_VII_INTERDICTOR",
	"SUPER_TRANSPORT_VII",
	"SUPER_TRANSPORT_VI",
	"NEUTRON_STAR_TENDER",
	"SUPER_TRANSPORT_XI_MODIFIED",
	"SUPER_TRANSPORT_XI",
	"CALAMARI_CRUISER_LINER",
	"SPACE_ARC_CRUISER",
	"HOME_ONE_TYPE_LINER",
	"KOMRK_GUNSHIP_SQUADRON_INFLUENCE",
	"ARMADIA_INFLUENCE",
	"C_TYPE_INFLUENCE",
	"NAMANA_CRUISER_INFLUENCE",
	"MUNIFICENT_INFLUENCE",
	"BAKURA_DESTROYER_INFLUENCE",
	"KELDABE_INFLUENCE"
	}

	Define_State("State_Init", State_Init);


end


function State_Init(message)
	if message == OnEnter then
		IA_Spawn(Object.Get_Type().Get_Name(), "INSTANTACTION_MARKER_IF", "Empire", unit_table)
		ScriptExit()
		
	end
end