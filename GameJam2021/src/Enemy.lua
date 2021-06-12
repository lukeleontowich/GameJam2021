Enemy = Class{}

function Enemy:init(params)
    self.x = params.x
    self.y = params.y
    self.color = params.color

    self.dx = 0.1
    self.dy = 0.1

    self.width = 16
    self.height = 16

    self.redBlob = params.redBlob
    self.blueBlob = params.blueBlob

    -- 1 means it's on the left side of the screen, 2 means it's on the right
    -- (important for how we are doing collisions with wall, and which
    -- player it is attacking)
    self.side = 1

    self.timer = 0

    self.currentAnimation = 2
    self.animationDirection = 2
    self.interval = 0.2

    self.isDead = false
    self.exists = true
end

function Enemy:update(dt)
    self.timer = self.timer + dt

    if self.timer > self.interval then
        if self.isDead then
            self.exists = false
        end
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

    --add enemy movement (AI)
    if self.side == 1 then
        if self.redBlob.x > self.x then
            self.x = self.x + self.dx
        elseif self.redBlob.x < self.x then
            self.x = self.x - self.dx
        end
        if self.redBlob.y < self.y then
            self.y = self.y - self.dy 
        elseif self.redBlob.y > self.y then
            self.y = self.y + self.dy
        end
    else
    end
end

function Enemy:render()
    if self.color == 1 then
        if self.isDead then
            love.graphics.draw(gTextures['red_enemy_dead'], self.x, self.y)
        else
            if self.currentAnimation == 1 then
                love.graphics.draw(gTextures['red_enemy_left'], self.x, self.y)
            elseif self.currentAnimation == 2 then
                love.graphics.draw(gTextures['red_enemy_still'], self.x, self.y)
            else
                love.graphics.draw(gTextures['red_enemy_right'], self.x, self.y)
            end
        end
    else
        if self.isDead then
        else
            if self.currentAnimation == 1 then
                love.graphics.draw(gTextures['blue_enemy_left'], self.x, self.y, 0, self.sx, self.sy)
            elseif self.currentAnimation == 2 then
                love.graphics.draw(gTextures['blue_enemy_still'], self.x, self.y, 0, self.sx, self.sy)
            else
                love.graphics.draw(gTextures['blue_enemy_right'], self.x, self.y, 0, self.sx, self.sy)
            end
        end
    end
end

function Enemy:collides(target)
    return (not (target.x > self.x + self.width or self.x > target.x + target.width or
            target.y > self.y + self.height or self.y > target.y + target.height)) and
            target.color == self.color
end