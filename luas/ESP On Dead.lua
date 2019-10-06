local a,b,c,d,e,f,g = entities.GetLocalPlayer,string.format,gui.GetValue,gui.SetValue,gui.Combobox,gui.Checkbox,pairs
local h = f(gui.Reference('VISUALS','ENEMIES','Filter'),'lua_esp_on_dead','ESP On Dead',false)
local i,j = {},{}

local k = gui.Window('esp_on_dead_window','Esp On Dead/Alive',50,50,476,552)
local l = f(k,'lua_esp_on_dead_enabled','Active',false)
local m = gui.Groupbox(k,'Esp On Dead',16,48,212,457)
local n = {box=e(m,'esp_on_dead_box','Box','Off','2D','3D','Edges','Machine','Pentagon','Hexagon'),box_outline=f(m,'esp_on_dead_box_outline','Box Outline',false),box_precise=f(m,'esp_on_dead_box_precise','Box Precision',false),name=f(m,'esp_on_dead_name','Name',false),health=e(m,'esp_on_dead_health','Health','Off','Bar','Number','Both'),armor=f(m,'esp_on_dead_armor','Armor',false),weapon=e(m,'esp_on_dead_weapon','Weapon','Off','Show Active','Show All'),ammo=e(m,'esp_on_dead_ammo','Ammo','Off','Number','Bar'),skeleton=f(m,'esp_on_dead_skeleton','Skeleton',false),hitbox=e(m,'esp_on_dead_hitbox','Hitbox','Off','White','Color'),chams=e(m,'esp_on_dead_chams','Chams','Off','Color','Material','Color Wireframe','Mat Wireframe','Invisible','Metallic','Flat'),xqz=f(m,'esp_on_dead_xqz','XQZ',false),glow=e(m,'esp_on_dead_glow','Glow','Off','Team Color','Health Color'),headspot=f(m,'esp_on_dead_headspot','Head Spot',false),aimpoints=f(m,'esp_on_dead_aimpoints','Aim Points',false),hasc4=f(m,'esp_on_dead_hasc4','Has C4',false),hasdefuser=f(m,'esp_on_dead_hasdefuser','Has Defuser',false),defusing=f(m,'esp_on_dead_defusing','Is Defusing',false),flashed=f(m,'esp_on_dead_flashed','Is Flashed',false),scoped=f(m,'esp_on_dead_scoped','Is Scoped',false),reloading=f(m,'esp_on_dead_reloading','Is Reloading',false),comprank=f(m,'esp_on_dead_comprank','Competitive Rank',false),barrel=f(m,'esp_on_dead_barrel','Barrel',false),money=f(m,'esp_on_dead_money','Money',false),damage=f(m,'esp_on_dead_damage','Damage',false)}
local o = gui.Groupbox(k,'Esp On Alive',246,48,212,457)
local p = {box=e(o,'esp_on_alive_box','Box','Off','2D','3D','Edges','Machine','Pentagon','Hexagon'),box_outline=f(o,'esp_on_alive_box_outline','Box Outline',false),box_precise=f(o,'esp_on_alive_box_precise','Box Precision',false),name=f(o,'esp_on_alive_name','Name',false),health=e(o,'esp_on_alive_health','Health','Off','Bar','Number','Both'),armor=f(o,'esp_on_alive_armor','Armor',false),weapon=e(o,'esp_on_alive_weapon','Weapon','Off','Show Active','Show All'),ammo=e(o,'esp_on_alive_ammo','Ammo','Off','Number','Bar'),skeleton=f(o,'esp_on_alive_skeleton','Skeleton',false),hitbox=e(o,'esp_on_alive_hitbox','Hitbox','Off','White','Color'),chams=e(o,'esp_on_alive_chams','Chams','Off','Color','Material','Color Wireframe','Mat Wireframe','Invisible','Metallic','Flat'),xqz=f(o,'esp_on_alive_xqz','XQZ',false),glow=e(o,'esp_on_alive_glow','Glow','Off','Team Color','Health Color'),headspot=f(o,'esp_on_alive_headspot','Head Spot',false),aimpoints=f(o,'esp_on_alive_aimpoints','Aim Points',false),hasc4=f(o,'esp_on_alive_hasc4','Has C4',false),hasdefuser=f(o,'esp_on_alive_hasdefuser','Has Defuser',false),defusing=f(o,'esp_on_alive_defusing','Is Defusing',false),flashed=f(o,'esp_on_alive_flashed','Is Flashed',false),scoped=f(o,'esp_on_alive_scoped','Is Scoped',false),reloading=f(o,'esp_on_alive_reloading','Is Reloading',false),comprank=f(o,'esp_on_alive_comprank','Competitive Rank',false),barrel=f(o,'esp_on_alive_barrel','Barrel',false),money=f(o,'esp_on_alive_money','Money',false),damage=f(o,'esp_on_alive_damage','Damage',false)}

for x,v in g(n) do
	local x = b('esp_enemy_%s', x)
	i[x] = v
end
for x,v in g(p) do
	local x = b('esp_enemy_%s', x)
	j[x] = v
end
for x,v in g(p) do
	local a = b('esp_enemy_%s', x)
	local f = c(a)
	v:SetValue(f)
end

local function v(x)
	for i,v in g(x) do
		d(i, v:GetValue())
	end
end

local function A(z)
	local r = h:GetValue() and gui.Reference('MENU'):IsActive()
	k:SetActive(r)

	local s = not c('esp_filter_enemy') or not c('esp_active')

	if not l:GetValue() or s or a() == nil then
		return
	end
	
	local t = a():IsAlive() and j or i
	v(t)
end
callbacks.Register('CreateMove',A)