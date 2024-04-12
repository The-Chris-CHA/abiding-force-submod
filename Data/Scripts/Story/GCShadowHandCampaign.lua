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
--*   @Author:              Corey
--*   @Date:                2017-11-24T12:43:51+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            GCShadowHandCampaign.lua
--*   @Last modified by:
--*   @Last modified time:  2018-03-13T22:30:29-04:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************

require("PGStoryMode")
require("PGSpawnUnits")
require("eawx-util/ChangeOwnerUtilities")
StoryUtil = require("eawx-util/StoryUtil")

function Definitions()
    DebugMessage("%s -- In Definitions", tostring(Script))

    StoryModeEvents = {
        Determine_Faction = Determine_Faction_Lua,
        Delayed_Initialize = Initialize,
        Universal_Byss_Unlock = Byss_Unlock_Lua,
        Universal_Palpatine_Dies = Palpatine_Dies_Lua,
        Empire_Evil_Luke_Appears = Evil_Luke_Appears_Lua,
        Empire_Eclipse_Appears = Eclipse_Appears_Lua,
        Empire_Balmorra_Revolt = Balmorra_Revolt_Lua,
        Empire_Balmorra_Reconquered = Balmorra_Reconquered_Lua,
        NR_Save_Luke_Success = Save_Luke_Success_Lua,
        NR_Byss_Raid_Success = Byss_Raid_Success_Lua
    }
end

function Determine_Faction_Lua(message)
    if message == OnEnter then
        local p_newrep = Find_Player("Rebel")
        local p_empire = Find_Player("Empire")

        if p_newrep.Is_Human() then
            Story_Event("ENABLE_BRANCH_NR_FLAG")
        elseif p_empire.Is_Human() then
            Story_Event("ENABLE_BRANCH_EMPIRE_FLAG")

            local probe_list = {"Probe_Droid_Team"}
            local planet_list = {"Botajef","Corsin","Hakassi","Ord_Cantrell","Ord_Radama","Prakith","Thomork"}

            for _, planet_name in pairs(planet_list) do
                SpawnList(probe_list, FindPlanet(planet_name), p_empire, true, false)
            end
        end
        
        Story_Event("GC_CORUSCANT_EVAC_LONG")
    end
end

function Initialize(message)
    if message == OnEnter then
		crossplot:galactic()
		crossplot:publish("INITIALIZE_AI", "empty")
	else
		crossplot:update()
    end
end

function Byss_Unlock_Lua(message)
    if message == OnEnter then
        local player_empire = Find_Player("Empire")
        local player_newrep = Find_Player("Rebel")
        local planet_byss = FindPlanet("Byss")

        local EmpireCapital = Find_First_Object("Remnant_Capital")
        if TestValid(EmpireCapital) then
            local EmpireCapitalLocation = EmpireCapital.Get_Planet_Location()
            EmpireCapital.Despawn()
            SpawnList({"E_Ground_Barracks"}, EmpireCapitalLocation, player_empire, true, false)
        end

        ChangePlanetOwnerAndRetreat(planet_byss, player_empire)
        spawn_list_palpatine = {
            "Emperor_Palpatine_Team",
            "Pestage_Clone_Team",
            "Umak_Team",
            "Grath_Dark_Stormtrooper_Team",
            "Klev_Capital_Devastator",
            "Coross_Vengeance_II",
            "Cronal_Singularity",
            
            "Imperial_AT_AT_Refit_Company",
            "Imperial_XR85_Company",
            "Imperial_Chariot_LAV_Company",
            "Imperial_AT_ST_Company",
            "Imperial_Dark_Stormtrooper_Squad",
            "Imperial_Shadow_Stormtrooper_Squad",
            "Imperial_Compforce_Assault_Squad",
            
            "Dark_Empire_Cloning_Facility",
            "Remnant_Capital",
            "Empire_MoffPalace",
            "E_Ground_Barracks",
            "E_Ground_Advanced_Vehicle_Factory",
            "Ground_Hypervelocity_Gun",
            
            "Empire_Star_Base_5",
            "Secondary_Golan_Three",
            "Empire_Shipyard_Level_Four"
        }
        SpawnList(spawn_list_palpatine, planet_byss, player_empire, true, false)

        if player_newrep.Is_Human() then
            local spawn_list_human_nr = {
                "Luke_Skywalker_Darkside_Team",
                "Eclipse_Star_Destroyer"
            }
            SpawnList(spawn_list_human_nr, planet_byss, player_empire, true, false)
        end
    end
