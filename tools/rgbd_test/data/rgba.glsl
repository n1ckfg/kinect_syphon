// Created by inigo quilez - iq/2013 
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

uniform vec3 iResolution;

uniform sampler2D tex0;
uniform sampler2D tex1;

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	vec2 uv = fragCoord.xy / iResolution.xy;
	uv.y = abs(1.0 - uv.y);

	vec4 t0 = texture2D(tex0, uv);
	vec4 t1 = texture2D(tex1, uv);
	vec4 col = vec4(t0.xyz, t1.x);

	fragColor = col;
}

void main() {
	mainImage(gl_FragColor, gl_FragCoord.xy);
}