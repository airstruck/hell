return function (positionX, positionY, velocityX, velocityY)
    return {
        isEnemyBullet = true,
        size = 10,
        damage = { value = 2 },
        position = { x = positionX, y = positionY },
        velocity = { x = velocityX, y = velocityY }
    }
end
