local a,b,c,d,e,f,g,h,i,j,k,l,m,n=input.IsButtonDown,client.GetLocalPlayerIndex,entities.GetPlayerResources,draw.Color,draw.FilledRect,draw.TextShadow,common.Time,entities.GetLocalPlayer,string.format,os.date,draw.GetTextSize,client.GetConVar('name'),math.sin,draw.GetScreenSize

local A = gui.Multibox(gui.Reference('SETTINGS', 'Miscellaneous'), 'Watermark Options')
local B = gui.Checkbox(A, 'lua_wm_kills', 'Kills', false)
local C = gui.Checkbox(A, 'lua_wm_assists', 'Assists', false)
local D = gui.Checkbox(A, 'lua_wm_deaths', 'Deaths', false)
local E = gui.Checkbox(A, 'lua_wm_kd', 'KD', false)
local F = gui.Checkbox(A, 'lua_wm_ping', 'Ping', false)

local x = false -- show stuff
local y,z,o = 0,0,{}
local v = '%A, %B %d, %H:%M:%S' -- date format

local function t(a)
	local b = a/2
	return m(g() * 0.6) * b + b
end

local function p()
	local d,e,f,g,u = c():GetPropInt('m_iKills', b()),c():GetPropInt('m_iAssists', b()),c():GetPropInt('m_iDeaths', b()),c():GetPropInt('m_iPing', b()),0

	if f == 0 then
		u = d
	else
		u = i('%.2f', d/f)
	end

	o = {}

	if B:GetValue() then
		o[#o + 1] = 'Kills: '.. d
	end
	
	if C:GetValue() then
		o[#o + 1] = 'Assists: '.. e
	end
	
	if D:GetValue() then
		o[#o + 1] = 'Deaths: '.. f
	end
	
	if E:GetValue() then
		o[#o + 1] = 'K/D: '.. u
	end
	
	if F:GetValue() then
		o[#o + 1] = 'Ping: '.. g
	end
	
end

local function q()
	p()

	if #o == 0 then
		return
	end

	local a,_ = n()
	local c = a / 2
	
	local r = j(v)
	local v,_ = k(r)
	local a = v / 2

	d(100, 100, 100, 180)
	e(c - a - 5, z, c + a + 5, z + (#o*12) + 5)

	d(255, 35, 43, 255)
	for i=1, #o do
		local a,_ = k(o[i])
		f(c - (a/2), (z-10) + (i*12), o[i])
	end
end

local function r()
	local a,_ = n()
	local c = a / 2

	local v,w = k('Welcome back')
	local g, h = v / 2, z + (w / 2)-2
	
	local x,_ = k(l)
	local i = x / 2
	
	local x = c - g - i
	local w = c + g

	d(100, 100, 100, t(180))
	e(x - 7, z, w + i + 7, z + 21)

	d(255, 100, 43, t(255))
	f(x - 2, h, 'Welcome back')

	d(32, 255, 35, t(255))
	f(w - i + 2, h, l)
end

local function s()
	if g() <= 8 then
		r()
	end

	if h() ~= nil then
		y = 60
		z = y + 21

		if a('tab') or x then
			q()
		end
	else
		y = 0
		z = y + 21
	end
	
	local a,_ = n()
	local b = a / 2

	local r = j(v)
	local v, w = k(r)
	local c, g = v / 2, w / 2

	d(50, 50, 50, 180)
	e(b - c - 5, y, b + c + 5, z)

	d(255, 35, 43, 255)
	f(b - c, y + g - 2, r)
end

local function p()
	s()
end

callbacks.Register('Draw', p)