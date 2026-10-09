package com.example.PreparatoriosSpring.modelo;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "preparatorios")
public class Preparatorios {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "valor_pago")
    private Integer valorPago;

    @Column(name = "fecha_evaluacion")
    private LocalDateTime fechaEvaluacion;

    @Column(name = "lugar_evaluacion")
    private String lugarEvaluacion;

    @Column(name = "estado")
    private boolean estado = true;

    @Column(name = "valor_pagado", precision = 12, scale = 2)
    private BigDecimal valorPagado;

    @Column(name = "id_tipo_evaluacion")
    private Integer idTipoEvaluacion;

    @Column(name = "limite_inscritos")
    private Integer limiteInscritos;

    @Column(name = "fecha_limite_pago")
    private LocalDate fechaLimitePago;

    @Column(name = "mostrar_recibo")
    private boolean mostrarRecibo = false;

    @Column(name = "titulo")
    private String titulo;

    @Column(name = "acuerdo")
    private String acuerdo;

    public Preparatorios() {
    }

    public Preparatorios(int id, Integer valorPago, LocalDateTime fechaEvaluacion, String lugarEvaluacion,
                         boolean estado, BigDecimal valorPagado, Integer idTipoEvaluacion,
                         Integer limiteInscritos, LocalDate fechaLimitePago, boolean mostrarRecibo,
                         String titulo, String acuerdo) {
        this.id = id;
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

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Integer getValorPago() {
        return valorPago;
    }

    public void setValorPago(Integer valorPago) {
        this.valorPago = valorPago;
    }

    public LocalDateTime getFechaEvaluacion() {
        return fechaEvaluacion;
    }

    public void setFechaEvaluacion(LocalDateTime fechaEvaluacion) {
        this.fechaEvaluacion = fechaEvaluacion;
    }

    public String getLugarEvaluacion() {
        return lugarEvaluacion;
    }

    public void setLugarEvaluacion(String lugarEvaluacion) {
        this.lugarEvaluacion = lugarEvaluacion;
    }

    public boolean isEstado() {
        return estado;
    }

    public void setEstado(boolean estado) {
        this.estado = estado;
    }

    public BigDecimal getValorPagado() {
        return valorPagado;
    }

    public void setValorPagado(BigDecimal valorPagado) {
        this.valorPagado = valorPagado;
    }

    public Integer getIdTipoEvaluacion() {
        return idTipoEvaluacion;
    }

    public void setIdTipoEvaluacion(Integer idTipoEvaluacion) {
        this.idTipoEvaluacion = idTipoEvaluacion;
    }

    public Integer getLimiteInscritos() {
        return limiteInscritos;
    }

    public void setLimiteInscritos(Integer limiteInscritos) {
        this.limiteInscritos = limiteInscritos;
    }

    public LocalDate getFechaLimitePago() {
        return fechaLimitePago;
    }

    public void setFechaLimitePago(LocalDate fechaLimitePago) {
        this.fechaLimitePago = fechaLimitePago;
    }

    public boolean isMostrarRecibo() {
        return mostrarRecibo;
    }

    public void setMostrarRecibo(boolean mostrarRecibo) {
        this.mostrarRecibo = mostrarRecibo;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getAcuerdo() {
        return acuerdo;
    }

    public void setAcuerdo(String acuerdo) {
        this.acuerdo = acuerdo;
    }
}