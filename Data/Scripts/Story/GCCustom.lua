require("PGStoryMode")
require("deepcore/crossplot/crossplot")
require("deepcore/std/class")
require("eawx-util/PopulatePlanetUtilities")
require("UnitSpawnerTables")
StoryUtil = require("eawx-util/StoryUtil")
UnitUtil = require("eawx-util/UnitUtil")
require("CustomLibrary")

function Definitions()

    DebugMessage("%s -- In Definitions", tostring(Script))
	
	crossplot:galactic()
	crossplot:subscribe("START_LOCATION_PICK", Location_Choice)
	crossplot:subscribe("ROSTER_PICK", Roster_Choice)
	crossplot:subscribe("STARTING_SIZE_PICK", Size_Choice)
	crossplot:subscribe("PLANET_MODIFIER_PICK", Modifier_Choice)
	
    StoryModeEvents = {
		Universal_Story_Start = FTGUInit,
		First_Conquest = Planet_Selected
	}
	
	FTGU_Dummies = Get_FTGU_Dummies()
	
	LocationType = ""
	RosterType = ""
	StartType = ""
	PlanetModifier = ""
	
	humanname = ""
	humanfaction = nil
	
	Bordering_Planets_List = nil
	
	StartingEra = nil
	
end	

function find_Neutral_planet(space_only_ok)
	local allPlanets = FindPlanet.Get_All_Planets()

    local random = 0
    local planet = nil

    while table.getn(allPlanets) > 0 do
        random = GameRandom.Free_Random(1, table.getn(allPlanets))
        planet = allPlanets[random]
        table.remove(allPlanets, random)
		
		local base_level = EvaluatePerception("MaxGroundbaseLevel", Find_Player("Independent_Forces"), planet)
		if space_only_ok then
			base_level = 1
		end

        if planet.Get_Owner() == Find_Player("Neutral") and base_level > 0 then
            return planet
        end
    end
end

function find_connected_neutral_planet(start_planet, player)
	local iterations = 0
	while iterations <= 20 do
		local path = Find_Path(player, start_planet, find_Neutral_planet(true))
		local result = path[2]
		iterations = iterations + 1
		if result.Get_Owner() == Find_Player("Neutral") then
			return result
		end
	end
	return nil
end

function find_distant_neutral_planet(start_planet)
	local iterations = 0
	local guess = nil
	while iterations <= 100 do
		guess = find_Neutral_planet(false)
		local path = Find_Path(humanfaction, start_planet, guess)
		iterations = iterations + 1
		if table.getn(path) > 6 then
			return guess
		end
	end
	return guess
end

function find_double_distant_neutral_planet(start_planet, start_planet2)
	local iterations = 0
	local guess = nil
	while iterations <= 100 do
		guess = find_Neutral_planet(false)
		local path = Find_Path(humanfaction, start_planet, guess)
		local path2 = Find_Path(humanfaction, start_planet2, guess)
		iterations = iterations + 1
		if table.getn(path) > 6 and table.getn(path2) > 4 then
			return guess
		end
	end
	return guess
end

function find_bordering_neutral_planet(player, perception)
    local random = 0
    local planet = nil
	
	local iterations = 0
	local max_its = table.getn(Bordering_Planets_List) * 2

    while table.getn(Bordering_Planets_List) > 0 do
		iterations = iterations + 1
		if iterations > max_its then
			return nil --find_Neutral_planet(true)
		end
		
        random = GameRandom.Free_Random(1, table.getn(Bordering_Planets_List))
        planet = Bordering_Planets_List[random]

		local dbug = EvaluatePerception(perception, player, planet)

        if dbug > 0 and planet.Get_Owner() == Find_Player("Neutral") then
			table.remove(Bordering_Planets_List, random)
            return planet
        end
    end
end

function FTGUInit(message)
    if message == OnEnter then
		StartingEra = Set_Tech()
	else
		crossplot:update()
	end
end

