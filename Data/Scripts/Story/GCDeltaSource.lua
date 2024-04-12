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
		Spawn_Delta = Place_Informant,
		Select_Coruscant = Trigger_Speech
	}

end

function Place_Informant(message)
  if message == OnEnter then
	DeltaLoop()
  elseif message == OnUpdate then

  end
end

function DeltaLoop()
		local checkObject = Find_First_Object("Thrawn_Chimaera")
		
		local p_empire = Find_Player("Empire")

		start_planet = FindPlanet("Coruscant")
		
		if TestValid(checkObject) then	--Require Thrawn to be alive since he's the only one who had the codes. Plus this will exit the loop after era 2
			if start_planet.Get_Owner() ~= p_empire then --This abilitiy can't fire on your own planets, instead giving free probe droid spawns
				local probe_type = Find_Object_Type("Probe_Droid_Team")
				local probe_list = Spawn_Unit(probe_type, start_planet, p_empire)
				local probe_fleet = Assemble_Fleet(probe_list)
				probe_fleet.Activate_Ability("Probe_Droid_Team")
			end
		else
			ScriptExit()
		end
	Register_Timer(DeltaLoop, 230)
end

function Trigger_Speech(message)
  if message == OnEnter then
  
	local checkObject = Find_First_Object("Thrawn_Chimaera")
  
	local p_empire = Find_Player("Empire")
	
	local start_planet = FindPlanet("Coruscant")

	if TestValid(checkObject) and p_empire.Is_Human() then
		if start_planet.Get_Owner() ~= p_empire then
			Story_Event("DELTA_SPEECH")
		end
	end
  end
end