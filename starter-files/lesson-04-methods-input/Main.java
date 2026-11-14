import java.util.Scanner;

public class Main {
    // RETO: crea un método saludar(String nombre).
    // RETO: crea un método boolean puedeParticipar(int edad).

    public static void main(String[] args) {
        Scanner entrada = new Scanner(System.in);
        System.out.print("¿Cómo te llamas? ");
        String nombre = entrada.nextLine();
        System.out.println("Hola, " + nombre);
        // RETO: lee la edad e invoca los métodos.
    }
}