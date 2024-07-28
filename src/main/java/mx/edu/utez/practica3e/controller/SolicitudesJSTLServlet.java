package mx.edu.utez.practica3e.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.practica3e.dao.CarritoProductoDao;
import mx.edu.utez.practica3e.dao.SolicitudDao;
import mx.edu.utez.practica3e.dao.SolicitudEncargadoDao;
import mx.edu.utez.practica3e.model.Carrito_Producto;
import mx.edu.utez.practica3e.model.Solicitud;
import mx.edu.utez.practica3e.model.Solicitud_Encargado;
import mx.edu.utez.practica3e.model.Usuario;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "SolicitudesJSTLServlet", value = "/darSolicitudes")
public class SolicitudesJSTLServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        // Creación de daos
        SolicitudDao sdao = new SolicitudDao();
        CarritoProductoDao carritoProductoDao = new CarritoProductoDao();

        // Obtener solicitudes pendientes
        List<Solicitud> listaSolis = sdao.getAllPendientes();

        // Crear un mapa para almacenar los productos del carrito por ID de carrito
        Map<Integer, List<Carrito_Producto>> productosPorCarrito = new HashMap<>();

        // Para cada solicitud PENDIENTE, obtener los productos del carrito asociado
        for (Solicitud solicitud : listaSolis) {
            List<Carrito_Producto> productos = carritoProductoDao.obtenerProductosPorCarrito(solicitud.getCarrito().getId_carrito());
            productosPorCarrito.put(solicitud.getCarrito().getId_carrito(), productos);
        }

        Usuario encargado = (Usuario) session.getAttribute("usuario");
        SolicitudEncargadoDao seDao = new SolicitudEncargadoDao();
        List<Solicitud_Encargado> solicitudesEncargado = seDao.obtenerSolicitudesPorEncargado(encargado.getIdUsuario());

        // Crear un mapa para almacenar los productos del carrito por ID de carrito para las solicitudes del ENCARGADO
        Map<Integer, List<Carrito_Producto>> productosPorCarritoEncargado = new HashMap<>();

        for (Solicitud_Encargado solicitudEncargado : solicitudesEncargado) {
            int idCarrito = solicitudEncargado.getSolicitud().getCarrito().getId_carrito();
            List<Carrito_Producto> productos = carritoProductoDao.obtenerProductosPorCarrito(idCarrito);
            productosPorCarritoEncargado.put(idCarrito, productos);
        }

        // Establecer las solicitudes y los productos del carrito como atributos de la sesión
        session.setAttribute("solicitudes", listaSolis); // solicitudes PENDIENTES
        session.setAttribute("solicitudesEncargado", solicitudesEncargado); // SOLICITUDES ENCARGADO
        session.setAttribute("productosPorCarrito", productosPorCarrito); // productos de solicitudes PENDIENTES
        session.setAttribute("productosPorCarritoEncargado", productosPorCarritoEncargado); // productos de solicitudes del ENCARGADO
    }
}
