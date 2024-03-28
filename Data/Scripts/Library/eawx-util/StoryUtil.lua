
require("deepcore/crossplot/crossplot")
CONSTANTS = ModContentLoader.get("GameConstants")

StoryUtil = {
    __important = true,
    PlayerAgnosticPlots = {
        Galactic = "Conquests\\Player_Agnostic_Plot.xml",
        Space = "Conquests\\Tactical_Raids.XML",
		Land = "Conquests\\GroundTactical\\Tactical_GroundBattles.XML"
    },
	-- Global Events
	ShowTextEventName = "Show_Screen_Text",
	ShowTextNotificationName = "SHOW_SCREEN_TEXT",

	GenericSpeechEventName = "Template_Generic_Speech",
	GenericSpeechNotificationName = "GENERIC_SPEECH",

	CinematicSpeechEventName = "Template_Cinematic_Speech",
	CinematicSpeechNotificationName = "CINEMATIC_SPEECH",

	MultimediaEventName = "Template_Multimedia",
	MultimediaNotificationName = "MULTIMEDIA",


	GenericEventName = "Template_Generic_Event",
	GenericEventNotificationName = "GENERIC_EVENT",

	SetTechLevelEventName = "Template_Set_Tech_Level",
	SetTechLevelNotificationName = "SET_TECH_LEVEL",

	ChangeAIEventName = "Template_Switch_Control",
	ChangeAINotificationName = "SWITCH_CONTROL",

	PositionCameraEventName = "Template_Position_Camera",
	PositionCameraNotificationName = "POSITION_CAMERA",

	DeclareVictoryEventName = "Template_Victory_Event",
	DeclareVictoryNotificationName = "DECLARE_VICTORY",

	LinkTacticalEventName = "Template_Link_Tactical",
	LinkTacticalNotificationName = "LINK_TACTICAL",

	LoadCampaignEventName = "Template_Load_Campaign",
	LoadCampaignNotificationName = "CAMPAIGN_LOADING",


	-- Galactic Events
	SetTacticalMapEventName = "Template_Set_Tactical_Map",
	SetTacticalMapNotificationName = "SET_TACTICAL_MAP",

	LockPlanetEventName = "Template_Lock_Planet",
	LockPlanetNotificationName = "SET_PLANET_RESTRICTED",

	RevealPlanetEventName = "Template_Reveal_Planet",
	RevealPlanetNotificationName = "REVEAL_PLANET",

	RevealAllPlanetsEventName = "Template_Reveal_All_Planets",
	RevealAllPlanetsNotificationName = "REVEAL_ALL_PLANETS",

	EnableGalacticRevealEventName = "Template_Enable_Galactic_Reveal",
	EnableGalacticRevealNotificationName = "ENABLE_GALACTIC_REVEAL",

	RestrictAutoresolveEventName = "Template_Restrict_Autoresolve",
	RestrictAutoresolveNotificationName = "RESTRICT_AUTORESOLVE",

	EnableInvasionEventName = "Template_Enable_Invasion",
	EnableInvasionNotificationName = "ENABLE_INVASION",

	FlashPlanetEventName = "Template_Flash_Planet",
	FlashPlanetNotificationName = "FLASH_PLANET_GUI",

	GalacticGoalCompleteEventName = "Template_Goal_Complete",
	GalacticGoalCompleteNotificationName = "STORY_GOAL_COMPLETED",

	GalacticGoalRemoveEventName = "Template_Goal_Removed",
	GalacticGoalRemoveNotificationName = "REMOVE_STORY_GOAL",


	-- Tactical Events
	AIActivationEventName = "Template_AI_Activation",
	AIActivationNotificationName = "AI_ACTIVATION",

	DisableRetreatEventName = "Template_Disable_Retreat",
	DisableRetreatNotificationName = "DISABLE_RETREAT",

	VictoryAllowanceEventName = "Template_Victory_Allowance",
	VictoryAllowanceNotificationName = "VICTORY_ALLOWANCE",

	ReinforcementHandlerEventName = "Template_Reinforcement_Handler",
	ReinforcementHandlerNotificationName = "DISABLE_REINFORCEMENTS",

	HideAutoresolveEventName = "Template_Hide_Autoresolve",
	HideAutoresolveNotificationName = "HIDE_AUTORESOLVE",


	ObjectiveSandboxSetEventName = "Template_Objective_Sandbox_Set",
	ObjectiveSandboxSetNotificationName = "OBJECTIVE_SANDBOX_SET",

	ObjectiveCleanUpEventName = "Template_Objective_Clean_Up",
	ObjectiveCleanUpNotificationName = "OBJECTIVE_CLEAN_UP",

	ObjectiveCompleteEventName = "Template_Objective_Complete",
	ObjectiveCompleteNotificationName = "OBJECTIVE_COMPLETE",

	ObjectiveUpdateEventName = "Template_Objective_Update",
	ObjectiveUpdateNotificationName = "OBJECTIVE_UPDATE",

	ObjectiveFailedEventName = "Template_Objective_Failed",
	ObjectiveFailedNotificationName = "OBJECTIVE_FAILED",

	ObjectiveRemoveEventName = "Template_Objective_Remove",
	ObjectiveRemoveNotificationName = "REMOVE_OBJECTIVE",
}

-- Global Events
function StoryUtil.GetPlayerAgnosticPlot()
    local plotName = StoryUtil.PlayerAgnosticPlots[Get_Game_Mode()]
    return Get_Story_Plot(plotName)
end

