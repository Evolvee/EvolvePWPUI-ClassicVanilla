local COMPAT, addonName, T = select(4, GetBuildInfo()), ...
local MODERN, CI_ERA = COMPAT >= 10e4, COMPAT < 2e4
local AB = T.ActionBook:compatible(2, 35)
local KR = T.ActionBook:compatible("Kindred", 1, 11)
local IM = T.ActionBook:compatible("Imp", 1, 0)
local EV, MC, XU = T.Evie, T.M6Core, T.exUI
local L = setmetatable({}, {__call=function(_,k) return k end})
local M = {}

do -- EscapeCallback
	local getInfo, setInfo do
		local info = {}
		function getInfo(k)
			return info[k]
		end
		function setInfo(k, v)
			info[k] = v
		end
	end
	local function noop() end
	local function ESC_OnKeyDown(self, key)
		local it = getInfo(self)
		if key and (key == "ESCAPE" or key == it[3]) and GetCurrentKeyBoardFocus() == nil and not it[2](it[1], key) then
			return
		end
		local a, b = it[4], it[5]
		a:SetScript("OnKeyDown", nil)
		b:SetScript("OnKeyDown", noop)
		it[4], it[5] = b, a
	end
	function M:EscapeCallback(parent, key2, callback)
		if callback == nil then
			callback, key2 = key2, nil
		end
		local f0 = CreateFrame("Frame", nil, parent)
		local f1 = CreateFrame("Frame", nil, parent)
		local f2 = CreateFrame("Frame", nil, parent)
		setInfo(f0, {parent, callback, key2, f1, f2})
		f0:SetPropagateKeyboardInput(true)
		f0:SetScript("OnKeyDown", ESC_OnKeyDown)
		f1:SetScript("OnKeyDown", noop)
	end
end

local MacroTooltip = CreateFrame("GameTooltip", "M6MacroTooltip", UIParent) do
	MacroTooltip:SetFrameStrata("TOOLTIP")
	local title = MacroTooltip:CreateFontString(nil, "ARTWORK", "GameFontNormalMed2")
	local title2 = MacroTooltip:CreateFontString(nil, "ARTWORK", "GameFontNormalMed1")
	local desc = MacroTooltip:CreateFontString(nil, "ARTWORK", "GameFontHighlightLeft")
	title:SetPoint("TOPLEFT", 8, -8)
	title:SetJustifyH("LEFT")
	title2:SetJustifyH("RIGHT")
	title2:SetPoint("TOPRIGHT", -8, -8)
	title2:SetPoint("TOPLEFT", title, "TOPRIGHT", 12, 0)
	title2:SetTextColor(0.80, 0.80, 0.80)
	desc:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -3)
	desc:SetPoint("TOPRIGHT", title2, "BOTTOMRIGHT", 0, -3)
	MacroTooltip:AddFontStrings(title, title2)
	MacroTooltip:AddFontStrings(desc, MacroTooltip:CreateFontString())
	XU:Create("Backdrop", MacroTooltip, {edgeFile="Interface/Tooltips/UI-Tooltip-Border", bgFile="Interface/DialogFrame/UI-DialogBox-Background-Dark", tile=true, edgeSize=16, tileSize=16, insets={left=4,right=4,bottom=4,top=4}})
	MacroTooltip:SetScript("OnTooltipCleared", function(self)
		self:SetWidth(0)
	end)
end
local function shiftInputFocus(self)
	local focus = self.nextInput
	if IsShiftKeyDown() then
		focus = self.prevInput
	end
	if focus then
		focus:SetFocus()
	end
end
local multilineInput do
	local function onNavigate(self, _x,y, _w,h)
		local scroller = self.scroll
		local occH, occP, y = scroller:GetHeight(), scroller:GetVerticalScroll(), -y
		if occP > y then
			occP = y -- too far
		elseif (occP + occH) < (y+h) then
			occP = y+h-occH -- not far enough
		else
			return
		end
		scroller:SetVerticalScroll(occP)
		local _, mx = scroller.ScrollBar:GetMinMaxValues()
		occP = (mx-occP)^2 < 1 and mx or math.floor(occP)
		scroller.ScrollBar:SetMinMaxValues(0, occP < mx and mx or occP)
		scroller.ScrollBar:SetValue(occP)
	end
	local function onClick(self)
		self.input:SetFocus()
	end
	function multilineInput(name, parent, width)
		local scroller = CreateFrame("ScrollFrame", name .. "Scroll", parent, "UIPanelScrollFrameTemplate")
		local input = CreateFrame("Editbox", name, scroller)
		input:SetWidth(width-12)
		input:SetMultiLine(true)
		input:SetAutoFocus(false)
		input:SetTextInsets(2,4,0,2)
		input:SetFontObject(GameFontHighlight)
		input:SetScript("OnCursorChanged", onNavigate)
		input:SetScript("OnEscapePressed", input.ClearFocus)
		input:SetScript("OnTabPressed", shiftInputFocus)
		scroller:EnableMouse(1)
		scroller:SetScript("OnMouseDown", onClick)
		scroller:SetScrollChild(input)
		input.scroll, scroller.input = scroller, input
		return input, scroller
	end
end

