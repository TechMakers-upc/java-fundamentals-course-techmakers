public class Main {
    public static void main(String[] args) {
        int nota = 16;
        if (nota >= 11) {
            System.out.println("Aprobado");
        } else {
            System.out.println("Necesitas practicar más");
        }

        // for: sabemos cuántas veces queremos repetir.
        for (int intento = 1; intento <= 3; intento++) {
            System.out.println("Práctica " + intento);
        }

        // while: repetimos mientras se cumpla una condición.
        int nivel = 1;
        while (nivel <= 2) {
            System.out.println("Nivel " + nivel);
            nivel++;
        }
    }
}