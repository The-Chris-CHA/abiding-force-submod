return {
	Ship_Crew_Requirement = 50,
	Fighters = {
		["HOWLRUNNER_SQUADRON_DOUBLE"] = {
			IMPERIAL = {Initial = 1, Reserve = 1}
		},
		["REBEL_X-WING_SQUADRON_DOUBLE"] = {
			HOSTILE = {Initial = 1, Reserve = 1},
			REBEL = {Initial = 1, Reserve = 1, ResearchType = "~CoS_Tevv"},
			INDEPENDENT_FORCES = {Initial = 1, Reserve = 1}
		},
		["DREXL_SQUADRON_DOUBLE"] = {
			REBEL = {Initial = 1, Reserve = 1, ResearchType = "CoS_Tevv"}
		},
		["A-WING_SQUADRON"] = {
			REBEL = {Initial = 1, Reserve = 1}
		},
		["TIE_INTERCEPTOR_SQUADRON"] = {
			IMPERIAL = {Initial = 1, Reserve = 1}
		},
		["B-WING_SQUADRON"] = {
			HOSTILE = {Initial = 1, Reserve = 1, TechLevel = LessThan(6)},
			REBEL = {Initial = 1, Reserve = 1, ResearchType = "~BwingE"},
			INDEPENDENT_FORCES = {Initial = 1, Reserve = 1, TechLevel = LessThan(6)}
		},
		["B-WING_E_SQUADRON"] = {
			HOSTILE = {Initial = 1, Reserve = 1, TechLevel = GreaterOrEqualTo(6)},
			REBEL = {Initial = 1, Reserve = 1, ResearchType = "BwingE"},
			INDEPENDENT_FORCES = {Initial = 1, Reserve = 1, TechLevel = GreaterOrEqualTo(6)}
		},
		["STARWING_SQUADRON"] = {
			IMPERIAL = {Initial = 1, Reserve = 1}
		}
	},
	Scripts = {"multilayer", "fighter-spawn", "single-unit-retreat"},
	Flags = {HANGAR = true}
}