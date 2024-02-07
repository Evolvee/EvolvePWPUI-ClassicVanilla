-----
-- Variables
    -- Limit use of globals to this single variable
    _G.Ranker = {}

    -- Upvalue variables
        local _ = nil
        local Ranker = Ranker
        local ElvUI = ElvUI
        -- Upvalue lua functions
        local floor = math.floor
        local ceil = math.ceil
        local print = print
        local strsplit = strsplit
        local format = string.format
        local gsub = string.gsub
        local tonumber = tonumber
        local tinsert = table.insert
        local twipe = table.wipe
        local pairs = pairs
        local ipairs = ipairs
        local time = time
        local getmetatable = getmetatable
        local setmetatable = setmetatable
        local GetCVarBool = GetCVarBool
        -- Upvalue game functions
        local IsAddOnLoaded = IsAddOnLoaded
        local GetAddOnMetadata = GetAddOnMetadata
        local UnitName = UnitName
        local GetNormalizedRealmName = GetNormalizedRealmName
        local UnitLevel = UnitLevel
        local GetPVPRankProgress = GetPVPRankProgress
        local GetPVPRankInfo = GetPVPRankInfo
        local UnitPVPRank = UnitPVPRank
        local GetPVPLifetimeStats = GetPVPLifetimeStats
        local GetPVPLastWeekStats = GetPVPLastWeekStats
        local RegisterAddonMessagePrefix = C_ChatInfo.RegisterAddonMessagePrefix
        local NewTicker = C_Timer.NewTicker
        local GetServerTime = GetServerTime
        local SendAddonMessage = C_ChatInfo.SendAddonMessage
        local IsInGroup = IsInGroup
        local IsInGuild = IsInGuild
        local GetPVPThisWeekStats = GetPVPThisWeekStats
        local SecondsToTime = SecondsToTime
        local GetSecondsUntilWeeklyReset = C_DateAndTime.GetSecondsUntilWeeklyReset
        local FormatLargeNumber = FormatLargeNumber
        local CreateFrame = CreateFrame
        local CloseDropDownMenus = CloseDropDownMenus
        local ToggleCharacter = ToggleCharacter
        local HasActiveSeason = C_Seasons.HasActiveSeason
        local GetActiveSeason = C_Seasons.GetActiveSeason
        local GetBuildInfo = GetBuildInfo

    -- Definition of local variables
        local addonName = "Ranker"
        local timerDuration = 60 * 10 -- Ten minutes
        local worldLoaded = false
        local addonLoaded = false
        local interfaceLoaded = false
        local interfaceShown = false
        local whatIfScenario = false
        local optionsChanged = false
        local newVersionDetected, newVersionDetectionTimer
        local weeksToObjective = -1
        local playerName, playerLevel, playerRank, playerRankProgress, playerLastWeekHonor, playerDishonorableKills
        local rankerWhatIfRank, rankerWhatIfRankProgress
        local scenarioHK, scenarioHonor, scenarioRank, scenarioProgress, scenarioObjective, scenarioLimit
        local maxRank, sumHonor, tries, maxTries = 0, 0, 0, 20
        local maxObtainableRank = 14
        local lookupData = {
            defaults = {
                showWindowByDefault = false,
                showContributionPointsVarianceBug = true,
                useCurrentHonorWhenModeling = true,
                allowDecayPreventionHop = true,
                knowsboutMinimumHK = false,
                rankerObjective = 14,
                rankerLimit = 500000,
                contributionPointsVarianceThreshold = 16,
            }, 
            rankChangeFactor = {1, 1, 1, 0.8, 0.8, 0.8, 0.7, 0.7, 0.6, 0.5, 0.5, 0.4, 0.4, 0.34, 0.34},
            contributionPointsFloor = {0, 2000, 5000, 10000, 15000, 20000, 25000, 30000, 35000, 40000, 45000, 50000, 55000, 60000},
            contributionPointsCeiling = {2000, 5000, 10000, 15000, 20000, 25000, 30000, 35000, 40000, 45000, 50000, 55000, 60000, 65000},
            honorToContributionPointsRatio = {45000/20000, 45000/20000, 45000/20000, 45000/20000, 45000/20000, 45000/20000, (175000-45000)/(40000-20000), (175000-45000)/(40000-20000), (175000-45000)/(40000-20000), (175000-45000)/(40000-20000), (500000-175000)/(60000-40000), (500000-175000)/(60000-40000), (500000-175000)/(60000-40000), (500000-175000)/(60000-40000)},
            honorIncrements = {0, 4500, 11250, 22500, 33750, 45000, 77500, 110000, 142500, 175000, 256250, 337500, 418750, 500000},
            contributionPointsVariances = {
                ["3_4"] = {min = 10, max = 10},
                ["4_3"] = {min = 10},
                ["5_2"] = {min = 10},
                ["6_1"] = {min = 10, max = 10},
                ["6_2"] = {min = 10, max = 0},
                ["6_3"] = {min = 10, max = 0},
                ["6_4"] = {min = 10, max = 0},
                ["7_1"] = {min = 10, max = 10},
                ["7_2"] = {min = 10, max = 10},
                ["7_3"] = {min = 10, max = 10},
                ["7_4"] = {min = 10, max = 0},
                ["8_3"] = {min = 10, max = 10},
                ["9_2"] = {min = 10, max = 10},
                ["10_1"] = {min = 10, max = 10},
                ["10_2"] = {min = 10, max = 0},
                ["10_3"] = {min = 10, max = 0},
                ["10_4"] = {min = 14, max = 6},
                ["11_1"] = {min = 10, max = 10},
                ["11_2"] = {min = 10, max = 10},
                ["11_3"] = {min = 4, max = 16},
                ["12_2"] = {min = 14, max = 6},
                ["13_1"] = {min = 14, max = 6},
            },
            contributionPointsVariancesException = {
                ["10_4"] = {min = 4},
                ["11_3"] = {min = 14},
            },
            contributionPointsVariancesReplace = {
                ["11_1"] = {max = 10, progressFloor = 0.49795, progressCeil = 0.498},
                ["11_2"] = {max = 10, progressFloor = 0.49795, progressCeil = 0.498},
            },
        }

    -- Libraries
        local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0")

    -- Button text (consider localization of all written words) --
        local addonToggleButtonTextHide = "Hide Ranker"
        local addonToggleButtonTextShow = "Show Ranker"
        local addonWhatIfButtonTextHide = "Return to my current rank progress"
        local addonWhatIfButtonTextShow = "Start \"what if\" scenario modeling"

    -- Debugging mode
        local debug = false

    -- Preferences
        rankerOptions = lookupData.defaults

