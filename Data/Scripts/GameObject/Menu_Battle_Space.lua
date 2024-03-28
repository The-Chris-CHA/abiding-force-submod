--***************************************************--
--*********** Main Menu Space Script ****************--
--***************************************************--

require("PGStateMachine")
require("PGStoryMode")
require("PGSpawnUnits")
require("PGMoveUnits")

function Definitions()

	DebugMessage("%s -- In Definitions", tostring(Script))

	Define_State("State_Init", State_Init)

	battle_one_active = false
	battle_two_active = false
	battle_three_active = false
	battle_four_active = false
	
	cinematic_cam_active = false

	-- Players
	p_new_republic = Find_Player("Rebel")
	p_empire = Find_Player("Empire")

end

function State_Init(message)
	if message == OnEnter then

		if Get_Game_Mode() ~= "Space" then
			return
		end

		--Phase 1 Markers
		phase_1_new_republic_ship_1_marker = Find_Hint("MARKER_GENERIC_RED", "phase_1_new_republic_ship_1")
		phase_1_new_republic_ship_2_marker = Find_Hint("MARKER_GENERIC_RED", "phase_1_new_republic_ship_2")
		phase_1_new_republic_ship_3_marker = Find_Hint("MARKER_GENERIC_RED", "phase_1_new_republic_ship_3")
		phase_1_new_republic_homeone_marker = Find_Hint("MARKER_GENERIC_RED", "phase_1_new_republic_homeone")
		phase_1_new_republic_isdii_marker = Find_Hint("MARKER_GENERIC_RED", "phase_1_new_republic_isdii")
		
		phase_1_empire_ship_1_marker = Find_Hint("MARKER_GENERIC_RED", "phase_1_empire_ship_1")
		phase_1_empire_ship_2_marker = Find_Hint("MARKER_GENERIC_RED", "phase_1_empire_ship_2")
		phase_1_empire_ship_3_marker = Find_Hint("MARKER_GENERIC_RED", "phase_1_empire_ship_3")
		phase_1_empire_golan2_1_marker = Find_Hint("MARKER_GENERIC_RED", "phase_1_empire_golan2_1")
		phase_1_empire_golan2_2_marker = Find_Hint("MARKER_GENERIC_RED", "phase_1_empire_golan2_2")
		phase_1_empire_greywolf_marker = Find_Hint("MARKER_GENERIC_RED", "phase_1_empire_greywolf")
		
		--Phase 2 Markers
		phase_2_eriadu_ship_1_marker = Find_Hint("MARKER_GENERIC_BLUE", "phase_2_eriadu_ship_1")
		phase_2_eriadu_ship_2_marker = Find_Hint("MARKER_GENERIC_BLUE", "phase_2_eriadu_ship_2")
		phase_2_eriadu_assertor_marker = Find_Hint("MARKER_GENERIC_BLUE", "phase_2_eriadu_assertor")
		
		phase_2_hapes_ship_1_marker = Find_Hint("MARKER_GENERIC_BLUE", "phase_2_hapes_ship_1")
		phase_2_hapes_ship_2_marker = Find_Hint("MARKER_GENERIC_BLUE", "phase_2_hapes_ship_2")
		phase_2_hapes_ship_3_marker = Find_Hint("MARKER_GENERIC_BLUE", "phase_2_hapes_ship_3")
		phase_2_hapes_ship_4_marker = Find_Hint("MARKER_GENERIC_BLUE", "phase_2_hapes_ship_4")
		phase_2_hapes_starbase_marker = Find_Hint("MARKER_GENERIC_BLUE", "phase_2_hapes_starbase")

		--Phase 3 Markers
		phase_3_new_republic_ship_1_marker = Find_Hint("MARKER_GENERIC_GREEN", "phase_3_new_republic_ship_1")
		phase_3_new_republic_lusankya_marker = Find_Hint("MARKER_GENERIC_GREEN", "phase_3_new_republic_lusankya")
		phase_3_new_republic_endurance_marker = Find_Hint("MARKER_GENERIC_GREEN", "phase_3_new_republic_endurance")
		
		phase_3_empire_ship_1_marker = Find_Hint("MARKER_GENERIC_GREEN", "phase_3_empire_ship_1")
		phase_3_empire_reaper_marker = Find_Hint("MARKER_GENERIC_GREEN", "phase_3_empire_reaper")
		
		--Phase 4 Markers
		phase_4_empire_of_the_hand_ship_1_marker = Find_Hint("MARKER_GENERIC_YELLOW", "phase_4_empire_of_the_hand_ship_1")
		phase_4_empire_of_the_hand_ship_2_marker = Find_Hint("MARKER_GENERIC_YELLOW", "phase_4_empire_of_the_hand_ship_2")
		phase_4_empire_of_the_hand_ship_3_marker = Find_Hint("MARKER_GENERIC_YELLOW", "phase_4_empire_of_the_hand_ship_3")
		phase_4_empire_of_the_hand_visvia_1_marker = Find_Hint("MARKER_GENERIC_YELLOW", "phase_4_empire_of_the_hand_visvia_1")
		phase_4_empire_of_the_hand_visvia_2_marker = Find_Hint("MARKER_GENERIC_YELLOW", "phase_4_empire_of_the_hand_visvia_2")
		phase_4_empire_of_the_hand_visvia_3_marker = Find_Hint("MARKER_GENERIC_YELLOW", "phase_4_empire_of_the_hand_visvia_3")
		
		phase_4_pentastar_alignment_ship_1_marker = Find_Hint("MARKER_GENERIC_YELLOW", "phase_4_pentastar_alignment_ship_1")
		phase_4_pentastar_alignment_ship_2_marker = Find_Hint("MARKER_GENERIC_YELLOW", "phase_4_pentastar_alignment_ship_2")
		phase_4_pentastar_alignment_ship_3_marker = Find_Hint("MARKER_GENERIC_YELLOW", "phase_4_pentastar_alignment_ship_3")

		Create_Thread("State_List_Battle_01")
		Create_Thread("State_List_Battle_02")
		Create_Thread("State_List_Battle_03")
		Create_Thread("State_List_Battle_04")

		battle_map_gamble = GameRandom.Free_Random(1, 4)
		if battle_map_gamble == 1 then
			Create_Thread("Battle_One_Begins")
		elseif battle_map_gamble == 2 then
			Create_Thread("Battle_Two_Begins")
		elseif battle_map_gamble == 3 then
			Create_Thread("Battle_Three_Begins")
		elseif battle_map_gamble == 4 then
			Create_Thread("Battle_Four_Begins")
        end
	end
