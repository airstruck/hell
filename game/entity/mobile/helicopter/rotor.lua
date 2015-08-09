-- A missile turret. Tracks player, fires homing missiles.
-- Fires at a medium rate at regular intervals with no cooldown.

return function (positionX, positionY)
    return {
        position = { x = positionX, y = positionY },
        velocity = { x = 0, y = 0.0001 },
        turn = { angle = 8 }
    }
end
