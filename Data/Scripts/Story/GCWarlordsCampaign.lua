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

require("PGStoryMode")
require("PGSpawnUnits")
require("eawx-util/ChangeOwnerUtilities")
StoryUtil = require("eawx-util/StoryUtil")

function Definitions()
    DebugMessage("%s -- In Definitions", tostring(Script))

    StoryModeEvents = {
        Universal_Story_Start = Begin_GC,
        Determine_Faction_LUA = Find_Faction,
        Maldrood_Kashyyyk = Kashyyyk_Maldrood,
        Zsinj_Centares = Centares_Zsinj,
        Set_Subera_Isard = SubEra_Change,
        Talks_End = Pentastar_Talks,
		Loop_Clearer = Perpetuator,
    }
end

function Find_Faction(message)
    if message == OnEnter then
        local p_newrep = Find_Player("Rebel")
        local p_empire = Find_Player("Empire")
        local p_eoth = Find_Player("EmpireoftheHand")
        local p_eriadu = Find_Player("Eriadu_Authority")
        local p_pentastar = Find_Player("Pentastar")
        local p_zsinj = Find_Player("Zsinj_Empire")
        local p_maldrood = Find_Player("Greater_Maldrood")
        local p_corporate = Find_Player("Corporate_Sector")

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
        end
    end
end

function Kashyyyk_Maldrood(message)
    if message == OnEnter then
        local p_maldrood = Find_Player("Greater_Maldrood")
        local start_planet = FindPlanet("Kashyyyk")

        if start_planet.Get_Owner() == Find_Player("Greater_Maldrood") then
            if p_maldrood.Is_Human() then
                Story_Event("SYN_JOINS_SPEECH")
            end
            local spawn_list_syn = {"Syn_Silooth"}
            local SynSpawn = SpawnList(spawn_list_syn, start_planet, p_maldrood, true, false)
        --end
        end
    elseif message == OnUpdate then
    end
end

function Centares_Zsinj(message)
    if message == OnEnter then
        p_zsinj = Find_Player("Zsinj_Empire")
        start_planet = FindPlanet("Centares")

        if start_planet.Get_Owner() == Find_Player("Zsinj_Empire") then
            if p_zsinj.Is_Human() then
                Story_Event("SELIT_JOINS_SPEECH")
            end
            spawn_list_selit = {"Selit_Team"}
            SpawnList(spawn_list_selit, start_planet, p_zsinj, true, false)
        --end
        end
    end
end

function SubEra_Change(message)
    if message == OnEnter then
        p_empire = Find_Player("Empire")
        p_harrsk = Find_Player("Warlords")

        start_planet = FindPlanet("Coruscant")

        if not StoryUtil.CheckFriendlyPlanet(start_planet,p_empire) then
            start_planet = StoryUtil.FindFriendlyPlanet(p_empire)
        end

        spawn_list_isard = {"Lusankya", "Implacable_Star_Destroyer"}
        IsardSpawn = SpawnList(spawn_list_isard, start_planet, p_empire, true, false)

        checkPestage = Find_First_Object("Sate_Pestage")
        if TestValid(checkPestage) then
            checkPestage.Despawn()
        end

        checkHarrsk = Find_First_Object("Whirlwind_Star_Destroyer")
        if TestValid(checkHarrsk) then
            checkHarrsk.Despawn()
        end

        ProjectAmbition = Find_First_Object("Project_Ambition_Dummy")
        if TestValid(ProjectAmbition) then
            spawn_list_ambition = {"Makati_Steadfast", "Takel_MagicDragon", "Corrupter_Star_Destroyer"}
            AmbitionRewards = SpawnList(spawn_list_ambition, start_planet, p_empire, true, false)
            ProjectAmbition.Despawn()
        end

        --Harrsk spawns

        start_planet = FindPlanet("Kalist")
        if start_planet.Get_Owner() == p_empire then
            ChangePlanetOwnerAndRetreat(start_planet, p_harrsk)

            spawn_list = {"Whirlwind_Star_Destroyer"}
            HarrskForces = SpawnList(spawn_list, start_planet, p_harrsk, false, false)
        end

        start_planet = FindPlanet("Abregado_Rae")
        if start_planet.Get_Owner() == p_empire then
            ChangePlanetOwnerAndRetreat(start_planet, p_harrsk)

            spawn_list = {"Generic_Star_Destroyer"}
            HarrskForces = SpawnList(spawn_list, start_planet, p_harrsk, false, false)
        end
    elseif message == OnUpdate then
    end
end

function Pentastar_Talks(message)
    if message == OnEnter then
        local p_pentastar = Find_Player("Pentastar")

        local start_planet = FindPlanet("Bastion")
        if start_planet.Get_Owner() == Find_Player("Pentastar") then
            if p_pentastar.Is_Human() then
                Story_Event("KAINE_JOINS_SPEECH")
            end
            local spawn_list_Reaper = {"Ardus_Kaine_Team", "Gregor_Team", "Dekeet_Intractable", "Dynamic_Besk", "Otro_Enforcer"}
            local ReaperSpawn = SpawnList(spawn_list_Reaper, start_planet, p_pentastar, true, false)
        end
    elseif message == OnUpdate then
    end
end

function Perpetuator(message)
    if message == OnEnter then
    end
end
