-- update systems related to firing bullets

local Fire = {}

local System = require 'lib.knife.system'

local Vector = require 'game.vector'
local Entity = require 'game.entity'

-- update delay time until next bullet can be fired

local function updateFireInterval (fire, dt)
    if not fire.delay then
        fire.delay = 0
        return
    end

    if fire.delay > 0 then
        fire.delay = fire.delay - dt
    end

    if fire.delay < 0 then
        fire.delay = 0
    end
end

-- some enemy weapons overheat and need to cool down

local function updateFireCooldown (fire, dt)
    if not (fire.warmup and fire.cooldown) then
        return
    end

    if not fire.heat then
        fire.heat = 0
    end

    if fire.isCoolingDown then
        fire.heat = fire.heat - dt
    else
        fire.heat = fire.heat + dt
    end

    if fire.heat >= fire.warmup then
        fire.isCoolingDown = true
        fire.heat = fire.cooldown
    elseif fire.heat <= 0 then
        fire.isCoolingDown = false
    end
end

local function spawnBullets (p, fireAngles, fire, bullet, entities)
    if fire.isCoolingDown or (fire.delay and fire.delay > 0) then
        return
    end
    fire.delay = fire.interval

    for _, angle in ipairs(fireAngles) do
        local vx, vy = Vector.fromAngle(angle)
        vx = vx * bullet.speed; vy = vy * bullet.speed
        local entity = Entity(bullet.name, p.x, p.y, vx, vy)
        if bullet.decorate then
            bullet.decorate(entity)
        end
        entities[#entities + 1] = entity
    end

    System.invalidate(entities)
end

-- manage fire interval and cooldown

Fire.delay = System(
{ 'fire' },
function (fire, dt)
    updateFireInterval(fire, dt)
    updateFireCooldown(fire, dt)
end)

-- fire a bullet at player

Fire.tracking = System(
{ 'position', 'tracking', 'fire', 'bullet', '_entities' },
function (p, tracking, fire, bullet, entities, dt)
    local fireAngles = { tracking.angle }
    spawnBullets (p, fireAngles, fire, bullet, entities)
end)

-- fire a bullet straight ahead

Fire.forward = System(
{ 'position', 'velocity', 'fire', 'bullet', '_entities' },
function (p, v, fire, bullet, entities, dt)
    local fireAngles = { Vector.toAngle(v.x, v.y) }
    spawnBullets (p, fireAngles, fire, bullet, entities)
end)

-- fire bullets at multiple angles

Fire.multi = System(
{ 'position', 'fireAngles', 'fire', 'bullet', '_entities' },
function (p, fireAngles, fire, bullet, entities, dt)
    spawnBullets (p, fireAngles, fire, bullet, entities)
end)

return Fire