end

function Story_Mode_Service()
	if battle_one_active or battle_two_active or battle_four_active then
		if TestValid(Find_First_Object("Skirmish_Wedge_Lusankya")) then
			Find_First_Object("Skirmish_Wedge_Lusankya").Despawn()
		end
		if TestValid(Find_First_Object("Skirmish_Pellaeon_Reaper")) then
			Find_First_Object("Skirmish_Pellaeon_Reaper").Despawn()
		end
	end
end

function Battle_Cinematic_Camera()
    Start_Cinematic_Mode()
end

function State_List_Battle_01()
	phase_1_new_republic_spawn_list_1 = 
	{
		"CALAMARI_CRUISER",
		"CALAMARI_CRUISER",
		"CALAMARI_CRUISER",
		"GENERIC_NEBULON_B",
		"GENERIC_NEBULON_B",
		"GENERIC_NEBULON_B",
		"CORELLIAN_CORVETTE",
		"CORELLIAN_CORVETTE",
		"CORELLIAN_CORVETTE",
		"GENERIC_QUASAR",
		"GENERIC_QUASAR",
		"MC30C",
		"MC30C",
		"ALLIANCE_ASSAULT_FRIGATE",		
	}
	
	phase_1_new_republic_spawn_list_2 = 
	{
		"CALAMARI_CRUISER",
		"CALAMARI_CRUISER",
		"CALAMARI_CRUISER",
		"GENERIC_NEBULON_B",
		"GENERIC_NEBULON_B",
		"GENERIC_NEBULON_B",
		"GENERIC_NEBULON_B",
		"CORELLIAN_CORVETTE",
		"CORELLIAN_CORVETTE",
		"CORELLIAN_CORVETTE",
		"GENERIC_QUASAR",
		"GENERIC_QUASAR",
		"MC30C",
		"MC30C",
	}
	
	phase_1_new_republic_spawn_list_3 = 
	{
		"CALAMARI_CRUISER",
		"CALAMARI_CRUISER",
		"GENERIC_NEBULON_B",
		"GENERIC_NEBULON_B",
		"GENERIC_NEBULON_B",
		"GENERIC_NEBULON_B",
		"CORELLIAN_CORVETTE",
		"CORELLIAN_CORVETTE",
		"CORELLIAN_CORVETTE",
		"GENERIC_QUASAR",
		"GENERIC_QUASAR",
		"MC30C",
		"ALLIANCE_ASSAULT_FRIGATE",
	}
	
	phase_1_empire_spawn_list_1 =
	{
		"GENERIC_STAR_DESTROYER",
		"GENERIC_STAR_DESTROYER",
		"GENERIC_INTERDICTOR_CRUISER",
		"GENERIC_INTERDICTOR_CRUISER",
		"GENERIC_INTERDICTOR_CRUISER",
		"CARRACK_CRUISER",
		"KATANA_DREADNAUGHT_EMPIRE",
		"KATANA_DREADNAUGHT_EMPIRE",
		"STRIKE_CRUISER",
		"STRIKE_CRUISER",
	}
	
	phase_1_empire_spawn_list_2 =
	{
		"GENERIC_STAR_DESTROYER",
		"GENERIC_STAR_DESTROYER",
		"GENERIC_INTERDICTOR_CRUISER",
		"GENERIC_INTERDICTOR_CRUISER",
		"GENERIC_INTERDICTOR_CRUISER",
		"CARRACK_CRUISER",
		"CARRACK_CRUISER",
		"KATANA_DREADNAUGHT_EMPIRE",
		"KATANA_DREADNAUGHT_EMPIRE",
		"STRIKE_CRUISER",
		"STRIKE_CRUISER",
		"STRIKE_CRUISER",
	}
	
	phase_1_empire_spawn_list_3 =
	{
		"GENERIC_STAR_DESTROYER",
		"GENERIC_STAR_DESTROYER",
		"GENERIC_STAR_DESTROYER",
		"GENERIC_INTERDICTOR_CRUISER",
		"GENERIC_INTERDICTOR_CRUISER",
		"CARRACK_CRUISER",
		"CARRACK_CRUISER",
		"KATANA_DREADNAUGHT_EMPIRE",
		"KATANA_DREADNAUGHT_EMPIRE",
		"STRIKE_CRUISER",
		"STRIKE_CRUISER",
	}
end

