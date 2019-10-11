--[[ 
	Download for skyboxes 		  			 --> https://mega.nz/#!TZd1hawL!g_Os7eFUtFCLyBdraWWZMnROkGKeovy-1mZlLXerHxQ
	Drag all of the .vmt and .vtf files here 		 --> steamapps\common\Counter-Strike Global Offensive\csgo\materials\skybox
	If the skybox folder doesn't exist, create it.
]]

local a,b,c=gui.GetValue,client.GetConVar,client.SetConVar

local d = {
	'','sky_descent','bartuc_canyon_','bartuc_grey_sky_','blue1','blue2','blue3','blue4','blue5','blue6','cssdefault','dark1','dark2','dark3','dark4','dark5','extreme_glaciation_','green1','green2','green3','green4','green5','greenscreen','greysky','night1','night2','night3','night4','night5','orange1','orange2','orange3','orange4','orange5','orange6','persistent_fog_','pink1','pink2','pink3','pink4','pink5','polluted_atm_','toxic_atm_','water_sunset_',
}

local e = gui.Window('skybox_window', 'Skyboxes', 200, 0, 200, 100)
local f = gui.Combobox(e, "lua_skyboxppicker", "Skybox picker", 
	'Off', "Galaxy", "Bartuc Canyon", "Bartuc Grey", "Blue One", "Blue Two", "Blue Three", "Blue Four", "Blue Five", "Blue Six", "Css Default", "Dark One", "Dark Two", "Dark Three", "Dark Four", "Dark Five", "Extreme Glaciation", "Green One", "Green Two", "Green Three", "Green Four", "Green Five", "Green Screen","Grey Sky", "Night One", "Night Two", "Night Three", "Night Four", "Night Five","Orange One", "Orange Two", "Orange Three", "Orange Four", "Orange Five", "Orange Six", "Persistent Fog", "Pink One", "Pink Two", "Pink Three", "Pink Four", "Pink Five", "Polluted", "Toxic", "Water Sunset"
)

local function g()
	e:SetActive(gui.Reference('MENU'):IsActive())

	local h = d[f:GetValue() + 1]
    if a("msc_restrict") ~= 1 and b("sv_skyname") ~= h then
		c('sv_skyname', h, true)
    end
end

callbacks.Register("Draw", g)
