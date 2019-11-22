local GetConVar, SetConVar = client.GetConVar, client.SetConVar
local enable = gui.Checkbox(gui.Reference('VISUALS', 'Shared'), 'disable_post_processing', 'Disable Post Processing', false)
callbacks.Register('CreateMove', function(_)
  local val = enable:GetValue() and 0 or 1
  if GetConVar('mat_postprocess_enable') ~= val then
    SetConVar('mat_postprocess_enable', val, true)
  end
end)
