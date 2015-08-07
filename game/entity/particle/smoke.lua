local Vector = require 'game.vector'

return function (positionX, positionY)
    local velocityX, velocityY = Vector.random(5)
    return {
        position = { x = positionX, y = positionY },
        velocity = { x = velocityX, y = velocityY },
        fade = { speed = 0.5, value = 0.5 },
        scale = { value = 0.1, delta = 0.25 }
    }
end
