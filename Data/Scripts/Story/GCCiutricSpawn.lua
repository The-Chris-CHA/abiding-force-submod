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
--*   @Last modified time:  2018-03-13T22:28:32-04:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************

require("PGStoryMode")
require("PGSpawnUnits")
require("eawx-util/ChangeOwnerUtilities")

function Definitions()
    DebugMessage("%s -- In Definitions", tostring(Script))

    StoryModeEvents = {
        Trigger_Council_Thrawn_Death = Ciutric_Breakway
    }
end

function Ciutric_Breakway(message)
    if message == OnEnter then
        p_empire = Find_Player("Empire")
        p_ciutric = Find_Player("Warlords")

        start_planet = FindPlanet("Ciutric")
        if TestValid(start_planet) then
            if start_planet.Get_Owner() == p_empire then
                ChangePlanetOwnerAndRetreat(start_planet, p_ciutric)

                spawn_list = {"Generic_Star_Destroyer"}
                SpawnList(spawn_list, start_planet, p_ciutric, true, false)
            end
        end

        start_planet = FindPlanet("Vrosynri")
        if TestValid(start_planet) then
            if start_planet.Get_Owner() == p_empire then
                ChangePlanetOwnerAndRetreat(start_planet, p_ciutric)

                spawn_list = {"Generic_Star_Destroyer"}
                SpawnList(spawn_list, start_planet, p_ciutric, true, false)
            end
        end

        start_planet = FindPlanet("Corvis_Minor")
        if TestValid(start_planet) then
            if start_planet.Get_Owner() == p_empire then
                ChangePlanetOwnerAndRetreat(start_planet, p_ciutric)

                spawn_list = {"Generic_Star_Destroyer"}
                SpawnList(spawn_list, start_planet, p_ciutric, true, false)
            end
        end
    end
    ScriptExit()
end
