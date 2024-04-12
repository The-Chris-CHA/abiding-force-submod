--********************************************
--******  Campaign: Caamas Crisis  ***********
--********************************************

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
		Trigger_Caamas_Crisis_Thrawn = State_Caamas_Crisis_Thrawn,
		Trigger_Caamas_Crisis_Which_Thrawn = State_Caamas_Crisis_Which_Thrawn,
		
		-- IR & NR
		Trigger_Caamas_Crisis_ThrawnClone_Destroyed = State_Caamas_Crisis_Peace_Check,
		Trigger_Caamas_Crisis_Flim_Destroyed = State_Caamas_Crisis_Peace_Check,
		Trigger_Caamas_Crisis_Nirauan_Captured = State_Caamas_Crisis_Peace_Check,
		Trigger_Caamas_Crisis_Pellaeon_Destroyed = State_Caamas_Crisis_Pellaeon_Destroyed,
		Trigger_Caamas_Crisis_Peace_Victory = State_Caamas_Crisis_Peace_Victory,

		-- IR
		Trigger_IR_Player_Checker = State_IR_Player_Checker,

		-- NR
		Trigger_NR_Player_Checker = State_NR_Player_Checker,
		
		-- EotH
		Trigger_EOTH_Player_Checker = State_EOTH_Player_Checker,
	}

	p_newrep = Find_Player("Rebel")
	p_empire = Find_Player("Empire")
	p_eoth = Find_Player("EmpireoftheHand")
end

function Delayed_Initialize_Lua(message)
	if message == OnEnter then
		crossplot:galactic()
		crossplot:publish("INITIALIZE_AI", "empty")
		crossplot:publish("NR_ADMIRAL_DECREMENT", 3, 1)
		crossplot:publish("NR_ADMIRAL_DECREMENT", 1, 3)
		crossplot:publish("NR_ADMIRAL_EXIT", {"Bell"}, 1)
		crossplot:publish("NR_ADMIRAL_LOCKIN", {"Mara"}, 3)

		crossplot:publish("NR_FILTER_REMOVE", {"Wedge_Rogues_Location_Set"}, 2)
		Clear_Fighter_Hero("WEDGE_ANTILLES_ROGUE_TEAM")
		Set_Fighter_Hero("TYCHO_CELCHU_ROGUE_TEAM", "GALACTIC_VOYAGER")
		crossplot:publish("NR_FILTER_ADD", {"Tycho_Rogues_Location_Set"}, 2)

		p_empire.Lock_Tech(Find_Object_Type("TURR_PHENNIR_TIE_INTERCEPTOR_LOCATION_SET"))
		Clear_Fighter_Hero("TURR_PHENNIR_TIE_INTERCEPTOR_181ST_SQUADRON")
		Set_Fighter_Hero("MAAREK_STELE_181ST_SQUADRON", "PELLAEON_GRAND_CHIMAERA")
		p_empire.Unlock_Tech(Find_Object_Type("MAAREK_STELE_181ST_LOCATION_SET"))

		Set_To_First_Extant_Host("SOONTIR_FEL_GRAY_LOCATION_SET", p_eoth)
		Set_To_First_Extant_Host("CHAK_FEL_LOCATION_SET", p_eoth)
		p_eoth.Unlock_Tech(Find_Object_Type("CHAK_FEL_LOCATION_SET"))
		p_eoth.Lock_Tech(Find_Object_Type("U_GROUND_PALACE"))		
	else
		crossplot:update()
	end
end

function State_Caamas_Crisis_Thrawn(message)
	if message == OnEnter then
		local HandOfThrawn = Find_First_Object("U_GROUND_PALACE")
		local DisraAndTierce = Find_First_Object("Vilim_Disra") and Find_First_Object("Grodin_Tierce")

		if p_newrep.Is_Human() and (HandOfThrawn or DisraAndTierce) and not (HandOfThrawn and DisraAndTierce) then
			if HandOfThrawn then
				StoryUtil.ChangeAIPlayer(p_empire.Get_Faction_Name(), "None")
			else
				StoryUtil.ChangeAIPlayer(p_eoth.Get_Faction_Name(), "None")
			end
		end

		if HandOfThrawn or DisraAndTierce then
			Story_Event("THRAWN_RETURNS")
		end
	end
