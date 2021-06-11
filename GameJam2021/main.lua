--  main.lua

local world = require("world")
local entities = require("entities")
local state = require("states")
local input = require("input")

love.focus = function(focus)
end

love.keypressed = function(key)
    input.press(key)
end

love.keyreleased = function (key)
end

love.update = function(dt)
end

love.draw = function()
    for _, entity in ipairs(entities) do
        if entity.draw then entity:draw()
        end
    end
end
