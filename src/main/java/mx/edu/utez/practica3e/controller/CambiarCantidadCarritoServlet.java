package mx.edu.utez.practica3e.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.practica3e.dao.CarritoProductoDao;

import java.io.IOException;

@WebServlet(name = "CambiarCantidadCarritoServlet", value = "/cambiarCantidadCarrito")
public class CambiarCantidadCarritoServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int idCarritoProducto = Integer.parseInt(req.getParameter("id_carrito_producto"));
            int cantidad = Integer.parseInt(req.getParameter("cantidad2"));

            CarritoProductoDao dao = new CarritoProductoDao();
            if (dao.actualizarCantidadYTotal(idCarritoProducto, cantidad)) {
                // Redirigir a la página del carrito si se actualizó correctamente
                req.getSession().setAttribute("mensaje", "Cantidad y total actualizados exitosamente.");
                resp.sendRedirect("carrito.jsp");
            } else {
                // Redirigir con un mensaje de error si no se pudo actualizar
                req.getSession().setAttribute("mensaje", "No se pudo actualizar la cantidad.");
                resp.sendRedirect("carrito.jsp");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            req.getSession().setAttribute("mensaje", "Datos inválidos para la cantidad.");
            resp.sendRedirect("carrito.jsp");
        }
    }
}
