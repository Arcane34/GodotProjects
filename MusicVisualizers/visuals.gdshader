shader_type canvas_item;

// COLOR is the COLOR of a pixel
// TIME is global time
// UV pixel coords

void vertex() {
	// Called for every vertex the material is visible on.
	
	//if (VERTEX.y < 0.0){
		//VERTEX += vec2(sin(TIME * 0.5) * 100.0 , 0);
	//}
}

vec3 palette(float t){
	vec3 a = vec3(0.000, 0.338, 0.500);
	vec3 b = vec3(0.000, 0.500, 0.500);
	vec3 c = vec3(0.498, 0.500, 0.333);
	vec3 d = vec3(2.138, 0.500, 0.667);
	return a + b *cos( 6.28318*(c*t+d) );
}

void fragment() {
	// Called for every pixel the material is visible on.
	
	//vec3 color_without_blue = vec3(COLOR.rgb ) * vec3(1,1,1);
	//float amount_of_gr = length(color_without_blue);
	//float green_red_mask = step(0.01, amount_of_gr);
	//vec3 ret_color = COLOR.rgb * green_red_mask;
	//float blue_mask = (1.0 - green_red_mask) * COLOR.b;
	//COLOR.rgb = vec3(blue_mask);
	vec2 st = UV;
	vec2 resolution = (1.0/SCREEN_PIXEL_SIZE);
	st = (FRAGCOORD.xy * 2.0 - resolution)/ resolution.y;

	
	
	float repeat = 8.0;
	float d = length(st);
	
	//vec3 col = vec3(1.0,0.0,0.0);
	vec3 col = palette(d + TIME);
	
	
	d = sin(d * repeat + TIME) / repeat;
	d= abs(d);
	d= .02/d;
	
	col *= d;
	
	COLOR.rgb = vec3(col);
	//COLOR.rgb = vec3(d);
	
	
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
