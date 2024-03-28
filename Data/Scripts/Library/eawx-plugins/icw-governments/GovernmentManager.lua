require("deepcore/std/class")
require("eawx-plugins/icw-governments/GovernmentNewRepublic")
require("eawx-plugins/icw-governments/GovernmentEmpire")
require("eawx-plugins/icw-governments/GovernmentHapan")
require("eawx-plugins/icw-governments/ShipMarket")

---@class GovernmentManager
GovernmentManager = class()

---@param dummy_lifecycle_handler KeyDummyLifeCycleHandler
function GovernmentManager:new(gc, absorb, dark_empire, id, dummy_lifecycle_handler)
    self.NRGOV = GovernmentNewRepublic(id, dummy_lifecycle_handler)
    self.EMPIREGOV = GovernmentEmpire(gc, absorb, dark_empire, id)
    self.SHIPMARKET = ShipMarket(gc)
    self.HAPGOV = GovernmentHapan(gc, id)
end

function GovernmentManager:update()
    self.NRGOV:Update()
    self.EMPIREGOV:Update()
    self.SHIPMARKET:Update()
    self.HAPGOV:Update()
end

return GovernmentManager
