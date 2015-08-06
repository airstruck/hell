-- A small plane. Low health, no weapons.

return function (positionX, positionY, velocityX, velocityY)
    return {
        size = 15,
        position = { x = positionX, y = positionY },
        velocity = { x = velocityX, y = velocityY },
        health = { value = 2 },
        damage = { value = 2 }
    }
end
