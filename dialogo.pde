class Story {
    HashMap<String, Dialogo> dialogos;
    String current;
    int width;
    int height;

    Story(int widthPantalla, int heightPantalla) {
        this.width = widthPantalla;
        this.height = heightPantalla;
        dialogos = new HashMap<String, Dialogo>();
    }

    void triggerRender() {
        Dialogo d = dialogos.get(current);
        ui.loadDialogo(d);
        ui.renderText();
    }


    void loadDefault() {
        dialogos.put("inicio", inicio());
        dialogos.put("jugar", jugar());
        dialogos.put("salir", salir());
        current = "inicio";
    }

    void loadOptionA() {
        Dialogo d = dialogos.get(dialogos.get(current).optionA);
        current = d.name;
    }

    void loadOptionB() {
        Dialogo d = dialogos.get(dialogos.get(current).optionB);
        current = d.name;
    }

    Dialogo getCurrentDialogo() {
        return dialogos.get(current);
    }
}

class Dialogo {
    String name;
    String texto;
    String imgPath;
    String soundPath;

    String optionA;
    String labelA;

    String optionB;
    String labelB;

    Dialogo() {
        this.name = "default";
        this.texto = "Texto del dialogo";
        this.imgPath = "img/placeholder.png";
        this.soundPath = "sound/placeholder.mp3";

        this.optionA = "default";
        this.labelA = "First option";

        this.optionB = "default";
        this.labelB = "Second option";
    }



}

Dialogo inicio() {
    Dialogo d = new Dialogo();
    d.name = "inicio";
    d.texto = "Bienvenidx a Platita Interactiva";
    d.imgPath = "img/inicio.png";
    d.soundPath = "sound/inicio.mp3";

    d.optionA = "jugar";
    d.labelA = "Jugar";

    d.optionB = "salir";
    d.labelB = "salir";

    return d;
}

Dialogo jugar() {
    Dialogo d = new Dialogo();
    d.name = "jugar";
    d.texto = "Jugando";
    d.imgPath = "img/jugar.png";
    d.soundPath = "sound/jugar.mp3";

    d.optionA = "ganar";
    d.labelA = "Ganar";

    d.optionB = "perder";
    d.labelB = "Perder";

    return d;
}

Dialogo salir() {
    Dialogo d = new Dialogo();
    d.name = "salir";
    d.texto = "Adios";
    d.imgPath = "img/salir.png";
    d.soundPath = "sound/salir.mp3";

    d.optionA = "default";
    d.labelA = "default";

    d.optionB = "default";
    d.labelB = "default";

    return d;
}

