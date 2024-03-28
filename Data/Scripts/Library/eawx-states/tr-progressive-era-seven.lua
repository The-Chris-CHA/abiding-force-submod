require("eawx-util/StoryUtil")
require("eawx-util/UnitUtil")
require("PGStoryMode")
require("PGSpawnUnits")
require("eawx-util/ChangeOwnerUtilities")

return {
	on_enter = function(self, state_context)

		GlobalValue.Set("CURRENT_ERA", 7)

		self.LeaderApproach = false
		self.TerrikApproach = false
		self.ResearchFired = false
		
		self.Active_Planets = StoryUtil.GetSafePlanetTable()
		self.entry_time = GetCurrentTime()
		self.plot = Get_Story_Plot("Conquests\\Events\\EventLogRepository.xml")

		Find_Player("Empire").Lock_Tech(Find_Object_Type("Dummy_Regicide_Pellaeon"))

		StoryUtil.SetPlanetRestricted("DOORNIK", 0)
		StoryUtil.SetPlanetRestricted("ZFELL", 0)
		StoryUtil.SetPlanetRestricted("NZOTH", 0)
		StoryUtil.SetPlanetRestricted("JTPTAN", 0)
		StoryUtil.SetPlanetRestricted("POLNEYE", 0)
		StoryUtil.SetPlanetRestricted("PRILDAZ", 0)

		if self.Active_Planets["NZOTH"] then
			Story_Event("GC_BLACK_FLEET_CRISIS")
		end

		if self.entry_time <= 5 then
			self.ResearchFired = true
			if Find_Player("local") == Find_Player("Rebel") then
				StoryUtil.Multimedia("TEXT_CONQUEST_PELLAEON_NR_INTRO_ONE", 15, nil, "Leia_Loop", 0)
				Story_Event("NEWREP_PELLAEON_STARTED")
			elseif Find_Player("local") == Find_Player("Greater_Maldrood") then
				StoryUtil.Multimedia("TEXT_CONQUEST_TERADOC_INTRO_E7", 15, nil, "Kosh_Teradoc_Loop", 0)
				Story_Event("MALDROOD_ERASEVEN_STARTED")
			elseif Find_Player("local") == Find_Player("EmpireoftheHand") then
				StoryUtil.Multimedia("TEXT_CONQUEST_EOTH_INTRO_E7", 15, nil, "Parck_Loop", 0)
				Story_Event("HAND_ERASEVEN_STARTED")
			elseif Find_Player("local") == Find_Player("Hapes_Consortium") then
				StoryUtil.Multimedia("TEXT_CONQUEST_INTRO_TENENIEL_ONE", 15, nil, "Teneniel_Loop2", 0)
				Story_Event("HAPES_TENENIEL_START")
			elseif Find_Player("local") == Find_Player("Corporate_Sector") then
				StoryUtil.Multimedia("TEXT_CONQUEST_INTRO_ODUMIN", 15, nil, "Odumin_Loop", 0)
				Story_Event("CSA_ERAONE_STARTED")
			end

			self.Starting_Spawns = require("eawx-mod-icw/spawn-sets/EraSevenStartSet")
			for faction, herolist in pairs(self.Starting_Spawns) do
				for planet, spawnlist in pairs(herolist) do
					StoryUtil.SpawnAtSafePlanet(planet, Find_Player(faction), self.Active_Planets, spawnlist)  
				end
			end
			
			crossplot:publish("CONQUER_NZOTH", "empty")
			crossplot:publish("CONQUER_MANDALORE_EMPIRE", "empty")
			crossplot:publish("CONQUER_MANDALORE_NR", "empty")

			if self.Active_Planets["BYSS"] then
				Destroy_Planet("Byss")
			end
			if self.Active_Planets["DA_SOOCHA"] then
				Destroy_Planet("Da_Soocha")
			end
			if self.Active_Planets["CARIDA"] then
				Destroy_Planet("Carida")
			end
			if self.Active_Planets["EOLSHA"] then
				Destroy_Planet("EolSha")
			end
			
		else

			self.Starting_Spawns = require("eawx-mod-icw/spawn-sets/EraSevenProgressSet")
			for faction, herolist in pairs(self.Starting_Spawns) do
				for planet, spawnlist in pairs(herolist) do
					StoryUtil.SpawnAtSafePlanet(planet, Find_Player(faction), self.Active_Planets, spawnlist)  
				end
			end
			
			crossplot:publish("CONQUER_NZOTH", "empty")

			crossplot:publish("ERA_SEVEN_TRANSITION", "empty")
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