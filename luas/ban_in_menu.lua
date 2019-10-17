local get,decodePNG,CreateTexture,SetTexture,FilledRect,GetScreenSize,GetMousePos,GetLocalPlayer=http.Get,common.DecodePNG,draw.CreateTexture,draw.SetTexture,draw.FilledRect,draw.GetScreenSize,input.GetMousePos,entities.GetLocalPlayer
local ban_type = gui.Combobox(gui.Reference('SETTINGS','Miscellaneous'),'ban_message','Ban Type', 'Overwatch Major', 'Untrusted', 'Vac')

local global_cooldown = get('https://i.imgur.com/8pN6rbP.png')
local convicted_by_ow_majorly = get('https://i.imgur.com/Yw5W6bI.png')
local untrusted = get('https://i.imgur.com/uM9jrJG.png')
local vac = get('https://i.imgur.com/R7aJ68P.png')
local vac_ban = get('https://i.imgur.com/boaHIwd.png')

local a,b,c = decodePNG(global_cooldown)
local d,e,f = decodePNG(convicted_by_ow_majorly)
local g,h,f = decodePNG(untrusted)
local j,b,c = decodePNG(vac)
local m,n,o = decodePNG(vac_ban)

local A,B,C,D,E = CreateTexture(a,b,c),CreateTexture(d,e,f),CreateTexture(g,h,f),CreateTexture(j,b,c),CreateTexture(m,n,o)
local gap = 19

local inside_box = function()
	local mx,my = GetMousePos()
	return mx >= 0 and mx <= b and my >= 0 and my <= c
end

local get_texture = function(a,b)
	if b then
		if a == 0 or a == 1 then return A end
		if a == 2 then return D end
	else
		if a == 0 then return B end
		if a == 1 then return C end
		if a == 2 then return E end
	end
end

local get_sizes = function(a)
	local x,_ = GetScreenSize()
	local gap = c + gap

	if a == 0 then
		return (x/2)-(e/2), gap, (x/2)+(e/2), gap + f
	end

	if a == 1 then
		return (x/2)-(h/2), gap, (x/2)+(h/2), gap + f
	end
	
	if a == 2 then
		return (x/2)-(n/2), gap, (x/2)+(n/2), gap + o
	end
end

local function draw_message()
	local x,_ = GetScreenSize()
	local x, y, w, h = get_sizes( ban_type:GetValue() )

	SetTexture( get_texture(ban_type:GetValue(),false) )
	FilledRect(x, y, w, h)
end

local function draw_ban()
	if GetLocalPlayer() ~= nil then
		return
	end

	SetTexture( get_texture(ban_type:GetValue(),true) )
	FilledRect(0,0,b,c)

	if inside_box() then
		draw_message()
	end
end

callbacks.Register('Draw',draw_ban)