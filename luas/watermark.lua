local GetMousePos, IsButtonDown, GetLocalPlayerIndex, GetPlayerResources, draw_Color, draw_FilledRect, draw_TextShadow, common_Time, GetLocalPlayer, string_format, os_date, draw_GetTextSize=input.GetMousePos,input.IsButtonDown,client.GetLocalPlayerIndex,entities.GetPlayerResources,draw.Color,draw.FilledRect,draw.TextShadow,common.Time,entities.GetLocalPlayer,string.format,os.date,draw.GetTextSize
local move_watermark = gui.Checkbox(gui.Reference('SETTINGS', 'Miscellaneous'), 'lua_time', 'Moving Watermark', false)

local x, y = 869, 60
local w, h = x + 182, y + 21
local height = h

local window_x_offset, window_y_offset

local function inside_box(a, b)
	return a[1] > b[1] and a[1] < b[3] and a[2] > b[2] and a[2] < b[4]
end

local function window_moving()
	local mouse_x, mouse_y = GetMousePos()
	local mouse_down = IsButtonDown(1)

	if mouse_down and moving_window then
		w = x + 182
		h = y + 20

		x = mouse_x - window_x_offset
		y = mouse_y - window_y_offset
		height = y + 21
	end

	if mouse_down and inside_box({mouse_x, mouse_y}, {x, y, w, h}) then
		window_x_offset = mouse_x - x
		window_y_offset = mouse_y - y
		moving_window = true
	end

    if moving_window and not mouse_down then
        moving_window = false
        window_x_offset = 0
        window_y_offset = 0
    end
end

local stats = {}
local function get_stats()
	local kills = GetPlayerResources():GetPropInt("m_iKills", GetLocalPlayerIndex())
	local assists = GetPlayerResources():GetPropInt("m_iAssists", GetLocalPlayerIndex())
	local deaths = GetPlayerResources():GetPropInt("m_iDeaths", GetLocalPlayerIndex())
	local ping = GetPlayerResources():GetPropInt("m_iPing", GetLocalPlayerIndex())

	if deaths == 0 then
		kd = kills
	else
		kd = string_format('%.2f', kills/deaths)
	end

	stats = {
		'Kills: '.. kills,
		'Assists: '.. assists,
		'Deaths: '.. deaths,
		'K/D: '.. kd, 
		'Ping: '.. ping	
	}
end

local function draw_scoreboard()
	get_stats()

	draw_Color(100, 100, 100, 180)
	draw_FilledRect(x, height, w, height + 69)

	draw_Color(255, 35, 43, 255)
	for i=1, #stats do
		draw_TextShadow(x + 12, y + 12 + (i*12), stats[i])
	end
end

local function draw_welcome()
	draw_Color(100, 100, 100, 180)
	draw_FilledRect(x, height, w, height + 25)

	local tw, th = draw_GetTextSize('Welcome back')
	local tw2, th2 = draw_GetTextSize('Zack')

	draw_Color(255, 35, 43, 255)
	draw_TextShadow(x + (tw/2) , y + 27 , 'Welcome back')

	draw_Color(32, 255, 35, 255)
	draw_TextShadow(x + (tw + tw2*2) - 4 , y + 27 , 'Zack')
end

local function draw_watermark()
	if common_Time() < 7 then
		draw_welcome()
	end

	if move_watermark:GetValue() then
		window_moving()
	else
		if GetLocalPlayer() ~= nil then		
			y = 60
			height = y + 21
		else
			y, height = 0, 21
		end
	end

	if GetLocalPlayer() ~= nil then
		if IsButtonDown('tab') then
			draw_scoreboard()
		end
	end

	draw_Color(50, 50, 50, 180)
	draw_FilledRect(x, y, w, height)

	local time = os_date('%A, %B %d, %H:%M:%S')
	local text_width, text_height = draw_GetTextSize(time)

	draw_Color(255, 35, 43, 255)
	draw_TextShadow(x + 12 + (text_width/w), y + (text_height/2) - 2, time)
end

local function drawing()
	draw_watermark()
end
callbacks.Register('Draw', drawing)