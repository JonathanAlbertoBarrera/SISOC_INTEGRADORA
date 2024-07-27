package mx.edu.utez.practica3e.model;

import java.sql.Date;

public class Solicitud {
    private int id_solicitud;
    private Carrito carrito;
    private Usuario usuario;
    private Date fecha;
    private String estado;
    private double total;

    public Solicitud() {
    }

    public Solicitud(int id_solicitud, Carrito carrito, Usuario usuario, Date fecha, String estado, double total) {
        this.id_solicitud = id_solicitud;
        this.carrito = carrito;
        this.usuario = usuario;
        this.fecha = fecha;
        this.estado = estado;
        this.total = total;
    }

    public int getId_solicitud() {
        return id_solicitud;
    }

    public void setId_solicitud(int id_solicitud) {
        this.id_solicitud = id_solicitud;
    }

    public Carrito getCarrito() {
        return carrito;
    }

    public void setCarrito(Carrito carrito) {
        this.carrito = carrito;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }
}
