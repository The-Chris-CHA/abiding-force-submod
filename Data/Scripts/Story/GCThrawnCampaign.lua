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
--*   @Date:                2017-10-01T19:08:32+02:00
--*   @Project:             Imperial Civil War
--*   @Filename:            GCThrawnCampaign.lua
--*   @Last modified by:    [TR]Pox
--*   @Last modified time:  2017-12-21T12:39:33+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



require("PGBase")
require("PGStateMachine")
require("PGStoryMode")
require("PGSpawnUnits")
require("deepcore/crossplot/crossplot")

function Definitions()

	DebugMessage("%s -- In Definitions", tostring(Script))
	
	StoryModeEvents = {
        Universal_Story_Start = Find_Faction,
		Delayed_Initialize = Initialize
	}

end


function Find_Faction(message)
  if message == OnEnter then
	Story_Event("GC_DELTA_SOURCE_INIT")
  end
end


function Initialize(message)
    if message == OnEnter then
		crossplot:galactic()
		crossplot:publish("INITIALIZE_AI", "empty")
		crossplot:publish("NR_ADMIRAL_DECREMENT", 1, 1)
		crossplot:publish("NR_ADMIRAL_DECREMENT", 1, 3)
		crossplot:publish("NR_ADMIRAL_LOCKIN", {"Kyle"}, 3)
		crossplot:publish("NR_ADMIRAL_LOCKIN", {"Mara"}, 3)
	else
		crossplot:update()
    end
end
