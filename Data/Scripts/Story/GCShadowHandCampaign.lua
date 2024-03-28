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
        Determine_Faction_LUA = Find_Faction,
        Eclipse_Completed_Generic = Palpatine_Joins,
        Warlords_Breakoff = Empire_Fractures,
        Luke_Completed = Luke_Joins,
        Balmorran_Revolt_Narrative = Spawn_Balmorrans,
        Conquer_Balmorra = Balmorran_Reward,
        Balmorra_Mission_Won = Noncanonical_Byss_Takeover
    }
end

function Find_Faction(message)
    if message == OnEnter then
        local p_newrep = Find_Player("Rebel")
        local p_empire = Find_Player("Empire")

        if p_newrep.Is_Human() then
            Story_Event("ENABLE_BRANCH_NR_FLAG")
        elseif p_empire.Is_Human() then
            Story_Event("ENABLE_BRANCH_EMPIRE_FLAG")
        end
		
		Story_Event("GC_CORUSCANT_EVAC_SHORT")
    end
end

function Palpatine_Joins(message)
    if message == OnEnter then
        local p_empire = Find_Player("Empire")
        local p_newrep = Find_Player("Rebel")
        local start_planet = FindPlanet("Byss")

        ChangePlanetOwnerAndRetreat(start_planet, p_empire)
        spawn_list_emperor = {
            "Emperor_Palpatine_Team",
			"Umak_Team",
			"Klev_Capital_Devastator",
            "Empire_MoffPalace",
			"Vindicator_Cruiser",
			"Victory_II_Frigate",
			"Raider_Corvette",
			"Raider_Corvette",
			"Raider_Corvette",
			"Raider_Corvette",
			"CR90_Zsinj",
			"CR90_Zsinj",
			"Dark_Empire_Cloning_Facility",
			"E_Ground_Barracks",
            "E_Ground_Light_Vehicle_Factory",
            "E_Ground_Heavy_Vehicle_Factory",
            "E_Ground_Advanced_Vehicle_Factory",
            "Eclipse_Star_Destroyer"
        }
        EmperorSpawn = SpawnList(spawn_list_emperor, start_planet, p_empire, true, false)

        if p_newrep.Is_Human() then
            spawn_list_luke = {"Luke_Skywalker_Darkside_Team"}
            LukeSpawn = SpawnList(spawn_list_luke, start_planet, p_empire, true, false)
        end
    end
end

