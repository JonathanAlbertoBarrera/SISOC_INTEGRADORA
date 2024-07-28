package mx.edu.utez.practica3e.controller;

import mx.edu.utez.practica3e.dao.SolicitudEncargadoDao;
import mx.edu.utez.practica3e.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name="EncargadoTomarSolicitudServlet", value="/tomarSolicitud")
public class EncargadoTomarSolicitudServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id_solicitud = Integer.parseInt(request.getParameter("id_solicitud"));
        Usuario encargado = (Usuario) request.getSession().getAttribute("usuario");
        HttpSession session = request.getSession();

        Solicitud_Encargado solicitudEncargado = new Solicitud_Encargado();
        SolicitudEncargadoDao seDao = new SolicitudEncargadoDao();

        Solicitud solicitud = new Solicitud();
        solicitud.setId_solicitud(id_solicitud);
        solicitudEncargado.setSolicitud(solicitud);
        solicitudEncargado.setEncargado(encargado);

        boolean exito = seDao.tomarSolicitud(solicitudEncargado);
        if (exito) {
            session.setAttribute("mensaje", "Solicitud tomada con éxito.");
        } else {
            session.setAttribute("mensaje", "Error al tomar la solicitud. Inténtelo de nuevo.");
        }

        // Redirigir al indexEncargado
        response.sendRedirect("indexEncargado.jsp");
    }
}
