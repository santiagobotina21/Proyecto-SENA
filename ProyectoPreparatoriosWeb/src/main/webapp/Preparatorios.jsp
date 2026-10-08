<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="modelo.Preparatorio"%>
<%!
    // Escapa el texto para mostrarlo de forma segura en HTML
    private String e(Object valor) {
        if (valor == null) return "";
        return valor.toString()
                .replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
                .replace("\"", "&quot;").replace("'", "&#39;");
    }
%>
<%
    // Si se abre el JSP directamente, se redirige al servlet para cargar los datos
    List<Preparatorio> lista = (List<Preparatorio>) request.getAttribute("lista");
    if (lista == null) {
        response.sendRedirect("preparatorios");
        return;
    }

    Preparatorio editar = (Preparatorio) request.getAttribute("preparatorioEditar");
    boolean editando = (editar != null);
    if (!editando) {
        editar = new Preparatorio();   // objeto vacío para el formulario de creación
    }

    String busqueda = (String) request.getAttribute("busqueda");
    String error = (String) request.getAttribute("error");
    String mensaje = request.getParameter("mensaje");

    DateTimeFormatter fmtInput = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
    DateTimeFormatter fmtTabla = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Preparatorios</title>
    <style>
        * { box-sizing: border-box; }
        body { font-family: Arial, sans-serif; margin: 0; background: #f2f4f7; color: #222; }
        header { background: #1f3b63; color: #fff; padding: 16px 24px; }
        header h1 { margin: 0; font-size: 22px; }
        main { padding: 20px 24px; }
        .card { background: #fff; border-radius: 8px; padding: 18px; margin-bottom: 20px;
                box-shadow: 0 1px 3px rgba(0,0,0,.1); }
        .card h2 { margin-top: 0; font-size: 18px; color: #1f3b63; }
        .grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(220px, 1fr)); gap: 12px; }
        label { display: block; font-size: 13px; font-weight: bold; margin-bottom: 4px; }
        input[type=text], input[type=number], input[type=date], input[type=datetime-local], input[type=search] {
            width: 100%; padding: 8px; border: 1px solid #c5ccd6; border-radius: 4px; }
        .checks { display: flex; gap: 20px; align-items: center; margin-top: 12px; }
        .checks label { display: inline; font-weight: normal; }
        .botones { margin-top: 16px; display: flex; gap: 8px; }
        button, .btn { padding: 8px 14px; border: none; border-radius: 4px; cursor: pointer;
                       font-size: 14px; text-decoration: none; display: inline-block; }
        .btn-primario { background: #1f3b63; color: #fff; }
        .btn-gris { background: #d9dee5; color: #222; }
        .btn-editar { background: #f0ad4e; color: #fff; padding: 5px 10px; font-size: 13px; }
        .btn-eliminar { background: #d9534f; color: #fff; padding: 5px 10px; font-size: 13px; }
        .buscador { display: flex; gap: 8px; margin-bottom: 14px; }
        .buscador input { flex: 1; }
        .tabla-contenedor { overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; font-size: 13px; }
        th, td { padding: 8px; border-bottom: 1px solid #e3e7ec; text-align: left; white-space: nowrap; }
        th { background: #eef1f5; }
        tr:hover td { background: #f8f9fb; }
        .acciones { display: flex; gap: 6px; }
        .acciones form { margin: 0; }
        .alerta { padding: 10px 14px; border-radius: 4px; margin-bottom: 16px; }
        .ok { background: #dff0d8; color: #2d662d; }
        .mal { background: #f2dede; color: #8a2b2b; }
        .activo { color: #2d662d; font-weight: bold; }
        .inactivo { color: #8a2b2b; font-weight: bold; }
    </style>
</head>
<body>
<header>
    <h1>Gestión de Preparatorios</h1>
</header>

<main>
    <%-- Mensajes --%>
    <% if ("creado".equals(mensaje)) { %>
        <div class="alerta ok">Preparatorio creado correctamente.</div>
    <% } else if ("actualizado".equals(mensaje)) { %>
        <div class="alerta ok">Preparatorio actualizado correctamente.</div>
    <% } else if ("eliminado".equals(mensaje)) { %>
        <div class="alerta ok">Preparatorio eliminado correctamente.</div>
    <% } %>
    <% if (error != null) { %>
        <div class="alerta mal"><%= e(error) %></div>
    <% } %>

    <%-- Formulario para crear / editar --%>
    <section class="card">
        <h2><%= editando ? "Editar preparatorio #" + editar.getId() : "Nuevo preparatorio" %></h2>
        <form action="preparatorios" method="post">
            <input type="hidden" name="accion" value="guardar">
            <input type="hidden" name="id" value="<%= editando ? editar.getId() : "" %>">

            <div class="grid">
                <div>
                    <label>Título</label>
                    <input type="text" name="titulo" required value="<%= e(editar.getTitulo()) %>">
                </div>
                <div>
                    <label>Acuerdo</label>
                    <input type="text" name="acuerdo" value="<%= e(editar.getAcuerdo()) %>">
                </div>
                <div>
                    <label>Valor pago</label>
                    <input type="number" name="valorPago" min="0" value="<%= e(editar.getValorPago()) %>">
                </div>
                <div>
                    <label>Valor pagado</label>
                    <input type="number" name="valorPagado" min="0" step="0.01" value="<%= e(editar.getValorPagado()) %>">
                </div>
                <div>
                    <label>Fecha y hora de evaluación</label>
                    <input type="datetime-local" name="fechaEvaluacion"
                           value="<%= editar.getFechaEvaluacion() == null ? "" : editar.getFechaEvaluacion().format(fmtInput) %>">
                </div>
                <div>
                    <label>Lugar de evaluación</label>
                    <input type="text" name="lugarEvaluacion" value="<%= e(editar.getLugarEvaluacion()) %>">
                </div>
                <div>
                    <label>ID tipo de evaluación</label>
                    <input type="number" name="idTipoEvaluacion" min="0" value="<%= e(editar.getIdTipoEvaluacion()) %>">
                </div>
                <div>
                    <label>Límite de inscritos</label>
                    <input type="number" name="limiteInscritos" min="0" value="<%= e(editar.getLimiteInscritos()) %>">
                </div>
                <div>
                    <label>Fecha límite de pago</label>
                    <input type="date" name="fechaLimitePago" value="<%= e(editar.getFechaLimitePago()) %>">
                </div>
            </div>

            <div class="checks">
                <span>
                    <input type="checkbox" id="mostrarRecibo" name="mostrarRecibo" <%= editar.isMostrarRecibo() ? "checked" : "" %>>
                    <label for="mostrarRecibo">Mostrar recibo</label>
                </span>
                <span>
                    <input type="checkbox" id="estado" name="estado" <%= editar.isEstado() ? "checked" : "" %>>
                    <label for="estado">Activo</label>
                </span>
            </div>

            <div class="botones">
                <button type="submit" class="btn-primario"><%= editando ? "Actualizar" : "Guardar" %></button>
                <% if (editando) { %>
                    <a href="preparatorios" class="btn btn-gris">Cancelar</a>
                <% } %>
            </div>
        </form>
    </section>

    <%-- Buscador y tabla --%>
    <section class="card">
        <h2>Lista de preparatorios</h2>

        <form action="preparatorios" method="get" class="buscador">
            <input type="search" name="busqueda" placeholder="Buscar por ID, título, acuerdo o lugar"
                   value="<%= e(busqueda) %>">
            <button type="submit" class="btn-primario">Buscar</button>
            <a href="preparatorios" class="btn btn-gris">Ver todos</a>
        </form>

        <div class="tabla-contenedor">
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Título</th>
                    <th>Acuerdo</th>
                    <th>Valor pago</th>
                    <th>Valor pagado</th>
                    <th>Fecha evaluación</th>
                    <th>Lugar</th>
                    <th>Tipo eval.</th>
                    <th>Límite</th>
                    <th>Límite pago</th>
                    <th>Recibo</th>
                    <th>Estado</th>
                    <th>Acciones</th>
                </tr>
                </thead>
                <tbody>
                <% if (lista.isEmpty()) { %>
                    <tr><td colspan="13">No se encontraron preparatorios.</td></tr>
                <% } %>
                <% for (Preparatorio p : lista) { %>
                    <tr>
                        <td><%= p.getId() %></td>
                        <td><%= e(p.getTitulo()) %></td>
                        <td><%= e(p.getAcuerdo()) %></td>
                        <td><%= e(p.getValorPago()) %></td>
                        <td><%= e(p.getValorPagado()) %></td>
                        <td><%= p.getFechaEvaluacion() == null ? "" : p.getFechaEvaluacion().format(fmtTabla) %></td>
                        <td><%= e(p.getLugarEvaluacion()) %></td>
                        <td><%= e(p.getIdTipoEvaluacion()) %></td>
                        <td><%= e(p.getLimiteInscritos()) %></td>
                        <td><%= e(p.getFechaLimitePago()) %></td>
                        <td><%= p.isMostrarRecibo() ? "Sí" : "No" %></td>
                        <td class="<%= p.isEstado() ? "activo" : "inactivo" %>">
                            <%= p.isEstado() ? "Activo" : "Inactivo" %>
                        </td>
                        <td>
                            <div class="acciones">
                                <a class="btn btn-editar"
                                   href="preparatorios?accion=editar&id=<%= p.getId() %>">Editar</a>
                                <form action="preparatorios" method="post"
                                      onsubmit="return confirm('¿Seguro que desea eliminar el preparatorio #<%= p.getId() %>?');">
                                    <input type="hidden" name="accion" value="eliminar">
                                    <input type="hidden" name="id" value="<%= p.getId() %>">
                                    <button type="submit" class="btn-eliminar">Eliminar</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </section>
</main>
</body>
</html>
