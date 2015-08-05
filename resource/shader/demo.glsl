extern number time;

vec4 effect (vec4 color, Image texture, vec2 texturePos, vec2 screenPos) {
    screenPos *= 0.01;

    screenPos.x += sin(screenPos.y + time);
    screenPos.y += cos(screenPos.x + time);

    float v = screenPos.x + screenPos.y * 2
        + sin(screenPos.x * screenPos.y) + time;

    float sinv = sin(v);

    float alpha = sinv * 3;
    float red = 0;

    if (time < 10) {
        alpha *= time * 0.1;
    } else {
        red = sin(time);
    }

    return vec4(red, cos(v) * 0.5, 1.5 - sinv, alpha);
}
