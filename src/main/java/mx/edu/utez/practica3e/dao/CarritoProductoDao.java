package mx.edu.utez.practica3e.dao;
import mx.edu.utez.practica3e.model.*;
import mx.edu.utez.practica3e.utils.DatabaseConnectionManager;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CarritoProductoDao {

    //para ir agregando productos al carrito
    public void agregarProductoAlCarrito(Carrito_Producto carritoProducto) {
        String query = "INSERT INTO carrito_producto (id_carrito, sku, cantidad, precio, totalProducto) VALUES (?, ?, ?, ?, ?)";

        try (Connection con = DatabaseConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, carritoProducto.getCarrito().getId_carrito());
            ps.setString(2, carritoProducto.getProducto().getSku());
            ps.setInt(3, carritoProducto.getCantidad());
            ps.setDouble(4, carritoProducto.getPrecio());
            ps.setDouble(5, carritoProducto.getTotalProducto());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //PARA SABER CUANTO SE ACUMULO DE TOTAL EN UN CARRITO

    public double getTotalCarrito(int id_carrito) {
        double total = 0.0;
        String query = "SELECT SUM(totalProducto) as total FROM carrito_producto WHERE id_carrito = ?";
        try (Connection con = DatabaseConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, id_carrito);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    total = rs.getDouble("total");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    //borrar del carrito
    public boolean eliminarPorId(int id_carrito_producto) {
        boolean eliminado = false;
        String query = "DELETE FROM carrito_producto WHERE id_carrito_producto = ?";
        try (Connection con = DatabaseConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, id_carrito_producto);
            eliminado = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return eliminado;
    }

    //cambiar la cantidad del producto en el carrito
    public boolean actualizarCantidadYTotal(int idCarritoProducto, int cantidad) {
        boolean actualizado = false;
        String querySelect = "SELECT precio FROM carrito_producto WHERE id_carrito_producto = ?";
        String queryUpdate = "UPDATE carrito_producto SET cantidad = ?, totalProducto = ? WHERE id_carrito_producto = ?";

        try (Connection con = DatabaseConnectionManager.getConnection();
             PreparedStatement psSelect = con.prepareStatement(querySelect)) {

            psSelect.setInt(1, idCarritoProducto);
            ResultSet rs = psSelect.executeQuery();

            if (rs.next()) {
                double precio = rs.getDouble("precio");
                double totalProducto = precio * cantidad;

                try (PreparedStatement psUpdate = con.prepareStatement(queryUpdate)) {
                    psUpdate.setInt(1, cantidad);
                    psUpdate.setDouble(2, totalProducto);
                    psUpdate.setInt(3, idCarritoProducto);
                    actualizado = psUpdate.executeUpdate() > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return actualizado;
    }

    //obtener productos de un carrito especifico
    public List<Carrito_Producto> obtenerProductosPorCarrito(int id_carrito) {
        List<Carrito_Producto> productosEnCarrito = new ArrayList<>();
        String query = "SELECT cp.*, p.nombre, p.descripcion, p.precio as producto_precio " +
                "FROM carrito_producto cp " +
                "JOIN producto p ON cp.sku = p.sku " +
                "WHERE cp.id_carrito = ?";
        try (Connection con = DatabaseConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, id_carrito);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Carrito_Producto cp = new Carrito_Producto();
                    cp.setId_carrito_producto(rs.getInt("id_carrito_producto"));
                    cp.setPrecio(rs.getDouble("precio"));
                    cp.setCantidad(rs.getInt("cantidad"));
                    cp.setTotalProducto(rs.getDouble("totalProducto"));

                    Producto producto = new Producto();
                    producto.setSku(rs.getString("sku"));
                    producto.setNombre(rs.getString("nombre"));
                    producto.setDescripcion(rs.getString("descripcion"));
                    producto.setPrecio(rs.getDouble("producto_precio"));
                    cp.setProducto(producto);

                    Carrito carrito = new Carrito();
                    carrito.setId_carrito(rs.getInt("id_carrito"));
                    cp.setCarrito(carrito);

                    productosEnCarrito.add(cp);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return productosEnCarrito;
    }

}
