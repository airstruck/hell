-- A truck. Has a missile turret mounted on it.
local Entity = require 'game.entity'

return function (positionX, positionY, velocityX, velocityY)
    local mobile = {
        size = 15,
        position = { x = positionX, y = positionY },
        velocity = { x = velocityX, y = velocityY },
        offset = { x = 25, y = 0 },
        health = { value = 5 }
    }
    local turret = Entity('turret.missile', positionX, positionY)

    turret.mount = { entity = mobile, offset = { x = -25, y = 0 } }

    mobile.attachments = { turret }

    return mobile
end
