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
require("eawx-util/ChangeOwnerUtilities")

function Definitions()

	DebugMessage("%s -- In Definitions", tostring(Script))
	
	StoryModeEvents =
	{
		Unlock_Katana = Find_Faction,
		STORY_CONQUER_Katana_Space = Spawn_Katanas,
		Loser_unlock = Force_Loss
	}

end

function Find_Faction(message)
    if message == OnEnter then
        p_newrep = Find_Player("Rebel")
        p_empire = Find_Player("Empire")
        p_eoth = Find_Player("EmpireoftheHand")
        p_eriadu = Find_Player("Eriadu_Authority")
        p_pentastar = Find_Player("Pentastar")
        p_zsinj = Find_Player("Zsinj_Empire")
        p_maldrood = Find_Player("Greater_Maldrood")
        p_corporate = Find_Player("Corporate_Sector")
        p_hapes = Find_Player("Hapes_Consortium")
		p_hutts = Find_Player("Hutt_Cartels")
		p_corellians = Find_Player("Corellia")
		p_chiss = Find_Player("Chiss")
		p_yevetha = Find_Player("Yevetha")
		p_ssi = Find_Player("SsiRuuvi_Imperium")
		p_killiks = Find_Player("Killik_Hives")

        if p_newrep.Is_Human() then
            Story_Event("KATANA_SPEECH_REBEL")
        elseif p_empire.Is_Human() then
            Story_Event("KATANA_SPEECH_EMPIRE")
        elseif p_eoth.Is_Human() then
            Story_Event("KATANA_SPEECH_EOTH")
        elseif p_eriadu.Is_Human() then
            Story_Event("KATANA_SPEECH_ERIADU")
        elseif p_pentastar.Is_Human() then
            Story_Event("KATANA_SPEECH_PENTASTAR")
        elseif p_zsinj.Is_Human() then
            Story_Event("KATANA_SPEECH_ZSINJ")
        elseif p_maldrood.Is_Human() then
            Story_Event("KATANA_SPEECH_MALDROOD")
        elseif p_corporate.Is_Human() then
            Story_Event("KATANA_SPEECH_CSA")
        elseif p_hapes.Is_Human() then
            Story_Event("KATANA_SPEECH_HAPES")
		elseif p_hutts.Is_Human() then
            Story_Event("KATANA_SPEECH_HUTTS")
		elseif p_corellians.Is_Human() then
            Story_Event("KATANA_SPEECH_CORELLIA")
		elseif p_chiss.Is_Human() then
            Story_Event("KATANA_SPEECH_CHISS")
		elseif p_yevetha.Is_Human() then
            Story_Event("KATANA_SPEECH_YEVETHA")
		elseif p_ssi.Is_Human() then
            Story_Event("KATANA_SPEECH_SSI")
		elseif p_killiks.Is_Human() then
            Story_Event("KATANA_SPEECH_KILLIK")
        end
    end
end

function Spawn_Katanas(message)
    if message == OnEnter then
		local deepspace = FindPlanet("Katana_Space")
		local katana_winner = deepspace.Get_Owner()
		
		local katana_type
		
		if katana_winner == Find_Player("Rebel") or katana_winner == Find_Player("Hapes_Consortium") then
			katana_type = "Katana_Dreadnaught_Rebel"
		else
			katana_type = "Katana_Dreadnaught_Empire"
		end
		
		for i=1,GlobalValue.Get("KATANA_CAPTURES") do
			SpawnList({katana_type},deepspace, katana_winner, true, false)
		end
    end
end

function Force_Loss(message)
	if message == OnEnter then
		ChangePlanetOwnerAndRetreat(FindPlanet("Katana_Space"), Find_Player("Neutral"))
	end
end
