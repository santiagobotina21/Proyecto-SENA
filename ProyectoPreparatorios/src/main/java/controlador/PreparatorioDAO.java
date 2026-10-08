package controlador;

import conexion.Conexion;
import modelo.Preparatorio;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import modelo.Preparatorio;

public class PreparatorioDAO {

    // ---------- LISTAR ----------
    public List<Preparatorio> listar() throws SQLException {
        String sql = "SELECT * FROM preparatorios ORDER BY id";
        List<Preparatorio> lista = new ArrayList<>();
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(mapear(rs));
            }
        }
        return lista;
    }

    // ---------- BUSCAR POR ID ----------
    public Preparatorio buscarPorId(int id) throws SQLException {
        String sql = "SELECT * FROM preparatorios WHERE id = ?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? mapear(rs) : null;
            }
        }
    }

    // ---------- CREAR ----------
    public boolean insertar(Preparatorio p) throws SQLException {
        String sql = "INSERT INTO preparatorios (valor_pago, fecha_evaluacion, lugar_evaluacion, estado, "
                + "valor_pagado, id_tipo_evaluacion, limite_inscritos, fecha_limite_pago, mostrar_recibo, "
                + "titulo, acuerdo) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            asignarParametros(ps, p);
            int filas = ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) {
                    p.setId(keys.getInt(1));
                }
            }
            return filas > 0;
        }
    }

    // ---------- ACTUALIZAR ----------
    public boolean actualizar(Preparatorio p) throws SQLException {
        String sql = "UPDATE preparatorios SET valor_pago = ?, fecha_evaluacion = ?, lugar_evaluacion = ?, "
                + "estado = ?, valor_pagado = ?, id_tipo_evaluacion = ?, limite_inscritos = ?, "
                + "fecha_limite_pago = ?, mostrar_recibo = ?, titulo = ?, acuerdo = ? WHERE id = ?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            asignarParametros(ps, p);
            ps.setInt(12, p.getId());
            return ps.executeUpdate() > 0;
        }
    }

    // ---------- ELIMINAR ----------
    public boolean eliminar(int id) throws SQLException {
        String sql = "DELETE FROM preparatorios WHERE id = ?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    // ---------- MÉTODOS AUXILIARES ----------
    private void asignarParametros(PreparedStatement ps, Preparatorio p) throws SQLException {
        setInteger(ps, 1, p.getValorPago());
        if (p.getFechaEvaluacion() != null) {
            ps.setTimestamp(2, Timestamp.valueOf(p.getFechaEvaluacion()));
        } else {
            ps.setNull(2, Types.TIMESTAMP);
        }
        ps.setString(3, p.getLugarEvaluacion());
        ps.setBoolean(4, p.isEstado());
        ps.setBigDecimal(5, p.getValorPagado());
        setInteger(ps, 6, p.getIdTipoEvaluacion());
        setInteger(ps, 7, p.getLimiteInscritos());
        if (p.getFechaLimitePago() != null) {
            ps.setDate(8, Date.valueOf(p.getFechaLimitePago()));
        } else {
            ps.setNull(8, Types.DATE);
        }
        ps.setBoolean(9, p.isMostrarRecibo());
        ps.setString(10, p.getTitulo());
        ps.setString(11, p.getAcuerdo());
    }

    private void setInteger(PreparedStatement ps, int indice, Integer valor) throws SQLException {
        if (valor != null) {
            ps.setInt(indice, valor);
        } else {
            ps.setNull(indice, Types.INTEGER);
        }
    }

    private Integer getInteger(ResultSet rs, String columna) throws SQLException {
        int valor = rs.getInt(columna);
        return rs.wasNull() ? null : valor;
    }

    private Preparatorio mapear(ResultSet rs) throws SQLException {
        Timestamp ts = rs.getTimestamp("fecha_evaluacion");
        Date fecha = rs.getDate("fecha_limite_pago");
        LocalDateTime fechaEvaluacion = (ts != null) ? ts.toLocalDateTime() : null;
        LocalDate fechaLimitePago = (fecha != null) ? fecha.toLocalDate() : null;

        return new Preparatorio(
                rs.getInt("id"),
                getInteger(rs, "valor_pago"),
                fechaEvaluacion,
                rs.getString("lugar_evaluacion"),
                rs.getBoolean("estado"),
                rs.getBigDecimal("valor_pagado"),
                getInteger(rs, "id_tipo_evaluacion"),
                getInteger(rs, "limite_inscritos"),
                fechaLimitePago,
                rs.getBoolean("mostrar_recibo"),
                rs.getString("titulo"),
                rs.getString("acuerdo")
        );
    }
}