function State_List_Battle_02()
	phase_2_eriadu_spawn_list_1 = 
	{
		"GENERIC_TWIN_WELL_CRUISER",
		"GENERIC_GLADIATOR",
		"IPV1_SYSTEM_PATROL_CRAFT",
		"IPV1_SYSTEM_PATROL_CRAFT",
		"ARQUITENS",
		"ARQUITENS",
	}
	
	phase_2_eriadu_spawn_list_2 = 
	{
		"GENERIC_TWIN_WELL_CRUISER",
		"GENERIC_GLADIATOR",
		"IPV1_SYSTEM_PATROL_CRAFT",
		"IPV1_SYSTEM_PATROL_CRAFT",
		"IPV1_SYSTEM_PATROL_CRAFT",
		"ARQUITENS",
	}
	
	phase_2_hapes_spawn_list_1 =
	{
		"BATTLEDRAGON",
		"BATTLEDRAGON",
		"MIST_CARRIER",
		"BETA_CRUISER",
		"NOVA_CRUISER",
		"TERAPHON_CRUISER",
		"BAIDAM",
		"PULSAR",
	}
	
	phase_2_hapes_spawn_list_2 =
	{
		"BATTLEDRAGON",
		"BATTLEDRAGON",
		"MIST_CARRIER",
		"BETA_CRUISER",
		"NOVA_CRUISER",
		"TERAPHON_CRUISER",
		"BAIDAM",
		"BAIDAM",
		"PULSAR",
	}
	
	phase_2_hapes_spawn_list_3 =
	{
		"BATTLEDRAGON",
		"BATTLEDRAGON",
		"BATTLEDRAGON",
		"BETA_CRUISER",
		"NOVA_CRUISER",
		"NOVA_CRUISER",
		"TERAPHON_CRUISER",
		"BAIDAM",
		"BAIDAM",
		"PULSAR",
	}
	
	phase_2_hapes_spawn_list_4 =
	{
		"BATTLEDRAGON",
		"BATTLEDRAGON",
		"BATTLEDRAGON",
		"BETA_CRUISER",
		"BETA_CRUISER",
		"NOVA_CRUISER",
		"NOVA_CRUISER",
		"BAIDAM",
		"BAIDAM",
		"PULSAR",
	}
end

function State_List_Battle_03()
	phase_3_new_republic_spawn_list = 
	{
		"MC80B",
		"ALLIANCE_ASSAULT_FRIGATE",
	}
	
	phase_3_empire_spawn_list = 
	{
		"GENERIC_STAR_DESTROYER_TWO",
		"GENERIC_STAR_DESTROYER_TWO",
		"GENERIC_STAR_DESTROYER_TWO",
	}
end

function State_List_Battle_04()
	phase_4_empire_of_the_hand_spawn_list_1 = 
	{
		"INTEGO_DESTROYER",
		"CHISS_STAR_DESTROYER",
		"CHAF_DESTROYER",
		"CHAF_DESTROYER",
		"EFODIO_FLEET_TENDER",
		"FRUORO",
	}
	
	phase_4_empire_of_the_hand_spawn_list_2 = 
	{
		"INTEGO_DESTROYER",
		"CHISS_STAR_DESTROYER",
		"CHISS_STAR_DESTROYER",
		"CHAF_DESTROYER",
		"CHAF_DESTROYER",
		"FRUORO",
	}
	
	phase_4_empire_of_the_hand_spawn_list_3 = 
	{
		"INTEGO_DESTROYER",
		"CHISS_STAR_DESTROYER",
		"CHAF_DESTROYER",
		"CHAF_DESTROYER",
		"EFODIO_FLEET_TENDER",
		"FRUORO",
	}
	
	phase_4_pentastar_alignment_spawn_list_1 = 
	{
		"GENERIC_SECUTOR",
		"GENERIC_VENATOR",
		"GENERIC_PROCURSATOR",
		"BATTLE_HORN",
		"RAIDER_CORVETTE",
		"RAIDER_CORVETTE",
		"IMPERIAL_CARGO_SHIP",
	}
	
	phase_4_pentastar_alignment_spawn_list_2 = 
	{
		"GENERIC_SECUTOR",
		"GENERIC_VENATOR",
		"GENERIC_PROCURSATOR",
		"BATTLE_HORN",
		"RAIDER_CORVETTE",
		"RAIDER_CORVETTE",
		"IMPERIAL_CARGO_SHIP",
	}
	
	phase_4_pentastar_alignment_spawn_list_3 = 
	{
		"GENERIC_SECUTOR",
		"GENERIC_VENATOR",
		"BATTLE_HORN",
		"RAIDER_CORVETTE",
		"RAIDER_CORVETTE",
		"IMPERIAL_CARGO_SHIP",
		"IMPERIAL_CARGO_SHIP",
	}
end

