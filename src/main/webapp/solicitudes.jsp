<%@ page import="mx.edu.utez.practica3e.dao.SolicitudDao" %>
<%@ page import="mx.edu.utez.practica3e.model.Solicitud" %>
<%@ page import="java.util.List" %>
<%@ page import="mx.edu.utez.practica3e.model.Carrito_Producto" %>
<%@ page import="mx.edu.utez.practica3e.dao.CarritoProductoDao" %>
<%@ page import="mx.edu.utez.practica3e.model.Producto" %>
<%@ page import="mx.edu.utez.practica3e.dao.ProductoDao" %>
<%@ page import="mx.edu.utez.practica3e.dao.CarritoDao" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        .botonesApp {
            background-color: #F4AB2C;
            border-color:#F4AB2C;
        }
        .imgProductos {
            width: 60%;
        }
        .row #icAddCar {
            width: 40%;
        }

        #tablaTodasSolis{
            display:none;
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
                    <a class="nav-link active" aria-current="page" href="indexCliente.jsp">Inicio</a>
                    <a class="nav-link" href="carrito.jsp">
                        <img src="img/carritoLogo.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Carrito de compra
                    </a>
                    <a class="nav-link" href="solicitudes.jsp">
                        <img src="img/orden.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Solicitudes
                    </a>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <img src="img/login.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> ${sessionScope.nombre_usuario != null ? sessionScope.nombre_usuario : 'Cuenta'}
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Cerrar Sesión</a></li>
                            <li><a class="dropdown-item" href="solicitudRecuperacion.jsp">Cambiar contraseña</a></li>
                        </ul>
                    </li>
                </div>
            </div>
        </div>
    </nav>
</header>

<%
    // Obtiene el ID del usuario de la sesión
    Integer idUsuario = (Integer) session.getAttribute("id_usuario");
    SolicitudDao solicitudDao = new SolicitudDao();
    List<Solicitud> listaSolicitudesPendientes = solicitudDao.getSolicitudesPendientesPorUsuario(idUsuario);
    List<Solicitud> listaSolicitudes = solicitudDao.getAllPorUsuario(idUsuario);
%>

