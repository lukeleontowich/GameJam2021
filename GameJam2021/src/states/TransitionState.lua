TransitionState = Class{__includes = BaseState}

function TransitionState:init(params)
end

function TransitionState:enter(params)
    self.redBlob = params.redBlob
    self.blueBlob = params.blueBlob
    self.enemies = params.enemies
    self.tiles = params.tiles
    self.portal = params.portal
    self.pressure_button = params.portal
    self.arrow_button = params.arrow_button
    self.chest_key = params.chest_key
    self.health = params.health
    self.rope = params.rope
    self.lastState = params.lastState
end

function TransitionState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        if self.lastState == 'simon_says' then
            gStateMachine:change('simon_says', {
                redBlob = self.redBlob,
                blueBlob = self.blueBlob,
                enemies = self.enemies,
                tiles = self.tiles,
                portal = self.portal,
                pressure_button = self.pressure_button,
                arrow_button = self.arrow_button,
                chest_key = self.chest_key,
                health = self.health,
                rope = self.rope
            })
        else
            gStateMachine:change('play', {
                redBlob = self.redBlob,
                blueBlob = self.blueBlob,
                enemies = self.enemies,
                tiles = self.tiles,
                portal = self.portal,
                pressure_button = self.pressure_button,
                arrow_button = self.arrow_button,
                chest_key = self.chest_key,
                health = self.health,
                rope = self.rope
            })
        end
    end
end

function TransitionState:render()
    love.graphics.draw(gTextures['background'], 0, 0)
    for tile in pairs(self.tiles) do
        self.tiles[tile]:render()
    end
    local distance = VIRTUAL_WIDTH - 9
    for h = 1, self.health do
        love.graphics.draw(gTextures['heart'], distance, 0)
        distance = distance - 9
    end
    self.portal:render()
    self.pressure_button:render()
    self.arrow_button:render()
    self.chest_key.chest:render() 
    self.rope:render()
    self.redBlob:render()
    self.blueBlob:render()
    if not self.chest_key:isOpened() then
        self.chest_key.key:render()
    end
    for x in pairs(self.enemies) do
        self.enemies[x]:render()
    end

    if self.health > 0 then
        love.graphics.setFont(gFonts['title'])
        love.graphics.setColor(0.1, 1.0, 0.1, 1.0)
        love.graphics.printf('%i lives left', self.health, VIRTUAL_HEIGHT / 2 - 40 + 1, VIRTUAL_WIDTH, 'center')
        love.graphics.setColor(1, 1, 1, 1)
    else
        gStateMachine:change('game_over', {
            redBlob = self.redBlob,
            blueBlob = self.blueBlob,
            enemies = self.enemies,
            tiles = self.tiles,
            portal = self.portal,
            pressure_button = self.pressure_button,
            arrow_button = self.arrow_button,
            chest_key = self.chest_key,
            health = self.health,
            rope = self.rope
        })
    end
end