package mx.edu.utez.practica3e.dao;


import mx.edu.utez.practica3e.model.Usuario;
import mx.edu.utez.practica3e.utils.DatabaseConnectionManager;

import java.sql.*;

// Estas clases DAO permiten el uso de funciones CRUD
public class UsuarioDao {

    //Programar una función R (lectura) para obtener un usuario
    //con el fin de hacer el inicio de sesión
    public Usuario getOne(String correo, String contrasena){
        Usuario u = new Usuario();
        String query = "select * from usuario where correo = ? and contrasena = sha2(?,256)";

        try{
            //1) conectarnos a la BD
            Connection con = DatabaseConnectionManager.getConnection();
            //2) Configurar el query y ejecutarlo
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1,correo);
            ps.setString(2,contrasena);
            ResultSet rs = ps.executeQuery();
            //3) Obtener la información
            if(rs.next()){
                //Entonces llenamos la información del usuario
                u.setId_usuario(rs.getInt("id_usuario"));
                u.setId_persona(rs.getInt("id_persona"));
                u.setRol(rs.getInt("rol"));
                u.setCorreo(rs.getString("correo"));
                u.setContrasena(rs.getString("contrasena"));
                u.setEstatus(rs.getBoolean("estatus"));
            }
        } catch(SQLException e){
            e.printStackTrace();
        }
        return u;
    }

    public boolean insert(Usuario u){
        boolean flag = false;
        String query = "insert into usuario(correo,contrasena,estatus) values(?,sha2(?,256),?) ";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1,u.getCorreo());
            ps.setString(2,u.getContrasena());
            ps.setBoolean(3,u.isEstatus());
            if(ps.executeUpdate()==1){
                flag = true;//Porque significa que si se inserto en la BD
                System.out.println("OK");
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
        return flag;
    }


}
