PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.tiles = LevelMaker.generate(VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
end

function PlayState:update(dt)
    self.redBlob:update(dt)
    self.blueBlob:update(dt)
    self.rope:update(dt)

    -- check for tile collisions
    for tile in pairs(self.tiles) do
        if self.tiles[tile]:collides(self.redBlob) then
            gSounds['collision']:play()
        end
    end

    for tile in pairs(self.tiles) do
        if self.tiles[tile]:collides(self.blueBlob) then
            gSounds['collision']:play()
        end
    end
end

function PlayState:render()
    love.graphics.draw(gTextures['background'], 0, 0)
    for tile in pairs(self.tiles) do
        self.tiles[tile]:render()
    end
    self.rope:render()
    self.redBlob:render()
    self.blueBlob:render()
    
end

function PlayState:enter(params)
    self.redBlob = params.redBlob
    self.blueBlob = params.blueBlob
    self.blueBlob.x = VIRTUAL_WIDTH / 2 + 24
    self.redBlob.x = VIRTUAL_WIDTH / 2 - 40   
    self.rope = Rope({
        blueBlob = self.blueBlob,
        redBlob = self.redBlob
    })
end