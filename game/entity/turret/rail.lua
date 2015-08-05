-- A rail turret. Tracks player, fires powerful fast bullets.
-- Fires at a slow rate at regular intervals with no cooldown.

return function (positionX, positionY)
    return {
        isEnemy = true,
        isTurret = true,
        bulletType = 'bullet.rail',
        bulletSpeed = 1000,
        fire = { interval = 2 },
        trackingAngle = { value = 0 },
        size = 15,
        position = { x = positionX, y = positionY },
        health = { value = 10, max = 10, pain = 0 }
    }
end
