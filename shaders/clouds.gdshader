shader_type canvas_item;

//void vertex() {
	//// Called for every vertex the material is visible on.
//}

//	Simplex 3D Noise by Ian McEwan, Ashima Arts
vec4 permute(vec4 x){return mod(((x*34.0)+1.0)*x, 289.0);}
vec4 taylorInvSqrt(vec4 r){return 1.79284291400159 - 0.85373472095314 * r;}

float noise(vec3 v){
  const vec2  C = vec2(1.0/6.0, 1.0/3.0) ;
  const vec4  D = vec4(0.0, 0.5, 1.0, 2.0);

// First corner
  vec3 i  = floor(v + dot(v, C.yyy) );
  vec3 x0 =   v - i + dot(i, C.xxx) ;

// Other corners
  vec3 g = step(x0.yzx, x0.xyz);
  vec3 l = 1.0 - g;
  vec3 i1 = min( g.xyz, l.zxy );
  vec3 i2 = max( g.xyz, l.zxy );

  //  x0 = x0 - 0. + 0.0 * C
  vec3 x1 = x0 - i1 + 1.0 * C.xxx;
  vec3 x2 = x0 - i2 + 2.0 * C.xxx;
  vec3 x3 = x0 - 1. + 3.0 * C.xxx;

// Permutations
  i = mod(i, 289.0 );
  vec4 p = permute( permute( permute(
             i.z + vec4(0.0, i1.z, i2.z, 1.0 ))
           + i.y + vec4(0.0, i1.y, i2.y, 1.0 ))
           + i.x + vec4(0.0, i1.x, i2.x, 1.0 ));

// Gradients
// ( N*N points uniformly over a square, mapped onto an octahedron.)
  float n_ = 1.0/7.0; // N=7
  vec3  ns = n_ * D.wyz - D.xzx;

  vec4 j = p - 49.0 * floor(p * ns.z *ns.z);  //  mod(p,N*N)

  vec4 x_ = floor(j * ns.z);
  vec4 y_ = floor(j - 7.0 * x_ );    // mod(j,N)

  vec4 x = x_ *ns.x + ns.yyyy;
  vec4 y = y_ *ns.x + ns.yyyy;
  vec4 h = 1.0 - abs(x) - abs(y);

  vec4 b0 = vec4( x.xy, y.xy );
  vec4 b1 = vec4( x.zw, y.zw );

  vec4 s0 = floor(b0)*2.0 + 1.0;
  vec4 s1 = floor(b1)*2.0 + 1.0;
  vec4 sh = -step(h, vec4(0.0));

  vec4 a0 = b0.xzyw + s0.xzyw*sh.xxyy ;
  vec4 a1 = b1.xzyw + s1.xzyw*sh.zzww ;

  vec3 p0 = vec3(a0.xy,h.x);
  vec3 p1 = vec3(a0.zw,h.y);
  vec3 p2 = vec3(a1.xy,h.z);
  vec3 p3 = vec3(a1.zw,h.w);

//Normalise gradients
  vec4 norm = taylorInvSqrt(vec4(dot(p0,p0), dot(p1,p1), dot(p2, p2), dot(p3,p3)));
  p0 *= norm.x;
  p1 *= norm.y;
  p2 *= norm.z;
  p3 *= norm.w;

// Mix final noise value
  vec4 m = max(0.6 - vec4(dot(x0,x0), dot(x1,x1), dot(x2,x2), dot(x3,x3)), 0.0);
  m = m * m;
  return 42.0 * dot( m*m, vec4( dot(p0,x0), dot(p1,x1),
                                dot(p2,x2), dot(p3,x3) ) );
}



uniform int OCTAVES: hint_range(0, 6, .5) = 2;
uniform float AMPLITUDE = 1.75;
uniform float FREQ = 1.0;
uniform float LACUNARITY = 2.0;
uniform float GAIN: hint_range(0, 1.0, .05) = .75;
uniform int pixelation_amount = 100;
uniform float OPACITY: hint_range(0.0, 1.0, 0.025) = .25;
uniform float SCROLL_SPEED = .25;

uniform float Y_STRETCH: hint_range(0.0, 8.0, .5) = 1.0;



float fbm(vec3 x) {
	float value = 0.0;
	float freq = FREQ;
	float amplitude = AMPLITUDE;

    for (int i = 0; i < OCTAVES; ++i) {
        float sn = noise(x * freq);
        value += amplitude * sn;
        freq *= LACUNARITY;
		amplitude *= GAIN;
	}
	return value;
}





vec3 colorize(float grey) {
	if (grey < .3)
		return vec3(91.0 / 255.0, 110.0 / 255.0, 225.0 / 255.0);
	else if (grey < .7)
		return vec3(203.0 / 255.0, 219.0 / 255.0, 252.0 / 255.0);
	else
		return vec3(255.0 / 255.0, 255.0 / 255.0, 255.0 / 255.0);
}

const vec3 magic = vec3(0.06711056f, 0.00583715f, 52.9829189f);

uniform float intensity: hint_range(0.0, 1.0, 0.05) = 0.0;

//group_uniforms player;
//uniform float player_influence: hint_range(0.0, 1.0, 0.05) = 0.60;
//uniform float radius: hint_range(0.0, 1.0, 0.05) = 0.05;

// --- Constants --- //
const mat4 THRESHOLD_MATRIX = mat4(
		vec4(1.0 / 17.0,  9.0 / 17.0,  3.0 / 17.0, 11.0 / 17.0),
		vec4(13.0 / 17.0,  5.0 / 17.0, 15.0 / 17.0,  7.0 / 17.0),
		vec4(4.0 / 17.0, 12.0 / 17.0,  2.0 / 17.0, 10.0 / 17.0),
		vec4(16.0 / 17.0,  8.0 / 17.0, 14.0 / 17.0,  6.0 / 17.0));


void fragment() {
	vec2 grid_uv = UV;
    if (true) {
        grid_uv = round(UV * float(pixelation_amount)) / float(pixelation_amount);
    }

	// Called for every pixel the material is visible on.
	vec4 col = vec4(fbm(vec3(grid_uv.x, grid_uv.y / Y_STRETCH - TIME * SCROLL_SPEED, TIME / 40.0)));
	float gray = (col.r + col.g + col.b) / 3.0;
	float quantised = step(0.5, gray);
	vec3 c = colorize(gray);
	COLOR = vec4(c, quantised * OPACITY);

	vec2 uv = UV / TEXTURE_PIXEL_SIZE;
	COLOR.a *= step(0.0, THRESHOLD_MATRIX[int(uv.x) % 4][int(uv.y) % 4] + quantised * 1.0 - 1.0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
