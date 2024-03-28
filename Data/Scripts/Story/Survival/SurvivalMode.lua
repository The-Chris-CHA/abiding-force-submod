require("PGSpawnUnits")
require("eawx-std/class")
require("GameObjectList")

SurvivalMode = class()

function SurvivalMode:new()
	--Base Unit CP, used for spawning units
    self.Max_Unit_CP = 1750

	--Players
    self.Hostile = Find_Player("Hostile")
    self.HumanPlayer = Find_Player("local")
    if self.HumanPlayer == Find_Player("Empire") then
        self.enemyPlayer = Find_Player("Rebel")
    else
        self.enemyPlayer = Find_Player("Empire")
    end
	--Spawn markers
    self.AlliedSpawnMarker = Find_First_Object("STORY_TRIGGER_ZONE_05")
    self.EnemySpawnMarkers = {
		Find_First_Object("STORY_TRIGGER_ZONE_00"),
        Find_First_Object("STORY_TRIGGER_ZONE_01"),
        Find_First_Object("STORY_TRIGGER_ZONE_02"),
        Find_First_Object("STORY_TRIGGER_ZONE_03"),
        Find_First_Object("STORY_TRIGGER_ZONE_04"),
		Find_First_Object("STORY_TRIGGER_ZONE_05"),
		Find_First_Object("STORY_TRIGGER_ZONE_06"),
		Find_First_Object("STORY_TRIGGER_ZONE_07"),
    }


	--Unit Tables
    self.EnemyUnits = {}
	self.AlliedUnits = {}

	--Necessary Booleans
    self.WaveAlive = false
    self.boss_fight = false

	--Find All space units
    for j, unit in pairs(ModContentLoader.get("GameObjectLibrary").Units) do
        --Can't check categories, which is.. fun
        if unit.Ship_Crew_Requirement then
            unitType = Find_Object_Type(j)
            if unitType.Is_Affiliated_With(self.enemyPlayer) then
                table.insert(self.EnemyUnits,unitType)
            elseif unitType.Is_Affiliated_With(self.HumanPlayer) then
                table.insert(self.AlliedUnits,unitType)
            end
		end
    end

	--Spawn initial allied units
    for var=1,5 do
		index = GameRandom.Free_Random(1,table.getn(self.AlliedUnits))
		unit = self.AlliedUnits[index]
		if unit.Get_Combat_Rating() > self.Max_Unit_CP then
			findingUnit = true
			while findingUnit do
				index = GameRandom.Free_Random(1,table.getn(self.AlliedUnits))
				unit = self.AlliedUnits[index]
				if unit.Get_Combat_Rating() <= self.Max_Unit_CP then
					Spawn_Unit(unit,self.AlliedSpawnMarker,self.HumanPlayer)
					findingUnit = false
				end
			end
        else
			Spawn_Unit(unit,self.AlliedSpawnMarker,self.HumanPlayer)
		end
    end

	--Spawn First Wave
    self.Wave = 1
	self.Max_Enemy_Units = self.Wave + 4
    self.CurrentWave = {}
    for var=1,self.Max_Enemy_Units do
        index = GameRandom.Free_Random(1,table.getn(self.EnemyUnits))
        unitType = self.EnemyUnits[index]
        if unitType.Get_Combat_Rating() > self.Max_Unit_CP then
			findingUnit = true
			while findingUnit do
				index = GameRandom.Free_Random(1,table.getn(self.EnemyUnits))
				unitType = self.EnemyUnits[index]
				if unitType.Get_Combat_Rating() <= self.Max_Unit_CP then
                    DebugMessage("%s Attempting to spawn Unit %s", tostring(Script),tostring(unitType.Get_Name()))
					unit = Spawn_Unit(unitType,self.EnemySpawnMarkers[GameRandom(1,table.getn(self.EnemySpawnMarkers))],self.Hostile)[1]
                    table.insert(self.CurrentWave, unit)
					findingUnit = false
				end
			end
        else
            unit = Spawn_Unit(unitType,self.EnemySpawnMarkers[GameRandom(1,table.getn(self.EnemySpawnMarkers))],self.Hostile)[1]
            table.insert(self.CurrentWave, unit)
        end
    end
    self.WaveAlive = true
    Story_Event("DISABLE_REINFORCEMENTS")

