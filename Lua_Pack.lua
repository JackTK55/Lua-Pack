--[[
recode recoil crosshair: find unknowncheats link

recode zeus bot: 

idk what else	
	--]]

-- stuff
local draw_Line, draw_TextShadow, draw_Color, draw_Text, g_tickinterval, string_format, http_Get, string_gsub, file_Open, math_random, math_exp, math_rad, math_max, math_abs, math_tan, math_sin, math_cos, math_fmod, draw_GetTextSize, draw_FilledRect, draw_RoundedRect, draw_RoundedRectFill, draw_CreateFont, draw_SetFont, client_WorldToScreen, draw_GetScreenSize, client_GetConVar, client_SetConVar, client_exec, PlayerNameByUserID, PlayerIndexByUserID, entities_GetByIndex, GetLocalPlayer, gui_SetValue, gui_GetValue, LocalPlayerIndex, c_AllowListener, cb_Register, g_tickcount, g_realtime, g_curtime, g_absoluteframetime, g_maxclients, math_floor, math_ceil, math_sqrt, GetPlayerResources, entities_FindByClass, IsButtonPressed, client_ChatSay, table_insert, table_remove, vector_Distance, draw_OutlinedCircle, table_concat = draw.Line, draw.TextShadow, draw.Color, draw.Text, globals.TickInterval, string.format, http.Get, string.gsub, file.Open, math.random, math.exp, math.rad, math.max, math.abs, math.tan, math.sin, math.cos, math.fmod, draw.GetTextSize, draw.FilledRect, draw.RoundedRect, draw.RoundedRectFill, draw.CreateFont, draw.SetFont, client.WorldToScreen, draw.GetScreenSize, client.GetConVar, client.SetConVar, client.Command, client.GetPlayerNameByUserID, client.GetPlayerIndexByUserID, entities.GetByIndex, entities.GetLocalPlayer, gui.SetValue, gui.GetValue, client.GetLocalPlayerIndex, client.AllowListener, callbacks.Register, globals.TickCount, globals.RealTime, globals.CurTime, globals.AbsoluteFrameTime, globals.MaxClients, math.floor, math.ceil, math.sqrt, entities.GetPlayerResources, entities.FindByClass, input.IsButtonPressed, client.ChatSay, table.insert, table.remove, vector.Distance, draw.OutlinedCircle, table.concat
-------------- References
local G_VM = gui.Groupbox(gui.Reference("VISUALS", "Shared"), "Extra Features")
local VOO_Ref = gui.Reference("VISUALS", "OTHER", "Options")
local VEO_Ref = gui.Reference("VISUALS", "ENEMIES", "Options")
local VTO_Ref = gui.Reference("VISUALS", "TEAMMATES", "Options")
local G_M1 = gui.Groupbox(gui.Reference("MISC", "GENERAL", "Main"), "Extra Features")
-------------- Font
local Vf30 = draw_CreateFont("Verdana", 30) 
local Vf12 = draw_CreateFont("Verdana", 12) 
local Vf11 = draw_CreateFont("Verdana", 11)
local Tf13 = draw_CreateFont("Tahoma", 13, 200)
-------------- Better Grenades
local better_grenades = gui.Checkbox(VOO_Ref, "esp_other_better_grenades", "Better Grenades", false)
-------------- Hit Log 
local HitLog = gui.Checkbox(G_M1, "msc_hitlog", "Hit Log", false)
-------------- Auto Buy
local AB_Show = gui.Checkbox(G_M1, "msc_autobuy", "AutoBuy", false)
local AB_W = gui.Window("AB_W", "Auto Buy", 100, 200, 200, 306)
local AB_GB = gui.Groupbox(AB_W, "Auto Buy Settings", 16, 17)
local AB_E = gui.Checkbox(AB_GB, "AB_Active", "Active", false)
local PrimaryWeapons = gui.Combobox(AB_GB, "AB_Primary_Weapons", "Primary Weapons", "-", "AK | M4", "Scout", "SG553 | AUG", "AWP", "Auto")
local SecondaryWeapons = gui.Combobox(AB_GB, "AB_Secondary_Weapons", "Secondary Weapons", "-", "Elite", "P250", "Tec-9 | Five-Seven", "R8 | Deagle")
local AB_M = gui.Multibox(AB_GB, 'Gear')
local Kev = gui.Checkbox(AB_M, "AB_Armor_K", "Kevlar", false)
local Kev_Hel = gui.Checkbox(AB_M, "AB_Armor_KH", "Helmet", false)
local Defuser = gui.Checkbox(AB_M, "AB_Defuser", "Defuse Kit", false)
local GNade = gui.Checkbox(AB_M, "AB_GNade", "Grenade", false)
local MNade = gui.Checkbox(AB_M, "AB_MNade", "Molotov", false)
local SNade = gui.Checkbox(AB_M, "AB_SNade", "Smoke", false)
local FNade = gui.Checkbox(AB_M, "AB_FNade", "Flashbang", false)
local Zeus = gui.Checkbox(AB_M, "AB_Zeus", "Zeus", false)
local AB_buyAbove = gui.Slider(AB_GB, 'AB_buyAboveAmount', 'Buy if $ is Above (value*1000)', 3.7, 0, 16)
-------------- Spec List
local SpectatorList = gui.Checkbox(G_M1, "msc_speclist", "Spectators", false)
-------------- Show Team Damage
local TeamDamageShow = gui.Checkbox(G_M1, "msc_showteamdmg", "Show Team Damage", false)
-------------- View Model Extender
local function VM_Cache() xO = client_GetConVar("viewmodel_offset_x") yO = client_GetConVar("viewmodel_offset_y") zO = client_GetConVar("viewmodel_offset_z") fO = client_GetConVar("viewmodel_fov") end VM_Cache()
local ViewModelShown = gui.Checkbox(G_M1, "msc_vme", "Viewmodel Changer", false)
local VM_W = gui.Window("VM_W", "Viewmodel Extender", 305,200,200,300)
local VMStuff = gui.Groupbox(VM_W, "Viewmodel Stuff", 15, 14, 170, 240)
local VM_e = gui.Checkbox(VMStuff, "msc_vme", "Enable", false)
local xS = gui.Slider(VMStuff, "VM_X", "X", xO, -20, 20)
local yS = gui.Slider(VMStuff, "VM_Y", "Y", yO, -100, 100)
local zS = gui.Slider(VMStuff, "VM_Z", "Z", zO, -20, 20)
local vfov = gui.Slider(VMStuff, "VM_fov", "Viewmodel FOV", fO, 0, 120)
-------------- Sniper Crosshair
local ComboCrosshair = gui.Combobox(G_VM, "vis_sniper_crosshair", "Sniper Crosshair", "Off", "Engine Crosshair", 'Engine Crosshair(+scoped)', "Aimware Crosshair", "Draw Crosshair")
-------------- Bullet impacts
local BulletImpacts_M = gui.Multibox(gui.Reference('VISUALS', 'MISC', 'Assistance'), 'Bullet Impact')
local BulletImpacts_Local = gui.Checkbox(BulletImpacts_M, "vis_bullet_impact_local", "Local", false)
local BulletImpacts_Enemy = gui.Checkbox(BulletImpacts_M, "vis_bullet_impact_enemy", "Enemy", false)
local BulletImpacts_Team = gui.Checkbox(BulletImpacts_M, "vis_bullet_impact_team", "Team", false)
local BulletImpacts_color_Local = gui.ColorEntry('clr_vis_bullet_impact_local', 'Bullet Impacts Local', 255,255,255,255)
local BulletImpacts_color_Enemy = gui.ColorEntry('clr_vis_bullet_impact_enemy', 'Bullet Impacts Enemy', 255,140,140,255)
local BulletImpacts_color_Team = gui.ColorEntry('clr_vis_bullet_impact_team', 'Bullet Impacts Team', 140,140,255,255)
local BulletImpacts_Time = gui.Slider(gui.Reference('VISUALS', 'MISC', 'Assistance'), 'vis_bullet_impact_time', 'Bullet Impact Time', 4, 0, 10)
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
local CC_W = gui.Window("CC_W", "Chat Spam", 510,200,200,285)
local CC_G1 = gui.Groupbox(CC_W, "Chat Spams", 15, 15, 170, 224)
local CC_Spams = gui.Combobox(CC_G1, "CC_Spam", "Spams", "Off", "Spam 1", "Spam 2", "Clear Chat")
local CC_Spam_spd = gui.Slider(CC_G1, "CC_Spam_Speed", "Spam Speed", 67.5, 10, 250)
local chatspam1txt = gui.Text(CC_G1, "Spam 1") local ChatSpam1 = gui.Editbox(CC_G1, "CC_Spam1", "Custom Chat Spam 1")
local chatspam2txt = gui.Text(CC_G1, "Spam 2") local ChatSpam2 = gui.Editbox(CC_G1, "CC_Spam2", "Custom Chat Spam 2")
-------------- Working Stattrak
local Working_Stattrak = gui.Checkbox(G_M1, "msc_stattrakcount", "Working Stattrak", false)
-------------- Aspect Ratio Changer
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
local RecoilCrosshair_color = gui.ColorEntry("clr_vis_recoilcrosshair", "Recoil Crosshair", 255,255,255,255)
-------------- Disable Fake angle ghost while in air/freezetime
local fakeangleghost = gui.Combobox(gui.Reference("VISUALS", "MISC", "Yourself Extra"), "vis_disable_fakeangleghost", "Disable Fake Angle Ghost", "Off", "In Air", "On Freeze Period", "Both")
-------------- Name Steal fix
local StealNameFix = gui.Checkbox(gui.Reference("MISC", "ENHANCEMENT", "Namestealer"), "msc_namestealer_fix", "Fix Name Steal", false)
-------------- Ghost Mode
local ghost_view = gui.Checkbox(gui.Reference("VISUALS", "MISC", "Yourself Extra"), 'vis_ghost', 'Ghost View', false)
-------------- Fake ducking indicator
local fake_duck_indicator = gui.Checkbox(VEO_Ref, 'esp_enemy_fakeduck', 'Is Fakeducking', false)
local fake_duck_indicator_color = gui.ColorEntry('clr_esp_enemy_fakeduck', 'Fake duck', 100, 200, 100, 255)
-------------- Disable Fog
local disable_fog = gui.Checkbox(gui.Reference('VISUALS', 'MISC', 'World'), 'vis_nofog', 'No Fog', false)
-------------- Disable Shadows
local disable_shadows = gui.Checkbox(gui.Reference('VISUALS', 'MISC', 'World'), 'vis_noshadows', 'No Shadows', false)
-------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------
local frame_rate = 0.0
local function get_abs_fps() frame_rate = 0.9 * frame_rate + (1.0 - 0.9) * g_absoluteframetime() return math_floor((1.0 / frame_rate) + 0.5) end
local function lerp_pos(x1, y1, z1, x2, y2, z2, percentage) local x = (x2 - x1) * percentage + x1 local y = (y2 - y1) * percentage + y1 local z = (z2 - z1) * percentage + z1 return x, y, z end
local function distance3D(a, b) distance = vector_Distance(a, b) return {['normal']=distance, ['u']=string_format('%.0fu', distance), ['ft']=string_format('%.0fft', distance*0.083333), ['m']=string_format('%.1fm', distance/39.370)} end
cb_Register("Draw", "Shows Menus", function() local menu_opened = gui.Reference("MENU"):IsActive() if AB_Show:GetValue() then AB_W:SetActive(menu_opened) else AB_W:SetActive(0) end if ViewModelShown:GetValue() then VM_W:SetActive(menu_opened) else VM_W:SetActive(0) end if CC_Show:GetValue() then CC_W:SetActive(menu_opened) else CC_W:SetActive(0) end end)
local function is_enemy(index) if entities_GetByIndex(index) == nil then return end return entities_GetByIndex(index):GetTeamNumber() ~= GetLocalPlayer():GetTeamNumber() end

