--////////////////////////////////////////////////
-- Katana Mission (New Republic)
--////////////////////////////////////////////////

require("PGStoryMode")
require("PGSpawnUnits")
require("PGMoveUnits")



function Definitions()

	DebugMessage("%s -- In Definitions", tostring(Script))
	
	StoryModeEvents = 
	{
		Battle_Start = Begin_Battle,
		Imps_Enter_System = First_Wave,
		Wave2_Spawn = More_Foes,
		Wave3_Spawn = Moar_Foes,
	}

	invaders = Find_Player("Hostile")
	empire = Find_Player("Empire")
	rebels = Find_Player("Rebel")

	intro_skipped = false
	mission_started = false

end

function Begin_Battle(message)
	if message == OnEnter then

		evil_1 = Find_Hint("STORY_TRIGGER_ZONE_00","entry1")
		evil_2 = Find_Hint("STORY_TRIGGER_ZONE_00","entry2")
		evil_3 = Find_Hint("STORY_TRIGGER_ZONE_00","entry3")
		evil_4 = Find_Hint("STORY_TRIGGER_ZONE_00","entry4")
		evil_5 = Find_Hint("STORY_TRIGGER_ZONE_00","entry5")
		evil_6 = Find_Hint("STORY_TRIGGER_ZONE_00","entry6")
		evil_7 = Find_Hint("STORY_TRIGGER_ZONE_00","entry7")
		evil_8 = Find_Hint("STORY_TRIGGER_ZONE_00","entry8")
		evil_9 = Find_Hint("STORY_TRIGGER_ZONE_00","entry9")
		evil_10 = Find_Hint("STORY_TRIGGER_ZONE_00","entry10")
		evil_11 = Find_Hint("STORY_TRIGGER_ZONE_00","entry11")
		evil_12 = Find_Hint("STORY_TRIGGER_ZONE_00","entry12")
		evil_13 = Find_Hint("STORY_TRIGGER_ZONE_00","entry13")
		evil_14 = Find_Hint("STORY_TRIGGER_ZONE_00","entry14")
		evil_15 = Find_Hint("STORY_TRIGGER_ZONE_00","entry15")
		evil_16 = Find_Hint("STORY_TRIGGER_ZONE_00","entry16")
		evil_17 = Find_Hint("STORY_TRIGGER_ZONE_00","entry17")
		evil_18 = Find_Hint("STORY_TRIGGER_ZONE_00","entry18")
		evil_19 = Find_Hint("STORY_TRIGGER_ZONE_00","entry19")
		evil_20 = Find_Hint("STORY_TRIGGER_ZONE_00","entry20")

		entry_marker = Find_First_Object("Attacker Entry Position")
		defender_entry_marker = Find_First_Object("Defending Forces Position")

		mission_started = true
		current_cinematic_thread = Create_Thread("Start_Cinematic_Intro")
	end
end

function Start_Cinematic_Intro ()

	Start_Cinematic_Camera()
	Suspend_AI(1)
	Lock_Controls(1)
	Fade_Screen_In(5)

	Stop_All_Music()
	Cancel_Fast_Forward()

	Set_Cinematic_Camera_Key(defender_entry_marker, 1800, 40, 0, 1, 0, 0, 0)
	Set_Cinematic_Target_Key(evil_20, 0, 0, 0, 0, 0, 0, 0) Sleep(1.0)

	Transition_Cinematic_Camera_Key(evil_3, 16, 400, 20, 0, 1, 0, 0, 0)
	Transition_Cinematic_Target_Key(evil_3, 10, 0, 0, 0, 0, 0, 0, 0) Sleep(2.5)

	Fade_Screen_Out(4) Sleep(2.5) Point_Camera_At(defender_entry_marker)
	Set_Cinematic_Camera_Key(defender_entry_marker, 2800, 200, 155, 1, 0, 0, 0)
	Set_Cinematic_Target_Key(defender_entry_marker, 0, 0, 0, 0, 0, 0, 0)
	Fade_Screen_In(4) Play_Music("Evacuation_of_Coruscant_Music_Event")

	Sleep(2) Letter_Box_In(3) Sleep(1) Story_Event("BEGIN_BRIEFING_OSH") Sleep(5.5)

	Story_Event("NEXT_BRIEFING_OSH") Sleep(5.5)

	Transition_Cinematic_Camera_Key(evil_17, 6, 500, 100, 45, 1, 0, 0, 0)
	Sleep(3) Transition_Cinematic_Target_Key(evil_19, 4, 0, 0, 40, 0, 0, 0, 0)
	Story_Event("END_BRIEFING_OSH")

	Transition_Cinematic_Camera_Key(evil_17, 5, 800, 80, 10, 1, 0, 0, 0)
	Transition_Cinematic_Target_Key(defender_entry_marker, 4, 0, 0, 40, 0, 0, 0, 0)
	Sleep(4.5) Create_Thread("End_Camera")

