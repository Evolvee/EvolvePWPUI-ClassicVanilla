
M6DB = {
	["icRangeColor"] = "ffffff",
	["groups"] = {
	},
	["icManaColor"] = "8080ff",
	["actions"] = {
		{
			"imptext", -- [1]
			"/cqs\n/cast [@cursor] {{spellr:10}}", -- [2]
			["globalBind"] = "MOUSEWHEELUP",
			["name"] = "r1 Blizzard",
		}, -- [1]
		{
			"imptext", -- [1]
			"#showtooltip Conjured Mineral Water\n/use [nomoving] Conjured Mineral Water\n/use [nomoving] Conjured Pumpernickel", -- [2]
			["name"] = "DRINK",
		}, -- [2]
		{
			"imptext", -- [1]
			"#showtooltip {{spell:1953}}\n/cqs\n/stopcasting\n/cast {{spell:1953}}", -- [2]
			["globalBind"] = "BUTTON5",
			["name"] = "Blink",
		}, -- [3]
		{
			"imptext", -- [1]
			"/cast {{spell:12824}}", -- [2]
			["globalBind"] = "SHIFT-V",
			["name"] = "max rank",
		}, -- [4]
		{
			"imptext", -- [1]
			"#showtooltip {{spell:11958}}\n/cast {{spell:12523}}\n/cqs\n/stopcasting\n/cancelaura Ice Block\n/cast {{spell:11958}}", -- [2]
			["globalBind"] = "MOUSEWHEELDOWN",
			["name"] = "block",
		}, -- [5]
		{
			"imptext", -- [1]
			"/cancelaura Ice Block", -- [2]
			["globalBind"] = "ALT-MOUSEWHEELDOWN",
			["name"] = "cancel block",
		}, -- [6]
		{
			"imptext", -- [1]
			"/cancelaura Ice Block", -- [2]
			["globalBind"] = "CTRL-MOUSEWHEELDOWN",
			["name"] = "cancel block2",
		}, -- [7]
		{
			"imptext", -- [1]
			"/cqs\n/cast {{spellr:116}}\n", -- [2]
			["globalBind"] = "BUTTON4",
			["name"] = "FB R1",
		}, -- [8]
		{
			"imptext", -- [1]
			"/cqs\n/cast {{spellr:120}}", -- [2]
			["globalBind"] = "SHIFT-4",
			["name"] = "Cone r1",
		}, -- [9]
		{
			"imptext", -- [1]
			"/cqs\n/cast {{spell:6131}}", -- [2]
			["globalBind"] = "SHIFT-3",
			["name"] = "Frost nova MAX rank",
		}, -- [10]
		{
			"imptext", -- [1]
			"/cast  {{spell:425121}}\n/cast  {{spell:12042}}\n/use  Hyperconductive Goldwrap\n/use  Gneuro-Linked Arcano-Filament Monocle", -- [2]
			["globalBind"] = "SHIFT-SPACE",
			["name"] = "burst",
		}, -- [11]
		{
			"imptext", -- [1]
			"/cqs\n/cast [@target, nodead, help] [@player] {{spell:436516}}", -- [2]
			["globalBind"] = "X",
			["name"] = "REGENx",
		}, -- [12]
		{
			"imptext", -- [1]
			"/cqs\n/cast {{spell:8417}}", -- [2]
			["globalBind"] = "SHIFT-BUTTON4",
			["name"] = "missiles",
		}, -- [13]
	},
	["profiles"] = {
		["Classic Era PTR"] = {
			["Evolvepwp"] = {
				{
					["slots"] = {
					},
					["bind"] = {
					},
				}, -- [1]
			},
		},
		["Living Flame"] = {
			["Evolvepwp"] = {
				{
					["slots"] = {
					},
					["bind"] = {
					},
				}, -- [1]
			},
			["Evolve"] = {
				{
					["slots"] = {
						["s01"] = 2,
					},
					["bind"] = {
					},
				}, -- [1]
			},
		},
		["Firemaw"] = {
			["Evolvepwp"] = {
				{
					["slots"] = {
						["s01"] = 17,
					},
					["bind"] = {
					},
				}, -- [1]
				{
					["slots"] = {
						["s01"] = 17,
					},
					["bind"] = {
					},
				}, -- [2]
			},
			["Evolvepwe"] = {
				{
					["slots"] = {
						["s01"] = 17,
					},
					["bind"] = {
					},
				}, -- [1]
				{
					["slots"] = {
					},
					["bind"] = {
					},
				}, -- [2]
			},
			["Evolvebanned"] = {
				{
					["slots"] = {
					},
					["bind"] = {
					},
				}, -- [1]
			},
		},
	},
}
