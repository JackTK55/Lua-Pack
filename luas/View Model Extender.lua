local client_GetConVar, client_SetConVar, string_format = client.GetConVar, client.SetConVar, string.format

local xO = string_format('%.3f', client_GetConVar("viewmodel_offset_x"))
local yO = string_format('%.3f', client_GetConVar("viewmodel_offset_y"))
local zO = string_format('%.3f', client_GetConVar("viewmodel_offset_z"))

local ViewModelShown = gui.Checkbox(gui.Reference("MISC", "GENERAL", "Main"), "msc_vme", "Viewmodel Changer", false)
local VM_W = gui.Window("VM_W", "Viewmodel Extender", 200,200,330,279)
local VMStuff = gui.Groupbox(VM_W, "Viewmodel Changer", 15, 14, 170, 218)
local VM_e = gui.Checkbox(VMStuff, "msc_vme", "Enable", false)
local VM_save_Cache = gui.Checkbox(VMStuff, "msc_vm_save_cache", "Cache Current X,Y,Z", false)

gui.Text(VMStuff, 'X')
local xS = gui.Editbox(VMStuff, "VM_X", xO)
gui.Text(VMStuff, 'Y')
local yS = gui.Editbox(VMStuff, "VM_Y", yO)
gui.Text(VMStuff, 'Z')
local zS = gui.Editbox(VMStuff, "VM_Z", zO)

local VMCache = gui.Groupbox(VM_W, "Cached Viewmodel", 186, 14, 129, 170)
gui.Text(VMCache, 'X')
local xC = gui.Editbox(VMCache, "VM_Xc", xO)
gui.Text(VMCache, 'Y')
local yC = gui.Editbox(VMCache, "VM_Yc", yO)
gui.Text(VMCache, 'Z')
local zC = gui.Editbox(VMCache, "VM_Zc", zO)

local menu_opened = true
callbacks.Register("Draw", "View Model Extender", function()
	if input.IsButtonPressed(gui.GetValue("msc_menutoggle")) then
		menu_opened = not menu_opened
	end

	if menu_opened then
		if ViewModelShown:GetValue() then
			VM_W:SetActive(1)
		else
			VM_W:SetActive(0)
		end
	else
		VM_W:SetActive(0)
	end
	
	if VM_e:GetValue() then
		client_SetConVar("viewmodel_offset_x", xS:GetValue(), true)
		client_SetConVar("viewmodel_offset_y", yS:GetValue(), true)
		client_SetConVar("viewmodel_offset_z", zS:GetValue(), true)
	else
		client_SetConVar("viewmodel_offset_x", xO, true)
		client_SetConVar("viewmodel_offset_y", yO, true)
		client_SetConVar("viewmodel_offset_z", zO, true)
	end
	
	if VM_save_Cache:GetValue() then
		xO = string_format('%.3f', client_GetConVar("viewmodel_offset_x"))
		yO = string_format('%.3f', client_GetConVar("viewmodel_offset_y"))
		zO = string_format('%.3f', client_GetConVar("viewmodel_offset_z"))
		gui.SetValue('VM_Xc', xO)
		gui.SetValue('VM_Yc', yO)
		gui.SetValue('VM_Zc', zO)
		
		VM_save_Cache:SetValue(0)
	end
	
end)