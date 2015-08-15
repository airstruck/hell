local Entity = {}

local Memo = require 'game.memo'

local qualify = Memo(function (name)
    return 'game.entity.' .. name
end)

function Entity.spawn (amount, name, ...)
    local entities = {}
    local offset = 1

    for index = 1, amount do
        entities[index] = Entity(name, ...)
    end

    return entities
end

return setmetatable(Entity, {
    __call = function (t, name, ...)
        local entity = require(qualify(name))(...)

        entity.name = name

        return entity
    end
})
