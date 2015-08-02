return function (positionX, positionY)
    return {
        isEnemy = true,
        isTurret = true,
        fireInterval = 0.25,
        fireDelay = { value = 0 },
        trackingAngle = { value = 0 },
        size = 2,
        position = { x = positionX, y = positionY }
    }
end
