-- world.lua
-- World Lua

-- fixture_a, fixture_b, contact
local begin_contact_callback = function(fa, fb, c)
end

local end_contact_callback = function(fa, fb, c) 
end

local pre_solve_callback = function(fa, fb, c) 
end

local post_solve_callback = function(fa, fb, c)
end


local wind = 0

local gravity = 0

local world = love.physics.newWorld(wind, gravity)

world:setCallbacks (
    nil,
    nil,
    nil,
    nil
)

return world