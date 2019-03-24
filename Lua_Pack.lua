-- stuff
local draw_Line, draw_TextShadow, draw_Color, draw_Text, g_tickinterval, string_format, http_Get, string_gsub, file_Open, math_exp, math_rad, math_max, math_abs, math_tan, math_sin, math_cos, math_fmod, draw_GetTextSize, draw_FilledRect, draw_RoundedRect, draw_RoundedRectFill, draw_CreateFont, draw_SetFont, client_WorldToScreen, draw_GetScreenSize, client_GetConVar, client_SetConVar, client_exec, PlayerNameByUserID, PlayerIndexByUserID, entities_GetByIndex, GetLocalPlayer, gui_SetValue, gui_GetValue, LocalPlayerIndex, c_AllowListener, cb_Register, g_tickcount, g_realtime, g_curtime, g_absoluteframetime, math_floor, math_sqrt, GetPlayerResources, entities_FindByClass, IsButtonPressed, client_ChatSay, table_insert, table_remove, vector_Distance = draw.Line, draw.TextShadow, draw.Color, draw.Text, globals.TickInterval, string.format, http.Get, string.gsub, file.Open, math.exp, math.rad, math.max, math.abs, math.tan, math.sin, math.cos, math.fmod, draw.GetTextSize, draw.FilledRect, draw.RoundedRect, draw.RoundedRectFill, draw.CreateFont, draw.SetFont, client.WorldToScreen, draw.GetScreenSize, client.GetConVar, client.SetConVar, client.Command, client.GetPlayerNameByUserID, client.GetPlayerIndexByUserID, entities.GetByIndex, entities.GetLocalPlayer, gui.SetValue, gui.GetValue, client.GetLocalPlayerIndex, client.AllowListener, callbacks.Register, globals.TickCount, globals.RealTime, globals.CurTime, globals.AbsoluteFrameTime, math.floor, math.sqrt, entities.GetPlayerResources, entities.FindByClass, input.IsButtonPressed, client.ChatSay, table.insert, table.remove, vector.Distance
-------------- References
local G_VM = gui.Groupbox(gui.Reference("VISUALS", "Shared"), "Extra Features", 0, 397, 200, 200)
local VOO_Ref = gui.Reference("VISUALS", "OTHER", "Options")
local VEO_Ref = gui.Reference("VISUALS", "ENEMIES", "Options")
local VTO_Ref = gui.Reference("VISUALS", "TEAMMATES", "Options")
local G_M1 = gui.Groupbox(gui.Reference("MISC", "GENERAL", "Main"), "Extra Features", 0, 206, 200, 272)
-------------- Font
local Vf30 = draw_CreateFont("Verdana", 30) 
local Vf12 = draw_CreateFont("Verdana", 12) 
local Tf = draw_CreateFont("Tahoma")
-------------- Better Grenades
local better_grenades = gui.Checkbox(VOO_Ref, "esp_other_better_grenades", "Better Grenades", false)
-------------- Hit Log 
local HitLog = gui.Checkbox(G_M1, "msc_hitlog", "Hit Log", false)
-------------- Auto Buy
local AB_Show = gui.Checkbox(G_M1, "msc_autobuy", "AutoBuy", false)
local AB_W = gui.Window("AB_W", "Auto Buy", 200, 200, 200, 328)
local AB_GB = gui.Groupbox(AB_W, "Auto Buy Settings", 15, 14, 170, 268)
local AB_E = gui.Checkbox(AB_GB, "AB_Active", "Active", false)
local PrimaryWeapons = gui.Combobox(AB_GB, "AB_Primary_Weapons", "Primary Weapons", "Off", "AK | M4", "Scout", "SG553 | AUG", "AWP", "Auto")
local SecondaryWeapons = gui.Combobox(AB_GB, "AB_Secondary_Weapons", "Secondary Weapons", "Off", "Elite", "P250", "Tec-9 | Five-Seven", "R8 | Deagle")
local Armor = gui.Combobox(AB_GB, "AB_Armor", "Armor", "Off", "Kevlar", "Kevlar + Helmet")
local Nades = gui.Checkbox(AB_GB, "AB_Nades", "Grenades", false)
local Zeus = gui.Checkbox(AB_GB, "AB_Zeus", "Zeus", false)
local Defuser = gui.Checkbox(AB_GB, "AB_Defuser", "Defuser", false)
-------------- Spec List
local SpectatorList = gui.Checkbox(G_M1, "msc_speclist", "Spectators", false)
-------------- Show Team Damage
local TeamDamageShow = gui.Checkbox(G_M1, "msc_showteamdmg", "Show Team Damage", false)
-------------- View Model Extender
local function VM_Cache() xO = client_GetConVar("viewmodel_offset_x") yO = client_GetConVar("viewmodel_offset_y") zO = client_GetConVar("viewmodel_offset_z") fO = client_GetConVar("viewmodel_fov") end VM_Cache()
local ViewModelShown = gui.Checkbox(G_M1, "msc_vme", "Viewmodel Changer", false)
local VM_W = gui.Window("VM_W", "Viewmodel Extender", 200,200,200,300)
local VMStuff = gui.Groupbox(VM_W, "Viewmodel Stuff", 15, 14, 170, 240)
local VM_e = gui.Checkbox(VMStuff, "msc_vme", "Enable", false)
local xS = gui.Slider(VMStuff, "VM_X", "X", xO, -20, 20)
local yS = gui.Slider(VMStuff, "VM_Y", "Y", yO, -100, 100)
local zS = gui.Slider(VMStuff, "VM_Z", "Z", zO, -20, 20)
local vfov = gui.Slider(VMStuff, "VM_fov", "Viewmodel FOV", fO, 0, 120)
-------------- Sniper Crosshair
local ComboCrosshair = gui.Combobox(G_VM, "vis_sniper_crosshair", "Sniper Crosshair", "Off", "Engine Crosshair", "Engine Crosshair (+scoped)", "Aimware Crosshair", "Draw Crosshair")
-------------- Scoped FOV Fix
local s_fovfix = gui.Checkbox(G_VM, "vis_fixfov", "Fix Scoped FOV", false)
local fov_value, vm_fov_value = gui_GetValue("vis_view_fov"), gui_GetValue("vis_view_model_fov")
-------------- Knife On Left Hand
local K_O_L_H = gui.Checkbox(G_M1, "msc_knifelefthand", "Knife On Left Hand", false)
-------------- Bomb Timer
local BombTimer = gui.Checkbox(VOO_Ref, "esp_other_better_c4timer", "Bomb Timer", false)
-------------- Bomb Damage
local Bomb_Damage = gui.Checkbox(VOO_Ref, "esp_other_bombdamage", "Bomb Damage", false)
-------------- Chat Spammer
local CC_Show = gui.Checkbox(G_M1, "msc_chat_spams", "Chat Spams", false)
local CC_W = gui.Window("CC_W", "Chat Spam", 200,200,200,285)
local CC_G1 = gui.Groupbox(CC_W, "Chat Spams", 15, 15, 170, 224)
local CC_Spams = gui.Combobox(CC_G1, "CC_Spam", "Spams", "Off", "Spam 1", "Spam 2", "Clear Chat")
local CC_Spam_spd = gui.Slider(CC_G1, "CC_Spam_Speed", "Spam Speed", 67.5, 10, 250)
local chatspam1txt = gui.Text(CC_G1, "Spam 1") local ChatSpam1 = gui.Editbox(CC_G1, "CC_Spam1", "Custom Chat Spam 1")
local chatspam2txt = gui.Text(CC_G1, "Spam 2") local ChatSpam2 = gui.Editbox(CC_G1, "CC_Spam2", "Custom Chat Spam 2")
-------------- Aspect Ratio Changer
local aspect_ratio_table = {}
local aspect_ratio_check = gui.Checkbox(G_M1, "msc_aspect_enable", "Aspect Ratio Changer", false) 
local aspect_ratio_reference = gui.Slider(G_M1, "msc_aspect_value", "Force aspect ratio", 100, 1, 199) -- % times your original ratio
-------------- Esp On Dead
local espdead = gui.Checkbox(gui.Reference("VISUALS", "ENEMIES", "Filter"), "esp_espondead", "ESP when dead", false)
-------------- Engine Radar
local ERadar = gui.Checkbox(G_VM, "esp_engine_radar", "Engine Radar", false)
-------------- Team & Enemy Tracers
local tracersEnemy = gui.Checkbox(VEO_Ref, "esp_enemy_tracer", "Tracers", false)
local tracersTeam = gui.Checkbox(VTO_Ref, "esp_team_tracer", "Tracers", false)
-------------- Team & Enemy & Other Distance + visible help 
local enemy_distance = gui.Checkbox(VEO_Ref, "esp_enemy_distance", "Distance", false)
local team_distance = gui.Checkbox(VTO_Ref, "esp_team_distance", "Distance", false)
local other_distance = gui.Checkbox(VOO_Ref, "esp_other_distance", "Distance", false)
-------------- Full Bright
local fBright = gui.Checkbox(G_VM, "vis_fullbright", "Full Bright", false)
-------------- Disable Post Processing
local DPP = gui.Checkbox(G_VM, "vis_disable_post", "Disable Post Processing", false)
-------------- Zeusbot
local zeusbot = gui.Checkbox(gui.Reference("LEGIT", "Extra"), "lbot_zeusbot_enable", "Zeusbot", false)
local trige, trigm, trigaf, trighc = gui_GetValue("lbot_trg_enable"), gui_GetValue("lbot_trg_mode"), gui_GetValue("lbot_trg_autofire"), gui_GetValue("lbot_trg_hitchance")
-------------- Recoil Crosshair
local RecoilCrosshair = gui.Checkbox(G_VM, "vis_recoilcrosshair", "Recoil Crosshair", false)
-------------- Disable Fake angle ghost while in air
local fakeangleghost = gui.Checkbox(gui.Reference("VISUALS", "MISC", "Yourself Extra"), "vis_disable_fakeangleghost_inair", "Disable Fake Angle Ghost in air", false)
-------------- Infinite Name Spam
local infname = gui.Checkbox(gui.Reference("MISC", "ENHANCEMENT", "Appearance"), "msc_infinite_namespam_button", "Enable infinite namespam [BUTTON]", false)
-------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------- 
local frame_rate, menu_opened = 0.0, true
local function get_abs_fps() frame_rate = 0.9 * frame_rate + (1.0 - 0.9) * g_absoluteframetime() return math_floor((1.0 / frame_rate) + 0.5) end
local function lerp_pos(x1, y1, z1, x2, y2, z2, percentage) local x = (x2 - x1) * percentage + x1 local y = (y2 - y1) * percentage + y1 local z = (z2 - z1) * percentage + z1 return x, y, z end
local function distance3D(x1, y1, z1, x2, y2, z2) return math_floor(vector_Distance(x1, y1, z1, x2, y2, z2)) end
local function menus() if IsButtonPressed(gui_GetValue("msc_menutoggle")) then menu_opened = not menu_opened end if menu_opened then if AB_Show:GetValue() then AB_W:SetActive(1) else AB_W:SetActive(0) end if ViewModelShown:GetValue() then VM_W:SetActive(1) else VM_W:SetActive(0) end if CC_Show:GetValue() then CC_W:SetActive(1) else CC_W:SetActive(0) end else AB_W:SetActive(0) VM_W:SetActive(0) CC_W:SetActive(0) end end cb_Register("Draw", "shows", menus)

