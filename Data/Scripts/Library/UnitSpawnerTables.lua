function DefineUnitTable(faction)

    if faction == Find_Player("Empire") then
	    Unit_Table = {
            {Find_Object_Type("Beta_ETR_3_Squadron"), 2, "Space"}		
            ,{Find_Object_Type("IPV1_System_Patrol_Craft"), 5, "Space"}		
            ,{Find_Object_Type("Lancer_Frigate"), 4, "Space"}
            ,{Find_Object_Type("Escort_Carrier"), 3, "Space"}
            ,{Find_Object_Type("Carrack_Cruiser"), 4, "Space"}
            ,{Find_Object_Type("Strike_Cruiser"), 4, "Space"}
            ,{Find_Object_Type("Vindicator_Cruiser"), 3, "Space"}
            ,{Find_Object_Type("Dreadnaught_Empire"), 4, "Space"}
            ,{Find_Object_Type("Star_Galleon"), 1, "Space"}
            ,{Find_Object_Type("Generic_Acclamator_Assault_Ship_II"), 3, "Space"}
            ,{Find_Object_Type("Generic_Procursator"), 2, "Space"}
            ,{Find_Object_Type("Generic_Victory_Destroyer"), 3, "Space"}
            ,{Find_Object_Type("Generic_Victory_Destroyer_Two"), 3, "Space"}
            ,{Find_Object_Type("Generic_Star_Destroyer_Two"), 1, "Space"}
            ,{Find_Object_Type("Generic_Star_Destroyer"), 1, "Space"}
            ,{Find_Object_Type("Generic_Tector"), 1, "Space"}
            ,{Find_Object_Type("Army_Trooper_Squad"), 4, "Land"}
            ,{Find_Object_Type("Army_Guard_Squad"), 3, "Land"}		
            ,{Find_Object_Type("Imperial_Stormtrooper_Squad"), 2, "Land"}
            ,{Find_Object_Type("Imperial_Shadow_Stormtrooper_Squad"), 0.1, "Land"}			
            ,{Find_Object_Type("Imperial_Scout_Trooper_Infantry_Squad"), 1, "Land"}			
            ,{Find_Object_Type("Imperial_74Z_Bike_Company"), 2, "Land"}
            ,{Find_Object_Type("Imperial_AT_ST_Company"), 3, "Land"}
            ,{Find_Object_Type("Imperial_Chariot_LAV_Company"), 3, "Land"}
            ,{Find_Object_Type("Imperial_S_1_Firehawke_Company"), 2, "Land"}
            ,{Find_Object_Type("Imperial_PX4_Company"), 1, "Land"}			
            ,{Find_Object_Type("Imperial_AT_AT_Company"), 2, "Land"}
            ,{Find_Object_Type("Imperial_IDT_Group"), 1, "Land"}
            ,{Find_Object_Type("Imperial_Deathhawk_Group"), 1, "Land"}
            ,{Find_Object_Type("Imperial_SPMAG_Company"), 1, "Land"}
        }
    elseif faction == Find_Player("Rebel") then
        Unit_Table = {
			{Find_Object_Type("Calamari_Cruiser"), 2, "Space"}
            ,{Find_Object_Type("Alliance_Assault_Frigate_II"), 2, "Space"}
            ,{Find_Object_Type("Quasar"), 5, "Space"}
            ,{Find_Object_Type("Nebulon_B_Frigate"), 5, "Space"}
            ,{Find_Object_Type("Alliance_Assault_Frigate"), 4, "Space"}
            ,{Find_Object_Type("Dreadnaught_Rebel"), 4, "Space"}
            ,{Find_Object_Type("Corellian_Corvette"), 5, "Space"}
            ,{Find_Object_Type("Corellian_Gunboat"), 5, "Space"}
            ,{Find_Object_Type("Marauder_Cruiser"), 5, "Space"}
			,{Find_Object_Type("Marauder_Missile_Cruiser"), 3, "Space"}
            ,{Find_Object_Type("Dauntless"), 2, "Space"}
            ,{Find_Object_Type("Nebulon_B_Tender"), 2, "Space"}			
            ,{Find_Object_Type("Liberator_Cruiser"), 2, "Space"}			
            ,{Find_Object_Type("MC80B"), 1, "Space"}
            ,{Find_Object_Type("MC40a"), 3, "Space"}
			,{Find_Object_Type("MC30a"), 3, "Space"}
            ,{Find_Object_Type("MC30c"), 3, "Space"}
            ,{Find_Object_Type("Rebel_Infantry_Squad"), 5, "Land"}
            ,{Find_Object_Type("Rebel_Marine_Squad"), 2, "Land"}
            ,{Find_Object_Type("Rebel_T2B_Company"), 3, "Land"}
            ,{Find_Object_Type("Rebel_T1B_Company"), 2, "Land"}
            ,{Find_Object_Type("Rebel_AAC_2_Company"), 3, "Land"}
            ,{Find_Object_Type("Rebel_AA5_Company"), 1, "Land"}
            ,{Find_Object_Type("Rebel_Freerunner_Company"), 2, "Land"}			
            ,{Find_Object_Type("Rebel_T3B_Company"), 2, "Land"}			
            ,{Find_Object_Type("Rebel_T4B_Company"), 1, "Land"}			
            ,{Find_Object_Type("Rebel_Tracker_Company"), 1, "Land"}
            ,{Find_Object_Type("Rebel_Snowspeeder_Wing"), 2, "Land"}
            ,{Find_Object_Type("Rebel_Gallofree_HTT_Company"), 1, "Land"}
            ,{Find_Object_Type("Rebel_MPTL_Company"), 1, "Land"}
            }
	elseif faction == Find_Player("Hapes_Consortium") then
        Unit_Table = {
            {Find_Object_Type("BattleDragon"), 3, "Space"}
            ,{Find_Object_Type("Nova_Cruiser"), 4, "Space"}
            ,{Find_Object_Type("Beta_Cruiser"), 3, "Space"}
            ,{Find_Object_Type("Stella"), 3, "Space"}
            ,{Find_Object_Type("Baidam"), 4, "Space"}			
            ,{Find_Object_Type("Charubah_Frigate"), 2, "Space"}			
            ,{Find_Object_Type("Magnetar"), 1, "Space"}			
            ,{Find_Object_Type("Pulsar"), 1, "Space"}			
            ,{Find_Object_Type("Terephon_Cruiser"), 1, "Space"}			
            ,{Find_Object_Type("Olanji_Frigate"), 2, "Space"}			
            ,{Find_Object_Type("Coronal"), 1, "Space"}			
            ,{Find_Object_Type("Neutron_Cruiser"), 1, "Space"}			
            ,{Find_Object_Type("Mist_Carrier"), 1, "Space"}			
            ,{Find_Object_Type("Hapan_Infantry_Squad"), 3, "Land"}
            ,{Find_Object_Type("HRG_Commando_Squad"), 1, "Land"}
            ,{Find_Object_Type("Hapan_LightTank_Company"), 3, "Land"}
            ,{Find_Object_Type("Hapan_Transport_Company"), 2, "Land"}
            ,{Find_Object_Type("Hapan_HeavyTank_Company"), 2, "Land"}			
            }
    elseif faction == Find_Player("EmpireoftheHand") then
        Unit_Table = {
            {Find_Object_Type("Chaf_Destroyer"), 3, "Space"}
            ,{Find_Object_Type("Fruoro"), 4, "Space"}
            ,{Find_Object_Type("Syndic_Destroyer"), 1, "Space"}
            ,{Find_Object_Type("Phalanx_Destroyer"), 2, "Space"}
            ,{Find_Object_Type("Chiss_Star_Destroyer"), 1, "Space"}
            ,{Find_Object_Type("Peltast"), 1, "Space"}
            ,{Find_Object_Type("Ormos"), 4, "Space"}
            ,{Find_Object_Type("Muqaraea"), 4, "Space"}
            ,{Find_Object_Type("Syzygos"), 3, "Space"}
            ,{Find_Object_Type("Kynigos"), 3, "Space"}
            ,{Find_Object_Type("Baomu"), 2, "Space"}
            ,{Find_Object_Type("Rohkea"), 4, "Space"}
            ,{Find_Object_Type("Kuuro"), 4, "Space"}
            ,{Find_Object_Type("Phalanx_Trooper_Squad"), 4, "Land"}
			,{Find_Object_Type("EotH_Kirov_Brigade"), 1, "Land"}
			,{Find_Object_Type("MMT_Brigade"), 1, "Land"}
			,{Find_Object_Type("Flame_Tank_Company"), 2, "Land"}
			,{Find_Object_Type("RFT_Brigade"), 3, "Land"}
			,{Find_Object_Type("EotH_Scout_Brigade"), 1, "Land"}
			,{Find_Object_Type("Gilzean_Brigade"), 2, "Land"}
			,{Find_Object_Type("AirStraeker_Company"), 1, "Land"}
			,{Find_Object_Type("Mortar_Company"), 1, "Land"}
            }
    elseif faction == Find_Player("Chiss") then
            Unit_Table = {
			{Find_Object_Type("Fruoro"), 5, "Space"}
			,{Find_Object_Type("Syndic_Destroyer"), 5, "Space"}
			,{Find_Object_Type("Ormos"), 4, "Space"}
            ,{Find_Object_Type("Muqaraea"), 4, "Space"}
            ,{Find_Object_Type("Syzygos"), 3, "Space"}
            ,{Find_Object_Type("Kynigos"), 3, "Space"}
            ,{Find_Object_Type("Baomu"), 2, "Space"}
            ,{Find_Object_Type("Rohkea"), 4, "Space"}
            ,{Find_Object_Type("Kuuro"), 4, "Space"}
			,{Find_Object_Type("Phalanx_Trooper_Squad"), 4, "Land"}
			,{Find_Object_Type("EotH_Kirov_Brigade"), 1, "Land"}
			,{Find_Object_Type("MMT_Brigade"), 1, "Land"}
			,{Find_Object_Type("Flame_Tank_Company"), 2, "Land"}
			,{Find_Object_Type("RFT_Brigade"), 3, "Land"}
			,{Find_Object_Type("EotH_Scout_Brigade"), 1, "Land"}
			,{Find_Object_Type("Gilzean_Brigade"), 2, "Land"}
			,{Find_Object_Type("AirStraeker_Company"), 1, "Land"}
            }
    elseif faction == Find_Player("Eriadu_Authority") then            
        Unit_Table = {
            {Find_Object_Type("IPV1_System_Patrol_Craft"), 5, "Space"}
            ,{Find_Object_Type("Gamma_ATR_6_Squadron"), 2, "Space"}			
            ,{Find_Object_Type("Raider_II_Corvette"), 3, "Space"}			
            ,{Find_Object_Type("Arquitens"), 4, "Space"}
            ,{Find_Object_Type("Eidolon"), 2, "Space"}
			,{Find_Object_Type("Generic_Gladiator"), 4, "Space"}
            ,{Find_Object_Type("Galleon"), 2, "Space"}			
            ,{Find_Object_Type("Generic_Imperial_I_Frigate"), 4, "Space"}
            ,{Find_Object_Type("Generic_Victory_Destroyer"), 3, "Space"}
            ,{Find_Object_Type("Generic_Star_Destroyer_Two"), 1, "Space"}
            ,{Find_Object_Type("Generic_Star_Destroyer"), 1, "Space"}
            ,{Find_Object_Type("Army_Trooper_Squad"), 5, "Land"}
            ,{Find_Object_Type("Army_Guard_Squad"), 3, "Land"}			
            ,{Find_Object_Type("Army_Special_Missions_Squad"), 2, "Land"}
            ,{Find_Object_Type("Imperial_Army_Commando_Squad"), 1, "Land"}			
            ,{Find_Object_Type("Imperial_ISB_Infiltrator_Squad"), 1, "Land"}			
            ,{Find_Object_Type("Imperial_64Y_Company"), 3, "Land"}
            ,{Find_Object_Type("Imperial_AT_MP_Company"), 2, "Land"}
            ,{Find_Object_Type("Imperial_1L_Tank_Company"), 4, "Land"}
            ,{Find_Object_Type("Imperial_1M_Tank_Company"), 3, "Land"}			
            ,{Find_Object_Type("Imperial_1H_Tank_Company"), 2, "Land"}
            ,{Find_Object_Type("Imperial_AT_AT_Company"), 1, "Land"}
            ,{Find_Object_Type("Imperial_TRMB_Company"), 1, "Land"}
            ,{Find_Object_Type("Imperial_Lancet_Group"), 1, "Land"}
            ,{Find_Object_Type("Imperial_Flashblind_Group"), 1, "Land"}
            ,{Find_Object_Type("Imperial_Light_Artillery_Company"), 1, "Land"}
            }
    elseif faction == Find_Player("Pentastar") then           
        Unit_Table = {
            {Find_Object_Type("Raider_Corvette"), 4, "Space"}
            ,{Find_Object_Type("Decimator_Squadron"), 2, "Space"}
            ,{Find_Object_Type("Corellian_Buccaneer"), 2, "Space"}
            ,{Find_Object_Type("Tartan_Patrol_Cruiser"), 3, "Space"}
            ,{Find_Object_Type("Battle_Horn"), 3, "Space"}
			,{Find_Object_Type("Victory_II_Frigate"), 4, "Space"}
			,{Find_Object_Type("Trenchant"), 4, "Space"}			
			,{Find_Object_Type("Escort_Carrier"), 2, "Space"}		
            ,{Find_Object_Type("Enforcer"), 4, "Space"}
			,{Find_Object_Type("Dreadnaught_Empire"), 3, "Space"}
			,{Find_Object_Type("Imperial_Cargo_Ship"), 2, "Space"}
			,{Find_Object_Type("Generic_Acclamator_Assault_Ship_Leveler"), 3, "Space"}
			,{Find_Object_Type("Generic_Venator"), 3, "Space"}
            ,{Find_Object_Type("Generic_Procursator"), 3, "Space"}
            ,{Find_Object_Type("Generic_Tector"), 1, "Space"}
            ,{Find_Object_Type("Generic_Star_Destroyer"), 1, "Space"}
            ,{Find_Object_Type("Enforcer_Trooper_Squad"), 5, "Land"}
            ,{Find_Object_Type("Army_Guard_Squad"), 2, "Land"}			
            ,{Find_Object_Type("Pentastar_Army_Trooper_Squad"), 3, "Land"}
            ,{Find_Object_Type("Imperial_Guardian_Protector_Squad"), 1, "Land"}
            ,{Find_Object_Type("Imperial_Army_Commando_Squad"), 1, "Land"}			
            ,{Find_Object_Type("Imperial_IntSec_Operator_Squad"), 1, "Land"}		
            ,{Find_Object_Type("Imperial_TIE_Mauler_Company"), 2, "Land"}
            ,{Find_Object_Type("Imperial_AT_PT_Company"), 3, "Land"}
            ,{Find_Object_Type("Imperial_AT_DP_Company"), 2, "Land"}
            ,{Find_Object_Type("Imperial_Century_Tank_Company"), 2, "Land"}			
            ,{Find_Object_Type("Imperial_B5_Juggernaut_Company"), 1, "Land"}
            ,{Find_Object_Type("Imperial_C10_Siege_Tower_Company"), 1, "Land"}
            ,{Find_Object_Type("Imperial_Gaba18_Group"), 2, "Land"}
            ,{Find_Object_Type("Imperial_Nemesis_Gunship_Group"), 1, "Land"}
            ,{Find_Object_Type("Imperial_Heavy_Artillery_Company"), 1, "Land"}
            }
	elseif faction == Find_Player("Zsinj_Empire") then            
        Unit_Table = {
            {Find_Object_Type("CR90_Zsinj"), 5, "Space"}
            ,{Find_Object_Type("YZ_775_Squadron"), 2, "Space"}
            ,{Find_Object_Type("Lancer_Frigate"), 2, "Space"}
            ,{Find_Object_Type("Nebulon_B_Zsinj"), 5, "Space"}
			,{Find_Object_Type("Surveyor_Frigate"), 4, "Space"}
			,{Find_Object_Type("Dragon_Heavy_Cruiser"), 2, "Space"}
			,{Find_Object_Type("CR92_Assassin"), 4, "Space"}			
			,{Find_Object_Type("Neutron_Star"), 4, "Space"}
            ,{Find_Object_Type("Interceptor_Frigate"), 2, "Space"}
            ,{Find_Object_Type("Action_VI_Support"), 2, "Space"}
            ,{Find_Object_Type("Super_Transport_XI_Modified"), 1, "Space"}
            ,{Find_Object_Type("Star_Galleon"), 2, "Space"}			
            ,{Find_Object_Type("Generic_Victory_Destroyer_TWO"), 3, "Space"}
            ,{Find_Object_Type("Generic_Star_Destroyer_Two"), 1, "Space"}
            ,{Find_Object_Type("Generic_Star_Destroyer"), 1, "Space"}
            ,{Find_Object_Type("Army_Trooper_Squad"), 4, "Land"}
            ,{Find_Object_Type("Zsinj_Raptor_Squad"), 3, "Land"}
            ,{Find_Object_Type("Zsinj_74Z_Bike_Company"), 1, "Land"}
            ,{Find_Object_Type("Army_Guard_Squad"), 2, "Land"}			
            ,{Find_Object_Type("EVO_Trooper_Platoon"), 1, "Land"}
            ,{Find_Object_Type("Imperial_IntSec_Operator_Squad"), 1, "Land"}			
            ,{Find_Object_Type("Imperial_ULAV_Company"), 2, "Land"}
            ,{Find_Object_Type("Imperial_Repulsor_Scout_Company"), 2, "Land"}
            ,{Find_Object_Type("Imperial_Chariot_LAV_Company"), 1, "Land"}
            ,{Find_Object_Type("Imperial_AT_AP_Walker_Company"), 1, "Land"}
            ,{Find_Object_Type("Imperial_Repulsor_Scout_Company"), 2, "Land"}			
            ,{Find_Object_Type("Imperial_PX10_Company"), 3, "Land"}
            ,{Find_Object_Type("Imperial_APC_Company"), 1, "Land"}
            ,{Find_Object_Type("Imperial_A9_Fortress_Company"), 1, "Land"}
            ,{Find_Object_Type("Imperial_IDT_Group"), 1, "Land"}
            ,{Find_Object_Type("Imperial_SPMAT_Company"), 1, "Land"}
            }
	elseif faction == Find_Player("Greater_Maldrood") then            
        Unit_Table = {
            {Find_Object_Type("Tartan_Patrol_Cruiser"), 3, "Space"}
			,{Find_Object_Type("Guardian_Squadron"), 5, "Space"}
			,{Find_Object_Type("Customs_Corvette"), 5, "Space"}
            ,{Find_Object_Type("Carrack_Cruiser"), 5, "Space"}
            ,{Find_Object_Type("Broadside_Cruiser"), 3, "Space"}
            ,{Find_Object_Type("Vigil"), 4, "Space"}
			,{Find_Object_Type("Generic_Pursuit"), 2, "Space"}
            ,{Find_Object_Type("Strike_Cruiser"), 4, "Space"}
            ,{Find_Object_Type("Vindicator_Cruiser"), 2, "Space"}
            ,{Find_Object_Type("Generic_Acclamator_Assault_Ship_II"), 2, "Space"}
            ,{Find_Object_Type("Star_Galleon"), 2, "Space"}			
            ,{Find_Object_Type("Generic_Imperial_II_Frigate"), 4, "Space"}
            ,{Find_Object_Type("Generic_Victory_Destroyer"), 2, "Space"}
            ,{Find_Object_Type("Crimson_Victory"), 3, "Space"}
            ,{Find_Object_Type("Generic_Tector"), 1, "Space"}
            ,{Find_Object_Type("Generic_Star_Destroyer"), 1, "Space"}
            ,{Find_Object_Type("Army_Trooper_Squad"), 4, "Land"}
            ,{Find_Object_Type("Army_Guard_Squad"), 2, "Land"}
            ,{Find_Object_Type("Imperial_Fleet_Commando_Squad"), 1, "Land"}			
            ,{Find_Object_Type("Imperial_ISB_Infiltrator_Squad"), 1, "Land"}			
            ,{Find_Object_Type("Imperial_74Z_Bike_Company"), 1, "Land"}			
            ,{Find_Object_Type("Imperial_Navy_Commando_Squad"), 2, "Land"}
            ,{Find_Object_Type("Imperial_AT_RT_Company"), 3, "Land"}
            ,{Find_Object_Type("Imperial_ISP_Company"), 2, "Land"}		   
            ,{Find_Object_Type("Imperial_RTT_Company"), 3, "Land"}		   
            ,{Find_Object_Type("Imperial_SA5_Company"), 2, "Land"}
            ,{Find_Object_Type("Imperial_2M_Company"), 2, "Land"}
            ,{Find_Object_Type("Imperial_A5_Juggernaut_Company"), 1, "Land"}
            ,{Find_Object_Type("Imperial_Heavy_Recovery_Vehicle_Company"), 1, "Land"}
            ,{Find_Object_Type("Imperial_INT4_Group"), 1, "Land"}
            ,{Find_Object_Type("Imperial_MAAT_Group"), 1, "Land"}
            ,{Find_Object_Type("Imperial_Missile_Artillery_Company"), 1, "Land"}
            }
    elseif faction == Find_Player("Corporate_Sector") then       
        Unit_Table = {
            {Find_Object_Type("Citadel_Cruiser_Squadron"), 2, "Space"}
            ,{Find_Object_Type("Gozanti_Cruiser_Squadron"), 1, "Space"}
			,{Find_Object_Type("Marauder_Cruiser"), 5, "Space"}
			,{Find_Object_Type("Marauder_Missile_Cruiser"), 3, "Space"}
			,{Find_Object_Type("Etti_Lighter"), 4, "Space"}
			,{Find_Object_Type("Nebulon_B_Frigate"), 3, "Space"}
			,{Find_Object_Type("Quasar"), 3, "Space"}
            ,{Find_Object_Type("Recusant"), 4, "Space"}
			,{Find_Object_Type("Neutron_Star"), 4, "Space"}
			,{Find_Object_Type("Generic_Gladiator"), 3, "Space"}
			,{Find_Object_Type("Dreadnaught_Empire"), 3, "Space"}			
			,{Find_Object_Type("Liberator_Cruiser"), 2, "Space"}			
            ,{Find_Object_Type("Galleon"), 2, "Space"}			
            ,{Find_Object_Type("Generic_Victory_Destroyer"), 3, "Space"}
            ,{Find_Object_Type("Generic_Victory_Destroyer_Two"), 1, "Space"}
            ,{Find_Object_Type("Bulwark_I"), 3, "Space"}
            ,{Find_Object_Type("Dauntless"), 1, "Space"}
            ,{Find_Object_Type("Invincible_Cruiser"), 1, "Space"}
            ,{Find_Object_Type("Espo_Squad"), 5, "Land"}
            ,{Find_Object_Type("Heavy_Espo_Squad"), 3, "Land"}			
            ,{Find_Object_Type("CSA_B1_Droid_Squad"), 2, "Land"}
            ,{Find_Object_Type("CSA_Destroyer_Droid_Company"), 1, "Land"}
			,{Find_Object_Type("Class_I_Company"), 2, "Land"}
            ,{Find_Object_Type("Espo_Walker_Squad"), 3, "Land"}			
            ,{Find_Object_Type("GX12_Company"), 2, "Land"}			
            ,{Find_Object_Type("Strikebreaker_Group"), 1, "Land"}
            ,{Find_Object_Type("Persuader_Company"), 1, "Land"}
            ,{Find_Object_Type("JX40_Group"), 1, "Land"}
            ,{Find_Object_Type("SX20_Company"), 2, "Land"}
            ,{Find_Object_Type("X10_Group"), 3, "Land"}
            ,{Find_Object_Type("K222_Group"), 1, "Land"}
            ,{Find_Object_Type("Hailfire_Company"), 1, "Land"}
            ,{Find_Object_Type("CA_Artillery_Company"), 1, "Land"}
            }
    elseif faction == Find_Player("Hutt_Cartels") then       
        Unit_Table = {
            {Find_Object_Type("Heavy_Minstrel_Yacht"), 2, "Space"}
            ,{Find_Object_Type("Ubrikkian_Frigate"), 1, "Space"}
            ,{Find_Object_Type("Kossak_Frigate"), 5, "Space"}
            ,{Find_Object_Type("Juvard_Frigate"), 4, "Space"}
            ,{Find_Object_Type("Kaloth_Battlecruiser"), 4, "Space"}
            ,{Find_Object_Type("Barabbula_Frigate"), 4, "Space"}
            ,{Find_Object_Type("Dreadnaught_Empire"), 3, "Space"}
			,{Find_Object_Type("Military_Soldier_Team"), 3, "Land"}
			,{Find_Object_Type("Light_Mercenary_Team"), 3, "Land"} 
            ,{Find_Object_Type("Mercenary_Team"), 3, "Land"}    
            ,{Find_Object_Type("Elite_Mercenary_Team"), 3, "Land"}  
			,{Find_Object_Type("Hutt_Flare_S_Company"), 2, "Land"}
			,{Find_Object_Type("AST5_Company"), 1, "Land"}	
            ,{Find_Object_Type("MAL_Rocket_Vehicle_Company"), 1, "Land"}
        }
    elseif faction == Find_Player("SsiRuuvi_Imperium") then       
        Unit_Table = {
            {Find_Object_Type("Wurrif_Cruiser"), 4, "Space"}
            ,{Find_Object_Type("Lwhekk_Manufacturing_Ship"), 1, "Space"}
            ,{Find_Object_Type("Shree_Cruiser"), 1, "Space"}		
            ,{Find_Object_Type("SsiRuuk_Soldier_Squad"), 5, "Land"}
        }
    elseif faction == Find_Player("Yevetha") then
            Unit_Table = {
			{Find_Object_Type("Armadia"), 5, "Space"}
			,{Find_Object_Type("C_type_Thrustship"), 5, "Space"}
			,{Find_Object_Type("Victory_I_Frigate"), 4, "Space"}
            ,{Find_Object_Type("Yevetha_Dreadnaught"), 1, "Space"}
            ,{Find_Object_Type("Generic_Gladiator_Two"), 3, "Space"}
            ,{Find_Object_Type("Generic_Star_Destroyer_Two"), 1, "Space"}
            ,{Find_Object_Type("Surveyor_Frigate"), 2, "Space"}
            ,{Find_Object_Type("Active_Frigate"), 4, "Space"}
            ,{Find_Object_Type("Generic_Acclamator_Assault_Ship_II"), 4, "Space"}
			,{Find_Object_Type("Imperial_AT_ST_A_Company"), 4, "Land"}
			,{Find_Object_Type("Imperial_AT_AA_Company"), 1, "Land"}
			,{Find_Object_Type("Imperial_Light_Artillery_Company"), 1, "Land"}			
			,{Find_Object_Type("Imperial_TIE_Mauler_Company"), 3, "Land"}
			,{Find_Object_Type("Imperial_AT_TE_Walker_Company"), 1, "Land"}
			,{Find_Object_Type("Imperial_B5_Juggernaut_Company"), 2, "Land"}
			,{Find_Object_Type("Imperial_LAAT_Group"), 1, "Land"}
            }		
    elseif faction == Find_Player("Corellia") then
        Unit_Table = {
            {Find_Object_Type("Strike_Cruiser"), 3, "Space"}
            ,{Find_Object_Type("Strike_Interdictor"), 1, "Space"}			
            ,{Find_Object_Type("CC7700"), 1, "Space"}
			,{Find_Object_Type("Starbolt"), 3, "Space"}
			,{Find_Object_Type("Proficient"), 4, "Space"}
			,{Find_Object_Type("Proficient_tender"), 2, "Space"}
            ,{Find_Object_Type("YZ_775_Squadron"), 3, "Space"}			
            ,{Find_Object_Type("Corellian_Corvette"), 5, "Space"}
            ,{Find_Object_Type("Corellian_Gunboat"), 5, "Space"}
            ,{Find_Object_Type("CR92_Assassin"), 2, "Space"}			
            ,{Find_Object_Type("Corellian_Buccaneer"), 2, "Space"}
            ,{Find_Object_Type("Interceptor_Frigate"), 4, "Space"}
            ,{Find_Object_Type("Action_VI_Support"), 2, "Space"}
            ,{Find_Object_Type("Generic_Victory_Destroyer"), 1, "Space"}			
            ,{Find_Object_Type("Generic_Star_Destroyer"), 1, "Space"}			
            ,{Find_Object_Type("Torpedo_Sphere"), 1, "Space"}
            ,{Find_Object_Type("Military_Soldier_Team"), 3, "Land"}
			,{Find_Object_Type("Police_Responder_Team"), 2, "Land"}
            ,{Find_Object_Type("Arrow_23_Company"), 1, "Land"}
            ,{Find_Object_Type("Rebel_AAC_2_Company"), 1, "Land"}
            ,{Find_Object_Type("Rebel_Freerunner_Company"), 1, "Land"}			
            ,{Find_Object_Type("Rebel_Tracker_Company"), 1, "Land"}
			,{Find_Object_Type("Teklos_Company"), 1, "Land"}
            ,{Find_Object_Type("Talon_Cloud_Car_Group"), 1, "Land"}			
            ,{Find_Object_Type("Cor_VAAT_Group"), 1, "Land"}
        }
    elseif faction == Find_Player("Mandalorians") then
        Unit_Table = {
            {Find_Object_Type("Keldabe"), 5, "Space"}		
            ,{Find_Object_Type("Neutron_Star"), 2, "Space"}
            ,{Find_Object_Type("Neutron_Star_Tender"), 1, "Space"}
            ,{Find_Object_Type("Dreadnaught_Carrier"), 1, "Space"}			
            ,{Find_Object_Type("Vengeance_Frigate"), 3, "Space"}
            ,{Find_Object_Type("Dreadnaught_Empire"), 3, "Space"}			
            ,{Find_Object_Type("Crusader_Gunship"), 5, "Space"}
            ,{Find_Object_Type("Komrk_Gunship_Squadron"), 5, "Space"}
            ,{Find_Object_Type("Generic_Venator"), 1, "Space"}
            ,{Find_Object_Type("Mandalorian_Soldier_Company"), 3, "Land"}
			,{Find_Object_Type("Mandalorian_Commando_Company"), 2, "Land"}		
            ,{Find_Object_Type("Canderous_Assault_Tank_Company"), 1, "Land"}
            ,{Find_Object_Type("MAL_Rocket_Vehicle_Company"), 1, "Land"}			
        }
    elseif faction == Find_Player("Warlords") then
        Unit_Table = {
            {Find_Object_Type("CR90_Zsinj"), 5, "Space"}
            ,{Find_Object_Type("IPV1_System_Patrol_Craft"), 5, "Space"}			
            ,{Find_Object_Type("Corellian_Gunboat"), 5, "Space"}
            ,{Find_Object_Type("Nebulon_B_Zsinj"), 5, "Space"}			
            ,{Find_Object_Type("Lancer_Frigate"), 2, "Space"}
            ,{Find_Object_Type("Star_Galleon"), 1, "Space"}
            ,{Find_Object_Type("Carrack_Cruiser"), 4, "Space"}
            ,{Find_Object_Type("Strike_Cruiser"), 4, "Space"}			
            ,{Find_Object_Type("Escort_Carrier"), 3, "Space"}
            ,{Find_Object_Type("Dreadnaught_Empire"), 4, "Space"}
			,{Find_Object_Type("Generic_Acclamator_Assault_Ship_I"), 1, "Space"}			
            ,{Find_Object_Type("Generic_Interdictor_Cruiser"), 1, "Space"}			
            ,{Find_Object_Type("Generic_Victory_Destroyer"), 2, "Space"}
            ,{Find_Object_Type("Generic_Victory_Destroyer_Two"), 2, "Space"}
            ,{Find_Object_Type("Generic_Star_Destroyer_Two"), 1, "Space"}
            ,{Find_Object_Type("Generic_Star_Destroyer"), 1, "Space"}			
            ,{Find_Object_Type("Torpedo_Sphere"), 0.1, "Space"}
            ,{Find_Object_Type("Altor_Replenishment_Ship"), 0.1, "Space"}			
            ,{Find_Object_Type("Army_Guard_Squad"), 4, "Land"}
            ,{Find_Object_Type("Army_Trooper_Squad"), 4, "Land"}
            ,{Find_Object_Type("Army_Special_Missions_Squad"), 3, "Land"}		
            ,{Find_Object_Type("Navy_Trooper_Squad"), 4, "Land"}			
            ,{Find_Object_Type("Imperial_Navy_Commando_Squad"), 3, "Land"}			
            ,{Find_Object_Type("Imperial_Stormtrooper_Squad"), 2, "Land"}			
            ,{Find_Object_Type("Imperial_Compforce_Assault_Squad"), 3, "Land"}
            ,{Find_Object_Type("Imperial_74Z_Bike_Company"), 1, "Land"}
            ,{Find_Object_Type("Imperial_64Y_Company"), 1, "Land"}
            ,{Find_Object_Type("Imperial_PX10_Company"), 3, "Land"}
            ,{Find_Object_Type("Imperial_AT_ST_Company"), 3, "Land"}
            ,{Find_Object_Type("Imperial_Chariot_LAV_Company"), 1, "Land"}			
            ,{Find_Object_Type("Imperial_SA5_Company"), 2, "Land"}
            ,{Find_Object_Type("Imperial_PX4_Company"), 2, "Land"}			
            ,{Find_Object_Type("Imperial_A9_Fortress_Company"), 1, "Land"}
            ,{Find_Object_Type("Imperial_A5_Juggernaut_Company"), 1, "Land"}			
            ,{Find_Object_Type("Imperial_AT_AT_Company"), 1, "Land"}			
        }		
    else
        Unit_Table = {
            {Find_Object_Type("Generic_Venator"), 3, "Space"}
			,{Find_Object_Type("Dauntless"), 2, "Space"}
			,{Find_Object_Type("Generic_Providence"), 0.5, "Space"}
			,{Find_Object_Type("Keldabe"), 1, "Space"}
			,{Find_Object_Type("Space_ARC_Cruiser"), 1, "Space"}			
			,{Find_Object_Type("Invincible_Cruiser"), 1, "Space"}
            ,{Find_Object_Type("Corellian_Corvette"), 5, "Space"}
            ,{Find_Object_Type("Corellian_Gunboat"), 5, "Space"}
            ,{Find_Object_Type("Carrack_Cruiser"), 4, "Space"}			
            ,{Find_Object_Type("Generic_Star_Destroyer"), 1, "Space"}			
			,{Find_Object_Type("IPV1_System_Patrol_Craft"), 5, "Space"}
			,{Find_Object_Type("Customs_Corvette"), 5, "Space"}
            ,{Find_Object_Type("Marauder_Cruiser"), 5, "Space"}
			,{Find_Object_Type("Marauder_Missile_Cruiser"), 3, "Space"}
            ,{Find_Object_Type("Dreadnaught_Empire"), 4, "Space"}
            ,{Find_Object_Type("Generic_Victory_Destroyer"), 3, "Space"}
			,{Find_Object_Type("Generic_Gladiator"), 2, "Space"}
			,{Find_Object_Type("Generic_Acclamator_Assault_Ship_I"), 2, "Space"}
			,{Find_Object_Type("Generic_Acclamator_Assault_Ship_II"), 2, "Space"}
			,{Find_Object_Type("Generic_Acclamator_Assault_Ship_Leveler"), 2, "Space"}
			,{Find_Object_Type("Generic_Imperial_I_Frigate"), 2, "Space"}			
			,{Find_Object_Type("Generic_Imperial_II_Frigate"), 2, "Space"}
			,{Find_Object_Type("Munificent"), 0.5, "Space"}				
			,{Find_Object_Type("Recusant"), 0.5, "Space"}
			,{Find_Object_Type("Captor"), 0.5, "Space"}			
            ,{Find_Object_Type("Liberator_Cruiser"), 2, "Space"}	
            ,{Find_Object_Type("Nebulon_B_Zsinj"), 5, "Space"}
			,{Find_Object_Type("Super_Transport_VI"), 1, "Space"}
			,{Find_Object_Type("Super_Transport_VII"), 1, "Space"}
			,{Find_Object_Type("Super_Transport_VII_Interdictor"), 1, "Space"}
			,{Find_Object_Type("Super_Transport_XI"), 1, "Space"}
			,{Find_Object_Type("Guardian_Lasers_Squadron"), 4, "Space"}
            ,{Find_Object_Type("Citadel_Cruiser_Squadron"), 4, "Space"}
            ,{Find_Object_Type("Gozanti_Cruiser_Squadron"), 5, "Space"}
            ,{Find_Object_Type("Neutron_Star"), 4, "Space"}
			,{Find_Object_Type("Neutron_Star_Tender"), 1, "Space"}
            ,{Find_Object_Type("Galleon"), 2, "Space"}
            ,{Find_Object_Type("CC7700"), 1, "Space"}
            ,{Find_Object_Type("Generic_Quasar"), 1, "Space"}			
            ,{Find_Object_Type("Crusader_Gunship"), 1, "Space"}
			,{Find_Object_Type("Interceptor_Frigate"), 5, "Space"}
            ,{Find_Object_Type("Kaloth_Battlecruiser"), 2, "Space"}
            ,{Find_Object_Type("Heavy_Minstrel_Yacht"), 1, "Space"}			
			,{Find_Object_Type("Starbolt"), 2, "Space"}
			,{Find_Object_Type("Proficient"), 1, "Space"}
			,{Find_Object_Type("Proficient_tender"), 1, "Space"}						
            ,{Find_Object_Type("Police_Responder_Team"), 2, "Land"}
            ,{Find_Object_Type("Security_Trooper_Team"), 2, "Land"}
            ,{Find_Object_Type("Military_Soldier_Team"), 3, "Land"}
            ,{Find_Object_Type("PDF_Soldier_Team"), 3, "Land"}
			,{Find_Object_Type("PDF_Tactical_Unit_Team"), 2, "Land"}
            ,{Find_Object_Type("Light_Mercenary_Team"), 3, "Land"}	
            ,{Find_Object_Type("Mercenary_Team"), 3, "Land"}	
            ,{Find_Object_Type("Elite_Mercenary_Team"), 3, "Land"}			
            ,{Find_Object_Type("Scavenger_Team"), 2, "Land"}
            ,{Find_Object_Type("Heavy_Scavenger_Team"), 1, "Land"}
            ,{Find_Object_Type("SD_6_Droid_Company"), 1, "Land"}
            ,{Find_Object_Type("SD_9_Droid_Company"), 1, "Land"}			
            ,{Find_Object_Type("CSA_B1_Droid_Squad"), 1, "Land"}
            ,{Find_Object_Type("CSA_Destroyer_Droid_Company"), 1, "Land"}	
            ,{Find_Object_Type("Destroyer_Droid_II_Company"), 0.5, "Land"}			
			,{Find_Object_Type("Overracer_Speeder_Bike_Company"), 2, "Land"}	
			,{Find_Object_Type("X34_Technical_Company"), 3, "Land"}
            ,{Find_Object_Type("Imperial_AT_AP_Walker_Company"), 2, "Land"}
            ,{Find_Object_Type("Imperial_AT_RT_Company"), 1, "Land"}
			,{Find_Object_Type("Espo_Walker_Early_Squad"), 2, "Land"}
            ,{Find_Object_Type("ISP_Company"), 1, "Land"}
			,{Find_Object_Type("Imperial_LAAT_Group"), 1, "Land"}
			,{Find_Object_Type("Imperial_MAAT_Group"), 1, "Land"}			
            ,{Find_Object_Type("AAC_1_Company"), 1, "Land"}
			,{Find_Object_Type("Imperial_TNT_Company"), 1, "Land"}
			,{Find_Object_Type("Imperial_TX130_Company"), 2, "Land"}
			,{Find_Object_Type("Imperial_ULAV_Company"), 2, "Land"}			
			,{Find_Object_Type("Imperial_AT_PT_Company"), 3, "Land"}
			,{Find_Object_Type("Arrow_23_Company"), 3, "Land"}
			,{Find_Object_Type("ULAV_Early_Company"), 2, "Land"}			
			,{Find_Object_Type("AA70_Company"), 2, "Land"}			
			,{Find_Object_Type("T2A_Company"), 2, "Land"}
			,{Find_Object_Type("T1A_Company"), 1, "Land"}			
			,{Find_Object_Type("Freerunner_Early_Company"), 3, "Land"}
            ,{Find_Object_Type("Freerunner_Assault_Company"), 1, "Land"}			
			,{Find_Object_Type("Storm_Cloud_Car_Group"), 1, "Land"}
			,{Find_Object_Type("Skyhopper_Group"), 1, "Land"}
			,{Find_Object_Type("Skyhopper_Antivehicle_Group"), 1, "Land"}
			,{Find_Object_Type("Skyhopper_Primitive_Group"), 1, "Land"}
			,{Find_Object_Type("Skyhopper_Security_Group"), 1, "Land"}
			,{Find_Object_Type("Imperial_Gaba18_Group"), 1, "Land"}
			,{Find_Object_Type("Rebel_Snowspeeder_Wing"), 1, "Land"}
			,{Find_Object_Type("Talon_Cloud_Car_Group"), 1, "Land"}			
			,{Find_Object_Type("JX30_Group"), 1, "Land"}
			,{Find_Object_Type("T4A_Company"), 2, "Land"}
			,{Find_Object_Type("T3A_Company"), 1, "Land"}
			,{Find_Object_Type("SA5_Company_Early_Company"), 2, "Land"}			
            ,{Find_Object_Type("MZ8_Tank_Company"), 1, "Land"}			
            ,{Find_Object_Type("Imperial_AT_TE_Walker_Company"), 1, "Land"}
            ,{Find_Object_Type("Imperial_PX4_Company"), 1, "Land"}
			,{Find_Object_Type("Teklos_Company"), 1, "Land"}
            ,{Find_Object_Type("Imperial_A5_Juggernaut_Company"), 1, "Land"}
            ,{Find_Object_Type("Imperial_A6_Juggernaut_Company"), 1, "Land"}			
			,{Find_Object_Type("Rebel_AA5_Company"), 4, "Land"}
            ,{Find_Object_Type("Rebel_Freerunner_Company"), 1, "Land"}
            ,{Find_Object_Type("Freerunner_AA_Company"), 2, "Land"}			
            ,{Find_Object_Type("Aratech_Battle_Platform_Company"), 1, "Land"}	
            ,{Find_Object_Type("MAL_Rocket_Vehicle_Company"), 1, "Land"}			
        }
    end

        return Unit_Table
