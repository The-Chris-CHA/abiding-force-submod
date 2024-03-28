return {
	Ship_Crew_Requirement = 1,
	Fighters = {
		["MIYTIL_FIGHTER_SQUADRON"] = {
			HAPES_CONSORTIUM = {Initial = 1, Reserve = 0},
			HOSTILE = {Initial = 1, Reserve = 0},
			INDEPENDENT_FORCES = {Initial = 1, Reserve = 0}
		},
		["REBEL_X-WING_SQUADRON"] = {
			REBEL = {Initial = 1, Reserve = 0}
		},
		["TIE_FIGHTER_SQUADRON"] = {
			IMPERIAL = {Initial = 1, Reserve = 0}
		}
	},
	Scripts = {"multilayer", "fighter-spawn"},
	Flags = {HANGAR = true}
}