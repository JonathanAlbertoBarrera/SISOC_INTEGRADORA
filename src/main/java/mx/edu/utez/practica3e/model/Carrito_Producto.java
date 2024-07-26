package mx.edu.utez.practica3e.model;
import java.io.Serializable;

public class Carrito_Producto {
    private int id_carrito_producto;
    private Carrito carrito;
    private Producto producto;
    private int cantidad;
    private double totalProducto;

    public Carrito_Producto() {
    }

    public Carrito_Producto(int id_carrito_producto, Carrito carrito, Producto producto, int cantidad, double totalProducto) {
        this.id_carrito_producto = id_carrito_producto;
        this.carrito = carrito;
        this.producto = producto;
        this.cantidad = cantidad;
        this.totalProducto = totalProducto;
    }

    public int getId_carrito_producto() {
        return id_carrito_producto;
    }

    public void setId_carrito_producto(int id_carrito_producto) {
        this.id_carrito_producto = id_carrito_producto;
    }

    public Carrito getCarrito() {
        return carrito;
    }

    public void setCarrito(Carrito carrito) {
        this.carrito = carrito;
    }

    public Producto getProducto() {
        return producto;
    }

    public void setProducto(Producto producto) {
        this.producto = producto;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public double getTotalProducto() {
        return totalProducto;
    }

    public void setTotalProducto(double totalProducto) {
        this.totalProducto = totalProducto;
    }
}
