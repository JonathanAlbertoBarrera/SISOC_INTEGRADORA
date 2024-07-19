package mx.edu.utez.practica3e.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.practica3e.dao.UsuarioDao;
import mx.edu.utez.practica3e.model.Persona;
import mx.edu.utez.practica3e.model.Usuario;

import java.io.IOException;

@WebServlet(name="AdminModificarEncargado", value = "/modiEncargado")
public class AdminModificarEncargado extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Actualizar usuario
        try {
            String nombre = req.getParameter("nombre");
            String apellidos = req.getParameter("apellidos");
            String telefono = req.getParameter("telefono");
            String sexo = req.getParameter("sexo");
            String correo = req.getParameter("correo");
            int id_usuario = Integer.parseInt(req.getParameter("id_usuario"));

            // Crear objetos
            Persona persona = new Persona();
            persona.setNombre(nombre);
            persona.setApellidos(apellidos);
            persona.setTelefono(telefono);
            persona.setSexo(sexo);

            Usuario usuario = new Usuario();
            usuario.setIdUsuario(id_usuario);
            usuario.setPersona(persona);
            usuario.setCorreo(correo);

            // Llamar al DAO para actualizar el usuario
            UsuarioDao usuarioDao = new UsuarioDao();
            boolean actualizado = usuarioDao.updateUsuario(usuario);

            if (actualizado) {
                req.getSession().setAttribute("mensaje", "Usuario actualizado exitosamente");
            } else {
                req.getSession().setAttribute("mensaje", "Error al actualizar el usuario");
            }

        } catch (NumberFormatException e) {
            req.getSession().setAttribute("mensaje", "Error al convertir el ID del usuario");
        } catch (Exception e) {
            req.getSession().setAttribute("mensaje", "Error inesperado: " + e.getMessage());
        }

        // Redireccionar de vuelta a la página con la tabla de usuarios
        resp.sendRedirect("indexAdmin.jsp");
    }
}


