--  Levels.lua
Levels = Class{}
function Levels:init()
self.level1 = Level{
    chest_keys = {
        ChestKey({
            chest = Chest({x = VIRTUAL_WIDTH / 4, y = VIRTUAL_HEIGHT / 4}),
            key = Key({x = 3 * VIRTUAL_WIDTH / 4, y = 3 * VIRTUAL_HEIGHT / 4})
        })
    },
    portals = {
        Portal({
            left_x = 20,
            left_y = 20,
            right_x = VIRTUAL_WIDTH - 40,
            right_y = 20
        })
    },
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
}
end

