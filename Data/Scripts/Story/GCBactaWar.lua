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
require("deepcore/crossplot/crossplot")
require("deepcore/std/class")
StoryUtil = require("eawx-util/StoryUtil")
require("SetFighterResearch")

function Definitions()

  DebugMessage("%s -- In Definitions", tostring(Script))

  StoryModeEvents =
	{
		--Generic
		Delayed_Initialize = Delayed_Initialize_Lua,
	}
	
	p_newrep = Find_Player("Rebel")
	p_empire = Find_Player("Empire")
end

function Delayed_Initialize_Lua(message)
    if message == OnEnter then
		crossplot:galactic()
		crossplot:publish("INITIALIZE_AI", "empty")
		crossplot:publish("NR_ADMIRAL_DECREMENT", 3, 1)
		crossplot:publish("NR_ADMIRAL_LOCKIN", {"Ackbar"}, 1)
		
		crossplot:publish("NR_FILTER_REMOVE", {"SalmY_Location_Set"}, 2)
		Set_Fighter_Hero("SALM_Y-WING_SQUADRON", "HOME_ONE")
		
		p_empire.Lock_Tech(Find_Object_Type("TURR_PHENNIR_TIE_INTERCEPTOR_LOCATION_SET"))
		Clear_Fighter_Hero("VESSERY_STRANGER_SQUADRON")
		Set_Fighter_Hero("ERISI_DLARIT_ELITE_SQUADRON", "ISARD_LUSANKYA")
		p_empire.Unlock_Tech(Find_Object_Type("ERISI_DLARIT_LOCATION_SET"))
	else
		crossplot:update()
    end
end
