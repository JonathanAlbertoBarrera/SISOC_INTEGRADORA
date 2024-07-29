<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="mx.edu.utez.practica3e.dao.*" %>
<%@ page import="mx.edu.utez.practica3e.model.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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

        .si{
            color:#ffffff;
        }
        .barra a:hover{
            color:#F4AB2C;
        }

        .barra a:focus{
            color:#F4AB2C;
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
            border-color: #F4AB2C;
            margin: 0 10px; /* Añadir margen para asegurar que los botones estén espaciados */
        }

        .botonesApp.activo {
            background-color: black; /* Color de fondo negro para el botón activo */
            color: white; /* Texto blanco para el botón activo */
        }


    </style>

</head>
<body>
<header>
    <nav class="navbar navbar-expand-lg barra bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand si" href="#">Cafetería (ADMIN)</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse si" id="navbarNavAltMarkup">
                <div class="navbar-nav mx-auto">
                    <a class="nav-link si" aria-current="page"  href="indexAdmin.jsp">Inicio</a>
                    <a class="nav-link si" href="marcas.jsp">
                        <img src="img/iconoMarcas.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Marcas
                    </a>
                    <a class="nav-link si" href="categorias.jsp">
                        <img src="img/iconoCategoria.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Categorias
                    </a>
                    <a class="nav-link si" href="productosAdmin.jsp">
                        <img src="img/iconoProductos.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Productos
                    </a>
                    <a class="nav-link si" href="comprasAdmin.jsp">
                        <img src="img/iconoCompras.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Compras
                    </a>
                    <a class="nav-link si" href="ventasAdmin.jsp">
                        <img src="img/iconoVentas.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Ventas
                    </a>
                    <li class="nav-item dropdown bg-dark si">
                        <a class="nav-link dropdown-toggle si" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <img src="img/login.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> ${sessionScope.nombre_usuario != null ? sessionScope.nombre_usuario : 'Cuenta'}
                        </a>
                        <ul class="dropdown-menu text-bg-dark si">
                            <li><a class="dropdown-item si" href="${pageContext.request.contextPath}/logout" >Cerrar Sesión</a></li>
                            <li><a class="dropdown-item si" href="solicitudRecuperacion.jsp">Cambiar contraseña</a></li>
                        </ul>
                    </li>
                </div>
            </div>
        </div>
    </nav>
</header>

<main>
    <h3>Ventas</h3>
    <img src="img/iconoVentas.png" width="5%" height="5%">

    <!-- TABLA TODAS LAS CATEGORIAS -->
    <div class="table-responsive" id="tablaCategorias">

        <%
            HttpSession sesion1 = request.getSession();
            String mensaje2A = (String) sesion1.getAttribute("mensaje2A");

            if(mensaje2A != null){ %>
        <p class="text-danger"><%=mensaje2A%></p>
        <% } %>

        <!--TABLA DE VENTAS ENTREGADAS -->
        <table id="example3" class="table table-striped table-hover" style="width: 100%">
            <thead>
            <tr>
                <th>ID Solicitud</th>
                <th>ID carrito</th>
                <th>Cliente</th>
                <th>Fecha</th>
                <th>Total</th>
                <th>Ver detalles</th>
            </tr>
            </thead>
            <tbody>
            <%
                SolicitudDao dao = new SolicitudDao();
                SolicitudEncargadoDao dao2=new SolicitudEncargadoDao();
                ArrayList<Solicitud> lista = (ArrayList<Solicitud>) dao.obtenerSolicitudesEntregadas();
                for(Solicitud s : lista) {
            %>
            <tr>
                <td><%= s.getId_solicitud() %></td>
                <td><%= s.getCarrito().getId_carrito() %></td>
                <td><%= s.getUsuario().getPersona().getNombre()%> <%= s.getUsuario().getPersona().getApellidos()%></td>
                <td><%= s.getFecha() %></td>
                <td><%= s.getTotal()%></td>
                <!-- td detalles-->
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

