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
--*   @Author:              Jorritkarwehr
--*   @Date:                2017-10-01T19:08:32+02:00
--*   @Project:             Imperial Civil War
--*   @Filename:            GCCoruscantEvacuation.lua
--*   @Last modified by:    Mord
--*   @Last modified time:  2023-08-30T22:57:40-05:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************

require("PGBase")
require("PGStateMachine")
require("PGStoryMode")
require("PGSpawnUnits")
require("eawx-util/ChangeOwnerUtilities")

function Definitions()

    DebugMessage("%s -- In Definitions", tostring(Script))
    
    StoryModeEvents =
    {
        Start_Chain = Start_Chain_Lua,
        Empire_Wins_Coruscant = Empire_Wins_Coruscant_Lua,
    }

end

function Start_Chain_Lua(message)
  if message == OnEnter then
    local p_newrep = Find_Player("Rebel")

    if p_newrep.Is_Human() and FindPlanet("Coruscant").Get_Owner() == p_newrep then
        Story_Event("CORUSCANT_EVAC_START")
    end
  end
end

function Empire_Wins_Coruscant_Lua(message)
    if message == OnEnter then
        local planet_coruscant = FindPlanet("Coruscant")
        local p_empire = Find_Player(GlobalValue.Get("IMPERIAL_REMNANT"))

        Story_Event("STOP_MONITOR_LUKE_DEATH")
        ChangePlanetOwnerAndRetreat(planet_coruscant, Find_Player("Neutral"), FindPlanet("Da_Soocha"))
        Story_Event("RESUME_MONITOR_LUKE_DEATH")
        ChangePlanetOwnerAndReplace(planet_coruscant, p_empire)

        local spawn_list = {
            "Generic_Star_Destroyer_Two",
            "Generic_Secutor",
            "Generic_Allegiance",
            "MTC_Support",
            "MTC_Support",
            "MTC_Support",
            "Generic_Interdictor_Cruiser",
            "Generic_Victory_Destroyer",
            "Vindicator_Cruiser",
            "Carrack_Cruiser",
            "Carrack_Cruiser",
            "Lancer_Frigate",
            "Lancer_Frigate",
            "Lancer_Frigate",
            "Raider_Corvette",
            "Generic_Procursator",
            "Generic_Victory_Destroyer_Two",
            "Generic_Star_Destroyer",
            "Generic_Star_Destroyer",
            "Strike_Cruiser",
            "Strike_Cruiser",
            "Generic_Victory_Destroyer",
            
            "Imperial_AT_AT_Company",
            "Imperial_XR85_Company",
            "Imperial_Century_Tank_Company",
            "Imperial_SA5_Company",
            "Imperial_Chariot_LAV_Company",
            "Imperial_AT_ST_Company",
            "Imperial_ISB_Infiltrator_Squad",
            "Imperial_Compforce_Assault_Squad",
            "Imperial_Stormtrooper_Squad",
            "Imperial_Army_Trooper_Squad",
            
            "Empire_MoffPalace",
            "E_Ground_Barracks",
            "E_Ground_Light_Vehicle_Factory",
            "E_Ground_Heavy_Vehicle_Factory",
        }

        --this force is supposed to just sit on Coruscant
        SpawnList(spawn_list, planet_coruscant, p_empire, false, false)

        if Find_Player("Rebel").Is_Human() then
            Story_Event("NR_PLAYER_SHADOWHAND_INTRO")
        end
    end
end
