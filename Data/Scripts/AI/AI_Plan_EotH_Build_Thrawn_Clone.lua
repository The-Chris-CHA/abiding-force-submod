require("pgevents")

function Definitions()
	Category = "EotH_Construct_Thrawn_Clone"
	IgnoreTarget = true
	TaskForce = {
	{
		"ReserveForce"
		,"DenyHeroAttach"
		,"Dummy_Find_Thrawn_Clone = 1"
	}
	}
	AllowFreeStoreUnits = false
end

function ReserveForce_Thread()	
	ReserveForce.Set_As_Goal_System_Removable(false)
	BlockOnCommand(ReserveForce.Produce_Force())
	ReserveForce.Set_Plan_Result(true)
end
