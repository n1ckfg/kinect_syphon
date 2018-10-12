uniform vec3 iResolution;

uniform sampler2D tex0;
uniform sampler2D tex1;

uniform float threshold;
uniform float alpha;

vec4 threshFilter(vec3 v) {
	float avg = (v.x + v.y + v.z) / 3.0;
    if (avg > threshold / 255.0) {
      return vec4(1,1,1,1);
    } else {
      return vec4(0,0,0,alpha);
    }
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	vec2 uv = fragCoord.xy / iResolution.xy;
	vec2 uv2 = vec2(uv.x, abs(1.0 - uv.y));

	vec4 col0 = texture2D(tex0, uv2);
	vec4 col1 = texture2D(tex1, uv2);

	vec4 mask = threshFilter(col0.xyz);

	fragColor = col1 * mask;
}

void main() {
	mainImage(gl_FragColor, gl_FragCoord.xy);
}