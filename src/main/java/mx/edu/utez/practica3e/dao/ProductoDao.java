package mx.edu.utez.practica3e.dao;

import mx.edu.utez.practica3e.model.*;
import mx.edu.utez.practica3e.utils.DatabaseConnectionManager;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductoDao {
    //Se obtienen todos los productos
    public List<Producto> getAll() {
        List<Producto> productos = new ArrayList<>();
        String query = "SELECT p.sku, p.nombre AS producto_nombre, p.descripcion AS producto_descripcion, p.urlImagen, p.precio, p.cantidad, p.estatus AS producto_estatus, " +
                "c.id_categoria, c.nombre AS categoria_nombre, c.descripcion AS categoria_descripcion, c.estatus AS categoria_estatus, " +
                "m.id_marca, m.nombre AS marca_nombre, m.descripcion AS marca_descripcion, m.estatus AS marca_estatus " +
                "FROM producto p " +
                "JOIN categoria c ON p.id_categoria = c.id_categoria " +
                "JOIN marca m ON p.id_marca = m.id_marca";

        try (Connection con = DatabaseConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Categoria categoria = new Categoria();
                categoria.setId_categoria(rs.getInt("id_categoria"));
                categoria.setNombre(rs.getString("categoria_nombre"));
                categoria.setDescripcion(rs.getString("categoria_descripcion"));
                categoria.setEstatus(rs.getBoolean("categoria_estatus"));

                Marca marca = new Marca();
                marca.setId_marca(rs.getInt("id_marca"));
                marca.setNombre(rs.getString("marca_nombre"));
                marca.setDescripcion(rs.getString("marca_descripcion"));
                marca.setEstatus(rs.getBoolean("marca_estatus"));

                Producto producto = new Producto();
                producto.setSku(rs.getString("sku"));
                producto.setNombre(rs.getString("producto_nombre"));
                producto.setDescripcion(rs.getString("producto_descripcion"));
                producto.setUrlImagen(rs.getString("urlImagen"));
                producto.setPrecio(rs.getDouble("precio"));
                producto.setCantidad(rs.getInt("cantidad"));
                producto.setEstatus(rs.getBoolean("producto_estatus"));

                producto.setCategoria(categoria);
                producto.setMarca(marca);

                productos.add(producto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return productos;
    }


    //insertar producto
    public boolean insert(Producto producto,Categoria c, Marca m) {
        boolean flag = false;
        String query = "INSERT INTO producto (sku, id_categoria, id_marca, nombre, descripcion, urlImagen, precio, cantidad, estatus) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, producto.getSku());
            ps.setInt(2, producto.getCategoria().getId_categoria());
            ps.setInt(3, producto.getMarca().getId_marca());
            ps.setString(4, producto.getNombre());
            ps.setString(5, producto.getDescripcion());
            ps.setString(6, producto.getUrlImagen());
            ps.setDouble(7, producto.getPrecio());
            ps.setInt(8, producto.getCantidad());
            ps.setBoolean(9, producto.isEstatus());
            if (ps.executeUpdate() > 0) {
                flag = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return flag;
    }


    //desactivar un producto
    public boolean desactivar(Producto p) {
        boolean flag = false;
        String query = "UPDATE producto SET estatus = ? WHERE sku = ?";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setBoolean(1,p.isEstatus());
            ps.setString(2, p.getSku());
            if(ps.executeUpdate() > 0){
                flag = true;
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return flag;
    }

}
