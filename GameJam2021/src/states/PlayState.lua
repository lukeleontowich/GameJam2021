PlayState = Class{__includes = BaseState}

function PlayState:init()
end

function PlayState:update(dt)
    self.redBlob:update(dt)
    self.blueBlob:update(dt)
end

function PlayState:render()
    love.graphics.draw(gTextures['background'], 0, 0)
    self.redBlob:render()
    self.blueBlob:render()
end

function PlayState:enter(params)
    self.redBlob = params.redBlob
    self.blueBlob = params.blueBlob
    self.blueBlob.x = 0
    self.redBlob.x = 32
end