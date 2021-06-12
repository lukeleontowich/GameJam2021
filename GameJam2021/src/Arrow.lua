Arrow = Class{}

function Arrow:init(params)
    self.x = params.x
    self.y = params.y

    -- 1 = up
    -- 2 = down
    -- 3 = left
    -- 4 = right
    self.direction = params.direction

    self.dy = 0.5

    self.interval = 0.02
    self.timer = 0
end

function Arrow:update(dt)
    self.timer = self.timer + dt

    if self.timer > self.interval then
        self.timer = self.timer % self.interval

        self.y = self.y + self.dy
    end

    if love.keyboard.wasPressed('up') then
    elseif love.keyboard.wasPressed('down') then
    elseif love.keyboard.wasPressed('left') then
    else
    end
end

function Arrow:render()
    if self.direction == 1 then
        love.graphics.draw(gTextures['up_arrow'], VIRTUAL_WIDTH / 2 - 32, self.y)
    elseif self.direction == 2 then
        love.graphics.draw(gTextures['down_arrow'], VIRTUAL_WIDTH / 2 + 32, self.y)
    elseif self.direction == 3 then
        love.graphics.draw(gTextures['left_arrow'], VIRTUAL_WIDTH / 2 - 64, self.y)
    else
        love.graphics.draw(gTextures['right_arrow'], VIRTUAL_WIDTH / 2 + 64, self.y)
    end
end