PlayState = Class{__includes = BaseState}



function PlayState:init()
    self.tiles = LevelMaker.generate(VIRTUAL_WIDTH, VIRTUAL_HEIGHT) 
--[[
    self.arrow_button = Button({
        x = 30,
        y = VIRTUAL_HEIGHT - 14,
        type = 2
    })
]]
    self.health = 3
    self.level_over = false
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    --  Update the Blobs
    self.redBlob:update(dt)
    self.blueBlob:update(dt)

    --  Get the velocity of the rope (needed for the push buttons)
    local vel_left, vel_right = self.rope:update(dt)

    --  update the pressure buttons
    for button in pairs(self.level.pressure_buttons) do 
        self.level.pressure_buttons[button]:update(vel_left, vel_right, self.redBlob, self.blueBlob)
    end

    
    --  Update Enemy positions
    for x in pairs(self.level.enemies) do
        self.level.enemies[x]:update(dt)
    end

    --check for enemy collisions
    for enemy in pairs(self.level.enemies) do
        if self.level.enemies[enemy]:collides(self.redBlob) and not self.level.enemies[enemy].isDead then
            gSounds['enemy_death']:play()
            self.level.enemies[enemy].isDead = true
            self.level.enemies[enemy].timer = 0
        elseif self.level.enemies[enemy]:hurt(self.redBlob) then
            gSounds['hurt']:play()
            self:loseHeart()
        end
    end

    for enemy in pairs(self.level.enemies) do
        if self.level.enemies[enemy]:collides(self.blueBlob) and not self.level.enemies[enemy].isDead then
            gSounds['enemy_death']:play()
            self.level.enemies[enemy].isDead = true
            self.level.enemies[enemy].timer = 0
        elseif self.level.enemies[enemy]:hurt(self.blueBlob) then
            gSounds['hurt']:play()
            self:loseHeart()
        end
        if not self.level.enemies[enemy].exists then
            table.remove(self.level.enemies, enemy)
        end
    end

    for enemy in pairs(self.level.enemies) do
        for enemy2 in pairs(self.level.enemies) do
            if self.level.enemies[enemy].x < self.level.enemies[enemy2].x + self.level.enemies[enemy2].width 
            and self.level.enemies[enemy].x > self.level.enemies[enemy2].x then
                self.level.enemies[enemy].x = self.level.enemies[enemy].x + self.level.enemies[enemy].dx
            elseif self.level.enemies[enemy].y < self.level.enemies[enemy2].y + self.level.enemies[enemy2].height
            and self.level.enemies[enemy].y > self.level.enemies[enemy2].y then
                self.level.enemies[enemy].y = self.level.enemies[enemy].y + self.level.enemies[enemy].dy
            end
        end
    end

    --  Check if chests are opened and if the blobs have the key
    for x in pairs(self.level.chest_keys) do
        if not self.level.chest_keys[x]:isOpened() then
            if self.level.chest_keys[x]:hasKey(self.blueBlob) then
                self.level.chest_keys[x]:openingChest(self.blueBlob)
            elseif self.level.chest_keys[x]:hasKey(self.redBlob) then
                self.level.chest_keys[x]:openingChest(self.redBlob)
            end
        end
    end

    --  See if the key is in the portal and if so send it
    --  There will be an error rn for muliple cchest_keys
    for x in pairs(self.level.chest_keys) do
        if self.level.portal:collides(self.level.chest_keys[x].key) and not self.level.chest_keys[x].portaled then
            self.blueBlob.has_key = false
            self.redBlob.has_key = false
        end
    end

    --  Check if an enemy is in a portal then send it
    for enemy in pairs(self.level.enemies) do
        if not self.level.enemies[enemy].portaled then 
            if self.level.portal:collides(self.level.enemies[enemy]) then
                self.level.enemies[enemy].portaled = true
                self.level.enemies[enemy].timer = 0
                if self.level.enemies[enemy].side == 1 then
                    print("here")
                    self.level.enemies[enemy].side = 2 
                    print("enemy side:", self.level.enemies[enemy].side)
                elseif self.level.enemies[enemy].side == 2 then
                    print("shouldn't be here")
                    self.level.enemies[enemy].side = 1
                end
            end
        end
    end