end

function SurvivalMode:update()
    if self.WaveAlive == true then
        DebugMessage("%s updating", tostring(Script))
        units_alive = 0
        for i, unit in pairs(self.CurrentWave) do
            if TestValid(unit) then
                units_alive = units_alive + 1
            end
        end

        if units_alive <= 0 then
			self:destroy_remaining_units()
            -- ShowScreenText("Wave Defeated Successfully")

            self.Max_Unit_CP = self.Max_Unit_CP + 125
			self.Max_Enemy_Units = self.Wave + 4


            new_money = 1000+(self.Wave*50)
            self.HumanPlayer.Give_Money(new_money)

            Story_Event("ENABLE_REINFORCEMENTS")
            
            -- if self.Wave > 3 and GameRandom.Free_Random(1,100) > 80 then
            --     self:spawn_wave_reward()
            -- end
            self.Wave = self.Wave+1

            -- ShowScreenText("Wave Spawning in 30 Seconds",1)
            Register_Timer(self.spawn_wave, 30)
            self.WaveAlive  = false

        end
    end
end

function SurvivalMode:spawn_wave()
	Story_Event("DISABLE_REINFORCEMENTS")
    self.CurrentWave = {}
    for var=1,self.Max_Enemy_Units do
        index = GameRandom.Free_Random(1,table.getn(self.EnemyUnits))
        unitType = self.EnemyUnits[index]
        if unitType.Get_Combat_Rating() > self.Max_Unit_CP then
			findingUnit = true
			while findingUnit do
				index = GameRandom.Free_Random(1,table.getn(self.EnemyUnits))
				unitType = self.EnemyUnits[index]
				if unitType.Get_Combat_Rating() <= self.Max_Unit_CP then
                    DebugMessage("%s Attempting to spawn Unit %s", tostring(Script),tostring(unitType.Get_Name()))
					unit = Spawn_Unit(unitType,self.EnemySpawnMarkers[GameRandom(1,table.getn(self.EnemySpawnMarkers))],self.Hostile)[1]
                    table.insert(self.CurrentWave, unit)
					findingUnit = false
				end
			end
        else
            unit = Spawn_Unit(unitType,self.EnemySpawnMarkers[GameRandom(1,table.getn(self.EnemySpawnMarkers))],self.Hostile)[1]
            table.insert(self.CurrentWave, unit)
        end
    end

	if Simple_Mod(self.Wave, 5) == 0 then
		self.boss_fight = true
		-- self:spawn_boss()
    else
        self.boss_fight = false
    end


    self.WaveAlive = true
end


function SurvivalMode:spawn_wave_reward()
    reward_types = {
        "Random_Unit",
        "Credits",
        "Hero_Spawn"
    }
	if Simple_Mod(self.Wave, 5) == 0 then
		reward = GameRandom(1,3)
    else
        reward = GameRandom(1,2)
    end
    if reward_types[reward] == "Random_Unit" then
        Spawn_Unit(self.EnemyUnits[GameRandom(1,table.getn(self.EnemyUnits))], self.AlliedSpawnMarker,self.Hostile)
    elseif reward_types[reward] == "Credits" then
        self.HumanPlayer.Give_Money(GameRandom.Free_Random(2000,6000))
    elseif reward_types[reward] == "Hero_Spawn" then
        --Need to actually do hero tables then fix this
        Spawn_Unit(self.EnemyUnits[GameRandom.Free_Random(1,table.getn(self.EnemyUnits))], self.AlliedSpawnMarker,self.Hostile)
    end
end

function SurvivalMode:destroy_remaining_units()
    remaining_units = Find_All_Objects_Of_Type(self.Hostile)
    if table.getn(remaining_units) > 0 then
        for i, unit in pairs(remaining_units) do
            if TestValid(unit) and (unit.Is_Category("Fighter") or unit.Is_Category("Bomber")) then
                unit.Take_Damage(9999999)
            end
        end
    end
end

return SurvivalMode