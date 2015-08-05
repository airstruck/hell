-- A pulse turret. Fires multiple bullets at once in different directions.
-- Fires at a medium rate at regular intervals with no cooldown.

local function calculateFireAngles (fireAngleCount)
    local interval = math.pi * 2 / fireAngleCount
    local angles = {}
    local angle = 0
    local index = 0

    while index < fireAngleCount do
        index = index + 1
        angles[index] = angle
        angle = angle + interval
    end

    return angles
end

return function (positionX, positionY, fireAngleCount)
    return {
        isEnemy = true,
        size = 15,
        bullet = { name = 'bullet.pulse', speed = 100 },
        fire = { interval = 1 },
        fireAngles = calculateFireAngles(fireAngleCount),
        position = { x = positionX, y = positionY },
        health = { value = 8, max = 8, pain = 0 }
    }
end