function StoryUtil.ShowScreenText(textId, time, var, color, teletype)
    local plot = StoryUtil.GetPlayerAgnosticPlot()

    if not plot then
        return
    end

    local screenTextEvent = plot.Get_Event(StoryUtil.ShowTextEventName)

    if not screenTextEvent then
        return
    end

    local colorString = ""
    if color then
        colorString = color.r .. " " .. color.g .. " " .. color.b
    end

    if not var then
        var = ""
    end

    local use_teletype = 1
    if teletype == false then
        use_teletype = 0
    end

    screenTextEvent.Set_Reward_Parameter(0, textId)
    screenTextEvent.Set_Reward_Parameter(1, tostring(time))
    screenTextEvent.Set_Reward_Parameter(2, var)
    screenTextEvent.Set_Reward_Parameter(3, "")
    screenTextEvent.Set_Reward_Parameter(4, use_teletype)
    screenTextEvent.Set_Reward_Parameter(5, colorString)
    Story_Event(StoryUtil.ShowTextNotificationName)
end

function StoryUtil.RemoveScreenText(textId)
    local plot = StoryUtil.GetPlayerAgnosticPlot()

    if not plot then
        return
    end

    local screenTextEvent = plot.Get_Event(StoryUtil.ShowTextEventName)

    if not screenTextEvent then
        return
    end

    screenTextEvent.Set_Reward_Parameter(0, textId)
    screenTextEvent.Set_Reward_Parameter(3, "remove")
    Story_Event(StoryUtil.ShowTextNotificationName)
end

function StoryUtil.PlayGenericSpeech(speechId)
    local plot = StoryUtil.GetPlayerAgnosticPlot()

    if not plot then
        return
    end

    local speechEvent = plot.Get_Event(StoryUtil.GenericSpeechEventName)

    if not speechEvent then
        return
    end

	Stop_All_Speech()
    speechEvent.Set_Reward_Parameter(0, speechId)
    Story_Event(StoryUtil.GenericSpeechNotificationName)
end

function StoryUtil.PlayCinematicSpeech(textId, var, color, teletype, speechId, movie_name, faction)
    local plot = StoryUtil.GetPlayerAgnosticPlot()

    if not plot then
        return
    end

    if faction ~= nil then
        if Find_Player("local") ~= Find_Player(faction) then
            return
        end
    end

    local cinematicSpeechEvent = plot.Get_Event(StoryUtil.CinematicSpeechEventName)

    if not cinematicSpeechEvent then
        return
    end

    local colorString = ""
    if color then
        colorString = color.r .. " " .. color.g .. " " .. color.b
    end

    if not var then
        var = ""
    end

    local use_teletype = 1
    if teletype == false then
        use_teletype = 0
    end

    if speechId == nil then
        speechId = ""
    end

    if movie_name == nil then
        movie_name = ""
    end
    
    cinematicSpeechEvent.Set_Reward_Parameter(0, textId)
    cinematicSpeechEvent.Set_Reward_Parameter(1, -1)
    cinematicSpeechEvent.Set_Reward_Parameter(2, var)
    cinematicSpeechEvent.Set_Reward_Parameter(3, "")
    cinematicSpeechEvent.Set_Reward_Parameter(4, use_teletype)
    cinematicSpeechEvent.Set_Reward_Parameter(5, colorString)
    cinematicSpeechEvent.Set_Reward_Parameter(7, speechId)
    cinematicSpeechEvent.Set_Reward_Parameter(8, movie_name)
    cinematicSpeechEvent.Set_Reward_Parameter(9, 1)

    local cinematicSpeechRemoveEvent = plot.Get_Event("Template_Cinematic_Speech_Remove_Text")
    cinematicSpeechRemoveEvent.Set_Event_Parameter(0, speechId)
    cinematicSpeechRemoveEvent.Set_Reward_Parameter(0, textId)

    Story_Event(StoryUtil.CinematicSpeechNotificationName)
end

function StoryUtil.Multimedia(textId, time, speech_name, movie_name, int, faction, color)
    local plot = StoryUtil.GetPlayerAgnosticPlot()

    if not plot then
        return
    end

    if faction ~= nil then
        if Find_Player("local") ~= Find_Player(faction) then
            return
        end
    end

    local multimediaEvent = plot.Get_Event(StoryUtil.MultimediaEventName)

    if not multimediaEvent then
        return
    end

    local colorString = ""
    if color then
        colorString = color.r .. " " .. color.g .. " " .. color.b
    end

    if speech_name == nil then
        speech_name = ""
    end

    if movie_name == nil then
        movie_name = ""
    end
    
    multimediaEvent.Set_Reward_Parameter(0, textId)
    multimediaEvent.Set_Reward_Parameter(1, tostring(time))
    multimediaEvent.Set_Reward_Parameter(5, colorString)
    multimediaEvent.Set_Reward_Parameter(7, speech_name)
    multimediaEvent.Set_Reward_Parameter(8, movie_name)
    multimediaEvent.Set_Reward_Parameter(9, tostring(int))
    Story_Event(StoryUtil.MultimediaNotificationName)
end


function StoryUtil.GetGenericEvent()
    local plot = StoryUtil.GetPlayerAgnosticPlot()

    if not plot then
        return nil
    end

    return plot.Get_Event(StoryUtil.GenericEventName)
end

function StoryUtil.TriggerGenericEvent()
    Story_Event(StoryUtil.GenericEventNotificationName)
end

