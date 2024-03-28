require("eawx-util/UnitUtil")
require("PGStoryMode")
require("PGSpawnUnits")

return {
	on_enter = function(self, state_context)

		self.MediatorEvent = false
		self.ViscountEvent = false
		self.NCMPEvent = false
		self.ThrawnCloneEvent = false

		self.entry_time = GetCurrentTime()

		if self.entry_time <= 5 then

			UnitUtil.SetLockList("REBEL", {
				"Calamari_Cruiser",
				"MC30c",
				"MC40a",
				"Rebel_Infantry_Squad",
				"Rebel_Snowspeeder_Wing",
				"Incom_HQ",
				"Bulwark_III",
				"Quasar", 
				"Liberator_Cruiser",
				"Corellian_Corvette", 
				"Corellian_Gunboat", 
				"Nebulon_B_Frigate", 
				"Nebulon_B_Tender", 
				"Sienar_HQ"
			}, false)

			UnitUtil.SetLockList("EMPIRE", {
				"Eidolon",
				"IPV1_System_Patrol_Craft",
				"Imperial_Boarding_Shuttle",
				"Ysalamiri_Stormtrooper_Squad",
				"Noghri_Assassin_Squad",
				"Imperial_PX10_Company",
				"Imperial_AT_ST_Company",
				"Imperial_AT_AT_Company",
				"Mekuun_HQ",
				"Cygnus_HQ",
				"TaggeCo_HQ",
				-- Historical-only units
				"Imperial_Navy_Commando_Squad"
			}, false)

			UnitUtil.SetLockList("EMPIRE", {
				"Nebulon_B_Empire",
				"Crusader_Gunship",
				"Imperial_Dwarf_Spider_Droid_Company",
				"Imperial_AT_AT_Refit_Company",
				"Imperial_AT_ST_A_Company",
			})


			UnitUtil.SetLockList("REBEL", {
				"Wedge_Lusankya",
				"Candidate_Shesh",
				"Agave_Corvette", 
				"Warrior_Gunship", 
				"Sacheen", 
				"Hajen", 
				"Corona",
				"Belarus",
				"Republic_SD", "SnunbUpgrade", 
				"REC_HQ",
				"Majestic", 
				"Defender_Carrier", 
				"Nebula", "SovvDaunt2VP", 
				"Endurance", "BrandIndomitable2Yald"
			})
			
			UnitUtil.SetLockList("PENTASTAR", {
				"Merkuni_HQ",
				"Adz"
			})
			
			UnitUtil.SetLockList("ZSINJ_EMPIRE", {
				"Adz"
			})
			
			UnitUtil.SetLockList("GREATER_MALDROOD", {
				"Adz"
			})
			
			UnitUtil.SetLockList("ERIADU_AUTHORITY", {
				"Adz"
			})
			
			UnitUtil.SetLockList("CORPORATE_SECTOR", {
				"MTC_Combat",
				"MTC_Support"
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
			
			self.NCMPEvent = true
		else
			
			UnitUtil.SetLockList("REBEL", {
				"Candidate_Shesh",
				"BrandIndomitable2Yald"
			})

		end
	end,
	on_update = function(self, state_context)  
	end,
	on_exit = function(self, state_context)
	end
}