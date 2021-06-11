StartState = Class{__includes = BaseState}

function StartState:render()
    love.graphics.draw(gTextures['red_blob_still'], 0, 0)
end