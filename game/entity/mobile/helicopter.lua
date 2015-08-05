-- A helicopter. Medium health, fires missiles.

return function (positionX, positionY, velocityX, velocityY)
    return {
        isEnemy = true,
        size = 20,
        offset = { x = 50, y = 0 },
        bulletType = 'bullet.missile',
        bulletSpeed = 250,
        fire = { interval = 2 },
        position = { x = positionX, y = positionY },
        velocity = { x = velocityX, y = velocityY },
        health = { value = 5, max = 5, pain = 0 }
    }
end
