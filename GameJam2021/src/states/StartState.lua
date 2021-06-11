StartState = Class{__includes = BaseState}

function StartState:render()
    love.graphics.draw(gTextures['background'], 0, 0)
    love.graphics.draw(gTextures['red_blob_still'], (VIRTUAL_WIDTH / 2) - 16, VIRTUAL_HEIGHT - 32)
    love.graphics.draw(gTextures['tile'], 0, 0)
end