function StoryUtil.ResetGenericEvent()
    local plot = StoryUtil.GetPlayerAgnosticPlot()

    if not plot then
        return
    end

    local genericEvent = plot.Get_Event(StoryUtil.GenericEventName)

    if not genericEvent then
        return
    end

    genericEvent.Set_Reward_Type("")
    genericEvent.Set_Reward_Parameter(0, "")
    genericEvent.Set_Reward_Parameter(1, "")
    genericEvent.Set_Reward_Parameter(2, "")
    genericEvent.Set_Reward_Parameter(3, "")
    genericEvent.Set_Reward_Parameter(4, "")
    genericEvent.Set_Reward_Parameter(5, "")
    genericEvent.Set_Reward_Parameter(6, "")
    genericEvent.Set_Reward_Parameter(7, "")
    genericEvent.Set_Reward_Parameter(8, "")
    genericEvent.Set_Reward_Parameter(9, "")
    genericEvent.Set_Reward_Parameter(10, "")
    genericEvent.Set_Reward_Parameter(11, "")
    genericEvent.Set_Reward_Parameter(12, "")
end

function StoryUtil.SetTechLevel(player, level)
    local plot = StoryUtil.GetPlayerAgnosticPlot()

    local player_name = player.Get_Faction_Name()

    if not plot then
        return
    end

    local setTechLevelEvent = plot.Get_Event(StoryUtil.SetTechLevelEventName)

    if not setTechLevelEvent then
        return
    end

    if player_name == "Rebel" then
        level = level - 1
    end

    setTechLevelEvent.Set_Reward_Parameter(0, player_name)
    setTechLevelEvent.Set_Reward_Parameter(1, level)
    Story_Event(StoryUtil.SetTechLevelNotificationName)
end

function StoryUtil.ChangeAIPlayer(player, ai_type)
    local plot = StoryUtil.GetPlayerAgnosticPlot()

    local player_name = player

    if not plot then
        return
    end

    local aiChangeEvent = plot.Get_Event(StoryUtil.ChangeAIEventName)

    if not aiChangeEvent then
        return
    end

    aiChangeEvent.Set_Reward_Parameter(0, player_name)
    aiChangeEvent.Set_Reward_Parameter(1, ai_type)
    Story_Event(StoryUtil.ChangeAINotificationName)
end

function StoryUtil.PositionCamera(planet)
    local plot = StoryUtil.GetPlayerAgnosticPlot()

    if not plot then
        return
    end

    local positionCameraEvent = plot.Get_Event(StoryUtil.PositionCameraEventName)

    if not positionCameraEvent then
        return
    end

    positionCameraEvent.Set_Reward_Parameter(0, planet)
    Story_Event(StoryUtil.PositionCameraNotificationName)
end

function StoryUtil.DeclareVictory(player, play_victory_text)
    local plot = StoryUtil.GetPlayerAgnosticPlot()
    local player_name = nil
    if type(player) == "string" then
        player_name = player
    else
        player_name = player.Get_Faction_Name()
    end

    if not plot then
        return
    end

    local victoryEvent = plot.Get_Event(StoryUtil.DeclareVictoryEventName)

    if not victoryEvent then
        return
    end

    local use_victory_text = 1
    if play_victory_text == false then
        use_victory_text = 0
    end

    victoryEvent.Set_Reward_Parameter(0, player_name)
    victoryEvent.Set_Reward_Parameter(1, use_victory_text)
    Story_Event(StoryUtil.DeclareVictoryNotificationName)
end

function StoryUtil.TriggerScriptedBattle(planet, layer, attacker, defender, is_sandbox, map, battle_plot)
    local plot = StoryUtil.GetPlayerAgnosticPlot()

    if not battle_plot then
        return
    end

    local linkTacticalEvent = plot.Get_Event(StoryUtil.LinkTacticalEventName)

    if not linkTacticalEvent then
        return
    end

	if is_sandbox then
		is_sandbox = 1
	elseif not is_sandbox then
		is_sandbox = 0
	end

    linkTacticalEvent.Set_Reward_Parameter(0, planet)
    linkTacticalEvent.Set_Reward_Parameter(1, layer)
    linkTacticalEvent.Set_Reward_Parameter(2, attacker)
    linkTacticalEvent.Set_Reward_Parameter(3, map)
    linkTacticalEvent.Set_Reward_Parameter(4, defender)
    linkTacticalEvent.Set_Reward_Parameter(6, battle_plot)
    linkTacticalEvent.Set_Reward_Parameter(7, is_sandbox)
    linkTacticalEvent.Set_Reward_Parameter(8, 0)
    linkTacticalEvent.Set_Reward_Parameter(9, 1)
    linkTacticalEvent.Set_Reward_Parameter(10, 1)
    linkTacticalEvent.Set_Reward_Parameter(11, "RETREAT_PLAYER")
    linkTacticalEvent.Set_Reward_Parameter(12, 0)
    linkTacticalEvent.Set_Reward_Parameter(13, 1)
    Story_Event(StoryUtil.LinkTacticalNotificationName)
end

function StoryUtil.LoadCampaign(campaign, player_index)
    local plot = StoryUtil.GetPlayerAgnosticPlot()

    if not plot then
        return
    end

    local loadCampaignEvent = plot.Get_Event(StoryUtil.LoadCampaignEventName)

    if not loadCampaignEvent then
        return
    end

    loadCampaignEvent.Set_Reward_Parameter(0, campaign)
    loadCampaignEvent.Set_Reward_Parameter(1, player_index)
    Story_Event(StoryUtil.LoadCampaignNotificationName)
end

function StoryUtil.ValidGlobalValue(val)
    return val and val ~= ""
end


-- Galactic Events
function StoryUtil.CheckFriendlyPlanet(planet, player, count_neutral_as_friendly)
	if EvaluatePerception("Enemy_Present", player, planet) > 0 then
		return false
	end

	if planet.Get_Owner() == player then
		return true
	end

	if count_neutral_as_friendly then
		if planet.Get_Owner() == Find_Player("Neutral") then
			return true
		end
	end

	return false
