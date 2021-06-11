Blob = Class{__includes = Entity}

function Blob:init(params)
    self.x = params.x
    self.y = params.y

    --  1 is red 2 is blue
    self.color = params.color

    self.currentAnimation = 1

    self.dx = 0.5
    self.dy = 0.5

    self.sx = 0.4
    self.sy = 0.4

    self.pixels = 32
end

function Blob:update(dt)
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
        love.graphics.draw(gTextures['red_blob_still'], self.x, self.y, 0, self.sx, self.sy)
    else
        love.graphics.draw(gTextures['blue_blob_still'], self.x, self.y, 0, self.sx, self.sy)
    end
end