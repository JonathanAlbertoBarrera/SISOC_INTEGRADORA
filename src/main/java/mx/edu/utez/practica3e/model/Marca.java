package mx.edu.utez.practica3e.model;
import java.io.Serializable;

public class Marca {
    private int id_marca;
    private String nombre;
    private String descripcion;
    private boolean estatus;

    public Marca() {

    }

    public Marca(int id_marca, String nombre, String descripcion, boolean estatus) {
        this.id_marca = id_marca;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.estatus = estatus;
    }

    public int getId_marca() {
        return id_marca;
    }

    public void setId_marca(int id_marca) {
        this.id_marca = id_marca;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public boolean isEstatus() {
        return estatus;
    }

    public void setEstatus(boolean estatus) {
        this.estatus = estatus;
    }
}
