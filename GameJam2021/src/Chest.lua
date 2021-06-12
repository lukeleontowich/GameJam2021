-- Chest.lua

Chest = Class {}

function Chest:init(params)
    self.x = params.x
    self.y = params.y 

    self.width = 16
    self.height = 16

    self.chest_opened = false
end

function Chest:render()
    if self.chest_opened then
        love.graphics.draw(gTextures['chest_open'], self.x, self.y)
    else 
        love.graphics.draw(gTextures['chest'], self.x, self.y)
    end
end
