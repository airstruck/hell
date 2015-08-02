-- A small plane. Low health, no weapons.

return function (positionX, positionY, velocityX, velocityY)
    return {
        isEnemy = true,
        size = 10,
        position = { x = positionX, y = positionY },
        velocity = { x = velocityX, y = velocityY },
        health = { value = 3, max = 3, pain = 0 }
    }
end
