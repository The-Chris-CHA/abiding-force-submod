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
--*       File:              RepublicHeroes.lua                                                     *
--*       File Created:      Monday, 24th February 2020 02:19                                      *
--*       Author:            [TR] Jorritkarwehr                                                             *
--*       Last Modified:     Monday, 24th February 2020 02:34                                      *
--*       Modified By:       [TR] Jorritkarwehr                                                             *
--*       Copyright:         Thrawns Revenge Development Team                                      *
--*       License:           This code may not be used without the author's explicit permission    *
--**************************************************************************************************

require("PGStoryMode")
require("PGSpawnUnits")
require("deepcore/std/class")
require("eawx-util/StoryUtil")
require("HeroSystem")

RepublicHeroes = class()

function RepublicHeroes:new(gc, herokilled_finished_event, human_player)
	self.human_player = human_player
	gc.Events.GalacticProductionFinished:attach_listener(self.on_production_finished, self)
	herokilled_finished_event:attach_listener(self.on_galactic_hero_killed, self)
	self.inited = false
	self.NJOspeech = false
	self.NJOinit = false
	
	crossplot:subscribe("NR_ADMIRAL_DECREMENT", self.admiral_decrement, self)
	crossplot:subscribe("NR_ADMIRAL_LOCKIN", self.admiral_lockin, self)
	crossplot:subscribe("NR_ADMIRAL_EXIT", self.admiral_exit, self)
	crossplot:subscribe("NR_ADMIRAL_STORYLOCK", self.admiral_storylock, self)
	crossplot:subscribe("NR_ADMIRAL_RETURN", self.admiral_return, self)
	
	crossplot:subscribe("ERA_THREE_TRANSITION", self.Era_3, self)
	crossplot:subscribe("ERA_FOUR_TRANSITION", self.Era_4, self)
	crossplot:subscribe("ERA_SEVEN_TRANSITION", self.Era_7, self)
	
	crossplot:subscribe("NCMP2_HEROES", self.NCMP2_handler, self)
	crossplot:subscribe("BAC_HEROES", self.Bothan_Heroes, self)
	crossplot:subscribe("MEDIATOR_HEROES", self.Mediator_Heroes, self)
	
	crossplot:subscribe("NJO_CREATED", self.New_Jedi_Order_Init, self)
	crossplot:subscribe("NR_CANON_ADMIRALS", self.Canon_Heroes, self)
	
	admiral_data = {
		total_slots = 4,			--Max slot number. Set at the start of the GC and never change
		free_hero_slots = 4,		--Slots open to buy
		vacant_hero_slots = 0,	    --Slots that need another action to move to free
		vacant_limit = 5,           --Number of times a lost slot can be reopened
		initialized = false,
		full_list = { --All options for reference operations
			["Ackbar"] = {"ACKBAR_ASSIGN",{"ACKBAR_RETIRE","ACKBAR_RETIRE2"},{"HOME_ONE","GALACTIC_VOYAGER"},"TEXT_UNIT_GALACTIC_VOYAGER"},
			["Nantz"] = {"NANTZ_ASSIGN",{"NANTZ_RETIRE","NANTZ_RETIRE2"},{"NANTZ_INDEPENDENCE","NANTZ_FAITHFUL_WATCHMAN"},"TEXT_UNIT_NANTZ"},
			["Sovv"] = {"SOVV_ASSIGN",{"SOVV_RETIRE","SOVV_RETIRE2"},{"SOVV_DAUNTLESS","SOVV_VOICE_OF_THE_PEOPLE"},"TEXT_UNIT_SOVV"},
			["Solo"] = {"SOLO_ASSIGN",{"SOLO_RETIRE"},{"SOLO_REMONDA"},"TEXT_HERO_HAN_SOLO",["no_random"] = true, ["required_unit"] = "MILLENNIUM_FALCON", ["required_team"] = "HAN_SOLO_TEAM"},
			["Han"] = {"HAN_ASSIGN",{"HAN_RETIRE"},{"HAN_INTREPID"},"TEXT_HERO_HAN_SOLO",["no_random"] = true, ["required_unit"] = "MILLENNIUM_FALCON", ["required_team"] = "HAN_SOLO_TEAM"}, --Han's forms are so separate that it's easier to handle them separately
			["Iblis"] = {"IBLIS_ASSIGN",{"IBLIS_RETIRE","IBLIS_RETIRE2","IBLIS_RETIRE3","IBLIS_RETIRE4"},{"IBLIS_PEREGRINE","IBLIS_SELONIAN_FIRE","IBLIS_BAIL_ORGANA","IBLIS_HARBINGER"},"TEXT_HERO_GARM"},
			["Drayson"] = {"DRAYSON_ASSIGN",{"DRAYSON_RETIRE","DRAYSON_RETIRE2"},{"DRAYSON_TRUE_FIDELITY","DRAYSON_NEW_HOPE"},"TEXT_HERO_DRAYSON"},
			["Ragab"] = {"RAGAB_ASSIGN",{"RAGAB_RETIRE"},{"RAGAB_EMANCIPATOR"},"TEXT_HERO_RAGAB"},
			["Kalback"] = {"KALBACK_ASSIGN",{"KALBACK_RETIRE"},{"KALBACK_JUSTICE"},"TEXT_HERO_KALBACK"},
			["Tallon"] = {"TALLON_ASSIGN",{"TALLON_RETIRE"},{"TALLON_SILENT_WATER"},"TEXT_HERO_TALLON"},
			["Vantai"] = {"VANTAI_ASSIGN",{"VANTAI_RETIRE"},{"VANTAI_MOONSHADOW"},"TEXT_HERO_VANTAI"},
			["Brand"] = {"BRAND_ASSIGN",{"BRAND_RETIRE","BRAND_RETIRE2"},{"BRAND_INDOMITABLE","BRAND_YALD"},"TEXT_HERO_BRAND"},
			["Bell"] = {"BELL_ASSIGN",{"BELL_RETIRE"},{"BELL_ENDURANCE"},"TEXT_HERO_BELL"},
			["Abaht"] = {"ABAHT_ASSIGN",{"ABAHT_RETIRE"},{"ABAHT_INTREPID"},"TEXT_HERO_ABAHT"},
			["Nammo"] = {"NAMMO_ASSIGN",{"NAMMO_RETIRE"},{"NAMMO_DEFIANCE"},"TEXT_HERO_NAMMO"},
			["Krefey"] = {"KREFEY_ASSIGN",{"KREFEY_RETIRE"},{"KREFEY_RALROOST"},"TEXT_HERO_KREFEY"},
			["Snunb"] = {"SNUNB_ASSIGN",{"SNUNB_RETIRE","SNUNB_RETIRE2"},{"SNUNB_ANTARES_SIX","SNUNB_RESOLVE"},"TEXT_HERO_SNUNB"},
			["Ackdool"] = {"ACKDOOL_ASSIGN",{"ACKDOOL_RETIRE"},{"ACKDOOL_MEDIATOR"},"TEXT_HERO_ACKDOOL"},
			["Burke"] = {"BURKE_ASSIGN",{"BURKE_RETIRE"},{"BURKE_REMEMBER_ALDERAAN"},"TEXT_HERO_BURKE"},
			["Massa"] = {"MASSA_ASSIGN",{"MASSA_RETIRE","MASSA_RETIRE2"},{"MASSA_LUCREHULK_AUXILIARY","MASSA_LUCREHULK_CARRIER"},"TEXT_HERO_MASSA"},
			["Dorat"] = {"DORAT_ASSIGN",{"DORAT_RETIRE"},{"DORAT_ARROW_OF_SULLUST"},"TEXT_HERO_DORAT"},
			["Grant"] = {"GRANT_ASSIGN",{"GRANT_RETIRE"},{"GRANT_ORIFLAMME"},"TEXT_HERO_GRANT"},
			["Lando"] = {"LANDO_ASSIGN",{"LANDO_RETIRE","LANDO_RETIRE2"},{"LANDO_LIBERATOR","LANDO_ALLEGIANCE"},"TEXT_HERO_LANDO",["no_random"] = true, ["required_unit"] = "LANDO_CALRISSIAN", ["required_team"] = "LANDO_CALRISSIAN_TEAM"},
			["Raddus"] = {"RADDUS_ASSIGN",{"RADDUS_RETIRE"},{"RADDUS_PROFUNDITY"},"TEXT_HERO_RADDUS"},
			["Hera"] = {"HERA_ASSIGN",{"HERA_RETIRE"},{"HERA_STARHAWK"},"TEXT_HERO_HERA"},
		},
		available_list = {--Heroes currently available for purchase. Seeded with those who have no special prereqs
			"Ackbar",
			"Nantz",
			"Sovv",
			"Solo",
			"Drayson",
			"Ragab",
			"Kalback",
			"Tallon",
			"Vantai",
			"Snunb",
			"Burke",
			"Massa",
			"Lando",
		},
		story_locked_list = {--Heroes not accessible, but able to return with the right conditions
			["Dorat"] = true
		},
		active_player = Find_Player("Rebel"),
		extra_name = "EXTRA_ADMIRAL_SLOT",
		random_name = "RANDOM_ASSIGN",
		global_display_list = "NR_ADMIRAL_LIST", --Name of global array used for documention of currently active heroes
		disabled = false
	}
	
	council_data = {
		total_slots = 1,			--Max slot number. Set at the start of the GC and never change
		free_hero_slots = 1,		--Slots open to buy
		vacant_hero_slots = 0,	    --Slots that need another action to move to free
		vacant_limit = 1,           --Number of times a lost slot can be reopened
		initialized = false,
		full_list = { --All options for reference operations
			["Corran"] = {"CORRAN_ASSIGN",{"CORRAN_RETIRE"},{"CORRAN_HORN"},"TEXT_HERO_CORRAN_HORN", ["Companies"] = {"CORRAN_HORN_TEAM"}},
			["Kyle"] = {"KYLE_ASSIGN",{"KYLE_RETIRE"},{"KYLE_KATARN"},"TEXT_HERO_KYLE_KATARN", ["Companies"] = {"KATARN_TEAM"}},
			["Mara"] = {"MARA_ASSIGN",{"MARA_RETIRE"},{"MARA_JADE_LIGHTSABER"},"TEXT_HERO_MARA_JADE", ["Companies"] = {"MARA_SABER_TEAM"}},
			["Cilghal"] = {"CILGHAL_ASSIGN",{"CILGHAL_RETIRE"},{"CILGHAL"},"TEXT_HERO_CILGHAL", ["Companies"] = {"CILGHAL_TEAM"}},
		},
		available_list = {--Heroes currently available for purchase. Seeded with those who have no special prereqs
			"Kyle",
		},
		story_locked_list = {},--Heroes not accessible, but able to return with the right conditions
		active_player = Find_Player("Rebel"),
		extra_name = "EXTRA_COUNCIL_SLOT",
		random_name = "RANDOM_COUNCIL_ASSIGN",
		global_display_list = "NR_JEDI_LIST", --Name of global array used for documention of currently active heroes
		disabled = true
	}
	
	viewers = {
		["VIEW_ADMIRALS"] = 1,
		["VIEW_COUNCIL"] = 2,
	}
	
	old_view = 1
	
	Krefey_Checks = 0
