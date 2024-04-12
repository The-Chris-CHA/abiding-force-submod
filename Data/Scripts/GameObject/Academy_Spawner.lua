--******************************************************************************
--     _______ __
--    |_     _|  |--.----.---.-.--.--.--.-----.-----.
--      |   | |     |   _|  _  |  |  |  |     |__ --|
--      |___| |__|__|__| |___._|________|__|__|_____|
--     ______
--    |   __ \.-----.--.--.-----.-----.-----.-----.
--    |      <|  -__|  |  |  -__|     |  _  |  -__|
--    |___|__||_____|\___/|_____|__|__|___  |_____|
--                                    |_____|
--*   @Author:              [TR]Pox
--*   @Date:                2018-03-20T01:27:01+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            Deconstruction.lua
--*   @Last modified by:    [TR]Pox
--*   @Last modified time:  2018-03-26T09:58:14+02:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************

require("MinorHeroSpawner")

function Definitions()
    DebugMessage("%s -- In Definitions", tostring(Script))

    Define_State("State_Init", State_Init);
end


function State_Init(message)
	if message == OnEnter then
		local space_V_list
		local space_IV_list
		local space_III_list
		local land_IV_list
		local land_III_list
		local faction = Object.Get_Owner()
		if faction == Find_Player("Rebel") then
			space_V_list = {"Commander_Liberty_V", "Commander_Dauntless_V"}
			space_IV_list = {"Commander_Dreadnaught_IV_Rebel", "Commander_MC40_IV"}
			space_III_list = {"Commander_Assault_Frigate_III"}
			land_IV_list = {"Commander_Army_NR_IV_Company", "Commander_AA70_IV_Company", "Commander_SRV1_IV_Company", "Commander_T1B_IV_Company"}
			land_III_list  = {"Commander_Army_NR_III_Company", "Commander_AA70_III_Company", "Commander_SRV1_III_Company", "Commander_T1B_III_Company"}
		elseif faction == Find_Player("Greater_Maldrood") then
			space_V_list = {"Commander_Procursator_V", "Commander_CCVSD_V"}
			space_IV_list = {"Commander_Imperial_IV", "Commander_Dreadnaught_IV"}
			space_III_list = {"Commander_Strike_III"}
			land_IV_list = {"Commander_Army_GE_IV_Company", "Commander_Stormtrooper_IV_Company", "Commander_ISB_Infiltrator_IV_Company", "Commander_1M_Tank_IV_Company", "Commander_Century_Tank_IV_Company", "Commander_RTT_IV_Company", "Commander_Chariot_IV_Company"}
			land_III_list  = {"Commander_Army_GE_III_Company", "Commander_Stormtrooper_III_Company", "Commander_Navy_Special_III_Company", "Commander_1M_Tank_III_Company", "Commander_Century_Tank_III_Company", "Commander_RTT_III_Company", "Commander_Chariot_III_Company"}
		elseif faction == Find_Player("Eriadu_Authority") then
			space_V_list = {"Commander_VSD1_V", "Commander_VSD2_V"}
			space_IV_list = {"Commander_Imperial_IV", "Commander_Broadside_IV"}
			space_III_list = {"Commander_Vindicator_III"}
			land_IV_list = {"Commander_Army_GE_IV_Company", "Commander_Stormtrooper_IV_Company", "Commander_Galactic_Marine_IV_Company", "Commander_1M_Tank_IV_Company", "Commander_Century_Tank_IV_Company", "Commander_RTT_IV_Company", "Commander_Chariot_IV_Company"}
			land_III_list  = {"Commander_Army_GE_III_Company", "Commander_Stormtrooper_III_Company", "Commander_Army_Special_III_Company", "Commander_1M_Tank_III_Company", "Commander_Century_Tank_III_Company", "Commander_RTT_III_Company", "Commander_Chariot_III_Company"}
		elseif faction == Find_Player("Pentastar") then
			space_V_list = {"Commander_Venator_V", "Commander_VSD2_V"}
			space_IV_list = {"Commander_Acclamator_Level_IV", "Commander_Dreadnaught_IV"}
			space_III_list = {"Commander_Enforcer_III"}
			land_IV_list = {"Commander_Army_GE_IV_Company", "Commander_Stormtrooper_IV_Company", "Commander_Pentastar_Patrol_IV_Company", "Commander_1M_Tank_IV_Company", "Commander_Century_Tank_IV_Company", "Commander_RTT_IV_Company", "Commander_Chariot_IV_Company"}
			land_III_list  = {"Commander_Army_GE_III_Company", "Commander_Stormtrooper_III_Company", "Commander_Army_Special_III_Company", "Commander_1M_Tank_III_Company", "Commander_Century_Tank_III_Company", "Commander_RTT_III_Company", "Commander_Chariot_III_Company"}
		elseif faction == Find_Player("Zsinj_Empire") then
			space_V_list = {"Commander_VSD1_V", "Commander_VSD2_V"}
			space_IV_list = {"Commander_Dreadnaught_IV", "Commander_Neutron_IV"}
			space_III_list = {"Commander_Gladiator2_III"}
			land_IV_list = {"Commander_Army_GE_IV_Company", "Commander_Stormtrooper_IV_Company", "Commander_ISB_Infiltrator_IV_Company", "Commander_1M_Tank_IV_Company", "Commander_Century_Tank_IV_Company", "Commander_RTT_IV_Company", "Commander_Chariot_IV_Company"}
			land_III_list  = {"Commander_Army_GE_III_Company", "Commander_Stormtrooper_III_Company", "Commander_Raptor_III_Company", "Commander_1M_Tank_III_Company", "Commander_Century_Tank_III_Company", "Commander_RTT_III_Company", "Commander_Chariot_III_Company"}
		elseif faction == Find_Player("Corporate_Sector") then
			space_V_list = {"Commander_VSD1_V", "Commander_Dauntless_V"}
			space_IV_list = {"Commander_Dreadnaught_IV_Rebel", "Commander_Neutron_IV"}
			space_III_list = {"Commander_Gladiator_III"}
			land_IV_list = {"OOM_Commander_IV_Company", "Commander_Espo_IV_Company", "Commander_GX12_IV_Company", "Commander_JX30_IV_Company", "Commander_Persuader_IV_Company", "Commander_X10_IV_Company"}
			land_III_list  = {"OOM_Commander_III_Company", "Commander_Espo_III_Company", "Commander_GX12_III_Company", "Commander_JX30_III_Company", "Commander_Persuader_III_Company", "Commander_X10_III_Company"}
		elseif faction == Find_Player("EmpireoftheHand") then
			space_V_list = {"Commander_Chaf_V", "Commander_VSD1_V"}
			space_IV_list = {"Commander_Kynigos_IV", "Commander_Dreadnaught_IV"}
			space_III_list = {"Commander_Rohkea_III"}
			land_IV_list = {"Commander_Kirov_IV_Company"}
			land_III_list  = {"Commander_Kirov_III_Company"}
		else --Empire, but a default case is good practice
			space_V_list = {"Commander_VSD1_V", "Commander_VSD2_V"}
			space_IV_list = {"Commander_Dreadnaught_IV", "Commander_Broadside_IV"}
			space_III_list = {"Commander_Vindicator_III"}
			land_IV_list = {"Commander_Army_GE_IV_Company", "Commander_Stormtrooper_IV_Company", "Commander_ISB_Infiltrator_IV_Company", "Commander_1M_Tank_IV_Company", "Commander_Century_Tank_IV_Company", "Commander_RTT_IV_Company", "Commander_Chariot_IV_Company"}
			land_III_list  = {"Commander_Army_GE_III_Company", "Commander_Stormtrooper_III_Company", "Commander_Nova_Stormtrooper_III_Company", "Commander_1M_Tank_III_Company", "Commander_Century_Tank_III_Company", "Commander_RTT_III_Company", "Commander_Chariot_III_Company"}
		end
		Register_Timer(CadetLoop, 0, {Object, true, space_V_list, space_IV_list, space_III_list, land_IV_list, land_III_list})
    end
end