shader_type canvas_item;

uniform float glow_strength : hint_range(0.0, 1.0) = 0.5; // Adjust the strength of the glow
uniform float glow_radius : hint_range(0.0, 100.0) = 20.0; // Adjust the radius of the glow

void vertex() {
    // no changes to the vertex shader
}

void fragment() {
    vec4 color = texture(TEXTURE, SCREEN_UV);

    // Detect white regions
    if (color.rgb == vec3(1.0)) {
        // Calculate distance to the center of the white region
        float distance = length(SCREEN_UV - vec2(0.5, 0.5));

        // Calculate the glow factor based on distance and radius
        float glow_factor = smoothstep(0.0, glow_radius, glow_radius - distance);

        // Add glow effect to white regions
        vec3 glow_color = vec3(1.0, 1.0, 1.0); // Yellow glow color
        COLOR = vec4(mix(color.rgb, glow_color, glow_factor), color.a);
    } else {
        COLOR = color;
    }
}
