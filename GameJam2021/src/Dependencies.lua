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

-- game states
require 'src/states/BaseState'
require 'src/states/PlayState'
require 'src/states/StartState'

require 'src/LevelMaker'
require 'src/EnemySpawner'

gFonts = {
    ['title'] = love.graphics.newFont('fonts/Title.ttf', 32),
    ['menu'] = love.graphics.newFont('fonts/Title.ttf', 12)
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
    ['key'] = love.graphics.newImage('graphics/Key.png'),
    ['chest'] = love.graphics.newImage('graphics/Chest.png')
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

    ['music'] = love.audio.newSource('sounds/Bubblegum.wav', 'static')
}