end

function Story_Handle_Esc()
	if current_cinematic_thread ~= nil then
		Thread.Kill(current_cinematic_thread)
		current_cinematic_thread = nil
		Stop_All_Speech()
		Remove_All_Text()
		intro_skipped = true
		Create_Thread("End_Camera")
	end 
end

function End_Camera()
	if intro_skipped then
		Fade_Screen_In(.1)
		Story_Event("END_BRIEFING_OSH")
		end

	Point_Camera_At(defender_entry_marker)
	Transition_To_Tactical_Camera(4)
	Sleep(4.3) Letter_Box_Out(3) Suspend_AI(0)
	Sleep(1.4)
	End_Cinematic_Camera()
	Lock_Controls(0)
end

function First_Wave(message)
	if message == OnEnter then

		local invaders = Find_Player("Hostile")

		Resume_Hyperspace_In()

		invader1 = Spawn_Unit(Find_Object_Type("Skirmish_Star_Destroyer_Two"), evil_1, invaders)
		invader1 = Find_Nearest(evil_1, invaders, true)
		invader1.Teleport_And_Face(evil_1)
		invader1.Cinematic_Hyperspace_In(350)

		invader2 = Spawn_Unit(Find_Object_Type("Skirmish_MTC_Support"), evil_2, invaders)
		invader2 = Find_Nearest(evil_2, invaders, true)
		invader2.Teleport_And_Face(evil_2)
		invader2.Cinematic_Hyperspace_In(350)

		invader3 = Spawn_Unit(Find_Object_Type("Skirmish_Dreadnaught_Empire"), evil_3, invaders)
		invader3 = Find_Nearest(evil_3, invaders, true)
		invader3.Teleport_And_Face(evil_3)
		invader3.Cinematic_Hyperspace_In(350)

		invader4 = Spawn_Unit(Find_Object_Type("Skirmish_Victory_Destroyer"), evil_4, invaders)
		invader4 = Find_Nearest(evil_4, invaders, true)
		invader4.Teleport_And_Face(evil_4)
		invader4.Cinematic_Hyperspace_In(350)

		invader5 = Spawn_Unit(Find_Object_Type("Skirmish_Vindicator_Cruiser"), evil_5, invaders)
		invader5 = Find_Nearest(evil_5, invaders, true)
		invader5.Teleport_And_Face(evil_5)
		invader5.Cinematic_Hyperspace_In(350)

		invader6 = Spawn_Unit(Find_Object_Type("Skirmish_Carrack_Cruiser"), evil_6, invaders)
		invader6 = Find_Nearest(evil_6, invaders, true)
		invader6.Teleport_And_Face(evil_6)
		invader6.Cinematic_Hyperspace_In(350)

		invader7 = Spawn_Unit(Find_Object_Type("Skirmish_Lancer_Frigate"), evil_7, invaders)
		invader7 = Find_Nearest(evil_7, invaders, true)
		invader7.Teleport_And_Face(evil_7)
		invader7.Cinematic_Hyperspace_In(350)

		invader8 = Spawn_Unit(Find_Object_Type("Skirmish_Tartan_Patrol_Cruiser"), evil_8, invaders)
		invader8 = Find_Nearest(evil_8, invaders, true)
		invader8.Teleport_And_Face(evil_8)
		invader8.Cinematic_Hyperspace_In(350)

		invader9 = Spawn_Unit(Find_Object_Type("Skirmish_Procursator"), evil_9, invaders)
		invader9 = Find_Nearest(evil_9, invaders, true)
		invader9.Teleport_And_Face(evil_9)
		invader9.Cinematic_Hyperspace_In(350)

		invader10 = Spawn_Unit(Find_Object_Type("Skirmish_Procursator"), evil_10, invaders)
		invader10 = Find_Nearest(evil_10, invaders, true)
		invader10.Teleport_And_Face(evil_10)
		invader10.Cinematic_Hyperspace_In(350)

		invader11 = Spawn_Unit(Find_Object_Type("Skirmish_Strike_Cruiser"), evil_11, invaders)
		invader11 = Find_Nearest(evil_11, invaders, true)
		invader11.Teleport_And_Face(evil_11)
		invader11.Cinematic_Hyperspace_In(350)

		invader12 = Spawn_Unit(Find_Object_Type("Skirmish_Gladiator"), evil_12, invaders)
		invader12 = Find_Nearest(evil_12, invaders, true)
		invader12.Teleport_And_Face(evil_12)
		invader12.Cinematic_Hyperspace_In(350)

		invader13 = Spawn_Unit(Find_Object_Type("Skirmish_Gladiator"), evil_13, invaders)
		invader13 = Find_Nearest(evil_13, invaders, true)
		invader13.Teleport_And_Face(evil_13)
		invader13.Cinematic_Hyperspace_In(350)

		invader14 = Spawn_Unit(Find_Object_Type("Skirmish_Secutor"), evil_19, invaders)
		invader14 = Find_Nearest(evil_19, invaders, true)
		invader14.Teleport_And_Face(evil_19)
		invader14.Cinematic_Hyperspace_In(350)

		invader15 = Spawn_Unit(Find_Object_Type("Skirmish_Allegiance"), evil_20, invaders)
		invader15 = Find_Nearest(evil_20, invaders, true)
		invader15.Teleport_And_Face(evil_20)
		invader15.Cinematic_Hyperspace_In(350)

	end
