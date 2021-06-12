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

    self.pressure_button = Button({
        x = 0, 
        y = VIRTUAL_HEIGHT - 14, 
        type = 1 
    })

    self.arrow_button = Button({
        x = 30,
        y = VIRTUAL_HEIGHT - 14,
        type = 2
    })

    self.health = 3

    self.pbutton1 = PressureButton({y = 20, side = 1})
    self.pbutton2 = PressureButton({y = 50, side = 2})
end

function PlayState:update(dt)
    self.redBlob:update(dt)
    self.blueBlob:update(dt)
    local vel_left, vel_right = self.rope:update(dt)
    --  TAKE THIS OUT LATER
    if vel_left > 0 then
        print("vel_left: ", vel_left)
    end
    if vel_right > 0 then
        print("vel_right: ", vel_right)
    end

    self.pbutton1:update(vel_left, vel_right, self.redBlob, self.blueBlob)
    self.pbutton2:update(vel_left, vel_right, self.redBlob, self.blueBlob)
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
                self.enemies[enemy].timer = 0
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

    if self.arrow_button:collides(self.redBlob) or self.arrow_button:collides(self.blueBlob) then
        if not self.arrow_button.pressed_sound_played then
            gSounds['button_push']:play()
            self.arrow_button.pressed_sound_played = true
        end
        self.arrow_button.arrow_button_pressed = true
    
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
    self.pressure_button:render()
    self.pbutton1:render()
    self.pbutton2:render()
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

    self.level = Level{
        chest_keys = {
            ChestKey({
                chest = Chest({x = VIRTUAL_WIDTH / 4, y = VIRTUAL_HEIGHT / 4}),
                key = Key({x = 3 * VIRTUAL_WIDTH / 4, y = 3 * VIRTUAL_HEIGHT / 4})
            })
        },
        portals = {
            Portal({
                left_x = 20,
                left_y = 20,
                right_x = VIRTUAL_WIDTH - 40,
                right_y = 20
            })
        },
        pressure_buttons = {
            PressureButton({y = 20, side = 1}),
            PressureButton({y = 50, side = 2})
        },
        buttons = {
            Button({x = 30,y = VIRTUAL_HEIGHT - 14,type = 2})
        },
        enemies = {
            Enemy({x = 5, y = 50, color = 1, redBlob = red, blueBlob = blue}),
            Enemy({x = 30, y = 50, color = 2, redBlob = red, blueBlob = blue})
        }
    }
    self.enemies = level.enemies
end