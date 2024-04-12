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
--*   @Date:                2017-11-24T12:43:51+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            GCShadowHandCampaign.lua
--*   @Last modified by:
--*   @Last modified time:  2018-02-03T12:22:17-05:00
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

  StoryModeEvents =
    {
	  Determine_Faction_LUA = Find_Faction,
	  Rogue_Disappearance = Kill_Rogues,
	  Requiem_Appears = Requiem_Spawn,
	  NR_Builds_Lusankya = NR_Lusankya,
	  Isard_Takes_Lusankya = CH_Lusankya,
	  Delayed_Initialize = Initialize
    }

end

function Find_Faction(message)
  if message == OnEnter then

    local p_newrep = Find_Player("Rebel")
    local p_empire = Find_Player("Empire")
   

    if p_newrep.Is_Human() then
      Story_Event("ENABLE_BRANCH_NEWREP_FLAG")
    elseif p_empire.Is_Human() then
      Story_Event("ENABLE_BRANCH_EMPIRE_FLAG")
    end
  end
end

function Initialize(message)
    if message == OnEnter then
		crossplot:galactic()
		crossplot:publish("INITIALIZE_AI", "empty")
		crossplot:publish("NR_ADMIRAL_DECREMENT", {10, 10, 10}, 0)
		crossplot:publish("NR_ADMIRAL_LOCKIN", {"Ackbar", "Vantai", "Iblis", "Ragab"}, 1)
		crossplot:publish("NR_ADMIRAL_LOCKIN", {"Cracken"}, 2)
		Set_Fighter_Hero("WEDGE_ANTILLES_ROGUE_TEAM", "BELL_SWIFT_LIBERTY")
		
		Set_Fighter_Hero("SALM_B-WING_SQUADRON", "VANTAI_MOONSHADOW")
		Clear_Fighter_Hero("SALM_Y-WING_SQUADRON")
		crossplot:publish("NR_FILTER_REMOVE", {"SalmY_Location_Set","Ranulf_Trommer_Location_Set"}, 2)
		crossplot:publish("NR_FILTER_ADD", {"SalmB_Location_Set"}, 2)
	else
		crossplot:update()
    end
end

function Kill_Rogues(message)
	if message == OnEnter then
		local p_rebel = Find_Player("Rebel")
		
		crossplot:publish("NR_FILTER_REMOVE", {"Wedge_Rogues_Location_Set"}, 2)
		Clear_Fighter_Hero("WEDGE_ANTILLES_ROGUE_TEAM")
	else
		crossplot:update()
	end
end

function Requiem_Spawn(message)
  if message == OnEnter then

    local p_rebel = Find_Player("Rebel")
    local start_planet = FindPlanet("Ciutric")

    if not StoryUtil.CheckFriendlyPlanet(start_planet,p_rebel) then
		start_planet = StoryUtil.FindFriendlyPlanet(p_rebel)
	end

    local spawn_list_requiem = { "Requiem_Squadron_Space" }
    local RequiemSpawn = SpawnList(spawn_list_requiem, start_planet, p_rebel,false,false)

  end
end

function NR_Lusankya(message)
  if message == OnEnter then

     p_rebel = Find_Player("Rebel")
     start_planet = FindPlanet("Bilbringi")

    if not StoryUtil.CheckFriendlyPlanet(start_planet,p_rebel) then
		start_planet = StoryUtil.FindFriendlyPlanet(p_rebel)
	end

    local spawn_list_lusankya = { "Wedge_Lusankya" }
    local LusankyaSpawn = SpawnList(spawn_list_lusankya, start_planet, p_rebel,false,false)

  end
end

function CH_Lusankya(message)
  if message == OnEnter then

    local p_empire = Find_Player("Empire")
    local start_planet = FindPlanet("Bilbringi")

    if not StoryUtil.CheckFriendlyPlanet(start_planet,p_empire) then
		start_planet = StoryUtil.FindFriendlyPlanet(p_empire)
	end

    local spawn_list_lusankya = { "Isard_Lusankya", "TIE_Defender_Squadron_Buildable", "TIE_Defender_Squadron_Buildable" }
    local LusankyaSpawn = SpawnList(spawn_list_lusankya, start_planet, p_empire,false,false)

  end
end