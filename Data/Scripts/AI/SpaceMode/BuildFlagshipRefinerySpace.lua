-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/SpaceMode/BuildRefinerySpace.lua#2 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/SpaceMode/BuildRefinerySpace.lua $
--
--    Original Author: Steve Copeland
--
--            $Author: James_Yarrow $
--
--            $Change: 46312 $
--
--          $DateTime: 2006/06/15 13:55:40 $
--
--          $Revision: #2 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("pgevents")


function Definitions()
	
	Category = "Build_Flagship_Refinery_Space"
	IgnoreTarget = true
	TaskForce = {
	{
		"MainForce"
		,"FS_UC_Mineral_Extractor = 1"
	}
	}
--	RequiredCategories = {"Structure"}
	AllowFreeStoreUnits = false
	good_pad = nil
	pad = nil
	refinery = nil

end

function MainForce_Thread()

	-- Make sure we use a build pad that's not too near to the enemy base
	nearby_pad_list = MainForce.Get_Reserved_Build_Pads()
	for i, pad in pairs(nearby_pad_list) do
		if EvaluatePerception("Distance_To_Nearest_Enemy_Starbase", PlayerObject, pad) > 3000 then
			good_pad = pad
			break
		end
	end
	
	if good_pad then 
	
		MainForce.Build("FS_UC_Mineral_Extractor", good_pad)
		-- Make sure we track the results	
		MainForce.Set_As_Goal_System_Removable(false)
	
		-- If it survives X seconds, consider it a successful plan
		Sleep(1)
		if TestValid(good_pad) then
			refinery = good_pad.Get_Build_Pad_Contents()
			if TestValid(refinery) then
				MainForce.Set_Plan_Result(true)
			end
		end
	else
		-- This plan/target sucks. Pause for a moment, then release the allocated cash.
		Sleep(5)
	end
	
	ScriptExit()
end