end

function Palpatine_Dies_Lua(message)
    if message == OnEnter then
        local p_neutral = Find_Player("Neutral")
        local p_empire = Find_Player("Empire")
        local p_maldrood = Find_Player("Greater_Maldrood")
        local p_eriadu = Find_Player("Eriadu_Authority")
        local p_harrsk = Find_Player("Warlords")
        local p_pentastar = Find_Player("Pentastar")

        local start_planet = nil
        local spawn_list = {}

        --if Palpatine's cloning facility is still alive, despawn it
        local DECloningFacility = Find_First_Object("Dark_Empire_Cloning_Facility")
        if TestValid(DECloningFacility) then
            DECloningFacility.Despawn()
        end

        --if Dark Luke is around and Leia is not, he takes over the Empire
        if Find_First_Object("Luke_Skywalker_Darkside") and not Find_First_Object("Princess_Leia") then
            Story_Event("LUKE_LEADS_EMPIRE")
        --if Sedriss is still around, he takes over the Empire
        elseif Find_First_Object("Sedriss") then
            Story_Event("SEDRISS_LEADS_EMPIRE")
        --if none of the above, Carnor shows up
        else
            local activePlanets = StoryUtil.GetSafePlanetTable()
            local spawnListCarnor = {
                "Carnor_Jax_Team",
                "Imperial_Shadow_Stormtrooper_Squad"
            }
            
            if FindPlanet("BYSS").Get_Owner() == p_empire then
                start_planet = "BYSS"
            else
                start_planet = "ORD_CANTRELL"
            end
            
            StoryUtil.SpawnAtSafePlanet(start_planet, p_empire, activePlanets, spawnListCarnor)
            
            Story_Event("CARNOR_LEADS_EMPIRE")    
        end

        --first, move all seceding planets to Neutral at once to prevent Empire forces from retreating to any
        local seceding_planet_objects = {}
        local possible_seceding_planet_names = {
            "Balamak",
            "Metalorn",
            "Centares",
            "Hakassi",
            "Kampe",
            "Kalist",
            "Entralla",
            "Borosk",
            "Ord_Trasi",
            "Garqi"
        }

        for i, planetName in pairs(possible_seceding_planet_names) do
            local planetObject = FindPlanet(planetName)

            if planetObject.Get_Owner() == p_empire then
                table.insert(seceding_planet_objects, planetObject)
            end
        end

        Story_Event("STOP_MONITOR_EVIL_LUKE_DEATH")
        ChangePlanetOwnerAndRetreat(seceding_planet_objects, p_neutral)
        Story_Event("RESUME_MONITOR_EVIL_LUKE_DEATH")

        --Federated Teradoc Union (Centares for Treutan, Hakassi for Kosh)

        p_maldrood.Give_Money(10000)

        local TreutenTeradoc = Find_First_Object("Treuten_Crimson_Sunrise")
        if TestValid(TreutenTeradoc) then
            TreutenTeradoc.Despawn()
        end

        local KoshTeradoc = Find_First_Object("Kosh_Lancet")
        if TestValid(KoshTeradoc) then
            KoshTeradoc.Despawn()
        end

        local maldrood_centares = false
        local maldrood_balamak = false
        local maldrood_metalorn = false
        local maldrood_hakassi = false

        start_planet = FindPlanet("Centares")
        if start_planet.Get_Owner() == p_neutral then
            ChangePlanetOwnerAndRetreat(start_planet, p_maldrood)
            spawn_list = {
                "Generic_Tector",
                "Generic_Star_Destroyer",
                "Crimson_Victory",
                "Crimson_Victory",
                "Crimson_Victory",
                "Crimson_Victory",
                "Crimson_Victory",
                "Strike_Cruiser",
                "Strike_Cruiser",
                "Broadside_Cruiser",
                "Customs_Corvette",
                "Customs_Corvette",
                "Customs_Corvette",
                "Customs_Corvette",
                "Customs_Corvette",
                
                "Imperial_A5_Juggernaut_Company",
                "Imperial_Heavy_Recovery_Vehicle_Company",
                "Imperial_SA5_Company",
                "Imperial_Missile_Artillery_Company",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Navy_Commando_Squad",
                "Imperial_Navy_Commando_Squad",
                "Imperial_Navy_Commando_Squad",
                
                "Maldrood_Capital",
                "Maldrood_MoffPalace",
                "T_Ground_Barracks",
                "T_Ground_Light_Vehicle_Factory",
                "T_Ground_Heavy_Vehicle_Factory",
                "Tax_Agency",
                
                "Empire_Star_Base_4",
                "Secondary_Golan_Two",
                "Greater_Maldrood_Shipyard_Level_Two"
            }
            SpawnList(spawn_list, start_planet, p_maldrood, true, false)
            
            maldrood_centares = start_planet
        end

        start_planet = FindPlanet("Metalorn")
        if start_planet.Get_Owner() == p_neutral then
            ChangePlanetOwnerAndRetreat(start_planet, p_maldrood)
            spawn_list = {
                "Generic_Star_Destroyer",
                "Crimson_Victory",
                "Crimson_Victory",
                "Crimson_Victory",
                "Crimson_Victory",
                "Strike_Cruiser",
                "Strike_Cruiser",
                "Broadside_Cruiser",
                "Customs_Corvette",
                "Customs_Corvette",
                "Customs_Corvette",
                "Customs_Corvette",
                "Customs_Corvette",
                
                "Imperial_A5_Juggernaut_Company",
                "Imperial_Heavy_Recovery_Vehicle_Company",
                "Imperial_RTT_Company",
                "Imperial_INT4_Group",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Fleet_Commando_Squad",
                "Imperial_Fleet_Commando_Squad",
                "Imperial_Navy_Commando_Squad",
                "Imperial_Navy_Commando_Squad",
                "Imperial_Army_Guard_Squad",
                
                "Maldrood_MoffPalace",
                "T_Ground_Advanced_Vehicle_Factory",
                "T_Ground_Heavy_Vehicle_Factory",
                "T_Ground_Heavy_Vehicle_Factory",
                "Tax_Agency",
                
                "Empire_Star_Base_3",
                "Secondary_Golan_One",
                "Greater_Maldrood_Shipyard_Level_Two"
            }
            SpawnList(spawn_list, start_planet, p_maldrood, true, false)
            
            maldrood_metalorn = start_planet
        end

        start_planet = FindPlanet("Balamak")
        if start_planet.Get_Owner() == p_neutral then
            ChangePlanetOwnerAndRetreat(start_planet, p_maldrood)
            spawn_list = {
                "Generic_Tector",
                "Crimson_Victory",
                "Crimson_Victory",
                "Crimson_Victory",
                "Crimson_Victory",
                "Strike_Cruiser",
                "Strike_Cruiser",
                "Broadside_Cruiser",
                "Customs_Corvette",
                "Customs_Corvette",
                "Customs_Corvette",
                "Customs_Corvette",
                "Customs_Corvette",
                
                "Imperial_MAAT_Group",
                "Imperial_2M_Company",
                "Imperial_ISP_Company",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Imperial_ISB_Infiltrator_Squad",
                "Imperial_Navy_Commando_Squad",
                
                "Maldrood_MoffPalace",
                "T_Ground_Light_Vehicle_Factory",
                "T_Ground_Heavy_Vehicle_Factory",
                "Tax_Agency",
                
                "Empire_Star_Base_3",
                "Secondary_Golan_One",
                "Greater_Maldrood_Shipyard_Level_One"
            }
            SpawnList(spawn_list, start_planet, p_maldrood, true, false)
            
            maldrood_balamak = start_planet
        end

        start_planet = FindPlanet("Hakassi")
        if start_planet.Get_Owner() == p_neutral then
            ChangePlanetOwnerAndRetreat(start_planet, p_maldrood)
            spawn_list = {
                "Generic_Allegiance",
                "Generic_Tector",
                "Generic_Star_Destroyer",
                "Generic_Star_Destroyer",                
                "Generic_Imperial_II_Frigate",    
                "Generic_Imperial_II_Frigate",
                "Generic_Imperial_II_Frigate",            
                "Strike_Cruiser",
                "Strike_Cruiser",
                "Strike_Cruiser",
                "Strike_Cruiser",               
                "Customs_Corvette",
                "Customs_Corvette",
                "Customs_Corvette",
                "Customs_Corvette",
                "Customs_Corvette",
                
                "Imperial_A5_Juggernaut_Company",
                "Imperial_Heavy_Recovery_Vehicle_Company",
                "Imperial_SA5_Company",
                "Imperial_Missile_Artillery_Company",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Imperial_ISB_Infiltrator_Squad",
                "Imperial_Navy_Commando_Squad",
                "Imperial_Navy_Commando_Squad",
                "Imperial_Navy_Commando_Squad",
                
                "Maldrood_MoffPalace",
                "T_Ground_Heavy_Vehicle_Factory",
                "Ground_Hypervelocity_Gun",
                
                "Empire_Star_Base_5",
                "Secondary_Golan_Three",
                "Greater_Maldrood_Shipyard_Level_Three"
            }
            SpawnList(spawn_list, start_planet, p_maldrood, true, false)
            
            maldrood_hakassi = start_planet
        end

        --GM capital preference order: Centares, Hakassi, Metalorn, Balamak (any others get Barracks)
        if maldrood_centares then
            if maldrood_hakassi then
                SpawnList({"T_Ground_Barracks"}, maldrood_hakassi, p_maldrood, true, false)
            end
            if maldrood_metalorn then
                SpawnList({"T_Ground_Barracks"}, maldrood_metalorn, p_maldrood, true, false)
            end
            if maldrood_balamak then
                SpawnList({"T_Ground_Barracks"}, maldrood_balamak, p_maldrood, true, false)
            end
        elseif maldrood_hakassi then
            SpawnList({"Maldrood_Capital"}, maldrood_hakassi, p_maldrood, true, false)

            if maldrood_metalorn then
                SpawnList({"T_Ground_Barracks"}, maldrood_metalorn, p_maldrood, true, false)
            end
            if maldrood_balamak then
                SpawnList({"T_Ground_Barracks"}, maldrood_balamak, p_maldrood, true, false)
            end
        elseif maldrood_metalorn then
            SpawnList({"Maldrood_Capital"}, maldrood_metalorn, p_maldrood, true, false)

            if maldrood_balamak then
                SpawnList({"T_Ground_Barracks"}, maldrood_balamak, p_maldrood, true, false)
            end
        elseif maldrood_balamak then
            SpawnList({"Maldrood_Capital"}, maldrood_balamak, p_maldrood, true, false)
        end
        
        --Treuten preference order: Centares, Metalorn, Balamak, Hakassi
        local treuten_list = {
            "Treuten_13X",
            "Generic_Bellator"
        }
        if maldrood_centares then
            SpawnList(treuten_list, maldrood_centares, p_maldrood, true, false)
        elseif maldrood_metalorn then
            SpawnList(treuten_list, maldrood_metalorn, p_maldrood, true, false)
        elseif maldrood_balamak then
            SpawnList(treuten_list, maldrood_balamak, p_maldrood, true, false)
        elseif maldrood_hakassi then
            SpawnList(treuten_list, maldrood_hakassi, p_maldrood, true, false)
        end        

        --Kosh preference order: Hakassi, Centares, Metalorn, Balamak
        if maldrood_hakassi then
            SpawnList({"Kosh_Lancet"}, maldrood_hakassi, p_maldrood, true, false)
        elseif maldrood_centares then
            SpawnList({"Kosh_Lancet"}, maldrood_centares, p_maldrood, true, false)
        elseif maldrood_metalorn then
            SpawnList({"Kosh_Lancet"}, maldrood_metalorn, p_maldrood, true, false)
        elseif maldrood_balamak then
            SpawnList({"Kosh_Lancet"}, maldrood_balamak, p_maldrood, true, false)
        end


        --Zero Command

        local checkHarrsk = Find_First_Object("Harrsk_Shockwave")
        if TestValid(checkHarrsk) then
            checkHarrsk.Despawn()
        end

        start_planet = FindPlanet("Kalist")
        if start_planet.Get_Owner() == p_neutral then
            ChangePlanetOwnerAndRetreat(start_planet, p_harrsk)
            spawn_list = {
                "Harrsk_Shockwave",
                "Dominion",
                "Generic_Tector",                
                "Vindicator_Cruiser",
                "Vindicator_Cruiser",                
                "Strike_Cruiser",
                "Strike_Cruiser",
                "Lancer_Frigate",
                "Lancer_Frigate",
                "Lancer_Frigate",

                "Imperial_AT_AT_Company",
                "Imperial_S_1_Firehawke_Company",
                "Imperial_AT_ST_Company",
                "Imperial_SPMAG_Company",
                "Imperial_A5RX_Company",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Scout_Trooper_Infantry_Squad",
                "Imperial_Navy_Trooper_Squad",
                "Imperial_Navy_Trooper_Squad",
                
                "Empire_MoffPalace",
                "E_Ground_Barracks",
                "E_Ground_Heavy_Vehicle_Factory",
                "Ground_Hypervelocity_Gun",
                
                "Empire_Star_Base_5",
                "Secondary_Golan_Three",
                "Empire_Shipyard_Level_Three"
            }
            SpawnList(spawn_list, start_planet, p_harrsk, true, false)
        end


       -- Eriadu Authority

        p_eriadu.Give_Money(10000)
        
        local checkDelvardus = Find_First_Object("Delvardus_Brilliant")
        if TestValid(checkDelvardus) then
            checkDelvardus.Despawn()
        end

        start_planet = FindPlanet("Kampe")
        if start_planet.Get_Owner() == p_neutral then
            ChangePlanetOwnerAndRetreat(start_planet, p_eriadu)
            spawn_list = {
                "Delvardus_Night_Hammer",
                "Generic_Star_Destroyer",
                "Generic_Star_Destroyer_Two",
                "Eidolon",
                "Generic_Gladiator",
                "Generic_Gladiator",
                "IPV1_System_Patrol_Craft",
                "IPV1_System_Patrol_Craft",
                "IPV1_System_Patrol_Craft",
                "IPV1_System_Patrol_Craft",
                "IPV1_System_Patrol_Craft",
                
                "Octavion_Sorin_Team",
                "Imperial_1H_Tank_Company",
                "Imperial_1L_Tank_Company",
                "Imperial_Light_Artillery_Company",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Army_Special_Missions_Squad",
                "Imperial_Army_Special_Missions_Squad",
                "Imperial_Army_Commando_Squad",
                "Imperial_Galactic_Marine_Squad",
                
                "Eriadu_Capital",
                "Eriadu_MoffPalace",
                "A_Ground_Heavy_Vehicle_Factory",
                "Ground_Hypervelocity_Gun",
                
                "Empire_Star_Base_5",
                "Secondary_Golan_Three",
                "Eriadu_Shipyard_Level_Three"
            }
            SpawnList(spawn_list, start_planet, p_eriadu, true, false)
        end


        -- Pentastar Alignment

        p_pentastar.Give_Money(10000)

        local pentastar_entralla = false
        local pentastar_garqi = false
        local pentastar_borosk = false
        local pentastar_ord_trasi = false

        start_planet = FindPlanet("Entralla")
        if start_planet.Get_Owner() == p_neutral then
            ChangePlanetOwnerAndRetreat(start_planet, p_pentastar)
            spawn_list = {
                "Reaper",
                "Generic_Star_Destroyer",
                "Generic_Star_Destroyer",
                "Enforcer",
                "Enforcer",
                "Enforcer",
                "Enforcer",
                "Tartan_Patrol_Cruiser",
                "Tartan_Patrol_Cruiser",

                "Imperial_C10_Siege_Tower_Company",
                "Imperial_Nemesis_Gunship_Group",
                "Imperial_AT_DP_Company",
                "Imperial_Century_Tank_Company",
                "Pentastar_Enforcer_Trooper_Squad",
                "Pentastar_Enforcer_Trooper_Squad",
                "Pentastar_Enforcer_Trooper_Squad",
                "Imperial_Guardian_Protector_Squad",
                "Imperial_Guardian_Protector_Squad",
                "Imperial_Guardian_Protector_Squad",
                
                "PA_Capital",
                "Pentastar_MoffPalace",
                "P_Ground_Barracks",
                "P_Ground_Heavy_Vehicle_Factory",
                "Tax_Agency",
                "Tax_Agency",
                
                "Empire_Star_Base_4",
                "Secondary_Golan_Two",
                "Generic_TradeStation",
                "Pentastar_Shipyard_Level_Two"
            }
            SpawnList(spawn_list, start_planet, p_pentastar, true, false)
            
            pentastar_entralla = start_planet
        end

        start_planet = FindPlanet("Garqi")
        if start_planet.Get_Owner() == p_neutral then
            ChangePlanetOwnerAndRetreat(start_planet, p_pentastar)
            spawn_list = {            
                "Generic_Tector",
                "Generic_Star_Destroyer",
                "Enforcer",
                "Enforcer",
                "Imperial_Cargo_Ship",
                "Raider_Corvette",
                "Raider_Corvette",

                "Imperial_C10_Siege_Tower_Company",
                "Imperial_Nemesis_Gunship_Group",
                "Imperial_AT_DP_Company",
                "Imperial_Century_Tank_Company",
                "Pentastar_Army_Trooper_Squad",
                "Pentastar_Army_Trooper_Squad",
                "Pentastar_Army_Trooper_Squad",
                "Imperial_Guardian_Protector_Squad",
                "Imperial_Guardian_Protector_Squad",
                "Imperial_Guardian_Protector_Squad",
                
                "Pentastar_MoffPalace",
                "P_Ground_Heavy_Vehicle_Factory",
                "P_Ground_Advanced_Vehicle_Factory",
                
                "Empire_Star_Base_3",
                "Secondary_Golan_One",
                "Generic_TradeStation",
                "Pentastar_Shipyard_Level_One"
            }
            SpawnList(spawn_list, start_planet, p_pentastar, true, false)
            
            pentastar_garqi = start_planet
        end

        start_planet = FindPlanet("Borosk")
        if start_planet.Get_Owner() == p_neutral then
            ChangePlanetOwnerAndRetreat(start_planet, p_pentastar)
            spawn_list = {
                "Generic_Star_Destroyer",
                "Generic_Procursator",  
                "Generic_Venator",
                "Generic_Acclamator_Assault_Ship_Leveler",
                "Battle_Horn",
                "Tartan_Patrol_Cruiser",
                "Tartan_Patrol_Cruiser",
                
                "Imperial_AT_DP_Company",
                "Imperial_AT_PT_Company",
                "Pentastar_Enforcer_Trooper_Squad",
                "Pentastar_Enforcer_Trooper_Squad",
                
                "Pentastar_MoffPalace",
                "P_Ground_Light_Vehicle_Factory",
                "P_Ground_Heavy_Vehicle_Factory",
                "Tax_Agency",

                "Empire_Star_Base_3",
                "Secondary_Golan_One",
                "Pentastar_Shipyard_Level_Two"
            }
            SpawnList(spawn_list, start_planet, p_pentastar, true, false)
            
            pentastar_borosk = start_planet
        end

        start_planet = FindPlanet("Ord_Trasi")
        if start_planet.Get_Owner() == p_neutral then
            ChangePlanetOwnerAndRetreat(start_planet, p_pentastar)
            spawn_list = {
                "Generic_Tector",
                "Generic_Venator",
                "Enforcer",
                "Dreadnaught_Empire",
                "Dreadnaught_Empire",
                "Trenchant",
                "Trenchant",
                "Trenchant",
                 
                "Imperial_Century_Tank_Company",
                "Imperial_TIE_Mauler_Company",
                "Pentastar_Enforcer_Trooper_Squad",
                "Pentastar_Enforcer_Trooper_Squad",
                
                "Pentastar_MoffPalace",
                "P_Ground_Light_Vehicle_Factory",
                "P_Ground_Heavy_Vehicle_Factory",

                "Empire_Star_Base_4",
                "Secondary_Golan_Two",
                "Pentastar_Shipyard_Level_Three"
            }
            SpawnList(spawn_list, start_planet, p_pentastar, true, false)
            
            pentastar_ord_trasi = start_planet
        end
    
        --PA capital & Reaper preference order: Entralla, Garqi, Borosk, Ord Trasi (any others get Barracks)
        local pa_list = {
            "PA_Capital",
            "Reaper"
        }

        if pentastar_entralla then
            if pentastar_garqi then
                SpawnList({"P_Ground_Barracks"}, pentastar_garqi, p_pentastar, true, false)
            end
            if pentastar_borosk then
                SpawnList({"P_Ground_Barracks"}, pentastar_borosk, p_pentastar, true, false)
            end
            if pentastar_ord_trasi then
                SpawnList({"P_Ground_Barracks"}, pentastar_ord_trasi, p_pentastar, true, false)
            end
        elseif pentastar_garqi then
            SpawnList(pa_list, pentastar_garqi, p_pentastar, true, false)

            if pentastar_borosk then
                SpawnList({"P_Ground_Barracks"}, pentastar_borosk, p_pentastar, true, false)
            end
            if pentastar_ord_trasi then
                SpawnList({"P_Ground_Barracks"}, pentastar_ord_trasi, p_pentastar, true, false)
            end
        elseif pentastar_borosk then
            SpawnList(pa_list, pentastar_borosk, p_pentastar, true, false)

            if pentastar_ord_trasi then
                SpawnList({"P_Ground_Barracks"}, pentastar_ord_trasi, p_pentastar, true, false)
            end
        elseif pentastar_ord_trasi then
            SpawnList(pa_list, pentastar_ord_trasi, p_pentastar, true, false)
        end
    end
