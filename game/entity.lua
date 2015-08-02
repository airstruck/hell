local Memoize = require 'lib.knife.memoize'

local qualify = Memoize(function (name)
    return 'game.entity.' .. name
end)

return function (name, ...)
    local entity = require(qualify(name))(...)

    entity.name = name

    return entity
end
