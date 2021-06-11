--  Entity.lua

Entity = Class{}

-- C++
-- Entity:init(int x, int y, int dx, int dy, int w, int h, 
--TEXTURE* texture, STATEMACHINE* stateMachine, LEVEL* level)
function Entity:init(def)
    self.x = def.x
    self.y = def.y

    self.dx = def.dx
    self.dy = def.dy

    self.width = def.width
    self.height = def.height

    self.texture = def.texture
    self.stateMachine = def.stateMachine

    self.direction = 'left'

    self.map = def.map

    self.level = def.level

end


function Entity:changeState(state, params)
    self.stateMachine:change(state, params)
end

function Entity:update(dt)
    self.stateMachine:update(dt)
end

function Entity:collides(entity)
end

function Entity:render()
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.currentAnimation:getCurrentFrame()],
    math.floor(self.x) + 8, math.floor(self.y) + 10, 0, self.direction == 'right' and 1 or -1, 1, 8, 10)
end