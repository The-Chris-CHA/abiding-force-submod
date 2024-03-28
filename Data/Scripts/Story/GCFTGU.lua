require("PGStoryMode")
require("deepcore/crossplot/crossplot")
require("deepcore/std/class")
require("eawx-util/PopulatePlanetUtilities")
require("UnitSpawnerTables")
StoryUtil = require("eawx-util/StoryUtil")

function Definitions()

    DebugMessage("%s -- In Definitions", tostring(Script))
    StoryModeEvents = {
		Universal_Story_Start = Spawn_Starting_Forces,
		Rancor_Base_Check = Delete_Old
	}
	
end		

function Spawn_Starting_Forces(message)
    if message == OnEnter then		
	
		p_newrep = Find_Player("Rebel")
		p_empire = Find_Player("Empire")
		p_eoth = Find_Player("EmpireoftheHand")
		p_eriadu = Find_Player("Eriadu_Authority")
		p_pentastar = Find_Player("Pentastar")
		p_zsinj = Find_Player("Zsinj_Empire")
		p_maldrood = Find_Player("Greater_Maldrood")
		p_corporate = Find_Player("Corporate_Sector")
		p_hapes = Find_Player("Hapes_Consortium")
		

		if p_newrep.Is_Human() then
			Story_Event("ENABLE_BRANCH_NEWREP_FLAG")
		elseif p_empire.Is_Human() then
			Story_Event("ENABLE_BRANCH_EMPIRE_FLAG")
		elseif p_eoth.Is_Human() then
			Story_Event("ENABLE_BRANCH_EOTH_FLAG")
		elseif p_eriadu.Is_Human() then
			Story_Event("ENABLE_BRANCH_ERIADU_FLAG")
		elseif p_pentastar.Is_Human() then
			Story_Event("ENABLE_BRANCH_PENTASTAR_FLAG")
		elseif p_zsinj.Is_Human() then
			Story_Event("ENABLE_BRANCH_ZSINJ_FLAG")
		elseif p_maldrood.Is_Human() then
			Story_Event("ENABLE_BRANCH_TERADOC_FLAG")
		elseif p_corporate.Is_Human() then
			Story_Event("ENABLE_BRANCH_CORPORATE_SECTOR_FLAG")
		elseif p_hapes.Is_Human() then
			Story_Event("ENABLE_BRANCH_HAPES_CONSORTIUM_FLAG")
		end
		
		credits = Find_Player("local").Get_Credits()
		techLevel = (credits / 1000) + 1
		
		GlobalValue.Set("CURRENT_ERA", techLevel)
		p_newrep.Give_Money(8000-credits)
		p_empire.Give_Money(8000-credits)
		p_eoth.Give_Money(8000-credits)
		p_eriadu.Give_Money(8000-credits)
		p_pentastar.Give_Money(8000-credits)
		p_zsinj.Give_Money(8000-credits)
		p_maldrood.Give_Money(8000-credits)
		p_corporate.Give_Money(8000-credits)
		p_hapes.Give_Money(8000-credits)
		
		if techLevel > 7 then
			techLevel = 7
		end
		
		if techLevel > 5 then
			StoryUtil.SetTechLevel(p_newrep, 2)
			StoryUtil.SetTechLevel(p_empire, 3)
			StoryUtil.SetTechLevel(p_eoth, 3)
			StoryUtil.SetTechLevel(p_eriadu, 3)
			StoryUtil.SetTechLevel(p_pentastar, 3)
			StoryUtil.SetTechLevel(p_zsinj, 3)
			StoryUtil.SetTechLevel(p_maldrood, 3)
			StoryUtil.SetTechLevel(p_corporate, 3)
			StoryUtil.SetTechLevel(p_hapes, 3)
		elseif techLevel > 3 then
			StoryUtil.SetTechLevel(p_newrep, 1)
			StoryUtil.SetTechLevel(p_empire, 2)
			StoryUtil.SetTechLevel(p_eoth, 2)
			StoryUtil.SetTechLevel(p_eriadu, 2)
			StoryUtil.SetTechLevel(p_pentastar, 2)
			StoryUtil.SetTechLevel(p_zsinj, 2)
			StoryUtil.SetTechLevel(p_maldrood, 2)
			StoryUtil.SetTechLevel(p_corporate, 2)
			StoryUtil.SetTechLevel(p_hapes, 2)
		end
		
		GlobalValue.Set("CURRENT_ERA", techLevel)
		
		if not p_newrep.Is_Human() then
			Story_Event("SET_NR_TECH")
		end
		
		if not p_empire.Is_Human() then
			Story_Event("SET_IR_TECH")
		end
		
		if not p_eoth.Is_Human() then
			Story_Event("SET_EH_TECH")
		end
		--Randomly spawn units at all planets owned by neutral or hostile
		--Probably want some screen text to tell the player the game is loading still
		local p_independent = Find_Player("Independent_Forces")
		local p_neutral = Find_Player("Neutral")
		local planet = nil
		local scaled_combat_power = 7500
		
		for _, planet in pairs(FindPlanet.Get_All_Planets()) do	
			if planet.Get_Owner() == (p_neutral or p_independent) then	
				scaled_combat_power = 7500 * EvaluatePerception("GenericPlanetValue", p_independent, planet) * (1.5 - EvaluatePerception("Is_Connected_To_Player", p_independent, planet))
				ChangePlanetOwnerAndPopulate(planet, p_independent, scaled_combat_power, false, true)
			end
		end
		
		ssd_meme_table = {
			{"Assertor", 5},
			{"Generic_Executor",2},
			{"Generic_Mandator_II",4},
			{"Generic_Mandator_III",4},
			{"Eclipse_Star_Destroyer",6},
			{"Generic_Bellator",3},
			{"Generic_Vengeance",3},
			{"Sovereign",6},
			{"Generic_Aramadia",4},
			{"Viscount",2}
		}
		
		local max_ssd = 4
		local spawned_ssd = 0
		if p_independent.Get_Difficulty() == "Easy" then
			max_ssd = 2
		elseif p_independent.Get_Difficulty() == "Hard" then
			max_ssd = 8
		end
		
		for _, pair in pairs(ssd_meme_table) do
			if GameRandom.Free_Random(1, pair[2]) == 1 then
				local ssd_planet = StoryUtil.FindFriendlyPlanet(p_independent)
				SpawnList({pair[1]}, ssd_planet, p_independent,false,false)
				spawned_ssd = spawned_ssd + 1
				if spawned_ssd >= max_ssd then
					break
				end
			end
		end
		
	end
end

function Delete_Old(message)
    if message == OnEnter then
		local capital_table = Find_All_Objects_Of_Type("Remnant_Capital")
        for i, unit in pairs(capital_table) do
			if unit.Get_Owner() == Find_Player("Zsinj_Empire") then
				unit.Despawn()
				p_zsinj.Give_Money(5000)
			end
        end
	end
end