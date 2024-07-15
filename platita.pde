PShader pixelateShader;
PImage img;
PGraphics pg;
PGraphics gameBackground;
PGraphics editedImage;
// Capture cam;
UI ui;

void setup() {
  // Processing config
  size(600, 600, P2D);
  frameRate(10);

  // Paleta de colores
  Colores colores = new Colores();
  color[] paleta = colores.verdecito();

  // UI
  ui = new UI(width, height);

  // Shader
//   pixelateShader = loadShader("dithering.glsl");
//   setShaderColors(paleta);
//   pixelateShader.set("resolution", float(width), float(height));
  // Set fps to 10
  

  // Load the shader
//   pixelateShader = loadShader("circle.glsl");
    
  // Load the background image
//   img = loadImage("img/zebra.jpg");

  // Create a PGraphics object for the background
  

// shader.set("resolution", float(width), float(height));
    // Set the colors for the dithering
    // color[] paleta = colores.verdecito();
    
      // Brightest color
  // Set the resolution uniform
  

//   pixelateShader.set("backgroundTexture", img);

//   ui = new UI(width, height, "Hello World");
//     ui.setTextColor(paleta[2]);
//     ui.setBackgroundColor(paleta[3]);

  
}

void draw() {
    

    pixelateShader.set("time", millis() / 1000.0);

    // Draw the image onto the PGraphics object
    gameBackground.beginDraw();
    gameBackground.shader(pixelateShader);
    gameBackground.rectMode(CENTER);
    gameBackground.rect(width/2, height/2, width, height);
    gameBackground.endDraw();


    // Render the image without breaking aspect ratio, crop the center
    image(gameBackground, 0, 0);

    // Draw a red circle in the mouse pos
    // ui.renderText();

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
void setShaderColors(color[] paleta) {
    pixelateShader.set("color0", colorToFloatArray(paleta[0])[0],colorToFloatArray(paleta[0])[1],colorToFloatArray(paleta[0])[2]); // Darkest color
    pixelateShader.set("color1", colorToFloatArray(paleta[1])[0],colorToFloatArray(paleta[1])[1],colorToFloatArray(paleta[1])[2]);
    pixelateShader.set("color2", colorToFloatArray(paleta[2])[0],colorToFloatArray(paleta[2])[1],colorToFloatArray(paleta[2])[2]);
    pixelateShader.set("color3", colorToFloatArray(paleta[3])[0],colorToFloatArray(paleta[3])[1],colorToFloatArray(paleta[3])[2]);
    pixelateShader.set("color4", colorToFloatArray(paleta[4])[0],colorToFloatArray(paleta[4])[1],colorToFloatArray(paleta[4])[2]);
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

// // Funciton that takes 2 digit hexadecimal and converts into range 0 - 255
// int hexToDec(String hex) {
//     return unhex(hex);
// }


class Escena {

}

public enum DialogType {
    OPCIONES,
    FIN;
}

class Dialogo {
    Dialogo[] opciones = new Dialogo[2];
    String textoOpcion;
    String textoDialogo;
    DialogType tipo;

    Dialogo(String textoDialogo, String textoOpcion, DialogType tipo) {
        this.textoDialogo = textoDialogo;
        this.textoOpcion = textoOpcion;
        this.tipo = tipo;
    }

    void setTextoDialogo(String texto) {
        this.textoDialogo = texto;
    }

    void setOpcionA(Dialogo d) {
        opciones[0] = d;
    }

    void setOpcionB(Dialogo d) {
        opciones[1] = d;
    }
}

// Create a class images that when initialized loads all images from the data/img folder into an array and when pressing a key it changes the image
// Use Java path utilties to load the images
// class Images {
//     PImage[] images;
//     int currentImageIndex;

//     Images() {
//         File folder = new File(sketchPath("data/img"));
//         File[] listOfFiles = folder.listFiles();
//         images = new PImage[listOfFiles.length];
//         for (int i = 0; i < listOfFiles.length; i++) {
//             if (listOfFiles[i].isFile()) {
//                 images[i] = loadImage(listOfFiles[i].getPath());
//             }
//         }
//         currentImageIndex = 0;
//     }

//     void changeImage() {
//         currentImageIndex++;
//         if (currentImageIndex >= images.length) {
//             currentImageIndex = 0;
//         }
//     }

//     PImage getCurrentImage() {
//         return images[currentImageIndex];
//     }
// }

// void keyPressed() {
//     if (key == ' ') {
//         images.changeImage();
//     }
// }