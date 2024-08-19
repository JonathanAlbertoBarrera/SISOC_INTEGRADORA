package mx.edu.utez.practica3e.utils;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {
        "/indexAdmin.jsp",
        "/marcas.jsp",
        "/categorias.jsp",
        "/productosAdmin.jsp",
        "/comprasAdmin.jsp",
        "/ventasAdmin.jsp",
        "/AdminEliminarUsuarioServlet",
        "/AdminDesactivarMarcaServlet",
        "/AdminDesactivarCategoriaServlet",
        "/AdminDesactivarProductoServlet",
        "/AdminModificarEncargadoServlet",
        "/AdminModificarMarcaServlet",
        "/AdminModificarCategoriaServlet",
        "/AdminModificarProductoServlet",
        "/AdminRegistrarEncargadoServlet",
        "/AdminRegistrarMarcaServlet",
        "/AdminRegistrarCategoriaServlet",
        "/AdminRegistrarProductoServlet",
        "/PdfUsuariosInactivosServlet"

}) //Direcciones que va a proteger este filtro
public class FiltroAdminSesion implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        // Obtener la sesión, si no existe devolverá null
        HttpSession session = httpRequest.getSession(false);

        // Variable para verificar si el usuario es admin
        boolean isAdmin = false;

        // Verificar si la sesión no es nula y si el atributo tipoRol está presente y es igual a "Administrador"
        if (session != null && "Administrador".equals(session.getAttribute("tipoRol"))) {
            isAdmin = true;
        }

        // Si es admin, permitir el acceso
        if (isAdmin) {
            // Prevenir almacenamiento en caché
            httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
            httpResponse.setHeader("Pragma", "no-cache"); // HTTP 1.0
            httpResponse.setDateHeader("Expires", 0); // Proxies
            chain.doFilter(request, response);
        } else {
            // Si no es admin o no hay sesión, redirigir a la página de acceso denegado
            httpResponse.sendRedirect("accesoDenegado.jsp");
        }
    }
}
