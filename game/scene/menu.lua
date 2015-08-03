-- Title screen.

local Scene = require('game.scene'):extend()

local Entity = require 'game.entity'


function Scene:load (level, entities)

    local function restart ()
        level = require('game.level.01')()
        entities = { Entity('player') }
    end

    self:on('draw', function (dt)
        love.graphics.setColor(255, 255, 255)
        love.graphics.print('Hell version ' .. _G.HELL_VERSION, 50, 50)
        love.graphics.print('Press "p" to play', 50, 100)
        if level then
            love.graphics.print('Press "r" to restart', 50, 150)
        end
        if _G.HELL_DEBUG then
            love.graphics.setColor(255, 0, 0)
            love.graphics.print('Debug mode on', 50, 300)
        end
    end)

    self:on('keypressed', function(key)
        if key == 'p' or level and key == 'escape' then
            if not level then
                restart()
            end
            self.stage:loadScene('play', level, entities)
        elseif level and key == 'r' then
            restart()
            self.stage:loadScene('play', level, entities)
        end
    end)

end

return Scene
