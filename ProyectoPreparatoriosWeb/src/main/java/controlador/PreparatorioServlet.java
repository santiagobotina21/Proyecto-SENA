package controlador;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;
import java.util.List;
import modelo.Preparatorio;

@WebServlet(name = "PreparatorioServlet", urlPatterns = {"/preparatorios"})
public class PreparatorioServlet extends HttpServlet {

    private final PreparatorioDAO dao = new PreparatorioDAO();

    // GET: listar, buscar y cargar un registro en el formulario para editar
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        if ("editar".equals(accion)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                Preparatorio p = dao.buscarPorId(id);
                if (p != null) {
                    request.setAttribute("preparatorioEditar", p);
                } else {
                    request.setAttribute("error", "No existe un preparatorio con ID " + id);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "ID no válido.");
            } catch (SQLException e) {
                request.setAttribute("error", "Error al buscar: " + e.getMessage());
            }
        }

        mostrarPagina(request, response);
    }

    // POST: guardar (crear o actualizar) y eliminar
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        try {
            if ("guardar".equals(accion)) {
                Preparatorio p = leerFormulario(request);
                if (p.getId() == 0) {
                    dao.insertar(p);
                    response.sendRedirect("preparatorios?mensaje=creado");
                } else {
                    dao.actualizar(p);
                    response.sendRedirect("preparatorios?mensaje=actualizado");
                }
                return;
            }

            if ("eliminar".equals(accion)) {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.eliminar(id);
                response.sendRedirect("preparatorios?mensaje=eliminado");
                return;
            }

            response.sendRedirect("preparatorios");

        } catch (SQLIntegrityConstraintViolationException e) {
            request.setAttribute("error",
                    "No se puede eliminar: el preparatorio tiene inscripciones o configuraciones asociadas.");
            mostrarPagina(request, response);
        } catch (NumberFormatException | DateTimeParseException e) {
            request.setAttribute("error", "Hay datos con formato incorrecto. Revisa números y fechas.");
            mostrarPagina(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Error en la base de datos: " + e.getMessage());
            mostrarPagina(request, response);
        }
    }

    // Carga la lista (completa o filtrada) y envía todo al JSP
    private void mostrarPagina(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String busqueda = request.getParameter("busqueda");
        try {
            List<Preparatorio> lista = (busqueda != null && !busqueda.isBlank())
                    ? dao.buscar(busqueda.trim())
                    : dao.listar();
            request.setAttribute("lista", lista);
        } catch (SQLException e) {
            request.setAttribute("lista", List.of());
            request.setAttribute("error", "Error al consultar: " + e.getMessage());
        }
        request.setAttribute("busqueda", busqueda == null ? "" : busqueda);
        request.getRequestDispatcher("Preparatorios.jsp").forward(request, response);
    }

    // Llena el objeto Preparatorio con los setters a partir del formulario
    private Preparatorio leerFormulario(HttpServletRequest request) {
        Preparatorio p = new Preparatorio();

        String id = request.getParameter("id");
        p.setId(texto(id) == null ? 0 : Integer.parseInt(id));

        p.setTitulo(texto(request.getParameter("titulo")));
        p.setAcuerdo(texto(request.getParameter("acuerdo")));
        p.setValorPago(entero(request.getParameter("valorPago")));
        p.setValorPagado(decimal(request.getParameter("valorPagado")));
        p.setLugarEvaluacion(texto(request.getParameter("lugarEvaluacion")));
        p.setIdTipoEvaluacion(entero(request.getParameter("idTipoEvaluacion")));
        p.setLimiteInscritos(entero(request.getParameter("limiteInscritos")));

        String fechaEval = texto(request.getParameter("fechaEvaluacion"));      // formato 2026-11-20T08:00
        p.setFechaEvaluacion(fechaEval == null ? null : LocalDateTime.parse(fechaEval));

        String fechaPago = texto(request.getParameter("fechaLimitePago"));      // formato 2026-11-15
        p.setFechaLimitePago(fechaPago == null ? null : LocalDate.parse(fechaPago));

        // Los checkbox solo se envían si están marcados
        p.setMostrarRecibo(request.getParameter("mostrarRecibo") != null);
        p.setEstado(request.getParameter("estado") != null);
        return p;
    }

    private String texto(String valor) {
        return (valor == null || valor.isBlank()) ? null : valor.trim();
    }

    private Integer entero(String valor) {
        return texto(valor) == null ? null : Integer.valueOf(valor.trim());
    }

    private BigDecimal decimal(String valor) {
        return texto(valor) == null ? null : new BigDecimal(valor.trim());
    }
}