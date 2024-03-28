return {
	Ship_Crew_Requirement = 20,
	Fighters = {
		["HOWLRUNNER_SQUADRON_HALF"] = {
			HAPES_CONSORTIUM = {Initial = 1, Reserve = 1},
			HOSTILE = {Initial = 1, Reserve = 1},
			IMPERIAL = {Initial = 1, Reserve = 1},
			INDEPENDENT_FORCES = {Initial = 1, Reserve = 1}
		},
		["IRDA_SQUADRON_HALF"] = {
			CORPORATE_SECTOR = {Initial = 1, Reserve = 1}
		},
		["REBEL_X-WING_SQUADRON_HALF"] = {
			REBEL = {Initial = 1, Reserve = 1}
		},
		["TIE_FIGHTER_SQUADRON_HALF"] = {
			EMPIREOFTHEHAND = {Initial = 1, Reserve = 1}
		}
	},
	Scripts = {"multilayer", "fighter-spawn", "single-unit-retreat"}
}