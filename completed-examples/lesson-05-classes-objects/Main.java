class Estudiante {
    String nombre;
    int nota;

    // El constructor prepara un nuevo objeto.
    Estudiante(String nombre, int nota) {
        this.nombre = nombre;
        this.nota = nota;
    }

    void mostrarFicha() {
        System.out.println(nombre + " obtuvo " + nota + " puntos.");
    }

    boolean aprobo() {
        return nota >= 11;
    }
}

public class Main {
    public static void main(String[] args) {
        Estudiante ana = new Estudiante("Ana", 16);
        Estudiante luis = new Estudiante("Luis", 9);
        ana.mostrarFicha();
        luis.mostrarFicha();
        System.out.println("¿Ana aprobó? " + ana.aprobo());
    }
}