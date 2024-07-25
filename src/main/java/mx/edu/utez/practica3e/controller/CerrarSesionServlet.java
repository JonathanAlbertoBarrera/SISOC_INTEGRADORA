package mx.edu.utez.practica3e.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.practica3e.dao.UsuarioDao;
import mx.edu.utez.practica3e.model.Usuario;

import java.io.IOException;

@WebServlet(name="CerrarSesionServlet", value="/logout")
public class CerrarSesionServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Obtener la sesión actual
        HttpSession session = req.getSession(false);

        if (session != null) {
            // Invalidar la sesión
            session.invalidate();
        }

        // Redirigir al usuario al index sin registro
        resp.sendRedirect("index.jsp");
    }
}
