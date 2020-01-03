local GetLocalPlayer,g_curtime,PlayerIndexByUserID,pairs,remove = entities.GetLocalPlayer,globals.CurTime,client.GetPlayerIndexByUserID,pairs,table.remove

local noises = {'weapon_fire', 'player_footstep', 'weapon_reload'}
for i=1,#noises do client.AllowListener(noises[i]) end
local made_noise, dur = {}, 1.25

callbacks.Register('FireGameEvent', function(e)
	for i=1,#noises do
		local noise = noises[i]
		if noise == e:GetName() then
			local player_index = PlayerIndexByUserID(e:GetInt('UserID'))
			made_noise[player_index] = {noise, g_curtime() + dur}
		end
	end
end)

callbacks.Register('DrawESP', function(b)
	local abs = GetLocalPlayer():GetAbsOrigin()
	local ent = b:GetEntity()
	local x,y,w,h = b:GetRect()

	for i,v in pairs(made_noise) do
		if i == ent:GetIndex() then
			if v[2] >= g_curtime() then
				b:Color(255,255,255,255)
				draw.OutlinedRect(x, y, w, h)
				b:AddTextBottom(v[1])
			else
				remove(made_noise, i)
			end
		end
	end
end)
