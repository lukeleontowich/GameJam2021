Class = require 'lib/class'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/Constants'
require 'src/StateMachine'

require 'src/Blob'
require 'src/Enemy'
require 'src/Rope'
require 'src/Tile'
require 'src/ChestKey'
require 'src/Portal'
require 'src/Chest'
require 'src/Key'
require 'src/Button'
require 'src/Arrow'
require 'src/PressureButton'
require 'src/Level'
require 'src/Levels'

-- game states
require 'src/states/BaseState'
require 'src/states/InstructionState'
require 'src/states/PlayState'
require 'src/states/StartState'
require 'src/states/SimonSaysState'
require 'src/states/PauseState'
require 'src/states/TransitionState'
require 'src/states/GameOverState'

require 'src/LevelMaker'
require 'src/EnemySpawner'

gFonts = {
    ['title'] = love.graphics.newFont('fonts/Title.ttf', 32),
    ['menu'] = love.graphics.newFont('fonts/Title.ttf', 12),
    ['small'] = love.graphics.newFont('fonts/arial.ttf', 7)
}

gTextures = {
    ['background'] = love.graphics.newImage('graphics/Background.png'),
    ['tile'] = love.graphics.newImage('graphics/Normal_Tile.png'),
    ['portal_tile'] = love.graphics.newImage('graphics/Portal_Tile.png'),
    ['red_blob_still'] = love.graphics.newImage('graphics/Red_Blob_Still.png'),
    ['red_blob_squishing'] = love.graphics.newImage('graphics/Red_Blob_Squish_1.png'),
    ['red_blob_squished'] = love.graphics.newImage('graphics/Red_Blob_Squish_2.png'),
    ['blue_blob_still'] = love.graphics.newImage('graphics/Blue_Blob_Still.png'),
    ['blue_blob_squishing'] = love.graphics.newImage('graphics/Blue_Blob_Squish_1.png'),
    ['blue_blob_squished'] = love.graphics.newImage('graphics/Blue_Blob_Squish_2.png'),
    ['red_enemy_still'] = love.graphics.newImage('graphics/Red_Enemy_Still.png'),
    ['red_enemy_left'] = love.graphics.newImage('graphics/Red_Enemy_Left.png'),
    ['red_enemy_right'] = love.graphics.newImage('graphics/Red_Enemy_Right.png'),
    ['red_enemy_dead'] = love.graphics.newImage('graphics/Red_Enemy_Dead.png'),
    ['blue_enemy_still'] = love.graphics.newImage('graphics/Blue_Enemy_Still.png'),
    ['blue_enemy_left'] = love.graphics.newImage('graphics/Blue_Enemy_Left.png'),
    ['blue_enemy_right'] = love.graphics.newImage('graphics/Blue_Enemy_Right.png'),
    ['blue_enemy_dead'] = love.graphics.newImage('graphics/Blue_Enemy_Dead.png'),
    ['key'] = love.graphics.newImage('graphics/Key.png'),
    ['chest'] = love.graphics.newImage('graphics/Chest.png'),
    ['chest_open'] = love.graphics.newImage('graphics/Chest_Open.png'),
    ['heart'] = love.graphics.newImage('graphics/Heart.png'),
    ['pressure_button'] = love.graphics.newImage('graphics/Pressure_Button.png'),
    ['button_base'] = love.graphics.newImage('graphics/Button_Base.png'),
    ['arrow_button'] = love.graphics.newImage('graphics/Arrow_Button.png'),
    ['arrow_button_pressed'] = love.graphics.newImage('graphics/Arrow_Button_Pressed.png'),
    ['up_arrow'] = love.graphics.newImage('graphics/Up.png'),
    ['down_arrow'] = love.graphics.newImage('graphics/down.png'),
    ['left_arrow'] = love.graphics.newImage('graphics/Left.png'),
    ['right_arrow'] = love.graphics.newImage('graphics/Right.png'),
    ['instruction_background'] = love.graphics.newImage('graphics/Instruction_Background.png')
}

gSounds = {
    ['select'] = love.audio.newSource('sounds/Select.wav', 'static'),
    ['collision'] = love.audio.newSource('sounds/Collision.wav', 'static'),
    ['rope_snap'] = love.audio.newSource('sounds/Rope_Snap.wav', 'static'),
    ['enemy_death'] = love.audio.newSource('sounds/Enemy_Death.wav', 'static'),
    ['pick_up_key'] = love.audio.newSource('sounds/Key.wav', 'static'),
    ['chest_unlocked'] = love.audio.newSource('sounds/Unlock_Chest.wav', 'static'),
    ['portal_activate'] = love.audio.newSource('sounds/Portal_Activate.wav', 'static'),
    ['hurt'] = love.audio.newSource('sounds/Hurt.wav', 'static'),
    ['button_push'] = love.audio.newSource('sounds/Button_Push.wav', 'static'),
    ['up_arrow'] = love.audio.newSource('sounds/Up_Arrow.wav', 'static'),
    ['down_arrow'] = love.audio.newSource('sounds/Down_Arrow.wav', 'static'),
    ['left_arrow'] = love.audio.newSource('sounds/Left_Arrow.wav', 'static'),
    ['right_arrow'] = love.audio.newSource('sounds/Right_Arrow.wav', 'static'),
    ['missed_arrow'] = love.audio.newSource('sounds/Wrong_Arrow.wav', 'static'),

    ['music'] = love.audio.newSource('sounds/Bubblegum.wav', 'static')
}