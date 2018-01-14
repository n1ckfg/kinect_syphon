uniform vec3 iResolution; 

uniform sampler2D texture1;
uniform sampler2D texture2;

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	vec2 uv = fragCoord.xy / iResolution.xy;
	vec4 col1 = texture2D(texture1, uv);
	vec4 col2 = texture2D(texture2, uv);

    fragColor = vec4(col1[0], col1[1], col1[2], col2[3])
}

void main() {
	mainImage(gl_FragColor, gl_FragCoord.xy);
}