require("PGStoryMode")
require("deepcore/crossplot/crossplot")
StoryUtil = require("eawx-util/StoryUtil")

function Definitions()

    DebugMessage("%s -- In Definitions", tostring(Script))
	crossplot:galactic()
	crossplot:subscribe("STARTING_SIZE_PICK", Size_Choice)
	crossplot:subscribe("CUSTOM_FIXED_START", Fixed_Start)
	crossplot:subscribe("CUSTOM_FULL_HEROES", Empire_Heroes)
	
    StoryModeEvents = {
		Delayed_Initialize = Initialize,
		Rancor_Base_Check = Delete_Old
	}
	
end		

function Initialize(message)
    if message == OnEnter then	
	else
		crossplot:update()
    end
end

function Size_Choice(choice)
	p_Republic = Find_Player("Rebel")
	if p_Republic.Is_Human() then
		if choice == "CUSTOM_GC_SMALL_START" then
			crossplot:publish("NR_ADMIRAL_DECREMENT", {2,2,0}, 0)
		end
		if choice == "CUSTOM_GC_FTGU" then
			FTGU_Decrements()
		end
	end
end

function Fixed_Start()
	p_Republic = Find_Player("Rebel")
	if p_Republic.Is_Human() then
		FTGU_Decrements()
	end
end

function FTGU_Decrements()
	crossplot:publish("NR_ADMIRAL_DECREMENT", {3,2,0}, 0)
	crossplot:publish("NR_ADMIRAL_DECREMENT", {1,1,1}, 0, true)
end

function Delete_Old(message)
    if message == OnEnter then
		local capital_table = Find_All_Objects_Of_Type("Kamino_Capital")
		local p_zsinj = Find_Player("Zsinj_Empire")
        for i, unit in pairs(capital_table) do
			if unit.Get_Owner() == p_zsinj then
				unit.Despawn()
				p_zsinj.Give_Money(5000)
				break --Only take away one if Zsinj has multiple
			end
        end
	end
end

function Empire_Heroes()
	era = GlobalValue.Get("CURRENT_ERA")
	local regime = {"PESTAGE","ISARD","THRAWN","PALPATINE","CARNOR","DAALA","PELLAEON"}
	p_Empire = Find_Player("Empire")
	
	Starting_Spawns = require("eawx-mod-icw/spawn-sets/EmpireProgressSet")
	for planet, herolist in pairs(Starting_Spawns[regime[era]]) do
		for _, hero_table in pairs(herolist) do
			StoryUtil.SpawnAtSafePlanet(planet, p_Empire, StoryUtil.GetSafePlanetTable(), {hero_table.object})  
		end
	end
	
	local caps = Find_All_Objects_Of_Type("Kamino_Capital")
	for _, cap in pairs(caps) do
		local locale = cap.Get_Planet_Location()
		
		local yards = Find_All_Objects_Of_Type("Zsinj_Shipyard_Level_One")
		for __, yard in pairs(yards) do
			if yard.Get_Planet_Location() == locale then
				yard.Despawn()
				break
			end
		end
		yards = Find_All_Objects_Of_Type("Zsinj_Shipyard_Level_Two")
		for __, yard in pairs(yards) do
			if yard.Get_Planet_Location() == locale then
				yard.Despawn()
				break
			end
		end
		yards = Find_All_Objects_Of_Type("Zsinj_Shipyard_Level_Three")
		for __, yard in pairs(yards) do
			if yard.Get_Planet_Location() == locale then
				yard.Despawn()
				break
			end
		end
		yards = Find_All_Objects_Of_Type("Zsinj_Shipyard_Level_Four")
		for __, yard in pairs(yards) do
			if yard.Get_Planet_Location() == locale then
				yard.Despawn()
				break
			end
		end
		SpawnList({"Rancor_Base"}, locale, Find_Player("Zsinj_Empire"),false,false)
		cap.Despawn()
	end
end