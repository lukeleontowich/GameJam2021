PauseState = Class{__includes = BaseState}

function PauseState:init()
end

function PauseState:enter(params)
    self.redBlob = params.redBlob
    self.blueBlob = params.blueBlob
    self.tiles = params.tiles
    self.health = params.health
    self.level = params.level
end

function PauseState:render() 
    love.graphics.draw(gTextures['instruction_background'], 
        VIRTUAL_WIDTH / 2 - (gTextures['instruction_background']:getWidth() / 2),
        VIRTUAL_HEIGHT / 2 - (gTextures['instruction_background']:getHeight() / 2))
    love.graphics.setFont(gFonts['title'])
    love.graphics.setColor(0.0, 0.0, 0.0, 1.0)
    love.graphics.printf("GAME PAUSED!",  1, VIRTUAL_HEIGHT / 2 - 50 + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
end

function PauseState:update(dt)
    if love.keyboard.isDown('escape') or love.keyboard.isDown('p') then
        gStateMachine:change('play', {
            redBlob = self.redBlob,
            blueBlob = self.blueBlob,
            tiles = self.tiles,
            1
        }) 
    end
end