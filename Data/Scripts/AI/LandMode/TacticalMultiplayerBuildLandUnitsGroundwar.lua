require("pgevents")


function Definitions()
	
	Category = "Tactical_Multiplayer_Build_Land_Units_GroundWar"
	IgnoreTarget = true
	TaskForce = {
	{
		"ReserveForce"
	
		,"GW_IR_AAA |	GW_IR_AAB |	GW_IR_AAC |	GW_IR_AAD |	GW_IR_AAE |	GW_IR_AAH |	GW_IR_AAI |	GW_IR_AAJ |	GW_IR_AAO |	GW_IR_AAQ	= 0,5"
		,"GW_IR_AAF |	GW_IR_AAN 	= 0,3"								
		,"GW_IR_AAG |	GW_IR_AAK |	GW_IR_AAL |	GW_IR_AAP	= 0,3"
		,"GW_IR_AAR |	GW_IR_AAS |	GW_IR_AAT |	GW_IR_AAX |	GW_IR_AAY |	GW_IR_ABA= 0,1"
		,"GW_IR_AAM |	GW_IR_AAU |	GW_IR_AAV |	GW_IR_AAZ	= 0,2"
		
		,"GW_NR_AAA |	GW_NR_AAB |	GW_NR_AAC |	GW_NR_AAD |	GW_NR_AAH |	GW_NR_AAI |	GW_NR_AAM = 0,5"
		,"GW_NR_AAE |	GW_NR_AAG |	GW_NR_AAL	= 0,3"
		,"GW_NR_AAF |	GW_NR_AAJ	= 0,3"
		,"GW_NR_AAN |	GW_NR_AAO |	GW_NR_AAQ |	GW_NR_AAS	= 0,1"	
		,"GW_NR_AAK |	GW_NR_AAP |	GW_NR_AAR |	GW_NR_AAT	= 0,2"	
		
		,"GW_PA_AAA |	GW_PA_AAB |	GW_PA_AAC |	GW_PA_AAD |	GW_PA_AAF |	GW_PA_AAK |	GW_PA_AAL |	GW_PA_AAM |	GW_PA_AAQ	= 0,5"	
		,"GW_PA_AAE |	GW_PA_AAG	= 0,3"								
		,"GW_PA_AAH |	GW_PA_AAJ	= 0,3"							
		,"GW_PA_AAO |	GW_PA_AAP	= 0,1"							
		,"GW_PA_AAI	 |	GW_PA_AAN |	GW_PA_AAR	= 0,2"						
		
		,"GW_EA_AAA |	GW_EA_AAB |	GW_EA_AAC |	GW_EA_AAD |	GW_EA_AAE |	GW_EA_AAI |	GW_EA_AAJ |	GW_EA_AAK |	GW_EA_AAT	= 0,5"	
		,"GW_EA_AAF |	GW_EA_AAG |	GW_EA_AAH	= 0,3"
		,"GW_EA_AAL |	GW_EA_AAN	= 0,3"	
		,"GW_EA_AAO |	GW_EA_AAQ |	GW_EA_AAR |	GW_EA_AAS |	GW_EA_AAU	= 0,1"
		,"GW_EA_AAM |	GW_EA_AAP	= 0,2"

		,"GW_GM_AAA |	GW_GM_AAB |	GW_GM_AAD |	GW_GM_AAE |	GW_GM_AAK |	GW_GM_AAL |	GW_GM_AAS	= 0,5"
		,"GW_GM_AAC |	GW_GM_AAF	= 0,3"
		,"GW_GM_AAG |	GW_GM_AAI |	GW_GM_AAJ |	GW_GM_AAR	= 0,3"
		,"GW_GM_AAM |	GW_GM_AAO |	GW_GM_AAP	= 0,1"
		,"GW_GM_AAH |	GW_GM_AAN |	GW_GM_AAQ	= 0,2"

		,"GW_Zsinj_AAA |	GW_Zsinj_AAB |	GW_Zsinj_AAD |	GW_Zsinj_AAE |	GW_Zsinj_AAI |	GW_Zsinj_AAK	= 0,5"
		,"GW_Zsinj_AAC |	GW_Zsinj_AAF |	GW_Zsinj_AAG |	GW_Zsinj_AAH	= 0,3"
		,"GW_Zsinj_AAJ	= 0,3"
		,"GW_Zsinj_AAM |	GW_Zsinj_AAN |	GW_Zsinj_AAP	= 0,1"
		,"GW_Zsinj_AAL |	GW_Zsinj_AAO	= 0,2"

		,"GW_EOTH_AAA |	GW_EOTH_AAB	= 0,5"
		,"GW_EOTH_AAC |	GW_EOTH_AAD	= 0,3"
		,"GW_EOTH_AAE |	GW_EOTH_AAF	= 0,3"
		,"GW_EOTH_AAH |	GW_EOTH_AAI	= 0,1"
		,"GW_EOTH_AAG	= 0,2"

		,"GW_CSA_AAA |	GW_CSA_AAB |	GW_CSA_AAC |	GW_CSA_AAE |	GW_CSA_AAF |	GW_CSA_AAP	= 0,5"
		,"GW_CSA_AAD	= 0,3"
		,"GW_CSA_AAG |	GW_CSA_AAH |	GW_CSA_AAK	= 0,3"
		,"GW_CSA_AAL |	GW_CSA_AAM |	GW_CSA_AAN |	GW_CSA_AAO	= 0,1"
		,"GW_CSA_AAI |	GW_CSA_AAJ	= 0,2"

		,"GW_Hapes_AAA |	GW_Hapes_AAB |	GW_Hapes_AAC |	GW_Hapes_AAE |	GW_Hapes_AAF |	GW_Hapes_AAK	= 0,5"
		,"GW_Hapes_AAD	= 0,3"
		,"GW_Hapes_AAH	= 0,3"
		,"GW_Hapes_AAI	= 0,1"
		,"GW_Hapes_AAG |	GW_Hapes_AAJ |	GW_Hapes_AAL	= 0,2"
		}
	}
	RequiredCategories = {"Wall"}
	AllowFreeStoreUnits = false

end

function ReserveForce_Thread()
			
	BlockOnCommand(ReserveForce.Produce_Force())
	ReserveForce.Set_Plan_Result(true)
	ReserveForce.Set_As_Goal_System_Removable(false)

	-- Give some time to accumulate money.
	tech_level = PlayerObject.Get_Tech_Level()
	min_credits = 1000
	if tech_level == 1 then
		min_credits = 1000
	elseif tech_level >= 2 then
		min_credits = 2000
	end
	
	max_sleep_seconds = 30
	current_sleep_seconds = 0
	while (PlayerObject.Get_Credits() < min_credits) and (current_sleep_seconds < max_sleep_seconds) do
		current_sleep_seconds = current_sleep_seconds + 1
		Sleep(1)
	end
		
	ScriptExit()
end