package mx.edu.utez.practica3e.dao;
import mx.edu.utez.practica3e.model.*;
import mx.edu.utez.practica3e.utils.DatabaseConnectionManager;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SolicitudEncargadoDao {
    // Método para registrar la solicitud tomada por el encargado
    public boolean tomarSolicitud(Solicitud_Encargado solicitudEncargado) {
        boolean resultado = false;
        String insertQuery = "INSERT INTO solicitud_encargado (id_solicitud, id_encargado) VALUES (?, ?)";
        String selectQuery = "SELECT estado FROM solicitud WHERE id_solicitud = ?";

        try (Connection con = DatabaseConnectionManager.getConnection();
             PreparedStatement psInsert = con.prepareStatement(insertQuery);
             PreparedStatement psSelect = con.prepareStatement(selectQuery)) {

            // Comprobar el estado de la solicitud
            psSelect.setInt(1, solicitudEncargado.getSolicitud().getId_solicitud());
            try (ResultSet rs = psSelect.executeQuery()) {
                if (rs.next()) {
                    String estado = rs.getString("estado");
                    if (!"Pendiente".equals(estado)) {
                        return false; // No se puede tomar una solicitud que no está pendiente
                    }
                } else {
                    return false; // No se encontró la solicitud
                }
            }

            // Insertar el registro en solicitud_encargado
            psInsert.setInt(1, solicitudEncargado.getSolicitud().getId_solicitud());
            psInsert.setInt(2, solicitudEncargado.getEncargado().getIdUsuario());
            resultado = psInsert.executeUpdate() > 0;

            // Actualizar el estado de la solicitud a "En Proceso"
            if (resultado) {
                actualizarEstadoSolicitud(solicitudEncargado.getSolicitud().getId_solicitud(), "En Proceso");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return resultado;
    }

    // Método para actualizar el estado de una solicitud
    private boolean actualizarEstadoSolicitud(int id_solicitud, String nuevoEstado) {
        String updateQuery = "UPDATE solicitud SET estado = ? WHERE id_solicitud = ?";

        try (Connection con = DatabaseConnectionManager.getConnection();
             PreparedStatement psUpdate = con.prepareStatement(updateQuery)) {

            psUpdate.setString(1, nuevoEstado);
            psUpdate.setInt(2, id_solicitud);
            return psUpdate.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    //obtener solicitudes por encargado
    public List<Solicitud_Encargado> obtenerSolicitudesPorEncargado(int id_encargado) {
        List<Solicitud_Encargado> listaSolicitudesEncargado = new ArrayList<>();
        String query = "SELECT se.id_sc, s.id_solicitud, s.id_carrito, s.total, s.fecha, s.estado, " +
                "u.id_usuario, u.correo, p.nombre, p.apellidos " +
                "FROM solicitud_encargado se " +
                "JOIN solicitud s ON se.id_solicitud = s.id_solicitud " +
                "JOIN usuario u ON s.id_usuario = u.id_usuario " +
                "JOIN persona p ON u.id_persona = p.id_persona " +
                "WHERE se.id_encargado = ? AND s.estado != 'Entregada' AND s.estado != 'Cancelada'";

        try (Connection con = DatabaseConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, id_encargado);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Solicitud_Encargado solicitudEncargado = new Solicitud_Encargado();
                    solicitudEncargado.setId_sc(rs.getInt("id_sc"));

                    Solicitud solicitud = new Solicitud();
                    solicitud.setId_solicitud(rs.getInt("id_solicitud"));
                    solicitud.setTotal(rs.getDouble("total"));
                    solicitud.setFecha(rs.getDate("fecha"));
                    solicitud.setEstado(rs.getString("estado"));

                    Carrito carrito = new Carrito();
                    carrito.setId_carrito(rs.getInt("id_carrito"));
                    solicitud.setCarrito(carrito);

                    Usuario usuario = new Usuario();
                    usuario.setIdUsuario(rs.getInt("id_usuario"));
                    usuario.setCorreo(rs.getString("correo"));

                    Persona persona = new Persona();
                    persona.setNombre(rs.getString("nombre"));
                    persona.setApellidos(rs.getString("apellidos"));
                    usuario.setPersona(persona);

                    solicitud.setUsuario(usuario);
                    solicitudEncargado.setSolicitud(solicitud);

                    listaSolicitudesEncargado.add(solicitudEncargado);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return listaSolicitudesEncargado;
    }


}
