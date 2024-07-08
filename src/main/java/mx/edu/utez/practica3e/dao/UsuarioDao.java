package mx.edu.utez.practica3e.dao;


import mx.edu.utez.practica3e.model.Persona;
import mx.edu.utez.practica3e.model.Rol;
import mx.edu.utez.practica3e.model.Usuario;
import mx.edu.utez.practica3e.utils.DatabaseConnectionManager;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

// Estas clases DAO permiten el uso de funciones CRUD
public class UsuarioDao {

    //Obtener un solo Usuario, considerando que hay datos tambien en la tabla Persona y Rol
    public Usuario getOne(String correo, String contrasena) {
        Usuario usuario = null;
        String query = "SELECT u.id_usuario, u.correo, u.contrasena, u.estatus, " +
                "p.id_persona, p.nombre, p.apellidos, p.telefono, p.sexo, " +
                "r.id, r.tipoRol " +
                "FROM usuario u " +
                "JOIN persona p ON u.id_persona = p.id_persona " +
                "JOIN roles r ON u.id_rol = r.id " +
                "WHERE u.correo = ? AND u.contrasena = sha2(?, 256)";

        try (Connection con = DatabaseConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, correo);
            ps.setString(2, contrasena);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Persona persona = new Persona();
                    persona.setIdPersona(rs.getInt("id_persona"));
                    persona.setNombre(rs.getString("nombre"));
                    persona.setApellidos(rs.getString("apellidos"));
                    persona.setTelefono(rs.getString("telefono"));
                    persona.setSexo(rs.getString("sexo"));

                    Rol rol = new Rol();
                    rol.setId(rs.getInt("id"));
                    rol.setTipoRol(rs.getString("tipoRol"));

                    usuario = new Usuario();
                    usuario.setIdUsuario(rs.getInt("id_usuario"));
                    usuario.setCorreo(rs.getString("correo"));
                    usuario.setContrasena(rs.getString("contrasena"));
                    usuario.setEstatus(rs.getBoolean("estatus"));
                    usuario.setPersona(persona);
                    usuario.setRol(rol);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return usuario;
    }

    //Se obtienen todos los usuarios
    public List<Usuario> getAll() {
        List<Usuario> usuarios = new ArrayList<>();
        String query = "SELECT u.id_usuario, u.correo, u.contrasena, u.estatus, " +
                "p.id_persona, p.nombre, p.apellidos, p.telefono, p.sexo, " +
                "r.id, r.tipoRol " +
                "FROM usuario u " +
                "JOIN persona p ON u.id_persona = p.id_persona " +
                "JOIN roles r ON u.id_rol = r.id";

        try (Connection con = DatabaseConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Persona persona = new Persona();
                persona.setIdPersona(rs.getInt("id_persona"));
                persona.setNombre(rs.getString("nombre"));
                persona.setApellidos(rs.getString("apellidos"));
                persona.setTelefono(rs.getString("telefono"));
                persona.setSexo(rs.getString("sexo"));

                Rol rol = new Rol();
                rol.setId(rs.getInt("id"));
                rol.setTipoRol(rs.getString("tipoRol"));

                Usuario usuario = new Usuario();
                usuario.setIdUsuario(rs.getInt("id_usuario"));
                usuario.setCorreo(rs.getString("correo"));
                usuario.setContrasena(rs.getString("contrasena"));
                usuario.setEstatus(rs.getBoolean("estatus"));
                usuario.setPersona(persona);
                usuario.setRol(rol);

                usuarios.add(usuario);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return usuarios;
    }

    //Se inserta tanto en la tabla usuario como en persona
    public boolean insert(Usuario u, Persona p) {
        boolean flag = false;
        String queryPersona = "INSERT INTO persona (nombre, apellidos, telefono, sexo) VALUES (?, ?, ?, ?)";
        String queryUsuario = "INSERT INTO usuario (id_persona, id_rol, correo, contrasena, estatus) VALUES (?, ?, ?, sha2(?, 256), ?)";

        try (Connection con = DatabaseConnectionManager.getConnection()) {
            con.setAutoCommit(false);

            try (PreparedStatement psPersona = con.prepareStatement(queryPersona, PreparedStatement.RETURN_GENERATED_KEYS)) {
                psPersona.setString(1, p.getNombre());
                psPersona.setString(2, p.getApellidos());
                psPersona.setString(3, p.getTelefono());
                psPersona.setString(4, p.getSexo());

                if (psPersona.executeUpdate() == 1) {
                    try (ResultSet generatedKeys = psPersona.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            int idPersona = generatedKeys.getInt(1);

                            try (PreparedStatement psUsuario = con.prepareStatement(queryUsuario)) {
                                psUsuario.setInt(1, idPersona);
                                psUsuario.setInt(2, u.getRol().getId());  // Rol por defecto
                                psUsuario.setString(3, u.getCorreo());
                                psUsuario.setString(4, u.getContrasena());
                                psUsuario.setBoolean(5, u.isEstatus());

                                if (psUsuario.executeUpdate() == 1) {
                                    con.commit();
                                    flag = true;  // Porque significa que sí se insertó en la BD
                                } else {
                                    con.rollback();
                                }
                            }
                        } else {
                            con.rollback();
                        }
                    }
                } else {
                    con.rollback();
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return flag;
    }

}
