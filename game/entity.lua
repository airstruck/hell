local Entity = {}

local Memoize = require 'lib.knife.memoize'

local qualify = Memoize(function (name)
    return 'game.entity.' .. name
end)

function Entity.spawn (entities, amount, name, ...)
    local offset = #entities + 1

    for index = offset, offset + amount do
        entities[index] = Entity(name, ...)
    end
end

return setmetatable(Entity, {
    __call = function (t, name, ...)
        local entity = require(qualify(name))(...)

        entity.name = name

        return entity
    end
})
