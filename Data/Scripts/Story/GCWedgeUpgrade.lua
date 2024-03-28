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
--*   @Date:                2019-12-18T14:01:09+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            GCWedgeUpgrade.lua
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
StoryUtil = require("eawx-util/StoryUtil")

function Definitions()
    DebugMessage("%s -- In Definitions", tostring(Script))

    StoryModeEvents = {
        Spawn_Rogue_Squadron = Tycho_appears
    }
end

function Tycho_appears(message)
    if message == OnEnter then
        p_rebel = Find_Player("Rebel")

        start_planet = FindPlanet("Coruscant")
        --checkWedge = Find_First_Object("Wedge_Rogue_Squadron_Space") --tried to spawn Tycho in Wedge's location, but it wasn't working. I blame squadron/unit confusion, probably
        --if TestValid(checkWedge) then
        --start_planet = checkWedge.Get_Planet_Location()
        --checkWedge.Despawn()
        --end

        if not StoryUtil.CheckFriendlyPlanet(start_planet,p_rebel) then
            start_planet = StoryUtil.FindFriendlyPlanet(p_rebel)
        end
        spawn_list_Tycho = {"Rogue_Squadron_Space"}
        TychoSpawn = SpawnList(spawn_list_Tycho, start_planet, p_rebel, true, false)

        ScriptExit()
    elseif message == OnUpdate then
    end
end
