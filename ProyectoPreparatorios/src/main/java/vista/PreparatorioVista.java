package vista;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.Scanner;
import modelo.Preparatorio;

public class PreparatorioVista {

    private final Scanner sc = new Scanner(System.in);
    private static final DateTimeFormatter FORMATO_FECHA_HORA = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

    public int mostrarMenu() {
        System.out.println("\n===== CRUD PREPARATORIOS =====");
        System.out.println("1. Listar preparatorios");
        System.out.println("2. Crear preparatorio");
        System.out.println("3. Actualizar preparatorio");
        System.out.println("4. Eliminar preparatorio");
        System.out.println("5. Buscar por ID");
        System.out.println("0. Salir");
        return leerEntero("Seleccione una opción");
    }

    public void mostrarLista(List<Preparatorio> lista) {
        if (lista.isEmpty()) {
            System.out.println("No hay preparatorios registrados.");
            return;
        }
        System.out.println("\n--- LISTA DE PREPARATORIOS ---");
        for (Preparatorio p : lista) {
            System.out.println(p);
            System.out.println("------------------------------");
        }
    }

    public void mostrarPreparatorio(Preparatorio p) {
        System.out.println("\n" + p);
    }

    public void mostrarMensaje(String mensaje) {
        System.out.println(mensaje);
    }

    public void mostrarError(String mensaje) {
        System.out.println("[ERROR] " + mensaje);
    }

    public int pedirId(String mensaje) {
        return leerEntero(mensaje);
    }

    public boolean confirmar(String mensaje) {
        System.out.print(mensaje + " (s/n): ");
        return sc.nextLine().trim().equalsIgnoreCase("s");
    }

    /**
     * Pide los datos por consola.
     * Si 'actual' es null se está creando; si no, se está actualizando
     * y al presionar Enter se conserva el valor actual.
     */
    public Preparatorio pedirDatos(Preparatorio actual) {
        boolean editando = actual != null;
        Preparatorio p = editando ? actual : new Preparatorio();

        System.out.println(editando
                ? "\n--- ACTUALIZAR (Enter para conservar el valor actual) ---"
                : "\n--- NUEVO PREPARATORIO (Enter para dejar vacío) ---");

        p.setTitulo(leerTexto("Título", p.getTitulo()));
        p.setAcuerdo(leerTexto("Acuerdo", p.getAcuerdo()));
        p.setValorPago(leerEnteroOpcional("Valor pago", p.getValorPago()));
        p.setFechaEvaluacion(leerFechaHora("Fecha evaluación (yyyy-MM-dd HH:mm)", p.getFechaEvaluacion()));
        p.setLugarEvaluacion(leerTexto("Lugar evaluación", p.getLugarEvaluacion()));
        p.setLimiteInscritos(leerEnteroOpcional("Límite inscritos", p.getLimiteInscritos()));
        p.setFechaLimitePago(leerFecha("Fecha límite pago (yyyy-MM-dd)", p.getFechaLimitePago()));
        return p;
    }

    // ---------- Lectura de datos ----------

    private int leerEntero(String mensaje) {
        while (true) {
            System.out.print(mensaje + ": ");
            try {
                return Integer.parseInt(sc.nextLine().trim());
            } catch (NumberFormatException e) {
                System.out.println("Debe ingresar un número entero.");
            }
        }
    }

    private String leerTexto(String campo, String actual) {
        System.out.print(campo + mostrarActual(actual) + ": ");
        String entrada = sc.nextLine().trim();
        return entrada.isEmpty() ? actual : entrada;
    }

    private Integer leerEnteroOpcional(String campo, Integer actual) {
        while (true) {
            System.out.print(campo + mostrarActual(actual) + ": ");
            String entrada = sc.nextLine().trim();
            if (entrada.isEmpty()) return actual;
            try {
                return Integer.parseInt(entrada);
            } catch (NumberFormatException e) {
                System.out.println("Debe ingresar un número entero.");
            }
        }
    }


    private LocalDateTime leerFechaHora(String campo, LocalDateTime actual) {
        while (true) {
            System.out.print(campo + mostrarActual(actual == null ? null : actual.format(FORMATO_FECHA_HORA)) + ": ");
            String entrada = sc.nextLine().trim();
            if (entrada.isEmpty()) return actual;
            try {
                return LocalDateTime.parse(entrada, FORMATO_FECHA_HORA);
            } catch (DateTimeParseException e) {
                System.out.println("Formato inválido. Ejemplo: 2026-11-20 08:00");
            }
        }
    }

    private LocalDate leerFecha(String campo, LocalDate actual) {
        while (true) {
            System.out.print(campo + mostrarActual(actual) + ": ");
            String entrada = sc.nextLine().trim();
            if (entrada.isEmpty()) return actual;
            try {
                return LocalDate.parse(entrada);
            } catch (DateTimeParseException e) {
                System.out.println("Formato inválido. Ejemplo: 2026-11-15");
            }
        }
    }


    private String mostrarActual(Object actual) {
        return actual == null ? "" : " [" + actual + "]";
    }
}