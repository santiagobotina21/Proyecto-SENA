package modelo;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class Preparatorio {

    private int id;
    private Integer valorPago;
    private LocalDateTime fechaEvaluacion;
    private String lugarEvaluacion;
    private boolean estado;
    private BigDecimal valorPagado;
    private Integer idTipoEvaluacion;
    private Integer limiteInscritos;
    private LocalDate fechaLimitePago;
    private boolean mostrarRecibo;
    private String titulo;
    private String acuerdo;

    // Constructor vacío
    public Preparatorio() {
        this.estado = true;
        this.mostrarRecibo = false;
    }

    // Constructor sin id (para insertar)
    public Preparatorio(Integer valorPago, LocalDateTime fechaEvaluacion, String lugarEvaluacion,
                        boolean estado, BigDecimal valorPagado, Integer idTipoEvaluacion,
                        Integer limiteInscritos, LocalDate fechaLimitePago, boolean mostrarRecibo,
                        String titulo, String acuerdo) {
        this.valorPago = valorPago;
        this.fechaEvaluacion = fechaEvaluacion;
        this.lugarEvaluacion = lugarEvaluacion;
        this.estado = estado;
        this.valorPagado = valorPagado;
        this.idTipoEvaluacion = idTipoEvaluacion;
        this.limiteInscritos = limiteInscritos;
        this.fechaLimitePago = fechaLimitePago;
        this.mostrarRecibo = mostrarRecibo;
        this.titulo = titulo;
        this.acuerdo = acuerdo;
    }

    // Constructor completo (para leer de la base de datos)
    public Preparatorio(int id, Integer valorPago, LocalDateTime fechaEvaluacion, String lugarEvaluacion,
                        boolean estado, BigDecimal valorPagado, Integer idTipoEvaluacion,
                        Integer limiteInscritos, LocalDate fechaLimitePago, boolean mostrarRecibo,
                        String titulo, String acuerdo) {
        this(valorPago, fechaEvaluacion, lugarEvaluacion, estado, valorPagado, idTipoEvaluacion,
             limiteInscritos, fechaLimitePago, mostrarRecibo, titulo, acuerdo);
        this.id = id;
    }

    // Getters y Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public Integer getValorPago() { return valorPago; }
    public void setValorPago(Integer valorPago) { this.valorPago = valorPago; }

    public LocalDateTime getFechaEvaluacion() { return fechaEvaluacion; }
    public void setFechaEvaluacion(LocalDateTime fechaEvaluacion) { this.fechaEvaluacion = fechaEvaluacion; }

    public String getLugarEvaluacion() { return lugarEvaluacion; }
    public void setLugarEvaluacion(String lugarEvaluacion) { this.lugarEvaluacion = lugarEvaluacion; }

    public boolean isEstado() { return estado; }
    public void setEstado(boolean estado) { this.estado = estado; }

    public BigDecimal getValorPagado() { return valorPagado; }
    public void setValorPagado(BigDecimal valorPagado) { this.valorPagado = valorPagado; }

    public Integer getIdTipoEvaluacion() { return idTipoEvaluacion; }
    public void setIdTipoEvaluacion(Integer idTipoEvaluacion) { this.idTipoEvaluacion = idTipoEvaluacion; }

    public Integer getLimiteInscritos() { return limiteInscritos; }
    public void setLimiteInscritos(Integer limiteInscritos) { this.limiteInscritos = limiteInscritos; }

    public LocalDate getFechaLimitePago() { return fechaLimitePago; }
    public void setFechaLimitePago(LocalDate fechaLimitePago) { this.fechaLimitePago = fechaLimitePago; }

    public boolean isMostrarRecibo() { return mostrarRecibo; }
    public void setMostrarRecibo(boolean mostrarRecibo) { this.mostrarRecibo = mostrarRecibo; }

    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }

    public String getAcuerdo() { return acuerdo; }
    public void setAcuerdo(String acuerdo) { this.acuerdo = acuerdo; }

    @Override
    public String toString() {
        return "ID: " + id
                + "\n  Título: " + titulo
                + "\n  Acuerdo: " + acuerdo
                + "\n  Valor pago: " + valorPago
                + "\n  Valor pagado: " + valorPagado
                + "\n  Fecha evaluación: " + fechaEvaluacion
                + "\n  Lugar evaluación: " + lugarEvaluacion
                + "\n  Tipo evaluación: " + idTipoEvaluacion
                + "\n  Límite inscritos: " + limiteInscritos
                + "\n  Fecha límite pago: " + fechaLimitePago
                + "\n  Mostrar recibo: " + (mostrarRecibo ? "Sí" : "No")
                + "\n  Estado: " + (estado ? "Activo" : "Inactivo");
    }
}