function State_Spawn_Battle_01()
	--New Republic fleet
	player_phase_1_homeone = Spawn_Unit(Find_Object_Type("Home_One_Type"), phase_1_new_republic_homeone_marker, p_new_republic)
	player_phase_1_homeone = Find_Nearest(phase_1_new_republic_homeone_marker, p_new_republic, true)
	player_phase_1_homeone.Teleport_And_Face(phase_1_new_republic_homeone_marker)
	player_phase_1_homeone.Cinematic_Hyperspace_In(0.1)
	player_phase_1_homeone.Set_Importance(10)
	player_phase_1_homeone.Set_Cannot_Be_Killed(true)
	
	player_phase_1_isdii = Spawn_Unit(Find_Object_Type("Generic_Star_Destroyer_Two"), phase_1_new_republic_isdii_marker, p_new_republic)
	player_phase_1_isdii = Find_Nearest(phase_1_new_republic_isdii_marker, p_new_republic, true)
	player_phase_1_isdii.Teleport_And_Face(phase_1_new_republic_isdii_marker)
	player_phase_1_isdii.Cinematic_Hyperspace_In(0.1)
	
	Phase_1_New_Republic_Fleet_01 = SpawnList(phase_1_new_republic_spawn_list_1, phase_1_new_republic_ship_1_marker.Get_Position(), p_new_republic, true, true)
	New_Republic_Phase_1_Fleet_01 = Phase_1_New_Republic_Fleet_01[1]
	New_Republic_Phase_1_Fleet_01.Teleport_And_Face(phase_1_new_republic_ship_1_marker)
	New_Republic_Phase_1_Fleet_01.Cinematic_Hyperspace_In(0.1)
	
	Phase_1_New_Republic_Fleet_02 = SpawnList(phase_1_new_republic_spawn_list_2, phase_1_new_republic_ship_2_marker.Get_Position(), p_new_republic, true, true)
	New_Republic_Phase_1_Fleet_02 = Phase_1_New_Republic_Fleet_02[1]
	New_Republic_Phase_1_Fleet_02.Teleport_And_Face(phase_1_new_republic_ship_2_marker)
	New_Republic_Phase_1_Fleet_02.Cinematic_Hyperspace_In(0.1)
	
	Phase_1_New_Republic_Fleet_03 = SpawnList(phase_1_new_republic_spawn_list_3, phase_1_new_republic_ship_3_marker.Get_Position(), p_new_republic, true, true)
	New_Republic_Phase_1_Fleet_03 = Phase_1_New_Republic_Fleet_03[1]
	New_Republic_Phase_1_Fleet_03.Teleport_And_Face(phase_1_new_republic_ship_3_marker)
	New_Republic_Phase_1_Fleet_03.Cinematic_Hyperspace_In(0.1)

	--Empire fleet
	player_phase_1_golan2_1 = Spawn_Unit(Find_Object_Type("Empire_Star_Base_3"), phase_1_empire_golan2_1_marker, p_empire)
	player_phase_1_golan2_1 = Find_Nearest(phase_1_empire_golan2_1_marker, p_empire, true)
	player_phase_1_golan2_1.Teleport_And_Face(phase_1_empire_golan2_1_marker)
	
	player_phase_1_golan2_2 = Spawn_Unit(Find_Object_Type("Empire_Star_Base_3"), phase_1_empire_golan2_2_marker, p_empire)
	player_phase_1_golan2_2 = Find_Nearest(phase_1_empire_golan2_2_marker, p_empire, true)
	player_phase_1_golan2_2.Teleport_And_Face(phase_1_empire_golan2_2_marker)
	
	player_phase_1_greywolf = Spawn_Unit(Find_Object_Type("Grey_Wolf"), phase_1_empire_greywolf_marker, p_empire)
	player_phase_1_greywolf = Find_Nearest(phase_1_empire_greywolf_marker, p_empire, true)
	player_phase_1_greywolf.Teleport_And_Face(phase_1_empire_greywolf_marker)
	--player_phase_1_greywolf.Cinematic_Hyperspace_In(0.1)
	player_phase_1_greywolf.Set_Importance(10)
	player_phase_1_greywolf.Set_Cannot_Be_Killed(true)
	
	Phase_1_Empire_Fleet_01 = SpawnList(phase_1_empire_spawn_list_1, phase_1_empire_ship_1_marker.Get_Position(), p_empire, true, true)
	Empire_Phase_1_Fleet_01 = Phase_1_Empire_Fleet_01[1]
	Empire_Phase_1_Fleet_01.Teleport_And_Face(phase_1_empire_ship_1_marker)
	Empire_Phase_1_Fleet_01.Cinematic_Hyperspace_In(0.1)
	
	Phase_1_Empire_Fleet_02 = SpawnList(phase_1_empire_spawn_list_2, phase_1_empire_ship_2_marker.Get_Position(), p_empire, true, true)
	Empire_Phase_1_Fleet_02 = Phase_1_Empire_Fleet_02[1]
	Empire_Phase_1_Fleet_02.Teleport_And_Face(phase_1_empire_ship_2_marker)
	Empire_Phase_1_Fleet_02.Cinematic_Hyperspace_In(0.1)
	
	Phase_1_Empire_Fleet_03 = SpawnList(phase_1_empire_spawn_list_3, phase_1_empire_ship_3_marker.Get_Position(), p_empire, true, true)
	Empire_Phase_1_Fleet_03 = Phase_1_Empire_Fleet_03[1]
	Empire_Phase_1_Fleet_03.Teleport_And_Face(phase_1_empire_ship_3_marker)
	Empire_Phase_1_Fleet_03.Cinematic_Hyperspace_In(0.1)
end

function State_Spawn_Battle_02()
	--Eriadu fleet
	player_phase_2_assertor = Spawn_Unit(Find_Object_Type("Skirmish_Assertor"), phase_2_eriadu_assertor_marker, p_empire)
	player_phase_2_assertor = Find_Nearest(phase_2_eriadu_assertor_marker, p_empire, true)
	player_phase_2_assertor.Teleport_And_Face(phase_2_eriadu_assertor_marker)
	player_phase_2_assertor.Cinematic_Hyperspace_In(0.1)
	player_phase_2_assertor.Set_Importance(10)
	player_phase_2_assertor.Set_Cannot_Be_Killed(true)
	
	Phase_2_Eriadu_Fleet_01 = SpawnList(phase_2_eriadu_spawn_list_1, phase_2_eriadu_ship_1_marker.Get_Position(), p_empire, true, true)
	Eriadu_Phase_2_Fleet_01 = Phase_2_Eriadu_Fleet_01[1]
	Eriadu_Phase_2_Fleet_01.Teleport_And_Face(phase_2_eriadu_ship_1_marker)
	Eriadu_Phase_2_Fleet_01.Cinematic_Hyperspace_In(0.1)
	
	Phase_2_Eriadu_Fleet_02 = SpawnList(phase_2_eriadu_spawn_list_2, phase_2_eriadu_ship_2_marker.Get_Position(), p_empire, true, true)
	Eriadu_Phase_2_Fleet_02 = Phase_2_Eriadu_Fleet_02[1]
	Eriadu_Phase_2_Fleet_02.Teleport_And_Face(phase_2_eriadu_ship_2_marker)
	Eriadu_Phase_2_Fleet_02.Cinematic_Hyperspace_In(0.1)	

	--Hapes fleet
	player_hapes_station = Spawn_Unit(Find_Object_Type("Hapan_Star_Base_4"), phase_2_hapes_starbase_marker, p_new_republic)
	player_hapes_station = Find_Nearest(phase_2_hapes_starbase_marker, p_new_republic, true)
	player_hapes_station.Teleport_And_Face(phase_2_hapes_starbase_marker)
	player_hapes_station.Set_Importance(10)
	player_hapes_station.Set_Cannot_Be_Killed(true)
	
	Phase_2_Hapes_Fleet_01 = SpawnList(phase_2_hapes_spawn_list_1, phase_2_hapes_ship_1_marker.Get_Position(), p_new_republic, true, true)
	Hapes_Phase_2_Fleet_01 = Phase_2_Hapes_Fleet_01[1]
	Hapes_Phase_2_Fleet_01.Teleport_And_Face(phase_2_hapes_ship_1_marker)
	Hapes_Phase_2_Fleet_01.Cinematic_Hyperspace_In(0.1)
	
	Phase_2_Hapes_Fleet_02 = SpawnList(phase_2_hapes_spawn_list_2, phase_2_hapes_ship_2_marker.Get_Position(), p_new_republic, true, true)
	Hapes_Phase_2_Fleet_02 = Phase_2_Hapes_Fleet_02[1]
	Hapes_Phase_2_Fleet_02.Teleport_And_Face(phase_2_hapes_ship_2_marker)
	Hapes_Phase_2_Fleet_02.Cinematic_Hyperspace_In(0.1)
	
	Phase_2_Hapes_Fleet_03 = SpawnList(phase_2_hapes_spawn_list_3, phase_2_hapes_ship_3_marker.Get_Position(), p_new_republic, true, true)
	Hapes_Phase_2_Fleet_03 = Phase_2_Hapes_Fleet_03[1]
	Hapes_Phase_2_Fleet_03.Teleport_And_Face(phase_2_hapes_ship_3_marker)
	Hapes_Phase_2_Fleet_03.Cinematic_Hyperspace_In(0.1)
	
	Phase_2_Hapes_Fleet_04 = SpawnList(phase_2_hapes_spawn_list_4, phase_2_hapes_ship_4_marker.Get_Position(), p_new_republic, true, true)
	Hapes_Phase_2_Fleet_04 = Phase_2_Hapes_Fleet_04[1]
	Hapes_Phase_2_Fleet_04.Teleport_And_Face(phase_2_hapes_ship_4_marker)
	Hapes_Phase_2_Fleet_04.Cinematic_Hyperspace_In(0.1)
