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
require("deepcore/crossplot/crossplot")
require("SetFighterResearch")

function Definitions()
    DebugMessage("%s -- In Definitions", tostring(Script))

    StoryModeEvents = {
        Spawn_Tycho_Celchu_Rogue_Team = fn_Spawn_Tycho_Celchu_Rogue_Team
    }
end

function fn_Spawn_Tycho_Celchu_Rogue_Team(message)
    if message == OnEnter then
		crossplot:galactic()
        p_rebel = Find_Player("Rebel")

		crossplot:publish("NR_FILTER_REMOVE", {"Wedge_Rogues_Location_Set"}, 2)
		Clear_Fighter_Hero("WEDGE_ANTILLES_ROGUE_TEAM")
		Set_Fighter_Hero("TYCHO_CELCHU_ROGUE_TEAM", "WEDGE_LUSANKYA")
		crossplot:publish("NR_FILTER_ADD", {"Tycho_Rogues_Location_Set"}, 2)
    elseif message == OnUpdate then
		crossplot:update()
    end
end
