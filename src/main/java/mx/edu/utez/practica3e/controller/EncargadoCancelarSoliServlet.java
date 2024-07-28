package mx.edu.utez.practica3e.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.practica3e.dao.SolicitudDao;

import java.io.IOException;

@WebServlet(name = "EncargadoCancelarSoliServlet", value = "/cancelarSoli")
public class EncargadoCancelarSoliServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int idSolicitud = Integer.parseInt(req.getParameter("id_solicitud"));

        SolicitudDao solicitudDao = new SolicitudDao();
        boolean exito = solicitudDao.cancelarSolicitud(idSolicitud);

        if (exito) {
            req.getSession().setAttribute("mensaje", "La solicitud " + idSolicitud + " se ha cancelado exitosamente.");
        } else {
            req.getSession().setAttribute("mensaje", "Hubo un problema al cancelar la solicitud.");
        }
        resp.sendRedirect("controlSolicitudes.jsp");
    }
}

