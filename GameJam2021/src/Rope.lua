--  rope.lua

Rope = Class{__includes = Entity}

function Rope:init(param) 
    self.redBlob = param.redBlob
    self.blueBlob = param.blueBlob
    
end

function Rope:update(dt)
    self.length = (
        (self.redBlob.x - self.blueBlob.x) *
        (self.redBlob.x - self.blueBlob.x) +
        (self.rebBlob.y - self.blueBlob.y) *
        (self.redBlob.y - self.blueBlob.y))
    
    print("rope length:", self.length)
end
