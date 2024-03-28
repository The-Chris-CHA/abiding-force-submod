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
--*       File:              WarlordRespawn.lua                                                     *
--*       File Created:      Monday, 24th February 2020 02:19                                      *
--*       Author:            [TR] Jorritkarwehr                                                             *
--*       Last Modified:     Monday, 24th February 2020 02:34                                      *
--*       Modified By:       [TR] Jorritkarwehr                                                             *
--*       Copyright:         Thrawns Revenge Development Team                                      *
--*       License:           This code may not be used without the author's explicit permission    *
--**************************************************************************************************

require("PGSpawnUnits")
require("deepcore/std/class")
StoryUtil = require("eawx-util/StoryUtil")
require("PGDebug")

WarlordRespawn = class()

function WarlordRespawn:new(herokilled_finished_event, human_player)
    self.human_player = human_player
	self.Active_Planets = StoryUtil.GetSafePlanetTable()
	self.start_planet = nil
    herokilled_finished_event:attach_listener(self.on_galactic_hero_killed, self)
end

function WarlordRespawn:on_galactic_hero_killed(hero_name, owner)
	--Logger:trace("entering WarlordRespawn:on_galactic_hero_killed")
	if hero_name == "THALASSA" then
		if not Find_First_Object("Night_Hammer_Delvardus") then
			local p_eriadu = Find_Player("Eriadu_Authority")

			if self.Active_Planets["KAMPE"] then
				self.start_planet = FindPlanet("Kampe")
				if not StoryUtil.CheckFriendlyPlanet(self.start_planet,p_eriadu) then
					self.start_planet = StoryUtil.FindFriendlyPlanet(p_eriadu)
				end
			else
				self.start_planet = StoryUtil.FindFriendlyPlanet(p_eriadu)
			end
			if self.start_planet then
				SpawnList({"Delvardus_Brilliant"}, self.start_planet, p_eriadu, true, false)
				Story_Event("DELVARDUS_RETURNS")
			end
		end
    elseif hero_name == "13X_TERADOC" then
		if owner == "GREATER_MALDROOD" then
			local p_maldrood = Find_Player("Greater_Maldrood")
			if self.Active_Planets["HAKASSI"] then
				self.start_planet = FindPlanet("Hakassi")
				if not StoryUtil.CheckFriendlyPlanet(self.start_planet,p_maldrood) then
					self.start_planet = StoryUtil.FindFriendlyPlanet(p_maldrood)
				end
			else
				self.start_planet = StoryUtil.FindFriendlyPlanet(p_maldrood)
			end
			if self.start_planet then
				SpawnList({"CrimsonSunrise_Star_Destroyer"}, self.start_planet, p_maldrood, true, false)
				Story_Event("TERADOC_RETURNS")
			end
		end
	elseif hero_name == "TYBER_ZANN_TEAM" then
		if owner == "ZSINJ_EMPIRE" then
			local p_zsinj = Find_Player("Zsinj_Empire")
			if self.Active_Planets["DATHOMIR"] then
				self.start_planet = FindPlanet("Dathomir")
				if not StoryUtil.CheckFriendlyPlanet(self.start_planet,p_zsinj) then
					self.start_planet = StoryUtil.FindFriendlyPlanet(p_zsinj)
				end
			else
				self.start_planet = StoryUtil.FindFriendlyPlanet(p_zsinj)
			end
			if self.start_planet then
				SpawnList({"TYBER_ZANN_TEAM2"}, self.start_planet, p_zsinj, true, false)
				Story_Event("TYBER_ZANN_RETURNS")
			end
		end
    end

end