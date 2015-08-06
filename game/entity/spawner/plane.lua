return function (positionX, positionY)
    return {
        isStationary = true,
        isInvisible = true,
        bullet = { name = 'mobile.plane', speed = 250 },
        fire = { interval = 0.5 },
        position = { x = positionX, y = positionY },
        velocity = { x = 0, y = 0.0001 },
        fade = { speed = 0.4, value = 0 }
    }
end
