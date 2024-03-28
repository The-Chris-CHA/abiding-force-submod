require("PGStoryMode")
require("PGSpawnUnits")
require("eawx-util/ChangeOwnerUtilities")
require("deepcore/std/class")
StoryUtil = require("eawx-util/StoryUtil")
UnitUtil = require("eawx-util/UnitUtil")
require("deepcore/crossplot/crossplot")
require("TRCommands")

function Definitions()

	DebugMessage("%s -- In Definitions", tostring(Script))

	Define_State("State_Init", State_Init);

end

function State_Init(message)
	Objective_Name_Attacker = "TEXT_TACTICAL_VICTORY_POINT_CAPTURE_DESCRIPTION"
	Objective_Name_Defender = "TEXT_TACTICAL_VICTORY_POINT_DEFEND_DESCRIPTION"
	
	if message == OnEnter then
		if Get_Game_Mode() ~= "Land" then
			ScriptExit()
		end

       local Scritped_Battle_Marker = Find_First_Object("Scripted_Battle_Marker")

		if TestValid(Scritped_Battle_Marker) then
			ScriptExit()
		end

		if not ModContentLoader then
            ModContentLoader = require("eawx-std/ModContentLoader")
		end
		
		CONSTANTS = ModContentLoader.get("GameConstants")
		
		players = {}
		
		p_attacker = false
		
		p_neutral = Find_Player("Neutral")
		
		for _, player_name in pairs(CONSTANTS.PLAYABLE_FACTIONS) do
			player_object = Find_Player(player_name)
			if player_object.Is_Human() then
				p_human = player
				p_human_object = player_object
			end
			
			if table.getn(Find_All_Objects_Of_Type(player_object)) > 0 then
				table.insert(players, player_object)
			end
		end

		p_attacker = StoryUtil.Find_Attacking_Player(true)
		p_defender = StoryUtil.Find_Defending_Player()

		victory_point_present = false
		
		victoryPoint = Find_First_Object("Victory_Point")
		
		if TestValid(victoryPoint) then
			victory_point_present = true
		end
		Sleep(2)
		if EvaluatePerception("Is_Defender", p_human_object) == 0 then
			if victory_point_present then
				victoryPoint.Highlight(true)
				Story_Event("CAPTURE_POINT_PRESENT")
				Add_Objective(Objective_Name_Attacker, false)
			else
				Story_Event("CAPTURE_POINT_NOT_PRESENT")
				ScriptExit()
			end
		else
			if victory_point_present then
				victoryPoint.Highlight(true)
				Story_Event("CAPTURE_POINT_PRESENT_DEFENDER")
				Add_Objective(Objective_Name_Defender, false)
			else
				Story_Event("CAPTURE_POINT_NOT_PRESENT_DEFENDER")
				ScriptExit()
			end
		end

        DebugMessage("DetermineEvents Victory Point Handler Finished")
	elseif message == OnUpdate then
		DebugMessage("DetermineEvents Victory Point Handler Update Started")
		if victory_point_present then
			if victoryPoint.Get_Owner() == p_attacker and (EvaluatePerception("Disable_VictoryPoint", p_attacker) == 0) then
				StoryUtil.DeclareVictory(p_attacker, true)
				if p_human_object == p_attacker then
					StoryUtil.SetObjectiveComplete(Objective_Name_Attacker)
				end
				if p_human_object == p_defender then
					StoryUtil.SetObjectiveFailed(Objective_Name_Defender)
				end

				Point_Camera_At(victoryPoint)
				Create_Cinematic_Transport(CONSTANTS.TRANSPORTS[p_attacker.Get_Faction_Name()], p_attacker.Get_ID(), victoryPoint.Get_Position(), 0, 1, 0.25, 60, 1)
				
				ScriptExit()
			end
		end
		DebugMessage("DetermineEvents Victory Point Handler Update Finished")
    end
end