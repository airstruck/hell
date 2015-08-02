return function (positionX, positionY, velocityX, velocityY)
    return {
        isEnemyBullet = true,
        size = 5,
        position = { x = positionX, y = positionY },
        velocity = { x = velocityX, y = velocityY }
    }
end
