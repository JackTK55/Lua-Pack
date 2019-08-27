--[[ 
	download for skyboxes 		  --> https://mega.nz/#!TZd1hawL!g_Os7eFUtFCLyBdraWWZMnROkGKeovy-1mZlLXerHxQ
	drag all of the skyboxes here --> steamapps\common\Counter-Strike Global Offensive\csgo\materials\skybox
]]

local gui_GetValue, client_GetConVar, client_SetConVar = gui.GetValue, client.GetConVar, client.SetConVar

local skyboxes = {
	'', 'sky_descent', 'bartuc_canyon_', 'bartuc_grey_sky_', 'blue1', 'blue2', 'blue3', 'blue4', 'blue5', 'blue6', 'cssdefault', 'dark1', 'dark2', 'dark3', 'dark4', 'dark5', 'extreme_glaciation_', 'green1', 'green2', 'green3', 'green4', 'green5', 'greenscreen', 'greysky', 'night1', 'night2', 'night3', 'night4', 'night5', 'orange1', 'orange2', 'orange3', 'orange4', 'orange5', 'orange6', 'persistent_fog_', 'pink1', 'pink2', 'pink3', 'pink4', 'pink5', 'polluted_atm_', 'toxic_atm_', 'water_sunset_',
}

local skybox_window = gui.Window('skybox_window', 'Skyboxes', 200, 0, 200, 100)

local skybox_combo = gui.Combobox(skybox_window, "lua_skyboxppicker", "Skybox picker", 
	'Off', "Galaxy", "Bartuc Canyon", "Bartuc Grey", "Blue One", "Blue Two", "Blue Three", "Blue Four", "Blue Five", "Blue Six", "Css Default", "Dark One", "Dark Two", "Dark Three", "Dark Four", "Dark Five", "Extreme Glaciation", "Green One", "Green Two", "Green Three", "Green Four", "Green Five", "Green Screen","Grey Sky", "Night One", "Night Two", "Night Three", "Night Four", "Night Five","Orange One", "Orange Two", "Orange Three", "Orange Four", "Orange Five", "Orange Six", "Persistent Fog", "Pink One", "Pink Two", "Pink Three", "Pink Four", "Pink Five", "Polluted", "Toxic", "Water Sunset"
)

callbacks.Register("Draw", "Skybox Changer", function()
	skybox_window:SetActive(gui.Reference('MENU'):IsActive())
	local skybox_new = skyboxes[skybox_combo:GetValue() + 1] or ''
    if gui_GetValue("msc_restrict") ~= 1 and client_GetConVar("sv_skyname") ~= skybox_new then
		client_SetConVar('sv_skyname', skybox_new, true)
    end
end)