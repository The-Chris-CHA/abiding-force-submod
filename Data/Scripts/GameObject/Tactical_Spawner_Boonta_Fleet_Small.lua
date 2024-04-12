require("PGBase")
require("PGStateMachine")
require("PGStoryMode")
require("PGSpawnUnits")

function Definitions()
    DebugMessage("%s -- In Definitions", tostring(Script))

    Define_State("State_Init", State_Init);
end

function State_Init(message)
    if Get_Game_Mode() ~= "Space" then
		ScriptExit()
	end

	local ship_list = {
			"Juvard_Frigate",
			"Kossak_Frigate",
			"Barabbula_Frigate",
			"Tarrada_Frigate",
			}

		local squad_count = GameRandom(5, 5)
		for spawn = 1, squad_count do
			local ShipIndex = GameRandom.Free_Random(1, table.getn(ship_list))
			local ShipGamble = ship_list[ShipIndex]
			Reinforce_Unit(Find_Object_Type(ShipGamble), false, Find_Player("Hutt_Cartels"))
		end

	Object.Despawn()
	ScriptExit()
end