function Location_Choice(choice)
	LocationType = choice
	
	for factionid, info in pairs(FTGU_Dummies) do
		local player = Find_Player(factionid)
		
		if player.Is_Human() then
			humanname = factionid
			humanfaction = Find_Player(humanname)
			break
		end
	end
end

function Roster_Choice(choice)
	RosterType = choice
end

function Modifier_Choice(choice)
	PlanetModifier = choice
	
	SpawnList({PlanetModifier}, Find_First_Object(LocationType).Get_Planet_Location(), humanfaction,false,false)
end

function Size_Choice(choice)
	StartType = choice
	
	local primary_list = {"Custom_GC_Starter_Dummy_Team"}
	local secondary_list = {"Custom_GC_Random_Dummy","Custom_GC_Random_Dummy","Custom_GC_Random_Dummy","Custom_GC_Random_Dummy","Custom_GC_Random_Dummy"}
	local everywhere_list = {}
	
	local humaninfo = FTGU_Dummies[humanname]
	
	for factionid, info in pairs(FTGU_Dummies) do
		table.insert(everywhere_list, info.DummyUnit)
		if factionid ~= humanname then
			table.insert(primary_list, info.DummyUnit)
		end
	end
	
	local start = nil
	for _, candidate in pairs(humaninfo.PlayerStart) do
		start = FindPlanet(candidate)
		if start ~= nil then
			break
		end
	end
	if start == nil then
		start = find_Neutral_planet(false)
	end
	
	StoryUtil.ShowScreenText("Pick your starting planet by conquering it with the GC Starter object", 20, nil, {r = 244, g = 244, b = 0})
	if LocationType == "CUSTOM_GC_PICK_LOCATION" then
		StoryUtil.ShowScreenText("Place the factions you wish to fight in the orbit of your choice before conquering", 20, nil, {r = 244, g = 244, b = 0})
		SpawnList(primary_list, start, humanfaction,false,false)
		SpawnList(secondary_list, start, humanfaction,false,false)
		
	elseif LocationType == "CUSTOM_GC_PICK_ENEMY_LOCATION" then
		StoryUtil.ShowScreenText("Place the enemy faction objects over planets you want them to own before conquering your choice. Default enemy markers are placed on their default locations", 20, nil, {r = 244, g = 244, b = 0})
		
		SpawnList(primary_list, start, humanfaction,false,false)
		SpawnList(secondary_list, start, humanfaction,false,false)
	elseif LocationType == "CUSTOM_GC_PICK_EVERYWHERE" then
		StoryUtil.ShowScreenText("Place the enemy faction objects over planets you want them to own before conquering your choice. Default enemy markers are placed on their default locations", 20, nil, {r = 244, g = 244, b = 0})
		
		SpawnList(primary_list, start, humanfaction,false,false)
		for i = 1,4 do 
		   --SpawnList(secondary_list, start, humanfaction,false,false)
		   SpawnList({"Custom_GC_Capital","Custom_GC_Capital","Custom_GC_Capital","Custom_GC_Capital"}, start, humanfaction,false,false)
		end
		for i = 1,100 do 
		   SpawnList(everywhere_list, start, humanfaction,false,false) 
		end
	end
	
	if RosterType ~= "CUSTOM_GC_STANDARD_ROSTER" then
		if RosterType == "CUSTOM_GC_CUSTOM_ROSTER" then
			StoryUtil.ShowScreenText("Place all units you wish to be able to build over your starting planet to enable. All others will be disabled", 20, nil, {r = 50, g = 244, b = 0})
		elseif RosterType == "CUSTOM_GC_CUSTOM_ROSTER_ENABLE" then
			StoryUtil.ShowScreenText("Place any extra units you wish to be able to build over your starting planet", 20, nil, {r = 50, g = 244, b = 0})
		end
		--Find separate planets for space and ground rosters, because putting them together probably overflows the UI
		--Ideally make them connected, but it's more important to not make them space only. And even more important to not be caught in an infinite loop
		local rosterdump = find_connected_neutral_planet(start,humanfaction)
		local base_level = EvaluatePerception("MaxGroundbaseLevel", humanfaction, rosterdump)
		local iterations = 0
		while iterations <= 50 do
			if base_level == 0 then
				rosterdump = find_connected_neutral_planet(start,humanfaction)
				base_level = EvaluatePerception("MaxGroundbaseLevel", humanfaction, rosterdump)
			else
				break
			end
			iterations = iterations + 1
		end
		if base_level == 0 then
			iterations = 0
			rosterdump = find_Neutral_planet(start,humanfaction)
			base_level = EvaluatePerception("MaxGroundbaseLevel", humanfaction, rosterdump)
			while iterations <= 50 do
				if base_level == 0 or rosterdump == start then
					rosterdump = find_Neutral_planet(start,humanfaction)
					base_level = EvaluatePerception("MaxGroundbaseLevel", humanfaction, rosterdump)
				else
					break
				end
				iterations = iterations + 1
			end
		end
		
		local rosterspace = find_connected_neutral_planet(rosterdump,humanfaction)
		base_level = EvaluatePerception("MaxGroundbaseLevel", humanfaction, rosterspace)
		while iterations <= 50 do
			if base_level == 0 or rosterspace == start then
				rosterspace = find_connected_neutral_planet(start,humanfaction)
				base_level = EvaluatePerception("MaxGroundbaseLevel", humanfaction, rosterspace)
			else
				break
			end
			iterations = iterations + 1
		end
		if base_level == 0 then
			iterations = 0
			rosterspace = find_Neutral_planet(start,humanfaction)
			base_level = EvaluatePerception("MaxGroundbaseLevel", humanfaction, rosterspace)
			while iterations <= 50 do
				if base_level == 0 or rosterspace == start or rosterspace == rosterdump  then
					rosterspace = find_Neutral_planet(start,humanfaction)
					base_level = EvaluatePerception("MaxGroundbaseLevel", humanfaction, rosterspace)
				else
					break
				end
				iterations = iterations + 1
			end
		end
		
		--Fill up the ground so you don't conquer the planet and trigger a start
		SpawnList({"Placement_Dummy","Placement_Dummy","Placement_Dummy","Placement_Dummy","Placement_Dummy","Placement_Dummy","Placement_Dummy","Placement_Dummy","Placement_Dummy","Placement_Dummy"}, rosterdump, Find_Player("Neutral"),false,false)
		if RosterType == "CUSTOM_GC_CUSTOM_ROSTER" then
			SpawnList(humaninfo.RosterUnits, rosterspace, humanfaction,false,false)
		else
			local locked = {}
			for _, unit in pairs(humaninfo.RosterUnits) do
				if Find_Object_Type(unit).Is_Build_Locked(humanfaction) or Find_Object_Type(unit).Is_Obsolete(humanfaction) then
					table.insert(locked, unit)
				end
			end
			if table.getn(locked) == 0 then
				StoryUtil.ShowScreenText("No ground Roster Additions exist", 10)
			else
				SpawnList(locked, rosterspace, humanfaction,false,false)
			end
		end
		local companies = {}
		for _, comp in pairs(humaninfo.RosterCompanies) do
			if (RosterType == "CUSTOM_GC_CUSTOM_ROSTER" or Find_Object_Type(comp[1]).Is_Build_Locked(humanfaction) or Find_Object_Type(comp[1]).Is_Obsolete(humanfaction)) and (comp[3] == nil or FindPlanet(comp[3]) ~= nil) then
				if comp[3] ~= nil then
					StoryUtil.ShowScreenText(comp[1] .. " can only be built on " .. comp[3], 20, nil, {r = 244, g = 244, b = 0})
				end
				table.insert(companies, comp[1])
			end
		end
		if table.getn(companies) == 0 then
			StoryUtil.ShowScreenText("No space Roster Additions exist", 10)
		else
			SpawnList(companies, rosterdump, humanfaction,false,false)
		end
		local forceorbit = Find_All_Objects_Of_Type("Placement_Dummy")
		for _, randomDummy in pairs(forceorbit) do
			randomDummy.Despawn()
		end
	end
	
	SpawnList({LocationType, RosterType, StartType}, find_distant_neutral_planet(start), humanfaction,false,false)
