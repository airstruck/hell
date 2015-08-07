return function (positionX, positionY, velocityX, velocityY)
    local homing = { speed = 2 }
    local turn = { angle = 0 }
    return {
        size = 10,
        homing = homing,
        turn = turn,
        damage = { value = 2 },
        position = { x = positionX, y = positionY },
        velocity = { x = velocityX, y = velocityY },
        bullet = { name = 'particle.smoke', speed = 0 },
        fire = { interval = 0.01 },
        schedule = { { 3, [homing] = { speed = 0 }, [turn] = { angle = 0 } } }
    }
end
