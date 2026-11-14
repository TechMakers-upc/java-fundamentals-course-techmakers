class Estudiante {
    String nombre;
    int nota;

    Estudiante(String nombre, int nota) {
        this.nombre = nombre;
        this.nota = nota;
    }

    // RETO: añade el método void mostrarFicha().
    // RETO: añade el método boolean aprobo().
}

public class Main {
    public static void main(String[] args) {
        Estudiante ana = new Estudiante("Ana", 16);
        System.out.println(ana.nombre);
        // RETO: crea un segundo objeto y muestra su ficha.
    }
}