end

function Planet_Selected(message)
	if message == OnEnter then	
		local checkobject = Find_First_Object("Custom_GC_Starter_Dummy")
		if checkobject ~= nil then
			local startplanet = checkobject.Get_Planet_Location()
			local humaninfo = FTGU_Dummies[humanname]
			
			local infoobject = Find_First_Object(LocationType)
			if infoobject ~= nil then
				infoobject.Despawn()
			end
			infoobject = Find_First_Object(RosterType)
			if infoobject ~= nil then
				infoobject.Despawn()
			end
			infoobject = Find_First_Object(StartType)
			if infoobject ~= nil then
				infoobject.Despawn()
			end
			infoobject = Find_First_Object(PlanetModifier)
			if infoobject ~= nil then
				infoobject.Despawn()
			end
			
			--Reset money after any nonsense with upkeep while the game was set up or sale of units
			humanfaction.Give_Money(8000 - humanfaction.Get_Credits())
		
			--Handle custom roster before any final spawns take place
			if RosterType ~= "CUSTOM_GC_STANDARD_ROSTER" then		
				for _, unittype in pairs(humaninfo.RosterUnits) do
					local tech_key = Find_First_Object(unittype)
					local techtype = Find_Object_Type(unittype)
					if tech_key == nil then
						if RosterType == "CUSTOM_GC_CUSTOM_ROSTER" then
							humanfaction.Lock_Tech(techtype)
						end
					else
						if tech_key.Get_Planet_Location() == startplanet then
							humanfaction.Unlock_Tech(techtype)
						else
							if RosterType == "CUSTOM_GC_CUSTOM_ROSTER" then
								humanfaction.Lock_Tech(techtype)
							end
						end
						tech_key.Despawn()
					end
				end
				for _, companydata in pairs(humaninfo.RosterCompanies) do
					local tech_key = Find_First_Object(companydata[2])
					local techtype = Find_Object_Type(companydata[1])
					if tech_key == nil then
						if RosterType == "CUSTOM_GC_CUSTOM_ROSTER" then
							humanfaction.Lock_Tech(techtype)
						end
					else
						if tech_key.Get_Planet_Location() == startplanet then
							humanfaction.Unlock_Tech(techtype)
						else
							if RosterType == "CUSTOM_GC_CUSTOM_ROSTER" then
								humanfaction.Lock_Tech(techtype)
							end
						end
						UnitUtil.DespawnCompany(companydata[1])
					end
				end
			end
			
			checkobject.Despawn()
			spawn_human_start(startplanet, true)
			
			if LocationType == "CUSTOM_GC_PICK_EVERYWHERE" then
				if StartType == "CUSTOM_GC_SMALL_START" then
					spawn_small_heroes(humaninfo,startplanet,humanfaction)
				end
				local caps = Find_All_Objects_Of_Type("Custom_GC_Capital")
				for _, cap in pairs(caps) do
					if cap.Get_Planet_Location() == startplanet then
						cap.Despawn()
					end
				end
				for factionid, info in pairs(FTGU_Dummies) do
					local player = Find_Player(factionid)
					local factionDummies = Find_All_Objects_Of_Type(info.DummyUnit)
					local smallhero = 0
					if player == humanfaction then
						smallhero = 2
					end
					
					for _, dummy in pairs(factionDummies) do
						local planet = dummy.Get_Planet_Location()
						if planet ~= nil then 
							if planet.Get_Owner() == Find_Player("Neutral") then
								caps = Find_All_Objects_Of_Type("Custom_GC_Capital")
								local frnocap = nil
								for _, cap in pairs(caps) do
									if cap.Get_Planet_Location() == planet then
										frnocap = info.Capital
										cap.Despawn()
										smallhero = smallhero + 1
										break
									end
								end
								populate_planet(planet,player,frnocap)
								if smallhero == 1 then
									if StartType == "CUSTOM_GC_SMALL_START" then
										spawn_small_heroes(info,planet,player)
									end
									smallhero = smallhero + 1
								else
									if frnocap ~= nil then
										player.Give_Money(8000)
									end
								end
							end
						end
						dummy.Despawn()
					end
				end
				
				spawn_full_heroes()
				
				caps = Find_All_Objects_Of_Type("Custom_GC_Capital")
				for _, cap in pairs(caps) do
					cap.Despawn()
				end
			else
				local selected_factions = {humanname}
				local unselected_factions = {}
				local enemy_starts = {}
				
				for factionid, info in pairs(FTGU_Dummies) do
					if factionid ~= humanname then
						local dummy = Find_First_Object(info.DummyUnit)
						local checklocation = startplanet
						local picked = false
						if dummy ~= nil then
							checklocation = dummy.Get_Planet_Location()
							dummy.Despawn()
							
							if LocationType == "CUSTOM_GC_PICK_LOCATION" then
								if checklocation == startplanet then
									picked = true
									checklocation = find_distant_neutral_planet(startplanet)
								end
							elseif LocationType == "CUSTOM_GC_PICK_ENEMY_LOCATION" then
								if checklocation ~= nil then --Apparently changing ownership under a dummy can put it in the shadow realm
									if checklocation.Get_Owner() == Find_Player("Neutral") then
										picked = true
									end
								end
							end
						end
						
						if picked then
							local faction = Find_Player(factionid)
							table.insert(selected_factions, factionid)
							populate_planet(checklocation,faction,FTGU_Dummies[factionid].Capital)
							if StartType == "CUSTOM_GC_FTGU" then
								FTGU_Enemy_Start(checklocation,faction,startplanet)
							end
							Sleep(0.001)
						else
							table.insert(unselected_factions, factionid)
						end
					end
				end
				
				local randomDummies = Find_All_Objects_Of_Type("Custom_GC_Random_Dummy")
				for _, randomDummy in pairs(randomDummies) do
					local checklocation = randomDummy.Get_Planet_Location()
					randomDummy.Despawn()
					
					local add_random = false
					if LocationType == "CUSTOM_GC_PICK_LOCATION" then
						if checklocation == startplanet then
							add_random = true
							checklocation = find_distant_neutral_planet(startplanet)
						end
					elseif LocationType == "CUSTOM_GC_PICK_ENEMY_LOCATION" then
						if checklocation ~= nil then
							if checklocation.Get_Owner() == Find_Player("Neutral") then
								add_random = true
							end
						end
					end
					
					if add_random then
						local options = table.getn(unselected_factions)
						if options > 0 then
							local uns = GameRandom.Free_Random(1, options)
							local factionid = unselected_factions[uns]
							StoryUtil.ShowScreenText("Selected random enemy: " .. factionid, 10)
							local faction = Find_Player(factionid)
							table.insert(selected_factions, factionid)
							populate_planet(checklocation,faction,FTGU_Dummies[factionid].Capital)
							if StartType == "CUSTOM_GC_FTGU" then
								FTGU_Enemy_Start(checklocation,faction,startplanet)
							end
							table.remove(unselected_factions, uns)
							Sleep(0.001)
						end
					end
				end
				
				if StartType ~= "CUSTOM_GC_FTGU" then
					spawn_connected_territory(selected_factions)
				end
			end
			
			spawn_IF()
		end
	else
		crossplot:update()
	end
