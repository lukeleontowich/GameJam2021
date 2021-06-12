Tile = Class{}

function Tile:init(x, y)
    self.x = x
    self.y = y

    self.sx = 3
    self.sy = 3
end

--need to add tile collision

function Tile:render()
    love.graphics.draw(gTextures['tile'], self.x, self.y)
end