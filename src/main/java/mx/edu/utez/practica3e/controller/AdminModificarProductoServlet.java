package mx.edu.utez.practica3e.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import mx.edu.utez.practica3e.model.Categoria;
import mx.edu.utez.practica3e.model.Marca;
import mx.edu.utez.practica3e.model.Producto;
import mx.edu.utez.practica3e.dao.ProductoDao;

@WebServlet(name="AdminModificarProductoServlet", value="/modiProducto")
@MultipartConfig
public class AdminModificarProductoServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Obtener parámetros del formulario
        String sku = request.getParameter("sku");
        String nombre = getPartValue(request.getPart("nombre2"));
        String descripcion = getPartValue(request.getPart("descripcion2"));
        int id_categoria = Integer.parseInt(getPartValue(request.getPart("categorias2")));
        int id_marca = Integer.parseInt(getPartValue(request.getPart("marcas2")));
        double precio = Double.parseDouble(getPartValue(request.getPart("precio2")));
        int cantidad = Integer.parseInt(getPartValue(request.getPart("cantidad2")));


        // Obtener la imagen
        byte[] imagen = null;
        try {
            Part filePart = request.getPart("imagen_producto2");
            if (filePart != null && filePart.getSize() > 0) {
                imagen = getBytesFromPart(filePart);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Obtener el producto existente para mantener la imagen si no se proporciona una nueva
        ProductoDao productoDao = new ProductoDao();
        Producto productoExistente = productoDao.getProductoBySku(sku);

        // Crear objeto Marca y Categoria
        Marca marca = new Marca();
        marca.setId_marca(id_marca);

        Categoria categoria = new Categoria();
        categoria.setId_categoria(id_categoria);

        // Crear objeto Producto y establecer sus atributos
        Producto producto = new Producto();
        producto.setSku(sku);
        producto.setNombre(nombre);
        producto.setDescripcion(descripcion);
        producto.setCategoria(categoria);
        producto.setMarca(marca);
        producto.setPrecio(precio);
        producto.setCantidad(cantidad);


        // Si no se proporcionó una nueva imagen, mantener la imagen existente
        if (imagen == null) {
            producto.setImagen(productoExistente.getImagen());
        } else {//si se dio una nueva imagen y se hace el setImagen
            producto.setImagen(imagen);
        }

        // Llamar al DAO para actualizar el producto
        boolean isUpdated = productoDao.update(producto);

        if (isUpdated) {
            // Redirigir a la página productpsAdmin con un mensaje de éxito
            request.getSession().setAttribute("mensaje2", "El producto: "+nombre+" se actualizó correctamente.");
            response.sendRedirect("productosAdmin.jsp");
        } else {
            // Manejar el error mostrando un mensaje de error en la misma página
            request.getSession().setAttribute("mensaje2", "Error al actualizar el producto: " + sku);
            response.sendRedirect("productosAdmin.jsp");
        }
    }

    private String getPartValue(Part part) throws IOException {
        if (part == null) {
            return null;
        }
        InputStream inputStream = part.getInputStream();
        byte[] bytes = new byte[inputStream.available()];
        inputStream.read(bytes);
        return new String(bytes);
    }

    private byte[] getBytesFromPart(Part part) throws IOException {
        try (InputStream inputStream = part.getInputStream();
             ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream()) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                byteArrayOutputStream.write(buffer, 0, bytesRead);
            }
            return byteArrayOutputStream.toByteArray();
        }
    }
}
