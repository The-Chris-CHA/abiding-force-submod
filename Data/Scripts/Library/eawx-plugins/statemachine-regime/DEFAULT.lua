require("eawx-statemachine/EawXState")

---@param dsl dsl
return function(dsl)
    local policy = dsl.policy
    local effect = dsl.effect
    local owned_by = dsl.conditions.owned_by

    local initialize = EawXState.with_empty_policy()
      
    return initialize
end