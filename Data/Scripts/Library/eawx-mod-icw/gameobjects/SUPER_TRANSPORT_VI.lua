return {
	Ship_Crew_Requirement = 5,
	Fighters = {
		["STANDARD_CIVILIAN_FIGHTER_HALF"] = {
			DEFAULT = {Initial = 1, Reserve = 2}
		},
		["STANDARD_CIVILIAN_BOMBER_HALF"] = {
			DEFAULT = {Initial = 1, Reserve = 2}
		}
	},
	Scripts = {"multilayer", "fighter-spawn", "single-unit-retreat"},
	Flags = {HANGAR = true}
}