-------------------- Auto Updater
local scriptName = GetScriptName()
local scriptFile = "https://raw.githubusercontent.com/Zack2kl/Lua-Pack/master/Lua_Pack.lua"
local versionFile = "https://raw.githubusercontent.com/Zack2kl/Lua-Pack/master/version.txt"
local currentVersion = "1.4.2.4"
local updateAvailable, newVersionCheck, updateDownloaded = false, true, false

function autoupdater()
if not gui_GetValue("lua_allow_http") or common.Time() > 60 then return end
if newVersionCheck then local newVersion = http_Get(versionFile) if currentVersion ~= newVersion then updateAvailable = true end newVersionCheck = false end 
if updateAvailable and not updateDownloaded then if not gui_GetValue("lua_allow_cfg") then draw_Color(255, 255, 255, 255) draw_Text(2, 0, string_gsub(scriptName, ".lua", "")..": Update Available, Script/Config editing is Required") else local newScript = http_Get(scriptFile) local oldScript = file_Open(scriptName, "w") oldScript:Write(newScript) oldScript:Close() updateAvailable = false updateDownloaded = true print(string_gsub(scriptName, ".lua", " updated from"), currentVersion, "to", http_Get(versionFile)) print(string_gsub(scriptName, ".lua", ": "), "If there are any issues contact me on discord Zack#1307") end end
if updateDownloaded then draw_Color(255, 255, 255, 255) draw_Text(2, 0, string_gsub(scriptName, ".lua", "")..": Update Downloaded, reload the script") end end
cb_Register("Draw", "Auto Update", autoupdater)

