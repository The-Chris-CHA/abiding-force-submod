require("PGBase")
require("PGStateMachine")
require("PGStoryMode")
StoryUtil = require("eawx-util/StoryUtil")

function Definitions()

	DebugMessage("%s -- In Definitions", tostring(Script))

	StoryModeEvents = { Universal_Story_Start = Set_Tech }
end

function Set_Tech(message)
  if message == OnEnter then

    --Match the order of the index in factions.xml
	liveFactionTable = {
      ["REBEL"] = 0,
      ["EMPIRE"] = 1,
      --"HUTT_CARTELS" 2,
      --"NEUTRAL" 3,
      --"HOSTILE" 4,
      ["EMPIREOFTHEHAND"] = 5,
      --"UNDERWORLD" 6,
      ["ZSINJ_EMPIRE"] = 7,
      ["ERIADU_AUTHORITY"] = 8,
      --"CHISS" 9,
      --"CORELLIA" 10,
      ["SSIRUUVI_IMPERIUM"] = 11, 
      ["HAPES_CONSORTIUM"] = 12,
      ["CORPORATE_SECTOR"] =13,
      ["PENTASTAR"] = 14,
      ["GREATER_MALDROOD"] = 15,
      --"WARLORDS"
    }

    local faction_index = 0
    local credits = 0
    local faction_name = "REBEL"
	for faction, id in pairs(liveFactionTable) do
		if Find_Player(faction).Is_Human() then
            faction_index = id
            faction_name = faction
			credits = Find_Player(faction).Get_Credits()
      Find_Player(faction).Give_Money(10000-credits)
			break
		end
	end

	local era = (credits / 1000) + 1

		if era >= 6 then
			era = 6
		end
		
		if era == 5 then
			era = 4
		end
		
		if era <= 3 then
			era = 3
		end

    plot = Get_Story_Plot("Conquests\\Progressive\\GCLoader.xml")
	
		planet_name = "Sandbox_DeepCoreConflict_"

        loadEvent = plot.Get_Event("Load_Another_GC")

        StoryUtil.ShowScreenText(planet_name.."_Era_"..tostring(era).."_"..faction_name, 10)

		local name = "Sandbox_DeepCoreConflict_Era_"..tostring(era).."_"..faction_name

        --Uncomment this to use old map setup
        --local name = planet_name.."_"..faction_name.."_Era_"..tostring(era)

        loadEvent.Set_Reward_Parameter(0, name)
        loadEvent.Set_Reward_Parameter(1, faction_index)

	
    Story_Event("LOAD_CAMPAIGN_EVENT")

  elseif message == OnUpdate then
	ScriptExit()
  end
end