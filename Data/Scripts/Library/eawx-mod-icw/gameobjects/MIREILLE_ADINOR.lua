return {
	Fighters = {
		["REBEL_X-WING_SQUADRON_DOUBLE"] = {
			DEFAULT = {Initial = 1, Reserve = 1, TechLevel = LessOrEqualTo(6)}
		},
		["E-WING_SQUADRON_DOUBLE"] = {
			DEFAULT = {Initial = 1, Reserve = 1, TechLevel = GreaterThan(6)}
		},
        ["B-WING_SQUADRON"] = {
            DEFAULT = {Initial = 1, Reserve = 1}
        },
		["KRED_XWING"] = {
			DEFAULT = {Initial = 1, Reserve = 0}
		},
		["DREX_XWING"] = {
			DEFAULT = {Initial = 1, Reserve = 0}
		}
	},
	Scripts = {"multilayer", "fighter-spawn"}
}