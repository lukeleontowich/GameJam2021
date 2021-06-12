LevelMaker = Class{}

function LevelMaker.generate(width, height)
    local tiles = {}
    
    local y = 0
    for i = 1, 8 do
        local tile = Tile(VIRTUAL_WIDTH / 2 - 8, y)
        table.insert(tiles, tile)
        y = y + 18
    end

    return tiles
end