--********************************************
--******  Campaign: Final Imperial Push  *****
--********************************************

require("PGDebug")
require("PGStateMachine")
require("PGStoryMode")

require("eawx-util/StoryUtil")
require("deepcore/std/deepcore")
require("deepcore-extensions/initialize")

require("eawx-statemachine/dsl/TransitionPolicyFactory")
require("eawx-statemachine/dsl/TransitionEffectBuilderFactory")
require("SetFighterResearch")

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


        --local holocron_event = plot.Get_Event("Show_Debug_Display")
        
        --local holocron_sink = require("deepcore/log/sinks/holocron-window")
        --                        :with_event(holocron_event)

        --Logger = require("deepcore/log/logger")
        --        :with_sink(holocron_sink)
        --        :with_log_level(3)

        GlobalValue.Set("CURRENT_ERA", 7)
        GlobalValue.Set("REGIME_INDEX", 7)
        GlobalValue.Set("PROGRESS_REGIME", false)

        local plugin_list = ModContentLoader.get("InstalledPlugins")
        local context = {
            plot = plot,
            maxroutes = 4,
            id = "DEFAULT",
            year_start = 17,
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
