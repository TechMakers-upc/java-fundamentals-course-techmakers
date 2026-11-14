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
        Estudiante[] grupo = {
            new Estudiante("Ana", 16),
            new Estudiante("Luis", 12)
        };
        for (Estudiante e : grupo) {
            System.out.println(e.getNombre());
        }
        // RETO: suma las notas, calcula el promedio y muéstralo.
        // RETO: agrega un tercer estudiante.
    }
}