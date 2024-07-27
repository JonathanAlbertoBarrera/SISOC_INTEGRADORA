package mx.edu.utez.practica3e.controller;

import mx.edu.utez.practica3e.dao.CarritoProductoDao;
import mx.edu.utez.practica3e.dao.ProductoDao;
import mx.edu.utez.practica3e.dao.SolicitudDao;
import mx.edu.utez.practica3e.model.*;
import mx.edu.utez.practica3e.dao.CarritoDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet(name="AgregarSolicitudServlet", value="/hacerSolicitud")
public class AgregarSolicitudServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");
        CarritoDao carritoDao=new CarritoDao();
        Carrito carrito = carritoDao.getCarritoNoConfirmado(usuario.getIdUsuario());

        if (carrito == null) {
            request.setAttribute("mensaje", "No hay carrito sin confirmar para hacer la solicitud.");
            request.getRequestDispatcher("carrito.jsp").forward(request, response);
            return;
        }

        CarritoProductoDao carritoProductoDao=new CarritoProductoDao();
        List<Carrito_Producto> productosEnCarrito = carritoProductoDao.obtenerProductosPorCarrito(carrito.getId_carrito());
        boolean stockSuficiente = true;
        String mensajeError = "";
        ProductoDao productoDao=new ProductoDao();

        for (Carrito_Producto cp : productosEnCarrito) {
            Producto producto = productoDao.getProductoBySku(cp.getProducto().getSku());
            if (producto.getCantidad() < cp.getCantidad()) {
                stockSuficiente = false;
                mensajeError += "El producto " + producto.getNombre() + " solo tiene " + producto.getCantidad() + " unidades disponibles. ";
            }
        }

        if (!stockSuficiente) {
            request.setAttribute("mensaje", mensajeError);
            request.getRequestDispatcher("carrito.jsp").forward(request, response);
            return;
        }

        double totalSolicitud = 0;
        for (Carrito_Producto cp : productosEnCarrito) {
            Producto producto = productoDao.getProductoBySku(cp.getProducto().getSku());
            totalSolicitud += cp.getTotalProducto();
            producto.setCantidad(producto.getCantidad() - cp.getCantidad());
            productoDao.updateCantidadProducto(producto);
        }

        Solicitud solicitud = new Solicitud();
        solicitud.setCarrito(carrito);
        solicitud.setUsuario(usuario);
        solicitud.setFecha(new Date(System.currentTimeMillis()));
        solicitud.setEstado("Pendiente");
        solicitud.setTotal(totalSolicitud);

        SolicitudDao solicitudDao=new SolicitudDao();
        boolean solicitudGuardada = solicitudDao.guardarSolicitud(solicitud);

        if (solicitudGuardada) {
            carrito.setConfirmado(true);
            carritoDao.actualizarCarrito(carrito);
            request.setAttribute("mensaje", "Solicitud realizada con éxito.");
        } else {
            request.setAttribute("mensaje", "Error al confirmar la solicitud.");
        }

        request.getRequestDispatcher("carrito.jsp").forward(request, response);
    }

}
