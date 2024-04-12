--******************************************************************************
--     _______ __
--    |_     _|  |--.----.---.-.--.--.--.-----.-----.
--      |   | |     |   _|  _  |  |  |  |     |__ --|
--      |___| |__|__|__| |___._|________|__|__|_____|
--     ______
--    |   __ \.-----.--.--.-----.-----.-----.-----.
--    |      <|  -__|  |  |  -__|     |  _  |  -__|
--    |___|__||_____|\___/|_____|__|__|___  |_____|
--                                    |_____|
--*   @Author:              Corey
--*   @Date:                2017-12-18T14:01:09+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            GCWarlordsCampaign.lua
--*   @Last modified by:
--*   @Last modified time:  2018-02-05T07:31:34-05:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************

require("PGBase")
require("PGStateMachine")
require("PGStoryMode")
require("PGSpawnUnits")
require("eawx-util/ChangeOwnerUtilities")
StoryUtil = require("eawx-util/StoryUtil")
require("SetFighterResearch")

function Definitions()
    DebugMessage("%s -- In Definitions", tostring(Script))

    StoryModeEvents = {
        Determine_Faction_LUA = Find_Faction,
        Delayed_Initialize = Initialize,
        Era_Selection = Era_Setup,
        Night_Hammer_Complete = Night_Hammer_Spawn,
        The_game_has_gone_too_long = Duo_spawn,
    }
	
	techLevel = 1
end

function Find_Faction(message)
    if message == OnEnter then
        p_newrep = Find_Player("Rebel")
        p_empire = Find_Player("Empire")
        p_eoth = Find_Player("EmpireoftheHand")
        p_eriadu = Find_Player("Eriadu_Authority")
        p_pentastar = Find_Player("Pentastar")
        p_zsinj = Find_Player("Zsinj_Empire")
        p_maldrood = Find_Player("Greater_Maldrood")

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
        end
    end
end

function Initialize(message)
    if message == OnEnter then
		crossplot:galactic()
		crossplot:publish("INITIALIZE_AI", "empty")
	else
		crossplot:update()
    end
end

function Era_Setup(message)
    if message == OnEnter then
		Set_Fighter_Research("V38")
        p_maldrood = Find_Player("Greater_Maldrood")
        p_harrsk = Find_Player("Empire")
        p_eriadu = Find_Player("Eriadu_Authority")
        p_yzu = Find_Player("Warlords")
		
		credits = p_maldrood.Get_Credits()
        techLevel = (credits / 1000) + 1
		
		p_maldrood.Give_Money(8000-credits)
		p_harrsk.Give_Money(8000-credits)
		p_eriadu.Give_Money(8000-credits)
		p_yzu.Give_Money(8000-credits)
				
        if techLevel < 4 then
            Story_Event("START_KOSH")
			--Maldrood_Spawns(true)
			--Other_Spawns(true)
			techLevel = 3
		elseif techLevel == 4 or techLevel == 5 then
			Story_Event("START_PREOSH")   
			--Maldrood_Spawns(false)
			--Other_Spawns(true)
			techLevel = 4
			
			StoryUtil.SetTechLevel(p_maldrood, 2)
			StoryUtil.SetTechLevel(p_eriadu, 2)
			StoryUtil.SetTechLevel(p_yzu, 2)
        else
            Story_Event("START_NOTDARKSABER")           
			--Maldrood_Spawns(false)
			--Other_Spawns(false)
			techLevel = 6
			
			StoryUtil.SetTechLevel(p_maldrood, 3)
			StoryUtil.SetTechLevel(p_eriadu, 3)
			StoryUtil.SetTechLevel(p_yzu, 3)
			
			NH_upgrade = Find_Object_Type("BrilliantUpgrade")
			p_eriadu.Lock_Tech(NH_upgrade)
        end
		
		GlobalValue.Set("CURRENT_ERA", techLevel)
    end
end

function Maldrood_Spawns(early)
	p_maldrood = Find_Player("Greater_Maldrood")
	if early then
		--Kosh in the core, Crimson Command out in Maldrood sector with Treutan
		start_planet = FindPlanet("Hakassi")
		spawn_list_hakassi = {
			"Kosh_Lancet",
			"Generic_Star_Destroyer",
			"Generic_Procursator",
			"Strike_Cruiser",
			"Strike_Cruiser",
			"Vigil",
			"Customs_Corvette",
			"Customs_Corvette"
		}
		SpawnList(spawn_list_hakassi, start_planet, p_maldrood, true, false)
		start_planet = FindPlanet("Ojom")
		spawn_list_ojom = {"Generic_Star_Destroyer", "Strike_Cruiser", "Strike_Cruiser", "Customs_Corvette"}
		SpawnList(spawn_list_ojom, start_planet, p_maldrood, true, false)
		start_planet = FindPlanet("Ebaq")
		spawn_list_ebaq = {"Generic_Procursator", "Generic_Victory_Destroyer", "Strike_Cruiser", "Escort_Carrier", "Escort_Carrier"}
		SpawnList(spawn_list_ebaq, start_planet, p_maldrood, true, false)
		start_planet = FindPlanet("Columus")
		spawn_list_columus = {"Tavira_Invidious", "Eidolon", "Vigil", "Customs_Corvette"}
		SpawnList(spawn_list_columus, start_planet, p_maldrood, true, false)
	else
		start_planet = FindPlanet("Hakassi")
		spawn_list_hakassi = {
			"Pellaeon_13X",
			"Treuten_Crimson_Sunrise",
			"Crimson_Victory",
			"Crimson_Victory",
			"Crimson_Victory",
			"Vigil",
			"Customs_Corvette"
		}
		SpawnList(spawn_list_hakassi, start_planet, p_maldrood, true, false)
		start_planet = FindPlanet("Ojom")
		spawn_list_ojom = {"Crimson_Victory", "Crimson_Victory", "Crimson_Victory", "Strike_Cruiser", "Strike_Cruiser"}
		SpawnList(spawn_list_ojom, start_planet, p_maldrood, true, false)
		start_planet = FindPlanet("Ebaq")
		spawn_list_ebaq = {"Crimson_Victory", "Crimson_Victory", "Crimson_Victory", "Generic_Imperial_II_Frigate", "Generic_Pursuit"}
		SpawnList(spawn_list_ebaq, start_planet, p_maldrood, true, false)
		start_planet = FindPlanet("Columus")
		spawn_list_columus = {"Crimson_Victory", "Vindicator_Cruiser", "Vigil", "Tartan_Patrol_Cruiser", "Tartan_Patrol_Cruiser", "Customs_Corvette"}
		SpawnList(spawn_list_columus, start_planet, p_maldrood, true, false)
	end
