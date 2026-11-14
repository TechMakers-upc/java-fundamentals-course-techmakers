class Estudiante {
    private String nombre;
    private int nota;

    Estudiante(String nombre, int nota) {
        this.nombre = nombre;
        this.nota = nota;
    }

    String getNombre() { return nombre; }
    int getNota() { return nota; }
    // RETO: añade setNota(int nuevaNota) y valida un rango de 0 a 20.
}

public class Main {
    public static void main(String[] args) {
        Estudiante ana = new Estudiante("Ana", 15);
        System.out.println(ana.getNombre() + ": " + ana.getNota());
        // RETO: intenta actualizar la nota y prueba un valor inválido.
    }
}