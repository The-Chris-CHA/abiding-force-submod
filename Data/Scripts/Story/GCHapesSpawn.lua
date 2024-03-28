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
        Hapes_Spawns = HapesSpawns
    }
end

function HapesSpawns(message)
    if message == OnEnter then
        p_hapes = Find_Player("Hapes_Consortium")
        start_planet = FindPlanet("Terephon")
        if TestValid(start_planet) then
            ChangePlanetOwnerAndRetreat(start_planet, p_hapes)
            spawn_list_Hapans = {
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser"
            }
            SpawnList(spawn_list_Hapans, start_planet, p_hapes, true, false)
        end

        start_planet = FindPlanet("Charubah")
        if TestValid(start_planet) then
            ChangePlanetOwnerAndRetreat(start_planet, p_hapes)
            spawn_list_Hapans = {
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser"
            }
            SpawnList(spawn_list_Hapans, start_planet, p_hapes, true, false)
        end

        start_planet = FindPlanet("Hapes")
        if TestValid(start_planet) then
            ChangePlanetOwnerAndRetreat(start_planet, p_hapes)
            spawn_list_Hapans = {
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Taa_Chume_Star_Home",
                "Isolder_Song_of_War"
            }
            SpawnList(spawn_list_Hapans, start_planet, p_hapes, true, false)
        end

        start_planet = FindPlanet("Transitory_Mists_I")
        if TestValid(start_planet) then
            ChangePlanetOwnerAndRetreat(start_planet, p_hapes)
            spawn_list_Hapans = {
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser"
            }
            SpawnList(spawn_list_Hapans, start_planet, p_hapes, true, false)
        end

        start_planet = FindPlanet("Transitory_Mists_II")
        if TestValid(start_planet) then
            ChangePlanetOwnerAndRetreat(start_planet, p_hapes)
            spawn_list_Hapans = {
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser"
            }
            SpawnList(spawn_list_Hapans, start_planet, p_hapes, true, false)
        end

        start_planet = FindPlanet("Transitory_Mists_III")
        if TestValid(start_planet) then
            ChangePlanetOwnerAndRetreat(start_planet, p_hapes)
            spawn_list_Hapans = {
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "BattleDragon",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser",
                "Nova_Cruiser"
            }
            SpawnList(spawn_list_Hapans, start_planet, p_hapes, true, false)
        end

        ScriptExit()
    end
end
