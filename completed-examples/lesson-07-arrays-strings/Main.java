class Estudiante {
    private String nombre;
    private int nota;

    Estudiante(String nombre, int nota) {
        this.nombre = nombre;
        this.nota = nota;
    }

    String getNombre() {
        return nombre;
    }

    int getNota() {
        return nota;
    }
}

public class Main {
    public static void main(String[] args) {
        Estudiante[] grupo = {
            new Estudiante("Ana", 16),
            new Estudiante("Luis", 12),
            new Estudiante("María", 18)
        };

        int suma = 0;
        for (Estudiante estudiante : grupo) {
            System.out.println(estudiante.getNombre().toUpperCase()
                + ": " + estudiante.getNota());
            suma += estudiante.getNota();
        }
        double promedio = (double) suma / grupo.length;
        System.out.println("Promedio del grupo: " + promedio);
    }
}