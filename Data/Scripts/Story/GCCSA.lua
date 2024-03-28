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
--*   @Date:                2017-12-18T14:01:09+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            GCCSA.lua
--*   @Last modified by:
--*   @Last modified time:  2018-02-05T07:31:34-05:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************

require("PGBase")
require("PGStateMachine")
require("PGStoryMode")
require("PGSpawnUnits")
require("eawx-util/ChangeOwnerUtilities")
StoryUtil = require("eawx-util/StoryUtil")
require("deepcore/crossplot/crossplot")

function Definitions()
    DebugMessage("%s -- In Definitions", tostring(Script))

    StoryModeEvents = {
        Determine_Faction_LUA = Find_Faction,
        Era_Selection = Era_Setup,
        Empire_Dromund = Prophet_spawn,
		Delayed_Initialize = Initialize
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
        p_csa = Find_Player("Corporate_Sector")

        if p_newrep.Is_Human() then
            Story_Event("ENABLE_BRANCH_NEWREP_FLAG")
        elseif p_empire.Is_Human() then
            Story_Event("ENABLE_BRANCH_EMPIRE_FLAG")
        elseif p_eoth.Is_Human() then
            Story_Event("ENABLE_BRANCH_EOTH_FLAG")
        elseif p_eriadu.Is_Human() then
            Story_Event("ENABLE_BRANCH_ERIADU_FLAG")
        elseif p_pentastar.Is_Human() then
            Story_Event("ENABLE_BRANCH_PENTASTAR_FLAG")
        elseif p_zsinj.Is_Human() then
            Story_Event("ENABLE_BRANCH_ZSINJ_FLAG")
        elseif p_maldrood.Is_Human() then
            Story_Event("ENABLE_BRANCH_TERADOC_FLAG")
        elseif p_csa.Is_Human() then
            Story_Event("ENABLE_BRANCH_CSA_FLAG")
        end
    end
end

function Initialize(message)
    if message == OnEnter then
		crossplot:galactic()
		crossplot:publish("NR_ADMIRAL_DECREMENT", 2, 1)
	else
		crossplot:update()
    end
end

function Era_Setup(message)
    if message == OnEnter then
		credits = p_csa.Get_Credits()
        techLevel = GlobalValue.Get("CURRENT_ERA")
				
		if p_empire.Is_Human() then
			if techLevel == 2 then
				techLevel = 3
			end
			if techLevel > 4 then
				techLevel = 4
			end
		end
		
		if p_zsinj.Is_Human() then
			if techLevel > 3 then
				techLevel = 3
			end
		end
		
		--universal_forces(techLevel)
        if techLevel == 1 then
            --Zsinj_South_forces()
            --era1_forces()
            Story_Event("START_ERA_MAKATI")
		elseif techLevel == 2 then
            --Zsinj_South_forces()
            --Zsinj_North_forces(techLevel)
            --CSA_extra_forces()
            --orron_forces()
            Story_Event("START_ERA_HFZ_LITE")
        elseif techLevel == 3 then
			--Post_Zsinj_forces()
			--Zsinj_North_forces(techLevel)
            --orron_forces()
			Story_Event("START_ERA_POST_ZSINJ")
        elseif techLevel == 4 then
            --era3_forces()
            --CSA_extra_forces()
            --mytus_forces()
			Story_Event("START_ERA_DE_LITE")
			--StoryUtil.SetTechLevel(Find_Player("Empire"), 2)
			--StoryUtil.SetTechLevel(Find_Player("Rebel"), 1)
			--StoryUtil.SetTechLevel(Find_Player("Corporate_Sector"), 2)
        else
            --CSA_extra_forces()
            --orron_forces()
            --mytus_forces()
            --era4_forces()
			Story_Event("START_ERA_NR_BRAWL")
			--if techLevel == 5 then
			--	StoryUtil.SetTechLevel(Find_Player("Rebel"), 1)
			--	StoryUtil.SetTechLevel(Find_Player("Corporate_Sector"), 2)
			--else
			--	StoryUtil.SetTechLevel(Find_Player("Rebel"), 2)
			--	StoryUtil.SetTechLevel(Find_Player("Corporate_Sector"), 3)
			--end
        end

        placeholder_table = Find_All_Objects_Of_Type("Placement_Dummy")
        for i, unit in pairs(placeholder_table) do
            unit.Despawn()
        end
		StoryUtil.AIActivation()
    end
end

-- CSA and NR base, Lianna
function universal_forces(era)
    p_newrep = Find_Player("Rebel")
    p_warlords = Find_Player("Warlords")
    p_csa = Find_Player("Corporate_Sector")

    start_planet = FindPlanet("Etti") -- lack of Sloane and Brollyx is intentional. Other factions are pretty short on heroes and Sloanes's probably in the exclave by Naboo anyway
    unit_list = {
        "Grumby_Notropis",
        "Weplinn_ISD",
		"Marauder_Cruiser",
        "Marauder_Cruiser",
        "Karrek_Flim_Team",
		"Riga_Team",
        "Odumin_Team",
        "Fiolla_Team",
        "Fasser_Team",
        "Nieler_Team",
        "Citadel_Cruiser_Squadron",
        "Citadel_Cruiser_Squadron",
        "C_Ground_Barracks",
		"CSA_Shipyard_Level_Three",
        "C_Ground_Light_Vehicle_Factory",
        "Espo_Walker_Squad",
        "SX20_Company",
        "Espo_Squad",
        "Espo_Squad"
    }
    SpawnList(unit_list, start_planet, p_csa, true, false)
    units = Spawn_Unit(Find_Object_Type("NewRepublic_Star_Base_3"), start_planet, p_csa)

    start_planet = FindPlanet("Ulicia")
    start_planet.Change_Owner(p_csa)
    unit_list = {
        "Gozanti_Cruiser_Squadron",
        "Gozanti_Cruiser_Squadron",
        "Gozanti_Cruiser_Squadron",
        "CSA_LocalOffice",
        "C_Ground_Light_Vehicle_Factory",
        "C_Ground_Heavy_Vehicle_Factory",
        "Strikebreaker_Group",
        "CSA_Shipyard_Level_Two",
        "JX40_Group",
        "X10_Group",
        "Espo_Squad",
        "Espo_Squad"
    }
    SpawnList(unit_list, start_planet, p_csa, true, false)
    units = Spawn_Unit(Find_Object_Type("NewRepublic_Star_Base_1"), start_planet, p_csa)

    start_planet = FindPlanet("Atchorb")
    start_planet.Change_Owner(p_csa)
    unit_list = {
        "Krin_Invincible",
        "Recusant",
        "Marauder_Cruiser",
        "Marauder_Cruiser",
        "Citadel_Cruiser_Squadron",
        "Citadel_Cruiser_Squadron",
        "CSA_LocalOffice",
        "C_Ground_Barracks",
		"CSA_Shipyard_Level_One",
        "Aratech_Battle_Platform_Company",
        "GX12_Company",
        "GX12_Company",
        "Espo_Squad",
        "Espo_Squad"
    }
    SpawnList(unit_list, start_planet, p_csa, true, false)
    units = Spawn_Unit(Find_Object_Type("NewRepublic_Star_Base_1"), start_planet, p_csa)

    start_planet = FindPlanet("Bonadan")
    start_planet.Change_Owner(p_csa)
    unit_list = {
        "Generic_Victory_Destroyer",
		"Generic_Victory_Destroyer",
		"Generic_Gladiator",
		"Neutron_Star",
        "Marauder_Cruiser",
        "Marauder_Cruiser",
        "Marauder_Cruiser",
        "Marauder_Cruiser",
        "CSA_Shipyard_Level_Two",
        "CSA_LocalOffice",
        "C_Ground_Barracks",
        "Tax_Agency",
        "Espo_Walker_Squad",
        "Espo_Squad",
        "Espo_Squad",
        "Espo_Squad"
    }
    SpawnList(unit_list, start_planet, p_csa, true, false)
    units = Spawn_Unit(Find_Object_Type("NewRepublic_Star_Base_2"), start_planet, p_csa)

    start_planet = FindPlanet("Mon_Calamari")
    unit_list = {"MC40a",
		"MC40a",
		"MC40a",
		"Airen_Cracken_Team",
		"R_Ground_Light_Vehicle_Factory",
		"NewRepublic_Shipyard_Level_Four"
	}
    SpawnList(unit_list, start_planet, p_newrep, true, false)
    units = Spawn_Unit(Find_Object_Type("NewRepublic_Star_Base_5"), start_planet, p_newrep)

    start_planet = FindPlanet("Hast")
    start_planet.Change_Owner(p_newrep)
    unit_list = {
        "Calamari_Cruiser",
        "Nebulon_B_Frigate",
        "Corellian_Corvette",
        "Corellian_Corvette",
        "Corellian_Corvette",
        "NewRepublic_Shipyard_Level_Three",
        "NewRep_SenatorsOffice",
        "R_Ground_Heavy_Vehicle_Factory"
    }
    SpawnList(unit_list, start_planet, p_newrep, true, false)
    units = Spawn_Unit(Find_Object_Type("NewRepublic_Star_Base_4"), start_planet, p_newrep)

    start_planet = FindPlanet("New_Alderaan")
    start_planet.Change_Owner(p_newrep)
    unit_list = {
        "NewRep_SenatorsOffice",
        "R_Ground_Barracks",
		"NewRepublic_Shipyard_Level_One",
        "R_Ground_Light_Vehicle_Factory"
    }
    SpawnList(unit_list, start_planet, p_newrep, true, false)
    units = Spawn_Unit(Find_Object_Type("NewRepublic_Star_Base_2"), start_planet, p_newrep)

    if era > 1 then --keep the NR passive for a while in era 1
        start_planet = FindPlanet("Mon_Calamari")
        unit_list = {
            "Rebel_T4B_Company",
            "Rebel_T4B_Company",
            "Rebel_T3B_Company",
            "Rebel_Infantry_Squad",
            "Rebel_Infantry_Squad",
            "Rebel_Infantry_Squad"
        }
        SpawnList(unit_list, start_planet, p_newrep, true, false)

        start_planet = FindPlanet("Hast")
        unit_list = {
            "Rebel_T3B_Company",
            "Rebel_T3B_Company",
            "Rebel_Freerunner_Company",
            "Rebel_Freerunner_Company",
            "Rebel_Freerunner_Company",
            "Rebel_Infantry_Squad",
            "Rebel_Infantry_Squad",
            "Rebel_Infantry_Squad"
        }
        SpawnList(unit_list, start_planet, p_newrep, true, false)

        start_planet = FindPlanet("New_Alderaan")
        unit_list = {
            "Rebel_AAC_2_Company",
            "Rebel_AAC_2_Company",
            "Rebel_AA5_Company",
            "Rebel_AA5_Company",
            "Rebel_T2B_Company",
            "Rebel_Infantry_Squad",
            "Rebel_Infantry_Squad",
            "Rebel_Infantry_Squad",
            "Rebel_Infantry_Squad"
        }
        SpawnList(unit_list, start_planet, p_newrep, true, false)
    end

    start_planet = FindPlanet("Mon_Calamari")
    if era < 4 then
        unit_list = {"Home_One"}
    else
        unit_list = {"Galactic_Voyager"}
    end
    SpawnList(unit_list, start_planet, p_newrep, true, false)

    start_planet = FindPlanet("Lianna")
    start_planet.Change_Owner(p_warlords)
    unit_list = {
        "IPV1_System_Patrol_Craft",
        "IPV1_System_Patrol_Craft",
        "IPV1_System_Patrol_Craft",
        "IPV1_System_Patrol_Craft",
        "Marauder_Cruiser",
        "Marauder_Cruiser",
        "Marauder_Cruiser",
        "Vindicator_Cruiser",
        "Vindicator_Cruiser",
        "Vindicator_Cruiser",
        "Avenger_Squadron_Buildable",
        "TIE_Defender_Squadron_Buildable",
        "Empire_MoffPalace",
        "Sienar_HQ",
        "Imperial_Century_Tank_Company",
        "Imperial_TIE_Mauler_Company",
        "Imperial_TIE_Mauler_Company",
        "Imperial_TIE_Mauler_Company",
        "Imperial_Lancet_Group",
        "Imperial_Lancet_Group",
		"Security_Trooper_Team",
		"Security_Trooper_Team",
		"Security_Trooper_Team",
		"Security_Trooper_Team"
    }
    SpawnList(unit_list, start_planet, p_warlords, true, false)
end

-- era 1 Empire, Screed, Prophets
function era1_forces(message)
    p_empire = Find_Player("Empire")
    p_zsinj = Find_Player("Zsinj_Empire")
    p_warlords = Find_Player("Warlords")

    empire_base()

    start_planet = FindPlanet("Saffalore")
    unit_list = {"Makati_Steadfast"}
    SpawnList(unit_list, start_planet, p_empire, true, false)

    start_planet = FindPlanet("Oslumpex")
    start_planet.Change_Owner(p_empire)
    unit_list = {
        "Generic_Acclamator_Assault_Ship_II",
        "Generic_Acclamator_Assault_Ship_II",
        "Empire_MoffPalace",
        "E_Ground_Light_Vehicle_Factory",
        "E_Ground_Heavy_Vehicle_Factory",
        "Imperial_AT_PT_Company",
        "Empire_Shipyard_Level_Two",
        "Imperial_AT_PT_Company",
        "Army_Trooper_Squad",
        "Army_Trooper_Squad"
    }
    SpawnList(unit_list, start_planet, p_empire, true, false)
    units = Spawn_Unit(Find_Object_Type("Empire_Star_Base_1"), start_planet, p_empire)

    start_planet = FindPlanet("Maryo")
    start_planet.Change_Owner(p_empire)
    unit_list = {
        "Carrack_Cruiser",
        "Empire_MoffPalace",
        "E_Ground_Barracks",
		"Empire_Shipyard_Level_One",
        "Army_Trooper_Squad",
        "Imperial_Stormtrooper_Squad",
        "Army_Trooper_Squad",
        "Imperial_Stormtrooper_Squad",
        "Army_Trooper_Squad"
    }
    SpawnList(unit_list, start_planet, p_empire, true, false)
    units = Spawn_Unit(Find_Object_Type("Empire_Star_Base_1"), start_planet, p_empire)

    start_planet = FindPlanet("Desevro")
    unit_list = {"Demolisher"}
    SpawnList(unit_list, start_planet, p_zsinj, true, false)

    start_planet = FindPlanet("Dromund")
    start_planet.Change_Owner(p_warlords)
    unit_list = {
        "Raider_Corvette",
        "Raider_Corvette",
        "Generic_Star_Destroyer",
        "Decimator_Squadron",
        "Generic_Imperial_II_Frigate",
        "Generic_Imperial_II_Frigate",
        "Empire_MoffPalace",
        "Imperial_AT_TE_Walker_Company",
        "Jedgar_Team",
        "Dark_Jedi_Squad",
        "Dark_Jedi_Squad",
        "Dark_Jedi_Squad",
        "Dark_Jedi_Squad",
        "Dark_Jedi_Squad"
    }
    SpawnList(unit_list, start_planet, p_warlords, true, false)
end

function empire_base(message)
    p_empire = Find_Player("Empire")

    start_planet = FindPlanet("Emmer")
    start_planet.Change_Owner(p_empire)
    unit_list = {
        "Generic_Star_Destroyer",
        "Strike_Cruiser",
        "Strike_Cruiser",
        "Empire_MoffPalace",
        "Remnant_Capital",
        "E_Ground_Light_Vehicle_Factory",
		"Empire_Shipyard_Level_One",
        "Imperial_Century_Tank_Company",
        "Imperial_SPMAG_Company",
        "Imperial_AT_AA_Company"
    }
    SpawnList(unit_list, start_planet, p_empire, true, false)
    units = Spawn_Unit(Find_Object_Type("Empire_Star_Base_2"), start_planet, p_empire)

    start_planet = FindPlanet("Orron")
    start_planet.Change_Owner(p_empire)
    unit_list = {
        "Dreadnaught_Empire",
        "Carrack_Cruiser",
        "Empire_MoffPalace",
        "E_Ground_Barracks",
		"Empire_Shipyard_Level_One",
        "Army_Trooper_Squad",
        "Army_Trooper_Squad",
        "Imperial_74Z_Bike_Company",
        "Imperial_74Z_Bike_Company"
    }
    SpawnList(unit_list, start_planet, p_empire, true, false)
    units = Spawn_Unit(Find_Object_Type("Empire_Star_Base_2"), start_planet, p_empire)

    start_planet = FindPlanet("Saffalore")
    start_planet.Change_Owner(p_empire)
    unit_list = {
        "Generic_Star_Destroyer_Two",
        "Generic_Victory_Destroyer_Two",
        "Strike_Cruiser",
        "Strike_Cruiser",
        "Escort_Carrier",
        "Lancer_Frigate",
        "Empire_MoffPalace",
        "E_Ground_Barracks",
        "E_Ground_Light_Vehicle_Factory",
		"Empire_Shipyard_Level_Two",
        "Imperial_Chariot_LAV_Company",
        "Imperial_2M_Company",
        "Imperial_2M_Company",
        "Imperial_Stormtrooper_Squad",
        "Imperial_Stormtrooper_Squad"
    }
    SpawnList(unit_list, start_planet, p_empire, true, false)
    units = Spawn_Unit(Find_Object_Type("Empire_Star_Base_2"), start_planet, p_empire)

    start_planet = FindPlanet("Kalla")
    start_planet.Change_Owner(p_empire)
    unit_list = {
        "Generic_Star_Destroyer",
        "Dreadnaught_Empire",
        "Dreadnaught_Empire",
        "Escort_Carrier",
        "Empire_MoffPalace",
        "E_Ground_Barracks",
        "E_Ground_Light_Vehicle_Factory",
		"Empire_Shipyard_Level_One",
        "Imperial_AT_ST_Company",
        "Imperial_TIE_Mauler_Company",
        "Imperial_Stormtrooper_Squad",
        "Imperial_Stormtrooper_Squad"
    }
    SpawnList(unit_list, start_planet, p_empire, true, false)
    units = Spawn_Unit(Find_Object_Type("Empire_Star_Base_1"), start_planet, p_empire)

    start_planet = FindPlanet("Raxus")
    start_planet.Change_Owner(p_empire)
    unit_list = {
        "Generic_Star_Destroyer",
        "Dreadnaught_Empire",
        "Escort_Carrier",
        "Lancer_Frigate",
        "Empire_MoffPalace",
        "Empire_Shipyard_Level_Two",
        "E_Ground_Light_Vehicle_Factory",
        "E_Ground_Heavy_Vehicle_Factory",
        "Imperial_Century_Tank_Company",
        "Imperial_2M_Company",
        "Imperial_Stormtrooper_Squad"
    }
    SpawnList(unit_list, start_planet, p_empire, true, false)
    units = Spawn_Unit(Find_Object_Type("Empire_Star_Base_2"), start_planet, p_empire)
end

-- era 1 and 2 Zsinj basic roster
function Zsinj_South_forces(message)
    p_zsinj = Find_Player("Zsinj_Empire")

    start_planet = FindPlanet("Desevro")
    start_planet.Change_Owner(p_zsinj)
    unit_list = {
        "Generic_Star_Destroyer",
        "Generic_Victory_Destroyer",
        "Generic_Victory_Destroyer",
        "Generic_Gladiator",
        "Generic_Gladiator",
        "Generic_Gladiator",
        "CR90_Zsinj",
        "CR90_Zsinj",
        "Teubbo_Team",
        "Zsinj_MoffPalace",
        "Rancor_Base",
        "Z_Ground_Heavy_Vehicle_Factory",
        "Z_Ground_Light_Vehicle_Factory",
        "Z_Ground_Barracks",
        "Imperial_A5_Juggernaut_Company",
        "Imperial_Century_Tank_Company",
        "Imperial_TIE_Mauler_Company",
        "Imperial_TIE_Mauler_Company",
        "Zsinj_Raptor_Squad",
        "Zsinj_Raptor_Squad"
    }
    SpawnList(unit_list, start_planet, p_zsinj, true, false)
    units = Spawn_Unit(Find_Object_Type("Empire_Star_Base_2"), start_planet, p_zsinj)

    start_planet = FindPlanet("Ession")
    start_planet.Change_Owner(p_zsinj)
    unit_list = {
        "Night_Caller",
        "CR90_Zsinj",
        "Generic_Star_Destroyer_Two",
        "Zsinj_MoffPalace",
        "Z_Ground_Light_Vehicle_Factory",
        "Z_Ground_Light_Vehicle_Factory",
		"Zsinj_Shipyard_Level_Two",
        "Imperial_IDT_Group",
        "Imperial_IDT_Group",
        "Hailfire_Company",
        "Zsinj_Raptor_Squad",
        "Zsinj_Raptor_Squad"
    }
    SpawnList(unit_list, start_planet, p_zsinj, true, false)
    units = Spawn_Unit(Find_Object_Type("Empire_Star_Base_1"), start_planet, p_zsinj)

    start_planet = FindPlanet("Felucia")
    start_planet.Change_Owner(p_zsinj)
    unit_list = {
        "Neutron_Star",
        "Nebulon_B_Zsinj",
        "Zsinj_MoffPalace",
        "Z_Ground_Barracks",
        "Z_Ground_Barracks",
		"Zsinj_Shipyard_Level_One",
        "Lanu_Team",
        "Zsinj_Raptor_Squad",
        "Zsinj_Raptor_Squad",
        "Zsinj_Raptor_Squad",
        "Zsinj_74Z_Bike_Company",
        "Zsinj_74Z_Bike_Company"
    }
    SpawnList(unit_list, start_planet, p_zsinj, true, false)
    units = Spawn_Unit(Find_Object_Type("Empire_Star_Base_1"), start_planet, p_zsinj)

    start_planet = FindPlanet("Galidraan")
    start_planet.Change_Owner(p_zsinj)
    unit_list = {
        "Dreadnaught_Empire",
        "Dreadnaught_Empire",
        "Nebulon_B_Zsinj",
        "Nebulon_B_Zsinj",
        "Nebulon_B_Zsinj",
        "Zsinj_MoffPalace",
        "Z_Ground_Light_Vehicle_Factory",
		"Zsinj_Shipyard_Level_Two",
        "Z_Ground_Barracks",
        "Imperial_2M_Company",
        "Zsinj_Raptor_Squad"
    }
    SpawnList(unit_list, start_planet, p_zsinj, true, false)
    units = Spawn_Unit(Find_Object_Type("Empire_Star_Base_1"), start_planet, p_zsinj)

    start_planet = FindPlanet("Raxus_Second")
    start_planet.Change_Owner(p_zsinj)
    unit_list = {
        "Banjeer",
        "Neutron_Star",
        "Neutron_Star",
        "Neutron_Star",
        "Neutron_Star",
        "Zsinj_MoffPalace",
        "Z_Ground_Light_Vehicle_Factory",
        "Z_Ground_Barracks",
		"Zsinj_Shipyard_Level_One",
        "Imperial_AT_ST_Company",
        "Zsinj_Raptor_Squad",
        "Zsinj_Raptor_Squad"
    }
    SpawnList(unit_list, start_planet, p_zsinj, true, false)
    units = Spawn_Unit(Find_Object_Type("Empire_Star_Base_2"), start_planet, p_zsinj)
end

-- era 2 Zsinj extra roster and Solo Fleet
function Zsinj_North_forces(era)
    p_zsinj = Find_Player("Zsinj_Empire")
    p_newrep = Find_Player("Rebel")

    start_planet = FindPlanet("Raxus")
    start_planet.Change_Owner(p_zsinj)
    unit_list = {
        "Generic_Star_Destroyer",
        "Dreadnaught_Empire",
        "Nebulon_B_Zsinj",
        "Nebulon_B_Zsinj",
        "Nebulon_B_Zsinj",
        "CR90_Zsinj",
        "CR90_Zsinj",
        "Zsinj_MoffPalace",
        "Z_Ground_Heavy_Vehicle_Factory",
        "Z_Ground_Light_Vehicle_Factory",
		"Zsinj_Shipyard_Level_Two",
        "Imperial_AT_TE_Walker_Company",
        "Hailfire_Company",
        "Zsinj_Raptor_Squad",
        "Zsinj_Raptor_Squad"
    }
    SpawnList(unit_list, start_planet, p_zsinj, true, false)
    units = Spawn_Unit(Find_Object_Type("Empire_Star_Base_1"), start_planet, p_zsinj)

    start_planet = FindPlanet("Emmer")
    start_planet.Change_Owner(p_zsinj)
    unit_list = {
        "Generic_Star_Destroyer_Two",
        "Generic_Victory_Destroyer_Two",
        "Generic_Victory_Destroyer",
        "Zsinj_MoffPalace",
        "Z_Ground_Light_Vehicle_Factory",
        "Z_Ground_Light_Vehicle_Factory",
		"Zsinj_Shipyard_Level_One",
        "Imperial_SPMAG_Company",
        "Imperial_Century_Tank_Company",
        "Zsinj_Raptor_Squad",
        "Zsinj_74Z_Bike_Company",
        "Zsinj_74Z_Bike_Company"
    }
    SpawnList(unit_list, start_planet, p_zsinj, true, false)
    units = Spawn_Unit(Find_Object_Type("Empire_Star_Base_1"), start_planet, p_zsinj)
	
	if era < 3 then
	unit_list = {
        "Implacable_Star_Destroyer"
    }
	else
	unit_list = {
        "Nabyl_Hawkbat"
    }
	end
	SpawnList(unit_list, start_planet, p_zsinj, true, false)

    start_planet = FindPlanet("Kalla")
    start_planet.Change_Owner(p_zsinj)
    unit_list = {
        "Generic_Victory_Destroyer",
        "Generic_Victory_Destroyer",
        "Dreadnaught_Empire",
        "Dreadnaught_Empire",
        "CR90_Zsinj",
        "CR90_Zsinj",
        "CR90_Zsinj",
        "Zsinj_MoffPalace",
        "Z_Ground_Light_Vehicle_Factory",
        "Z_Ground_Barracks",
		"Zsinj_Shipyard_Level_One",
        "Imperial_AT_ST_Company",
        "Zsinj_Raptor_Squad",
        "Zsinj_Raptor_Squad",
        "Zsinj_Raptor_Squad"
    }
    SpawnList(unit_list, start_planet, p_zsinj, true, false)
    units = Spawn_Unit(Find_Object_Type("Empire_Star_Base_1"), start_planet, p_zsinj)

    start_planet = FindPlanet("Saffalore")
    start_planet.Change_Owner(p_zsinj)
    unit_list = {
        "Generic_Star_Destroyer",
        "Generic_Victory_Destroyer_Two",
        "Generic_Gladiator",
        "Generic_Gladiator",
        "Zsinj_MoffPalace",
        "Z_Ground_Heavy_Vehicle_Factory",
        "Z_Ground_Light_Vehicle_Factory",
		"Zsinj_Shipyard_Level_Two",
        "Imperial_2M_Company",
        "Imperial_IDT_Group",
        "Imperial_TIE_Mauler_Company",
        "Zsinj_Raptor_Squad",
        "Zsinj_Raptor_Squad",
        "Zsinj_74Z_Bike_Company"
    }
    SpawnList(unit_list, start_planet, p_zsinj, true, false)
    units = Spawn_Unit(Find_Object_Type("Empire_Star_Base_2"), start_planet, p_zsinj)

    --Failing miserably to Hunt Zsinj, but hey, a reference!
    start_planet = FindPlanet("Nespis")
    unit_list = {
        "Solo_Remonda",
        "Rogue_Squadron_Space",
        "Wraith_Squadron_Space",
        "Generic_Star_Destroyer_Two",
        "ISD_1_NR",
        "ISD_1_NR",
        "Calamari_Cruiser",
        "Calamari_Cruiser",
        "Generic_Interdictor_Cruiser",
        "Quasar",
        "Nebulon_B_Frigate",
        "Nebulon_B_Frigate",
        "Nebulon_B_Frigate",
        "Marauder_Cruiser",
        "Corellian_Corvette"
    }
    SpawnList(unit_list, start_planet, p_newrep, true, false)
end

-- Dark Empire, Era 3 NR specific
function era3_forces(message)
    p_empire = Find_Player("Empire")
    p_newrep = Find_Player("Rebel")

    empire_base()

    start_planet = FindPlanet("Orron")
    unit_list = {
		"Klev_Capital_Devastator",
        "Banjeer_Neutron",
        "Generic_Allegiance",
        "Generic_Victory_Destroyer_Two",
        "MTC_Support",
        "MTC_Support",
        "MTC_Support",
        "Lancer_Frigate",
        "Imperial_AT_AT_Company"
    }
    SpawnList(unit_list, start_planet, p_empire, true, false)

    start_planet = FindPlanet("Ession")
    start_planet.Change_Owner(p_empire)
    unit_list = {
        "Generic_Star_Destroyer",
        "Strike_Cruiser",
        "Strike_Cruiser",
        "MTC_Support",
        "MTC_Support",
        "Lancer_Frigate",
        "Lancer_Frigate",
        "Empire_MoffPalace",
        "E_Ground_Barracks",
        "E_Ground_Light_Vehicle_Factory",
		"Empire_Shipyard_Level_Two",
        "Imperial_XR85_Company",
        "Imperial_Century_Tank_Company",
        "Imperial_AT_PT_Company",
        "Imperial_Stormtrooper_Squad",
        "Imperial_Stormtrooper_Squad",
        "Imperial_Stormtrooper_Squad"
    }
    SpawnList(unit_list, start_planet, p_empire, true, false)
    units = Spawn_Unit(Find_Object_Type("Empire_Star_Base_2"), start_planet, p_empire)

    start_planet = FindPlanet("Desevro")
    start_planet.Change_Owner(p_empire)
    unit_list = {
        "Generic_Star_Destroyer",
        "Generic_Victory_Destroyer_Two",
        "MTC_Support",
        "MTC_Support",
        "Empire_MoffPalace",
        "E_Ground_Light_Vehicle_Factory",
        "E_Ground_Light_Vehicle_Factory",
		"Empire_Shipyard_Level_Two",
        "Imperial_XR85_Company",
        "Imperial_XR85_Company",
        "Army_Trooper_Squad",
        "Army_Trooper_Squad"
    }
    SpawnList(unit_list, start_planet, p_empire, true, false)
    units = Spawn_Unit(Find_Object_Type("Empire_Star_Base_1"), start_planet, p_empire)

    start_planet = FindPlanet("Felucia")
    start_planet.Change_Owner(p_empire)
    unit_list = {
        "Dreadnaught_Empire",
        "Dreadnaught_Empire",
        "Dreadnaught_Empire",
        "Escort_Carrier",
        "Escort_Carrier",
        "Empire_MoffPalace",
        "E_Ground_Barracks",
        "E_Ground_Barracks",
		"Empire_Shipyard_Level_One",
        "Imperial_TIE_Mauler_Company",
        "Imperial_Stormtrooper_Squad",
        "Imperial_Stormtrooper_Squad",
        "Imperial_74Z_Bike_Company",
        "Imperial_74Z_Bike_Company"
    }
    SpawnList(unit_list, start_planet, p_empire, true, false)
    units = Spawn_Unit(Find_Object_Type("Empire_Star_Base_1"), start_planet, p_empire)

    start_planet = FindPlanet("Galidraan")
    start_planet.Change_Owner(p_empire)
    unit_list = {
        "Dreadnaught_Empire",
        "Carrack_Cruiser",
        "Empire_MoffPalace",
        "E_Ground_Barracks",
        "E_Ground_Light_Vehicle_Factory",
		"Empire_Shipyard_Level_Two",
        "Army_Trooper_Squad",
        "Army_Trooper_Squad",
        "Army_Trooper_Squad"
    }
    SpawnList(unit_list, start_planet, p_empire, true, false)
    units = Spawn_Unit(Find_Object_Type("Empire_Star_Base_1"), start_planet, p_empire)

    start_planet = FindPlanet("Raxus_Second")
    start_planet.Change_Owner(p_empire)
    unit_list = {
        "Generic_Victory_Destroyer",
        "Vindicator_Cruiser",
        "Vindicator_Cruiser",
        "MTC_Support",
        "MTC_Support",
        "Lancer_Frigate",
        "Lancer_Frigate",
        "Lancer_Frigate",
        "Empire_MoffPalace",
        "E_Ground_Barracks",
        "E_Ground_Light_Vehicle_Factory",
		"Empire_Shipyard_Level_One",
        "Imperial_Stormtrooper_Squad",
        "Army_Trooper_Squad"
    }
    SpawnList(unit_list, start_planet, p_empire, true, false)
    units = Spawn_Unit(Find_Object_Type("Empire_Star_Base_1"), start_planet, p_empire)

    start_planet = FindPlanet("Dromund") --Pilgrimage to a Sith historic site or something. This planet is really just here for Jedgar and Kadann
    start_planet.Change_Owner(p_empire)
    unit_list = {"Sedriss_Team"}
    SpawnList(unit_list, start_planet, p_empire, true, false)

    start_planet = FindPlanet("Mon_Calamari")
    unit_list = {"MC80B", "Ragab_Emancipator", "MC90"} --Mon Remonda, Emancipator, and some random extra Mon Cal strength
    SpawnList(unit_list, start_planet, p_newrep, true, false)

    start_planet = FindPlanet("Nespis")
    start_planet.Change_Owner(p_newrep)
    unit_list = {
        "Lando_Calrissian_Team", --Arguably Liberator, but all the hero slots are used up and it's technically already gone, even if you can still buy it
        "Wedge_Rogue_Squadron_Space",
        "Princess_Leia_Team",
        "Mon_Mothma_Team",
        "Luke_Skywalker_Jedi_Teams",
        "Han_Solo_Team",
        "NewRep_SenatorsOffice",
        "Rebel_Vwing_Group",
        "Rebel_Vwing_Group",
        "Rebel_Vwing_Group",
        "Rebel_Infantry_Squad",
        "Rebel_Infantry_Squad",
        "Rebel_Infantry_Squad",
        "Rebel_Infantry_Squad"
    }
    SpawnList(unit_list, start_planet, p_newrep, true, false)
end

-- CSA era 2 and 3
function CSA_extra_forces(message)
    p_csa = Find_Player("Corporate_Sector")

    start_planet = FindPlanet("Oslumpex")
    start_planet.Change_Owner(p_csa)
    unit_list = {
        "Bulwark_I",
        "Dauntless",
        "Gozanti_Cruiser_Squadron",
        "Gozanti_Cruiser_Squadron",
        "CSA_LocalOffice",
        "C_Ground_Light_Vehicle_Factory",
        "C_Ground_Heavy_Vehicle_Factory",
		"CSA_Shipyard_Level_Two",
        "Strikebreaker_Group",
        "JX40_Group",
        "GX12_Company",
        "Espo_Squad",
        "Espo_Squad"
    }
    SpawnList(unit_list, start_planet, p_csa, true, false)
    units = Spawn_Unit(Find_Object_Type("NewRepublic_Star_Base_2"), start_planet, p_csa)

    start_planet = FindPlanet("Maryo")
    start_planet.Change_Owner(p_csa)
    unit_list = {
        "Generic_Victory_Destroyer",
        "Generic_Gladiator",
        "Generic_Gladiator",
        "CSA_LocalOffice",
        "C_Ground_Barracks",
		"CSA_Shipyard_Level_One",
        "X10_Group",
        "X10_Group",
        "SX20_Company",
        "Espo_Squad",
        "Espo_Squad"
    }
    SpawnList(unit_list, start_planet, p_csa, true, false)
    units = Spawn_Unit(Find_Object_Type("NewRepublic_Star_Base_1"), start_planet, p_csa)
end

-- CSA era 2 and 4
function orron_forces(message)
    p_csa = Find_Player("Corporate_Sector")

    start_planet = FindPlanet("Orron")
    start_planet.Change_Owner(p_csa)
    unit_list = {
        "Lucrehulk_CSA",
        "CSA_LocalOffice",
        "C_Ground_Barracks",
        "C_Ground_Barracks",
		"CSA_Shipyard_Level_One",
        "Espo_Walker_Squad",
        "Espo_Walker_Squad",
        "X10_Group",
        "GX12_Company",
        "Espo_Squad",
        "Espo_Squad",
        "Espo_Squad"
    }
    SpawnList(unit_list, start_planet, p_csa, true, false)
    units = Spawn_Unit(Find_Object_Type("NewRepublic_Star_Base_2"), start_planet, p_csa)
end

-- CSA era 3 and 4
function mytus_forces(message)
    p_csa = Find_Player("Corporate_Sector")

    start_planet = FindPlanet("Mytus")
    start_planet.Change_Owner(p_csa)
    unit_list = {"Nebulon_B_Zsinj", "Nebulon_B_Zsinj", "CSA_LocalOffice"}
    SpawnList(unit_list, start_planet, p_csa, true, false)
end

--Extra NR and CSA
function era4_forces(message)
    p_csa = Find_Player("Corporate_Sector")
    p_newrep = Find_Player("Rebel")

    start_planet = FindPlanet("Kalla")
    start_planet.Change_Owner(p_csa)
    unit_list = {
        "Bulwark_I",
        "Neutron_Star",
        "Neutron_Star",
        "CSA_LocalOffice",
        "C_Ground_Barracks",
        "C_Ground_Light_Vehicle_Factory",
		"CSA_Shipyard_Level_One",
        "Persuader_Company",
        "Persuader_Company",
        "Hailfire_Company",
        "CSA_B1_Droid_Squad",
        "CSA_B1_Droid_Squad"
    }
    SpawnList(unit_list, start_planet, p_csa, true, false)
    units = Spawn_Unit(Find_Object_Type("NewRepublic_Star_Base_2"), start_planet, p_csa)

    start_planet = FindPlanet("Saffalore")
    start_planet.Change_Owner(p_csa)
    unit_list = {
        "Dreadnaught_Empire",
        "CSA_LocalOffice",
        "C_Ground_Barracks",
        "C_Ground_Light_Vehicle_Factory",
		"CSA_Shipyard_Level_Two",
        "GX12_Company",
        "GX12_Company",
        "X10_Group",
        "SX20_Company",
        "Espo_Squad",
        "Espo_Squad"
    }
    SpawnList(unit_list, start_planet, p_csa, true, false)
    units = Spawn_Unit(Find_Object_Type("NewRepublic_Star_Base_1"), start_planet, p_csa)

    start_planet = FindPlanet("Ession")
    start_planet.Change_Owner(p_csa)
    unit_list = {
        "Bulwark_III",
		"Generic_Victory_Destroyer_Two",
        "MTC_Support",
        "MTC_Support",
        "MTC_Support",
        "MTC_Support",
		"Marauder_Cruiser",
		"Marauder_Cruiser",
		"Marauder_Cruiser",
        "CSA_LocalOffice",
        "C_Ground_Light_Vehicle_Factory",
        "C_Ground_Light_Vehicle_Factory",
		"CSA_Shipyard_Level_Two",
        "Aratech_Battle_Platform_Company",
        "K222_Group",
        "K222_Group",
        "Espo_Squad",
        "Espo_Squad",
        "Espo_Squad"
    }
    SpawnList(unit_list, start_planet, p_csa, true, false)
    units = Spawn_Unit(Find_Object_Type("NewRepublic_Star_Base_2"), start_planet, p_csa)
	
	start_planet = FindPlanet("Orron")
    start_planet.Change_Owner(p_csa)
    unit_list = {
        "Dreadnaught_Empire",
        "Dreadnaught_Empire",
        "Recusant",
        "Espo_Squad",
        "Strikebreaker_Group",
		"CSA_Shipyard_Level_One"
    }
    SpawnList(unit_list, start_planet, p_csa, true, false)
    units = Spawn_Unit(Find_Object_Type("NewRepublic_Star_Base_1"), start_planet, p_csa)

    start_planet = FindPlanet("Mon_Calamari")
    unit_list = {"Cilghal_Team"}
    SpawnList(unit_list, start_planet, p_newrep, true, false)

    start_planet = FindPlanet("Desevro")
    start_planet.Change_Owner(p_newrep)
    unit_list = {
        "Majestic",
        "Majestic",
        "Sacheen",
        "Sacheen",
        "NewRep_SenatorsOffice",
        "R_Ground_Barracks",
        "R_Ground_Light_Vehicle_Factory",
		"NewRepublic_Shipyard_Level_Two",
        "Rebel_T4B_Company",
        "Rebel_T2B_Company",
        "Rebel_T2B_Company",
        "Rebel_Infantry_Squad",
        "Rebel_Infantry_Squad"
    }
    SpawnList(unit_list, start_planet, p_newrep, true, false)
    units = Spawn_Unit(Find_Object_Type("NewRepublic_Star_Base_1"), start_planet, p_newrep)

    start_planet = FindPlanet("Felucia")
    start_planet.Change_Owner(p_newrep)
    unit_list = {
        "Alliance_Assault_Frigate",
        "MC40a",
        "NewRep_SenatorsOffice",
        "R_Ground_Barracks",
        "R_Ground_Barracks",
		"NewRepublic_Shipyard_Level_One",
        "Rebel_T1B_Company",
        "Rebel_Infantry_Squad",
        "Rebel_Infantry_Squad"
    }
    SpawnList(unit_list, start_planet, p_newrep, true, false)
    units = Spawn_Unit(Find_Object_Type("NewRepublic_Star_Base_1"), start_planet, p_newrep)

    start_planet = FindPlanet("Galidraan")
    start_planet.Change_Owner(p_newrep)
    unit_list = {
        "Alliance_Assault_Frigate",
        "Corellian_Gunboat",
        "Corellian_Gunboat",
        "NewRep_SenatorsOffice",
        "R_Ground_Light_Vehicle_Factory",
		"NewRepublic_Shipyard_Level_Two",
        "Rebel_Infiltrator_Team",
        "Rebel_Infiltrator_Team",
        "Rebel_Infiltrator_Team",
        "Rebel_Gallofree_HTT_Company"
    }
    SpawnList(unit_list, start_planet, p_newrep, true, false)
    units = Spawn_Unit(Find_Object_Type("NewRepublic_Star_Base_1"), start_planet, p_newrep)

    start_planet = FindPlanet("Raxus")
    start_planet.Change_Owner(p_newrep)
    unit_list = {
        "MC80B",
        "ISD_1_NR",
        "Corellian_Gunboat",
        "Corellian_Gunboat",
        "NewRep_SenatorsOffice",
        "R_Ground_Light_Vehicle_Factory",
        "R_Ground_Heavy_Vehicle_Factory",
		"NewRepublic_Shipyard_Level_Two",
        "Rebel_Tracker_Company",
        "Rebel_MPTL_Company",
        "Rebel_Vwing_Group",
        "Rebel_Vwing_Group",
        "Rebel_Infantry_Squad",
        "Rebel_Infantry_Squad",
        "Rebel_Infantry_Squad"
    }
    SpawnList(unit_list, start_planet, p_newrep, true, false)
    units = Spawn_Unit(Find_Object_Type("NewRepublic_Star_Base_1"), start_planet, p_newrep)

    start_planet = FindPlanet("Raxus_Second")
    start_planet.Change_Owner(p_newrep)
    unit_list = {
        "MC90",
        "Dauntless",
        "Corellian_Corvette",
        "Corellian_Corvette",
        "NewRep_SenatorsOffice",
        "R_Ground_Light_Vehicle_Factory",
		"NewRepublic_Shipyard_Level_One",
        "Rebel_AAC_2_Company",
        "Rebel_AAC_2_Company",
        "Rebel_Infantry_Squad",
        "Rebel_Infantry_Squad"
    }
    SpawnList(unit_list, start_planet, p_newrep, true, false)
    units = Spawn_Unit(Find_Object_Type("NewRepublic_Star_Base_1"), start_planet, p_newrep)

    start_planet = FindPlanet("Emmer")
    start_planet.Change_Owner(p_newrep)
    unit_list = {
        "Nebula",
        "Endurance",
        "Corona",
        "Corona",
        "Sacheen",
        "Sacheen",
        "NewRep_SenatorsOffice",
        "R_Ground_Light_Vehicle_Factory",
        "R_Ground_Light_Vehicle_Factory",
		"NewRepublic_Shipyard_Level_One",
        "Rebel_Freerunner_Company",
        "Rebel_Freerunner_Company",
        "Rebel_Freerunner_Company",
        "Rebel_Vwing_Group",
        "Rebel_Infantry_Squad",
        "Rebel_Infantry_Squad"
    }
    SpawnList(unit_list, start_planet, p_newrep, true, false)
    units = Spawn_Unit(Find_Object_Type("NewRepublic_Star_Base_2"), start_planet, p_newrep)
end

function Prophet_spawn(message)
    if message == OnEnter then
        p_empire = Find_Player("Empire")

        start_planet = FindPlanet("Korriban")
        if start_planet.Get_Owner() == Find_Player("Empire") then
            if p_empire.Is_Human() then
                Story_Event("PROPHET_SPEECH")
            end
            spawn_list_duo = {"Kadann_Team", "Jedgar_Team"}
            SpawnList(spawn_list_duo, start_planet, p_empire, true, false)
        end
    end
end

function Post_Zsinj_forces(message)
	p_maldrood = Find_Player("Greater_Maldrood")
    p_empire = Find_Player("Empire")
	p_zsinj = Find_Player("Zsinj_Empire")
	
    start_planet = FindPlanet("Saffalore")
	start_planet.Change_Owner(p_zsinj)

    start_planet = FindPlanet("Felucia")
    start_planet.Change_Owner(p_maldrood)
    unit_list = {
        "13X_Teradoc",
        "Crimson_Victory",
        "Crimson_Victory",
		"Crimson_Victory",
		"Crimson_Victory",
		"Generic_Procursator",
		"Generic_Procursator",
		"Strike_Cruiser",
		"Strike_Cruiser",
		"Strike_Cruiser",
		"Strike_Cruiser",
		"Strike_Cruiser",
		"Escort_Carrier",
		"Escort_Carrier",
		"IPV1_System_Patrol_Craft",
		"IPV1_System_Patrol_Craft",
		"IPV1_System_Patrol_Craft",
		"IPV1_System_Patrol_Craft",
		"IPV1_System_Patrol_Craft",
        "Maldrood_MoffPalace",
        "Maldrood_Capital",
        "T_Ground_Heavy_Vehicle_Factory",
		"T_Ground_Light_Vehicle_Factory",
		"Greater_Maldrood_Shipyard_Level_One",
        "Imperial_SA5_Company",
        "Imperial_SA5_Company",
		"Imperial_SA5_Company",
        "Imperial_LAAT_Group",
        "Imperial_LAAT_Group",
        "Imperial_BARC_Company",
		"Imperial_Stormtrooper_Squad",
		"Imperial_Stormtrooper_Squad",
    }
    SpawnList(unit_list, start_planet, p_maldrood, true, false)
    units = Spawn_Unit(Find_Object_Type("Empire_Star_Base_2"), start_planet, p_maldrood)
	
	start_planet = FindPlanet("Galidraan")
    start_planet.Change_Owner(p_maldrood)
    unit_list = {
        "Arquitens",
        "Arquitens",
        "Arquitens",
		"Escort_Carrier",
		"Escort_Carrier",
		"Strike_Cruiser",
		"Strike_Cruiser",
		"Strike_Cruiser",
		"IPV1_System_Patrol_Craft",
		"IPV1_System_Patrol_Craft",
		"IPV1_System_Patrol_Craft",
        "Maldrood_MoffPalace",
        "T_Ground_Barracks",
		"T_Ground_Barracks",
		"Greater_Maldrood_Shipyard_Level_Two",
        "Imperial_AT_PT_Company",
        "Imperial_AT_PT_Company",
		"Imperial_AT_PT_Company",
        "Imperial_AT_AP_Walker_Company",
        "Imperial_LAAT_Group",
        "Army_Trooper_Squad",
		"Army_Trooper_Squad",
		"Army_Trooper_Squad",
    }
    SpawnList(unit_list, start_planet, p_maldrood, true, false)
    units = Spawn_Unit(Find_Object_Type("Empire_Star_Base_2"), start_planet, p_maldrood)
	
	start_planet = FindPlanet("Ession")
    start_planet.Change_Owner(p_empire)
    unit_list = {
        "Banjeer_Neutron",
        "Generic_Star_Destroyer_Two",
        "Escort_Carrier",
		"Escort_Carrier",
		"Escort_Carrier",
		"Generic_Victory_Destroyer",
		"Strike_Cruiser",
		"Strike_Cruiser",
		"IPV1_System_Patrol_Craft",
		"IPV1_System_Patrol_Craft",
		"IPV1_System_Patrol_Craft",
		"Empire_MoffPalace",
        "Remnant_Capital",
		"E_Ground_Heavy_Vehicle_Factory",
        "E_Ground_Light_Vehicle_Factory",
		"Empire_Shipyard_Level_Two",
        "Imperial_2M_Company",
        "Imperial_2M_Company",
		"Imperial_2M_Company",
        "Imperial_IDT_Group",
        "Imperial_IDT_Group",
        "Imperial_74Z_Bike_Company",
		"Imperial_Stormtrooper_Squad",
		"Imperial_Stormtrooper_Squad",
		"Imperial_Chariot_LAV_Company",
		"Imperial_Chariot_LAV_Company",
    }
    SpawnList(unit_list, start_planet, p_empire, true, false)
    units = Spawn_Unit(Find_Object_Type("Empire_Star_Base_2"), start_planet, p_empire)
	
	start_planet = FindPlanet("Maryo")
    start_planet.Change_Owner(p_empire)
    unit_list = {
        "Generic_Acclamator_Assault_Ship_II",
        "Empire_MoffPalace",
        "E_Ground_Barracks",
		"Empire_Shipyard_Level_One",
        "Imperial_Chariot_LAV_Company",
        "Imperial_Chariot_LAV_Company",
        "Army_Trooper_Squad",
        "Imperial_Stormtrooper_Squad",
        "Army_Trooper_Squad"
    }
    SpawnList(unit_list, start_planet, p_empire, true, false)
    units = Spawn_Unit(Find_Object_Type("Empire_Star_Base_1"), start_planet, p_empire)

    start_planet = FindPlanet("Oslumpex")
    start_planet.Change_Owner(p_empire)
    unit_list = {
        "Generic_Acclamator_Assault_Ship_II",
        "Generic_Acclamator_Assault_Ship_II",
		"Carrack_Cruiser",
        "Empire_MoffPalace",
        "E_Ground_Light_Vehicle_Factory",
        "E_Ground_Heavy_Vehicle_Factory",
        "Imperial_AT_PT_Company",
        "Empire_Shipyard_Level_Two",
        "Imperial_AT_PT_Company",
        "Army_Trooper_Squad",
        "Army_Trooper_Squad"
    }
    SpawnList(unit_list, start_planet, p_empire, true, false)
    units = Spawn_Unit(Find_Object_Type("Empire_Star_Base_1"), start_planet, p_empire)

    start_planet = FindPlanet("Desevro")
    start_planet.Change_Owner(p_empire)
    unit_list = {
        "Generic_Star_Destroyer",
        "Generic_Victory_Destroyer_Two",
        "Strike_Cruiser",
        "Strike_Cruiser",
        "Empire_MoffPalace",
        "E_Ground_Light_Vehicle_Factory",
        "E_Ground_Light_Vehicle_Factory",
		"Empire_Shipyard_Level_Two",
        "Imperial_2M_Company",
        "Imperial_2M_Company",
        "Army_Trooper_Squad",
        "Army_Trooper_Squad"
    }
    SpawnList(unit_list, start_planet, p_empire, true, false)
    units = Spawn_Unit(Find_Object_Type("Empire_Star_Base_1"), start_planet, p_empire)
	
	start_planet = FindPlanet("Raxus_Second")
    start_planet.Change_Owner(p_empire)
    unit_list = {
        "Generic_Victory_Destroyer",
        "Vindicator_Cruiser",
        "Lancer_Frigate",
        "Lancer_Frigate",
        "Empire_MoffPalace",
        "E_Ground_Barracks",
        "E_Ground_Light_Vehicle_Factory",
		"Empire_Shipyard_Level_One",
        "Imperial_Stormtrooper_Squad",
        "Army_Trooper_Squad"
    }
    SpawnList(unit_list, start_planet, p_empire, true, false)
    units = Spawn_Unit(Find_Object_Type("Empire_Star_Base_1"), start_planet, p_empire)
end