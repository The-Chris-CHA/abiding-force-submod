require("PGStateMachine")
require("PGStoryMode")
require("TRCommands")

function Definitions()
	Define_State("State_Init", State_Init)
end

function State_Init(message)
	if message == OnEnter then
		if Get_Game_Mode() ~= "Land" then
			ScriptExit()
		end
	end
		
	local Hide_SPHAT = Find_All_Objects_Of_Type("Prop_SPHA-T")
	for i,SPHAT_Object in pairs(Hide_SPHAT) do
		if TestValid(SPHAT_Object) then
			SPHAT_Object.Despawn()
		end	
	end
end