end

function StoryUtil.FindFriendlyPlanet(player)
    if type(player) == "string" then
        player = Find_Player(player)
    end

    local allPlanets = FindPlanet.Get_All_Planets()

    local random = 0
    local planet = nil

    while table.getn(allPlanets) > 0 do
        random = GameRandom.Free_Random(1, table.getn(allPlanets))
        planet = allPlanets[random]
        table.remove(allPlanets, random)

        if StoryUtil.CheckFriendlyPlanet(planet, player) then
            return planet
        end
    end

    return nil
end

function StoryUtil.FindEnemyPlanet(player)
    if type(player) == "string" then
        player = Find_Player(player)
    end

    local allPlanets = FindPlanet.Get_All_Planets()

    local random = 0
    local planet = nil

    while table.getn(allPlanets) > 0 do
        random = GameRandom.Free_Random(1, table.getn(allPlanets))
        planet = allPlanets[random]
        table.remove(allPlanets, random)

        if planet.Get_Owner() ~= player and EvaluatePerception("Enemy_Present", planet.Get_Owner(), planet) == 0 then
            return planet
        end
    end

    return nil
end

function StoryUtil.FindTargetPlanet(player, must_be_connected_to_player, allow_fortress_worlds, amount)
	if type(player) == "string" then
		player = Find_Player(player)
	end

	local target_planet_list = {}
	local allPlanets = FindPlanet.Get_All_Planets()

	for _,planet in pairs(allPlanets) do
		local owner = planet.Get_Owner().Get_Faction_Name()
		if owner ~= player.Get_Faction_Name() and owner ~= "NEUTRAL" and EvaluatePerception("Priority_Target", player, planet) == 0 and EvaluatePerception("Is_Owned_By_Enemy", player, planet) == 1 then
			if must_be_connected_to_player then
				if EvaluatePerception("Is_Connected_To_Me", player, planet) == 1 then
					if allow_fortress_worlds then
						table.insert(target_planet_list, planet)
					end
					if not allow_fortress_worlds then
						if EvaluatePerception("Is_Important_Planet", player, planet) == 0 then
							table.insert(target_planet_list, planet)
						end
					end
				end
			end
			if not must_be_connected_to_player then
				if allow_fortress_worlds then
					table.insert(target_planet_list, planet)
				end
				if not allow_fortress_worlds then
					if EvaluatePerception("Is_Important_Planet", player, planet) == 0 then
						table.insert(target_planet_list, planet)
					end
				end
			end
		end
	end
	if table.getn(target_planet_list) == 0 then
		for _,planet in pairs(allPlanets) do
			local owner = planet.Get_Owner().Get_Faction_Name()
			if owner ~= player.Get_Faction_Name() and owner ~= "NEUTRAL" and EvaluatePerception("Priority_Target", player, planet) == 0 and EvaluatePerception("Is_Owned_By_Enemy", player, planet) == 1 then
				table.insert(target_planet_list, planet)
			end
		end
	end

	local planet_counter = table.getn(target_planet_list)

	if amount >= 5 then
		if table.getn(target_planet_list) >= 5 then
			random = GameRandom.Free_Random(1, planet_counter)
			local target01 = target_planet_list[random]
			table.remove(target_planet_list, random)

			random = GameRandom.Free_Random(1, planet_counter)
			local target02 = target_planet_list[random]
			table.remove(target_planet_list, random)

			random = GameRandom.Free_Random(1, planet_counter)
			local target03 = target_planet_list[random]
			table.remove(target_planet_list, random)

			random = GameRandom.Free_Random(1, planet_counter)
			local target04 = target_planet_list[random]
			table.remove(target_planet_list, random)

			random = GameRandom.Free_Random(1, planet_counter)
			local target05 = target_planet_list[random]

			return target01, target02, target03, target04, target05
		end
		if table.getn(target_planet_list) < 5 then
			local amount = 4
		end
	end
	if amount == 4 then
		if table.getn(target_planet_list) >= 4 then
			random = GameRandom.Free_Random(1, planet_counter)
			local target01 = target_planet_list[random]
			table.remove(target_planet_list, random)

			random = GameRandom.Free_Random(1, planet_counter)
			local target02 = target_planet_list[random]
			table.remove(target_planet_list, random)

			random = GameRandom.Free_Random(1, planet_counter)
			local target03 = target_planet_list[random]
			table.remove(target_planet_list, random)

			random = GameRandom.Free_Random(1, planet_counter)
			local target04 = target_planet_list[random]

			return target01, target02, target03, target04
		end
		if table.getn(target_planet_list) < 4 then
			local amount = 3
		end
	end
	if amount == 3 then
		if table.getn(target_planet_list) >= 3 then
			random = GameRandom.Free_Random(1, planet_counter)
			local target01 = target_planet_list[random]
			table.remove(target_planet_list, random)

			random = GameRandom.Free_Random(1, planet_counter)
			local target02 = target_planet_list[random]
			table.remove(target_planet_list, random)

			random = GameRandom.Free_Random(1, planet_counter)
			local target03 = target_planet_list[random]

			return target01, target02, target03
		end
		if table.getn(target_planet_list) < 3 then
			local amount = 2
		end
	end
	if amount == 2 then
		if table.getn(target_planet_list) >= 2 then
			random = GameRandom.Free_Random(1, planet_counter)
			local target01 = target_planet_list[random]
			table.remove(target_planet_list, random)

			random = GameRandom.Free_Random(1, planet_counter)
			local target02 = target_planet_list[random]

			return target01, target02
		end
		if table.getn(target_planet_list) < 2 then
			local amount = 1
		end
	end
	if amount == 1 then
		if table.getn(target_planet_list) >= 1 then
			random = GameRandom.Free_Random(1, planet_counter)
			local target01 = target_planet_list[random]

			return target01
		end
		if table.getn(target_planet_list) < 1 then
			return nil
		end
	end
