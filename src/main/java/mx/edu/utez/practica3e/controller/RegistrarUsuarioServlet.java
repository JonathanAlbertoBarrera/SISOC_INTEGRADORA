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


@WebServlet(name="RegistrarUsuarioServlet", value="/sign_in")
public class RegistrarUsuarioServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Obtener datos del formulario
        String nombre = req.getParameter("nombre");
        String apellidos = req.getParameter("apellidos");
        String telefono = req.getParameter("telefono");
        String sexo = req.getParameter("sexo");
        String correo = req.getParameter("correo");
        String pass1 = req.getParameter("pass1");
        String pass2 = req.getParameter("pass2");
        boolean estatus = true; //por defecto el estatus es true
        int rolId = 2; // Se asigna el rol de Cliente por defecto

        String ruta = "registrarUsuario.jsp";

        if (pass1.equals(pass2)) {
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
            u.setRol(new Rol(rolId, null)); // Rol por defecto: Cliente

            UsuarioDao dao = new UsuarioDao();
            boolean insert = dao.insert(u, p);

            if (insert) {
                HttpSession sesion = req.getSession();
                sesion.setAttribute("mensaje2", "REGISTRADO");
                resp.sendRedirect("iniciarSesion.jsp");
            } else {
                HttpSession sesion = req.getSession();
                sesion.setAttribute("mensaje3", "El usuario no se registró correctamente");
                resp.sendRedirect(ruta);
            }
        } else {
            HttpSession sesion = req.getSession();
            sesion.setAttribute("mensaje2", "Las contraseñas no coinciden");
            resp.sendRedirect(ruta);
        }
    }
}