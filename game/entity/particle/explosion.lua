local Vector = require 'game.vector'

return function (positionX, positionY)
    local velocityX, velocityY = Vector.random(50)
    return {
        position = { x = positionX, y = positionY },
        velocity = { x = velocityX, y = velocityY },
        fade = { speed = 1, value = 0.25 },
        scale = { value = 0.25, delta = 2 }
    }
end