end

function FTGU_Enemy_Start(ai_start,ai_faction,human_start)
	local disjoint = GameRandom.Free_Random(1, 2)
	if disjoint == 2 then
		disjoint = true
	else
		disjoint = false
	end
	
	local next_planet = find_connected_neutral_planet(ai_start,ai_faction)
	if next_planet == nil then
		next_planet = find_Neutral_planet(true)
	end
	populate_planet(next_planet,ai_faction,nil)
	next_planet = find_connected_neutral_planet(ai_start,ai_faction)
	if next_planet == nil then
		next_planet = find_Neutral_planet(true)
	end
	populate_planet(next_planet,ai_faction,nil)
	if disjoint then
		next_planet = find_double_distant_neutral_planet(ai_start,human_start)
		populate_planet(next_planet,ai_faction,nil)
		local last_planet = find_connected_neutral_planet(next_planet,ai_faction)
		if last_planet == nil then
			last_planet = find_Neutral_planet(true)
		end
		populate_planet(last_planet,ai_faction,nil)
	else
		next_planet = find_connected_neutral_planet(ai_start,ai_faction)
		if next_planet == nil then
			next_planet = find_Neutral_planet(true)
		end
		populate_planet(next_planet,ai_faction,nil)
	end
end

function spawn_connected_territory(faction_list)
	local planetcount =  table.getn(FindPlanet.Get_All_Planets())
	local factiontable = {}
	local perceptable = {}
	local planetstodo = {}
	local faction_modifier = 0
	local planet_multiplier = 1
	factioncount = table.getn(faction_list)
	if PlanetModifier == "CUSTOM_GC_PLAYER_EXTRA" then
		faction_modifier = 0.5
		planet_multiplier = 1.5
	elseif PlanetModifier == "CUSTOM_GC_PLAYER_HALF" then
		faction_modifier = -0.5
		planet_multiplier = 0.5
	elseif PlanetModifier == "CUSTOM_GC_PLAYER_FTGU_EXTREME" then
		faction_modifier = -1
		planet_multiplier = 0
	end
	
	local planetsperplayer = planetcount / (factioncount+faction_modifier) / 1.1 - 1 --Minus one for the starting planet
	if StartType == "CUSTOM_GC_SMALL_START" and planetsperplayer > 5 then
		planetsperplayer = 5
	end

	for _, factionid in pairs(faction_list) do
		local factionobject = Find_Player(factionid)
		table.insert(factiontable,factionobject)
		table.insert(perceptable,FTGU_Dummies[factionid].Perception)
		table.insert(planetstodo,planetsperplayer)
		
		if StartType == "CUSTOM_GC_SMALL_START" then
			local data = FTGU_Dummies[factionid]
			local capitals = Find_All_Objects_Of_Type(data.Capital)
			local capital = nil
			for n, cap in pairs(capitals) do
				if cap.Get_Owner() == factionobject then
					capital = cap
					break
				end
			end
			
			spawn_small_heroes(data,capital.Get_Planet_Location(),factionobject)
		end
	end
	planetstodo[1] = (planetstodo[1] + 1) * planet_multiplier - 1 --Strange addition compensates for the starting planet not being included in the planets to do
	
	Bordering_Planets_List = FindPlanet.Get_All_Planets()
	
	local maxtodo = planetsperplayer
	
	for __=1,3 do --If the perceptions fail, try again a few times
		for planet=1,maxtodo do
			for i, faction in pairs(factiontable) do
				if planetstodo[i] > 0.99 then
					local newplanet = find_bordering_neutral_planet(faction, perceptable[i])
					if newplanet ~= nil then
						planetstodo[i] = planetstodo[i] - 1
						populate_planet(newplanet, faction, nil)
					end
				end
			end
			Sleep(0.001) --This not only looks cool to see the slow fill in, but helps the perceptions not randomly fail
		end
		maxtodo = 0
		for _, count in pairs(planetstodo) do
			if count > maxtodo then
				maxtodo = count
			end
		end
	end
	
	--Fill out anything that still failed or was boxed in and had no valid spots
	for planet=1,maxtodo do
		for i, faction in pairs(factiontable) do
			if planetstodo[i] > 0.99 then
				local newplanet = find_Neutral_planet(true)
				if newplanet ~= nil then
					planetstodo[i] = planetstodo[i] - 1
					populate_planet(newplanet, faction, nil)
				end
			end
		end
	end
	
	spawn_full_heroes()
