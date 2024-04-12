--************************************--
--*****  Campaign: Reunification *****--
--************************************--

require("PGBase")
require("PGStoryMode")
require("PGSpawnUnits")
require("PGStateMachine")
require("SetFighterResearch")
require("eawx-util/ChangeOwnerUtilities")
require("deepcore/std/class")
StoryUtil = require("eawx-util/StoryUtil")
UnitUtil = require("eawx-util/UnitUtil")
require("deepcore/crossplot/crossplot")
require("eawx-util/PopulatePlanetUtilities")

function Definitions()
	DebugMessage("%s -- In Definitions", tostring(Script))
	
	StoryModeEvents = {
		-- Generic
		Delayed_Initialize = Delayed_Initialize_Lua,
		Trigger_Gorgon_Destroyed = State_Gorgon_Destroyed,
		Trigger_Reunification_Timer = State_Reunification_Timer,
		Trigger_Reunification_Timer_Long = State_Reunification_Timer,
	
		-- IR
		Trigger_IR_Player_Checker = State_IR_Player_Checker,
		Trigger_IR_Reunification_Tsoss_Conference = State_IR_Reunification_Tsoss_Conference,
	
		-- NR
		Trigger_NR_Player_Checker = State_NR_Player_Checker,
		
		-- EA
		Trigger_EA_Player_Checker = State_EA_Player_Checker,
		Trigger_EA_Reunification_Night_Hammer_Built = State_EA_Reunification_Night_Hammer_Built,
	
		-- GM
		Trigger_GM_Player_Checker = State_GM_Player_Checker,
		
		-- Hutts
		Trigger_Hutts_Player_Checker = State_Hutts_Player_Checker,
	}
	
	p_empire = Find_Player("Empire")
	p_newrep = Find_Player("Rebel")
	p_eriadu = Find_Player("Eriadu_Authority")
	p_maldrood = Find_Player("Greater_Maldrood")
	p_hutts = Find_Player("Hutt_Cartels")
	p_warlords = Find_Player("Warlords")
	p_neutral = Find_Player("Neutral")
	
	flag_tsoss_happened = false
end

function Delayed_Initialize_Lua(message)
    if message == OnEnter then
		crossplot:galactic()
		crossplot:publish("INITIALIZE_AI", "empty")
		crossplot:publish("NR_ADMIRAL_DECREMENT", 1, 1)

		crossplot:publish("NR_FILTER_REMOVE", {"Wedge_Rogues_Location_Set"}, 2)
		Clear_Fighter_Hero("WEDGE_ANTILLES_ROGUE_TEAM")
		Set_Fighter_Hero("TYCHO_CELCHU_ROGUE_TEAM", "GALACTIC_VOYAGER")
		crossplot:publish("NR_FILTER_ADD", {"Tycho_Rogues_Location_Set"}, 2)

		p_eriadu.Lock_Tech(Find_Object_Type("BRILLIANTUPGRADE"))
		p_eriadu.Unlock_Tech(Find_Object_Type("BRILLIANTUPGRADE_REUNIFICATION"))
	else
		crossplot:update()
    end
end

function State_Gorgon_Destroyed(message)
    if message == OnEnter then
		Story_Event("GORGON_DESTROYED")	
    end
end

function State_Reunification_Timer(message)
    if message == OnEnter then		
		--IR Tsoss event not fired on this timer
		--if the Tsoss Conference already happened, it doesn't happen again
		if p_empire.Is_Human() or flag_tsoss_happened then
			return
		end

		--Hutts and NR can buy themselves extra time by killing Daala_Gorgon
		if (p_newrep.Is_Human() or p_hutts.Is_Human()) and Find_First_Object("Daala_Gorgon") == nil and GetCurrentTime() < (21 * 40) then
			return
		end

		--GM and EA do not get Tsossed if Daala is dead
		if (p_maldrood.Is_Human() or p_eriadu.Is_Human()) and Find_First_Object("Daala_Gorgon") == nil then
			return
		end

		--EA has a unique story path if Daala is alive
		if p_eriadu.Is_Human() and Find_First_Object("Daala_Gorgon") then
			Tsoss_Nonference()
			return
		end

		Tsoss_Conference()
    end
