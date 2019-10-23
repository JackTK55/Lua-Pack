local fmod, local_player, abs, sqrt, client_exec, string_format = math.fmod, entities.GetLocalPlayer, math.abs, math.sqrt, client.Command, string.format

local checkbox = gui.Checkbox(gui.Reference('SETTINGS', 'Miscellaneous'), 'lua_long_jump', 'Long Jump', false)
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
    return toBits(ent:GetProp('m_fFlags'))
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
	if not checkbox:GetValue() then
		return
	end

	local lp = local_player()

	if lp == nil or get_flags(lp)[1] ~= 1 then
		return
	end

	local curr_pos = { lp:GetProp("m_vecOrigin") }

	if last_pos[1] ~= 9999 then
		local distance = get_length(curr_pos, last_pos)
		local str = string_format('Long jump! Distance: %.2f', distance)
		local dis = distance > 229 and distance < 600

		if flat(curr_pos, last_pos) and dis then
			local sound = ( (distance >= 230 and distance < 250) and 'whickedsick.wav' ) or
						  ( (distance >= 250 and distance < 270) and 'unstoppable.wav' ) or
						  ( (distance >= 270 and distance < 600) and 'godlike.wav' )

			client_exec('playvol '.. sound ..' 1')
		end
	end

	last_pos = curr_pos
end

callbacks.Register("CreateMove", long_jump)