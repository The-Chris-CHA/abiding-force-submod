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
--*   @Author:              Corey
--*   @Date:                2017-12-18T14:01:09+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            GCWarlordsCampaign.lua
--*   @Last modified by:
--*   @Last modified time:  2018-03-13T22:28:32-04:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************

require("PGStoryMode")
require("PGSpawnUnits")
require("eawx-util/ChangeOwnerUtilities")
require("HeroSystem")
StoryUtil = require("eawx-util/StoryUtil")

function Definitions()
    DebugMessage("%s -- In Definitions", tostring(Script))

    StoryModeEvents = {
        Support_Candidate_Leia = Leia_Support,
        Support_Candidate_Borsk = Borsk_Support,
        Support_Candidate_Mothma = Mothma_Support,
        Support_Candidate_Gavrisom = Gavrisom_Support,
		Support_Candidate_Tevv = Tevv_Support,
		Support_Candidate_SoBilles = SoBilles_Support,
		Support_Candidate_Navik = Navik_Support,
		Support_Candidate_Shesh = Shesh_Support,
    }
end

function Leia_Support(message)
    DebugMessage("Support Change Started")
    if message == OnEnter then
        GlobalValue.Set("ChiefOfStatePreference", "DUMMY_CHIEFOFSTATE_LEIA")
    end
    DebugMessage("Support Change Finished")
end

function Borsk_Support(message)
    DebugMessage("Support Change Started")
    if message == OnEnter then
        GlobalValue.Set("ChiefOfStatePreference", "DUMMY_CHIEFOFSTATE_FEYLYA")
    end
    DebugMessage("Support Change Finished")
end

function Mothma_Support(message)
    DebugMessage("Support Change Started")
    if message == OnEnter then
        GlobalValue.Set("ChiefOfStatePreference", "DUMMY_CHIEFOFSTATE_MOTHMA")
    end
    DebugMessage("Support Change Finished")
end

function Gavrisom_Support(message)
    DebugMessage("Support Change Started")
    if message == OnEnter then
        GlobalValue.Set("ChiefOfStatePreference", "DUMMY_CHIEFOFSTATE_GAVRISOM")
    end
    DebugMessage("Support Change Finished")
end

function Tevv_Support(message)
    DebugMessage("Support Change Started")
    if message == OnEnter then
        GlobalValue.Set("ChiefOfStatePreference", "DUMMY_CHIEFOFSTATE_TEVV")
    end
    DebugMessage("Support Change Finished")
end

function SoBilles_Support(message)
    DebugMessage("Support Change Started")
    if message == OnEnter then
        GlobalValue.Set("ChiefOfStatePreference", "DUMMY_CHIEFOFSTATE_SOBILLES")
    end
    DebugMessage("Support Change Finished")
end

function Navik_Support(message)
    DebugMessage("Support Change Started")
    if message == OnEnter then
        GlobalValue.Set("ChiefOfStatePreference", "DUMMY_CHIEFOFSTATE_NAVIK")
    end
    DebugMessage("Support Change Finished")
end

function Shesh_Support(message)
    DebugMessage("Support Change Started")
    if message == OnEnter then
        GlobalValue.Set("ChiefOfStatePreference", "DUMMY_CHIEFOFSTATE_SHESH")
    end
    DebugMessage("Support Change Finished")
end