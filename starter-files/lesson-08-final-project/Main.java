import java.util.Scanner;

class Estudiante {
    private String nombre;
    private int nota;
    Estudiante(String nombre, int nota) {
        this.nombre = nombre;
        this.nota = nota;
    }
    String getNombre() { return nombre; }
    int getNota() { return nota; }
}

public class Main {
    public static void main(String[] args) {
        Scanner entrada = new Scanner(System.in);
        Estudiante[] grupo = new Estudiante[10];
        int cantidad = 0;
        System.out.println("Registro de estudiantes");
        // RETO: crea un menú para registrar, listar y buscar estudiantes.
        // RETO: valida la nota (0 a 20) y evita exceder el array.
        // SOLUCIÓN: consulta completed-examples/lesson-08-final-project/Main.java.
    }
}