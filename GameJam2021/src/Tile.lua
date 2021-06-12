Tile = Class{}

function Tile:init(x, y)
    self.x = x
    self.y = y
end

--need to add tile collision

function Tile:render()
    love.graphics.draw(gTextures['tile'], self.x, self.y)
end