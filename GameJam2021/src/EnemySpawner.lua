EnemySpawner = Class{}

function EnemySpawner.generate()
    local enemies = {}
    enemy = Enemy({
        x = 5,
        y = 5,
        color = 1
    })

    table.insert(enemies, enemy)
    
    return enemies
end