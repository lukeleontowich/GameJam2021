-- Chest.lua

Chest = Class {}

function Chest:init(params)
    self.x = params.x
    self.y = params.y 

    self.width = 16
    self.height = 16
end