<main>
    <h3>Solicitudes</h3>
    <img src="img/orden.png" width="5%" height="5%">
    <br>
    <div class="text-center">
        <button type="button" class="btn btn-success" id="btnHistorial" onclick="mostrarHistorialSolis()">
            Ver todo mi historial
        </button>
        <button type="button" class="btn btn-success" id="btnProceso" onclick="mostrarProcesoSolis()">
            Ver solicitudes pendientes/proceso
        </button>
    </div>

    <!-- TABLA SOLICITUDES PENDIENTES O EN PROCESO -->
    <div class="table-responsive" id="tablaSolicitudesPendientes">
        <h3>Solicitudes Pendientes o en Proceso</h3>
        <br>
        <br>
        <p>Cliente: ${sessionScope.nombre_usuario} ${sessionScope.apellido_usuario} </p>

        <table id="tablaPendientes" class="table table-striped table-hover table-responsive table-light table-borderless" style="width: 100%">
            <thead>
            <tr>
                <th>ID_SOLICITUD</th>
                <th>Total a pagar</th>
                <th>Fecha</th>
                <th>Estado de la solicitud</th>
                <th>Detalles</th>
            </tr>
            </thead>
            <tbody>
            <% for (Solicitud s : listaSolicitudesPendientes) { %>
            <tr>
                <td><%= s.getId_solicitud() %></td>
                <td><%= s.getTotal()%></td>
                <td><%= s.getFecha() %></td>
                <td><%= s.getEstado() %></td>
                <td>
                    <button type="button" class="btn botonesApp" data-bs-toggle="modal" data-bs-target="#modalProductos-<%= s.getId_solicitud() %>">
                        Ver mas detalles (productos)
                    </button>
                    <div class="modal fade" id="modalProductos-<%= s.getId_solicitud() %>" tabindex="-1" aria-labelledby="exampleModalLabel-<%= s.getId_solicitud() %>" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="desacModalLabel-<%= s.getId_solicitud() %>">Detalles</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group mb-3">
                                        <!-- Aqui se obtienen los productos de carrito_producto mediante el id_carrito-->
                                        <%
                                            CarritoProductoDao carritoProductoDao = new CarritoProductoDao();
                                            List<Carrito_Producto> listaProductos = carritoProductoDao.obtenerProductosPorCarrito(s.getCarrito().getId_carrito());
                                            Producto pro = new Producto();
                                            ProductoDao proDao = new ProductoDao();
                                        %>
                                        <h3>Total de la solicitud: <%= s.getTotal() %></h3>
                                        <div class="row">
                                            <% for (Carrito_Producto cp : listaProductos) { %>
                                            <div class="col-6 mb-3">
                                                <div class="card h-100">
                                                    <img src="<%= request.getContextPath() %>/image?sku=<%= cp.getProducto().getSku() %>" class="card-img-top img-fluid" alt="<%= cp.getProducto().getSku() %>">
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

    <!-- TABLA TODAS LAS SOLICITUDES -->
    <div class="table-responsive" id="tablaTodasSolis">
        <h3>Historial mis solicitudes</h3>
        <br>
        <br>
        <p>Cliente: ${sessionScope.nombre_usuario} ${sessionScope.apellidos_usuario} </p>

        <table id="example3" class="table table-striped table-hover table-responsive table-light table-borderless" style="width: 100%">
            <thead>
            <tr>
                <th>ID_SOLICITUD</th>
                <th>Total a pagar</th>
                <th>Fecha</th>
                <th>Estado de la solicitud</th>
                <th>Detalles</th>
            </tr>
            </thead>
            <tbody>
            <% for (Solicitud s : listaSolicitudes) { %>
            <tr>
                <td><%= s.getId_solicitud() %></td>
                <td><%= s.getTotal()%></td>
                <td><%= s.getFecha() %></td>
                <td><%= s.getEstado() %></td>
                <td>
                    <button type="button" class="btn botonesApp" data-bs-toggle="modal" data-bs-target="#modalProductos2-<%= s.getId_solicitud() %>">
                        Ver mas detalles (productos)
                    </button>
                    <div class="modal fade" id="modalProductos2-<%= s.getId_solicitud() %>" tabindex="-1" aria-labelledby="exampleModalLabel2-<%= s.getId_solicitud() %>" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="desacModalLabel2-<%= s.getId_solicitud() %>">Detalles</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group mb-3">
                                        <!-- Aqui se obtienen los productos de carrito_producto mediante el id_carrito-->
                                        <%
                                            CarritoProductoDao carritoProductoDao = new CarritoProductoDao();
                                            List<Carrito_Producto> listaProductos = carritoProductoDao.obtenerProductosPorCarrito(s.getCarrito().getId_carrito());
                                            Producto pro = new Producto();
                                            ProductoDao proDao = new ProductoDao();
                                        %>
                                        <h3>Total de la solicitud: <%= s.getTotal() %></h3>
                                        <div class="row">
                                            <% for (Carrito_Producto cp : listaProductos) { %>
                                            <div class="col-6 mb-3">
                                                <div class="card h-100">
                                                    <img src="<%= request.getContextPath() %>/image?sku=<%= cp.getProducto().getSku() %>" class="card-img-top img-fluid" alt="<%= cp.getProducto().getSku() %>">
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

<script src="${pageContext.request.contextPath}/JS/bootstrap.js"></script>
<script src="${pageContext.request.contextPath}/JS/jquery-3.7.0.js"></script>
<script src="${pageContext.request.contextPath}/JS/datatables.js"></script>
<script src="${pageContext.request.contextPath}/JS/dataTables.bootstrap5.js"></script>
<script src="${pageContext.request.contextPath}/JS/es-MX.json"></script>
<script>
    const tablePendientes = document.getElementById('tablaPendientes');
    new DataTable(tablePendientes, {
        language: {
            url: '${pageContext.request.contextPath}/JS/es-MX.json'
        }
    });

    const table3 = document.getElementById('example3');
    new DataTable(table3, {
        language: {
            url: '${pageContext.request.contextPath}/JS/es-MX.json'
        }
    });
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.11.6/umd/popper.min.js"></script>
<script src="JS/bootstrap.js"></script>
<script>
    function mostrarHistorialSolis() {
        document.getElementById('tablaSolicitudesPendientes').style.display = "none";
        document.getElementById('tablaTodasSolis').style.display = "block";
    }
    function mostrarProcesoSolis(){
        document.getElementById('tablaTodasSolis').style.display = "none";
        document.getElementById('tablaSolicitudesPendientes').style.display = "block";
    }
</script>
<%
    session.removeAttribute("mensaje2A");
%>
</body>
</html>