-------------------- Grenade Timers
local updatetick = 0 local grenades = {}
function EventHook(Event)
if not better_grenades:GetValue() then return end
if Event:GetName() == "round_prestart" then grenades = {} end
if Event:GetName() == "hegrenade_detonate" or Event:GetName() == "flashbang_detonate" or Event:GetName() == "inferno_expire" or Event:GetName() == "inferno_extinguish" then updatetick = g_tickcount() for index,value in pairs(grenades) do if value[1] == Event:GetInt("entityid") then table_remove(grenades, index) end end end end
function ESPHook(Builder)
if not better_grenades:GetValue() then return end
if Builder:GetEntity():GetClass() == "CSmokeGrenadeProjectile" and Builder:GetEntity():GetProp("m_nSmokeEffectTickBegin") ~= 0 then delta = (g_tickcount() - Builder:GetEntity():GetProp("m_nSmokeEffectTickBegin")) * g_tickinterval() Builder:AddBarBottom(1 - (delta/17.5))
elseif Builder:GetEntity():GetClass() == "CBaseCSGrenadeProjectile" then local found = false for index,value in pairs(grenades) do if value[1] == Builder:GetEntity():GetIndex() then DeltaT = (g_tickcount() - grenades[index][2]) * g_tickinterval() Builder:AddBarBottom(1 - (DeltaT/1.65)) found = true end end
if found == false and g_tickcount() > updatetick then local gMatrix = {Builder:GetEntity():GetIndex(), g_tickcount()} table_insert(grenades, gMatrix) end end end
function DrawingHook()
if not better_grenades:GetValue() then return end
for indexF,valueF in pairs(entities_FindByClass("CInferno")) do local found = false for indexT,valueT in pairs(grenades) do if valueT[1] ~= valueF:GetIndex() then return end
x, y = client_WorldToScreen(valueF:GetAbsOrigin()) local mollysize = 25 if x == nil and y == nil then return end draw_Color(0, 0, 0, 255) draw_RoundedRectFill( x - mollysize, y, x + mollysize, y + 4 )
local math = (((g_tickcount() - valueT[2]) * ((-1) - 1))/ ((valueT[2] + 7 / g_tickinterval()) - valueT[2])) + 1 draw_Color(227, 227, 227, 255) draw_RoundedRectFill(x - mollysize, y, x + mollysize * math, y + 4) draw_Color(255, 255, 255, 255) draw_RoundedRect(x - mollysize, y, x + mollysize, y + 4) 
draw_SetFont(Tf) local w,h = draw_GetTextSize("MOLLY") draw_TextShadow(x - w/2, y - h * 1.25 , "MOLLY") found = true end if found == false and g_tickcount() > updatetick then local gMatrix = {valueF:GetIndex(), g_tickcount()} table_insert(grenades, gMatrix) end end end
cb_Register("Draw", DrawingHook) cb_Register("DrawESP", ESPHook) cb_Register("FireGameEvent", EventHook) 

-------------------- Hit Log
local hitgroup_names = {"head", "chest", "stomach", "left arm", "right arm", "left leg", "right leg"}
local draw_hitsay = {}
function ChatLogger(Event)
if not HitLog:GetValue() or Event:GetName() == nil or Event:GetName() ~= "player_hurt" then return end
local attacker, victim = PlayerIndexByUserID(Event:GetInt("attacker")), PlayerIndexByUserID(Event:GetInt("userid"))
if attacker ~= LocalPlayerIndex() or victim == LocalPlayerIndex() then return end
local victimName, dmg, health, hitGroup = PlayerNameByUserID(Event:GetInt("userid")), Event:GetString("dmg_health"), Event:GetString("health"), hitgroup_names[Event:GetInt("hitgroup")] or "body"
response = string_format("Hit %s in the %s for %s damage (%s health remaining)", victimName, hitGroup, dmg, health) table_insert(draw_hitsay, {g_curtime(), response}) end
local On_Screen_Time, pixels_between_each_line, ScreenX, ScreenY, lowestopacity = 15, 12, 8, 3, 63.5
function hitlog()
if not HitLog:GetValue() or GetLocalPlayer() == nil then return end local things_on_screen = 0 for k, l in pairs(draw_hitsay) do local a = 1 
a = (On_Screen_Time - (g_curtime() - l[1])) / On_Screen_Time
if 255*a < lowestopacity then table_remove(draw_hitsay, k) else draw_SetFont(Tf) draw_Color(255,255,255,255*a) draw_TextShadow(ScreenX, things_on_screen * pixels_between_each_line + ScreenY, l[2]) things_on_screen = things_on_screen + 1 end end end
cb_Register("Draw", hitlog) cb_Register("FireGameEvent", ChatLogger)  

