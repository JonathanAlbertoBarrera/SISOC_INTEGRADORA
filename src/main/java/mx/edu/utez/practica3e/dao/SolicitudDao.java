package mx.edu.utez.practica3e.dao;
import mx.edu.utez.practica3e.model.*;
import mx.edu.utez.practica3e.utils.DatabaseConnectionManager;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SolicitudDao {

    //hacer solicitud y saber si se hizo correctamente al ser de tipo boolean
    public boolean guardarSolicitud(Solicitud solicitud) {
        boolean resultado = false;
        String query = "INSERT INTO solicitud (id_carrito, id_usuario, fecha, estado, total) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DatabaseConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, solicitud.getCarrito().getId_carrito());
            ps.setInt(2, solicitud.getUsuario().getIdUsuario());
            ps.setDate(3, solicitud.getFecha());
            ps.setString(4, solicitud.getEstado());
            ps.setDouble(5, solicitud.getTotal());

            resultado = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return resultado;
    }
}
