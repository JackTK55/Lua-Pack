local draw_GetScreenSize, entities_FindByClass, GetLocalPlayer, LocalPlayerIndex, GetPlayerResources, draw_SetFont, draw_GetTextSize, draw_Color, draw_TextShadow = draw.GetScreenSize, entities.FindByClass, entitiesGetLocalPlayer, client.GetLocalPlayerIndex, entities.GetPlayerResources, draw.SetFont, draw.GetTextSize, draw.Color, draw.TextShadow

local SpectatorList = gui.Checkbox(gui.Reference("MISC", "GENERAL", "Main"), "msc_speclist", "Spectators", false)
local Vf12 = draw.CreateFont("Verdana", 12) 

function SpecList()
	if not SpectatorList:GetValue() or GetLocalPlayer() == nil then 
		return 
	end 
	
	local specX, specY = draw_GetScreenSize() 
	local inbetween = 5 
	local players = entities_FindByClass("CCSPlayer") 
	
	for i = 1, #players do 
	
		local player = players[i] 
		local playername = player:GetName() 
		local playerindex = player:GetIndex() 
		local bot = GetPlayerResources():GetPropInt("m_iPing", playerindex) == 0
		
		if player:IsAlive() and not bot and player:GetPropEntity("m_hObserverTarget") ~= nil and playername ~= "GOTV" and playerindex ~= LocalPlayerIndex() then
			local SpecTargetIndex = player:GetPropEntity("m_hObserverTarget"):GetIndex() 
			
			if GetLocalPlayer():IsAlive() then 
				if SpecTargetIndex == LocalPlayerIndex() then 
					draw_SetFont(Vf12) 
					local tW, tH = draw_GetTextSize(playername) 
					draw_Color(255,255,255,255) 
					draw_TextShadow((specX - 5) - tW, inbetween, playername) 
					inbetween = (inbetween + tH) + 5 
				end
				
			else 
				if GetLocalPlayer():GetPropEntity("m_hObserverTarget") ~= nil then 
					local imSpeccing = GetLocalPlayer():GetPropEntity("m_hObserverTarget"):GetIndex() 
					
					if SpecTargetIndex == imSpeccing then 
						draw_SetFont(Vf12) 
						local tW, tH = draw_GetTextSize(playername) 
						draw_Color(255,255,255,255) 
						draw_TextShadow((specX - 5) - tW, inbetween, playername) 
						inbetween = (inbetween + tH) + 5 
					end
				end
			end 
		end 
	end 
end

cb_Register("Draw", SpecList)