-- update systems that only affect players

local Player = {}

local System = require 'lib.knife.system'

local Input = require 'game.input'
local Vector = require 'game.vector'
local Entity = require 'game.entity'

-- update player velocity from input position

Player.position = System(
{ 'isPlayer', 'position', 'velocity', 'maxSpeed', 'easeFactor' },
function (_, p, v, maxSpeed, easeFactor, dt)
    local ease = dt * easeFactor
    local vx, vy = Vector.fromPoints(p.x, p.y, Input.getPosition())
    v.x, v.y = Vector.limit(vx / ease, vy / ease, maxSpeed)
end)

-- handle player fire button

Player.fire = System(
{ 'isPlayer', 'position', 'fire' },
function (_, p, fire, dt, entities)
    if not Input.getFireButton() then
        return
    end
    if fire.delay and fire.delay > 0 then
        return
    end
    fire.delay = fire.interval
    entities[#entities + 1] = Entity('bullet.player', p.x, p.y, 0, -500)
end)

return Player
