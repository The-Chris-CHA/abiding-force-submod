require("deepcore/std/class")

---@class EventManager
EventManager = class()

function EventManager:new(galactic_conquest, human_player, planets)
    self.galactic_conquest = galactic_conquest
    self.human_player = human_player
    self.planets = planets

end

function EventManager:update()
    
end

return EventManager
