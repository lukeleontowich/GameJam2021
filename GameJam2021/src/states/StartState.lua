StartState = Class{__includes = BaseState}

function StartState:init()
    self.blueBlob = Blob({
        x = (VIRTUAL_WIDTH / 2) - 48, 
        y = VIRTUAL_HEIGHT - 32,
        color = 2
    })
    self.redBlob = Blob({
        x = (VIRTUAL_WIDTH / 2) + 16, 
        y = VIRTUAL_HEIGHT - 32,
        color = 1
    })
end

function StartState:render()
    love.graphics.draw(gTextures['background'], 0, 0)
    love.graphics.setFont(gFonts['title'])
    love.graphics.setColor(0.1, 1.0, 0.1, 1.0)
    love.graphics.printf('Blobs', 1, VIRTUAL_HEIGHT / 2 - 40 + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)
    self.blueBlob:render()
    self.redBlob:render()
end

function StartState:update() 
    if love.keyboard.keypressed() and not love.keyboard.keypress() then
        love.event.quit()
    end
end
