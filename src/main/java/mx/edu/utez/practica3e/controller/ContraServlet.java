package mx.edu.utez.practica3e.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.practica3e.dao.UsuarioDao;
import mx.edu.utez.practica3e.model.Usuario;
import mx.edu.utez.practica3e.utils.GmailSender;
import mx.edu.utez.practica3e.utils.SimpleRandomStringGenerator;

import java.io.IOException;

@WebServlet(name = "ContraServlet", value = "/recuContra")
public class ContraServlet extends HttpServlet {
    private final UsuarioDao usuarioDao = new UsuarioDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Obtener email
        String email = request.getParameter("correo");

        // 2. Revisar que existe en la BD
        Usuario usuario = usuarioDao.getByEmail(email);
        if (usuario == null) {
            request.getSession().setAttribute("mensaje", "Correo no registrado.");
            response.sendRedirect("solicitudRecuperacion.jsp");
            return;
        }

        // 3. Generar código
        String codigo = SimpleRandomStringGenerator.generateRandomString(20);

        // 4. Insertar código en BD
        usuario.setCodigo_recuperacion(codigo);
        usuarioDao.updateCodigoRecuperacion(usuario);

        // 5. Generar correo electrónico con enlace
        String enlace = "http://localhost:8080/practica3e_war_exploded/recuContra?codigo=" + codigo;
        String mensaje = "<a href=\"" + enlace + "\">click aquí</a>";
        try {
            new GmailSender().sendMail(email, "Recuperación de Contraseña", mensaje);
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("index.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Obtener código
        String codigo = request.getParameter("codigo");

        // 2. Revisar que existe en la BD
        Usuario usuario = usuarioDao.getByCodigoRecuperacion(codigo);
        if (usuario == null) {
            request.getSession().setAttribute("mensaje", "Código inválido.");
            response.sendRedirect("solicitudRecuperacion.jsp");
            return;
        }

        // 3. Redirigir a recuperacion.jsp
        response.sendRedirect("recuperacion.jsp?codigo=" + codigo);
    }
}
