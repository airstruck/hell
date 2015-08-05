return function ()
    return {
        isPlayer = true,
        isFriendly = true,
        size = 20,
        maxSpeed = 500,
        easeFactor = 8,
        fixedAngle = -math.pi * 0.5,
        shearFactor = 0.25,
        fire = { interval = 0.25 },
        position = { x = 400, y = 300 },
        velocity = { x = 0, y = 0 },
        health = { value = 10, pain = 0 }
    }
end
