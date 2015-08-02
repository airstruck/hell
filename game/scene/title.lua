-- Title screen.

local Scene = require('game.scene'):extend()

function Scene:load ()

    self:on('draw', function (dt)
        love.graphics.setColor(255, 255, 255)
        love.graphics.print('Hell version ' .. _G.HELL_VERSION, 50, 50)
        love.graphics.print('Press "p" to play', 50, 100)
        if _G.HELL_DEBUG then
            love.graphics.setColor(255, 0, 0)
            love.graphics.print('Debug mode on', 50, 150)
        end
    end)

    self:on('keypressed', function(key)
        if key == 'p' then
            self.stage:loadScene('play')
        end
    end)

end

return Scene
