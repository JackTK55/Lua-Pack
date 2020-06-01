local IsButtonDown, GetTextSize, Color, RoundedRectFill, RoundedRect, SetFont, Text, GetLocalPlayer, GetScreenSize = input.IsButtonDown, draw.GetTextSize, draw.Color, draw.RoundedRectFill, draw.RoundedRect, draw.SetFont, draw.Text, entities.GetLocalPlayer, draw.GetScreenSize
local font = draw.CreateFont('Times New Roman', 36)

local function add_key(x, y, k, k2)
	local r, g, b

	if IsButtonDown(k) then
		r, g, b = 63, 200, 63
	else
		r, g, b = 200, 63, 63
	end

	local k = k2 and k2 or k
	local tW, tH = GetTextSize(k)

	Color(r, g, b, 180)
	RoundedRectFill(x-18, y-18, x+18, y+18)

	Color(255, 255, 255, 180)
	RoundedRect(x-19, y-19, x+19, y+19) 

	if k == 'W' then
		x, y = x - 9, y - 6
	elseif k == '⯅' then
		y = y - 2
	elseif k == '⯆' then
		y = y - 4
	end

	SetFont(font)
	Color(255, 255, 255, 200)
	Text(x - (tW*0.5), y - (tH*0.5), k)
end

local function on_draw()
	if not GetLocalPlayer() then
		return
	end

	local W, H = GetScreenSize()
	local X, Y = W * 0.5, H * 0.7

	add_key(X, Y, 'W')
	add_key(X - 40, Y + 40, 'A')
	add_key(X, Y + 40, 'S')
	add_key(X + 40, Y + 40, 'D')
	add_key(X + 40, Y + 80, 'SPACE', '⯅')
	add_key(X - 40, Y + 80, 'CTRL', '⯆')
end

callbacks.Register('Draw', on_draw)
