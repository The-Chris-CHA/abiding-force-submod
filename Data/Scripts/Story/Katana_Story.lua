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
--*   @Date:                2017-08-20T21:31:11+02:00
--*   @Project:             Imperial Civil War
--*   @Filename:            Katana_Story.lua
--*   @Last modified by:    [TR]Pox
--*   @Last modified time:  2017-12-21T12:40:57+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



require("PGStoryMode")
require("PGSpawnUnits")
require("PGMoveUnits")



function Definitions()

	DebugMessage("%s -- In Definitions", tostring(Script))

	StoryModeEvents =
	{
		Battle_Start = Begin_Battle,
		Reinforcements_Appear = Spawn_Reinforcents,
		STORY_VICTORY_Player = Return_Katana_Count
	}



	marker_list = {}
	mission_started = false
	start_speech_trigger = "START_SPEECH"
	end_speech_trigger = "END_SPEECH"
	Reinforce_List = {}
end


function Begin_Battle(message)
	if message == OnEnter then
		DebugMessage("KatanaFleet Begin_Battle Started")
		empire = Find_Player("Empire")
		rebels = Find_Player("Rebel")
		eoth = Find_Player("EmpireoftheHand")
		pentastar = Find_Player("Pentastar")
		zsinj = Find_Player("Zsinj_Empire")
		maldrood = Find_Player("Greater_Maldrood")
		eriadu = Find_Player("Eriadu_Authority")
		csa = Find_Player("Corporate_Sector")
		hapans = Find_Player("Hapes_Consortium")
		hutts = Find_Player("Hutt_Cartels")
		corellians = Find_Player("Corellia")
		chiss = Find_Player("Chiss")
		yevetha = Find_Player("Yevetha")
		ssi = Find_Player("SsiRuuvi_Imperium")
		killiks = Find_Player("Killik_Hives")
		hostile = Find_Player("Hostile")
		pirates = Find_Player("Warlords")
			
		rebels.Make_Ally(pirates)
		hostile.Make_Ally(pirates)
		empire.Make_Ally(pirates)
		eoth.Make_Ally(pirates)
		pentastar.Make_Ally(pirates)
		zsinj.Make_Ally(pirates)
		maldrood.Make_Ally(pirates)
		eriadu.Make_Ally(pirates)
		csa.Make_Ally(pirates)
		hapans.Make_Ally(pirates)
		hutts.Make_Ally(pirates)
		corellians.Make_Ally(pirates)
		chiss.Make_Ally(pirates)
		yevetha.Make_Ally(pirates)
		ssi.Make_Ally(pirates)
		killiks.Make_Ally(pirates)
		
		pirates.Make_Ally(empire)
		pirates.Make_Ally(rebels)
		pirates.Make_Ally(hostile)
		pirates.Make_Ally(eoth)
		pirates.Make_Ally(pentastar)
		pirates.Make_Ally(zsinj)
		pirates.Make_Ally(maldrood)
		pirates.Make_Ally(eriadu)
		pirates.Make_Ally(csa)
		pirates.Make_Ally(hapans)
		pirates.Make_Ally(hutts)
		pirates.Make_Ally(corellians)
		pirates.Make_Ally(chiss)
		pirates.Make_Ally(yevetha)
		pirates.Make_Ally(ssi)
		pirates.Make_Ally(killiks)
		
		entry_marker = Find_First_Object("Attacker Entry Position")
		defender_marker = Find_First_Object("Defending Forces Position")
		reb_boarders = {"Gallofree_Transport", "Gallofree_Transport", "Gallofree_Transport"}
		imp_boarders = {"Imperial_Landing_Craft", "Imperial_Landing_Craft", "Imperial_Landing_Craft"}
		
		reb_enemy = {"Alliance_Assault_Frigate", "Alliance_Assault_Frigate", "Quasar", "Katana_Dreadnaught_Rebel", "Alliance_Assault_Frigate", "Alliance_Assault_Frigate", "Quasar", "Katana_Dreadnaught_Rebel", "MC80B", "Calamari_Cruiser"}
		imp_enemy = {"Generic_Star_Destroyer_Two", "Generic_Procursator", "Carrack_Cruiser", "Carrack_Cruiser", "Generic_Star_Destroyer_Two", "Generic_Procursator", "Carrack_Cruiser", "Carrack_Cruiser"}

		reb_reinforce = {"Alliance_Assault_Frigate", "Alliance_Assault_Frigate", "Quasar", "Katana_Dreadnaught_Rebel", "MC80B"}
		imp_reinforce = {"Generic_Star_Destroyer_Two", "Generic_Procursator", "Carrack_Cruiser", "Carrack_Cruiser"}

		player_list = nil
		enemy_list = nil
		player = nil

		if empire.Is_Human() then
			player_list = imp_boarders
			enemy_list = reb_enemy
			player = empire
			start_speech_trigger = "START_SPEECH_IR"
			end_speech_trigger = "END_SPEECH_IR"
			Reinforce_List = reb_reinforce
		elseif rebels.Is_Human() then
			player = rebels
			player_list = reb_boarders
			enemy_list = imp_enemy
			start_speech_trigger = "START_SPEECH_NR"
			end_speech_trigger = "END_SPEECH_NR"
			Reinforce_List = imp_reinforce
		elseif eoth.Is_Human() then
			player_list = imp_boarders
			enemy_list = reb_enemy
			player = eoth
			start_speech_trigger = "START_SPEECH_EOTH"
			end_speech_trigger = "END_SPEECH_EOTH"
			Reinforce_List = reb_reinforce
		elseif pentastar.Is_Human() then
			player_list = imp_boarders
			enemy_list = reb_enemy
			player = pentastar
			start_speech_trigger = "START_SPEECH_PA"
			end_speech_trigger = "END_SPEECH_PA"
			Reinforce_List = reb_reinforce
		elseif zsinj.Is_Human() then
			player_list = imp_boarders
			enemy_list = reb_enemy
			player = zsinj
			start_speech_trigger = "START_SPEECH_ZE"
			end_speech_trigger = "END_SPEECH_ZE"
			Reinforce_List = reb_reinforce
		elseif maldrood.Is_Human() then
			player_list = imp_boarders
			enemy_list = reb_enemy
			player = maldrood
			start_speech_trigger = "START_SPEECH_GM"
			end_speech_trigger = "END_SPEECH_GM"
			Reinforce_List = reb_reinforce
		elseif eriadu.Is_Human() then
			player_list = imp_boarders
			enemy_list = reb_enemy
			player = eriadu
			start_speech_trigger = "START_SPEECH_EA"
			end_speech_trigger = "END_SPEECH_EA"
			Reinforce_List = reb_reinforce
		elseif csa.Is_Human() then
			player_list = reb_boarders
			enemy_list = imp_enemy
			player = csa
			start_speech_trigger = "START_SPEECH_CSA"
			end_speech_trigger = "END_SPEECH_CSA"
			Reinforce_List = imp_reinforce
		elseif hapans.Is_Human() then
			player_list = reb_boarders
			enemy_list = imp_enemy
			player = hapans
			start_speech_trigger = "START_SPEECH_HAPES"
			end_speech_trigger = "END_SPEECH_HAPES"
			Reinforce_List = imp_reinforce
		elseif hutts.Is_Human() then
			player_list = reb_boarders
			enemy_list = reb_enemy
			player = hutts
			start_speech_trigger = "START_SPEECH_HUTTS"
			end_speech_trigger = "END_SPEECH_HUTTS"
			Reinforce_List = reb_reinforce
		elseif corellians.Is_Human() then
			player_list = reb_boarders
			enemy_list = imp_enemy
			player = corellians
			start_speech_trigger = "START_SPEECH_CORELLIA"
			end_speech_trigger = "END_SPEECH_CORELLIA"
			Reinforce_List = imp_reinforce
		elseif chiss.Is_Human() then
			player_list = imp_boarders
			enemy_list = reb_enemy
			player = chiss
			start_speech_trigger = "START_SPEECH_CHISS"
			end_speech_trigger = "END_SPEECH_CHISS"
			Reinforce_List = reb_reinforce
		elseif yevetha.Is_Human() then
			player_list = imp_boarders
			enemy_list = reb_enemy
			player = yevetha
			start_speech_trigger = "START_SPEECH_YEVETHA"
			end_speech_trigger = "END_SPEECH_YEVETHA"
			Reinforce_List = reb_reinforce
		elseif ssi.Is_Human() then
			player_list = reb_boarders
			enemy_list = imp_enemy
			player = ssi
			start_speech_trigger = "START_SPEECH_SSI"
			end_speech_trigger = "END_SPEECH_SSI"
			Reinforce_List = imp_reinforce
		elseif killiks.Is_Human() then
			player_list = reb_boarders
			enemy_list = imp_enemy
			player = killiks
			start_speech_trigger = "START_SPEECH_KILLIK"
			end_speech_trigger = "END_SPEECH_KILLIK"
			Reinforce_List = imp_reinforce
		end
		
		plot = Get_Story_Plot("Tactical_Katana.XML")
		
		event = plot.Get_Event("INCREMENT_FLAG_Katana_Count")
		
		if table.getn(Find_All_Objects_Of_Type(player))== 0 then --The AI took Katana Space, exit the battle
			event.Set_Reward_Parameter(1, 10)
			GlobalValue.Set("KATANA_CAPTURES", 10)
			Story_Event("NO_PLAYER_TEXT")
			Sleep(15)
			--force wins for the appropriate ai player
			if table.getn(Find_All_Objects_Of_Type(empire)) > 0 then
				Story_Event("EMPIRE_LOSE")
			elseif table.getn(Find_All_Objects_Of_Type(rebels)) > 0 then
				Story_Event("REBEL_LOSE")
			elseif table.getn(Find_All_Objects_Of_Type(eoth)) > 0 then
				Story_Event("EOTH_LOSE")
			elseif table.getn(Find_All_Objects_Of_Type(pentastar)) > 0 then
				Story_Event("PA_LOSE")
			elseif table.getn(Find_All_Objects_Of_Type(zsinj)) > 0 then
				Story_Event("ZSINJ_LOSE")
			elseif table.getn(Find_All_Objects_Of_Type(maldrood)) > 0 then
				Story_Event("GM_LOSE")
			elseif table.getn(Find_All_Objects_Of_Type(eriadu)) > 0 then
				Story_Event("EA_LOSE")
			elseif table.getn(Find_All_Objects_Of_Type(csa)) > 0 then
				Story_Event("CSA_LOSE")
			elseif table.getn(Find_All_Objects_Of_Type(hapans)) > 0 then
				Story_Event("HAPES_LOSE")
			elseif table.getn(Find_All_Objects_Of_Type(hutts)) > 0 then
				Story_Event("HUTTS_LOSE")
			elseif table.getn(Find_All_Objects_Of_Type(corellians)) > 0 then
				Story_Event("CORELLIANS_LOSE")
			elseif table.getn(Find_All_Objects_Of_Type(chiss)) > 0 then
				Story_Event("CHISS_LOSE")
			elseif table.getn(Find_All_Objects_Of_Type(yevetha)) > 0 then
				Story_Event("YEVETHA_LOSE")
			elseif table.getn(Find_All_Objects_Of_Type(ssi)) > 0 then
				Story_Event("SSIRUUVI_LOSE")
			elseif table.getn(Find_All_Objects_Of_Type(killiks)) > 0 then
				Story_Event("KILLIKS_LOSE")
			else --failback, which kills the fleet and doesn't give them the bonus dreadnaughts
				Story_Event("GENERIC_LOSE")
			end
			ScriptExit()
		end

		boarder_list = SpawnList(player_list, entry_marker, player, false, true)
		
		defender_list = SpawnList(enemy_list, defender_marker, hostile, true, true)






		for j, unit in pairs(boarder_list) do
			Register_Prox(unit, Take_Over_Katana, 200, Find_Player("Neutral"))

		end


		--spawn = Find_First_Object("STORY_TRIGGER_ZONE_00")

		--Spawn_Unit(Find_Object_Type("Katana_Dreadnaught"), spawn, Find_Player("Neutral"))
		list = Find_All_Objects_Of_Type("Katana_Dreadnaught")

		current_cinematic_thread = Create_Thread("Intro_Cinematic")
		mission_started = true
		DebugMessage("KatanaFleet Begin_Battle Finished")
	end