end

function spawn_small_heroes(data,location,player)
	local heroes = data.SmallHero[StartingEra]
	if heroes == nil then
		heroes = data.SmallHero[1]
	end
	if type(heroes) == "number" then
		heroes = data.SmallHero[heroes]
	end
	SpawnList(heroes,location,player,true,false)
end

function spawn_full_heroes()
	if StartType == "CUSTOM_GC_FULL_START" then
		crossplot:publish("CUSTOM_FULL_HEROES", "empty")
		local safes = StoryUtil.GetSafePlanetTable()
		local file = Get_Full_Hero_File(StartingEra)
	
		if file ~= nil then
			local Starting_Spawns = require(file)
			for faction, herolist in pairs(Starting_Spawns) do
				for planet, spawnlist in pairs(herolist) do
					StoryUtil.SpawnAtSafePlanet(planet, Find_Player(faction), safes, spawnlist)  
				end
			end
		end
	end	
end

function spawn_human_start(start_planet, preowned)
	local humaninfo = FTGU_Dummies[humanname]

	if preowned then --If the planet is owned because it was picked by conquest, make sure a capital is spawned in case it is a low slot count
		SpawnList({humaninfo.Capital}, start_planet, humanfaction,false,false)
	end
	ChangePlanetOwnerAndPopulate(start_planet, humanfaction, 4500)
	if not preowned then --If the planet isn't owned, spawning a capital first doesn't work
		SpawnList({humaninfo.Capital}, start_planet, humanfaction,false,false)
	end
