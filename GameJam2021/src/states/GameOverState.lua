GameOverState = Class{__includes = BaseState}

function GameOverState:init()
end

function GameOverState:enter(params)
    self.redBlob = params.redBlob
    self.blueBlob = params.blueBlob
    self.enemies = params.enemies
    self.tiles = params.tiles
    self.level = params.level
    self.health = params.health
    self.rope = params.rope
end

function GameOverState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play', {
            redBlob = self.redBlob,
            blueBlob = self.blueBlob,
            enemies = self.enemies,
            tiles = self.tiles,
            level = self.level,
            health = self.health,
            rope = self.rope
        })
    end
end

function GameOverState:render()
    love.graphics.draw(gTextures['background'], 0, 0)
    for tile in pairs(self.tiles) do
        self.tiles[tile]:render()
    end
    local distance = VIRTUAL_WIDTH - 9
    for h = 1, self.health do
        love.graphics.draw(gTextures['heart'], distance, 0)
        distance = distance - 9
    end
    self.level.portal:render()

    self.rope:render()
    self.redBlob:render()
    self.blueBlob:render()
    for x in pairs(self.level.chest_keys) do 
        if not self.level.chest_keys[x]:isOpened() then
            self.level.chest_keys[x].key:render()
        end
    end

    --  render enemies
    for x in pairs(self.level.enemies) do
        self.level.enemies[x]:render()
    end

    love.graphics.setFont(gFonts['title'])
    love.graphics.setColor(1, 0.1, 0.1, 1.0)
    love.graphics.printf('GAME OVER', self.health, VIRTUAL_HEIGHT / 2 - 40 + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)
end