Button = Class{}

function Button:init(params)
    self.x = params.x
    self.y = params.y

    -- 1 is pressure button, 2 is Simon Says button
    self.type = params.type
end

function Button:update(dt)
end

function Button:render()
    if self.type == 1 then
        love.graphics.draw(gTextures['pressure_button'], self.x + 1, self.y)
        love.graphics.draw(gTextures['button_base'], self.x, self.y + 7)
    else
    end
end