PauseState = Class{__includes = BaseState}

function PauseState:init()
end

function PauseState:enter(params)
    self.redBlob = params.redBlob
    self.blueBlob = params.blueBlob
    self.enemies = params.enemies
    self.tiles = params.tiles
    self.portal = params.portal
    self.pressure_button = params.portal
    self.arrow_button = params.arrow_button
    self.chest_key = params.chest_key
    self.health = params.health
    self.rope = params.rope
end

