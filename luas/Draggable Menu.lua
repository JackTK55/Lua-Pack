local IsButtonDown, GetMousePos = input.IsButtonDown, input.GetMousePos
local is_inside = function(a, b, x, y, w, h) return a >= x and a <= w and b >= y and b <= h end

--[[
	call: drag_menu(x, y, w, h)
	ex: 
	local x, y = drag_menu(
		tX, 
		tY, 
		tX + 300, 
		tY + 55
	)
]]

local MENU = gui.Reference('MENU')
local tX, tY = 300, 30 -- X, Y of menu spawn
local offsetX, offsetY, _drag
local drag_menu = function(x, y, w, h)
	if not MENU:IsActive() then
		return tX, tY
	end

	local mouse_down = IsButtonDown(1)

	if mouse_down then
		local X, Y = GetMousePos()

		if not _drag then
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
