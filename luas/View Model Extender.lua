local G,S,F,E,T,R,C=client.GetConVar,client.SetConVar,string.format,gui.Editbox,gui.Text,gui.Reference,gui.Checkbox
local s,x,y,z=false,'viewmodel_offset_x','viewmodel_offset_y','viewmodel_offset_z'

local function c()
	cX = F('%s', G(x):sub(0,5))
	cY = F('%s', G(y):sub(0,5))
	cZ = F('%s', G(z):sub(0,5))
end c()

local function sv(a,b,c)
	S(x,a,true)
	S(y,b,true)
	S(z,c,true)
end

local sw = C(R('MISC','GENERAL','Main'),'lua_show_viewmodel_extender','Show Viewmodel Extender',false)
local w = gui.Window('lua_viewmodel_extender_window','Viewmodel Extender',200,200,201,254)
local g = gui.Groupbox(w,'Viewmodel Changer',16,16,170,194)
local e = C(g,'lua_viewmodel_extender_enabled','Enable',false)

T(g,'X')
local sX = E(g,'lua_viewmodel_extender_x',cX)

T(g,'Y')
local sY = E(g,'lua_viewmodel_extender_y',cY)

T(g,'Z')
local sZ = E(g,'lua_viewmodel_extender_z',cZ)

callbacks.Register('Draw', function()
	w:SetActive(sw:GetValue() and R('MENU'):IsActive())

	if e:GetValue() then
		sv(sX:GetValue(), sY:GetValue(), sZ:GetValue())
		s = true
	else
		if s then
			sv(cX, cY, cZ)
			s = false
		end
	end
end)