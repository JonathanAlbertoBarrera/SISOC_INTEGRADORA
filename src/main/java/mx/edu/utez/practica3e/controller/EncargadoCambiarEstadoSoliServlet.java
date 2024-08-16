package mx.edu.utez.practica3e.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.practica3e.dao.CarritoProductoDao;
import mx.edu.utez.practica3e.dao.SolicitudDao;
import mx.edu.utez.practica3e.dao.SolicitudEncargadoDao;
import mx.edu.utez.practica3e.dao.UsuarioDao;
import mx.edu.utez.practica3e.model.Carrito_Producto;
import mx.edu.utez.practica3e.model.Solicitud;
import mx.edu.utez.practica3e.utils.GmailSender;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

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
        if ("En Proceso".equals(estadoActual)) {
            nuevoEstado = "Lista";
        } else if ("Lista".equals(estadoActual)) {
            nuevoEstado = "Entregada";
        } else {
            session.setAttribute("mensaje", "El estado no puede ser cambiado.");
            resp.sendRedirect("controlSolicitudes.jsp");
            return;
        }

        boolean exito = solicitudDao.cambiarEstadoSolicitud(idSolicitud, nuevoEstado);
        if (!exito) {
            session.setAttribute("mensaje", "Error al cambiar el estado de la solicitud. Inténtelo de nuevo.");
            resp.sendRedirect("controlSolicitudes.jsp");
            return;
        }

        // Obtener la solicitud y validar que no sea nula
        Solicitud solicitud = solicitudDao.obtenerSolicitudPorId(idSolicitud);
        if (solicitud == null) {
            session.setAttribute("mensaje", "Error: La solicitud no existe.");
            resp.sendRedirect("controlSolicitudes.jsp");
            return;
        }

        // Validar que la solicitud tenga un carrito asociado
        if (solicitud.getCarrito() == null) {
            session.setAttribute("mensaje", "Error: La solicitud no tiene un carrito asociado.");
            resp.sendRedirect("controlSolicitudes.jsp");
            return;
        }

        // Obtener productos del carrito
        List<Carrito_Producto> productosEnCarrito = new CarritoProductoDao().obtenerProductosPorCarrito(solicitud.getCarrito().getId_carrito());
        if (productosEnCarrito.isEmpty()) {
            session.setAttribute("mensaje", "Error: El carrito no contiene productos.");
            resp.sendRedirect("controlSolicitudes.jsp");
            return;
        }

        // Validar que el correo del usuario no sea nulo
        String emailUsuario = usuarioDao.obtenerEmailPorId(solicitud.getUsuario().getIdUsuario());
        if (emailUsuario == null || emailUsuario.isEmpty()) {
            session.setAttribute("mensaje", "Error: El usuario no tiene un correo electrónico asociado.");
            resp.sendRedirect("controlSolicitudes.jsp");
            return;
        }

        // Construir el cuerpo del correo
        StringBuilder mensaje = new StringBuilder();
        mensaje.append("<h1>Solicitud ").append(nuevoEstado).append("</h1>");
        mensaje.append("<p>Estimado usuario, la solicitud ").append(idSolicitud).append(" está ").append(nuevoEstado).append(".</p>");
        mensaje.append("<p>Detalle de productos:</p>");
        mensaje.append("<ul>");

        for (Carrito_Producto cp : productosEnCarrito) {
            mensaje.append("<li>").append(cp.getProducto().getNombre())
                    .append(" - Cantidad: ").append(cp.getCantidad())
                    .append(" - Precio: $").append(cp.getProducto().getPrecio())
                    .append(" - Total: $").append(cp.getTotalProducto())
                    .append("</li>");
        }

        mensaje.append("</ul>");
        mensaje.append("<p>Gracias por su preferencia.</p>");

        // Enviar el correo electrónico al usuario
        try {
            new GmailSender().sendMail(emailUsuario, "Solicitud " + nuevoEstado, mensaje.toString());
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("mensaje", "Solicitud actualizada, pero hubo un error al enviar el correo electrónico.");
        }

        session.setAttribute("mensaje", "El estado de la solicitud " + idSolicitud + " se ha cambiado a " + nuevoEstado + ".");
        resp.sendRedirect("controlSolicitudes.jsp");
    }
}