end

function DefineGroundBaseTable(faction)
    if faction == Find_Player("Empire") then
        Groundbase_Table = {
                Find_Object_Type("E_Ground_Barracks"),
                Find_Object_Type("E_Ground_Barracks"),
                Find_Object_Type("E_Ground_Light_Vehicle_Factory"),					
                Find_Object_Type("E_Ground_Heavy_Vehicle_Factory"),
				Find_Object_Type("E_Ground_Advanced_Vehicle_Factory"),					
            }
    elseif faction == Find_Player("Rebel") then         
        Groundbase_Table = {
                Find_Object_Type("R_Ground_Barracks"),
                Find_Object_Type("R_Ground_Barracks"),
                Find_Object_Type("R_Ground_Light_Vehicle_Factory"),
                Find_Object_Type("R_Ground_Heavy_Vehicle_Factory"),
                }
	elseif faction == Find_Player("Hapes_Consortium") then         
        Groundbase_Table = {
                Find_Object_Type("HC_Ground_Barracks"),
                Find_Object_Type("HC_Ground_Barracks"),
                Find_Object_Type("HC_Ground_Light_Vehicle_Factory"),
                Find_Object_Type("HC_Ground_Heavy_Vehicle_Factory"),
                }
    elseif faction == Find_Player("EmpireoftheHand") or faction == Find_Player("Chiss") then   
        Groundbase_Table = {
                Find_Object_Type("U_Ground_Barracks"),
                Find_Object_Type("U_Ground_Barracks"),
                Find_Object_Type("U_Ground_Vehicle_Factory"),
                Find_Object_Type("U_Ground_Droid_Works"),
                }
    elseif faction == Find_Player("Eriadu_Authority") then                  
        Groundbase_Table = {
                Find_Object_Type("A_Ground_Barracks"),
                Find_Object_Type("A_Ground_Barracks"),
                Find_Object_Type("A_Ground_Light_Vehicle_Factory"),
                Find_Object_Type("A_Ground_Heavy_Vehicle_Factory"),
				Find_Object_Type("A_Ground_Advanced_Vehicle_Factory"),	
                }
    elseif faction == Find_Player("Pentastar") then          
        Groundbase_Table = {
                Find_Object_Type("P_Ground_Barracks"),
                Find_Object_Type("P_Ground_Barracks"),
                Find_Object_Type("P_Ground_Light_Vehicle_Factory"),
                Find_Object_Type("P_Ground_Heavy_Vehicle_Factory"),
				Find_Object_Type("P_Ground_Advanced_Vehicle_Factory"),	
                }
	elseif faction == Find_Player("Zsinj_Empire") then          
        Groundbase_Table = {
                Find_Object_Type("Z_Ground_Barracks"),
                Find_Object_Type("Z_Ground_Barracks"),
                Find_Object_Type("Z_Ground_Light_Vehicle_Factory"),
                Find_Object_Type("Z_Ground_Heavy_Vehicle_Factory"),
				Find_Object_Type("Z_Ground_Advanced_Vehicle_Factory"),	
                }
	elseif faction == Find_Player("Greater_Maldrood") then          
        Groundbase_Table = {
                Find_Object_Type("T_Ground_Barracks"),
                Find_Object_Type("T_Ground_Barracks"),
                Find_Object_Type("T_Ground_Light_Vehicle_Factory"),
                Find_Object_Type("T_Ground_Heavy_Vehicle_Factory"),
				Find_Object_Type("T_Ground_Advanced_Vehicle_Factory"),	
                }
    elseif faction == Find_Player("Corporate_Sector") then               
        Groundbase_Table = {
                Find_Object_Type("C_Ground_Barracks"),
                Find_Object_Type("C_Ground_Barracks"),
                Find_Object_Type("C_Ground_Light_Vehicle_Factory"),
                Find_Object_Type("C_Ground_Heavy_Vehicle_Factory"),
                }
	elseif faction == Find_Player("SsiRuuvi_Imperium") then               
        Groundbase_Table = {
                Find_Object_Type("S_Ground_Barracks"),
                Find_Object_Type("S_Ground_Barracks"),
                -- Find_Object_Type("S_Ground_Light_Vehicle_Factory"),
                -- Find_Object_Type("S_Ground_Heavy_Vehicle_Factory"),
                }
    elseif faction == Find_Player("Warlords") then               
        Groundbase_Table = {
                Find_Object_Type("E_Ground_Barracks"),
                Find_Object_Type("E_Ground_Barracks"),
                Find_Object_Type("E_Ground_Barracks"),
                Find_Object_Type("A_Ground_Barracks"),			
                Find_Object_Type("A_Ground_Barracks"),				
                Find_Object_Type("A_Ground_Barracks"),
				Find_Object_Type("Z_Ground_Barracks"),			
                Find_Object_Type("Z_Ground_Barracks"),				
                Find_Object_Type("Z_Ground_Barracks"),
                Find_Object_Type("T_Ground_Barracks"),
                Find_Object_Type("T_Ground_Barracks"),				
                Find_Object_Type("T_Ground_Barracks"),				
                Find_Object_Type("E_Ground_Light_Vehicle_Factory"),
                Find_Object_Type("P_Ground_Light_Vehicle_Factory"),
                Find_Object_Type("Z_Ground_Light_Vehicle_Factory"),
                Find_Object_Type("T_Ground_Light_Vehicle_Factory"),
                Find_Object_Type("A_Ground_Light_Vehicle_Factory"),				
                Find_Object_Type("E_Ground_Heavy_Vehicle_Factory"),
                Find_Object_Type("P_Ground_Heavy_Vehicle_Factory"),				
                Find_Object_Type("Z_Ground_Heavy_Vehicle_Factory"),
                Find_Object_Type("T_Ground_Heavy_Vehicle_Factory"),
                Find_Object_Type("A_Ground_Heavy_Vehicle_Factory"),
				Find_Object_Type("A_Ground_Advanced_Vehicle_Factory"),				
				Find_Object_Type("P_Ground_Advanced_Vehicle_Factory"),
				Find_Object_Type("Z_Ground_Advanced_Vehicle_Factory"),				
				Find_Object_Type("T_Ground_Advanced_Vehicle_Factory"),								
                }				
    else
        Groundbase_Table = {
                Find_Object_Type("Revolt_Rural_PDF_Barracks"),
                Find_Object_Type("Revolt_Urban_PDF_Barracks"),
                Find_Object_Type("Revolt_Rural_Barracks"),
                Find_Object_Type("Revolt_Urban_Barracks"),
                Find_Object_Type("Revolt_Light_Merc_Barracks"),
                Find_Object_Type("Revolt_Merc_Barracks"),
                Find_Object_Type("Revolt_Elite_Merc_Barracks"),
                Find_Object_Type("Revolt_Precinct_House"),
                Find_Object_Type("Revolt_Scavenger_Outpost"),
                Find_Object_Type("Revolt_Scavenger_Base"),
                Find_Object_Type("Revolt_Underground_Market"),				
                Find_Object_Type("Revolt_Trade_Post"),
                Find_Object_Type("Revolt_Imperial_Deserter_Camp"),
                Find_Object_Type("Revolt_Imperial_Depot"),				
                Find_Object_Type("Revolt_OldRep_Light_Factory"),
                Find_Object_Type("Revolt_Walker_Light_Factory"),				
                Find_Object_Type("Revolt_YT_Light_Factory"),
                Find_Object_Type("Revolt_KAAC_Light_Factory"),
                Find_Object_Type("Revolt_Commercial_Speeder_Factory"),
                Find_Object_Type("Revolt_Commercial_Floater_Factory"),
                Find_Object_Type("Revolt_OldRep_Heavy_Factory"),
                Find_Object_Type("Revolt_YT_Heavy_Factory"),
                Find_Object_Type("Revolt_Illegal_Heavy_Factory"),
                Find_Object_Type("Revolt_OldRep_Advanced_Factory"),			
            }
    end

    return Groundbase_Table
