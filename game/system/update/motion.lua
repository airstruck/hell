-- update systems related to motion and collision

local Motion = {}

local System = require 'lib.knife.system'

local Vector = require 'game.vector'
local Entity = require 'game.entity'

local function checkCollision (posA, sizeA, posB, sizeB)
    local dx = math.abs(posA.x - posB.x)
    local dy = math.abs(posA.y - posB.y)
    local size = sizeA + sizeB

    return dx < size and dy < size
end

-- update player velocity from input position

local collide = System(
{ 'position', 'size', 'damage', '_entity' },
function (posB, sizeB, damage, entityB, posA, sizeA, health, entityA)
    if (entityA.isFriendly ~= entityB.isFriendly)
    and checkCollision(posA, sizeA, posB, sizeB) then
        health.pain = (health.pain or 0) + damage.value
        health.value = health.value - damage.value
        return true, Entity.spawn(5, 'particle.spark', posA.x, posA.y)
    end
end)

Motion.collision = System(
{ 'position', 'size', 'health', '_entity', '_entities' },
function (posA, sizeA, health, entityA, entities)
    collide(entities, posA, sizeA, health, entityA)
end)

-- update position from velocity

Motion.velocity = System(
{ 'position', 'velocity' },
function (p, v, dt)
    p.x = p.x + v.x * dt
    p.y = p.y + v.y * dt
end)

-- update velocity from turn angle

Motion.turn = System(
{ 'velocity', 'turn' },
function (v, turn, dt)
    v.x, v.y = Vector.adjustAngle(v.x, v.y, turn.angle * dt)
end)

-- track player position and update fire angle

Motion.tracking = System(
{ 'position', 'tracking', '_entities' },
function (p, tracking, entities, dt)
    local player = entities[1]
    local x, y = player.position.x, player.position.y
    tracking.angle = Vector.toAngle(Vector.fromPoints(p.x, p.y, x, y))
end)

-- thanks, Jasoco and Davidobot
local function angleDifference (t1, t2)
   return (t1 - t2 + math.pi) % (math.pi * 2) - math.pi
end

-- move towards player
Motion.homing = System(
{ 'position', 'velocity', 'homing', 'turn', '_entities' },
function (p, v, homing, turn, entities, dt)
    local player = entities[1]
    local x, y = player.position.x, player.position.y
    local currentAngle = Vector.toAngle(v.x, v.y)
    local angleToPlayer = Vector.toAngle(Vector.fromPoints(p.x, p.y, x, y))
    local diff = angleDifference(currentAngle, angleToPlayer)
    turn.angle = diff > 0 and -homing.speed or homing.speed
end)

-- remove entities when they go out of bounds

local boundaryMargin = 64
local windowHeight = love.window.getHeight()
local windowWidth = love.window.getWidth()

Motion.boundaryRemoval = System(
{ 'position' },
function (p)
    if p.y < -boundaryMargin or p.y > windowHeight + boundaryMargin
    or p.x < -boundaryMargin or p.x > windowWidth + boundaryMargin then
        return true
    end
end)

-- update position for mounted entities

Motion.mounted = System(
{ 'mount', 'position' },
function (mount, p)
    local mountEntity = mount.entity
    local mountPosition = mountEntity.position
    local offset = mount.offset

    if mountEntity.health and mountEntity.health.value <= 0 then
        mount.entity = nil
        return true
    end

    if offset then
        local offsetX, offsetY = offset.x, offset.y
        local mountVelocity = mountEntity.velocity
        local mountAngle = Vector.toAngle(mountVelocity.x, mountVelocity.y)
        local cosine, sine = math.cos(mountAngle), math.sin(mountAngle)
        p.x = mountPosition.x + offsetX * cosine + offsetY * sine
        p.y = mountPosition.y + offsetY * cosine + offsetX * sine
    else
        p.x = mountPosition.x
        p.y = mountPosition.y
    end
end)


return Motion
