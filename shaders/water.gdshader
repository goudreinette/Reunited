shader_type canvas_item;


float voronoi(vec2 uv) {
    vec2 i = floor(uv);
    vec2 f = fract(uv);
    float minDist1 = 1.0;
    float minDist2 = 1.0;
    for (int y = -1; y <= 1; y++) {
        for (int x = -1; x <= 1; x++) {
            vec2 neighbor = vec2(float(x), float(y));
            vec2 point = vec2(fract(sin(dot(i + neighbor, vec2(127.1, 311.7))) * 43758.5453));
            vec2 diff = neighbor + point - f;
            float dist = length(diff);

            float step1 = 1.0 - step(minDist1, dist);
            float step2 = 1.0 - step(minDist2, dist);

            minDist2 = minDist1 * step1 + (1.0 - step1) * (step2 * dist) + ((1.0 - step1)*(1.0 - step2)) * minDist2;
            minDist1 = dist * step1 + (1.0 - step1) * minDist1;
        }
    }
    return minDist2 - minDist1;
}


uniform float DISTORTION_SPEED: hint_range(0.0, 5.0, .1) = 2.0;
uniform float DISTORTION_STRENGTH: hint_range(0.0, 1.0, .01) = 0.17;
uniform float SCALE: hint_range(0.0, 30.0, .5) = 20.0;


void fragment() {
	// Pixelate it :D                             // This vector moves the water, to hide a certain issue
    vec2 uv = UV.xy;


    // More vibrant than the original!
    vec3 mainBlue = vec3(91.0 / 255.0, 110.0 / 255.0, 225.0 / 255.0);
    vec3 lightBlue = vec3(91.0 / 255.0, 110.0 / 255.0, 225.0 / 255.0); //vec3(99.0 / 255.0, 155.0 / 255.0, 255.0 / 255.0);
    //vec3 lightBlue = vec3(99.0 / 255.0, 155.0 / 255.0, 255.0 / 255.0);
    vec3 foamColor = vec3(96.0 / 255.0, 115.0 / 255.0, 227.0 / 255.0); // vec3(99.0 / 255.0, 155.0 / 255.0, 255.0 / 255.0); //vec3(203.0 / 255.0, 219.0 / 255.0, 252.0 / 255.0);

    // I decided to use the second color, to fade the foam a bit more, which is why they'll share the same UV :)
    float scale1 = SCALE;
    float distortion1Strength = DISTORTION_STRENGTH;
    float distortion1Frequency = 6.0;
    float distortion1Speed = DISTORTION_SPEED;
    float edge1ThresholdMin = 0.01;
    float edge1ThresholdMax = 0.18;
    float edge2ThresholdMin = 0.1;
    float edge2ThresholdMax = 0.2;

    vec2 uv1 = uv * scale1;

    vec2 distortedUV1 = uv1 + vec2(
        sin(TIME * distortion1Speed + uv1.y * distortion1Frequency) * distortion1Strength,
        cos(TIME * distortion1Speed + uv1.x * distortion1Frequency) * distortion1Strength
    );


    float edgeDist1 = voronoi(distortedUV1);
    float edges1 = smoothstep(edge1ThresholdMin, edge1ThresholdMax, edgeDist1);

    float edge1Halo = smoothstep(0.01, 0.04, edgeDist1); // Lighter effect around white lines

    float edges2 = smoothstep(edge2ThresholdMin, edge2ThresholdMax, edgeDist1);


    vec3 e = mix(lightBlue, mainBlue, step(0.5, edges2));
    e = mix(foamColor, e, step(0.5, edges1));


    e *= 0.1 + 1.0 - edge1Halo * 0.1;

    COLOR = vec4(vec3(e), smoothstep(0, 0.5, UV.y));
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
