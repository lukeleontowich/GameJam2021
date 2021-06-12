PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.tiles = LevelMaker.generate(VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    self.enemies = EnemySpawner.generate()
    self.chest_key = ChestKey( 
        {chest_x = VIRTUAL_WIDTH / 4,
        chest_y = VIRTUAL_HEIGHT / 4,
        key_x = 3 * VIRTUAL_WIDTH / 4,
        key_y = 3 * VIRTUAL_HEIGHT / 4}
    )
end

function PlayState:update(dt)
    self.redBlob:update(dt)
    self.blueBlob:update(dt)
    self.rope:update(dt)
    for x in pairs(self.enemies) do
        self.enemies[x]:update(dt)
    end

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
    if not self.chest_key:isOpened() then
        if self.chest_key:hasKey(self.blueBlob) then
            self.chest_key:openingChest(self.blueBlob)
        elseif self.chest_key:hasKey(self.redBlob) then
            self.chest_key:openingChest(self.redBlob)
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
    for x in pairs(self.enemies) do
        self.enemies[x]:render()
    end
    self.chest_key:render() 
end

function PlayState:enter(params)
    self.redBlob = params.redBlob
    self.blueBlob = params.blueBlob
    self.blueBlob.x = VIRTUAL_WIDTH / 2 + 24
    self.blueBlob.sx = 0.4
    self.blueBlob.sy = 0.4 
    self.redBlob.x = VIRTUAL_WIDTH / 2 - 40 
    self.redBlob.sx = 0.4
    self.redBlob.sy = 0.4 
    self.rope = Rope({
        blueBlob = self.blueBlob,
        redBlob = self.redBlob
    })
end