end

function Evil_Luke_Appears_Lua(message)
    if message == OnEnter then
        local activePlanets = StoryUtil.GetSafePlanetTable()
        local p_empire = Find_Player("Empire")
        local spawnListEvilLuke = {"Luke_Skywalker_Darkside_Team"}
        
        local planetName = "BYSS"

        if FindPlanet(planetName).Get_Owner() ~= p_empire then
            planetName = "KALIST"
        end
        
        StoryUtil.SpawnAtSafePlanet(planetName, p_empire, activePlanets, spawnListEvilLuke)
    end
end

function Eclipse_Appears_Lua(message)
    if message == OnEnter then
        local spawn_list = {
        "Eclipse_Star_Destroyer"
        }
        local planet_byss = FindPlanet("Byss")
        local player_empire = Find_Player("Empire")
        SpawnList(spawn_list, planet_byss, player_empire, true, false)
    end
end

function Balmorra_Revolt_Lua(message)
    if message == OnEnter then
        local p_empire = Find_Player("Empire")
        local p_balmorra = Find_Player("Independent_Forces")

        local start_planet = FindPlanet("Balmorra")
        if start_planet.Get_Owner() == p_empire then
            ChangePlanetOwnerAndRetreat(start_planet, p_balmorra)

            spawn_list = {
                "Generic_Star_Destroyer",
                "Generic_Star_Destroyer_Two",
                "Generic_Procursator",
                "Generic_Procursator",
                "Dreadnaught_Empire",
                "Dreadnaught_Empire",
                "Dreadnaught_Empire",
                "Raider_Corvette",
                "Raider_Corvette",
                
                "Imperial_AT_AT_Refit_Company",
                "Imperial_AT_AT_Refit_Company",
                "Imperial_AT_ST_Company",
                "Imperial_AT_ST_Company",
                "X1_Viper_Droid_Company",
                "X1_Viper_Droid_Company",
                "SD_10_Battle_Droid_Company",
                "SD_10_Battle_Droid_Company",
                "Military_Soldier_Team",
                "Military_Soldier_Team",
                
                "Revolt_PDF_HQ",
                "Revolt_Urban_Barracks",
                "E_Ground_Heavy_Vehicle_Factory",
                "E_Ground_Heavy_Vehicle_Factory",
                "E_Ground_Advanced_Vehicle_Factory",
                "Generic_Planetary_Shield",
                
                "Empire_Star_Base_4",
                "Secondary_Golan_Two",
                "Empire_Shipyard_Level_Two",
                "Generic_TradeStation"
            }
            SpawnList(spawn_list, start_planet, p_balmorra, false, false)
        end
    elseif message == OnUpdate then
    end
