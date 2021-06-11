Class = require 'lib/class'
push = require 'lib/push'

require 'src/Constants'
require 'src/StateMachine'

-- game states
require 'src/states/BaseState'
require 'src/states/PlayState'
require 'src/states/StartState'

gTextures = {
    ['background'] = love.graphics.newImage('graphics/Background.png'),
    ['tile'] = love.graphics.newImage('graphics/Normal_Tile.png'),
    ['red_blob_still'] = love.graphics.newImage('graphics/Red_Blob_Still.png'),
    ['red_blob_squishing'] = love.graphics.newImage('graphics/Red_Blob_Squish_1.png')
}