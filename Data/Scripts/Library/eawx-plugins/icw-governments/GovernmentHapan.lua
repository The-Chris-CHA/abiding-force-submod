require("deepcore/std/class")
require("deepcore/crossplot/crossplot")
require("PGStoryMode")

StoryUtil = require("eawx-util/StoryUtil")
UnitUtil = require("eawx-util/UnitUtil")

---@class GovernmentHapan
GovernmentHapan = class()

function GovernmentHapan:new(gc, id)
    
    self.HapesPlayer = Find_Player("Hapes_Consortium")
    self.human_player = Find_Player("local")
    self.id = id

    self.house_table ={
        ["ROYAL"] = {
            favour = 0,
            name = "Royal",
            structure = "HOUSE_ROYAL",
            shipyard = "HAPAN_SHIPYARD_ROYAL",
            perception = "Planet_Has_Shipyard_Royal",
            reward_list = {
                {unit = "ROYAL_COMMANDER", cost = 50, limit = 0, built = 0, locked = false},        
                {unit = "ROYAL_COMMANDER_HRG_COMMANDO_COMPANY", cost = 20, limit = 0, built = 0, locked = false},        
            },
            infantry_squad = "ROYAL_INFANTRY_SQUAD"
        },
        ["REQUUD"] = {
            favour = 0,
            name = "Requud",
            structure = "HOUSE_REQUUD",
            shipyard = "HAPAN_SHIPYARD_REQUUD",
            perception = "Planet_Has_Shipyard_Requud",
            reward_list = {
                {unit = "REQUUD_COMMANDER", cost = 50, limit = 0, built = 0, locked = false},        
                {unit = "REQUUD_COMMANDER_FIREDRAGON_COMPANY", cost = 20, limit = 0, built = 0, locked = false},        
            },
            infantry_squad = "REQUUD_INFANTRY_SQUAD"
        },
        ["GALNEY"] = {
            favour = 0,
            name = "Galney",
            structure = "HOUSE_GALNEY",
            shipyard = "HAPAN_SHIPYARD_GALNEY",
            perception = "Planet_Has_Shipyard_Galney",
            reward_list = {
                {unit = "GALNEY_COMMANDER", cost = 50, limit = 0, built = 0, locked = false},        
                {unit = "GALNEY_COMMANDER_HOUSE_GUARD_COMPANY", cost = 20, limit = 0, built = 0, locked = false},        
            },
            infantry_squad = "GALNEY_INFANTRY_SQUAD"
        },
        ["MALURI"] = {
            favour = 0,
            name = "Maluri",
            structure = "HOUSE_MALURI",
            shipyard = "HAPAN_SHIPYARD_MALURI",
            perception = "Planet_Has_Shipyard_Maluri",
            reward_list = {
                {unit = "MALURI_COMMANDER", cost = 50, limit = 0, built = 0, locked = false},        
                {unit = "MALURI_COMMANDER_RANA_COMPANY", cost = 20, limit = 0, built = 0, locked = false},        
            },
            infantry_squad = "MALURI_INFANTRY_SQUAD"
        },
        -- ["ALGRAY"] = {
        --     favour = 0,
        --     name = "AlGray",
        --     structure = "HOUSE_ALGRAY",
        --     shipyard = "HAPAN_SHIPYARD_ALGRAY",
        --     perception = "Planet_Has_Shipyard_AlGray",
        --     space_commander = "ALGRAY_COMMANDER",
		--	   ground_commander = "",
        --     commander_unlocked = false,
        --     infantry_squad = "ALGRAY_INFANTRY_SQUAD"
        -- },
        -- ["CORR"] = {
        --     favour = 0,
        --     name = "Corr",
        --     structure = "HOUSE_CORR",
        --     shipyard = "HAPAN_SHIPYARD_CORR",
        --     perception = "Planet_Has_Shipyard_Corr",
        --     space_commander = "CORR_COMMANDER",
		--	   ground_commander = "",
        --     commander_unlocked = false,
        --     infantry_squad = "CORR_INFANTRY_SQUAD"
        -- },
        -- ["THANE"] = {
        --     favour = 0,
        --     name = "Thane",
        --     structure = "HOUSE_THANE",
        --     shipyard = "HAPAN_SHIPYARD_THANE",
        --     perception = "Planet_Has_Shipyard_Thane",
        --     space_commander = "THANE_COMMANDER",
		--	   ground_commander = "",
        --     commander_unlocked = false,
        --     infantry_squad = "GALNEY_INFANTRY_SQUAD"
        -- },
    }

    gc.Events.GalacticProductionFinished:attach_listener(self.on_production_finished, self)
    gc.Events.GalacticProductionStarted:attach_listener(self.on_production_queued, self)
    gc.Events.GalacticProductionCanceled:attach_listener(self.on_production_canceled, self)

    if self.HapesPlayer == self.human_player then
        crossplot:subscribe("UPDATE_GOVERNMENT", self.UpdateDisplay, self)
    end

    self.Events = {}
    self.Events.SupportReached = Observable()
end

function GovernmentHapan:Update()
    --Logger:trace("entering GovernmentHapan:Update")

    self:CommanderLocks()
