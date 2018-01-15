uniform vec2 iResolution;
uniform float iGlobalTime;
 
//build in sampler2D  uniform
uniform sampler2D texture; 
 
 
//to make it easier without going through all the code
//define directive is kind copy paste text for the compiler 
#define iChannel0 texture
 
#define NUM_POINTS 1024
#define SEED 3
 
 
//at compile time mainImage() is not visibel in main()
//your have to order the main function after 
//definition of mainImage() or make a global declaration 
//confuses me also, but i dont know how to explain it better <span class="Emoticon Emoticon1"><span>:)</span></span>
//<a href="http://www.cprogramming.com/declare_vs_define.html" target="_blank" rel="nofollow">http://www.cprogramming.com/declare_vs_define.html</a>
 
void mainImage( out vec4 fragColor, in vec2 fragCoord );
 
 
void main() {
    mainImage(gl_FragColor,gl_FragCoord.xy);
}
 
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord.xy/iResolution.xy;
    //always initialise your especially! Color &or variables
    //otherwise it will fail on cross plattforms
    vec4 Color = vec4(uv,0.5+0.5*sin(iGlobalTime),1.0);
 
    int random = SEED;
 
    int a = 1103515245;
    int c = 12345;
    int m = 2147483648;
 
    vec2 o;
 
    float minDist = 10000000.0;
 
    for (int i = 0; i < NUM_POINTS; i++) {
        random = a * random + c;
 
        o.x = (float(random) / float(m)) * iResolution.x;
 
        random = a * random + c;
 
        o.y = (float(random) / float(m)) * iResolution.y;
 
        //if (distance(fragCoord, o) < minDist) {
            minDist = distance(fragCoord, o);
            vec2 uv = o / iResolution.xy;
            uv.x = 1.0 - uv.x;
           //the Color will added to previos value, not sure
          //if this gives your the effect you are going for
            Color += (texture(iChannel0, uv)) * (1.0 - minDist / 200.0);
        //}
    }

    fragColor = Color;
}