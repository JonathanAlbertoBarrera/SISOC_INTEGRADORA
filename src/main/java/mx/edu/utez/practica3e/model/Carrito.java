package mx.edu.utez.practica3e.model;

import java.io.Serializable;

public class Carrito {
    private int id_carrito;
    private Usuario usuario;
    private boolean confirmado;

    public Carrito() {
    }

    public Carrito(int id_carrito, Usuario usuario, boolean confirmado) {
        this.id_carrito = id_carrito;
        this.usuario = usuario;
        this.confirmado = confirmado;
    }

    public int getId_carrito() {
        return id_carrito;
    }

    public void setId_carrito(int id_carrito) {
        this.id_carrito = id_carrito;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public boolean isConfirmado() {
        return confirmado;
    }

    public void setConfirmado(boolean confirmado) {
        this.confirmado = confirmado;
    }
}
