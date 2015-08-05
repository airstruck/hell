local Update = {}

local System = require 'lib.knife.system'
local Event = require 'lib.knife.event'

local Input = require 'game.input'
local Vector = require 'game.vector'
local Entity = require 'game.entity'

local function checkCollision (posA, sizeA, posB, sizeB)
    local dx = math.abs(posA.x - posB.x)
    local dy = math.abs(posA.y - posB.y)
    local size = sizeA + sizeB

    return dx < size and dy < size
end

local function spawn (entities, amount, name, ...)
    local offset = #entities + 1

    for index = offset, offset + amount do
        entities[index] = Entity(name, ...)
    end
end

-- update player velocity from input position

local colliderComponents = { 'position', 'size', 'health', '_entity', '_index' }

Update.collision = System(
{ 'position', 'size', 'damage', '_entity', '_index', '_entities' },
function (posA, sizeA, damage, entityA, indexA, entities)
    for posB, sizeB, health, entityB, indexB
    in System.each(entities, colliderComponents, System.reverse) do
        if (posA ~= posB)
        and (entityA.isFriendly ~= entityB.isFriendly)
        and checkCollision(posA, sizeA, posB, sizeB) then
            -- Event.dispatch('collision', entityA, entityB)
            health.pain = health.pain + damage.value
            health.value = health.value - damage.value
            table.remove(entities, indexA)
            spawn(entities, 5, 'particle.spark', posA.x, posA.y)
            System.invalidate(entities)
        end
    end
end, System.reverse)

Update.death = System(
{'position', 'health', '_index', '_entities'},
function (p, health, index, entities, dt)
    if health.value <= 0 then
        local entity = table.remove(entities, index)
        spawn(entities, 5, 'particle.explosion', p.x, p.y)
        System.invalidate(entities)
        Event.dispatch('death', entity)
    end
end, System.reverse)

-- update player velocity from input position

Update.playerPosition = System(
{ 'isPlayer', 'position', 'velocity', 'maxSpeed', 'easeFactor' },
function (_, p, v, maxSpeed, easeFactor, dt)
    local ease = dt * easeFactor
    local vx, vy = Vector.fromPoints(p.x, p.y, Input.getPosition())
    v.x, v.y = Vector.limit(vx / ease, vy / ease, maxSpeed)
end)

-- handle player fire button

Update.playerFire = System(
{ 'isPlayer', 'position', 'fire', '_entities' },
function (_, p, fire, entities, dt)
    if not Input.getFireButton() then
        return
    end
    if fire.delay and fire.delay > 0 then
        return
    end
    fire.delay = fire.interval
    entities[#entities + 1] = Entity('bullet.player', p.x, p.y, 0, -500)
end)

-- update position from velocity

Update.velocity = System(
{ 'position', 'velocity' },
function (p, v, dt)
    p.x = p.x + v.x * dt
    p.y = p.y + v.y * dt
end)

-- update velocity from turn angle

Update.turn = System(
{ 'velocity', 'turn' },
function (v, turn, dt)
    v.x, v.y = Vector.adjustAngle(v.x, v.y, turn.angle * dt)
end)

-- update delay time until next bullet can be fired

Update.fireDelay = System(
{ 'fire' },
function (fire, dt)
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
end)

-- track player position and update fire angle

Update.trackingAngle = System(
{ 'position', 'trackingAngle', '_entities' },
function (p, trackingAngle, entities, dt)
    local player = entities[1]
    local x, y = player.position.x, player.position.y
    trackingAngle.value = Vector.toAngle(Vector.fromPoints(p.x, p.y, x, y))
end)

local function spawnBullets (p, fireAngles, fire, bullet, entities)

    if fire.delay and fire.delay > 0 then
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

-- fire a bullet at player

Update.trackingFire = System(
{ 'position', 'trackingAngle', 'fire', 'bullet', '_entities' },
function (p, trackingAngle, fire, bullet, entities, dt)
    local fireAngles = { trackingAngle.value }
    spawnBullets (p, fireAngles, fire, bullet, entities)
end)

-- fire a bullet straight ahead

Update.forwardFire = System(
{ 'position', 'velocity', 'fire', 'bullet', '_entities' },
function (p, v, fire, bullet, entities, dt)
    local fireAngles = { Vector.toAngle(v.x, v.y) }
    spawnBullets (p, fireAngles, fire, bullet, entities)
end)

-- fire bullets at multiple angles

Update.multiFire = System(
{ 'position', 'fireAngles', 'fire', 'bullet', '_entities' },
function (p, fireAngles, fire, bullet, entities, dt)
    spawnBullets (p, fireAngles, fire, bullet, entities)
end)

-- remove entities when they go out of bounds

local boundaryMargin = 64
local windowHeight = love.window.getHeight()
local windowWidth = love.window.getWidth()

Update.boundaryRemoval = System(
{ 'position', '_entities', '_index' },
function (p, entities, index)
    if p.y < -boundaryMargin or p.y > windowHeight + boundaryMargin
    or p.x < -boundaryMargin or p.x > windowWidth + boundaryMargin then
        table.remove(entities, index)
        System.invalidate(entities)
    end
end, System.reverse)

-- fade entities out and remove them

Update.fade = System(
{ 'fade', '_entities', '_index' },
function (fade, entities, index, dt)
    fade.value = fade.value + fade.speed * dt
    if fade.value >= 1 then
        table.remove(entities, index)
        System.invalidate(entities)
    end
end, System.reverse)

Update.pain = System(
{ 'health' },
function (health, dt)
    if health.pain > 0 then
        health.pain = health.pain - dt * 4
    end
end)

Update.scale = System(
{ 'scale' },
function (scale, dt)
    if scale.delta then
        scale.value = scale.value + scale.delta * dt
    end
end)

-- execute scheduled tasks

Update.schedule = System(
{ 'schedule' },
function (schedule, dt)
    local task = schedule[1]
    if not task then
        return
    end
    schedule.elapsed = (schedule.elapsed or 0) + dt
    if task[1] > schedule.elapsed then
        return
    end
    for target, values in pairs(task) do
        if type(target) == 'table' then
            for key, value in pairs(values) do
                target[key] = value
            end
        end
    end
    schedule.elapsed = 0
    table.remove(schedule, 1)
end)

return Update
