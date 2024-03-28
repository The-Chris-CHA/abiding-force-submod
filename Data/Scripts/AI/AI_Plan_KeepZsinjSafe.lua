require("pgevents")

-- Tell the script pooling system to pre-cache this number of scripts.
ScriptPoolCount = 1

function Definitions()			
	Category = "Keep_Zsinj_Safe"
	
	TaskForce = {
	{
		"ReserveForce"
		,"DenyHeroAttach"
		,"Iron_Fist_VSD = 1"
	}
	}
end

function ReserveForce_Thread()

	ReserveForce.Set_As_Goal_System_Removable(false)
	AssembleForce(ReserveForce)
	BlockOnCommand(ReserveForce.Move_To(Target))
	ReserveForce.Set_Plan_Result(true)

	Sleep(20)
	
	while (EvaluatePerception("Safe_Zsinj_Planet", PlayerObject, Target) > 0) do
		Sleep(1)
	end
	
	ScriptExit()
end
function ReserveForce_Production_Failed(failed_object_type)
	ScriptExit()
end
