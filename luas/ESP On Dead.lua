local a,b,c,d,e,f,g = entities.GetLocalPlayer,string.format,gui.GetValue,gui.SetValue,gui.Combobox,gui.Checkbox,pairs
local h = f(gui.Reference('VISUALS','ENEMIES','Filter'),'lua_esp_on_dead','ESP On Dead',false)
local i,j = {},{}

local k = gui.Window('esp_on_dead_window','Esp On Dead',50,50,243,483)
local m = gui.Groupbox(k,'Esp On Dead',16,16,212,420)
local l = f(m,'lua_esp_on_dead_enabled','Active',false)
local n = {box=e(m,'esp_on_dead_box','Box','Off','2D','3D','Edges','Machine','Pentagon','Hexagon'),box_outline=f(m,'esp_on_dead_box_outline','Box Outline',false),box_precise=f(m,'esp_on_dead_box_precise','Box Precision',false),name=f(m,'esp_on_dead_name','Name',false),health=e(m,'esp_on_dead_health','Health','Off','Bar','Number','Both'),armor=f(m,'esp_on_dead_armor','Armor',false),weapon=e(m,'esp_on_dead_weapon','Weapon','Off','Show Active','Show All'),ammo=e(m,'esp_on_dead_ammo','Ammo','Off','Number','Bar'),skeleton=f(m,'esp_on_dead_skeleton','Skeleton',false),hitbox=e(m,'esp_on_dead_hitbox','Hitbox','Off','White','Color'),chams=e(m,'esp_on_dead_chams','Chams','Off','Color','Material','Color Wireframe','Mat Wireframe','Invisible','Metallic','Flat'),xqz=f(m,'esp_on_dead_xqz','XQZ',false),glow=e(m,'esp_on_dead_glow','Glow','Off','Team Color','Health Color'),headspot=f(m,'esp_on_dead_headspot','Head Spot',false),aimpoints=f(m,'esp_on_dead_aimpoints','Aim Points',false),hasc4=f(m,'esp_on_dead_hasc4','Has C4',false),hasdefuser=f(m,'esp_on_dead_hasdefuser','Has Defuser',false),defusing=f(m,'esp_on_dead_defusing','Is Defusing',false),flashed=f(m,'esp_on_dead_flashed','Is Flashed',false),scoped=f(m,'esp_on_dead_scoped','Is Scoped',false),reloading=f(m,'esp_on_dead_reloading','Is Reloading',false),comprank=f(m,'esp_on_dead_comprank','Competitive Rank',false),barrel=f(m,'esp_on_dead_barrel','Barrel',false),money=f(m,'esp_on_dead_money','Money',false),damage=f(m,'esp_on_dead_damage','Damage',false)}

for x,v in g(n) do
	local x = b('esp_enemy_%s', x)
	i[x] = v
end

local function o()
	for x,v in g(i) do
		local v = c(x)
		j[x] = v
	end
end
o()

local function v(x, y)
	if y then
		for x,v in g(x) do
			d(x, v)
		end
	else
		for x,v in g(x) do
			d(x, v:GetValue())
		end
	end
end

local function A()
	local s = not c('esp_filter_enemy') or not c('esp_active')
	local r = h:GetValue() and gui.Reference('MENU'):IsActive()
	k:SetActive(r)

	if not l:GetValue() or a() == nil or s then
		return
	end

	local t = not a():IsAlive() and i or j
	v(t, a():IsAlive())

	if not a():IsAlive() then
		return
	end

	o()
end
callbacks.Register('Draw',A)