end

function DefineStarBaseTable(faction)
	if faction == Find_Player("Empire") or faction == Find_Player("Eriadu_Authority") or faction == Find_Player("Pentastar") or faction == Find_Player("Zsinj_Empire") or faction == Find_Player("Greater_Maldrood") or faction == Find_Player("Warlords") then
        Starbase_Table = {
                Find_Object_Type("Empire_Star_Base_1"),
                Find_Object_Type("Empire_Star_Base_2"),					
                Find_Object_Type("Empire_Star_Base_3"),
				Find_Object_Type("Empire_Star_Base_4"),									
				Find_Object_Type("Empire_Star_Base_5"),									
            }
    elseif faction == Find_Player("Rebel") or faction == Find_Player("Corellia") then         
        Starbase_Table = {
                Find_Object_Type("NewRepublic_Star_Base_1"),
                Find_Object_Type("NewRepublic_Star_Base_2"),					
                Find_Object_Type("NewRepublic_Star_Base_3"),
				Find_Object_Type("NewRepublic_Star_Base_4"),									
				Find_Object_Type("NewRepublic_Star_Base_5"),
                }
	elseif faction == Find_Player("Hapes_Consortium") then         
        Starbase_Table = {
				Find_Object_Type("Hapan_Star_Base_1"),
                Find_Object_Type("Hapan_Star_Base_2"),					
                Find_Object_Type("Hapan_Star_Base_3"),
				Find_Object_Type("Hapan_Star_Base_4"),									
				Find_Object_Type("Hapan_Star_Base_5"),
                }
    elseif faction == Find_Player("EmpireoftheHand") or faction == Find_Player("Chiss") then   
        Starbase_Table = {
                Find_Object_Type("Brask_Starbase"),
                Find_Object_Type("EotH_Star_Base_2"),					
                Find_Object_Type("EotH_Star_Base_3"),
				Find_Object_Type("Visvia_Starbase"),									
				Find_Object_Type("Oto_Starbase"),
                }
    elseif faction == Find_Player("Corporate_Sector") then               
        Starbase_Table = {
                Find_Object_Type("CSA_Star_Base_1"),
                Find_Object_Type("CSA_Star_Base_2"),					
                Find_Object_Type("CSA_Star_Base_3"),
				Find_Object_Type("CSA_Star_Base_4"),									
				Find_Object_Type("CSA_Star_Base_5"),
                }		
    else
        Starbase_Table = {
                Find_Object_Type("Empire_Star_Base_1"),
                Find_Object_Type("Empire_Star_Base_2"),					
                Find_Object_Type("Empire_Star_Base_3"),
				Find_Object_Type("Empire_Star_Base_4"),									
				Find_Object_Type("Empire_Star_Base_5"),	
            }
    end

    return Starbase_Table
