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
                    Usuario usuario=new Usuario();
                    usuario.setIdUsuario(rs.getInt("id_usuario"));
                    solicitud.setUsuario(usuario);

                    listaSolicitudes.add(solicitud);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return listaSolicitudes;
    }

    //OBTENER LAS SOLICITUDES SEGUN EL USUARIO CORRESPONDIENTE (ENTREGADAS) PARA MOSTRAR EN VENTAS ENCARGADO
    public List<Solicitud> getAllVentasPuntoVentaEncargado(int idUsuario) {
        List<Solicitud> listaSolicitudes = new ArrayList<>();
        String query = "SELECT s.*, p.nombre, p.apellidos " +
                "FROM solicitud s " +
                "JOIN usuario u ON s.id_usuario = u.id_usuario " +
                "JOIN persona p ON u.id_persona = p.id_persona " +
                "WHERE s.id_usuario = ? AND s.estado = 'Entregada'";

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

                    Usuario usuario = new Usuario();
                    usuario.setIdUsuario(rs.getInt("id_usuario"));

                    // Verifica si persona es null y la inicializa si es necesario
                    if (usuario.getPersona() == null) {
                        usuario.setPersona(new Persona());
                    }

                    usuario.getPersona().setNombre(rs.getString("nombre"));
                    usuario.getPersona().setApellidos(rs.getString("apellidos"));
                    solicitud.setUsuario(usuario);

                    listaSolicitudes.add(solicitud);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return listaSolicitudes;
    }


    // PARA OBTENER SOLICITUDES que no esten entregadas o canceladas
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
                    Usuario usuario=new Usuario();
                    usuario.setIdUsuario(rs.getInt("id_usuario"));
                    solicitud.setUsuario(usuario);

                    listaSolicitudes.add(solicitud);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return listaSolicitudes;
    }

    //obtener todas las solicitudes pendientes
    public List<Solicitud> getAllPendientes() {
        List<Solicitud> listaSolicitudes = new ArrayList<>();
        String query = "SELECT s.*, u.correo, p.nombre, p.apellidos " +
                "FROM solicitud s " +
                "JOIN usuario u ON s.id_usuario = u.id_usuario " +
                "JOIN persona p ON u.id_persona = p.id_persona " +
                "WHERE s.estado = 'Pendiente'";

        try (Connection con = DatabaseConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

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

                    Usuario usuario = new Usuario();
                    usuario.setIdUsuario(rs.getInt("id_usuario"));
                    usuario.setCorreo(rs.getString("correo"));

                    Persona persona = new Persona();
                    persona.setNombre(rs.getString("nombre"));
                    persona.setApellidos(rs.getString("apellidos"));
                    usuario.setPersona(persona);

                    solicitud.setUsuario(usuario);

                    listaSolicitudes.add(solicitud);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return listaSolicitudes;
    }

    //para cambiar el estado de la solicitud a Lista o Entregada
    public boolean cambiarEstadoSolicitud(int id_solicitud, String nuevoEstado) {
        String query = "UPDATE solicitud SET estado = ? WHERE id_solicitud = ?";
        try (Connection con = DatabaseConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, nuevoEstado);
            ps.setInt(2, id_solicitud);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Método para cancelar la solicitud y restaurar el stock de los productos
    public boolean cancelarSolicitud(int idSolicitud) {
        String updateSolicitudQuery = "UPDATE solicitud SET estado = 'Cancelada' WHERE id_solicitud = ?";
        String selectProductosQuery = "SELECT cp.sku, cp.cantidad FROM carrito_producto cp " +
                "JOIN solicitud s ON cp.id_carrito = s.id_carrito " +
                "WHERE s.id_solicitud = ?";
        String updateProductoQuery = "UPDATE producto SET cantidad = cantidad + ? WHERE sku = ?";
        boolean exito = false;

        try (Connection con = DatabaseConnectionManager.getConnection()) {
            // Actualizar el estado de la solicitud
            try (PreparedStatement ps = con.prepareStatement(updateSolicitudQuery)) {
                ps.setInt(1, idSolicitud);
                ps.executeUpdate();
            }

            // Obtener los productos y cantidades del carrito asociado a la solicitud
            try (PreparedStatement ps = con.prepareStatement(selectProductosQuery)) {
                ps.setInt(1, idSolicitud);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        String sku = rs.getString("sku");
                        int cantidad = rs.getInt("cantidad");

                        // Restaurar el stock del producto
                        try (PreparedStatement psUpdate = con.prepareStatement(updateProductoQuery)) {
                            psUpdate.setInt(1, cantidad);
                            psUpdate.setString(2, sku);
                            psUpdate.executeUpdate();
                        }
                    }
                }
            }

            exito = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return exito;
    }

    //obtener solicitudes entregadas
    public List<Solicitud> obtenerSolicitudesEntregadas() {
        List<Solicitud> listaSolicitudes = new ArrayList<>();
        String query = "SELECT s.id_solicitud, s.id_carrito, s.id_usuario, s.total, s.fecha, s.estado, " +
                "u.id_usuario, u.correo, p.nombre, p.apellidos " +
                "FROM solicitud s " +
                "JOIN usuario u ON s.id_usuario = u.id_usuario " +
                "JOIN persona p ON u.id_persona = p.id_persona " +
                "WHERE s.estado = 'Entregada'";

        try (Connection con = DatabaseConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Solicitud solicitud = new Solicitud();
                solicitud.setId_solicitud(rs.getInt("id_solicitud"));
                solicitud.setTotal(rs.getDouble("total"));
                solicitud.setFecha(rs.getDate("fecha"));
                solicitud.setEstado(rs.getString("estado"));

                // Carrito
                Carrito carrito = new Carrito();
                carrito.setId_carrito(rs.getInt("id_carrito"));
                solicitud.setCarrito(carrito);

                // Usuario (cliente)
                Usuario cliente = new Usuario();
                cliente.setIdUsuario(rs.getInt("id_usuario"));
                cliente.setCorreo(rs.getString("correo"));

                Persona personaCliente = new Persona();
                personaCliente.setNombre(rs.getString("nombre"));
                personaCliente.setApellidos(rs.getString("apellidos"));
                cliente.setPersona(personaCliente);

                solicitud.setUsuario(cliente);

                listaSolicitudes.add(solicitud);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return listaSolicitudes;
    }
    public Solicitud obtenerSolicitudPorId(int id) {
        Solicitud solicitud = null;
        String query = "SELECT s.id_solicitud, s.fecha, s.total, s.estado, u.id_usuario, u.correo " +
                "FROM solicitud s " +
                "JOIN usuario u ON s.id_usuario = u.id_usuario " +
                "WHERE s.id_solicitud = ?";

        try (Connection connection = DatabaseConnectionManager.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, id);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    solicitud = new Solicitud();
                    solicitud.setId_solicitud(resultSet.getInt("id_solicitud"));
                    solicitud.setFecha(resultSet.getDate("fecha"));
                    solicitud.setTotal(resultSet.getDouble("total"));
                    solicitud.setEstado(resultSet.getString("estado"));

                    Usuario usuario = new Usuario();
                    usuario.setIdUsuario(resultSet.getInt("id_usuario"));
                    usuario.setCorreo(resultSet.getString("correo"));
                    solicitud.setUsuario(usuario);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return solicitud;
    }
}
