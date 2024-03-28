require("eawx-util/UnitUtil")
require("PGStoryMode")
require("PGSpawnUnits")

return {
    on_enter = function(self, state_context)

        self.NCMPEvent = false
        self.RepublicEvent = false

        self.entry_time = GetCurrentTime()

        if self.entry_time <= 5 then
		
            UnitUtil.SetLockList("REBEL", {
				"Bulwark_III", 
				"Rebel_Vwing_Group",
				"MC90", "AckbarHO2GV", "NantzIn2FW", 
				"Defense_Trooper_Squad",
				"Jedi_Temple",
				"Jedi_Squad"
			}, false)
			
            UnitUtil.SetLockList("EMPIRE", {
				"Generic_Executor",
				"Generic_Praetor",
				"Eidolon",
				"TaggeCo_HQ",
				"Incom_HQ",
				"SoroSuub_HQ",
				"Imperial_PX10_Company",
				"Imperial_AT_AT_Refit_Company",
                "Imperial_AT_ST_A_Company",
				-- Historical-only units
				"Imperial_Navy_Commando_Squad"
            }, false)
			
			UnitUtil.SetLockList("REBEL", {
				"Wedge_Lusankya"
			})
			
			UnitUtil.SetLockList("EMPIRE", {
				"Imperial_Boarding_Shuttle",
				"Mekuun_HQ",
				"Cygnus_HQ",
				"Ysalamiri_Stormtrooper_Squad",
				"Noghri_Assassin_Squad"
            })
			
			UnitUtil.SetLockList("PENTASTAR", {
				"Merkuni_HQ"
            })

            UnitUtil.SetLockList("ERIADU_AUTHORITY", {
                "TaggeCo_HQ",
                "BrilliantUpgradeEarly"
            }, false)

            UnitUtil.SetLockList("GREATER_MALDROOD", {
                "TaggeCo_HQ"
            }, false)

            UnitUtil.SetLockList("PENTASTAR", {
                "TaggeCo_HQ"
            }, false)

            UnitUtil.SetLockList("ZSINJ_EMPIRE", {
                "TaggeCo_HQ"
            }, false)

		else
			
        end
    end,
    on_update = function(self, state_context)  
    end,
    on_exit = function(self, state_context)
    end
}