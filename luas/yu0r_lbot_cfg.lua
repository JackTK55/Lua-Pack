--[[
	Original by: yu0r
		from an old myg0t cfg on the forums, tweaked for other weapons that aren't deagle and scout

	Edited by: zack
--]]

local weapons = { {
		glock = { curve = 0.507042, filter_arms = 0, filter_chest = 0, filter_head = 1, filter_legs = 0, filter_stomach = 0, fov = 3.80282, fsd = 0.01, hitbox = 0, hitboxselect = 0, randomize = 6.9, rcs = 1, rcs_horiz = 100, rcs_standalone = 0, smooth = 1.8, smoothtype = 1, tsd = 0 },
		hkp2000 = { curve = 0.647887, filter_arms = 0, filter_chest = 1, filter_head = 1, filter_legs = 0, filter_stomach = 0, fov = 2.7, fsd = 0.03, hitbox = 0, hitboxselect = 1, randomize = 3.4, rcs = 1, rcs_horiz = 100, rcs_standalone = 1, smooth = 2.4, smoothtype = 1, tsd = 0.31 }, 
		usp_silencer_off = { curve = 0.647887, filter_arms = 0, filter_chest = 1, filter_head = 1, filter_legs = 0, filter_stomach = 0, fov = 2.7, fsd = 0.03, hitbox = 0, hitboxselect = 1, randomize = 3.4, rcs = 1, rcs_horiz = 100, rcs_standalone = 1, smooth = 2.4, smoothtype = 1, tsd = 0.31 }, 
		usp_silencer = { curve = 0.647887, filter_arms = 0, filter_chest = 1, filter_head = 1, filter_legs = 0, filter_stomach = 0, fov = 2.7, fsd = 0.03, hitbox = 0, hitboxselect = 1, randomize = 3.4, rcs = 1, rcs_horiz = 100, rcs_standalone = 1, smooth = 2.4, smoothtype = 1, tsd = 0.31 }, 
		elite = { curve = 0.666667, filter_arms = 0, filter_chest = 0, filter_head = 1, filter_legs = 0, filter_stomach = 0, fov = 2.53521, fsd = 0.0258216, hitbox = 0, hitboxselect = 1, randomize = 2.4554, rcs = 1, rcs_horiz = 100, rcs_standalone = 1, smooth = 3.31455, smoothtype = 1, tsd = 0.230047 }, 
		tec9 = { curve = 0.0469484, filter_arms = 0, filter_chest = 1, filter_head = 1, filter_legs = 0, filter_stomach = 0, fov = 2.67606, fsd = 0.00938967, hitbox = 0, hitboxselect = 1, randomize = 2.86385, rcs = 1, rcs_horiz = 42.723, rcs_standalone = 1, smooth = 1, smoothtype = 1, tsd = 0.25 }, 
		fiveseven = { curve = 0, filter_arms = 0, filter_chest = 0, filter_head = 1, filter_legs = 0, filter_stomach = 0, fov = 2.73521, fsd = 0.0187793, hitbox = 0, hitboxselect = 0, randomize = 2.7108, rcs = 1, rcs_horiz = 100, rcs_standalone = 0, smooth = 2.4, smoothtype = 1, tsd = 0.459524 }, 
		deagle = { curve = 0, filter_arms = 0, filter_chest = 0, filter_head = 1, filter_legs = 0, filter_stomach = 0, fov = 1.1, fsd = 0,--[[.01]] hitbox = 0, hitboxselect = 1, randomize = 4.5, rcs = 1, rcs_horiz = 100, rcs_standalone = 0,--[[0]] smooth = 1, smoothtype = 0, tsd = 0--[[.45]] }, 

	},  {
		mac10 = { curve = 0.5, filter_arms = 0, filter_chest = 0, filter_head = 1, filter_legs = 0, filter_stomach = 0, fov = 8, fsd = 0, hitbox = 0, hitboxselect = 0, randomize = 2, rcs = 1, rcs_horiz = 60, rcs_standalone = 1, smooth = 6.075, smoothtype = 1, tsd = 0.4 }, 
		mp7 = { curve = 0.5, filter_arms = 0, filter_chest = 1, filter_head = 1, filter_legs = 0, filter_stomach = 1, fov = 8, fsd = 0, hitbox = 0, hitboxselect = 1, randomize = 6, rcs = 1, rcs_horiz = 60, rcs_standalone = 1, smooth = 7.4, smoothtype = 1, tsd = 0.4 }, 
		mp9 = { curve = 0.516432, filter_arms = 0, filter_chest = 1, filter_head = 1, filter_legs = 0, filter_stomach = 0, fov = 8, fsd = 0.0117371, hitbox = 0, hitboxselect = 1, randomize = 6.19718, rcs = 1, rcs_horiz = 60, rcs_standalone = 0, smooth = 6.03756, smoothtype = 1, tsd = 0.511737 }, 
		bizon = { curve = 0.5, filter_arms = 0, filter_chest = 1, filter_head = 1, filter_legs = 0, filter_stomach = 1, fov = 8, fsd = 0.00704225, hitbox = 0, hitboxselect = 1, randomize = 6.3662, rcs = 1, rcs_horiz = 100, rcs_standalone = 1, smooth = 6.075, smoothtype = 1, tsd = 0.4 }, 
		p90 = { curve = 0.769953, filter_arms = 0, filter_chest = 1, filter_head = 1, filter_legs = 0, filter_stomach = 1, fov = 3.66197, fsd = 0.0140845, hitbox = 0, hitboxselect = 0, randomize = 4.62911, rcs = 1, rcs_horiz = 50, rcs_standalone = 1, smooth = 10.2582, smoothtype = 1, tsd = 0 },
	 
	},  {
		ak47 = { curve = 0.5,--[[0.58216]] filter_arms = 0, filter_chest = 1, filter_head = 1, filter_legs = 0, filter_stomach = 0, fov = 2.3, fsd = 0.01,--[[0]] hitbox = 0, hitboxselect = 0, randomize = 4.0,--[[4.92958	4.5]] rcs = 1, rcs_horiz = 50, rcs_standalone = 1, smooth = 6.6,--[[7.8 8.6]] smoothtype = 1, tsd = 0.22 }, 
		m4a1_silencer = { curve = 0.215962, filter_arms = 0, filter_chest = 1, filter_head = 1, filter_legs = 0, filter_stomach = 0, fov = 1.97183, fsd = 0.028169, hitbox = 0, hitboxselect = 1, randomize = 5.64, rcs = 1, rcs_horiz = 100, rcs_standalone = 1, smooth = 10.1, smoothtype = 1, tsd = 0 }, 
		m4a1 = { curve = 0.215962, filter_arms = 0, filter_chest = 1, filter_head = 1, filter_legs = 0, filter_stomach = 0, fov = 1.97183, fsd = 0.028169, hitbox = 0, hitboxselect = 1, randomize = 5.64, rcs = 1, rcs_horiz = 100, rcs_standalone = 1, smooth = 10.1, smoothtype = 1, tsd = 0 }, 
		m4a1_silencer_off = { curve = 0.215962, filter_arms = 0, filter_chest = 1, filter_head = 1, filter_legs = 0, filter_stomach = 0, fov = 1.97183, fsd = 0.028169, hitbox = 0, hitboxselect = 1, randomize = 5.64, rcs = 1, rcs_horiz = 100, rcs_standalone = 1, smooth = 10.1, smoothtype = 1, tsd = 0 }, 
		famas = { curve = 0.888263, filter_arms = 0, filter_chest = 1, filter_head = 1, filter_legs = 0, filter_stomach = 0, fov = 1.97183, fsd = 0.028169, hitbox = 0, hitboxselect = 1, randomize = 6.7723, rcs = 1, rcs_horiz = 100, rcs_standalone = 1, smooth = 6.2, smoothtype = 1, tsd = 0.310047 }, 
		galilar = { curve = 0.798122, filter_arms = 0, filter_chest = 1, filter_head = 1, filter_legs = 0, filter_stomach = 0, fov = 2.3, fsd = 0.07, hitbox = 0, hitboxselect = 0, randomize = 5.9, rcs = 1, rcs_horiz = 100, rcs_standalone = 1, smooth = 12.4366, smoothtype = 1, tsd = 0 }, 

	},  {
		xm1014 = { curve = 0.394366, filter_arms = 0, filter_chest = 1, filter_head = 0, filter_legs = 0, filter_stomach = 1, fov = 1.26761, fsd = 0.0117371, hitbox = 1, hitboxselect = 1, randomize = 4, rcs = 0, rcs_horiz = 100, rcs_standalone = 1, smooth = 6.30986, smoothtype = 0, tsd = 0.399061 }, 
		mag7 = { curve = 0.394366, filter_arms = 0, filter_chest = 1, filter_head = 1, filter_legs = 0, filter_stomach = 0, fov = 1.26761, fsd = 0, hitbox = 1, hitboxselect = 0, randomize = 0, rcs = 0, rcs_horiz = 100, rcs_standalone = 1, smooth = 6.30986, smoothtype = 0, tsd = 0.399061 }, 
		nova = { curve = 0.394366, filter_arms = 0, filter_chest = 1, filter_head = 0, filter_legs = 0, filter_stomach = 1, fov = 1.26761, fsd = 0.0117371, hitbox = 1, hitboxselect = 1, randomize = 4, rcs = 0, rcs_horiz = 100, rcs_standalone = 1, smooth = 6.30986, smoothtype = 0, tsd = 0.399061 },

	},  {
		g3sg1 = { curve = 0.5, filter_arms = 0, filter_chest = 1, filter_head = 1, filter_legs = 0, filter_stomach = 0, fov = 2.0625, fsd = 0.0117371, hitbox = 0, hitboxselect = 0, randomize = 3.56807, rcs = 1, rcs_horiz = 100, rcs_standalone = 0, smooth = 2.6338, smoothtype = 0, tsd = 0.394366 }, 
		scar20 = { curve = 0.5, filter_arms = 0, filter_chest = 1, filter_head = 1, filter_legs = 0, filter_stomach = 0, fov = 2.0625, fsd = 0.0117371, hitbox = 0, hitboxselect = 0, randomize = 3.56807, rcs = 1, rcs_horiz = 100, rcs_standalone = 0, smooth = 3.3, smoothtype = 0, tsd = 0.394366 }, 
		ssg08 = { curve = 0.5, filter_arms = 0, filter_chest = 0, filter_head = 1, filter_legs = 0, filter_stomach = 0, fov = 2.0625, fsd = 0.0117371, hitbox = 0, hitboxselect = 0, randomize = 1, rcs = 1, rcs_horiz = 100, rcs_standalone = 1, smooth = 1.2, smoothtype = 0, tsd = 0.394366 }, 
		awp = { curve = 0.5, filter_arms = 0, filter_chest = 0, filter_head = 1, filter_legs = 0, filter_stomach = 0, fov = 2.0625, fsd = 0.0117371, hitbox = 0, hitboxselect = 0, randomize = 1, rcs = 1, rcs_horiz = 100, rcs_standalone = 1, smooth = 1.2, smoothtype = 0, tsd = 0.394366 }, 

	}, {
		m249 = { curve = 0.5, filter_arms = 0, filter_chest = 1, filter_head = 1, filter_legs = 0, filter_stomach = 0, fov = 2.3, fsd = 0.01, hitbox = 0, hitboxselect = 0, randomize = 4, rcs = 1, rcs_horiz = 100, rcs_standalone = 1, smooth = 6.58216, smoothtype = 1, tsd = 0.22 }, 
		negev = { curve = 0.5, filter_arms = 0, filter_chest = 1, filter_head = 1, filter_legs = 0, filter_stomach = 0, fov = 2.3, fsd = 0.01, hitbox = 0, hitboxselect = 0, randomize = 4, rcs = 1, rcs_horiz = 100, rcs_standalone = 1, smooth = 6.58216, smoothtype = 1, tsd = 0.22 },
	}
}

local prevars = {
	'lbot_pistol_',
	'lbot_smg_',
	'lbot_rifle_',
	'lbot_shotgun_',
	'lbot_sniper_',
	'lbot_rifle_'
}

local GetLocalPlayerIndex, GetPlayerIndexByUserID, SetValue, pairs = client.GetLocalPlayerIndex, client.GetPlayerIndexByUserID, gui.SetValue, pairs
local function on_event(e)
	if e:GetName() ~= 'item_equip' then
		return
	end

	if GetLocalPlayerIndex() ~= GetPlayerIndexByUserID( e:GetInt('userid') ) then
		return
	end

	local item, weptype = e:GetString('item'), e:GetInt('weptype')

	local lbot_ = prevars[ weptype ]
	local tbl_w = weapons[ weptype ]

	if not tbl_w then
		return
	end

	local tbl = tbl_w[ item ]

	if not tbl then
		return
	end

	for k, v in pairs(tbl) do
		local var = lbot_.. k
		SetValue(var, v)
	end
end

client.AllowListener('item_equip')
callbacks.Register('FireGameEvent', on_event)
