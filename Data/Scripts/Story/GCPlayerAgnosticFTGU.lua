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
--*   @Date:                2017-11-24T12:43:51+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            GCPlayerAgnostic.lua
--*   @Last modified by:    [TR]Pox
--*   @Last modified time:  2018-03-19T22:04:47+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************

require("PGDebug")
require("PGStateMachine")
require("PGStoryMode")

require("eawx-util/StoryUtil")
require("deepcore/std/deepcore")
require("deepcore-extensions/initialize")

require("eawx-statemachine/dsl/TransitionPolicyFactory")
require("eawx-statemachine/dsl/TransitionEffectBuilderFactory")

function Definitions()
    DebugMessage("%s -- In Definitions", tostring(Script))

    ServiceRate = 0.1

    StoryModeEvents = {Zoom_Zoom = Begin_GC}
end

function Begin_GC(message)
    if message == OnEnter then
        CONSTANTS = ModContentLoader.get("GameConstants")
        GameObjectLibrary = ModContentLoader.get("GameObjectLibrary")
        local plot = StoryUtil.GetPlayerAgnosticPlot()
        StoryUtil.ShowScreenText("TEXT_GUI_INITIALIZING", 10)

        local era = Find_Player("local").Get_Credits()/1000 + 1
   
        local credits = Find_Player("local").Get_Credits()
        

        GlobalValue.Set("CURRENT_ERA", era)
        GlobalValue.Set("REGIME_INDEX", era)

        local year_start = 4
        local month_start = 1 -- Era 1
        if era == 2 then
            year_start = 6
        elseif era == 3 then
            year_start = 9   
        elseif era == 4 then
            year_start = 10
        elseif era == 5 then
            year_start = 11
        elseif era == 6 then
            year_start = 11
            month_start = 6
        elseif era == 7 then
            year_start = 12
        end

        GlobalValue.Set("PROGRESS_REGIME", false)
        
        --local holocron_event = plot.Get_Event("Show_Debug_Display")
        
        --local holocron_sink = require("deepcore/log/sinks/holocron-window")
        --                        :with_event(holocron_event)

        --Logger = require("deepcore/log/logger")
        --        :with_sink(holocron_sink)
        --        :with_log_level(3)

        local plugin_list = ModContentLoader.get("InstalledPlugins")
        local context = {
            plot = plot,
            maxroutes = 5,
            id = "FTGU",
            legitimacy_absorb = 0,
            year_start = year_start,
            dark_empire = false,
            is_generated = false,
            statemachine_dsl_config = {
                transition_policy_factory = EawXTransitionPolicyFactory,
                transition_effect_builder_factory = EawXTransitionEffectBuilderFactory
            }
        }

        ActiveMod = deepcore:galactic {
            context = context,
            plugins = plugin_list,
            plugin_folder = "eawx-plugins",
            planet_factory = function(planet_name)
                local Planet = require("deepcore-extensions/galaxy/Planet")
                return Planet(planet_name)
            end
        }

    elseif message == OnUpdate then
        ActiveMod:update()
    end
end
