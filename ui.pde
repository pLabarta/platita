class UI {
    int width;
    int height;

    String text;
    String optionA;
    String optionB;

    PShader shader;
    PGraphics rawBackground;
    PGraphics filteredBackground;
    PImage image;

    String currentText;
    int textPxSize;
    int margin;
    color textColor;
    color bgColor;

    UI(int width, int height) {
        this.width = width;
        this.height = height;
        this.text = "";
        this.margin = 10;
        this.textPxSize = 32;
        this.currentText = "";
        this.textColor = color(0);
        this.bgColor = color(255);

        this.image = loadImage("img/zebra.jpg");

        this.shader = loadShader("dithering.glsl");
        this.rawBackground = createGraphics(width, height, P2D);
        this.filteredBackground = createGraphics(width, height, P2D);

        this.shader.set("resolution", float(width), float(height));
        setShaderColors(shader, new Colores().mil());
        this.shader.set("backgroundTexture", image);
    }

    void loadDialogo(Dialogo d) {
        this.text = d.texto;
        this.optionA = d.optionA;
        this.optionB = d.optionB;
    }

    void setTextColor(color c) {
        this.textColor = c;
    }

    void setImage(String imgPath) {
        this.image = loadImage(imgPath);
    }

    void setBackgroundColor(color c) {
        this.bgColor = c;
    }

    // Function that renders the text one character at a time with a delay until it reaches the end and shows the full text
    void renderText() {
        fill(bgColor);
        noStroke();
        rectMode(CORNER);
        rect(margin, height/4*3, width - margin * 2, height/4-margin);
        textSize(textPxSize);
        fill(textColor);
        text(currentText, margin*2, height/4*3+textPxSize+margin);
        if (currentText.length() < text.length()) {
                currentText = text.substring(0, currentText.length() + 1);
        }
    }
}

// Function that convers a color into an array of 3 floats from 0.0 to 1.0 for using in the shader colors
float[] colorToFloatArray(color c) {
    float[] colorArray = new float[3];
    colorArray[0] = red(c) / 255.0;
    colorArray[1] = green(c) / 255.0;
    colorArray[2] = blue(c) / 255.0;
    return colorArray;
}

// Function to set shader colors from a color[5] array named paleta
void setShaderColors(PShader shader ,color[] paleta) {
    shader.set("color0", colorToFloatArray(paleta[0])[0],colorToFloatArray(paleta[0])[1],colorToFloatArray(paleta[0])[2]); // Darkest color
    shader.set("color1", colorToFloatArray(paleta[1])[0],colorToFloatArray(paleta[1])[1],colorToFloatArray(paleta[1])[2]);
    shader.set("color2", colorToFloatArray(paleta[2])[0],colorToFloatArray(paleta[2])[1],colorToFloatArray(paleta[2])[2]);
    shader.set("color3", colorToFloatArray(paleta[3])[0],colorToFloatArray(paleta[3])[1],colorToFloatArray(paleta[3])[2]);
    shader.set("color4", colorToFloatArray(paleta[4])[0],colorToFloatArray(paleta[4])[1],colorToFloatArray(paleta[4])[2]);
}

class Colores {
    Colores() {
    }

    color[] mil() {
        color[] mil = new color[5];
        mil[4] = color(235, 255, 242); // Claro
        mil[3] = color(249, 238, 168);
        mil[2] = color(242, 147, 52);
        mil[1] = color(77, 39, 96);
        mil[0] = color(38, 25, 38); // Oscuro
        return mil;
    }

    color[] cien() {
        color[] cien = new color[5];
        cien[4] = color(255, 255, 255); // Claro
        cien[3] = color(255, 255, 255);
        cien[2] = color(255, 255, 255);
        cien[1] = color(255, 255, 255);
        cien[0] = color(255, 255, 255); // Oscuro
        return cien;
    }

    color[] violeta() {
        color[] violeta = new color[5];
        // violeta[4] = color("BF4B75"); // Claro
        // violeta[3] = color("#40363F");
        // violeta[2] = color("#554759");
        // violeta[1] = color("#81708C");
        // violeta[0] = color("#261D17"); // Oscuro
        violeta[4] = color(191, 75, 117); // Claro
        violeta[3] = color(191, 75, 117);
        violeta[2] = color(85, 71, 89);
        violeta[1] = color(129, 112, 140);
        violeta[0] = color(38, 29, 23); // Oscuro

        return violeta;
    
    }

    color[] verdecito() {
        color[] verdecito = new color[5];
        verdecito = hexToColor(new String[] {"#034159","#025951","#02735E","#038C3E","#0CF25D"});
        return verdecito;
    }
    
}

// Function that converts hexadecimal color string array to Colores method
color[] hexToColor(String[] hex) {
    color[] colores = new color[5];
    for (int i = 0; i < hex.length; i++) {
        colores[i] = color(unhex(hex[i].substring(1, 3)), unhex(hex[i].substring(3, 5)), unhex(hex[i].substring(5, 7)));
    }
    return colores;
}