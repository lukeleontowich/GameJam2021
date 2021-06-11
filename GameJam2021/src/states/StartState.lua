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
    love.graphics.printf('Blobs', 1, VIRTUAL_HEIGHT / 2 - 40 + 1, VIRTUAL_WIDTH, 'center')
    self.blueBlob:render()
    self.redBlob:render()
end