end

function Spawn_Reinforcents(message)
	if message == OnEnter then
		hostile = Find_Player("Hostile")
		reinforce_list = SpawnList(Reinforce_List, Find_First_Object("Attacker Entry Position"), hostile, true, true)
	end
end

function Return_Katana_Count(message)
	if message == OnEnter then
		DebugMessage("KatanaFleet Return_Katana_Count Started")
		reb_katana = {}
		katana_list = Find_All_Objects_Of_Type("Katana_Dreadnaught")
		for i, obj in pairs(katana_list) do
			if obj.Get_Owner() == player then
				table.insert(reb_katana, obj)

			end
		end
		event.Set_Reward_Parameter(1, table.getn(reb_katana))
		Story_Event("INCREMENT_KATANA_COUNT")
		GlobalValue.Set("KATANA_CAPTURES", table.getn(reb_katana))
		DebugMessage("KatanaFleet Return_Katana_Count Finished")

	end
end



function Take_Over_Katana(self_obj, trigger_obj)
	DebugMessage("KatanaFleet Take_Over_Katana Started")
	for j, obj in pairs(list) do
		if trigger_obj == obj then

			table.remove(list, j)
			trigger_obj.Change_Owner(pirates)

			self_obj.Stop()
			self_obj.Suspend_Locomotor(true)
			if self_obj.Get_Owner().Is_Human() then
				Story_Event("BOARDING_KATANA_TEXT")
			end
			unit_list = {self_obj, trigger_obj}
			Create_Thread("ChangeKatanaOwner",unit_list)



		end
	end
	DebugMessage("KatanaFleet Take_Over_Katana Finished")
