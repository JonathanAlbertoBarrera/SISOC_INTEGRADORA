package mx.edu.utez.practica3e.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.practica3e.dao.CategoriaDao;
import mx.edu.utez.practica3e.model.Categoria;

import java.io.IOException;

@WebServlet(name="AdminModificarCategoriaServlet", value = "/modiCategoria")
public class AdminModificarCategoriaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Actualizar categoria
        try {
            String nombre = req.getParameter("nombre");
            String descripcion = req.getParameter("descripcion");
            int id_categoria = Integer.parseInt(req.getParameter("id_categoria"));

            // Crear objeto
            Categoria categoria = new Categoria();
            categoria.setNombre(nombre);
            categoria.setDescripcion(descripcion);
            categoria.setId_categoria(id_categoria);


            // Llamar al DAO para actualizar la categoria
            CategoriaDao categoriaDao = new CategoriaDao();
            boolean actualizado = categoriaDao.updateCategoria(categoria);

            if (actualizado) {
                req.getSession().setAttribute("mensaje2A", "Categoría actualizada exitosamente");
            } else {
                req.getSession().setAttribute("mensaje2A", "Error al actualizar la categoría");
            }

        } catch (NumberFormatException e) {
            req.getSession().setAttribute("mensaje2A", "Error al convertir el ID");
        } catch (Exception e) {
            req.getSession().setAttribute("mensaje2A", "Error inesperado: " + e.getMessage());
        }

        // Redireccionar de vuelta a la pagina de categorias
        resp.sendRedirect("categorias.jsp");
    }
}

