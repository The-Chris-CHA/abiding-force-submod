-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/SpaceMode/BombingRun.lua#3 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/SpaceMode/BombingRun.lua $
--
--    Original Author: Steve_Copeland
--
--            $Author: James_Yarrow $
--
--            $Change: 52287 $
--
--          $DateTime: 2006/08/22 10:41:09 $
--
--          $Revision: #3 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("pgevents")

function Definitions()

	AllowEngagedUnits = false
	IgnoreTarget = true
	Category = "Bomb_Unit"
	TaskForce = {
	{
		"BomberForce"						
		,"Bomber = 2,5"
	},
	{
		"FighterForce"		
		,"Fighter = 2,4"
	}
	}

	time_to_drop_bombs = 2
	bombers_reinforced = false
	send_fighters = false
	
end

function BomberForce_Thread()

	BlockOnCommand(BomberForce.Produce_Force())
	BomberForce.Set_As_Goal_System_Removable(false)

	QuickReinforce(PlayerObject, AITarget, BomberForce, FighterForce)
	bombers_reinforced = true
	
	-- Do some setup if the bombers arent' already too close
	-- Also, don't bother with this setup if the tactical game is well underway
	if (BomberForce.Get_Distance(FighterForce) > 200) and (BomberForce.Get_Distance(AITarget) > 2000) then
	
		DebugMessage("%s -- bomber force setting up for escort", tostring(Script))
	
		BomberForce.Set_Targeting_Priorities("Bomber_Hit_And_Run", "Bomber")
		send_fighters = true

		BomberForce.Activate_Ability("SPOILER_LOCK", true)
		
		run_target = FindTarget(BomberForce, "Space_Area_Is_Friendly", "Tactical_Location", 0.8, 300.0)
		
		if run_target then
			DebugMessage("%s -- hiding until escort", tostring(Script))
			BlockOnCommand(BomberForce.Move_To(run_target, BomberForce.Get_Self_Threat_Max()))
		end
		
	end
	
	while send_fighters do
		DebugMessage("%s -- bomber force waiting for escort", tostring(Script))
		Sleep(1)
	end

	DebugMessage("bomber force target: %s", tostring(AITarget))
	BlockOnCommand(BomberForce.Attack_Target(AITarget, BomberForce.Get_Self_Threat_Max()))
end


-- Handle a hardpoint achieving range on the attack target
function BomberForce_Hardpoint_Target_In_Range(tf, unit, target)

	BomberForce.Activate_Ability("SPOILER_LOCK", false)

	-- Create a timer for this squadron to flee after it's had a chance to drop the rest of it's bombs
	Register_Timer(Repeat_Attack, time_to_drop_bombs, unit)
end


function Repeat_Attack(unit)
	DebugMessage("%s -- bomber force repeating attack", tostring(Script))
	run_target = FindTarget(BomberForce, "Space_Area_Is_Friendly", "Tactical_Location", 0.8, 300.0)
	if run_target then
		MessageBox("%s %.3f -- Bomber squad fleeing to %s.", tostring(Script), GetCurrentTime(), tostring(run_target))
		GoKite(BomberForce, unit, run_target, false)
		Sleep(5)
	end
	
	BomberForce.Attack_Target(AITarget)
	
	-- Once one attack is done, we'll let desirability drops end the plan
	BomberForce.Set_As_Goal_System_Removable(true)
end


function FighterForce_Thread()
	BlockOnCommand(FighterForce.Produce_Force())

	QuickReinforce(PlayerObject, AITarget, FighterForce, BomberForce)

   	SetClassPriorities(FighterForce, "Attack_Move")
   	
	Try_Ability(FighterForce, "STEALTH")
	
	while not bombers_reinforced do
		DebugMessage("%s -- fighter force waiting for bombers", tostring(Script))
		reinforce_target = FindTarget(FighterForce, "Space_Area_Is_Friendly", "Tactical_Location", 0.8, 300.0)
		if reinforce_target then
			DebugMessage("%s -- fighter force moving to safe location", tostring(Script))
			BlockOnCommand(FighterForce.Move_To(reinforce_target), -1, Bombers_Have_Reinforced)
		else
			Sleep(1)
		end
	end
	
	FighterForce.Guard_Target(BomberForce)
	
	send_fighters = false

	while not send_fighters do
		Escort(FighterForce, BomberForce)
	end

end

function Bombers_Have_Reinforced()
	return bombers_reinforced
end


function BomberForce_Original_Target_Destroyed()
	DebugMessage("%s-- killed plan because original target destroyed", tostring(Script))
	ScriptExit()
end

function FighterForce_Original_Target_Destroyed()
	DebugMessage("%s-- killed plan because original target destroyed", tostring(Script))
	ScriptExit()
end