end





function ChangeKatanaOwner(unit_list)
	DebugMessage("KatanaFleet ChangeKatanaOwner Started")
	Sleep(15)

	if TestValid(unit_list[1]) then

		if unit_list[1].Get_Owner().Is_Human() then
			Story_Event("BOARDING_SUCCESSFUL_TEXT")
		end
		unit_list[1].Suspend_Locomotor(false)
		unit_list[2].Change_Owner(unit_list[1].Get_Owner())

	end
	DebugMessage("KatanaFleet ChangeKatanaOwner Finished")
end




function Intro_Cinematic()
	DebugMessage("KatanaFleet ChangeKatanaOwner Started")

	Fade_Screen_Out(.5)
	Suspend_AI(1)
	Lock_Controls(1)
	Letter_Box_In(0)

	Start_Cinematic_Camera()

	-- camera location	object	   x     y     z   + not so important stuff
	Set_Cinematic_Camera_Key(list[1], 1500, 120, 30, 1, 0, 0, 0)

	-- object the camera points at     x  y  z  blabla
	Set_Cinematic_Target_Key(list[1], 0, 0, 0, 0, 0, 0, 0)

	Fade_Screen_In(3)
	Story_Event(start_speech_trigger)

	Sleep(9)

	Transition_Cinematic_Target_Key(boarder_list[1], 5, 0, 0, 0, 0, 0, 1, 0)
	Transition_Cinematic_Camera_Key(boarder_list[1], 5, 600, 10, 30, 1, 0, 1, 0)

	Sleep(9)


	Transition_To_Tactical_Camera(1)

	Story_Event(end_speech_trigger)
    	Letter_Box_Out(1)
	Sleep(1)
    	End_Cinematic_Camera()
    	Fade_Screen_In(.5)
	Lock_Controls(0)
	Suspend_AI(0)
	DebugMessage("KatanaFleet ChangeKatanaOwner Finished")
end


function Story_Handle_Esc()
	DebugMessage("KatanaFleet Story_Handle_Esc Started")
  	if current_cinematic_thread ~= nil then
		Thread.Kill(current_cinematic_thread)
		current_cinematic_thread = nil

    		Letter_Box_Out(0)
		End_Cinematic_Camera()
		Lock_Controls(0)
		Suspend_AI(0)


	end
	DebugMessage("KatanaFleet Story_Handle_Esc Finished")
end
