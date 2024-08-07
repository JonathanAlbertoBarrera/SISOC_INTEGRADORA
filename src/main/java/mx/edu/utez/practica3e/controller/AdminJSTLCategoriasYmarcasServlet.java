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
import mx.edu.utez.practica3e.model.Categoria;
import mx.edu.utez.practica3e.model.Marca;
import mx.edu.utez.practica3e.model.Producto;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name="AdminJSTLCategoriasYmarcasServlet",value = "/mandarCategoriasYmarcas")
public class AdminJSTLCategoriasYmarcasServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        //Creacion de listas
        List<Categoria> lista = new ArrayList<>();
        List<Marca> lista2 = new ArrayList<>();
        List<Producto> lista3=new ArrayList<>();

        //Creacion de daos
        CategoriaDao dao = new CategoriaDao();
        MarcaDao dao2=new MarcaDao();
        ProductoDao dao3=new ProductoDao();

        //se rellenan las listas con los correspondientes daos
        lista = dao.getAll();//las categorias
        lista2=dao2.getAll();//las marcas
        lista3=dao3.getAllActivos();

        session.setAttribute("categorias",lista);
        session.setAttribute("marcas",lista2);
        session.setAttribute("productos",lista3);



    }
}