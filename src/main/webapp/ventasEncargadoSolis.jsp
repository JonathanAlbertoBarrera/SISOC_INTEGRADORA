<%@ page import="mx.edu.utez.practica3e.model.Carrito_Producto" %>
<%@ page import="java.util.List" %>
<%@ page import="mx.edu.utez.practica3e.dao.CarritoProductoDao" %>
<%@ page import="mx.edu.utez.practica3e.dao.SolicitudEncargadoDao" %>
<%@ page import="mx.edu.utez.practica3e.model.Solicitud_Encargado" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="mx.edu.utez.practica3e.dao.ProductoDao" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>Sistema de órdenes de cafetería</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel="stylesheet" href="css/bootstrap.css">
    <style>
        html, body {
            height: 100%;
            margin: 0;
        }
        .content {
            min-height: calc(100vh - 56px); /* Ajusta la altura del contenido para dejar espacio para el footer */
        }

        .barra {
            background-color:#F4AB2C;
        }
        main {
            text-align: center;
        }
        body {
            font-family: 'Montserrat', sans-serif;
        }
        .hidden {
            display: none;
        }
        .botonesApp{
            background-color: #F4AB2C;
            border-color:#F4AB2C;
        }
        .row img{
            width: 60%;
        }
        .row #icAddCar{
            width: 40%;
        }
    </style>
</head>
<body>
<!-- BARRA NAVEGACION -->
<header>
    <nav class="navbar navbar-expand-lg barra">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Cafetería</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                <div class="navbar-nav mx-auto">
                    <a class="nav-link active" aria-current="page"  href="indexEncargado.jsp">Inicio</a>
                    <a class="nav-link" href="controlSolicitudes.jsp">
                        <img src="img/orden.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Mis Solicitudes
                    </a>
                    <a class="nav-link" href="productosEncargado.jsp">
                        <img src="img/iconoProductos.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Productos
                    </a>
                    <a class="nav-link" href="carritoEncargado.jsp">
                        <img src="img/carritoLogo.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Carrito de compra
                    </a>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <img src="img/iconoVentas.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Mis ventas
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="ventasEncargado.jsp" >Punto de venta</a></li>
                            <li><a class="dropdown-item" href="ventasEncargadoSolis.jsp">Solicitudes</a></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <img src="img/login.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> ${sessionScope.nombre_usuario != null ? sessionScope.nombre_usuario : 'Cuenta'}
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout" >Cerrar Sesión</a></li>
                            <li><a class="dropdown-item" href="solicitudRecuperacion.jsp">Cambiar contraseña</a></li>
                        </ul>
                    </li>
                </div>
            </div>
        </div>
    </nav>
</header>

<main class="content">
    <div class="container mt-2">
        <h2 id="titSeccion">Mis ventas por solicitudes tomadas</h2>
    </div>
    <!-- TABLA TODAS LAS VENTAS (ENTREGADAS) -->
    <div class="table-responsive" id="tablaCategorias">

        <%
            HttpSession sesion1 = request.getSession();
            String mensaje2A = (String) sesion1.getAttribute("mensaje2A");

            if(mensaje2A != null){ %>
        <p class="text-danger"><%=mensaje2A%></p>
        <% } %>

        <!--TABLA DE VENTAS MEDIANTE SOLICITUD ENTREGADAS -->
        <table id="example3" class="table table-striped table-hover" style="width: 100%">
            <thead>
            <tr>
                <th>ID Solicitud</th>
                <th>Cliente</th>
                <th>Fecha</th>
                <th>Total</th>
                <th>Ver detalles</th>
            </tr>
            </thead>
            <tbody>
            <%
                SolicitudEncargadoDao dao = new SolicitudEncargadoDao();
                Integer idUsuario = (Integer) session.getAttribute("id_usuario");
                ArrayList<Solicitud_Encargado> lista = (ArrayList<Solicitud_Encargado>) dao.obtenerVentaPorSolicitudEncargado(idUsuario);
                for(Solicitud_Encargado s : lista) {
            %>
            <tr>
                <td><%= s.getSolicitud().getId_solicitud() %></td>
                <td><%= s.getSolicitud().getUsuario().getPersona().getNombre()%> <%= s.getSolicitud().getUsuario().getPersona().getApellidos()%></td>
                <td><%= s.getSolicitud().getFecha()%></td>
                <td><%= s.getSolicitud().getTotal()%></td>
                <!-- td detalles-->
                <td>
                    <button type="button" class="btn botonesApp" data-bs-toggle="modal" data-bs-target="#modalProductos2-<%= s.getSolicitud().getId_solicitud() %>">
                        Ver mas detalles (productos)
                    </button>
                    <div class="modal fade" id="modalProductos2-<%= s.getSolicitud().getId_solicitud() %>" tabindex="-1" aria-labelledby="exampleModalLabel2-<%= s.getSolicitud().getId_solicitud() %>" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="desacModalLabel2-<%= s.getSolicitud().getId_solicitud() %>">Detalles</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group mb-3">
                                        <!-- Aqui se obtienen los productos de carrito_producto mediante el id_carrito-->
                                        <%
                                            CarritoProductoDao carritoProductoDao = new CarritoProductoDao();
                                            List<Carrito_Producto> listaProductos = carritoProductoDao.obtenerProductosPorCarrito(s.getSolicitud().getCarrito().getId_carrito());
                                            ProductoDao proDao = new ProductoDao();
                                        %>
                                        <h3>Total de la solicitud: <%= s.getSolicitud().getTotal() %></h3>
                                        <div class="row">
                                            <% for (Carrito_Producto cp : listaProductos) { %>
                                            <div class="col-6 mb-3">
                                                <div class="card h-100">
                                                    <img src="${pageContext.request.contextPath}/image?sku=<%= cp.getProducto().getSku() %>" class="card-img-top img-fluid" alt="<%= cp.getProducto().getSku() %>">
                                                    <div class="card-body p-2">
                                                        <h5 class="card-title" style="font-size: 1rem;"><%= proDao.getProductoBySku(cp.getProducto().getSku()).getNombre() %></h5>
                                                        <p class="card-text" style="font-size: 0.875rem;">Cantidad: <%= cp.getCantidad() %></p>
                                                        <p class="card-text" style="font-size: 0.875rem;">Precio: <%= cp.getPrecio() %></p>
                                                        <p class="card-text" style="font-size: 0.875rem;">Total: <%= cp.getTotalProducto() %></p>
                                                    </div>
                                                </div>
                                            </div>
                                            <% } %>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">OK</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>

</main>

<footer class="bg-body-tertiary text-black text-center py-3 barra">
    <div class="container">
        <p>&copy; 2024 Mi Cafetería. Todos los derechos reservados.</p>
        <p>Contáctanos: info@micafeteria.com</p>
    </div>
</footer>

<script src="${pageContext.request.contextPath}/JS/bootstrap.js"></script>
<script src="${pageContext.request.contextPath}/JS/jquery-3.7.0.js"></script>
<script src="${pageContext.request.contextPath}/JS/datatables.js"></script>
<script src="${pageContext.request.contextPath}/JS/dataTables.bootstrap5.js"></script>
<script src="${pageContext.request.contextPath}/JS/es-MX.json"></script>
<script>
    const table3 = document.getElementById('example3');
    new DataTable(table3, {
        language: {
            url: '${pageContext.request.contextPath}/JS/es-MX.json'
        }
    });
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.11.6/umd/popper.min.js"></script>
<script src="JS/bootstrap.js"></script>
<%
    sesion1.removeAttribute("mensaje2A");
%>
</body>
</html>

