require("eawx-util/StoryUtil")
require("eawx-util/UnitUtil")
require("eawx-util/ChangeOwnerUtilities")
require("PGStoryMode")
require("PGSpawnUnits")

return {
	on_enter = function(self, state_context)

		GlobalValue.Set("CURRENT_ERA", 4)

		self.ResearchFired = false

		self.Active_Planets = StoryUtil.GetSafePlanetTable()
		self.entry_time = GetCurrentTime()
		self.plot = Get_Story_Plot("Conquests\\Events\\EventLogRepository.xml")

		StoryUtil.SetPlanetRestricted("DOORNIK", 1)
		StoryUtil.SetPlanetRestricted("ZFELL", 1)
		StoryUtil.SetPlanetRestricted("NZOTH", 1)
		StoryUtil.SetPlanetRestricted("JTPTAN", 1)
		StoryUtil.SetPlanetRestricted("POLNEYE", 1)
		StoryUtil.SetPlanetRestricted("PRILDAZ", 1)

		if self.entry_time <= 5 then
			self.ResearchFired = true
			self.Starting_Spawns = require("eawx-mod-icw/spawn-sets/EraFourStartSet")
			for faction, herolist in pairs(self.Starting_Spawns) do
				for planet, spawnlist in pairs(herolist) do
					StoryUtil.SpawnAtSafePlanet(planet, Find_Player(faction), self.Active_Planets, spawnlist)  
				end
			end

			if Find_Player("local") == Find_Player("Rebel") then
				StoryUtil.Multimedia("TEXT_CONQUEST_PALPATINE_NR_INTRO_TWO", 15, nil, "Mon_Mothma_Loop", 0)
				Story_Event("NEWREP_PALPATINE_STARTED")
			elseif Find_Player("local") == Find_Player("Pentastar") then
				StoryUtil.Multimedia("TEXT_CONQUEST_PENTASTAR_INTRO_E4", 15, nil, "Kaine_Loop", 0)
				Story_Event("PENTASTAR_ERAFOUR_STARTED")
			elseif Find_Player("local") == Find_Player("Eriadu_Authority") then
				StoryUtil.Multimedia("TEXT_CONQUEST_ERIADU_INTRO_E4", 15, nil, "Delvardus_Loop", 0)
				Story_Event("ERIADU_ERAFOUR_STARTED")
			elseif Find_Player("local") == Find_Player("Greater_Maldrood") then
				StoryUtil.Multimedia("TEXT_CONQUEST_TERADOC_INTRO_E4", 15, nil, "Treuten_Teradoc_Loop", 0)
				Story_Event("MALDROOD_ERAFOUR_STARTED")
			elseif Find_Player("local") == Find_Player("EmpireoftheHand") then
				StoryUtil.Multimedia("TEXT_CONQUEST_EOTH_INTRO_E4", 15, nil, "Parck_Loop", 0)
				Story_Event("HAND_ERAFOUR_STARTED")
			elseif Find_Player("local") == Find_Player("Hapes_Consortium") then
				StoryUtil.Multimedia("TEXT_CONQUEST_INTRO_TENENIEL_ONE", 15, nil, "Teneniel_Loop", 0)
				Story_Event("HAPES_TENENIEL_START")
			elseif Find_Player("local") == Find_Player("Corporate_Sector") then
				StoryUtil.Multimedia("TEXT_CONQUEST_INTRO_ODUMIN", 15, nil, "Odumin_Loop", 0)
				Story_Event("CSA_ERAONE_STARTED")
			end
			
			crossplot:publish("CONQUER_MANDALORE_EMPIRE", "empty")
			crossplot:publish("CONQUER_MANDALORE_NR", "empty")
			
		else
			self.Starting_Spawns = require("eawx-mod-icw/spawn-sets/EraFourProgressSet")
			for faction, herolist in pairs(self.Starting_Spawns) do
				for planet, spawnlist in pairs(herolist) do
					StoryUtil.SpawnAtSafePlanet(planet, Find_Player(faction), self.Active_Planets, spawnlist)  
				end
			end

			UnitUtil.ReplaceAtLocation("Home_One", "Galactic_Voyager")

			UnitUtil.DespawnList{
				"Aralani_Frontier",
				"Mon_Mothma"
			}

			crossplot:publish("ERA_FOUR_TRANSITION", "empty")
		end

	end,
	on_update = function(self, state_context)
		local current = GetCurrentTime() - self.entry_time
        if (current >=5) and (self.ResearchFired == true)  then
			self.ResearchFired = false
			crossplot:publish("NCMP_RESEARCH_FINISHED", "empty")
			crossplot:publish("REPUBLIC_RESEARCH_FINISHED", "empty")
		end
	end,
	on_exit = function(self, state_context)
	end
}