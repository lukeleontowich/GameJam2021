--  main.lua
require 'src/Dependencies'

function love.load()
    love.window.setTitle('Blobs')

    math.randomseed(os.time())
    
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true,
        canvas = false
    })

    gStateMachine = StateMachine {
        ['start'] = function() return StartState() end,
        ['instruction'] = function() return InstructionState() end,
        ['play'] = function() return PlayState() end,
        ['simon_says'] = function() return SimonSaysState() end,
        ['pause'] = function() return PauseState() end,
        ['transition'] = function() return TransitionState() end,
        ['game_over'] = function() return GameOverState() end
    }
    gStateMachine:change('start')

    gSounds['music']:setLooping(true)
    gSounds['music']:play()

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.draw()
    push:start()
    gStateMachine:render()
    push:finish()
end
