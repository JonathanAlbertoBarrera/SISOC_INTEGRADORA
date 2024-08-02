package mx.edu.utez.practica3e.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.practica3e.dao.MarcaDao;
import mx.edu.utez.practica3e.model.Marca;

import java.io.IOException;

@WebServlet(name="AdminDesactivarMarcaServlet", value ="/desactivarMarca")
public class AdminDesactivarMarcaServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, IOException {

        int id_marca = Integer.parseInt(req.getParameter("id_marca"));
        boolean estatus = Boolean.parseBoolean(req.getParameter("estatus"));

        Marca m = new Marca();
        m.setId_marca(id_marca);
        m.setEstatus(!estatus); // Cambiar el estado actual

        MarcaDao dao = new MarcaDao();
        if(dao.desactivar(m)){
            // Si se hizo el update de estado
            resp.sendRedirect("marcas.jsp");
            req.getSession().setAttribute("mensaje2A", "Se cambió el estatus de la marca con id "+id_marca);
        } else {
            // No se pudo cambiar el estado, mando un error
            req.getSession().setAttribute("mensaje2A", "No se pudo cambiar el estado de la marca con id "+id_marca);
            resp.sendRedirect("marcas.jsp");
        }
    }
}