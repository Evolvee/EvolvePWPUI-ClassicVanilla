--[[	Modern TargetFrame Health Visibility Patch
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145
	https://www.curseforge.com/members/sdphantomgamer/projects	]]
--------------------------------------------------------------------------

if select(4,GetBuildInfo())<11404 then return; end

--------------------------
--[[	Namespace	]]
--------------------------
local AddOn=select(2,...);
AddOn.Options=AddOn.Options or {};

----------------------------------
--[[	Options Defaults	]]
----------------------------------
AddOn.Options.HealthVisibilityPatch=true;

------------------
--[[	Patch	]]
------------------
local HookedBars={};

local function ShouldKnowUnitHealth(unit)--	Lua implementation of how health obfuscation works in the current game
--	Note: Totems/Guardians/Etc are considered NPCs when it comes to health obfuscation
	local guid=UnitGUID(unit);
	local unittype=guid and guid:match("^(.-)%-");

	return	(unittype~="Player" and unittype~="Pet")--	Is NPC? (incl. totem/guardian/etc)
	or	(UnitIsUnit(unit,"player") or UnitIsUnit(unit,"pet"))--	Is player or player's pet?
	or	(UnitPlayerOrPetInRaid(unit) or UnitPlayerOrPetInParty(unit));--	Is in party/raid?
end

hooksecurefunc("UnitFrameHealthBar_Update",function(statusbar,unit)
	if AddOn.Options.HealthVisibilityPatch then
--		Verify if percent lock is set
		if statusbar and not statusbar.lockValues and unit==statusbar.unit and statusbar.showPercentage then
--			Re-evaluate and update text
			local known=ShouldKnowUnitHealth(unit); if known then
				statusbar.showPercentage=false;
				TextStatusBar_UpdateTextString(statusbar);
			end
		end
	end

--	Capture for options
	HookedBars[statusbar]=true;
end);

----------------------------------
--[[	Feature Registration	]]
----------------------------------
AddOn.RegisterFeature("HealthVisibilityPatch",function(key,enabled)
	local showhealthfunc=enabled and ShouldKnowUnitHealth or _G.ShouldKnowUnitHealth;--	Select between our custom function and Blizzard's version
	for statusbar in pairs(HookedBars) do
		local unit=statusbar.unit; if unit then
			statusbar.showPercentage=not showhealthfunc(unit);
			TextStatusBar_UpdateTextString(statusbar);
		end
	end
end);
