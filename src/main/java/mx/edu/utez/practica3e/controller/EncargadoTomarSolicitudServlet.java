package mx.edu.utez.practica3e.controller;

import mx.edu.utez.practica3e.dao.CarritoProductoDao;
import mx.edu.utez.practica3e.dao.SolicitudEncargadoDao;
import mx.edu.utez.practica3e.dao.SolicitudDao;
import mx.edu.utez.practica3e.dao.UsuarioDao;
import mx.edu.utez.practica3e.model.Carrito_Producto;
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
import java.util.List;

@WebServlet(name = "EncargadoTomarSolicitudServlet", value = "/tomarSolicitud")
public class EncargadoTomarSolicitudServlet extends HttpServlet {

    private final SolicitudEncargadoDao seDao = new SolicitudEncargadoDao();
    private final SolicitudDao solicitudDao = new SolicitudDao();
    private final UsuarioDao usuarioDao = new UsuarioDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id_solicitud = Integer.parseInt(request.getParameter("id_solicitud"));
        Usuario encargado = (Usuario) request.getSession().getAttribute("usuario");
        HttpSession session = request.getSession();

        // Validar que el usuario esté logueado
        if (encargado == null) {
            session.setAttribute("mensaje", "Error: Usuario no autenticado.");
            response.sendRedirect("index.jsp");
            return;
        }

        // Obtener la solicitud y validar que no sea nula
        Solicitud solicitud = solicitudDao.obtenerSolicitudPorId(id_solicitud);
        if (solicitud == null) {
            session.setAttribute("mensaje", "Error: La solicitud no existe.");
            response.sendRedirect("controlSolicitudes.jsp");
            return;
        }

        // Validar que la solicitud tenga un carrito asociado
        if (solicitud.getCarrito() == null) {
            session.setAttribute("mensaje", "Error: La solicitud no tiene un carrito asociado.");
            response.sendRedirect("controlSolicitudes.jsp");
            return;
        }

        // Obtener productos del carrito
        List<Carrito_Producto> productosEnCarrito = new CarritoProductoDao().obtenerProductosPorCarrito(solicitud.getCarrito().getId_carrito());
        if (productosEnCarrito.isEmpty()) {
            session.setAttribute("mensaje", "Error: El carrito no contiene productos.");
            response.sendRedirect("controlSolicitudes.jsp");
            return;
        }

        // Validar que el correo del usuario no sea nulo
        String emailUsuario = usuarioDao.obtenerEmailPorId(solicitud.getUsuario().getIdUsuario());
        if (emailUsuario == null || emailUsuario.isEmpty()) {
            session.setAttribute("mensaje", "Error: El usuario no tiene un correo electrónico asociado.");
            response.sendRedirect("controlSolicitudes.jsp");
            return;
        }

        // Tomar la solicitud
        Solicitud_Encargado solicitudEncargado = new Solicitud_Encargado();
        solicitudEncargado.setSolicitud(solicitud);
        solicitudEncargado.setEncargado(encargado);

        boolean exito = seDao.tomarSolicitud(solicitudEncargado);
        if (exito) {
            session.setAttribute("mensaje", "Solicitud tomada con éxito.");

            // Construir el cuerpo del correo
            StringBuilder mensaje = new StringBuilder();
            mensaje.append("<h1>Solicitud en Proceso</h1>");
            mensaje.append("<p>Estimado usuario, la solicitud ").append(id_solicitud).append(" está siendo procesada.</p>");
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
                new GmailSender().sendMail(emailUsuario, "Solicitud en Proceso", mensaje.toString());
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("mensaje", "Solicitud tomada con éxito, pero hubo un error al enviar el correo electrónico.");
            }
        } else {
            session.setAttribute("mensaje", "Error al tomar la solicitud. Inténtelo de nuevo.");
        }

        // Redirigir al indexEncargado
        response.sendRedirect("indexEncargado.jsp");
    }
}
