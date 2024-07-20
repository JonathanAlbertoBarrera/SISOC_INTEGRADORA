package mx.edu.utez.practica3e.dao;

import mx.edu.utez.practica3e.utils.DatabaseConnectionManager;
import mx.edu.utez.practica3e.model.Categoria;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoriaDao {

    //se inserta una categoria
    public boolean insert(Categoria c) {
        boolean flag = false;
        String query = "INSERT INTO categoria (nombre,descripcion,estatus) VALUES (?, ?, ?)";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, c.getNombre());
            ps.setString(2, c.getDescripcion());
            ps.setBoolean(3,c.isEstatus());
            if(ps.executeUpdate() > 0){
                flag = true;
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return flag;
    }

    //Se obtienen todas las categorias
    public List<Categoria> getAll() {
        List<Categoria> categorias = new ArrayList<>();
        String query = "SELECT * FROM categoria";

        try (Connection con = DatabaseConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Categoria categoria = new Categoria();
                categoria.setId_categoria(rs.getInt("id_categoria"));
                categoria.setNombre(rs.getString("nombre"));
                categoria.setDescripcion(rs.getString("descripcion"));
                categoria.setEstatus(rs.getBoolean("estatus"));

                categorias.add(categoria);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categorias;
    }

    //se modifica una categoria
    public boolean updateCategoria(Categoria c) {
        boolean flag = false;
        String query = "UPDATE categoria SET nombre = ?, descripcion = ? WHERE id_categoria = ?";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, c.getNombre());
            ps.setString(2, c.getDescripcion());
            ps.setInt(3,c.getId_categoria());
            if (ps.executeUpdate() > 0) {
                flag = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return flag;
    }

    //cambiar estatus a inactivo a una categoria
    public boolean desactivar(Categoria c) {
        boolean flag = false;
        String query = "UPDATE categoria SET estatus = ? WHERE id_categoria = ?";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setBoolean(1,c.isEstatus());
            ps.setInt(2, c.getId_categoria());
            if(ps.executeUpdate() > 0){
                flag = true;
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return flag;
    }

}
