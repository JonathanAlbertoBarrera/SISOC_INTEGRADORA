package mx.edu.utez.practica3e.controller;

import mx.edu.utez.practica3e.dao.SolicitudEncargadoDao;
import mx.edu.utez.practica3e.dao.SolicitudDao;
import mx.edu.utez.practica3e.dao.UsuarioDao;
import mx.edu.utez.practica3e.model.Solicitud;
import mx.edu.utez.practica3e.model.Solicitud_Encargado;
import mx.edu.utez.practica3e.model.Usuario;
import mx.edu.utez.practica3e.utils.GmailSender;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name="EncargadoTomarSolicitudServlet", value="/tomarSolicitud")
public class EncargadoTomarSolicitudServlet extends HttpServlet {

    private final SolicitudEncargadoDao seDao = new SolicitudEncargadoDao();
    private final SolicitudDao solicitudDao = new SolicitudDao();
    private final UsuarioDao usuarioDao = new UsuarioDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id_solicitud = Integer.parseInt(request.getParameter("id_solicitud"));
        Usuario encargado = (Usuario) request.getSession().getAttribute("usuario");
        HttpSession session = request.getSession();

        Solicitud_Encargado solicitudEncargado = new Solicitud_Encargado();
        Solicitud solicitud = solicitudDao.obtenerSolicitudPorId(id_solicitud);
        solicitudEncargado.setSolicitud(solicitud);
        solicitudEncargado.setEncargado(encargado);

        boolean exito = seDao.tomarSolicitud(solicitudEncargado);
        if (exito) {
            session.setAttribute("mensaje", "Solicitud tomada con éxito.");

            // Obtener el correo electrónico del usuario
            String emailUsuario = usuarioDao.obtenerEmailPorId(solicitud.getUsuario().getIdUsuario());

            // Enviar el correo electrónico al usuario
            String mensaje = "<h1>Solicitud en Proceso</h1>" +
                    "<p>Estimado usuario la solicitud: " + id_solicitud  +
                    "<p>Nos complace informarle que su solicitud está siendo procesada por nuestro personal.</p>" +
                    "<p>Gracias por su preferencia.</p>";

            try {
                new GmailSender().sendMail(emailUsuario, "Solicitud en Proceso", mensaje);
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("mensaje", "Solicitud tomada con éxito");
            }
        } else {
            session.setAttribute("mensaje", "Error al tomar la solicitud. Inténtelo de nuevo.");
        }

        // Redirigir al indexEncargado
        response.sendRedirect("indexEncargado.jsp");
    }
}