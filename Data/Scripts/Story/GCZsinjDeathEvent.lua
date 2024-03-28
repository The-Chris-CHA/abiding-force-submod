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
--*   @Filename:            GCZsinjCampaign.lua
--*   @Last modified by:
--*   @Last modified time:  2018-02-05T07:33:34-05:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************

require("PGBase")
require("PGStateMachine")
require("PGStoryMode")
require("PGSpawnUnits")
require("eawx-util/ChangeOwnerUtilities")
require("eawx-util/PlanetPopulateUtilities")

function Definitions()
    DebugMessage("%s -- In Definitions", tostring(Script))

    StoryModeEvents = {
        Zsinj_Death = On_Zsinj_Death
    }
end

function On_Zsinj_Death(message)
    if message == OnEnter then
        p_empire = Find_Player("Empire")
        p_rebel = Find_Player("Rebel")
        p_maldrood = Find_Player("Greater_Maldrood")
        p_corporate = Find_Player("Corporate_Sector")
        p_zsinj = Find_Player("Zsinj_Empire")

        --Post-Zsinj, Kosh merges with Treutan
        start_planet = FindPlanet("Centares")
        if TestValid(start_planet) then
            if start_planet.Get_Owner() == p_maldrood then
                spawn_list_kosh = {"Lancet_Kosh"}
                KoshSpawn = SpawnList(spawn_list_kosh, start_planet, p_maldrood, true, false)
            end
        end

        --Corporate Sector Spawns

        start_planet = FindPlanet("Etti")
        if TestValid(start_planet) then
            if start_planet.Get_Owner() == p_zsinj then
                --			Story_Event("CORPORATE_EMERGE_Etti")
                
                ChangePlanetOwnerAndPopulate(start_planet, p_corporate, 7500)
            end
        end

        start_planet = FindPlanet("Ession")
        if TestValid(start_planet) then
            if start_planet.Get_Owner() == p_zsinj then
                --			Story_Event("CORPORATE_EMERGE_Ession")
                ChangePlanetOwnerAndPopulate(start_planet, p_corporate, 7500)
            end
        end

        start_planet = FindPlanet("Bonadan")
        if TestValid(start_planet) then
            if start_planet.Get_Owner() == p_zsinj then
                --			Story_Event("CORPORATE_EMERGE_Bonadan")
                ChangePlanetOwnerAndPopulate(start_planet, p_corporate, 7500)
            end
        end

        ScriptExit()
    elseif message == OnUpdate then
    end
end
