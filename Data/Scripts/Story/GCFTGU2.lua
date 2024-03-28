require("PGStoryMode")
require("deepcore/crossplot/crossplot")

function Definitions()

    DebugMessage("%s -- In Definitions", tostring(Script))
    StoryModeEvents = {
		Delayed_Initialize = Initialize
	}
	
end		

function Initialize(message)
    if message == OnEnter then
		crossplot:galactic()
		p_newrep = Find_Player("Rebel")
		if p_newrep.Is_Human() then
			crossplot:publish("NR_ADMIRAL_DECREMENT", 10, 1)
			crossplot:publish("NR_ADMIRAL_DECREMENT", 10, 2)
			crossplot:publish("NR_ADMIRAL_LOCKIN", {"Bell"}, 1)
		end
	else
		crossplot:update()
    end
end