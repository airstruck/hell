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

local colliderComponents = { 'position', 'size', 'health', '_entity', '_index' }

Motion.collision = System(
{ 'position', 'size', 'damage', '_entity', '_index', '_entities' },
function (posA, sizeA, damage, entityA, indexA, entities)
    for posB, sizeB, health, entityB, indexB
    in System.each(entities, colliderComponents, System.reverse) do
        if (entityA.isFriendly ~= entityB.isFriendly)
        and checkCollision(posA, sizeA, posB, sizeB) then
            health.pain = (health.pain or 0) + damage.value
            health.value = health.value - damage.value
            table.remove(entities, indexA)
            Entity.spawn(entities, 5, 'particle.spark', posA.x, posA.y)
            System.invalidate(entities)
        end
    end
end, System.reverse)

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

-- remove entities when they go out of bounds

local boundaryMargin = 64
local windowHeight = love.window.getHeight()
local windowWidth = love.window.getWidth()

Motion.boundaryRemoval = System(
{ 'position', '_entities', '_index' },
function (p, entities, index)
    if p.y < -boundaryMargin or p.y > windowHeight + boundaryMargin
    or p.x < -boundaryMargin or p.x > windowWidth + boundaryMargin then
        table.remove(entities, index)
        System.invalidate(entities)
    end
end, System.reverse)

return Motion
