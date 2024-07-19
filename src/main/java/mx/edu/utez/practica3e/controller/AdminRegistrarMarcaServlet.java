package mx.edu.utez.practica3e.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.practica3e.dao.MarcaDao;
import mx.edu.utez.practica3e.model.Marca;

import java.io.IOException;


@WebServlet(name="AdminRegistrarMarcaServlet", value="/addMarca")
public class AdminRegistrarMarcaServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Obtener datos del formulario
        String nombre = req.getParameter("nombre");
        String descripcion = req.getParameter("descripcion");
        boolean estatus = true; //por defecto el estatus es true

        String ruta = "marcas.jsp";


        // Crear objetos Persona y Usuario
        Marca m = new Marca();
        m.setNombre(nombre);
        m.setDescripcion(descripcion);
        m.setEstatus(estatus);

        MarcaDao dao = new MarcaDao();
        boolean insert = dao.insert(m);

        if (insert) {
            HttpSession sesion = req.getSession();
            sesion.setAttribute("mensaje2A", "SE REGISTRÓ LA NUEVA MARCA");
            resp.sendRedirect("marcas.jsp");
        } else {
            HttpSession sesion = req.getSession();
            sesion.setAttribute("mensaje2A", "La marca no se registró correctamente. Vuelve a intentar");
            resp.sendRedirect("marcas.jsp");
        }
    }
}