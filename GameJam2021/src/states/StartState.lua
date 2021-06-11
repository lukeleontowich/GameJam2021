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

    love.graphics.setColor(0.1, 1.0, 0.1, 1.0)
    love.graphics.printf("Welcome!", 
    0, VIRTUAL_HEIGHT / 2 - 48, VIRTUAL_WIDTH, 'center')
    love.graphics.printf("Press Any Key to Continue", 0, VIRTUAL_HEIGHT / 2 - 24, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(self.color)
    love.graphics.draw(gTextures['background'], 0, 0)
    love.graphics.setFont(gFonts['title'])
    love.graphics.printf('Blobs', 1, VIRTUAL_HEIGHT / 2 - 40 + 1, VIRTUAL_WIDTH, 'center')
    self.blueBlob:render()
    self.redBlob:render()
end
