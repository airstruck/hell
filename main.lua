-- globals

_G.HELL_DEBUG = false
_G.HELL_VERSION = '0.0.3'

-- lock the global table

setmetatable(_G, {
    __index = function () error('referenced an undefined variable', 2) end,
    __newindex = function () error('new global variables disabled', 2) end
})

-- have love's handlers and callbacks dispatch knife events

local Event = require 'lib.knife.event'

Event.injectDispatchers(love.handlers)
Event.injectDispatchers(love, { 'update', 'draw' })

-- press f12 to toggle debug mode

Event.on('keypressed', function(key)
    if key == 'f12' then
        _G.HELL_DEBUG = not _G.HELL_DEBUG
    end
end)

love.graphics.setDefaultFilter('nearest', 'nearest')

-- set the stage with the title scene

require 'game.stage' 'menu'
