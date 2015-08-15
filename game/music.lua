-- simple music manager

local Music = {}

local Memo = require 'game.memo'

local load = Memo(function (name)
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
