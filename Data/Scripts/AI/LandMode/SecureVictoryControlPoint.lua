-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/LandMode/SecureVictoryControlPoint.lua#2 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/LandMode/SecureVictoryControlPoint.lua $
--
--    Original Author: James Yarrow
--
--            $Author: James_Yarrow $
--
--            $Change: 44927 $
--
--          $DateTime: 2006/05/23 17:53:49 $
--
--          $Revision: #2 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("pgevents")

function Definitions()

	Category = "Secure_Victory_Control_Point"
	IgnoreTarget = false
	MaxContrastScale = 1.5
	TaskForce = 
	{
		{
			"MainForce"
			,"Infantry = 1, 20"
			,"-B2_RP_Team"
			,"-Clone_Jumptrooper_One_Team"
			,"-Clone_Jumptrooper_Two_Team"
			,"-Mando_Commando_Team"
			,"-Jumptrooper_Team"
		},
		{
			"EscortForce"	
			,"Vehicle | Air | LandHero = 0, 20"
			,"EscortForce"
			,"-Republic_AV7"
			,"-HAG"
			,"-CA_Artillery"
			,"-MAL_Rocket_Vehicle"
			,"-Plasma_Mortar"
			,"-Hapan_Artillery"
			,"-SPMAG_Walker"
			,"-SPMAT_Walker"
			,"-Imperial_Light_Artillery"
			,"-Imperial_Heavy_Artillery"
			,"-Imperial_Missile_Artillery"
			,"-MPTL"
			,"-Mando_Artillery_Platform"
			,"-VX_Artillery_Droid"
			,"-Sith_Krath_Artillery"
		}
	}

	RequiredCategories = { "Infantry" }
end

function MainForce_Thread()
	BlockOnCommand(MainForce.Produce_Force())
	
	QuickReinforce(PlayerObject, AITarget, MainForce, EscortForce)
	
	Set_Land_AI_Targeting_Priorities(MainForce)
	-- move to contestables
	BlockOnCommand(MainForce.Attack_Move(AITarget))
	
	MainForce.Set_As_Goal_System_Removable(false)
					
	-- Stand guard so that we can retain usage of this structure
	MainForce.Guard_Target(AITarget)
	Sleep(30)

	MainForce.Set_Plan_Result(true)

	ScriptExit()
end

-- Override default handling, which will kill the plan
function MainForce_Original_Target_Owner_Changed(tf, old_player, new_player)
end


function EscortForce_Thread()
	BlockOnCommand(EscortForce.Produce_Force())
	
	QuickReinforce(PlayerObject, AITarget, EscortForce, MainForce)
	
	Set_Land_AI_Targeting_Priorities(EscortForce)
	-- Give an initial order to put the escorts in a state that the Escort function expects
	Try_Ability(EscortForce, "FORCE_CLOAK")
	EscortForce.Guard_Target(MainForce)

	EscortAlive = true
	while EscortAlive do
		Escort(EscortForce, MainForce)
	end
end

function EscortForce_No_Units_Remaining()
	EscortAlive = false
end

-- Override default handling, which will kill the plan
function EscortForce_Original_Target_Owner_Changed(tf, old_player, new_player)
end