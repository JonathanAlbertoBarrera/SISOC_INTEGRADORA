package mx.edu.utez.practica3e.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.practica3e.dao.UsuarioDao;
import mx.edu.utez.practica3e.model.Persona;
import mx.edu.utez.practica3e.model.Rol;
import mx.edu.utez.practica3e.model.Usuario;

import java.io.IOException;


@WebServlet(name="AdminRegistrarEncargadoServlet", value="/addEncargado")
public class AdminRegistrarEncargadoServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Obtener datos del formulario
        String nombre = req.getParameter("nombre");
        String apellidos = req.getParameter("apellidos");
        String telefono = req.getParameter("telefono");
        String sexo = req.getParameter("sexo");
        String correo = req.getParameter("correo");
        String pass1 = req.getParameter("pass1");
        boolean estatus = true; //por defecto el estatus es true
        int rolId = 3; // Se asigna el rol de encargado

        String ruta = "indexAdmin.jsp";


        // Crear objetos Persona y Usuario
        Persona p = new Persona();
        p.setNombre(nombre);
        p.setApellidos(apellidos);
        p.setTelefono(telefono);
        p.setSexo(sexo);

        Usuario u = new Usuario();
        u.setCorreo(correo);
        u.setContrasena(pass1);
        u.setEstatus(estatus);
        u.setRol(new Rol(rolId, null));

        UsuarioDao dao = new UsuarioDao();
        boolean insert = dao.insert(u, p);

        if (insert) {
            HttpSession sesion = req.getSession();
            sesion.setAttribute("mensaje2A", "SE REGISTRO EL NUEVO ENCARGADO");
            resp.sendRedirect("indexAdmin.jsp");
        } else {
            HttpSession sesion = req.getSession();
            sesion.setAttribute("mensaje2A", "El usuario no se registró correctamente. Vuelve a intentar");
        }
    }
}
