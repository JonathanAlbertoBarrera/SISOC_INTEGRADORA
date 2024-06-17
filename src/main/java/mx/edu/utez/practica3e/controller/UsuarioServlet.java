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
        //1) Obtener la información del formulario
        String nombre_usuario = req.getParameter("nombre_usuario");
        String contra = req.getParameter("contra");
        String ruta = "index.jsp";

        //2) conectarme a la base de datos y buscar al usuario segun
        // las credenciales del form
        UsuarioDao dao = new UsuarioDao();
        Usuario u = dao.getOne(nombre_usuario,contra);

        if(u.getNombre_usuario() == null){
            //No existe el usuario en la base de datos
            HttpSession sesion = req.getSession();
            sesion.setAttribute("mensaje","El usuario no existe en la BD");
            resp.sendRedirect(ruta);
        }else{
            //Si existe el usuario
            ruta="bienvenido.jsp";
            HttpSession sesion = req.getSession();
            sesion.setAttribute("usuario",u);
            resp.sendRedirect(ruta);
        }


    }
}