end

function RepublicHeroes:on_production_finished(planet, object_type_name)--object_type_name, owner)
	--Logger:trace("entering RepublicHeroes:on_production_finished")
	if not self.inited then
		self.inited = true
		self:init_heroes()
		local temp = Find_First_Object("Jedi_Temple")
		if TestValid(temp) then
			self:New_Jedi_Order()
		end
	end
	if object_type_name == "DORAT_MASSA" then
		Handle_Hero_Exit("Dorat", admiral_data, true)
		Handle_Hero_Add("Massa", admiral_data)
	elseif object_type_name == "MASSA_DORAT" or object_type_name == "MASSA_DORAT2" then
		Handle_Hero_Exit("Massa", admiral_data, true)
		Handle_Hero_Add("Dorat", admiral_data)
	elseif object_type_name == "JEDI_TEMPLE" then
		self:New_Jedi_Order()
	else
		if viewers[object_type_name] and admiral_data.active_player.Is_Human() then
			switch_views(viewers[object_type_name])
			local viewer = Find_First_Object(object_type_name)
			if TestValid(viewer) then
				viewer.Despawn()
			end
		end
		Handle_Build_Options(object_type_name, admiral_data)
		Handle_Build_Options(object_type_name, council_data)
		if object_type_name == "HAN_ASSIGN" then
			Handle_Hero_Exit("Abaht", admiral_data)
			if admiral_data.active_player.Is_Human() then
				Story_Event("HAN_INTREPID_SPEECH")
			end
		elseif object_type_name == "HAN_RETIRE" then
			Handle_Hero_Add("Abaht", admiral_data)
		end
	end
