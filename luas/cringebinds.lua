local font = draw.CreateFont('Times New Roman', 36)

local function add_key(x, y, k, k2)
	local r, g, b

	if input.IsButtonDown(k) then
		r, g, b = 63, 200, 63
	else
		r, g, b = 200, 63, 63
	end

	local k = k2 and k2 or k
	local tW, tH = draw.GetTextSize(k)

	draw.Color(r, g, b, 180)
	draw.RoundedRectFill(x-18, y-18, x+18, y+18)

	draw.Color(255, 255, 255, 180)
	draw.RoundedRect(x-19, y-19, x+19, y+19) 

	if k == 'W' then
		x, y = x - 9, y - 6
	elseif k == '⯅' then
		y = y - 2
	elseif k == '⯆' then
		y = y - 4
	end

	draw.SetFont(font)
	draw.Color(255, 255, 255, 200)
	draw.Text(x - (tW*0.5), y - (tH*0.5), k)
end

local function on_draw()
	if not entities.GetLocalPlayer() then
		return
	end

	local W, H = draw.GetScreenSize()
	local X, Y = W * 0.5, H * 0.7

	add_key(X, Y, 'W')
	add_key(X - 40, Y + 40, 'A')
	add_key(X, Y + 40, 'S')
	add_key(X + 40, Y + 40, 'D')
	add_key(X + 40, Y + 80, 'SPACE', '⯅')
	add_key(X - 40, Y + 80, 'CTRL', '⯆')
end

callbacks.Register('Draw', on_draw)
