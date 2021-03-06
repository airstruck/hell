-- Gameplay scene.

local Scene = require('game.scene'):extend()

local Shader = require 'game.shader'

local System = require 'lib.knife.system'

local function addSystems (group, module)
    for _, system in pairs(module) do
        group[#group + 1] = system
    end
end

function Scene:load (level, entities)

    local updateSystems = {}

    addSystems(updateSystems, require 'game.system.update.motion')
    addSystems(updateSystems, require 'game.system.update.fire')
    addSystems(updateSystems, require 'game.system.update.effect')
    addSystems(updateSystems, require 'game.system.update')
    addSystems(updateSystems, require 'game.system.update.player')

    self:on('update', function (dt)
        level:update(entities, dt)
        for _, update in ipairs(updateSystems) do
            update(entities, dt)
        end
    end)

    local Draw = require 'game.system.draw'

    local spriteSheet = love.graphics.newImage('resource/sprite.png')
    local spriteBatch = love.graphics.newSpriteBatch(spriteSheet)

    self:on('draw', function ()
        spriteBatch:clear()
        Draw.sprite(entities, spriteBatch)
        Shader.set('pain')
        love.graphics.draw(spriteBatch)
        Shader.unset()
        if _G.HELL_DEBUG then
            Draw.hitbox(entities)
        end
    end)

    self:on('keypressed', function(key)
        if key == 'escape' then
            self:loadScene('menu', level, entities)
        end
    end)

    self:on('death', function(entity)
        if _G.HELL_DEBUG then
            print(('%s died'):format(entity.name))
        end
        if entity.isPlayer then
            self:delay(1, function ()
                self:loadScene('menu')
            end)
        end
    end)

    love.mouse.setGrabbed(true)
end

function Scene:unload ()
    love.mouse.setGrabbed(false)
    self:removeHandlers()
end

return Scene