end

function State_Spawn_Battle_03()
	--New Republic fleet
	player_phase_3_lusankya = Spawn_Unit(Find_Object_Type("Skirmish_Wedge_Lusankya"), phase_3_new_republic_lusankya_marker, p_new_republic)
	player_phase_3_lusankya = Find_Nearest(phase_3_new_republic_lusankya_marker, p_new_republic, true)
	player_phase_3_lusankya.Teleport_And_Face(phase_3_new_republic_lusankya_marker)
	player_phase_3_lusankya.Cinematic_Hyperspace_In(0.1)
	player_phase_3_lusankya.Set_Importance(10)
	player_phase_3_lusankya.Set_Cannot_Be_Killed(true)
	
	player_phase_3_endurance = Spawn_Unit(Find_Object_Type("Endurance"), phase_3_new_republic_endurance_marker, p_new_republic)
	player_phase_3_endurance = Find_Nearest(phase_3_new_republic_endurance_marker, p_new_republic, true)
	player_phase_3_endurance.Teleport_And_Face(phase_3_new_republic_endurance_marker)
	player_phase_3_endurance.Cinematic_Hyperspace_In(100)
	
	Phase_3_New_Republic_Fleet = SpawnList(phase_3_new_republic_spawn_list, phase_3_new_republic_ship_1_marker.Get_Position(), p_new_republic, true, true)
	New_Republic_Phase_3_Fleet = Phase_3_New_Republic_Fleet[1]
	New_Republic_Phase_3_Fleet.Teleport_And_Face(phase_3_new_republic_ship_1_marker)
	New_Republic_Phase_3_Fleet.Cinematic_Hyperspace_In(50)

	--Empire fleet
	player_phase_3_reaper = Spawn_Unit(Find_Object_Type("Skirmish_Pellaeon_Reaper"), phase_3_empire_reaper_marker, p_empire)
	player_phase_3_reaper = Find_Nearest(phase_3_empire_reaper_marker, p_empire, true)
	player_phase_3_reaper.Teleport_And_Face(phase_3_empire_reaper_marker)
	player_phase_3_reaper.Cinematic_Hyperspace_In(0.1)
	player_phase_3_reaper.Set_Importance(10)
	player_phase_3_reaper.Set_Cannot_Be_Killed(true)
	
	Phase_3_Empire_Fleet = SpawnList(phase_3_empire_spawn_list, phase_3_empire_ship_1_marker.Get_Position(), p_empire, true, true)
	Empire_Phase_3_Fleet = Phase_3_Empire_Fleet[1]
	Empire_Phase_3_Fleet.Teleport_And_Face(phase_3_empire_ship_1_marker)
	Empire_Phase_3_Fleet.Cinematic_Hyperspace_In(50)
end

