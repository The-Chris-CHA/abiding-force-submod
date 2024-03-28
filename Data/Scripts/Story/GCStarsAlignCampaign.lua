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
--*   @Filename:            GCStarsAlignCampaign.lua
--*   @Last modified by:    [TR]Pox
--*   @Last modified time:  2017-12-21T12:39:24+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



require("PGBase")
require("PGStateMachine")
require("PGStoryMode")
require("PGSpawnUnits")
require("eawx-util/StoryUtil")
require("deepcore/galaxy/Planet")
require("deepcore/crossplot/crossplot")

function Definitions()

  DebugMessage("%s -- In Definitions", tostring(Script))

  StoryModeEvents =
  {
	Determine_Faction_LUA = Find_Faction,
	Talks_End = Begin_GC,
	Delayed_Initialize = Initialize
	-- Determine_Faction_LUA = Starbase_Test
  }

end


function Find_Faction(message)
  if message == OnEnter then
	DebugMessage("Find_Faction SA Campaign Started")
	p_newrep = Find_Player("Rebel")
	p_empire = Find_Player("Empire")
	p_eoth = Find_Player("Underworld")
	p_eriadu = Find_Player("Eriadu_Authority")
	p_pentastar = Find_Player("Pentastar")
	p_zsinj = Find_Player("Zsinj_Empire")
	p_maldrood = Find_Player("Greater_Maldrood")
	p_corporate = Find_Player("Corporate_Sector")

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
	elseif p_corporate.Is_Human() then
		Story_Event("ENABLE_BRANCH_CORPORATE_SECTOR_FLAG")
	end

		techLevel = p_empire.Get_Tech_Level()
		if techLevel ~= 1 then
			Story_Event("DISABLE_SPAWN")
	 	end
		
	local check_progressives = FindPlanet("Byss") --This is used for both Stars Align and Progressives, so make sure we're on Stars Align before killing slots
	if not TestValid(check_progressives)  then
		Story_Event("NR_ADMIRAL_DECREMENT_2")
	end
	
	DebugMessage("Find_Faction SA Campaign Finished")
	end
end

function Begin_GC(message)
  if message == OnEnter then
	DebugMessage("Begin_GC SA Campaign Started")
    p_empire = Find_Player("Empire")
    p_rebel = Find_Player("Rebel")
    p_pentastar = Find_Player("Pentastar")


		start_planet = FindPlanet("Bastion")
		if not StoryUtil.CheckFriendlyPlanet(start_planet,p_pentastar) then
			start_planet = StoryUtil.FindFriendlyPlanet(p_pentastar)
		end
		if start_planet then
			spawn_list_Reaper = { "Ardus_Kaine_Team", "Gregor_Team", "Dekeet_Intractable", "Dynamic_Besk", "Otro_Enforcer"  }
			ReaperSpawn = SpawnList(spawn_list_Reaper, start_planet, p_pentastar,true,false)
		end
		
		if p_pentastar.Is_Human() then
			Story_Event("KAINE_JOINS_SPEECH")
		end


	DebugMessage("Begin_GC SA Campaign Finished")
	ScriptExit()
  elseif message == OnUpdate then
	DebugMessage("Begin_GC SA Campaign Updated")
  end
end

function Initialize(message)
    if message == OnEnter then
		crossplot:galactic()
		crossplot:publish("NR_ADMIRAL_DECREMENT", 2, 1)
	else
		crossplot:update()
    end
end
