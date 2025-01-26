shader_type canvas_item;

//void vertex() {
	//// Called for every vertex the material is visible on.
//}

float rand(vec2 coord){
    return fract(sin(dot(coord, vec2(56, 78)) * 1000.0) * 1000.0);
}

float noise(vec2 coord){
    vec2 i = floor(coord);
    vec2 f = fract(coord);

    float a = rand(i);
    float b = rand(i + vec2(1.0, 0.0));
    float c = rand(i + vec2(0.0, 1.0));
    float d = rand(i + vec2(1.0, 1.0));

    vec2 cubic = f * f * (3.0 - 2.0 * f);

    return mix(a, b, cubic.x) + (c - a) * cubic.y * (1.0 - cubic.x) + (d - b) * cubic.x * cubic.y;
}

uniform int OCTAVES = 2;

float fbm(vec2 coord){
    float value = 0.0;
    float scale = 0.5;

    for(int i = 0; i < OCTAVES; i++){
        value += noise(coord) * scale;
        coord *= 2.0;
        scale *= 0.5;
    }
    return value;
}

uniform int pixelation_amount = 100;

void fragment() {
	vec2 grid_uv = UV;
    if (true) {
        grid_uv = round(UV * float(pixelation_amount)) / float(pixelation_amount);
    }

	// Called for every pixel the material is visible on.
	vec4 col = vec4(fbm(vec2(grid_uv.x * 10.0, grid_uv.y * 2.0 - TIME)));
	float gray = (col.r + col.g + col.b) / 3.0;
	float quantised = step(0.6, gray);
	COLOR = vec4(1.0, 1.0, 1.0, quantised * .3);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
