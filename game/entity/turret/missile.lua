-- A missile turret. Tracks player, fires homing missiles.
-- Fires at a medium rate at regular intervals with no cooldown.

return function (positionX, positionY)
    return {
        isEnemy = true,
        isTurret = true,
        bullet = { name = 'bullet.missile', speed = 200 },
        fire = { interval = 2 },
        tracking = { angle = 0 },
        size = 15,
        position = { x = positionX, y = positionY },
        health = { value = 8, max = 8, pain = 0 }
    }
end
