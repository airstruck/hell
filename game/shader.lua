local Shader = {}

local Memoize = require('lib.knife.memoize')

local read = love.filesystem.read
local new = love.graphics.newShader
local set = love.graphics.setShader

local load = Memoize(function (name)
    return new(('resource/shader/%s.glsl'):format(name))
end)

Shader.set = function (name)
    local shader = load(name)
    set(shader)
    return shader
end

Shader.unset = function ()
    return set()
end

return Shader
