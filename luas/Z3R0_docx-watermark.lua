local SetFont, TextShadow, GetTextSize, GetLocalPlayer, sqrt, floor, AbsoluteFrameTime, frame_rate, format, Color, FilledRect, OutlinedRect, IsButtonDown, GetMousePos, date = draw.SetFont, draw.TextShadow, draw.GetTextSize, entities.GetLocalPlayer, math.sqrt, math.floor, globals.AbsoluteFrameTime, 0.0, string.format, draw.Color, draw.FilledRect, draw.OutlinedRect, input.IsButtonDown, input.GetMousePos, os.date
local MENU = gui.Reference('MENU')

local is_inside = function(a, b, x, y, w, h) return a >= x and a <= w and b >= y and b <= h end
local get_abs_fps = function() frame_rate = 0.9 * frame_rate + (1 - 0.9) * AbsoluteFrameTime() return floor( (1 / frame_rate) + 0.5 ) end

local t_font = draw.CreateFont("Arial", 17, 10)
local v_font = draw.CreateFont("Arial", 16, 10)

local tX, tY = 300, 30
local offsetX, offsetY, _drag
local drag_menu = function(x, y, w, h)
	if not MENU:IsActive() then
		return tX, tY
	end

	local mouse_down = IsButtonDown(1)

	if mouse_down then
		local X, Y = GetMousePos()

		if not _drag then
			local w, h = x + w, y + h
			if is_inside(X, Y, x, y, w, h) then
				offsetX, offsetY = X - x, Y - y
				_drag = true
			end
		else
			tX, tY = X - offsetX, Y - offsetY
		end
	else
		_drag = false
	end

	return tX, tY
end

local function bg(x, y, w, h)
	local w, h = x + w, y + h

	Color( 30, 25, 65 )
	FilledRect( x, y, w, h )

	Color( 195, 23, 83 )
	OutlinedRect( x, y, w, h )
end

local function bg_text(x, y)
	local r, g, b = 255, 255, 255

	Color( r, g, b )
	SetFont( t_font )
	TextShadow( x + 8, y + 3, 'aimware' )

	SetFont( v_font )
	local fps = get_abs_fps()

	if fps < 30 then
		Color(255, 0, 0)
	else
		Color( r, g, b )
	end

	local fW, fH = GetTextSize( fps )
	local A = fW * 0.5
	TextShadow( (x + 90) - A, y + 4, fps)

	Color( r, g, b )
	TextShadow( x + 100, y + 4, 'fps' )

	local local_player = GetLocalPlayer()
	if local_player then
		local alive = local_player:IsAlive()
		local vX, vY = local_player:GetPropFloat( 'localdata', 'm_vecVelocity[0]' ), local_player:GetPropFloat( 'localdata', 'm_vecVelocity[1]' )
		local vx, vy = vX * vX, vY * vY
		local v = sqrt( vx + vy )
		local speed = floor( v + 0.5 )
		
		local sW, sH = GetTextSize( speed )
		local B = sW * 0.5

		TextShadow( (x + 146) - B, y + 4, speed )
		TextShadow( x + 160, y + 4, 'u/s' )
	end

	local _time = date( '%H:%M:%S' )
	TextShadow( x + 199, y + 4, _time )
end

local function bg_separator(x, y)
	Color( 255, 255, 255 )
	SetFont( t_font )

	TextShadow( x + 70, y + 3, '|' )
	TextShadow( x + 126, y + 3, '|' )
	TextShadow( x + 186, y + 3, '|' )
end

local function on_draw()
	local x, y = drag_menu(tX, tY, 260, 25)

	bg(x, y, 260, 25)
	bg_text(x, y)
	bg_separator(x, y)
end

callbacks.Register("Draw", on_draw)
