return function (fn)
    local cache = {}
    return function (key)
        if not cache[key] then
            cache[key] = fn(key)
        end
        return cache[key]
    end
end