end

function StoryUtil.SpawnAtSafePlanet(planet_name, player, spawn_location_table, spawn_list, ai_use_set, allow_neutral)
    local player_string = player
    if type(player) == "string" then
        player = Find_Player(player)
    end

    player_string = player.Get_Faction_Name()

    local capital_structure = nil
    local capital_location = nil
    local capital = nil

    if CONSTANTS.ALL_FACTIONS_CAPITALS[player_string] then
        capital = CONSTANTS.ALL_FACTIONS_CAPITALS[player_string].STRUCTURE
        if capital then
            capital_structure = Find_First_Object(capital)
            if capital_structure then
                capital_location = capital_structure.Get_Planet_Location()
            end
        end
    end      

    if spawn_location_table[planet_name] then
        local start_planet = FindPlanet(planet_name)

        if allow_neutral == nil then
            allow_neutral = true
        end
		
        if not StoryUtil.CheckFriendlyPlanet(start_planet, player, allow_neutral) then
            if player == Find_Player("Warlords") or player == Find_Player("Independent_Forces") then
                return nil
            else
                if capital_location ~= nil then
                    start_planet = capital_location
                else
                    start_planet = StoryUtil.FindFriendlyPlanet(player)
                end
            end
        end
		
        local ai_use = true
        if ai_use_set == false then
            ai_use = false
        end

        if start_planet then
            SpawnList(spawn_list, start_planet, player, ai_use, false)
            return start_planet
        else
            DebugMessage(
                "%s -- No spawn planet could be found as alternative for %s!",
                tostring(Script),
                tostring(planet_name)
            )
            return nil
        end
    else
        start_planet = nil
        if capital_location ~= nil then
            start_planet = capital_location
        else
            start_planet = StoryUtil.FindFriendlyPlanet(player)
        end
		
		local ai_use = true
        if ai_use_set == false then
            ai_use = false
        end

        if start_planet then
            SpawnList(spawn_list, start_planet, player, ai_use, false)
            return start_planet
        else
            DebugMessage(
                "%s -- No spawn planet could be found as alternative for %s!",
                tostring(Script),
                tostring(planet_name)
            )
            return nil
        end
    end
end

function StoryUtil.GetSafePlanetTable()
    local Active_Planets = {}
    local all_planets = FindPlanet.Get_All_Planets()

    for _, planet in pairs(all_planets) do
        local name = planet.Get_Type().Get_Name()
        Active_Planets[name] = true
    end

    return Active_Planets
end

function StoryUtil.DebugLog(text)
    local plot = StoryUtil.GetPlayerAgnosticPlot()

    local debugStack = GlobalValue.Get("DEBUG_LOG")

    table.remove(debugStack, 1)
    table.insert(debugStack, text)

    if not plot then
        return
    end

    local debugEvent = plot.Get_Event("Show_Debug_Display")

    if not debugEvent then
        return
    end

    GlobalValue.Set("DEBUG_LOG", debugStack)

    debugEvent.Clear_Dialog_Text()
    for _, entry in pairs(debugStack) do
        debugEvent.Add_Dialog_Text(entry)
    end
end


function StoryUtil.SetTacticalMap(map_name, layer, map_owner)
    local plot = StoryUtil.GetPlayerAgnosticPlot()

    if not plot then
        return
    end

    local setTacticalMapEvent = plot.Get_Event(StoryUtil.SetTacticalMapEventName)

    if not setTacticalMapEvent then
        return
    end

	local map_owner_name = map_owner.Get_Faction_Name()

    setTacticalMapEvent.Set_Reward_Parameter(0, map_name)
    setTacticalMapEvent.Set_Reward_Parameter(1, layer)
    setTacticalMapEvent.Set_Reward_Parameter(1, map_owner_name)
    Story_Event(StoryUtil.SetTacticalMapNotificationName)
end

function StoryUtil.SetPlanetRestricted(planet, status)
    local plot = StoryUtil.GetPlayerAgnosticPlot()

    if not plot then
        return
    end

    local lockPlanetEvent = plot.Get_Event(StoryUtil.LockPlanetEventName)

    if not lockPlanetEvent then
        return
    end

    crossplot:publish("LOCK_PLANET", planet, status)

    lockPlanetEvent.Set_Reward_Parameter(0, planet)
    lockPlanetEvent.Set_Reward_Parameter(1, status)
    Story_Event(StoryUtil.LockPlanetNotificationName)
end

function StoryUtil.RevealPlanet(planet, reveal)
    local plot = StoryUtil.GetPlayerAgnosticPlot()

    if not plot then
        return
    end

    local revealPlanetEvent = plot.Get_Event(StoryUtil.RevealPlanetEventName)

    if not revealPlanetEvent then
        return
    end

    local reveal_planet = 1
    if reveal == false then
        reveal_planet = 0
    end

    revealPlanetEvent.Set_Reward_Parameter(0, planet)
    revealPlanetEvent.Set_Reward_Parameter(1, reveal_planet)
    Story_Event(StoryUtil.RevealPlanetNotificationName)
end

