--  input.lua

local state = require("state")

local press_functions = {
    escape = function()
        love.event.quit()
    end
}

local release_functions = {

}

return {
    press = function(key)
        if press_functions[key] then
            press_functions[key]()
        end
    end
}