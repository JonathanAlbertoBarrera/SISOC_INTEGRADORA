<%@ page import="mx.edu.utez.practica3e.model.Carrito_Producto" %>
<%@ page import="java.util.List" %>
<%@ page import="mx.edu.utez.practica3e.dao.CarritoProductoDao" %>
<%@ page import="mx.edu.utez.practica3e.model.Carrito" %>
<%@ page import="mx.edu.utez.practica3e.dao.CarritoDao" %>
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

        .imgProductos{
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
                    <a class="nav-link" href="ventasEncargado.jsp">
                        <img src="img/iconoVentas.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Mis Ventas
                    </a>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <img src="img/login.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> ${sessionScope.nombre_usuario != null ? sessionScope.nombre_usuario : 'Cuenta'}
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout" >Cerrar Sesión</a></li>
                            <li><a class="dropdown-item" href="registrarUsuario.jsp">Registrarse</a></li>
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
    CarritoDao carritoDAO = new CarritoDao();
    Carrito carrito = carritoDAO.getCarritoNoConfirmado(idUsuario);
    CarritoProductoDao carritoProductoDao = new CarritoProductoDao();
    double totalCarrito = carrito != null ? carritoProductoDao.getTotalCarrito(carrito.getId_carrito()) : 0.0;
%>

<main class="content">
    <div class="container mt-2">
        <h2 id="titSeccion">Carrito</h2>
    </div>
    <!-- TABLA TODOS LOS PRODUCTOS DEL CARRITO -->
    <div class="table-responsive" id="tablaCarrito">
        <h3>Carrito de Compras</h3>
        <img src="img/carritoLogo.png" width="5%" height="5%">
        <!-- BOTÓN NUEVA MARCA -->
        <button type="button" class="btn btn-success" onclick="window.location.href='productosEncargado.jsp'">
            Regresar a comprar más productos
        </button>

        <br>
        <br>
        <h3>Total del Carrito: $<%= String.format("%.2f", totalCarrito) %></h3>
        <form method="post" action="hacerSolicitudEncargado">
            <input type="submit" value="Hacer Solicitud" class="btn btn-success">
        </form>

        <br>
        <% if (request.getAttribute("mensaje") != null) { %>
        <div class="alert alert-info">
            <%= request.getAttribute("mensaje") %>
        </div>
        <% } %>

        <!--TABLA DE PRODUCTOS DEL CARRITO -->
        <% if (carrito != null) { %>
        <table id="example3" class="table table-striped table-hover table-responsive table-light table-borderless" style="width: 100%">
            <thead>
            <tr>
                <th>Imagen</th>
                <th>SKU</th>
                <th>Nombre</th>
                <th>Descripción</th>
                <th>Cantidad</th>
                <th>Precio</th>
                <th>Total por producto</th>
                <th>Cambiar cantidad</th>
                <th>Eliminar del carrito</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<Carrito_Producto> lista = carritoDAO.getAllPorCarrito(carrito.getId_carrito());
                if (lista != null && !lista.isEmpty()) {
            %>

            <% for (Carrito_Producto cp : lista) { %>
            <tr>
                <td> <img src="<%= request.getContextPath() %>/image?sku=<%= cp.getProducto().getSku() %>" class="imgProductos" alt="<%= cp.getProducto().getNombre() %>"></td>
                <td><%= cp.getProducto().getSku() %></td>
                <td><%= cp.getProducto().getNombre() %></td>
                <td><%= cp.getProducto().getDescripcion() %></td>
                <td><%= cp.getCantidad() %></td>
                <td><%= cp.getProducto().getPrecio() %></td>
                <td><%= cp.getTotalProducto() %></td>

                <!-- td para modificar cantidad-->
                <td>
                    <button type="button" class="btn botonesApp" data-bs-toggle="modal" data-bs-target="#modalSetCant-<%= cp.getId_carrito_producto() %>">
                        Cambiar cantidad
                    </button>
                    <!-- Modal -->
                    <div class="modal fade" id="modalSetCant-<%= cp.getId_carrito_producto() %>" tabindex="-1" aria-labelledby="exampleModalLabel-<%= cp.getId_carrito_producto() %>" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="desacModalLabel-<%= cp.getId_carrito_producto() %>">Cambiar cantidad</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <form method="post" action="cambiarCantidadCarrito">
                                    <div class="modal-body">
                                        <div class="form-group mb-3">
                                            <label for="cantidad2">Nueva cantidad deseada:</label>
                                            <input type="number" class="form-control" id="cantidad2" min="1" name="cantidad2" required>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                                        <input type="hidden" name="id_carrito_producto" value="<%= cp.getId_carrito_producto() %>">
                                        <input type="hidden" name="sku" value="<%= cp.getProducto().getSku() %>">
                                        <button type="submit" class="btn btn-primary botonesApp">Confirmar</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </td>
                <!-- td para eliminar del carrito-->
                <td>
                    <img src="img/DELETEICONO.gif" width="20%" height="20%">
                    <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#modalQuitarCarrito-<%= cp.getId_carrito_producto() %>">
                        Quitar del carrito
                    </button>

                    <!-- Modal Para quitar del carrito -->
                    <div class="modal fade" id="modalQuitarCarrito-<%= cp.getId_carrito_producto() %>" tabindex="-1" aria-labelledby="exampleModalLabel-<%= cp.getId_carrito_producto() %>" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="desacModalLabel-<%= cp.getId_carrito_producto() %>">Confirmar eliminación</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    ¿Estás seguro de que deseas quitar del carrito al producto
                                    <%= cp.getProducto().getNombre() %>?
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                                    <form method="post" action="borrarDelCarrito">
                                        <input type="hidden" name="id_carrito_producto" value="<%= cp.getId_carrito_producto() %>">
                                        <button type="submit" class="btn btn-primary botonesApp">Confirmar</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
            <% } %>
            <% } else { %>
            <tr>
                <td colspan="9">No hay productos en el carrito.</td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } else { %>
        <p>Agrega productos al carrito desde el inicio para verlos aquí.</p>
        <% } %>
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
    // Elimina el mensaje de la sesión después de usarlo
    session.removeAttribute("mensaje");
%>

</body>
</html>