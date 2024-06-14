package mx.edu.utez.practica3e.dao;


import mx.edu.utez.practica3e.model.Usuario;
import mx.edu.utez.practica3e.utils.DatabaseConnectionManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

// Estas clases DAO permiten el uso de funciones CRUD
public class UsuarioDao {

    //Programar una función R (lectura) para obtener un usuario
    //con el fin de hacer el inicio de sesión
    public Usuario getOne(String nombre_usuario, String contra){
        Usuario u = new Usuario();
        String query = "select * from usuario where nombre_usuario = ? and contra = ?";

        try{
            //1) conectarnos a la BD
            Connection con = DatabaseConnectionManager.getConnection();
            //2) Configurar el query y ejecutarlo
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1,nombre_usuario);
            ps.setString(2,contra);
            ResultSet rs = ps.executeQuery();
            //3) Obtener la información
            if(rs.next()){
                //Entonces llenamos la información del usuario
                u.setId(rs.getInt("id"));
                u.setNombre_usuario(rs.getString("nombre_usuario"));
                u.setContra(rs.getString("contra"));
                u.setCorreo(rs.getString("correo"));
                u.setTipo_usuario(rs.getInt("tipo_usuario"));
                u.setEstado(rs.getBoolean("estado"));
            }
        } catch(SQLException e){
            e.printStackTrace();
        }
        return u;
    }


}