function StoryUtil.RevealAllPlanets()
    local plot = StoryUtil.GetPlayerAgnosticPlot()

    if not plot then
        return
    end

    Story_Event(StoryUtil.RevealAllPlanetsNotificationName)
end

function StoryUtil.EnableGalacticReveal(reveal)
    local plot = StoryUtil.GetPlayerAgnosticPlot()

    if not plot then
        return
    end

    local enableGalacticReveal = plot.Get_Event(StoryUtil.EnableGalacticRevealEventName)

    if not enableGalacticReveal then
        return
    end

    local reveal_planets = 1
    if reveal == false then
        reveal_planets = 0
    end

    enableGalacticReveal.Set_Reward_Parameter(0, reveal_planets)
    Story_Event(StoryUtil.EnableGalacticRevealNotificationName)
end

function StoryUtil.RestrictAutoresolve(planet, allow_autoresolve)
    local plot = StoryUtil.GetPlayerAgnosticPlot()

    if not plot then
        return
    end

    local restrictAutoresolveEvent = plot.Get_Event(StoryUtil.RestrictAutoresolveEventName)

    if not restrictAutoresolveEvent then
        return
    end

    local is_allowed = 1
    if allow_autoresolve == false then
        is_allowed = 0
    end

    restrictAutoresolveEvent.Set_Reward_Parameter(0, planet)
    restrictAutoresolveEvent.Set_Reward_Parameter(1, is_allowed)
    Story_Event(StoryUtil.RestrictAutoresolveNotificationName)
end

function StoryUtil.EnableInvasion(planet, allow_invasion)
    local plot = StoryUtil.GetPlayerAgnosticPlot()

    if not plot then
        return
    end

    local enableInvasionEvent = plot.Get_Event(StoryUtil.EnableInvasionEventName)

    if not enableInvasionEvent then
        return
    end

    local is_allowed = 1
    if allow_invasion == false then
        is_allowed = 0
    end

    enableInvasionEvent.Set_Reward_Parameter(0, planet)
    enableInvasionEvent.Set_Reward_Parameter(1, is_allowed)
    Story_Event(StoryUtil.EnableInvasionNotificationName)
end

function StoryUtil.FlashPlanet(planet, flashId)
    local plot = StoryUtil.GetPlayerAgnosticPlot()

    if not plot then
        return
    end

    local flashPlanetEvent = plot.Get_Event(StoryUtil.FlashPlanetEventName)

    if not flashPlanetEvent then
        return
    end

    flashPlanetEvent.Set_Reward_Parameter(0, planet)
    flashPlanetEvent.Set_Reward_Parameter(1, flashId)
    Story_Event(StoryUtil.FlashPlanetNotificationName)

    local flashPlanetRemoveEvent = plot.Get_Event("Template_Flash_Planet_Remove")
    flashPlanetRemoveEvent.Set_Reward_Parameter(0, flashId)

    Story_Event(StoryUtil.CinematicSpeechNotificationName)
end

function StoryUtil.GalacticGoalComplete(textId)
    local plot = StoryUtil.GetPlayerAgnosticPlot()

    if not plot then
        return
    end

    local galacticGoalCompleteEvent = plot.Get_Event(StoryUtil.GalacticGoalCompleteEventName)

    if not galacticGoalCompleteEvent then
        return
    end

    galacticGoalCompleteEvent.Set_Reward_Parameter(0, textId)
    Story_Event(StoryUtil.GalacticGoalCompleteNotificationName)
end

function StoryUtil.GalacticGoalRemove(textId)
    local plot = StoryUtil.GetPlayerAgnosticPlot()

    if not plot then
        return
    end

    local galacticGoalRemoveEvent = plot.Get_Event(StoryUtil.GalacticGoalRemoveEventName)

    if not galacticGoalRemoveEvent then
        return
    end

    galacticGoalRemoveEvent.Set_Reward_Parameter(0, textId)
    Story_Event(StoryUtil.GalacticGoalRemoveNotificationName)
end


-- Tactical Events
function StoryUtil.Find_Attacking_Player(land_battle, sleep)
	if land_battle then
		local attacker_marker = Find_First_Object("Attacker Entry Position")

		if not TestValid(attacker_marker) then
			return nil
		end

		Sleep(0.5)

		local p_attacker = Find_Nearest(attacker_marker, "Infantry | Vehicle | Air | LandHero")

		if TestValid(p_attacker) and p_attacker.Get_Distance(attacker_marker) < 100 then
			return p_attacker.Get_Owner()
		else
			return nil
		end
	else
		if sleep == true then
			Sleep(5)
		end

		DebugMessage("%s -- Set Attacker", tostring(Script))
		local attacker_marker_list = Find_All_Objects_Of_Type("Attacker Entry Position")

		for _,attacker_marker in pairs(attacker_marker_list) do
			local p_attacker = Find_Nearest(attacker_marker, "SpaceHero | Fighter | Bomber | Transport | Corvette | Frigate | Capital | SuperCapital")
			DebugMessage("%s -- Attacker starting unit %s", tostring(Script), tostring(p_attacker))
			if TestValid(p_attacker) then
				if attacker_marker.Get_Distance(p_attacker) < 4000 then
					DebugMessage("%s -- Set Attacker Marker", tostring(Script))
					return p_attacker.Get_Owner()
				end
			end
		end
	end
end

function StoryUtil.Find_Defending_Player()
    local defending_player = nil
	local defender_marker = Find_First_Object("Defending Forces Position")

	if not TestValid(defender_marker) then
		return nil
	end

	local defending_player = defender_marker.Get_Owner()
	if TestValid(defending_player) then
		return defending_player
	else
		return nil
	end
end

