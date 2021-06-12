PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.tiles = LevelMaker.generate(VIRTUAL_WIDTH, VIRTUAL_HEIGHT) 
    self.chest_key = ChestKey( 
        {chest = Chest({x = VIRTUAL_WIDTH / 4, y = VIRTUAL_HEIGHT / 4}),
        key_x = 3 * VIRTUAL_WIDTH / 4,
        key_y = 3 * VIRTUAL_HEIGHT / 4}
    )
    self.portal = Portal({
        left_x = 20,
        left_y = 20,
        right_x = VIRTUAL_WIDTH - 40,
        left_y = 20
    })
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

    --check for enemy collisions
    for enemy in pairs(self.enemies) do
        if self.enemies[enemy]:collides(self.redBlob) and not self.enemies[enemy].isDead then
            gSounds['enemy_death']:play()
            self.enemies[enemy].isDead = true
            self.enemies[enemy].timer = 0
        elseif self.enemies[enemy]:hurt(self.redBlob) then
            gSounds['hurt']:play()
        end
    end

    for enemy in pairs(self.enemies) do
        if self.enemies[enemy]:collides(self.blueBlob) and not self.enemies[enemy].isDead then
            gSounds['enemy_death']:play()
            self.enemies[enemy].isDead = true
            self.enemies[enemy].timer = 0
        elseif self.enemies[enemy]:hurt(self.blueBlob) then
            gSounds['hurt']:play()
        end
        if not self.enemies[enemy].exists then
            table.remove(self.enemies, enemy)
        end
    end

    for enemy in pairs(self.enemies) do
        for enemy2 in pairs(self.enemies) do
            if self.enemies[enemy].x < self.enemies[enemy2].x + self.enemies[enemy2].width 
            and self.enemies[enemy].x > self.enemies[enemy2].x then
                self.enemies[enemy].x = self.enemies[enemy].x + self.enemies[enemy].dx
            elseif self.enemies[enemy].y < self.enemies[enemy2].y + self.enemies[enemy2].height
            and self.enemies[enemy].y > self.enemies[enemy2].y then
                self.enemies[enemy].y = self.enemies[enemy].y + self.enemies[enemy].dy
            end
        end
    end

    if not self.chest_key:isOpened() then
        if self.chest_key:hasKey(self.blueBlob) then
            self.chest_key:openingChest(self.blueBlob)
        elseif self.chest_key:hasKey(self.redBlob) then
            self.chest_key:openingChest(self.redBlob)
        end
    end

    --if not self.chest_key.portaled then
      --  self.portal:collides(self.chest_key)

end

function PlayState:render()
    love.graphics.draw(gTextures['background'], 0, 0)
    for tile in pairs(self.tiles) do
        self.tiles[tile]:render()
    end
    self.portal:render()
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
    self.enemies = EnemySpawner.generate(self.redBlob, self.blueBlob)
end