end

function switch_views(new_view)
	--Logger:trace("entering RepublicHeroes:switch_views")
	
	local tech_unit
	
	if new_view == 1 then
		tech_unit = Find_Object_Type("VIEW_ADMIRALS")
		admiral_data.active_player.Lock_Tech(tech_unit)
		Enable_Hero_Options(admiral_data)
	end
	if new_view == 2 then
		tech_unit = Find_Object_Type("VIEW_COUNCIL")
		admiral_data.active_player.Lock_Tech(tech_unit)
		Enable_Hero_Options(council_data)
	end
	
	if old_view == 1 and admiral_data.vacant_limit > -1 and admiral_data.vacant_hero_slots < admiral_data.total_slots then
		tech_unit = Find_Object_Type("VIEW_ADMIRALS")
		admiral_data.active_player.Unlock_Tech(tech_unit)
		Disable_Hero_Options(admiral_data)
	end
	if old_view == 2 and council_data.vacant_limit > -1 and council_data.vacant_hero_slots < council_data.total_slots then
		tech_unit = Find_Object_Type("VIEW_COUNCIL")
		admiral_data.active_player.Unlock_Tech(tech_unit)
		Disable_Hero_Options(council_data)
	end
	
	old_view = new_view
end

function RepublicHeroes:init_heroes()
	--Logger:trace("entering RepublicHeroes:init_heroes")
	init_hero_system(admiral_data)
	init_hero_system(council_data)
	
	local tech_level = GlobalValue.Get("CURRENT_ERA")
	
	--Handle special actions for starting tech level
	if tech_level >= 2 then
		Handle_Hero_Exit("Kalback", admiral_data)
		Handle_Hero_Exit("Massa", admiral_data)
		Handle_Hero_Add("Dorat", admiral_data)
		local assign_unit = Find_Object_Type("DORAT_MASSA")
		admiral_data.active_player.Lock_Tech(assign_unit)
	end
	
	if tech_level >= 3 then
		Handle_Hero_Add("Iblis", admiral_data)
	end
	
	if tech_level >= 4 then
		Handle_Hero_Exit("Solo", admiral_data)
		Handle_Hero_Add("Grant", admiral_data)
		local assign_unit = Find_Object_Type("GRANT_RETIRE") --Starts locked as to not be there when PA Grant is attacking
		admiral_data.active_player.Unlock_Tech(assign_unit)
	end
	
	if tech_level >= 5 then
		Handle_Hero_Exit("Ragab", admiral_data)
		set_unit_index("Lando", 2, admiral_data)
	end
	
	if tech_level >= 7 then
		Handle_Hero_Add("Brand", admiral_data)
		Handle_Hero_Add("Abaht", admiral_data)
		Handle_Hero_Add("Han", admiral_data)
		Handle_Hero_Add("Bell", admiral_data)
		Krefey_Check()
		self:New_Jedi_Order()
		
		admiral_data.total_slots = admiral_data.total_slots + 1
		admiral_data.free_hero_slots = admiral_data.free_hero_slots + 1
		Unlock_Hero_Options(admiral_data)
	end
