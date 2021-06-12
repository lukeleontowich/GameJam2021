EnemySpawner = Class{}

function EnemySpawner.generate(red, blue)
    local enemies = {}
    enemy = Enemy({
        x = 5,
        y = 50,
        color = 1,
        redBlob = red,
        blueBlob = blue
    })

    table.insert(enemies, enemy)

    enemy = Enemy({
        x = 30,
        y = 50,
        color = 2,
        redBlob = red,
        blueBlob = blue
    })

    table.insert(enemies, enemy)

    return enemies
end