function State_Spawn_Battle_04()
	--Empire Of The Hand fleet
	player_empire_of_the_hand_visvia_1 = Spawn_Unit(Find_Object_Type("Visvia"), phase_4_empire_of_the_hand_visvia_1_marker, p_new_republic)
	player_empire_of_the_hand_visvia_1 = Find_Nearest(phase_4_empire_of_the_hand_visvia_1_marker, p_new_republic, true)
	player_empire_of_the_hand_visvia_1.Teleport_And_Face(phase_4_empire_of_the_hand_visvia_1_marker)
	player_empire_of_the_hand_visvia_1.Set_Importance(10)
	player_empire_of_the_hand_visvia_1.Set_Cannot_Be_Killed(true)

	player_empire_of_the_hand_visvia_2 = Spawn_Unit(Find_Object_Type("Visvia"), phase_4_empire_of_the_hand_visvia_2_marker, p_new_republic)
	player_empire_of_the_hand_visvia_2 = Find_Nearest(phase_4_empire_of_the_hand_visvia_2_marker, p_new_republic, true)
	player_empire_of_the_hand_visvia_2.Teleport_And_Face(phase_4_empire_of_the_hand_visvia_2_marker)
	player_empire_of_the_hand_visvia_2.Set_Importance(10)
	player_empire_of_the_hand_visvia_2.Set_Cannot_Be_Killed(true)
	
	player_empire_of_the_hand_visvia_3 = Spawn_Unit(Find_Object_Type("Visvia"), phase_4_empire_of_the_hand_visvia_3_marker, p_new_republic)
	player_empire_of_the_hand_visvia_3 = Find_Nearest(phase_4_empire_of_the_hand_visvia_3_marker, p_new_republic, true)
	player_empire_of_the_hand_visvia_3.Teleport_And_Face(phase_4_empire_of_the_hand_visvia_3_marker)
	player_empire_of_the_hand_visvia_3.Set_Importance(10)
	player_empire_of_the_hand_visvia_3.Set_Cannot_Be_Killed(true)
	
	Phase_4_Empire_Of_The_Hand_Fleet_01 = SpawnList(phase_4_empire_of_the_hand_spawn_list_1, phase_4_empire_of_the_hand_ship_1_marker.Get_Position(), p_new_republic, true, true)
	Empire_Of_The_Hand_Phase_4_Fleet_01 = Phase_4_Empire_Of_The_Hand_Fleet_01[1]
	Empire_Of_The_Hand_Phase_4_Fleet_01.Teleport_And_Face(phase_4_empire_of_the_hand_ship_1_marker)
	Empire_Of_The_Hand_Phase_4_Fleet_01.Cinematic_Hyperspace_In(0.1)
	
	Phase_4_Empire_Of_The_Hand_Fleet_02 = SpawnList(phase_4_empire_of_the_hand_spawn_list_2, phase_4_empire_of_the_hand_ship_2_marker.Get_Position(), p_new_republic, true, true)
	Empire_Of_The_Hand_Phase_4_Fleet_02 = Phase_4_Empire_Of_The_Hand_Fleet_02[1]
	Empire_Of_The_Hand_Phase_4_Fleet_02.Teleport_And_Face(phase_4_empire_of_the_hand_ship_2_marker)
	Empire_Of_The_Hand_Phase_4_Fleet_02.Cinematic_Hyperspace_In(0.1)
	
	Phase_4_Empire_Of_The_Hand_Fleet_03 = SpawnList(phase_4_empire_of_the_hand_spawn_list_3, phase_4_empire_of_the_hand_ship_3_marker.Get_Position(), p_new_republic, true, true)
	Empire_Of_The_Hand_Phase_4_Fleet_03 = Phase_4_Empire_Of_The_Hand_Fleet_03[1]
	Empire_Of_The_Hand_Phase_4_Fleet_03.Teleport_And_Face(phase_4_empire_of_the_hand_ship_3_marker)
	Empire_Of_The_Hand_Phase_4_Fleet_03.Cinematic_Hyperspace_In(0.1)

	--Pentastar Alignment fleet
	Phase_4_Pentastar_Alignment_Fleet_01 = SpawnList(phase_4_pentastar_alignment_spawn_list_1, phase_4_pentastar_alignment_ship_1_marker.Get_Position(), p_empire, true, true)
	Pentastar_Alignment_Phase_4_Fleet_01 = Phase_4_Pentastar_Alignment_Fleet_01[1]
	Pentastar_Alignment_Phase_4_Fleet_01.Teleport_And_Face(phase_4_pentastar_alignment_ship_1_marker)
	Pentastar_Alignment_Phase_4_Fleet_01.Cinematic_Hyperspace_In(0.1)
	
	Phase_4_Pentastar_Alignment_Fleet_02 = SpawnList(phase_4_pentastar_alignment_spawn_list_2, phase_4_pentastar_alignment_ship_2_marker.Get_Position(), p_empire, true, true)
	Pentastar_Alignment_Phase_4_Fleet_02 = Phase_4_Pentastar_Alignment_Fleet_02[1]
	Pentastar_Alignment_Phase_4_Fleet_02.Teleport_And_Face(phase_4_pentastar_alignment_ship_2_marker)
	Pentastar_Alignment_Phase_4_Fleet_02.Cinematic_Hyperspace_In(0.1)
	
	Phase_4_Pentastar_Alignment_Fleet_03 = SpawnList(phase_4_pentastar_alignment_spawn_list_3, phase_4_pentastar_alignment_ship_3_marker.Get_Position(), p_empire, true, true)
	Pentastar_Alignment_Phase_4_Fleet_03 = Phase_4_Pentastar_Alignment_Fleet_03[1]
	Pentastar_Alignment_Phase_4_Fleet_03.Teleport_And_Face(phase_4_pentastar_alignment_ship_3_marker)
	Pentastar_Alignment_Phase_4_Fleet_03.Cinematic_Hyperspace_In(0.1)
end