-------------------- Auto Updater
local scriptName = GetScriptName()
local scriptFile = "https://raw.githubusercontent.com/Zack2kl/Lua-Pack/master/Lua_Pack.lua"
local versionFile = "https://raw.githubusercontent.com/Zack2kl/Lua-Pack/master/version.txt"
local currentVersion = "1.4.5.3"
local updateAvailable, newVersionCheck, updateDownloaded = false, true, false

function autoupdater()
if not gui_GetValue("lua_allow_http") then return end
if newVersionCheck then local newVersion = http_Get(versionFile) if currentVersion ~= newVersion then updateAvailable = true end newVersionCheck = false end 
if updateAvailable and not updateDownloaded then if not gui_GetValue("lua_allow_cfg") then draw_Color(255, 255, 255, 255) draw_Text(2, 0, string_gsub(scriptName, ".lua", "")..": Update Available, Script/Config editing is Required") else local newScript = http_Get(scriptFile) local oldScript = file_Open(scriptName, "w") oldScript:Write(newScript) oldScript:Close() updateAvailable = false updateDownloaded = true print(string_gsub(scriptName, ".lua", " updated from"), currentVersion, "to", http_Get(versionFile)) end end
if updateDownloaded then draw_Color(255, 255, 255, 255) draw_Text(2, 0, string_gsub(scriptName, ".lua", "")..": Update Downloaded, reload the script") end end
cb_Register("Draw", "Auto Update", autoupdater)

