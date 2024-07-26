package mx.edu.utez.practica3e.dao;
import mx.edu.utez.practica3e.model.*;
import mx.edu.utez.practica3e.utils.DatabaseConnectionManager;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CarritoProductoDao {

    //para ir agregando productos al carrito
    public void agregarProductoAlCarrito(Carrito_Producto carritoProducto) {
        String query = "INSERT INTO carrito_producto (id_carrito, sku, cantidad, totalProducto) VALUES (?, ?, ?, ?)";

        try (Connection con = DatabaseConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, carritoProducto.getCarrito().getId_carrito());
            ps.setString(2, carritoProducto.getProducto().getSku());
            ps.setInt(3, carritoProducto.getCantidad());
            ps.setDouble(4, carritoProducto.getTotalProducto());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