-------------------- Auto Buy 
local SecondaryWeapon, PrimaryWeapon, buy_armor = "", "", ""
function buy(Event)
if not AB_E:GetValue() or GetLocalPlayer() == nil or Event:GetName() == nil then return end
if Event:GetName() == "player_spawn" then if PlayerIndexByUserID(Event:GetInt("userid")) == LocalPlayerIndex() then buy = true end end money = GetLocalPlayer():GetProp("m_iAccount")
if buy then if (SecondaryWeapons:GetValue() == 0) then SecondaryWeapon = ""
elseif (SecondaryWeapons:GetValue() == 1) then SecondaryWeapon = 'buy "elite"; '
elseif (SecondaryWeapons:GetValue() == 2) then SecondaryWeapon = 'buy "p250"; '
elseif (SecondaryWeapons:GetValue() == 3) then SecondaryWeapon = 'buy "tec9"; '
elseif (SecondaryWeapons:GetValue() == 4) then SecondaryWeapon = 'buy "deagle"; ' end
if money >= 3000 or money < 1 then PWb = true end
if PWb then if (PrimaryWeapons:GetValue() == 0) then PrimaryWeapon = ""
elseif (PrimaryWeapons:GetValue() == 1) then PrimaryWeapon = 'buy "ak47"; '
elseif (PrimaryWeapons:GetValue() == 2) then PrimaryWeapon = 'buy "ssg08"; '
elseif (PrimaryWeapons:GetValue() == 3) then PrimaryWeapon = 'buy "sg556"; '
elseif (PrimaryWeapons:GetValue() == 4) then PrimaryWeapon = 'buy "awp"; '
elseif (PrimaryWeapons:GetValue() == 5) then PrimaryWeapon = 'buy "scar20"; ' end
if Armor:GetValue() == 0 then buy_armor = ""
elseif Armor:GetValue() == 1 then buy_armor = 'buy "vest"; '
elseif Armor:GetValue() == 2 then buy_armor = 'buy "vest"; buy "vesthelm"' end
if Nades:GetValue() then client_exec('buy "hegrenade"; buy "incgrenade"; buy "molotov"; buy "smokegrenade"; buy "flashbang"', true) end
if Zeus:GetValue() then client_exec('buy "taser"', true) end
if Defuser:GetValue() then client_exec('buy "defuser"', true) end PWb = false end current_buy = (PrimaryWeapon.. SecondaryWeapon.. buy_armor) client_exec(current_buy, true) buy = false end end
cb_Register("FireGameEvent", buy)

-------------------- View Model Extender | Spectator list fix / made by anue | Disable Post Processing | full bright | Engine Radar | Disable Fake angle ghost while in air
function VM_E() if VM_e:GetValue() then client_SetConVar("viewmodel_offset_x", xS:GetValue(), true) client_SetConVar("viewmodel_offset_y", yS:GetValue(), true) client_SetConVar("viewmodel_offset_z", zS:GetValue(), true) client_SetConVar("viewmodel_fov", vfov:GetValue(), true) else client_SetConVar("viewmodel_offset_x", xO, true) client_SetConVar("viewmodel_offset_y", yO, true) client_SetConVar("viewmodel_offset_z", zO, true) client_SetConVar("viewmodel_fov", fO, true) end end cb_Register("Draw", VM_E)
function speclistfix(E) if not gui_GetValue("msc_showspec") or E:GetName() ~= "round_start" then return end client_exec("cl_fullupdate", true) end cb_Register("FireGameEvent", speclistfix)
function Dis_PP() if DPP:GetValue() then client_SetConVar("mat_postprocess_enable", 0, true) else client_SetConVar("mat_postprocess_enable", 1, true) end end cb_Register("Draw", Dis_PP)
function full_bright() if fBright:GetValue() then client_SetConVar("mat_fullbright", 1, true) else client_SetConVar("mat_fullbright", 0, true) end end cb_Register("Draw", full_bright)
function engineradar() if ERadar:GetValue() then ERval = 1 else ERval = 0 return end for a, player in pairs(entities_FindByClass("CCSPlayer")) do player:SetProp("m_bSpotted", ERval) end end cb_Register("Draw", engineradar)
function Disable_FakeAAGhost(UserCMD) if not fakeangleghost:GetValue() then return end if gui.GetValue("vis_fakeghost") ~= 0 then fakeghostval = gui.GetValue("vis_fakeghost") end if GetLocalPlayer():GetProp("m_fFlags") == 256 then gui.SetValue("vis_fakeghost", 0) else gui.SetValue("vis_fakeghost", fakeghostval) end end cb_Register("CreateMove", Disable_FakeAAGhost)

-------------------- Scoped Fov Fix
function scopefov()
if not s_fovfix:GetValue() or GetLocalPlayer() == nil then return end
local view_fov = gui_GetValue("vis_view_fov") local view_model_fov = gui_GetValue("vis_view_model_fov")
if view_fov ~= 0 then fov_value = gui_GetValue("vis_view_fov") end if view_model_fov ~= 0 then vm_fov_value = gui_GetValue("vis_view_model_fov") end
if GetLocalPlayer():GetProp("m_bIsScoped") == 1 or GetLocalPlayer():GetProp("m_bIsScoped") == 257 then gui_SetValue("vis_view_fov", 0) gui_SetValue("vis_view_model_fov", 0) 
elseif view_fov == 0 then gui_SetValue("vis_view_fov", fov_value) gui_SetValue("vis_view_model_fov", vm_fov_value) end end
cb_Register("Draw", "fixes scoped fov", scopefov)

