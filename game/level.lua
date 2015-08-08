local Level = require('lib.knife.base'):extend()

local System = require 'lib.knife.system'

Level.scaleX = 40

Level.scaleY = 40

Level.scrollSpeed = 20

function Level:constructor (mapString)
    self.symbols = require('game.level.symbols')()
    self.progress = 0
    self.nextRow = 0
    self.map = self:loadMap(mapString or self.mapString)
    self.rowCount = #self.map
end

function Level:loadMap (mapString)
    local map = {}

    mapString:gsub('(.-)\r?\n', function (row)
        map[#map + 1] = row
        return row
    end)

    return map
end

local scroll = System(
{ 'position', '_entity' },
function (p, entity, dt, scrollSpeed)
    if entity.isStationary then
        return
    end
    p.y = p.y + scrollSpeed * dt
end)

function Level:update (entities, dt)

    scroll(entities, dt, self.scrollSpeed)

    if self.nextRow >= self.rowCount then
        return
    end

    self.progress = self.progress + self.scrollSpeed * dt

    if math.floor(self.progress / self.scaleY) > self.nextRow then
        local row = self.map[self.rowCount - self.nextRow]
        local x, y = 0, 0
        for symbol in row:gmatch('..') do
            x = x + self.scaleX
            if symbol ~= '  ' then
                if _G.HELL_DEBUG then
                    print('level symbol: ' .. symbol)
                end
                self.symbols[symbol](entities, x, y)
            end
        end
        self.nextRow = self.nextRow + 1
    end
end

return Level
