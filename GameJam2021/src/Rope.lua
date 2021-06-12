--  rope.lua

Rope = Class{__includes = Entity}

function Rope:init(param) 
    self.redBlob = param.redBlob
    self.blueBlob = param.blueBlob
    self.max_length = (VIRTUAL_WIDTH / 1.5) * (VIRTUAL_WIDTH / 1.5)
    --  80% the max_lenth
    self.tensor_length = self.max_length * 0.5
    self.tensor_num  = 1.0
    self.original_speed = self.redBlob.dx
    self.length = 0
    self.center_x = 0
    self.center_y = 0
    self.tense = false
end

function Rope:ropeSnap()
    local center_x = 0
    local center_y = 0
    --  case 1
    if self.redBlob.x < self.blueBlob.x and self.redBlob.y > self.blueBlob.y then
        center_x = (self.blueBlob.x - self.redBlob.x) / 2 + self.redBlob.x
        center_y = (self.redBlob.y - self.blueBlob.y) / 2 + self.blueBlob.y 
        self.redBlob.x = center_x - self.redBlob.width
        self.redBlob.y = center_y + self.redBlob.height
        self.blueBlob.x = center_x + self.blueBlob.width
        self.blueBlob.y = center_y + self.redBlob.height
    -- case 2
    elseif self.redBlob.x > self.blueBlob.x and self.redBlob.y < self.blueBlob.y then
        center_x = (self.redBlob.x - self.blueBlob.x) / 2 + self.blueBlob.x
        center_y = (self.blueBlob.y - self.redBlob.y) / 2 + self.redBlob.y 
        self.redBlob.x = center_x - self.redBlob.width
        self.redBlob.y = center_y - self.redBlob.height
        self.blueBlob.x = center_x + self.blueBlob.width
        self.blueBlob.y = center_y + self.blueBlob.height
    end


end

function Rope:update(dt)
   
    self.length = (
        (self.redBlob.x - self.blueBlob.x) *
        (self.redBlob.x - self.blueBlob.x) +
        (self.redBlob.y - self.blueBlob.y) *
        (self.redBlob.y - self.blueBlob.y))
    if self.length > self.max_length then
        --self:ropeSnap()
    
    elseif self.length > self.tensor_length then
        self.tensor_num = 1.0 - self.length / self.max_length 
        self.redBlob.dx = self.original_speed * self.tensor_num
        self.redBlob.dy = self.original_speed * self.tensor_num
        self.blueBlob.dx = self.original_speed * self.tensor_num
        self.blueBlob.dy = self.original_speed * self.tensor_num
    else
        self.tensor_num = 1.0
        self.redBlob.dx = self.original_speed 
        self.redBlob.dy = self.original_speed 
        self.blueBlob.dx = self.original_speed
        self.blueBlob.dy = self.original_speed
    end
end

function Rope:render()
    local color = {1.0, 1.0, 1.0, 1.0}
    love.graphics.setColor(1- self.tensor_num, self.tensor_num, 0.0, 1.0)
    love.graphics.line(
        self.redBlob.x + self.redBlob.width, 
        self.redBlob.y + self.redBlob.height, 
        self.blueBlob.x + self.blueBlob.width , 
        self.blueBlob.y + self.blueBlob.height
    )
    love.graphics.setColor(1.0, 1.0, 1.0, 1.0)

end