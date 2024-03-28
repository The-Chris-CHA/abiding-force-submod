require("deepcore/std/class")
require("deepcore/crossplot/crossplot")
require("PGStoryMode")

---@class ShipMarket
ShipMarket = class()

function ShipMarket:new(gc)
    self.CSAPlayer = Find_Player("Corporate_Sector")
    self.human_player = Find_Player("local")
	
    self.market_roster = require("eawx-mod-icw/ShipMarketOptions")

    self.shipyard_types = {
        {"CSA_SHIPYARD_LEVEL_ONE", "Planet_Has_Shipyard_One"},
        {"CSA_SHIPYARD_LEVEL_TWO", "Planet_Has_Shipyard_Two"},
        {"CSA_SHIPYARD_LEVEL_THREE", "Planet_Has_Shipyard_Three"},
        {"CSA_SHIPYARD_LEVEL_FOUR", "Planet_Has_Shipyard_Four"}
    }

    self:first_week_setup()

    gc.Events.GalacticProductionStarted:attach_listener(self.on_production_queued, self)
    gc.Events.GalacticProductionCanceled:attach_listener(self.on_production_canceled, self)
    crossplot:subscribe("CSA_TAGGE", self.tagge_handler, self)

    if self.CSAPlayer == self.human_player then
        crossplot:subscribe("UPDATE_GOVERNMENT", self.UpdateDisplay, self)
    end

    self.Events = {}
    self.Events.ShipsAdded = Observable()
end

function ShipMarket:first_week_setup()
    --Logger:trace("entering ShipMarket:first_week_setup")
    for _, ship in pairs(self.market_roster) do
        self.CSAPlayer.Lock_Tech(Find_Object_Type(ship[1]))
    end

    for i, ship in pairs(self.market_roster) do
        if GameRandom(1,1000) <= ship[3] then
            self.market_roster[i][2] = self.market_roster[i][2] + 1       
        end
    end
end

function ShipMarket:Update()
    --Logger:trace("entering ShipMarket:Update")

    for i, ship in pairs(self.market_roster) do
        if GameRandom(1,1000) <= ship[3]  then
            self.market_roster[i][2] = self.market_roster[i][2] + 1
            if self.CSAPlayer.Is_Human() then
                self.Events.ShipsAdded:notify {
                    added = string.gsub(string.gsub(Find_Object_Type(self.market_roster[i][1]).Get_Name(), "_", " "), "GENERIC", "")
                }
            end
        end
    end

    for _ , ship in pairs(self.market_roster) do
        if ship[2] > 0 then
            self.CSAPlayer.Unlock_Tech(Find_Object_Type(ship[1]))
        end
    end
end

function ShipMarket:on_production_queued(planet, game_object_type_name)
    DebugMessage("In ShipMarket:on_production_queued")
    if planet:get_owner() ~= self.CSAPlayer then
        return
    end
    --Logger:trace("entering ShipMarket:on_production_queued")
    for _, ship in pairs(self.market_roster) do
        if ship[1] == game_object_type_name then
            ship[2] = ship[2] - 1 
            if ship[2] < 1 then
                self.CSAPlayer.Lock_Tech(Find_Object_Type(ship[1]))
            end
        end
    end
    
end

function ShipMarket:remove_existing_structure(planet, type)
    --Logger:trace("entering ShipMarket:remove_existing_structure")
    for i, structure in pairs(Find_All_Objects_Of_Type(type)) do
        if structure.Get_Planet_Location() == planet:get_game_object() then
            structure.Despawn()
        end
    end
end

---@param planet Planet
function ShipMarket:on_production_canceled(planet, game_object_type_name)
    DebugMessage("In ShipMarket:on_production_canceled")
    if planet:get_owner() ~= self.CSAPlayer then
        return
    end
    --Logger:trace("entering ShipMarket:on_production_canceled")
    for _, ship in pairs(self.market_roster) do
        if ship[1] == game_object_type_name then
            ship[2] = ship[2] + 1 
            if ship[2] > 0 then
                self.CSAPlayer.Unlock_Tech(Find_Object_Type(ship[1]))
            end
        end
    end
end

function ShipMarket:tagge_handler()
    --Logger:trace("entering ShipMarket:tagge_handler")
    self.market_roster[2][3] = 6
end

function ShipMarket:UpdateDisplay()
    --Logger:trace("entering ShipMarket:UpdateDisplay")
    local plot = Get_Story_Plot("Conquests\\Player_Agnostic_Plot.xml")
    local government_display_event = plot.Get_Event("Government_Display")
    if self.CSAPlayer.Is_Human() then
        government_display_event.Set_Reward_Parameter(1, "CORPORATE_SECTOR")

        government_display_event.Clear_Dialog_Text()

        government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
        government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_CSA")
        government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")

        government_display_event.Add_Dialog_Text("TEXT_NONE")
        
        government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_CSA_OVERVIEW_HEADER")
        government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
        government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_CSA_OVERVIEW")
        government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
        government_display_event.Add_Dialog_Text("TEXT_NONE")
        government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_CSA_LIST_01")
        government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
        for _, ship in pairs(self.market_roster) do
            --if ship[2] ~= 0 then
                government_display_event.Add_Dialog_Text("%s : "..tostring(ship[2]) .." - [ ".. tostring(ship[3]/10) .."%% ]",
                    Find_Object_Type(ship[1]))
            --end
        end

        Story_Event("GOVERNMENT_DISPLAY")
    end
end

return ShipMarket
