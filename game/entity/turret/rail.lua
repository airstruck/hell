-- A rail turret. Tracks player, fires powerful fast bullets.
-- Fires at a slow rate at regular intervals with no cooldown.

return function (positionX, positionY)
    return {
        isEnemy = true,
        size = 15,
        tracking = { angle = 0 },
        fire = { interval = 2 },
        bullet = { name = 'bullet.rail', speed = 1000 },
        position = { x = positionX, y = positionY },
        health = { value = 10 }
    }
end
