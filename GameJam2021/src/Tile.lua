Tile = Class{}

function Tile:init(x, y)
    self.x = x
    self.y = y

    self.width = 16
    self.height = 16

    self.sx = 3
    self.sy = 3
end

--need to add tile collision

function Tile:render()
    love.graphics.draw(gTextures['tile'], self.x, self.y)
end

function Tile:collides(target)
    return not (target.x > self.x + self.width or self.x > target.x + target.width or
            target.y > self.y + self.height or self.y > target.y + target.height)
end