-------------------- Sniper Crosshair
function ifCrosshair()
if GetLocalPlayer() == nil or ComboCrosshair:GetValue() == 0 then return end
local Weapon = GetLocalPlayer():GetPropEntity("m_hActiveWeapon") local Scoped = GetLocalPlayer():GetProp("m_bIsScoped") == 1 or GetLocalPlayer():GetProp("m_bIsScoped") == 257
if Weapon == nil then return end local cWep = Weapon:GetClass()
if cWep == "CWeaponAWP" or cWep == "CWeaponSSG08" or cWep == "CWeaponSCAR20" or cWep == "CWeaponG3SG1" then drawCrosshair = true else drawCrosshair = false end local screenCenterX, screenY = draw_GetScreenSize() local scX, scY = screenCenterX / 2, screenY / 2
if drawCrosshair == true and ComboCrosshair:GetValue() == 0 then client_SetConVar("weapon_debug_spread_show", 0, true)
elseif drawCrosshair == true and ComboCrosshair:GetValue() == 1 then gui_SetValue("esp_crosshair", false) if Scoped then client_SetConVar("weapon_debug_spread_show", 0, true) else client_SetConVar("weapon_debug_spread_show", 3, true) end
elseif drawCrosshair == true and ComboCrosshair:GetValue() == 2 then gui_SetValue("esp_crosshair", false) client_SetConVar("weapon_debug_spread_show", 3, true)
elseif drawCrosshair == true and ComboCrosshair:GetValue() == 3 then if Scoped then gui_SetValue("esp_crosshair", false) else client_SetConVar("weapon_debug_spread_show", 0, true) gui_SetValue("esp_crosshair", true) end 
elseif drawCrosshair == false and ComboCrosshair:GetValue() == 3 then gui_SetValue("esp_crosshair", false)
elseif drawCrosshair == true and ComboCrosshair:GetValue() == 4 then client_SetConVar("weapon_debug_spread_show", 0, true) gui_SetValue("esp_crosshair", false) draw_Color(255,255,255,255) draw_Line(scX, scY - 8, scX, scY + 8) --[[ line down ]] draw_Line(scX - 8, scY, scX + 8, scY) --[[ line across ]] end end
cb_Register("Draw", ifCrosshair)

-------------------- Bomb Timer & defuse timer
local function mathfix() local screenX, screenY = draw_GetScreenSize() screenY3 = screenY/2 end cb_Register("Draw", "fixes screenY3", mathfix)
local function get_site_name(site) local a_x, a_y, a_z = GetPlayerResources():GetProp("m_bombsiteCenterA") local b_x, b_y, b_z = GetPlayerResources():GetProp("m_bombsiteCenterB") local site_x1, site_y1, site_z1 = site:GetMins() local site_x2, site_y2, site_z2 = site:GetMaxs() local site_x, site_y, site_z = lerp_pos(site_x1, site_y1, site_z1, site_x2, site_y2, site_z2, 0.5) local distance_a, distance_b = vector_Distance(site_x, site_y, site_z, a_x, a_y, a_z), vector_Distance(site_x, site_y, site_z, b_x, b_y, b_z) return distance_b > distance_a and "A" or "B" end
local colorchange, drawBar, drawDefuse, drawPlanting, plantedTime, plantedTime2, fill, fill2, fill3, plantingName, plantingStarted, plantingTime, plantingSite = 10, false, false, false, 0, 0, 0, screenY3, 0, "", 0, 3.125, ""
function bomb(event)
if not BombTimer:GetValue() then return end
if event:GetName() == "bomb_beginplant" then ScreenX = 20 ScreenY = 55 fill = 0 fill2 = screenY3 fill3 = 0 drawPlanting = true plantingName = PlayerNameByUserID(event:GetInt("userid")) plantingStarted = g_curtime() plantingSite = get_site_name(entities_GetByIndex(event:GetInt("site"))) end
if event:GetName() == "bomb_abortplant" then ScreenX = 8 ScreenY = 3 drawPlanting = false end
if event:GetName() == "bomb_planted" then ScreenX = 20 ScreenY = 55 plantedTime = g_curtime() drawBar = true drawPlanting = false end
if event:GetName() == "bomb_begindefuse" then ScreenX = 20 ScreenY = 79 defusingName = PlayerNameByUserID(event:GetInt("userid")) plantedTime2 = g_curtime() drawDefuse = true end
if event:GetName() == "bomb_abortdefuse" then ScreenX = 20 ScreenY = 55 drawDefuse = false fill2 = screenY3 fill3 = 0 end
if event:GetName() == "bomb_defused" then drawBar = false drawDefuse = false end
if event:GetName() == "round_officially_ended" then drawBar = false drawDefuse = false end 
if event:GetName() == "round_start" then ScreenX = 8 ScreenY = 3 draw_hitsay = {} end end
function drawProgress()
if not BombTimer:GetValue() then return end local screenX, screenY = draw_GetScreenSize() local Player = GetLocalPlayer()
if drawBar and entities_FindByClass("CPlantedC4")[1] ~= nil then local ToExplode = entities_FindByClass("CPlantedC4")[1] c4time = math_floor(ToExplode:GetProp("m_flTimerLength")) C4time = math_floor(((plantedTime - g_curtime()) + c4time))
if C4time > -1  then local godownby = (screenY / c4time) / get_abs_fps() 
if Player:GetTeamNumber() == 3 and Player:GetProp("m_bHasDefuser") == 0 and C4time <= 10.05 then r, g, b, a = 255,13,13,255 
elseif Player:GetTeamNumber() == 3 and Player:GetProp("m_bHasDefuser") == 1 and C4time <= 5.05 then r, g, b, a = 255,13,13,255 else r, g, b, a = 255,255,255,255 end
local bombsite = ToExplode:GetProp("m_nBombSite") == 0 and "A" or "B" siteinfo = string_format("%s - %.1fs", bombsite, ((plantedTime - g_curtime()) + c4time)) draw_SetFont(Vf30) draw_Color(r, g, b, a) draw_Text(20, 0, siteinfo)
if C4time <= colorchange then draw_Color(255,0,0,255) else draw_Color(0,255,0,255) end draw_FilledRect(1, fill, 15, screenY) draw_Color(0,0,0,100) draw_FilledRect(0, 0, 16, screenY) fill = fill + godownby end end
if drawPlanting then local plant_percentage = (g_curtime() - plantingStarted) / plantingTime local plantinfo = string_format("%s -%.1fs", plantingName, (plantingStarted - g_curtime()) + plantingTime) 
if plant_percentage > 0 and 1 > plant_percentage then local remove_from_Y = screenY * (1 - plant_percentage) draw_SetFont(Vf30) draw_Color(255,255,255,255) draw_Text(20, 0, plantingSite.." - Planting") draw_Color(255,255,255,255) draw_Text(20, 25, plantinfo) draw_Color(0,255,0,255) draw_FilledRect(1, 0+remove_from_Y, 15, screenY+remove_from_Y) draw_Color(0,0,0,100) draw_FilledRect(0, 0, 16, screenY) end end
if drawDefuse and entities_FindByClass("CPlantedC4")[1] ~= nil then local ToDefuse = entities_FindByClass("CPlantedC4")[1] DefuseTime = math_floor(ToDefuse:GetProp("m_flDefuseLength")) DefuseT = string_format("%.1fs", (plantedTime2 - g_curtime()) + DefuseTime) draw_SetFont(Vf30) draw_Color(255,255,255,255) draw_Text(20, 50, defusingName.." - ".. DefuseT)
if DefuseTime == 10 then local godownby3 = (screenY / DefuseTime) / get_abs_fps() draw_Color(0,0,255,255) draw_FilledRect(1, fill3, 15, screenY) draw_Color(0,0,0,100) draw_FilledRect(0, 0, 16, screenY) fill3 = fill3 + godownby3
elseif DefuseTime == 5 then local godownby2 = ((screenY/2) / DefuseTime) / get_abs_fps() draw_Color(0,0,255,255) draw_FilledRect(1, fill2, 15, screenY) draw_Color(0,0,0,100) draw_FilledRect(0, (screenY/2), 16, screenY) fill2 = fill2 + godownby2 end end end 

