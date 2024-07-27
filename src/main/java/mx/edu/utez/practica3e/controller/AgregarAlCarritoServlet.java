package mx.edu.utez.practica3e.controller;

import mx.edu.utez.practica3e.model.*;
import mx.edu.utez.practica3e.dao.CarritoDao;
import mx.edu.utez.practica3e.dao.CarritoProductoDao;
import mx.edu.utez.practica3e.dao.ProductoDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name="AgregarAlCarritoServlet", value="/agregarCarrito")
public class AgregarAlCarritoServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id_usuario = Integer.parseInt(request.getParameter("id_usuario"));
        String sku = request.getParameter("sku");
        int cantidad = Integer.parseInt(request.getParameter("addCant"));


        CarritoDao carritoDAO = new CarritoDao();
        CarritoProductoDao carritoProductoDAO = new CarritoProductoDao();

        // Obtener carrito no confirmado del usuario
        Carrito carrito = carritoDAO.getCarritoNoConfirmado(id_usuario);

        // Si no hay un carrito no confirmado, crear uno nuevo
        if (carrito == null) {
            Usuario usuario = new Usuario();
            usuario.setIdUsuario(id_usuario);

            carrito = new Carrito();
            carrito.setUsuario(usuario);
            carrito.setConfirmado(false);
            carritoDAO.crearCarrito(carrito);
        }

        // Agregar el producto al carrito
        ProductoDao productoDAO = new ProductoDao();
        Producto producto = productoDAO.getProductoBySku(sku);

        Carrito_Producto carritoProducto = new Carrito_Producto();
        carritoProducto.setCarrito(carrito);
        carritoProducto.setProducto(producto);
        carritoProducto.setCantidad(cantidad);
        carritoProducto.setPrecio(producto.getPrecio());
        System.out.println(carritoProducto.getPrecio());
        double totalProducto = (producto.getPrecio()) * cantidad;
        carritoProducto.setTotalProducto(totalProducto);

        carritoProductoDAO.agregarProductoAlCarrito(carritoProducto);

        // Redirigir al index.jsp
        response.sendRedirect("indexCliente.jsp");
    }
}
