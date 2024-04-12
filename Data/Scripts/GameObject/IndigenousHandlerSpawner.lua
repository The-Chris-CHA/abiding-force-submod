require("PGBase")
require("PGStateMachine")
require("PGStoryMode")
require("TRCommands")
require("eawx-util/StoryUtil")
require("eawx-util/MissionFunctions")

function Definitions()
    DebugMessage("%s -- In Definitions", tostring(Script))
    Define_State("State_Init", State_Init);
end

function State_Init(message)

	if Get_Game_Mode() ~= "Space" then
		ScriptExit()
	end

	if message == OnEnter then
		local p_attacker = StoryUtil.Find_Attacking_Player()
		local p_defender = StoryUtil.Find_Defending_Player()
		
				
		local region = nil
		repeat    
		-- The AI may not yet be initialized
		Sleep(1)
		region = Evaluate_In_Galactic_Context("Regional_Fighter_Planets", p_defender)
		until (region ~= nil)
		
		local regionals = require("RegionalFighterBases")
		
		if regionals[region] then
			
			local influence = nil
			repeat
				-- The AI may not yet be initialized
				Sleep(1)
				influence = Evaluate_In_Galactic_Context("Planet_Influence_Value", p_defender)
			until (influence ~= nil)
			
			local entry_marker = nil

			local locals = nil
			if influence == 0 then --In the first week or other corner cases where no dummies are present, default to IF instead of attacker
				influence = 5
			end
			if influence >= 7 then
				locals = p_defender
				entry_marker = Find_First_Object("Defending Forces Position")
			elseif influence <= 4 then
				locals = p_attacker
				entry_marker = Find_First_Object("Attacker Entry Position")
			else
				locals = Find_Player("Independent_Forces")
				locals.Enable_As_Actor()
				entry_marker = Find_First_Object("Map_Corner")
			end

			SpawnList({regionals[region]}, entry_marker.Get_Position(), locals, false, true)
		end
    end
end