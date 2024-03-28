--////////////////////////////////////////////////
-- Katana Mission (New Republic)
--////////////////////////////////////////////////

require("PGStoryMode")
require("PGSpawnUnits")
require("PGMoveUnits")



function Definitions()

	DebugMessage("%s -- In Definitions", tostring(Script))
	
	StoryModeEvents = 
	{
		Battle_Start = Begin_Battle
	}
end


function Begin_Battle(message)
	if message == OnEnter then
		local p_empire = Find_Player("Empire")
		local p_rebel = Find_Player("Rebel")

		local spawn_list_viper = {"X1_Viper_Droid_Company"}
		local spawn_list_commandos = {"Rebel_Infiltrator_Squad"}

		local entry_marker = Find_First_Object("Attacker Entry Position")

		if not entry_marker then
			local entry_marker = Find_First_Object("Reinforcement_Point")
			if not entry_marker then
				entry_marker = Find_First_Object("Reinforcement_Point_Plus1_Cap")
			end
			if not entry_marker then
				entry_marker = Find_First_Object("Reinforcement_Point_Plus2_Cap")
			end
			if not entry_marker then
				entry_marker = Find_First_Object("Reinforcement_Point_Plus3_Cap")
			end
			if not entry_marker then
				entry_marker = Find_First_Object("Reinforcement_Point_Plus4_Cap")
			end
			if not entry_marker then
				entry_marker = Find_First_Object("Reinforcement_Point_Plus5_Cap")
			end
			if not entry_marker then
				entry_marker = Find_First_Object("Reinforcement_Point_Plus10_Cap")
			end
		end

		for i=1,3 do
			local raiders = SpawnList(spawn_list_viper, entry_marker.Get_Position(), p_rebel, true, true)
			local raiders2 = SpawnList(spawn_list_commandos, entry_marker.Get_Position(), p_rebel, true, true)
		end
	end
end