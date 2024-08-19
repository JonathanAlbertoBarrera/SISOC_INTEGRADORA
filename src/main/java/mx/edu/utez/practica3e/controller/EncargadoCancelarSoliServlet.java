package mx.edu.utez.practica3e.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.practica3e.dao.SolicitudDao;
import mx.edu.utez.practica3e.dao.UsuarioDao;
import mx.edu.utez.practica3e.model.Solicitud;
import mx.edu.utez.practica3e.utils.GmailSender;

import java.io.IOException;

@WebServlet(name = "EncargadoCancelarSoliServlet", value = "/cancelarSoli")
public class EncargadoCancelarSoliServlet extends HttpServlet {

    private final SolicitudDao solicitudDao = new SolicitudDao();
    private final UsuarioDao usuarioDao = new UsuarioDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id_solicitud = Integer.parseInt(req.getParameter("id_solicitud"));
        String motivo = req.getParameter("motivo");
        HttpSession session = req.getSession();

        // Cancelar la solicitud
        boolean exito = solicitudDao.cancelarSolicitud(id_solicitud);

        if (exito) {
            session.setAttribute("mensaje", "La solicitud " + id_solicitud + " se ha cancelado exitosamente.");

            // Obtener la solicitud para acceder al usuario
            Solicitud solicitud = solicitudDao.obtenerSolicitudPorId(id_solicitud);

            if (solicitud != null) {
                // Obtener el email del usuario
                String emailUsuario = usuarioDao.obtenerEmailPorId(solicitud.getUsuario().getIdUsuario());

                if (emailUsuario != null && !emailUsuario.isEmpty()) {
                    // Construir el cuerpo del correo
                    StringBuilder mensaje = new StringBuilder();
                    mensaje.append("<h1>Solicitud Cancelada</h1>");
                    mensaje.append("<p>Estimado usuario, lamentamos informarle que la solicitud ")
                            .append(id_solicitud).append(" ha sido cancelada.</p>");
                    mensaje.append("<p><strong>Motivo de la cancelación:</strong> ").append(motivo).append("</p>");
                    mensaje.append("<p>Gracias por su comprensión.</p>");

                    // Enviar el correo electrónico al usuario
                    try {
                        new GmailSender().sendMail(emailUsuario, "Solicitud Cancelada", mensaje.toString());
                    } catch (Exception e) {
                        e.printStackTrace();
                        session.setAttribute("mensaje", "Solicitud cancelada, pero hubo un error al enviar el correo electrónico.");
                    }
                } else {
                    session.setAttribute("mensaje", "Solicitud cancelada, pero el usuario no tiene un correo electrónico asociado.");
                }
            } else {
                session.setAttribute("mensaje", "Solicitud cancelada, pero no se pudo obtener la información de la solicitud.");
            }
        } else {
            session.setAttribute("mensaje", "Hubo un problema al cancelar la solicitud.");
        }

        // Redirigir a controlSolicitudes.jsp
        resp.sendRedirect("controlSolicitudes.jsp");
    }
}

