package mx.edu.utez.practica3e.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.practica3e.dao.UsuarioDao;
import mx.edu.utez.practica3e.model.Usuario;

import java.io.IOException;

@WebServlet(name="UsuarioServlet", value="/login")
public class UsuarioServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1) Obtener la información del formulario
        String correo = req.getParameter("correo");
        String contrasena = req.getParameter("contrasena");
        String ruta = "iniciarSesion.jsp";

        // 2) Conectarme a la base de datos y buscar al usuario según las credenciales del form
        UsuarioDao dao = new UsuarioDao();
        Usuario u = dao.getOne(correo, contrasena);

        if (u == null || u.getCorreo() == null) {
            // No existe el usuario en la base de datos
            HttpSession sesion = req.getSession();
            sesion.setAttribute("mensaje", "El usuario no existe en la BD o la contraseña es incorrecta. Vuelve a intentar");
            req.setAttribute("correo", correo); // Guardar el correo ingresado
            req.setAttribute("contrasena", contrasena); // Guardar la contraseña ingresada
            req.getRequestDispatcher(ruta).forward(req, resp);
        } else if (!u.isEstatus()) {
            // Usuario inactivo
            HttpSession sesion = req.getSession();
            sesion.setAttribute("mensaje", "El usuario/cuenta está inactiva. No puedes iniciar sesión. En caso de cualquier aclaración puedes contactarnos " +
                    "al correo: " + "sistemasdeordenesdecafeteria@gmail.com");
            req.setAttribute("correo", correo); // Guardar el correo ingresado
            req.setAttribute("contrasena", contrasena); // Guardar la contraseña ingresada
            req.getRequestDispatcher(ruta).forward(req, resp);
        } else {
            // Si existe el usuario y está activo

            HttpSession sesion = req.getSession();
            sesion.setAttribute("usuario", u);
            sesion.setAttribute("id_usuario", u.getIdUsuario());
            sesion.setAttribute("nombre_usuario", u.getPersona().getNombre());
            sesion.setAttribute("apellido_usuario", u.getPersona().getApellidos());
            sesion.setAttribute("tipoRol", u.getRol().getTipoRol());
            int id_rol = u.getRol().getId();
            switch (id_rol) {
                case 1: // es administrador
                    ruta = "indexAdmin.jsp";
                    break;
                case 2: // es cliente registrado
                    ruta = "indexCliente.jsp";
                    break;
                case 3: // es Encargado
                    ruta = "indexEncargado.jsp";
                    break;
                default:
                    ruta = "iniciarSesion.jsp";
                    break;
            }
            resp.sendRedirect(ruta);
        }
    }
}


