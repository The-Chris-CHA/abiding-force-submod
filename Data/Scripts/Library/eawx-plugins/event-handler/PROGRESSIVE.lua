require("deepcore/std/class")
require("eawx-events/GenericResearch")
require("eawx-events/GenericSwap")
require("eawx-events/GenericConquer")
require("eawx-events/TerrikUpgrade")
require("eawx-events/PentastarTalks")


---@class EventManager
EventManager = class()

function EventManager:new(galactic_conquest, human_player, planets)
    self.galactic_conquest = galactic_conquest
    self.human_player = human_player
    self.planets = planets
    self.starting_era = nil

    self.KashyyykConquer = GenericConquer(self.galactic_conquest,
        "CONQUER_KASHYYYK",
        "KASHYYYK", {"Greater_Maldrood"},
        {"Syn_Silooth"}, false, "Syn_Loop")

    self.CentaresConquer = GenericConquer(self.galactic_conquest,
        "CONQUER_CENTARES",
        "CENTARES", {"Zsinj_Empire"},
        {"Selit_Team"}, false)
		
	self.MandaloreConquerEmpire = GenericConquer(self.galactic_conquest,
        "CONQUER_MANDALORE_EMPIRE",
        "MANDALORE", {"Empire", "Greater_Maldrood", "Eriadu_Authority", "Pentastar", "Zsinj_Empire"},
        {"Lorka_Gedyc_Team"}, false, "Boba_Fett_Loop")
		
	self.MandaloreConquerNR = GenericConquer(self.galactic_conquest,
        "CONQUER_MANDALORE_NR",
        "MANDALORE", {"Rebel"},
        {"Fenn_Shysa_Team"}, false, "Boba_Fett_Loop")

    self.NzothConquer = GenericConquer(self.galactic_conquest,
        "CONQUER_NZOTH",
        "NZOTH", {},
        {"EX_F"}, false)

    self.VentureUpgrade = VentureUpgrade(self.galactic_conquest)

    self.PentastarTalks = PentastarTalks(self.galactic_conquest)
    self.PentastarTalksFulfilled = false


end

function EventManager:update()
    
    self.current_time = GetCurrentTime()
    if (self.current_time >= 5) and (self.starting_era == nil) then   
        self.starting_era = GlobalValue.Get("CURRENT_ERA")  
    elseif (self.current_time >= 80) and (self.PentastarTalksFulfilled == false) then
        if self.starting_era == 1 then      
            self.PentastarTalks:fulfill()
            self.PentastarTalksFulfilled = true
        end
    end

end

return EventManager
