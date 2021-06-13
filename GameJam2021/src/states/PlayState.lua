PlayState = Class{__includes = BaseState}



function PlayState:init()
    self.tiles = LevelMaker.generateTiles(VIRTUAL_WIDTH, VIRTUAL_HEIGHT) 
    self.level_over = false
    self.game_over = false
    self.level_timer = 0
    self.game_timer = 0
end

------------------------------------------------------
---  UPDATE  -----------------------------------------
------------------------------------------------------
function PlayState:update(dt)
    --  update the timer
    if not self.level_over then
        self.level_timer = self.level_timer + dt
        self.game_timer = self.game_timer + dt
    end

    --  Check if escape is pressed
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    --  Check for a pause in the game
    self:pause()

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
    self:enemyCollision(self.redBlob)
    self:enemyCollision(self.blueBlob)
    for enemy in pairs(self.level.enemies) do
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
            end
        end
    end

    --  check to see if the level is over
    if self:levelIsOver() then
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

    if self.level_over  and not self.game_over then
        love.graphics.draw(gTextures['instruction_background'], 
        VIRTUAL_WIDTH / 2 - (gTextures['instruction_background']:getWidth() / 2),
        VIRTUAL_HEIGHT / 2 - (gTextures['instruction_background']:getHeight() / 2))
        love.graphics.setFont(gFonts['title'])
        love.graphics.setColor(0.0, 0.0, 0.0, 1.0)
        love.graphics.printf("LEVEL COMPLETE!",  1, VIRTUAL_HEIGHT / 2 - 50 + 1, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('PRESS ENTER TO CONTINUE', 
                            1, VIRTUAL_HEIGHT / 2 - 20 + 1, VIRTUAL_WIDTH, 'center')
        love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
    end
    if self.game_over then
        love.graphics.draw(gTextures['instruction_background'], 
        VIRTUAL_WIDTH / 2 - (gTextures['instruction_background']:getWidth() / 2),
        VIRTUAL_HEIGHT / 2 - (gTextures['instruction_background']:getHeight() / 2))
        love.graphics.setFont(gFonts['title'])
        love.graphics.setColor(0.0, 0.0, 0.0, 1.0)
        love.graphics.printf("YOU WIN!",  1, VIRTUAL_HEIGHT / 2 - 50 + 1, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(gFonts['small'])
        local timer_display = 'Time: ' .. math.floor(self.game_timer)
        love.graphics.printf(timer_display, 1, VIRTUAL_HEIGHT / 2 + 1, VIRTUAL_WIDTH, 'center')
        love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
    end
    
    --  diplay timers
     -- Print a counter clock
  love.graphics.setFont(gFonts['small'])
  local timer_display = 'Time: ' .. math.floor(self.level_timer)
  love.graphics.printf(timer_display, 1, 1, 100, 'left')
end


-----------------------------------------------------------------
---  ENTER  -----------------------------------------------------
-----------------------------------------------------------------
function PlayState:enter(params)
    self.redBlob = params.redBlob
    self.blueBlob = params.blueBlob
    --self.blueBlob.x = VIRTUAL_WIDTH / 2 + 24
    self.blueBlob.sx = 0.4
    self.blueBlob.sy = 0.4 
    --self.redBlob.x = VIRTUAL_WIDTH / 2 - 40 
    self.redBlob.sx = 0.4
    self.redBlob.sy = 0.4 
    if params.lastState == 'transition' or params.lastState == 'pause' then
        self.rope = params.rope
        self.level_timer = params.level_timer
        self.game_timer = params.game_timer
    else
        self.rope = Rope({
            blueBlob = self.blueBlob,
            redBlob = self.redBlob
        })
    end

    self.health = params.health
    
    self.levels = LevelMaker.generateLevels(self.redBlob, self.blueBlob)
    
    if params.lastState == 'transition' or params.lastState == 'pause' then
        self.level = params.level
        self.level_cntr = params.level_cntr
    else
        self.level = self.levels[1]
        self.level_cntr = 1
    end
    --self.enemies = self.levels.enemies

end

function PlayState:nextLevel()
    if love.keyboard.isDown('return') then
        self.level_timer = 0
        --  resest blob positions
        self.blueBlob.x = VIRTUAL_WIDTH / 2 + 16
        self.blueBlob.y = VIRTUAL_HEIGHT / 2
        self.redBlob.x = VIRTUAL_WIDTH /2 - 48
        self.blueBlob.y = VIRTUAL_HEIGHT / 2
        if self.level_cntr >= #self.levels then
            self.game_over = true
        else
            self.level_cntr = self.level_cntr + 1
            self.health = 3
            self.level_over = false
            self.level = self.levels[self.level_cntr]
            self.blueBlob.has_key = false
            self.redBlob.has_key = false
        end
    end
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
        level_cntr = self.level_cntr,
        level_timer = self.level_timer,
        game_timer = self.game_timer,
        lastState = 'play'
    })
end

function PlayState:levelIsOver()
    --  check if all enemies are dead
    for x in pairs(self.level.enemies) do 
        if not self.level.enemies[x].isDead then
            return false
        end
    end
    --  Check that all chests have been opened
    for x in pairs(self.level.chest_keys) do
        if not self.level.chest_keys[x]:isOpened() then
            return false
        end
    end
    --  Check that all pressure buttons are pressed
    for x in pairs(self.level.pressure_buttons) do
        if not self.level.pressure_buttons[x].hit then
            return false
        end
    end
    return true
end

function PlayState:enemyCollision(target)
    for enemy in pairs(self.level.enemies) do
        if self.level.enemies[enemy]:collides(target) and not self.level.enemies[enemy].isDead then
            gSounds['enemy_death']:play()
            self.level.enemies[enemy].isDead = true
            self.level.enemies[enemy].timer = 0
        elseif self.level.enemies[enemy]:hurt(target) then
            gSounds['hurt']:play()
            self:loseHeart()
            for s in pairs(self.level.enemies) do
                self.level.enemies[s].x = self.level.enemies[s].originalX
                self.level.enemies[s].y = self.level.enemies[s].originalY
            end
        end
    end
end

function PlayState:pause()
    if love.keyboard.isDown('p') then
        gStateMachine:change('pause', {
            redBlob = self.redBlob,
            blueBlob = self.blueBlob,
            enemies = self.enemies,
            tiles = self.tiles,
            health = self.health - 1,
            rope = self.rope,
            level = self.level,
            level_cntr = self.level_cntr,
            game_timer = self.game_timer,
            level_timer = self.level_timer
        })
    end
end