-------------------- Bomb Damage
function DrawDamage()
if not Bomb_Damage:GetValue() or entities_FindByClass("CPlantedC4")[1] == nil then return end local Bomb = entities_FindByClass("CPlantedC4")[1]
if Bomb:GetProp("m_bBombTicking") and Bomb:GetProp("m_bBombDefused") == 0 and g_curtime() < Bomb:GetProp("m_flC4Blow") then local Player = GetLocalPlayer() local HealthToTake = math_floor(DamagefromDomb(Bomb, Player))
if g_curtime() < Bomb:GetProp("m_flC4Blow") then
if HealthToTake >= Player:GetHealth() then draw_SetFont(Vf30) draw_Color(255,0,0,255) draw_Text(20, 25, "FATAL") 
elseif HealthToTake < Player:GetHealth() and HealthToTake > 0 then draw_SetFont(Vf30) draw_Color(255,255,255,255) draw_Text(20, 25, "-"..HealthToTake+1) end end end end
function DamagefromDomb(Bomb, Player)
if not Bomb_Damage:GetValue() then return end local ArmorValue = Player:GetProp("m_ArmorValue")
local C4Distance = math_sqrt((select(1,Bomb:GetAbsOrigin()) - select(1,Player:GetAbsOrigin())) ^ 2 + (select(2,Bomb:GetAbsOrigin()) - select(2,Player:GetAbsOrigin())) ^ 2 + (select(3,Bomb:GetAbsOrigin()) - select(3,Player:GetAbsOrigin())) ^ 2) local Gauss = (C4Distance - 75.68) / 789.2 local flDamage = 450.7 * math_exp(-Gauss * Gauss)
if ArmorValue > 0 then local flNew = flDamage * 0.5 local flArmor = (flDamage - flNew) * 0.5
if flArmor > ArmorValue then flArmor = ArmorValue * 2 flNew = flDamage - flArmor end flDamage = flNew end
return math_max(flDamage, 0) end 
cb_Register("Draw", drawProgress) cb_Register("Draw", "draws bomb damage", DrawDamage) cb_Register("FireGameEvent", bomb)

-------------------- Chat Spams
local c_spammedlast = g_realtime() + CC_Spam_spd:GetValue()/100
function custom_chat()
if CC_Spams:GetValue() == 0 then return
elseif CC_Spams:GetValue() == 1 and g_realtime() >= c_spammedlast then client_ChatSay(ChatSpam1:GetValue()) c_spammedlast = g_realtime() + CC_Spam_spd:GetValue()/100
elseif CC_Spams:GetValue() == 2 and g_realtime() >= c_spammedlast then client_ChatSay(ChatSpam2:GetValue()) c_spammedlast = g_realtime() + CC_Spam_spd:GetValue()/100
elseif CC_Spams:GetValue() == 3 and g_realtime() >= c_spammedlast then client_ChatSay("﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽\n") c_spammedlast = g_realtime() + CC_Spam_spd:GetValue()/100 end end
cb_Register("Draw", custom_chat)
 
-------------------- Aspect Ratio Changer
local function gcd(m, n) while m ~= 0 do m, n = math_fmod(n, m), m end return n end
local function set_aspect_ratio(aspect_ratio_multiplier) local screen_width, screen_height = draw_GetScreenSize() local aspectratio_value = (screen_width*aspect_ratio_multiplier)/screen_height if aspect_ratio_multiplier == 1 or not aspect_ratio_check:GetValue() then aspectratio_value = 0 end client_SetConVar( "r_aspectratio", tonumber(aspectratio_value), true) end
local function on_aspect_ratio_changed() local screen_width, screen_height = draw_GetScreenSize() for i=1, 200 do local i2=i*0.01    i2 = 2 - i2 local divisor = gcd(screen_width*i2, screen_height) if screen_width*i2/divisor < 100 or i2 == 1 then aspect_ratio_table[i] = screen_width*i2/divisor .. ":" .. screen_height/divisor  end  end local aspect_ratio = aspect_ratio_reference:GetValue()*0.01 aspect_ratio = 2 - aspect_ratio set_aspect_ratio(aspect_ratio) end
cb_Register("Draw", on_aspect_ratio_changed)

