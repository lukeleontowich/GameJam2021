LevelMaker = Class{}

function LevelMaker.generateTiles(width, height)
    local tiles = {}
    
    local y = 0
    for i = 1, 8 do
        local tile = Tile(VIRTUAL_WIDTH / 2 - 8, y)
        table.insert(tiles, tile)
        y = y + 18
    end

    return tiles
end

function LevelMaker.generateLevels(red, blue)
    local levels = {
        --[[self.level0 = ]]{
        chest_keys = {
            ChestKey({
                chest = Chest({x = VIRTUAL_WIDTH / 4, y = VIRTUAL_HEIGHT / 4}),
                key = Key({x = 3 * VIRTUAL_WIDTH / 4, y = 3 * VIRTUAL_HEIGHT / 4})
            })
        },
        portal = Portal({
                left_x = 20,
                left_y = 20,
                right_x = VIRTUAL_WIDTH - 40,
                right_y = 20
        }),
        pressure_buttons = {},
        buttons = {},
        enemies = {}
    },

    --[[self.level1 = ]]{
        chest_keys = {},
        portal = Portal({
            left_x = -100,
            left_y = -100,
            right_x = -100,
            right_y = -100
    }),
        pressure_buttons = {
            PressureButton({y = 20, side = 1}),
            PressureButton({y = 50, side = 2})
        },
        buttons = {},
        enemies = {}
    },

    --[[self.level2 = ]]{
        chest_keys = {},
        portal = Portal({
                left_x = 20,
                left_y = 20,
                right_x = VIRTUAL_WIDTH - 40,
                right_y = 20
        }),
        pressure_buttons = {},
        buttons = {},
        enemies = {
            Enemy({x = 5, y = 50, color = 1, redBlob = red, blueBlob = blue}),
            Enemy({x = 30, y = 50, color = 2, redBlob = red, blueBlob = blue})
        }
    },

    --[[self.level3 = ]]{
        chest_keys = {
            ChestKey({
                chest = Chest({x = VIRTUAL_WIDTH / 4, y = VIRTUAL_HEIGHT / 4}),
                key = Key({x = 3 * VIRTUAL_WIDTH / 4, y = 3 * VIRTUAL_HEIGHT / 4})
            })
        },
        portal = Portal({
                left_x = 20,
                left_y = 20,
                right_x = VIRTUAL_WIDTH - 40,
                right_y = 20
        }),
        pressure_buttons = {
            PressureButton({y = 20, side = 1}),
            PressureButton({y = 50, side = 2})
        },
        buttons = {
            Button({x = 30,y = VIRTUAL_HEIGHT - 14,type = 2})
        },
        enemies = {
            Enemy({x = 5, y = 50, color = 1, redBlob = red, blueBlob = blue}),
            Enemy({x = 30, y = 50, color = 2, redBlob = red, blueBlob = blue})
        }
    },

    --[[self.level4 = ]]{
        chest_keys = {
            ChestKey({
                chest = Chest({x = 20, y = VIRTUAL_HEIGHT - 30}),
                key = Key({x = VIRTUAL_WIDTH - 20, y = 50})
            })
        },
        portal = Portal({
                left_x = 20,
                left_y = 20,
                right_x = VIRTUAL_WIDTH - 40,
                right_y = 20
        }),
        pressure_buttons = {
            PressureButton({y = 20, side = 1})
        },
        buttons = {},
        enemies = {
            Enemy({x = 5, y = 50, color = 1, redBlob = red, blueBlob = blue}),
            Enemy({x = 30, y = 50, color = 2, redBlob = red, blueBlob = blue}),
            Enemy({x = VIRTUAL_WIDTH - 20, y = VIRTUAL_HEIGHT - 40, color = 1, 
                   redBlob = red, blueBlob = blue})
        }
    },

    --[[self.level5 = ]]{
        chest_keys = {
            ChestKey({
                chest = Chest({x = 50, y = 100}),
                key = Key({x = 190, y = 25})
            })
        },
        portal = Portal({
                left_x = 50,
                left_y = 30,
                right_x = 190,
                right_y = 120
        }),
        pressure_buttons = {
            PressureButton({y = 40, side = 1}),
            PressureButton({y = 60, side = 2}),
            PressureButton({y = 100, side = 1})
        },
        buttons = {},
        enemies = {
            Enemy({x = 10, y = 130, color = 2, redBlob = red, blueBlob = blue}),
            Enemy({x = 30, y = 130, color = 2, redBlob = red, blueBlob = blue}),
            Enemy({x = 50, y = 130, color = 2, redBlob = red, blueBlob = blue}),
            Enemy({x = 160, y = 30, color = 1, redBlob = red, blueBlob = blue}),
            Enemy({x = 160, y = 30, color = 1, redBlob = red, blueBlob = blue}),
            Enemy({x = 160, y = 30, color = 1, redBlob = red, blueBlob = blue})
        }
    }}

    return levels
end