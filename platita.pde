import processing.video.*;

PShader pixelateShader;
PImage img;
PGraphics pg;
PGraphics gameBackground;
PGraphics editedImage;
// Capture cam;
UI ui;

Story story;

String mode;

Historia historia;

Writer writer;

String inputText = "";
boolean controlPressed = false;
Capture cam;

void setup() {
  // Processing config
  size(800, 600, P2D);
  frameRate(10);

  // Writer o Reader mode
  historia = loadHistoria("data/stories/inicio.json");
  mode = "historia";

  // Paleta de colores
  Colores colores = new Colores();
  color[] paleta = colores.verdecito();

  // UI
  ui = new UI(width, height);

  gameBackground = createGraphics(width, height, P2D);

  story = new Story(width, height);
  story.loadDefault();

  ui.loadDialogo(story.getCurrentDialogo());

  // Test historia JSON

//   Historia historia = new Historia("algo de prueba", "M", 25, 1000, "Texto de prueba", "img/placeholder.png");
//   saveHistoria(historia, "data/stories/"+historia.nombre+".json");

    // Historia historia2 = loadHistoria("data/stories/historia.json");
    // println(historia2.nombre);

    cam = new Capture(this, 640, 480);
    cam.start();
    

}

void draw() {
    
    gameBackground.beginDraw();
    gameBackground.shader(ui.shader);
    gameBackground.rectMode(CENTER);
    gameBackground.rect(width/2, height/2, width, height);
    gameBackground.endDraw();

    image(gameBackground, 0, 0);

    if (mode == "writer") {
        if (cam.available() == true) {
            cam.read();
        }
        ui.setLiveImage(cam);
        ui.renderFullText(inputText);
    } else if (mode == "historia") {
        ui.setImage(historia.imgPath);
        ui.renderHistoria(historia);
    }
    
}

void keyPressed() {

    println(controlPressed);

    println(key);

    if (controlPressed && key == ENTER && mode == "writer") {
        println("CONTROL + S");
        
        PImage camImage = cam.get();
        camImage.save("data/img/"+inputText.substring(0, 4)+".png");
        

        Historia nuevaHistoria = new Historia(
            inputText.substring(0, 4),
            "M",
            25,
            1000,
            inputText,
            "img/"+inputText.substring(0, 4)+".png"
        );
        saveHistoria(nuevaHistoria, "data/stories/"+nuevaHistoria.nombre+".json");
        mode = "menu";
    }

    if (key == CODED && keyCode == 17) {
        println("CONTROL pressed");
        controlPressed = true; // Set the flag when CONTROL is pressed
    }

    if (mode == "writer") {
        println(key);
        println(inputText);
        if (key == BACKSPACE && inputText.length() > 0) {
            inputText = inputText.substring(0, inputText.length() - 1); // Remove last character
        } else if (key != CODED) {
            inputText += key; // Append the typed character to inputText
        }
    } else {
        if (key == 'a' || key == CODED && keyCode == LEFT) {
            String randomPath = getRandomJsonFilePath();
            historia = loadHistoria(randomPath);
            mode = "historia";
            // story.loadOptionA();
            // ui.loadDialogo(story.getCurrentDialogo());
        // } else if (key == 'd' || key == CODED && keyCode == RIGHT) {
        //     story.loadOptionB();
        //     ui.loadDialogo(story.getCurrentDialogo());
        } else if (key == 'w') {
            mode = "writer";
        } 
    }

    
}

void keyReleased() {
    if (key == CODED && keyCode == 17) {
        println("CONTROL released");
        controlPressed = false; // Reset the flag when CONTROL is released
    }
}