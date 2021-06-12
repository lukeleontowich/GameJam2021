--  rope.lua

Rope = Class{__includes = Entity}

function Rope:init(param) 
    self.redBlob = param.redBlob
    self.blueBlob = param.blueBlob
    self.max_length = (VIRTUAL_WIDTH / 2) * (VIRTUAL_WIDTH / 2)
    --  80% the max_lenth
    self.tensor_length = self.max_length * 0.8 
    self.tensor_num  = 1.0
    self.original_speed = self.redBlob.dx
    self.length = 0
    self.center_x = 0
    self.center_y = 0
end

function Rope:getCenter()
    local x1, x2, y1, y2 = 0
    if self.redBlob.x > self.blueBlob.x then
        x1 = self.blueBlob.x
        x2 = self.redBlob.x
    else
        x1 = self.redBlob.x
        x2 = self.blueBlob.x
    end
    if self.redBlob.y > self.blueBlob.y then
        y1 = self.blueBlob.y
        y2 = self.redBlob.y
    else
        y1 = self.redBlob.y
        y2 = self.blueBlob.y
    end
    self.center_x = (x2 - x1) / 2
    self.center_y = (y2 - y1) / 2

    --self.redBlob.x = 
end

function Rope:update(dt)
    print("tensor length: ", self.tensor_length)
    print("length: ", self.length)
    self.length = (
        (self.redBlob.x - self.blueBlob.x) *
        (self.redBlob.x - self.blueBlob.x) +
        (self.redBlob.y - self.blueBlob.y) *
        (self.redBlob.y - self.blueBlob.y))
    if self.length > self.max_length then
        local center_x = (self.redBlob.x - self.blueBlob.x) / 2
        local center_y = (math.abs(self.redBlob.y - self.blueBlob.y)) / 2
        if self.redBlob.x > self.blueBlob.x then
            self.redBlob.x = center_x + 8
            self.blueBlob.x = center_x - 8
        else
            self.redBlob.x = center_x - 8
            self.blueBlob.x = center_x + 8
        end
        if self.redBlob.y > self.blueBlob.y then
            self.redBlob.y = center_y + 8
            self.blueBlob.y = center_y - 8
        else
            self.redBlob.y = center_y - 8
            self.blueBlob.y = center_y + 8
        end
    end
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
        self.redBlob.x + 8, 
        self.redBlob.y + 8, 
        self.blueBlob.x + 8 , 
        self.blueBlob.y + 8)

end