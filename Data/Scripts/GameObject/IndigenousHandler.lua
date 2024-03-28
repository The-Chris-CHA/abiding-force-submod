require("PGBase")
require("PGStateMachine")
require("PGStoryMode")
require("PGSpawnUnits")
require("eawx-util/StoryUtil")

function Definitions()
    DebugMessage("%s -- In Definitions", tostring(Script))
    Define_State("State_Init", State_Init);
end

function State_Init(message)
    if Get_Game_Mode() ~= "Land" then
		ScriptExit()
	end

	local p_attacker = StoryUtil.Find_Attacking_Player(true)
	local p_defender = StoryUtil.Find_Defending_Player()

	local Unrest = false
	local Unrest_group
	
	local Inciter = Find_First_Object("Tanniel") --Reverse priority, Navett probably should win if they oppose
	if TestValid(Inciter) then
		Unrest_group = Inciter.Get_Owner()
		Unrest = true
	end
	
	Inciter = Find_First_Object("Drend_Navett")
	if TestValid(Inciter) then
		Unrest_group = Inciter.Get_Owner()
		Unrest = true
	end
	
	if Unrest and p_defender ~= Unrest_group then
		local unrest_target = GameRandom(1, 3)
		if unrest_target == 1 then
			Object.Change_Owner(Unrest_group)
			Object.Set_Garrison_Spawn(true)
			ScriptExit()
		end
		if unrest_target == 2 then
			Object.Change_Owner(Find_Player("Hostile"))
			Object.Set_Garrison_Spawn(true)
			ScriptExit()
		end
	end

	if p_defender == Find_Player("Independent_Forces") or p_defender == Find_Player("Warlords") then
		Object.Change_Owner(p_defender)
		Object.Set_Garrison_Spawn(true)
	else
		if Object.Get_Type() == Find_Object_Type("Indigenous_Dwelling_Mon_Calamari")
		or Object.Get_Type() == Find_Object_Type("Indigenous_Dwelling_Gungan")
		or Object.Get_Type() == Find_Object_Type("Indigenous_Dwelling_Wookiee")
		or Object.Get_Type() == Find_Object_Type("Indigenous_Dwelling_Twilek")
		or Object.Get_Type() == Find_Object_Type("Indigenous_Dwelling_Ewok")
		or Object.Get_Type() == Find_Object_Type("Indigenous_Dwelling_Sullustan")
		or Object.Get_Type() == Find_Object_Type("Indigenous_Dwelling_Bothan") then
			Object.Change_Owner(Find_Player("Rebel"))
			Object.Set_Garrison_Spawn(true)
		end
		if Object.Get_Type() == Find_Object_Type("Indigenous_Dwelling_Hutt") then
			Object.Change_Owner(Find_Player("Hutt_Cartels"))
			Object.Set_Garrison_Spawn(true)
		end
		if Object.Get_Type() == Find_Object_Type("Indigenous_Dwelling_Cultists")
		or Object.Get_Type() == Find_Object_Type("Indigenous_Dwelling_Tusken")
		or Object.Get_Type() == Find_Object_Type("Indigenous_Dwelling_Wampa")
		or Object.Get_Type() == Find_Object_Type("Indigenous_Dwelling_Terentatek")
		or Object.Get_Type() == Find_Object_Type("Indigenous_Dwelling_Rancor")
		or Object.Get_Type() == Find_Object_Type("Indigenous_Dwelling_Vornskr")
		or Object.Get_Type() == Find_Object_Type("Indigenous_Dwelling_Kath")
		or Object.Get_Type() == Find_Object_Type("Indigenous_Jawa_Sandcrawler") then
			Object.Change_Owner(Find_Player("Hostile"))
			Object.Set_Garrison_Spawn(true)
		end
		if Object.Get_Owner() == Find_Player("Neutral") then
			if p_attacker ~= Find_Player("Rebel") and p_defender ~= Find_Player("Rebel") then
				local unrest_target = GameRandom.Free_Random(1, 6)
				if unrest_target <= 3 then
					Object.Change_Owner(p_defender)
					Object.Set_Garrison_Spawn(true)
				end
				if unrest_target == 4 then
					Object.Change_Owner(Find_Player("Rebel"))
					Object.Set_Garrison_Spawn(true)
				end
				if unrest_target >= 5 then
					Object.Change_Owner(p_attacker)
					Object.Set_Garrison_Spawn(true)
				end
			else
				local unrest_target = GameRandom.Free_Random(1, 6)
				if unrest_target <= 3 then
					Object.Change_Owner(p_defender)
					Object.Set_Garrison_Spawn(true)
				end
				if unrest_target == 4 then
					Object.Change_Owner(Find_Player("Independent_Forces"))
					Object.Set_Garrison_Spawn(true)
				end
				if unrest_target >= 5 then
					Object.Change_Owner(p_attacker)
					Object.Set_Garrison_Spawn(true)
				end
			end
		else
			Object.Set_Garrison_Spawn(true)
		end
	end
	ScriptExit()
end
