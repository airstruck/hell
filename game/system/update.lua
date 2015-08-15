-- miscellaneous update systems

local Update = {}

local System = require 'lib.knife.system'
local Event = require 'lib.knife.event'

local Vector = require 'game.vector'
local Entity = require 'game.entity'

-- things explode when health drops below zero

Update.death = System(
{'position', 'health', '_entity' },
function (p, health, entity, dt)
    if health.value <= 0 then
        -- local entity = table.remove(entities, index)
        entity.attachments = nil
        Event.dispatch('death', entity)
        return true, Entity.spawn(5, 'particle.explosion', p.x, p.y)
    end
end)

-- execute scheduled tasks

Update.schedule = System(
{ 'schedule' },
function (schedule, dt)
    local task = schedule[1]
    if not task then
        return
    end
    schedule.elapsed = (schedule.elapsed or 0) + dt
    if task[1] > schedule.elapsed then
        return
    end
    for target, values in pairs(task) do
        if type(target) == 'table' then
            for key, value in pairs(values) do
                target[key] = value
            end
        end
    end
    schedule.elapsed = 0
    table.remove(schedule, 1)
end)

return Update
