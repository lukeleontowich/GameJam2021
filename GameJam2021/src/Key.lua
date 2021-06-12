-- Key.lua

Key = Class {}

function Key:init(params)
    self.x = params.x  
    self.y = params.y
    self.portaled = false
    self.width = 16
    self.height = 16 
end
