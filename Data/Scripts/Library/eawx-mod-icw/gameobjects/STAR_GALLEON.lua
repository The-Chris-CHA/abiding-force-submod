return {
	Ship_Crew_Requirement = 5,
	Fighters = {
		["IRD_SQUADRON_HALF"] = {
			CORPORATE_SECTOR = {Initial = 1, Reserve = 1}
		},
		["TIE_FIGHTER_SQUADRON_HALF"] = {
			EMPIRE = {Initial = 1, Reserve = 1, TechLevel = LessThan(6)},
			ERIADU_AUTHORITY = {Initial = 1, Reserve = 1, ResearchType = "~EATIEShields"},
			GREATER_MALDROOD = {Initial = 1, Reserve = 1, HeroOverride = {{"TAVIRA_INVIDIOUS"}, {"CLUTCH_SQUADRON_HALF"}}},
			PENTASTAR = {Initial = 1, Reserve = 1},
			HOSTILE = {Initial = 1, Reserve = 1},
			INDEPENDENT_FORCES = {Initial = 1, Reserve = 1},
			WARLORDS = {Initial = 1, Reserve = 1},
			ZSINJ_EMPIRE = {Initial = 1, Reserve = 1},
		},
		["SUPER_TIE_SQUADRON_HALF"] = {
			EMPIRE = {Initial = 1, Reserve = 1, TechLevel = GreaterOrEqualTo(6)}
		},
		["SHIELDED_TIE_SQUADRON_HALF"] = {
			ERIADU_AUTHORITY = {Initial = 1, Reserve = 1, ResearchType = "EATIEShields"}
		}
	},
	Scripts = {"multilayer", "single-unit-retreat"},
	Flags = {HANGAR = true}
}