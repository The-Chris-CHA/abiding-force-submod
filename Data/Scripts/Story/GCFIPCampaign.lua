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

function Definitions()
	DebugMessage("%s -- In Definitions", tostring(Script))

	StoryModeEvents = {
		Determine_Faction_LUA = Begin_GC,
		Delayed_Initialize = Initialize
	}
end

function Begin_GC(message)
	  if message == OnEnter then

	 p_newrep = Find_Player("Rebel")
	 p_empire = Find_Player("Empire")
	 p_eoth = Find_Player("EmpireoftheHand")
	 p_eriadu = Find_Player("Eriadu_Authority")
	 p_pentastar = Find_Player("Pentastar")
	 p_zsinj = Find_Player("Zsinj_Empire")
	 p_maldrood = Find_Player("Greater_Maldrood")

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
		
		crossplot:galactic()
		crossplot:publish("NR_ADMIRAL_DECREMENT", 2, 1)
		crossplot:publish("NR_ADMIRAL_EXIT", {"Ackbar"}, 1)
		crossplot:publish("NR_ADMIRAL_EXIT", {"Bell"}, 1)
	else
		crossplot:update()
	end
end
