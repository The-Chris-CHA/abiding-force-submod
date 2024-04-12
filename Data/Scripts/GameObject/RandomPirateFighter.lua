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
--*   @Author:              [TR]Jorritkarwehr
--*   @Date:                2024-03-04T01:27:01+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            Deconstruction.lua
--*   @Last modified by:    [TR]Jorritkarwehr
--*   @Last modified time:  2024-03-04T09:58:14+02:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************

require("RandomEnable")

function Definitions()
    DebugMessage("%s -- In Definitions", tostring(Script))

    Define_State("State_Init", State_Init);
end


function State_Init(message)
    if message == OnEnter then
		PirateHeroes = {
			"Scarlet_Location_Set",
			"Ssurussk_Location_Set",
			"Stormtrooper_X_Location_Set"
		}
		
		Random_Enable(Object, PirateHeroes, "PIRATE_FIGHTERS")
		ScriptExit()
    end
end
