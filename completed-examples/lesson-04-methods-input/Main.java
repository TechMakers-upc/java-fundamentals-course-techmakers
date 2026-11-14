import java.util.Scanner;

public class Main {
    // Un método recibe un parámetro y realiza una tarea.
    static void saludar(String nombre) {
        System.out.println("¡Hola, " + nombre + "!");
    }

    // Otro método devuelve un valor.
    static boolean puedeParticipar(int edad) {
        return edad >= 12;
    }

    public static void main(String[] args) {
        Scanner entrada = new Scanner(System.in);
        System.out.print("¿Cómo te llamas? ");
        String nombre = entrada.nextLine();
        System.out.print("¿Cuántos años tienes? ");
        int edad = entrada.nextInt();

        saludar(nombre);
        if (puedeParticipar(edad)) {
            System.out.println("Puedes participar en el club de Java.");
        } else {
            System.out.println("Espera un poco antes de participar.");
        }
    }
}