return {
	Ship_Crew_Requirement = 10,
	Fighters = {
		["MIXED_UGLY_SQUADRON"] = {
			DEFAULT = {Initial = 1, Reserve = 3}
		},
		["STANDARD_CIVILIAN_FIGHTER"] = {
			DEFAULT = {Initial = 1, Reserve = 1}
		},
		["STANDARD_PIRATE_FIGHTER"] = {
			DEFAULT = {Initial = 1, Reserve = 1}
		},
		["STANDARD_CIVILIAN_BOMBER"] = {
			DEFAULT = {Initial = 1, Reserve = 1}
		},
		["STANDARD_CIVILIAN_BOMBER_DOUBLE"] = {
			DEFAULT = {Initial = 1, Reserve = 1}
		}
	},
	Scripts = {"multilayer", "fighter-spawn", "single-unit-retreat"}
}