function Battle_One_Begins()
	if not battle_two_active and not battle_three_active and not battle_four_active then
		battle_one_active = true
		Fade_On()

		Set_New_Environment(1)

		local unhide_battle_one_list = Find_All_Objects_With_Hint("1")
		for h,unhide01 in pairs(unhide_battle_one_list) do
			if TestValid(unhide01) then
				Hide_Object(unhide01, 0)
			end	
		end

		local hide_battle_two_list = Find_All_Objects_With_Hint("2")
		for h,hide02 in pairs(hide_battle_two_list) do
			if TestValid(hide02) then
				Hide_Object(hide02, 1)
			end	
		end
		
		local hide_battle_three_list = Find_All_Objects_With_Hint("3")
		for h,hide03 in pairs(hide_battle_three_list) do
			if TestValid(hide03) then
				Hide_Object(hide03, 1)
			end	
		end
		
		local hide_battle_four_list = Find_All_Objects_With_Hint("4")
		for h,hide04 in pairs(hide_battle_four_list) do
			if TestValid(hide04) then
				Hide_Object(hide04, 1)
			end	
		end

		Create_Thread("State_Spawn_Battle_01")

		if not cinematic_cam_active then
			current_cinematic_thread_id = Create_Thread("Battle_Cinematic_Camera")
			cinematic_cam_active = true
		end
		
		Fade_Screen_In(5)
		
		Sleep (5)

		local new_republic_attack_one_list = Find_All_Objects_Of_Type(p_new_republic, "SpaceHero | Corvette | Capital | Frigate | SuperCapital")
		for g,newrepattack01 in pairs(new_republic_attack_one_list) do
			if TestValid(newrepattack01) then
				if TestValid(player_phase_1_greywolf) then
					newrepattack01.Attack_Move(player_phase_1_greywolf)
				end
			end
		end

		local empire_attack_one_list = Find_All_Objects_Of_Type(p_empire, "SpaceHero | Corvette | Capital | Frigate | SuperCapital")
		for g,empireattack01 in pairs(empire_attack_one_list) do
			if TestValid(empireattack01) then
				if TestValid(player_phase_1_homeone) then
					empireattack01.Attack_Move(player_phase_1_homeone)
				end
			end
		end

		Sleep(90) --Length of battle
		
		Fade_Screen_Out(2)
		
		Sleep (3)
		
		Fade_On()
		Do_End_Cinematic_Cleanup()

		local newrepublic_despawn_one_list = Find_All_Objects_Of_Type(p_new_republic, "SpaceHero | Corvette | Capital | Frigate | SpaceStructure | SuperCapital")
		for g,newrepdespawn01 in pairs(newrepublic_despawn_one_list) do
			if TestValid(newrepdespawn01) then
				newrepdespawn01.Despawn()
			end
		end

		local empire_despawn_one_list = Find_All_Objects_Of_Type(p_empire, "SpaceHero | Corvette | Capital | Frigate | SpaceStructure | SuperCapital")
		for g,empiredespawn01 in pairs(empire_despawn_one_list) do
			if TestValid(empiredespawn01) then
				empiredespawn01.Despawn()
			end
		end

		battle_one_active = false

		battle_map_gamble = GameRandom.Free_Random(1, 10)
		if battle_map_gamble <= 8 then
			Create_Thread("Battle_Two_Begins")
		elseif battle_map_gamble == 9 then
			Create_Thread("Battle_Three_Begins")
		elseif battle_map_gamble == 10 then
			Create_Thread("Battle_Four_Begins")
		end
	end
end

function Battle_Two_Begins()
	if not battle_one_active and not battle_three_active and not battle_four_active then
		battle_two_active = true
		
		Fade_On()

		Set_New_Environment(2)

		local hide_battle_one_list = Find_All_Objects_With_Hint("1")
		for h,hide01 in pairs(hide_battle_one_list) do
			if TestValid(hide01) then
				Hide_Object(hide01, 1)
			end	
		end

		local unhide_battle_two_list = Find_All_Objects_With_Hint("2")
		for h,unhide02 in pairs(unhide_battle_two_list) do
			if TestValid(unhide02) then
				Hide_Object(unhide02, 0)
			end	
		end
		
		local hide_battle_three_list = Find_All_Objects_With_Hint("3")
		for h,hide03 in pairs(hide_battle_three_list) do
			if TestValid(hide03) then
				Hide_Object(hide03, 1)
			end	
		end
		
		local hide_battle_four_list = Find_All_Objects_With_Hint("4")
		for h,hide04 in pairs(hide_battle_four_list) do
			if TestValid(hide04) then
				Hide_Object(hide04, 1)
			end	
		end

		Create_Thread("State_Spawn_Battle_02")

		if not cinematic_cam_active then
			current_cinematic_thread_id = Create_Thread("Battle_Cinematic_Camera")
			cinematic_cam_active = true
		end
		
		Fade_Screen_In(5)
		
		Sleep (5)
		
		local eriadu_attack_one_list = Find_All_Objects_Of_Type(p_empire, "SpaceHero | Corvette | Capital | Frigate | SuperCapital")
		for g,eriaduattack01 in pairs(eriadu_attack_one_list) do
			if TestValid(eriaduattack01) then
				if TestValid(player_hapes_station) then
					eriaduattack01.Attack_Move(player_hapes_station)
				end
			end
		end

		local hapes_attack_one_list = Find_All_Objects_Of_Type(p_new_republic, "SpaceHero | Corvette | Capital | Frigate | SuperCapital")
		for g,hapesattack01 in pairs(hapes_attack_one_list) do
			if TestValid(hapesattack01) then
				if TestValid(player_phase_2_assertor) then
					hapesattack01.Attack_Move(player_phase_2_assertor)
				end
			end
		end

		Sleep(90) --Length of battle
		
		Fade_Screen_Out(2)
		
		Sleep (3)
		
		Fade_On()
		Do_End_Cinematic_Cleanup()

		local eriadu_despawn_one_list = Find_All_Objects_Of_Type(p_empire, "SpaceHero | Corvette | Capital | Frigate | SpaceStructure | SuperCapital")
		for g,eriadudespawn01 in pairs(eriadu_despawn_one_list) do
			if TestValid(eriadudespawn01) then
				eriadudespawn01.Despawn()
			end
		end

		local hapes_despawn_one_list = Find_All_Objects_Of_Type(p_new_republic, "SpaceHero | Corvette | Capital | Frigate | SpaceStructure | SuperCapital")
		for g,hapesdespawn01 in pairs(hapes_despawn_one_list) do
			if TestValid(hapesdespawn01) then
				hapesdespawn01.Despawn()
			end
		end

		battle_two_active = false
		
		battle_map_gamble = GameRandom.Free_Random(1, 10)
		if battle_map_gamble <= 8 then
			Create_Thread("Battle_Three_Begins")
		elseif battle_map_gamble == 9 then
			Create_Thread("Battle_One_Begins")
		elseif battle_map_gamble == 10 then
			Create_Thread("Battle_Four_Begins")
		end
	end
end