function StoryUtil.SpawnUnitGround(unit, spawn_position, player)
    local player_name = player

	local unit_to_spawn = Find_Object_Type(unit)
	local unit_to_spawn_list = Spawn_Unit(unit_to_spawn, spawn_position, player_name)
	local player_unit_to_spawn = unit_to_spawn_list[1]
	player_unit_to_spawn.Teleport_And_Face(spawn_position)

	if TestValid(player_unit_to_spawn) then
		return player_unit_to_spawn
	else
		return nil
	end
end

function StoryUtil.SpawnUnitSpace(unit, spawn_position, player, hyperspace_duration)
    local player_name = player

	local player_unit_to_spawn = Spawn_Unit(Find_Object_Type("Generic_Praetor"), spawn_position, player_name)
	local player_unit_to_spawn = Find_Nearest(spawn_position, player_name, true)
	player_unit_to_spawn.Teleport_And_Face(spawn_position)
	player_unit_to_spawn.Cinematic_Hyperspace_In(hyperspace_duration)

	if TestValid(player_unit_to_spawn) then
		return player_unit_to_spawn
	else
		return nil
	end
end

function StoryUtil.CinematicEnvironmentOn()
	Allow_Localized_SFX(false)
	SFXManager.Allow_HUD_VO(false)
	SFXManager.Allow_Ambient_VO(false)
	SFXManager.Allow_Enemy_Sighted_VO(false)
	SFXManager.Allow_Unit_Reponse_VO(false)
	Set_Cinematic_Environment(true)
end

function StoryUtil.CinematicEnvironmentOff()
	Allow_Localized_SFX(true)
	SFXManager.Allow_HUD_VO(true)
	SFXManager.Allow_Ambient_VO(true)
	SFXManager.Allow_Enemy_Sighted_VO(true)
	SFXManager.Allow_Unit_Reponse_VO(true)
	Set_Cinematic_Environment(false)
end

function StoryUtil.StartCinematicCamera()
	Start_Cinematic_Camera()
	Stop_All_Music()
	Lock_Controls(1)
	Cancel_Fast_Forward()
	Letter_Box_In(0)
	Remove_All_Text()
	Suspend_AI(1)
	Fade_On()
end

function StoryUtil.EndCinematicCamera(camera_target, duration)
	Point_Camera_At(camera_target)
	Transition_To_Tactical_Camera(duration)
	Letter_Box_Out(duration)
	Suspend_AI(0)
	Lock_Controls(0)
	End_Cinematic_Camera()
end

function StoryUtil.SetCinematicCamera(camera_position, camera_target, follow_target)
    local should_follow = 1
    if follow_target == false then
        should_follow = 0
    end

	Set_Cinematic_Camera_Key(camera_position, 0, 0, 0, 1, 0, 0, 0)
	Set_Cinematic_Target_Key(camera_position, 0, 0, 0, 0, camera_target, should_follow, 0)
end

function StoryUtil.TransitionCinematicCamera(new_camera_position, camera_target, follow_target, duration)
    local should_follow = 1
    if follow_target == false then
        should_follow = 0
    end
	Transition_Cinematic_Camera_Key(new_camera_position, duration, 0, 0, 0, 1, 0, 0, 0)
	Transition_Cinematic_Target_Key(new_camera_position, duration, 0, 0, 0, 0, camera_target, should_follow, 0)
end


function StoryUtil.AIActivation()
    local plot = StoryUtil.GetPlayerAgnosticPlot()

    if not plot then
        return
    end

	if (GlobalValue.Get("CRUEL_ON") == 1) then
        if (GlobalValue.Get("ACTIVE_MOD") == 1) then -- 0 = TR; 1 = FotR; 2 = RevRev
            for _, faction in pairs(CONSTANTS.ALL_FACTIONS_NOT_NEUTRAL) do
                local faction_object = Find_Player(faction)
                if faction_object ~= Find_Player("local") then
                    local faction_name = faction_object.Get_Faction_Name()
                    if faction_name == "REBEL" then
                        local ai_type = CONSTANTS.ALL_FACTIONS_CRUEL_AI_CIS[string.upper(faction)]
                        StoryUtil.ChangeAIPlayer(faction_name, ai_type)
                    else
                        local ai_type = CONSTANTS.ALL_FACTIONS_CRUEL_AI[string.upper(faction)]
                        StoryUtil.ChangeAIPlayer(faction_name, ai_type)
                    end
                end
            end
        else
            for _, faction in pairs(CONSTANTS.ALL_FACTIONS_NOT_NEUTRAL) do
                local faction_object = Find_Player(faction)
                if faction_object ~= Find_Player("local") then
                    local faction_name = faction_object.Get_Faction_Name()
                    local ai_type = CONSTANTS.ALL_FACTIONS_CRUEL_AI[string.upper(faction)]
                    StoryUtil.ChangeAIPlayer(faction_name, ai_type)
                end
            end
        end
	end
	if (GlobalValue.Get("CRUEL_ON") == 0) then
        if (GlobalValue.Get("ACTIVE_MOD") == 1) then -- 0 = TR; 1 = FotR; 2 = RevRev
            for _, faction in pairs(CONSTANTS.ALL_FACTIONS_NOT_NEUTRAL) do
                local faction_object = Find_Player(faction)
                if faction_object ~= Find_Player("local") then
                    local faction_name = faction_object.Get_Faction_Name()
                    if faction_name == "REBEL" then
                        local ai_type = CONSTANTS.ALL_FACTIONS_AI_CIS[string.upper(faction)]
                        StoryUtil.ChangeAIPlayer(faction_name, ai_type)
                    else
                        local ai_type = CONSTANTS.ALL_FACTIONS_AI[string.upper(faction)]
                        StoryUtil.ChangeAIPlayer(faction_name, ai_type)
                    end
                end
            end
        else
            for _, faction in pairs(CONSTANTS.ALL_FACTIONS_NOT_NEUTRAL) do
                local faction_object = Find_Player(faction)
                if faction_object ~= Find_Player("local") then
                    local faction_name = faction_object.Get_Faction_Name()
                    local ai_type = CONSTANTS.ALL_FACTIONS_AI[string.upper(faction)]
                    StoryUtil.ChangeAIPlayer(faction_name, ai_type)
                end
            end
        end
	end
    Story_Event(StoryUtil.AIActivationNotificationName)
