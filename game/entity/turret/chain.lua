-- A missile turret. Tracks player, fires homing missiles.
-- Fires at a medium rate at regular intervals with no cooldown.

return function (positionX, positionY)
    return {
        isEnemy = true,
        isTurret = true,
        bulletType = 'bullet.chain',
        bulletSpeed = 150,
        fire = { interval = 0.2 },
        trackingAngle = { value = 0 },
        size = 15,
        position = { x = positionX, y = positionY },
        health = { value = 8, max = 8, pain = 0 }
    }
end
