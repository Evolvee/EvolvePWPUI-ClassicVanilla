
M6DB = {
	["icRangeColor"] = "ffffff",
	["groups"] = {
	},
	["icManaColor"] = "8080ff",
	["actions"] = {
		{
			"imptext", -- [1]
			"/cqs\n/cancelaura Mind Control\n/cast {{spell:605}}", -- [2]
			["globalBind"] = "SHIFT-BUTTON4",
			["name"] = "MC target",
		}, -- [1]
		{
			"imptext", -- [1]
			"/cqs\n/cancelaura Mind Control\n/cast [target=focus, exists] {{spell:605}}", -- [2]
			["globalBind"] = "CTRL-BUTTON4",
			["name"] = "MC focus",
		}, -- [2]
		{
			"imptext", -- [1]
			"/cqs\n/cast {{spellr:48078}}", -- [2]
			["globalBind"] = "MOUSEWHEELUP",
			["name"] = "Holy Nova",
		}, -- [3]
		{
			"imptext", -- [1]
			"/cancelaura Dispersion", -- [2]
			["globalBind"] = "ALT-MOUSEWHEELDOWN",
			["name"] = "Cancelaura Dispersion 1",
		}, -- [4]
		{
			"imptext", -- [1]
			"/cancelaura Dispersion", -- [2]
			["globalBind"] = "SHIFT-MOUSEWHEELDOWN",
			["name"] = "Cancelaura Dispersion 2",
		}, -- [5]
		{
			"imptext", -- [1]
			"#showtooltip {{spell:988}}\n/cqs\n/cast [target=party2, exists] {{spellr:988}}", -- [2]
			["globalBind"] = "CTRL-C",
			["name"] = "Dispel Party2",
		}, -- [6]
		{
			"imptext", -- [1]
			"#showtooltip {{spell:988}}\n/cqs\n/cast [target=pet, exists] {{spellr:988}}", -- [2]
			["globalBind"] = "SHIFT-R",
			["name"] = "Dispel Pet",
		}, -- [7]
		{
			"imptext", -- [1]
			"/cqs\n/cast [target=pet, exists] {{spell:6346}}", -- [2]
			["globalBind"] = "CTRL-R",
			["name"] = "Fear Ward Pet",
		}, -- [8]
		{
			"imptext", -- [1]
			"/cqs\n/target Ebon Gargoyle\n/cast {{spellr:10955}}\n/targetlasttarget", -- [2]
			["globalBind"] = "SHIFT-G",
			["name"] = "Shackle Gargoyle",
		}, -- [9]
		{
			"imptext", -- [1]
			"/cqs\n/cast [@cursor] !{{spell:32375}}", -- [2]
			["globalBind"] = "BUTTON4",
			["name"] = "Mass Dispel",
		}, -- [10]
		{
			"imptext", -- [1]
			"/stopcasting\n/cancelaura Dispersion\n/cast Shadowmeld", -- [2]
			["globalBind"] = "SHIFT-X",
			["name"] = "Meld",
		}, -- [11]
		{
			"imptext", -- [1]
			"/cast [target=Player] Bauble of True Blood\n/cast Battlemaster's Vivacity", -- [2]
			["globalBind"] = "ALT-MOUSEWHEELUP",
			["name"] = "Trinket Heal Self",
		}, -- [12]
		{
			"imptext", -- [1]
			"/cast [target=party1, exists] Bauble of True Blood", -- [2]
			["globalBind"] = "SHIFT-MOUSEWHEELUP",
			["name"] = "Trinket Heal P1",
		}, -- [13]
		{
			"imptext", -- [1]
			"/cast [target=party2, exists] Bauble of True Blood", -- [2]
			["globalBind"] = "CTRL-MOUSEWHEELUP",
			["name"] = "Trinket Heal P2",
		}, -- [14]
		{
			"imptext", -- [1]
			"/cqs\n/cast [nopet] {{spell:34433}}\n/petattack\n/cast Shadowcrawl", -- [2]
			["globalBind"] = "R",
			["name"] = "Shadowfiend",
		}, -- [15]
		{
			"imptext", -- [1]
			"", -- [2]
			["globalBind"] = "CTRL-BUTTON5",
			["name"] = "SWD to Poly/Seduction ONLY",
		}, -- [16]
		{
			"imptext", -- [1]
			"#showtooltip  {{spell:48158}}\n/cancelaura Dispersion\n/cast [@target, harm] {{spell:48158}}\n/stopmacro [harm]\n/targetenemy\n/cast {{spell:48158}}\n/targetlasttarget [harm]", -- [2]
			["globalBind"] = "BUTTON5",
			["name"] = "M6 SWD Regular",
		}, -- [17]
		{
			"imptext", -- [1]
			"/cqs\n/cancelaura Dispersion\n/cast [exists] {{spell:64044}}", -- [2]
			["globalBind"] = "F",
			["name"] = "Horror Target",
		}, -- [18]
		{
			"imptext", -- [1]
			"/cqs\n/cancelaura Dispersion\n/cast [target=focus, exists] {{spell:64044}}", -- [2]
			["globalBind"] = "SHIFT-F",
			["name"] = "Horror Focus",
		}, -- [19]
		{
			"imptext", -- [1]
			"/cqs\n/cancelaura Dispersion\n/cast [exists] {{spell:15487}}", -- [2]
			["globalBind"] = "V",
			["name"] = "Silence Target",
		}, -- [20]
		{
			"imptext", -- [1]
			"/cqs\n/cancelaura Dispersion\n/cast [target=focus, exists] {{spell:15487}}", -- [2]
			["globalBind"] = "SHIFT-V",
			["name"] = "Silence Focus",
		}, -- [21]
		{
			"imptext", -- [1]
			"/use Medallion of the Alliance\n/cast {{spell:59752}}", -- [2]
			["globalBind"] = "CAPSLOCK",
			["icon"] = 133453,
			["name"] = "PVP Trinket",
		}, -- [22]
		{
			"imptext", -- [1]
			"/cqs\n/cancelaura Dispersion\n/cast [target=focus, exists] {{spell:48158}}", -- [2]
			["globalBind"] = "SHIFT-BUTTON5",
			["name"] = "SWD Focus (TEMP)",
		}, -- [23]
		{
			"imptext", -- [1]
			".gender\n.race 5\n.hairstyle 4\n.haircolor 9\n.item 3 35086\n.item 5 35087\n.item 19 35221\n.item 10 35053\n.item 6 35153\n.item 16 1728\n.item 1 19984\n.enchant 1 1\n.mount 25335\n.spell 48156 46562\n", -- [2]
			["icon"] = 254858,
			["name"] = "imorph HUMAN",
		}, -- [24]
		{
			"imptext", -- [1]
			".race 5\n.face 2\n.hairstyle 4\n.haircolor 9\n.skincolor 3\n.features 5\n.item 3 35086\n.item 5 35087\n.item 19 35221\n.item 10 35053\n.item 6 35153\n.item 16 1728\n.item 1 19984\n.enchant 1 1\n.mount 25335\n.spell 48156 46562\n.spell 58984 1856\n", -- [2]
			["icon"] = 132902,
			["name"] = "IMORPH NE",
		}, -- [25]
	},
	["profiles"] = {
		["Stitches"] = {
			["Evolvepwp"] = {
				{
					["slots"] = {
					},
					["bind"] = {
					},
				}, -- [1]
			},
		},
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
