StartState = Class{__includes = BaseState}

function StartState:init()
    self.color = {1.0, 1.0, 1.0, 1.0}
end

local menu_states = {'start', 'how_to_play', 'main'}



function StartState:render()
    love.graphics.draw(
        gTextures['intro'], 
        0, 0, 0, 0.5, 0.5, 0, 0)
    love.graphics.setColor(0.2, 0.21, 0.2, 1.0)
    local off = 40
    --[[love.graphics.polygon(
        'fill',
        VIRTUAL_WIDTH / 2 - off, 
        VIRTUAL_HEIGHT / 2 - off,
        VIRTUAL_WIDTH / 2 - off,
        VIRTUAL_HEIGHT / 2 + off,
        VIRTUAL_WIDTH / 2 + off,
        VIRTUAL_HEIGHT / 2 + off,
        VIRTUAL_WIDTH / 2 + off,
        VIRTUAL_HEIGHT / 2 - off
    )--]]
    love.graphics.setColor(0.1, 1.0, 0.1, 1.0)
    love.graphics.printf("Welcome!", 
    0, VIRTUAL_HEIGHT / 2 - 48, VIRTUAL_WIDTH, 'center')
    love.graphics.printf("Press Any Key to Continue", 0, VIRTUAL_HEIGHT / 2 - 24, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(self.color)
    --love.graphics.draw(gTextures['red_blob_still'], 0, 0)
end

function StartState:update() 
    if love.keyboard.wasPressed() and not love.keyboard.wasPressed('escape') then
        gStateMachine:change('play')
    end
end

