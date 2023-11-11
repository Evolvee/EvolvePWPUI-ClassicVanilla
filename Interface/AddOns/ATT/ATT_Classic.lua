--[[
Name: Ability Team Tracker Classic
Author: by Izy
Contact/support @ curseforge.com/wow/addons/att
Description: Track the cooldowns of your party members
--]]
local _G = _G
local addon, ATTdbs = ...
local UnitClass = UnitClass
local UnitGUID = UnitGUID
local IsInInstance = IsInInstance
local IsInGroup = IsInGroup
local IsInRaid = IsInRaid
local UnitRace = UnitRace
local CooldownFrame_Set = CooldownFrame_Set
local GetTalentInfo = GetTalentInfo
local GetSpellInfo = GetSpellInfo
local LGlows = ATTdbs.LibATTButtonGlow
local SO = ATTdbs.LibSimpleOptions
local openRaidLib = ATTdbs.openRaidLib
local ChatPrefix = "ATT-Check"
local ATTversion = GetAddOnMetadata("ATT", "Version")
local db
local selectedDB
local dbModif = ATTdbs.dbModif
local dbRacials = ATTdbs.dbRacials
local dbImport = ATTdbs.dbImport
local ShareCD = ATTdbs.ShareCD
local dbAuraRemoved = ATTdbs.dbAuraRemoved
local dbAuraApplied = ATTdbs.dbAuraApplied
local dbTrinkets = ATTdbs.dbTrinkets
local cooldownResetters = ATTdbs.cooldownResetters
local validPartyUnits = ATTdbs.validPartyUnits
local validRaidUnits = ATTdbs.validRaidUnits
local customframes = ATTdbs.customframes
local ATT = CreateFrame("Frame", "ATT", UIParent)
local ATTIcons = CreateFrame("Frame", nil, UIParent)
local ATTAnchor = CreateFrame("Frame", nil, UIParent)
local ATTInspectFrame = CreateFrame("Frame")

local NotifyInspect = NotifyInspect
local elapsedTime = 0

local anchors = {}
local activeGUIDS = {}
local activeBUFFS = {}
local syncChache = {}

-- Player Inspect
local inspect_queue = {}
local dbInspect = {}
local insUnitStart = {}
local isFWW = {} -- workaround fix
local hookedFrames = {}

local PlayerGUID = UnitGUID("player")

local function print(...)
    for i = 1, select('#', ...) do
        ChatFrame1:AddMessage("|cff33ff99ATT|r: " .. select(i, ...))
    end
end

function ATT:GetUnitByGUID(guid)
    if not guid then return end
    local validUnits = ATT.inRaid and validRaidUnits or validPartyUnits
    for k, v in pairs(validUnits) do
        if guid and UnitGUID(k) == guid then
            return k
        end
    end
end

function ATT:GetAnchorByUnit(unit)
    if not validRaidUnits[unit] and not validPartyUnits[unit] then return end
    local guid = UnitGUID(unit)
    local fixedUnit = self:GetUnitByGUID(guid)
    local validUnits = ATT.inRaid and validRaidUnits or validPartyUnits
    return anchors[validUnits[fixedUnit]]
end

