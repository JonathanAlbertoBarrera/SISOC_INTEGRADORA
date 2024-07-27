package mx.edu.utez.practica3e.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.practica3e.dao.CarritoProductoDao;

import java.io.IOException;

@WebServlet(name = "BorrarDelCarritoServlet", value = "/borrarDelCarrito")
public class BorrarDelCarritoServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int idCarritoProducto = Integer.parseInt(req.getParameter("id_carrito_producto"));

        CarritoProductoDao dao = new CarritoProductoDao();
        if (dao.eliminarPorId(idCarritoProducto)) {
            // Redirigir a la página del carrito si se eliminó correctamente
            req.getSession().setAttribute("mensaje", "Producto eliminado del carrito exitosamente.");
            resp.sendRedirect("carrito.jsp");
        } else {
            // Redirigir con un mensaje de error si no se pudo eliminar
            req.getSession().setAttribute("mensaje", "No se pudo eliminar el producto del carrito.");
            resp.sendRedirect("carrito.jsp");
        }
    }
}