-----
-- Addon loading
    -- When the addon gets loaded: listen to specific events and handle slash commands
        function Ranker:OnLoadHandler(frame)
            frame:RegisterEvent("ADDON_LOADED")
            frame:RegisterEvent("PLAYER_LOGIN")
            frame:RegisterEvent("PLAYER_ENTERING_WORLD")
            frame:RegisterEvent("PLAYER_PVP_RANK_CHANGED")
            frame:RegisterEvent("CHAT_MSG_ADDON")
            frame:RegisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN")
            frame:RegisterEvent("ADDON_ACTION_BLOCKED")
            frame:RegisterEvent("ADDON_ACTION_FORBIDDEN")

            -- Accept two slash commands for basic addon interaction
            SlashCmdList["RANKER_BASIC"] = function(message, editbox) Ranker:SlashHandler(message, editbox) end
            SLASH_RANKER_BASIC1, SLASH_RANKER_BASIC2 = "/ranker", "/rank"
        end

    -- When the slash commands for basic addon interaction are entered: provide basic feedback
        function Ranker:SlashHandler(message, editbox)
            if message == "config" or message == "conf" or message == "options" or message == "opt" then
                Ranker:OpenConfigurationOptions()
            elseif message == "prune" then
                Ranker:PruneOldData()
            elseif message == "test" then
                Ranker:Test()
            else
                if rankerData == nil then
                    Ranker:OutputToChat("I have no data stored.", debug)
                else
                    Ranker:OutputToChat("I have "..FormatLargeNumber(#rankerData).." data points stored.", debug)
                end
                Ranker:OutputToChat("Available commands: /ranker, /ranker config, /ranker prune", true)

                ToggleCharacter("HonorFrame", true)
                Ranker:ShowWindow()
                Ranker:ResetToCurrentSituationAndPredict()
            end
        end

    -- When the registered events are triggered: update variables and save data
        function Ranker:OnEventHandler(frame, event, arg1, ...)
            local prefix, message = ...

            -- Fired when saved variables are loaded
            if event == "ADDON_LOADED" then
                addonLoaded = IsAddOnLoaded(addonName)
                local _, gameBuild, gameBuildDate, gameTocVersion = GetBuildInfo()
                if HasActiveSeason() and GetActiveSeason() == Enum.SeasonID.Placeholder and gameTocVersion * 1 < 20000 then
                    local timestampNextPhase = time({["day"] = 6,["month"] = 2, ["year"] = 2024, ["hour"] = 0})
                    local timestampNextPhaseForAll = time({["day"] = 8,["month"] = 2, ["year"] = 2024, ["hour"] = 0})
                    local timestampsTwoDays = 2 * 24 * 60 * 60
                    local timestampNow = time()
                    if ((timestampNow >= timestampNextPhase and GetSecondsUntilWeeklyReset() > timestampsTwoDays) or timestampNow >= timestampNextPhaseForAll) then
                        if gameTocVersion * 1 >= 11500 and gameBuild * 1 >= 52610 then
                            maxObtainableRank = 5
                        end
                    else
                        if gameTocVersion * 1 == 11500 and gameBuild * 1 >= 52409 then
                            maxObtainableRank = 3
                        end
                    end
                    -- if gameTocVersion * 1 >= 11500 and gameBuild * 1 > ??? then
                        -- maxObtainableRank = 9
                    -- end
                    -- if gameTocVersion * 1 >= 11500 and gameBuild * 1 > ??? then
                        -- maxObtainableRank = 10
                    -- end
                    -- if gameTocVersion * 1 >= 11500 and gameBuild * 1 > ??? then
                        -- maxObtainableRank = 11
                    -- end
                    -- if gameTocVersion * 1 >= 11500 and gameBuild * 1 > ??? then
                        -- maxObtainableRank = 12
                    -- end
                    -- if gameTocVersion * 1 >= 11500 and gameBuild * 1 > ??? then
                        -- maxObtainableRank = 13
                    -- end
                    -- if gameTocVersion * 1 >= 11500 and gameBuild * 1 > ??? then
                    --     maxObtainableRank = 14
                    -- end
                    lookupData.defaults.rankerObjective = maxObtainableRank
                    if rankerObjective == nil then
                        rankerObjective = lookupData.defaults.rankerObjective
                    end
                    if rankerObjective > maxObtainableRank then 
                        rankerObjective = lookupData.defaults.rankerObjective 
                    end
                end
            -- Fires during the loading screen when logging in or reloading, before the first PLAYER_ENTERING_WORLD
            elseif event == "PLAYER_LOGIN" then
                -- Use defaults for the configuration options
                if rankerOptions.showWindowByDefault == nil then
                    rankerOptions.showWindowByDefault = lookupData.defaults.showWindowByDefault
                end
                if rankerOptions.showContributionPointsVarianceBug == nil then
                    rankerOptions.showContributionPointsVarianceBug = lookupData.defaults.showContributionPointsVarianceBug
                end
                if rankerOptions.useCurrentHonorWhenModeling == nil then
                    rankerOptions.useCurrentHonorWhenModeling = lookupData.defaults.useCurrentHonorWhenModeling
                end
                if rankerOptions.knowsboutMinimumHK == nil then
                    rankerOptions.knowsboutMinimumHK = lookupData.defaults.knowsboutMinimumHK
                end
                if rankerObjective == nil then
                    rankerObjective = lookupData.defaults.rankerObjective
                end
                if rankerLimit == nil then
                    rankerLimit = lookupData.defaults.rankerLimit
                end
            -- Fired after PLAYER_LOGIN, when the player enters/leaves an instance, and whenever the player sees a loading screen
            elseif event == "PLAYER_ENTERING_WORLD" then
                if not interfaceLoaded and not worldLoaded then
                    worldLoaded = true
                    Ranker:AddOnLoaded()
                end
                Ranker:DataUpdate(event)
            -- Listen for other triggers to updata our data
            elseif event == "PLAYER_PVP_RANK_CHANGED" or (event == "CHAT_MSG_ADDON" and prefix == addonName) then
                Ranker:DataUpdate(event, arg1, ...)
            -- Listen for trigger to update our frame
            elseif event == "CHAT_MSG_COMBAT_HONOR_GAIN" then
                Ranker:Predict()
            end
        end

    -- When the addon and saved variables are loaded: initiate our data variable
        function Ranker:AddOnLoaded()
            if worldLoaded then
                if rankerData == nil then
                    rankerData = {}
                end

                -- Savedvariable with the addon version
                rankerVersion = GetAddOnMetadata("Ranker", "Version")

                -- Locals for data that remains static for the session
                playerName = UnitName("player").."-"..GetNormalizedRealmName()
                playerLevel = UnitLevel("player")
                playerRankProgress = floor(GetPVPRankProgress() * 10000000000) / 10000000000
                _, playerRank = GetPVPRankInfo(UnitPVPRank("player"))
                _, playerDishonorableKills = GetPVPLifetimeStats()
                _, _,playerLastWeekHonor = GetPVPLastWeekStats()
                rankerWhatIfRank = playerRank
                rankerWhatIfRankProgress = playerRankProgress

                -- Register an addon message prefix to receive addon messages with that prefix
                local registerPrefixSuccess = RegisterAddonMessagePrefix(addonName)
                if not registerPrefixSuccess then return end

                -- Start timer to share data pariodically
                local myTimer = NewTicker(timerDuration, Ranker.DataTimer)

                -- Build the configuration options
                Ranker:CreateConfigurationOptions()

                -- Create the user interface
                Ranker:CreateUserInterface()

                -- We're ready
                Ranker:OutputToChat("AddOn version "..rankerVersion.." loaded.", true)
            end
        end

-----
-- User interface
    -- Create a frame next to the honor frame that can be shown or hidden by the click of a button
        function Ranker:CreateUserInterface()
            if interfaceLoaded == true then return end

            -- Default colors
            local headerFont = "GameFontNormal"
            local normalFont = "GameFontHighlight"

            -- The Ranker frame is attached to the honor frame and has content that may require the user to scroll
            local mainFrame = CreateFrame("Frame", "RankerMainFrame", HonorFrame, "BasicFrameTemplateWithInset")
            mainFrame:SetSize(HonorFrameProgressButton:GetWidth() + 150, HonorFrame:GetHeight() - 89)
            mainFrame:SetPoint("LEFT", HonorFrame, "RIGHT", -30, 30.5)
            if ElvUI then
                mainFrame:StripTextures()
                mainFrame:SetPoint("LEFT", HonorFrame, "RIGHT", -30, 32.5)
                mainFrame:SetHeight(HonorFrame:GetHeight() - 88.5)
                mainFrame:CreateBackdrop()
                mainFrame.backdrop:SetBackdropColor(0, 0, 0, 0.1)
                mainFrame:SetTemplate('Transparent')
            end
            mainFrame.Title = mainFrame:CreateFontString(nil, "OVERLAY")
            mainFrame.Title:SetFontObject("GameFontHighlight")
            mainFrame.Title:SetPoint("CENTER", mainFrame.TitleBg, "CENTER", 11, 0)
            mainFrame.Title:SetText(addonName.." v"..rankerVersion)
            mainFrame.ScrollFrame = CreateFrame("ScrollFrame", nil, mainFrame, "UIPanelScrollFrameTemplate")
            mainFrame.ScrollFrame:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", -26, -28)
            mainFrame.ScrollFrame:SetPoint("BOTTOMRIGHT", mainFrame, "BOTTOMRIGHT", -31, 6)
            mainFrame.ScrollChild = CreateFrame("Frame", nil, mainFrame.ScrollFrame)
            mainFrame.ScrollChild:SetSize(mainFrame:GetWidth(), mainFrame:GetHeight() - 100)
            mainFrame.ScrollFrame:SetScrollChild(mainFrame.ScrollChild)
            Ranker.MainFrame = mainFrame

            -- The top messages in the Ranker have a yellow/gold color
            local header = mainFrame.ScrollChild:CreateFontString("RankerFrameHeading", "OVERLAY", headerFont)
            header:SetPoint("TOPLEFT", 40, -4)
            header:SetJustifyH("LEFT")
            header:SetJustifyV("TOP")
            header:SetWidth(mainFrame:GetWidth()-40)
            header:SetHeight(12.8)
            header:SetWordWrap(true)
            header:SetIndentedWordWrap(false)
            header:SetNonSpaceWrap(true)
            header:SetText("")
            header:SetFont(STANDARD_TEXT_FONT, 13)
            header:Show()
            Ranker.FrameHeading = header

            -- The main content of the Ranker pane has a white color
            local content = mainFrame.ScrollChild:CreateFontString("RankerFrameContent", "OVERLAY", normalFont)
            content:SetPoint("TOPLEFT", 40, -54)
            content:SetJustifyH("LEFT")
            content:SetJustifyV("TOP")
            content:SetWidth(mainFrame:GetWidth()-44)
            content:SetWordWrap(true)
            content:SetIndentedWordWrap(false)
            content:SetNonSpaceWrap(true)
            content:SetText("")
            content:SetFont(STANDARD_TEXT_FONT, 12)
            content:Show()
            Ranker.FrameContent = content

            -- Textures for when achievement is met
            -- ThumbsUp icon first
            local textureFrame = mainFrame.ScrollChild
            local texture1 = textureFrame:CreateTexture("RankerFrameFinishedTexture1", "ARTWORK")
            texture1:SetTexture("Interface\\AddOns\\Ranker\\Icons\\ThumbsUp")
            texture1:SetSize(100, 100)
            texture1:SetPoint("LEFT", textureFrame, "LEFT", 60, 0)
            texture1:Hide()
            -- The objective rank icon second
            local _, rankNumber = GetPVPRankInfo(rankerObjective + 4)
            local rankIcon = format("%s%02d","Interface\\PvPRankBadges\\PvPRank", rankNumber)
            local texture2 = textureFrame:CreateTexture("RankerFrameFinishedTexture2", "ARTWORK")
            texture2:SetTexture(rankIcon)
            texture2:SetSize(100, 100)
            texture2:SetPoint("LEFT", texture1, "RIGHT", 10, -2)
            texture2:Hide()
            -- Checkmark icon third
            local texture3 = textureFrame:CreateTexture("RankerFrameFinishedTexture3", "ARTWORK")
            texture3:SetTexture("Interface\\AddOns\\Ranker\\Icons\\Checkmark")
            texture3:SetSize(150, 150)
            texture3:SetPoint("LEFT", texture2, "RIGHT", 10, 24)  
            texture3:Hide()
            Ranker.Texture1 = texture1
            Ranker.Texture2 = texture2
            Ranker.Texture3 = texture3

            -- Rank dropdown list for "what if" scenario modeling that lists the available PvP ranks (except unranked since for calculation purposes it's the same as rank 1)
            local whatIfRankList = LibDD:Create_UIDropDownMenu("RankerWhatIfRankList", mainFrame.ScrollChild)
            whatIfRankList:SetPoint("TOPLEFT", 96, 4)
            LibDD:UIDropDownMenu_SetWidth(whatIfRankList, 64)
            if ElvUI then 
                whatIfRankList:SetPoint("TOPLEFT", 102, 4)
                LibDD:UIDropDownMenu_SetWidth(whatIfRankList, 68)
            end
            LibDD:UIDropDownMenu_SetText(whatIfRankList, "rank "..rankerWhatIfRank)
            LibDD:UIDropDownMenu_Initialize(whatIfRankList, function(self, level, menuList)
                local info = LibDD:UIDropDownMenu_CreateInfo()
                local rankName
                for i = 1, maxObtainableRank do         
                    rankName = GetPVPRankInfo(i+4)
                    info.func = self.SetValue
                    info.text, info.arg1, info.checked = "rank "..i.." ("..rankName..")", i, i == rankerWhatIfRank
                    info.icon = format("%s%02d","Interface\\PvPRankBadges\\PvPRank", i)
                    info.isNotRadio = false
                    LibDD:UIDropDownMenu_AddButton(info)
                end
            end)
            function whatIfRankList:SetValue(newValue)
                rankerWhatIfRank = newValue
                LibDD:UIDropDownMenu_SetText(whatIfRankList, "rank "..rankerWhatIfRank)
                CloseDropDownMenus()
                Ranker:Predict()
  
                if not Ranker.WhatIfButton then return end
                Ranker.WhatIfButton:SetText(addonWhatIfButtonTextHide)
            end
            whatIfRankList:Hide()
            Ranker.WhatIfRankList = whatIfRankList

            -- When "what if" scenario modeling is active, display the "and" right between the rank dropdown list and the rank progress editbox 
            local headingAnd = mainFrame.ScrollChild:CreateFontString("RankerFrameHeadingAnd", "OVERLAY", headerFont)
            headingAnd:SetPoint("TOPLEFT", whatIfRankList, "TOPRIGHT", -10, -8)
            headingAnd:SetJustifyH("LEFT")
            headingAnd:SetJustifyV("TOP")
            headingAnd:SetWidth(60)
            headingAnd:SetWordWrap(true)
            headingAnd:SetIndentedWordWrap(false)
            headingAnd:SetNonSpaceWrap(true)
            headingAnd:SetText("and")
            headingAnd:SetFont(STANDARD_TEXT_FONT, 13)
            headingAnd:Hide()
            Ranker.FrameHeadingAnd = headingAnd

            -- Rank progress editbox for "what if" scenario modeling that accepts percentages with two decimals, and left/right/top/bottom arrow key inputs
            local whatIfRankProgressBox = CreateFrame("EditBox", "RankerWhatIfRankProgressBox", mainFrame.ScrollChild, "InputBoxTemplate")
            whatIfRankProgressBox:SetPoint("TOPLEFT", whatIfRankList, "TOPRIGHT", 24, -2)
            whatIfRankProgressBox:SetAutoFocus(false)
            whatIfRankProgressBox:SetFontObject(GameFontHighlightSmall)
            whatIfRankProgressBox:SetHeight(22)
            whatIfRankProgressBox:SetWidth(50)
            whatIfRankProgressBox:SetJustifyH("RIGHT")
            whatIfRankProgressBox:EnableMouse(true)
            whatIfRankProgressBox:SetMaxLetters(6)
            whatIfRankProgressBox:SetTextInsets(0, 5, 2, 0)
            whatIfRankProgressBox:HookScript("OnTextChanged", function(frame)
                Ranker:WhatIfRankProgressBoxChanged(frame)
            end)
            whatIfRankProgressBox:HookScript("OnArrowPressed", function(frame, key)
                Ranker:WhatIfRankProgressBoxChanged(frame, key)
            end)
            whatIfRankProgressBox:Hide()
            Ranker.WhatIfRankProgressBox = whatIfRankProgressBox

            -- When "what if" scenario modeling is active, display the weekly reset message to the right of the rank progress editbox
            local headingReset = mainFrame.ScrollChild:CreateFontString("RankerFrameHeadingReset", "OVERLAY", headerFont)
            headingReset:SetPoint("TOPLEFT", whatIfRankProgressBox, "TOPRIGHT", 0, -6)
            headingReset:SetJustifyH("LEFT")
            headingReset:SetJustifyV("TOP")
            headingReset:SetWidth(200)
            headingReset:SetWordWrap(true)
            headingReset:SetIndentedWordWrap(false)
            headingReset:SetNonSpaceWrap(true)
            headingReset:SetText("")
            headingReset:SetFont(STANDARD_TEXT_FONT, 13)
            headingReset:Hide()
            Ranker.FrameHeadingReset = headingReset

            -- Dropdown list for the player's rank objective
            local dropDownRankerObjective = LibDD:Create_UIDropDownMenu("RankerObjective", mainFrame.ScrollChild)
            dropDownRankerObjective:SetPoint("TOPLEFT", 20, -21)
            LibDD:UIDropDownMenu_SetWidth(dropDownRankerObjective, 160)
            LibDD:UIDropDownMenu_SetText(dropDownRankerObjective, "Your objective: rank "..rankerObjective)
            LibDD:UIDropDownMenu_Initialize(dropDownRankerObjective, function(self, level, menuList)
                local info = LibDD:UIDropDownMenu_CreateInfo()
                local rankName
                for i = 1, maxObtainableRank do         
                    rankName = GetPVPRankInfo(i+4)
                    info.func = self.SetValue
                    info.text, info.arg1, info.checked = "rank "..i.." ("..rankName..")", i, i == rankerObjective
                    info.icon = format("%s%02d","Interface\\PvPRankBadges\\PvPRank", i)
                    info.isNotRadio = false
                    LibDD:UIDropDownMenu_AddButton(info)
                end
            end)
            function dropDownRankerObjective:SetValue(newValue)
                rankerObjective = newValue
                LibDD:UIDropDownMenu_SetText(dropDownRankerObjective, "Your objective: rank "..rankerObjective)
                
                local rankName, rankNumber = GetPVPRankInfo(rankerObjective + 4)
                local rankIcon = format("%s%02d","Interface\\PvPRankBadges\\PvPRank", rankNumber)
                Ranker.Texture2:SetTexture(rankIcon)

                CloseDropDownMenus()
                Ranker:Predict()
            end

            -- Dropdown list for the player's homor limit
            local honorIncrements = lookupData.honorIncrements
            local dropDownRankerLimit = LibDD:Create_UIDropDownMenu("RankerLimit", mainFrame.ScrollChild)
            dropDownRankerLimit:SetPoint("TOPRIGHT", 12, -21)
            LibDD:UIDropDownMenu_SetWidth(dropDownRankerLimit, 180)
            LibDD:UIDropDownMenu_SetText(dropDownRankerLimit, "You honor limit: "..FormatLargeNumber(rankerLimit))
            LibDD:UIDropDownMenu_Initialize(dropDownRankerLimit, function(self, level, menuList)
                local info = LibDD:UIDropDownMenu_CreateInfo()
                local limit = maxObtainableRank
                if maxObtainableRank >= 5 and maxObtainableRank < 14 then limit = maxObtainableRank + 1 end
                if maxObtainableRank >= 9 and maxObtainableRank < 13 then limit = maxObtainableRank + 2 end
                for i = 1, limit do
                    info.func = self.SetValue
                    info.text, info.arg1, info.checked = FormatLargeNumber(honorIncrements[i]).." honor", honorIncrements[i], honorIncrements[i] == rankerLimit
                    LibDD:UIDropDownMenu_AddButton(info)
                end
            end)
            function dropDownRankerLimit:SetValue(newValue)
                rankerLimit = newValue
                LibDD:UIDropDownMenu_SetText(dropDownRankerLimit, "Your honor limit: "..FormatLargeNumber(rankerLimit))
                CloseDropDownMenus()
                Ranker:Predict()
            end

            -- Button on top right of the Honor pane to toggle the visibility of the Ranker pane
            local toggleButton = CreateFrame("Button", "RankerToggleButton", HonorFrame, "GameMenuButtonTemplate")
            toggleButton:SetText(addonToggleButtonTextShow)
            toggleButton:SetSize(100, 22)
            toggleButton:SetPoint("TOPRIGHT", HonorFrame, "TOPRIGHT", -32, 8)
            if ElvUI then 
                toggleButton:SetTemplate(nil, true, true)
                toggleButton:SetPoint("TOPRIGHT", HonorFrame, "TOPRIGHT", -32, 10)
            end
            toggleButton:HookScript("OnClick", Ranker.ToggleWindow)
            Ranker.ToggleButton = toggleButton

            -- Button on top right of the Ranker pane to toggle between "what if" scenario modeling and the current situation
            local whatIfButton = CreateFrame("Button", "RankerWhatIfButton", mainFrame, "GameMenuButtonTemplate")
            whatIfButton:SetText(addonWhatIfButtonTextShow)
            whatIfButton:SetSize(240, 22)
            whatIfButton:SetPoint("TOPRIGHT", mainFrame, "TOPRIGHT", 0, 22)
            if ElvUI then 
                whatIfButton:SetTemplate(nil, true, true)
                whatIfButton:SetPoint("TOPRIGHT", mainFrame, "TOPRIGHT", 1, 22)
            end
            whatIfButton:HookScript("OnClick", Ranker.ToggleWhatIfScenarioModeling)
            Ranker.WhatIfButton = whatIfButton

            -- Hook to the Homor pane 
            HonorFrame:HookScript("OnShow", Ranker.OnHonorFrameShow)
            HonorFrame:HookScript("OnHide", Ranker.OnHonorFrameHide)
            
            -- Hide the Ranker pane until it's called
            mainFrame:Hide()
            mainFrame:HookScript("OnShow", Ranker.OnShow)
            mainFrame:HookScript("OnHide", Ranker.OnHide)

            -- The user interface is now available, continue
            interfaceLoaded = true
        end

    -- Set and retrieve text within the main frame of the Ranker user interface
        function Ranker:SetFrameText(frame, message)
            if not interfaceLoaded or interfaceLoaded ~= true then return end
            frame:SetText(message.."\n")
        end
        function Ranker:GetFrameText(frame)
            return frame:GetText() or ""
        end

    -- Show or hide the Ranker user interface with a single toggle button that is displayed on the top right of the honor pane
        function Ranker:ToggleWindow()
            if not Ranker.ToggleButton then return end
            if Ranker.MainFrame:IsShown() then interfaceShown = false else interfaceShown = true end
            Ranker.MainFrame:SetShown(not Ranker.MainFrame:IsShown())
        end
        function Ranker:ShowWindow()
            interfaceShown = true
            Ranker.MainFrame:SetShown(interfaceShown)
        end
        function Ranker:HideWindow()
            interfaceShown = false
            Ranker.MainFrame:SetShown(interfaceShown)
        end

    -- Change the Ranker toggle button text depending on the visibility state of the Ranker user interface
        function Ranker:OnShow()
            interfaceShown = true
            Ranker.ToggleButton:SetText(addonToggleButtonTextHide)
            Ranker:ResetToCurrentSituationAndPredict()
        end
        function Ranker:OnHide()
            Ranker.ToggleButton:SetText(addonToggleButtonTextShow)
        end

    -- Start or stop "what if" scenario modeling with a single toggle button that is displayed on the top right of the Ranker user interface
        function Ranker:ToggleWhatIfScenarioModeling()
            optionsChanged = true
            if whatIfScenario == nil or whatIfScenario == false then
                whatIfScenario = true
                Ranker.WhatIfButton:SetText(addonWhatIfButtonTextHide)
                Ranker.WhatIfRankList:SetValue(rankerWhatIfRank)
                Ranker.WhatIfRankList:Show()
                Ranker.WhatIfRankProgressBox:SetText(format("%.2f%%", rankerWhatIfRankProgress * 100))
                Ranker.WhatIfRankProgressBox:Show()
                Ranker.FrameHeadingAnd:Show()
                Ranker.FrameHeadingReset:Show()
                Ranker:Predict()
            else
                Ranker:ResetToCurrentSituationAndPredict()
            end
        end

    -- Predict the current player situation only and disable "what if" scenario modeling
        function Ranker:ResetToCurrentSituationAndPredict()
            whatIfScenario = false
            Ranker.WhatIfButton:SetText(addonWhatIfButtonTextShow)
            LibDD:UIDropDownMenu_SetText(Ranker.WhatIfRankList, "rank 0")
            Ranker.WhatIfRankList:Hide()
            Ranker.WhatIfRankProgressBox:SetText("0.00%")
            Ranker.WhatIfRankProgressBox:Hide()
            Ranker.FrameHeadingAnd:Hide()
            Ranker.FrameHeadingReset:Hide()
            Ranker:SetFrameText(Ranker.FrameHeading, "")
            Ranker:Predict()
        end

    -- Validate and transform input made into the "what if" progress editbox 
        function Ranker:WhatIfRankProgressBoxChanged(frame, key)
            whatIfScenario = true
            local value = frame:GetText()

            if value ~= "0.00%" then
                value = gsub(value, "%%", "")
                if not tonumber(value) or tonumber(value) < 0 or tonumber(value) >= 100 then frame:SetText("0.00%") return end
                value = tonumber(value)
            else
                value = 0
            end
            
            if key == "UP" then value = value + 0.01 end
            if key == "DOWN" then value = value - 0.01 if value < 0 then value = 99.99 end end
            if key == "RIGHT" then value = value + 1 if value > 99.99 then value = value - 100 end end
            if key == "LEFT" then value = value - 1 if value < 0 then value = value + 100 end end

            if key == nil then
                rankerWhatIfRankProgress = value / 100
                Ranker:Predict()
            else
                frame:SetText(format("%.2f%%", value))
            end
        end

    -- Allow display of Ranker (if everything is loaded) when the honor pane is opened
        function Ranker:OnHonorFrameShow()
            if worldLoaded and addonLoaded and interfaceLoaded then
                if rankerOptions.showWindowByDefault and rankerOptions.showWindowByDefault == true then
                    ToggleCharacter("HonorFrame", true)
                    Ranker:ShowWindow()
                end
            else
                Ranker:OutputToChat("Please wait until the AddOn has fully loaded.", true)
            end
        end

    -- Set the interface to hidden so that predictions don't run while honor is gained and the pane is closed
        function Ranker:OnHonorFrameHide()
            interfaceShown = false
        end

-----
-- Configuration options
    -- Create the configuration panel with options
        function Ranker:CreateConfigurationOptions()
            -- Name of the AddOn entry in the list of AddOns with configuration options
            RankerFrame.name = "Ranker v"..rankerVersion
            InterfaceOptions_AddCategory(RankerFrame)

            -- Title
            RankerFrame.title = CreateFrame("Frame", "RankerConfiguration", RankerFrame)
            RankerFrame.title:SetPoint("TOPLEFT", RankerFrame, "TOPLEFT", 10, -10)
            RankerFrame.title:SetWidth(300)
            RankerFrame.titleString = RankerFrame.title:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            RankerFrame.titleString:SetPoint("TOPLEFT", RankerFrame, "TOPLEFT", 10, -10)
            RankerFrame.titleString:SetText("|cffe6cc80Configuration options for Ranker v"..rankerVersion..":|r")
        
            -- Option to show the Ranker pane automatically when opening the Honor pane
            RankerFrame.buttonShowWindowByDefault = CreateFrame("CheckButton", "default", RankerFrame, "UICheckButtonTemplate")
            RankerFrame.buttonShowWindowByDefault:SetPoint("TOPLEFT", 20, -30)
            RankerFrame.buttonShowWindowByDefault.Text:SetText("Automatically show the Ranker pane when opening the Honor pane")
            RankerFrame.buttonShowWindowByDefault:SetChecked(rankerOptions.showWindowByDefault)
            RankerFrame.buttonShowWindowByDefault:HookScript("OnClick", 
            function()
                rankerOptions.showWindowByDefault = not rankerOptions.showWindowByDefault
                optionsChanged = true
            end)
        
            -- Option to use current honor for "what if" scenario modeling
            RankerFrame.buttonUseCurrentHonorWhenModeling = CreateFrame("CheckButton", "default", RankerFrame, "UICheckButtonTemplate")
            RankerFrame.buttonUseCurrentHonorWhenModeling:SetPoint("TOPLEFT", 20, -60)
            RankerFrame.buttonUseCurrentHonorWhenModeling.Text:SetText("Use my current honor (instead of 0 honor) when modeling \"what if\" scenarios")
            RankerFrame.buttonUseCurrentHonorWhenModeling:SetChecked(rankerOptions.useCurrentHonorWhenModeling)
            RankerFrame.buttonUseCurrentHonorWhenModeling:HookScript("OnClick", 
            function()
                rankerOptions.useCurrentHonorWhenModeling = not rankerOptions.useCurrentHonorWhenModeling
                optionsChanged = true
            end)
        
            -- Option to stop the reminders about the minimum of 15 HK that are needed each reset
            RankerFrame.buttonKnowsboutMinimumHK = CreateFrame("CheckButton", "default", RankerFrame, "UICheckButtonTemplate")
            RankerFrame.buttonKnowsboutMinimumHK:SetPoint("TOPLEFT", 20, -90)
            RankerFrame.buttonKnowsboutMinimumHK.Text:SetText("I know that at least 15 HK are needed each weekly reset for any rank progress")
            RankerFrame.buttonKnowsboutMinimumHK:SetChecked(rankerOptions.knowsboutMinimumHK)
            RankerFrame.buttonKnowsboutMinimumHK:HookScript("OnClick", 
            function()
                rankerOptions.knowsboutMinimumHK = not rankerOptions.knowsboutMinimumHK
                optionsChanged = true
            end)
        end

    -- Open the configuration panel
        function Ranker:OpenConfigurationOptions()
            InterfaceOptionsFrame_OpenToCategory(RankerFrame)
        end

-----
-- Utilities
    -- Provide information to the player
        function Ranker:OutputToChat(message, debug)
            if debug == true then
                message = message or ""
                print("|cffe6cc80Ranker|r: "..message)
            end
        end

-----
-- Share and save data
    -- Share data with others in periodic intervals (e.g., 10 minutes)
        function Ranker:DataTimer()
            Ranker.DataUpdate("TIMER", nil)
        end

    -- When triggered to update the ranker data: retrieve the information and store it if it's new
        function Ranker:DataUpdate(event, arg1, ...)
            if worldLoaded then
                -- Data received from other players
                if event == "CHAT_MSG_ADDON" then
                    local prefix, message = ...
                    
                    if prefix == addonName then
                        if message ~= nil then
                            local name, level, rank, rankProgress, lastWeekHonor, version, dishonorableKills = strsplit("^", message)

                            if name ~= playerName then
                                -- Backwards compatability since older versions don't share DKs
                                if dishonorableKills then
                                    Ranker:OutputToChat("AddOn message received: "..name.."^"..level.."^"..rank.."^"..rankProgress.."^"..lastWeekHonor.."^"..version.."^"..dishonorableKills.."", debug)
                                else
                                    Ranker:OutputToChat("AddOn message received: "..name.."^"..level.."^"..rank.."^"..rankProgress.."^"..lastWeekHonor.."^"..version.."", debug)
                                end
                                
                                -- Perform a version check
                                if Ranker:VersionCheck(version, rankerVersion) == true then
                                    -- Update the title of the Ranker pane when a newer version is available
                                    Ranker.MainFrame.Title:SetText(addonName.." v"..rankerVersion.." (a newer version is available)")

                                    -- Warn the user 10 minutes after receiving a message from a player with a newer version (and reset the 10 minute timer on each loading screen or interface reload)
                                    if newVersionDetected == false then
                                        newVersionDetected = true
                                        Ranker:OutputToChat("Ranker is out of date. You can download the latest version from curseforge: https://www.curseforge.com/wow/addons/ranker-your-helper-through-the-classic-era-pvp-honor-system", true)
                                    elseif newVersionDetected == nil then
                                        if newVersionDetectionTimer == nil then
                                            newVersionDetectionTimer = NewTicker(timerDuration, Ranker.VersionDetectionResetTimer)
                                        end
                                    end
                                elseif version ~= rankerVersion then
                                    Ranker:OutputToChat("Different version ("..version..") used by "..name..".", debug) 
                                end

                                -- Only write new data
                                if not Ranker:DataExists(rankerData, name, 1*level, 1*rank, 1*rankProgress, 1*lastWeekHonor) then
                                    if not dishonorableKills then dishonorableKills = -1 end
                                    Ranker:SaveData(rankerData, name, 1*level, 1*rank, 1*rankProgress, 1*lastWeekHonor, version, 1*dishonorableKills, GetServerTime())
                                end
                            end
                        end
                    end
                else
                    -- Only write new data for the currently logged in player
                    if not Ranker:DataExists(rankerData, playerName, playerLevel, playerRank, playerRankProgress, playerLastWeekHonor) then 
                        Ranker:SaveData(rankerData, playerName, playerLevel, playerRank, playerRankProgress, playerLastWeekHonor, rankerVersion, playerDishonorableKills, GetServerTime())
                    end

                    -- Share data from currently logged in player with other players when entering the world and on each timer tick
                    if (event == "PLAYER_ENTERING_WORLD" or event == "TIMER") then
                        if event == "TIMER" then 
                            Ranker:OutputToChat("Timer tick for sharing data with others.", debug) 
                        end

                        -- Always share information with players nearby when not in instance
                        local message = playerName.."^"..playerLevel.."^"..playerRank.."^"..playerRankProgress.."^"..playerLastWeekHonor.."^"..rankerVersion.."^"..playerDishonorableKills
                        SendAddonMessage(addonName, message, "YELL")

                        -- Share when in a group
                        if IsInGroup() then 
                            SendAddonMessage(addonName, message, "INSTANCE_CHAT")
                        -- Share with the guild
                        elseif IsInGuild() then
                            SendAddonMessage(addonName, message, "GUILD")
                        end

                        Ranker:OutputToChat("AddOn message sent: "..message, debug)
                    end
                end
            end
        end

    -- Verify that the data is new
        function Ranker:DataExists(rankerData, playerName, playerLevel, playerRank, playerRankProgress, playerLastWeekHonor)
            if rankerData == nil then 
                Ranker:OutputToChat("New data!", debug) 
                return false 
            end

            for key = 1, #rankerData do
                if rankerData[key].playerName and rankerData[key].playerLevel and rankerData[key].playerRank and rankerData[key].playerRankProgress and rankerData[key].playerLastWeekHonor then
                    if rankerData[key].playerName == playerName and rankerData[key].playerLevel == playerLevel and rankerData[key].playerRank == playerRank and rankerData[key].playerRankProgress == playerRankProgress and rankerData[key].playerLastWeekHonor == playerLastWeekHonor then
                        Ranker:OutputToChat("Data already exists.", debug)
                        return true
                    end
                end
            end

            Ranker:OutputToChat("New data.", debug)
            return false
        end

    -- Save new data for the current player
        function Ranker:SaveData(rankerData, playerName, playerLevel, playerRank, playerRankProgress, playerLastWeekHonor, version, playerDishonorableKills, currentTime)
            tinsert(rankerData, {["timestamp"] = currentTime, ["playerName"] = playerName, ["playerLevel"] = playerLevel, ["playerRank"] = playerRank, ["playerRankProgress"] = playerRankProgress, ["playerLastWeekHonor"] = playerLastWeekHonor, ["version"] = version, ["playerDishonorableKills"] = playerDishonorableKills or -1})
            Ranker:OutputToChat("Data stored: "..playerName.."^"..playerLevel.."^"..playerRank.."^"..playerRankProgress.."^"..playerLastWeekHonor.."^"..version.."^"..playerDishonorableKills.."^"..currentTime, debug)
        end

-----
-- Version check
    -- Compare version received with current version
        function Ranker:VersionCheck(versionReceived, rankerVersion)
            if rankerVersion == versionReceived then return false end

            local yearRec, monthRec, dayRec, iterationRec = strsplit(".", versionReceived)
            local dateRec = time({["day"] = dayRec,["month"] = monthRec, ["year"] = yearRec})

            iterationRec = iterationRec * 1

            local year, month, day, iteration = strsplit(".", rankerVersion)
            local date = time({["day"] = day,["month"] = month, ["year"] = year})
            iteration = iteration * 1

            if dateRec == nil then return false end
            if dateRec > date then return true end
            if dateRec == date and iterationRec > iteration then return true end
            
            return false
        end

    -- Reset the version check after 10 minutes to avoid spamming the player
        function Ranker:VersionDetectionResetTimer()
            newVersionDetected = false
        end

-----
-- Calculations
    -- Predict or simulate honor system outcomes
        function Ranker:Predict(overrideHK, overrideHonor, overrideRank, overrideProgress)
            -- Only update if the pane is open
            if not interfaceShown then return end

            -- This function accepts ovverides to allow modeling of other scenarios
            if overrideHK and overrideHonor and overrideRank and overrideProgress then
                scenarioHK = overrideHK
                scenarioHonor = overrideHonor
                scenarioRank = overrideRank
                scenarioProgress = overrideProgress
                Ranker.WhatIfRankList:SetValue(overrideRank)
                Ranker.WhatIfRankProgressBox:SetText(format("%.2f%%", overrideProgress * 100))
                Ranker:OutputToChat("Overrides active: "..overrideHK.." HK, "..overrideHonor.." Honor, Rank "..overrideRank.." and "..overrideProgress, debug)
            else
                overrideHK, overrideHonor = GetPVPThisWeekStats()
                overrideProgress = floor(GetPVPRankProgress() * 10000000000) / 10000000000
                _, overrideRank = GetPVPRankInfo(UnitPVPRank("player"))
            end
            
            -- What if scenario modeling
            if whatIfScenario then
                overrideHK = overrideHK or 0
                if rankerOptions.useCurrentHonorWhenModeling and rankerOptions.useCurrentHonorWhenModeling == true then
                    overrideHonor = overrideHonor
                else
                    overrideHonor = 0
                end
                overrideRank = rankerWhatIfRank or overrideRank
                overrideProgress = rankerWhatIfRankProgress or overrideProgress
                Ranker:OutputToChat("What if scenario active: "..overrideHK.." HK, "..overrideHonor.." Honor, Rank "..overrideRank.." and "..overrideProgress, debug)
                Ranker:SetFrameText(Ranker.FrameHeading, "If you were ")
            end

            -- Nothing to predict for players at max rank
            if (overrideRank or playerRank) >= rankerObjective then
                if Ranker:GetFrameText(Ranker.FrameHeading) ~= "If you were \n" then Ranker:SetFrameText(Ranker.FrameHeading, "Congratulations! You are rank "..(overrideRank or playerRank)..".") end
                Ranker:SetFrameText(Ranker.FrameContent, "Your objective was to be a "..GetPVPRankInfo((rankerObjective or overrideRank or playerRank)+4)..".")
                Ranker:SetFrameText(Ranker.FrameContent, Ranker:GetFrameText(Ranker.FrameContent).."There's nothing left to predict for you.")
                Ranker.Texture1:Show()
                Ranker.Texture2:Show()
                Ranker.Texture3:Show()
                return
            else
                Ranker.Texture1:Hide()
                Ranker.Texture2:Hide()
                Ranker.Texture3:Hide()
            end

            -- Start the prediction for players below rank maxObtainableRank
            if not whatIfScenario then
                if overrideRank == 0 then
                    Ranker:SetFrameText(Ranker.FrameHeading, "You are currently unranked. The weekly reset is in "..SecondsToTime(GetSecondsUntilWeeklyReset())..".")
                else
                    Ranker:SetFrameText(Ranker.FrameHeading, "You are rank "..overrideRank.." and "..format("%.2f%%", overrideProgress * 100)..". Weekly reset in "..SecondsToTime(GetSecondsUntilWeeklyReset())..".")
                end
            end
            Ranker:SetFrameText(Ranker.FrameHeadingReset, ". Reset in "..SecondsToTime(GetSecondsUntilWeeklyReset())..".")

            -- Only predict new scenarios
            if not optionsChanged and (scenarioHK and scenarioHK == overrideHK and scenarioHonor and scenarioHonor == overrideHonor and scenarioRank and scenarioRank == overrideRank and scenarioProgress and scenarioProgress == overrideProgress and scenarioObjective and scenarioObjective == rankerObjective and scenarioLimit and scenarioLimit == rankerLimit) then return end
            scenarioHK = overrideHK
            scenarioHonor = overrideHonor
            scenarioRank = overrideRank
            scenarioProgress = overrideProgress
            scenarioObjective = rankerObjective
            scenarioLimit = rankerLimit
            
            -- Verify honorable kill threshold
            local verb = "will"
            if overrideRank == 0 then overrideRank = 1 end
            if overrideHK < 15 then
                verb = "can"
                if overrideHK == 0 then
                    Ranker:SetFrameText(Ranker.FrameContent, "You need at least |cffe6cc8015 honorable kills for any rank progress|r!".."\n")
                elseif 15 - overrideHK == 1 then
                    Ranker:SetFrameText(Ranker.FrameContent, "You need at least |cffe6cc801 more honorable kill for any rank progress|r!".."\n")
                else
                    Ranker:SetFrameText(Ranker.FrameContent, "You need at least |cffe6cc80"..15 - overrideHK.." more honorable kills for any rank progress|r!".."\n")
                end
                Ranker:SetFrameText(Ranker.FrameContent, Ranker:GetFrameText(Ranker.FrameContent).."You have "..FormatLargeNumber(overrideHonor).." honor.")

                if not rankerOptions.knowsboutMinimumHK and not whatIfScenario then
                    Ranker:SetFrameText(Ranker.FrameContent, Ranker:GetFrameText(Ranker.FrameContent).."\n".."Rank predictions will appear once you meet the 15 honorable kills requirement.")
                    Ranker:SetFrameText(Ranker.FrameContent, Ranker:GetFrameText(Ranker.FrameContent).."\n".."Explore \"what if\" scenarios to model potential outcomes without meeting the 15 honorable kills requirement.")
                    Ranker:SetFrameText(Ranker.FrameContent, Ranker:GetFrameText(Ranker.FrameContent).."\n".."Optionally, confirm that you know about this minimum threshold in AddOn options.")
                    return
                end
            else
                Ranker:SetFrameText(Ranker.FrameContent, "You have "..FormatLargeNumber(overrideHonor).." honor.")
            end
            
            -- Several options are possible based on the "expected rank"
            Ranker:OutputToChat("Determining your result after the weekly reset...", debug)
            local options = Ranker:ChooseYourOwnAdventure(overrideRank, overrideHonor, overrideProgress)
            local even, objectiveMet = nil, "", false
            if overrideProgress > 0 then even = " even " else even = " " end
            for key = 1, #options do
                local varianceMessage = ""
                if options[key].rankMin and options[key].rankProgressMin then
                    varianceMessage = varianceMessage.."rank "..options[key].rankMin.." and "..format("%.2f%%", options[key].rankProgressMin*100)
                end
                if options[key].rankMax and options[key].rankProgressMax then
                    if varianceMessage ~= "" then varianceMessage = varianceMessage.." or " end
                    if options[key].rankMax ~= options[key].rank or options[key].rankMax ~= options[key].rankMin then varianceMessage = varianceMessage.."rank "..options[key].rankMax.." and " else varianceMessage = varianceMessage.."" end
                    varianceMessage = varianceMessage..format("%.2f%%", options[key].rankProgressMax*100)
                end
                if (options[key].rankMin and options[key].rankProgressMin and options[key].rankMax and options[key].rankProgressMax) and (options[key].rankMin == options[key].rankMax and options[key].rankProgressMin == options[key].rankProgressMax) then
                    varianceMessage = "rank "..options[key].rankMin.." and "..format("%.2f%%", options[key].rankProgressMin*100)
                end
                if ((options[key].situation == "!!" or options[key].situation == "+1") and (overrideRank == 6 and overrideProgress >= 0.30)) or
                ((options[key].situation == "+2" or options[key].situation == "+3" or options[key].situation == "+4") and (overrideRank == 6 and overrideProgress < 0.30)) or
                ((options[key].situation == "!!" or options[key].situation == "+1" or options[key].situation == "+2" or options[key].situation == "+3") and (overrideRank == 7 and overrideProgress >= 0.30)) or
                ((options[key].situation == "+4") and (overrideRank == 7 and overrideProgress < 0.30)) or
                ((options[key].situation == "!!" or options[key].situation == "+1") and (overrideRank == 10 and overrideProgress >= 0.50)) or
                ((options[key].situation == "+2" or options[key].situation == "+3") and (overrideRank == 10 and overrideProgress < 0.50)) or
                ((options[key].situation == "!!" or options[key].situation == "+1" or options[key].situation == "+2") and (overrideRank == 11 and overrideProgress >= 0.49795)) or
                ((options[key].situation == "!!" or options[key].situation == "+1") and (overrideRank == 13 and overrideProgress >= 0.6627451181)) then 
                    varianceMessage = ""
                end
                if options[key].honorRemains and options[key].honorRemains > 0 and options[key].rank <= rankerObjective and options[key].situation ~= "+1" then
                    Ranker:OutputToChat("Option #: "..options[key].number.." ("..options[key].situation.."): rank "..options[key].rank.." and "..format("%.2f%%", options[key].rankProgress*100).." with "..FormatLargeNumber(options[key].honorNeed).." honor (missing "..FormatLargeNumber(options[key].honorRemains)..").", debug)
                    if options[key].situation == "!!" then
                        if lookupData.defaults.allowDecayPreventionHop == true then
                            Ranker:SetFrameText(Ranker.FrameContent, Ranker:GetFrameText(Ranker.FrameContent).."You can obtain |cffe6cc80rank "..options[key].rank.." and "..format("%.2f%%", options[key].rankProgress*100).."|r with "..FormatLargeNumber(options[key].honorNeed).." honor.")
                            if rankerOptions.showContributionPointsVarianceBug == true and varianceMessage ~= "" then
                                Ranker:SetFrameText(Ranker.FrameContent, Ranker:GetFrameText(Ranker.FrameContent).."        A bug may result in "..varianceMessage.." instead.")
                            end
                        end
                    else
                        Ranker:SetFrameText(Ranker.FrameContent, Ranker:GetFrameText(Ranker.FrameContent).."You can obtain |cffe6cc80rank "..options[key].rank.." and "..format("%.2f%%", options[key].rankProgress*100).."|r with "..FormatLargeNumber(options[key].honorNeed).." honor.")
                        if rankerOptions.showContributionPointsVarianceBug == true and varianceMessage ~= "" then
                            Ranker:SetFrameText(Ranker.FrameContent, Ranker:GetFrameText(Ranker.FrameContent).."        A bug may result in "..varianceMessage.." instead.")
                        end
                    end
                    if (options[key].situation == "!!" and lookupData.defaults.allowDecayPreventionHop == true) or options[key].situation ~= "!!" then
                        Ranker:SetFrameText(Ranker.FrameContent, Ranker:GetFrameText(Ranker.FrameContent).."        You need |cffe6cc80"..FormatLargeNumber(options[key].honorRemains).." more|r honor.")
                    end
                elseif (options[key].honorRemains and options[key].honorRemains <= 0) or (options[key].rank <= rankerObjective) and options[key].situation ~= "+1" then
                    Ranker:OutputToChat("Option #: "..options[key].number.." ("..options[key].situation.."): rank "..options[key].rank.." and "..format("%.2f%%", options[key].rankProgress*100).." with "..FormatLargeNumber(options[key].honorNeed).." honor.", debug)
                    if (options[options[key].number+1] and options[options[key].number+1].honorRemains > 0) or not options[options[key].number+1] then
                        if options[key].situation == "!!" then
                            if lookupData.defaults.allowDecayPreventionHop == true then
                                if options[key].rank >= rankerObjective then objectiveMet = true maxRank = options[key].rank end
                                Ranker:SetFrameText(Ranker.FrameContent, Ranker:GetFrameText(Ranker.FrameContent).."You "..verb.." be |cffe6cc80rank "..options[key].rank.." and "..format("%.2f%%", options[key].rankProgress*100).."|r.")
                            end
                        else
                            if options[key].rank >= rankerObjective then objectiveMet = true maxRank = options[key].rank end
                            Ranker:SetFrameText(Ranker.FrameContent, Ranker:GetFrameText(Ranker.FrameContent).."You "..verb.." be |cffe6cc80rank "..options[key].rank.." and "..format("%.2f%%", options[key].rankProgress*100).."|r.")
                        end
                        if rankerOptions.showContributionPointsVarianceBug == true and varianceMessage ~= "" then
                            Ranker:SetFrameText(Ranker.FrameContent, Ranker:GetFrameText(Ranker.FrameContent).."        A bug may result in "..varianceMessage..".")
                        end
                    end
                end
            end

            if #options > 0 then
                if objectiveMet == true then
                    Ranker:SetFrameText(Ranker.FrameContent, Ranker:GetFrameText(Ranker.FrameContent).."\n".."You "..verb.." be |cffe6cc80rank "..maxRank.."|r after the weekly reset.")
                    if overrideHK < 15 then
                        if overrideHK == 0 then
                            Ranker:SetFrameText(Ranker.FrameContent, Ranker:GetFrameText(Ranker.FrameContent).."You need |cffe6cc8015 more honorable kills|r!")
                        elseif 15 - overrideHK == 1 then
                            Ranker:SetFrameText(Ranker.FrameContent, Ranker:GetFrameText(Ranker.FrameContent).."You need |cffe6cc801 more honorable kill|r!")
                        else
                            Ranker:SetFrameText(Ranker.FrameContent, Ranker:GetFrameText(Ranker.FrameContent).."You need |cffe6cc80"..15 - overrideHK.." more honorable kills|r!")
                        end
                    end
                else
                    -- An optimal path to the objective rank
                    Ranker:OutputToChat("Determining your optimal path to your objective rank...", debug)
                    Ranker:SetFrameText(Ranker.FrameContent, Ranker:GetFrameText(Ranker.FrameContent).."\n".."Your optimal path (least amount of time and honor) to rank "..rankerObjective..":")
                    Ranker:ProjectOptimalPathToObjectiveRank(overrideRank, overrideProgress, overrideHonor)

                    -- Summarize the optimal path
                    local weeksToGo = tries - 1
                    local weeksToObjectiveText = weeksToGo.." more week"
                    if weeksToGo > 1 then
                        weeksToObjectiveText = weeksToObjectiveText.."s"
                    end
                    if maxRank < rankerObjective then
                        Ranker:SetFrameText(Ranker.FrameContent, Ranker:GetFrameText(Ranker.FrameContent).."\n".."Obtaining rank "..rankerObjective.." is |cffe6cc80impossible with your honor limit|r!")
                    else
                        if weeksToGo == 0 then
                            Ranker:SetFrameText(Ranker.FrameContent, Ranker:GetFrameText(Ranker.FrameContent).."\n".."You "..verb.." be |cffe6cc80rank "..maxRank.."|r after the weekly reset.")
                            Ranker:SetFrameText(Ranker.FrameContent, Ranker:GetFrameText(Ranker.FrameContent).."You need more honor!")
                        elseif weeksToGo > 0 then
                            Ranker:SetFrameText(Ranker.FrameContent, Ranker:GetFrameText(Ranker.FrameContent).."\n".."Obtaining rank "..rankerObjective.." takes you |cffe6cc80"..weeksToObjectiveText.."|r after the weekly reset.")
                            Ranker:SetFrameText(Ranker.FrameContent, Ranker:GetFrameText(Ranker.FrameContent).."This path requires you to obtain "..FormatLargeNumber(sumHonor).." honor in total.")
                        end
                    end
                    sumHonor, tries = 0, 0, 0
                end
            else
                Ranker:SetFrameText(Ranker.FrameContent, Ranker:GetFrameText(Ranker.FrameContent).."\n".."Obtaining rank "..rankerObjective.." is |cffe6cc80impossible with your honor limit|r!")
            end

            -- Call to action
            Ranker:SetFrameText(Ranker.FrameContent, Ranker:GetFrameText(Ranker.FrameContent).."\n".."Please contact me if your actual result is way off.".."\n")
            optionsChanged = false
        end

    -- Calculate the estimate CP for a given rank and progress withn the rank based on known data
        function Ranker:CalculateContributionPoints(rank, rankProgress)
            if rank <= 1 then return 0 end

            local contributionPointsFloor = lookupData.contributionPointsFloor
            local contributionPointsCeiling = lookupData.contributionPointsCeiling

            return ((contributionPointsCeiling[rank] - contributionPointsFloor[rank]) * (rankProgress or 1)) + contributionPointsFloor[rank]
        end

    -- Calculate the estimated rank based on the provided CP
        function Ranker:CalculatePredictedRank(inputRank, inputCP)
            if inputRank == nil then return end

            local contributionPointsFloor = lookupData.contributionPointsFloor
            local contributionPointsCeiling = lookupData.contributionPointsCeiling
            local rank, rankProgress

            for key = 1, #contributionPointsCeiling do
                if inputCP >= contributionPointsFloor[key] and key <= inputRank then
                    rank = key
                    rankProgress = ((inputCP - contributionPointsFloor[key]) / (contributionPointsCeiling[key] - contributionPointsFloor[key]))
                else
                    return rank, rankProgress
                end
            end

            return rank, rankProgress
        end

    -- Calculate how many maximum honor points are needed to obtain the maximum amount of CP
        function Ranker:CalculateMaxHonorNeeded(rank, honor)
            if rank == nil then return end
            if rank == 0 then rank = 1 end

            local contributionPointsFloor = lookupData.contributionPointsFloor
            local contributionPointsCeiling = lookupData.contributionPointsCeiling
            local honorToContributionPointsRatio = lookupData.honorToContributionPointsRatio
            local maxRequiredCP
            local maxNeededHonor

            for key = 1, #contributionPointsCeiling do
                if key <= rank then
                    maxRequiredCP = contributionPointsFloor[key]
                end
            end

            if rank <= 6 then
                maxNeededHonor = contributionPointsFloor[rank] * honorToContributionPointsRatio[rank]
            elseif rank <= 10 then
                maxNeededHonor = 45000 + (contributionPointsFloor[rank] - 20000) * honorToContributionPointsRatio[rank]
            else
                maxNeededHonor = 175000 + (contributionPointsFloor[rank] - 40000) * honorToContributionPointsRatio[rank]
            end

            return maxRequiredCP, maxNeededHonor, maxNeededHonor - (honor or 0)
        end

    -- Calculate the gain in CP based on the converted predicted CP
        function Ranker:CalculateCPGain(rank, objectiveRank, predictedCP, currentCP)
            if objectiveRank == nil then return end
            if rank == 0 then rank = 1 end

            local contributionPointsFloor = lookupData.contributionPointsFloor
            local rankChangeFactor = lookupData.rankChangeFactor
            local objectiveCP, newCP, gainedCP, bonusCP, gainedCPwithCeiling, buckets = 0, 0, 0, 0, 0, 0

            for key = rank + 1, objectiveRank do
                buckets = objectiveRank - rank
                if key ~= 1 then
                    -- The CP awarded for each bucket is calculated by multiplying the available CP with a change factor
                    gainedCP = ((contributionPointsFloor[key] - contributionPointsFloor[key - 1]) * rankChangeFactor[key])
                end
                if key == rank + 1 then
                    -- Two ranks ignore the change factor and this new ceiling since the changes introduced as of September 12 (to prevent gaming the system through DKs)
                    if rank == 9 then 
                        gainedCP = 3000 
                    elseif rank == 11 then 
                        gainedCP = 2500
                    end
                    -- The CP awarded in the first bucket is now the minimum of 3000 (for rank 9), 2500 (for rank 11), the gainedCP in the bucket multiplied with the change factor (original Blizzard post), or the gainedCPwithCeiling based on current rank progress to prevent gaming the system through DKs
                    gainedCPwithCeiling = ((contributionPointsFloor[key] - contributionPointsFloor[key - 1]) * (1 - ((currentCP - contributionPointsFloor[key - 1]) / (contributionPointsFloor[key] - contributionPointsFloor[key - 1]))))
                    if gainedCPwithCeiling < gainedCP then gainedCP = gainedCPwithCeiling end
                    -- Bonus CP is awarded in certain cases, if the current rank is between 6 and 10, with the September 12 changes (to prevent gaming the system through DKs)
                    if (rank == 6 and buckets == 4) or 
                    (rank == 7 and buckets >= 3) or 
                    (rank == 8 and (buckets == 2 or buckets == 3)) or 
                    (rank == 9 and buckets >= 3) or 
                    (rank == 10 and buckets >= 2) then 
                        bonusCP = 500
                    elseif rank == 8 and buckets == 4 then 
                        bonusCP = 1000
                    end
                end
                objectiveCP = objectiveCP + gainedCP
            end

            if objectiveCP == 0 then
                objectiveCP = predictedCP 
                newCP = predictedCP
            else 
                newCP = currentCP + objectiveCP
            end

            return objectiveCP, newCP, bonusCP
        end

    -- Project a path to rank maxObtainableRank
        function Ranker:ProjectSimplePathToObjectiveRank(rank, rankProgress, honorNeeded)
            if rank >= rankerObjective then return end
            Ranker:OutputToChat("ProjectSimplePathToObjectiveRank: rank "..rank.." and "..rankProgress.." ("..honorNeeded..")", debug)

            local efficientOptions = {}
            local currentOption = 1
            local weeknum = 0
            local totalHonor = honorNeeded
            local currentRank = rank
            local currentProgress = rankProgress
            
            while currentOption <= maxTries do
                local options = Ranker:ChooseYourOwnAdventure(currentRank, 0, currentProgress)
                
                if not options or #options == 0 then
                    break
                end
                
                local bestOption
                local highestRank = -1
                local highestProgress = -1
                
                for _, option in ipairs(options) do
                    if option.rank == rankerObjective then
                        weeksToObjective = weeknum
                        Ranker:OutputToChat("    >F#"..option.number.." ("..option.situation.."): Weeks: "..weeksToObjective.." and total honor: "..FormatLargeNumber(totalHonor + option.honorNeed), debug)
                        
                        return totalHonor + option.honorNeed, weeksToObjective
                    end
                    if option.rank > highestRank or (option.rank == highestRank and option.rankProgress > highestProgress) then
                        bestOption = option
                        highestRank = option.rank
                        highestProgress = option.rankProgress
                    end
                end

                table.insert(efficientOptions, bestOption)
                totalHonor = totalHonor + bestOption.honorNeed
                currentRank = bestOption.rank
                currentProgress = bestOption.rankProgress
                currentOption = currentOption + 1
                weeknum = weeknum + 1
                Ranker:OutputToChat("    +B#"..bestOption.number.." ("..bestOption.situation.."): Weeks: "..weeksToObjective.." and total honor: "..FormatLargeNumber(totalHonor), debug)
            end
            
            return totalHonor, weeknum
        end

    -- Choose your own adventure, returns up to 5 options (for the decay prevention hop and for each step up)
        function Ranker:ChooseYourOwnAdventure(rank, honor, progress)
            Ranker:OutputToChat("ChooseYourOwnAdventure: rank "..rank.." and "..progress.." ("..honor..")", debug)
            local currentCP = Ranker:CalculateContributionPoints(rank, ceil(progress * 1000) / 1000)
            local currentRank = rank
            local situations = {"0", "+1", "+2", "+3", "+4"}
            local options = {}
            local situation, CP, honorNeed, honorRemains, totalNewCP, bonusCP, predictedNewRank, predictedNewProgress

            for num = 1, 5 do
                if rank + num - 1 <= min(maxObtainableRank + 4, 14) then
                    situation = situations[num]
                    
                    CP, honorNeed, honorRemains = Ranker:CalculateMaxHonorNeeded(rank+num-1, honor)
                    _, totalNewCP, bonusCP = Ranker:CalculateCPGain(rank, rank+num-1, CP, currentCP)
                    totalNewCP = totalNewCP + bonusCP
                    predictedNewRank, predictedNewProgress = Ranker:CalculatePredictedRank(rank + 4, totalNewCP)

                    if (predictedNewRank <= rankerObjective and (honorNeed <= rankerLimit)) or (honor >= honorNeed) and (honorNeed <= honor or honorNeed <= rankerLimit) then
                        if num == 1 and rank + num <= rankerObjective then
                            CP = Ranker:CalculateMaxHonorNeeded(rank + num, honorNeed)
                            _, totalNewCP = Ranker:CalculateCPGain(rank, rank + num, CP, currentCP)
                            predictedNewRank, predictedNewProgress = Ranker:CalculatePredictedRank(rank + 4, totalNewCP)
                            situation = "!!" 
                        end
                    
                        local lookup, lookupTable, varianceType, predictedNewRankMin, predictedNewProgressMin, predictedNewRankMax, predictedNewProgressMax
                        local varianceMin, varianceMax = 0, 0
                        
                        if situation == "!!" then lookup = rank.."_1" else lookup = rank.."_"..(situation * 1) end
                        if lookupData.contributionPointsVariances[lookup] then
                            lookupTable = lookupData.contributionPointsVariances[lookup]
                            varianceType = "Regular"
                        end
                        if lookupData.contributionPointsVariancesException[lookup] and progress >= 0.50 then
                            lookupTable = lookupData.contributionPointsVariancesException[lookup]
                            varianceType = "Exception"
                        end
                        if lookupData.contributionPointsVariancesReplace[lookup] and (progress <= lookupData.contributionPointsVariancesReplace[lookup].progressCeil and progress >= lookupData.contributionPointsVariancesReplace[lookup].progressFloor) then
                            lookupTable = lookupData.contributionPointsVariancesReplace[lookup]
                            varianceType = "Replace"
                        end
                        if lookupTable then
                            varianceMin = lookupTable.min
                            varianceMax = lookupTable.max
                            if varianceType == "Replace" then
                                if varianceMin and varianceMin ~= 0 then 
                                    predictedNewRank, predictedNewProgress = Ranker:CalculatePredictedRank(rank + 4, totalNewCP - lookupTable.min) 
                                end
                                if varianceMax and varianceMax ~= 0 then 
                                    predictedNewRank, predictedNewProgress = Ranker:CalculatePredictedRank(rank + 4, totalNewCP + lookupTable.max) 
                                end
                            else
                                if varianceMin and varianceMin ~= 0 then
                                    predictedNewRankMin, predictedNewProgressMin = Ranker:CalculatePredictedRank(rank + 4, totalNewCP - varianceMin)
                                    if not varianceMax then predictedNewRankMax, predictedNewProgressMax = predictedNewRankMin, predictedNewProgressMin end
                                end
                                if varianceMax and varianceMax ~= 0 then 
                                    predictedNewRankMax, predictedNewProgressMax = Ranker:CalculatePredictedRank(rank + 4, totalNewCP + varianceMax) 
                                end
                            end
                        end
                        if lookupData.defaults.allowDecayPreventionHop == true or (lookupData.defaults.allowDecayPreventionHop ~= true and situation ~= "!!") then
                            tinsert(options, {["number"] = num, ["situation"] = situation, ["rank"] = predictedNewRank, ["rankProgress"] = predictedNewProgress, ["honorNeed"] = honorNeed, ["honorRemains"] = honorRemains, ["rankMin"] = predictedNewRankMin, ["rankProgressMin"] = predictedNewProgressMin, ["rankMax"] = predictedNewRankMax, ["rankProgressMax"] = predictedNewProgressMax})
                            Ranker:OutputToChat("  ChooseYourOwnAdventure option: "..num.." ("..situation..") need "..honorNeed.." honor ("..honorRemains.." more) for rank "..(predictedNewRankMin or "nil").." and "..(predictedNewProgressMin or "nil")..", or rank "..predictedNewRank.." and "..predictedNewProgress..", or rank "..(predictedNewRankMax or "nil").." and "..(predictedNewProgressMax or "nil")..".", debug)
                        end
                    end
                end
            end
            
            return options
        end

    -- Return the best possible option
        function Ranker:FindTheBestPossibleOption(entries)
            if not entries or #entries == 0 then
                return nil
            end
        
            local bestEntry = entries[1]
        
            for i = 2, #entries do
                local currentEntry = entries[i]

                Ranker:OutputToChat("    FindTheBestPossibleOption: "..currentEntry.weeksTotal.." vs "..bestEntry.weeksTotal..", "..currentEntry.honorTotal.." vs "..bestEntry.honorTotal..", "..currentEntry.honorRemains.." vs "..bestEntry.honorRemains..", "..currentEntry.rankTo.." vs "..bestEntry.rankTo..", "..currentEntry.option.." vs "..bestEntry.option..", "..#entries..", "..currentEntry.rankFrom.." and "..currentEntry.progressFrom..", "..currentEntry.rankTo.." and "..currentEntry.progressTo, debug)
                if currentEntry.honorRemains > bestEntry.honorRemains and currentEntry.honorRemains <= 0 and currentEntry.honorRemains > bestEntry.honorRemains and currentEntry.option > bestEntry.option and currentEntry.rankTo >= bestEntry.rankTo then
                    bestEntry = currentEntry
                    Ranker:OutputToChat("    ^^^^^", debug)
                elseif currentEntry.weeksTotal < bestEntry.weeksTotal then
                    bestEntry = currentEntry                    
                    Ranker:OutputToChat("    ^^^^^ !", debug)
                elseif currentEntry.weeksTotal == bestEntry.weeksTotal and currentEntry.honorTotal < bestEntry.honorTotal then
                    bestEntry = currentEntry                    
                    Ranker:OutputToChat("    ^^^^^ !!", debug)
                elseif currentEntry.weeksTotal == bestEntry.weeksTotal and currentEntry.rankTo > bestEntry.rankTo and currentEntry.honorTotal <= bestEntry.honorTotal then
                    bestEntry = currentEntry                    
                    Ranker:OutputToChat("    ^^^^^ !!!", debug)
                end
            end

            return bestEntry
        end

    -- Calculate how to reach the objective the quickest with the least amount of honor required
        function Ranker:ProjectOptimalPathToObjectiveRank(overrideRank, overrideProgress, overrideHonor)
            local tempTable = {}
            local options = Ranker:ChooseYourOwnAdventure(overrideRank, overrideHonor, overrideProgress)

            for key = 1, #options do
                local honorTotal, weekNum = Ranker:ProjectSimplePathToObjectiveRank(options[key].rank, options[key].rankProgress, options[key].honorNeed)
                local rankTo, progressTo = options[key].rank, options[key].rankProgress
                local weekText = "+"..tries.." week"
                       
                if tries == 0 then weekText = "current week" end
                if tries > 1 then weekText = weekText.."s" end
                if not (((options[key].situation == "!!" or options[key].situation == "+1") and (overrideRank == 6 and overrideProgress >= 0.30)) or
                ((options[key].situation == "+2" or options[key].situation == "+3" or options[key].situation == "+4") and (overrideRank == 6 and overrideProgress < 0.30)) or
                ((options[key].situation == "!!" or options[key].situation == "+1" or options[key].situation == "+2" or options[key].situation == "+3") and (overrideRank == 7 and overrideProgress >= 0.30)) or
                ((options[key].situation == "+4") and (overrideRank == 7 and overrideProgress < 0.30)) or
                ((options[key].situation == "!!" or options[key].situation == "+1") and (overrideRank == 10 and overrideProgress >= 0.50)) or
                ((options[key].situation == "+2" or options[key].situation == "+3") and (overrideRank == 10 and overrideProgress < 0.50)) or
                ((options[key].situation == "!!" or options[key].situation == "+1" or options[key].situation == "+2") and (overrideRank == 11 and overrideProgress >= 0.50)) or
                ((options[key].situation == "!!" or options[key].situation == "+1") and (overrideRank == 13 and overrideProgress >= 0.6627451181))) then
                    if options[key].rankMin and options[key].rankProgressMin then
                        rankTo, progressTo = options[key].rankMin, options[key].rankProgressMin
                    elseif options[key].rankMax and options[key].rankProgressMax then
                        rankTo, progressTo = options[key].rankMax, options[key].rankProgressMax
                    end
                end
                table.insert(tempTable, {["rankFrom"] = overrideRank, ["progressFrom"] = overrideProgress, ["option"] = options[key].number, ["rankTo"] = rankTo, ["progressTo"] = progressTo, ["honorNeed"] = options[key].honorNeed, ["honorRemains"] = options[key].honorRemains, ["weeksTotal"] = weekNum or 0, ["honorTotal"] = honorTotal or 0, ["weekText"] = weekText})
            end
            
            local bestEntry = Ranker:FindTheBestPossibleOption(tempTable)

            if not bestEntry then
                return
            end
            
            tries = tries + 1
            sumHonor = sumHonor + bestEntry.honorNeed
            maxRank = bestEntry.rankTo

            Ranker:OutputToChat("From rank "..bestEntry.rankFrom.." and "..format("%.2f%%", bestEntry.progressFrom * 100)..", take option "..bestEntry.option.." to rank "..bestEntry.rankTo.." and "..format("%.2f%%", bestEntry.progressTo * 100).." with "..FormatLargeNumber(bestEntry.honorNeed).." honor ("..bestEntry.weekText..").", debug)
            Ranker:SetFrameText(Ranker.FrameContent, Ranker:GetFrameText(Ranker.FrameContent).." - To rank "..bestEntry.rankTo.." and "..format("%.2f%%", bestEntry.progressTo * 100).." with |cffe6cc80"..FormatLargeNumber(bestEntry.honorNeed).."|r honor ("..bestEntry.weekText..").")
            
            if (bestEntry.rankFrom == bestEntry.rankTo and bestEntry.progressFrom == bestEntry.progressTo) or (bestEntry.rankTo == rankerObjective) or (tries > maxTries) then
                return
            end
            
            Ranker:ProjectOptimalPathToObjectiveRank(bestEntry.rankTo, bestEntry.progressTo, 0)
        end

-----
-- Test calculations based on data gathered
    -- Find pairs in the saved data, run the prediction, and identify any discprancies
        function Ranker:Test()
            local dataLastWeek = {}
            local dataCurrentWeek = {}
            local currentReset = time() + GetSecondsUntilWeeklyReset() 
            local counter = 0
            local oneWeek = 7 * 24 * 60 * 60
            local lastReset = currentReset - oneWeek
            local priorReset = currentReset - (oneWeek * 2)
            local tempData = {}
            local rankerObjectiveOld = rankerObjective
            local rankerLimitOld = rankerLimit
            rankerObjective = lookupData.defaults.rankerObjective
            rankerLimit = lookupData.defaults.rankerLimit

            for key = 1, #rankerData do
                if rankerData[key] and rankerData[key].timestamp then
                    local playerName = rankerData[key].playerName
                    if rankerData[key].timestamp <= lastReset and rankerData[key].timestamp > priorReset then
                        if not tempData[playerName] then tempData[playerName] = {} end
                        tinsert(dataLastWeek, rankerData[key])
                        tinsert(tempData[playerName], {id = 1, lastweek = true, previousRank = rankerData[key].playerRank, previousProgress = rankerData[key].playerRankProgress})
                    elseif rankerData[key].timestamp > lastReset then
                        if not tempData[playerName] then tempData[playerName] = {} end
                        tinsert(dataCurrentWeek, rankerData[key])
                        tinsert(tempData[playerName], {id = 2, currentweek = true, currentRank = rankerData[key].playerRank, currentProgress = rankerData[key].playerRankProgress, previousHonor = rankerData[key].playerLastWeekHonor})
                    end
                end
            end

            for key, value in pairs(dataCurrentWeek) do
                local playerName = value.playerName

                if #tempData[playerName] == 2 and tempData[playerName][1].previousRank ~= nil and tempData[playerName][2].currentRank ~= nil then
                    local previousRank = tempData[playerName][1].previousRank
                    local previousRankNew = previousRank
                    local previousProgress = tempData[playerName][1].previousProgress
                    local previousHonor = tempData[playerName][2].previousHonor
                    local currentRank = tempData[playerName][2].currentRank
                    local currentRankNew = currentRank
                    local currentProgress = tempData[playerName][2].currentProgress
                    if previousRank == 0 then previousRankNew = 1 end
                    if currentRank == 0 then currentRankNew = 1 end
                    local previousCP = Ranker:CalculateContributionPoints(previousRankNew, previousProgress)
                    local currentCP = Ranker:CalculateContributionPoints(currentRankNew, currentProgress)
                    local options = Ranker:ChooseYourOwnAdventure(previousRankNew, previousHonor, previousProgress)

                    for key = 1, #options do
                        if options[key].honorRemains and options[key].honorRemains <= 0 then
                            if (options[options[key].number+1] and options[options[key].number+1].honorRemains > 0) or not options[options[key].number+1] then
                                local newCP = Ranker:CalculateContributionPoints(options[key].rank, options[key].rankProgress)
                                local deltaCP = newCP - currentCP
                                if (previousRank + previousProgress ~= currentRank + currentProgress) and (deltaCP <= -lookupData.defaults.contributionPointsVarianceThreshold or deltaCP >= lookupData.defaults.contributionPointsVarianceThreshold) then
                                    counter = counter + 1
                                    Ranker:OutputToChat("Case #"..counter.." for player "..playerName, true)
                                    Ranker:OutputToChat("  They were rank "..previousRank.." and "..format("%.2f%%", previousProgress*100)..". Got "..FormatLargeNumber(previousHonor).." honor.", true)
                                    Ranker:OutputToChat("  They are now rank "..currentRank.." and "..format("%.2f%%", currentProgress*100)..".", true)
                                    Ranker:OutputToChat("  They were predicted to be rank "..options[key].rank.." and "..format("%.2f%%", options[key].rankProgress*100)..".", true)
                                    Ranker:OutputToChat("  From "..previousCP.." CP to "..currentCP.." CP.", true)
                                    Ranker:OutputToChat("  Predicted was "..newCP.." CP.", true)
                                    Ranker:OutputToChat("  Difference of "..deltaCP.." CP.", true)
                                end
                            end
                        end
                    end
                end
            end

            if counter == 0 then
                Ranker:OutputToChat("Tested all data points. Everything seems fine.", true)
            end
            
            rankerObjective = rankerObjectiveOld
            rankerLimit = rankerLimitOld
        end

-----
-- Data management
    -- Prune data that is no longer useful
        function Ranker:PruneOldData()
            -- Delete any data point older than September 13, the reset when the change related to dishonorable kills went into effect
            local timestampOldData = time({["day"] = 13,["month"] = 9, ["year"] = 2023, ["hour"] = 0})
            local tempData = {}

            for key = 1, #rankerData do
                if rankerData[key] and rankerData[key].timestamp and rankerData[key].timestamp >= timestampOldData then
                    tinsert(tempData, rankerData[key])
                end
            end

            -- Report back
            Ranker:OutputToChat("Pruned "..#rankerData - #tempData.." outdated data points.", true)

            -- Save
            rankerData = tempData
        end

-----