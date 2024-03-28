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
--*       File:              MissionDistributor.lua                                                *
--*       File Created:      Wednesday, 25th December 2019 12:39                                   *
--*       Author:            [TR] Pox                                                              *
--*       Last Modified:     Friday, 21st February 2020 10:17                                      *
--*       Modified By:       [TR] Pox                                                              *
--*       Copyright:         Thrawns Revenge Development Team                                      *
--*       License:           This code may not be used without the author's explicit permission    *
--**************************************************************************************************

require("deepcore/std/class")

---@class MissionDistributor
MissionDistributor = class()

function MissionDistributor:new(player_agnostic_plot)
    self.newRepublic = Find_Player("Rebel")
    self.empire = Find_Player("Empire")
end

function MissionDistributor:Assign()
    -- if self.republic.Is_Human() then
    --     self.RepMissions:Assign()
    -- elseif self.cis.Is_Human() then
    --     self.CISMissions:Assign()
    -- end
end

return MissionDistributor
