return function (positionX, positionY)
    return {
        isEnemy = true,
        fire = { interval = 0.25 },
        tracking = { angle = 0 },
        size = 2,
        position = { x = positionX, y = positionY }
    }
end
