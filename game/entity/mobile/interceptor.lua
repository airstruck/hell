-- An interceptor jet. Medium health, fires homing missiles.

return function (positionX, positionY, velocityX, velocityY)
    return {
        isEnemy = true,
        bulletType = 'bullet.missile',
        fireInterval = 0.25,
        fireDelay = { value = 0 },
        position = { x = positionX, y = positionY },
        velocity = { x = velocityX, y = velocityY },
        size = 10
    }
end
