package mx.edu.utez.practica3e.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.practica3e.dao.SolicitudDao;

import java.io.IOException;

@WebServlet(name = "EncargadoCambiarEstadoSoliServlet", value = "/cambiarEstadoSoli")
public class EncargadoCambiarEstadoSoliServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int idSolicitud = Integer.parseInt(req.getParameter("id_solicitud"));
        String estadoActual = req.getParameter("estado");

        String nuevoEstado;
        if (estadoActual.equals("En Proceso")) {
            nuevoEstado = "Lista";
        } else if (estadoActual.equals("Lista")) {
            nuevoEstado = "Entregada";
        } else {
            req.getSession().setAttribute("mensaje", "El estado no puede ser cambiado.");
            resp.sendRedirect("controlSolicitudes.jsp");
            return;
        }

        SolicitudDao solicitudDao = new SolicitudDao();
        boolean exito = solicitudDao.cambiarEstadoSolicitud(idSolicitud, nuevoEstado);

        if (exito) {
            req.getSession().setAttribute("mensaje", "El estado de la solicitud " + idSolicitud + " se ha cambiado a " + nuevoEstado + ".");
        } else {
            req.getSession().setAttribute("mensaje", "Hubo un problema al cambiar el estado de la solicitud.");
        }
        resp.sendRedirect("controlSolicitudes.jsp");
    }
}

