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
--*   @Author:              [TR]Pox
--*   @Date:                2018-03-20T01:27:01+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            Deconstruction.lua
--*   @Last modified by:    [TR]Pox
--*   @Last modified time:  2018-03-26T09:58:14+02:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************

require("RandomReplaceSpawn")

function Definitions()
    DebugMessage("%s -- In Definitions", tostring(Script))

    Define_State("State_Init", State_Init);
end


function State_Init(message)
    if message == OnEnter then	
		PirateHeroes = {
			{"Drednar_Sable_III"},
			{"Coorshas_Cross"},
			{"Kath_Scarlet"},
			{"Entel_Night_Wind"},
			{"Slader_Raider_II"},
			{"Miktiss_Asagov_Raider"},
			{"Ardella_Smokeswimmer"},
			{"Kaerobani_Interdictor"},
			{{"Mabin_Squadron", "Mabin_Gozanti"}},
			{"Vulture_Pirates"},
			{{"Ssurussk_Nebula_Raiders", "Ssurussk"}},
			{"Barkbone_RobberBaron"},
			{"Antig_Trustworthy"}
		}
		
		Random_Replacement(Object, PirateHeroes, true)
		ScriptExit()
    end
end