end

function More_Foes(message)
	if message == OnEnter then

		invader_1 = Spawn_Unit(Find_Object_Type("Skirmish_Star_Destroyer_Two"), evil_1, invaders)
		invader_1 = Find_Nearest(evil_1, invaders, true)
		invader_1.Teleport_And_Face(evil_1)
		invader_1.Cinematic_Hyperspace_In(350)

		invader_2 = Spawn_Unit(Find_Object_Type("Skirmish_Praetor"), evil_2, invaders)
		invader_2 = Find_Nearest(evil_2, invaders, true)
		invader_2.Teleport_And_Face(evil_2)
		invader_2.Cinematic_Hyperspace_In(350)

		invader_3 = Spawn_Unit(Find_Object_Type("Skirmish_MTC_Support"), evil_3, invaders)
		invader_3 = Find_Nearest(evil_3, invaders, true)
		invader_3.Teleport_And_Face(evil_3)
		invader_3.Cinematic_Hyperspace_In(350)

		invader_4 = Spawn_Unit(Find_Object_Type("Skirmish_MTC_Support"), evil_4, invaders)
		invader_4 = Find_Nearest(evil_4, invaders, true)
		invader_4.Teleport_And_Face(evil_4)
		invader_4.Cinematic_Hyperspace_In(350)

		invader_5 = Spawn_Unit(Find_Object_Type("Skirmish_Dreadnaught_Empire"), evil_5, invaders)
		invader_5 = Find_Nearest(evil_5, invaders, true)
		invader_5.Teleport_And_Face(evil_5)
		invader_5.Cinematic_Hyperspace_In(350)

		invader_6 = Spawn_Unit(Find_Object_Type("Skirmish_Lancer_Frigate"), evil_6, invaders)
		invader_6 = Find_Nearest(evil_6, invaders, true)
		invader_6.Teleport_And_Face(evil_6)
		invader_6.Cinematic_Hyperspace_In(350)

		invader_7 = Spawn_Unit(Find_Object_Type("Skirmish_Victory_Destroyer_Two"), evil_7, invaders)
		invader_7 = Find_Nearest(evil_7, invaders, true)
		invader_7.Teleport_And_Face(evil_7)
		invader_7.Cinematic_Hyperspace_In(350)

		invader_8 = Spawn_Unit(Find_Object_Type("Skirmish_Victory_Destroyer_Two"), evil_8, invaders)
		invader_8 = Find_Nearest(evil_8, invaders, true)
		invader_8.Teleport_And_Face(evil_8)
		invader_8.Cinematic_Hyperspace_In(350)

		invader_9 = Spawn_Unit(Find_Object_Type("Skirmish_Star_Destroyer"), evil_9, invaders)
		invader_9 = Find_Nearest(evil_9, invaders, true)
		invader_9.Teleport_And_Face(evil_9)
		invader_9.Cinematic_Hyperspace_In(350)

		invader_10 = Spawn_Unit(Find_Object_Type("Skirmish_Strike_Cruiser"), evil_10, invaders)
		invader_10 = Find_Nearest(evil_10, invaders, true)
		invader_10.Teleport_And_Face(evil_10)
		invader_10.Cinematic_Hyperspace_In(350)

		invader_11 = Spawn_Unit(Find_Object_Type("Skirmish_Strike_Cruiser"), evil_11, invaders)
		invader_11 = Find_Nearest(evil_11, invaders, true)
		invader_11.Teleport_And_Face(evil_11)
		invader_11.Cinematic_Hyperspace_In(350)

		invader_12 = Spawn_Unit(Find_Object_Type("Skirmish_Vigil"), evil_12, invaders)
		invader_12 = Find_Nearest(evil_12, invaders, true)
		invader_12.Teleport_And_Face(evil_12)
		invader_12.Cinematic_Hyperspace_In(350)

		invader_13 = Spawn_Unit(Find_Object_Type("Skirmish_Vigil"), evil_13, invaders)
		invader_13 = Find_Nearest(evil_13, invaders, true)
		invader_13.Teleport_And_Face(evil_13)
		invader_13.Cinematic_Hyperspace_In(350)

		invader_14 = Spawn_Unit(Find_Object_Type("Skirmish_IPV1"), evil_14, invaders)
		invader_14 = Find_Nearest(evil_14, invaders, true)
		invader_14.Teleport_And_Face(evil_14)
		invader_14.Cinematic_Hyperspace_In(350)

		invader_15 = Spawn_Unit(Find_Object_Type("Skirmish_Gladiator"), evil_15, invaders)
		invader_15 = Find_Nearest(evil_15, invaders, true)
		invader_15.Teleport_And_Face(evil_15)
		invader_15.Cinematic_Hyperspace_In(350)
	end