end

-- Empire

function State_IR_Player_Checker(message)
    if message == OnEnter then
		if p_empire.Is_Human() then

			StoryUtil.SetPlanetRestricted("TSOSS", 1)

			Story_Event("IR_STORY_START")

			Sleep(4.0)
			gc_start = true
		end
    end
end

function State_IR_Reunification_Tsoss_Conference(message)
    if message == OnEnter then
		Tsoss_Conference()
    end
end

-- New Republic

function State_NR_Player_Checker(message)
    if message == OnEnter then
		if p_newrep.Is_Human() then
		
			StoryUtil.SetPlanetRestricted("TSOSS", 1)
		
			Story_Event("NR_STORY_START")

			Sleep(4.0)
			gc_start = true
		end
    end
end

-- Eriadu Authority

function State_EA_Player_Checker(message)
    if message == OnEnter then
		if p_eriadu.Is_Human() then
		
			StoryUtil.SetPlanetRestricted("TSOSS", 1)
		
			Story_Event("EA_STORY_START")

			Sleep(4.0)
			gc_start = true
		end
    end
end

function State_EA_Reunification_Night_Hammer_Built(message)
	if message == OnEnter then
		Story_Event("EA_NIGHT_HAMMER_BUILT")
	end
end

-- Greater Maldrood

function State_GM_Player_Checker(message)
    if message == OnEnter then
		if p_maldrood.Is_Human() then
		
			StoryUtil.SetPlanetRestricted("TSOSS", 1)
		
			Story_Event("GM_STORY_START")

			Sleep(4.0)
			gc_start = true
		end
    end
end

-- Hutt Cartels

function State_Hutts_Player_Checker(message)
    if message == OnEnter then
		if p_hutts.Is_Human() then
		
			StoryUtil.SetPlanetRestricted("TSOSS", 1)
		
			Story_Event("HUTTS_STORY_START")

			Sleep(4.0)
			gc_start = true
		end
    end
end

-- Tsoss Conference

