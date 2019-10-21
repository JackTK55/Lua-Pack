--[[
	Created by: yu0r ( https://aimware.net/forum/user-1566.html )
	Edited by: zack
]]

local floor, sin, RealTime, FindByClass, GetConVar, SetConVar, GetLocalPlayer, Reference, Combobox, Checkbox, Slider = math.floor, math.sin, globals.RealTime, entities.FindByClass, client.GetConVar, client.SetConVar, entities.GetLocalPlayer, gui.Reference, gui.Combobox, gui.Checkbox, gui.Slider

local show_window = Checkbox(Reference('VISUALS','OTHER','Filter'), 'lua_chickenshit_show_window', 'Show Chicken Changer Window', false)
local window = gui.Window('lua_chickenshit_window', 'Chicken Stuff', 200, 200, 250, 399)
local lua_groupbox = gui.Groupbox(window, 'Chicken Changer', 16, 16)
local lua_EnableChicken = Checkbox(lua_groupbox, 'lua_EnableChicken', 'Enable', false)

local lua_ChickenScale = Slider(lua_groupbox, 'lua_ChickenScale', 'Chicken Scale', 1.0, 0.25, 4.0)
local lua_ChickenColor = Combobox(lua_groupbox, 'lua_ChickenColor', 'Chicken Color','Off','Solid', 'Rainbow')
local lua_ChickenRainbowSpeed = Slider(lua_groupbox, 'lua_ChickenRainbowSpeed', 'Chicken Color Speed', 1.0, 0.25, 4.0)
local lua_ChickenModel = Combobox(lua_groupbox, 'lua_ChickenModel', 'Holiday Theme','Default Chicken', 'Party Chicken', 'Ghost Chicken', 'Festive Chicken', 'Easter Chicken', 'Jack-o-Chicken')
local lua_ChickenSkin = Combobox(lua_groupbox, 'lua_ChickenSkin', 'Chicken Skin','Default', 'Other')

local lua_EnableParty = Checkbox(lua_groupbox, 'lua_EnableParty', 'sv_partymode 1', false)
local lua_ChickenAA = Checkbox(lua_groupbox, 'lua_ChickenAA', 'ChickenAA', false)

local Chicken_Color = gui.ColorEntry( 'Chicken_Color', 'Chicken Color', 0, 0, 0,255)

local function RGB2clr(R, G, B)
	return 0xFFFFFF & ((R&0xFF)|((G&0xFF)<<8)|((B&0xFF)<<16))
end

local function Rainbow()
	local speed = lua_ChickenRainbowSpeed:GetValue()
	local r = floor(sin(RealTime() * speed) * 127 + 128)
	local g = floor(sin(RealTime() * speed + 2) * 127 + 128)
	local b = floor(sin(RealTime() * speed + 4) * 127 + 128)
	return r, g, b
end

local function ChickenShit()
	window:SetActive(show_window:GetValue() and Reference('MENU'):IsActive())

	if GetLocalPlayer() == nil then
		return
	end

	local chickens = FindByClass('CChicken')
	local enabled = lua_EnableChicken:GetValue()
	local chicken_model = lua_ChickenModel:GetValue()
	local chicken_skin = lua_ChickenSkin:GetValue()
	local chicken_scale = lua_ChickenScale:GetValue()
	local enable_party = lua_EnableParty:GetValue() and 1 or 0
	local party_mode = GetConVar('sv_party_mode')
	local chicken_aa = lua_ChickenAA:GetValue()

	local normal_color = RGB2clr( 255, 255, 255 )
	local A = lua_ChickenColor:GetValue() == 0 and normal_color or
			  lua_ChickenColor:GetValue() == 1 and RGB2clr( Chicken_Color:GetValue() ) or
			  lua_ChickenColor:GetValue() == 2 and RGB2clr( Rainbow() )

	if chickens[1] == nil then
		return
	end

	for i=1, #chickens do
		local chicken = chickens[i]
		local m_clrRender = chicken:GetProp('m_clrRender')
		local m_nBody = chicken:GetProp('m_nBody')
		local m_nSkin = chicken:GetProp('m_nSkin')
		local m_flModelScale = chicken:GetProp('m_flModelScale')

		if enabled then

			if m_clrRender ~= A then
				chicken:SetProp('m_clrRender', A)
			end

			if m_nBody ~= chicken_model then
				chicken:SetProp('m_nBody', chicken_model)
			end

			if m_nSkin ~= chicken_skin then
				chicken:SetProp('m_nSkin', chicken_skin)
			end

			if m_flModelScale ~= chicken_scale then
				chicken:SetProp('m_flModelScale', chicken_scale)
			end

		else
			
			if m_clrRender ~= normal_color then
				chicken:SetProp('m_clrRender', normal_color)
			end

			if m_nBody ~= 0 then
				chicken:SetProp('m_nBody', 0)
			end

			if m_flModelScale ~= 1.0 then
				chicken:SetProp('m_flModelScale', 1.0)
			end

			if m_nSkin ~= 0 then
				chicken:SetProp('m_nSkin', 0)
			end

		end

		if party_mode ~= enable_party then
			SetConVar('sv_party_mode', enable_party, true)
		end

		if chicken_aa then
			chicken:SetProp('m_nSequence', -509)
		end
	end
end

callbacks.Register('Draw', ChickenShit)
