return {
    Fighters = {
        HWING_SQUADRON = {
            DEFAULT = {Initial = 1, TechLevel = LessThan(4), Reserve = 1}
        },
		["K-WING_SQUADRON"] = {
			DEFAULT = {Initial = 1, TechLevel = GreaterOrEqualTo(4), Reserve = 1}
		},
        ["REBEL_X-WING_SQUADRON"] = {
            DEFAULT = {Initial = 1, Reserve = 1}
        },
		["B-WING_SQUADRON_DOUBLE"] = {
            DEFAULT = {Initial = 1, ResearchType = "~BwingE", Reserve = 1}
        },
		["B-WING_E_SQUADRON_DOUBLE"] = {
			DEFAULT = {Initial = 1, ResearchType = "BwingE", Reserve = 1}
		},
    },
    Scripts = {"multilayer", "fighter-spawn"}
}