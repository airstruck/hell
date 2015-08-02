extern number time;

vec4 effect (vec4 color, Image texture, vec2 texturePos, vec2 screenPos) {
    float v = 0;
    vec2 pos = screenPos * 0.01;

    pos.x += sin(pos.y + time);
    pos.y += cos(pos.x + time);

    v += pos.x;
    v += pos.y * 2;
    v += sin(pos.x * pos.y);
    v += time;

    return vec4(0, cos(v) * 0.5, 1.5 - sin(v), sin(v) * 3);
}
