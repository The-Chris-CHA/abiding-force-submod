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

function Definitions()

  DebugMessage("%s -- In Definitions", tostring(Script))

  StoryModeEvents =
  {
    Universal_Story_Start = Find_Faction,
	Delayed_Initialize = Initialize
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
		local p_newrep = Find_Player("Rebel")
		crossplot:galactic()
		if p_newrep.Is_Human() then
			crossplot:publish("NR_ADMIRAL_DECREMENT", 3, 1)
			crossplot:publish("NR_ADMIRAL_LOCKIN", {"Ackbar"}, 1)
		end
	else
		crossplot:update()
    end
end
