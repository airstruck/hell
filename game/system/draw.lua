local Draw = {}

local System = require 'lib.knife.system'
local Memoize = require 'lib.knife.memoize'

local Vector = require 'game.vector'
local Shader = require 'game.shader'

local newImage = love.graphics.newImage

local getSprite = Memoize(function (name)
    local image = newImage(('resource/sprite/%s.png'):format(name))
    return image, image:getWidth(), image:getHeight()
end)

local spriteScale = 0.5

-- draw sprite

Draw.sprite = System(
{ 'position', 'name', '_entity' },
function (p, name, entity)
    local image, width, height = getSprite(name)
    local ox, oy = width * 0.5, height * 0.5 -- offset
    local kx, ky = 0, 0 -- shear

    local angle = entity.fixedAngle
        or entity.trackingAngle
        and entity.trackingAngle.value
        or entity.velocity
        and Vector.toAngle(entity.velocity.x, entity.velocity.y)
        or 0

    local scale = entity.scale and entity.scale.value or spriteScale

    if entity.offset then
        ox = ox + entity.offset.x
        oy = oy + entity.offset.y
    end

    if entity.shearFactor and entity.velocity and entity.maxSpeed then
        kx = kx - entity.shearFactor * (entity.velocity.x / entity.maxSpeed)
    end

    local alpha = entity.fade and 255 - entity.fade.value * 255 or 255

    love.graphics.setColor(255, 255, 255, alpha)

    if entity.health then
        local pain = entity.health.pain
        if pain > 0 then
            Shader.set('pain'):send('value', pain)
        end
    end

    love.graphics.draw(image, p.x, p.y, angle, scale, scale, ox, oy, kx, ky)

    Shader.unset()
end)

-- draw hitbox from size and position

Draw.hitbox = System(
{ 'size', 'position' },
function (size, p)
    local length = size * 2
    local x = p.x - size + 0.5
    local y = p.y - size + 0.5
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.rectangle('line', x, y, length, length)
end)

return Draw
