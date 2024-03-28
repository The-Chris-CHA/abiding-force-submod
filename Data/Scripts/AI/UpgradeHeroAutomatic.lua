-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/GenerateMagicSpaceDefense.lua#2 $
--/////////////////////////////////////////////////////////////////////////////////////////////////
--
-- (C) Petroglyph Games, Inc.
--
--
--  *****           **                          *                   *
--  *   **          *                           *                   *
--  *    *          *                           *                   *
--  *    *          *     *                 *   *          *        *
--  *   *     *** ******  * **  ****      ***   * *      * *****    * ***
--  *  **    *  *   *     **   *   **   **  *   *  *    * **   **   **   *
--  ***     *****   *     *   *     *  *    *   *  *   **  *    *   *    *
--  *       *       *     *   *     *  *    *   *   *  *   *    *   *    *
--  *       *       *     *   *     *  *    *   *   * **   *   *    *    *
--  *       **       *    *   **   *   **   *   *    **    *  *     *   *
-- **        ****     **  *    ****     *****   *    **    ***      *   *
--                                          *        *     *
--                                          *        *     *
--                                          *       *      *
--                                      *  *        *      *
--                                      ****       *       *
--
--/////////////////////////////////////////////////////////////////////////////////////////////////
-- C O N F I D E N T I A L   S O U R C E   C O D E -- D O   N O T   D I S T R I B U T E
--/////////////////////////////////////////////////////////////////////////////////////////////////
--
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/GenerateMagicSpaceDefense.lua $
--
--    Original Author: James Yarrow
--
--            $Author: James_Yarrow $
--
--            $Change: 53991 $
--
--          $DateTime: 2006/09/08 11:01:51 $
--
--          $Revision: #2 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("pgevents")


function Definitions()	
	Category = "Upgrade_SSD_Hero"	
	TaskForce = {
	{
		"ReserveForce"
		,"DenyHeroAttach"
		,"TaskForceRequired"
	}
	}
	AllowFreeStoreUnits = false
end

function ReserveForce_Thread()
	ReserveForce.Set_As_Goal_System_Removable(false)
	
	local faction = PlayerObject.Get_Faction_Name()
	
	if faction == "EMPIRE" then
		Cycle_Hero("Ysanne_Isard", "Lusankya")
	elseif faction == "PENTASTAR" then
		Cycle_Hero("Ardus_Kaine", "Reaper_Kaine")
	elseif faction == "ERIADU_AUTHORITY" then
		Cycle_Hero("Delvardus_Brilliant", "Night_Hammer_Delvardus")
	elseif faction == "ZSINJ_EMPIRE" then
		Cycle_Hero("Iron_Fist_VSD", "Iron_Fist")
	else
		DebugMessage("%s -- Invalid faction, aborting", tostring(Script))
		ScriptExit()
	end
end

function Cycle_Hero(hero_name, ssd)
	hero = Find_First_Object(hero_name)

	if TestValid(hero) then
		local new_transport = Spawn_Unit(Find_Object_Type(ssd), Target, PlayerObject)
		hero.Despawn()
		new_transport[1].Prevent_AI_Usage(false)
		PlayerObject.Give_Money(-22500)
		ReserveForce.Set_Plan_Result(true)
		ScriptExit()
	else
		DebugMessage("%s -- hero %s not found, aborting", tostring(Script), tostring(hero_name))
		ScriptExit()
	end
end