-- Level.lua

Level = Class {}

function Level:init(params)
    self.chest_keys = params.chest_keys
    self.portals = params.portals
    self.pressure_buttons = params.pressure_buttons
    self.buttons = params.buttons
    self.enemies = params.enemies
end