local mainPanel = CreateFrame("Frame", "M6UI", UIParent, "PortraitFrameTemplate") do
	local currentFilter = "all"

	local f = mainPanel do
		f.portrait = f.portrait or f.PortraitContainer.portrait
		f.TitleText = f.TitleText or f.TitleContainer.TitleText
		f:SetWidth(578)
		f:SetFrameStrata("HIGH")
		f:SetToplevel(true)
		f:Hide()
		SetPortraitToTexture(f.portrait, MODERN and "interface/icons/secrets_of_the_empire_icon" or "interface/icons/inv_misc_gear_01")
		f.Bg:SetTexture("Interface\\garrison\\GarrisonMissionUIInfoBoxBackgroundTile", true, true)
		f.Bg:SetTexture("Interface\\FrameGeneral\\UI-Background-Marble", true, true)
		f.Bg:SetDrawLayer("BACKGROUND", -5)
		f.Bg1 = f:CreateTexture(nil, "BACKGROUND", nil, -4)
		f.Bg1:SetTexture("Interface\\FrameGeneral\\UI-Background-Rock", true, true)
		f.Bg1:SetHorizTile(true)
		f.Bg1:SetPoint("TOPLEFT", 2, -24)
		f.Bg1:SetPoint("TOPRIGHT", -2, -24)
		f.Bg1:SetTexCoord(0,1,0,40/256)
		f.Bg1:SetHeight(38)
		f.BgSep = f:CreateTexture(nil, "BORDER", nil, 4)
		f.BgSep:SetPoint("TOPLEFT", f.Bg1, "BOTTOMLEFT", 0, 1)
		f.BgSep:SetPoint("TOPRIGHT", f.Bg1, "BOTTOMRIGHT", 0, 1)
		f.BgSep:SetHeight(8)
		f.BgSep:SetTexture("Interface\\FrameGeneral\\_UI-Frame", true, false)
		f.BgSep:SetTexCoord(0,1, 28/128, 35/128)
		f.Status = f:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
		f.Status:SetPoint("RIGHT", f, "TOPRIGHT", -16, -42);
		f.TitleText:SetText(addonName)
		f:EnableMouse(true)
		f:SetMovable(true)
		f:SetClampedToScreen(true)
		f:SetClampRectInsets(-10, 0, 12, 0)
		do -- Move Handles
			local function Mover_OnDown(_, button)
				if button == "LeftButton" then
					mainPanel:StartMoving()
				end
			end
			local function Mover_OnUp()
				mainPanel:StopMovingOrSizing()
			end
			local function Mover_OnEnter()
				SetCursor("Interface/CURSOR/UI-Cursor-Move.crosshair")
			end
			local function Mover_OnLeave()
				SetCursor(nil)
			end
			local h = CreateFrame("Frame", nil, mainPanel)
			h:SetAllPoints(MODERN and f.PortraitContainer.portrait or f.portrait)
			h:SetScript("OnMouseDown", Mover_OnDown)
			h:SetScript("OnMouseUp", Mover_OnUp)
			h:SetScript("OnEnter", Mover_OnEnter)
			h:SetScript("OnLeave", Mover_OnLeave)
			h = CreateFrame("Frame", nil, mainPanel)
			h:SetPoint("TOPLEFT", f.TitleText, "TOPLEFT", -4, 6)
			h:SetPoint("BOTTOMRIGHT", f.TitleText, "BOTTOMRIGHT", 32, -6)
			h:SetScript("OnMouseDown", Mover_OnDown)
			h:SetScript("OnMouseUp", Mover_OnUp)
			h:SetScript("OnEnter", Mover_OnEnter)
			h:SetScript("OnLeave", Mover_OnLeave)
		end
		
		local function HasOtherClosableThings()
			if GetUIPanel("left") or GetUIPanel("center") or GetUIPanel("right") or GetUIPanel("doublewide") or GetUIPanel("fullscreen") then
				return true
			end
			for i=1, NUM_CONTAINER_FRAMES do
				if _G["ContainerFrame"..i]:IsShown() then
					return true
				end
			end
			for i=1, #UISpecialFrames do
				local frame = _G[UISpecialFrames[i]]
				if frame and frame.IsForbidden and not frame:IsForbidden() and frame:IsShown() then
					return true
				end
			end
			return false
		end
		M:EscapeCallback(f, function(self, key)
			local closeMe = key == "ESCAPE" and not securecall(HasOtherClosableThings)
			if closeMe then
				self:Hide()
			end
			return not closeMe
		end)
	end
	local contentSlot = CreateFrame("Frame", nil, mainPanel) do
		contentSlot:SetPoint("TOPLEFT", f.BgSep, "BOTTOMLEFT", 0, 4)
		contentSlot:SetPoint("BOTTOMRIGHT", 0, 0)
	end
	local sf, bar, slate = CreateFrame("Frame", nil, contentSlot) do
		sf:SetPoint("TOPLEFT", 0, -1)
		sf:SetPoint("BOTTOMRIGHT", -24, 5)
		local clipRoot = CreateFrame("Frame", nil, sf)
		clipRoot:SetClipsChildren(true)
		clipRoot:SetAllPoints()
		slate = CreateFrame("Frame", nil, clipRoot)
		slate:SetSize(mainPanel:GetWidth()-28, 400)
		bar = XU:Create("ScrollBar", nil, sf) do
			bar:SetPoint("TOPLEFT", sf, "TOPRIGHT", 1, 0)
			bar:SetPoint("BOTTOMLEFT", sf, "BOTTOMRIGHT", 1, 0)
			bar:SetWheelScrollTarget(sf)
			bar:SetScript("OnValueChanged", function(_, v, _isUserInteraction)
				slate:SetPoint("TOPLEFT", 0, v)
			end)
		end
		f.scrollList, sf.bar, sf.slate = sf, bar, slate
		local newMacro = CreateFrame("Button", nil, sf) do
			newMacro:SetNormalTexture("Interface/GuildBankFrame/UI-GuildBankFrame-NewTab")
			newMacro:SetPushedTexture("Interface/GuildBankFrame/UI-GuildBankFrame-NewTab")
			newMacro:GetPushedTexture():SetTexCoord(-0.02, 0.98, -0.02, 0.98)
			newMacro:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square")
			newMacro:SetSize(24, 24)
			newMacro:SetScript("OnEnter", function(self)
				GameTooltip:SetOwner(self, "ANCHOR_NONE")
				GameTooltip:SetPoint("LEFT", self, "RIGHT", 4, 0)
				GameTooltip:SetText(L"Create a new macro")
			end)
			newMacro:SetScript("OnLeave", function(self)
				if GameTooltip:IsOwned(self) then
					GameTooltip:Hide()
				end
			end)
			newMacro:SetPoint("TOPLEFT", mainPanel, "TOPLEFT", 62, -32)
			newMacro:SetScript("OnClick", function()
				PlaySound(SOUNDKIT.IG_CHARACTER_INFO_OPEN)
				M:OpenEditor(0)
			end)
		end
		local filterButton = CreateFrame("Button", nil, sf, "UIMenuButtonStretchTemplate") do
			filterButton:SetSize(92, 22)
			filterButton:SetText(L"Filter")
			filterButton:SetPoint("TOPRIGHT", mainPanel, "TOPRIGHT", -12, -36)
			local t = filterButton:CreateTexture(nil, "ARTWORK")
			t:SetTexture("Interface/ChatFrame/ChatFrameExpandArrow")
			t:SetSize(10,12)
			t:SetPoint("RIGHT", filterButton.MiddleRight, "RIGHT", -5, 0)
			filterButton.Icon = t
			local drop = CreateFrame("Frame", "M6UIFilterDropDown", filterButton, "UIDropDownMenuTemplate")
			filterButton:SetScript("OnClick", function(self)
				PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
				ToggleDropDownMenu(1, nil, drop, self, 0, 0)
				DropDownList1:ClearAllPoints()
				DropDownList1:SetPoint("TOPRIGHT", self, "BOTTOMRIGHT", 8, 6)
			end)
			function filterButton:HandlesGlobalMouseEvent()
				return true
			end
			local function setFilter(_, fv)
				M:SetFilter(fv, true)
				-- SD's short menu fallback to UIDD doesn't close the top-level menu
				CloseDropDownMenus()
			end
			local filters={"All","all", "Currently active","active", "Key-bound","keybound", "Inactive","inactive"}
			local function groupEntryFormat(k, list)
				return list._m[k], list._cv == k
			end
			function drop:initialize(level, nameList)
				if level == 2 then
					XU:Create("ScrollableDropDownList", 2, nameList, groupEntryFormat, setFilter, false)
					return
				end
				local cv = M:GetFilter()
				local info = {func=setFilter}
				for i=1,#filters, 2 do
					local fv = filters[i+1]
					info.text, info.arg1, info.checked = filters[i], fv, cv == fv
					UIDropDownMenu_AddButton(info)
				end
				local a, m = {}, {}
				for gid, name in MC:AllGroups() do
					m[gid], a[#a+1] = name, gid
				end
				if #a > 0 then
					table.sort(a, function(a,b) return strcmputf8i(m[a], m[b]) < 0 end)
					UIDropDownMenu_AddSeparator()
					local primaryLimit = #a > 12 and 8 or #a
					for i=1,primaryLimit do
						local fv = a[i]
						info.text, info.arg1, info.checked = m[fv], fv, fv == cv
						UIDropDownMenu_AddButton(info)
					end
					if primaryLimit < #a then
						info.hasArrow, info.notCheckable, info.padding, info.fontObject = 1, 1, 32, GameFontNormalSmall
						info.text, info.func, info.checked = nil
						info.menuList, info.text = a, L"More groups"
						a._m, a._cv = m, cv
						UIDropDownMenu_AddButton(info)
					end
				end
			end
			local filterResetButton = CreateFrame("Button", nil, filterButton) do
				local b = filterResetButton
				b:SetSize(23,23)
				b:SetPoint("CENTER", filterButton, "TOPRIGHT", -3, 0)
				b:SetNormalAtlas("auctionhouse-ui-filter-redx")
				b:SetHighlightAtlas("auctionhouse-ui-filter-redx")
				b:GetHighlightTexture():SetBlendMode("ADD")
				b:GetHighlightTexture():SetAlpha(0.4)
				b:SetScript("OnClick", function()
					PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
					M:SetFilter("all", true)
					if UIDROPDOWNMENU_OPEN_MENU == drop then
						CloseDropDownMenus()
					end
				end)
			end
			mainPanel.FilterButton, filterButton.Reset = filterButton, filterResetButton
		end
		mainPanel.Instruction = sf:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
		mainPanel.Instruction:SetPoint("BOTTOM", sf, "TOP", 10, 12)
		mainPanel.Instruction:SetText(L"Right click on a macro for options.")
	end
	local editPanel, getEditMacroText, setEditMacroText, clearMacroEditor = CreateFrame("Frame", nil, contentSlot) do
		editPanel:SetPoint("TOPLEFT", sf, "TOPLEFT", 0, 0)
		editPanel:SetPoint("BOTTOMRIGHT", sf, "BOTTOMRIGHT", 20, 0)
		editPanel:Hide()
		local ebox, eboxFirst, eboxLast = {}
		local host, editorHost = AB:CreateEditorHost(editPanel) do
			host:SetPoint("TOPLEFT", 6, -73)
			host:SetPoint("BOTTOMRIGHT", -8, 34)
			local tt = {}
			function getEditMacroText()
				editorHost:GetAction(tt)
				return tt[2]
			end
			function setEditMacroText(text)
				editorHost:SetAction({"imptext", text})
			end
			function clearMacroEditor()
				editorHost:Clear()
			end
			function host:OnTabPressed()
				shiftInputFocus(ebox)
			end
			local function box_SetFocus(self)
				local w = editorHost:GetTabFocusWidget(self == eboxFirst and 1 or self == eboxLast and -1 or 0)
				if w then
					w:SetFocus()
				end
			end
			ebox.SetFocus, ebox.GetText = box_SetFocus, getEditMacroText
			eboxFirst = {SetFocus=ebox.SetFocus}
			eboxLast = {SetFocus=ebox.SetFocus}
			editPanel.box = ebox
		end
		local nbox = XU:Create("LineInput", nil, editPanel) do
			nbox:SetWidth(200)
			nbox:SetPoint("LEFT", editPanel, "TOPLEFT", 120, -12)
			nbox:SetScript("OnTabPressed", shiftInputFocus)
			local lab = nbox:CreateFontString(nil, "ARTWORK", "GameFontNormal")
			lab:SetText(L"Name:")
			lab:SetPoint("LEFT", editPanel, "TOPLEFT", 8, -12)
			editPanel.nameBox = nbox
		end
		local gbox = XU:Create("LineInput", nil, editPanel) do
			gbox:SetWidth(145)
			gbox:SetPoint("LEFT", nbox, "RIGHT", 100, 0)
			gbox:SetScript("OnTabPressed", shiftInputFocus)
			local lab = gbox:CreateFontString(nil, "ARTWORK", "GameFontNormal")
			lab:SetText(L"Group:")
			lab:SetPoint("LEFT", nbox, "RIGHT", 35, 0)
			editPanel.groupNameBox = gbox
		end
		gbox.nextInput, gbox.prevInput = eboxFirst, nbox
		nbox.nextInput, nbox.prevInput = gbox, eboxLast
		ebox.nextInput, ebox.prevInput = nbox, gbox
		local bind = CreateFrame("Button", nil, editPanel, "UIPanelButtonTemplate") do
			bind:SetWidth(260)
			bind:SetPoint("LEFT", editPanel, "TOPLEFT", 120-6, -54)
			bind:RegisterForClicks("AnyUp")
			bind:SetFrameLevel(bind:GetFrameLevel()+20)
			local lab = bind:CreateFontString(nil, "ARTWORK", "GameFontNormal")
			lab:SetText(L"Binding:")
			lab:SetPoint("LEFT", editPanel, "TOPLEFT", 8, -54)
			local glob = CreateFrame("CheckButton", nil, bind, "InterfaceOptionsCheckButtonTemplate") do
				glob:SetPoint("LEFT", bind, "RIGHT", 2, -1)
				glob.Text:SetText(L"Global binding")
				glob:SetHitRectInsets(0, -glob.Text:GetStringWidth()-5, 0,0)
				glob:SetScript("OnClick", nil)
				bind.glob = glob
			end
			
			local alternateFrame = CreateFrame("Frame", nil, bind) do
				XU:Create("Backdrop", alternateFrame, { bgFile="Interface/ChatFrame/ChatFrameBackground", edgeFile="Interface/DialogFrame/UI-DialogBox-Border", tile=true, tileSize=32, edgeSize=32, insets={left=11, right=11, top=12, bottom=10}, bgColor=0xd8000000})
				alternateFrame:SetSize(320, 115)
				alternateFrame:EnableMouse(1)
				alternateFrame:SetScript("OnHide", alternateFrame.Hide)
				local extReminder = CreateFrame("BUTTON", nil, alternateFrame)
				extReminder:SetHeight(16) extReminder:SetPoint("TOPLEFT", 12, -10) extReminder:SetPoint("TOPRIGHT", -12, -10)
				extReminder:SetNormalTexture("Interface/Buttons/UI-OptionsButton")
				extReminder:SetPushedTextOffset(0,0)
				extReminder:SetText(" ") extReminder:SetNormalFontObject(GameFontHighlightSmall) do
					local fs, tex = extReminder:GetFontString(), extReminder:GetNormalTexture()
					fs:ClearAllPoints() tex:ClearAllPoints()
					fs:SetPoint("LEFT", 18, -1) tex:SetSize(14,14) tex:SetPoint("LEFT")
				end
				alternateFrame.caption = extReminder
				extReminder:SetScript("OnEnter", function(self)
					GameTooltip:SetOwner(self, "ANCHOR_NONE")
					GameTooltip:SetPoint("TOP", self, "BOTTOM")
					GameTooltip:AddLine(L"Conditional Bindings", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
					GameTooltip:AddLine(L"The binding will update to reflect the value of this macro conditional.", HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, 1)
					GameTooltip:AddLine((L"You may use extended macro conditionals; see |cff33DDFF%s|r for details."):format("https://townlong-yak.com/addons/m6/conditionals"), HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, 1)
					GameTooltip:AddLine((L"Example: %s."):format(GREEN_FONT_COLOR_CODE .. "[combat] ALT-C; [nomounted] CTRL-F|r"), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
					GameTooltip:Show()
				end)
				extReminder:SetScript("OnLeave", function(self)
					if GameTooltip:IsOwned(self) then
						GameTooltip:Hide()
					end
				end)
				extReminder:SetScript("OnHide", extReminder:GetScript("OnLeave"))
				local input, scroll = multilineInput("M6_AlternateBindInput", alternateFrame, 335)
				alternateFrame.input, alternateFrame.scroll = input, scroll
				scroll:SetPoint("TOPLEFT", 10, -28)
				scroll:SetPoint("BOTTOMRIGHT", -33, 10)
				input:SetMaxBytes(1023)
				input:SetScript("OnEscapePressed", function() M:HideEditorModal(alternateFrame) end)
				input:SetScript("OnChar", function(self, c)
					if c == "\n" then
						local bind = strtrim((self:GetText():gsub("[\r\n]", "")))
						if bind ~= "" then
							alternateFrame.owner:SetBinding(bind)
						end
						M:HideEditorModal(alternateFrame)
					end
				end)
			end
			
			local function Deactivate(self)
				self:UnlockHighlight()
				self:EnableKeyboard(false)
				self:SetScript("OnHide", nil)
				self:SetScript("OnUpdate", nil)
				self:SetScript("OnKeyDown", nil)
				self:SetScript("OnGamePadButtonDown", nil)
				self:SetScript("OnMouseWheel", nil)
				self.capture = nil
				self:GetHighlightTexture():SetAlpha(0.25)
				if self.oldFocus then
					self.oldFocus:SetFocus()
					self.oldFocus = nil
				end
			end
			local function WatchFocus(self)
				if GetCurrentKeyBoardFocus() then
					self.oldFocus = nil
					Deactivate(self)
				end
			end
			local function GetCurrentModifiers()
				return (IsAltKeyDown() and "ALT-" or "") ..  (IsControlKeyDown() and "CTRL-" or "") .. (IsShiftKeyDown() and "SHIFT-" or "") .. (IsMetaKeyDown() and "META-" or "")
			end
			local unbindableKeys = {
				UNKNOWN=1, ESCAPE=1, ALT=1, SHIFT=1, META=1,
				LALT=1, LCTRL=1, LSHIFT=1, LMETA=1,
				RALT=1, RCTRL=1, RSHIFT=1, RMETA=1,
				PADRSTICKUP=1, PADRSTICKDOWN=1, PADRSTICKLEFT=1, PADRSTICKRIGHT=1,
				PADLSTICKUP=1, PADLSTICKDOWN=1, PADLSTICKLEFT=1, PADLSTICKRIGHT=1,
			}
			local function SetBind(self, bind)
				if bind == "ESCAPE" then
					return Deactivate(self)
				elseif unbindableKeys[bind] then
					return
				elseif bind and bind:match("PAD") and (
				         bind == GetCVar("GamePadEmulateAlt") or
				         bind == GetCVar("GamePadEmulateCtrl") or
				         bind == GetCVar("GamePadEmulateShift")
				       ) then
					return
				elseif GetCurrentKeyBoardFocus() then
					self.oldFocus = nil
					return Deactivate(self)
				end
				self:SetBinding(GetCurrentModifiers() .. bind)
			end
			local function SetWheelBind(self, delta)
				SetBind(self, delta > 0 and "MOUSEWHEELUP" or "MOUSEWHEELDOWN")
			end
			local buttonMap = {LeftButton="BUTTON1", RightButton="BUTTON2", MiddleButton="BUTTON3"}
			bind:SetScript("OnClick", function(self, button)
				if button == "LeftButton" then
					if self.capture then
						Deactivate(self)
					elseif IsAltKeyDown() then
						if alternateFrame:IsShown() and alternateFrame.owner == self then
							M:HideEditorModal(alternateFrame)
						else
							alternateFrame.owner = self
							alternateFrame.caption:SetText(L"Press ENTER to save.")
							alternateFrame.input:SetText(self.value or "")
							alternateFrame:SetParent(self)
							alternateFrame:SetFrameLevel(self:GetFrameLevel()+10)
							alternateFrame:ClearAllPoints()
							alternateFrame:SetPoint("TOP", self, "BOTTOM", 0, 4)
							if alternateFrame:GetLeft() < self:GetParent():GetLeft() then
								alternateFrame:SetPoint("TOPLEFT", self, "BOTTOMLEFT", -8, 4)
							elseif alternateFrame:GetRight() > self:GetParent():GetRight() then
								alternateFrame:SetPoint("TOPRIGHT", self, "BOTTOMRIGHT", 8+22, 4)
							end
							M:ShowEditorModal(alternateFrame)
							alternateFrame.input:SetFocus()
						end
					else
						self.capture = true
						self:LockHighlight()
						self:GetHighlightTexture():SetAlpha(1)
						self:SetScript("OnHide", Deactivate)
						self:SetScript("OnUpdate", WatchFocus)
						self:SetScript("OnKeyDown", SetBind)
						self:SetScript("OnGamePadButtonDown", SetBind)
						self:SetScript("OnMouseWheel", SetWheelBind)
						M:HideEditorModal(nil)
						local kf = GetCurrentKeyBoardFocus()
						if kf and kf.ClearFocus and kf.SetFocus then
							kf:ClearFocus()
							self.oldFocus = kf
						end
					end
				elseif button == "RightButton" then
					if self.capture then
						self:SetBinding(nil)
					end
				elseif self.capture then
					self:SetBinding(GetCurrentModifiers() .. (buttonMap[button] or button:upper()))
				end
			end)
			local specialSymbolMap = {OPEN="[", CLOSE="]", SEMICOLON=";"}
			local function FormatBindingText(bind)
				local bindText = bind and bind ~= "" and GetBindingText((bind:gsub("[^%-]+$", specialSymbolMap)))
				if CI_ERA and bindText and bind:match("PAD") then
					for ai in bindText:gmatch("|A:([^:]+)") do
						if not C_Texture.GetAtlasInfo(ai) then -- BUG[1.14.4/2310]
							bindText = bind:gsub("[^%-]+$", specialSymbolMap)
							break
						end
					end
				end
				return bindText or NONE_KEY
			end
			function bind:SetBinding(bind)
				self.value = bind ~= "" and bind or nil
				if self.value and bind:match("%[.*%]") then
					local cv = KR:EvaluateCmdOptions(self.value)
					self:SetText(FormatBindingText(cv) .. " |cff20ff20[+]")
				else
					self:SetText(FormatBindingText(self.value))
				end
				Deactivate(self)
			end
			bind.Deactivate = Deactivate
			editPanel.bind = bind
		end
		local ico, isd = CreateFrame("Button", nil, editPanel) do
			ico:SetSize(204, 18)
			ico:SetPoint("LEFT", editPanel, "TOPLEFT", 120, -33)
			ico:RegisterForClicks("AnyUp")
			ico:SetNormalFontObject(GameFontHighlightSmall2)
			ico:SetHighlightFontObject(GameFontHighlightSmall2)
			ico:SetText("!")
			local fs = ico:GetFontString()
			fs:ClearAllPoints()
			fs:SetPoint("LEFT", 24, 0)
			ico:SetNormalTexture("Interface\\Icons\\INV_Misc_QuestionMark")
			local nt = ico:GetNormalTexture()
			nt:ClearAllPoints()
			nt:SetSize(18, 18)
			nt:SetPoint("LEFT")
			ico:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square")
			local ht = ico:GetHighlightTexture()
			ht:SetAllPoints(nt)
			local lab = ico:CreateFontString(nil, "ARTWORK", "GameFontNormal")
			lab:SetText(L"Icon:")
			lab:SetPoint("LEFT", editPanel, "TOPLEFT", 8, -33)
			isd = XU:Create("IconSelector", nil, ico)
			isd:SetGridSize(7, 12)
			isd:SetPoint("TOPLEFT", ico, "BOTTOMLEFT", -20, 4)
			isd:SetHitRectInsets(-100, 0, 0, 0)
			isd:SetScript("OnIconSelect", function(_, asset)
				ico:SetIcon(asset)
			end)
			isd:SetScript("OnEditFocusGained", function(self, editbox)
				local nc = NORMAL_FONT_COLOR
				GameTooltip:SetOwner(editbox, "ANCHOR_NONE")
				if editbox:GetBottom() < 120 then
					GameTooltip:SetPoint("BOTTOMLEFT", editbox, "TOPLEFT", -6, 0)
				else
					GameTooltip:SetPoint("TOPLEFT", editbox, "BOTTOMLEFT", -6, 0)
				end
				GameTooltip:AddLine(L"Override Icon", 1,1,1)
				GameTooltip:AddLine(L"Specify an icon by entering an icon file name, texture path, atlas name, or a known ability name.", nc.r, nc.g, nc.b, 1)
				if self:IsSearchPossible() then
					GameTooltip:AddLine((L"Press %s to search"):format(HIGHLIGHT_FONT_COLOR_CODE .. GetBindingText("ALT-ENTER") .. "|r"), nc.r, nc.g, nc.b, 1)
				else
					local at = HIGHLIGHT_FONT_COLOR_CODE .. "IconFileNames |cff606060<|cff40a0ffhttps://townlong-yak.com/addons/iconfilenames|r>|r|r"
					GameTooltip:AddLine((L"Install and enable %s to search by file name."):format(at), nc.r, nc.g, nc.b, 1)
				end
				GameTooltip:Show()
			end)
			isd:SetScript("OnEditFocusLost", function(_, editbox)
				if GameTooltip:IsOwned(editbox) then
					GameTooltip:Hide()
				end
			end)
			ico:SetScript("OnClick", function()
				M[isd:IsShown() and "HideEditorModal" or "ShowEditorModal"](M, isd)
				PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON)
			end)
			isd.SetFocus = isd.FocusManualInput
			function ico:SetIcon(tex, ...)
				self.value = tex
				if select("#", ...) == 1 then
					self.dynamicIcon = ...
				end
				self:SetText(tex and L"Static custom icon" or L"Determined by macro content")
				self:SetNormalTexture(tex or self.dynamicIcon or "Interface\\Icons\\INV_Misc_QuestionMark")
				isd:SetFirstAsset(tex or self.dynamicIcon)
				isd:SetSelectedAsset(tex)
			end
			editPanel.icon = ico
		end
		local save = CreateFrame("Button", nil, editPanel, "UIPanelButtonTemplate")
		save:SetWidth(120)
		save:SetText(L"Save")
		save:SetPoint("BOTTOMRIGHT", -2, 4)
		save:SetScript("OnClick", function() PlaySound(SOUNDKIT.GS_TITLE_OPTION_OK) M:SaveEditor() end)
		local cancel = CreateFrame("Button", nil, editPanel, "UIPanelButtonTemplate")
		cancel:SetWidth(120)
		cancel:SetText(L"Cancel")
		cancel:SetPoint("RIGHT", save, "LEFT", -16, 0)
		cancel:SetScript("OnClick", function()
			PlaySound(SOUNDKIT.GS_TITLE_OPTION_EXIT)
			editPanel:Hide()
			sf:Show()
		end)
		M:EscapeCallback(editPanel, "TAB", function(s, key)
			if key == "ESCAPE" then
				if isd:IsShown() then
					isd:Hide()
				else
					cancel:Click()
				end
			elseif key == "TAB" then
				local focusBox = isd:IsShown() and isd or s.nameBox:GetText() == "" and ebox:GetText() == "" and s.nameBox or ebox
				focusBox:SetFocus()
			end
		end)
	end
	local menu, drop = {
		{text="Place on action bars", func=function(_, id) MC:PickupAction(id) M:SyncContent() end, notCheckable=true},
		{text="Deactivate", notCheckable=true, func=function(_, id) MC:DeactivateAction(id) M:SyncContent() end},
		{text="|cffff0000Delete", notCheckable=true, func=function(_, id) MC:DeleteAction(id) M:ReFilter() end},
	}, CreateFrame("Frame", "M6ActionsDropDown", slate, "UIDropDownMenuTemplate")
	
	local function Button_OnClick(self, button)
		local id = self:GetID()
		if id == 0 or button == "LeftButton" then
			PlaySound(SOUNDKIT.IG_QUEST_LIST_OPEN)
			M:OpenEditor(id)
		elseif UIDROPDOWNMENU_OPEN_MENU == drop and DropDownList1:IsVisible() and menu[1].arg1 == id then
			CloseDropDownMenus()
		elseif button == "RightButton" then
			for i=1,#menu do
				menu[i].arg1 = id
			end
			menu[2].disabled = not MC:IsActionActivated(id)
			EasyMenu(menu, drop, "cursor", 9000, 9000, "MENU", 4)
			DropDownList1:ClearAllPoints()
			DropDownList1:SetPoint("TOPLEFT", self, "TOPRIGHT", 1, 8)
		end
	end
	local function Button_OnDrag(self)
		local id = self:GetID()
		if id > 0 and (IsShiftKeyDown() or MC:IsActionActivated(id)) then
			MC:PickupAction(id)
			M:SyncContent()
		end
	end
	local function Button_OnEnter(self)
		local id = self:GetID()
		local name = id == 0 and "Create new macro" or MC:GetActionName(id)
		local group = id ~= 0 and MC:GetActionGroup(id)
		MacroTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
		MacroTooltip:AddDoubleLine(name or "Unnamed macro", group or "", nil, nil, nil, 0.60, 0.60, 0.60)
		if id ~= 0 then
			local mt, text = MC:GetAction(id)
			if type(text) ~= "string" then
				text = ""
			elseif mt == "imptext" then
				text = (IsAltKeyDown() and IM.DecodeTokens or IM.FormatTokens)(IM, text)
			end
			local pat = "^(" .. ("[^\n]*\n"):rep(20) .. ").+"
			MacroTooltip:AddLine(text ~= "" and text:gsub(pat, "%1|cff909090[...]") or ("|cff909090" .. L"Blank"), 1,1,1,1)
		end
		MacroTooltip:Show()
	end
	local function Button_OnLeave(self)
		if MacroTooltip:IsOwned(self) then
			MacroTooltip:Hide()
		end
	end
	local function CreateButton(p, w)
		local b = CreateFrame("Button", nil, p)
		b:SetSize(w,w)
		b:SetNormalTexture("Interface/Icons/Temp")
		b:GetNormalTexture():SetAlpha(0)
		b.Icon = b:CreateTexture(nil, "BACKGROUND")
		b.Icon:SetPoint("TOPRIGHT", -2, -2)
		b.Icon:SetPoint("BOTTOMLEFT", 2, 2)
		b:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square")
		b:SetPushedTexture("Interface/Buttons/UI-Quickslot-Depress")
		b:GetPushedTexture():SetAllPoints(b.Icon)
		b:GetHighlightTexture():SetAllPoints(b.Icon)
		b:SetScript("OnClick", Button_OnClick)
		b:SetScript("OnDragStart", Button_OnDrag)
		b:SetScript("OnEnter", Button_OnEnter)
		b:SetScript("OnLeave", Button_OnLeave)
		b:RegisterForClicks("RightButtonUp", "LeftButtonUp")
		b:RegisterForDrag("LeftButton")
		b.border = b:CreateTexture(nil, "OVERLAY")
		b.border:SetAllPoints()
		return b
	end

	local TOTAL_WIDTH, BUTTON_SIZE = slate:GetWidth()-4, 40
	local BUTTONS_PER_ROW = math.floor(TOTAL_WIDTH/(BUTTON_SIZE+2))
	local BUTTON_SPACER = BUTTON_SIZE + math.floor((TOTAL_WIDTH-BUTTON_SIZE*BUTTONS_PER_ROW)/(BUTTONS_PER_ROW-1))
	local BUTTON_LEFT = 2 + (TOTAL_WIDTH - BUTTON_SPACER*(BUTTONS_PER_ROW-1)-BUTTON_SIZE)/2
	bar:SetValueStep(BUTTON_SPACER)
	bar:SetStepsPerPage(5)
	local GROUP_MIX_FILTERS = {all=1, active=1, keybound=1, inactive=1}

	M.keys, M.buttons, M.headers = {}, {}, {}
	function M:Reset(resetFilter, newGroup, preserveScroll, _scrollActionID)
		if resetFilter then
			M:SetFilter("all", false)
		elseif not (GROUP_MIX_FILTERS[currentFilter] or MC:GetGroupID(currentFilter)) then
			M:SetFilter(newGroup and MC:GetGroupID(newGroup) or "all", false)
		end
		if preserveScroll ~= true then
			bar:SetValue(0, true)
		end
		M:RefreshView()
	end
	function M:SetFilter(filterKey, callReset)
		mainPanel.FilterButton.Reset:SetShown(filterKey ~= "all")
		if currentFilter ~= filterKey then
			wipe(M.keys)
			currentFilter = filterKey
			if callReset then
				M:Reset()
			end
		end
	end
	function M:GetFilter()
		return currentFilter
	end
	function M:RefreshView()
		local kt = M.keys or {}
		if not kt[1] then
			local o, g, gi = {}, {}, {}
			local isGroupMixFilter = GROUP_MIX_FILTERS[currentFilter]
			for id, name in MC:AllActions() do
				local f, gn, gid = true, MC:GetActionGroup(id)
				if currentFilter == "all" then
					f = true
				elseif currentFilter == "active" then
					f = MC:IsActionActivated(id)
				elseif currentFilter == "keybound" then
					f = not not MC:GetActionBind(id)
				elseif currentFilter == "inactive" then
					f = not (MC:IsActionActivated(id) or MC:GetActionBind(id))
				else
					f = gid == currentFilter
				end
				if f then
					kt[#kt+1], o[id], gid = id, name, gid or -1
					local ge = gi[gid] or {name=gn or "", gid=gid, active=false, keybound=false}
					ge.active = ge.active or not not MC:IsActionActivated(id)
					ge.keybound = ge.keybound or not not MC:GetActionBind(id)
					g[id], gi[gid] = ge, ge
				end
			end
			table.sort(kt, function(a, b)
				local ac, bc = g[a], g[b]
				if ac == bc then
				elseif ac.active ~= bc.active then
					return ac.active
				elseif ac.keybound ~= bc.keybound then
					return ac.keybound
				elseif ac.name ~= bc.name then
					return strcmputf8i(ac.name, bc.name) < 0
				end
				ac, bc = o[a], o[b]
				if ac and bc then
					return strcmputf8i(ac, bc) < 0
				elseif ac or bc then
					return not bc
				end
				return a < b
			end)

			local bt, gPrev, gOfs, yOfs = M.buttons, nil, 1, 0
			local ht, nhi = M.headers, 1
			for i=1,#kt do
				local sb, id, ge, hs, gn = bt[i], kt[i]
				ge = g[id]
				if not sb then
					sb = CreateButton(slate, BUTTON_SIZE)
					bt[i] = sb
				end
				if ge ~= gPrev then
					gPrev, gOfs, yOfs, gn = ge, i, i > 1 and (yOfs + math.ceil((i-gOfs)/BUTTONS_PER_ROW) * BUTTON_SPACER) or 0, ge.name
					if isGroupMixFilter and (gn ~= "" or i > 1) then
						hs, yOfs = ht[nhi] or slate:CreateFontString(nil, "OVERLAY", "GameFontHighlightMed2"), yOfs + (i > 1 and 6 or 2)
						hs:SetText(gn == "" and "|cffa0a0a0Ungrouped" or gn)
						hs:SetPoint("TOPLEFT", 4, -yOfs)
						ht[nhi], nhi, yOfs = hs, nhi + 1, yOfs + 18
					end
				end
				sb:SetID(id)
				sb:SetPoint("TOPLEFT", BUTTON_LEFT + (i-gOfs) % BUTTONS_PER_ROW * BUTTON_SPACER, -math.floor((i-gOfs)/BUTTONS_PER_ROW) * BUTTON_SPACER - yOfs)
			end
			local ch = (yOfs + math.ceil((#kt+1-gOfs)/BUTTONS_PER_ROW) * BUTTON_SPACER)
			M.keys, slate.contentHeight = kt, ch
			for i=1, #bt do
				bt[i]:SetShown(i <= #kt)
			end
			for i=1, #ht do
				ht[i]:SetShown(i < nhi)
			end
			local vh = sf:GetHeight()
			bar:SetWindowRange(vh)
			bar:SetMinMaxValues(0, math.max(0, ch - vh))
		end
		M:SyncContent()
	end
	function M:SyncContent()
		local bt = M.buttons
		for i=1, #bt do
			local b = bt[i]
			local id = b:IsShown() and b:GetID()
			if id and (id <= 0 or MC:IsActionValid(id)) then
				local showBorder, ico = false, id <= 0 and "Interface/GuildBankFrame/UI-GuildBankFrame-NewTab" or MC:GetActionIcon(id)
				if not ico then
					local _, _, tex = AB:GetActionDescription(MC:GetAction(id))
					ico = tex or "Interface/Icons/INV_Misc_QuestionMark"
				end
				if MC:IsActionActivated(id) then
					b.border:SetAtlas("loottoast-itemborder-blue")
					showBorder = true
				elseif MC:GetActionBind(id) then
					b.border:SetAtlas("loottoast-itemborder-green")
					showBorder = true
				end
				b.border:SetShown(showBorder)
				if type(ico) == "string" and GetFileIDFromPath(ico) == nil then
					b.Icon:SetAtlas(ico)
				else
					b.Icon:SetTexture(ico)
				end
			end
		end
	end
	function M:ReFilter()
		wipe(M.keys)
		M:Reset(false, nil, true)
	end
	function M:ReturnToList(resetFilter)
		editPanel:Hide()
		wipe(M.keys)
		M:Reset(resetFilter)
		sf:Show()
	end
	function M:SaveEditor()
		local id, nbox, gbox, mt = editPanel.id, editPanel.nameBox, editPanel.groupNameBox, getEditMacroText()
		if id > 0 then
			MC:SetAction(id, "imptext", mt)
		else
			id = MC:NewAction("imptext", mt)
			editPanel.id = id
		end
		local group = gbox:GetText()
		MC:SetActionBind(id, editPanel.bind.value, editPanel.bind.glob:GetChecked())
		MC:SetActionIcon(id, editPanel.icon.value)
		MC:SetActionGroup(id, group)
		if MC:SetActionName(id, nbox:GetText()) then
			editPanel:Hide()
			clearMacroEditor()
			wipe(M.keys)
			M:Reset(false, group, true, id)
			sf:Show()
		else
			nbox:SetText(MC:GetActionName(id))
			nbox:SetFocus()
		end
	end
	function M:OpenEditor(id)
		editPanel.id = id
		local text, isBindLocal, ico, bind, name, group, ico2, _, globalBind = "", true
		if id > 0 then
			local t, a = MC:GetAction(id)
			if t == "macrotext" or t == "imptext" then
				text = a
			end
			name, group, ico = MC:GetActionName(id), MC:GetActionGroup(id), MC:GetActionIcon(id)
			bind, isBindLocal, globalBind = MC:GetActionBind(id)
			_, _, ico2 = AB:GetActionDescription(MC:GetAction(id))
		end
		editPanel.id, editPanel.icon.value = id, ico
		setEditMacroText(text)
		editPanel.nameBox:SetText(name or "")
		editPanel.groupNameBox:SetText(group or "")
		editPanel.bind:SetBinding(bind)
		editPanel.bind.glob:SetChecked(globalBind and (globalBind == bind or not isBindLocal))
		editPanel.icon:SetIcon(ico, ico2)
		CloseDropDownMenus()
		sf:Hide()
		editPanel:Show()
		editPanel[id > 0 and "box" or "nameBox"]:SetFocus()
	end
	function M:ShowEditorModal(f)
		local of = M.curEditorModal
		f:Show()
		M.curEditorModal = f
		if of and of ~= f then
			of:Hide()
		end
		if editPanel.bind.capture then
			editPanel.bind:Deactivate()
		end
	end
	function M:HideEditorModal(f)
		local of = M.curEditorModal
		if f then
			f:Hide()
			M.curEditorModal = of ~= f and of or nil
		elseif of then
			of:Hide()
			M.curEditorModal = nil
		end
	end
	mainPanel:SetScript("OnShow", function()
		M:ReturnToList(true)
	end)
	function EV:M6_ACTIVE_SET_CHANGED()
		M:SyncContent()
	end
end

local function copyProfileData(from, method, cmd, desc, oktext)
	local cn, rm, rn, si = from:match("^%s*([^%-%s]+)(%-?)(.-)%s* (%d)%s*$")
	if not si then
		print(YELLOW_FONT_COLOR_CODE .. (L"Syntax: %s %s %s-%s %s"):format(
			SLASH_M61, cmd,
			HIGHLIGHT_FONT_COLOR_CODE .. L"{character name}" .. "|r",
			HIGHLIGHT_FONT_COLOR_CODE .. L"{realm name}" .. "|r",
			HIGHLIGHT_FONT_COLOR_CODE .. L"{specialization index}" .. "|r"
		))
		print(YELLOW_FONT_COLOR_CODE .. "   " .. desc)
		local s, c, r = GetSpecialization(), UnitName("player"), GetRealmName()
		print(YELLOW_FONT_COLOR_CODE .. "   " .. (L"Example: %s %s %s-%s %d"):format(HIGHLIGHT_FONT_COLOR_CODE .. SLASH_M61, cmd, c, r, s))
		return
	end
	local r, c = MC:HasProfile(cn, rm == "-" and rn or nil, si+0)
	if r then
		if M6[method](M6, c, r, si+0) then
			print(YELLOW_FONT_COLOR_CODE .. (oktext):format(HIGHLIGHT_FONT_COLOR_CODE .. c, r .. "|r", HIGHLIGHT_FONT_COLOR_CODE .. si .. "|r"))
		end
	else
		print(YELLOW_FONT_COLOR_CODE .. (c and L"A realm name must be specified." or L"Character/specialization not found."))
	end
end

SLASH_M61, SlashCmdList.M6 = "/m6", function(arg)
	local av, ar = (arg or ""):match("^%s*(%S+)%s*(.-)$")
	if av == "vers" or av == "version" then
		print(("|cff0077dd[%s] |cffffffff%s|cfff8a800%s"):format(
			addonName, C_AddOns.GetAddOnMetadata(addonName, "Version") or "?",
			T.SkipLocalActionBook and "+sha" or "+int"
		))
		return
	elseif av == "copy-map" or av == "cm" then
		return copyProfileData(ar, "ReplaceProfileMap", "copy-map", L"Changes M6 macro assignments to those used by the specified character.", L"M6 macro asssignments copied from %s-%s (spec %s).")
	elseif av == "copy-bindings" or av == "cb" then
		return copyProfileData(ar, "ReplaceProfileBindings", "copy-bindings", L"Changes M6 macro bindings to those used by the specified character.", L"M6 macro bindings copied from %s-%s (spec %s).")
	end
	mainPanel:SetShown(not mainPanel:IsShown())
	if mainPanel:IsShown() then
		mainPanel:ClearAllPoints()
		mainPanel:SetPoint("CENTER")
		M:ReturnToList(true)
	end
end