function Battle_Three_Begins()
	if not battle_one_active and not battle_two_active and not battle_four_active then
		battle_three_active = true
		
		Fade_On()

		Set_New_Environment(3)

		local hide_battle_one_list = Find_All_Objects_With_Hint("1")
		for h,hide01 in pairs(hide_battle_one_list) do
			if TestValid(hide01) then
				Hide_Object(hide01, 1)
			end	
		end

		local hide_battle_two_list = Find_All_Objects_With_Hint("2")
		for h,hide02 in pairs(hide_battle_two_list) do
			if TestValid(hide02) then
				Hide_Object(hide02, 1)
			end	
		end

		local unhide_battle_three_list = Find_All_Objects_With_Hint("3")
		for h,unhide03 in pairs(unhide_battle_three_list) do
			if TestValid(unhide03) then
				Hide_Object(unhide03, 0)
			end	
		end
		
		local hide_battle_four_list = Find_All_Objects_With_Hint("4")
		for h,hide04 in pairs(hide_battle_four_list) do
			if TestValid(hide04) then
				Hide_Object(hide04, 1)
			end	
		end

		Create_Thread("State_Spawn_Battle_03")

		if not cinematic_cam_active then
			current_cinematic_thread_id = Create_Thread("Battle_Cinematic_Camera")
			cinematic_cam_active = true
		end

		Fade_Screen_In(5)
		
		Sleep (5)

		local new_republic_attack_two_list = Find_All_Objects_Of_Type(p_new_republic, "SpaceHero | Corvette | Capital | Frigate | SuperCapital")
		for g,newrepattack02 in pairs(new_republic_attack_two_list) do
			if TestValid(newrepattack02) then
				if TestValid(player_phase_3_reaper) then
					newrepattack02.Attack_Move(player_phase_3_reaper)
				end
			end
		end

		local empire_attack_two_list = Find_All_Objects_Of_Type(p_empire, "SpaceHero | Corvette | Capital | Frigate | SuperCapital")
		for g,empireattack02 in pairs(empire_attack_two_list) do
			if TestValid(empireattack02) then
				if TestValid(player_phase_3_lusankya) then
					empireattack02.Attack_Move(player_phase_3_lusankya)
				end
			end
		end

		Sleep(90) --Length of battle
		
		Fade_Screen_Out(2)
		
		Sleep (3)
		
		Fade_On()
		Do_End_Cinematic_Cleanup()

		local newrepublic_despawn_two_list = Find_All_Objects_Of_Type(p_new_republic, "SpaceHero | Corvette | Capital | Frigate | SpaceStructure | SuperCapital")
		for g,newrepdespawn02 in pairs(newrepublic_despawn_two_list) do
			if TestValid(newrepdespawn02) then
				newrepdespawn02.Despawn()
			end
		end

		local empire_despawn_two_list = Find_All_Objects_Of_Type(p_empire, "SpaceHero | Corvette | Capital | Frigate | SpaceStructure | SuperCapital")
		for g,empiredespawn02 in pairs(empire_despawn_two_list) do
			if TestValid(empiredespawn02) then
				empiredespawn02.Despawn()
			end
		end

		battle_three_active = false
		
		battle_map_gamble = GameRandom.Free_Random(1, 10)
		if battle_map_gamble <= 8 then
			Create_Thread("Battle_Four_Begins")
		elseif battle_map_gamble == 9 then
			Create_Thread("Battle_One_Begins")
		elseif battle_map_gamble == 10 then
			Create_Thread("Battle_Two_Begins")
		end
	end
end

function Battle_Four_Begins()
	if not battle_one_active and not battle_two_active and not battle_three_active then
		battle_four_active = true
		
		Fade_On()

		Set_New_Environment(4)

		local hide_battle_one_list = Find_All_Objects_With_Hint("1")
		for h,hide01 in pairs(hide_battle_one_list) do
			if TestValid(hide01) then
				Hide_Object(hide01, 1)
			end	
		end

		local hide_battle_two_list = Find_All_Objects_With_Hint("2")
		for h,hide02 in pairs(hide_battle_two_list) do
			if TestValid(hide02) then
				Hide_Object(hide02, 1)
			end	
		end

		local hide_battle_three_list = Find_All_Objects_With_Hint("3")
		for h,hide03 in pairs(hide_battle_three_list) do
			if TestValid(hide03) then
				Hide_Object(hide03, 1)
			end	
		end
		
		local unhide_battle_four_list = Find_All_Objects_With_Hint("4")
		for h,unhide04 in pairs(unhide_battle_four_list) do
			if TestValid(unhide04) then
				Hide_Object(unhide04, 0)
			end	
		end

		Create_Thread("State_Spawn_Battle_04")

		if not cinematic_cam_active then
			current_cinematic_thread_id = Create_Thread("Battle_Cinematic_Camera")
			cinematic_cam_active = true
		end

		Fade_Screen_In(5)
		
		Sleep (5)

		local pa_attack_one_list = Find_All_Objects_Of_Type(p_empire, "SpaceHero | Corvette | Capital | Frigate | SuperCapital")
		for g,paattack01 in pairs(pa_attack_one_list) do
			if TestValid(paattack01) then
				if TestValid(player_empire_of_the_hand_visvia_2) then
					paattack01.Attack_Move(player_empire_of_the_hand_visvia_2)
				end
			end
		end

		Sleep(90) --Length of battle
		
		Fade_Screen_Out(2)
		
		Sleep (3)
		
		Fade_On()
		Do_End_Cinematic_Cleanup()

		local eoth_despawn_one_list = Find_All_Objects_Of_Type(p_new_republic, "SpaceHero | Corvette | Capital | Frigate | SpaceStructure | SuperCapital")
		for g,eothdespawn03 in pairs(eoth_despawn_one_list) do
			if TestValid(eothdespawn03) then
				eothdespawn03.Despawn()
			end
		end

		local pa_despawn_three_list = Find_All_Objects_Of_Type(p_empire, "SpaceHero | Corvette | Capital | Frigate | SpaceStructure | SuperCapital")
		for g,padespawn03 in pairs(pa_despawn_three_list) do
			if TestValid(padespawn03) then
				padespawn03.Despawn()
			end
		end

		battle_four_active = false
		
		battle_map_gamble = GameRandom.Free_Random(1, 10)
		if battle_map_gamble <= 8 then
			Create_Thread("Battle_One_Begins")
		elseif battle_map_gamble == 9 then
			Create_Thread("Battle_Two_Begins")
		elseif battle_map_gamble == 10 then
			Create_Thread("Battle_Three_Begins")
		end
	end
end