-------------------- Grenade Timers
local smokes, molotovs, flashes, grenades = {}, {}, {}, {}
function Timers(e)
if not better_grenades:GetValue() or e:GetName() ~= "round_prestart" and e:GetName() ~= "smokegrenade_detonate" and e:GetName() ~= "molotov_detonate" and e:GetName() ~= "inferno_startburn" and e:GetName() ~= "inferno_expire" and e:GetName() ~= "inferno_extinguish" and e:GetName() ~= "grenade_thrown" then return end local entityid = e:GetInt("entityid") local x = e:GetFloat("x") local y = e:GetFloat("y") local z = e:GetFloat("z") local userid_to_index = PlayerIndexByUserID(e:GetInt("userid"))
if e:GetName() == "round_prestart" then smokes, molotovs = {}, {} end
if e:GetName() == "smokegrenade_detonate" then table_insert(smokes, {g_curtime(), entityid, x, y, z}) end
if e:GetName() == "molotov_detonate" then user_index = userid_to_index end if e:GetName() == "inferno_startburn" then table_insert(molotovs, {g_curtime(), entityid, x, y, z, user_index}) end
if e:GetName() == "inferno_expire" or e:GetName() == "inferno_extinguish" then for k, v in pairs(molotovs) do if v[2] == entityid then table_remove(molotovs, k) end end end
if e:GetName() == "grenade_thrown" then randnumber = math_random(1, client_GetConVar("ammo_grenade_limit_total")*g_maxclients()) if e:GetString("weapon") == "flashbang" then table_insert(flashes, {g_curtime(), randnumber * 1.77}) end if e:GetString("weapon") == "hegrenade" then table_insert(grenades, {g_curtime(), randnumber * 2.10}) end end end
function DrawTimers()
if not better_grenades:GetValue() or GetLocalPlayer() == nil then return end 
for k, v in pairs(smokes) do if v[1] - g_curtime() + 17.6 > 0 then local X, Y = client_WorldToScreen(v[3], v[4], v[5]) local smoke_timeleft = string_format("%0.1f", v[1] - g_curtime() + 17.6) if X ~= nil and Y ~= nil then draw_SetFont(Vf11) local tW, tH = draw_GetTextSize(smoke_timeleft) local tW2, tH2 = draw_GetTextSize("SMOKE") draw_Color(255, 255, 255, 255) draw_TextShadow(X - (tW/2), Y - (tH/2), smoke_timeleft) draw_Color(255, 255, 255, 255) draw_TextShadow(X - (tW2/2), Y - (tH2/2) + tH2, "SMOKE") end else table_remove(smokes, k) end end 
for k, v in pairs(molotovs) do if v[1] - g_curtime() + 7 > 0 then local X, Y = client_WorldToScreen(v[3], v[4], v[5]) local molotov_timeleft = string_format("%0.1f", v[1] - g_curtime() + 7) if X ~= nil and Y ~= nil then draw_SetFont(Vf11) local tW, tH = draw_GetTextSize(molotov_timeleft) local tW2, tH2 = draw_GetTextSize("MOLLY") draw_Color(255, 255, 255, 255) draw_TextShadow(X - (tW/2), Y - (tH/2), molotov_timeleft) if not is_enemy(v[6]) then r, g, b, a = 153, 153, 255, 255 else r, g, b, a = 251, 82, 79, 255 end draw_Color(r, g, b, a) draw_TextShadow(X - (tW2/2), Y - (tH2/2) + tH2, "MOLLY") end else table_remove(molotovs, k) end end end
function GFTimers(b)
if not better_grenades:GetValue() or b:GetEntity():GetClass() ~= "CBaseCSGrenadeProjectile" then return end
for k, v in pairs(flashes) do if v[1] - g_curtime() + 1.65 > 0 then if v[2] == randnumber * 1.77 then b:AddBarBottom(v[1] - g_curtime() + 1.65) end else table_remove(flashes, k) end end 
for k, v in pairs(grenades) do if v[1] - g_curtime() + 1.65 > 0 then if v[2] == randnumber * 2.10 then b:AddBarBottom(v[1] - g_curtime() + 1.65) end else table_remove(grenades, k) end end end
cb_Register("Draw", DrawTimers) cb_Register("DrawESP", GFTimers) cb_Register("FireGameEvent", Timers)

-------------------- Auto Buy
local primary_weapon, secondary_weapon = {'', 'buy "ak47"; ', 'buy "ssg08"; ', 'buy "sg556"; ', 'buy "awp"; ', 'buy "scar20"; '}, {'', 'buy "elite"; ', 'buy "p250"; ', 'buy "tec9"; ', 'buy "deagle"; '}
function auto_buy(e)
if not AB_E:GetValue() or e:GetName() == nil or e:GetName() ~= 'player_spawn' or GetLocalPlayer() == nil then return end if PlayerIndexByUserID(e:GetInt("userid")) ~= LocalPlayerIndex() then return end local money = GetLocalPlayer():GetProp('m_iAccount')
local buy_items = table_concat({primary_weapon[PrimaryWeapons:GetValue() + 1] or '', secondary_weapon[SecondaryWeapons:GetValue() + 1] or '', Kev:GetValue() and 'buy "vest"; ' or '', Kev_Hel:GetValue() and 'buy "vesthelm"; ' or '', Defuser:GetValue() and 'buy "defuser"; ' or '', GNade:GetValue() and 'buy "hegrenade"; ' or '', MNade:GetValue() and 'buy "molotov"; buy "incgrenade"; ' or '', SNade:GetValue() and 'buy "smokegrenade"; ' or '', FNade:GetValue() and 'buy "flashbang"; ' or '', Zeus:GetValue() and 'buy "taser"; ' or ''}, '')
if money >= AB_buyAbove:GetValue()*1000 or money < 1 then client_exec(buy_items, true) end end
cb_Register("FireGameEvent", auto_buy)

