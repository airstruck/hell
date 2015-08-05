-- simple music manager

local Music = {}

local Memoize = require 'lib.knife.memoize'

local load = Memoize(function (name)
    return love.audio.newSource(('resource/music/%s'):format(name), 'stream')
end)

function Music.play (name)
    local source = load(name)
    if Music.source then
        Music.source:stop()
    end
    Music.source = source
    source:setLooping(true)
    source:play()
    return source
end

return Music
