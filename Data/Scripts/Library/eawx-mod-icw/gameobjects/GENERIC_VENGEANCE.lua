return {
	Ship_Crew_Requirement = 300,
	Fighters = {
		["HOWLRUNNER_SQUADRON_DOUBLE"] = {
			DEFAULT = {Initial = 2, Reserve = 16}
		},
		["SHIELDED_RAPTOR_SQUADRON_DOUBLE"] = {
			DEFAULT = {Initial = 1, Reserve = 3}
		},
		["TIE_HEAVY_BOMBER_SQUADRON"] = {
			DEFAULT = {Initial = 1, Reserve = 4}
		}
	},
	Scripts = {"fighter-spawn", "persistent-damage"},
	Flags = {HANGAR = true}
}