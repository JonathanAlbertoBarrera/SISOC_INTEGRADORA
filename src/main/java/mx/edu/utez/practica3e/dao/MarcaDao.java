package mx.edu.utez.practica3e.dao;
import mx.edu.utez.practica3e.model.Usuario;
import mx.edu.utez.practica3e.utils.DatabaseConnectionManager;
import mx.edu.utez.practica3e.model.Marca;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MarcaDao {

    //se inserta una marca
    public boolean insert(Marca m) {
        boolean flag = false;
        String query = "INSERT INTO marca (nombre,descripcion,estatus) VALUES (?, ?, ?)";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, m.getNombre());
            ps.setString(2, m.getDescripcion());
            ps.setBoolean(3,m.isEstatus());
            if(ps.executeUpdate() > 0){
                flag = true;
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return flag;
    }

    //Se obtienen todas las marcas
    public List<Marca> getAll() {
        List<Marca> marcas = new ArrayList<>();
        String query = "SELECT * FROM marca";

        try (Connection con = DatabaseConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Marca marca = new Marca();
                marca.setId_marca(rs.getInt("id_marca"));
                marca.setNombre(rs.getString("nombre"));
                marca.setDescripcion(rs.getString("descripcion"));
                marca.setEstatus(rs.getBoolean("estatus"));

                marcas.add(marca);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return marcas;
    }

    //se modifica una marca
    public boolean updateMarca(Marca m) {
        boolean flag = false;
        String query = "UPDATE marca SET nombre = ?, descripcion = ? WHERE id_marca = ?";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, m.getNombre());
            ps.setString(2, m.getDescripcion());
            ps.setInt(3, m.getId_marca());
            if (ps.executeUpdate() > 0) {
                flag = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return flag;
    }

    //cambiar estatus a inactivo a una marca
    public boolean desactivar(Marca m) {
        boolean flag = false;
        String query = "UPDATE marca SET estatus = ? WHERE id_marca = ?";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setBoolean(1,m.isEstatus());
            ps.setInt(2, m.getId_marca());
            if(ps.executeUpdate() > 0){
                flag = true;
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return flag;
    }

}
