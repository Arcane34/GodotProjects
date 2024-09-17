shader_type canvas_item;

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}



void vertex() {
	
}

uniform float threshold = 0.5;

void fragment() {
	// Get the pixel color from the texture
	COLOR.rgb = vec3(.0,.0,.0);
	vec4 pixel_color = texture(TEXTURE, UV);
	if (pixel_color.r < threshold){
		COLOR.rgb = vec3(1.0);
	}
	//float col = sin(pixel_color.r * 30. + TIME);
	//COLOR.rgb = vec3(0.02/col);
}