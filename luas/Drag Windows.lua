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