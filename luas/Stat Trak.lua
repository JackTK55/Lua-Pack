local a,b,c,d,e,f,g,h,i,u,x=file.Open,gui.GetValue,gui.SetValue,entities.GetByUserID,client.GetPlayerIndexByUserID,entities.GetLocalPlayer,client.GetLocalPlayerIndex,string.format,gui.Command,client.AllowListener,client.Command
local j = gui.Checkbox(gui.Reference("MISC","GENERAL","Main"),"msc_stattrak_count","Stattrak Counter",false)
local k = gui.Checkbox(gui.Reference("MISC","GENERAL","Main"),"msc_stattrak_saving","Save Stattrak to File",false)

local l, m = {}, false
local n,o,p = {'inferno','hegrenade','smokegrenade','flashbang','decoy','knife','taser','shield'},{'deagle','elite','fiveseven','glock','ak47','aug','awp','famas','g3sg1','galilar','m249','m4a1','mac10','p90','mp5sd','ump45','xm1014','bizon','mag7','negev','sawedoff','tec9','hkp2000','mp7','mp9','nova','p250','shield','scar20','sg556','ssg08','m4a1_silencer','usp_silencer','cz75a','revolver','bayonet','knife_flip','knife_gut','knife_karambit','knife_m9_bayonet','knife_tactical','knife_falchion','knife_survival_bowie','knife_butterfly','knife_push','knife_ursus','knife_gypsy_jackknife','knife_stiletto','knife_widowmaker'},{[500]='bayonet',[505]='knife_flip',[506]='knife_gut',[507]='knife_karambit',[508]='knife_m9_bayonet',[509]='knife_tactical',[512]='knife_falchion',[514]='knife_survival_bowie',[515]='knife_butterfly',[516]='knife_push',[519]='knife_ursus',[520]='knife_gypsy_jackknife',[522]='knife_stiletto',[523]='knife_widowmaker'}

local function q(a)
	for b, c in pairs(p) do
		if b == a then
			return c
		end
	end
	return 'knife'
end

local function r(s)
	if s == 'l' then
		local t = a('stattrak_values.dat', 'r')

		if t == nil then
			return
		end

			local u = t:Read()
				i(u)
		t:Close()

		for i=1, #o do
			local c = h('skin_%s_stattrak', o[i])
			l[c] = b(c)
		end
	end

	if not k:GetValue() then
		return
	end

	if s == 's' then
		local t = a('stattrak_values.dat', 'w')
		for c, v in pairs(l) do
			local d = h('%s %i;', c, v)
			t:Write(d)
		end

		t:Close()
	end
end
r('l')

local function s(t, m)
    for i=1, #t do
        if t[i] == m then
            return true
        end
    end
    return false
end

local function v(a, b)
	return d(b):GetTeamNumber() ~= f():GetTeamNumber() and e(a) == g() and e(b) ~= g()
end

u('player_death')
u('round_prestart')
local function Stattrak(z)
	local y = z:GetName()

	if not j:GetValue() or not b("skin_active") or (y ~= 'player_death' and y ~= 'round_prestart') then
		return
	end

	if y == "player_death" and v(z:GetInt("attacker"), z:GetInt("userid")) then

		local w = z:GetString("weapon")

		if w == 'knife' or w == 'knife_t' then
			w = q(f():GetWeaponID())
		end

		if not s(n, w) then
			local x = b(h("skin_%s_enable", w))
			local t = h("skin_%s_stattrak", w)
			local aa = tonumber(b(t))

			if x and aa > 0 then
				c(t, aa + 1)
				l[t] = b(t)
				m = true
			end
		end
	end

	if y == "round_prestart" then
		if m then
			x("cl_fullupdate", true)
			r('s')
			m = false
		end
	end
end

callbacks.Register("FireGameEvent", Stattrak)