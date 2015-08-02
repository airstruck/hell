-- Gameplay scene.

local Scene = require('game.scene'):extend()

local Update = require 'game.system.update'
local Draw = require 'game.system.draw'
local Entity = require 'game.entity'

local entities = {
    Entity('player')
}

local level = require 'game.level.01'

function Scene:load ()

    love.mouse.setGrabbed(true)

    self:on('update', function (dt)
        level:update(entities, dt)
        for _, update in pairs(Update) do
            update(entities, dt, level)
        end
    end)

    self:on('draw', function (dt)
        Draw.sprite(entities)
        if _G.HELL_DEBUG then
            Draw.hitbox(entities)
        end
    end)

    self:on('keypressed', function(key)
        if key == 'escape' then
            self.stage:loadScene('title')
        end
    end)

end

function Scene:unload ()
    love.mouse.setGrabbed(false)
    self:removeHandlers()
end

return Scene
