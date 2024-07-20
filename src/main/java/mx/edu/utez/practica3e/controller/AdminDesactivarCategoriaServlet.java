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
            resp.sendRedirect("categorias.jsp");
            req.getSession().setAttribute("mensaje2A", "Se cambió el estatus de la categoría");
        } else {
            // No se pudo cambiar el estado, mando un error
            req.getSession().setAttribute("mensaje2A", "No se pudo cambiar el estado de la categoría");
            resp.sendRedirect("categorias.jsp");
        }
    }
}
