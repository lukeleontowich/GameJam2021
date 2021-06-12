SimonSaysState = Class{__includes = BaseState}

function SimonSaysState:init()
end

function SimonSaysState:enter(params)
    self.redBlob = params.redBlob
    self.redBlob.frozen = true
    self.blueBlob = params.blueBlob
    self.blueBlob.frozen = true
    self.enemies = params.enemies
    self.tiles = params.tiles
    self.portal = params.portal
    self.health = params.health
end

function SimonSaysState:render()
    love.graphics.draw(gTextures['background'], 0, 0)
    for tile in pairs(self.tiles) do
        self.tiles[tile]:render()
    end
    local distance = VIRTUAL_WIDTH - 9
    for h = 1, self.health do
        love.graphics.draw(gTextures['heart'], distance, 0)
        distance = distance - 9
    end
    self.portal:render()
end