PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.tiles = LevelMaker.generate(VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
end

function PlayState:update(dt)
    self.redBlob:update(dt)
    self.blueBlob:update(dt)
    self.rope:update(dt)
end

function PlayState:render()
    love.graphics.draw(gTextures['background'], 0, 0)
    for i = 1, #self.tiles do
        self.tiles[i]:render()
    end
    self.redBlob:render()
    self.blueBlob:render()
    self.rope:render()
end

function PlayState:enter(params)
    self.redBlob = params.redBlob
    self.blueBlob = params.blueBlob
    self.blueBlob.x = 0
    self.redBlob.x = 32    
    self.rope = Rope({
        blueBlob = self.blueBlob,
        redBlob = self.redBlob
    })
end