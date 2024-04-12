require("pgevents")

function Definitions()
	DebugMessage("%s -- In Definitions", tostring(Script))

	Category = "Build_Ground_Company"
	IgnoreTarget = true
	TaskForce = {
	{
		"StructureForce",
		"Aratech_HQ | Balmorran_Arms_HQ | Bespin_Motors_HQ | CEC_HQ | Cloning_HQ | Damorian_HQ | Hoersch_Kessel_HQ | Incom_HQ | KDY_HQ | Mandal_Motors_HQ | Mekuun_HQ | Rendili_HQ | Sorosuub_HQ | Taim_Bak_HQ | TransGalMeg_HQ | Ubrikkian_HQ | ADC_HQ | Arakyd_HQ | Baktoid_HQ | Bothawui_HQ | Carida_Academy | Cygnus_HQ | Galentro_HQ | GormTalquist_HQ | KDY_Branch | Koensayr_HQ | Loronar_HQ | MCS_HQ | Merkuni_HQ  | Metalworks_Guild_HQ | NenCarvon_HQ | Olanji_Charubah_HQ | REC_HQ | Rossum_HQ | SecuriTech_HQ | SFS_HQ | Sienar_HQ | TaggeCo_HQ | Tarkin_Estates | Telgorn_HQ | Ulban_HQ | Uulshos_HQ | Yutrane_Trackata_HQ | zZip_HQ = 1"
	}
	}

	DebugMessage("%s -- Done Definitions", tostring(Script))
end

function StructureForce_Thread()
	DebugMessage("%s -- In StructureForce_Thread.", tostring(Script))
	
	StructureForce.Set_As_Goal_System_Removable(false)
	AssembleForce(StructureForce)
	
	StructureForce.Set_Plan_Result(true)
	--Clean out MajorItem budget
	Budget.Flush_Category("MajorItem")
	DebugMessage("%s -- StructureForce done!", tostring(Script));
	ScriptExit()
end

function StructureForce_Production_Failed(tf, failed_object_type)
	DebugMessage("%s -- Abandonning plan owing to production failure.", tostring(Script))
	ScriptExit()
end