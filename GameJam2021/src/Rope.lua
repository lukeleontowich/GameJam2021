--  rope.lua


Rope = Class{__includes = Entity}
local tile_size = 16
local center_x = VIRTUAL_WIDTH / 2
local center_y = 0

function Rope:init(param) 
    self.redBlob = param.redBlob
    self.blueBlob = param.blueBlob
    self.max_length = (VIRTUAL_WIDTH / 1.5) * (VIRTUAL_WIDTH / 1.5)
    --  40% the max_lenth
    self.tensor_length = self.max_length * 0.4
    self.tensor_num  = 1.0
    self.original_speed = self.redBlob.dx
    self.length = 0
end



function Rope:update(dt)
    local left_snap_velocity = 0
    local right_snap_velocity = 0
    self.length = (
        (self.redBlob.x - self.blueBlob.x) *
        (self.redBlob.x - self.blueBlob.x) +
        (self.redBlob.y - self.blueBlob.y) *
        (self.redBlob.y - self.blueBlob.y))

    if self.length > self.tensor_length then
        if self.tensor_num < 0.1 then
            left_snap_velocity, right_snap_velocity = self:ropeSnap()
            self.tensor_num = 1.0
            self.redBlob.dx = self.original_speed 
            self.redBlob.dy = self.original_speed 
            self.blueBlob.dx = self.original_speed
            self.blueBlob.dy = self.original_speed
        else
            self.tensor_num = 1.0 - self.length / self.max_length 
            self.redBlob.dx = self.original_speed * self.tensor_num
            self.redBlob.dy = self.original_speed * self.tensor_num
            self.blueBlob.dx = self.original_speed * self.tensor_num
            self.blueBlob.dy = self.original_speed * self.tensor_num
        end
    else
        self.tensor_num = 1.0
        self.redBlob.dx = self.original_speed 
        self.redBlob.dy = self.original_speed 
        self.blueBlob.dx = self.original_speed
        self.blueBlob.dy = self.original_speed
    end
    return left_snap_velocity, right_snap_velocity
end

function Rope:render()
    local color = {1.0, 1.0, 1.0, 1.0}
    love.graphics.setColor(1- self.tensor_num, self.tensor_num, 0.0, 1.0)
    love.graphics.line(
        self.redBlob.x + self.redBlob.centerX, 
        self.redBlob.y + self.redBlob.centerY, 
        self.blueBlob.x + self.blueBlob.centerX, 
        self.blueBlob.y + self.blueBlob.centerY
    )
    love.graphics.setColor(1.0, 1.0, 1.0, 1.0)

end

function Rope:ropeSnap()
    
    gSounds['rope_snap']:play()

    local orig_red_x = self.redBlob.x
    local orig_blue_x = self.blueBlob.x 

    --  setting blob new coordinates
    self.redBlob.x = center_x- tile_size - self.redBlob.centerX
    self.blueBlob.x = center_x + tile_size - self.blueBlob.centerX

    local slope = (self.blueBlob.y - self.redBlob.y) / (self.blueBlob.x - self.redBlob.x)
    local b = (self.blueBlob.y - (slope * self.blueBlob.x))

    local center_y_left = slope * (self.redBlob.x) + b
    local center_y_right = slope * (self.blueBlob.x) + b

    --  velocities  adjust this ---------------||  (if you want different max)
    --                                          |
    local velocity_max = center_x * center_x / 1.5
    
    local velocity_left = (
        (center_x - orig_red_x) * (center_x - orig_red_x) +
        (center_y_left - self.redBlob.y) * (center_y_left - self.redBlob.y)
    )
    local velocity_right = (
        (orig_blue_x - center_x) * (orig_blue_x - center_x) +
        (self.blueBlob.y - center_y_right) * (self.blueBlob.y - center_y_right)
    )

    local velocity_left_ratio = velocity_left / velocity_max
    local velocity_right_ratio = velocity_right / velocity_max

    if (velocity_left_ratio > 1.0) then
        velocity_left_ratio = 1.0
    end
    if (velocity_right_ratio > 1.0) then
        velocity_right_ratio = 1.0
    end

    self.redBlob.y = center_y_left
    self.blueBlob.y = center_y_right

    return velocity_left_ratio, velocity_right_ratio
end