end

function RepublicHeroes:admiral_decrement(quantity, set)
	--Logger:trace("entering RepublicHeroes:admiral_decrement")
	if set == 1 then
		Decrement_Hero_Amount(quantity, admiral_data)
	end
	if set == 2 then
		Decrement_Hero_Amount(quantity, council_data)
	end
end

function RepublicHeroes:admiral_lockin(list, set)
	--Logger:trace("entering RepublicHeroes:admiral_lockin")
	if set == 1 then
		lock_retires(list, admiral_data)
	end
	if set == 2 then
		lock_retires(list, council_data)
	end
end

function RepublicHeroes:admiral_storylock(list, set)
	--Logger:trace("entering RepublicHeroes:admiral_storylock")
	if set == 1 then
		for _, tag in pairs(list) do
			Handle_Hero_Exit(tag, admiral_data, true)
		end
	end
	if set == 2 then
		for _, tag in pairs(list) do
			Handle_Hero_Exit(tag, council_data, true)
		end
	end
end

function RepublicHeroes:admiral_exit(list, set)
	--Logger:trace("entering RepublicHeroes:admiral_exit")
	if set == 1 then
		for _, tag in pairs(list) do
			Handle_Hero_Exit(tag, admiral_data)
		end
	end
	if set == 2 then
		for _, tag in pairs(list) do
			Handle_Hero_Exit(tag, council_data)
		end
	end
