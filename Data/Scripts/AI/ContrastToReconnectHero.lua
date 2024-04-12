-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/ContrastToReconnect.lua#1 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/ContrastToReconnect.lua $
--
--    Original Author: Steve_Copeland
--
--            $Author: Andre_Arsenault $
--
--            $Change: 37816 $
--
--          $DateTime: 2006/02/15 15:33:33 $
--
--          $Revision: #1 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

ScriptPoolCount = 4

require("pgevents")

--
-- Galactic Mode Contrast To Reconnect Islands of Nodes Script
--

function Definitions()
	DebugMessage("%s -- In Definitions", tostring(Script))
	MaxContrastScale = 2.0
	
	Category = "Conquer_To_Reconnect"
	TaskForce = {
	-- First Task Force
	{
		"SpaceForce"						
		,"MinimumTotalSize = 20"				
		,"Corvette | Frigate | Capital = 100%"
		,"AntiBomber = 0, 50"
		,"Gunship = 0,10"
		,"SuperCapital = 0, 1"
		,"SpaceHero = 0, 2"
	},
	{
		"GroundForce"
		,"MinimumTotalSize = 15"			
		,"Vehicle | Infantry | Air = 100%"
		,"LandHero = 0, 2"
	}
	}
	RequiredCategories = { "Infantry", "AntiBomber", "Frigate | Capital" }		--Must have at least one ground unit, also make sure space force is reasonable

	PerFailureContrastAdjust = 0.5
	
	SpaceSecured = true
	LandSecured = false
	InSpaceConflict = false
	WasConflict = false
	
	DebugMessage("%s -- Done Definitions", tostring(Script))
end

function SpaceForce_Thread()
	DebugMessage("%s -- In SpaceForce_Thread.", tostring(Script))

	-- Since we're using plan failure to adjust contrast, we're 
	-- only concerned with failures in battle. Default the 
	-- plan to successful and then 
	-- only on the event of our task force being killed is the
	-- plan set to a failed state.
	SpaceForce.Set_Plan_Result(true)
		
	SpaceSecured = false

	if SpaceForce.Are_All_Units_On_Free_Store() == true then
		DebugMessage("SpaceForce converged on target (disconnecting node)")
		GlobalValue.Set("CONQUER_OPPONENT", Target.Get_Type().Get_Name())
		SynchronizedAssemble(SpaceForce)
		WasConflict = true
	else
		DebugMessage("%s -- Can't freestore allocate all our units, so just allocating build tasks.", tostring(Script))
		BlockOnCommand(SpaceForce.Produce_Force());
		return
	end
	
	if EvaluatePerception("Is_Good_Ground_Grab_Target", PlayerObject, Target) == 0 then
		DebugMessage("%s -- No SpaceForce at target and enemies still present in space.  Abandonning plan.", tostring(Script))
		SpaceForce.Set_Plan_Result(false)
		Exit_Plan_With_Possible_Sleep(GroundForce, SpaceForce)
	else
		DebugMessage("%s -- No SpaceForce, but Space at target appears clear anyway.", tostring(Script))
		SpaceSecured = true
	end
	
	while not LandSecured do
		Sleep(5)
	end
	
	Release_Excess_Spaceforce(SpaceForce, PlayerObject, Target)
	DebugMessage("%s -- SpaceForce Done!  Exiting Script!", tostring(Script))
end

function GroundForce_Thread()
	DebugMessage("%s -- In GroundForce_Thread.", tostring(Script))

	GroundForce.Set_Plan_Result(true)

	if GroundForce.Are_All_Units_On_Free_Store() == true then

		DebugMessage("%s -- GroundForce waiting for the space force to succede.", tostring(Script))
		while not SpaceSecured do
			if WasConflict then
				Exit_Plan_With_Possible_Sleep(GroundForce, SpaceForce)
			end
			Sleep(1)
		end
		DebugMessage("%s -- converging ground units on the target.", tostring(Script))
		SynchronizedAssemble(GroundForce)
	else
		DebugMessage("%s -- Can't freestore allocate all our units, so just allocating build tasks.", tostring(Script))
		BlockOnCommand(GroundForce.Produce_Force());
		return
	end
		
	WasConflict = true
	if Invade(GroundForce) == false then
		DebugMessage("%s -- Curses...The invasion failed!  Exiting Script!", tostring(Script))
		Exit_Plan_With_Possible_Sleep(GroundForce, SpaceForce)
	end

	DebugMessage("%s -- Political control changed building Ground and Starbase.", tostring(Script))
	LandSecured = true
	GroundForce.Set_Plan_Result(true)
	FundBases(PlayerObject, Target)
	Exit_Plan_With_Possible_Sleep(GroundForce, SpaceForce)
end

function SpaceForce_Production_Failed(tf, failed_object_type)
	DebugMessage("%s -- Abandonning plan owing to production failure.", tostring(Script))
	ScriptExit()
end

function GroundForce_Production_Failed(tf, failed_object_type)
	DebugMessage("%s -- Abandonning plan owing to production failure.", tostring(Script))
	ScriptExit()
end

function GroundForce_Original_Target_Owner_Changed(tf, old_owner, new_owner)	
	--Ignore changes to neutral - it might just be temporary on the way to
	--passing into my control.
	if new_owner ~= PlayerObject and new_owner.Is_Neutral() == false then
		if (not LandSecured) or (PlayerObject.Get_Difficulty() == "Hard") then
			ScriptExit()
		end
	end
end

function SpaceForce_Original_Target_Owner_Changed(tf, old_owner, new_owner)	
	--Ignore changes to neutral - it might just be temporary on the way to
	--passing into my control.
	if new_owner ~= PlayerObject and new_owner.Is_Neutral() == false then
		if (not LandSecured) or (PlayerObject.Get_Difficulty() == "Hard") then
			ScriptExit()
		end
	end
end

function SpaceForce_No_Units_Remaining()
	if not LandSecured then
		DebugMessage("%s -- All units dead or non-buildable.  Abandonning plan.", tostring(Script))
		SpaceForce.Set_Plan_Result(false) 
		--Don't exit since we need to sleep to enforce delays between AI attacks (can't be done inside an event handler)
	end
end

function GroundForce_No_Units_Remaining()
	if not LandSecured then
		DebugMessage("%s -- All units dead or non-buildable.  Abandonning plan.", tostring(Script))
		GroundForce.Set_Plan_Result(false) 
		--Don't exit since we need to sleep to enforce delays between AI attacks (can't be done inside an event handler)
	end
end

