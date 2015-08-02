-- A missile turret. Tracks player, fires homing missiles.
-- Fires at a medium rate at regular intervals with no cooldown.

return function (positionX, positionY)
    return {
        isEnemy = true,
        isTurret = true,
        bulletType = 'bullet.missile',
        bulletSpeed = 250,
        fireInterval = 2,
        fireDelay = { value = 0 },
        trackingAngle = { value = 0 },
        size = 15,
        position = { x = positionX, y = positionY },
        health = { value = 8, max = 8, pain = 0 }
    }
end