end

function RepublicHeroes:admiral_return(list, set)
	--Logger:trace("entering RepublicHeroes:admiral_return")
	if set == 1 then
		for _, tag in pairs(list) do
			if check_hero_exists(tag, admiral_data) then
				Handle_Hero_Add(tag, admiral_data)
			end
		end
	end
	if set == 2 then
		for _, tag in pairs(list) do
			if check_hero_exists(tag, council_data) then
				Handle_Hero_Add(tag, council_data)
			end
		end
	end
end

function RepublicHeroes:on_galactic_hero_killed(hero_name, owner)
	--Logger:trace("entering RepublicHeroes:on_galactic_hero_killed")
	if hero_name == "YSANNE_ISARD_TEAM" or hero_name == "LUSANKYA" or hero_name == "LUSANKYA_NO_TRANSITION" then
		Find_Player("Rebel").Unlock_Tech(Find_Object_Type("Wedge_Lusankya"))
		if admiral_data.active_player.Is_Human() then
			Story_Event("WEDGE_SPEECH")
		end
	end
	if hero_name == "CHIMERA" then
		if Handle_Hero_Exit("Kalback", admiral_data) then
			if admiral_data.active_player.Is_Human() then
				Story_Event("KALBACK_SPEECH")
			end
		end
	end
	local tag = Handle_Hero_Killed(hero_name, owner, admiral_data)
	if tag == "Ackbar" then
		if not check_hero_exists("Ackbar", admiral_data) then
			Handle_Hero_Add("Nammo", admiral_data)
		end
	elseif tag == "Massa" then
		local assign_unit = Find_Object_Type("DORAT_MASSA")
		admiral_data.active_player.Lock_Tech(assign_unit)
		
		if check_hero_exists("Dorat", admiral_data) then
			Handle_Hero_Add("Dorat", admiral_data)
		end
	elseif tag == "Dorat" then
		local assign_unit = Find_Object_Type("MASSA_DORAT")
		admiral_data.active_player.Lock_Tech(assign_unit)
		local assign_unit = Find_Object_Type("MASSA_DORAT2")
		admiral_data.active_player.Lock_Tech(assign_unit)
		
		if check_hero_exists("Massa", admiral_data) then
			Handle_Hero_Add("Massa", admiral_data)
		end
	elseif tag == "Han" or tag == "Solo" then
		local planet = StoryUtil.FindFriendlyPlanet(admiral_data.active_player)
		SpawnList({"Han_Solo_Team"}, planet, admiral_data.active_player, true, false)
		if admiral_data.active_player.Is_Human() then
			Story_Event("HAN_RESPAWN_SPEECH")
		end
	elseif tag == "Lando" then
		local planet = StoryUtil.FindFriendlyPlanet(admiral_data.active_player)
		SpawnList({"Lando_Calrissian_Team"}, planet, admiral_data.active_player, true, false)
		if admiral_data.active_player.Is_Human() then
			Story_Event("LANDO_RESPAWN_SPEECH")
		end
	end
	Handle_Hero_Killed(hero_name, owner, council_data)
