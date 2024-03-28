-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/SpaceMode/TacticalMultiplayerBuildSpaceUnitsGeneric.lua#5 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/SpaceMode/TacticalMultiplayerBuildSpaceUnitsGeneric.lua $
--
--    Original Author: James Yarrow
--
--            $Author: James_Yarrow $
--
--            $Change: 54441 $
--
--          $DateTime: 2006/09/13 15:08:39 $
--
--          $Revision: #5 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("pgevents")
						
function Definitions()

	Category = "Tactical_Multiplayer_Build_Space_Units_Flagship"
	IgnoreTarget = true
	TaskForce = {
		{
		"ReserveForce"
		,"Flagship_NR_AAA | Flagship_NR_AAB | Flagship_NR_AAC | Flagship_NR_AAG | Flagship_NR_AAH | Flagship_NR_AAK | Flagship_NR_AAL | Flagship_NR_AAM | Flagship_NR_AAN | Flagship_NR_AAW | Flagship_NR_AAX = 0, 5"
		,"Flagship_NR_AAD | Flagship_NR_AAE | Flagship_NR_AAF | Flagship_NR_AAO | Flagship_NR_AAP | Flagship_NR_AAQ | Flagship_NR_AAT | Flagship_NR_AAY = 0, 4" 
		,"Flagship_NR_AAI | Flagship_NR_ABI | Flagship_NR_AAJ | Flagship_NR_AAR | Flagship_NR_AAS | Flagship_NR_AAU | Flagship_NR_AAV = 0, 5" 
		,"Flagship_NR_AAZ | Flagship_NR_ABA | Flagship_NR_ABB | Flagship_NR_ABC | Flagship_NR_ABD | Flagship_NR_ABE = 0, 2"
		,"Flagship_NR_ABF | Flagship_NR_ABG | Flagship_NR_ABH = 0, 2"
		
		,"Flagship_IR_AAA | Flagship_IR_AAE | Flagship_IR_AAI | Flagship_IR_AAK | Flagship_IR_AAR = 0, 5"
		,"Flagship_IR_AAB | Flagship_IR_AAC | Flagship_IR_AAD | Flagship_IR_AAG | Flagship_IR_AAQ | Flagship_IR_AAW = 0, 4" 
		,"Flagship_IR_AAF | Flagship_IR_AAH | Flagship_IR_AAJ | Flagship_IR_AAL | Flagship_IR_AAM | Flagship_IR_AAN | Flagship_IR_AAO | Flagship_IR_AAP = 0, 5" 
		,"Flagship_IR_AAS | Flagship_IR_AAT = 0, 2"
		,"Flagship_IR_AAU | Flagship_IR_AAV = 0, 2"
		
		,"Flagship_EOTH_AAA | Flagship_EOTH_AAB | Flagship_EOTH_AAE | Flagship_EOTH_AAI = 0, 5"
		,"Flagship_EOTH_AAC | Flagship_EOTH_AAD = 0, 4" 
		,"Flagship_EOTH_AAF | Flagship_EOTH_AAG | Flagship_EOTH_AAH | Flagship_EOTH_AAJ | Flagship_EOTH_AAK | Flagship_EOTH_AAL = 0, 5" 
		,"Flagship_EOTH_AAM | Flagship_EOTH_AAN | Flagship_EOTH_AAO | Flagship_EOTH_AAP = 0, 2"
		,"Flagship_EOTH_AAQ = 0, 2"
		
		,"Flagship_EA_AAA | Flagship_EA_AAB | Flagship_EA_AAH | Flagship_EA_AAL | Flagship_EA_AAN = 0, 5"
		,"Flagship_EA_AAC | Flagship_EA_AAD | Flagship_EA_AAE | Flagship_EA_AAI | Flagship_EA_AAK = 0, 4" 
		,"Flagship_EA_AAF | Flagship_EA_AAG | Flagship_EA_AAJ | Flagship_EA_AAM  = 0, 5" 
		,"Flagship_EA_AAO | Flagship_EA_AAP | Flagship_EA_AAQ = 0, 2"
		,"Flagship_EA_AAQ | Flagship_EA_AAS | Flagship_EA_AAT | Flagship_EA_AAU | Flagship_EA_AAV = 0, 2"
		
		,"Flagship_PA_AAA | Flagship_PA_AAB | Flagship_PA_AAC | Flagship_PA_AAH | Flagship_PA_AAL | Flagship_PA_AAO = 0, 5"
		,"Flagship_PA_AAD | Flagship_PA_AAE | Flagship_PA_AAF | Flagship_PA_AAG | Flagship_PA_AAN = 0, 4" 
		,"Flagship_PA_AAI | Flagship_PA_AAJ | Flagship_PA_AAK | Flagship_PA_AAM = 0, 5" 
		,"Flagship_PA_AAP | Flagship_PA_AAQ = 0, 2"
		,"Flagship_PA_AAR | Flagship_PA_AAS = 0, 2"
		
		,"Flagship_GM_AAA | Flagship_GM_AAC | Flagship_GM_AAB | Flagship_GM_AAN = 0, 5"
		,"Flagship_GM_AAD | Flagship_GM_AAD | Flagship_GM_AAF | Flagship_GM_AAI = 0, 4" 
		,"Flagship_GM_AAG | Flagship_GM_AAH | Flagship_GM_AAJ | Flagship_GM_AAK | Flagship_GM_AAL | Flagship_GM_AAM = 0, 5" 
		,"Flagship_GM_AAO = 0, 2"
		,"Flagship_GM_AAP | Flagship_GM_AAQ = 0, 2"
		
		,"Flagship_Zsinj_AAA | Flagship_Zsinj_AAB | Flagship_Zsinj_AAC | Flagship_Zsinj_AAL | Flagship_Zsinj_AAQ  = 0, 5"
		,"Flagship_Zsinj_AAD | Flagship_Zsinj_AAE | Flagship_Zsinj_AAG | Flagship_Zsinj_AAH | Flagship_Zsinj_AAK | Flagship_Zsinj_AAF = 0, 4" 
		,"Flagship_Zsinj_AAI | Flagship_Zsinj_AAJ | Flagship_Zsinj_AAM | Flagship_Zsinj_AAN = 0, 5" 
		,"Flagship_Zsinj_AAO | Flagship_Zsinj_AAP = 0, 2"
		,"Flagship_Zsinj_AAR | Flagship_Zsinj_AAS = 0, 2"	
		
		,"Flagship_CSA_AAA | Flagship_CSA_AAB | Flagship_CSA_AAC | Flagship_CSA_AAU | Flagship_CSA_AAG | Flagship_CSA_AAN | Flagship_CSA_AAP = 0, 5"
		,"Flagship_CSA_AAD | Flagship_CSA_AAE | Flagship_CSA_AAF = 0, 4" 
		,"Flagship_CSA_AAH | Flagship_CSA_AAI | Flagship_CSA_AAJ | Flagship_CSA_AAK | Flagship_CSA_AAL | Flagship_CSA_AAM | Flagship_CSA_AAO = 0, 5" 
		,"Flagship_CSA_AAQ | Flagship_CSA_AAR = 0, 2"
		,"Flagship_CSA_AAS | Flagship_CSA_AAT = 0, 2"
		
		,"Flagship_HAPES_AAA | Flagship_HAPES_AAF = 0,5"
		,"Flagship_HAPES_AAB | Flagship_HAPES_AAC | Flagship_HAPES_AAD | Flagship_HAPES_AAE = 0, 4"
		,"Flagship_HAPES_AAG | Flagship_HAPES_AAH | Flagship_HAPES_AAI = 0, 5"
		,"Flagship_HAPES_AAJ | Flagship_HAPES_AAK | Flagship_HAPES_AAL = 0, 2"
		,"Flagship_HAPES_AAM = 0, 2"
		
		}
	}
	
	AllowFreeStoreUnits = false

end

function ReserveForce_Thread()
			
	BlockOnCommand(ReserveForce.Produce_Force())
	ReserveForce.Set_Plan_Result(true)
	ReserveForce.Set_As_Goal_System_Removable(false)
		
	-- Give some time to accumulate money.
	tech_level = PlayerObject.Get_Tech_Level()
	max_sleep_seconds = 60
	max_cash_on_hand = 6000
	if tech_level == 2 then
		max_sleep_seconds = 60
		max_cash_on_hand = 8000
	elseif tech_level == 3 then
		max_sleep_seconds = 60
		max_cash_on_hand = 10000
	elseif tech_level == 4 then
		max_sleep_seconds = 60
		max_cash_on_hand = 15000
	elseif tech_level == 5 then
		max_sleep_seconds = 60
		max_cash_on_hand = 20000
	end
	
	current_sleep_seconds = 0
	while (current_sleep_seconds < max_sleep_seconds) do
		current_sleep_seconds = current_sleep_seconds + 1
		Sleep(1)
	end

	ScriptExit()
end