end

function Moar_Foes(message)
	if message == OnEnter then
		
		invader__1 = Spawn_Unit(Find_Object_Type("Skirmish_Gladiator"), evil_1, invaders)
		invader__1 = Find_Nearest(evil_1, invaders, true)
		invader__1.Teleport_And_Face(evil_1)
		invader__1.Cinematic_Hyperspace_In(350)
		
		invader__2 = Spawn_Unit(Find_Object_Type("Skirmish_Gladiator"), evil_2, invaders)
		invader__2 = Find_Nearest(evil_2, invaders, true)
		invader__2.Teleport_And_Face(evil_2)
		invader__2.Cinematic_Hyperspace_In(350)

		invader__3 = Spawn_Unit(Find_Object_Type("Skirmish_Dreadnaught_Empire"), evil_3, invaders)
		invader__3 = Find_Nearest(evil_3, invaders, true)
		invader__3.Teleport_And_Face(evil_3)
		invader__3.Cinematic_Hyperspace_In(350)

		invader__4 = Spawn_Unit(Find_Object_Type("Skirmish_Dreadnaught_Empire"), evil_4, invaders)
		invader__4 = Find_Nearest(evil_4, invaders, true)
		invader__4.Teleport_And_Face(evil_4)
		invader__4.Cinematic_Hyperspace_In(350)

		invader__5 = Spawn_Unit(Find_Object_Type("Skirmish_Victory_Destroyer"), evil_5, invaders)
		invader__5 = Find_Nearest(evil_5, invaders, true)
		invader__5.Teleport_And_Face(evil_5)
		invader__5.Cinematic_Hyperspace_In(350)

		invader__6 = Spawn_Unit(Find_Object_Type("Skirmish_Carrack_Cruiser"), evil_6, invaders)
		invader__6 = Find_Nearest(evil_6, invaders, true)
		invader__6.Teleport_And_Face(evil_6)
		invader__6.Cinematic_Hyperspace_In(350)

		invader__7 = Spawn_Unit(Find_Object_Type("Skirmish_Carrack_Cruiser"), evil_7, invaders)
		invader__7 = Find_Nearest(evil_7, invaders, true)
		invader__7.Teleport_And_Face(evil_7)
		invader__7.Cinematic_Hyperspace_In(350)

		invader__8 = Spawn_Unit(Find_Object_Type("Skirmish_Raider_Pentastar"), evil_8, invaders)
		invader__8 = Find_Nearest(evil_8, invaders, true)
		invader__8.Teleport_And_Face(evil_8)
		invader__8.Cinematic_Hyperspace_In(350)

		invader__9 = Spawn_Unit(Find_Object_Type("Skirmish_Lancer_Frigate"), evil_9, invaders)
		invader__9 = Find_Nearest(evil_9, invaders, true)
		invader__9.Teleport_And_Face(evil_9)
		invader__9.Cinematic_Hyperspace_In(350)

		invader__10 = Spawn_Unit(Find_Object_Type("Skirmish_Raider_Pentastar"), evil_10, invaders)
		invader__10 = Find_Nearest(evil_10, invaders, true)
		invader__10.Teleport_And_Face(evil_10)
		invader__10.Cinematic_Hyperspace_In(350)

		invader__11 = Spawn_Unit(Find_Object_Type("Skirmish_Star_Destroyer"), evil_11, invaders)
		invader__11 = Find_Nearest(evil_11, invaders, true)
		invader__11.Teleport_And_Face(evil_11)
		invader__11.Cinematic_Hyperspace_In(350)

		invader__12 = Spawn_Unit(Find_Object_Type("Skirmish_Neutron_Star"), evil_12, invaders)
		invader__12 = Find_Nearest(evil_12, invaders, true)
		invader__12.Teleport_And_Face(evil_12)
		invader__12.Cinematic_Hyperspace_In(350)

		invader__13 = Spawn_Unit(Find_Object_Type("Skirmish_Broadside_Cruiser"), evil_13, invaders)
		invader__13 = Find_Nearest(evil_13, invaders, true)
		invader__13.Teleport_And_Face(evil_13)
		invader__13.Cinematic_Hyperspace_In(350)

		invader__14 = Spawn_Unit(Find_Object_Type("Skirmish_Broadside_Cruiser"), evil_14, invaders)
		invader__14 = Find_Nearest(evil_14, invaders, true)
		invader__14.Teleport_And_Face(evil_14)
		invader__14.Cinematic_Hyperspace_In(350)

		invader__15 = Spawn_Unit(Find_Object_Type("Skirmish_Secutor"), evil_15, invaders)
		invader__15 = Find_Nearest(evil_15, invaders, true)
		invader__15.Teleport_And_Face(evil_15)
		invader__15.Cinematic_Hyperspace_In(350)
		Stop_All_Music()
		Sleep(2)
		Play_Music("Evacuation_of_Coruscant_3_Music_Event")
		Sleep(120) Resume_Mode_Based_Music()
	end
end

function spawnFleet(param)
  local self = param[1]
  self.spawnList = SpawnList(param[2], param[3], param[4], true, true)
end