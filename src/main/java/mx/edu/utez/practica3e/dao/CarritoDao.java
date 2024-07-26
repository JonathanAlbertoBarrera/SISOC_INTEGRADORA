package mx.edu.utez.practica3e.dao;

import mx.edu.utez.practica3e.model.Carrito;
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

}
