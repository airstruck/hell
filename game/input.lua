local Input = {}

function Input.getPosition ()
    return love.mouse.getX(), love.mouse.getY()
end

function Input.getFireButton ()
    return love.mouse.isDown('l')
end

return Input