end

function GovernmentHapan:CommanderLocks()
    --Logger:trace("entering GovernmentHapan:CommanderLocks")
    for house, house_info in pairs(self.house_table) do
            for i, unit in pairs(house_info.reward_list) do
                if house_info.favour < unit.cost then
                    UnitUtil.SetBuildable(self.HapesPlayer, unit.unit, false)
                    self.house_table[house].reward_list[i].locked = false
                else
                    if unit.limit > 0 and unit.built >= unit.limit then
                        return
                    else
                        UnitUtil.SetBuildable(self.HapesPlayer, unit.unit, true)

                        if self.HapesPlayer == self.human_player then
                            if self.house_table[house].reward_list[i].locked == false then
                                self.Events.SupportReached:notify {
                                    added = house
                                }

                                self.house_table[house].reward_list[i].locked = true
                            end
                        end
                    end
                end
            end
    end
end

function GovernmentHapan:on_production_finished(planet, game_object_type_name)
    DebugMessage("In GovernmentHapan:on_production_finished")
    if planet:get_owner() ~= self.HapesPlayer then
        return
    end
    --Logger:trace("entering GovernmentHapan:on_production_finished")
    for house, house_info in pairs(self.house_table) do
        for i, unit in pairs(house_info.reward_list) do
            if unit.unit == game_object_type_name then
                self.house_table[house].reward_list[i].built = self.house_table[house].reward_list[i].built + 1
            end
        end
        if EvaluatePerception(house_info.perception, self.HapesPlayer, planet:get_game_object()) == 1 then
            self.house_table[house].favour = self.house_table[house].favour + 2
            self:CommanderLocks()
        end
    end

end

function GovernmentHapan:on_production_queued(planet, game_object_type_name)
   
    DebugMessage("In GovernmentHapan:on_production_queued")
    if planet:get_owner() ~= self.HapesPlayer then
        return
    end
    --Logger:trace("entering GovernmentHapan:on_production_queued")
    for house, house_info in pairs(self.house_table) do
        for _, unit in pairs(house_info.reward_list) do
            if unit.unit == game_object_type_name then
                self.house_table[house].favour = self.house_table[house].favour - unit.cost
                self:CommanderLocks()
            end
        end
    end
end

function GovernmentHapan:on_production_canceled(planet, game_object_type_name)
    
    DebugMessage("In GovernmentHapan:on_production_canceled")
    if planet:get_owner() ~= self.HapesPlayer then
        return
    end
    --Logger:trace("entering GovernmentHapan:on_production_canceled")
    for house, house_info in pairs(self.house_table) do
        for _, unit in pairs(house_info.reward_list) do
            if unit.unit == game_object_type_name then
                self.house_table[house].favour = self.house_table[house].favour + unit.cost
                self:CommanderLocks()
            end
        end
    end
end

function GovernmentHapan:remove_existing_structure(planet, type)
    --Logger:trace("entering GovernmentHapan:remove_existing_structure")
    for i, structure in pairs(Find_All_Objects_Of_Type(type)) do
        if structure.Get_Planet_Location() == planet:get_game_object() then
            structure.Despawn()
        end
    end
end

function GovernmentHapan:UpdateDisplay()
    --Logger:trace("entering GovernmentHapan:UpdateDisplay")
    if self.HapesPlayer.Is_Human() then
        local plot = Get_Story_Plot("Conquests\\Player_Agnostic_Plot.xml")
        local government_display_event = plot.Get_Event("Government_Display")

        government_display_event.Set_Reward_Parameter(1, "HAPES_CONSORTIUM")

        government_display_event.Clear_Dialog_Text()

        government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
        government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_HAPAN")
        government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
        government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_HAPAN_DESCRIPTION")

        government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
        government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_HAPAN_LOYALTY_HEADER")
        for house, house_info in pairs(self.house_table) do
            government_display_event.Add_Dialog_Text(
               "- "..house_info.name.." House: "..tostring(house_info.favour)
            )
        end
        government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
	
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_HAPAN_REWARD_HEADER")
		government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
		
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_HAPAN_ROYAL_HEADER")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_HAPAN_ROYAL_REWARD_1")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_HAPAN_ROYAL_REWARD_2")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_HAPAN_ROYAL_REWARD_3")
		
		government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
		
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_HAPAN_REQUUD_HEADER")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_HAPAN_REQUUD_REWARD_1")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_HAPAN_REQUUD_REWARD_2")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_HAPAN_REQUUD_REWARD_3")
		
		government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
		
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_HAPAN_GALNEY_HEADER")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_HAPAN_GALNEY_REWARD_1")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_HAPAN_GALNEY_REWARD_2")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_HAPAN_GALNEY_REWARD_3")
		
		government_display_event.Add_Dialog_Text("TEXT_DOCUMENTATION_BODY_SEPARATOR")
		
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_HAPAN_MALURI_HEADER")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_HAPAN_MALURI_REWARD_1")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_HAPAN_MALURI_REWARD_2")
		government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_HAPAN_MALURI_REWARD_3")

        Story_Event("GOVERNMENT_DISPLAY")
    end
end

return GovernmentHapan