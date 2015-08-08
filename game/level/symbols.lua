local Entity = require 'game.entity'

local Vector = require 'game.vector'

local function spawn (entities, entity)
    local index = #entities + 1
    entities[index] = entity
    if not entity.attachments then
        return
    end
    for _, attachment in ipairs(entity.attachments) do
        index = index + 1
        entities[index] = attachment
    end
end

return function ()
    return {

        -- truck moving south
        ['tv'] = function (entities, x, y)
            local entity = Entity('mobile.truck', x, y, 10, 10)
            entity.turn = { angle = -0.1 }
            spawn(entities, entity)
        end,

        -- small planes flying south
        ['pv'] = function (entities, x, y)
            spawn(entities, Entity('spawner.plane', x, y))
        end,

        -- small planes flying south, looping west to north
        ['pJ'] = function (entities, x, y)
            local spawner = Entity('spawner.plane', x, y)

            function spawner.bullet.decorate (plane)
                plane.turn = { angle = 0 }
                plane.schedule = {
                    { 1, [plane.turn] = { angle = 2 } },
                    { math.pi / 2, [plane.turn] = { angle = 0 } }
                }
            end

            spawn(entities, spawner)
        end,

        -- small planes flying south, looping east to north
        ['pL'] = function (entities, x, y)
            local spawner = Entity('spawner.plane', x, y)

            function spawner.bullet.decorate (plane)
                plane.turn = { angle = 0 }
                plane.schedule = {
                    { 1, [plane.turn] = { angle = -2 } },
                    { math.pi / 2, [plane.turn] = { angle = 0 } }
                }
            end

            spawn(entities, spawner)
        end,

        -- helicopter flying southeast
        ['h>'] = function (entities, x, y)
            spawn(entities, Entity('mobile.helicopter', x, y,  50, 100))
        end,

        -- helicopter flying southwest
        ['<h'] = function (entities, x, y)
            spawn(entities, Entity('mobile.helicopter', x, y,  -50, 100))
        end,

        -- laser turret southeast
        ['L>'] = function (entities, x, y)
            spawn(entities, Entity('turret.laser', x, y,  1, 1))
        end,

        -- laser turret southwest
        ['<L'] = function (x, y)
            spawn(entities, Entity('turret.laser', x, y,  -1, 1))
        end,

        -- pulse turret, 2 way
        ['D2'] = function (entities, x, y)
            spawn(entities, Entity('turret.pulse', x, y,  2))
        end,

        -- pulse turret, 4 way
        ['D4'] = function (entities, x, y)
            spawn(entities, Entity('turret.pulse', x, y, 4))
        end,

        -- pulse turret, 8 way
        ['D8'] = function (entities, x, y)
            spawn(entities, Entity('turret.pulse', x, y, 8))
        end,

        -- pulse turret, 16 way
        ['D*'] = function (entities, x, y)
            spawn(entities, Entity('turret.pulse', x, y, 16))
        end,

        -- chain turret
        ['CT'] = function (entities, x, y)
            spawn(entities, Entity('turret.chain', x, y))
        end,

        -- rail turret
        ['RT'] = function (entities, x, y)
            spawn(entities, Entity('turret.rail', x, y))
        end,

        -- missile turret
        ['MT'] = function (entities, x, y)
            spawn(entities, Entity('turret.missile', x, y))
        end
    }
end