function ATT:QueueInspect(guid)
    if guid then
        for i = 1, #inspect_queue do
            if inspect_queue[i] == guid then
                return
            end
        end
        insUnitStart[guid] = GetTime()
        inspect_queue[#inspect_queue + 1] = guid
    end
end

function ATT:DequeueInspectByGUID(guid)
    for i = 1, #inspect_queue do
        if inspect_queue[i] == guid then
            table.remove(inspect_queue, i)
        end
    end
end

function ATT:RequeueInspectByGUID(guid)
    for i = 1, #inspect_queue do
        if inspect_queue[i] == guid then
            self.insTimes = 0
            table.remove(inspect_queue, i)
            inspect_queue[#inspect_queue + 1] = guid
        end
    end
end

function ATT:ProcessInspect(unit, guid, specInspect)

    -- Talent Check / Inspect
    if unit and specInspect then
        dbInspect[guid] = {}
        local isInspect = (guid ~= PlayerGUID) and true --here SYNC for other players
        for i = 1, 3 do
            for j = 1, 31 do
                local Name, _, _, _, rank = GetTalentInfo(i, j, isInspect, unit)
                if rank and Name then dbInspect[guid][Name] = rank end
            end
        end
        for k = 13, 14 do
            local itemLink = GetInventoryItemLink(unit, k)
            local itemID = itemLink and GetItemInfoInstant(itemLink)
            if itemID then
                if ATTdbs.dbTrinketsMerge[itemID] then itemID = ATTdbs.dbTrinketsMerge[itemID] end --trinket merge?
                dbInspect[guid][itemID] = 1
            end
        end
        dbInspect[guid]["isInspected"] = true
    end

    self:UpdateIcons()
    if syncChache[guid] then
        local anchor = self:GetAnchorByUnit(unit)
        local syncSpells = syncChache[guid]
        if next(syncSpells) and anchor then
            for k, icon in pairs(anchor.icons) do
                if syncSpells[icon.abilityID] then
                self:ProcessSync(anchor, icon.abilityID, syncSpells[icon.abilityID], unit)
                end
            end
        end
        syncChache[guid] = nil
    end
end

function ATT:InspectPlayer()
    local _, instanceType = IsInInstance()
    ATT.inRaid =  (IsInRaid() and type ~= "arena")
    ATT.isBgMode = db.bgMode and (instanceType == "pvp")

    local unit = self:GetUnitByGUID(PlayerGUID)
    self:ProcessInspect(unit, PlayerGUID, 1)
end

function ATT:InspectIsReady(guid, unit)
    self:DequeueInspectByGUID(guid)
    if guid and guid ~= PlayerGUID then
        self:ProcessInspect(unit, guid, 1)
    end
end

function ATT:EnqueueInspect(isUpdate)
    local groupSize = GetNumGroupMembers() < db.raidGroupSize and GetNumGroupMembers() or db.raidGroupSize

    for i = 1, ((ATT.inRaid and groupSize) or 4) do --inRaidGr
        local unit = (ATT.inRaid and "raid" .. i) or ("party" .. i)
        local guid = UnitGUID(unit)
        if guid and guid ~= PlayerGUID then
            if isUpdate then
                if not dbInspect[guid] or (dbInspect[guid] and not dbInspect[guid]["spec"]) then
                    self:QueueInspect(guid)
                end -- here
            else
                self:QueueInspect(guid)
            end
        end
    end
    if #inspect_queue > 0 and not ATTInspectFrame:IsShown() then
        self.lastIns = nil
        ATTInspectFrame:Show();
    end
end

function ATT:ProcessInspectQueue()
    for i, guid in pairs(inspect_queue) do
        local unit = self:GetUnitByGUID(guid)
        if (unit and (not UnitIsConnected(unit) or (insUnitStart[guid] and insUnitStart[guid] + 120 < GetTime()))) or not unit then --here
            self:DequeueInspectByGUID(guid)
        end

        if unit and self.lastIns and self.lastIns == guid and (insUnitStart[guid] and insUnitStart[guid] + 2 < GetTime()) then
            elapsedTime = -1
            self.lastIns = nil
            self.insTimes = self.insTimes and (self.insTimes + 1) or 1
            if self.insTimes > 5 then self:RequeueInspectByGUID(guid) end
            break
        end

        if unit and not (InspectFrame and InspectFrame:IsShown()) and CheckInteractDistance(unit, 1) and UnitIsConnected(unit) and CanInspect(unit) then
            self.lastIns = guid
            NotifyInspect(unit)
            break
        end
    end
end

local function InspectTimer(self, elapsed)
    elapsedTime = elapsedTime + elapsed

    if elapsedTime and elapsedTime > 0.5 then
        elapsedTime = 0
        ATT:ProcessInspectQueue()
        if #inspect_queue == 0 then ATTInspectFrame:Hide() end
    end
end

function ATT:INSPECT_READY(guid)
    if (InspectFrame and InspectFrame:IsShown()) then
        return
    end
    local unit = self:GetUnitByGUID(guid)
    local itemLink = unit and GetInventoryItemLink(unit, 16); --insFix
    local itemID = itemLink and GetItemInfoInstant(itemLink)

    if guid and unit and self.lastIns == guid and itemID then
        self:InspectIsReady(guid, unit)
        self.insTimes = 0
    end
end

function ATT:SavePositions()
    for k, anchor in ipairs(anchors) do
        local scale = anchor:GetEffectiveScale()
        local worldscale = UIParent:GetEffectiveScale()
        local x = anchor:GetLeft() * scale
        local y = (anchor:GetTop() * scale) - (UIParent:GetTop() * worldscale)
        if not db.positions[k] then
            db.positions[k] = {}
        end
        db.positions[k].x = x
        db.positions[k].y = y
    end
end

function ATT:CheckBlizzFrames()
    local compact = C_CVar.GetCVarBool("useCompactPartyFrames")
    local UseCombinedGroups = CompactRaidFrameManager_GetSetting and CompactRaidFrameManager_GetSetting("KeepGroupsTogether")
    local frametype = nil

    if ATT.inRaid then
        if compact and _G["CompactPartyFrameMember1"] and _G["CompactPartyFrameMember1"]:IsVisible() then
            frametype = "CompactPartyFrameMember%d"
        else
            if not UseCombinedGroups then
                frametype = "CompactRaidFrame%d"
            else
                frametype = "CompactRaidGroup1RGMember%d"
            end
        end
    else
        if compact then
            if _G["CompactPartyFrameMember1"] and _G["CompactPartyFrameMember1"]:IsVisible() then
                frametype = "CompactPartyFrameMember%d"
            else
                if not UseCombinedGroups then
                    frametype = "CompactRaidFrame%d"
                else
                    frametype = "CompactRaidGroup1RGMember%d"
                end
            end
        else
            frametype = "PartyMemberFrame%d"
        end
    end

    return frametype
end

function ATT:FindFrames()
    hookedFrames = {}
    local frametype = nil
    local cunit = nil

    if db.attach == 1 and ATT_DropDown1.values[7] then
        frametype = customframes[ATT_DropDown1.values[7]].cframe
        cunit = customframes[ATT_DropDown1.values[7]].cunitid
    else
        if db.attach == 1 or db.attach == 2 then
            frametype = self:CheckBlizzFrames()
        elseif db.attach and db.attach > 2 and customframes[db.attach] then
            frametype = customframes[db.attach].cframe
            cunit = customframes[db.attach].cunitid
        end
    end

    if not frametype then
        return
    end

    local isGrouped = string.find(frametype, "1RG")
    if isGrouped then
        for k = 1, 8 do
            local framename = string.gsub(frametype, "1RG", k)
            for i = 1, 5 do
                local name = format(framename, i)
                local frame = _G[name]
                local unit = frame and (cunit and frame[cunit] or frame['unit'])
                local guid = unit and UnitGUID(unit)
                if guid and not frame:IsForbidden() and frame:IsShown() then
                    hookedFrames[guid] = frame
                end
            end
        end
    else
        if frametype == "CompactPartyFrameMember%d" then
            for i = 1, 5 do
                local name = "CompactPartyFrameMember" .. i
                local frame = _G[name]
                local unit = frame and (cunit and frame[cunit] or frame['unit'])
                local guid = unit and UnitGUID(unit)
                if guid and not frame:IsForbidden() and frame:IsShown() then
                    hookedFrames[guid] = frame
                end
            end
        elseif frametype == "PartyMemberFrame%d" then
            if PlayerGUID and _G["PlayerFrame"] and _G["PlayerFrame"]:IsShown() then hookedFrames[PlayerGUID] = _G["PlayerFrame"] end
            for i = 1, 4 do
                local name = "PartyMemberFrame" .. i
                local frame = _G[name]
                local unit = frame and (cunit and frame[cunit] or frame['unit'])
                local guid = unit and UnitGUID(unit)
                if guid and not frame:IsForbidden() and frame:IsShown() then
                    hookedFrames[guid] = frame
                end
            end
        else
            for i = 1, 40 do
                local name = format(frametype, i)
                local frame = _G[name]
                local unit = frame and (cunit and frame[cunit] or frame['unit'])
                local guid = unit and UnitGUID(unit)
                if guid and not frame:IsForbidden() and frame:IsShown() then
                    hookedFrames[guid] = frame
                end
            end
        end
    end
    if PlayerGUID and _G["PlayerFrame"] and (not hookedFrames[PlayerGUID] or (hookedFrames[PlayerGUID] and not hookedFrames[PlayerGUID]:IsVisible() and GetNumGroupMembers() == 0)) then
        hookedFrames[PlayerGUID] = _G["PlayerFrame"]
    end

    --print(frametype)
end

function ATT:UpdatePositions()
    db.positions = db.positions or {}
    self:FindFrames()

    for k, anchor in ipairs(anchors) do
        anchors[k]:ClearAllPoints()
        local unit = (ATT.inRaid and "raid" .. k) or ((k == 5 and "player") or (k ~= 5 and "party" .. k))
        local anchorGuid = unit and UnitGUID(unit)
        local raidFrame =  hookedFrames[anchorGuid]

        if anchor.GUID == PlayerGUID and db.selfAttach then raidFrame = nil end

        if raidFrame and db.attach and db.attach ~= 0 then
            if not db.attachPos or db.attachPos == 0  then
                  anchors[k]:SetPoint("BOTTOMLEFT", raidFrame, "TOPLEFT", db.offsetX, db.offsetY) --anchorTOPLEFT
            elseif db.attachPos == 1 then
                  anchors[k]:SetPoint("BOTTOMRIGHT", raidFrame, "TOPRIGHT", db.offsetX, db.offsetY) --anchorTOPRIGHT
            elseif db.attachPos == 2 then
                  anchors[k]:SetPoint("TOPLEFT", raidFrame, "BOTTOMLEFT", db.offsetX, db.offsetY) --anchorBOTTOMLEFT
            elseif db.attachPos == 3 then
                    anchors[k]:SetPoint("TOPRIGHT", raidFrame, "BOTTOMRIGHT", db.offsetX, db.offsetY) --anchorBOTTOMRIGHT
            elseif db.attachPos == 4 then
               anchors[k]:SetPoint("CENTER", raidFrame, "LEFT", db.offsetX, db.offsetY) --anchorCENTERLEFT
            elseif db.attachPos == 5 then
               anchors[k]:SetPoint("CENTER", raidFrame, "RIGHT", db.offsetX, db.offsetY) --anchorCENTERRIGHT
            else
                anchors[k]:SetPoint("BOTTOMLEFT", raidFrame, "TOPLEFT", db.offsetX, db.offsetY) --anchorTOPLEFT
        end

        else
            if db.positions[k] then
                local x = db.positions[k].x
                local y = db.positions[k].y
                local scale = anchors[k]:GetEffectiveScale()
                anchors[k]:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x / scale, y / scale)
            else
                anchors[k]:SetPoint("CENTER", UIParent, "CENTER")
            end
        end
    end
end

function ATT:CreateAnchors()
    for i = 1, 40 do
        local anchor = CreateFrame("Frame", "ATTAnchor" .. i, ATTAnchor, BackdropTemplateMixin and "BackdropTemplate, TooltipBackdropTemplate") --GlowBoxTemplate
        local index = anchor:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
        anchor:SetHeight(22)
        anchor:SetWidth(24)
        anchor:EnableMouse(true)
        anchor:SetMovable(true)
        --anchor:Show()
        anchor.icons = {}
        anchor.freeProcs = {}
        anchor.StopAllIcons = function(flag)
            for k, icon in ipairs(anchor.icons) do
                if flag ~= "raidstop" or (flag == "raidstop" and icon.cooldown and icon.cooldown >= 120) then
                    icon.Stop();
                    icon.seen = nil
                end
            end
        end
        anchor.StopAllGlow = function(flag)
            for k, icon in ipairs(anchor.icons) do
                LGlows.HideOverlayGlow2(icon)
            end
        end
        anchor:SetScript("OnMouseDown",
            function(self, button)
                if button == "LeftButton" and db.attach == 0 or (anchor.GUID == PlayerGUID and db.selfAttach) then
                    self:StartMoving();
                end
            end)
        anchor:SetScript("OnMouseUp",
            function(self, button)
                if button == "LeftButton" and db.attach == 0 or (anchor.GUID == PlayerGUID and db.selfAttach) then
                    self:StopMovingOrSizing();
                    ATT:SavePositions()
                end
            end)

        anchor:Hide()
        anchors[i] = anchor
        index:SetPoint("CENTER")
        index:SetText(i)
    end
end

local function CreateIcon(anchor)
    local icon = CreateFrame("Frame", anchor:GetName() .. "Icon" .. (#anchor.icons + 1), ATTIcons, "ATTButtonTemplate")
    icon:SetSize(40, 40)
    icon:SetAlpha(db.iconAlpha or 1)

    local cd = CreateFrame("Cooldown", icon:GetName() .. "Cooldown", icon, "CooldownFrameTemplate")
    cd:SetHideCountdownNumbers(false)
    icon.cd = cd

    icon.Start = function(sentCD, nextcharge, rate)
       -- if activeBUFFS[guid] and activeBUFFS[guid][icon.abilityID] then return end
       if activeBUFFS[icon.GUID] and activeBUFFS[icon.GUID][icon.abilityID] then return end --freeprocs
       local cTime = GetTime()
        if icon.raterecovery and not icon.excluded then
            rate = icon.raterecovery
            cTime = cTime * (1 - rate) + cTime * rate
            sentCD = sentCD * rate
            icon.cdrecovery = sentCD
        end
        icon.texture:SetVertexColor(1, 1, 1)

        local chargesText = icon.chargesText:GetText() and icon.chargesText:GetText():match("^[0-9]+$")
        local charges = chargesText and tonumber(chargesText)
        if icon.maxcharges and charges then
            if charges == icon.maxcharges or nextcharge == icon.maxcharges then
                CooldownFrame_Set(cd, cTime, sentCD, true, true, rate)
                cd:SetHideCountdownNumbers(true)
                cd:SetDrawSwipe(false)
                icon.starttime = cTime
                charges = charges - 1
                icon.chargesText:SetText(charges)
            elseif charges < icon.maxcharges and nextcharge == 5 then
                CooldownFrame_Set(cd, cTime, sentCD, true, true, rate)
                cd:SetHideCountdownNumbers(true)
                cd:SetDrawSwipe(false)
                icon.starttime = cTime
                icon.chargesText:SetText(charges)
            elseif charges > 1 and nextcharge == 1 and icon.starttime < cTime and charges < icon.maxcharges then
                if not icon.glowDuration then
                    cd:SetHideCountdownNumbers(false)
                end
                charges = charges - 1
                icon.chargesText:SetText(charges)
            elseif charges == 1 and nextcharge == 1 and icon.starttime < cTime then
                if not icon.glowDuration then
                    cd:SetHideCountdownNumbers(false)
                end
                cd:SetDrawEdge(true)
                cd:SetDrawSwipe(true)
                charges = charges - 1
                icon.chargesText:SetText(charges)
            end
        else
            CooldownFrame_Set(cd, cTime, sentCD, true, false, rate)
            icon.starttime = cTime
        end

        icon:Show()
        icon.active = true;
        icon.flashAnim:Play()

        activeGUIDS[icon.GUID] = activeGUIDS[icon.GUID] or {}
        activeGUIDS[icon.GUID][icon.abilityID] = activeGUIDS[icon.GUID][icon.abilityID] or {}
        activeGUIDS[icon.GUID][icon.abilityID].chargeleft = charges
        activeGUIDS[icon.GUID][icon.abilityID].starttime = icon.starttime
        activeGUIDS[icon.GUID][icon.abilityID].cooldown = sentCD
        if db.hidden then ATT:ToggleDisplay(anchor, icon.GUID) end
        if icon.ability and icon.abilityID and anchor.spec and nextcharge ~= 5 then
            if db.alertCD[anchor.spec][icon.abilityID] then PlaySound(8959, "Master"); end
            if db.alertCDtext[anchor.spec][icon.abilityID] then
                local playername = select(6, GetPlayerInfoByGUID(icon.GUID))
                if playername then
                    UIErrorsFrame:AddMessage("|T" .. icon.texture:GetTexture() ..":18|t |cffFF4500" .. icon.ability .. "|r  - used by ->>  |cffFF4500" .. playername .. "|r");
                end
            end
        end
    end

    icon.Stop = function()
        if icon.glowDuration then
            LGlows.HideOverlayGlow2(icon)
        end
        CooldownFrame_Set(cd, 0, 0, 0);
        icon.starttime = 0

        if icon.inUse then
            activeGUIDS[icon.GUID] = activeGUIDS[icon.GUID] or {}
            activeGUIDS[icon.GUID][icon.abilityID] = activeGUIDS[icon.GUID][icon.abilityID] or {}
            activeGUIDS[icon.GUID][icon.abilityID].starttime = icon.starttime
            activeGUIDS[icon.GUID][icon.abilityID].cooldown = icon.cooldown
        end
        if db.hidden then ATT:ToggleDisplay(anchor, icon.GUID) end
    end

    icon.SetTimer = function(starttime, cooldown, rate, isRate, charges)
       if activeBUFFS[icon.GUID] and activeBUFFS[icon.GUID][icon.abilityID] then return end --freeprocs
        if icon.raterecovery and icon.inUse and not isRate then
            rate = icon.raterecovery
            starttime = icon.starttime - ((icon.starttime - starttime) * rate)
            cooldown = cooldown * rate
        end

        if icon.inUse then
            icon.texture:SetVertexColor(1, 1, 1)
            CooldownFrame_Set(cd, starttime, cooldown, true, false, rate)
            icon.active = true
            icon.starttime = starttime

            activeGUIDS[icon.GUID] = activeGUIDS[icon.GUID] or {}
            activeGUIDS[icon.GUID][icon.abilityID] = activeGUIDS[icon.GUID][icon.abilityID] or {}
            activeGUIDS[icon.GUID][icon.abilityID].starttime = icon.starttime
            activeGUIDS[icon.GUID][icon.abilityID].cooldown = cooldown

        if icon.maxcharges and charges then
            icon.chargesText:SetText(charges)
            cd:SetDrawEdge(true)
            if charges and charges == 0 then
                cd:SetDrawSwipe(true)
                cd:SetHideCountdownNumbers(false)
            else
                cd:SetHideCountdownNumbers(true)
                cd:SetDrawSwipe(false)
            end
            activeGUIDS[icon.GUID][icon.abilityID].chargeleft = charges
        end

            if db.hidden then ATT:ToggleDisplay(anchor, icon.GUID) end
        end
    end

    icon.SetOldTimer = function(starttime, cooldown, rate, isRate, charges)
        if icon.raterecovery or not icon.inUse then
            return
        end
        icon.texture:SetVertexColor(1, 1, 1)
        CooldownFrame_Set(cd, starttime, cooldown, true, false, rate)
        
        if icon.maxcharges and charges then
            icon.chargesText:SetText(charges)
            cd:SetDrawEdge(true)
            if charges and charges == 0 then
                cd:SetDrawSwipe(true)
                cd:SetHideCountdownNumbers(false)
            else
                cd:SetHideCountdownNumbers(true)
                cd:SetDrawSwipe(false)
            end
            activeGUIDS[icon.GUID][icon.abilityID].chargeleft = charges
        end
        icon.active = true
        icon.starttime = starttime
    end

    local texture = icon:CreateTexture(nil, "ARTWORK")
    texture:SetAllPoints(true)
    icon.texture = texture

    ATT:ApplyIconTextureBorder(icon)

    icon.chargesText = icon:CreateFontString(nil, nil, "DialogButtonHighlightText")
    icon.chargesText:SetTextColor(1, 1, 1)
    icon.chargesText:SetText("")
    icon.chargesText:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT")

    -- tooltip:
    if not db.showTooltip then
        icon:EnableMouse(false)
    end

    icon:SetScript('OnEnter', function()
        if db.showTooltip and icon.abilityID then
            local tooltip = Spell:CreateFromSpellID(icon.abilityID)
            tooltip:ContinueOnSpellLoad(function()
                GameTooltip:ClearLines();
                GameTooltip:SetOwner(WorldFrame, "ANCHOR_CURSOR")
                GameTooltip:SetSpellByID(icon.abilityID)
                GameTooltip:AddLine("Spell ID: " .. icon.abilityID .. " - iCD: " .. icon.cooldown .. " sec", 1, 1, 1)
                GameTooltip:SetPadding(16, 0)
                -- GameTooltip:SetAlpha(db.iconAlpha or 1)
                GameTooltip:Show()
            end)
            icon:EnableMouse(true)
        end
    end)

    icon:SetScript('OnLeave', function()
        if db.showTooltip and icon.abilityID then
            GameTooltip:ClearLines()
            GameTooltip:Hide()
            icon:EnableMouse(true)
        end
    end)

    icon.cd:SetScript("OnCooldownDone", function()
        if icon.active and icon.cooldown then
            if activeGUIDS[icon.GUID] and activeGUIDS[icon.GUID][icon.abilityID] then
                activeGUIDS[icon.GUID][icon.abilityID] = nil
            end
            icon.active = nil
        end
        local chargesText = icon.chargesText:GetText() and icon.chargesText:GetText():match("^[0-9]+$")
        local charges = chargesText and tonumber(chargesText)

        if icon.maxcharges and charges and icon.inUse then
            local newCharges = math.min(icon.maxcharges, charges + 1) --update
            icon.chargesText:SetText(newCharges or icon.maxcharges)
            if newCharges and (newCharges < icon.maxcharges) then
                icon.Start(icon.cooldown, 5)
            end
        end

        if db.hidden then
            ATT:ToggleDisplay(anchor, icon.GUID)
        end
        if icon.glowDuration then
            LGlows.HideOverlayGlow2(icon)
        end
    end)

    local Masque, MSQ_Version = LibStub("Masque", true)
    if Masque and MSQ_Version then
        icon.MasqueGroup = Masque:Group("Ability Team Tracker")
        icon.MasqueGroup:AddButton(icon, {
            FloatingBG = false,
            Icon = icon.texture,
            Cooldown = icon.cd,
        })
    end

    return icon
end

-- adds a new icon
function ATT:AddIcon(icons, anchor)
    local newicon = CreateIcon(anchor)
    icons[#icons + 1] = newicon
    return newicon
end

function ATT:ApplyIconTextureBorder(icon)
    icon.texture:SetVertexColor(1, 1, 1)
    if db.showIconBorders then
        icon.texture:SetTexCoord(0, 1, 0, 1)
    else
        icon.texture:SetTexCoord(0.07, 0.9, 0.07, 0.90)
    end
end

function ATT:UpdateAnchorGUID(anchor, unit, guid)
    local _, class = UnitClass(unit)
    anchor.GUID = guid
    anchor.class = class
    local icons = anchor.icons
    local numIcons = 1
    local _, _, raceID = UnitRace(unit)
    local dbInspected = dbInspect[guid]

    --dbInspected and dbInspect[guid]["isInspected"] and -- inspect doesnt work for party in vanilla
    if class and dbImport[class] and type(db.isEnabledSpell[class] == "table") and dbInspected then
        -- Trinkets
        for abilityIndex, abilityTable in pairs(self:MergeTable(class, "trinkets")) do
            local name, id, trinketId, cooldown, texture = abilityTable.name, abilityTable.ability,
                abilityTable.trinketId, abilityTable.cooldown, abilityTable.texture

            if name and id and trinketId and db.isEnabledSpell[class][trinketId] and dbInspected[trinketId] then
                local icon = icons[numIcons] or self:AddIcon(icons, anchor)
                icon.texture:SetTexture(texture or self:FindAbilityIcon(name, id))
                icon.GUID = anchor.GUID
                icon.ability = name
                icon.abilityID = id
                icon.cooldown = cooldown
                icon.maxcharges = nil
                icon.chargesText:SetText()
                icon.inUse = true
                icon.excluded = true
                icon.race = nil

                ATT:ApplyIconTextureBorder(icon)
                activeGUIDS[icon.GUID] = activeGUIDS[icon.GUID] or {}
                if activeGUIDS[icon.GUID][id] then
                    icon.SetOldTimer(activeGUIDS[icon.GUID][id].starttime, activeGUIDS[icon.GUID][id].cooldown, nil , nil, activeGUIDS[icon.GUID][id].chargeleft )
                else
                    icon.Stop()
                end
                numIcons = numIcons + 1
            end
        end

        -- Racials
        for abilityIndex, abilityTable in pairs(self:MergeTable(class, "racials")) do
            local name, id, cooldown, maxcharges, race, cdshare, texture = abilityTable.name, abilityTable.ability,
                abilityTable.cooldown, abilityTable.maxcharges, abilityTable.race, abilityTable.cdshare,
                abilityTable.texture

            if name and id and db.isEnabledSpell[class][id] and raceID == race then
                local icon = icons[numIcons] or self:AddIcon(icons, anchor)
                icon.texture:SetTexture(texture or self:FindAbilityIcon(name, id))
                icon.GUID = anchor.GUID
                icon.ability = name
                icon.abilityID = id
                icon.cooldown = cooldown
                icon.maxcharges = nil
                icon.chargesText:SetText()
                icon.inUse = true
                icon.race = raceID
                icon.excluded = true
                icon.racecdshare = cdshare

                ATT:ApplyIconTextureBorder(icon)
                activeGUIDS[icon.GUID] = activeGUIDS[icon.GUID] or {}
                if activeGUIDS[icon.GUID][id] then
                    icon.SetOldTimer(activeGUIDS[icon.GUID][id].starttime, activeGUIDS[icon.GUID][id].cooldown, nil , nil, activeGUIDS[icon.GUID][id].chargeleft )
                else
                    icon.Stop()
                end
                numIcons = numIcons + 1
            end
        end

        -- Abilities:
        if not ATT.isBgMode then
            for abilityIndex, abilityTable in pairs(self:MergeTable(class, "abilities", true)) do
                local name, id, cooldown, charges, custom, spellrace, texture = abilityTable.name, abilityTable.ability,abilityTable.cooldown, abilityTable.charges, abilityTable.custom, abilityTable.race, abilityTable.texture
                local modif = dbModif[id]

                if name and spellrace and (raceID ~= spellrace[1] and raceID ~= spellrace[2] and raceID ~= spellrace[3]) then name = nil end
                if name and (custom and not db.isEnabledSpell[class][id .. "custom"]) or (not custom and not db.isEnabledSpell[class][id]) or dbInspected[name] == 0 then name = nil end

                if name and modif and dbInspected[modif.mod] and dbInspected[modif.mod] > 0 then
                    local newcd = dbInspected[modif.mod]
                    local cd = cooldown
                    cooldown = cooldown - (modif.rank[newcd] or modif.rank[1])
                end

                if name and id then
                    local icon = icons[numIcons] or self:AddIcon(icons, anchor)
                    icon.texture:SetTexture(texture or self:FindAbilityIcon(name, id))
                    icon.GUID = anchor.GUID
                    icon.ability = name
                    icon.abilityID = id
                    icon.cooldown = cooldown
                    icon.maxcharges = nil
                    icon.chargesText:SetText()
                    icon.inUse = true
                    icon.race = nil

                    ATT:ApplyIconTextureBorder(icon)
                    activeGUIDS[icon.GUID] = activeGUIDS[icon.GUID] or {}
                    if activeGUIDS[icon.GUID][id] then
                        icon.SetOldTimer(activeGUIDS[icon.GUID][id].starttime, activeGUIDS[icon.GUID][id].cooldown, nil , nil, activeGUIDS[icon.GUID][id].chargeleft )
                    else
                        icon.Stop()
                    end
                    numIcons = numIcons + 1
                end
            end
        end
    end

    -- clean leftover icons
    for j = numIcons, #icons do
        icons[j].ability = nil
        icons[j].abilityID = nil
        icons[j].spec = nil
        icons[j].seen = nil
        icons[j].active = nil
        icons[j].inUse = nil
        icons[j].showing = nil
    end

    self:ToggleDisplay(anchor, guid)
end

function ATT:ToggleDisplay(anchor, unitGuid, isUpdate)
    local icons = anchor.icons
    local lastActiveIndex = 0
    local oldActiveIndex = 0
    local count = 0
    -- if isUpdate then anchor.SyncCDs = {} end

    for k, icon in pairs(icons) do
        -- if isUpdate and icon.inUse and icon.abilityID then table.insert(anchor.SyncCDs, icon.abilityID) end
        if icon.active and icon.cooldown then
            icon.timeleft = icon.starttime + icon.cooldown - GetTime()
            if icon.timeleft <= 0 or not icon.timeleft then
                if activeGUIDS[icon.GUID] and activeGUIDS[icon.GUID][icon.abilityID] then
                    activeGUIDS[icon.GUID][icon.abilityID] = nil
                end
                icon.active = nil
            end
        end
        ATT:ApplyIconTextureBorder(icon)
        if db.showTooltip then
            icon:EnableMouse(true)
        else
            icon:EnableMouse(false)
        end -- click-through
        if icon and icon.abilityID and icon.inUse and unitGuid and unitGuid == anchor.GUID and icon.GUID == unitGuid then
            icon.showing = (activeGUIDS[icon.GUID] and activeGUIDS[icon.GUID][icon.abilityID] and icon.active) or
                (not db.hidden)
        end
        icon:ClearAllPoints()
        icon:Hide()
    end

    local attachPos = (db.attachPos or 0) % 2 == 0
    for k, icon in pairs(icons) do
        if icon and icon.abilityID and icon.showing and icon.inUse and unitGuid and unitGuid == anchor.GUID and
            icon.GUID == unitGuid then
            if db.reverseIcons then
                if db.IconRows > 1 then
                    if lastActiveIndex == 0 then
                         icon:SetPoint(attachPos and "TOPLEFT" or "TOPRIGHT", anchor, attachPos and "BOTTOMRIGHT" or "BOTTOMLEFT")
                    elseif (count >= db.IconRows and count % db.IconRows == 0) then
                        icon:SetPoint(attachPos and "LEFT" or "RIGHT", icons[oldActiveIndex],attachPos and "RIGHT" or "LEFT", attachPos and 1 * db.iconOffsetY or -1 * db.iconOffsetY, 0)
                    else
                        if db.growUP then
                            icon:SetPoint(attachPos and "BOTTOM" or "BOTTOM", icons[lastActiveIndex],attachPos and "TOP" or "TOP", 0, 1 * db.iconOffsetX)
                        else
                            icon:SetPoint(attachPos and "TOP" or "TOP", icons[lastActiveIndex], attachPos and "BOTTOM" or "BOTTOM", 0, -1 * db.iconOffsetX)

                        end
                    end
                else
                    if lastActiveIndex == 0 then
                        icon:SetPoint(attachPos and "TOPLEFT" or "TOPRIGHT", anchor, attachPos and "BOTTOMRIGHT" or "BOTTOMLEFT", attachPos and 1 * db.iconOffsetY or -1 * db.iconOffsetY, 0)
                    else
                        icon:SetPoint(attachPos and "LEFT" or "RIGHT", icons[lastActiveIndex],attachPos and "RIGHT" or "LEFT", attachPos and 1 * db.iconOffsetY or -1 * db.iconOffsetY, 0)
                    end
                end
            else
                if db.IconRows > 1 then
                    if lastActiveIndex == 0 then
                       icon:SetPoint(attachPos and "TOPRIGHT" or "TOPLEFT", anchor,attachPos and "BOTTOMLEFT" or "BOTTOMRIGHT")
                    elseif (count >= db.IconRows and count % db.IconRows == 0) then
                        icon:SetPoint(attachPos and "RIGHT" or "LEFT", icons[oldActiveIndex],attachPos and "LEFT" or "RIGHT", attachPos and -1 * db.iconOffsetY or db.iconOffsetY, 0)
                    else
                        if db.growUP then
                            icon:SetPoint(attachPos and "BOTTOM" or "BOTTOM", icons[lastActiveIndex],attachPos and "TOP" or "TOP", 0, 1 * db.iconOffsetX)
                        else
                             icon:SetPoint(attachPos and "TOP" or "TOP", icons[lastActiveIndex],attachPos and "BOTTOM" or "BOTTOM", 0, -1 * db.iconOffsetX)
                        end
                    end
                else
                    if lastActiveIndex == 0 then
                            icon:SetPoint(attachPos and "TOPRIGHT" or "TOPLEFT", anchor,attachPos and "BOTTOMLEFT" or "BOTTOMRIGHT", attachPos and -1 * db.iconOffsetY or db.iconOffsetY, 0)
                    else
                        icon:SetPoint(attachPos and "RIGHT" or "LEFT", icons[lastActiveIndex],attachPos and "LEFT" or "RIGHT", attachPos and -1 * db.iconOffsetY or db.iconOffsetY, 0)
                    end
                end
            end

            lastActiveIndex = k
            if (count == 0 or (count >= db.IconRows and count % db.IconRows == 0)) then
                oldActiveIndex = count == 0 and k or lastActiveIndex
            end
            count = count + 1
            icon:Show()
        end
    end
end

function ATT:UpdateIcons()
    local groupSize = GetNumGroupMembers() < db.raidGroupSize and GetNumGroupMembers() or db.raidGroupSize

    for k, anchor in ipairs(anchors) do
        local unit = (ATT.inRaid and "raid" .. k) or ((k == 5 and "player") or (k ~= 5 and "party" .. k))
        local guid = unit and UnitGUID(unit)

        if db.lock or not guid then anchor:Hide() else anchor:Show() end
        if guid and guid == PlayerGUID and (not db.showSelf or (ATT.inRaid and db.raidGroupSize == 0 and db.selfHideInRaid)) then
            anchor:Hide()
            anchor.GUID = nil
            anchor.spec = nil
            guid = nil
        end
        if guid and guid ~= PlayerGUID and ATT.inRaid and (groupSize < k) then
            anchor:Hide()
            anchor.GUID = nil
            anchor.spec = nil
            guid = nil
        end
        if not guid then
            anchor:Hide()
           -- if anchor.GUID then activeBUFFS[anchor.GUID] = {} ; activeAURAS[anchor.GUID] = {} end
            anchor.GUID = nil
            anchor.spec = nil
            guid = nil
        end

        self:UpdateAnchorGUID(anchor, unit, guid)
    end
end

function ATT:ApplyAnchorSettings()
    local _, type = IsInInstance()
    ATT.inRaid =  (IsInRaid() and type ~= "arena")
    ATT.isBgMode = db.bgMode and (type == "pvp")
    ATTIcons:SetScale(db.scale or 1)

    if (db.isEnabledVisibility.arena and type == "arena") or
        (db.isEnabledVisibility.dungeons and type == "party") or
        (db.isEnabledVisibility.scenarios and type == "scenario") or
        (db.isEnabledVisibility.inraid and type == "raid") or
        (db.isEnabledVisibility.inbg and type == "pvp") or
        (db.isEnabledVisibility.outside and type == "none") then
        ATTIcons:Show();
        self:Show();
    else
        ATTIcons:Hide();
        self:Hide();
    end

    if not db.lock and ATTIcons:IsShown() then
        ATTAnchor:Show()
    else
        ATTAnchor:Hide()
    end

    self:UpdatePositions();
    self:UpdateIcons();
end

function ATT:UNIT_AURA(unit)
    if not ATTIcons:IsShown() then return end
    local anchor = self:GetAnchorByUnit(unit)
    if not anchor then return end
    -- Feign Death workaround fix
    local guid = UnitGUID(unit)
    local fd = select(1, AuraUtil.FindAuraByName(GetSpellInfo(5384), unit))
    if not fd and isFWW["fd" .. guid] == guid then
        C_Timer.After(0.12,
            function()
                self:StartCooldown(GetSpellInfo(5384), unit, 5384);
                isFWW["fd" .. guid] = nil;
            end)
    end
end

function ATT:PLAYER_ENTERING_WORLD()
    self:CheckProfile()
    C_Timer.After(1, function()
        local _, instanceType = IsInInstance()
        self:InspectPlayer()
        self:StopAllGlow()
        self:UpdateGroup()
        if instanceType == "arena" then
            self:StopAllIcons();
        end
        self:SendUpdate()
    end)
end

function ATT:GROUP_ROSTER_UPDATE()
    if (not ATTIcons:IsShown()) then
        return
    end
    self:ApplyAnchorSettings()
    self:EnqueueInspect(true)

    C_Timer.After(0.05, function()
        self:ApplyAnchorSettings()
        self:EnqueueInspect(true)
    end)
end

function ATT:UpdateGroup()
    self:ApplyAnchorSettings();
    self:EnqueueInspect()
end

function ATT:GROUP_JOINED()
    self:ApplyAnchorSettings()
    self:EnqueueInspect()
    local _, instanceType = IsInInstance()
    if instanceType == "arena" then
        self:StopAllIcons();
    end
end

function ATT:FindAbilityByName(abilities, name)
    if abilities then
        for i, v in pairs(abilities) do
            if v and v.ability and v.ability == name then return v, i end
        end
    end
end

function ATT:StartCooldown(spellName, unit, SentID, flag)
    if not unit then return end
    local anchor = self:GetAnchorByUnit(unit)
    local guid = anchor.GUID

    if not anchor or not guid then return end
    self:TrackCooldown(anchor, spellName, SentID, unit, guid, flag)
end

function ATT:TrackCooldown(anchor, ability, SentID, unit, guid, flag)
    local rate = nil
    for k, icon in ipairs(anchor.icons) do
        if icon.cooldown and icon.inUse then
            -- Direct cooldown
            if icon.ability and icon.ability == ability then --here
                if flag then
                    icon.cd:Clear()
                    icon.texture:SetVertexColor(0.4, 0.4, 0.4)
                    break
                end
                icon.seen = true
                icon.Start(icon.cooldown, 1, rate)
            end
        end
        -- Cooldown Share
        if ShareCD[ability] and ShareCD[ability][icon.abilityID] and icon.inUse then icon.Start(icon.cooldown, 1, rate) end

        -- Cooldown reset
        if cooldownResetters[ability] then
            if type(cooldownResetters[ability]) == "table" and (cooldownResetters[ability][icon.abilityID] or cooldownResetters[ability]["ALL"]) and not icon.excluded and icon.inUse then
                icon.Stop()
            end
        end
    end
end

function ATT:COMBAT_LOG_EVENT_UNFILTERED()
    if not ATTIcons:IsShown() then return end
    local _, event, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, SentID, spellName, _, auraType, _, powerType, _, _, _, crit =
        CombatLogGetCurrentEventInfo()
    local unit = self:GetUnitByGUID(sourceGUID)
    local unitDest = self:GetUnitByGUID(destGUID)

    if unit and (event == "SPELL_CAST_SUCCESS") then
        self:StartCooldown(spellName, unit, SentID, dbAuraRemoved[spellName] and "AuraOn")
    end
    if unit and (event == "SPELL_AURA_APPLIED") and (auraType == "BUFF") then
        if dbAuraApplied[spellName] then self:StartCooldown(spellName, unit, SentID, dbAuraApplied and "AuraOn") end
    end
    if unit and (event == "SPELL_AURA_REMOVED") and (auraType == "BUFF") then
        if dbAuraRemoved[spellName] then self:StartCooldown(spellName, unit, SentID) end
    end

    if db.glow and unit and ((event == "SPELL_AURA_APPLIED") or (event == "SPELL_AURA_REMOVED")) and (auraType == "BUFF") then
        local dest = (unitDest and unitDest) or unit
        C_Timer.After(0.05, function() self:IconGlow(unit, spellName, event, dest, SentID) end)
    end
end

function ATT:IconGlow(unit, spellName, event, unitDest, SentID)
    if not unit then
        return
    end
    local anchor = self:GetAnchorByUnit(unit)
    if not anchor then
        return
    end

    for k, icon in ipairs(anchor.icons) do
        if icon.inUse and event == "SPELL_AURA_APPLIED" and (SentID == icon.abilityID) and not icon.race then --spellName == icon.ability
            local duration = select(5, AuraUtil.FindAuraByName(spellName, unitDest))
            if icon.showing and icon.cooldown and duration and duration > 1 and icon.cooldown > duration then -- here (icon.active or dbAuraRemoved[SentID])
                icon.glowDuration = duration
                icon.cd:SetHideCountdownNumbers(true);
                icon.cd:SetDrawSwipe(false)
                LGlows.ShowOverlayGlow2(icon)
                C_Timer.After(duration + 0.5, function()
                    local isActive = select(5, AuraUtil.FindAuraByName(spellName, unitDest));
                    if not isActive then
                        LGlows.HideOverlayGlow2(icon)
                    end
                end)
            end
        end
        if event == "SPELL_AURA_REMOVED" and SentID == icon.abilityID and icon.glowDuration then
            LGlows.HideOverlayGlow2(icon)
        end
    end
end

function ATT:UNIT_SPELLCAST_SUCCEEDED(unit, _, SentID) ---check anchor
    local anchor = self:GetAnchorByUnit(unit)
    if not anchor then return end
    local guid = UnitGUID(unit)
    if (SentID == 5579 or SentID == 23273 or SentID == 23274 or SentID == 23276 or SentID == 23277) and unit and guid then
        self:StartCooldown(GetSpellInfo(SentID), unit, SentID, dbAuraRemoved[GetSpellInfo(SentID)] and "AuraOn")
    end
    -- Feign Death workaround fix
    if SentID == 5384 and unit and guid then
        self:StartCooldown(GetSpellInfo(5384), unit, 5384, "AuraOn");
        isFWW["fd" .. guid] = guid
    end
end

-- resets all icons
function ATT:StopAllIcons(flag)
    for k, anchor in ipairs(anchors) do
        anchor:StopAllIcons(flag)
    end
    wipe(activeGUIDS)
end

function ATT:StopAllGlow()
    for k, anchor in ipairs(anchors) do
        anchor:StopAllGlow()
    end
end

function ATT:SendUpdate()
    if self.useCrossAddonCommunication and IsInGroup() then
        local joinedString = strjoin(",", "Version", PlayerGUID, ATTversion)
        C_ChatInfo.SendAddonMessage(ChatPrefix, joinedString,
            (IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and "INSTANCE_CHAT") or (IsInRaid(LE_PARTY_CATEGORY_HOME) and "RAID") or "PARTY")
    end
end


function ATT:ProcessSync(anchor, spellId, cooldownInfo, test)
    -- if test then print(spellId) end
     local isReady, normalizedPercent, timeLeft, charges, minValue, maxValue, currentValue = openRaidLib.GetCooldownStatusFromCooldownInfo(cooldownInfo)
     local cTime = GetTime()
     local spellName = GetSpellInfo(spellId)
 
         for k, icon in ipairs(anchor.icons) do
             if (not isReady) and timeLeft and  timeLeft > 0 and icon.inUse and icon.ability == spellName then
                 local start = cTime - icon.cooldown + timeLeft --processing time
                -- print(unitId .. " - " .. unit .. " - " .. spellId .. " - " ..timeLeft)
                icon.SetTimer(start, icon.cooldown, nil, nil, icon.maxcharges and charges)
            elseif isReady and icon.inUse and icon.starttime and icon.active and icon.ability == spellName then
                --and not ATTdbs.dbReplace[icon.abilityID]
                 icon.Stop()
           end
        end
 end
 
 function ATT.OnReceiveCooldownListUpdate(unitId, unitCooldows, allUnitsCooldowns)
    local guid = UnitGUID(unitId)
    local unit = ATT:GetUnitByGUID(guid)
    local anchor = ATT:GetAnchorByUnit(unit)
    if not anchor or not guid or not next(unitCooldows) then return end

    if not dbInspect[guid] then 
        syncChache[guid] = unitCooldows
    end

    for spellId, cooldownInfo in pairs(unitCooldows) do
        ATT:ProcessSync(anchor, spellId, cooldownInfo, unit)
    end
end

function ATT.OnReceiveCooldownUpdate(unitId, spellId, cooldownInfo, unitCooldows, allUnitsCooldowns)
    local guid = UnitGUID(unitId)
    local unit = ATT:GetUnitByGUID(guid)
    local anchor = ATT:GetAnchorByUnit(unit)
    if not anchor or not guid or not cooldownInfo then return end

    if not dbInspect[guid] and syncChache[guid] then
        syncChache[guid][spellId] = cooldownInfo
    end

    ATT:ProcessSync(anchor, spellId, cooldownInfo, unit)
end

 function ATT.OnUnitUpdate(unitId, unitInfo, allUnitsInfo)
    local guid = UnitGUID(unitId)
    local unit = ATT:GetUnitByGUID(guid)
    local anchor = ATT:GetAnchorByUnit(unit)
    if not anchor then return end
    --[[
          local specId = unitInfo.specId
          local specName = unitInfo.specName
          local role = unitInfo.role
          local renown = unitInfo.renown
          local covenantId = unitInfo.covenantId
          local talents = unitInfo.talents
          local pvpTalents = unitInfo.pvpTalents
          local conduits = unitInfo.conduits
          local class = unitInfo.class
          local classId = unitInfo.classId
          local className = unitInfo.className
          local unitName = unitInfo.name 
          local unitNameFull = unitInfo.nameFull
        --]]  
end

 --registering the callback:
 openRaidLib.RegisterCallback(ATT, "CooldownListUpdate", "OnReceiveCooldownListUpdate")
 openRaidLib.RegisterCallback(ATT, "CooldownUpdate", "OnReceiveCooldownUpdate")
 --openRaidLib.RegisterCallback(ATT, "UnitInfoUpdate", "OnUnitUpdate")

function ATT:CHAT_MSG_ADDON(prefix, message, dist, sender)
    if prefix == ChatPrefix and message then
        local msgtype, guid, infos = strmatch(message, "(.-),(.-),(.+)")

        if not msgtype or not guid or not infos then return end

        if msgtype == "Version" then
            if infos and tonumber(infos) and tonumber(infos) > tonumber(ATTversion) and not self.VersionChecked then
                self.VersionChecked = tonumber(infos)
                print("There is a new version of |cff33ff99Ability Team Tracker|r: |cffFF4500v" ..
                infos .. "|r - you are currently using: |cffFF4500v" .. ATTversion .. "|r")
            end
        end
    end
end

function ATT:PLAYER_EQUIPMENT_CHANGED(item)
    if InCombatLockdown() or not db.showSelf then
        return
    end
    if not item then
        return
    end
    self:InspectPlayer()
end

function ATT:CVAR_UPDATE(cvar)
    if cvar == "USE_RAID_STYLE_PARTY_FRAMES" then
        C_Timer.After(0.1, function() self:ApplyAnchorSettings(); end)
    end
end

function ATT:CHAT_MSG_BG_SYSTEM_NEUTRAL(text)
    if not ATTIcons:IsShown() or not text then return end
    local _, instanceType = IsInInstance()
    if (instanceType == "arena" or instanceType == "pvp") and (string.find(text, "!")) then
        self:InspectPlayer()
        self:UpdateGroup()
    end
end

function ATT:CHARACTER_POINTS_CHANGED()
    self:InspectPlayer()
end

function ATT:CheckProfile()
    local _, instanceType = IsInInstance()
    selectedDB.ProfileSelected = selectedDB.ProfileSelected or "DEFAULT"

    if selectedDB.autoselectBG then
        if instanceType == "pvp" and selectedDB.ProfileSelected ~= "BG" then
            selectedDB.lastProfile = selectedDB.ProfileSelected
            selectedDB.ProfileSelected = "BG"
        elseif selectedDB.ProfileSelected == "BG" and selectedDB.lastProfile then
            selectedDB.ProfileSelected = selectedDB.lastProfile
            selectedDB.lastProfile = nil
        end
    end

    db = selectedDB[selectedDB.ProfileSelected]
    db.classSelected = "WARRIOR";
    db.category = "abilities";
    ATT.inRaid =  (IsInRaid() and type ~= "arena")
    ATT.isBgMode = db.bgMode and (instanceType == "pvp")
end

function ATT:LoadProfiles()
    local profiles = { "DEFAULT", "TANK", "HEALER", "DAMAGER", "BG", "Extra1", "Extra2" }
    local oldDB = ATTDB --getting old main profiles
    oldDB.Profiles = nil --remove old profiles

    if ATTDB["isEnabledSpell"] then ATTDB = {} end --cleaning DB
    if ATTCharDB["isEnabledSpell"] then ATTCharDB = {} end --cleaning Char DB

    if ATTDB.profilebychar then selectedDB = ATTCharDB else selectedDB = ATTDB end
    local dbProfiles = {}

    for i = 1, #profiles do
        if not selectedDB[profiles[i]] then
            dbProfiles[profiles[i]] = {}
            for a, b in pairs(profiles[i] == "DEFAULT" and oldDB["isEnabledSpell"] and oldDB or ATTdbs.Defaults) do
                if type(b) ~= "table" then
                    dbProfiles[profiles[i]][a] = b
                else
                    dbProfiles[profiles[i]][a] = {}
                    for c, d in pairs(b) do
                        if type(d) ~= "table" then
                            dbProfiles[profiles[i]][a][c] = d
                        else
                            dbProfiles[profiles[i]][a][c] = {}
                            for e, f in pairs(d) do dbProfiles[profiles[i]][a][c][e] = f end
                        end
                    end
                end
            end
            selectedDB[profiles[i]] = dbProfiles[profiles[i]]
        end
    end
end

function ATT:PLAYER_LEAVING_WORLD()
    ATTInspectFrame:Hide()
end

local function ATT_OnLoad(self)
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("PLAYER_LEAVING_WORLD")
    self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
    self:RegisterEvent("GROUP_ROSTER_UPDATE")
    self:RegisterEvent("GROUP_JOINED")
    self:RegisterEvent("UNIT_AURA")
    self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    self:RegisterEvent("CVAR_UPDATE", "USE_RAID_STYLE_PARTY_FRAMES")
    self:RegisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL")
    self:RegisterEvent("CHARACTER_POINTS_CHANGED")

    if C_ChatInfo.RegisterAddonMessagePrefix(ChatPrefix) then self.useCrossAddonCommunication = true end
    if self.useCrossAddonCommunication then self:RegisterEvent("CHAT_MSG_ADDON") end
    self:SetScript("OnEvent", function(self, event, ...) if self[event] then self[event](self, ...) end end);
    ATTDB = ATTDB or {}
    ATTCharDB = ATTCharDB or {}

    for _, v in pairs(dbTrinkets) do
        local isTrinket = GetItemInfoInstant(v.trinketId)
        local item = isTrinket and Item:CreateFromItemID(v.trinketId)
        if item then
            item:ContinueOnItemLoad(function()
                if v.isPvPtrinket then
                    v.name = GetSpellInfo(v.ability)
                else
                    v.name = item:GetItemName()
                end
                v.texture = item:GetItemIcon()
            end)
        end
    end

    self:LoadProfiles()
    self:CheckProfile()
    self:CreateAnchors()
    self:CreateOptions()
    self:UpdateScrollBar()
    self:FindFrameType();
    ATTInspectFrame:Hide()
    ATTInspectFrame:SetScript("OnUpdate", InspectTimer)
    ATTInspectFrame:SetScript("OnShow", function(self)
        ATT:RegisterEvent("INSPECT_READY")
        elapsedTime = -1
    end)
    ATTInspectFrame:SetScript("OnHide",
        function(self)
            ATT:UnregisterEvent("INSPECT_READY")
            ClearInspectPlayer()
            elapsedTime = -1
        end)
    C_Timer.After(2.6, function()
        ATT:FindFrameType();
        self:ApplyAnchorSettings();
    end)

    if IsAddOnLoaded("Blizzard_CompactRaidFrames") then
        hooksecurefunc("CompactUnitFrameProfiles_ActivateRaidProfile", function() ATT:ApplyAnchorSettings(); end)
        hooksecurefunc("CompactRaidFrameManager_UpdateShown", function() ATT:ApplyAnchorSettings(); end)
    end

    print("|cff33ff99A|rbility |cff33ff99T|ream |cff33ff99T|rracker |cffFF4500v" ..
    ATTversion .. "|r |cff33ff99Classic|r loaded. Type |cffFF4500/att|r to open options.")
end

function ATT:FindAbilityIcon(ability, id)
    if not id then
        return ""
    end
    local icon;
    if id then
        icon = GetSpellTexture(id)
    else
        _, _, icon = GetSpellInfo(ability)
    end
    return icon or ""
end

function ATT:MergeTable(class, category, isAnchor)
    local newdbSpells = {}

    if not db.alertCDtext then db.alertCDtext = {} end --updade fix
    if type(db.isEnabledSpell[class]) ~= "table" then db.isEnabledSpell[class] = {} end
    if type(db.customSpells[class]) ~= "table" then db.customSpells[class] = {} end
    if type(db.iconOrder[class]) ~= "table" then db.iconOrder[class] = {} end
    if type(db.alertCD[class]) ~= "table" then db.alertCD[class] = {} end
    if type(db.alertCDtext[class]) ~= "table" then db.alertCDtext[class] = {} end

    local dbSpells = dbImport[class]
    local dbiconOrder = db.iconOrder[class]
    local dbcustomSpells = db.customSpells[class]

    if category == "abilities" then
        if dbSpells then
            for _, v in pairs(dbSpells) do
                if not v.name then v.name = GetSpellInfo(v.ability) end --if not v.name
                if v.name then table.insert(newdbSpells, v) end
            end
        end

        if dbcustomSpells then
            for _, v in pairs(dbcustomSpells) do
                if not v.name then v.name = GetSpellInfo(v.ability) end
                if v.name then table.insert(newdbSpells, v) end
            end
        end

        for _, v in pairs(newdbSpells) do
            if dbiconOrder[v.ability] then
                v.order = dbiconOrder[v.ability] or 20
            else
                v.order = 20
            end
        end

        table.sort(newdbSpells, function(a, b)
            if isAnchor then
                if (a.order) == (b.order) then
                    return (a.name) < (b.name)
                else
                    return (a.order) < (b.order)
                end
            else
                return (a.name) < (b.name)
            end
        end)
    elseif category == "trinkets" then
        if dbTrinkets then
            for _, v in pairs(dbTrinkets) do
                if v.name then table.insert(newdbSpells, v) end
            end
            table.sort(newdbSpells, function(a, b)
                if (a.isPvPtrinket and not b.isPvPtrinket) then
                    return (1) < (2)
                elseif (not a.isPvPtrinket and b.isPvPtrinket) then
                    return (1) > (2)
                else
                    return (a.name) < (b.name)
                end
            end)
        end
    elseif category == "racials" then
        if dbRacials then
            for _, v in pairs(dbRacials) do
                if not v.name then v.name = GetSpellInfo(v.ability) end
                if v.name then table.insert(newdbSpells, v) end
            end
            table.sort(newdbSpells, function(a, b) return (a.name) < (b.name) end)
        end
    end

    return newdbSpells
end

-- Panel
-------------------------------------------------------------

local function CreatePopUpFrame(panel, name)
    local popUpFrame = CreateFrame("Frame", name, panel, "TooltipBorderedFrameTemplate");
    popUpFrame:SetFrameLevel(popUpFrame:GetFrameLevel() + 3)
    popUpFrame:EnableMouse(true);
    popUpFrame:SetBackdropColor(0, 0, 0);
    popUpFrame:SetSize(280, 265);
    popUpFrame:SetPoint('LEFT', 180, -100);

    local title = popUpFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetJustifyH("CENTER")
    title:SetText(name)
    title:SetPoint("TOP", popUpFrame, "TOP", 0, -10)

    local closebtn = CreateFrame("button", "closebtn", popUpFrame, "UIPanelButtonTemplate")
    closebtn:SetHeight(24)
    closebtn:SetWidth(60)
    closebtn:SetPoint("BOTTOM", popUpFrame, "BOTTOM", 0, 5)
    closebtn:SetText("Close")
    closebtn:SetScript("OnClick", function(self)
        self:GetParent():Hide()
        panel.popUP = false
    end)

    popUpFrame:Hide()
    return popUpFrame
end

local function CreateListButton(parent, index, panel)
    local button = CreateFrame("CheckButton", parent:GetName() .. index, parent, "InterfaceOptionsCheckButtonTemplate")
    button.orderbtn = CreateFrame("button", parent:GetName() .. index .. "orderbtn", button,
        "UIPanelScrollUpButtonTemplate")
    return button
end

local function CreateEditBox(name, parent, width, height)
    local editbox = CreateFrame("EditBox", parent:GetName() .. name, parent, "InputBoxTemplate")
    editbox:SetHeight(height)
    editbox:SetWidth(width)
    editbox:SetAutoFocus(false)
    editbox:SetNumeric(true)
    editbox:SetMaxLetters(8)
    local label = editbox:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
    label:SetText(name)
    label:SetPoint("BOTTOMLEFT", editbox, "TOPLEFT", -3, 0)
    return editbox
end

local function EnableGlobalSpell(id, value, option)
    for i = 1, GetNumClasses() do
        local className, classTag, classID = GetClassInfo(i)
        if classTag then
            if option == "spell" then
                if not db.isEnabledSpell[classTag] then db.isEnabledSpell[classTag] = {} end
                db.isEnabledSpell[classTag][id] = value
            elseif option == "alertCDtext" then
                if not db.alertCDtext[classTag] then db.alertCDtext[classTag] = {} end
                db.alertCDtext[classTag][id] = value
            elseif option == "alertCD" then
                if not db.alertCD[classTag] then db.alertCD[classTag] = {} end
                db.alertCD[classTag][id] = value
            end
        end
    end
end

function ATT:FindFrameType()
    local hookFrames = { 0, "Do Not Attach", 1, "Auto attach UI", 2, "Blizzard UI" }
    for x, v in pairs(customframes) do
        local checkframe = format(string.gsub(v.cframe, "1RG", 1), 1)
        if (_G[checkframe] or IsAddOnLoaded(v.cname)) then
            tinsert(hookFrames, x);
            tinsert(hookFrames, v.ctype);
        end
    end

    ATT_DropDown1.values = hookFrames
    ATT_DropDown1.doRefresh()
end


function ATT:CreateOptions()
    local panel = SO.AddOptionsPanel("Ability Team Tracker", function() end)
    self.panel = panel

    SO.AddSlashCommand("Ability Team Tracker", "/att")
    panel:MakeTitleTextAndSubText("Ability Team Tracker")

    local attach = panel:MakeDropDown('name', ' Attach to raid frames', 'description', 'Select hook mode behaviour',
        'values', { 0, "Do Not Attach", 1, "Auto attach UI", 2, "Blizzard UI" }, 'default', 0, 'getFunc', function()
            return db.attach or 0
        end, 'getCurrent', function()
            return db.attach or 0
        end, 'setFunc', function(value)
            db.attach = tonumber(value);
            self:ApplyAnchorSettings();
        end)
    attach:SetPoint("TOPLEFT", panel, "TOPLEFT", 5, -60)

    local attachPos = panel:MakeDropDown('name', ' Attach position', 'description', 'Select anchor position',
    'values', { 0, "TOP LEFT", 1, "TOP RIGHT", 2, "BOTTOM LEFT", 3, "BOTTOM RIGHT", 4, "CENTER LEFT", 5, "CENTER RIGHT" }, 'default', 0, 'getFunc', function()
        return  db.attachPos or 0
    end, 'getCurrent', function()
        return  db.attachPos or 0
    end, 'setFunc', function(value)
        db.attachPos = tonumber(value);
        self:ApplyAnchorSettings();
    end)
    attachPos:SetPoint("TOPLEFT", attach, "TOPLEFT", 0, -50)

    local growUP = panel:MakeToggle('name', 'Grow Rows Upwards', 'description', 'Grow new rows upwards', 'default'
   , false, 'getFunc', function()
       return db.growUP
   end, 'getCurrent', function()
       return db.growUP
   end, 'setFunc', function(value)
       db.growUP = value;
       self:ApplyAnchorSettings();
   end)
   growUP:SetPoint("TOP", panel, "TOP", -120, -50)

   local reverseIcons = panel:MakeToggle('name', 'Grow Icons Reversed', 'description', 'Reverse icons growing direction',
   'default', false, 'getFunc', function()
       return db.reverseIcons
   end, 'getCurrent', function()
       return db.reverseIcons
   end, 'setFunc', function(value)
       db.reverseIcons = value;
       self:ApplyAnchorSettings()
   end)
reverseIcons:SetPoint("TOP", growUP, "BOTTOM", 0, -5)

   local selfAttach = panel:MakeToggle(
    'name', 'Disable Self Attach',
    'description', 'Disable self frame hooking',
    'default', false,
    'getFunc', function() return db.selfAttach end,
    'getCurrent', function() return db.selfAttach end,
    'setFunc', function(value)
        db.selfAttach = value;
        self:ApplyAnchorSettings()
    end)
selfAttach:SetPoint("TOP", reverseIcons, "BOTTOM", 0, -5)

    local scale = panel:MakeSlider('name', 'Scale', 'description', 'Adjust the scale of icons', 'minText', 'Min',
        'maxText', 'Max', 'minValue', 1, 'maxValue', 200, 'step', 1, 'default', 100, 'current',
        db.scale and tonumber(db.scale * 100) or 1, 'getCurrent',
        function()
            return db.scale and tonumber(db.scale * 100) or 100
        end, 'setFunc', function(value)
            if (tonumber(value) / 100) ~= db.scale then
                db.scale = tonumber(string.format("%.2f", value)) / 100;
                ATTIcons:SetScale(db.scale or 1)
            end
        end, 'currentTextFunc', function(value)
            return tonumber(string.format("%.2f", value))
        end)
    scale:SetPoint("TOPLEFT", attach, "TOPLEFT", 20, -100)

    local iconRows = panel:MakeSlider('name', 'Icon Rows', 'description', 'Adjust number of icons per row', 'minText',
        '1', 'maxText', '5', 'minValue', 1, 'maxValue', 5, 'step', 1, 'default', 2, 'current',
        tonumber(db.IconRows) or 1
        , 'getCurrent',
        function()
            return tonumber(db.IconRows) or 1
        end, 'setFunc', function(value)
            if value ~= db.IconRows then
                db.IconRows = tonumber(string.format("%.1d", value));
                self:UpdateIcons();
            end
        end, 'currentTextFunc', function(value)
            return tonumber(string.format("%.1d", value));
        end)
    iconRows:SetPoint("LEFT", scale, "RIGHT", 15, 0)

    local iconAlpha = panel:MakeSlider('name', 'Icon Opacity', 'description', 'Adjust icons opacity', 'minText',
        'Hide', 'maxText', 'Max', 'minValue', 0, 'maxValue', 10, 'step', 1, 'default', 0, 'current',
        db.iconAlpha and tonumber(db.iconAlpha * 10) or 10,
        'getCurrent', function()
            return db.iconAlpha and tonumber(db.iconAlpha * 10) or 10
        end, 'setFunc', function(value)
            if value ~= db.iconAlpha then
                db.iconAlpha = value / 10;
                self:UpdateIcons();
            end
        end, 'currentTextFunc', function(value)
            return tonumber(string.format("%.1d", value));
        end)
    iconAlpha:SetPoint("LEFT", iconRows, "RIGHT", 15, 0)

    local raidGroupSize = panel:MakeSlider('name', 'Raid Anchors', 'description',
        'Adjust number of anchors to show inside a raid group\n', 'minText', 'Hide', 'maxText', '40', 'minValue', 0,
        'maxValue', 40, 'step', 1, 'default', 0, 'current', tonumber(db.raidGroupSize) or 5,
        'getCurrent', function()
            return tonumber(db.raidGroupSize) or 5
        end, 'setFunc', function(value)
            if value ~= db.raidGroupSize then
                db.raidGroupSize = tonumber(string.format("%.1d", value));
                self:EnqueueInspect(true)
                self:UpdateIcons();
            end
        end, 'currentTextFunc', function(value)
            return tonumber(string.format("%.1d", value));
        end)
    raidGroupSize:SetPoint("LEFT", iconAlpha, "RIGHT", 15, 0)

    local offsetX = panel:MakeSlider('name', 'Anchor Offset X', 'description', 'Adjust anchor position X', 'minText',
        'Left', 'maxText', 'Right', 'minValue', -200, 'maxValue', 200, 'step', 1, 'default', 0, 'current',
        tonumber(db.offsetX) or 0,
        'getCurrent', function()
            return tonumber(db.offsetX) or 0
        end, 'setFunc', function(value)
            if value ~= db.offsetX then
                db.offsetX = tonumber(value);
                self:UpdatePositions()
            end
        end, 'currentTextFunc', function(value)
            return tonumber(value);
        end)
    offsetX:SetPoint("TOPLEFT", attach, "TOPLEFT", 20, -160)

    local offsetY = panel:MakeSlider('name', 'Anchor Offset Y', 'description', 'Adjust anchor position Y', 'minText',
        'Down', 'maxText', 'Up', 'minValue', -200, 'maxValue', 200, 'step', 1, 'default', 0, 'current',
        tonumber(db.offsetY) or 0,
        'getCurrent', function()
            return tonumber(db.offsetY) or 0
        end, 'setFunc', function(value)
            if value ~= db.offsetY then
                db.offsetY = tonumber(value);
                self:UpdatePositions()
            end
        end, 'currentTextFunc', function(value)
            return tonumber(value);
        end)
    offsetY:SetPoint("LEFT", offsetX, "RIGHT", 15, 0)

    local iconOffsetX = panel:MakeSlider('name', 'Row Spacing', 'description', 'Adjust space between rows', 'minText',
        '0', 'maxText', '100', 'minValue', 0, 'maxValue', 100, 'step', 1, 'default', 5, 'current',
        tonumber(db.iconOffsetX) or 5,
        'getCurrent', function()
            return tonumber(db.iconOffsetX) or 5
        end, 'setFunc', function(value)
            if value ~= db.iconOffsetX then
                db.iconOffsetX = tonumber(string.format("%.1d", value));
                self:UpdateIcons();
            end
        end, 'currentTextFunc', function(value)
            return tonumber(string.format("%.1d", value));
        end)
    iconOffsetX:SetPoint("LEFT", offsetY, "RIGHT", 15, 0)

    local iconOffsetY = panel:MakeSlider('name', 'Icon Spacing', 'description', 'Adjust space between icons', 'minText',
        '0', 'maxText', '100', 'minValue', 0, 'maxValue', 100, 'step', 1, 'default', 2, 'current',
        tonumber(db.iconOffsetY) or 2,
        'getCurrent', function()
            return tonumber(db.iconOffsetY) or 2
        end, 'setFunc', function(value)
            if value ~= db.iconOffsetY then
                db.iconOffsetY = tonumber(string.format("%.1d", value));
                self:UpdateIcons();
            end
        end, 'currentTextFunc', function(value)
            return tonumber(string.format("%.1d", value));
        end)
    iconOffsetY:SetPoint("LEFT", iconOffsetX, "RIGHT", 15, 0)

    local lock = panel:MakeToggle('name', 'Hide Anchors', 'description', 'Hide/Lock anchors', 'default', false, 'getFunc'
    , function()
        return db.lock
    end, 'getCurrent', function()
        return db.lock
    end, 'setFunc', function(value)
        db.lock = value;
        self:ApplyAnchorSettings()
    end)
    lock:SetPoint("TOP", panel, "TOP", 40, -50)

    local glow = panel:MakeToggle('name', 'Glow Icons', 'description',
        'Show Glow animation when\nimportant abilites are active', 'default', true, 'getFunc', function()
            return db.glow
        end, 'getCurrent', function()
            return db.glow
        end, 'setFunc', function(value)
            db.glow = value;
            self:UpdateIcons();
        end)
    glow:SetPoint("TOP", lock, "BOTTOM", 0, -5)

    local showIconBorders = panel:MakeToggle('name', 'Draw Borders', 'description', 'Draw borders around icons',
        'default', true, 'getFunc', function()
            return db.showIconBorders
        end, 'getCurrent', function()
            return db.showIconBorders
        end, 'setFunc', function(value)
            db.showIconBorders = value;
            self:UpdateIcons();
        end)
    showIconBorders:SetPoint("TOP", glow, "BOTTOM", 0, -5)

    local showSelf = panel:MakeToggle('name', 'Show Self', 'description', 'Show your own icons', 'default', false,
        'getFunc', function()
            return db.showSelf
        end, 'getCurrent', function()
            return db.showSelf
        end, 'setFunc', function(value)
            db.showSelf = value;
            self:InspectPlayer()
            self:ApplyAnchorSettings()
        end)
    showSelf:SetPoint("LEFT", lock, "RIGHT", 120, 0)

    local showTooltip = panel:MakeToggle('name', 'Show Tooltip', 'description', 'Show tooltips over icons', 'default',
        false, 'getFunc', function()
            return db.showTooltip
        end, 'getCurrent', function()
            return db.showTooltip
        end, 'setFunc', function(value)
            db.showTooltip = value;
            self:UpdateIcons();
        end)
    showTooltip:SetPoint("TOP", showSelf, "BOTTOM", 0, -5)

    local hidden = panel:MakeToggle('name', 'Hidden Mode', 'description', 'Show icons only if that are on cooldown',
        'default', false, 'getFunc', function()
            return db.hidden
        end, 'getCurrent', function()
            return db.hidden
        end, 'setFunc', function(value)
            db.hidden = value;
            self:UpdateIcons();
        end)
    hidden:SetPoint("TOP", showTooltip, "BOTTOM", 0, -5)

    local cpanel = CreateFrame("Frame", "ATTFrame", panel, BackdropTemplateMixin and "BackdropTemplate, TooltipBorderedFrameTemplate")
    cpanel:SetSize(640, 280)
    cpanel:SetPoint("TOP", panel, "TOP", 0, -270)
    cpanel:SetBackdropColor(0,0,0, 0.4)

    local info = CreateFrame("Frame", "ATTFrame", panel, BackdropTemplateMixin and "BackdropTemplate")
    info:SetPoint("TOPLEFT", panel, "TOPLEFT", 25, -560)
    info:SetSize(50, 50)

    local version = info:CreateFontString(nil, "ARTWORK", "GameFontDisable")
    version:SetText("|cffffff00ATT|r |cff33ff99v" .. ATTversion .. "|r Classic by |cffffff00izy|r")
    version:SetPoint("TOPLEFT", info, "TOPLEFT", 0, 0)

    local contact = info:CreateFontString(nil, "ARTWORK", "GameFontDisable")
    contact:SetText("[ Contact: curseforge.com/wow/addons/att ]")
    contact:SetPoint("TOPLEFT", info, "TOPLEFT", -5, -15)

    self:CreateOptionFrame()
    self:CreateVisibilityFrame()
    self:CreateProfilesFrame()
    self:CreateAbilityEditor()
    self:UpdateScrollBar()
    self:CreateOrderFrame()
end

function ATT:CreateOptionFrame()
    local panel = self.panel

    local extraoptions = CreatePopUpFrame(panel, "Options")

    local selfHideInRaid = panel:MakeToggle('name', 'Hide Self In Raid', 'description',
    'Hide Self in Raid Groups when Raid Anchors option is set to 0', 'extra', extraoptions, 'default', false, 'getFunc',
    function()
        return db.selfHideInRaid
    end, 'getCurrent', function()
        return db.selfHideInRaid
    end, 'setFunc', function(value)
        db.selfHideInRaid = value;
        ATT:ApplyAnchorSettings();
    end)
    selfHideInRaid:SetPoint("TOP", extraoptions, "TOP", -110, -40)

    local bgMode = panel:MakeToggle('name', 'Battleground Mode', 'description',
        'Show only trinkets and racials\ninside Battlegrounds', 'extra', extraoptions, 'default', false, 'getFunc',
        function()
            return db.bgMode
        end, 'getCurrent', function()
            return db.bgMode
        end, 'setFunc', function(value)
            db.bgMode = value;
            ATT:ApplyAnchorSettings();
        end)
    bgMode:SetPoint("TOP", selfHideInRaid, "TOP", 0, -30)

    local syncInfo = extraoptions:CreateFontString(nil, nil, "GameFontNormalSmall")
    syncInfo:SetWidth(250)
    syncInfo:SetText("- Sync Cooldowns is now enabled by default and can receive updates from other addons that are using OpenRaidLib if other party / raid memebers dont have ATT enabled")
    syncInfo:SetJustifyH("LEFT")
    syncInfo:SetPoint("TOPLEFT", bgMode, "TOPLEFT", 0, -35)

    local showExtraOptions = panel:MakeButton('name', 'Options', 'description', 'Open Options Tab', 'newsize', false,
        'func', function()
            if panel.popUP then
                panel.popUP:Hide()
                panel.popUP = false
            else
                extraoptions:Show()
                panel.popUP = extraoptions
            end
        end)
    showExtraOptions:SetPoint("TOPLEFT", panel, "TOPLEFT", 360, -560)
end

function ATT:CreateVisibilityFrame()
    local panel = self.panel
    local visibility = CreatePopUpFrame(panel, "Visibility")

    local arena = panel:MakeToggle('name', 'Show in Arenas', 'description', '', 'extra', visibility, 'default', false,
        'getFunc', function()
        return db.isEnabledVisibility["arena"]
    end, 'getCurrent', function()
        return db.isEnabledVisibility["arena"]
    end, 'setFunc', function(value)
        db.isEnabledVisibility["arena"] = value;
        ATT:ApplyAnchorSettings();
    end)
    arena:SetPoint("TOP", visibility, "TOP", -110, -40)

    local dungeons = panel:MakeToggle('name', 'Show in Dungeons', 'description', '', 'extra', visibility, 'default',
        false, 'getFunc', function()
        return db.isEnabledVisibility["dungeons"]
    end, 'getCurrent', function()
        return db.isEnabledVisibility["dungeons"]
    end, 'setFunc', function(value)
        db.isEnabledVisibility["dungeons"] = value;
        ATT:ApplyAnchorSettings();
    end)
    dungeons:SetPoint("TOP", arena, "TOP", 0, -30)

    local scenarios = panel:MakeToggle('name', 'Show in Scenarios', 'description', '', 'extra', visibility, 'default',
        false, 'getFunc', function()
        return db.isEnabledVisibility["scenarios"]
    end, 'getCurrent', function()
        return db.isEnabledVisibility["scenarios"]
    end, 'setFunc', function(value)
        db.isEnabledVisibility["scenarios"] = value;
        ATT:ApplyAnchorSettings();
    end)
    scenarios:SetPoint("TOP", dungeons, "TOP", 0, -30)

    local inbg = panel:MakeToggle('name', 'Show in Battlegrounds', 'description', '', 'extra', visibility, 'default',
        false, 'getFunc', function()
        return db.isEnabledVisibility["inbg"]
    end, 'getCurrent', function()
        return db.isEnabledVisibility["inbg"]
    end, 'setFunc', function(value)
        db.isEnabledVisibility["inbg"] = value;
        ATT:ApplyAnchorSettings();
    end)
    inbg:SetPoint("TOP", scenarios, "TOP", 0, -30)

    local inraid = panel:MakeToggle('name', 'Show in Raid Instances', 'description', '', 'extra', visibility, 'default',
        false, 'getFunc', function()
        return db.isEnabledVisibility["inraid"]
    end, 'getCurrent', function()
        return db.isEnabledVisibility["inraid"]
    end, 'setFunc', function(value)
        db.isEnabledVisibility["inraid"] = value;
        ATT:ApplyAnchorSettings();
    end)
    inraid:SetPoint("TOP", inbg, "TOP", 0, -30)

    local outside = panel:MakeToggle('name', 'Show in Open World', 'description', '', 'extra', visibility, 'default',
        false, 'getFunc', function()
        return db.isEnabledVisibility["outside"]
    end, 'getCurrent', function()
        return db.isEnabledVisibility["outside"]
    end, 'setFunc', function(value)
        db.isEnabledVisibility["outside"] = value;
        ATT:ApplyAnchorSettings();
    end)
    outside:SetPoint("TOP", inraid, "TOP", 0, -30)

    local showVisibility = panel:MakeButton('name', 'Visibility', 'description', 'Open Visibility Tab', 'newsize', false,
        'func', function()
        if panel.popUP then
            panel.popUP:Hide()
            panel.popUP = false
        else
            visibility:Show()
            panel.popUP = visibility
        end
    end)
    showVisibility:SetPoint("TOPLEFT", panel, "TOPLEFT", 460, -560)
end

function ATT:CreateProfilesFrame()
    local panel = self.panel

    local profiles = CreatePopUpFrame(panel, "Profiles")

    local selectProfile = panel:MakeDropDown('name', ' Select Profile', 'description', 'Select Profile', 'extra',
        profiles, 'values',
        { "DEFAULT", "Main", "TANK", "Tank", "HEALER", "Healer", "DAMAGER", "DPS", "BG", "BattleGround", "Extra1",
            "Extra Profie 1", "Extra2", "Extra Profie 2" }, 'default', "DEFAULT", 'getFunc', function()
        return selectedDB.ProfileSelected
    end, 'getCurrent', function()
        return selectedDB.ProfileSelected
    end, 'setFunc', function(value)
        local _, instanceType = IsInInstance()
        if selectedDB.autoselectBG and instanceType == "pvp" then
            print("You can not change profiles in battleground if |cffFF4500'Auto Switch BG Profile'|r is enabled")
            panel:UpdateSettings()
            return
        end
        selectedDB.ProfileSelected = value
        self:CheckProfile();
        self:UpdateScrollBar();
        self:ApplyAnchorSettings();
        panel:UpdateSettings()
    end) -- here
    selectProfile:SetPoint("TOP", profiles, "TOP", -40, -60)

    local copyProfile = panel:MakeButton('name', 'Import', 'description',
        'Copy settings from the Main profile to the current profile', 'extra', profiles, 'newsize', 2, 'func',
        function()
            if selectedDB.ProfileSelected ~= "DEFAULT" then
                StaticPopup_Show("ATT_COPYPROFILES")
            else
                print(
                    "You have to select a different profile - |cffFF4500Main|r profile can NOT copy itsef.")
            end
        end)
    copyProfile:SetPoint("LEFT", selectProfile, "RIGHT", -5, 3)

    StaticPopupDialogs["ATT_COPYPROFILES"] = {
        text = "Are you sure you want to copy the settings from the Main profile to this profile?\n\nAll the settings on the current profile will be overwritten.",
        button1 = "Yes",
        button2 = "No",
        OnAccept = function()
            if selectedDB.ProfileSelected ~= "DEFAULT" then
                selectedDB[selectedDB.ProfileSelected] = selectedDB["DEFAULT"]
                self:CheckProfile();
                self:UpdateScrollBar();
                self:ApplyAnchorSettings();
                panel:UpdateSettings()
                print("Current profile has been |cffFF4500updated|r")
            end
        end,
        exclusive = true,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }

    local autoselectBG = panel:MakeToggle('name', 'Auto Switch BG Profile', 'description',
        'Auto Switch to BattleGround profile inside battlegrounds\n', 'extra', profiles, 'default', false, 'getFunc',
        function()
            return selectedDB.autoselectBG
        end, 'setFunc', function(value)
        selectedDB.autoselectBG = value;
        ATT:CheckProfile();
        ATT:UpdateScrollBar();
        ATT:ApplyAnchorSettings();
        panel:UpdateSettings()
    end)
    autoselectBG:SetPoint("TOP", profiles, "TOP", -95, -100)

    local profilebychar = panel:MakeToggle('name', 'Use Character DB', 'description',
        'Your profiles will be stored per Charcater and not per Account\n', 'extra', profiles, 'default', false,
        'getFunc', function()
        return ATTDB.profilebychar
    end, 'setFunc', function(value)
        StaticPopup_Show("ATT_CHARDB")
    end)
    profilebychar:SetPoint("TOP", autoselectBG, "TOP", 0, -30)

    StaticPopupDialogs["ATT_CHARDB"] = {
        text = "Are you sure you want to switch the DB?\n\n Your UI will be reloaded .",
        button1 = "Yes",
        button2 = "No",
        OnAccept = function()
            --ATTCharDB = {}; ---HERE TODO TESTING
            ATTDB.profilebychar = (not ATTDB.profilebychar);
            ATT:CheckProfile();
            ATT:UpdateScrollBar();
            ATT:ApplyAnchorSettings();
            panel:UpdateSettings()
            ReloadUI();
        end,
        OnCancel = function()
            profilebychar:SetChecked(not not ATTDB.profilebychar)
        end,
        exclusive = true,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }

    local reset = panel:MakeButton('name', 'Reset Addon', 'description', 'Reset all settings and profiles', 'extra',
        profiles, 'newsize', false, 'func', function()
        StaticPopup_Show("ATT_RESET")
    end)
    reset:SetPoint("TOP", profilebychar, "TOP", 95, -60)

    StaticPopupDialogs["ATT_RESET"] = {
        text = "Are you sure you want to reset ATT?\n\nAll your settings will be lost and your UI will be reloaded.",
        button1 = "Yes",
        button2 = "No",
        OnAccept = function()
            ATTDB = {};
            ATTCharDB = {};
            ReloadUI();
        end,
        exclusive = true,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }

    profiles:SetScript("OnHide",
        function(self)
            StaticPopup_Hide("ATT_RESET")
            StaticPopup_Hide("ATT_COPYPROFILES")
            StaticPopup_Hide("ATT_CHARDB")
        end)

    local showProfiles = panel:MakeButton('name', 'Profiles', 'description', 'Open Profiles tab', 'newsize', false,
        'func', function()
        if panel.popUP then
            panel.popUP:Hide()
            panel.popUP = false
        else
            profiles:Show()
            panel.popUP = profiles
        end
    end)
    showProfiles:SetPoint("TOPLEFT", panel, "TOPLEFT", 560, -560)
end

function ATT:CreateOrderFrame()
    local panel = self.panel
    local popUpFrame = CreateFrame("Frame", "Order", panel, "TooltipBorderedFrameTemplate");
    self.OrderPopUpFrame = popUpFrame
    popUpFrame.id = nil

    popUpFrame:SetFrameLevel(popUpFrame:GetFrameLevel() + 3)
    popUpFrame:EnableMouse(true);
    popUpFrame:SetBackdropColor(0, 0, 0);
    popUpFrame:SetSize(250, 180);
    popUpFrame:SetPoint('LEFT', 200, -65);
    popUpFrame.title = popUpFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    popUpFrame.title:SetPoint("TOP", popUpFrame, "TOP", 0, -10)
    popUpFrame:Hide()

    local closebtn = CreateFrame("button", "closebtn", popUpFrame, "UIPanelButtonTemplate")
    closebtn:SetHeight(24)
    closebtn:SetWidth(100)
    closebtn:SetPoint("BOTTOM", popUpFrame, "BOTTOM", 0, 5)
    closebtn:SetText("Close")
    closebtn:SetScript("OnClick", function(self)
        self:GetParent():Hide()
        panel.popUP = false
        ATT:UpdateIcons()
    end)

    local order = panel:MakeSlider('name', 'Icon Order', 'extra', popUpFrame, 'description', 'Adjust icon order priority',
        'minText', '1', 'maxText', '20', 'minValue', 1, 'maxValue', 20, 'step', 1, 'default', 1, 'current',
        tonumber(db.iconOrder[db.classSelected][popUpFrame.id]) or 20, 'setFunc', function(value)
        if value ~= db.iconOrder[db.classSelected][popUpFrame.id] then
            db.iconOrder[db.classSelected][popUpFrame.id] = tonumber(string.format("%.1d", value))
        end
    end, 'currentTextFunc', function(value)
        return tonumber(string.format("%.1d", value))
    end)
    order:SetPoint("TOP", popUpFrame, "TOP", 0, -60)

    local notorder = popUpFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    notorder:SetText("Changing order of trinkets or racials\n is not supported")
    notorder:SetPoint("TOP", popUpFrame, "TOP", 0, -60)

    local alertCD = panel:MakeToggle('name', 'Sound alert', 'extra', popUpFrame, 'description',
        'Play a sound when activated', 'default', false, 'getFunc', function()
        return db.alertCD[db.classSelected][popUpFrame.id]
    end,
        'setFunc', function(value)
        if db.globalSelections and db.category ~= "abilities" then
            EnableGlobalSpell(popUpFrame.id, value, "alertCD") --global selections
        else
            db.alertCD[db.classSelected][popUpFrame.id] = value;
        end
    end)
    alertCD:SetPoint("TOP", order, "BOTTOM", -90, -30)

    local alertCDtext = panel:MakeToggle('name', 'Text alert', 'extra', popUpFrame, 'description',
        'Show a text alert when activated', 'default', false, 'getFunc', function()
        return db.alertCDtext[db.classSelected][popUpFrame.id]
    end, 'setFunc', function(value)
        if db.globalSelections and db.category ~= "abilities" then
            EnableGlobalSpell(popUpFrame.id, value, "alertCDtext") --global selections
        else
            db.alertCDtext[db.classSelected][popUpFrame.id] = value;
        end
    end)
    alertCDtext:SetPoint("LEFT", alertCD, "RIGHT", 100, 0)

    popUpFrame:SetScript("OnShow", function(self)
        alertCD:SetChecked(not not db.alertCD[db.classSelected][popUpFrame.id])
        alertCDtext:SetChecked(not not db.alertCDtext[db.classSelected][popUpFrame.id])
        if (db.category == "abilities") then
            order:SetValue(tonumber(db.iconOrder[db.classSelected][popUpFrame.id]) or 20)
            order.currentText:SetText(tonumber(db.iconOrder[db.classSelected][popUpFrame.id]) or 20)
            order:Show();
            notorder:Hide();
        else
            order:Hide();
            notorder:Show();
        end
    end)
end

function ATT:UpdateScrollBar()
    local panel, scrollframe, btns = self.panel, self.scrollframe, self.btns
    local OrderPopUpFrame = self.OrderPopUpFrame
    local line = 1

    for abilityIndex, abilityTable in pairs(self:MergeTable(db.classSelected, db.category)) do
        local name, id, cooldown, maxcharges, custom, texture, trinketId, isPvPtrinket = abilityTable.name,
            abilityTable.ability, abilityTable.cooldown, abilityTable.maxcharges, abilityTable.custom,
            abilityTable.texture, abilityTable.trinketId, abilityTable.isPvPtrinket
        local button = btns[line]
        local abilitytexture = texture or self:FindAbilityIcon(name, id)

        if line == 1 then
            button:SetPoint("TOPLEFT", scrollframe, "TOPLEFT", 2, 0)
        end

        if custom then
            button.Text:SetText("|T" .. abilitytexture .. ":20|t |cff808080" .. name .. "|r")
            button:SetChecked(db.isEnabledSpell[db.classSelected][id .. "custom"])
            button:SetScript("OnClick", function(self)
                db.isEnabledSpell[db.classSelected][id .. "custom"] = (button:GetChecked() == true and true) or false;
                ATT:UpdateIcons();
            end)
        else
            if isPvPtrinket then
                button.Text:SetText("|T" .. abilitytexture .. ":20|t |cffFF4500" .. name .. "|r")
            else
                button.Text:SetText("|T" .. abilitytexture .. ":20|t " .. name)
            end
            button:SetChecked(db.isEnabledSpell[db.classSelected][trinketId and trinketId or id])
            button:SetScript("OnClick", function(self)
                if db.globalSelections and db.category ~= "abilities" then
                    EnableGlobalSpell(trinketId and trinketId or id, (button:GetChecked() == true and true) or false,
                        "spell") --global selections
                else
                    db.isEnabledSpell[db.classSelected][trinketId and trinketId or id] = (button:GetChecked() == true and button:GetChecked()) or
                        false;
                end
                ATT:UpdateIcons();
            end)
        end
        button.Text:SetSize(160, 22)
        button.Text:SetJustifyH("LEFT")
        button:SetHitRectInsets(0, -160, 0, 0)
        button.Text:SetFont(GameFontNormal:GetFont(), 12)


        button:SetScript('OnEnter', function()
            local tooltip = trinketId and Item:CreateFromItemID(trinketId) or Spell:CreateFromSpellID(id)
            if trinketId then
                tooltip:ContinueOnItemLoad(function()
                    GameTooltip:ClearLines();
                    GameTooltip:SetOwner(button.Text, "ANCHOR_TOP")
                    if isPvPtrinket then
                        GameTooltip:SetSpellByID(id)
                        GameTooltip:AddLine("|cffFF4500PvP|r - Spell ID:" .. id, 1, 1, 1)
                    else
                        GameTooltip:SetItemByID(trinketId)
                        GameTooltip:AddLine("Spell ID: " .. id, 1, 1, 1)
                    end
                    GameTooltip:SetPadding(16, 0)
                    GameTooltip:Show()
                end)
            else
                tooltip:ContinueOnSpellLoad(function()
                    GameTooltip:ClearLines();
                    GameTooltip:SetOwner(button.Text, "ANCHOR_TOP")
                    GameTooltip:SetSpellByID(id)
                    if custom then
                        GameTooltip:AddLine("|cff808080CUSTOM|r - Spell ID: " .. id .. " - CD: " .. cooldown, 1, 1, 1)
                    else
                        GameTooltip:AddLine("Spell ID: " .. id, 1, 1, 1)
                    end
                    GameTooltip:SetPadding(16, 0)
                    GameTooltip:Show()
                end)
            end
        end)

        button:SetScript('OnLeave', function()
            GameTooltip:ClearLines()
            GameTooltip:Hide()
        end)

        local orderbtn = button.orderbtn
        orderbtn:SetPoint("LEFT", button, "RIGHT", 162, 0)
        orderbtn:SetText("Order")
        orderbtn:SetScript("OnClick", function(self)
            OrderPopUpFrame.title:SetText(("|T" .. abilitytexture .. ":20|t " .. name:sub(1, 30)))
            OrderPopUpFrame.id = id
            if panel.popUP then
                panel.popUP:Hide()
                panel.popUP = false
            else
                OrderPopUpFrame:Show()
                panel.popUP = OrderPopUpFrame
            end
        end)

        button:Show()
        line = line + 1
    end

    for i = line, 50 do
        btns[i]:Hide();
    end
end

function ATT:CreateAbilityEditor()
    local panel = self.panel
    panel:Hide()
    local btns = {}
    self.btns = btns

    local scrollframe = CreateFrame("ScrollFrame", "ATTScrollFrame", panel, "ScrollFrameTemplate")
    local child = CreateFrame("Frame", "ATTScrollFrameChild", scrollframe)
    child:SetSize(1, 1)
    scrollframe:SetScrollChild(child)
    self.scrollframe = child
    scrollframe:SetSize(440, 255)
    scrollframe:SetPoint('LEFT', 25, -112)

    for i = 1, 50 do
        local button = CreateListButton(child, tostring(i), panel)
        if (i % 2 == 0) then
            button:SetPoint("LEFT", btns[#btns], "RIGHT", 190, 0)
        else
            button:SetPoint("TOPLEFT",
                btns[#btns - 1], "BOTTOMLEFT", 0, 0)
        end
        btns[#btns + 1] = button
    end

    scrollframe:SetScript("OnShow",
        function(self)
            ATT:FindFrameType();
            if panel.popUP then
                panel.popUP:Hide()
                panel.popUP = false
            end
            child.dropdown.initialize()
            child.dropdown:SetValue(db.classSelected or "WARRIOR")
            panel:UpdateSettings()
        end)

    local dropdown = panel:MakeDropDown(
        'name', ' Class',
        'description', 'Pick a class',
        'values', {
        "WARRIOR", "Warrior",
        "PALADIN", "Paladin",
        "PRIEST", "Priest",
        "SHAMAN", "Shaman",
        "DRUID", "Druid",
        "ROGUE", "Rogue",
        "MAGE", "Mage",
        "WARLOCK", "Warlock",
        "HUNTER", "Hunter",
    },
        'default', 'WARRIOR',
        'getFunc', function() return db.classSelected end,
        'getCurrent', function() return db.classSelected end,
        'setFunc', function(value)
        db.classSelected = value;
        db.category = "abilities"
        child.dropdown2.initialize()
        child.dropdown2:SetValue(db.category)
    end)
    dropdown:SetPoint("TOPLEFT", scrollframe, "TOPRIGHT", 20, -10)
    child.dropdown = dropdown

    local dropdown2 = panel:MakeDropDown('name', ' Category', 'description', 'Pick a category', 'values',
        { "abilities", "Abilities", "trinkets", "Trinkets", "racials", "Racials" }, 'default', "abilities", 'current',
        "abilities", 'getCurrent', function()
        return db.category
    end, 'setFunc', function(value)
        if panel.popUP then
            panel.popUP:Hide()
            panel.popUP = false
        end
        db.category = value;
        ATT:UpdateScrollBar()
    end)
    dropdown2:SetPoint("TOPLEFT", dropdown, "BOTTOMLEFT", 0, -20)
    child.dropdown2 = dropdown2

    local globalSelections = panel:MakeToggle('name', 'Global Selections', 'description',
        'When enabled next selections of trinkets or racials will be applied to all classes', 'default', true,
        'getFunc', function()
        return db.globalSelections
    end, 'getCurrent', function()
        return db.globalSelections
    end, 'setFunc', function(value)
        db.globalSelections = value;
        self:UpdateIcons();
    end)
    globalSelections:SetPoint("TOPLEFT", dropdown2, "BOTTOMLEFT", 20, -5)

    local ideditbox = CreateEditBox("Ability ID", panel, 75, 30)
    ideditbox:SetPoint("TOPLEFT", dropdown2, "BOTTOMLEFT", 25, -50)

    local cdeditbox = CreateEditBox("CD (s)", panel, 35, 30)
    cdeditbox:SetPoint("LEFT", ideditbox, "RIGHT", 15, 0)

    local addbutton = panel:MakeButton(
        'name', 'Add',
        'description', "Add / Update ability",
        'newsize', 2,
        'func', function()
        local id = ideditbox:GetText():match("^[0-9]+$")
        local class = dropdown.value
        local ability = GetSpellInfo(id)
        local cdtext = cdeditbox:GetText():match("^[0-9]+$")

        if ability and cdtext and id and db.customSpells[class] then
            local abilities = db.customSpells[class]
            local _ability, _index = ATT:FindAbilityByName(db.customSpells[class], tonumber(ideditbox:GetText()))
            if _ability and _index then
                abilities[_index] = {
                    ability = tonumber(id),
                    cooldown = tonumber(cdtext),
                    order = _ability.order or 20,
                    custom = true
                }
                ideditbox:SetText("");
                cdeditbox:SetText("");
                print("Updated Custom Ability: |cffFF4500" ..ability .. "|r id: |cffFF4500" .. id .. "|r cd: |cffFF4500" .. cdtext .. "|r")
            else
                table.insert(abilities,
                    { ability = tonumber(id), cooldown = tonumber(cdtext), order = 20, custom = true })
                ideditbox:SetText("");
                cdeditbox:SetText("");
                print("Added Custom Ability: |cffFF4500" ..ability .. "|r id: |cffFF4500" .. id .. "|r cd: |cffFF4500" .. cdtext .. "|r")
            end
            ATT:UpdateScrollBar();
            ATT:UpdateIcons()
        else
            print("Invalid or blank:|cffFF4500 Ability ID or Cooldown|r")
        end
    end)
    addbutton:SetPoint("TOPLEFT", ideditbox, "BOTTOMLEFT", -5, -5)

    local removebutton = panel:MakeButton(
        'name', 'Remove',
        'description', 'Remove ability',
        'newsize', 2,
        'func', function()
        local class = dropdown.value
        local id = ideditbox:GetText():match("^[0-9]+$")
        local ability = GetSpellInfo(id) or id
        local _ability, _index = ATT:FindAbilityByName(db.customSpells[class], tonumber(ideditbox:GetText()))
        if _ability and _index then
            table.remove(db.customSpells[class], _index)
            print("Removed |cffFF4500" .. ability .. "|r id: |cffFF4500" .. id .. "|r")
            ideditbox:SetText("");
            cdeditbox:SetText("");
            ATT:UpdateScrollBar();
            ATT:UpdateIcons()
        else
            print("Invalid or blank:|cffFF4500 Ability ID|r")
        end
    end)
    removebutton:SetPoint("LEFT", addbutton, "RIGHT", 5, 0)
end

ATT:RegisterEvent("ADDON_LOADED")
ATT:SetScript("OnEvent", ATT_OnLoad)