end


function DefineShipyardTable(faction)
	if faction == Find_Player("Empire") then
        Shipyard_Table = {
                Find_Object_Type("Empire_Shipyard_Level_One"),
                Find_Object_Type("Empire_Shipyard_Level_Two"),					
                Find_Object_Type("Empire_Shipyard_Level_Three"),
				Find_Object_Type("Empire_Shipyard_Level_Four"),																		
            }
    elseif faction == Find_Player("Rebel") then         
        Shipyard_Table = {
                Find_Object_Type("NewRepublic_Shipyard_Level_One"),
                Find_Object_Type("NewRepublic_Shipyard_Level_Two"),					
                Find_Object_Type("NewRepublic_Shipyard_Level_Three"),
				Find_Object_Type("NewRepublic_Shipyard_Level_Four"),																		
            }
	elseif faction == Find_Player("Hapes_Consortium") then         
        Shipyard_Table = {
                Find_Object_Type("Hapan_Shipyard_Royal"),
				Find_Object_Type("Hapan_Shipyard_Royal"),
			    Find_Object_Type("Hapan_Shipyard_Royal"),
				Find_Object_Type("Hapan_Shipyard_Royal"),
            }
    elseif faction == Find_Player("EmpireoftheHand") then   
        Shipyard_Table = {
                Find_Object_Type("EOTH_Shipyard_Level_One"),
                Find_Object_Type("EOTH_Shipyard_Level_Two"),					
                Find_Object_Type("EOTH_Shipyard_Level_Three"),
				Find_Object_Type("EOTH_Shipyard_Level_Four"),																		
            }
	elseif faction == Find_Player("Chiss") then   
        Shipyard_Table = {
                Find_Object_Type("Chiss_Shipyard_Level_One"),
                Find_Object_Type("Chiss_Shipyard_Level_Two"),					
                Find_Object_Type("Chiss_Shipyard_Level_Three"),
				Find_Object_Type("Chiss_Shipyard_Level_Four"),																		
            }
	elseif faction == Find_Player("Eriadu_Authority") then         
        Shipyard_Table = {
                Find_Object_Type("Eriadu_Shipyard_Level_One"),
                Find_Object_Type("Eriadu_Shipyard_Level_Two"),					
                Find_Object_Type("Eriadu_Shipyard_Level_Three"),
				Find_Object_Type("Eriadu_Shipyard_Level_Four"),																		
            }
	elseif faction == Find_Player("Pentastar") then         
        Shipyard_Table = {
                Find_Object_Type("Pentastar_Shipyard_Level_One"),
                Find_Object_Type("Pentastar_Shipyard_Level_Two"),					
                Find_Object_Type("Pentastar_Shipyard_Level_Three"),
				Find_Object_Type("Pentastar_Shipyard_Level_Four"),																		
            }
	elseif faction == Find_Player("Zsinj_Empire") then         
        Shipyard_Table = {
                Find_Object_Type("Zsinj_Shipyard_Level_One"),
                Find_Object_Type("Zsinj_Shipyard_Level_Two"),					
                Find_Object_Type("Zsinj_Shipyard_Level_Three"),
				Find_Object_Type("Zsinj_Shipyard_Level_Four"),																		
            }
	elseif faction == Find_Player("Greater_Maldrood") then         
        Shipyard_Table = {
                Find_Object_Type("Greater_Maldrood_Shipyard_Level_One"),
                Find_Object_Type("Greater_Maldrood_Shipyard_Level_Two"),					
                Find_Object_Type("Greater_Maldrood_Shipyard_Level_Three"),
				Find_Object_Type("Greater_Maldrood_Shipyard_Level_Four"),																		
            }
    elseif faction == Find_Player("Corporate_Sector") then               
        Shipyard_Table = {
                Find_Object_Type("CSA_Shipyard_Level_One"),
                Find_Object_Type("CSA_Shipyard_Level_Two"),	
                Find_Object_Type("CSA_Shipyard_Level_Three"),
				Find_Object_Type("CSA_Shipyard_Level_Four"),															
            }
    elseif faction == Find_Player("Warlords") then               
        Shipyard_Table = {
                Find_Object_Type("Pentastar_Shipyard_Level_One"),
                Find_Object_Type("Greater_Maldrood_Shipyard_Level_Two"),					
                Find_Object_Type("Eriadu_Shipyard_Level_Three"),
				Find_Object_Type("Empire_Shipyard_Level_Four"),																
            }			
    else
        Shipyard_Table = {
                Find_Object_Type("Empire_Shipyard_Level_One"),
                Find_Object_Type("Empire_Shipyard_Level_Two"),					
                Find_Object_Type("Empire_Shipyard_Level_Three"),
				Find_Object_Type("Empire_Shipyard_Level_Four"),																		
            }
    end

    return Shipyard_Table
