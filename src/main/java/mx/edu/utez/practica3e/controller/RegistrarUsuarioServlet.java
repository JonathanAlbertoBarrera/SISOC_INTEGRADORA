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


@WebServlet(name="RegistrarUsuarioServlet", value="/sign_in")
public class RegistrarUsuarioServlet extends HttpServlet {

    //1) Primero configurar la clase para que sea servlet
    //2) Manejar el método doPost para obtener la información del formulario de registro de persona
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String correo = req.getParameter("correo");
        String pass1 = req.getParameter("pass1");
        String pass2 = req.getParameter("pass2");
        boolean estatus = true;
        String ruta = "iniciarSesion.jsp";
        if (pass1.equals(pass2)) {
            pass1 = pass2;
            UsuarioDao dao = new UsuarioDao();
            Usuario u = new Usuario();
            {
                u.setCorreo(correo);
                u.setContrasena(pass1);
            };
            boolean insert = dao.insert(u);
            //4) una vez insertada la persona redirigir el usuario hacia el index.jsp
            if (insert) {
                HttpSession sesion = req.getSession();
                resp.sendRedirect(ruta);
                sesion.setAttribute("mensaje2","REGISTRADO");
            }else{
                HttpSession sesion = req.getSession();
                sesion.setAttribute("mensaje3","El usuario no se registro correctamente");
            }
        }else{
            HttpSession sesion = req.getSession();
            sesion.setAttribute("mensaje2","Las contraseñas no coinciden");
            resp.sendRedirect("registrarUsuario.jsp");
        }
    }





}
