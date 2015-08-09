-- A helicopter. Medium health, fires missiles.
local Entity = require 'game.entity'

return function (positionX, positionY, velocityX, velocityY)
    local mobile = {
        size = 20,
        offset = { x = 50, y = 0 },
        bullet = { name = 'bullet.missile', speed = 250 },
        fire = { interval = 3 },
        position = { x = positionX, y = positionY },
        velocity = { x = velocityX, y = velocityY },
        health = { value = 5 }
    }
    local rotor = Entity('mobile.helicopter.rotor', positionX, positionY)

    rotor.mount = { entity = mobile }

    mobile.attachments = { rotor }

    return mobile
end
