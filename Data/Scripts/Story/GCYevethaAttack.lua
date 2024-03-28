require("PGStoryMode")
StoryUtil = require("eawx-util/StoryUtil")

function Definitions()

	DebugMessage("%s -- In Definitions", tostring(Script))
	
	StoryModeEvents = 
	{
		Black_Fleet_Enable = Yev_Attack
	}
	
	black_fleet = {
		"Bille_Pride",
		"Voota_Splendor",
		"Toorr_Devotion",
		"Attan_Beauty",
		"Noorr_Purity",
		"Generic_Star_Destroyer_Two",
		"Generic_Victory_Destroyer",
		"Generic_Victory_Destroyer",
		"Armadia",
		"Armadia",
		"Armadia",
		"Armadia",
		"Armadia",
		"Armadia",
		"Armadia",
		"Armadia",
		"Armadia",
		"Armadia",
		"Armadia",
		"Armadia",
		"Armadia",
		"C_type_Thrustship",
		"C_type_Thrustship",
		"C_type_Thrustship",
		"C_type_Thrustship",
		"C_type_Thrustship"
	}
	
	black_sword_unit_list = nil
	
	Duskhan_move_delay = 45

	-- For memory pool cleanup hints

end

function Yev_Attack(message)
	if message == OnEnter then
		startplanet = FindPlanet("Nzoth")
		if not TestValid(startplanet) then
			Story_Event("NO_YEVETHA")
			ScriptExit() --No Yevetha in this GC
		end
		Yevetha_player = Find_Player("Yevetha")
		black_sword_unit_list = SpawnList(black_fleet, startplanet, Yevetha_player, false, false)
		black_fleet = Assemble_Fleet(black_sword_unit_list)
		if not black_fleet then
			--MessageBox("Can't find death star; aborting")
			ScriptExit()
		end

		Register_Timer(Yev_Loop, 200)
	end
end


function Yev_Loop()
	if TestValid(black_fleet) then
		Yevetha_player = Find_Player("Yevetha")
		target_planet = StoryUtil.FindEnemyPlanet(Find_Player("Yevetha"))
		
		if not target_planet then
			--MessageBox("I guess the Black Fleet won?")
			ScriptExit()
		end
		
		current_planet = black_fleet.Get_Parent_Object()
		if not current_planet then
			--MessageBox("Error, wasn't on a planet; trying again later.")
			Sleep(5)
		else
			local to_grow_or_not = GameRandom(1, 10)
			if current_planet.Get_Owner() == Yevetha_player then 
				to_grow_or_not = 0 -- don't allow arbitrarily large stacks over Koornacht
			end
			
			local growing_list
			if to_grow_or_not == 1 then
				growing_list = { "Armadia", "Armadia", "Armadia" }
				to_grow_or_not = 1
			elseif to_grow_or_not == 2 then
				growing_list = { "Armadia", "Armadia", "C_type_Thrustship", "C_type_Thrustship" }
				to_grow_or_not = 1
			elseif to_grow_or_not == 3 then
				growing_list = { "Generic_Victory_Destroyer" }
				to_grow_or_not = 1
			end
			
			if to_grow_or_not == 1 then
				local black_fleet_followers = SpawnList(growing_list, current_planet, Yevetha_player, false, false)
			end
			
			bf_path = Find_Path(Yevetha_player, current_planet, target_planet)
			if bf_path then
				if table.getn(bf_path) > 1 then
					next_planet = bf_path[2]
					if next_planet.Get_Owner().Is_Human() or next_planet.Get_Owner() == Yevetha_player and (next_planet == FindPlanet("Nzoth") or next_planet == FindPlanet("Polneye") or next_planet == FindPlanet("Jtptan") or next_planet == FindPlanet("Doornik") or next_planet == FindPlanet("Prildaz") or next_planet == FindPlanet("Zfell")) then
					--don't move to AI controlled worlds, as the non playable independents will autolose everything if this happens
					--Also allow passage through Yevethan territory, but not through any other independents. Prentioch allowing them free passage is weird.
						current_list = {}
						for index, obj in pairs(black_sword_unit_list) do
							if TestValid(obj) then
								table.insert(current_list, obj)
							end
						end
						black_fleet = Assemble_Fleet(current_list)
						BlockOnCommand(black_fleet.Move_To(next_planet))
						bf_commander = Find_First_Object("Bille_Pride")
						if not TestValid(bf_commander) then
							bf_commander = Find_First_Object("Noorr_Purity")
							if not TestValid(bf_commander) then
								bf_commander = Find_First_Object("Toorr_Devotion")
								if not TestValid(bf_commander) then
									ScriptExit()  --If the SSDs, Allegiance, and VSD hero are dead, it's probably fine for the fleet to give up
								end
							end
						end
						bf_commander.Set_Check_Contested_Space(true)
					end
				end
			end
		end

		Register_Timer(Yev_Loop, GameRandom(35, 80))
	end
end



function Story_Mode_Service()


end