-------------------- Esp on Dead
function ESP_Always_OnDead() 
if not espdead:GetValue() or GetLocalPlayer() == nil then return end
if GetLocalPlayer():GetHealth() <= 0 then
    gui_SetValue("esp_enemy_box", 3)
    gui_SetValue("esp_enemy_weapon", 1)
    gui_SetValue("esp_enemy_health", 2) gui_SetValue("esp_enemy_glow", 2)
	gui_SetValue("esp_enemy_skeleton", true) gui_SetValue("esp_enemy_name", true)
else
    gui_SetValue("esp_enemy_box", 0) gui_SetValue("esp_enemy_weapon", 0) gui_SetValue("esp_enemy_health", 0) gui_SetValue("esp_enemy_glow", 0)
	gui_SetValue("esp_enemy_skeleton", false) gui_SetValue("esp_enemy_name", false) end end
cb_Register("Draw", ESP_Always_OnDead)

-------------------- Enemy & Team Tracers
function Tracers()
if not tracersEnemy:GetValue() and not tracersTeam:GetValue() then return end
if GetLocalPlayer() == nil then return end local sX, sY = draw_GetScreenSize() local lpTeamNum = GetLocalPlayer():GetTeamNumber() local players = entities_FindByClass("CCSPlayer") for i = 1, #players do local player = players[i] local pX, pY, pZ = client_WorldToScreen(player:GetAbsOrigin()) playerteam = player:GetTeamNumber()
if playerteam == lpTeamNum then r,g,b,z = 0,0,255,255 else r,g,b,a = 255,0,0,255 end 
if tracersEnemy:GetValue() then if player:GetTeamNumber() ~= lpTeamNum and player:IsAlive() and pX ~= nil and pY ~= nil then draw_Color(r,g,b,a) draw_Line(sX/2, sY, pX, pY) end end
if tracersTeam:GetValue() then if player:GetTeamNumber() == lpTeamNum and player:IsAlive() and pX ~= nil and pY ~= nil and player:GetIndex() ~= LocalPlayerIndex() then draw_Color(r,g,b,a) draw_Line(sX/2, sY, pX, pY) end end end end
cb_Register("Draw", Tracers)

-------------------- Enemy & Team & Other Distance
function Distance(builder)
playerteam = builder:GetEntity():GetTeamNumber()
if not enemy_distance:GetValue() and not team_distance:GetValue() and not other_distance:GetValue() then return end
local ent = builder:GetEntity() local ppX, ppY, ppZ = ent:GetAbsOrigin() local lX, lY, lZ = GetLocalPlayer():GetAbsOrigin() local dist = math_floor(distance3D(ppX, ppY, ppZ, lX, lY, lZ)* 0.0833)
if enemy_distance:GetValue() and ent:IsAlive() and ent:IsPlayer() and playerteam ~= GetLocalPlayer():GetTeamNumber() then builder:Color(255, 255, 255, 255) builder:AddTextBottom(dist.. "ft") end
if team_distance:GetValue() and ent:IsAlive() and ent:IsPlayer() and playerteam == GetLocalPlayer():GetTeamNumber() and ent:GetIndex() ~= LocalPlayerIndex() then builder:Color(255, 255, 255, 255) builder:AddTextBottom(dist.. "ft") end
if other_distance:GetValue() and not ent:IsPlayer() then builder:Color(255, 255, 255, 255) builder:AddTextBottom(dist.. "ft") end end
cb_Register("DrawESP", "Distance ESP", Distance)

-------------------- Knife on Left Hand
function on_knife_righthand()
if not K_O_L_H:GetValue() then return end if GetLocalPlayer() == nil or GetLocalPlayer():GetHealth() <= 0 then client_exec("cl_righthand 1", true) return end
local wep = GetLocalPlayer():GetPropEntity("m_hActiveWeapon") if wep == nil then return end local cwep = wep:GetClass()
if cwep == "CKnife" then client_exec("cl_righthand 0", true) else client_exec("cl_righthand 1", true) end end
cb_Register("Draw", on_knife_righthand) 

-------------------- Zeusbot
function zeuslegit()
if not zeusbot:GetValue() or GetLocalPlayer() == nil then return end local Weapon = GetLocalPlayer():GetPropEntity("m_hActiveWeapon") if Weapon == nil then return end local CWeapon = Weapon:GetClass() 
local trige, trigm, trigaf, trighc = gui_GetValue("lbot_trg_enable"), gui_GetValue("lbot_trg_mode"), gui_GetValue("lbot_trg_autofire"), gui_GetValue("lbot_trg_hitchance")
if trige ~= 1 and trigm ~= 0 and trigaf ~= 1 and trighc ~= gui_GetValue("rbot_taser_hitchance") then trige2, trigm2, trigaf2, trighc2 = gui_GetValue("lbot_trg_enable"), gui_GetValue("lbot_trg_mode"), gui_GetValue("lbot_trg_autofire"), gui_GetValue("lbot_trg_hitchance") end
if CWeapon == "CWeaponTaser" then gui_SetValue("lbot_trg_enable", 1) gui_SetValue("lbot_trg_mode", 0) gui_SetValue("lbot_trg_autofire", 1) gui_SetValue("lbot_trg_hitchance", gui_GetValue("rbot_taser_hitchance"))
else gui_SetValue("lbot_trg_enable", trige2) gui_SetValue("lbot_trg_mode", trigm2) gui_SetValue("lbot_trg_autofire", trigaf2) gui_SetValue("lbot_trg_hitchance", trighc2) end end
cb_Register("Draw", zeuslegit)

