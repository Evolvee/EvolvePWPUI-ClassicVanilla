
WeakAurasSaved = {
	["dynamicIconCache"] = {
	},
	["editor_tab_spaces"] = 4,
	["login_squelch_time"] = 10,
	["RealTimeProfilingWindow"] = {
		["xOffset"] = 203.3777770996094,
		["yOffset"] = -182.7555541992188,
	},
	["minimap"] = {
		["minimapPos"] = 228.8875173730628,
		["hide"] = true,
	},
	["lastUpgrade"] = 1702466731,
	["ProfilingWindow"] = {
		["xOffset"] = 738.5557250976562,
		["yOffset"] = -262.4444580078125,
	},
	["displays"] = {
		["wsg rez timer and fc/efc hp"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "cNXgQKDMd",
			["authorOptions"] = {
				{
					["type"] = "number",
					["useDesc"] = true,
					["max"] = 5,
					["step"] = 1,
					["width"] = 1,
					["min"] = 1,
					["key"] = "avRezThreshold",
					["default"] = 2,
					["name"] = "AV Rez Threshold",
					["desc"] = "This # is how many people must rez within 100ms to resync the timer!",
				}, -- [1]
				{
					["type"] = "number",
					["useDesc"] = true,
					["max"] = 5,
					["step"] = 1,
					["width"] = 1,
					["min"] = 1,
					["key"] = "wsgRezThreshold",
					["default"] = 2,
					["name"] = "WSG Rez Threshold",
					["desc"] = "This # is how many people must rez within 100ms to resync the timer!",
				}, -- [2]
				{
					["text"] = "",
					["type"] = "header",
					["useName"] = false,
					["width"] = 1,
				}, -- [3]
				{
					["type"] = "toggle",
					["default"] = true,
					["width"] = 1,
					["name"] = "Manual Sync",
					["useDesc"] = true,
					["key"] = "manual",
					["desc"] = "Allows you to use a macro to manually sync everyones Graveyard Timer, Uncheck if you don't want this feature",
				}, -- [4]
				{
					["text"] = "\nManual Sync Macro\nPress When Enemy Rez's If Timer Is Wrong\n\n/script WeakAuras.ScanEvents(\"BG_REZ_SYNC\", \"SYNC\");",
					["type"] = "description",
					["fontSize"] = "medium",
					["width"] = 2,
				}, -- [5]
				{
					["type"] = "number",
					["useDesc"] = false,
					["max"] = 1,
					["step"] = 0.05,
					["width"] = 1,
					["min"] = 0,
					["key"] = "option6",
					["default"] = 0,
					["name"] = "Lag Tolereance",
				}, -- [6]
			},
			["displayText"] = "%c",
			["customText"] = "function()\n    local now = GetTime();\n    aura_env.HordeRess = aura_env.numHorde - aura_env.numHordeOld;\n    aura_env.AllyRess = aura_env.numAlliance - aura_env.numAllianceOld;\n    \n    if ((aura_env.aliveLC == nil or aura_env.totalUnitsLC == nil) and aura_env.enabled) then\n        aura_env.aliveLC, aura_env.totalUnitsLC = aura_env.getRaidInfo();\n    end\n    \n    if (aura_env.aliveLC ~= nil and aura_env.totalUnitsLC ~= nil and (aura_env.lastRezCheck == nil or aura_env.lastRezCheck + aura_env.lastRezThrottle <= now)) then\n        local alive, totalUnits = aura_env.getRaidInfo();\n        if (aura_env.shouldUpdateRezTimer(alive, aura_env.aliveLC, totalUnits, aura_env.totalUnitsLC)) then\n            aura_env.nextRez = now + aura_env.rezInterval;\n            aura_env.numHordeOld = aura_env.numHorde;\n            aura_env.numAllianceOld = aura_env.numAlliance;\n            \n            if ((UnitFactionGroup(\"player\") == \"Horde\") and aura_env.AllyRess > 0) then\n                print(string.format(\"Enemies Ressed: %d\", aura_env.AllyRess))\n            elseif ((UnitFactionGroup(\"player\") == \"Alliance\") and aura_env.HordeRess > 0) then\n                print(string.format(\"Enemies Ressed: %d\", aura_env.HordeRess))\n            end\n            \n            aura_env.HordeRess = 0;\n            aura_env.AllyRess = 0;\n        end\n        aura_env.lastRezCheck = now;\n        aura_env.aliveLC = alive;\n        aura_env.totalUnitsLC = totalUnits\n    end\n    \n    if (aura_env.nextRez ~= nil) then\n        local time = aura_env.nextRez - now;\n        \n        if (time <= 0) then\n            aura_env.nextRez = now + aura_env.rezInterval;\n            aura_env.numHordeOld = aura_env.numHorde;\n            aura_env.numAllianceOld = aura_env.numAlliance;\n            \n            if ((UnitFactionGroup(\"player\") == \"Horde\") and aura_env.AllyRess > 0) then\n                print(string.format(\"Enemies Ressed: %d\", aura_env.AllyRess))\n            elseif ((UnitFactionGroup(\"player\") == \"Alliance\") and aura_env.HordeRess > 0) then\n                print(string.format(\"Enemies Ressed: %d\", aura_env.HordeRess))\n            end\n            \n            aura_env.HordeRess = 0;\n            aura_env.AllyRess = 0;\n        end\n        \n        if (time <= 2) then\n            RequestBattlefieldScoreData();\n        end\n        \n        if ((UnitFactionGroup(\"player\") == \"Horde\") and aura_env.AllyRess >= 0) then\n            return string.format(\"GY Timer: %.1f \\n Ressing: %d\", time, aura_env.AllyRess);\n        elseif ((UnitFactionGroup(\"player\") == \"Alliance\") and aura_env.HordeRess >= 0) then\n            return string.format(\"GY Timer: %.1f \\n Ressing: %d\", time, aura_env.HordeRess);\n        else\n            return string.format(\"GY Timer: %.1f \\n Ressing: --\", time);\n        end\n    end\n    return \"GY Timer: -- \\n Ressing: --\";\nend",
			["yOffset"] = 170.9940185546875,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
					["custom"] = "-- Config Vars\naura_env.startText = {\n    [\"The battle for Alterac Valley has begun!\"] = 0,\n    [\"Let the battle for Warsong Gulch begin!\"] = 5,\n}\n\naura_env.zones = {\n    [\"Alterac Valley\"] = false,\n    [\"Warsong Gulch\"] = true,\n}\n\naura_env.prefix = \"AuroBGRez\";\nC_ChatInfo.RegisterAddonMessagePrefix(aura_env.prefix)\n\n-- I've seen Rez's in between 31 - 32; 31.5 Seems most common\naura_env.rezInterval = 31.5;\naura_env.lastRezThrottle = 0.1;\naura_env.lastRezPlayerReq = 2;\n\n-- Reused Variables\naura_env.enabled = false;\naura_env.nextRez = nil;\naura_env.aliveLC = nil;\naura_env.lastRezCheck = nil;\naura_env.totalUnitsLC = nil;\naura_env.numHorde = 0;\naura_env.numAlliance = 0;\naura_env.numHordeOld = 0;\naura_env.numAllianceOld = 0;\naura_env.HordeRess = 0;\naura_env.AllyRess = 0;\n\n-- Functions\naura_env.resetState = function()\n    aura_env.enabled = false;\n    aura_env.nextRez = nil;\n    aura_env.aliveLC = nil;\n    aura_env.lastRezCheck = nil;    \n    aura_env.totalUnitsLC = nil;\n    aura_env.numHorde = 0;\n    aura_env.numAlliance = 0;\n    aura_env.numHordeOld = 0;\n    aura_env.numAllianceOld = 0;\n    aura_env.HordeRess = 0;\n    aura_env.AllyRess = 0;\nend\n\naura_env.getRaidInfo = function()\n    local c = 0;\n    local t = 0;\n    for unit in WA_IterateGroupMembers() do\n        t = t + 1;\n        local alive = not UnitIsDeadOrGhost(unit);\n        if (alive) then\n            c = c + 1; \n        end\n    end\n    return c, t;\nend\n\naura_env.shouldUpdateRezTimer = function(alive, aliveLC, totalUnits, totalUnitsLC)\n    if (aliveLC + aura_env.getRezThreshold() <= alive and totalUnits == totalUnitsLC) then\n        return true; \n    end\nend\n\naura_env.getRezThreshold = function()\n    local zone = GetZoneText();\n    if (zone == \"Alterac Valley\") then\n        return aura_env.config.avRezThreshold;\n    end\n    \n    if (zone == \"Warsong Gulch\") then\n        return aura_env.config.wsgRezThreshold\n    end\n    \n    return aura_env.lastRezPlayerReq;\nend",
					["do_custom"] = true,
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["custom_type"] = "status",
						["debuffType"] = "HELPFUL",
						["event"] = "Health",
						["unit"] = "player",
						["spellIds"] = {
						},
						["events"] = "CHAT_MSG_BG_SYSTEM_NEUTRAL, CHAT_MSG_BG_SYSTEM_ALLIANCE, BG_REZ_SYNC, CHAT_MSG_ADDON, ZONE_CHANGED_NEW_AREA, UPDATE_BATTLEFIELD_SCORE, PLAYER_UNGHOST",
						["custom"] = "function(e, ...)\n    if (e == \"CHAT_MSG_BG_SYSTEM_NEUTRAL\" or e == \"CHAT_MSG_BG_SYSTEM_ALLIANCE\") then\n        local message = select(1, ...);\n        local startOffset = aura_env.startText[message];\n        if (startOffset ~= nil) then\n            aura_env.nextRez = GetTime() + aura_env.rezInterval + startOffset;\n        end\n    end\n    \n    if (e == \"BG_REZ_SYNC\") then\n        local msg = select(1, ...);\n        local _, instanceType = IsInInstance();\n        if (instanceType == \"pvp\" and msg == \"SYNC\") then\n            C_ChatInfo.SendAddonMessage(aura_env.prefix, \"SYNC\", \"INSTANCE_CHAT\")    \n        end\n    end\n    \n    if (e == \"CHAT_MSG_ADDON\") then\n        local prefix = select(1, ...);\n        local text = select(2, ...);\n        local channel = select(3, ...);\n        local sender = select(4, ...);\n        if (prefix == aura_env.prefix and aura_env.config.manual and text == \"SYNC\") then\n            aura_env.nextRez = GetTime() + aura_env.rezInterval\n            aura_env.numHordeOld = aura_env.numHorde;\n            aura_env.numAllianceOld = aura_env.numAlliance;\n            aura_env.HordeRess = 0;\n            aura_env.AllyRess = 0;\n        end\n    end\n    \n    if (e == \"ZONE_CHANGED_NEW_AREA\") then\n        aura_env.resetState();\n        local zone = GetZoneText();\n        if (aura_env.zones[zone] == true) then\n            aura_env.enabled = true;\n        else\n            aura_env.enabled = false;\n        end \n    end\n    \n    if (e == \"UPDATE_BATTLEFIELD_SCORE\") then\n        aura_env.numHorde = 0;\n        aura_env.numAlliance = 0;\n        RequestBattlefieldScoreData();\n        local numScores = GetNumBattlefieldScores()\n        for i=1, numScores do\n            local _, _, _, deaths, _, faction = GetBattlefieldScore(i);\n            if (faction) then\n                if (faction == 0) then\n                    aura_env.numHorde = aura_env.numHorde + deaths\n                    \n                else\n                    aura_env.numAlliance = aura_env.numAlliance + deaths\n                    \n                end\n            end\n        end\n    end\n    \n    if (e == \"PLAYER_UNGHOST\") then\n        local _, iType = IsInInstance();\n        if (iType == \"pvp\" and (UnitHealth(\"player\")/UnitHealthMax(\"player\"))*100 == 100) then\n            C_ChatInfo.SendAddonMessage(aura_env.prefix, \"SYNC\", \"INSTANCE_CHAT\")\n            if not aura_env.config.manual then\n                aura_env.nextRez = GetTime() + aura_env.rezInterval\n                aura_env.numHordeOld = aura_env.numHorde;\n                aura_env.numAllianceOld = aura_env.numAlliance;\n                aura_env.HordeRess = 0;\n                aura_env.AllyRess = 0;\n            end\n        end\n    end\n    \n    return aura_env.enabled;\nend",
						["names"] = {
						},
						["check"] = "event",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
						["custom"] = "function()\n   return not aura_env.enabled; \nend",
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["selfPoint"] = "BOTTOM",
			["desc"] = "Edited by Swagkhalifa (Mograine EU)",
			["font"] = "Friz Quadrata TT",
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_never"] = false,
				["use_ignoreNameRealm"] = false,
				["class"] = {
					["multi"] = {
					},
				},
				["use_zone"] = true,
				["ignoreNameRealm"] = "",
				["zoneIds"] = "",
				["zone"] = "Warsong Gulch",
				["talent"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 20,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["regionType"] = "text",
			["conditions"] = {
			},
			["displayText_format_c_format"] = "none",
			["url"] = "https://wago.io/cNXgQKDMd/1",
			["shadowYOffset"] = -1,
			["xOffset"] = 592.4345092773438,
			["justify"] = "CENTER",
			["semver"] = "1.0.0",
			["tocversion"] = 20502,
			["id"] = "wsg rez timer and fc/efc hp",
			["uid"] = "sZ)3RrDlVCM",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["wordWrap"] = "WordWrap",
			["config"] = {
				["manual"] = true,
				["option6"] = 0,
				["avRezThreshold"] = 2,
				["wsgRezThreshold"] = 2,
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
		},
		["Drink while running - manaregen bar when reminder is active"] = {
			["sparkWidth"] = 10,
			["sparkOffsetX"] = 0,
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["yOffset"] = 100,
			["anchorPoint"] = "BOTTOM",
			["spark"] = false,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["url"] = "https://wago.io/g_yvuk2RN/1",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["custom_type"] = "status",
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["customDuration"] = "function()\n    \n    return 2, wa_DrinkWhileRunning.tickExpirationTime\n    \nend\n\n\n",
						["subeventSuffix"] = "_CAST_START",
						["spellIds"] = {
						},
						["custom"] = "function()\n    if not wa_DrinkWhileRunning then return end\n    \n    \n    local t = WeakAuras.GetActiveTriggers(wa_DrinkWhileRunning.id)\n    \n    \n    if t[2] or t[3] then\n        return true\n    end\n    \nend\n\n\n",
						["check"] = "update",
						["names"] = {
						},
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["icon_color"] = {
				0.07843137254902, -- [1]
				0.72156862745098, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["enableGradient"] = false,
			["selfPoint"] = "CENTER",
			["internalVersion"] = 70,
			["barColor2"] = {
				1, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["barColor"] = {
				0.32549019607843, -- [1]
				0.84313725490196, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["icon"] = false,
			["height"] = 5,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["type"] = "subforeground",
				}, -- [2]
			},
			["gradientOrientation"] = "HORIZONTAL",
			["sparkOffsetY"] = 0,
			["load"] = {
				["use_class"] = false,
				["use_never"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
						["HUNTER"] = true,
						["WARLOCK"] = true,
						["SHAMAN"] = true,
						["MAGE"] = true,
						["DRUID"] = true,
						["PALADIN"] = true,
						["PRIEST"] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["config"] = {
			},
			["source"] = "import",
			["uid"] = "unoCHqo9QRV",
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["anchorFrameType"] = "SCREEN",
			["frameStrata"] = 1,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["anchorFrameFrame"] = "WeakAuras:Drink while running - reminder",
			["sparkHidden"] = "NEVER",
			["icon_side"] = "LEFT",
			["auto"] = true,
			["sparkHeight"] = 30,
			["texture"] = "Blizzard",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["zoom"] = 0,
			["semver"] = "1.0.0",
			["tocversion"] = 11306,
			["id"] = "Drink while running - manaregen bar when reminder is active",
			["iconSource"] = -1,
			["alpha"] = 1,
			["width"] = 250,
			["authorOptions"] = {
			},
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["inverse"] = false,
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0, -- [4]
			},
			["orientation"] = "HORIZONTAL_INVERSE",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["parent"] = "Drink while running",
		},
		["Drink while running"] = {
			["controlledChildren"] = {
				"Drink while running - reminder", -- [1]
				"Drink while running - manaregen bar when reminder is active", -- [2]
				"Drink while running - always active manaregen bar", -- [3]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = 200,
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["url"] = "https://wago.io/g_yvuk2RN/1",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["names"] = {
						},
						["type"] = "aura2",
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["event"] = "Health",
						["unit"] = "player",
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["version"] = 1,
			["subRegions"] = {
			},
			["load"] = {
				["use_class"] = "false",
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["source"] = "import",
			["scale"] = 0.55,
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["regionType"] = "group",
			["borderSize"] = 2,
			["borderOffset"] = 4,
			["semver"] = "1.0.0",
			["tocversion"] = 11306,
			["id"] = "Drink while running",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["xOffset"] = 0,
			["borderInset"] = 1,
			["uid"] = "1Av8O31Zrl6",
			["selfPoint"] = "BOTTOMLEFT",
			["conditions"] = {
			},
			["information"] = {
				["groupOffset"] = true,
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["config"] = {
			},
		},
		["HEAL BUFF"] = {
			["iconSource"] = -1,
			["wagoID"] = "Z56qtVHdT",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = 300,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "aura2",
						["auranames"] = {
							"Chronostatic Preservation", -- [1]
						},
						["matchesShowOn"] = "showOnActive",
						["event"] = "Health",
						["unit"] = "player",
						["unitExists"] = false,
						["ownOnly"] = true,
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["useName"] = true,
						["names"] = {
						},
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["useTooltip"] = false,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeType"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["preset"] = "shrink",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.25,
					["type"] = "subglow",
					["useGlowColor"] = false,
					["glowType"] = "buttonOverlay",
					["glowThickness"] = 1,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["glowDuration"] = 1,
					["glowXOffset"] = 0,
					["glowScale"] = 1,
					["glow"] = true,
					["glowLength"] = 10,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [2]
			},
			["height"] = 70,
			["load"] = {
				["use_class"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "MAGE",
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["source"] = "import",
			["cooldownTextDisabled"] = false,
			["selfPoint"] = "CENTER",
			["regionType"] = "icon",
			["xOffset"] = 0,
			["icon"] = true,
			["cooldown"] = true,
			["internalVersion"] = 70,
			["config"] = {
			},
			["useCooldownModRate"] = true,
			["zoom"] = 0,
			["semver"] = "1.0.0",
			["tocversion"] = 11501,
			["id"] = "HEAL BUFF",
			["anchorFrameType"] = "SCREEN",
			["frameStrata"] = 1,
			["width"] = 70,
			["alpha"] = 1,
			["uid"] = "NpXdkWg8cDZ",
			["inverse"] = false,
			["url"] = "",
			["conditions"] = {
			},
			["information"] = {
			},
			["authorOptions"] = {
			},
		},
		["Renew (P1)"] = {
			["user_y"] = 0,
			["user_x"] = 0,
			["xOffset"] = -39,
			["yOffset"] = 0.57,
			["foregroundColor"] = {
				0, -- [1]
				1, -- [2]
				0.1372549086809158, -- [3]
				1, -- [4]
			},
			["desaturateBackground"] = false,
			["sameTexture"] = true,
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "aura2",
						["auranames"] = {
							"48068", -- [1]
						},
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["spellIds"] = {
						},
						["specificUnit"] = "party1",
						["useName"] = true,
						["names"] = {
						},
						["unit"] = "member",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["endAngle"] = 360,
			["internalVersion"] = 70,
			["selfPoint"] = "CENTER",
			["alpha"] = 1,
			["desc"] = "Renew duration indicator for party1 frame...",
			["rotation"] = 0,
			["font"] = "Friz Quadrata TT",
			["slanted"] = false,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 39,
			["backgroundColor"] = {
				0.501960813999176, -- [1]
				0.501960813999176, -- [2]
				0.501960813999176, -- [3]
				0, -- [4]
			},
			["load"] = {
				["use_class"] = true,
				["use_never"] = true,
				["talent"] = {
					["multi"] = {
						[103] = true,
					},
				},
				["use_talent"] = false,
				["class"] = {
					["single"] = "PRIEST",
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["crop_x"] = 0.41,
			["useAdjustededMax"] = false,
			["fontSize"] = 12,
			["anchorPoint"] = "CENTER",
			["startAngle"] = 0,
			["desaturateForeground"] = false,
			["config"] = {
			},
			["mirror"] = false,
			["useAdjustededMin"] = false,
			["regionType"] = "progresstexture",
			["uid"] = "qNFOL)6H20f",
			["blendMode"] = "BLEND",
			["foregroundTexture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\UI-PartyFlash-Highlight_Renew",
			["anchorFrameType"] = "SELECTFRAME",
			["slantMode"] = "INSIDE",
			["textureWrapMode"] = "CLAMPTOBLACKADDITIVE",
			["anchorFrameFrame"] = "PartyMemberFrame1",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["crop_y"] = 0.41,
			["compress"] = false,
			["id"] = "Renew (P1)",
			["smoothProgress"] = false,
			["frameStrata"] = 1,
			["width"] = 39,
			["backgroundTexture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura3",
			["auraRotation"] = 0,
			["inverse"] = false,
			["authorOptions"] = {
			},
			["orientation"] = "ANTICLOCKWISE",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["backgroundOffset"] = 2,
		},
		["GUILD STV"] = {
			["iconSource"] = -1,
			["wagoID"] = "ahVVVMAW0",
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["url"] = "https://wago.io/ahVVVMAW0/2",
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Blood Moon", -- [1]
						},
						["destNameRealm"] = "Octwo, Eilin",
						["subeventPrefix"] = "SPELL",
						["use_class"] = false,
						["debuffType"] = "HELPFUL",
						["use_namerealm"] = false,
						["useName"] = false,
						["namerealm"] = "",
						["custom_type"] = "stateupdate",
						["custom_hide"] = "custom",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Health",
						["use_destNameRealm"] = false,
						["type"] = "custom",
						["custom"] = "function(allstates, event, unit, ...)\n    if event == \"NAME_PLATE_UNIT_REMOVED\" then\n        if UnitIsPlayer(unit) then\n            local GUID = UnitGUID(unit)\n            local changed = false\n            for k, v in pairs(allstates) do\n                if k == GUID then\n                    v.show = false\n                    v.changed = true\n                    changed = true\n                end \n            end\n            return changed\n        end\n        \n    elseif event == \"NAME_PLATE_UNIT_ADDED\" then\n        if UnitIsPlayer(unit) then\n            local GUID = UnitGUID(unit)\n            local hostile = UnitCanAttack(\"player\", unit)\n            if hostile then\n                local playerGuildName, _ = GetGuildInfo(unit)\n                local playerGuild, _ = GetGuildInfo(\"player\")\n                if playerGuildName == playerGuild then\n                    local name, _ = strsplit(\" \", playerGuild)\n                    allstates[GUID] = {\n                        progressType = \"timed\",\n                        name = name,\n                        show = true,\n                        changed = true,\n                        autoHide = true,\n                        unit = unit\n                    }\n                    return true\n                end\n            end\n        end\n    end\nend\n\n\n\n",
						["spellIds"] = {
						},
						["events"] = "NAME_PLATE_UNIT_ADDED, NAME_PLATE_UNIT_REMOVED",
						["check"] = "event",
						["names"] = {
						},
						["use_unit"] = true,
						["unit"] = "nameplate",
					},
					["untrigger"] = {
						["custom"] = "function(event, unitId, ...)\n    if event == \"NAME_PLATE_UNIT_REMOVED\" then\n        return true\n    end\nend",
					},
				}, -- [1]
				["disjunctive"] = "all",
				["customTriggerLogic"] = "function(t)\n    return t[1] and t[2]\nend",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["rotation"] = 0,
			["version"] = 2,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_text_format_n_format"] = "none",
					["text_text"] = "%n",
					["text_text_format_p_time_mod_rate"] = true,
					["text_selfPoint"] = "CENTER",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["text_text_format_c_format"] = "none",
					["text_text_format_p_time_legacy_floor"] = false,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["anchorXOffset"] = 0,
					["text_text_format_p_format"] = "timed",
					["text_shadowXOffset"] = 1,
					["type"] = "subtext",
					["text_text_format_p_time_format"] = 0,
					["text_color"] = {
						1, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_font"] = "Fira Sans Condensed Medium",
					["text_shadowYOffset"] = -1,
					["text_anchorYOffset"] = 10,
					["text_fontType"] = "OUTLINE",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_fontSize"] = 28,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["anchorYOffset"] = 0,
				}, -- [2]
			},
			["height"] = 65,
			["rotate"] = true,
			["load"] = {
				["talent"] = {
					["multi"] = {
					},
				},
				["use_zone"] = true,
				["use_never"] = false,
				["zone"] = "Stranglethorn Vale",
				["group_leader"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["textureWrapMode"] = "CLAMPTOBLACKADDITIVE",
			["source"] = "import",
			["cooldownTextDisabled"] = false,
			["color"] = {
				0.65882354974747, -- [1]
				0.29019609093666, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["mirror"] = false,
			["cooldownEdge"] = false,
			["regionType"] = "texture",
			["desc"] = "Pike and Max make happy guild friends.",
			["blendMode"] = "BLEND",
			["cooldown"] = false,
			["selfPoint"] = "CENTER",
			["texture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\cancel-icon.tga",
			["uid"] = "SdaTzt)PqCq",
			["zoom"] = 0,
			["semver"] = "1.0.1",
			["tocversion"] = 11501,
			["id"] = "GUILD STV",
			["alpha"] = 1,
			["frameStrata"] = 7,
			["width"] = 65,
			["anchorFrameType"] = "NAMEPLATE",
			["config"] = {
			},
			["inverse"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["authorOptions"] = {
			},
		},
		["Drink while running - always active manaregen bar"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["parent"] = "Drink while running",
			["preferToUpdate"] = false,
			["yOffset"] = -594.41693783798,
			["anchorPoint"] = "BOTTOM",
			["spark"] = false,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["url"] = "https://wago.io/g_yvuk2RN/1",
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0, -- [4]
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["custom_type"] = "status",
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["customDuration"] = "function()\n    \n    return 2, wa_DrinkWhileRunning.tickExpirationTime\n    \nend\n\n\n",
						["subeventSuffix"] = "_CAST_START",
						["spellIds"] = {
						},
						["custom"] = "function()\n    if not wa_DrinkWhileRunning then return end\n    \n    \n    \n    if UnitPower(\"player\",0) >= UnitPowerMax(\"player\",0)\n    then\n        if aura_env.config.showOnFullMana then\n            return true\n        end\n    else\n        return true\n    end\n    \nend\n\n\n",
						["check"] = "update",
						["names"] = {
						},
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["icon_color"] = {
				0.07843137254902, -- [1]
				0.72156862745098, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["sparkOffsetX"] = 0,
			["barColor2"] = {
				1, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["barColor"] = {
				0.32549019607843, -- [1]
				0.84313725490196, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["enableGradient"] = false,
			["sparkOffsetY"] = 0,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["type"] = "subforeground",
				}, -- [2]
			},
			["gradientOrientation"] = "HORIZONTAL",
			["selfPoint"] = "CENTER",
			["load"] = {
				["use_class"] = false,
				["use_never"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
						["HUNTER"] = true,
						["WARLOCK"] = true,
						["SHAMAN"] = true,
						["MAGE"] = true,
						["DRUID"] = true,
						["PALADIN"] = true,
						["PRIEST"] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["source"] = "import",
			["uid"] = "KmEw3mSZr25",
			["height"] = 8.2321729660034,
			["anchorFrameType"] = "SCREEN",
			["frameStrata"] = 1,
			["anchorFrameFrame"] = "WeakAuras:Drink while running - reminder",
			["regionType"] = "aurabar",
			["icon"] = false,
			["id"] = "Drink while running - always active manaregen bar",
			["icon_side"] = "LEFT",
			["semver"] = "1.0.0",
			["sparkHeight"] = 30,
			["texture"] = "Blizzard",
			["zoom"] = 0,
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["auto"] = true,
			["tocversion"] = 11306,
			["sparkHidden"] = "NEVER",
			["useAdjustededMin"] = false,
			["alpha"] = 1,
			["width"] = 374.66561889648,
			["version"] = 1,
			["config"] = {
				["showOnFullMana"] = true,
			},
			["inverse"] = false,
			["xOffset"] = -363.44739596372,
			["orientation"] = "HORIZONTAL_INVERSE",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["authorOptions"] = {
				{
					["type"] = "toggle",
					["default"] = true,
					["key"] = "showOnFullMana",
					["name"] = "Show on full mana",
					["useDesc"] = false,
					["width"] = 1,
				}, -- [1]
			},
		},
		["BLINK CD visual"] = {
			["iconSource"] = -1,
			["wagoID"] = "EJSv8n-lB",
			["color"] = {
				0.984313725490196, -- [1]
				0.9725490196078431, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = false,
			["actions"] = {
				["start"] = {
				},
				["init"] = {
					["do_custom"] = false,
				},
				["finish"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["rem"] = "6000",
						["useStacks"] = false,
						["auranames"] = {
							"Inner Fire", -- [1]
						},
						["matchesShowOn"] = "showOnMissing",
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showOnReady",
						["unit"] = "player",
						["use_showgcd"] = false,
						["stacks"] = "5",
						["names"] = {
						},
						["use_showlossofcontrol"] = false,
						["match_count"] = "1",
						["subeventPrefix"] = "SPELL",
						["useName"] = true,
						["debuffType"] = "HELPFUL",
						["match_countOperator"] = "<",
						["use_remaining"] = false,
						["stacksOperator"] = "<=",
						["useExactSpellId"] = false,
						["use_spellCount"] = false,
						["spellName"] = 1953,
						["event"] = "Cooldown Progress (Spell)",
						["type"] = "spell",
						["realSpellName"] = "Blink",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["remOperator"] = "<=",
						["auraspellids"] = {
							"11025", -- [1]
							"10952", -- [2]
							"7128", -- [3]
							"1254", -- [4]
							"1006", -- [5]
							"588", -- [6]
							"11026", -- [7]
							"10951", -- [8]
							"624", -- [9]
							"7130", -- [10]
							"1252", -- [11]
							"7129", -- [12]
							"602", -- [13]
							"609", -- [14]
							"1253", -- [15]
							"1007", -- [16]
						},
						["use_track"] = true,
						["useRem"] = true,
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["duration_type"] = "seconds",
					["preset"] = "fade",
					["easeStrength"] = 3,
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 6,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["type"] = "subborder",
					["border_offset"] = 1,
					["border_color"] = {
						0.9921568627450981, -- [1]
						1, -- [2]
						0.9686274509803922, -- [3]
						1, -- [4]
					},
					["border_visible"] = true,
					["border_edge"] = "None",
					["border_size"] = 14,
				}, -- [2]
				{
					["glowFrequency"] = 0.25,
					["type"] = "subglow",
					["glowDuration"] = 1,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						0.9490196704864502, -- [2]
						0.9921569228172302, -- [3]
						1, -- [4]
					},
					["glowXOffset"] = 0,
					["useGlowColor"] = true,
					["glow"] = true,
					["glowThickness"] = 1,
					["glowScale"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 48,
			["load"] = {
				["ingroup"] = {
				},
				["use_level"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "MAGE",
					["multi"] = {
						["MAGE"] = true,
						["PRIEST"] = true,
					},
				},
				["use_class"] = true,
				["size"] = {
					["single"] = "pvp",
					["multi"] = {
						["scenario"] = true,
						["ten"] = true,
						["twentyfive"] = true,
						["fortyman"] = true,
						["ratedpvp"] = true,
						["flexible"] = true,
						["ratedarena"] = true,
						["party"] = true,
						["arena"] = true,
						["twenty"] = true,
						["pvp"] = true,
					},
				},
				["use_never"] = false,
				["use_alive"] = true,
				["spec"] = {
					["multi"] = {
					},
				},
				["level"] = {
					"3", -- [1]
				},
				["level_operator"] = {
					">=", -- [1]
				},
				["zoneIds"] = "",
			},
			["width"] = 48,
			["source"] = "import",
			["authorOptions"] = {
			},
			["selfPoint"] = "CENTER",
			["xOffset"] = 320,
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["anchorFrameFrame"] = "PlayerFrame",
			["regionType"] = "icon",
			["displayIcon"] = 135932,
			["icon"] = true,
			["useTooltip"] = false,
			["uid"] = "QPQu9PF22s1",
			["alpha"] = 1,
			["useCooldownModRate"] = true,
			["cooldownTextDisabled"] = false,
			["semver"] = "1.0.5",
			["tocversion"] = 20502,
			["id"] = "BLINK CD visual",
			["auto"] = true,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0,
			["config"] = {
			},
			["inverse"] = false,
			["url"] = "",
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "show",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "sub.3.glow",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "insufficientResources",
						["value"] = 1,
					},
					["changes"] = {
						{
							["property"] = "alpha",
						}, -- [1]
					},
				}, -- [2]
			},
			["cooldown"] = false,
			["desc"] = "Inner Fire at the right side of the screen to rebuff it!",
		},
		["Homonculi duration rework??"] = {
			["sparkWidth"] = 10,
			["sparkOffsetX"] = 0,
			["wagoID"] = "sz3jz7-QJ",
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -2,
			["anchorPoint"] = "CENTER",
			["zoom"] = 0.2,
			["cooldownSwipe"] = false,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["cooldownEdge"] = false,
			["icon"] = false,
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = {
							"34433", -- [1]
						},
						["duration"] = "15",
						["genericShowOn"] = "showOnCooldown",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["unit"] = "player",
						["sourceUnit"] = "player",
						["event"] = "Combat Log",
						["names"] = {
						},
						["realSpellName"] = 0,
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = true,
						["spellName"] = {
							0, -- [1]
						},
						["use_spellName"] = false,
						["use_track"] = true,
						["use_genericShowOn"] = true,
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["iconSource"] = 0,
			["xOffset"] = 68,
			["barColor"] = {
				1, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["cooldownTextDisabled"] = false,
			["url"] = "",
			["version"] = 2,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_text_format_p_time_precision"] = 1,
					["text_text_format_p_big_number_format"] = "AbbreviateLargeNumbers",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_format"] = "Number",
					["text_text_format_p_decimal_precision"] = 0,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_color"] = {
						1, -- [1]
						0.9333333333333333, -- [2]
						0.9372549019607843, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowXOffset"] = 0,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "INNER_LEFT",
					["text_text"] = "%p",
					["text_text_format_p_time_format"] = 0,
					["text_fontSize"] = 20,
					["anchorXOffset"] = 0,
					["text_text_format_p_round_type"] = "floor",
				}, -- [2]
			},
			["height"] = 30,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
					["custom"] = "if not aura_env.region.mask then\n  aura_env.region.mask = aura_env.region:CreateMaskTexture()\nend\naura_env.region.mask:SetTexture([[Interface\\AddOns\\WeakAuras\\Media\\Textures\\Circle_White]])\naura_env.region.mask:SetAllPoints()\naura_env.region.icon:AddMaskTexture(aura_env.region.mask)\naura_env.region.cooldown:SetSwipeTexture([[Interface\\AddOns\\WeakAuras\\Media\\Textures\\Circle_White]], 0,0,0,0.2)\naura_env.region.cooldown:SetUseCircularEdge(true)\n",
					["do_custom"] = false,
				},
			},
			["load"] = {
				["use_class"] = true,
				["use_spellknown"] = false,
				["use_never"] = true,
				["talent"] = {
					["single"] = 62,
					["multi"] = {
						[62] = true,
					},
				},
				["class"] = {
					["single"] = "PRIEST",
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["spellknown"] = 31687,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["source"] = "import",
			["information"] = {
				["forceEvents"] = true,
			},
			["conditions"] = {
			},
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["sparkOffsetY"] = 0,
			["useAdjustededMin"] = false,
			["regionType"] = "icon",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0, -- [4]
			},
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["icon_side"] = "RIGHT",
			["width"] = 30,
			["alpha"] = 1,
			["sparkHeight"] = 30,
			["texture"] = "Blizzard",
			["anchorFrameFrame"] = "PetFrame",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["semver"] = "1.0.1",
			["tocversion"] = 30400,
			["sparkHidden"] = "NEVER",
			["id"] = "Homonculi duration rework??",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SELECTFRAME",
			["useCooldownModRate"] = true,
			["uid"] = "9ni(PItb)Ay",
			["inverse"] = false,
			["spark"] = false,
			["orientation"] = "HORIZONTAL",
			["displayIcon"] = "136199",
			["cooldown"] = false,
			["config"] = {
			},
		},
		["Barrage"] = {
			["iconSource"] = -1,
			["wagoID"] = "Z56qtVHdT",
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = 5.019683837890625,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = true,
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "aura2",
						["auranames"] = {
							"400588", -- [1]
						},
						["matchesShowOn"] = "showOnActive",
						["event"] = "Health",
						["unit"] = "player",
						["unitExists"] = false,
						["ownOnly"] = true,
						["spellIds"] = {
						},
						["names"] = {
						},
						["useName"] = true,
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["duration_type"] = "seconds",
					["preset"] = "shrink",
					["easeStrength"] = 3,
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.25,
					["type"] = "subglow",
					["glowDuration"] = 1,
					["glowType"] = "buttonOverlay",
					["glowThickness"] = 1,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["useGlowColor"] = false,
					["glowXOffset"] = 0,
					["glowLength"] = 10,
					["glow"] = true,
					["glowScale"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [2]
			},
			["height"] = 70,
			["load"] = {
				["use_class"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "MAGE",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["source"] = "import",
			["zoom"] = 0,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["selfPoint"] = "CENTER",
			["icon"] = true,
			["information"] = {
			},
			["url"] = "",
			["uid"] = "0Q6XPpG5LEn",
			["frameStrata"] = 1,
			["cooldownTextDisabled"] = false,
			["semver"] = "1.0.0",
			["tocversion"] = 11501,
			["id"] = "Barrage",
			["width"] = 70,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["useCooldownModRate"] = true,
			["config"] = {
			},
			["inverse"] = false,
			["useTooltip"] = false,
			["conditions"] = {
			},
			["cooldown"] = true,
			["xOffset"] = -266.0000610351563,
		},
		["PW: Shield (P1)"] = {
			["user_y"] = 0,
			["user_x"] = 0,
			["authorOptions"] = {
			},
			["yOffset"] = 0.57,
			["foregroundColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["desaturateBackground"] = false,
			["sameTexture"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "aura2",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["auranames"] = {
							"6788", -- [1]
						},
						["spellIds"] = {
						},
						["specificUnit"] = "party1",
						["unit"] = "member",
						["names"] = {
						},
						["useName"] = true,
						["debuffType"] = "HARMFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["endAngle"] = 360,
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["frameStrata"] = 1,
			["desc"] = "Shield CD on Party1 indicator...",
			["rotation"] = 0,
			["font"] = "Friz Quadrata TT",
			["backgroundOffset"] = 2,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 43,
			["backgroundTexture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura3",
			["load"] = {
				["use_class"] = true,
				["use_never"] = true,
				["talent"] = {
					["multi"] = {
						[103] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "PRIEST",
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["use_talent"] = false,
			},
			["conditions"] = {
			},
			["useAdjustededMax"] = false,
			["textureWrapMode"] = "CLAMPTOBLACKADDITIVE",
			["backgroundColor"] = {
				0.5, -- [1]
				0.5, -- [2]
				0.5, -- [3]
				0.5, -- [4]
			},
			["startAngle"] = 0,
			["desaturateForeground"] = false,
			["anchorFrameFrame"] = "PartyMemberFrame1",
			["mirror"] = false,
			["useAdjustededMin"] = false,
			["regionType"] = "progresstexture",
			["uid"] = "nD2epxy)96V",
			["blendMode"] = "BLEND",
			["foregroundTexture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\UI-PartyFlash-Highlight_Shield",
			["width"] = 43,
			["slantMode"] = "INSIDE",
			["fontSize"] = 12,
			["crop_y"] = 0.41,
			["anchorPoint"] = "CENTER",
			["selfPoint"] = "CENTER",
			["compress"] = false,
			["id"] = "PW: Shield (P1)",
			["smoothProgress"] = false,
			["alpha"] = 1,
			["anchorFrameType"] = "SELECTFRAME",
			["config"] = {
			},
			["auraRotation"] = 0,
			["inverse"] = false,
			["xOffset"] = -39,
			["orientation"] = "ANTICLOCKWISE",
			["crop_x"] = 0.41,
			["information"] = {
				["forceEvents"] = true,
			},
			["slanted"] = false,
		},
		["Drink while running - reminder"] = {
			["iconSource"] = -1,
			["parent"] = "Drink while running",
			["preferToUpdate"] = false,
			["yOffset"] = 239,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Health",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["events"] = "UNIT_POWER_UPDATE:player COMBAT_LOG_EVENT_UNFILTERED PLAYER_ENTERING_WORLD PLAYER_REGEN_DISABLED PLAYER_REGEN_ENABLED",
						["spellIds"] = {
						},
						["custom_type"] = "event",
						["names"] = {
						},
						["subeventPrefix"] = "SPELL",
						["custom"] = "function(e, ...)\n    -- WA triggers all events when it's opened.\n    -- That's usually ok, but not when we are tracking mana regen ticks.\n    if WeakAuras.IsOptionsOpen() then return end\n    \n    \n    local time = GetTime()\n    \n    \n    \n    if e == \"PLAYER_REGEN_DISABLED\" then\n        aura_env.inCombat = true\n        \n    elseif e == \"PLAYER_REGEN_ENABLED\" then\n        aura_env.inCombat = false\n        aura_env.timeLeftCombat = time\n        \n    elseif e == \"PLAYER_ENTERING_WORLD\" then\n        aura_env.tickExpirationTime = time + 2\n        wa_DrinkWhileRunning.tickExpirationTime = aura_env.tickExpirationTime\n        aura_env.inCombat = UnitAffectingCombat(\"player\")\n        \n    elseif e == \"UNIT_POWER_UPDATE\" then\n        if (aura_env.prevPower < UnitPower(\"player\")) then\n            \n            if aura_env.ignorePowerChange then\n                aura_env.ignorePowerChange = false\n            else\n                aura_env.tickExpirationTime = time + 2\n                wa_DrinkWhileRunning.tickExpirationTime = aura_env.tickExpirationTime\n            end\n        end\n        aura_env.prevPower = UnitPower(\"player\")\n        \n    elseif e == \"COMBAT_LOG_EVENT_UNFILTERED\" then\n        local clEvent = select(2, ...)\n        \n        local unitID = select(8, ...)\n        if aura_env.ignoreEvents[clEvent] and unitID == UnitGUID(\"player\") then\n            aura_env.ignorePowerChange = true\n        end\n    end\n    \n    \n    \nend",
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["customDuration"] = "function()\n    \n    \n    --if aura_env.tickExpirationTime > 0\n    --and (GetTime() - aura_env.tickExpirationTime) > aura_env.createNewTickWhenLateBy\n    --then\n    --    aura_env.tickExpirationTime = aura_env.tickExpirationTime + 2\n    --end\n    \n    \n    return 2, aura_env.tickExpirationTime\n    \n    \nend",
						["type"] = "custom",
						["custom"] = "function()\n    local time = GetTime()\n    \n    \n    if (time - aura_env.tickExpirationTime) >= 0 then\n        local modTwo = (time - aura_env.tickExpirationTime) % 2\n        \n        aura_env.tickExpirationTime = time - modTwo + 2\n        wa_DrinkWhileRunning.tickExpirationTime = aura_env.tickExpirationTime\n    end\n    \n    \n    if aura_env.inCombat == true\n    or UnitPower(\"player\",0) >= UnitPowerMax(\"player\",0)\n    or (not aura_env.config.whileCastingChanneling and CastingInfo())   -- can only show for player in Classic\n    or (not aura_env.config.whileCastingChanneling and ChannelInfo())   -- can only show for player in Classic\n    or IsMounted()\n    then\n        return false\n    end\n    \n    \n    \n    if WA_GetUnitAura(\"player\", \"Drink\") then\n        aura_env.timeStoppedDrinking = time\n        return false\n    end\n    \n    \n    \n    if aura_env.config.afterCombat.show\n    and GetTime() - aura_env.timeLeftCombat < aura_env.config.afterCombat.seconds\n    then\n        return true\n    end\n    \n    \n    \n    if aura_env.config.afterDrinking.show\n    and (GetTime() - aura_env.timeStoppedDrinking) < aura_env.config.afterDrinking.seconds\n    then\n        return true\n    end\n    \n    \n    \nend\n\n\n",
						["custom_type"] = "status",
						["check"] = "update",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				{
					["trigger"] = {
						["type"] = "custom",
						["custom"] = "function()\n    \n    \n    if aura_env.config.afterCombat.force_show\n    and GetTime() - aura_env.timeLeftCombat < aura_env.config.afterCombat.force_seconds\n    and UnitPower(\"player\",0) < UnitPowerMax(\"player\",0)\n    and not aura_env.inCombat\n    then\n        return true\n    end\n    \n    \n    \nend\n\n\n",
						["custom_type"] = "status",
						["check"] = "update",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
					},
				}, -- [3]
				["disjunctive"] = "custom",
				["customTriggerLogic"] = "function(trigger)\n    return trigger[2] or trigger[3]\nend",
				["activeTriggerMode"] = 2,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_shadowXOffset"] = 0,
					["text_text"] = " ",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_visible"] = true,
				}, -- [2]
			},
			["height"] = 250,
			["load"] = {
				["use_class"] = false,
				["use_never"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
						["HUNTER"] = true,
						["WARLOCK"] = true,
						["SHAMAN"] = true,
						["MAGE"] = true,
						["DRUID"] = true,
						["PALADIN"] = true,
						["PRIEST"] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["source"] = "import",
			["zoom"] = 0,
			["config"] = {
				["whileCastingChanneling"] = true,
				["afterDrinking"] = {
					["show"] = true,
					["seconds"] = 6,
				},
				["afterCombat"] = {
					["show"] = false,
					["force_seconds"] = 0.5,
					["force_show"] = false,
					["seconds"] = 5,
				},
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["regionType"] = "icon",
			["cooldown"] = false,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 2,
						["op"] = ">",
						["value"] = "0.6",
						["variable"] = "expirationTime",
					},
					["changes"] = {
						{
							["property"] = "alpha",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 2,
						["op"] = "<=",
						["value"] = "0.6",
						["variable"] = "expirationTime",
					},
					["changes"] = {
						{
							["value"] = 0.5,
							["property"] = "alpha",
						}, -- [1]
					},
				}, -- [2]
				{
					["check"] = {
						["trigger"] = 2,
						["op"] = "<",
						["value"] = "0.1",
						["variable"] = "expirationTime",
					},
					["changes"] = {
						{
							["property"] = "alpha",
						}, -- [1]
					},
				}, -- [3]
				{
					["check"] = {
						["trigger"] = 3,
						["variable"] = "show",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = 0.5,
							["property"] = "alpha",
						}, -- [1]
					},
				}, -- [4]
			},
			["xOffset"] = 0,
			["url"] = "https://wago.io/g_yvuk2RN/1",
			["width"] = 250,
			["alpha"] = 1,
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["tocversion"] = 11306,
			["id"] = "Drink while running - reminder",
			["frameStrata"] = 1,
			["useCooldownModRate"] = true,
			["anchorFrameType"] = "SCREEN",
			["semver"] = "1.0.0",
			["uid"] = "2iCghYvwgWz",
			["inverse"] = false,
			["authorOptions"] = {
				{
					["subOptions"] = {
						{
							["type"] = "toggle",
							["default"] = true,
							["key"] = "show",
							["name"] = "Show after drinking",
							["useDesc"] = false,
							["width"] = 1,
						}, -- [1]
						{
							["type"] = "range",
							["useDesc"] = false,
							["max"] = 10,
							["step"] = 1,
							["width"] = 1,
							["min"] = 1,
							["key"] = "seconds",
							["default"] = 5,
							["name"] = "for seconds",
						}, -- [2]
					},
					["hideReorder"] = true,
					["useDesc"] = false,
					["nameSource"] = 0,
					["width"] = 1,
					["useCollapse"] = false,
					["name"] = "After Drinking",
					["collapse"] = false,
					["type"] = "group",
					["limitType"] = "none",
					["groupType"] = "simple",
					["key"] = "afterDrinking",
					["size"] = 10,
				}, -- [1]
				{
					["subOptions"] = {
						{
							["type"] = "toggle",
							["default"] = false,
							["key"] = "show",
							["name"] = "Show after combat",
							["useDesc"] = false,
							["width"] = 1,
						}, -- [1]
						{
							["type"] = "range",
							["useDesc"] = false,
							["max"] = 10,
							["step"] = 1,
							["width"] = 1,
							["min"] = 1,
							["key"] = "seconds",
							["default"] = 5,
							["name"] = "for seconds",
						}, -- [2]
						{
							["type"] = "toggle",
							["default"] = true,
							["key"] = "force_show",
							["name"] = "Force 1 tick after combat",
							["useDesc"] = false,
							["width"] = 1,
						}, -- [3]
						{
							["type"] = "range",
							["useDesc"] = false,
							["max"] = 2,
							["step"] = 0.25,
							["width"] = 1,
							["min"] = 0.25,
							["key"] = "force_seconds",
							["default"] = 0.5,
							["name"] = "for seconds",
						}, -- [4]
					},
					["hideReorder"] = true,
					["useDesc"] = false,
					["nameSource"] = 0,
					["width"] = 1,
					["useCollapse"] = false,
					["name"] = "After Combat",
					["collapse"] = false,
					["type"] = "group",
					["limitType"] = "none",
					["groupType"] = "simple",
					["key"] = "afterCombat",
					["size"] = 10,
				}, -- [2]
				{
					["type"] = "toggle",
					["default"] = true,
					["key"] = "whileCastingChanneling",
					["name"] = "Show reminders while casting/channeling",
					["useDesc"] = false,
					["width"] = 2,
				}, -- [3]
			},
			["displayIcon"] = 132805,
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
					["custom"] = "aura_env.tickExpirationTime = 0\naura_env.timeLeftCombat = 0\naura_env.timeStoppedDrinking = 0\n\naura_env.createNewTickWhenLateBy = 0.7\naura_env.ignoreNewTicksEarlierThan = 0.5\n\nwa_DrinkWhileRunning = {\n    tickExpirationTime = 0,\n    id = aura_env.id\n}\n\n\n\naura_env.ignorePowerChange = false\naura_env.prevPower = UnitPower(\"player\")\naura_env.ignoreEvents = {\n    [\"SPELL_ENERGIZE\"] = true,\n    [\"SPELL_DRAIN\"] = true,\n    [\"SPELL_LEECH\"] = true,\n    [\"SPELL_PERIODIC_ENERGIZE\"] = true,\n    [\"SPELL_PERIODIC_DRAIN\"] = true,\n    [\"SPELL_PERIODIC_LEECH\"] = true\n}\n\n\n\n\n",
					["do_custom"] = true,
				},
			},
		},
		["PW: Shield (P2)"] = {
			["user_y"] = 0,
			["user_x"] = 0,
			["authorOptions"] = {
			},
			["yOffset"] = 0.57,
			["foregroundColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["desaturateBackground"] = false,
			["sameTexture"] = true,
			["backgroundColor"] = {
				0.5, -- [1]
				0.5, -- [2]
				0.5, -- [3]
				0.5, -- [4]
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "aura2",
						["auranames"] = {
							"6788", -- [1]
						},
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["spellIds"] = {
						},
						["specificUnit"] = "party2",
						["useName"] = true,
						["names"] = {
						},
						["unit"] = "member",
						["debuffType"] = "HARMFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["endAngle"] = 360,
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["alpha"] = 1,
			["desc"] = "Shield CD on Party2 indicator...",
			["rotation"] = 0,
			["font"] = "Friz Quadrata TT",
			["slanted"] = false,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 43,
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["load"] = {
				["use_class"] = true,
				["use_never"] = true,
				["talent"] = {
					["multi"] = {
						[103] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "PRIEST",
					["multi"] = {
					},
				},
				["use_talent"] = false,
			},
			["crop_x"] = 0.41,
			["useAdjustededMax"] = false,
			["textureWrapMode"] = "CLAMPTOBLACKADDITIVE",
			["xOffset"] = -39,
			["startAngle"] = 0,
			["desaturateForeground"] = false,
			["useAdjustededMin"] = false,
			["mirror"] = false,
			["anchorFrameFrame"] = "PartyMemberFrame2",
			["regionType"] = "progresstexture",
			["config"] = {
			},
			["blendMode"] = "BLEND",
			["smoothProgress"] = false,
			["anchorFrameType"] = "SELECTFRAME",
			["slantMode"] = "INSIDE",
			["crop_y"] = 0.41,
			["fontSize"] = 12,
			["anchorPoint"] = "CENTER",
			["selfPoint"] = "CENTER",
			["compress"] = false,
			["id"] = "PW: Shield (P2)",
			["foregroundTexture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\UI-PartyFlash-Highlight_Shield",
			["frameStrata"] = 1,
			["width"] = 43,
			["uid"] = "zDMEhE)lXyO",
			["auraRotation"] = 0,
			["inverse"] = false,
			["backgroundTexture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura3",
			["orientation"] = "ANTICLOCKWISE",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["backgroundOffset"] = 2,
		},
		["Sell Grey"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "PQe9_D2o2",
			["parent"] = "Auto Sell Grey / Repair",
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["url"] = "https://wago.io/PQe9_D2o2/1",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Health",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["events"] = "MERCHANT_SHOW",
						["custom"] = "function(event, ...)\n    if event == \"MERCHANT_SHOW\" then\n        for i = 0, 5 do\n            -- Stop the loop if no bag\n            if(C_Container.GetContainerNumSlots(i) == nil) then\n                break\n            end\n            for j = 1, C_Container.GetContainerNumSlots(i) do\n                local info = C_Container.GetContainerItemInfo(i, j)\n                if(info ~= nil and info.quality == 0) then\n                    C_Container.UseContainerItem(i,j)\n                end\n            end\n        end\n    end\nend",
						["custom_type"] = "event",
						["names"] = {
						},
						["subeventPrefix"] = "SPELL",
						["spellIds"] = {
						},
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["party"] = true,
						["flexible"] = true,
						["twenty"] = true,
						["ten"] = true,
						["twentyfive"] = true,
						["fortyman"] = true,
						["none"] = true,
					},
				},
			},
			["fontSize"] = 12,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["wordWrap"] = "WordWrap",
			["regionType"] = "text",
			["selfPoint"] = "BOTTOM",
			["preferToUpdate"] = false,
			["conditions"] = {
			},
			["displayText_format_p_time_precision"] = 1,
			["displayText"] = "",
			["xOffset"] = 0,
			["config"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 30402,
			["id"] = "Sell Grey",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["semver"] = "1.0.0",
			["uid"] = "xVDDwVIhtTI",
			["shadowYOffset"] = -1,
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
				["forceEvents"] = true,
			},
			["automaticWidth"] = "Auto",
		},
		["VEINS CD Visual"] = {
			["iconSource"] = -1,
			["wagoID"] = "EJSv8n-lB",
			["xOffset"] = -568.8888778686523,
			["preferToUpdate"] = false,
			["yOffset"] = -337.0667037963867,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
					["do_custom"] = false,
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["rem"] = "6000",
						["useStacks"] = false,
						["auranames"] = {
							"Inner Fire", -- [1]
						},
						["subeventPrefix"] = "SPELL",
						["matchesShowOn"] = "showOnMissing",
						["genericShowOn"] = "showOnReady",
						["names"] = {
						},
						["use_showgcd"] = false,
						["stacks"] = "5",
						["unit"] = "player",
						["use_showlossofcontrol"] = false,
						["match_count"] = "1",
						["auraspellids"] = {
							"11025", -- [1]
							"10952", -- [2]
							"7128", -- [3]
							"1254", -- [4]
							"1006", -- [5]
							"588", -- [6]
							"11026", -- [7]
							"10951", -- [8]
							"624", -- [9]
							"7130", -- [10]
							"1252", -- [11]
							"7129", -- [12]
							"602", -- [13]
							"609", -- [14]
							"1253", -- [15]
							"1007", -- [16]
						},
						["use_remaining"] = false,
						["debuffType"] = "HELPFUL",
						["subeventSuffix"] = "_CAST_START",
						["useName"] = true,
						["stacksOperator"] = "<=",
						["match_countOperator"] = "<",
						["use_spellCount"] = false,
						["spellName"] = 425121,
						["event"] = "Cooldown Progress (Spell)",
						["type"] = "spell",
						["realSpellName"] = "Icy Veins",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["useExactSpellId"] = false,
						["remOperator"] = "<=",
						["use_genericShowOn"] = true,
						["use_track"] = true,
						["useRem"] = true,
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["preset"] = "fade",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desc"] = "Inner Fire at the right side of the screen to rebuff it!",
			["version"] = 6,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["border_offset"] = 1,
					["border_size"] = 14,
					["border_color"] = {
						0.9921568627450981, -- [1]
						1, -- [2]
						0.9686274509803922, -- [3]
						1, -- [4]
					},
					["border_visible"] = false,
					["border_edge"] = "None",
					["type"] = "subborder",
				}, -- [2]
			},
			["height"] = 48,
			["load"] = {
				["ingroup"] = {
				},
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "MAGE",
					["multi"] = {
						["MAGE"] = true,
						["PRIEST"] = true,
					},
				},
				["use_class"] = true,
				["use_spellknown"] = false,
				["zoneIds"] = "",
				["level_operator"] = {
					">=", -- [1]
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["level"] = {
					"3", -- [1]
				},
				["use_level"] = false,
				["size"] = {
					["single"] = "pvp",
					["multi"] = {
						["scenario"] = true,
						["ten"] = true,
						["twentyfive"] = true,
						["fortyman"] = true,
						["ratedpvp"] = true,
						["party"] = true,
						["ratedarena"] = true,
						["flexible"] = true,
						["arena"] = true,
						["twenty"] = true,
						["pvp"] = true,
					},
				},
			},
			["anchorFrameType"] = "SCREEN",
			["source"] = "import",
			["zoom"] = 0,
			["selfPoint"] = "CENTER",
			["icon"] = true,
			["cooldown"] = true,
			["anchorFrameFrame"] = "PlayerFrame",
			["regionType"] = "icon",
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "show",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "insufficientResources",
						["value"] = 1,
					},
					["changes"] = {
						{
							["property"] = "alpha",
						}, -- [1]
					},
				}, -- [2]
			},
			["url"] = "",
			["authorOptions"] = {
			},
			["config"] = {
			},
			["frameStrata"] = 1,
			["auto"] = true,
			["cooldownTextDisabled"] = false,
			["semver"] = "1.0.5",
			["tocversion"] = 20502,
			["id"] = "VEINS CD Visual",
			["useCooldownModRate"] = true,
			["alpha"] = 1,
			["width"] = 48,
			["desaturate"] = false,
			["uid"] = "6vnX6bzrDkY",
			["inverse"] = false,
			["color"] = {
				0.984313725490196, -- [1]
				0.9725490196078431, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["displayIcon"] = 135932,
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["useTooltip"] = false,
		},
		["Auto Sell Grey / Repair"] = {
			["controlledChildren"] = {
				"Auto Repair", -- [1]
				"Sell Grey", -- [2]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["wagoID"] = "PQe9_D2o2",
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["url"] = "https://wago.io/PQe9_D2o2/1",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["unit"] = "player",
						["type"] = "aura2",
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["names"] = {
						},
						["event"] = "Health",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["version"] = 1,
			["subRegions"] = {
			},
			["load"] = {
				["size"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["multi"] = {
					},
				},
			},
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["source"] = "import",
			["scale"] = 1,
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["regionType"] = "group",
			["borderSize"] = 2,
			["borderOffset"] = 4,
			["semver"] = "1.0.0",
			["tocversion"] = 30402,
			["id"] = "Auto Sell Grey / Repair",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["config"] = {
			},
			["borderInset"] = 1,
			["selfPoint"] = "CENTER",
			["authorOptions"] = {
			},
			["conditions"] = {
			},
			["information"] = {
			},
			["uid"] = "PScy(MT9aGi",
		},
		["Auto Repair"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "PQe9_D2o2",
			["parent"] = "Auto Sell Grey / Repair",
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["url"] = "https://wago.io/PQe9_D2o2/1",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["custom_type"] = "event",
						["debuffType"] = "HELPFUL",
						["duration"] = "1",
						["event"] = "Health",
						["unit"] = "player",
						["names"] = {
						},
						["dynamicDuration"] = true,
						["custom"] = "function(event, ...)\n    if event == \"MERCHANT_SHOW\" then\n        if (CanMerchantRepair()) then    \n            repairAllCost, canRepair = GetRepairAllCost();\n            -- If merchant can repair and there is something to repair\n            if (canRepair and repairAllCost > 0) then\n                costTextureString = GetCoinTextureString(repairAllCost);\n                -- Use Guild Bank\n                guildRepairedItems = false\n                if (IsInGuild() and CanGuildBankRepair()) then\n                    -- Checks if guild has enough money\n                    local amount = GetGuildBankWithdrawMoney()\n                    local guildBankMoney = GetGuildBankMoney()\n                    amount = amount == -1 and guildBankMoney or min(amount, guildBankMoney)\n                    \n                    if (amount >= repairAllCost) then\n                        RepairAllItems(true);\n                        guildRepairedItems = true\n                        DEFAULT_CHAT_FRAME:AddMessage(\"Equipment has been repaired by your Guild for \"..costTextureString, 255, 255, 255)\n                    end\n                end\n                \n                -- Use own funds\n                if (repairAllCost <= GetMoney() and not guildRepairedItems) then\n                    RepairAllItems(false);\n                    DEFAULT_CHAT_FRAME:AddMessage(\"Equipment has been repaired for \"..costTextureString, 255, 255, 255)\n                end\n            end\n        end\n    end\nend",
						["events"] = "MERCHANT_SHOW",
						["spellIds"] = {
						},
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["party"] = true,
						["flexible"] = true,
						["twenty"] = true,
						["ten"] = true,
						["twentyfive"] = true,
						["fortyman"] = true,
						["none"] = true,
					},
				},
			},
			["fontSize"] = 12,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["wordWrap"] = "WordWrap",
			["regionType"] = "text",
			["selfPoint"] = "BOTTOM",
			["preferToUpdate"] = false,
			["conditions"] = {
			},
			["displayText_format_p_time_precision"] = 1,
			["displayText"] = "",
			["xOffset"] = 0,
			["config"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 30402,
			["id"] = "Auto Repair",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["semver"] = "1.0.0",
			["uid"] = "wWxzU1KWdFX",
			["shadowYOffset"] = -1,
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
				["forceEvents"] = true,
			},
			["automaticWidth"] = "Auto",
		},
		["Inner Fire REBUFF!"] = {
			["iconSource"] = -1,
			["wagoID"] = "EJSv8n-lB",
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["rem"] = "6000",
						["useStacks"] = false,
						["auranames"] = {
							"Inner Fire", -- [1]
						},
						["matchesShowOn"] = "showOnMissing",
						["unit"] = "player",
						["stacks"] = "5",
						["match_count"] = "1",
						["debuffType"] = "HELPFUL",
						["useName"] = true,
						["stacksOperator"] = "<=",
						["useExactSpellId"] = false,
						["event"] = "Health",
						["subeventSuffix"] = "_CAST_START",
						["type"] = "aura2",
						["match_countOperator"] = "<",
						["spellIds"] = {
						},
						["names"] = {
						},
						["remOperator"] = "<=",
						["auraspellids"] = {
							"11025", -- [1]
							"10952", -- [2]
							"7128", -- [3]
							"1254", -- [4]
							"1006", -- [5]
							"588", -- [6]
							"11026", -- [7]
							"10951", -- [8]
							"624", -- [9]
							"7130", -- [10]
							"1252", -- [11]
							"7129", -- [12]
							"602", -- [13]
							"609", -- [14]
							"1253", -- [15]
							"1007", -- [16]
						},
						["subeventPrefix"] = "SPELL",
						["useRem"] = true,
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeType"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["preset"] = "slidetop",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 6,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["border_size"] = 14,
					["type"] = "subborder",
					["border_color"] = {
						0.9921568627450981, -- [1]
						1, -- [2]
						0.9686274509803922, -- [3]
						1, -- [4]
					},
					["border_visible"] = true,
					["border_edge"] = "None",
					["border_offset"] = 1,
				}, -- [2]
				{
					["glowFrequency"] = 0.25,
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						0, -- [2]
						0.07450980392156863, -- [3]
						1, -- [4]
					},
					["glowDuration"] = 1,
					["useGlowColor"] = false,
					["glowScale"] = 1,
					["glowThickness"] = 1,
					["glow"] = true,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 48,
			["load"] = {
				["ingroup"] = {
				},
				["use_level"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["level_operator"] = {
					">=", -- [1]
				},
				["use_class"] = true,
				["zoneIds"] = "",
				["class"] = {
					["single"] = "PRIEST",
					["multi"] = {
						["MAGE"] = true,
						["PRIEST"] = true,
					},
				},
				["level"] = {
					"3", -- [1]
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["use_alive"] = true,
				["use_never"] = true,
				["size"] = {
					["single"] = "pvp",
					["multi"] = {
						["scenario"] = true,
						["ten"] = true,
						["twentyfive"] = true,
						["fortyman"] = true,
						["ratedpvp"] = true,
						["party"] = true,
						["ratedarena"] = true,
						["flexible"] = true,
						["arena"] = true,
						["twenty"] = true,
						["pvp"] = true,
					},
				},
			},
			["anchorFrameType"] = "SCREEN",
			["source"] = "import",
			["desc"] = "Inner Fire at the right side of the screen to rebuff it!",
			["icon"] = true,
			["url"] = "",
			["cooldown"] = false,
			["anchorFrameFrame"] = "PlayerFrame",
			["regionType"] = "icon",
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "show",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "sub.3.glow",
						}, -- [1]
					},
				}, -- [1]
			},
			["selfPoint"] = "CENTER",
			["useTooltip"] = false,
			["config"] = {
			},
			["alpha"] = 1,
			["frameStrata"] = 1,
			["zoom"] = 0,
			["semver"] = "1.0.5",
			["tocversion"] = 20502,
			["id"] = "Inner Fire REBUFF!",
			["auto"] = true,
			["useCooldownModRate"] = true,
			["width"] = 48,
			["cooldownTextDisabled"] = false,
			["uid"] = ")GOgtvSY(WA",
			["inverse"] = false,
			["xOffset"] = 430,
			["displayIcon"] = 135932,
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["color"] = {
				0.984313725490196, -- [1]
				0.9725490196078431, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Renew (P2)"] = {
			["user_y"] = 0,
			["user_x"] = 0,
			["authorOptions"] = {
			},
			["yOffset"] = 0.57,
			["anchorPoint"] = "CENTER",
			["desaturateBackground"] = false,
			["sameTexture"] = true,
			["backgroundColor"] = {
				0.501960813999176, -- [1]
				0.501960813999176, -- [2]
				0.501960813999176, -- [3]
				0, -- [4]
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "aura2",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["auranames"] = {
							"48068", -- [1]
						},
						["spellIds"] = {
						},
						["specificUnit"] = "party2",
						["unit"] = "member",
						["names"] = {
						},
						["useName"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["endAngle"] = 360,
			["internalVersion"] = 70,
			["selfPoint"] = "CENTER",
			["frameStrata"] = 1,
			["desc"] = "Renew duration indicator for party2 frame...",
			["rotation"] = 0,
			["font"] = "Friz Quadrata TT",
			["backgroundOffset"] = 2,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 39,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["load"] = {
				["use_class"] = true,
				["use_never"] = true,
				["talent"] = {
					["multi"] = {
						[103] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "PRIEST",
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["use_talent"] = false,
			},
			["conditions"] = {
			},
			["useAdjustededMax"] = false,
			["fontSize"] = 12,
			["foregroundColor"] = {
				0, -- [1]
				1, -- [2]
				0.1372549086809158, -- [3]
				1, -- [4]
			},
			["startAngle"] = 0,
			["xOffset"] = -39,
			["auraRotation"] = 0,
			["mirror"] = false,
			["useAdjustededMin"] = false,
			["regionType"] = "progresstexture",
			["config"] = {
			},
			["blendMode"] = "BLEND",
			["backgroundTexture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura3",
			["width"] = 39,
			["slantMode"] = "INSIDE",
			["smoothProgress"] = false,
			["anchorFrameFrame"] = "PartyMemberFrame2",
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["crop_y"] = 0.41,
			["compress"] = false,
			["id"] = "Renew (P2)",
			["textureWrapMode"] = "CLAMPTOBLACKADDITIVE",
			["alpha"] = 1,
			["anchorFrameType"] = "SELECTFRAME",
			["foregroundTexture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\UI-PartyFlash-Highlight_Renew",
			["uid"] = "Uko)K87(0(R",
			["inverse"] = false,
			["desaturateForeground"] = false,
			["orientation"] = "ANTICLOCKWISE",
			["crop_x"] = 0.41,
			["information"] = {
				["forceEvents"] = true,
			},
			["slanted"] = false,
		},
		["BLINK VISUAL"] = {
			["iconSource"] = -1,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = -361.9550170898438,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["type"] = "spell",
						["spellName"] = 1953,
						["subeventSuffix"] = "_CAST_START",
						["genericShowOn"] = "showOnCooldown",
						["use_genericShowOn"] = true,
						["event"] = "Cooldown Progress (Spell)",
						["subeventPrefix"] = "SPELL",
						["realSpellName"] = "Blink",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["unit"] = "player",
						["use_remaining"] = false,
						["names"] = {
						},
						["use_track"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_shadowXOffset"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_fontType"] = "OUTLINE",
				}, -- [2]
				{
					["glowFrequency"] = 0.25,
					["type"] = "subglow",
					["useGlowColor"] = false,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["glowDuration"] = 1,
					["glowXOffset"] = 0,
					["glow"] = false,
					["glowScale"] = 1,
					["glowThickness"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 38,
			["load"] = {
				["size"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["multi"] = {
					},
				},
			},
			["regionType"] = "icon",
			["xOffset"] = 19.91094970703125,
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["cooldown"] = true,
			["authorOptions"] = {
			},
			["zoom"] = 0,
			["cooldownTextDisabled"] = false,
			["anchorFrameType"] = "SCREEN",
			["id"] = "BLINK VISUAL",
			["config"] = {
			},
			["alpha"] = 1,
			["width"] = 38,
			["frameStrata"] = 1,
			["uid"] = "V5Yry0gMZJk",
			["inverse"] = false,
			["useCooldownModRate"] = true,
			["conditions"] = {
			},
			["information"] = {
			},
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
		},
	},
	["registered"] = {
	},
	["lastArchiveClear"] = 1659733987,
	["dbVersion"] = 70,
	["editor_font_size"] = 12,
	["editor_theme"] = "Monokai",
}
