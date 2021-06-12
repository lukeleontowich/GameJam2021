Blob = Class{__includes = Entity}

function Blob:init(params)
    self.x = params.x
    self.y = params.y

    --  1 is red 2 is blue
    self.color = params.color

    self.currentAnimation = 1
    -- 1 is increasing, 2 is decreasing
    self.animationDirection = 1

    self.dx = 0.5
    self.dy = 0.5

    self.sx = 0.4
    self.sy = 0.4

    self.pixels = 32

    self.timer = 0
    self.interval = 0.4
end

function Blob:update(dt)
    self.timer = self.timer + dt

    if self.timer > self.interval then
        self.timer = self.timer % self.interval

        if self.currentAnimation == 1 or self.currentAnimation == 3 then
            self.currentAnimation = 2
        else
            if self.animationDirection == 1 then
                self.currentAnimation = 3
                self.animationDirection = 2
            else
                self.currentAnimation = 1
                self.animationDirection = 1
            end
        end
    
    end

    if self.color == 1 then
        if love.keyboard.isDown('d') then
            self.x = self.x + self.dx
        elseif love.keyboard.isDown('a') then
            self.x = self.x - self.dx
        elseif love.keyboard.isDown('w') then
            self.y = self.y - self.dy 
        elseif love.keyboard.isDown('s') then
            self.y = self.y + self.dy
        end
    elseif self.color == 2 then
        if love.keyboard.isDown('right') then
            self.x = self.x + self.dx
        elseif love.keyboard.isDown('left') then
            self.x = self.x - self.dx
        elseif love.keyboard.isDown('up') then
            self.y = self.y - self.dy 
        elseif love.keyboard.isDown('down') then
            self.y = self.y + self.dy
        end
    end

    
    --  Make sure the blob stays on screen
    if self.x > VIRTUAL_WIDTH - self.sx * self.pixels then
        self.x = self.x - self.dx
    elseif self.x < 0  then
        self.x = self.x + self.dx
    elseif self.y < 0 then 
        self.y = self.y + self.dy
    elseif self.y > VIRTUAL_HEIGHT - self.dy * self.pixels then
        self.y = self.y - self.dy

    end
end

function Blob:render()
    if self.color == 1 then
        if self.currentAnimation == 1 then
            love.graphics.draw(gTextures['red_blob_still'], self.x, self.y, 0, self.sx, self.sy)
        elseif self.currentAnimation == 2 then
            love.graphics.draw(gTextures['red_blob_squishing'], self.x, self.y, 0, self.sx, self.sy)
        else
            love.graphics.draw(gTextures['red_blob_squished'], self.x, self.y, 0, self.sx, self.sy)
        end
    else
        if self.currentAnimation == 1 then
            love.graphics.draw(gTextures['blue_blob_still'], self.x, self.y, 0, self.sx, self.sy)
        elseif self.currentAnimation == 2 then
            love.graphics.draw(gTextures['blue_blob_squishing'], self.x, self.y, 0, self.sx, self.sy)
        else
            love.graphics.draw(gTextures['blue_blob_squished'], self.x, self.y, 0, self.sx, self.sy)
        end
    end
end