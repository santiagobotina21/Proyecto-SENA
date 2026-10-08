package controlador;

import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.List;
import modelo.Preparatorio;
import vista.PreparatorioVista;

public class PreparatorioControlador {

    private final PreparatorioDAO dao;
    private final PreparatorioVista vista;

    public PreparatorioControlador(PreparatorioDAO dao, PreparatorioVista vista) {
        this.dao = dao;
        this.vista = vista;
    }

    public void iniciar() {
        int opcion;
        do {
            opcion = vista.mostrarMenu();
            switch (opcion) {
                case 1 -> listar();
                case 2 -> crear();
                case 3 -> actualizar();
                case 4 -> eliminar();
                case 5 -> buscar();
                case 0 -> vista.mostrarMensaje("Saliendo del sistema...");
                default -> vista.mostrarMensaje("Opción no válida.");
            }
        } while (opcion != 0);
    }

    private void listar() {
        try {
            List<Preparatorio> lista = dao.listar();
            vista.mostrarLista(lista);
        } catch (SQLException e) {
            vista.mostrarError("Error al listar: " + e.getMessage());
        }
    }

    private void buscar() {
        int id = vista.pedirId("Ingrese el ID a buscar");
        try {
            Preparatorio p = dao.buscarPorId(id);
            if (p == null) {
                vista.mostrarMensaje("No existe un preparatorio con ID " + id);
            } else {
                vista.mostrarPreparatorio(p);
            }
        } catch (SQLException e) {
            vista.mostrarError("Error al buscar: " + e.getMessage());
        }
    }

    private void crear() {
        Preparatorio p = vista.pedirDatos(null);
        try {
            if (dao.insertar(p)) {
                vista.mostrarMensaje("Preparatorio creado con ID " + p.getId());
            } else {
                vista.mostrarMensaje("No se pudo crear el preparatorio.");
            }
        } catch (SQLException e) {
            vista.mostrarError("Error al crear: " + e.getMessage());
        }
    }

    private void actualizar() {
        int id = vista.pedirId("Ingrese el ID a actualizar");
        try {
            Preparatorio actual = dao.buscarPorId(id);
            if (actual == null) {
                vista.mostrarMensaje("No existe un preparatorio con ID " + id);
                return;
            }
            Preparatorio nuevo = vista.pedirDatos(actual);
            nuevo.setId(id);
            if (dao.actualizar(nuevo)) {
                vista.mostrarMensaje("Preparatorio actualizado correctamente.");
            } else {
                vista.mostrarMensaje("No se pudo actualizar.");
            }
        } catch (SQLException e) {
            vista.mostrarError("Error al actualizar: " + e.getMessage());
        }
    }

    private void eliminar() {
        int id = vista.pedirId("Ingrese el ID a eliminar");
        try {
            Preparatorio p = dao.buscarPorId(id);
            if (p == null) {
                vista.mostrarMensaje("No existe un preparatorio con ID " + id);
                return;
            }
            vista.mostrarPreparatorio(p);
            if (!vista.confirmar("¿Seguro que desea eliminarlo?")) {
                vista.mostrarMensaje("Operación cancelada.");
                return;
            }
            if (dao.eliminar(id)) {
                vista.mostrarMensaje("Preparatorio eliminado.");
            }
        } catch (SQLIntegrityConstraintViolationException e) {
            vista.mostrarError("No se puede eliminar: tiene inscripciones o configuraciones asociadas.");
        } catch (SQLException e) {
            vista.mostrarError("Error al eliminar: " + e.getMessage());
        }
    }
}