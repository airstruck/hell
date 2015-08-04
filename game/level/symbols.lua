local Entity = require 'game.entity'

local Vector = require 'game.vector'

return function ()
    return {
        -- small plane flying south, looping west to north
        ['pJ'] = function (x, y)
            local entity = Entity('mobile.plane', x, y,  0, 200)
            entity.turn = { angle = 0 }
            entity.schedule = {
                { 1, [entity.turn] = { angle = 2 } },
                { math.pi / 2, [entity.turn] = { angle = 0 } }
            }
            return entity
        end,

        -- small plane flying south, looping east to north
        ['pL'] = function (x, y)
            local entity = Entity('mobile.plane', x, y,  0, 200)
            entity.turn = { angle = 0 }
            entity.schedule = {
                { 1, [entity.turn] = { angle = -2 } },
                { math.pi / 2, [entity.turn] = { angle = 0 } }
            }
            return entity
        end,

        -- small plane flying south
        ['pv'] = function (x, y)
            return Entity('mobile.plane', x, y,  0, 200)
        end,

        -- small plane flying southeast
        ['p>'] = function (x, y)
            return Entity('mobile.plane', x, y,  50, 200)
        end,

        -- small plane flying southwest
        ['<p'] = function (x, y)
            return Entity('mobile.plane', x, y,  -50, 200)
        end,

        -- helicopter flying southeast
        ['h>'] = function (x, y)
            return Entity('mobile.helicopter', x, y,  50, 200)
        end,

        -- helicopter flying southwest
        ['<h'] = function (x, y)
            return Entity('mobile.helicopter', x, y,  -50, 200)
        end,

        -- laser turret southeast
        ['L>'] = function (x, y)
            return Entity('turret.laser', x, y,  1, 1)
        end,

        -- laser turret southwest
        ['<L'] = function (x, y)
            return Entity('turret.laser', x, y,  -1, 1)
        end,

        -- pulse turret, 2 way
        ['D2'] = function (x, y)
            return Entity('turret.pulse', x, y,  2)
        end,

        -- directional turret, 4 way
        ['D4'] = function (x, y)
            return Entity('turret.pulse', x, y, 4)
        end,

        -- pulse turret, 8 way
        ['D8'] = function (x, y)
            return Entity('turret.pulse', x, y, 8)
        end,

        -- pulse turret, 16 way
        ['D*'] = function (x, y)
            return Entity('turret.pulse', x, y, 16)
        end,

        -- chain turret
        ['CT'] = function (x, y)
            return Entity('turret.chain', x, y)
        end,

        -- rail turret
        ['RT'] = function (x, y)
            return Entity('turret.rail', x, y)
        end
    }
end