end

-- Always needs 5 levels
function DefineDefenseStarbaseTable(faction)
	if faction == Find_Player("Hapes_Consortium") then
        Defenses_Table = {
                nil,
                Find_Object_Type("Meridian_I"),
                Find_Object_Type("Meridian_II"),					
                Find_Object_Type("Meridian_III"),
				Find_Object_Type("Meridian_IV")								
            }
    elseif faction == Find_Player("EmpireoftheHand") or faction == Find_Player("Chiss") then      
        Defenses_Table = {
                nil,
                Find_Object_Type("Brask"),	
                Find_Object_Type("Secondary_Golan_One"),
                Find_Object_Type("Secondary_Golan_Two"),	
                Find_Object_Type("Visvia")				
            }
	elseif faction == Find_Player("Corporate_Sector") then      
        Defenses_Table = {
                nil,
                nil,
                Find_Object_Type("Secondary_Golan_One"),
                Find_Object_Type("Secondary_Golan_Two"),	
                Find_Object_Type("Valor_Station")				
            }
	else         
        Defenses_Table = {
                nil,
                nil,
				Find_Object_Type("Secondary_Golan_One"),
                Find_Object_Type("Secondary_Golan_Two"),					
                Find_Object_Type("Secondary_Golan_Three"),
                }
    end

    return Defenses_Table
