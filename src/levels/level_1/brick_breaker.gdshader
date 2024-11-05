shader_type canvas_item;

uniform sampler2D noise_texture1: repeat_enable;
uniform sampler2D noise_texture2: repeat_enable;
uniform vec2 offset1 = vec2(0.1);
uniform vec2 offset2 = vec2(-0.1);
uniform float distorsion_strength: hint_range(0.0, 10.0, 0.1) = 0.0;

uniform sampler2D screen_texture: hint_screen_texture, filter_nearest;

float move_y(float x, float y, vec4 noise1, vec4 noise2) {
	if (mod(x, 2.0) == 0.0) {
		return y + noise1.r * noise2.r * distorsion_strength * 10.0;
	} else {
		return y - noise1.r * noise2.r * distorsion_strength;
	}
}

void fragment() {
	vec4 original_color = texture(TEXTURE, UV + offset1 * TIME);
	vec4 noise1 = texture(noise_texture1, UV + offset1 * TIME);
	vec4 noise2 = texture(noise_texture2, UV + offset2 * TIME);
	vec4 noise_mix = vec4(vec3(noise1.r * noise2.r), 0.5);

	//vec4 screen_color = texture(screen_texture, SCREEN_UV + noise1.r * noise2.r * distorsion_strength);
	//vec4 screen_color = texture(screen_texture, vec2(SCREEN_UV.x, SCREEN_UV.y + noise1.r * noise2.r * distorsion_strength));
	vec4 screen_color = texture(screen_texture, vec2(SCREEN_UV.x, move_y(SCREEN_UV.x, SCREEN_UV.y, noise1, noise2)));
	COLOR = noise_mix;
	COLOR = mix(screen_color, noise_mix, 0.0);
}