end

function Other_Spawns(early)
	p_harrsk = Find_Player("Empire")
    p_eriadu = Find_Player("Eriadu_Authority")
    p_yzu = Find_Player("Warlords")
	
	if early then
		start_planet = FindPlanet("Kalist")
		spawn_list_kalist = {
			"Harrsk_Whirlwind",
			"Noils_Team",
			"Ilthmars_Fist",
			"Agamar_Meniscus",
		}
		SpawnList(spawn_list_kalist, start_planet, p_harrsk, true, false)

		--Extra starting forces for the Night Hammerless EA
		start_planet = FindPlanet("Kampe")
		spawn_list_kampe = {"Vindicator_Cruiser", "Generic_Praetor"}
		SpawnList(spawn_list_kampe, start_planet, p_eriadu, true, false)

		start_planet = FindPlanet("Prakith")
		spawn_list_prakith = {"Strike_Cruiser", "Strike_Cruiser", "Raider_Corvette", "Raider_Corvette"}
		SpawnList(spawn_list_prakith, start_planet, p_yzu, true, false)
		
		--Random warlord service, with a decent chance it was in this area
		start_planet = FindPlanet("Cal_Seti")
		spawn_list_prakith = {"Praji_Secutor"}
		SpawnList(spawn_list_prakith, start_planet, p_yzu, true, false)
	else
		start_planet = FindPlanet("Kalist")
		spawn_list_kalist = {
			"Harrsk_Shockwave",
			"Noils_Team",
			"Generic_Tector",
			"Lancer_Frigate",
			"Generic_Star_Destroyer_Two",
			"Desanne_Redemption"
		} --The battlecruiser is probably gone by Darksaber
		SpawnList(spawn_list_kalist, start_planet, p_harrsk, true, false)
		
		--Praji was governor of Kaikielius by now. While he arguably could be with EA in era 2 as well, The association isn't strong and this lets there be more diversity between eras
		start_planet = FindPlanet("Kaikielius")
		spawn_list_tsoss = {"Praji_Secutor", "Generic_Gladiator", "Vindicator_Cruiser", "Vindicator_Cruiser"}
		SpawnList(spawn_list_tsoss, start_planet, p_eriadu, true, false)
		
		start_planet = FindPlanet("Foerost")
		spawn_list_tsoss = {"Generic_Star_Destroyer", "Generic_Gladiator", "Raider_II_Corvette", "Raider_II_Corvette"}
		SpawnList(spawn_list_tsoss, start_planet, p_eriadu, true, false)
		
		start_planet = FindPlanet("Tsoss")
		spawn_list_tsoss = {"Adz", "Adz"}
		SpawnList(spawn_list_tsoss, start_planet, p_eriadu, true, false)
		
		NH_upgrade = Find_Object_Type("BrilliantUpgrade")
		p_eriadu.Lock_Tech(NH_upgrade)

		start_planet = FindPlanet("Prakith")
		spawn_list_prakith = {"Strike_Cruiser_Gorath", "Strike_Cruiser_Gorath", "Adz", "Adz"}
		SpawnList(spawn_list_prakith, start_planet, p_yzu, true, false)
		
		start_planet = FindPlanet("Cal_Seti")
		spawn_list_prakith = {"Generic_Star_Destroyer_Two"}
		SpawnList(spawn_list_prakith, start_planet, p_yzu, true, false)
	end
end

function Night_Hammer_Spawn(message)
    if message == OnEnter then
        p_eriadu = Find_Player("Eriadu_Authority")

        start_planet = FindPlanet("Kampe")
        if not StoryUtil.CheckFriendlyPlanet(start_planet,p_eriadu) then
            start_planet = StoryUtil.FindFriendlyPlanet(p_eriadu)
        end
        if start_planet then
            spawn_list_Night_Hammer = {"Night_Hammer"}
            SpawnList(spawn_list_Night_Hammer, start_planet, p_eriadu, true, false)
        end
    end
end

function Duo_spawn(message)
    if message == OnEnter then
        p_harrsk = Find_Player("Empire")
		if not p_harrsk.Is_Human() then
			start_planet = FindPlanet("Thomork")
			if not StoryUtil.CheckFriendlyPlanet(start_planet,p_harrsk) then
				start_planet = StoryUtil.FindFriendlyPlanet(p_harrsk)
			end
			if start_planet then
				spawn_list_duo = {"Megador", "Dominion"}
				SpawnList(spawn_list_duo, start_planet, p_harrsk, true, false)
			end
		end
    end
end
