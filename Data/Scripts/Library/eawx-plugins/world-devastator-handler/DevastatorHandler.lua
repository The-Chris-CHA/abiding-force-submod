--**************************************************************************************************
--*    _______ __                                                                                  *
--*   |_     _|  |--.----.---.-.--.--.--.-----.-----.                                              *
--*     |   | |     |   _|  _  |  |  |  |     |__ --|                                              *
--*     |___| |__|__|__| |___._|________|__|__|_____|                                              *
--*    ______                                                                                      *
--*   |   __ \.-----.--.--.-----.-----.-----.-----.                                                *
--*   |      <|  -__|  |  |  -__|     |  _  |  -__|                                                *
--*   |___|__||_____|\___/|_____|__|__|___  |_____|                                                *
--*                                   |_____|                                                      *
--*                                                                                                *
--*                                                                                                *
--*       File:              DevastatorHandler.lua                                                  *
--*       File Created:      Monday, 2nd March 2020 13:51                                          *
--*       Author:            [TR] Pox                                                              *
--*       Last Modified:     Tuesday, 5th May 2020 01:41                                           *
--*       Modified By:       [TR] Pox                                                              *
--*       Copyright:         Thrawns Revenge Development Team                                      *
--*       License:           This code may not be used without the author's explicit permission    *
--**************************************************************************************************

require("deepcore/std/class")
require("deepcore/crossplot/crossplot")
require("eawx-util/GalacticUtil")
require("eawx-util/UnitUtil")

---@class DevastatorHandler
DevastatorHandler = class()

---@param galactic_display DisplayComponentContainer
function DevastatorHandler:new(galactic_display, gc)
    ---@private
    ---@type NewsFeedDisplayComponent
    self.news_feed = galactic_display:get_component("news_feed")
    self.WinningEmpire = Find_Player("Empire")
    self.Player = Find_Player("local")
    self.ReplaceChance = 5
    self.CurrentDevastator = nil

    self.DevastatorTable ={
        {"KLEV_FRIGATE_DEVASTATOR", "KLEV_CAPITAL_DEVASTATOR", "KLEV_BATTLECRUISER_DEVASTATOR"},
        {"WORLD_DEVASTATOR_FRIGATE", "WORLD_DEVASTATOR_CAPITAL", "WORLD_DEVASTATOR_BATTLECRUISER"}
    }

    for _, devastator_table in pairs(self.DevastatorTable) do
        for _, devastator in pairs(devastator_table) do
            GlobalValue.Set(devastator, 0)
        end
    end

    if Find_Player("EMPIRE").Is_Human() or Find_Player("PENTASTAR").Is_Human() or Find_Player("ERIADU_AUTHORITY").Is_Human() or Find_Player("ZSINJ_EMPIRE").Is_Human() or Find_Player("GREATER_MALDROOD").Is_Human() then
        gc.Events.TacticalBattleEnded:attach_listener(self.on_battle_end, self)
    end

    crossplot:subscribe("IMPERIAL_REMNANT_DECIDED", self.DetermineRemnant, self)

end

function DevastatorHandler:DetermineRemnant()
    --Logger:trace("entering DevastatorHandler:DetermineRemnant")

    local dark_empire = GlobalValue.Get("IMPERIAL_REMNANT")
    
    self.WinningEmpire = Find_Player(dark_empire)
end

function DevastatorHandler:update()
    --Logger:trace("entering DevastatorHandler:update")

    if self.Player ~= self.WinningEmpire then
        local chance = 100
        if self.WinningEmpire.Get_Difficulty() == "Easy" then
            chance = 200
        elseif self.WinningEmpire.Get_Difficulty() == "Hard" then
            chance = 50
        end
    
        if GlobalValue.Get("CRUEL_ON") == 1 then
            chance = chance / 2
        end
    
        local current_devastator = self.CurrentDevastator
        for _, devastator_table in pairs(self.DevastatorTable) do
            for i, devastator in pairs(devastator_table) do
                if i < 3 then
                    if TestValid(Find_First_Object(devastator)) then
                        self.CurrentDevastator = devastator
                        if self.CurrentDevastator == current_devastator then
                            local roll = GameRandom.Free_Random(1, chance)

                            if roll <= self.ReplaceChance then
                                self.ReplaceChance = 5
                                UnitUtil.ReplaceAtLocation(devastator, devastator_table[i+1])
                                GlobalValue.Set(devastator, 0)

                                if i+1 == 3 then
                                    UnitUtil.SpawnAtObjectLocation(devastator_table[i+1], "WORLD_DEVASTATOR_FRIGATE")
                                end
                                break
                            else
                                self.ReplaceChance = self.ReplaceChance + 5
                            end
                        end
                    end
                end
            end
        end
    end
end

function DevastatorHandler:on_battle_end()
    --Logger:trace("entering DevastatorHandler:on_battle_end")

    for _, devastator_table in pairs(self.DevastatorTable) do
        for i, devastator in pairs(devastator_table) do
            if GlobalValue.Get(devastator) >= 100 and i == 1 then
                UnitUtil.ReplaceAtLocation(devastator, devastator_table[i+1])
                GlobalValue.Set(devastator, 0)

                if i+1 == 3 then
                    UnitUtil.SpawnAtObjectLocation(devastator_table[i+1], "WORLD_DEVASTATOR_FRIGATE")
                end

                StoryUtil.ShowScreenText("A World Devastator has upgraded", 15)
                break
            end
            if GlobalValue.Get(devastator) >= 200 and i == 2 then
                UnitUtil.ReplaceAtLocation(devastator, devastator_table[i+1])
                GlobalValue.Set(devastator, 0)

                if i+1 == 3 then
                    UnitUtil.SpawnAtObjectLocation(devastator_table[i+1], "WORLD_DEVASTATOR_FRIGATE")
                end

                StoryUtil.ShowScreenText("A World Devastator has upgraded", 15)
                break
            end
        end
    end
end
