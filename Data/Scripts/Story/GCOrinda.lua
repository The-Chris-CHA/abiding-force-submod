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
--*   @Filename:            GCOrinda.lua
--*   @Last modified by:    [TR]Pox
--*   @Last modified time:  2017-12-21T12:39:24+01:00
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

  StoryModeEvents =
  {
	Determine_Faction_LUA = Find_Faction,
    Rogriss_Joins = Rogriss_Spawn,
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
		crossplot:publish("NR_ADMIRAL_DECREMENT", 2, 1)
		crossplot:publish("NR_ADMIRAL_LOCKIN", {"Bell"}, 1)
	else
		crossplot:update()
    end
end

function Rogriss_Spawn(message)
  if message == OnEnter then

    p_empire = Find_Player("Empire")
    p_rebel = Find_Player("Rebel")

    start_planet = FindPlanet("Bastion")
	
	if p_empire.Is_Human() then
  		Story_Event("ROGRISS_JOINS_SPEECH")
  	end
	
    spawn_list_Rogriss = { "Rogriss_Dominion" }
    ReaperSpawn = SpawnList(spawn_list_Rogriss, start_planet, p_empire,true,false)

	ScriptExit()
  elseif message == OnUpdate then

  end
end

