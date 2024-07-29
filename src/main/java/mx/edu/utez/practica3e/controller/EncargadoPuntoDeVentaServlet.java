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
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet(name="EncargadoPuntoDeVentaServlet", value="/hacerSolicitudEncargado")
public class EncargadoPuntoDeVentaServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");
        CarritoDao carritoDao = new CarritoDao();
        Carrito carrito = carritoDao.getCarritoNoConfirmado(usuario.getIdUsuario());

        if (carrito == null) {
            request.setAttribute("mensaje", "No hay carrito para hacer la solicitud.");
            request.getRequestDispatcher("carritoEncargado.jsp").forward(request, response);
            return;
        }

        CarritoProductoDao carritoProductoDao = new CarritoProductoDao();
        List<Carrito_Producto> productosEnCarrito = carritoProductoDao.obtenerProductosPorCarrito(carrito.getId_carrito());
        ProductoDao productoDao = new ProductoDao();

        boolean stockSuficiente = true;
        StringBuilder mensajeError = new StringBuilder();

        // Sumar cantidades por SKU y verificar el stock
        for (int i = 0; i < productosEnCarrito.size(); i++) {
            Carrito_Producto cp = productosEnCarrito.get(i);
            Producto producto = productoDao.getProductoBySku(cp.getProducto().getSku());
            int cantidadTotal = cp.getCantidad();

            for (int j = i + 1; j < productosEnCarrito.size(); j++) {
                Carrito_Producto cp2 = productosEnCarrito.get(j);
                if (cp2.getProducto().getSku().equals(cp.getProducto().getSku())) {
                    cantidadTotal += cp2.getCantidad();
                }
            }

            if (producto.getCantidad() < cantidadTotal) {
                stockSuficiente = false;
                mensajeError.append("El producto ")
                        .append(producto.getNombre())
                        .append(" solo tiene ")
                        .append(producto.getCantidad())
                        .append(" unidades disponibles. ");
                break;  // no hay suficiente stock
            }
        }

        if (!stockSuficiente) {
            request.setAttribute("mensaje", mensajeError.toString());
            request.getRequestDispatcher("carritoEncargado.jsp").forward(request, response);
            return;
        }

        double totalSolicitud = 0;

        // Actualizar la cantidad de productos y calcular el total de la solicitud
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
        solicitud.setEstado("Entregada");
        solicitud.setTotal(totalSolicitud);

        SolicitudDao solicitudDao = new SolicitudDao();
        boolean solicitudGuardada = solicitudDao.guardarSolicitud(solicitud);

        if (solicitudGuardada) {
            carrito.setConfirmado(true);
            carritoDao.actualizarCarrito(carrito);
            request.setAttribute("mensaje", "Venta realizada con éxito.");
        } else {
            request.setAttribute("mensaje", "Error al realizar la venta.");
        }

        request.getRequestDispatcher("carritoEncargado.jsp").forward(request, response);
    }
}
