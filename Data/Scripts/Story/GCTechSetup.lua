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

ModContentLoader = require("eawx-std/ModContentLoader")
CONSTANTS = ModContentLoader.get("GameConstants")
require("TRCommands")

function Definitions()

	DebugMessage("%s -- In Definitions", tostring(Script))

	StoryModeEvents = { Tech_Check = Set_Tech }
end

function Set_Tech(message)
  if message == OnEnter then


	liveFactionTable = CreateFactionTable(CONSTANTS.ALL_FACTIONS_NOT_NEUTRAL)

	for _, faction in pairs(liveFactionTable) do
		if faction.Is_Human() then
			credits = faction.Get_Credits()
			break
		end
	end

	local era = (credits / 1000) + 1

		if era >= 8 then
			era = 7
		end

	if Find_Player("Zsinj_Empire").Is_Human() then
		if era >= 2 then
			era = 2
		end
	elseif Find_Player("Pentastar").Is_Human() then
		if era >= 6 then
			era = 6
		end
	elseif Find_Player("Eriadu_Authority").Is_Human() then
		if era >= 6 then
			era = 6
		end
	elseif Find_Player("Greater_Maldrood").Is_Human() then
		if era >= 6 then
			era = 6
		end
	end

	GlobalValue.Set("CURRENT_ERA", era)

  elseif message == OnUpdate then
	ScriptExit()
  end
end

