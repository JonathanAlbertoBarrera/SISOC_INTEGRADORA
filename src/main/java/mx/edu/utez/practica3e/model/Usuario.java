package mx.edu.utez.practica3e.model;

import java.io.Serializable;

//Debe de implemntar las convenciones de Java Bean

public class Usuario {
    private int idUsuario;
    private Persona persona;
    private Rol rol;
    private String correo;
    private String contrasena;
    private boolean estatus;

    public Usuario() {
    }

    public Usuario(int idUsuario, Persona persona, Rol rol, String correo, String contrasena, boolean estatus) {
        this.idUsuario = idUsuario;
        this.persona = persona;
        this.rol = rol;
        this.correo = correo;
        this.contrasena = contrasena;
        this.estatus = estatus;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public Persona getPersona() {
        return persona;
    }

    public void setPersona(Persona persona) {
        this.persona = persona;
    }

    public Rol getRol() {
        return rol;
    }

    public void setRol(Rol rol) {
        this.rol = rol;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

    public boolean isEstatus() {
        return estatus;
    }

    public void setEstatus(boolean estatus) {
        this.estatus = estatus;
    }
}
