-- A scene represents a "game state" or "screen."
-- For example, the title screen or the gameplay state.

local Scene = require('lib.knife.base'):extend()

local Event = require 'lib.knife.event'

function Scene:constructor (stage)
    self.stage = stage
    self.handlers = {}
end

function Scene:on (name, callback)
    local handler = Event.on(name, callback)
    self.handlers[handler] = true
    return handler
end

function Scene:removeHandlers ()
    for handler in pairs(self.handlers) do
        handler:remove()
    end
end

function Scene:load ()

end

function Scene:unload ()
    self:removeHandlers()
end

function Scene:delay (time, callback)
    local handler
    handler = self:on('update', function (dt)
        time = time - dt
        if time <= 0 then
            self.handlers[handler] = nil
            handler:remove()
            callback()
        end
    end)
end

return Scene