function Empire_Fractures(message)
    if message == OnEnter then
        local p_empire = Find_Player("Empire")
        local p_maldrood = Find_Player("Greater_Maldrood")
        local p_eriadu = Find_Player("Eriadu_Authority")
        local p_harrsk = Find_Player("Warlords")
        local p_pentastar = Find_Player("Pentastar")

        --Carnor takes control of the Empire

        local start_planet = FindPlanet("Byss")
        if start_planet.Get_Owner() == p_empire then
            spawn_list = {"Carnor_Jax_Team"}
            ImperialForces = SpawnList(spawn_list, start_planet, p_empire, true, false)
        end

        --Federated Teradoc Union (Centares for Treutan, Hakassi for Kosh)

        local checkTeradoc = Find_First_Object("CrimsonSunrise_Star_Destroyer")
        if TestValid(checkTeradoc) then
            checkTeradoc.Despawn()
        end

        local start_planet = FindPlanet("Centares")
        if start_planet.Get_Owner() == p_empire then
            ChangePlanetOwnerAndRetreat(start_planet, p_maldrood)
            spawn_list = {
                "Imperial_AT_AT_Company",
                "Imperial_AT_AT_Company",
                "Imperial_AT_ST_Company",
                "Imperial_AT_ST_Company",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Generic_Star_Destroyer_Two",
                "Generic_Star_Destroyer_Two",
                "Generic_Star_Destroyer",
                "Generic_Star_Destroyer",
                "13X_Teradoc",
                "Generic_Gladiator",
                "Generic_Gladiator",
                "Broadside_Cruiser",				
                "Crimson_Victory",
                "Crimson_Victory",
                "Crimson_Victory",
                "Crimson_Victory",
                "Crimson_Victory",
                "Crimson_Victory"
            }
            ImperialForces = SpawnList(spawn_list, start_planet, p_maldrood, true, false)
        end

        local checkKosh = Find_First_Object("Lancet_Kosh")
        if TestValid(checkKosh) then
            checkKosh.Despawn()
        end

        local start_planet = FindPlanet("Hakassi")
        if start_planet.Get_Owner() == p_empire then
            ChangePlanetOwnerAndRetreat(start_planet, p_maldrood)
            spawn_list = {
                "Imperial_AT_AT_Company",
                "Imperial_AT_AT_Company",
                "Imperial_AT_ST_Company",
                "Imperial_AT_ST_Company",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Generic_Allegiance",
                "Generic_Star_Destroyer_Two",
                "Generic_Star_Destroyer_Two",
                "Generic_Star_Destroyer_Two",
                "Generic_Star_Destroyer_Two",				
                "Generic_Imperial_II_Frigate",	
                "Generic_Imperial_II_Frigate",
                "Generic_Imperial_II_Frigate",					
                "Lancet_Kosh",
                "Strike_Cruiser",
                "Strike_Cruiser",
                "Strike_Cruiser",
                "Strike_Cruiser",				
                "Strike_Cruiser"
            }
            ImperialForces = SpawnList(spawn_list, start_planet, p_maldrood, true, false)
        end

        --Zero Command

        local checkHarrsk = Find_First_Object("Shockwave_Star_Destroyer")
        if TestValid(checkHarrsk) then
            checkHarrsk.Despawn()
        end

        local start_planet = FindPlanet("Kalist")
        if start_planet.Get_Owner() == p_empire then
            ChangePlanetOwnerAndRetreat(start_planet, p_harrsk)
            spawn_list = {
                "Imperial_AT_AT_Company",
                "Imperial_AT_AT_Company",
                "Imperial_AT_ST_Company",
                "Imperial_AT_ST_Company",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Generic_Star_Destroyer_Two",
                "Generic_Star_Destroyer_Two",
                "Generic_Star_Destroyer_Two",
                "Generic_Acclamator_Assault_Ship_I",
                "Generic_Acclamator_Assault_Ship_I",				
                "Victory_II_Frigate",
                "Victory_II_Frigate",				
                "Vigil",
                "Vigil",
                "Shockwave_Star_Destroyer"
            }
            ImperialForces = SpawnList(spawn_list, start_planet, p_harrsk, true, false)
        end

        --Pentastar
        local start_planet = FindPlanet("Entralla")
        if start_planet.Get_Owner() == p_empire then
            ChangePlanetOwnerAndRetreat(start_planet, p_pentastar)
            spawn_list = {
                "Imperial_AT_AT_Company",
                "Imperial_AT_AT_Company",
                "Imperial_AT_ST_Company",
                "Imperial_AT_ST_Company",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Generic_Bellator",
                "Generic_Star_Destroyer_Two",
                "Generic_Star_Destroyer_Two",
                "Generic_Star_Destroyer_Two",
                "Generic_Procursator",
                "Strike_Cruiser",
                "Strike_Cruiser"
            }
            ImperialForces = SpawnList(spawn_list, start_planet, p_pentastar, true, false)
        end

        local start_planet = FindPlanet("Bastion")
        if start_planet.Get_Owner() == p_empire then
            ChangePlanetOwnerAndRetreat(start_planet, p_pentastar)
            spawn_list = {
                "Imperial_AT_AT_Company",
                "Imperial_AT_AT_Company",
                "Imperial_AT_ST_Company",
                "Imperial_AT_ST_Company",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Generic_Bellator",
                "Enforcer",
                "Enforcer",
                "Enforcer",
                "Generic_Procursator",				
                "Generic_Star_Destroyer_Two",
                "Generic_Star_Destroyer_Two",
                "Generic_Star_Destroyer_Two"
            }
            ImperialForces = SpawnList(spawn_list, start_planet, p_pentastar, true, false)
        end

        -- Delvardus

        local checkDelvardus = Find_First_Object("Delvardus_Brilliant")
        if TestValid(checkDelvardus) then
            checkDelvardus.Despawn()
        end

        local start_planet = FindPlanet("Eriadu")
        if start_planet.Get_Owner() == p_empire then
            ChangePlanetOwnerAndRetreat(start_planet, p_eriadu)
            spawn_list = {
                "Imperial_AT_AT_Company",
                "Imperial_AT_AT_Company",
                "Imperial_AT_ST_Company",
                "Imperial_AT_ST_Company",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
				"Torpedo_Sphere",
				"Torpedo_Sphere",
				"Torpedo_Sphere",
                "Generic_Star_Destroyer_Two",
                "Generic_Star_Destroyer_Two",
                "Generic_Star_Destroyer_Two",
                "Generic_Star_Destroyer_Two",
                "Escort_Carrier",
                "Escort_Carrier"
            }
            ImperialForces = SpawnList(spawn_list, start_planet, p_eriadu, true, false)
        end

        local start_planet = FindPlanet("Kampe")
        if start_planet.Get_Owner() == p_empire then
            ChangePlanetOwnerAndRetreat(start_planet, p_eriadu)
            spawn_list = {
                "Imperial_AT_AT_Company",
                "Imperial_AT_AT_Company",
                "Imperial_AT_ST_Company",
                "Imperial_AT_ST_Company",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Imperial_Stormtrooper_Squad",
                "Torpedo_Sphere",
                "Generic_Star_Destroyer_Two",
                "Generic_Star_Destroyer_Two",
                "Generic_Star_Destroyer_Two",
                "Generic_Star_Destroyer_Two",
                "Escort_Carrier",
                "Escort_Carrier",
                "Escort_Carrier",
                "Delvardus_Brilliant",
                "Night_Hammer"
            }
            ImperialForces = SpawnList(spawn_list, start_planet, p_eriadu, true, false)
        end
    end
