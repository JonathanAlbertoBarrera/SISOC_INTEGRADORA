package mx.edu.utez.practica3e.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.practica3e.dao.ProductoDao;
import mx.edu.utez.practica3e.model.Producto;

import java.io.IOException;

@WebServlet(name="AdminDesactivarProductoServlet", value ="/desactivarProducto")
public class AdminDesactivarProductoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, IOException {

        String sku = req.getParameter("sku");
        boolean estatus = Boolean.parseBoolean(req.getParameter("estatus"));

        Producto p = new Producto();
        p.setSku(sku);
        p.setEstatus(!estatus);// Cambiar el estado actual

        ProductoDao dao = new ProductoDao();
        if(dao.desactivar(p)){
            // Si se hizo el update de estado
            resp.sendRedirect("productosAdmin.jsp");
            req.getSession().setAttribute("mensaje2", "Se cambió el estatus del producto "+sku);
        } else {
            // No se pudo cambiar el estado, mando un error
            req.getSession().setAttribute("mensaje2", "No se pudo cambiar el estado del producto "+sku);
            resp.sendRedirect("productosAdmin.jsp");
        }
    }
}