end

function State_Caamas_Crisis_Which_Thrawn(message)
	if message == OnEnter then
        local activePlanets = StoryUtil.GetSafePlanetTable()

		local HandOfThrawn = Find_First_Object("U_GROUND_PALACE")

		local Disra = Find_First_Object("Vilim_Disra")
		if Disra ~= nil then
			Disra = TestValid(Disra.Get_Planet_Location())
		end
		local Tierce = Find_First_Object("Grodin_Tierce")
		if Tierce ~= nil then
			Tierce = TestValid(Tierce.Get_Planet_Location())
		end

		local DisraAndTierce = Disra and Tierce

		if HandOfThrawn then
			StoryUtil.SpawnAtSafePlanet("NIRAUAN", p_eoth, activePlanets, {"Thrawn_Clone_Eviscerator"})
		end
		
		if DisraAndTierce then
			Find_First_Object("Grodin_Tierce").Despawn()
			StoryUtil.SpawnAtSafePlanet("BASTION", p_empire, activePlanets, {"Flim_Tierce_Ironhand"})
		end

		if (HandOfThrawn or DisraAndTierce) then
			Story_Event("STOP_MONITOR_PELLAEON_DEATH")
			
			if p_newrep.Is_Human() then
				if not (HandOfThrawn and DisraAndTierce) then
					if HandOfThrawn then
						integrating_player = p_eoth
						integrated_player = p_empire
					else
						integrating_player = p_empire
						integrated_player = p_eoth
					end
					integrating_player.Give_Money(integrated_player.Get_Credits())
					Faction_Total_Replace(integrated_player,integrating_player,2)	
					Story_Event("NR_ONE_THRAWN")
				else
					Story_Event("NR_TWO_THRAWNS")
					Set_Fighter_Hero("MAAREK_STELE_181ST_SQUADRON", "FLIM_TIERCE_IRONHAND")
					Defection(p_empire,p_eoth,{"Pellaeon_Grand_Chimaera"},activePlanets)				
				end
			elseif p_empire.Is_Human() then
				if not (HandOfThrawn and DisraAndTierce) then
					if HandOfThrawn then
						Defection(p_empire,p_eoth,{"Hestiv"},activePlanets)
						Story_Event("IR_CLONE_THRAWN")
					else
						Set_Fighter_Hero("SOONTIR_FEL_GRAY_SQUADRON", "STENT_THRAWNS_HAND")
						Defection(p_eoth,p_empire,{"Niriz_Admonitor"},activePlanets)
						Set_Fighter_Hero("MAAREK_STELE_181ST_SQUADRON", "FLIM_TIERCE_IRONHAND")
						Defection(p_empire,p_eoth,{"Pellaeon_Grand_Chimaera"},activePlanets)
						Story_Event("IR_IMPOSTER_THRAWN")
					end
				else
					Set_Fighter_Hero("MAAREK_STELE_181ST_SQUADRON", "FLIM_TIERCE_IRONHAND")
					Defection(p_empire,p_eoth,{"Pellaeon_Grand_Chimaera"},activePlanets)
					Story_Event("IR_IMPOSTER_THRAWN")
				end
			else
				if not (HandOfThrawn and DisraAndTierce) then
					if HandOfThrawn then
						Defection(p_empire,p_eoth,{"Hestiv"},activePlanets)
						Story_Event("EOTH_CLONE_THRAWN")
					else
						Set_Fighter_Hero("SOONTIR_FEL_GRAY_SQUADRON", "STENT_THRAWNS_HAND")
						Defection(p_eoth,p_empire,{"Niriz_Admonitor"},activePlanets)
						Set_Fighter_Hero("MAAREK_STELE_181ST_SQUADRON", "FLIM_TIERCE_IRONHAND")
						Defection(p_empire,p_eoth,{"Pellaeon_Grand_Chimaera"},activePlanets)
						Story_Event("EOTH_IMPOSTER_THRAWN")
					end
				else
					Set_Fighter_Hero("MAAREK_STELE_181ST_SQUADRON", "FLIM_TIERCE_IRONHAND")
					Defection(p_empire,p_eoth,{"Pellaeon_Grand_Chimaera"},activePlanets)
					Story_Event("IR_IMPOSTER_THRAWN")
				end
			end

			Story_Event("RESUME_MONITOR_PELLAEON_DEATH")
		end

		p_eoth.Unlock_Tech(Find_Object_Type("U_GROUND_PALACE"))
	end