-------------------- Spectator list
function SpecList()
if not SpectatorList:GetValue() or GetLocalPlayer() == nil then return end local specX, specY = draw_GetScreenSize() local inbetween = 5 local players = entities_FindByClass("CCSPlayer") for i = 1, #players do local player = players[i] local playername = player:GetName() local playerindex = player:GetIndex() local bot = GetPlayerResources():GetPropInt("m_iPing", playerindex) == 0
if player:GetHealth() <= 0 and not bot and player:GetPropEntity("m_hObserverTarget") ~= nil and playername ~= "GOTV" and playername ~= GetLocalPlayer():GetName() then 
local SpecTargetIndex = player:GetPropEntity("m_hObserverTarget"):GetIndex() 
if GetLocalPlayer():GetHealth() > 0 then if SpecTargetIndex == LocalPlayerIndex() then draw_SetFont(Vf12) local tW, tH = draw_GetTextSize(playername) draw_Color(255,255,255,255) draw_TextShadow( specX - 5 - tW, inbetween, playername) inbetween = inbetween + tH + 5 end
elseif GetLocalPlayer():GetHealth() <= 0 then if GetLocalPlayer():GetPropEntity("m_hObserverTarget") ~= nil then local imSpeccing = GetLocalPlayer():GetPropEntity("m_hObserverTarget"):GetIndex() 
if SpecTargetIndex == imSpeccing then draw_SetFont(Vf12) local tW, tH = draw_GetTextSize(playername) draw_Color(255,255,255,255) draw_TextShadow(specX - 5 - tW, inbetween, playername) inbetween = inbetween + tH + 5 end end end end end end
cb_Register("Draw", SpecList)

-------------------- Recoil Crosshair
function RCC()
if not RecoilCrosshair:GetValue() or GetLocalPlayer() == nil or GetLocalPlayer():GetHealth() <= 0 then return end local screenX, screenY = draw_GetScreenSize() local x = screenX/2 local y = screenY/2
local r, g, b, a = gui_GetValue("clr_esp_crosshair_recoil") local recoil_scale = client_GetConVar("weapon_recoil_scale") local fov = gui_GetValue("vis_view_fov") if fov == 0 then fov = 90 end local weapon = GetLocalPlayer():GetPropEntity("m_hActiveWeapon") local weapon_name = weapon:GetClass() 
if weapon_name == "CWeaponAWP" or weapon_name == "CWeaponSSG08" or weapon:GetProp("m_flRecoilIndex") == 0 or gui_GetValue("rbot_active") and gui_GetValue("rbot_antirecoil") then return end local aim_punch_angle_pitch, aim_punch_angle_yaw = GetLocalPlayer():GetPropVector("localdata", "m_Local", "m_aimPunchAngle") 
if -aim_punch_angle_pitch >= 0.07 and -aim_punch_angle_pitch >= 0.07 then if gui_GetValue("vis_norecoil") then x = x - (((screenX/fov)* aim_punch_angle_yaw)*1.2)*(recoil_scale*0.5) y = y + (((screenY/fov)* aim_punch_angle_pitch)*2)*(recoil_scale*0.5) else x = x - (((screenX/fov)* aim_punch_angle_yaw)*0.6)*(recoil_scale*0.5) y = y + ((screenY/fov)* aim_punch_angle_pitch)*(recoil_scale*0.5) end 
draw_Color(r, g, b, a) draw_RoundedRect(x-3, y-3, x+3, y+3) end end
cb_Register("Draw", RCC)

-------------------- Name Steal fix
function infiniteNameSpam()
if gui_GetValue("msc_namestealer_enable") ~= 0 then namesteal = gui_GetValue("msc_namestealer_enable") end
if infname:GetValue() then client.SetConVar("name", "\n\xAD\xAD\xAD", false) infname:SetValue(0) end end cb_Register("Draw", infiniteNameSpam)
function NameStealFix(e)
if GetLocalPlayer() == nil or GetLocalPlayer():GetTeamNumber() == 1 then return end
if e:GetName() == "round_end" then gui_SetValue("msc_namestealer_enable", 0) end
if e:GetName() == "round_start" then gui_SetValue("msc_namestealer_enable", namesteal) end end cb_Register("FireGameEvent", NameStealFix)

-------------------- Show Team Damage
local damagedone, killed = 0, 0
function KillsAndDamage(e)
if e:GetName() == "player_hurt" then if PlayerIndexByUserID(e:GetInt("attacker")) == LocalPlayerIndex() and PlayerIndexByUserID(e:GetInt("userid")) ~= LocalPlayerIndex() and playerteam == GetLocalPlayer():GetTeamNumber() then damagedone = damagedone + e:GetInt("dmg_health") end end
if e:GetName() == "player_death" then if PlayerIndexByUserID(e:GetInt("attacker")) == LocalPlayerIndex() and PlayerIndexByUserID(e:GetInt("userid")) ~= LocalPlayerIndex() and playerteam == GetLocalPlayer():GetTeamNumber() then killed = killed + 1 end end
if e:GetName() == "player_connect_full" then damagedone, killed = 0, 0 end end
function DrawsTKsDMG() if not TeamDamageShow:GetValue() or GetLocalPlayer() == nil then return end local X, Y = draw_GetScreenSize() draw_Color(255,255,255,255) draw_SetFont(Tf) draw_TextShadow(10, Y/2-40, "Damage Done: ".. damagedone) draw_TextShadow(10, Y/2-30, "Teammates Killed: ".. killed) end 
cb_Register("FireGameEvent", KillsAndDamage) cb_Register("Draw", DrawsTKsDMG)

c_AllowListener("round_end") c_AllowListener("round_start") c_AllowListener("bomb_beginplant") c_AllowListener("bomb_abortplant") c_AllowListener("bomb_planted") c_AllowListener("bomb_defused") c_AllowListener("bomb_begindefuse") c_AllowListener("bomb_abortdefuse") c_AllowListener("round_officially_ended") c_AllowListener("player_spawn") c_AllowListener("player_hurt") c_AllowListener("player_death") c_AllowListener("player_connect_full") c_AllowListener("inferno_expire") c_AllowListener("inferno_extinguish") c_AllowListener("molotov_detonate") c_AllowListener("hegrenade_detonate") c_AllowListener("flashbang_detonate") 