end

function StoryUtil.DisableRetreat(player, status)
    local plot = StoryUtil.GetPlayerAgnosticPlot()

    if not plot then
        return
    end

	local player_name = player.Get_Faction_Name()

    local disableRetreatEvent = plot.Get_Event(StoryUtil.DisableRetreatEventName)

    if not disableRetreatEvent then
        return
    end

    local is_disable = 1
    if status == false then
        is_disable = 0
    end

    disableRetreatEvent.Set_Reward_Parameter(0, player_name)
    disableRetreatEvent.Set_Reward_Parameter(1, is_disable)
    Story_Event(StoryUtil.DisableRetreatNotificationName)
end

function StoryUtil.VictoryAllowance(status)
    local plot = StoryUtil.GetPlayerAgnosticPlot()

    if not plot then
        return
    end

    local victoryAllowanceEvent = plot.Get_Event(StoryUtil.VictoryAllowanceEventName)

    if not victoryAllowanceEvent then
        return
    end

    local is_allowed = 1
    if status == false then
        is_allowed = 0
    end

    victoryAllowanceEvent.Set_Reward_Parameter(0, is_allowed)
    Story_Event(StoryUtil.VictoryAllowanceNotificationName)
end

function StoryUtil.ReinforcementHandler(status, player)
    local plot = StoryUtil.GetPlayerAgnosticPlot()

    if not plot then
        return
    end

	if player then
		local player_name = player.Get_Faction_Name()
	end

    if not player then
        player_name = ""
    end

    local reinforcementHandlerEvent = plot.Get_Event(StoryUtil.ReinforcementHandlerEventName)

    if not reinforcementHandlerEvent then
        return
    end

    local is_allowed = 1
    if status == false then
        is_allowed = 0
    end

    reinforcementHandlerEvent.Set_Reward_Parameter(0, is_allowed)
    reinforcementHandlerEvent.Set_Reward_Parameter(1, player_name)
    Story_Event(StoryUtil.ReinforcementHandlerNotificationName)
end

function StoryUtil.HideAutoresolve()
    local plot = StoryUtil.GetPlayerAgnosticPlot()

    if not plot then
        return
    end

    Story_Event(StoryUtil.HideAutoresolveNotificationName)
end


function StoryUtil.SetObjectiveSandboxSet()
    local plot = StoryUtil.GetPlayerAgnosticPlot()

    if not plot then
        return
    end

    Story_Event(StoryUtil.ObjectiveSandboxSetNotificationName)
end

function StoryUtil.SetObjectiveCleanUp()
    local plot = StoryUtil.GetPlayerAgnosticPlot()

    if not plot then
        return
    end

    Story_Event(StoryUtil.ObjectiveCleanUpNotificationName)
end

function StoryUtil.SetObjectiveComplete(textId)
    local plot = StoryUtil.GetPlayerAgnosticPlot()

    if not plot then
        return
    end

    local tacticalObjectiveEvent = plot.Get_Event(StoryUtil.ObjectiveCompleteEventName)

    if not tacticalObjectiveEvent then
        return
    end

    tacticalObjectiveEvent.Set_Reward_Parameter(0, textId)
    Story_Event(StoryUtil.ObjectiveCompleteNotificationName)
end

function StoryUtil.SetObjectiveUpdate(old_textId, new_textID)
    local plot = StoryUtil.GetPlayerAgnosticPlot()

    if not plot then
        return
    end

    local tacticalObjectiveUpdateEvent = plot.Get_Event(StoryUtil.ObjectiveUpdateEventName)

    if not tacticalObjectiveUpdateEvent then
        return
    end

    tacticalObjectiveUpdateEvent.Set_Reward_Parameter(0, old_textId)
    tacticalObjectiveUpdateEvent.Set_Reward_Parameter(1, new_textID)
    Story_Event(StoryUtil.ObjectiveUpdateNotificationName)
end

function StoryUtil.SetObjectiveFailed(textId)
    local plot = StoryUtil.GetPlayerAgnosticPlot()

    if not plot then
        return
    end

    local tacticalObjectiveEvent = plot.Get_Event(StoryUtil.ObjectiveFailedEventName)

    if not tacticalObjectiveEvent then
        return
    end

    tacticalObjectiveEvent.Set_Reward_Parameter(0, textId)
    Story_Event(StoryUtil.ObjectiveFailedNotificationName)
end

function StoryUtil.SetObjectiveRemove(textId)
    local plot = StoryUtil.GetPlayerAgnosticPlot()

    if not plot then
        return
    end

    local tacticalObjectiveEvent = plot.Get_Event(StoryUtil.ObjectiveRemoveEventName)

    if not tacticalObjectiveEvent then
        return
    end

    tacticalObjectiveEvent.Set_Reward_Parameter(0, textId)
    Story_Event(StoryUtil.ObjectiveRemoveNotificationName)
end

return StoryUtil
