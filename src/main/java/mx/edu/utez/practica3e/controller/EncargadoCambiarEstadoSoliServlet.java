package mx.edu.utez.practica3e.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.practica3e.dao.SolicitudDao;
import mx.edu.utez.practica3e.dao.SolicitudEncargadoDao;
import mx.edu.utez.practica3e.dao.UsuarioDao;
import mx.edu.utez.practica3e.model.Solicitud;
import mx.edu.utez.practica3e.utils.GmailSender;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "EncargadoCambiarEstadoSoliServlet", value = "/cambiarEstadoSoli")
public class EncargadoCambiarEstadoSoliServlet extends HttpServlet {

    private final SolicitudEncargadoDao seDao = new SolicitudEncargadoDao();
    private final SolicitudDao solicitudDao = new SolicitudDao();
    private final UsuarioDao usuarioDao = new UsuarioDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int idSolicitud = Integer.parseInt(req.getParameter("id_solicitud"));
        String estadoActual = req.getParameter("estado");
        HttpSession session = req.getSession();

        String nuevoEstado;
        if (estadoActual.equals("En Proceso")) {
            nuevoEstado = "Lista";
        } else if (estadoActual.equals("Lista")) {
            nuevoEstado = "Entregada";
        } else {
            req.getSession().setAttribute("mensaje", "El estado no puede ser cambiado.");
            resp.sendRedirect("controlSolicitudes.jsp");
            return;
        }

        boolean exito = solicitudDao.cambiarEstadoSolicitud(idSolicitud, nuevoEstado);
        Solicitud solicitud = solicitudDao.obtenerSolicitudPorId(idSolicitud);

        if (exito) {
            req.getSession().setAttribute("mensaje", "El estado de la solicitud " + idSolicitud + " se ha cambiado a " + nuevoEstado + ".");
            String emailUsuario = usuarioDao.obtenerEmailPorId(solicitud.getUsuario().getIdUsuario());

            // Enviar el correo electrónico al usuario
            String mensaje = "<h1>Solicitud Lista</h1>" +
                    "<p>Estimado usuario la solicitud:" + idSolicitud +
                    "<p>Nos complace informarle que su solicitud está lista para ser entregada.</p>" +
                    "<p>Gracias por su preferencia.</p>";

            try {
                new GmailSender().sendMail(emailUsuario, "Solicitud lista", mensaje);
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("mensaje", "Solicitud lista, pero hubo un error al enviar el correo electrónico.");
            }
        } else {
            session.setAttribute("mensaje", "Error al cambiar el esta de la solicitud. Inténtelo de nuevo.");
        }
        resp.sendRedirect("controlSolicitudes.jsp");
    }

}