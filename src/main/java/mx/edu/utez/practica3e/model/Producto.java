package mx.edu.utez.practica3e.model;

public class Producto {
    private String sku;
    private Categoria categoria;
    private Marca marca;
    private String nombre;
    private String descripcion;
    private String urlImagen;
    private double precio;
    private int cantidad;
    private boolean estatus;

    public Producto() {
    }

    public Producto(String sku, Categoria categoria, Marca marca, String nombre, String descripcion, String urlImagen,double precio, int cantidad, boolean estatus) {
        this.sku = sku;
        this.categoria = categoria;
        this.marca = marca;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.urlImagen=urlImagen;
        this.precio = precio;
        this.cantidad = cantidad;
        this.estatus = estatus;
    }

    public String getSku() {
        return sku;
    }

    public void setSku(String sku) {
        this.sku = sku;
    }

    public Categoria getCategoria() {
        return categoria;
    }

    public void setCategoria(Categoria categoria) {
        this.categoria = categoria;
    }

    public Marca getMarca() {
        return marca;
    }

    public void setMarca(Marca marca) {
        this.marca = marca;
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

    public String getUrlImagen() {
        return urlImagen;
    }

    public void setUrlImagen(String urlImagen) {
        this.urlImagen = urlImagen;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public boolean isEstatus() {
        return estatus;
    }

    public void setEstatus(boolean estatus) {
        this.estatus = estatus;
    }
}
