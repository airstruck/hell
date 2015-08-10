vec4 effect (vec4 color, Image texture, vec2 texturePos, vec2 screenPos) {
    vec4 c = Texel(texture, texturePos);

    c.r += color.r;
    c.bg -= color.r;
    c.a *= color.a;

    return c;
}
