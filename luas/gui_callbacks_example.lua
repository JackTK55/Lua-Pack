if not client.set_callback then LoadScript('gui_callbacks.lua') end

local ref = gui.Reference('Settings', 'Advanced')
local enable = gui.Checkbox(ref, 'temp_checkbox', 'Enable', false)
local combobox = gui.Combobox( ref , 'temp_combobox', 'Options', 'Value 1', 'Value 2', 'Value 3', 'Value 4')
local editbox = gui.Editbox( ref, 'temp_editbox', 'Message' )

-- "self" represents the gui object
local function on_checkbox_change( self )
    print( self:GetName(), self:GetValue() )
end

local function on_combobox_change( self )
    print( self:GetName(), self:GetString() )
end

local function on_editbox_change( self )
    print( self:GetName(), self:GetValue() )
end


-- Calls the functions on lua load
-- params: (gui object)
on_checkbox_change( enable )
on_combobox_change( combobox )
on_editbox_change( editbox )


-- Sets up the function to get called whenever the value changes
-- params: (gui object), (unique name), (callback)
client.set_callback( enable, 'Checkbox', on_checkbox_change )
client.set_callback( combobox, 'Combobox', on_combobox_change )
client.set_callback( editbox, 'Editbox', on_editbox_change )


-- To stop the callbacks you can unset them using the same unique name you gave them
-- params: (unique name)
client.unset_callback( 'Checkbox' )
client.unset_callback( 'Combobox' )
client.unset_callback( 'Editbox' )