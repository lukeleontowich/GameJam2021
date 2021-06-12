SimonSaysState = Class{__includes = BaseState}

function SimonSaysState:init()
    self.arrows = {}
    for i = 1, 5 do
        arrow = Arrow({
            x = math.random(VIRTUAL_WIDTH - 20),
            y = 0 + (-20) * i,
            direction = math.random(4)
        })
        table.insert(self.arrows, arrow)
    end
end

function SimonSaysState:enter(params)
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
    self.arrowY = -64
end

function SimonSaysState:update(dt)
    local currentArrow

    for a in pairs(self.arrows) do
        self.arrows[a]:update(dt)
        if self.arrows[a].y > VIRTUAL_HEIGHT - 35 and self.arrows[a].y < VIRTUAL_HEIGHT - 15 then
            currentArrow = self.arrows[a]
        end
    end

    if love.keyboard.wasPressed('up') then
        if not currentArrow == nil then
            if currentArrow.direction == 1 then
                gSounds['up_arrow']:play()
            else
                gSounds['missed_arrow']:play()
            end
        else
            gSounds['missed_arrow']:play()
        end
    elseif love.keyboard.wasPressed('down') then
        if not currentArrow == nil then
            if currentArrow.direction == 2 then
                gSounds['down_arrow']:play()
            else
                gSounds['missed_arrow']:play()
            end
        
        end
    elseif love.keyboard.wasPressed('left') then
        if not currentArrow == nil then
            if currentArrow.direction == 3 then
                gSounds['left_arrow']:play()
            else
                gSounds['missed_arrow']:play()
            end
        end
    else
        if not currentArrow == nil then
            if currentArrow.direction == 4 then
                gSounds['right_arrow']:play()
            else
                gSounds['missed_arrow']:play()
            end
        end
    end
end

function SimonSaysState:render()
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

    --draw arrows at bottom of screen
    love.graphics.setColor(1, 1, 1, 0.5)
    love.graphics.draw(gTextures['up_arrow'], VIRTUAL_WIDTH / 2 - 32, VIRTUAL_HEIGHT - 30)
    love.graphics.draw(gTextures['down_arrow'], VIRTUAL_WIDTH / 2 + 32, VIRTUAL_HEIGHT - 30)
    love.graphics.draw(gTextures['left_arrow'], VIRTUAL_WIDTH / 2 - 64, VIRTUAL_HEIGHT - 30)
    love.graphics.draw(gTextures['right_arrow'], VIRTUAL_WIDTH / 2 + 64, VIRTUAL_HEIGHT - 30)
    love.graphics.setColor(1, 1, 1, 1)
    -- start arrow scrolling
    for a in pairs(self.arrows) do
        self.arrows[a]:render()
    end
end