end

function populate_planet(start_planet, faction, capital)
	local scaled_combat_power = 800 * EvaluatePerception("GenericPlanetValue", humanfaction, start_planet)
	if capital ~= nil then
		scaled_combat_power = 4500
	end
	ChangePlanetOwnerAndPopulate(start_planet, faction, scaled_combat_power)
	if capital ~= nil then
		SpawnList({capital}, start_planet, faction,false,false)
	end
end

function spawn_IF()
	--Randomly spawn units at all planets owned by neutral or hostile
	--Probably want some screen text to tell the player the game is loading still
	local p_independent = Find_Player("Independent_Forces")
	local p_neutral = Find_Player("Neutral")
	local planet = nil
	local scaled_combat_power = 7500
	
	for _, planet in pairs(FindPlanet.Get_All_Planets()) do	
		if planet.Get_Owner() == (p_neutral or p_independent) then	
			scaled_combat_power = 7500 * EvaluatePerception("GenericPlanetValue", p_independent, planet) * (1.5 - EvaluatePerception("Is_Connected_To_Player", p_independent, planet))
			ChangePlanetOwnerAndPopulate(planet, p_independent, scaled_combat_power, "RANDOM", true)
		end
	end
	
	ssd_meme_table = Get_SSDS()
	
	local max_ssd = 4
	local spawned_ssd = 0
	if p_independent.Get_Difficulty() == "Easy" then
		max_ssd = 2
	elseif p_independent.Get_Difficulty() == "Hard" then
		max_ssd = 8
	end
	
	for _, pair in pairs(ssd_meme_table) do
		if GameRandom.Free_Random(1, pair[2]) == 1 then
			local ssd_planet = StoryUtil.FindFriendlyPlanet(p_independent)
			SpawnList({pair[1]}, ssd_planet, p_independent,false,false)
			spawned_ssd = spawned_ssd + 1
			if spawned_ssd >= max_ssd then
				break
			end
		end
	end
	
	crossplot:publish("INITIALIZE_AI", "empty")
	Story_Event("FTGU_SPAWN_COMPLETE")
end
