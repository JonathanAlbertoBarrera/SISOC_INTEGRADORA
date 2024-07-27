package mx.edu.utez.practica3e.dao;

import mx.edu.utez.practica3e.model.Carrito;
import mx.edu.utez.practica3e.model.Carrito_Producto;
import mx.edu.utez.practica3e.model.Producto;
import mx.edu.utez.practica3e.model.Usuario;
import mx.edu.utez.practica3e.utils.DatabaseConnectionManager;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CarritoDao {

    //saber si el carrito no esta confirmado
    public Carrito getCarritoNoConfirmado(int id_usuario) {
        Carrito carrito = null;
        String query = "SELECT id_carrito, id_usuario, confirmado FROM carrito WHERE id_usuario = ? AND confirmado = false";

        try (Connection con = DatabaseConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, id_usuario);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    carrito = new Carrito();
                    carrito.setId_carrito(rs.getInt("id_carrito"));

                    Usuario usuario = new Usuario();
                    usuario.setIdUsuario(rs.getInt("id_usuario"));
                    carrito.setUsuario(usuario);

                    carrito.setConfirmado(rs.getBoolean("confirmado"));

                } else {
                    System.out.println("No se encontró un carrito no confirmado para el usuario ID: " + id_usuario);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return carrito;
    }


    //creacion de carrito
    public void crearCarrito(Carrito carrito) {
        String query = "INSERT INTO carrito (id_usuario, confirmado) VALUES (?, ?)";

        try (Connection con = DatabaseConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, carrito.getUsuario().getIdUsuario());
            ps.setBoolean(2, carrito.isConfirmado());
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    carrito.setId_carrito(rs.getInt(1));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    // Para obtener todos los productos registrados mediante un cierto carrito
    public List<Carrito_Producto> getAllPorCarrito(int id_carrito) {
        List<Carrito_Producto> lista = new ArrayList<>();
        String query = "SELECT cp.id_carrito_producto, cp.id_carrito, cp.sku, cp.cantidad,cp.precio, cp.totalProducto, " +
                "p.nombre, p.descripcion, p.imagen " +
                "FROM carrito_producto cp " +
                "JOIN producto p ON cp.sku = p.sku " +
                "WHERE cp.id_carrito = ?";

        try (Connection con = DatabaseConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, id_carrito);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Carrito_Producto carritoProducto = new Carrito_Producto();
                    carritoProducto.setId_carrito_producto(rs.getInt("id_carrito_producto"));

                    // Inicializa los objetos antes de usarlos
                    Carrito carrito = new Carrito();
                    carrito.setId_carrito(rs.getInt("id_carrito"));
                    carritoProducto.setCarrito(carrito);

                    Producto producto = new Producto();
                    producto.setSku(rs.getString("sku"));
                    producto.setNombre(rs.getString("nombre"));
                    producto.setDescripcion(rs.getString("descripcion"));
                    producto.setImagen(rs.getBytes("imagen"));
                    producto.setPrecio(rs.getDouble("precio"));
                    carritoProducto.setProducto(producto);

                    carritoProducto.setCantidad(rs.getInt("cantidad"));
                    carritoProducto.setPrecio(rs.getInt("precio"));
                    carritoProducto.setTotalProducto(rs.getDouble("totalProducto"));

                    lista.add(carritoProducto);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error al obtener productos del carrito: " + e.getMessage());
        }
        return lista;
    }


}
