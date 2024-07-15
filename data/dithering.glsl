#version 150

// Uniform variables for time and resolution
uniform float time;
uniform vec2 resolution;
uniform sampler2D backgroundTexture;

// Uniform variables for colors
uniform vec3 color0;
uniform vec3 color1;
uniform vec3 color2;
uniform vec3 color3;
uniform vec3 color4;

// Define iTime and iResolution for compatibility with Shadertoy
#define iTime time
#define iResolution resolution

// Output variable
out vec4 fragColor;

// Function to apply the grayscale filter
float applyGrayscale(vec4 color) {
    return dot(color.rgb, vec3(0.2126, 0.7152, 0.0722));
}

void main(void)
{
    // Normalize coordinates to range from 0 to 1
    vec2 uv = gl_FragCoord.xy / iResolution.xy;

    // Invert the uv.y
    uv.y = 1.0 - uv.y;

    // Sample the background texture
    vec4 bgColor = texture(backgroundTexture, uv);

    // Apply grayscale filter
    float gray = applyGrayscale(bgColor);

    // 8x8 Bayer matrix for dithering
    float bayerMatrix[64] = float[](
        0.0/64.0, 48.0/64.0, 12.0/64.0, 60.0/64.0, 3.0/64.0, 51.0/64.0, 15.0/64.0, 63.0/64.0,
        32.0/64.0, 16.0/64.0, 44.0/64.0, 28.0/64.0, 35.0/64.0, 19.0/64.0, 47.0/64.0, 31.0/64.0,
        8.0/64.0, 56.0/64.0, 4.0/64.0, 52.0/64.0, 11.0/64.0, 59.0/64.0, 7.0/64.0, 55.0/64.0,
        40.0/64.0, 24.0/64.0, 36.0/64.0, 20.0/64.0, 43.0/64.0, 27.0/64.0, 39.0/64.0, 23.0/64.0,
        2.0/64.0, 50.0/64.0, 14.0/64.0, 62.0/64.0, 1.0/64.0, 49.0/64.0, 13.0/64.0, 61.0/64.0,
        34.0/64.0, 18.0/64.0, 46.0/64.0, 30.0/64.0, 33.0/64.0, 17.0/64.0, 45.0/64.0, 29.0/64.0,
        10.0/64.0, 58.0/64.0, 6.0/64.0, 54.0/64.0, 9.0/64.0, 57.0/64.0, 5.0/64.0, 53.0/64.0,
        42.0/64.0, 26.0/64.0, 38.0/64.0, 22.0/64.0, 41.0/64.0, 25.0/64.0, 37.0/64.0, 21.0/64.0
    );

    int x = int(mod(gl_FragCoord.x, 8.0));
    int y = int(mod(gl_FragCoord.y, 8.0));
    float threshold = bayerMatrix[y * 8 + x];

    // Convert to 2-bit grayscale (4 levels)
    float grayLevel = floor(gray * 4.0 + threshold);

    // Map grayLevel to colors array
    vec3 color;
    if (grayLevel == 0.0) {
        color = color0;
    } else if (grayLevel == 1.0) {
        color = color1;
    } else if (grayLevel == 2.0) {
        color = color2;
    } else if (grayLevel == 3.0) {
        color = color3;
    } else {
        color = color4;
    }

    // Output the final color
    fragColor = vec4(color, bgColor.a);
}
