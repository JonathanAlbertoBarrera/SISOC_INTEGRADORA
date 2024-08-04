package mx.edu.utez.practica3e.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.practica3e.dao.ProductoDao;

import java.io.IOException;

@WebServlet(name="ModiCantidadProductoServlet", value="/modiCantidadProducto")
public class ModiCantidadProductoServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, IOException {
        try {
            // Obtener los parámetros del formulario
            String sku = request.getParameter("sku");
            int cantidad = Integer.parseInt(request.getParameter("cantidad"));

            // Actualizar la cantidad en la base de datos
            ProductoDao productoDao = new ProductoDao();
            boolean actualizado = productoDao.updateCantidad(sku, cantidad);

            // Redirigir o mostrar un mensaje de éxito
            if (actualizado) {
                request.getSession().setAttribute("mensaje2", "El producto "+sku+ " aumento su stock "+cantidad+" unidades");
                response.sendRedirect("comprasAdmin.jsp");
            } else {
                request.getSession().setAttribute("mensaje2", "El producto "+sku+ " no pudo aumentar su stock correctamente");
                response.sendRedirect("comprasAdmin.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}