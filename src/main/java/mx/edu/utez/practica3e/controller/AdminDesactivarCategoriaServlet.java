package mx.edu.utez.practica3e.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.practica3e.dao.CategoriaDao;
import mx.edu.utez.practica3e.model.Categoria;

import java.io.IOException;

@WebServlet(name="AdminDesactivarCategoriaServlet", value ="/desactivarCategoria")
public class AdminDesactivarCategoriaServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, IOException {

        int id_categoria = Integer.parseInt(req.getParameter("id_categoria"));
        boolean estatus = Boolean.parseBoolean(req.getParameter("estatus"));

        Categoria c = new Categoria();
        c.setId_categoria(id_categoria);
        c.setEstatus(!estatus); // Cambiar el estado actual

        CategoriaDao dao = new CategoriaDao();
        if(dao.desactivar(c)){
            // Si se hizo el update de estado
            req.getSession().setAttribute("mensaje2C", "Se cambió el estatus de la categoría con id "+id_categoria);
            resp.sendRedirect("categorias.jsp");
        } else {
            // No se pudo cambiar el estado, mando un error
            req.getSession().setAttribute("mensaje2C", "No se pudo cambiar el estado de la categoría con id "+id_categoria);
            resp.sendRedirect("categorias.jsp");
        }
    }
}
