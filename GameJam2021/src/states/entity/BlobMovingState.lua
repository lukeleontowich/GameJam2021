--  BlobMovingState.lua

BlobMovingState = Class(__includes = BaseState)

function PlayerMovingState(blob)
    self.blob = blob
    self.