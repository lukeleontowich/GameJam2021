PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.tiles = LevelMaker.generate(VIRTUAL_WIDTH, VIRTUAL_HEIGHT) 
    self.chest_key = ChestKey( 
        {chest = Chest({x = VIRTUAL_WIDTH / 4, y = VIRTUAL_HEIGHT / 4}),
        key = Key({x = 3 * VIRTUAL_WIDTH / 4, y = 3 * VIRTUAL_HEIGHT / 4})}
    )
    self.portal = Portal({
        left_x = 20,
        left_y = 20,
        right_x = VIRTUAL_WIDTH - 40,
        right_y = 20
    })

    self.health = 3
end

function PlayState:update(dt)
    self.redBlob:update(dt)
    self.blueBlob:update(dt)
    self.rope:update(dt)
    for x in pairs(self.enemies) do
        self.enemies[x]:update(dt)
    end

    --check for enemy collisions
    for enemy in pairs(self.enemies) do
        if self.enemies[enemy]:collides(self.redBlob) and not self.enemies[enemy].isDead then
            gSounds['enemy_death']:play()
            self.enemies[enemy].isDead = true
            self.enemies[enemy].timer = 0
        elseif self.enemies[enemy]:hurt(self.redBlob) then
            gSounds['hurt']:play()
            self.health = self.health - 1
        end
    end

    for enemy in pairs(self.enemies) do
        if self.enemies[enemy]:collides(self.blueBlob) and not self.enemies[enemy].isDead then
            gSounds['enemy_death']:play()
            self.enemies[enemy].isDead = true
            self.enemies[enemy].timer = 0
        elseif self.enemies[enemy]:hurt(self.blueBlob) then
            gSounds['hurt']:play()
            self.health = self.health - 1
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

    --  Check if chest is opened and if the blobs have the key
    if not self.chest_key:isOpened() then
        if self.chest_key:hasKey(self.blueBlob) then
            self.chest_key:openingChest(self.blueBlob)
        elseif self.chest_key:hasKey(self.redBlob) then
            self.chest_key:openingChest(self.redBlob)
        end
    end

    --  See if the key is in the portal and if so send it
    if self.portal:collides(self.chest_key.key) and not self.chest_key.portaled then
        self.blueBlob.has_key = false
        self.redBlob.has_key = false
    end

    --  Check if an enemy is in a portal then send it
    for enemy in pairs(self.enemies) do
        if not self.enemies[enemy].portaled then 
            if self.portal:collides(self.enemies[enemy]) then
                self.enemies[enemy].portaled = true
                if self.enemies[enemy].side == 1 then
                    print("here")
                    self.enemies[enemy].side = 2 
                    print("enemy side:", self.enemies[enemy].side)
                elseif self.enemies[enemy].side == 2 then
                    print("shoudln't be here")
                    self.enemies[enemy].side = 1
                end
            end
        end
    end
    for enemy in pairs(self.enemies) do
        --print("e1 side: ", self.enemies[enemy].side)
    end

end

function PlayState:render()
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
    self.chest_key:render() 
    self.rope:render()
    self.redBlob:render()
    self.blueBlob:render()
    for x in pairs(self.enemies) do
        self.enemies[x]:render()
    end
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