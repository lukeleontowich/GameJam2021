Tile = Class{}

function Tile:init(params)
    self.x = params.x
    self.y = params.y
end

--need to add tile collision

function Tile:render()
    love.graphics.draw(gTextures['tile'], self.x, self.y)
end