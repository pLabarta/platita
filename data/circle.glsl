#version 150

// Uniform variables for time and resolution
uniform float time;
uniform vec2 resolution;
uniform sampler2D backgroundTexture;

// Define iTime and iResolution for compatibility with Shadertoy
#define iTime time
#define iResolution resolution

// Output variable
out vec4 fragColor;

// Function to apply the grayscale filter
vec4 applyGrayscale(vec4 color) {
    float gray = dot(color.rgb, vec3(0.2126, 0.7152, 0.0722));
    return vec4(vec3(gray), color.a);
}

// Function that receivs grayscale and posterizes it to 5 colors
// from brighter to darker
vec4 applyPosterize(vec4 color) {
    vec3 colorA = vec3(0.92,1.,0.95);
    // Naranja Clarito
    vec3 colorB = vec3(0.976, 0.933, 0.659);
    // Naranja Oscuro
    vec3 colorC = vec3(0.949,0.576,0.204);
    // Violeta Oscuro
    vec3 colorD = vec3(0.302,0.153,0.376);
    // Oscuro
    vec3 colorE = vec3(0.15,0.1,0.15);

    vec3 colorArray[5];
    colorArray[0] = colorE;
    colorArray[1] = colorD;
    colorArray[2] = colorC;
    colorArray[3] = colorB;
    colorArray[4] = colorA;

    float gray = dot(color.rgb, vec3(0.2126, 0.7152, 0.0722));
    float grayStep = 1.0 / 5.0;
    float grayIndex = floor(gray / grayStep);
    return vec4(colorArray[int(grayIndex)], color.a);
}

// Function to apply the pixelation filter
vec2 applyPixelation(vec2 uv, float pixelSize) {
    uv *= resolution / pixelSize;
    uv = floor(uv);
    uv /= resolution / pixelSize;
    return uv;
}

void main(void)
{
    // Normalize coordinates to range from 0 to 1
    vec2 uv = gl_FragCoord.xy / iResolution.xy;

    // Invert the uv.y
    uv.y = 1.0 - uv.y;

    // Apply pixelation filter
    float pixelSize = 5.0; // Adjust the pixel size as needed
    uv = applyPixelation(uv, pixelSize);

    // Sample the background texture
    vec4 bgColor = texture(backgroundTexture, uv);

    // Apply grayscale filter
    vec4 grayColor = applyGrayscale(bgColor);

    // Apply posterize filter
    vec4 posterizeColor = applyPosterize(grayColor);

    // Output the final color
    fragColor = posterizeColor;
}
