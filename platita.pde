PShader pixelateShader;
PImage img;
PGraphics pg;
PGraphics gameBackground;
PGraphics editedImage;
// Capture cam;
UI ui;

Story story;

void setup() {
  // Processing config
  size(600, 600, P2D);
  frameRate(10);

  // Paleta de colores
  Colores colores = new Colores();
  color[] paleta = colores.verdecito();

  // UI
  ui = new UI(width, height);

  gameBackground = createGraphics(width, height, P2D);

  story = new Story(width, height);
  story.loadDefault();

  ui.loadDialogo(story.getCurrentDialogo());


}

void draw() {
    
    gameBackground.beginDraw();
    gameBackground.shader(ui.shader);
    gameBackground.rectMode(CENTER);
    gameBackground.rect(width/2, height/2, width, height);
    gameBackground.endDraw();

    image(gameBackground, 0, 0);

    
    ui.renderText();
    

    

    // // Draw the image onto the PGraphics object
    // gameBackground.beginDraw();
    // gameBackground.shader(pixelateShader);
    // gameBackground.rectMode(CENTER);
    // gameBackground.rect(width/2, height/2, width, height);
    // gameBackground.endDraw();


    // // Render the image without breaking aspect ratio, crop the center
    

    // Draw a red circle in the mouse pos
    // ui.renderText();

}

void keyPressed() {
    // A or left arrow
    if (key == 'a' || key == CODED && keyCode == LEFT) {
        story.loadOptionA();
        ui.loadDialogo(story.getCurrentDialogo());
    } else if (key == 'd' || key == CODED && keyCode == RIGHT) {
        story.loadOptionB();
        ui.loadDialogo(story.getCurrentDialogo());
    }
}

class Escena {

}

public enum DialogType {
    OPCIONES,
    FIN;
}