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
--*       File:              Devastator.lua                                                          *
--*       File Created:      Saturday, 7th March 2020 21:42                                        *
--*       Author:            [TR] Pox                                                              *
--*       Last Modified:     Monday, 8th June 2020 08:28                                           *
--*       Modified By:       [TR] Pox                                                              *
--*       Copyright:         Thrawns Revenge Development Team                                      *
--*       License:           This code may not be used without the author's explicit permission    *
--**************************************************************************************************

require("PGCommands")
require("TRCommands")
require("eawx-util/StoryUtil")
require("deepcore/std/class")
require("deepcore/crossplot/crossplot")

---@class Devastator
Devastator = class()

function Devastator:new()
    self.DevastatorID = Object.Get_Type().Get_Name()

    crossplot:subscribe("TACTICAL_UNIT_DESTROYED", self.object_detroyed, self)
end

function Devastator:object_detroyed(object_name, owner_name, killer_name, category)

    if Find_Player(killer_name) ~= Object.Get_Owner() or category == "None" then
        return
    end
        local devastator_material = GlobalValue.Get(self.DevastatorID)
        local added_material = 1
		if category == "STRUCTURE" or category == "SPACESTRUCTURE" then
            added_material = 10
        elseif category == "SUPERCAPITAL" then
            added_material = 50
        elseif category == "SPACEHERO" then
            added_material = 20
        elseif category == "CAPITAL" then
            added_material = 10
        elseif category == "FRIGATE" then
            added_material = 3
        elseif category == "CORVETTE" then
            added_material = 1
        end 

        Object.Attach_Particle_Effect("World_Devastator_Particle")
        
        StoryUtil.ShowScreenText("World Devastator has gained ".. tostring(added_material).. " material for a total of ".. tostring(added_material + devastator_material) , 10)
        
        GlobalValue.Set(self.DevastatorID, devastator_material + added_material)

end

return Devastator
