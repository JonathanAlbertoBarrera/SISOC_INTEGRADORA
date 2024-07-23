package mx.edu.utez.practica3e.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.UUID;
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

@WebServlet(name="AdminRegistrarProductoServlet", value="/addProducto")
@MultipartConfig
public class AdminRegistrarProductoServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Obtener parámetros del formulario
        String sku = getPartValue(request.getPart("sku"));
        String nombre = getPartValue(request.getPart("nombre"));
        String descripcion = getPartValue(request.getPart("descripcion"));
        int id_categoria = Integer.parseInt(getPartValue(request.getPart("categorias")));
        int id_marca = Integer.parseInt(getPartValue(request.getPart("marcas")));
        double precio = Double.parseDouble(getPartValue(request.getPart("precio")));
        int cantidad = Integer.parseInt(getPartValue(request.getPart("cantidad")));
        boolean estatus = true;

        String UPLOAD_DIRECTORY = request.getServletContext().getRealPath("/") + "img";
        String filePath = "";
        try {
            Part filePart = request.getPart("imagen_producto");
            String fileName = getSubmittedFileName(filePart);
                // Generar nombre unico con UUID
            String uniqueFileName = UUID.randomUUID().toString() + "_" + fileName;
            filePath = UPLOAD_DIRECTORY + File.separator + uniqueFileName;
            InputStream fileContent = filePart.getInputStream();
            //una ves termine este proceso el archivo ya esta en assets
            Files.copy(fileContent, Paths.get(filePath));
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Crear objetos Marca y Categoria
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
        producto.setUrlImagen(filePath);
        producto.setPrecio(precio);
        producto.setCantidad(cantidad);
        producto.setEstatus(estatus);

        // Llamar al DAO para guardar el producto
        ProductoDao productoDao = new ProductoDao();
        boolean isSaved = productoDao.insert(producto, categoria, marca);

        if (isSaved) {
            // Redirigir a la página de administración con un mensaje de éxito
            request.getSession().setAttribute("mensaje2", "El producto: "+nombre+" ,se registró correctamente.");
            response.sendRedirect("productosAdmin.jsp");
        } else {
            // Manejar el error mostrando un mensaje de error en la misma página
            request.getSession().setAttribute("mensaje2", "Error al guardar el producto: " + sku + " - " + filePath + " - " + nombre + " - " + precio + " - " + cantidad + " - " + id_marca);
            response.sendRedirect("productosAdmin.jsp");
        }
    }

    private String getSubmittedFileName(Part part) {
        String header = part.getHeader("content-disposition");
        String[] elements = header.split(";");
        for (String element : elements) {
            if (element.trim().startsWith("filename")) {
                return element.substring(
                        element.indexOf("=") + 1).trim().replace("\"", "");
            }
        }
        return "";
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
}
