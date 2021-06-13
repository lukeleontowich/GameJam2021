StartState = Class{__includes = BaseState}

local highlighted = 1

function StartState:init()
    self.blueBlob = Blob({
        x = (VIRTUAL_WIDTH / 2) - 48, 
        y = VIRTUAL_HEIGHT - 40,
        color = 2
    })
    self.redBlob = Blob({
        x = (VIRTUAL_WIDTH / 2) + 16, 
        y = VIRTUAL_HEIGHT - 40,
        color = 1
    })
    self.blueBlob.sx = 1
    self.blueBlob.sy = 1
    self.redBlob.sx = 1
    self.redBlob.sy = 1
end

function StartState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    
    -- toggle highlighted option if we press an arrow key up or down
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        highlighted = highlighted == 1 and 2 or 1
        gSounds['collision']:play()
    end
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gSounds['select']:play()

        if highlighted == 1 then
            gStateMachine:change('play', {
                redBlob = self.redBlob,
                blueBlob = self.blueBlob
            }) 
        else
            gStateMachine:change('instruction') 
        end   
    end
end

function StartState:render()
    love.graphics.draw(gTextures['background'], 0, 0)
    love.graphics.setFont(gFonts['title'])
    love.graphics.setColor(0.1, 1.0, 0.1, 1.0)
    love.graphics.printf('Blobs', 1, VIRTUAL_HEIGHT / 2 - 40 + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['menu'])

    -- if we're highlighting 1, render that option blue
    if highlighted == 1 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.printf("START", 0, VIRTUAL_HEIGHT / 2 + 2,
        VIRTUAL_WIDTH, 'center')

    -- reset the color
    love.graphics.setColor(1, 1, 1, 1)

    -- render option 2 blue if we're highlighting that one
    if highlighted == 2 then
        love.graphics.setColor(103/255, 1, 1, 1)
    else
        love.graphics.setColor(0.1, 1.0, 0.1, 1.0)
    end
    love.graphics.printf("INSTRUCTIONS", 0, VIRTUAL_HEIGHT / 2 + 20,
        VIRTUAL_WIDTH, 'center')

    -- reset the color
    love.graphics.setColor(1, 1, 1, 1)

    self.blueBlob:render()
    self.redBlob:render()
end