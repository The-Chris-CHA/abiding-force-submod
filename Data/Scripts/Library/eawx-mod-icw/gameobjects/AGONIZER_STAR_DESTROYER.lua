return {
	Fighters = {
		["TIE_FIGHTER_SQUADRON"] = {
			DEFAULT = {Initial = 1, Reserve = 2}
		},
		["SHIELDED_INTERCEPTOR_SQUADRON"] = {
			DEFAULT = {Initial = 1, Reserve = 2}
		},
		["SKIPRAY_SQUADRON_HALF"] = {
			DEFAULT = {Initial = 1, Reserve = 1}
		},
		["TIE_BOMBER_SQUADRON_HALF"] = {
			DEFAULT = {Initial = 1, Reserve = 1}
		},
		["181ST_FEL_SQUADRON"] = {
			DEFAULT = {Initial = 1, Reserve = 0, TechLevel = EqualTo(1)}
		}
	},
	Scripts = {"multilayer", "fighter-spawn"}
}