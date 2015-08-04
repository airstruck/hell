return function (positionX, positionY, velocityX, velocityY)
    return {
        isPlayerBullet = true,
        isFriendly = true,
        size = 5,
        offset = { x = 0, y = 0 },
        damage = { value = 1 },
        position = { x = positionX, y = positionY },
        velocity = { x = velocityX, y = velocityY }
    }
end
