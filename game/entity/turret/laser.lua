return function (positionX, positionY)
    return {
        isEnemy = true,
        isTurret = true,
        fire = { interval = 0.25 },
        trackingAngle = { value = 0 },
        size = 2,
        position = { x = positionX, y = positionY }
    }
end
