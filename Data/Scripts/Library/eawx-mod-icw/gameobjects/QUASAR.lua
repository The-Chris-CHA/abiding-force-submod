return {
	Ship_Crew_Requirement = 1,
	Fighters = {
		["REBEL_X-WING_SQUADRON"] = {
			DEFAULT = {Initial = 1, Reserve = 1, ResearchType = "~CoS_Tevv"}
		},
		["DREXL_SQUADRON"] = {
			DEFAULT = {Initial = 1, Reserve = 1, ResearchType = "CoS_Tevv"}
		},
		["Y-WING_SQUADRON"] = {
			DEFAULT = {Initial = 1, Reserve = 2}
		}
	},
	Scripts = {"multilayer", "fighter-spawn", "single-unit-retreat"},
	Flags = {HANGAR = true}
}