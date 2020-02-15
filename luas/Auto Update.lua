-- Base code for auto updating.

local cS = GetScriptName()
local cV = '1.0.0'
local gS = ' PUT LINK TO RAW LUA SCRIPT '
local gV = ' PUT LINK TO RAW VERSION '

callbacks.Register('Draw', 'Auto Update', function()
	if gui.GetValue('lua_allow_http') and gui.GetValue('lua_allow_cfg') then
		local nV = http.Get(gV)
		if cV ~= nV then
			local nF = http.Get(gS)
			local cF = file.Open(cS, 'w')
			cF:Write(nF)
			cF:Close()
			print(cS, 'updated from', cV, 'to', nV)
		else
			print(cS, 'is up-to-date.')
		--	callbacks.Unregister('Draw', 'Auto Update') -- can't use unregister in the func
		end
	end
end)
