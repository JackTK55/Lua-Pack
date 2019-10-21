local fmod, local_player, get_prop, abs, sqrt, ui_get, client_color_log, client_exec, string_format = math.fmod, entity.get_local_player, entity.get_prop, math.abs, math.sqrt, ui.get, client.color_log, client.exec, string.format

local checkbox = ui.new_checkbox("LUA", "A", "Enabled")
local last_pos = {9999, 9999, 9999}
local u = 5

local toBits = function(n)
    local t={}
    while n>0 do
        r=fmod(n,2)
        t[#t+1]=r
        n=(n-r)/2
    end
    return t
end

local get_flags = function(ent)
    return toBits(get_prop(ent, 'm_fFlags'))
end

local get_length = function(a, b)
    local x = abs( a[1] - b[1] )
    local y = abs( a[2] - b[2] )
    return sqrt( (x*x) + (y*y) )
end

local flat = function(a, b)
	local a, b = a[3], b[3]
	return a >= (b - u) and a <= (b + u)
end

local function long_jump(cmd)
	if not ui_get(checkbox) then
		return
	end

	local lp = local_player()

	if lp == nil or get_flags(lp)[1] ~= 1 then
		return
	end

	local curr_pos = { get_prop(lp, "m_vecOrigin") }

	if last_pos[1] ~= 9999 then
		local distance = get_length(curr_pos, last_pos)
		local str = string_format('Long jump! Distance: %.2f', distance)
		local dis = distance > 229 and distance < 600

		if flat(curr_pos, last_pos) and dis then
			local sound = ( (distance >= 230 and distance < 250) and 'whickedsick.wav' ) or
						  ( (distance >= 250 and distance < 270) and 'unstoppable.wav' ) or
						  ( (distance >= 270 and distance < 600) and 'godlike.wav' )

			client_color_log(0, 255, 0, str)
			client_exec('playvol '.. sound ..' 1')
		end
	end

	last_pos = curr_pos
end

client.set_event_callback("setup_command", long_jump)