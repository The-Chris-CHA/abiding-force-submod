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
--*   @Filename:            GCDeltaSource.lua
--*   @Last modified by:    Jorritkarwehr
--*   @Last modified time:  2017-12-21T12:39:33+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



require("PGBase")
require("PGStateMachine")
require("PGStoryMode")
require("PGSpawnUnits")

function Definitions()

	DebugMessage("%s -- In Definitions", tostring(Script))
	
	StoryModeEvents =
	{
		Start_Chain = Chain_Start,
		Empire_wins_Coruscant = Spawn_Empire_Reward,
	}

end

function Spawn_Empire_Reward(message)
    if message == OnEnter then
        local p_empire = Find_Player("Empire")
        local start_planet = FindPlanet("Coruscant")

        spawn_list_coruscant = {
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
            "Generic_Victory_Destroyer"
        }
        CoruscantSpawn = SpawnList(spawn_list_coruscant, start_planet, p_empire, false, false)
    end
end

function Chain_Start(message)
  if message == OnEnter then
	local p_NR = Find_Player("Rebel")
	local start_planet = FindPlanet("Coruscant")
	
	if p_NR.Is_Human() and start_planet.Get_Owner() == p_NR then
		Story_Event("CORUSCANT_EVAC_START")
	end
  end
end