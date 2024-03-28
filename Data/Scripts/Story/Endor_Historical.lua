--////////////////////////////////////////////////
-- Battle of Endor Mission (New Republic)
--////////////////////////////////////////////////

require("PGStoryMode")
require("PGSpawnUnits")
require("PGMoveUnits")



function Definitions()

	DebugMessage("%s -- In Definitions", tostring(Script))
	
	StoryModeEvents = 
	{
		Battle_Start = Begin_Battle,
		Wave2_Spawn = More_Foes
	}
end


function Begin_Battle(message)
	if message == OnEnter then
		empire = Find_Player("Empire")
		rebels = Find_Player("Rebel")
		attacker_entry_marker = Find_First_Object("Attacker Entry Position")
		defender_entry_marker = Find_First_Object("Defending Forces Position")
		
		defending_fleet = {"Skirmish_Generic_Nebulon_B", "Skirmish_CR90", "Skirmish_Generic_Nebulon_B", "Skirmish_CR90", "Skirmish_Home_One_Type", "Skirmish_CR90", "Calamari_Cruiser", "Calamari_Cruiser", "Calamari_Cruiser", "Home_One"}
		
		local defenders = Find_Player("Rebel")
		
		local rebels = SpawnList(defending_fleet, defender_entry_marker, defenders, true, true)
		
		
		invading_fleet = {"Skirmish_Star_Destroyer_Two", "Pride_of_Tarlandia", "Skirmish_Dreadnaught_Empire", "Skirmish_Victory_Destroyer", "Skirmish_Vindicator_Cruiser", "Skirmish_Carrack_Cruiser"}
		
		local invaders = Find_Player("Hostile")
		
		local imps = SpawnList(invading_fleet, attacker_entry_marker, invaders, true, true)
		
		
		ackbar = Find_First_Object("Home_One")
		ackbar.Highlight(true)
		Add_Radar_Blip(ackbar, "ackbar")
	end
end

function More_Foes(message)
	if message == OnEnter then
		empire = Find_Player("Empire")
		rebels = Find_Player("Rebel")
		attacker_entry_marker = Find_First_Object("Attacker Entry Position")
		
		invading_fleet_2 = {"Skirmish_Star_Destroyer_Two", "Skirmish_Lancer_Frigate", "Skirmish_Lancer_Frigate", "Skirmish_Dreadnaught_Empire", "Generic_Executor", "Skirmish_Victory_Destroyer_Two"}
		
		local invaders = Find_Player("Hostile")
		
		local imps = SpawnList(invading_fleet_2, attacker_entry_marker, invaders, true, true)
	end
end

function spawnFleet(param)
  local self = param[1]
  self.spawnList = SpawnList(param[2], param[3], param[4], true, true)
end
