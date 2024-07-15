class UI {
    int width;
    int height;

    String text;
    String optionA;
    String optionB;

    PShader shader;
    PGraphics rawBackground;
    PGraphics filteredBackground;

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

        this.shader = loadShader("dithering.glsl");
        this.rawBackground = createGraphics(width, height, P2D);
        this.filteredBackground = createGraphics(width, height, P2D);
    }

    void loadDialogo(Dialogo d) {
        this.text = d.texto;
        this.optionA = d.optionA;
        this.optionB = d.optionB;
    }

    void setTextColor(color c) {
        this.textColor = c;
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