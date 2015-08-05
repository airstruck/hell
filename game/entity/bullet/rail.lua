return function (positionX, positionY, velocityX, velocityY)
    return {
        isEnemyBullet = true,
        size = 15,
        damage = { value = 4 },
        position = { x = positionX, y = positionY },
        velocity = { x = velocityX, y = velocityY },
        bulletType = 'particle.rail',
        bulletSpeed = 0,
        fire = { interval = 0.01 },
    }
end