end

function GetGovernmentBuilding(faction)
	if faction == Find_Player("Empire") then
        Government_Building = Find_Object_Type("Empire_MoffPalace")
    elseif faction == Find_Player("Rebel") then         
        Government_Building = Find_Object_Type("NewRep_SenatorsOffice")
	elseif faction == Find_Player("Hapes_Consortium") then         
		Government_Building = Find_Object_Type("House_Royal")
    elseif faction == Find_Player("EmpireoftheHand") then   
		Government_Building = Find_Object_Type("Hand_GovernorOffice")
    elseif faction == Find_Player("Eriadu_Authority") then                  
		Government_Building = Find_Object_Type("Eriadu_MoffPalace")
    elseif faction == Find_Player("Pentastar") then          
		Government_Building = Find_Object_Type("Pentastar_MoffPalace")
	elseif faction == Find_Player("Zsinj_Empire") then          
		Government_Building = Find_Object_Type("Zsinj_MoffPalace")
	elseif faction == Find_Player("Greater_Maldrood") then          
		Government_Building = Find_Object_Type("Maldrood_MoffPalace")
    elseif faction == Find_Player("Corporate_Sector") then               
		Government_Building = Find_Object_Type("CSA_LocalOffice")
	elseif faction == Find_Player("SsiRuuvi_Imperium") then               
		Government_Building = Find_Object_Type("SsiRuuvi_Palace")	
    else
        Government_Building = nil
    end
	
	return Government_Building
end

function GetGTSBuilding(faction)
	if faction == Find_Player("Empire") or faction == Find_Player("EmpireoftheHand") or faction == Find_Player("Zsinj_Empire") or faction == Find_Player("Eriadu_Authority") or faction == Find_Player("Pentastar") or faction == Find_Player("Greater_Maldrood") then
        GTS_Building = Find_Object_Type("Ground_Hypervelocity_Gun")
    elseif faction == Find_Player("Rebel") or faction == Find_Player("Corporate_Sector") or faction == Find_Player("Hapes_Consortium") then         
        GTS_Building = Find_Object_Type("Ground_Ion_Cannon")
    else
        GTS_Building = nil
    end
	
	return GTS_Building
end