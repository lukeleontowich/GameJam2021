--  PressureButton.lua

PressureButton = Class{}

function PressureButton:init(params)
    self.y = params.y 
    self.side = params.side
    self.color_offset = 0.0
    self.hit = false
end

function PressureButton:update(vel_left, vel_right, redBlob, blueBlob)
    if not self.hit and vel_left > 0 and vel_right > 0 then
        if self.side == 1 and self:collision(redBlob) then
            if vel_left >= 1.0  then
                self.hit = true
                self.color_offset = 1.0
            else
                self.color_offset = vel_left
            end
        elseif self.side == 2 and self:collision(blueBlob) then
            if vel_right >= 1.0 then
                self.hit = true
                self.color_offset = 1.0
            else
                self.color_offset = vel_left
            end
        end
    end
end

function PressureButton:render()
    local color = {1.0, self.color_offset, 0.0, 1.0}
    if self.hit then
        color = {0.0, 1.0, 0.0, 1.0}
    end
    
    local x = VIRTUAL_WIDTH / 2
    local theta = 0
    if self.side == 1 then
        theta = 3 * math.pi / 2.0
        x = x - 16
        love.graphics.draw(gTextures['button_base'], x+6, self.y+1, theta, 1, 1)
    elseif self.side == 2 then
        theta = math.pi / 2.0
        x = x + 16
        love.graphics.draw(gTextures['button_base'], x-6, self.y-1, theta, 1, 1)
    end

    love.graphics.setColor(color)
    love.graphics.draw(gTextures['pressure_button'], x, self.y, theta, 1, 1)
    
    love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
    
end

function PressureButton:collision(blob) 
    if blob.y < self.y + 16 and blob.y + blob.pixels > self.y then
        return true
    else
        return false
    end
end
