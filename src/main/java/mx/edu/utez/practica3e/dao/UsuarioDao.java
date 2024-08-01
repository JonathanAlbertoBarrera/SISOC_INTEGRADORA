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

    //get all pero solo encargados
    public List<Usuario> getAllEncargados() {
        List<Usuario> usuarios = new ArrayList<>();
        String query = "SELECT u.id_usuario, u.correo, u.contrasena, u.estatus, " +
                "p.id_persona, p.nombre, p.apellidos, p.telefono, p.sexo, " +
                "r.id, r.tipoRol " +
                "FROM usuario u " +
                "JOIN persona p ON u.id_persona = p.id_persona " +
                "JOIN roles r ON u.id_rol = r.id WHERE u.id_rol=3"; //el id 3 de rol corresponde a encargados

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

    //get all pero solo clientes
    public List<Usuario> getAllClientes() {
        List<Usuario> usuarios = new ArrayList<>();
        String query = "SELECT u.id_usuario, u.correo, u.contrasena, u.estatus, " +
                "p.id_persona, p.nombre, p.apellidos, p.telefono, p.sexo, " +
                "r.id, r.tipoRol " +
                "FROM usuario u " +
                "JOIN persona p ON u.id_persona = p.id_persona " +
                "JOIN roles r ON u.id_rol = r.id WHERE u.id_rol=2"; //el id 2 de rol corresponde a clientes

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

    //get all pero sin usuario Administrador
    public List<Usuario> getAllSinAdmin() {
        List<Usuario> usuarios = new ArrayList<>();
        String query = "SELECT u.id_usuario, u.correo, u.contrasena, u.estatus, " +
                "p.id_persona, p.nombre, p.apellidos, p.telefono, p.sexo, " +
                "r.id, r.tipoRol " +
                "FROM usuario u " +
                "JOIN persona p ON u.id_persona = p.id_persona " +
                "JOIN roles r ON u.id_rol = r.id WHERE u.id_rol!=1"; //el id 2 de rol corresponde a clientes

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

    //Modificar USUARIO COMPLETO
    public boolean updateUsuario(Usuario u) {
        boolean flag = false;
        String query = "UPDATE usuario u JOIN persona p ON u.id_persona = p.id_persona SET p.nombre = ?, p.apellidos = ?, p.telefono = ?, p.sexo= ?, u.correo = ? WHERE u.id_usuario = ?";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, u.getPersona().getNombre());
            ps.setString(2, u.getPersona().getApellidos());
            ps.setString(3, u.getPersona().getTelefono());
            ps.setString(4, u.getPersona().getSexo());
            ps.setString(5, u.getCorreo());
            ps.setInt(6, u.getIdUsuario());

            if (ps.executeUpdate() > 0) {
                flag = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return flag;
    }

    //Modificar usuario SOLO CONTRASENA
    public boolean update(Usuario u) {
        boolean flag = false;
        String query = "UPDATE usuario SET contrasena = sha2(?, 256),codigo=null WHERE id_usuario = ?";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, u.getContrasena());
            ps.setInt(2, u.getIdUsuario());

            if (ps.executeUpdate() > 0) {
                flag = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return flag;
    }



    //PARA RECUPERACION CONTRA
    public Usuario getByEmail(String email) {
        Usuario u = null;
        String query = "select * from usuario where correo = ?";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                u = new Usuario();
                u.setIdUsuario(rs.getInt("id_usuario"));
                u.setCorreo(rs.getString("correo"));
                u.setCodigo_recuperacion(rs.getString("codigo_recuperacion"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return u;
    }

    public boolean updateCodigoRecuperacion(Usuario u) {
        boolean flag = false;
        String query = "update usuario set codigo = ? where id_usuario = ?";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, u.getCodigo_recuperacion());
            ps.setInt(2, u.getIdUsuario());
            if (ps.executeUpdate() > 0) {
                flag = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return flag;
    }

    public Usuario getByCodigoRecuperacion(String codigo) {
        Usuario u = null;
        String query = "select * from usuario where codigo = ?";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, codigo);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                u = new Usuario();
                u.setIdUsuario(rs.getInt("id_usuario"));
                u.setCorreo(rs.getString("correo"));
                u.setCodigo_recuperacion(rs.getString("codigo_recuperacion"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return u;
    }

    //funcion para desactivar usuarios que usa el admin
    public boolean desactivar(Usuario u) {
        boolean flag = false;
        String query = "UPDATE usuario SET estatus = ? WHERE id_usuario = ?";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setBoolean(1,u.isEstatus());
            ps.setInt(2, u.getIdUsuario());
            if(ps.executeUpdate() > 0){
                flag = true;
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return flag;
    }
    public String obtenerEmailPorId(int idUsuario) {
        String email = null;
        String query = "SELECT correo FROM usuario WHERE id_usuario = ?";

        try (Connection connection = DatabaseConnectionManager.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, idUsuario);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    email = resultSet.getString("correo");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return email;
    }

}
