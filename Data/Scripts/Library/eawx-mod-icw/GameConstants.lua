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
--*   @Date:                2018-03-10T11:56:43+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            GameConstants.lua
--*   @Last modified by:    [TR]Pox
--*   @Last modified time:  2018-03-10T19:29:08+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************

GameConstants = {
    YEAR_SUFFIX = "ABY",
    YEAR_CYCLES = 12,
    START_YEAR = 4,
    PLAYABLE_FACTIONS = {
        "EMPIRE",
        "REBEL",
        "EMPIREOFTHEHAND",
        "PENTASTAR",
        "GREATER_MALDROOD",
        "ZSINJ_EMPIRE",
        "ERIADU_AUTHORITY",
        "CORPORATE_SECTOR",
        "HAPES_CONSORTIUM"
    },
    NONPLAYABLE_FACTIONS = {
        "WARLORDS",
        "CHISS",
        "NEUTRAL",
        "HOSTILE",
        "HUTT_CARTELS",
		"SSIRUUVI_IMPERIUM",
		"KILLIK_HIVES",
		"MANDALORIANS",
		"YEVETHA",
		"INDEPENDENT_FORCES",
		"UNDERWORLD",
		"CORELLIA"
    },
    ALL_FACTIONS = {
        "EMPIRE",
        "REBEL",
        "EMPIREOFTHEHAND",
        "PENTASTAR",
        "GREATER_MALDROOD",
        "ZSINJ_EMPIRE",
        "ERIADU_AUTHORITY",
        "WARLORDS",
        "CHISS",
        "CORPORATE_SECTOR",
        "NEUTRAL",
        "HOSTILE",
        "HUTT_CARTELS",
        "HAPES_CONSORTIUM",
		"SSIRUUVI_IMPERIUM",
		"KILLIK_HIVES",
		"MANDALORIANS",
		"YEVETHA",
		"INDEPENDENT_FORCES",
		"UNDERWORLD",
		"CORELLIA"
    },
    ALL_FACTIONS_CAPITALS = {
        EMPIRE = {STRUCTURE = "REMNANT_CAPITAL", LOCATION = {"CORUSCANT", "BASTION", "ORINDA", "BYSS", "THE_MAW", "ORD_CANTRELL", "FONDOR", "CIUTRIC", "BESTINE"}},
        REBEL = {STRUCTURE = "NEWREP_SENATE", LOCATION = {"CORUSCANT", "SAIJO", "MON_CALAMARI", "BOTHAWUI", "ITHOR"}},
        EMPIREOFTHEHAND = {STRUCTURE = "U_GROUND_PALACE", LOCATION =  {"NIRAUAN"}},
        UNDERWORLD = {STRUCTURE = nil, LOCATION =  {"HELSKA"}},
        PENTASTAR = {STRUCTURE = "PA_CAPITAL", LOCATION = {"ENTRALLA","BASTION"}},
        GREATER_MALDROOD = {STRUCTURE = "MALDROOD_CAPITAL", LOCATION = {"CENTARES", "HAKASSI", "RYVESTER", "THANOS"}},
        ZSINJ_EMPIRE = {STRUCTURE = "RANCOR_BASE", LOCATION = {"SERENNO", "DATHOMIR"}},
        ERIADU_AUTHORITY = {STRUCTURE = "ERIADU_CAPITAL", LOCATION = {"ERIADU", "KAMPE", "SANRAFSIX"}},
        WARLORDS = {STRUCTURE = nil, LOCATION =  {}},
		CHISS = {STRUCTURE = nil, LOCATION =  {"CSILLA"}},
        CORPORATE_SECTOR = {STRUCTURE = "CSA_CAPITAL", LOCATION = {"ETTI"}},
        HOSTILE = {STRUCTURE = nil, LOCATION =  {}},
        HUTT_CARTELS = {STRUCTURE = nil, LOCATION =  {"NAL_HUTTA"}},
        HAPES_CONSORTIUM = {STRUCTURE = "HAPAN_PALACE", LOCATION = {"HAPES"}},
		SSIRUUVI_IMPERIUM = {STRUCTURE = "CREENAAK_PALACE", LOCATION = {"LWHEKK"}},
		KILLIK_HIVES = {STRUCTURE = nil, LOCATION =  {"YOGGOY"}},
		MANDALORIANS = {STRUCTURE = nil, LOCATION =  {"MANDALORE"}},
		YEVETHA = {STRUCTURE = nil, LOCATION =  {"NZOTH"}},
		INDEPENDENT_FORCES = {STRUCTURE = nil, LOCATION =  {}},
		CORELLIA = {STRUCTURE = nil, LOCATION =  {"CORELLIA"}}
    },
    ALL_FACTIONS_AI = {
        EMPIRE = "RemnantAI",
        REBEL = "GenericAI",
        EMPIREOFTHEHAND = "EotHAI",
        UNDERWORLD = "GenericAI",
        PENTASTAR = "PentastarAI",
        GREATER_MALDROOD = "WarlordAI",
        ZSINJ_EMPIRE = "ZsinjAI",
        ERIADU_AUTHORITY = "EriaduAI",
        WARLORDS = "None",
		CHISS = "None",
        CORPORATE_SECTOR = "CorporateAI",
        HOSTILE = "None",
        HUTT_CARTELS = "None",
        HAPES_CONSORTIUM = "GenericAI",
		SSIRUUVI_IMPERIUM = "None",
		KILLIK_HIVES = "None",
		MANDALORIANS = "None",
		YEVETHA = "None",
		INDEPENDENT_FORCES = "None",
		CORELLIA = "None"
    },
    ALL_FACTIONS_CRUEL_AI = {
        EMPIRE = "RemnantSkynetAI",
        REBEL = "SkynetAI",
        UNDERWORLD = "SkynetAI",
        EMPIREOFTHEHAND = "SkynetAI",
        PENTASTAR = "PentastarSkynetAI",
        GREATER_MALDROOD = "SkynetAI",
        ZSINJ_EMPIRE = "ZsinjSkynetAI",
        ERIADU_AUTHORITY = "EriaduSkynetAI",
        WARLORDS = "None",
		CHISS = "None",
        CORPORATE_SECTOR = "SkynetAI",
        HOSTILE = "None",
        HUTT_CARTELS = "None",
        HAPES_CONSORTIUM = "SkynetAI",
		SSIRUUVI_IMPERIUM = "None",
		KILLIK_HIVES = "None",
		MANDALORIANS = "None",
		YEVETHA = "None",
		INDEPENDENT_FORCES = "None",
		CORELLIA = "None"
    },
    ALL_FACTIONS_NOT_NEUTRAL = {
        "EMPIRE",
        "REBEL",
        "EMPIREOFTHEHAND",
        "PENTASTAR",
        "GREATER_MALDROOD",
        "ZSINJ_EMPIRE",
        "ERIADU_AUTHORITY",
        "WARLORDS",
        "CORPORATE_SECTOR",
        "CHISS",
        "HUTT_CARTELS",
        "HAPES_CONSORTIUM",
		"SSIRUUVI_IMPERIUM",
		"KILLIK_HIVES",
		"MANDALORIANS",
		"YEVETHA",
		"INDEPENDENT_FORCES",
		"UNDERWORLD",
		"CORELLIA"
    },
    ALL_FACTION_TEXTS = {
        EMPIRE = "TEXT_FACTION_EMPIRE",
        REBEL = "TEXT_FACTION_REBELS",
        EMPIREOFTHEHAND = "TEXT_FACTION_EOTH",
        PENTASTAR = "TEXT_FACTION_PENTASTAR",
        GREATER_MALDROOD = "TEXT_FACTION_TERADOC",
        ZSINJ_EMPIRE = "TEXT_FACTION_ZSINJ",
        ERIADU_AUTHORITY = "TEXT_FACTION_DELVARDUS",
        WARLORDS = "TEXT_FACTION_WARLORDS",
        CORPORATE_SECTOR = "TEXT_FACTION_CSA",
        NEUTRAL = "TEXT_FACTION_NEUTRAL",
        HOSTILE = "TEXT_FACTION_HOSTILE",
        HUTT_CARTELS = "TEXT_FACTION_HUTTS",
        HAPES_CONSORTIUM = "TEXT_FACTION_HAPES",
        CHISS = "TEXT_FACTION_CHISS",
		SSIRUUVI_IMPERIUM = "TEXT_FACTION_SSIRUUVI",
		KILLIK_HIVES = "TEXT_FACTION_KILLIK_HIVES",
		MANDALORIANS = "TEXT_FACTION_MANDALORIANS",
		YEVETHA = "TEXT_FACTION_YEVETHA",
		INDEPENDENT_FORCES = "TEXT_FACTION_INDEPENDENT_FORCES",
		UNDERWORLD = "TEXT_FACTION_VONG",
		CORELLIA = "TEXT_FACTION_CORELLIA"
    },
    FACTION_COLORS = {
        ["EMPIRE"] = {r = 8, g = 122, b = 16},
        ["REBEL"] = {r = 239, g = 139, b = 9},
        ["EMPIREOFTHEHAND"] = {r = 102, g = 188, b = 217},
        ["CHISS"] = {r = 120, g = 60, b = 36},
        ["PENTASTAR"] = {r = 55, g = 64, b = 184},
        ["GREATER_MALDROOD"] = {r = 255, g = 20, b = 50},
        ["ZSINJ_EMPIRE"] = {r = 179, g = 148, b = 105},
        ["ERIADU_AUTHORITY"] = {r = 255, g = 255, b = 255},
        ["WARLORDS"] = {r = 142, g = 195, b = 0},
        ["CORPORATE_SECTOR"] = {r = 176, g = 124, b = 172},
        ["HAPES_CONSORTIUM"] = {r = 212, g = 81, b = 255},
		["SSIRUUVI_IMPERIUM"] = {r = 100, g = 30, b = 60},
        ["NEUTRAL"] = {r = 100, g = 100, b = 100},
        ["HOSTILE"] = {r = 153, g = 21, b = 223},
		["HUTT_CARTELS"] = {r = 120, g = 60, b = 36},
		["KILLIK_HIVES"] = {r = 142, g = 195, b = 0},
		["MANDALORIANS"] = {r = 142, g = 195, b = 0},
		["YEVETHA"] = {r = 142, g = 195, b = 0},
		["INDEPENDENT_FORCES"] = {r = 142, g = 195, b = 0},
		["UNDERWORLD"] = {r = 102, g = 188, b = 217},
		["CORELLIA"] = {r = 120, g = 60, b = 36},
    },
    ALL_FACTION_NAMES = {
        EMPIRE = "Empire",
        REBEL = "New Republic",
        EMPIREOFTHEHAND = "Empire of the Hand",
        PENTASTAR = "Pentastar Alignment",
        GREATER_MALDROOD = "Greater Maldrood",
        ZSINJ_EMPIRE = "Zsinj's Empire",
        ERIADU_AUTHORITY = "Eriadu Authority",
        WARLORDS = "Minor Warlords",
        CORPORATE_SECTOR = "Corporate Sector Authority",
        NEUTRAL = "Neutral",
        HOSTILE = "Hostile",
        HUTT_CARTELS = "Hutts",
        HAPES_CONSORTIUM = "Hapes Consortium",
        CHISS = "Chiss Ascendancy",
		SSIRUUVI_IMPERIUM = "Ssi-Ruuvi Imperium",
		KILLIK_HIVES = "Killik Hives",
		MANDALORIANS = "Mandalorian Clans",
		YEVETHA = "Duskhan League",
		INDEPENDENT_FORCES = "Independent Forces",
		UNDERWORLD = "Yuuzhan Vong",
		CORELLIA = "Corellians"
    },
    ALIASES = {
        EMPIRE = "IMPERIAL",
        PENTASTAR = "IMPERIAL",
        GREATER_MALDROOD = "IMPERIAL",
        ZSINJ_EMPIRE = "IMPERIAL",
        ERIADU_AUTHORITY = "IMPERIAL",
		WARLORDS = "IMPERIAL",
		CHISS = "EMPIREOFTHEHAND", --Stopgap
		HUTT_CARTELS = "INDEPENDENT_FORCES", --Stopgap
		SSIRUUVI_IMPERIUM = "INDEPENDENT_FORCES", --Stopgap
		KILLIK_HIVES = "INDEPENDENT_FORCES", --Stopgap
		MANDALORIANS = "INDEPENDENT_FORCES", --Stopgap
		CORELLIA = "INDEPENDENT_FORCES", --Stopgap
		YEVETHA = "IMPERIAL", --Stopgap, probably
    },
	TRANSPORTS = {
		["EMPIRE"] = "Imperial_Landing_Craft_Landing",
        ["REBEL"] = "Gallofree_Transport_Landing",
        ["EMPIREOFTHEHAND"] = "Imperial_Landing_Craft_Landing",
        ["CHISS"] = "Imperial_Landing_Craft_Landing",
        ["PENTASTAR"] = "Imperial_Landing_Craft_Landing",
        ["GREATER_MALDROOD"] = "Imperial_Landing_Craft_Landing",
        ["ZSINJ_EMPIRE"] = "Imperial_Landing_Craft_Landing",
        ["ERIADU_AUTHORITY"] = "Imperial_Landing_Craft_Landing",
        ["WARLORDS"] = "Imperial_Landing_Craft_Landing",
        ["CORPORATE_SECTOR"] = "Gallofree_Transport_Landing",
        ["HAPES_CONSORTIUM"] = "Gallofree_Transport_Landing",
		["SSIRUUVI_IMPERIUM"] = "Gallofree_Transport_Landing",
		["KILLIK_HIVES"] = "Gallofree_Transport_Landing",
		["MANDALORIANS"] = "Gallofree_Transport_Landing",
		["YEVETHA"] = "Imperial_Landing_Craft_Landing",
		["INDEPENDENT_FORCES"] = "Gallofree_Transport_Landing",
		["UNDERWORLD"] = "Gallofree_Transport_Landing",
		["CORELLIA"] = "Gallofree_Transport_Landing",
	}
}

return GameConstants
