package mx.edu.utez.practica3e.model;

public class Solicitud_Encargado {
    private int id_sc;
    private Solicitud solicitud;
    private Usuario encargado;

    public Solicitud_Encargado() {
    }

    public Solicitud_Encargado(int id_sc, Solicitud solicitud, Usuario encargado) {
        this.id_sc = id_sc;
        this.solicitud = solicitud;
        this.encargado = encargado;
    }

    public int getId_sc() {
        return id_sc;
    }

    public void setId_sc(int id_sc) {
        this.id_sc = id_sc;
    }

    public Solicitud getSolicitud() {
        return solicitud;
    }

    public void setSolicitud(Solicitud solicitud) {
        this.solicitud = solicitud;
    }

    public Usuario getEncargado() {
        return encargado;
    }

    public void setEncargado(Usuario encargado) {
        this.encargado = encargado;
    }
}
