-- A scene represents a "game state" or "screen."
-- For example, the title screen or the gameplay state.

local Scene = require('lib.knife.base'):extend()

local Event = require 'lib.knife.event'

function Scene:constructor (stage)
    self.stage = stage
    self.handlers = {}
end

function Scene:on (name, callback)
    self.handlers[#self.handlers + 1] = Event.on(name, callback)
end

function Scene:removeHandlers ()
    for _, handler in ipairs(self.handlers) do
        handler:remove()
    end
end

function Scene:load ()

end

function Scene:unload ()
    self:removeHandlers()
end

return Scene