end

function Defection(abandoned_player,joined_player,list,planetlist)
	for _, unit_name in pairs(list) do
		local unit_instance = Find_First_Object(unit_name)
		local relevant_unit_name = get_relevant_object(unit_instance).Get_Type().Get_Name()
		if TestValid(unit_instance) then
			unit_instance.Despawn()
		end
		
		StoryUtil.SpawnAtSafePlanet(nil, joined_player, planetlist, {relevant_unit_name})
	end
end

-- Empire & New Republic

function State_Caamas_Crisis_Peace_Check(message)
	if message == OnEnter then	
		if GlobalValue.Get("Caamas_Treaty_Lock_Resolved") == 1 then
			return
		end

		if p_eoth.Is_Human() then
			GlobalValue.Set("Caamas_Treaty_Lock_Resolved", 1)
			return
		end

		if not Find_First_Object("Pellaeon_Grand_Chimaera") then
			GlobalValue.Set("Caamas_Treaty_Lock_Resolved", 1)
			return
		end

		local ThrawnClone = Find_First_Object("Thrawn_Clone_Eviscerator")
		local Flim = Find_First_Object("Flim_Tierce_Ironhand")
		local NirauanOwner = FindPlanet("Nirauan").Get_Owner()
		local p_human = Find_Player("local")
		
		if ThrawnClone or Flim or NirauanOwner ~= p_human then
			return
		end
		
		if p_human == p_empire then
			Story_Event("IR_DOCUMENT_FOUND")
			p_empire.Unlock_Tech(Find_Object_Type("DUMMY_TREATY_VICTORY"))			
		else
			Story_Event("NR_DOCUMENT_FOUND")
			p_newrep.Unlock_Tech(Find_Object_Type("DUMMY_TREATY_VICTORY"))
		end
		
		GlobalValue.Set("Caamas_Treaty_Lock_Resolved", 1)
	end
end

function State_Caamas_Crisis_Pellaeon_Destroyed(message)
	if message == OnEnter then	
		GlobalValue.Set("Caamas_Treaty_Lock_Resolved", 1)
		
		if p_empire.Is_Human() then
			Story_Event("IR_PELLAEON_KILLED")	
		elseif p_newrep.Is_Human() then
			Story_Event("NR_PELLAEON_KILLED")
		end
	end
end

function State_Caamas_Crisis_Peace_Victory(message)
	if message == OnEnter then
		StoryUtil.DeclareVictory(Find_Player("local"),true)
	end
end

-- Empire

function State_IR_Player_Checker(message)
    if message == OnEnter then
		if p_empire.Is_Human() then
			Story_Event("IR_STORY_START")

			Sleep(4.0)
			gc_start = true
		end
    end
end

-- New Republic

function State_NR_Player_Checker(message)
    if message == OnEnter then
		if p_newrep.Is_Human() then
			Story_Event("NR_STORY_START")

			Sleep(4.0)
			gc_start = true
		end
    end
end

-- Empire of the Hand

function State_EOTH_Player_Checker(message)
    if message == OnEnter then
		if p_eoth.Is_Human() then
			Story_Event("EOTH_STORY_START")

			Sleep(4.0)
			gc_start = true
		end
    end
end