
WeakAurasSaved = {
	["dynamicIconCache"] = {
	},
	["editor_tab_spaces"] = 4,
	["login_squelch_time"] = 10,
	["displays"] = {
		["Homonculi duration rework??"] = {
			["sparkWidth"] = 10,
			["iconSource"] = 0,
			["wagoID"] = "sz3jz7-QJ",
			["xOffset"] = 68,
			["preferToUpdate"] = false,
			["yOffset"] = -2,
			["anchorPoint"] = "CENTER",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["cooldownSwipe"] = false,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["url"] = "",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
					["custom"] = "if not aura_env.region.mask then\n  aura_env.region.mask = aura_env.region:CreateMaskTexture()\nend\naura_env.region.mask:SetTexture([[Interface\\AddOns\\WeakAuras\\Media\\Textures\\Circle_White]])\naura_env.region.mask:SetAllPoints()\naura_env.region.icon:AddMaskTexture(aura_env.region.mask)\naura_env.region.cooldown:SetSwipeTexture([[Interface\\AddOns\\WeakAuras\\Media\\Textures\\Circle_White]], 0,0,0,0.2)\naura_env.region.cooldown:SetUseCircularEdge(true)\n",
					["do_custom"] = false,
				},
				["finish"] = {
				},
			},
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
						["use_genericShowOn"] = true,
						["use_track"] = true,
						["event"] = "Combat Log",
						["use_spellName"] = false,
						["realSpellName"] = 0,
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = true,
						["spellName"] = {
							0, -- [1]
						},
						["names"] = {
						},
						["sourceUnit"] = "player",
						["unit"] = "player",
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
			["sparkOffsetX"] = 0,
			["authorOptions"] = {
			},
			["barColor"] = {
				1, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["config"] = {
			},
			["cooldownEdge"] = false,
			["sparkOffsetY"] = 0,
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
					["anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						0.9333333333333333, -- [2]
						0.9372549019607843, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowXOffset"] = 0,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_LEFT",
					["text_text"] = "%p",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 20,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_text_format_p_round_type"] = "floor",
				}, -- [2]
			},
			["height"] = 30,
			["icon"] = false,
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
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "PRIEST",
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
			["selfPoint"] = "CENTER",
			["source"] = "import",
			["cooldown"] = false,
			["displayIcon"] = "136199",
			["spark"] = false,
			["version"] = 2,
			["useAdjustededMin"] = false,
			["regionType"] = "icon",
			["uid"] = "9ni(PItb)Ay",
			["frameStrata"] = 1,
			["icon_side"] = "RIGHT",
			["anchorFrameType"] = "SELECTFRAME",
			["alpha"] = 1,
			["sparkHeight"] = 30,
			["texture"] = "Blizzard",
			["anchorFrameFrame"] = "PetFrame",
			["cooldownTextDisabled"] = false,
			["semver"] = "1.0.1",
			["tocversion"] = 30400,
			["id"] = "Homonculi duration rework??",
			["sparkHidden"] = "NEVER",
			["useCooldownModRate"] = true,
			["width"] = 30,
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["inverse"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0, -- [4]
			},
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["zoom"] = 0.2,
		},
		["Drink while running - manaregen bar when reminder is active"] = {
			["sparkWidth"] = 10,
			["sparkOffsetX"] = 0,
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["yOffset"] = 100,
			["anchorPoint"] = "BOTTOM",
			["semver"] = "1.0.0",
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["url"] = "https://wago.io/g_yvuk2RN/1",
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
						["type"] = "custom",
						["custom_type"] = "status",
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["customDuration"] = "function()\n    \n    return 2, wa_DrinkWhileRunning.tickExpirationTime\n    \nend\n\n\n",
						["subeventSuffix"] = "_CAST_START",
						["spellIds"] = {
						},
						["unit"] = "player",
						["check"] = "update",
						["names"] = {
						},
						["custom"] = "function()\n    if not wa_DrinkWhileRunning then return end\n    \n    \n    local t = WeakAuras.GetActiveTriggers(wa_DrinkWhileRunning.id)\n    \n    \n    if t[2] or t[3] then\n        return true\n    end\n    \nend\n\n\n",
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
			["parent"] = "Drink while running",
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["barColor"] = {
				0.32549019607843, -- [1]
				0.84313725490196, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["icon"] = false,
			["gradientOrientation"] = "HORIZONTAL",
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["type"] = "subforeground",
				}, -- [2]
			},
			["height"] = 5,
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0, -- [4]
			},
			["load"] = {
				["use_class"] = false,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
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
				["zoneIds"] = "",
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["uid"] = "unoCHqo9QRV",
			["source"] = "import",
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["auto"] = true,
			["width"] = 250,
			["alpha"] = 1,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["authorOptions"] = {
			},
			["id"] = "Drink while running - manaregen bar when reminder is active",
			["icon_side"] = "LEFT",
			["iconSource"] = -1,
			["sparkHeight"] = 30,
			["texture"] = "Blizzard",
			["zoom"] = 0,
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["spark"] = false,
			["tocversion"] = 11306,
			["sparkHidden"] = "NEVER",
			["anchorFrameFrame"] = "WeakAuras:Drink while running - reminder",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
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
			["config"] = {
			},
			["inverse"] = false,
			["sparkOffsetY"] = 0,
			["orientation"] = "HORIZONTAL_INVERSE",
			["conditions"] = {
			},
			["barColor2"] = {
				1, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["internalVersion"] = 70,
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
				["init"] = {
				},
				["finish"] = {
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
						["debuffType"] = "HELPFUL",
						["event"] = "Health",
						["names"] = {
						},
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
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
			["version"] = 1,
			["subRegions"] = {
			},
			["load"] = {
				["use_class"] = "false",
				["talent"] = {
					["multi"] = {
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
					["multi"] = {
					},
				},
				["zoneIds"] = "",
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
			["selfPoint"] = "BOTTOMLEFT",
			["config"] = {
			},
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
				["forceEvents"] = true,
				["groupOffset"] = true,
			},
			["uid"] = "1Av8O31Zrl6",
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
				["init"] = {
				},
				["finish"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Health",
						["unit"] = "player",
						["custom_hide"] = "timed",
						["spellIds"] = {
						},
						["events"] = "MERCHANT_SHOW",
						["subeventPrefix"] = "SPELL",
						["names"] = {
						},
						["custom_type"] = "event",
						["custom"] = "function(event, ...)\n    if event == \"MERCHANT_SHOW\" then\n        for i = 0, 5 do\n            -- Stop the loop if no bag\n            if(C_Container.GetContainerNumSlots(i) == nil) then\n                break\n            end\n            for j = 1, C_Container.GetContainerNumSlots(i) do\n                local info = C_Container.GetContainerItemInfo(i, j)\n                if(info ~= nil and info.quality == 0) then\n                    C_Container.UseContainerItem(i,j)\n                end\n            end\n        end\n    end\nend",
						["debuffType"] = "HELPFUL",
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
						["fortyman"] = true,
						["ten"] = true,
						["twentyfive"] = true,
						["twenty"] = true,
						["none"] = true,
					},
				},
			},
			["fontSize"] = 12,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["wordWrap"] = "WordWrap",
			["regionType"] = "text",
			["preferToUpdate"] = false,
			["selfPoint"] = "BOTTOM",
			["fixedWidth"] = 200,
			["displayText_format_p_time_precision"] = 1,
			["authorOptions"] = {
			},
			["shadowYOffset"] = -1,
			["uid"] = "xVDDwVIhtTI",
			["justify"] = "LEFT",
			["tocversion"] = 30402,
			["id"] = "Sell Grey",
			["semver"] = "1.0.0",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["config"] = {
			},
			["xOffset"] = 0,
			["displayText"] = "",
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["automaticWidth"] = "Auto",
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
							"48068", -- [1]
						},
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["spellIds"] = {
						},
						["specificUnit"] = "party1",
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
			["desc"] = "Renew duration indicator for party1 frame...",
			["rotation"] = 0,
			["font"] = "Friz Quadrata TT",
			["backgroundOffset"] = 2,
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
			["anchorPoint"] = "CENTER",
			["startAngle"] = 0,
			["authorOptions"] = {
			},
			["uid"] = "qNFOL)6H20f",
			["mirror"] = false,
			["useAdjustededMin"] = false,
			["regionType"] = "progresstexture",
			["auraRotation"] = 0,
			["blendMode"] = "BLEND",
			["backgroundTexture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura3",
			["width"] = 39,
			["slantMode"] = "INSIDE",
			["smoothProgress"] = false,
			["anchorFrameFrame"] = "PartyMemberFrame1",
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
			["id"] = "Renew (P1)",
			["textureWrapMode"] = "CLAMPTOBLACKADDITIVE",
			["alpha"] = 1,
			["anchorFrameType"] = "SELECTFRAME",
			["foregroundTexture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\UI-PartyFlash-Highlight_Renew",
			["config"] = {
			},
			["inverse"] = false,
			["desaturateForeground"] = false,
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
						["custom_hide"] = "timed",
						["custom"] = "function(e, ...)\n    -- WA triggers all events when it's opened.\n    -- That's usually ok, but not when we are tracking mana regen ticks.\n    if WeakAuras.IsOptionsOpen() then return end\n    \n    \n    local time = GetTime()\n    \n    \n    \n    if e == \"PLAYER_REGEN_DISABLED\" then\n        aura_env.inCombat = true\n        \n    elseif e == \"PLAYER_REGEN_ENABLED\" then\n        aura_env.inCombat = false\n        aura_env.timeLeftCombat = time\n        \n    elseif e == \"PLAYER_ENTERING_WORLD\" then\n        aura_env.tickExpirationTime = time + 2\n        wa_DrinkWhileRunning.tickExpirationTime = aura_env.tickExpirationTime\n        aura_env.inCombat = UnitAffectingCombat(\"player\")\n        \n    elseif e == \"UNIT_POWER_UPDATE\" then\n        if (aura_env.prevPower < UnitPower(\"player\")) then\n            \n            if aura_env.ignorePowerChange then\n                aura_env.ignorePowerChange = false\n            else\n                aura_env.tickExpirationTime = time + 2\n                wa_DrinkWhileRunning.tickExpirationTime = aura_env.tickExpirationTime\n            end\n        end\n        aura_env.prevPower = UnitPower(\"player\")\n        \n    elseif e == \"COMBAT_LOG_EVENT_UNFILTERED\" then\n        local clEvent = select(2, ...)\n        \n        local unitID = select(8, ...)\n        if aura_env.ignoreEvents[clEvent] and unitID == UnitGUID(\"player\") then\n            aura_env.ignorePowerChange = true\n        end\n    end\n    \n    \n    \nend",
						["events"] = "UNIT_POWER_UPDATE:player COMBAT_LOG_EVENT_UNFILTERED PLAYER_ENTERING_WORLD PLAYER_REGEN_DISABLED PLAYER_REGEN_ENABLED",
						["subeventPrefix"] = "SPELL",
						["names"] = {
						},
						["custom_type"] = "event",
						["spellIds"] = {
						},
						["debuffType"] = "HELPFUL",
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
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
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
				["zoneIds"] = "",
			},
			["source"] = "import",
			["zoom"] = 0,
			["uid"] = "2iCghYvwgWz",
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
			["xOffset"] = 0,
			["regionType"] = "icon",
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["displayIcon"] = 132805,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["frameStrata"] = 1,
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["tocversion"] = 11306,
			["id"] = "Drink while running - reminder",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
					["custom"] = "aura_env.tickExpirationTime = 0\naura_env.timeLeftCombat = 0\naura_env.timeStoppedDrinking = 0\n\naura_env.createNewTickWhenLateBy = 0.7\naura_env.ignoreNewTicksEarlierThan = 0.5\n\nwa_DrinkWhileRunning = {\n    tickExpirationTime = 0,\n    id = aura_env.id\n}\n\n\n\naura_env.ignorePowerChange = false\naura_env.prevPower = UnitPower(\"player\")\naura_env.ignoreEvents = {\n    [\"SPELL_ENERGIZE\"] = true,\n    [\"SPELL_DRAIN\"] = true,\n    [\"SPELL_LEECH\"] = true,\n    [\"SPELL_PERIODIC_ENERGIZE\"] = true,\n    [\"SPELL_PERIODIC_DRAIN\"] = true,\n    [\"SPELL_PERIODIC_LEECH\"] = true\n}\n\n\n\n\n",
					["do_custom"] = true,
				},
				["finish"] = {
				},
			},
			["useCooldownModRate"] = true,
			["width"] = 250,
			["semver"] = "1.0.0",
			["config"] = {
				["whileCastingChanneling"] = true,
				["afterCombat"] = {
					["show"] = false,
					["force_seconds"] = 0.5,
					["seconds"] = 5,
					["force_show"] = false,
				},
				["afterDrinking"] = {
					["show"] = true,
					["seconds"] = 6,
				},
			},
			["inverse"] = false,
			["authorOptions"] = {
				{
					["subOptions"] = {
						{
							["type"] = "toggle",
							["default"] = true,
							["key"] = "show",
							["useDesc"] = false,
							["name"] = "Show after drinking",
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
							["name"] = "for seconds",
							["default"] = 5,
						}, -- [2]
					},
					["hideReorder"] = true,
					["useDesc"] = false,
					["nameSource"] = 0,
					["width"] = 1,
					["useCollapse"] = false,
					["collapse"] = false,
					["name"] = "After Drinking",
					["key"] = "afterDrinking",
					["limitType"] = "none",
					["groupType"] = "simple",
					["type"] = "group",
					["size"] = 10,
				}, -- [1]
				{
					["subOptions"] = {
						{
							["type"] = "toggle",
							["default"] = false,
							["key"] = "show",
							["useDesc"] = false,
							["name"] = "Show after combat",
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
							["name"] = "for seconds",
							["default"] = 5,
						}, -- [2]
						{
							["type"] = "toggle",
							["default"] = true,
							["key"] = "force_show",
							["useDesc"] = false,
							["name"] = "Force 1 tick after combat",
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
							["name"] = "for seconds",
							["default"] = 0.5,
						}, -- [4]
					},
					["hideReorder"] = true,
					["useDesc"] = false,
					["nameSource"] = 0,
					["width"] = 1,
					["useCollapse"] = false,
					["collapse"] = false,
					["name"] = "After Combat",
					["key"] = "afterCombat",
					["limitType"] = "none",
					["groupType"] = "simple",
					["type"] = "group",
					["size"] = 10,
				}, -- [2]
				{
					["type"] = "toggle",
					["default"] = true,
					["key"] = "whileCastingChanneling",
					["useDesc"] = false,
					["name"] = "Show reminders while casting/channeling",
					["width"] = 2,
				}, -- [3]
			},
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 2,
						["op"] = ">",
						["variable"] = "expirationTime",
						["value"] = "0.6",
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
						["variable"] = "expirationTime",
						["value"] = "0.6",
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
						["variable"] = "expirationTime",
						["value"] = "0.1",
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
			["cooldown"] = false,
			["url"] = "https://wago.io/g_yvuk2RN/1",
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
			["desc"] = "Renew duration indicator for party2 frame...",
			["rotation"] = 0,
			["font"] = "Friz Quadrata TT",
			["slanted"] = false,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 39,
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
			["foregroundColor"] = {
				0, -- [1]
				1, -- [2]
				0.1372549086809158, -- [3]
				1, -- [4]
			},
			["startAngle"] = 0,
			["desaturateForeground"] = false,
			["config"] = {
			},
			["mirror"] = false,
			["useAdjustededMin"] = false,
			["regionType"] = "progresstexture",
			["uid"] = "Uko)K87(0(R",
			["blendMode"] = "BLEND",
			["foregroundTexture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\UI-PartyFlash-Highlight_Renew",
			["anchorFrameType"] = "SELECTFRAME",
			["slantMode"] = "INSIDE",
			["textureWrapMode"] = "CLAMPTOBLACKADDITIVE",
			["anchorFrameFrame"] = "PartyMemberFrame2",
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
			["id"] = "Renew (P2)",
			["smoothProgress"] = false,
			["frameStrata"] = 1,
			["width"] = 39,
			["backgroundTexture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura3",
			["auraRotation"] = 0,
			["inverse"] = false,
			["xOffset"] = -39,
			["orientation"] = "ANTICLOCKWISE",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["backgroundOffset"] = 2,
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
				["init"] = {
				},
				["finish"] = {
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
						["subeventPrefix"] = "SPELL",
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
						["spellIds"] = {
						},
						["names"] = {
						},
						["remOperator"] = "<=",
						["match_countOperator"] = "<",
						["type"] = "aura2",
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
					["preset"] = "slidetop",
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
					["border_size"] = 14,
					["border_offset"] = 1,
					["border_color"] = {
						0.9921568627450981, -- [1]
						1, -- [2]
						0.9686274509803922, -- [3]
						1, -- [4]
					},
					["border_visible"] = true,
					["border_edge"] = "None",
					["type"] = "subborder",
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
				["level_operator"] = {
					">=", -- [1]
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
						["party"] = true,
						["ratedarena"] = true,
						["flexible"] = true,
						["arena"] = true,
						["twenty"] = true,
						["pvp"] = true,
					},
				},
				["use_never"] = true,
				["use_alive"] = true,
				["spec"] = {
					["multi"] = {
					},
				},
				["level"] = {
					"3", -- [1]
				},
				["class"] = {
					["single"] = "PRIEST",
					["multi"] = {
						["MAGE"] = true,
						["PRIEST"] = true,
					},
				},
				["zoneIds"] = "",
			},
			["width"] = 48,
			["source"] = "import",
			["cooldownTextDisabled"] = false,
			["selfPoint"] = "CENTER",
			["desc"] = "Inner Fire at the right side of the screen to rebuff it!",
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["anchorFrameFrame"] = "PlayerFrame",
			["regionType"] = "icon",
			["displayIcon"] = 135932,
			["color"] = {
				0.984313725490196, -- [1]
				0.9725490196078431, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["useTooltip"] = false,
			["uid"] = ")GOgtvSY(WA",
			["alpha"] = 1,
			["auto"] = true,
			["zoom"] = 0,
			["semver"] = "1.0.5",
			["tocversion"] = 20502,
			["id"] = "Inner Fire REBUFF!",
			["useCooldownModRate"] = true,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["xOffset"] = 430,
			["config"] = {
			},
			["inverse"] = false,
			["icon"] = true,
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
			["cooldown"] = false,
			["url"] = "",
		},
		["Drink while running - always active manaregen bar"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["parent"] = "Drink while running",
			["preferToUpdate"] = false,
			["yOffset"] = -594.41693783798,
			["anchorPoint"] = "BOTTOM",
			["auto"] = true,
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
						["unit"] = "player",
						["check"] = "update",
						["names"] = {
						},
						["custom"] = "function()\n    if not wa_DrinkWhileRunning then return end\n    \n    \n    \n    if UnitPower(\"player\",0) >= UnitPowerMax(\"player\",0)\n    then\n        if aura_env.config.showOnFullMana then\n            return true\n        end\n    else\n        return true\n    end\n    \nend\n\n\n",
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
			["authorOptions"] = {
				{
					["type"] = "toggle",
					["default"] = true,
					["key"] = "showOnFullMana",
					["useDesc"] = false,
					["name"] = "Show on full mana",
					["width"] = 1,
				}, -- [1]
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
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
				["init"] = {
				},
				["finish"] = {
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
			["semver"] = "1.0.0",
			["load"] = {
				["use_class"] = false,
				["use_never"] = true,
				["talent"] = {
					["multi"] = {
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
				["zoneIds"] = "",
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["xOffset"] = -363.44739596372,
			["source"] = "import",
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["uid"] = "KmEw3mSZr25",
			["width"] = 374.66561889648,
			["alpha"] = 1,
			["anchorFrameFrame"] = "WeakAuras:Drink while running - reminder",
			["regionType"] = "aurabar",
			["version"] = 1,
			["sparkHidden"] = "NEVER",
			["icon_side"] = "LEFT",
			["useAdjustededMin"] = false,
			["sparkHeight"] = 30,
			["texture"] = "Blizzard",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["zoom"] = 0,
			["spark"] = false,
			["tocversion"] = 11306,
			["id"] = "Drink while running - always active manaregen bar",
			["icon"] = false,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["height"] = 8.2321729660034,
			["config"] = {
				["showOnFullMana"] = true,
			},
			["inverse"] = false,
			["selfPoint"] = "CENTER",
			["orientation"] = "HORIZONTAL_INVERSE",
			["conditions"] = {
			},
			["barColor2"] = {
				1, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["sparkOffsetX"] = 0,
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
				["init"] = {
				},
				["finish"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["custom_type"] = "event",
						["custom_hide"] = "timed",
						["duration"] = "1",
						["event"] = "Health",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["custom"] = "function(event, ...)\n    if event == \"MERCHANT_SHOW\" then\n        if (CanMerchantRepair()) then    \n            repairAllCost, canRepair = GetRepairAllCost();\n            -- If merchant can repair and there is something to repair\n            if (canRepair and repairAllCost > 0) then\n                costTextureString = GetCoinTextureString(repairAllCost);\n                -- Use Guild Bank\n                guildRepairedItems = false\n                if (IsInGuild() and CanGuildBankRepair()) then\n                    -- Checks if guild has enough money\n                    local amount = GetGuildBankWithdrawMoney()\n                    local guildBankMoney = GetGuildBankMoney()\n                    amount = amount == -1 and guildBankMoney or min(amount, guildBankMoney)\n                    \n                    if (amount >= repairAllCost) then\n                        RepairAllItems(true);\n                        guildRepairedItems = true\n                        DEFAULT_CHAT_FRAME:AddMessage(\"Equipment has been repaired by your Guild for \"..costTextureString, 255, 255, 255)\n                    end\n                end\n                \n                -- Use own funds\n                if (repairAllCost <= GetMoney() and not guildRepairedItems) then\n                    RepairAllItems(false);\n                    DEFAULT_CHAT_FRAME:AddMessage(\"Equipment has been repaired for \"..costTextureString, 255, 255, 255)\n                end\n            end\n        end\n    end\nend",
						["spellIds"] = {
						},
						["events"] = "MERCHANT_SHOW",
						["dynamicDuration"] = true,
						["names"] = {
						},
						["debuffType"] = "HELPFUL",
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
						["fortyman"] = true,
						["ten"] = true,
						["twentyfive"] = true,
						["twenty"] = true,
						["none"] = true,
					},
				},
			},
			["fontSize"] = 12,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["wordWrap"] = "WordWrap",
			["regionType"] = "text",
			["preferToUpdate"] = false,
			["selfPoint"] = "BOTTOM",
			["fixedWidth"] = 200,
			["displayText_format_p_time_precision"] = 1,
			["authorOptions"] = {
			},
			["shadowYOffset"] = -1,
			["uid"] = "wWxzU1KWdFX",
			["justify"] = "LEFT",
			["tocversion"] = 30402,
			["id"] = "Auto Repair",
			["semver"] = "1.0.0",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["config"] = {
			},
			["xOffset"] = 0,
			["displayText"] = "",
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["automaticWidth"] = "Auto",
		},
		["Finger of Frost - Proc"] = {
			["iconSource"] = -1,
			["wagoID"] = "VA2v9nkDv",
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -36.867759125722,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["url"] = "https://wago.io/VA2v9nkDv/2",
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showOnCooldown",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["type"] = "aura2",
						["names"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["matchesShowOn"] = "showAlways",
						["ownOnly"] = true,
						["event"] = "Cooldown Progress (Spell)",
						["use_exact_spellName"] = false,
						["realSpellName"] = 0,
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["useExactSpellId"] = true,
						["subeventPrefix"] = "SPELL",
						["auraspellids"] = {
							"400670", -- [1]
						},
						["use_track"] = true,
						["spellName"] = 0,
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 2,
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
						0.25098039215686, -- [1]
						0.78039215686275, -- [2]
						0.92156862745098, -- [3]
						1, -- [4]
					},
					["text_font"] = "Expressway",
					["text_shadowYOffset"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_fontSize"] = 24,
					["anchorXOffset"] = 0,
					["text_visible"] = true,
				}, -- [2]
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
					["glow"] = false,
					["glowScale"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
				{
					["border_size"] = 1,
					["border_offset"] = 1,
					["border_color"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["border_visible"] = true,
					["border_edge"] = "Square Full White",
					["type"] = "subborder",
				}, -- [4]
				{
					["text_shadowXOffset"] = 0,
					["text_text"] = "%p",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_mod_rate"] = true,
					["anchorXOffset"] = 0,
					["type"] = "subtext",
					["text_text_format_p_time_precision"] = 1,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Expressway",
					["text_text_format_p_format"] = "timed",
					["text_anchorYOffset"] = -30,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["anchorYOffset"] = 0,
					["text_shadowYOffset"] = 0,
					["text_fontSize"] = 18,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_text_format_p_time_format"] = 0,
				}, -- [5]
			},
			["height"] = 50,
			["load"] = {
				["use_never"] = true,
				["talent"] = {
					["single"] = 22,
					["multi"] = {
						[22] = true,
						[84] = true,
					},
				},
				["class"] = {
					["single"] = "MAGE",
					["multi"] = {
						["MAGE"] = true,
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
			["xOffset"] = -158.60426968075,
			["regionType"] = "icon",
			["desc"] = "\n\n",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["information"] = {
				["forceEvents"] = true,
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
			["uid"] = "JCBIB7B4rYy",
			["frameStrata"] = 1,
			["zoom"] = 0.3,
			["semver"] = "1.0.1",
			["tocversion"] = 11500,
			["id"] = "Finger of Frost - Proc",
			["width"] = 60,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["useCooldownModRate"] = true,
			["config"] = {
			},
			["inverse"] = true,
			["cooldownEdge"] = false,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "buffed",
						["value"] = 0,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
			},
			["cooldown"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
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
			["desc"] = "Shield CD on Party2 indicator...",
			["rotation"] = 0,
			["font"] = "Friz Quadrata TT",
			["backgroundOffset"] = 2,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 43,
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
				["talent"] = {
					["multi"] = {
						[103] = true,
					},
				},
				["use_talent"] = false,
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "PRIEST",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["conditions"] = {
			},
			["useAdjustededMax"] = false,
			["textureWrapMode"] = "CLAMPTOBLACKADDITIVE",
			["xOffset"] = -39,
			["startAngle"] = 0,
			["backgroundTexture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura3",
			["anchorFrameFrame"] = "PartyMemberFrame2",
			["mirror"] = false,
			["useAdjustededMin"] = false,
			["regionType"] = "progresstexture",
			["auraRotation"] = 0,
			["blendMode"] = "BLEND",
			["uid"] = "zDMEhE)lXyO",
			["width"] = 43,
			["slantMode"] = "INSIDE",
			["foregroundTexture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\UI-PartyFlash-Highlight_Shield",
			["fontSize"] = 12,
			["anchorPoint"] = "CENTER",
			["selfPoint"] = "CENTER",
			["compress"] = false,
			["id"] = "PW: Shield (P2)",
			["crop_y"] = 0.41,
			["alpha"] = 1,
			["anchorFrameType"] = "SELECTFRAME",
			["smoothProgress"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["desaturateForeground"] = false,
			["orientation"] = "ANTICLOCKWISE",
			["crop_x"] = 0.41,
			["information"] = {
				["forceEvents"] = true,
			},
			["slanted"] = false,
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
				["init"] = {
				},
				["finish"] = {
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
			["desc"] = "Shield CD on Party1 indicator...",
			["rotation"] = 0,
			["font"] = "Friz Quadrata TT",
			["slanted"] = false,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 43,
			["textureWrapMode"] = "CLAMPTOBLACKADDITIVE",
			["load"] = {
				["use_class"] = true,
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
			["backgroundTexture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura3",
			["backgroundColor"] = {
				0.5, -- [1]
				0.5, -- [2]
				0.5, -- [3]
				0.5, -- [4]
			},
			["startAngle"] = 0,
			["xOffset"] = -39,
			["useAdjustededMin"] = false,
			["mirror"] = false,
			["anchorFrameFrame"] = "PartyMemberFrame1",
			["regionType"] = "progresstexture",
			["auraRotation"] = 0,
			["blendMode"] = "BLEND",
			["config"] = {
			},
			["anchorFrameType"] = "SELECTFRAME",
			["slantMode"] = "INSIDE",
			["smoothProgress"] = false,
			["crop_y"] = 0.41,
			["anchorPoint"] = "CENTER",
			["selfPoint"] = "CENTER",
			["compress"] = false,
			["id"] = "PW: Shield (P1)",
			["fontSize"] = 12,
			["frameStrata"] = 1,
			["width"] = 43,
			["foregroundTexture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\UI-PartyFlash-Highlight_Shield",
			["uid"] = "nD2epxy)96V",
			["inverse"] = false,
			["desaturateForeground"] = false,
			["orientation"] = "ANTICLOCKWISE",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["backgroundOffset"] = 2,
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
				["init"] = {
				},
				["finish"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["debuffType"] = "HELPFUL",
						["type"] = "aura2",
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["names"] = {
						},
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
			["version"] = 1,
			["subRegions"] = {
			},
			["load"] = {
				["talent"] = {
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
			["borderInset"] = 1,
			["uid"] = "PScy(MT9aGi",
			["authorOptions"] = {
			},
			["selfPoint"] = "CENTER",
			["conditions"] = {
			},
			["information"] = {
			},
			["config"] = {
			},
		},
	},
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
	["lastArchiveClear"] = 1659733987,
	["registered"] = {
	},
	["dbVersion"] = 70,
	["editor_font_size"] = 12,
	["editor_theme"] = "Monokai",
}
