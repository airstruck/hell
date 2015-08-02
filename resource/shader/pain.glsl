extern number value;

vec4 effect (vec4 color, Image texture, vec2 texturePos, vec2 screenPos) {
    color *= Texel(texture, texturePos);

    float v = value * 0.5;

    if (v > 0.5) v = 0.5;

    color.r += v;
    color.g -= v;
    color.b -= v;

    return color;
}
