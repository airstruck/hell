local Draw = {}

local System = require 'lib.knife.system'
local Memo = require 'game.memo'

local Vector = require 'game.vector'
local Shader = require 'game.shader'

local Atlas = require 'resource.atlas'

local getQuad = Memo(function (name)
    local info = Atlas[name]
    local quad = love.graphics.newQuad(info.x, info.y, info.width, info.height,
        1024, 1024) -- FIXME
    return quad
end)

local spriteScale = 0.5

-- draw sprite

Draw.sprite = System(
{ 'position', 'name', '_entity' },
function (p, name, entity, spriteBatch)
    
    if entity.isInvisible then return end

    -- local image, width, height = getSprite(name)
    local quad = getQuad(name)
    local atlas = Atlas[name]
    local width, height = atlas.width, atlas.height


    local ox, oy = width * 0.5, height * 0.5 -- offset
    local kx, ky = 0, 0 -- shear

    local angle = entity.fixedAngle
        or entity.tracking
        and entity.tracking.angle
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

    local hasShader = false

    local pain = entity.health and entity.health.pain or 0

    if pain > 0.5 then
        pain = 0.5
    end

    spriteBatch:setColor(pain * 255, 0, 0, alpha)
    spriteBatch:add(quad, p.x, p.y, angle, scale, scale, ox, oy, kx, ky)

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
