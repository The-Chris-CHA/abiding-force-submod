
--******************************************--
--**** Thrawn's Revenge: Crimson Empire ****--
--******************************************--

require("PGBase")
require("PGStateMachine")
require("PGStoryMode")
require("PGSpawnUnits")
require("deepcore/crossplot/crossplot")


function Definitions()

  DebugMessage("%s -- In Definitions", tostring(Script))

  StoryModeEvents =
  {
    Determine_Faction_LUA = Find_Faction,
	Delayed_Initialize = Initialize
  }

end

function Find_Faction(message)
  if message == OnEnter then

	 p_newrep = Find_Player("Rebel")
	 p_empire = Find_Player("Empire")
	 p_eoth = Find_Player("EmpireoftheHand")
	 p_eriadu = Find_Player("Eriadu_Authority")
	 p_pentastar = Find_Player("Pentastar")
	 p_zsinj = Find_Player("Zsinj_Empire")
	 p_maldrood = Find_Player("Greater_Maldrood")

	if p_newrep.Is_Human() then
		Story_Event("ENABLE_BRANCH_NEWREP_FLAG")
	elseif p_empire.Is_Human() then
		Story_Event("ENABLE_BRANCH_EMPIRE_FLAG")
	elseif p_eoth.Is_Human() then
		Story_Event("ENABLE_BRANCH_EOTH_FLAG")
	elseif p_eriadu.Is_Human() then
		Story_Event("ENABLE_BRANCH_ERIADU_FLAG")
	elseif p_pentastar.Is_Human() then
		Story_Event("ENABLE_BRANCH_PENTASTAR_FLAG")
	elseif p_zsinj.Is_Human() then
		Story_Event("ENABLE_BRANCH_ZSINJ_FLAG")
	elseif p_maldrood.Is_Human() then
		Story_Event("ENABLE_BRANCH_TERADOC_FLAG")
	end
  end
end

function Initialize(message)
    if message == OnEnter then
		crossplot:galactic()
		crossplot:publish("INITIALIZE_AI", "empty")
		crossplot:publish("NR_ADMIRAL_DECREMENT", 1, 1)
		
		p_pentastar.Unlock_Tech(Find_Object_Type("REAPER"))
	else
		crossplot:update()
    end
end
