-- The stage is responsible for managing the current scene.
-- Each scene holds a reference to the stage so it can initiate
-- a transition to a different scene.

local Stage = require('lib.knife.base'):extend()

function Stage:constructor (...)
    self:loadScene(...)
end

function Stage:loadScene (name, ...)
    local Scene = require('game.scene.' .. name)
    if self.scene then
        self.scene:unload()
    end
    self.scene = Scene(self)
    self.scene:load(...)
end

return Stage
