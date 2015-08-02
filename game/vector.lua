local Vector = {}

-- get a vector's length, squared

function Vector.getLengthSquared (vx, vy)
    return vx * vx + vy * vy
end

-- get a vector's length

function Vector.getLength (vx, vy)
    return math.sqrt(Vector.getLengthSquared(vx, vy))
end

-- normalize a vector to a unit vector

function Vector.normalize (vx, vy)
    local length = Vector.getLength(vx, vy)
    return vx / length, vy / length
end

-- calculate a vector given two points

function Vector.fromPoints (x1, y1, x2, y2)
    return x2 - x1, y2 - y1
end

-- limit a vector's length

function Vector.limit (vx, vy, maxLength)
    local lengthSquared = Vector.getLengthSquared(vx, vy)
    if lengthSquared <= maxLength * maxLength then
        return vx, vy
    end
    local ratio = maxLength / math.sqrt(lengthSquared)
    return vx * ratio, vy * ratio
end

-- create randomized vector

function Vector.random (length)
    local angle = math.random() * math.pi * 2
    if not length then
        length = 1
    end
    return math.cos(angle) * length, math.sin(angle) * length
end

-- unit vector from angle in radians

function Vector.fromAngle (angle)
    return math.cos(angle), math.sin(angle)
end

-- unit vector to angle in radians

function Vector.toAngle (vx, vy)
    return math.atan2(vy, vx)
end

return Vector
