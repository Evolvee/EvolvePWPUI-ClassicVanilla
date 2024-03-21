--[================[
LibClassicDurations
Author: d87
Description: Tracks all aura applications in combat log and provides duration, expiration time.
And additionally enemy buffs info.

--]================]
if WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC then
    return
end

local MAJOR, MINOR = "LibClassicDurations", 72
local lib = LibStub:NewLibrary(MAJOR, MINOR)
if not lib then
    return
end

lib.callbacks = lib.callbacks or LibStub("CallbackHandler-1.0"):New(lib)
lib.frame = lib.frame or CreateFrame("Frame")

lib.guids = lib.guids or {}
lib.spells = lib.spells or {}
lib.buffCache = lib.buffCache or {}
local buffCache = lib.buffCache

local buffCacheValid = {}
local auraID = {}

lib.nameplateUnitMap = lib.nameplateUnitMap or {}
local nameplateUnitMap = lib.nameplateUnitMap

lib.guidAccessTimes = lib.guidAccessTimes or {}
local guidAccessTimes = lib.guidAccessTimes

local f = lib.frame
local callbacks = lib.callbacks
local guids = lib.guids
local spells = lib.spells

local INFINITY = math.huge
local PURGE_INTERVAL = 900
local PURGE_THRESHOLD = 1800

local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local UnitGUID, UnitAura = UnitGUID, UnitAura
local GetSpellInfo = GetSpellInfo
local GetTime, time = GetTime, time
local tinsert, unpack = table.insert, unpack
local bit_band = bit.band
local COMBATLOG_OBJECT_REACTION_FRIENDLY = COMBATLOG_OBJECT_REACTION_FRIENDLY

if lib.enableEnemyBuffTracking == nil then
    lib.enableEnemyBuffTracking = false
end
local enableEnemyBuffTracking = lib.enableEnemyBuffTracking


f:SetScript("OnEvent", function(self, event, ...)
    return self[event](self, event, ...)
end)

lib.dataVersions = lib.dataVersions or {}
local SpellDataVersions = lib.dataVersions

function lib:SetDataVersion(dataType, version)
    SpellDataVersions[dataType] = version
end

function lib:GetDataVersion(dataType)
    return SpellDataVersions[dataType] or 0
end

