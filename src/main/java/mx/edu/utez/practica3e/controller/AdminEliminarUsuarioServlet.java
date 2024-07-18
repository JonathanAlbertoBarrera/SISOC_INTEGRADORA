package mx.edu.utez.practica3e.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.practica3e.dao.UsuarioDao;
import mx.edu.utez.practica3e.model.Usuario;

import java.io.IOException;

@WebServlet(name="AdminEliminarUsuarioServlet", value ="/desactivar")
public class AdminEliminarUsuarioServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        boolean estado = Boolean.parseBoolean(req.getParameter("estado"));

        Usuario u = new Usuario();
        u.setIdUsuario(id);
        u.setEstatus(!estado); // Cambiar el estado actual

        UsuarioDao dao = new UsuarioDao();
        if(dao.desactivar(u)){
            // Si se hizo el update de estado
            resp.sendRedirect("indexAdmin.jsp");
        } else {
            // No se pudo cambiar el estado, mando un error
            req.getSession().setAttribute("mensaje", "No se pudo cambiar el estado");
            resp.sendRedirect("indexAdmin.jsp");
        }
    }
}

