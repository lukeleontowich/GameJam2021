LevelMaker = Class{}

function LevelMaker.generate(width, height)
    local tiles = {}
    
    for y = 0, VIRTUAL_HEIGHT do
        table.insert(tiles, Tile(VIRTUAL_WIDTH / 2 - 8, y))
        y = y + 31
    end

    return tiles
end