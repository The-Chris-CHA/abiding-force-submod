require("deepcore/std/class")

---@class DeepCoreCrossplotTransitionPolicy : DeepCoreTransitionPolicy
DeepCoreCrossplotTransitionPolicy = class()

---@param trigger_identifier string
---@param transition_function fun(state_context: table<string, any>)
function DeepCoreCrossplotTransitionPolicy:new(trigger_identifier, transition_function)
    ---@private
    self.trigger_identifier = string.upper(trigger_identifier)

    ---@private
    self.transition_function = transition_function or function()
        end

    self.trigger_finished = false
    
    crossplot:subscribe("STATE_TRANSITION", self.state_transition_trigger, self)
end

---@param state_context table<string, any>
function DeepCoreCrossplotTransitionPolicy:on_origin_entered(state_context)
end

---@param state_context table<string, any>
function DeepCoreCrossplotTransitionPolicy:should_transition(state_context)
    return self.trigger_finished
end

---@param state_context table<string, any>
function DeepCoreCrossplotTransitionPolicy:on_transition(state_context)
    self.transition_function(state_context)
end

---@param trigger_identifier string
function DeepCoreCrossplotTransitionPolicy:state_transition_trigger(trigger_identifier)
    if trigger_identifier ~= self.trigger_identifier then
        return
    end

    self.trigger_finished = true
end
