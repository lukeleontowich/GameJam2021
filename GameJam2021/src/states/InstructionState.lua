InstructionState = Class{__includes = BaseState}

function InstructionState:init()

end

function InstructionState:update(dt)
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('start')
    end 
end

function InstructionState:render()
    love.graphics.draw(gTextures['background'], 0, 0)
    love.graphics.draw(gTextures['instruction_background'], 
        VIRTUAL_WIDTH / 2 - (gTextures['instruction_background']:getWidth() / 2),
        VIRTUAL_HEIGHT / 2 - (gTextures['instruction_background']:getHeight() / 2)
    )
    love.graphics.setFont(gFonts['menu'])
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.printf('Instructions', 1, VIRTUAL_HEIGHT / 2 - 60 + 1, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('The main objective of the game is to solve all the problems', 1, VIRTUAL_HEIGHT / 2 - 50 + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('in each level. Once all problems have been cleared,', 1, VIRTUAL_HEIGHT / 2 - 40 + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('the wall in the middle is removed and the two blobs are reunited.', 1, VIRTUAL_HEIGHT / 2 - 30 + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)

    local x = VIRTUAL_WIDTH / 2
    theta = 3 * math.pi / 2.0
    x = x - 16
    love.graphics.draw(gTextures['button_base'], 40, VIRTUAL_HEIGHT / 2 - 3, theta, 1, 1)
    love.graphics.setColor(1, 0.1, 0.1, 1)
    love.graphics.draw(gTextures['pressure_button'], 33, VIRTUAL_HEIGHT / 2 - 4, theta, 1, 1)
    love.graphics.setColor(0, 0, 0, 1.0)

    love.graphics.printf('These buttons only activate when', 1, VIRTUAL_HEIGHT / 2 - 20, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('hit with a certain velocity.', 1, VIRTUAL_HEIGHT / 2 - 15, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.draw(gTextures['chest'], 33, VIRTUAL_HEIGHT / 2)

    love.graphics.setColor(0, 0, 0, 1.0)
    love.graphics.printf('The chest only opens when the', 1, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('blob opening it holds the key.', 1, VIRTUAL_HEIGHT / 2 + 5, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.draw(gTextures['portal_tile'], 33, VIRTUAL_HEIGHT / 2 + 20)
    love.graphics.setColor(0, 0, 0, 1.0)
    love.graphics.printf('The portals can move objects and', 1, VIRTUAL_HEIGHT / 2 + 20, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('enemies to the other side.', 1, VIRTUAL_HEIGHT / 2 + 25, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.draw(gTextures['red_blob_still'], 28, VIRTUAL_HEIGHT / 2 + 40, 0, 0.4, 0.4)
    love.graphics.draw(gTextures['blue_blob_still'], 38, VIRTUAL_HEIGHT / 2 + 40, 0, 0.4, 0.4)
    love.graphics.setColor(0, 0, 0, 1.0)
    love.graphics.printf('Red Blob Controls = w a s d', 1, VIRTUAL_HEIGHT / 2 + 40, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Blue Blob Controls = arrow keys', 1, VIRTUAL_HEIGHT / 2 + 45, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['menu'])
    love.graphics.printf('Press escape to return to main menu', 1, VIRTUAL_HEIGHT / 2 + 55, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)
end