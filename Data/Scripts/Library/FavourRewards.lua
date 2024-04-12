return {
    ["HAPES_CONSORTIUM"] = {
        ["ROYAL"] = {
            name = "Royal",
            faction_name = "HAPES_CONSORTIUM",
            faction = Find_Player("HAPES_CONSORTIUM"),
            favour = 0,
            max_value = -1,
            max_crossplot = nil,
            cycle_increase = 0,
            increase_on_capture = 0,
            reduction_speech = nil,
            support_structures_perception = "House_Royal_Construction_Favour",
            leader_holo = "",
            support_buildables = {
                {name = "HAPAN_INFANTRY_SQUAD", value = 1, locks = false}
            },
            reward_list = {
                {unit = "ROYAL_COMMANDER", 
                    threshold = 65, 
                    remove_cost = true, 
                    limit = 0, built = 0, building = 0, 
                    buildable = false, 
                    locks = true, 
                    tag = "Fleet Commander (Battle Dragon)",
                    crossplot = nil,
                    text = "A new Royal House fleet commander can be recruited on the political options tab.",
                },
                {unit = "ROYAL_COMMANDER_HRG_COMMANDO_COMPANY", 
                    threshold = 25, 
                    remove_cost = true, 
                    limit = 0, built = 0, building = 0, 
                    buildable = false,
                    locks = true, 
                    tag = "Field Commander (Royal House Guard Commando Platoon)",
                    crossplot = nil, 
                    text = "A new Royal House field commander can be recruited on the political options tab.",
                },
            },
            spawned_rewards = {
                --Test for other ones
                -- {unit = "STAR_HOME",
                --     threshold = 100,
                --     remove_cost = false,
                --     spawned = false,
                --     text = true
                -- },
            },
            integrates = false,
        },
        ["REQUUD"] = {
            name = "Requud",
            faction_name = "HAPES_CONSORTIUM",
            faction = Find_Player("HAPES_CONSORTIUM"),
            favour = 0,
            max_value = -1,
            max_crossplot = nil,
            cycle_increase = 0,
            increase_on_capture = 0,
            reduction_speech = nil,
            support_structures_perception = "House_Requud_Construction_Favour",
            leader_holo = "",
            support_buildables = {
                {name = "REQUUD_INFANTRY_SQUAD", value = 1, locks = false}
            },
            reward_list = {
                {unit = "REQUUD_COMMANDER", 
                    threshold = 65, 
                    remove_cost = true, 
                    limit = 0, built = 0, building = 0,
                    buildable = false,
                    locks = true, 
                    tag = "Fleet Commander (Battle Dragon)",
                    crossplot = nil,
                    text = "A new House Requud fleet commander can be recruited on the political options tab.",
                },
                {unit = "REQUUD_COMMANDER_FIREDRAGON_COMPANY", 
                    threshold = 25, 
                    remove_cost = true, 
                    limit = 0, built = 0, building = 0,
                    buildable = false,
                    locks = true,  
                    tag = "Field Commander (Fire Dragon Hovertank)",
                    crossplot = nil,
                    text = "A new House Requud field commander can be recruited on the political options tab.",
                },
            },
            spawned_rewards = {
            },
            integrates = false,
        },
        ["GALNEY"] = {
            name = "Galney",
            faction_name = "HAPES_CONSORTIUM",
            faction = Find_Player("HAPES_CONSORTIUM"),
            favour = 0,
            max_value = -1,
            max_crossplot = nil,
            cycle_increase = 0,
            increase_on_capture = 0,
            reduction_speech = nil,
            support_structures_perception = "House_Galney_Construction_Favour",
            leader_holo = "",
            support_buildables = {
                {name = "GALNEY_INFANTRY_SQUAD", value = 1, locks = false}
            },
            reward_list = {
                {unit = "GALNEY_COMMANDER", 
                    threshold = 65, 
                    remove_cost = true, 
                    limit = 0, built = 0, building = 0,
                    buildable = false,
                    locks = true,  
                    tag = "Fleet Commander (Battle Dragon)",
                    crossplot = nil,
                    text = "A new House Galney fleet commander can be recruited on the political options tab.",
                },
                {unit = "GALNEY_COMMANDER_HOUSE_GUARD_COMPANY", 
                    threshold = 25, 
                    remove_cost = true, 
                    limit = 0, built = 0, building = 0,
                    buildable = false,
                    locks = true,  
                    tag = "Field Commander (Galney House Guard Platoon)",
                    crossplot = nil,
                    text = "A new House Galney field commander can be recruited on the political options tab.",
                },
            },
            spawned_rewards = {
            },
            integrates = false,
        },
        ["MALURI"] = {
            name = "Maluri",
            faction_name = "HAPES_CONSORTIUM",
            faction = Find_Player("HAPES_CONSORTIUM"),
            favour = 0,
            max_value = -1,
            max_crossplot = nil,
            cycle_increase = 0,
            increase_on_capture = 0,
            reduction_speech = nil,
            support_structures_perception = "House_Maluri_Construction_Favour",
            leader_holo = "",
            support_buildables = {
                {name = "MALURI_INFANTRY_SQUAD", value = 1, locks = false}
            },
            reward_list = {
                {unit = "MALURI_COMMANDER", 
                    threshold = 65, 
                    remove_cost = true, 
                    limit = 0, built = 0, building = 0,
                    buildable = false,
                    locks = true,  
                    tag = "Fleet Commander (Battle Dragon)",
                    crossplot = nil,
                    text = "A new House Maluri fleet commander can be recruited on the political options tab.",
                },
                {unit = "MALURI_COMMANDER_RANA_COMPANY", 
                    threshold = 25, 
                    remove_cost = true, 
                    limit = 0, built = 0, building = 0,
                    buildable = false,
                    locks = true,  
                    tag = "Field Commander (Rana Armored Personnel Carrier)",
                    crossplot = nil,
                    text = "A new House Maluri field commander can be recruited on the political options tab.",
                },
            },
            spawned_rewards = {
            },
            integrates = false,
        },
    },
    --["ALGRAY"] = {},
    --["CORR"] = {},
    --["THANE"] = {},

    -- Hutt Government Favour
    ["HUTT_CARTELS"] = {
        ["SCUM"] = {
            name = "Criminal Underworld",
            faction_name = "HUTT_CARTELS",
            faction = Find_Player("HUTT_CARTELS"),
            favour = 0,
            max_value = 100,
            max_crossplot = nil,
            cycle_increase = 0,
            increase_on_capture = 0,
            reduction_speech = nil,
            support_structures_perception = nil,
            leader_holo = "",
            support_buildables = {
            },
            reward_list = {
                {unit = "HUTT_BOARDING_SHUTTLE", 
                    threshold = 20, 
                    remove_cost = false,
                    locks = true,
                    tag = "Boarding Shuttle",
                    limit = 0, built = 0, building = 0,
                    buildable = false, 
                    crossplot = "HUTT_BOARDING_AVAILABLE",
                    text = "TEXT_CONQUEST_GOVERNMENT_HUTTS_HUTT_BOARDING_SHUTTLE_AVAILABLE",
                },
                {unit = "DARKSABER", 
                    threshold = 100, 
                    remove_cost = false,
                    locks = true,
                    tag = "Darksaber", 
                    limit = 1, built = 0, building = 0,
                    buildable = false, 
                    crossplot = "DARKSABER_AVAILABLE",
                    text = "TEXT_CONQUEST_GOVERNMENT_HUTTS_DARKSABER_AVAILABLE",
                }
            },
            spawned_rewards = {
                    ["OTTO_TEAM"] = {
                        threshold = 10,
                        tag = "Otto (AT-ST)",
                        remove_cost = false,
                        unique = true, spawned = false,
                        text = "TEXT_CONQUEST_GOVERNMENT_HUTTS_OTTO_AVAILABLE",
                    },
                    ["GANIS_NAL_HUTTA_JEWEL"] = {
                        threshold = 30,
                        tag = "Ganis (Heavy Minstrel Yacht)",
                        remove_cost = false,
                        unique = true, spawned = false,
                        text = "TEXT_CONQUEST_GOVERNMENT_HUTTS_GANIS_NAL_AVAILABLE",
                    },
                    ["TAGOONTA_TEAM"] = {
                        threshold = 40,
                        tag = "Tagoonta (Minor Shell Hutt)",
                        remove_cost = false,
                        unique = true, spawned = false,
                        text = "TEXT_CONQUEST_GOVERNMENT_HUTTS_TAGOONTA_AVAILABLE",
                    },
                    ["TOBBA_YTOBBA"] = {
                        threshold = 60,
                        tag = "Tobba (Szajin Cruiser)",
                        remove_cost = false,
                        unique = true, spawned = false,
                        text = "TEXT_CONQUEST_GOVERNMENT_HUTTS_TOBBA_YTOBBA_AVAILABLE",
                    },
                    ["RIBOGA_RIGHTFUL_DOMINION"] = {
                        threshold = 80,
                        tag = "Riboga (Vontor Destroyer)",
                        remove_cost = false,
                        unique = true, spawned = false,
                        text = "TEXT_CONQUEST_GOVERNMENT_HUTTS_RIBOGA_AVAILABLE",
                    },
            },
            integrates = false,
        },
        ["HUTT_MOBILIZATION"] = {
            name = "Hutt Empire",
            faction_name = "HUTT_CARTELS",
            faction = Find_Player("HUTT_CARTELS"),
            favour = 0,
            max_value = 500,
            max_crossplot = nil,
            cycle_increase = 0,
            increase_on_capture = 0,
            reduction_speech = nil,
            support_structures_perception = nil,
            leader_holo = "",
            support_buildables = {
                {name = "BH_GALACTIC_JUVARD_FRIGATE", value = 4, locks = false},
                {name = "BH_GALACTIC_BARABBULA_FRIGATE", value = 5, locks = false},
                {name = "BH_GALACTIC_KOSSAK_FRIGATE", value = 6, locks = false},
                {name = "BH_GALACTIC_TARRADA_FRIGATE", value = 6, locks = false},
                {name = "BH_GALACTIC_UBRIKKIAN_CRUISER_GCW", value = 7, locks = false},
                {name = "BH_GALACTIC_TEMPEST_CRUISER", value = 10, locks = false},
                {name = "BH_GALACTIC_BATIL_CARRIER", value = 11, locks = false},
                {name = "BH_GALACTIC_SZAJIN_CRUISER", value = 14, locks = false},
                {name = "BH_GALACTIC_KARAGGA_DESTROYER", value = 14, locks = false},
                {name = "BH_GALACTIC_CHELANDION_CRUISER", value = 14, locks = false},
                {name = "BH_GALACTIC_VONTOR_DESTROYER", value = 25, locks = false},
                {name = "BH_GALACTIC_KARABOS_CRUISER", value = 30, locks = false},
                -- AI versions
                {name = "BH_GALACTIC_JUVARD_FRIGATE_AI", value = 4, locks = false},
                {name = "BH_GALACTIC_BARABBULA_FRIGATE_AI", value = 5, locks = false},
                {name = "BH_GALACTIC_KOSSAK_FRIGATE_AI", value = 6, locks = false},
                {name = "BH_GALACTIC_TARRADA_FRIGATE_AI", value = 6, locks = false},
                {name = "BH_GALACTIC_UBRIKKIAN_CRUISER_GCW_AI", value = 7, locks = false},
                {name = "BH_GALACTIC_TEMPEST_CRUISER_AI", value = 10, locks = false},
                {name = "BH_GALACTIC_BATIL_CARRIER_AI", value = 11, locks = false},
                {name = "BH_GALACTIC_SZAJIN_CRUISER_AI", value = 14, locks = false},
                {name = "BH_GALACTIC_KARAGGA_DESTROYER_AI", value = 14, locks = false},
                {name = "BH_GALACTIC_CHELANDION_CRUISER_AI", value = 14, locks = false},
                {name = "BH_GALACTIC_VONTOR_DESTROYER_AI", value = 25, locks = false},
                {name = "BH_GALACTIC_KARABOS_CRUISER_AI", value = 30, locks = false}
            },
            reward_list = {
                {unit = "BATIL_CARRIER", 
                    threshold = 100, 
                    remove_cost = false,
                    locks = true,
                    tag = "Batil Carrier", 
                    limit = 0, built = 0, building = 0,
                    buildable = false, 
                    crossplot = "BATIL_AVAILABLE",
                    text = "TEXT_CONQUEST_GOVERNMENT_HUTTS_BATIL_AVAILABLE",
                },
                {unit = "CHELANDION_CRUISER", 
                    threshold = 200, 
                    remove_cost = false,
                    locks = true,
                    tag = "Chelandion Cruiser", 
                    limit = 0, built = 0, building = 0,
                    buildable = false, 
                    crossplot = "CHELANDION_AVAILABLE",
                    text = "TEXT_CONQUEST_GOVERNMENT_HUTTS_CHELANDION_AVAILABLE",
                },
                {unit = "TARRADA_FRIGATE", 
                    threshold = 300, 
                    remove_cost = false,
                    locks = true,
                    tag = "Tarrada Frigate", 
                    limit = 0, built = 0, building = 0,
                    buildable = false, 
                    crossplot = "TARRADA_AVAILABLE",
                    text = "TEXT_CONQUEST_GOVERNMENT_HUTTS_TARRADA_AVAILABLE",
                },
                {unit = "UBRIKKIAN_CRUISER_GCW", 
                    threshold = 400, 
                    remove_cost = false,
                    locks = true,
                    tag = "Ubrikkian Cruiser", 
                    limit = 0, built = 0, building = 0,
                    buildable = false, 
                    crossplot = "UBRIKKIAN_CRUISER_AVAILABLE",
                    text = "TEXT_CONQUEST_GOVERNMENT_HUTTS_UBRIKKIAN_CRUISER_AVAILABLE",
                },
                {unit = "KARABOS_DESTROYER", 
                    threshold = 500, 
                    remove_cost = false,
                    locks = true,
                    tag = "Karabos Destroyer", 
                    limit = 0, built = 0, building = 0,
                    buildable = false, 
                    crossplot = "KARABOS_AVAILABLE",
                    text = "TEXT_CONQUEST_GOVERNMENT_HUTTS_KARABOS_AVAILABLE",
                },
				{unit = "TROONOLUPGRADE", 
                    threshold = 500, 
                    remove_cost = false,
                    locks = true,
                    tag = "Karabos Destroyer Upgrade for Troonol", 
                    limit = 0, built = 0, building = 0,
                    buildable = false,
					--crossplot = "KARABOS_UPGRADE",
                    --text = "TEXT_CONQUEST_GOVERNMENT_HUTTS_KARABOS_UPGRADE",
                }
                -- {unit = "HUTT_EMPIRE_UNLOCK", 
                --     threshold = 100, 
                --     remove_cost = false, 
                --     tag = "Unlock Hutt Empire",
                --     limit = 1, built = 0, building = 0,
                --     buildable = false, 
                --     crossplot = "HUTT_EMPIRE_AVAILABLE",
                --     text = nil,
                -- }
                },
            spawned_rewards = {
                    ["ULAL_POTALA_UM_VAR"] = {
                        threshold = 400,
                        tag = "Ulal (Vontor Destroyer)",
                        remove_cost = false,
                        unique = true, spawned = false,
                        text = "TEXT_CONQUEST_GOVERNMENT_HUTTS_ULAL_AVAILABLE",
                    },
            },
            integrates = false,
        },
    }
}