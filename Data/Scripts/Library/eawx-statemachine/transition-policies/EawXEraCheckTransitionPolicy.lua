require("deepcore/std/class")

---@class EawXEraCheckTransitionPolicy : EawXTransitionPolicy
EawXEraCheckTransitionPolicy = class()

---@param target_era number
---@param transition_function fun(state_context: table<string, any>)
function EawXEraCheckTransitionPolicy:new(target_era, transition_function)
    ---@private
    self.target_era = target_era

    ---@private
    ---@type number
    self.era_on_enter = nil

    ---@private
    self.transition_function = transition_function or function()
        end
end

---@param state_context table<string, any>
function EawXEraCheckTransitionPolicy:on_origin_entered(state_context)
    self.era_on_enter = Find_Player("Empire").Get_Tech_Level()
end

---@param state_context table<string, any>
function EawXEraCheckTransitionPolicy:should_transition(state_context)
    return Find_Player("Empire").Get_Tech_Level() == self.target_era
end

---@param state_context table<string, any>
function EawXEraCheckTransitionPolicy:on_transition(state_context)
    self.transition_function(state_context)
end