--[[
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
]]
    --  check to see if the level is over
    --  check if all enemies are dead
    local is_over = true
    for x in pairs(self.level.enemies) do 
        if not self.level.enemies[x].isDead then
            is_over = false
        end
    end
    --  Check that all chested have been over
    for x in pairs(self.level.chest_keys) do
        if not self.level.chest_keys[x]:isOpened() then
            is_over = false
        end
    end
    --  Check that all pressure buttons are pressed
    for x in pairs(self.level.pressure_buttons) do
        if not self.level.pressure_buttons[x].hit then
            is_over = false
        end
    end
    if is_over then
        self.level_over = true
    end
    if self.level_over then
        self:nextLevel()
    end
            
end

---------------------------------------------------
--  RENDER  ---------------------------------------
---------------------------------------------------
function PlayState:render()
    --  render backgrou9ns
    love.graphics.draw(gTextures['background'], 0, 0)
    for tile in pairs(self.tiles) do
        self.tiles[tile]:render()
    end

    -- render hearts
    local distance = VIRTUAL_WIDTH - 9
    for h = 1, self.health do
        love.graphics.draw(gTextures['heart'], distance, 0)
        distance = distance - 9
    end

    --  render portal
    self.level.portal:render()

    --  render pressure buttons
    for x in pairs(self.level.pressure_buttons) do
        self.level.pressure_buttons[x]:render()
    end


    --self.arrow_button:render()

    --  render chests
    for x in pairs(self.level.chest_keys) do
        self.level.chest_keys[x].chest:render() 
    end

    --  render rope
    self.rope:render()

    --  render blobs
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
    
    self.levels = {
    --[[self.level0 = ]]{
        chest_keys = {
            ChestKey({
                chest = Chest({x = VIRTUAL_WIDTH / 4, y = VIRTUAL_HEIGHT / 4}),
                key = Key({x = 3 * VIRTUAL_WIDTH / 4, y = 3 * VIRTUAL_HEIGHT / 4})
            })
        },
        portal = Portal({
                left_x = 20,
                left_y = 20,
                right_x = VIRTUAL_WIDTH - 40,
                right_y = 20
        }),
        pressure_buttons = {},
        buttons = {},
        enemies = {}
    },

    --[[self.level1 = ]]{
        chest_keys = {},
        portal = Portal({
            left_x = -100,
            left_y = -100,
            right_x = -100,
            right_y = -100
    }),
        pressure_buttons = {
            PressureButton({y = 20, side = 1}),
            PressureButton({y = 50, side = 2})
        },
        buttons = {},
        enemies = {}
    },

    --[[self.level2 = ]]{
        chest_keys = {},
        portal = Portal({
                left_x = 20,
                left_y = 20,
                right_x = VIRTUAL_WIDTH - 40,
                right_y = 20
        }),
        pressure_buttons = {},
        buttons = {},
        enemies = {
            Enemy({x = 5, y = 50, color = 1, redBlob = self.redBlob, blueBlob = self.blueBlob}),
            Enemy({x = 30, y = 50, color = 2, redBlob = self.redBlob, blueBlob = self.blueBlob})
        }
    },

    --[[self.level3 = ]]{
        chest_keys = {
            ChestKey({
                chest = Chest({x = VIRTUAL_WIDTH / 4, y = VIRTUAL_HEIGHT / 4}),
                key = Key({x = 3 * VIRTUAL_WIDTH / 4, y = 3 * VIRTUAL_HEIGHT / 4})
            })
        },
        portal = Portal({
                left_x = 20,
                left_y = 20,
                right_x = VIRTUAL_WIDTH - 40,
                right_y = 20
        }),
        pressure_buttons = {
            PressureButton({y = 20, side = 1}),
            PressureButton({y = 50, side = 2})
        },
        buttons = {
            Button({x = 30,y = VIRTUAL_HEIGHT - 14,type = 2})
        },
        enemies = {
            Enemy({x = 5, y = 50, color = 1, redBlob = self.redBlob, blueBlob = self.blueBlob}),
            Enemy({x = 30, y = 50, color = 2, redBlob = self.redBlob, blueBlob = self.blueBlob})
        }
    },

    --[[self.level4 = ]]{
        chest_keys = {
            ChestKey({
                chest = Chest({x = 20, y = VIRTUAL_HEIGHT - 30}),
                key = Key({x = VIRTUAL_WIDTH - 20, y = 50})
            })
        },
        portal = Portal({
                left_x = 20,
                left_y = 20,
                right_x = VIRTUAL_WIDTH - 40,
                right_y = 20
        }),
        pressure_buttons = {
            PressureButton({y = 20, side = 1})
        },
        buttons = {},
        enemies = {
            Enemy({x = 5, y = 50, color = 1, redBlob = self.redBlob, blueBlob = self.blueBlob}),
            Enemy({x = 30, y = 50, color = 2, redBlob = self.redBlob, blueBlob = self.blueBlob}),
            Enemy({x = VIRTUAL_WIDTH - 20, y = VIRTUAL_HEIGHT - 40, color = 1, 
                   redBlob = self.redBlob, blueBlob = self.blueBlob})
        }
    },

    --[[self.level5 = ]]{
        chest_keys = {
            ChestKey({
                chest = Chest({x = 50, y = 100}),
                key = Key({x = 190, y = 25})
            })
        },
        portal = Portal({
                left_x = 50,
                left_y = 30,
                right_x = 190,
                right_y = 120
        }),
        pressure_buttons = {
            PressureButton({y = 40, side = 1}),
            PressureButton({y = 60, side = 2}),
            PressureButton({y = 100, side = 1})
        },
        buttons = {},
        enemies = {
            Enemy({x = 10, y = 130, color = 2, redBlob = self.redBlob, blueBlob = self.blueBlob}),
            Enemy({x = 30, y = 130, color = 2, redBlob = self.redBlob, blueBlob = self.blueBlob}),
            Enemy({x = 50, y = 130, color = 2, redBlob = self.redBlob, blueBlob = self.blueBlob}),
            Enemy({x = 160, y = 30, color = 1, redBlob = self.redBlob, blueBlob = self.blueBlob}),
            Enemy({x = 160, y = 30, color = 1, redBlob = self.redBlob, blueBlob = self.blueBlob}),
            Enemy({x = 160, y = 30, color = 1, redBlob = self.redBlob, blueBlob = self.blueBlob})
        }
    }}
    
    

    self.level = self.levels[1]
    self.level_cntr = 1
    --self.enemies = self.levels.enemies

end

function PlayState:nextLevel()
    if love.keyboard.isDown('return') then
        if self.level_cntr >= #self.levels then
            print("GAME OVER")
        else
            self.level_cntr = self.level_cntr + 1
            self.health = 3
            self.level_over = false
            self.level = self.levels[self.level_cntr]
            self.blueBlob.has_key = false
            self.redBlob.has_key = false
        end
    end
<<<<<<< HEAD
end
=======

end

function PlayState:loseHeart()
    gStateMachine:change('transition', {
        redBlob = self.redBlob,
        blueBlob = self.blueBlob,
        enemies = self.enemies,
        tiles = self.tiles,
        health = self.health - 1,
        rope = self.rope,
        level = self.level,
        lastState = 'play'
    })
end
>>>>>>> c5000831db86b7153c9bae67b0ac6da61770a64e
