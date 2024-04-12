--////////////////////////////////////////////////
-- Byss Raid Mission (New Republic)
--////////////////////////////////////////////////
require("PGStoryMode")
require("PGSpawnUnits")
require("PGMoveUnits")

function Definitions()
	DebugMessage("%s -- In Definitions", tostring(Script))
	
	StoryModeEvents = {
		Battle_Start = Battle_Start_Lua
	}
end

function Battle_Start_Lua(message)
	if message == OnEnter then
		local p_empire = Find_Player("Empire")
		local p_rebel = Find_Player("Rebel")

		local spawn_list_viper = {"X1_Viper_Droid_Company"}
		local spawn_list_commandos = {"Rebel_Infiltrator_Squad"}

		local entry_marker = Find_First_Object("Attacker Entry Position")

		if not entry_marker then
			entry_marker = Find_First_Object("Reinforcement_Point_Plus5_Cap")
		end

		for i=1,3 do
			SpawnList(spawn_list_viper, entry_marker.Get_Position(), p_rebel, true, true)
			SpawnList(spawn_list_commandos, entry_marker.Get_Position(), p_rebel, true, true)
		end
	end
end