function Tsoss_Conference()
	flag_tsoss_happened = true

	Story_Event("STOP_MONITORING_GORGON")

	StoryUtil.SetPlanetRestricted("TSOSS", 0)

	--kill the Deep Core warlords (also despawn Pellaeon in Cronus_13x and Cronus in A6)
	--despawn Kosh just in case he wandered into the Deep Core
	UnitUtil.DespawnList({
		"HARRSK_SHOCKWAVE",
		"DELVARDUS_BRILLIANT",
		"TREUTEN_CRIMSON_SUNRISE",
		"YZU_CONSTITUTION",
		"PELLAEON_13X",
		"CRONUS_A6",
		"KOSH_LANCET",
	})

	--without this, Cronus_A6 does not despawn; idk ~Mord
	Sleep(0.1)

	local flipping_planets = {}

	--all EA planets flip, no exception
	for _, planet_object in pairs(FindPlanet.Get_All_Planets()) do
		if planet_object.Get_Owner() == p_eriadu then
			table.insert(flipping_planets, planet_object)
		end
	end

	--only GM and Minor Warlord planets in the Core flip
	local flippable_planets = {
		"BALMORRA",
		"CARIDA",
		"CHANDRILA",
		"CHASIN",
		"COLUMUS",
		"CORUSCANT",
		"EMPRESS_TETA",
		"EXODEEN",
		"HAKASSI",
		"KAIKIELIUS",
		"KALIST",
		"KAMPE",
		"KHOMM",
		"OJOM",
		"PRAKITH",
		"TSOSS",
	}

	local factions_to_flip = {
		p_maldrood,
		p_warlords
	}

	for _, target_faction in pairs(factions_to_flip) do
		for _, planet_name in pairs(flippable_planets) do
			local planet_object = FindPlanet(planet_name)
			if planet_object.Get_Owner() == target_faction then
				table.insert(flipping_planets, planet_object)
			end
		end
	end

	ChangePlanetOwnerAndReplace(flipping_planets, p_empire, 2)

	--Kosh loses access to Crimson Command, Empire replaces VSD-II with CCVSD
	UnitUtil.SetLockList("GREATER_MALDROOD", {"Crimson_Victory"}, false)
	UnitUtil.SetLockList("EMPIRE", {"Generic_Victory_Destroyer_Two"}, false)
	UnitUtil.SetLockList("EMPIRE", {"Crimson_Victory"})

	--spawn new minions (Cronus Cronus_13x, Pellaeon Firestorm, Noils, Gann, Royal Guard company)
	local safeplanets = StoryUtil.GetSafePlanetTable()
	StoryUtil.SpawnAtSafePlanet("KAMPE", p_empire, safeplanets, {"Cronus_13x"})
	StoryUtil.SpawnAtSafePlanet("HAKASSI", p_empire, safeplanets, {"Pellaeon_Firestorm"})
	StoryUtil.SpawnAtSafePlanet("KALIST", p_empire, safeplanets, {"Noils_Team"})
	StoryUtil.SpawnAtSafePlanet("PRAKITH", p_empire, safeplanets, {"Gann_Team"})
	StoryUtil.SpawnAtSafePlanet("TSOSS", p_empire, safeplanets, {"Imperial_Royal_Guard_Stormtrooper_Squad"})

	--respawn Kosh in the Mid Rim, if there's anything left
	StoryUtil.SpawnAtSafePlanet("RYVESTER", p_maldrood, safeplanets, {"Kosh_Lancet"})

	if p_empire.Is_Human() then
		--human gets discounted Knight Hammer upgrade on Kampe
		p_empire.Unlock_Tech(Find_Object_Type("DAALAUPGRADE_REUNIFICATION"))	
	else
		--AI just gets Knight Hammer free
		local Daala_Gorgon = Find_First_Object("Daala_Gorgon")
		if TestValid(Daala_Gorgon) then
			Daala_Gorgon.Despawn()
		end
		StoryUtil.SpawnAtSafePlanet("TSOSS", p_empire, safeplanets, {"Daala_Knight_Hammer"})
	end

	--Lusankya spawns for player Empire
	if p_empire.Is_Human() and not TestValid(Find_First_Object("Wedge_Lusankya")) then
		StoryUtil.SpawnAtSafePlanet("CHANDRILA", p_newrep, safeplanets, {"Wedge_Lusankya"})
	end

	--faction specific multimedia event
	Story_Event("TSOSS_CONFERENCE")	
	--universal lore holocron (after 15s delay)
	Story_Event("LORE_TSOSS_CONFERENCE")
end

function Tsoss_Nonference()
	flag_tsoss_happened = true
	
	Story_Event("STOP_MONITORING_GORGON")

	StoryUtil.SetPlanetRestricted("TSOSS", 0)

	local tsoss_object = FindPlanet("TSOSS")

	ChangePlanetOwnerAndReplace({tsoss_object}, p_empire)

	--Tsoss gets some structures and a fleet
	ChangePlanetOwnerAndPopulate(tsoss_object, p_empire, 2000, p_empire, false)

	--spawn new minions (Cronus 13X, Pellaeon Firestorm, Noils, Royal Guard company)
	local safeplanets = StoryUtil.GetSafePlanetTable()
	
	--Daala's hero squad, if alive, teleports to Tsoss, and Pellaeon defects to Daala
	local brusc = TestValid(Find_First_Object("Brusc_Manticore"))
	local mullinore = TestValid(Find_First_Object("Mullinore_Basilisk"))

	UnitUtil.DespawnList({
		"Daala_Gorgon",
		"Pellaeon_13X",
		"Brusc_Manticore",
		"Mullinore_Basilisk"
		})

	local hero_squad = {
		"Daala_Gorgon",
		"Pellaeon_13X"
	}

	if brusc then
		table.insert(hero_squad,"Brusc_Manticore")
	end
	
	if mullinore then
		table.insert(hero_squad,"Mullinore_Basilisk")
	end

	StoryUtil.SpawnAtSafePlanet("TSOSS", p_empire, safeplanets, hero_squad)

	--multimedia event
	Story_Event("TSOSS_NONFERENCE")	
end
