require("PGBase")
require("PGStateMachine")
require("PGStoryMode")
require("PGSpawnUnits")
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

	Object.Set_Garrison_Spawn(false)

	local p_attacker = StoryUtil.Find_Attacking_Player()
	local p_defender = StoryUtil.Find_Defending_Player()
	local influence = nil

	repeat
		-- The AI may not yet be initialized
		Sleep(1)
		influence = Evaluate_In_Galactic_Context("Planet_Influence_Value", p_defender)
	until (influence ~= nil)

	local locals = nil
	if influence == 5 then --In the first week or other corner cases where no dummies are present, default to IF instead of attacker
		influence = 5
	end
	if influence >= 7 then
		locals = p_defender
	elseif influence <= 4 then
		locals = p_attacker
	else
		locals = Find_Player("Independent_Forces")
	end

	Object.Change_Owner(locals)
	Object.Set_Garrison_Spawn(true)
	ScriptExit()
end
