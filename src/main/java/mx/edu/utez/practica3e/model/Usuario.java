package mx.edu.utez.practica3e.model;

import java.io.Serializable;

//Debe de implemntar las convenciones de Java Bean
public class Usuario implements Serializable {
    //Debe de representar exactamente la estructura de la
    //tabla de la base de datos

    private int id;
    private String nombre_usuario;
    private String contra;
    private String correo;
    private int tipo_usuario;
    private boolean estado;

    public Usuario() {
    }

    public Usuario(int id, String nombre_usuario, String contra, String correo, int tipo_usuario, boolean estado) {
        this.id = id;
        this.nombre_usuario = nombre_usuario;
        this.contra = contra;
        this.correo = correo;
        this.tipo_usuario = tipo_usuario;
        this.estado = estado;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre_usuario() {
        return nombre_usuario;
    }

    public void setNombre_usuario(String nombre_usuario) {
        this.nombre_usuario = nombre_usuario;
    }

    public String getContra() {
        return contra;
    }

    public void setContra(String contra) {
        this.contra = contra;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public int getTipo_usuario() {
        return tipo_usuario;
    }

    public void setTipo_usuario(int tipo_usuario) {
        this.tipo_usuario = tipo_usuario;
    }

    public boolean isEstado() {
        return estado;
    }

    public void setEstado(boolean estado) {
        this.estado = estado;
    }
}
