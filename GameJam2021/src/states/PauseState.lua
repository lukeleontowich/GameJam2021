PauseState = Class{__includes = BaseState}

function PauseState:init()
end

function PauseState:enter(params)
    self.redBlob = params.redBlob
    self.blueBlob = params.blueBlob
    self.enemies = params.enemies
    self.tiles = params.tiles
    self.health = params.health
    self.level = params.level
    self.level_cntr = params.level_cntr
    self.rope = params.rope
    self.level_timer = params.level_timer
    self.game_timer = params.game_timer
end

function PauseState:render() 
    love.graphics.draw(gTextures['instruction_background'], 
        VIRTUAL_WIDTH / 2 - (gTextures['instruction_background']:getWidth() / 2),
        VIRTUAL_HEIGHT / 2 - (gTextures['instruction_background']:getHeight() / 2))
    love.graphics.setFont(gFonts['title'])
    love.graphics.setColor(0.0, 0.0, 0.0, 1.0)
    love.graphics.printf("GAME PAUSED!",  1, VIRTUAL_HEIGHT / 2 - 50 + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('PRESS ESC TO CONTINUE', 
                            1, VIRTUAL_HEIGHT / 2 - 20 + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
end

function PauseState:update(dt)
    if love.keyboard.isDown('escape') then
        gStateMachine:change('play', {
            redBlob = self.redBlob,
            blueBlob = self.blueBlob,
            enemies = self.enemies,
            tiles = self.tiles,
            health = self.health - 1,
            rope = self.rope,
            level = self.level,
            level_cntr = self.level_cntr,
            lastState = 'pause',
            level_timer = self.level_timer,
            game_timer = self.game_timer
        }) 
    end
end