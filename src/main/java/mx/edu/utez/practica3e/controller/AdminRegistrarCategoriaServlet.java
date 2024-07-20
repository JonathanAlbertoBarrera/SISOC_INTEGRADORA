package mx.edu.utez.practica3e.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.practica3e.dao.CategoriaDao;
import mx.edu.utez.practica3e.model.Categoria;

import java.io.IOException;


@WebServlet(name="AdminRegistrarCategoriaServlet", value="/addCategoria")
public class AdminRegistrarCategoriaServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Obtener datos del formulario
        String nombre = req.getParameter("nombre");
        String descripcion = req.getParameter("descripcion");
        boolean estatus = true; //por defecto el estatus es true

        String ruta = "categorias.jsp";


        // Crear objetos de Categoria
        Categoria c = new Categoria();
        c.setNombre(nombre);
        c.setDescripcion(descripcion);
        c.setEstatus(estatus);

        CategoriaDao dao = new CategoriaDao();
        boolean insert = dao.insert(c);

        if (insert) {
            HttpSession sesion = req.getSession();
            sesion.setAttribute("mensaje2A", "SE REGISTRÓ LA NUEVA CATEGORÍA");
            resp.sendRedirect("categorias.jsp");
        } else {
            HttpSession sesion = req.getSession();
            sesion.setAttribute("mensaje2A", "La categoría no se registró correctamente. Vuelve a intentar");
            resp.sendRedirect("categorias.jsp");
        }
    }
}