end

function RepublicHeroes:Era_3()
	--Logger:trace("entering RepublicHeroes:Era_3")
	Handle_Hero_Add("Iblis", admiral_data)
end

function RepublicHeroes:Era_4()
	--Logger:trace("entering RepublicHeroes:Era_4")
	Handle_Hero_Exit("Kalback", admiral_data)
end

function Krefey_Check()
	--Logger:trace("entering RepublicHeroes:Krefey_Check")
	Krefey_Checks = Krefey_Checks + 1
	if Krefey_Checks == 2 then
		Handle_Hero_Add("Krefey", admiral_data)
	end
end

function RepublicHeroes:Era_7()
	--Logger:trace("entering RepublicHeroes:Era_7")
	Handle_Hero_Add("Han", admiral_data)
	Krefey_Check()
end

function RepublicHeroes:NCMP2_handler()
	--Logger:trace("entering RepublicHeroes:NCMP2_handler")
	admiral_data.total_slots = admiral_data.total_slots + 1
	admiral_data.free_hero_slots = admiral_data.free_hero_slots + 1
	
	Handle_Hero_Add("Bell", admiral_data)
	Handle_Hero_Add("Brand", admiral_data)
	Handle_Hero_Add("Abaht", admiral_data)
	local dummy = Find_First_Object("Solo_Remonda")
	if TestValid(dummy) then
		planet = dummy.Get_Planet_Location()
		if not TestValid(planet) then
			planet = StoryUtil.FindFriendlyPlanet(admiral_data.active_player)
		end
		if Handle_Hero_Exit("Solo", admiral_data) then
			SpawnList({"Han_Solo_Team"}, planet, admiral_data.active_player, true, false)
			if admiral_data.active_player.Is_Human() then
				Story_Event("HAN_RETIRE_SPEECH")
			end
		end
	else
		Handle_Hero_Exit("Solo", admiral_data)
	end
	Get_Active_Heroes(false, admiral_data)
end

function RepublicHeroes:New_Jedi_Order_Init()
	--Logger:trace("entering RepublicHeroes:New_Jedi_Order_Init")
	if admiral_data.active_player.Is_Human() and not self.NJOspeech then
		Story_Event("NJO_SPEECH")
	end
	self.NJOspeech = true
	local tech_unit = Find_Object_Type("JEDI_TEMPLE")
	admiral_data.active_player.Unlock_Tech(tech_unit)
	tech_unit = Find_Object_Type("JEDI_SQUAD")
	admiral_data.active_player.Unlock_Tech(tech_unit)
end

function RepublicHeroes:New_Jedi_Order()
	--Logger:trace("entering RepublicHeroes:New_Jedi_Order")
	if not self.NJOinit then
		council_data.total_slots = council_data.total_slots + 1
		council_data.free_hero_slots = council_data.free_hero_slots + 1
		Handle_Hero_Add("Corran", council_data)
		Handle_Hero_Add("Mara", council_data)
		Handle_Hero_Add("Cilghal", council_data)
		Get_Active_Heroes(false, council_data)
	end
	self.NJOinit = true
end

function RepublicHeroes:Bothan_Heroes()
	--Logger:trace("entering RepublicHeroes:Bothan_Heroes")
	Krefey_Check()
end

function RepublicHeroes:Mediator_Heroes()
	--Logger:trace("entering RepublicHeroes:Mediator_Heroes")
	Handle_Hero_Add("Ackdool", admiral_data)
end

function RepublicHeroes:Canon_Heroes()
	--Logger:trace("entering RepublicHeroes:Canon_Heroes")
	Handle_Hero_Add("Raddus", admiral_data)
	Handle_Hero_Add("Hera", admiral_data)
end