-------------------- View Model Extender | Spectator list fix / made by anue | Disable Post Processing | full bright | Engine Radar | Disable Fake angle ghost while in air/freeze time | Working Stattrak | ghost view | fake duck indicator | disable fog | disable shadows
function VM_E() if VM_e:GetValue() then client_SetConVar("viewmodel_offset_x", xS:GetValue(), true) client_SetConVar("viewmodel_offset_y", yS:GetValue(), true) client_SetConVar("viewmodel_offset_z", zS:GetValue(), true) client_SetConVar("viewmodel_fov", vfov:GetValue(), true) else client_SetConVar("viewmodel_offset_x", xO, true) client_SetConVar("viewmodel_offset_y", yO, true) client_SetConVar("viewmodel_offset_z", zO, true) client_SetConVar("viewmodel_fov", fO, true) end end cb_Register("Draw", VM_E)
function speclistfix(E) if not gui_GetValue("msc_showspec") or E:GetName() ~= "round_prestart" then return end client_exec("cl_fullupdate", true) end cb_Register("FireGameEvent", speclistfix)
function Dis_PP() client_SetConVar("mat_postprocess_enable", DPP:GetValue() and 0 or 1, true) end cb_Register("Draw", Dis_PP)
function full_bright() client_SetConVar("mat_fullbright", fBright:GetValue() and 1 or 0, true) end cb_Register("Draw", full_bright)
function engineradar() if ERadar:GetValue() then ER_val = 1 else ER_val = 0 end for i, player in pairs(entities_FindByClass("CCSPlayer")) do player:SetProp("m_bSpotted", ER_val) end end cb_Register("Draw", engineradar)
function fakeangleghostval() if fakeangleghost:GetValue() == 0 then fakeghost = "Off" elseif fakeangleghost:GetValue() == 1 then fakeghost = "in_air" elseif fakeangleghost:GetValue() == 2 then fakeghost = "in_freeze" elseif fakeangleghost:GetValue() == 3 then fakeghost = "in_freeze_and_air" end end cb_Register("Draw", fakeangleghostval) local FakeAAGhost2_round_end = false
function Disable_FakeAAGhost(UserCMD) if gui_GetValue("vis_fakeghost") ~= 0 then fakeghostval = gui_GetValue("vis_fakeghost") end if fakeghost == "in_freeze" or fakeghost == "Off" then return end if GetLocalPlayer():GetProp("m_fFlags") == 256 then gui_SetValue("vis_fakeghost", 0) else if not FakeAAGhost2_round_end then gui_SetValue("vis_fakeghost", fakeghostval) end end end cb_Register("CreateMove", Disable_FakeAAGhost)
function Disable_FakeAAGhost2(e) if fakeghost == "in_air" or fakeghost == "Off" then return end if e:GetName() == "round_end" then gui_SetValue("vis_fakeghost", 0) FakeAAGhost2_round_end = true end if e:GetName() == "round_freeze_end" then gui_SetValue("vis_fakeghost", fakeghostval) FakeAAGhost2_round_end = false end end cb_Register("FireGameEvent", Disable_FakeAAGhost2)
function StatTrak(e) if not Working_Stattrak:GetValue() or not gui_GetValue("skin_active") then return end if e:GetName() == "player_death" and PlayerIndexByUserID(e:GetInt("attacker")) == LocalPlayerIndex() and PlayerIndexByUserID(e:GetInt("userid")) ~= LocalPlayerIndex() and is_enemy(PlayerIndexByUserID(e:GetInt("userid"))) then if e:GetString("weapon") ~= "inferno" and e:GetString("weapon") ~= "hegrenade" and e:GetString("weapon") ~= "smokegrenade" and e:GetString("weapon") ~= "flashbang" and e:GetString("weapon") ~= "decoy" and e:GetString("weapon") ~= "knife" and e:GetString("weapon") ~= "knife_t" then wep = string_format("skin_%s_stattrak", e:GetString("weapon")) if tonumber(gui_GetValue(wep)) > 0 then gui_SetValue(wep, math_floor(gui_GetValue(wep)) + 1) end end end if e:GetName() == "round_prestart" then client_exec("cl_fullupdate", true) end end cb_Register("FireGameEvent", StatTrak)
function ghostview() if GetLocalPlayer() == nil then return end if ghost_view:GetValue() then ghost = 1 else ghost = 0 end if GetLocalPlayer():GetProp('m_bIsPlayerGhost') ~= ghost then GetLocalPlayer():SetProp('m_bIsPlayerGhost', ghost) end end cb_Register("Draw", 'ghost view', ghostview)
local function toBits(num) local t = {} while num > 0 do rest = math_fmod(num,2) t[#t+1] = rest num = (num-rest) / 2 end return t end
function fakeduck(b) if not fake_duck_indicator:GetValue() or b:GetEntity() == nil or not b:GetEntity():IsPlayer() or not b:GetEntity():IsAlive() then return end local entity, index, storedTick, crouchedTicks = b:GetEntity(), b:GetEntity():GetIndex(), 0, {} local duckamount = entity:GetProp('m_flDuckAmount') local duckspeed = entity:GetProp('m_flDuckSpeed') if crouchedTicks[index] == nil then crouchedTicks[index] = 0 end if duckspeed == 8 and duckamount <= 0.9 and duckamount > 0.01 and toBits(entity:GetProp('m_fFlags'))[1] == 1 then if storedTick ~= g_tickcount() then crouchedTicks[index] = crouchedTicks[index] + 1 storedTick = g_tickcount() end if crouchedTicks[index] >= 5 then b:Color(fake_duck_indicator_color:GetValue()) b:AddTextBottom('FD') end else crouchedTicks[index] = 0 end end cb_Register('DrawESP', fakeduck)
function dis_fog() local disableFog = disable_fog:GetValue() and 0 or 1 for i, fog in pairs(entities_FindByClass('CFogController')) do if fog:GetProp('m_fog.enable') ~= disableFog then fog:SetProp('m_fog.enable', disableFog) end end end  cb_Register('Draw', dis_fog)
function dis_shadows() if disable_shadows:GetValue() then if client_GetConVar('cl_csm_static_prop_shadows') ~= 0 or client_GetConVar('cl_csm_shadows') ~= 0 or client_GetConVar('cl_csm_world_shadows') ~= 0 or client_GetConVar('cl_foot_contact_shadows') ~= 0 or client_GetConVar('cl_csm_viewmodel_shadows') ~= 0 or client_GetConVar('cl_csm_rope_shadows') ~= 0 or client_GetConVar('cl_csm_sprite_shadows') ~= 0 then client_SetConVar('cl_csm_static_prop_shadows', 0, true) client_SetConVar('cl_csm_shadows', 0, true) client_SetConVar('cl_csm_world_shadows', 0, true) client_SetConVar('cl_foot_contact_shadows', 0, true) client_SetConVar('cl_csm_viewmodel_shadows', 0, true) client_SetConVar('cl_csm_rope_shadows', 0, true) client_SetConVar('cl_csm_sprite_shadows', 0, true) end else if client_GetConVar('cl_csm_static_prop_shadows') ~= 1 or client_GetConVar('cl_csm_shadows') ~= 1 or client_GetConVar('cl_csm_world_shadows') ~= 1 or client_GetConVar('cl_foot_contact_shadows') ~= 1 or client_GetConVar('cl_csm_viewmodel_shadows') ~= 1 or client_GetConVar('cl_csm_rope_shadows') ~= 1 or client_GetConVar('cl_csm_sprite_shadows') ~= 1 then client_SetConVar('cl_csm_static_prop_shadows', 1, true) client_SetConVar('cl_csm_shadows', 1, true) client_SetConVar('cl_csm_world_shadows', 1, true) client_SetConVar('cl_foot_contact_shadows', 1, true) client_SetConVar('cl_csm_viewmodel_shadows', 1, true) client_SetConVar('cl_csm_rope_shadows', 1, true) client_SetConVar('cl_csm_sprite_shadows', 1, true) end end end cb_Register('Draw', dis_shadows)

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
if GetLocalPlayer() == nil then return end local Weapon = GetLocalPlayer():GetPropEntity("m_hActiveWeapon") local Scoped = GetLocalPlayer():GetProp("m_bIsScoped") == 1 or GetLocalPlayer():GetProp("m_bIsScoped") == 257 if Weapon == nil then return end local cWep = Weapon:GetClass()
if cWep == "CWeaponAWP" or cWep == "CWeaponSSG08" or cWep == "CWeaponSCAR20" or cWep == "CWeaponG3SG1" then drawCrosshair = true else drawCrosshair = false end local screenCenterX, screenY = draw_GetScreenSize() local scX, scY = screenCenterX / 2, screenY / 2
if drawCrosshair and ComboCrosshair:GetValue() == 0 then return
elseif drawCrosshair and ComboCrosshair:GetValue() == 1 then gui_SetValue("esp_crosshair", false) if Scoped then client_SetConVar("weapon_debug_spread_show", 0, true) else client_SetConVar("weapon_debug_spread_show", 3, true) end
elseif drawCrosshair and ComboCrosshair:GetValue() == 2 then gui_SetValue("esp_crosshair", false) client_SetConVar("weapon_debug_spread_show", 3, true)
elseif drawCrosshair and ComboCrosshair:GetValue() == 3 then if Scoped then gui_SetValue("esp_crosshair", false) else client_SetConVar("weapon_debug_spread_show", 0, true) gui_SetValue("esp_crosshair", true) end 
elseif not drawCrosshair and ComboCrosshair:GetValue() == 3 then gui_SetValue("esp_crosshair", false)
elseif drawCrosshair and ComboCrosshair:GetValue() == 4 then client_SetConVar("weapon_debug_spread_show", 0, true) gui_SetValue("esp_crosshair", false) draw_Color(255,255,255,255) draw_Line(scX, scY - 8, scX, scY + 8) --[[ line down ]] draw_Line(scX - 8, scY, scX + 8, scY) --[[ line across ]] end end
cb_Register("Draw", ifCrosshair)

-------------------- HitLog
local hit_logs, hitgroup_names = {}, {"head", "chest", "stomach", "left arm", "right arm", "left leg", "right leg"}
function hitlog(e)
if not HitLog:GetValue() or e:GetName() ~= "player_hurt" then return end
if PlayerIndexByUserID(e:GetInt("userid")) ~= LocalPlayerIndex() and PlayerIndexByUserID(e:GetInt("attacker")) == LocalPlayerIndex() then
log = string_format("Hit %s in the %s for %s damage (%s health remaining)", PlayerNameByUserID(e:GetInt("userid")), hitgroup_names[e:GetInt("hitgroup")] or "body", e:GetString("dmg_health"), e:GetString("health"))
table_insert(hit_logs, {g_curtime(), log}) end end
local ScreenX, ScreenY = 8, 3
function draw_hitlog()
if not HitLog:GetValue() or hit_logs[1] == nil then return end local ScreenX,ScreenY = ScreenX,ScreenY
for k, v in pairs(hit_logs) do a = (v[1] - g_curtime() + 12) / 12 if 255*a > 67.5 then draw_SetFont(Tf13) tW, tH = draw_GetTextSize(v[2]) draw_Color(255, 255, 255, 255*a) draw_TextShadow(ScreenX, ScreenY, v[2]) ScreenY = ScreenY + tH else table_remove(hit_logs, k) end end end
cb_Register("Draw", draw_hitlog) cb_Register("FireGameEvent", hitlog)

-------------------- Bomb Timer & defuse timer & Bomb Damage
local function get_site_name(site) local a_x, a_y, a_z = GetPlayerResources():GetProp("m_bombsiteCenterA") local b_x, b_y, b_z = GetPlayerResources():GetProp("m_bombsiteCenterB") local site_x1, site_y1, site_z1 = site:GetMins() local site_x2, site_y2, site_z2 = site:GetMaxs() local site_x, site_y, site_z = lerp_pos(site_x1, site_y1, site_z1, site_x2, site_y2, site_z2, 0.5) local distance_a, distance_b = vector_Distance(site_x, site_y, site_z, a_x, a_y, a_z), vector_Distance(site_x, site_y, site_z, b_x, b_y, b_z) return distance_b > distance_a and "A" or "B" end
function bombEvents(e)
if not BombTimer:GetValue() or (e:GetName() ~= "bomb_beginplant" and e:GetName() ~= "bomb_abortplant" and e:GetName() ~= "bomb_planted" and e:GetName() ~= "bomb_begindefuse" and e:GetName() ~= "bomb_abortdefuse" and e:GetName() ~= "bomb_defused" and e:GetName() ~= 'bomb_exploded' and e:GetName() ~= "round_officially_ended" and e:GetName() ~= "round_prestart") then return end
if e:GetName() == "bomb_beginplant" then planter = PlayerNameByUserID(e:GetInt("userid")) plantPercent = 0 plantingStarted = g_curtime() plantingSite = get_site_name(entities_GetByIndex(e:GetInt("site"))) drawPlant = true ScreenX,ScreenY = 20,60 end
if e:GetName() == "bomb_abortplant" then drawPlant = false ScreenX,ScreenY = 8,3 end
if e:GetName() == "bomb_planted" then drawPlant = false plantedPercent = 0 plantedAt = g_curtime() drawBombPlanted = true ScreenX,ScreenY = 20,60 end
if e:GetName() == "bomb_begindefuse" then defuser = PlayerNameByUserID(e:GetInt("userid")) defusePercent = 0 defuseStarted = g_curtime() drawDefuse = true ScreenX,ScreenY = 20,90 end
if e:GetName() == "bomb_abortdefuse" then drawDefuse = false ScreenX,ScreenY = 20,60 end
if e:GetName() == "round_prestart" or e:GetName() == 'bomb_exploded' or e:GetName() == "bomb_defused" or e:GetName() == "round_officially_ended" then drawBombPlanted, drawDefuse, drawPlant = false, false, false ScreenX,ScreenY = 8,3 end end
function drawBombTimers()
if not BombTimer:GetValue() then return end local screenX, screenY = draw_GetScreenSize()
if drawPlant then local plantTime = string_format("%s - %0.1fs", planter, plantingStarted - g_curtime() + 3.125) local plantingInfo = string_format("%s - Planting", plantingSite) local plantPercent = (g_curtime() - plantingStarted) / 3.125 draw_SetFont(Vf30) local tW, tH = draw_GetTextSize(plantingInfo) draw_Color(124, 195, 13, 255) draw_Text(20, 0, plantingInfo) draw_Color(255, 255, 255, 255) draw_Text(20, tH, plantTime) if plantPercent < 1 and plantPercent > 0 then local plantingBar = (1 - plantPercent) * screenY draw_Color(13, 13, 13, 70) draw_FilledRect(0, 0, 16, screenY) draw_Color(0, 150, 0, 255) draw_FilledRect(1, plantingBar, 15, screenY+plantingBar) end end
if drawBombPlanted and entities_FindByClass("CPlantedC4")[1] ~= nil then local plantedBomb = entities_FindByClass("CPlantedC4") for i=1, #plantedBomb do bLength = plantedBomb[i]:GetPropFloat("m_flTimerLength") dLength = plantedBomb[i]:GetPropFloat("m_flDefuseLength") bSite = plantedBomb[i]:GetPropInt("m_nBombSite") == 0 and "A" or "B" end local plantedInfo = string_format("%s - %0.1fs", bSite, (plantedAt - g_curtime()) + bLength) local plantedPercent = (g_curtime() - plantedAt) / bLength if plantedAt - g_curtime() + bLength > 0 then draw_SetFont(Vf30) pTW, pTH = draw_GetTextSize(plantedInfo) 
if GetLocalPlayer():GetTeamNumber() == 3 and not GetLocalPlayer():GetPropBool("m_bHasDefuser") and (plantedAt - g_curtime()) + bLength < 10.1 or GetLocalPlayer():GetPropBool("m_bHasDefuser") and (plantedAt - g_curtime()) + bLength < 5.1 then r, g, b, a = 255,13,13,255 else r, g, b, a = 124, 195, 13, 255 end draw_Color(r, g, b, a) draw_Text(20, 0, plantedInfo) if plantedPercent < 1 and plantedPercent > 0 then local plantedBar = (1 - plantedPercent) * screenY draw_Color(13, 13, 13, 70) draw_FilledRect(0, 0, 16, screenY) draw_Color(0, 150, 0, 255) draw_FilledRect(1, screenY-plantedBar, 15, screenY) end end end
if drawDefuse and entities_FindByClass("CPlantedC4")[1] ~= nil then local plantedBomb = entities_FindByClass("CPlantedC4") for i=1, #plantedBomb do dLength = plantedBomb[i]:GetPropFloat("m_flDefuseLength") end local defuseInfo = string_format("%s - %0.1fs", defuser, (defuseStarted - g_curtime()) + dLength) local defusePercent = (g_curtime() - defuseStarted) / dLength if (defuseStarted - g_curtime()) + dLength > 0 then draw_SetFont(Vf30) draw_Color(255, 255, 255, 255) draw_Text(20, pTH+pTH, defuseInfo) if defusePercent < 1 and defusePercent > 0 then local defuseBar = (1 - defusePercent) * screenY draw_Color(13, 13, 13, 70) draw_FilledRect(0, 0, 16, screenY) draw_Color(0, 0, 150, 255) draw_FilledRect(1, screenY-defuseBar, 15, screenY) end end end end
function BombDamageIndicator()
if not Bomb_Damage:GetValue() or entities_FindByClass("CPlantedC4")[1] == nil then return end local Bomb = entities_FindByClass("CPlantedC4")[1]
if Bomb:GetPropBool("m_bBombTicking") and g_curtime() - 1 < Bomb:GetPropFloat("m_flC4Blow") and not Bomb:GetPropBool("m_bBombDefused") then local bDamage = DamagefromBomb(Bomb, GetLocalPlayer()) local bDmgInfo = string_format("-%i", bDamage)
if bDamage >= GetLocalPlayer():GetHealth() then draw_SetFont(Vf30) draw_Color(255, 0, 0, 255) draw_Text(20, pTH, "FATAL")
elseif bDamage < GetLocalPlayer():GetHealth() and bDamage - 1 > 0 then draw_SetFont(Vf30) draw_Color(255,255,255,255) draw_Text(20, pTH, bDmgInfo) end end end
function DamagefromBomb(Bomb, Player)
if not Bomb_Damage:GetValue() then return end local Bxyz = {Bomb:GetAbsOrigin()} local Pxyz = {Player:GetAbsOrigin()} local ArmorValue = Player:GetPropInt("m_ArmorValue") local C4Distance = math_sqrt((Bxyz[1] - Pxyz[1]) ^2 + (Bxyz[2] - Pxyz[2]) ^2 + (Bxyz[3] - Pxyz[3]) ^2) local d = ((C4Distance-75.68) / 789.2) local f1Damage = 450.7*math_exp(-d * d) if ArmorValue > 0 then local f1New = f1Damage * 0.5 local f1Armor = (f1Damage - f1New) * 0.5 if f1Armor > ArmorValue then f1Armor = ArmorValue * 2 f1New = f1Damage - f1Armor end f1Damage = f1New end 
return math_ceil(f1Damage + 0.5) end 
cb_Register("Draw", drawBombTimers) cb_Register("Draw", BombDamageIndicator) cb_Register("FireGameEvent", bombEvents)

-------------------- Chat Spams
local c_spammedlast = g_realtime() + CC_Spam_spd:GetValue()/100
function custom_chat()
if CC_Spams:GetValue() == 0 then return
elseif CC_Spams:GetValue() == 1 and g_realtime() >= c_spammedlast then client_ChatSay(ChatSpam1:GetValue()) c_spammedlast = g_realtime() + CC_Spam_spd:GetValue()/100
elseif CC_Spams:GetValue() == 2 and g_realtime() >= c_spammedlast then client_ChatSay(ChatSpam2:GetValue()) c_spammedlast = g_realtime() + CC_Spam_spd:GetValue()/100
elseif CC_Spams:GetValue() == 3 and g_realtime() >= c_spammedlast then client_ChatSay("﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽\n") c_spammedlast = g_realtime() + CC_Spam_spd:GetValue()/100 end end
cb_Register("Draw", custom_chat)

-------------------- Aspect Ratio Changer
local aspect_ratio_table = {}
local function gcd(m, n) while m ~= 0 do m, n = math_fmod(n, m), m end return n end
local function set_aspect_ratio(aspect_ratio_multiplier) local screen_width, screen_height = draw_GetScreenSize() local aspectratio_value = (screen_width*aspect_ratio_multiplier)/screen_height if aspect_ratio_multiplier == 1 or not aspect_ratio_check:GetValue() then aspectratio_value = 0 end client_SetConVar( "r_aspectratio", tonumber(aspectratio_value), true) end
local function on_aspect_ratio_changed() local screen_width, screen_height = draw_GetScreenSize() for i=1, 200 do local i2=i*0.01 i2 = 2 - i2 local divisor = gcd(screen_width*i2, screen_height) if screen_width*i2/divisor < 100 or i2 == 1 then aspect_ratio_table[i] = screen_width*i2/divisor .. ":" .. screen_height/divisor end end local aspect_ratio = aspect_ratio_reference:GetValue()*0.01 aspect_ratio = 2 - aspect_ratio set_aspect_ratio(aspect_ratio) end
cb_Register("Draw", on_aspect_ratio_changed)

-------------------- Esp on Dead
function ESP_Always_OnDead() 
if not espdead:GetValue() or GetLocalPlayer() == nil then return end
if not GetLocalPlayer():IsAlive() then gui_SetValue("esp_enemy_box", 3) gui_SetValue("esp_enemy_weapon", 1) gui_SetValue("esp_enemy_health", 2) gui_SetValue("esp_enemy_glow", 2) gui_SetValue("esp_enemy_skeleton", true) gui_SetValue("esp_enemy_name", true)
else gui_SetValue("esp_enemy_box", 0) gui_SetValue("esp_enemy_weapon", 0) gui_SetValue("esp_enemy_health", 0) gui_SetValue("esp_enemy_glow", 0) gui_SetValue("esp_enemy_skeleton", false) gui_SetValue("esp_enemy_name", false) end end
cb_Register("Draw", ESP_Always_OnDead)

-------------------- Enemy & Team Tracers
function Tracers()
if GetLocalPlayer() == nil or (not tracersEnemy:GetValue() and not tracersTeam:GetValue()) then return end
local sX, sY = draw_GetScreenSize() local players = entities_FindByClass("CCSPlayer") for i = 1, #players do local player = players[i] local pX, pY, pZ = client_WorldToScreen(player:GetAbsOrigin()) local playerindex = player:GetIndex()
if tracersEnemy:GetValue() then if is_enemy(playerindex) and player:IsAlive() and pX ~= nil and pY ~= nil then draw_Color(255,0,0,255) draw_Line(sX/2, sY, pX, pY) end end
if tracersTeam:GetValue() then if not is_enemy(playerindex) and player:IsAlive() and pX ~= nil and pY ~= nil and playerindex ~= LocalPlayerIndex() then draw_Color(0,0,255,255) draw_Line(sX/2, sY, pX, pY) end end end end
cb_Register("Draw", Tracers)

-------------------- Enemy & Team & Other Distance
function Distance(builder)
if not enemy_distance:GetValue() and not team_distance:GetValue() and not other_distance:GetValue() then return end
local ent = builder:GetEntity() local dist = distance3D({GetLocalPlayer():GetAbsOrigin()}, {ent:GetAbsOrigin()})['ft'] local playerindex = ent:GetIndex()
if enemy_distance:GetValue() and ent:IsAlive() and ent:IsPlayer() and is_enemy(playerindex) then builder:Color(255, 255, 255, 255) builder:AddTextBottom(dist) end
if team_distance:GetValue() and ent:IsAlive() and ent:IsPlayer() and not is_enemy(playerindex) and ent:GetIndex() ~= LocalPlayerIndex() then builder:Color(255, 255, 255, 255) builder:AddTextBottom(dist) end
if other_distance:GetValue() and not ent:IsPlayer() then builder:Color(255, 255, 255, 255) builder:AddTextBottom(dist) end end
cb_Register("DrawESP", "Distance ESP", Distance)

-------------------- Knife on Left Hand
function on_knife_righthand()
if not K_O_L_H:GetValue() then return end if GetLocalPlayer() == nil or not GetLocalPlayer():IsAlive() then client_exec("cl_righthand 1", true) return end
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
if not player:IsAlive() and not bot and player:GetPropEntity("m_hObserverTarget") ~= nil and playername ~= "GOTV" and playername ~= GetLocalPlayer():GetName() then 
local SpecTargetIndex = player:GetPropEntity("m_hObserverTarget"):GetIndex() 
if GetLocalPlayer():IsAlive() then if SpecTargetIndex == LocalPlayerIndex() then draw_SetFont(Vf12) local tW, tH = draw_GetTextSize(playername) draw_Color(255,255,255,255) draw_TextShadow( specX - 5 - tW, inbetween, playername) inbetween = inbetween + tH + 5 end
elseif not GetLocalPlayer():IsAlive() then if GetLocalPlayer():GetPropEntity("m_hObserverTarget") ~= nil then local imSpeccing = GetLocalPlayer():GetPropEntity("m_hObserverTarget"):GetIndex() 
if SpecTargetIndex == imSpeccing then draw_SetFont(Vf12) local tW, tH = draw_GetTextSize(playername) draw_Color(255,255,255,255) draw_TextShadow(specX - 5 - tW, inbetween, playername) inbetween = inbetween + tH + 5 end end end end end end
cb_Register("Draw", SpecList)

-------------------- Recoil Crosshair
function RCC()
if not RecoilCrosshair:GetValue() or GetLocalPlayer() == nil or not GetLocalPlayer():IsAlive() then return end local screenX, screenY = draw_GetScreenSize() local x = screenX/2 local y = screenY/2
local recoil_scale = client_GetConVar("weapon_recoil_scale") local fov = gui_GetValue("vis_view_fov") if fov == 0 then fov = 90 end local weapon = GetLocalPlayer():GetPropEntity("m_hActiveWeapon") if weapon == nil then return end local weapon_name = weapon:GetClass() 
if weapon_name == "CWeaponAWP" or weapon_name == "CWeaponSSG08" or weapon:GetProp("m_flRecoilIndex") == 0 or gui_GetValue("rbot_active") and gui_GetValue("rbot_antirecoil") then return end local aim_punch_angle_pitch, aim_punch_angle_yaw = GetLocalPlayer():GetPropVector("localdata", "m_Local", "m_aimPunchAngle") 
if -aim_punch_angle_pitch >= 0.07 and -aim_punch_angle_pitch >= 0.07 then if gui_GetValue("vis_norecoil") then x = x - (((screenX/fov)* aim_punch_angle_yaw)*1.2)*(recoil_scale*0.5) y = y + (((screenY/fov)* aim_punch_angle_pitch)*2)*(recoil_scale*0.5) else x = x - (((screenX/fov)* aim_punch_angle_yaw)*0.6)*(recoil_scale*0.5) y = y + ((screenY/fov)* aim_punch_angle_pitch)*(recoil_scale*0.5) end 
draw_Color(RecoilCrosshair_color:GetValue()) draw_OutlinedCircle(x, y, 3) end end
cb_Register("Draw", RCC)

-------------------- Name Steal fix
function infiniteNameSpam()
if gui_GetValue("msc_namestealer_enable") ~= 0 then namesteal = gui_GetValue("msc_namestealer_enable") end end cb_Register("Draw", infiniteNameSpam)
function NameStealFix(e)
if not StealNameFix:GetValue() or GetLocalPlayer() == nil or GetLocalPlayer():GetTeamNumber() == 1 then return end
if e:GetName() == "round_end" then gui_SetValue("msc_namestealer_enable", 0) end
if e:GetName() == "round_start" then gui_SetValue("msc_namestealer_enable", namesteal) end end cb_Register("FireGameEvent", NameStealFix)

-------------------- Show Team Damage
local damagedone, killed = 0, 0
function KillsAndDamage(e)
if e:GetName() == "player_hurt" then if PlayerIndexByUserID(e:GetInt("attacker")) == LocalPlayerIndex() and PlayerIndexByUserID(e:GetInt("userid")) ~= LocalPlayerIndex() and not is_enemy(PlayerIndexByUserID(e:GetInt("userid"))) then damagedone = damagedone + e:GetInt("dmg_health") end end
if e:GetName() == "player_death" then if PlayerIndexByUserID(e:GetInt("attacker")) == LocalPlayerIndex() and PlayerIndexByUserID(e:GetInt("userid")) ~= LocalPlayerIndex() and not is_enemy(PlayerIndexByUserID(e:GetInt("userid"))) then killed = killed + 1 end end
if e:GetName() == "player_connect_full" then if PlayerIndexByUserID(e:GetInt("userid")) == LocalPlayerIndex() then damagedone, killed = 0, 0 end end end
function DrawsTKsDMG() if not TeamDamageShow:GetValue() or GetLocalPlayer() == nil then return end local X, Y = draw_GetScreenSize() draw_Color(255,255,255,255) draw_SetFont(Tf13) draw_TextShadow(5, Y/2-40, "Damage Done: ".. damagedone) draw_TextShadow(5, Y/2-30, "Teammates Killed: ".. killed) end 
cb_Register("Draw", DrawsTKsDMG) cb_Register("FireGameEvent", KillsAndDamage)

-------------------- ghetto Bullet impacts
local bulletimpacts = {}
function bulletimpact(e)
if e:GetName() ~= "bullet_impact" or (not BulletImpacts_Local:GetValue() and not BulletImpacts_Enemy:GetValue() and not BulletImpacts_Team:GetValue()) then return end x = e:GetFloat("x") y = e:GetFloat("y") z = e:GetFloat("z") player_index = PlayerIndexByUserID(e:GetInt("userid"))
if BulletImpacts_Local:GetValue() then if player_index == LocalPlayerIndex() then table_insert(bulletimpacts, {g_curtime(), x, y, z, BulletImpacts_color_Local:GetValue()}) end end
if BulletImpacts_Enemy:GetValue() then if is_enemy(player_index) then table_insert(bulletimpacts, {g_curtime(), x, y, z, BulletImpacts_color_Enemy:GetValue()}) end end
if BulletImpacts_Team:GetValue() then if not is_enemy(player_index) and player_index ~= LocalPlayerIndex() then table_insert(bulletimpacts, {g_curtime(), x, y, z, BulletImpacts_color_Team:GetValue()}) end end end
function showimpacts() if GetLocalPlayer() == nil or (not BulletImpacts_Local:GetValue() and not BulletImpacts_Enemy:GetValue() and not BulletImpacts_Team:GetValue()) then return end for k, v in pairs(bulletimpacts) do if g_curtime() - v[1] > BulletImpacts_Time:GetValue() then table_remove(bulletimpacts, k) else local X, Y = client_WorldToScreen(v[2], v[3], v[4]) if X ~= nil and Y ~= nil then draw_Color(v[5], v[6], v[7], v[8]) draw_RoundedRect(X-3, Y-3, X+3, Y+3) end end end end
cb_Register("Draw", showimpacts) cb_Register("FireGameEvent", bulletimpact)


c_AllowListener("round_freeze_end") c_AllowListener("round_end") c_AllowListener("round_prestart") c_AllowListener("round_start") c_AllowListener("bomb_beginplant") c_AllowListener("bomb_abortplant") c_AllowListener("bomb_planted") c_AllowListener("bomb_defused") c_AllowListener('bomb_exploded') c_AllowListener("bomb_begindefuse") c_AllowListener("bomb_abortdefuse") c_AllowListener("round_officially_ended") c_AllowListener("player_spawn") c_AllowListener("player_hurt") c_AllowListener("player_death") c_AllowListener("player_connect_full") c_AllowListener("smokegrenade_detonate") c_AllowListener("molotov_detonate") c_AllowListener("inferno_startburn") c_AllowListener("inferno_expire") c_AllowListener("inferno_extinguish") c_AllowListener("grenade_thrown") c_AllowListener("bullet_impact")