return function (positionX, positionY)
    return {
        isStationary = true,
        isInvisible = true,
        bullet = { name = 'mobile.plane', speed = 250 },
        fire = { interval = 0.5 },
        position = { x = positionX, y = positionY },
        fireAngles = { math.pi / 2 },
        fade = { speed = 0.4, value = 0 }
    }
end
