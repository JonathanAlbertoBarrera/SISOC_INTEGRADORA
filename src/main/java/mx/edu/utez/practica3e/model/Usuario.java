package mx.edu.utez.practica3e.model;

import java.io.Serializable;

//Debe de implemntar las convenciones de Java Bean
public class Usuario implements Serializable {
    private int id_usuario;
    private int id_persona;
    private int rol;
    private String correo;
    private String contrasena;
    private boolean estatus;

    public Usuario() {
    }

    public Usuario(int id_usuario, int id_persona, int rol, String correo, String contrasena, boolean estatus) {
        this.id_usuario = id_usuario;
        this.id_persona = id_persona;
        this.rol = rol;
        this.correo = correo;
        this.contrasena = contrasena;
        this.estatus = estatus;
    }

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public int getId_persona() {
        return id_persona;
    }

    public void setId_persona(int id_persona) {
        this.id_persona = id_persona;
    }

    public int getRol() {
        return rol;
    }

    public void setRol(int rol) {
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