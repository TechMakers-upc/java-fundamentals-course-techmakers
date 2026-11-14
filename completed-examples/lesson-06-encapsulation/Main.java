class Estudiante {
    private String nombre;
    private int nota;

    Estudiante(String nombre, int nota) {
        this.nombre = nombre;
        setNota(nota);
    }

    String getNombre() {
        return nombre;
    }

    int getNota() {
        return nota;
    }

    void setNota(int nuevaNota) {
        if (nuevaNota >= 0 && nuevaNota <= 20) {
            nota = nuevaNota;
        } else {
            System.out.println("Error: la nota debe estar entre 0 y 20.");
        }
    }
}

public class Main {
    public static void main(String[] args) {
        Estudiante ana = new Estudiante("Ana", 15);
        System.out.println(ana.getNombre() + ": " + ana.getNota());
        ana.setNota(18);
        System.out.println("Nueva nota: " + ana.getNota());
        ana.setNota(25); // La validación impide esta actualización.
        System.out.println("Nota final: " + ana.getNota());
    }
}