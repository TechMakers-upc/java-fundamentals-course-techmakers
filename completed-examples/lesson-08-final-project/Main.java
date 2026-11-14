import java.util.Scanner;

class Estudiante {
    private String nombre;
    private int nota;

    Estudiante(String nombre, int nota) {
        this.nombre = nombre.trim();
        this.nota = nota;
    }

    String getNombre() {
        return nombre;
    }

    int getNota() {
        return nota;
    }

    boolean aprobo() {
        return nota >= 11;
    }
}

public class Main {
    private static final int CAPACIDAD = 10;
    private static final Estudiante[] estudiantes = new Estudiante[CAPACIDAD];
    private static int cantidad = 0;

    public static void main(String[] args) {
        Scanner entrada = new Scanner(System.in);
        int opcion;
        do {
            System.out.println("\n--- Registro de estudiantes ---");
            System.out.println("1. Registrar estudiante");
            System.out.println("2. Mostrar estudiantes");
            System.out.println("3. Buscar por nombre");
            System.out.println("4. Ver promedio");
            System.out.println("0. Salir");
            opcion = leerEntero(entrada, "Elige una opción: ");
            switch (opcion) {
                case 1: registrar(entrada); break;
                case 2: mostrar(); break;
                case 3: buscar(entrada); break;
                case 4: mostrarPromedio(); break;
                case 0: System.out.println("¡Hasta pronto!"); break;
                default: System.out.println("Opción no reconocida.");
            }
        } while (opcion != 0);
    }

    // nextLine y parseInt evitan problemas de saltos de línea al combinar entradas.
    private static int leerEntero(Scanner entrada, String mensaje) {
        while (true) {
            System.out.print(mensaje);
            String texto = entrada.nextLine().trim();
            try {
                return Integer.parseInt(texto);
            } catch (NumberFormatException error) {
                System.out.println("Escribe un número entero válido.");
            }
        }
    }

    private static void registrar(Scanner entrada) {
        if (cantidad == CAPACIDAD) {
            System.out.println("El registro está lleno.");
            return;
        }
        System.out.print("Nombre: ");
        String nombre = entrada.nextLine().trim();
        if (nombre.isEmpty()) {
            System.out.println("El nombre no puede estar vacío.");
            return;
        }
        int nota = leerEntero(entrada, "Nota entre 0 y 20: ");
        if (nota < 0 || nota > 20) {
            System.out.println("La nota debe estar entre 0 y 20.");
            return;
        }
        estudiantes[cantidad] = new Estudiante(nombre, nota);
        cantidad++;
        System.out.println("Estudiante registrado correctamente.");
    }

    private static void mostrar() {
        if (cantidad == 0) {
            System.out.println("No hay estudiantes todavía.");
            return;
        }
        for (int i = 0; i < cantidad; i++) {
            Estudiante e = estudiantes[i];
            String estado = e.aprobo() ? "Aprobó" : "En práctica";
            System.out.println((i + 1) + ". " + e.getNombre() + " - "
                + e.getNota() + " - " + estado);
        }
    }

    private static void buscar(Scanner entrada) {
        System.out.print("Nombre que deseas buscar: ");
        String nombre = entrada.nextLine().trim();
        for (int i = 0; i < cantidad; i++) {
            Estudiante e = estudiantes[i];
            if (e.getNombre().equalsIgnoreCase(nombre)) {
                System.out.println("Encontrado: " + e.getNombre()
                    + ", nota " + e.getNota());
                return;
            }
        }
        System.out.println("No se encontró ese nombre.");
    }

    private static void mostrarPromedio() {
        if (cantidad == 0) {
            System.out.println("No hay notas para promediar.");
            return;
        }
        int suma = 0;
        for (int i = 0; i < cantidad; i++) {
            suma += estudiantes[i].getNota();
        }
        double promedio = (double) suma / cantidad;
        System.out.printf("Promedio del grupo: %.1f%n", promedio);
    }
}