lib.AddAura = function(id, opts)
    if not opts then
        return
    end

    local lastRankID
    if type(id) == "table" then
        local clones = id
        lastRankID = clones[#clones]
    else
        lastRankID = id
    end

    local spellName = GetSpellInfo(lastRankID)
    if not spellName then
        return
    end

    if type(id) == "table" then
        for _, spellID in ipairs(id) do
            spells[spellID] = opts
        end
    else
        spells[id] = opts
    end
end

--------------------------
-- OLD GUIDs PURGE
--------------------------

local function purgeOldGUIDsArgs(dataTable, accessTimes)
    local now = time()
    local deleted = {}
    for guid, lastAccessTime in pairs(accessTimes) do
        if lastAccessTime + PURGE_THRESHOLD < now then
            dataTable[guid] = nil
            nameplateUnitMap[guid] = nil
            buffCacheValid[guid] = nil
            buffCache[guid] = nil
            auraID[guid] = nil
            tinsert(deleted, guid)
        end
    end
    for _, guid in ipairs(deleted) do
        accessTimes[guid] = nil
    end
end

local function purgeOldGUIDs()
    purgeOldGUIDsArgs(guids, guidAccessTimes)
end
if lib.purgeTicker then
    lib.purgeTicker:Cancel()
end
lib.purgeTicker = C_Timer.NewTicker(PURGE_INTERVAL, purgeOldGUIDs)

------------------------------------
-- Restore data if using standalone
f:RegisterEvent("PLAYER_LOGIN")
function f:PLAYER_LOGIN()
    if LCD_Data and LCD_GUIDAccess then
        purgeOldGUIDsArgs(LCD_Data, LCD_GUIDAccess)

        local function MergeTableNoOverwrite(t1, t2)
            if not t2 then
                return false
            end
            for k, v in pairs(t2) do
                if type(v) == "table" then
                    if t1[k] == nil then
                        t1[k] = CopyTable(v)
                    else
                        MergeTableNoOverwrite(t1[k], v)
                    end
                elseif t1[k] == nil then
                    t1[k] = v
                end
            end
            return t1
        end

        local curSessionData = lib.guids
        local restoredSessionData = LCD_Data
        MergeTableNoOverwrite(curSessionData, restoredSessionData)

        local curSessionAccessTimes = lib.guidAccessTimes
        local restoredSessionAccessTimes = LCD_GUIDAccess
        MergeTableNoOverwrite(curSessionAccessTimes, restoredSessionAccessTimes)
    end

    f:RegisterEvent("PLAYER_LOGOUT")
    function f:PLAYER_LOGOUT()
        LCD_Data = guids
        LCD_GUIDAccess = guidAccessTimes
    end
end

---------------------------
-- COMBAT LOG
---------------------------

local function SetTimer(dstGUID, spellID, opts, duration, doRemove)
    local guidTable = guids[dstGUID]
    if not guidTable then
        guids[dstGUID] = {}
        guidTable = guids[dstGUID]
    end

    if doRemove then
        if guidTable[spellID] then
            guidTable[spellID] = nil
        end
        return
    end

    local spellTable = guidTable[spellID]
    if not spellTable then
        guidTable[spellID] = {}
        spellTable = guidTable[spellID]
    end

    local applicationTable = spellTable


    if opts then
        duration = opts.duration
    elseif not duration then
        local spell, desc = Spell:CreateFromSpellID(spellID), nil
        spell:ContinueOnSpellLoad(function()
            desc = spell:GetSpellDescription()
        end)
        if desc then
            local min = desc:match("[Ll]asts?%s-(%d+)%s-([Mm]in)")
            local sec = desc:match("[Ll]asts?%s-(%d+)%s-([Ss]ec)")
            if min then
                duration = tonumber(min) * 60
            elseif sec then
                duration = tonumber(sec)
            else
                duration = 1
            end
        end
    end

    if not duration then
        return SetTimer(dstGUID, spellID, opts, nil, true)
    end
    local now = GetTime()
    applicationTable[1] = duration
    applicationTable[2] = now
    applicationTable[3] = "BUFF"
    applicationTable[4] = nil

    guidAccessTimes[dstGUID] = time()
end

local function FireToUnits(event, dstGUID)
    if dstGUID == UnitGUID("target") then
        callbacks:Fire(event, "target")
    end
    local nameplateUnit = nameplateUnitMap[dstGUID]
    if nameplateUnit then
        callbacks:Fire(event, nameplateUnit)
    end
end

---------------------------
-- COMBAT LOG HANDLER
---------------------------
function f:COMBAT_LOG_EVENT_UNFILTERED(event)
    return self:CombatLogHandler(CombatLogGetCurrentEventInfo())
end

function f:CombatLogHandler(...)
    local _, eventType, _, srcGUID, _, _, _, dstGUID, _, dstFlags, _, spellID, _, _, auraType= ...
    local isDstFriendly = bit_band(dstFlags, COMBATLOG_OBJECT_REACTION_FRIENDLY) > 0

    if auraType == "BUFF" or eventType == "SPELL_CAST_SUCCESS" and (dstGUID ~= UnitGUID("target")) then
        local opts = spells[spellID]

        local isEnemyBuff = not isDstFriendly and auraType == "BUFF"
        if isEnemyBuff and (eventType == "SPELL_AURA_REFRESH" or  eventType == "SPELL_AURA_APPLIED" or  eventType == "SPELL_AURA_APPLIED_DOSE") then
            SetTimer(dstGUID, spellID, opts, nil)
        elseif eventType == "SPELL_AURA_REMOVED" then
            SetTimer(dstGUID, spellID, opts, nil, true)
            -- elseif eventType == "SPELL_AURA_REMOVED_DOSE" then
            -- self:RemoveDose(dstGUID, spellID, spellName, auraType, amount)
        end
        if enableEnemyBuffTracking and isEnemyBuff then
            -- invalidate buff cache
            buffCacheValid[dstGUID] = nil

            FireToUnits("UNIT_BUFF", dstGUID)
            if eventType == "SPELL_AURA_REFRESH" or
                    eventType == "SPELL_AURA_APPLIED" or
                    eventType == "SPELL_AURA_APPLIED_DOSE"
            then
                FireToUnits("UNIT_BUFF_GAINED", dstGUID, spellID)
            end
        end
    end
    if eventType == "UNIT_DIED" then
        guids[dstGUID] = nil
        buffCache[dstGUID] = nil
        buffCacheValid[dstGUID] = nil
        guidAccessTimes[dstGUID] = nil
        if enableEnemyBuffTracking and not isDstFriendly then
            FireToUnits("UNIT_BUFF", dstGUID)
        end
        nameplateUnitMap[dstGUID] = nil
    end
end

---------------------------
-- ENEMY BUFFS
---------------------------
local makeBuffInfo = function(spellID, applicationTable)
    local name, _, icon, castTime, minRange, maxRange, _spellId = GetSpellInfo(spellID)
    local duration, startTime, auraType = unpack(applicationTable)
    -- no DRs on buffs
    if not startTime or (type(duration) == "function") then
        return
    end
    local expirationTime = startTime + duration - 0.1
    if duration == INFINITY then
        duration = 0
        expirationTime = 0
    end
    local now = GetTime()
    if expirationTime > now then
        local buffType = spells[spellID] and spells[spellID].buffType
        return { name, icon, 0, buffType, duration, expirationTime, nil, nil, nil, spellID, false, false, false, false, 1 }
    end
end

local function RegenerateBuffList(unit, dstGUID)
    local buffs = {}

    local guidTable = guids[dstGUID]
    if not guidTable then
        return
    end

    for spellID, t in pairs(guidTable) do
        if t.applications then
            for _, auraTable in pairs(t.applications) do
                if auraTable[3] == "BUFF" then
                    local buffInfo = makeBuffInfo(spellID, auraTable)
                    if buffInfo then
                        tinsert(buffs, buffInfo)
                    end
                end
            end
        else
            if t[3] == "BUFF" then
                local buffInfo = makeBuffInfo(spellID, t)
                if buffInfo then
                    tinsert(buffs, buffInfo)
                end
            end
        end
    end

    buffCache[dstGUID] = buffs
    buffCacheValid[dstGUID] = GetTime() + 40 -- Expiration timestamp
end

function lib.UnitAuraDirect(unit, index, filter)
    if enableEnemyBuffTracking and filter == "HELPFUL" and not UnitCanAssist("player", unit) and not UnitAura(unit, 1, filter) then
        local unitGUID = UnitGUID(unit)
        if not unitGUID then
            return
        end
        local isValid = buffCacheValid[unitGUID]

        if not isValid or isValid < GetTime() then
            RegenerateBuffList(unit, unitGUID)
        end

        local buffCacheHit = buffCache[unitGUID]
        if buffCacheHit then
            local buffReturns = buffCache[unitGUID][index]
            if buffReturns then
                return unpack(buffReturns)
            end
        end
    else
        return UnitAura(unit, index, filter)
    end
end

-- These next 3 functions should be deprecated..
function lib:UnitAura(...)
    return self.UnitAuraDirect(...)
end

function lib.UnitAuraWithBuffs(...)
    return lib.UnitAuraDirect(...)
end

function lib.UnitAuraWrapper(...)
    return UnitAura(...)
end

function f:NAME_PLATE_UNIT_ADDED(event, unit)
    if UnitCanAssist("player", unit) then
        return
    end
    local unitGUID = UnitGUID(unit)
    nameplateUnitMap[unitGUID] = unit
end
function f:NAME_PLATE_UNIT_REMOVED(event, unit)
    if UnitCanAssist("player", unit) then
        return
    end
    local unitGUID = UnitGUID(unit)
    if unitGUID then
        -- it returns correctly on death, but just in case
        nameplateUnitMap[unitGUID] = nil
    end
end

local GetGUIDAuraTime = function(dstGUID, spellID)
    local guidTable = guids[dstGUID]
    if guidTable then

        local spellTable = guidTable[spellID]
        if spellTable then
            local applicationTable = spellTable

            if not applicationTable then
                return
            end
            local duration, startTime = unpack(applicationTable)
            if duration == INFINITY then
                return nil
            end
            if not duration then
                return nil
            end
            if not startTime then
                return nil
            end
            duration = duration
            local expirationTime = startTime + duration - 0.1
            if GetTime() <= expirationTime then
                return duration, expirationTime
            end
        end
    end
end

function lib.GetAuraDurationByUnitDirect(unit, spellID)
    local dstGUID = UnitGUID(unit)
    return GetGUIDAuraTime(dstGUID, spellID)
end

function lib:GetAuraDurationByUnit(...)
    return self.GetAuraDurationByUnitDirect(...)
end

function callbacks.OnUsed()
    lib.enableEnemyBuffTracking = true
    enableEnemyBuffTracking = lib.enableEnemyBuffTracking
    f:RegisterEvent("NAME_PLATE_UNIT_ADDED")
    f:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
end
function callbacks.OnUnused()
    lib.enableEnemyBuffTracking = false
    enableEnemyBuffTracking = lib.enableEnemyBuffTracking
    f:UnregisterEvent("NAME_PLATE_UNIT_ADDED")
    f:UnregisterEvent("NAME_PLATE_UNIT_REMOVED")
end

local function auraChange(destGUID, spellId, opts, duration, buffType, remove)
    buffCacheValid[destGUID] = nil
    SetTimer(destGUID, spellId, opts, duration, remove)
    FireToUnits("UNIT_BUFF", destGUID)
    if spells[spellId] and (buffType ~= nil) then
        spells[spellId].buffType = buffType
    end
    if not remove then
        FireToUnits("UNIT_BUFF_GAINED", destGUID, spellId)
    end
end

function f:UNIT_AURA(event, unit, info)
    local unitGUID = UnitGUID(unit)
    if not unitGUID or info.isFullUpdate then
        return
    end

        if info.addedAuras then
            for _, v in pairs(info.addedAuras) do
                if v.isHelpful and v.auraInstanceID then
                    auraChange(unitGUID, v.spellId, nil, v.duration, v.dispelName)
                    if not auraID[unitGUID] then
                        auraID[unitGUID] = {}
                    end
                    auraID[unitGUID][v.auraInstanceID] = {unitGUID, v.spellId, v.duration, v.dispelName}
                end
            end
        end

    if info.updatedAuraInstanceIDs then
        for _, v in pairs(info.updatedAuraInstanceIDs) do
            if auraID[unitGUID] and auraID[unitGUID][v] then
                local dstGUID, spellID, duration, buffType = unpack(auraID[unitGUID][v])
                auraChange(dstGUID, spellID, nil, duration, buffType)
                break
            end
        end
    end

    if info.removedAuraInstanceIDs then
        for _, v in pairs(info.removedAuraInstanceIDs) do
            if auraID[unitGUID] and auraID[unitGUID][v] then
                local dstGUID, spellID, duration  = unpack(auraID[unitGUID][v])
                auraChange(dstGUID, spellID, nil, duration, nil, true)
                auraID[unitGUID][v] = nil
                break
            end
        end
    end
end

if next(callbacks.events) then
    callbacks.OnUsed()
end


lib.activeFrames = lib.activeFrames or {}
local activeFrames = lib.activeFrames
function lib:RegisterFrame(frame)
    activeFrames[frame] = true
    if next(activeFrames) then
        f:RegisterEvent("UNIT_AURA")
        f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    end
end
lib.Register = lib.RegisterFrame

function lib:UnregisterFrame(frame)
    activeFrames[frame] = nil
    if not next(activeFrames) then
        f:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        f:UnregisterEvent("UNIT_AURA")
    end
end
lib.Unregister = lib.UnregisterFrame