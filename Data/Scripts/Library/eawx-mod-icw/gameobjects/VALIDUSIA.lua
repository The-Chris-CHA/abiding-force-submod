return {
	Fighters = {
		["TIE_AGGRESSOR_SQUADRON_DOUBLE"] = {
			ZSINJ_EMPIRE = {Initial = 1, Reserve = 5}
		},
		["TIE_INTERCEPTOR_SQUADRON_DOUBLE"] = {
			EMPIRE = {Initial = 1, Reserve = 5},
			ERIADU_AUTHORITY = {Initial = 1, Reserve = 5, ResearchType = "~EATIEShields"},
			GREATER_MALDROOD = {Initial = 1, Reserve = 5},
			INDEPENDENT_FORCES = {Initial = 1, Reserve = 5},
			WARLORDS = {Initial = 1, Reserve = 5}
		},
		["SHIELDED_INTERCEPTOR_SQUADRON_DOUBLE"] = {
			ERIADU_AUTHORITY = {Initial = 1, Reserve = 5, ResearchType = "EATIEShields"}
		},
		["TIE_X2_SQUADRON_DOUBLE"] = {
			PENTASTAR = {Initial = 1, Reserve = 5}
		},
		["ADVANCED_SKIPRAY_SQUADRON"] = {
			PENTASTAR = {Initial = 1, Reserve = 5}
		},
		["EARLY_SKIPRAY_SQUADRON"] = {
			ERIADU_AUTHORITY = {Initial = 1, Reserve = 5}
		},
		["TIE_DEFENDER_SQUADRON"] = {
			EMPIRE	= {Initial = 1, Reserve = 5},
			INDEPENDENT_FORCES = {Initial = 1, Reserve = 5},
			WARLORDS = {Initial = 1, Reserve = 5}
		},
		["TIE_OPPRESSOR_SQUADRON"] = {
			GREATER_MALDROOD = {Initial = 1, Reserve = 5}
		},
		["TIE_RAPTOR_SQUADRON"] = {
			ZSINJ_EMPIRE = {Initial = 1, Reserve = 5}
		},
		["STARWING_SQUADRON_DOUBLE"] = {
			ZSINJ_EMPIRE = {Initial = 1, Reserve = 5}
		},
		["TIE_BOMBER_SQUADRON_DOUBLE"] = {
			EMPIRE = {Initial = 1, Reserve = 5, TechLevel = IsOneOf({1, 2, 4, 5, 6, 7, 8, 9, 10, 11})},
			ERIADU_AUTHORITY = {Initial = 1, Reserve = 5},
			GREATER_MALDROOD = {Initial = 1, Reserve = 5},
			PENTASTAR = {Initial = 1, Reserve = 5},
			INDEPENDENT_FORCES = {Initial = 1, Reserve = 5},
			WARLORDS = {Initial = 1, Reserve = 5}
		},
		["SCIMMY_SQUADRON_DOUBLE"] = {
			EMPIRE = {Initial = 1, Reserve = 5, TechLevel = EqualTo(3)}
		},
		["SKIRMISH_CUSTOMS_CORVETTE"] = {
			GREATER_MALDROOD = {Initial = 3, Reserve = 3}
		},
		["SKIRMISH_IPV1"] = {
			EMPIRE = {Initial = 3, Reserve = 3, TechLevel = LessThan(6)},
			ERIADU_AUTHORITY = {Initial = 3, Reserve = 3},
			INDEPENDENT_FORCES = {Initial = 3, Reserve = 3},
			WARLORDS = {Initial = 3, Reserve = 3}
		},
		["SKIRMISH_CRUSADER"] = {
			EMPIRE = {Initial = 3, Reserve = 3, TechLevel = GreaterOrEqualTo(6)}
		},
		["SKIRMISH_RAIDER_PENTASTAR"] = {
			PENTASTAR = {Initial = 3, Reserve = 3}
		},
		["SKIRMISH_ZSINJ_CR90"] = {
			ZSINJ_EMPIRE = {Initial = 3, Reserve = 3}
		}
	},
	Scripts = {"fighter-spawn"}
}