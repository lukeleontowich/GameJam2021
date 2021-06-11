Blob = Class{__includes = Entity}

function Blob:init(params)
    self.x = params.x
    self.y = params.y

    self.color = params.color

    self.currentAnimation = 1
end

function Blob:update(dt)
end

function Blob:render()
    if self.color == 1 then
        love.graphics.draw(gTextures['red_blob_still'], self.x, self.y)
    else
        love.graphics.draw(gTextures['blue_blob_still'], self.x, self.y)
    end
end