--[[	Modern TargetFrame
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145
	https://www.curseforge.com/members/sdphantomgamer/projects	]]
--------------------------------------------------------------------------

--------------------------
--[[	Namespace	]]
--------------------------
local Name,AddOn=...;
local Title=select(2,GetAddOnInfo(Name)):gsub("%s*v?[%d%.]+$","");
local Version=GetAddOnMetadata(Name,"Version");
local Author=GetAddOnMetadata(Name,"Author");

--------------------------
--[[	Saved Variables	]]
--------------------------
AddOn.Options=AddOn.Options or {};
local Defaults,Options=AddOn.Options,{};
ModernTargetFrame_Options=Options;

--------------------------
--[[	Options Panel	]]
--------------------------
local FeatureButtons={};
local Panel=CreateFrame("Frame"); do
	local title=Panel:CreateFontString(nil,"OVERLAY","GameFontNormalLarge");
	title:SetPoint("TOP",0,-12);
	title:SetText(Title);

	local author=Panel:CreateFontString(nil,"OVERLAY","GameFontNormalSmall");
	author:SetPoint("TOP",title,"BOTTOM",0,0);
	author:SetTextColor(1,0.5,0.25);
	author:SetFormattedText(AddOn.Localization.Options_ByAuthor_Format,Author);

	local ver=Panel:CreateFontString(nil,"OVERLAY","GameFontNormalSmall");
	ver:SetPoint("TOPLEFT",title,"TOPRIGHT",4,0);
	ver:SetTextColor(0.5,0.5,0.5);
	ver:SetText("v"..Version);
end

local function Options_Refresh()--	Runs on show
	for key,button in pairs(FeatureButtons) do button:SetChecked(Options[key]); end
end

local function Options_Default()--	Write Defaults to Options (Panel.refresh() runs afterward)
	for key,val in pairs(Defaults) do
		Options[key]=val;

		local button=FeatureButtons[key];
		if button then xpcall(button.Callback,CallErrorHandler,key,val); end
	end
end

local function Options_Okay()--	Changes stored in :SetChecked() state, save to Options
	for key,button in pairs(FeatureButtons) do
		local val=button:GetChecked();
		Options[key]=val;
		xpcall(button.Callback,CallErrorHandler,key,val);
	end
end

local function Options_Cancel()--	Fire callbacks with Options values (OnShow runs Panel.refresh())
	for key,button in pairs(FeatureButtons) do xpcall(button.Callback,CallErrorHandler,key,Options[key]); end
end

if Settings and (Settings.RegisterCanvasLayoutCategory and Settings.RegisterAddOnCategory) then
	Panel.OnCommit=Options_Okay;
	Panel.OnDefault=Options_Default;
	Panel.OnRefresh=Options_Refresh;

	local category=Settings.RegisterCanvasLayoutCategory(Panel,Title);
	category.ID=Title;
	Settings.RegisterAddOnCategory(category);
else
	Panel.name=Title;
	Panel.okay=Options_Okay;
	Panel.cancel=Options_Cancel;
	Panel.default=Options_Default;
	Panel.refresh=Options_Refresh;
	InterfaceOptions_AddCategory(Panel);
end

--------------------------
--[[	Event Handler	]]
--------------------------
Panel:RegisterEvent("ADDON_LOADED");
Panel:SetScript("OnEvent",function(self,event,...)
	if event=="ADDON_LOADED" and (...)==Name then
		Defaults,Options=AddOn.Options,ModernTargetFrame_Options;
		AddOn.Options=Options;--	Sync options

--		Trim/Fill Options
		for key,val in pairs(Defaults) do if type(Options[key])~=type(val) then Options[key]=val; end end
		for key,val in pairs(Options) do if Defaults[key]==nil then Options[key]=nil; end end

--		Send updates to modules
		for key,button in pairs(FeatureButtons) do xpcall(button.Callback,CallErrorHandler,key,Options[key]); end

--		Don't need this event anymore
		self:UnregisterEvent(event);
	end
end);

----------------------------------
--[[	Feature Registration	]]
----------------------------------
local FeatureCount=0;

local function FeatureButton_OnClick(self) xpcall(self.Callback,CallErrorHandler,self.Key,self:GetChecked()); end

function AddOn.RegisterFeature(key,callback)
	if FeatureButtons[key] then return; end--	Return button if exists

--	Create Button
	local button=CreateFrame("CheckButton",nil,Panel,"UICheckButtonTemplate");
	button:SetPoint("TOPLEFT",32,-48-(FeatureCount*24));

--	Initialize
	button:SetFontString(button.Text or button.text);--	Classic Vanilla (1.13.3) hasn't been updated to use .Text yet
	button:SetNormalFontObject(GameFontNormalSmall);
	button:SetDisabledFontObject(GameFontDisableSmall);
	button:SetText(AddOn.Localization["Options_FeatureName_"..key]);
	if callback then
		button.Key,button.Callback=key,callback;
		button:SetScript("OnClick",FeatureButton_OnClick);
	end

--	Link to Panel & Increment Counter
	FeatureButtons[key],FeatureCount=button,FeatureCount+1;
	return button;
end
