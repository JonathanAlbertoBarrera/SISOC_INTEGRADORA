package mx.edu.utez.practica3e.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.practica3e.dao.MarcaDao;
import mx.edu.utez.practica3e.model.Marca;

import java.io.IOException;

@WebServlet(name="AdminModificarMarcaServlet", value = "/modiMarca")
public class AdminModificarMarcaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Actualizar marca
        try {
            String nombre = req.getParameter("nombre");
            String descripcion = req.getParameter("descripcion");
            int id_marca = Integer.parseInt(req.getParameter("id_marca"));

            // Crear objetos
            Marca marca = new Marca();
            marca.setNombre(nombre);
            marca.setDescripcion(descripcion);
            marca.setId_marca(id_marca);


            // Llamar al DAO para actualizar la marca
            MarcaDao marcaDao = new MarcaDao();
            boolean actualizado = marcaDao.updateMarca(marca);

            if (actualizado) {
                req.getSession().setAttribute("mensaje2A", "Marca actualizada exitosamente");
            } else {
                req.getSession().setAttribute("mensaje2A", "Error al actualizar la marca");
            }

        } catch (NumberFormatException e) {
            req.getSession().setAttribute("mensaje2A", "Error al convertir el ID del usuario");
        } catch (Exception e) {
            req.getSession().setAttribute("mensaje2A", "Error inesperado: " + e.getMessage());
        }

        // Redireccionar de vuelta a la pagina de marcas
        resp.sendRedirect("marcas.jsp");
    }
}