end

function Luke_Joins(message)
    if message == OnEnter then
        local p_empire = Find_Player("Empire")
        local start_planet = FindPlanet("Byss")

        if not StoryUtil.CheckFriendlyPlanet(start_planet,p_empire) then
            start_planet = StoryUtil.FindFriendlyPlanet(p_empire)
        end

        spawn_list_luke = {"Luke_Skywalker_Darkside_Team"}
        LukeSpawn = SpawnList(spawn_list_luke, start_planet, p_empire, true, false)
    end
end

function Spawn_Balmorrans(message)
    if message == OnEnter then
        local p_empire = Find_Player("Empire")
        local p_balmorra = Find_Player("Warlords")

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
                "X1_Viper_Droid_Company",
                "X1_Viper_Droid_Company",
                "SD_6_Hulk_Infantry_Droid_Company",
                "SD_9_Battle_Droid_Company",
				"SD_9_Battle_Droid_Company",
                "SD_10_Battle_Droid_Company"
            }
            Balmorrans = SpawnList(spawn_list, start_planet, p_balmorra, false, false)
        end
    elseif message == OnUpdate then
    end
end

function Balmorran_Reward(message)
    if message == OnEnter then
        local p_empire = Find_Player("Empire")
        local start_planet = FindPlanet("Balmorra")

        if start_planet.Get_Owner() == Find_Player("Empire") then
            spawn_list_balmorra = {
                "X1_Viper_Droid_Company",
                "X1_Viper_Droid_Company",
                "X1_Viper_Droid_Company"
            }
            BalmorraSpawn = SpawnList(spawn_list_balmorra, start_planet, p_empire, true, false)
        end
    elseif message == OnUpdate then
    end
end

function Noncanonical_Byss_Takeover(message)
    if message == OnEnter then
        local p_rebel = Find_Player("Rebel")
        local start_planet = FindPlanet("Byss")

        --start_planet.Change_Owner(p_rebel)
        ChangePlanetOwnerAndRetreat(start_planet, p_rebel)
        spawn_list_unlikely_conquerors = {"X1_Viper_Droid_Company", "X1_Viper_Droid_Company"}
        BalmorraSpawn = SpawnList(spawn_list_unlikely_conquerors, start_planet, p_rebel, true, false)
    elseif message == OnUpdate then
    end
end
