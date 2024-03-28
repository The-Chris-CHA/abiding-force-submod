require("eawx-util/UnitUtil")
require("PGStoryMode")
require("PGSpawnUnits")

return {
    on_enter = function(self, state_context)

        self.entry_time = GetCurrentTime()

        if self.entry_time <= 5 then

            UnitUtil.SetLockList("REBEL", {
				"Bulwark_III",
				"Republic_SD", 
				"MC90", "AckbarHO2GV", "NantzIn2FW", 
				"Defense_Trooper_Squad",
				"Rebel_Vwing_Group",
				"Jedi_Temple",
				"Jedi_Squad"
			}, false)
			
			UnitUtil.SetLockList("EMPIRE", {
				"Generic_Praetor",
				"Eidolon",
				"Imperial_Boarding_Shuttle",
				"TaggeCo_HQ",
				"Incom_HQ",
				"SoroSuub_HQ",
				"Mekuun_HQ",
				"Cygnus_HQ",
				"Imperial_PX10_Company",
				"Imperial_AT_AT_Refit_Company",
                "Imperial_AT_ST_A_Company",
				-- Historical-only units
				"Imperial_Navy_Commando_Squad"
            }, false)
			
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