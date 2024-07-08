package mx.edu.utez.practica3e.model;

public class Rol {
    private int id;
    private String tipoRol;

    public Rol() {
    }

    public Rol(int id, String tipoRol) {
        this.id = id;
        this.tipoRol = tipoRol;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTipoRol() {
        return tipoRol;
    }

    public void setTipoRol(String tipoRol) {
        this.tipoRol = tipoRol;
    }
}
