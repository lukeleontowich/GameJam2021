--  ChestKeySpawner.lua

ChestKeySpawner = Class {}

-- {chestX, chesty, keyx keyy}
function ChestKeySpawner.generate(params)
    local chestKeys = {}

    for i = 2, params.quantity - 1 do
        local chest_key = ChestKey(params[i], param[i+1]  )       
        )
