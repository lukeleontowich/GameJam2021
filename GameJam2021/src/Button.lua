Button = Class{}

function Button:init(params)
    self.x = params.x
    self.y = params.y

    self.width = 16
    self.height = 7

    -- 1 is pressure button, 2 is Simon Says button
    self.type = params.type

    self.arrow_button_pressed = false
    self.pressed_sound_played = false
end

function Button:update(dt)
end

function Button:render()
    if self.type == 1 then
        love.graphics.draw(gTextures['pressure_button'], self.x + 1, self.y)
        love.graphics.draw(gTextures['button_base'], self.x, self.y + 7)
    else
        if not self.arrow_button_pressed then
            love.graphics.draw(gTextures['arrow_button'], self.x + 1, self.y)
            love.graphics.draw(gTextures['button_base'], self.x, self.y + 7)
        else
            love.graphics.draw(gTextures['arrow_button_pressed'], self.x + 1, self.y + 4)
            love.graphics.draw(gTextures['button_base'], self.x, self.y + 7)
        end
    end
end

function Button:collides(target)
    return not (target.x > self.x + self.width or self.x > target.x + target.width or
            target.y > self.y + self.height or self.y > target.y + target.height)
end