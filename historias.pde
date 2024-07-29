import java.io.File;
import java.util.Random;

class Historia {
    String nombre;
    String gender;
    int edad;
    int ingresos;
    String texto;
    String imgPath;

    Historia(
        String nombre,
        String gender,
        int edad,
        int ingresos,
        String texto,
        String imgPath
    ) {

        this.nombre = nombre;
        this.gender = gender;
        this.edad = edad;
        this.ingresos = ingresos;
        this.texto = texto;
        this.imgPath = imgPath;
        
        }
}

void validateNombre (String nombre) {
    if (nombre.length() < 3) {
        throw new IllegalArgumentException("El nombre debe tener al menos 3 caracteres");
    }
}

void validateEdad (int edad) {
    if (edad < 3 || edad > 100) {
        throw new IllegalArgumentException("La edad debe estar entre 3 y 100 años");
    }
}

// Create a function that loads an Historia object from a JSON file using JSONObject
Historia loadHistoria(String path) {
    JSONObject json = loadJSONObject(path);
    String nombre = json.getString("nombre");
    String gender = json.getString("gender");
    int edad = json.getInt("edad");
    int ingresos = json.getInt("ingresos");
    String texto = json.getString("texto");
    String imgPath = json.getString("imgPath");

    return new Historia(nombre, gender, edad, ingresos, texto, imgPath);
}

// Create a function that saves an Historia object to a JSON file using JSONObject
void saveHistoria(Historia historia, String path) {
    JSONObject json = new JSONObject();
    json.setString("nombre", historia.nombre);
    json.setString("gender", historia.gender);
    json.setInt("edad", historia.edad);
    json.setInt("ingresos", historia.ingresos);
    json.setString("texto", historia.texto);
    json.setString("imgPath", historia.imgPath);

    saveJSONObject(json, path);
}

String getRandomJsonFilePath() {
    File folder = new File(dataPath("stories"));
    File[] listOfFiles = folder.listFiles((dir, name) -> name.toLowerCase().endsWith(".json"));

    if (listOfFiles != null && listOfFiles.length > 0) {
        Random random = new Random();
        int index = random.nextInt(listOfFiles.length);
        return listOfFiles[index].getAbsolutePath();
    } else {
        println("No .json files found in the data/stories folder.");
        return null;
    }
}

