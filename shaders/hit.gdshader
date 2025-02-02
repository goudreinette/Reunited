shader_type canvas_item;



uniform bool active = false;
uniform vec4 hit_color: source_color = vec4(1.0);
//uniform float blink_speed: hint_range(0.125, 2.0, .125) = 0.25;
//uniform bool blink_on = true;





void fragment() {
	//vec4 curr_color = texture(TEXTURE, UV);

	//if (mod(TIME, blink_speed) < TIME / 2.0) {
		//COLOR = vec4(1.0,1.0,1.0,1.0);
	//} else {
		//COLOR = curr_color;
	//}

	vec4 previous_color = texture(TEXTURE, UV);
	vec4 white_color = vec4(hit_color.rgb, previous_color.a);
	vec4 new_color = previous_color;
	if (active == true) {
		new_color = white_color;
	}

	COLOR = new_color;
}
