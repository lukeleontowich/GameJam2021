Class = require 'lib/class'
push = require 'lib/push'

require 'src/Constants'
require 'src/StateMachine'

require 'src/Blob'

-- game states
require 'src/states/BaseState'
require 'src/states/PlayState'
require 'src/states/StartState'

gFonts = {
    ['title'] = love.graphics.newFont('fonts/Title.ttf', 32),
    ['menu'] = love.graphics.newFont('fonts/Title.ttf', 12)
}

gTextures = {
    ['background'] = love.graphics.newImage('graphics/Background.png'),
    ['tile'] = love.graphics.newImage('graphics/Normal_Tile.png'),
    ['red_blob_still'] = love.graphics.newImage('graphics/Red_Blob_Still.png'),
    ['red_blob_squishing'] = love.graphics.newImage('graphics/Red_Blob_Squish_1.png'),
    ['red_blob_squished'] = love.graphics.newImage('graphics/Red_Blob_Squish_2.png'),
    ['blue_blob_still'] = love.graphics.newImage('graphics/Blue_Blob_Still.png'),
    ['blue_blob_squishing'] = love.graphics.newImage('graphics/Blue_Blob_Squish_1.png'),
    ['blue_blob_squished'] = love.graphics.newImage('graphics/Blue_Blob_Squish_2.png')
}