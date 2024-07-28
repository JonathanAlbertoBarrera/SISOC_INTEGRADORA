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

    //OBTENER LAS SOLICITUDES SEGUN EL USUARIO CORRESPONDIENTE (SIN IMPORTAR ESTADO)
    public List<Solicitud> getAllPorUsuario(int idUsuario) {
        List<Solicitud> listaSolicitudes = new ArrayList<>();
        String query = "SELECT * FROM solicitud WHERE id_usuario = ?";

        try (Connection con = DatabaseConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, idUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Solicitud solicitud = new Solicitud();
                    solicitud.setId_solicitud(rs.getInt("id_solicitud"));
                    solicitud.setTotal(rs.getDouble("total"));
                    solicitud.setFecha(rs.getDate("fecha"));
                    solicitud.setEstado(rs.getString("estado"));
                    Carrito carrito = new Carrito();
                    carrito.setId_carrito(rs.getInt("id_carrito"));
                    solicitud.setCarrito(carrito);

                    listaSolicitudes.add(solicitud);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return listaSolicitudes;
    }

    // PARA OBTENER SOLICITUDES PENDIENTES O EN PROCESO
    public List<Solicitud> getSolicitudesPendientesPorUsuario(int idUsuario) {
        List<Solicitud> listaSolicitudes = new ArrayList<>();
        String query = "SELECT * FROM solicitud WHERE id_usuario = ? AND estado != 'Entregada' AND estado != 'Cancelada'";


        try (Connection con = DatabaseConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, idUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Solicitud solicitud = new Solicitud();
                    solicitud.setId_solicitud(rs.getInt("id_solicitud"));
                    solicitud.setTotal(rs.getDouble("total"));
                    solicitud.setFecha(rs.getDate("fecha"));
                    solicitud.setEstado(rs.getString("estado"));
                    Carrito carrito = new Carrito();
                    carrito.setId_carrito(rs.getInt("id_carrito"));
                    solicitud.setCarrito(carrito);

                    listaSolicitudes.add(solicitud);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return listaSolicitudes;
    }
}
