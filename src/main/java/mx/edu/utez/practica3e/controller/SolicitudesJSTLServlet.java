package mx.edu.utez.practica3e.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.practica3e.dao.CategoriaDao;
import mx.edu.utez.practica3e.dao.MarcaDao;
import mx.edu.utez.practica3e.dao.ProductoDao;
import mx.edu.utez.practica3e.dao.SolicitudDao;
import mx.edu.utez.practica3e.model.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name="SolicitudesJSTLServlet",value = "/darSolicitudes")
public class SolicitudesJSTLServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        //Creacion de listas
        List<Solicitud> listaSolis = new ArrayList<>();

        //Creacion de daos
        SolicitudDao sdao = new SolicitudDao();

        //se rellenan las listas con los correspondientes daos
        listaSolis = sdao.getAllPendientes();//solicitudes pendientes.


        session.setAttribute("solicitudes",listaSolis);


    }
}