--  rope.lua

Rope = Class{__includes = Entity}

function Rope:init(param) 
    self.redBlob = param.redBlob
    self.blueBlob = param.blueBlob
    self.tensor_length = VIRTUAL_WIDTH / 4
    self.tensor_num  = 1.0
    self.original_speed = self.redBlob.dx
    self.length = 0
end

function Rope:update(dt)
    print("tensor length: ", self.tensor_length)
    print("length: ", self.length)
    self.length = (
        (self.redBlob.x - self.blueBlob.x) *
        (self.redBlob.x - self.blueBlob.x) +
        (self.redBlob.y - self.blueBlob.y) *
        (self.redBlob.y - self.blueBlob.y))
    
    if self.length > self.tensor_length then
        self.redBlob.dx = self.original_speed * 0.2
        self.redBlob.dy = self.original_speed * 0.2
        self.blueBlob.dx = self.original_speed * 0.2
        self.blueBlob.dy = self.original_speed * 0.2
    else
        self.redBlob.dx = self.original_speed 
        self.redBlob.dy = self.original_speed 
        self.blueBlob.dx = self.original_speed
        self.blueBlob.dy = self.original_speed
    end
end

function Rope:render()
    local color = {1.0, 1.0, 1.0, 1.0}
    love.graphics.setColor(0.7, 0.7, 0.7, 1.0)
    love.graphics.line(
        self.redBlob.x, 
        self.redBlob.y, 
        self.blueBlob.x, 
        self.blueBlob.y)

end