end

function Balmorra_Reconquered_Lua(message)
    if message == OnEnter then
        local p_empire = Find_Player("Empire")
        local start_planet = FindPlanet("Balmorra")

        if start_planet.Get_Owner() == Find_Player("Empire") then
            spawn_list_balmorra = {
                "X1_Viper_Droid_Company",
                "X1_Viper_Droid_Company",
                "X1_Viper_Droid_Company"
            }
            SpawnList(spawn_list_balmorra, start_planet, p_empire, true, false)
        end
    elseif message == OnUpdate then
    end
end

function Save_Luke_Success_Lua(message)
    if message == OnEnter then
        local activePlanets = StoryUtil.GetSafePlanetTable()
        local p_newrep = Find_Player("Rebel")
        local spawnListGoodLuke = {"Luke_Skywalker_Jedi_Team"}

        StoryUtil.SpawnAtSafePlanet(nil, p_newrep, activePlanets, spawnListGoodLuke)
    end
end

function Byss_Raid_Success_Lua(message)
    if message == OnEnter then
        local p_rebel = Find_Player("Rebel")
        local start_planet = FindPlanet("Byss")

        ChangePlanetOwnerAndRetreat(start_planet, p_rebel)
        spawn_list_unlikely_conquerors = {"X1_Viper_Droid_Company", "X1_Viper_Droid_Company"}
        SpawnList(spawn_list_unlikely_conquerors, start_planet, p_rebel, true, false)
    elseif message == OnUpdate then
    end
end
