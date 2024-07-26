<%@ page import="mx.edu.utez.practica3e.dao.CarritoDao" %>
<%@ page import="mx.edu.utez.practica3e.dao.CarritoProductoDao" %>
<%@ page import="mx.edu.utez.practica3e.model.Carrito" %>
<%@ page import="mx.edu.utez.practica3e.model.Carrito_Producto" %>
<%@ page import="java.util.List" %>
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
                    <a class="nav-link active" aria-current="page" href="indexCliente.jsp">Inicio</a>
                    <a class="nav-link" href="carrito.jsp">
                        <img src="img/carritoLogo.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Carrito de compra
                    </a>
                    <a class="nav-link" href="#">
                        <img src="img/orden.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Órdenes
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
    CarritoDao carritoDAO = new CarritoDao();
    Carrito carrito = carritoDAO.getCarritoNoConfirmado(idUsuario);
%>

<main>
    <!-- TABLA TODOS LOS PRODUCTOS DEL CARRITO -->
    <div class="table-responsive" id="tablaCarrito">
        <h3>Carrito de Compras</h3>
        <img src="img/carritoLogo.png" width="5%" height="5%">
        <!-- BOTÓN NUEVA MARCA -->
        <button type="button" class="btn btn-success" onclick="window.location.href='indexCliente.jsp'">
            Regresar a comprar más productos
        </button>

        <!--TABLA DE PRODUCTOS DEL CARRITO -->
        <% if (carrito != null) { %>
        <table id="example3" class="table table-striped table-hover" style="width: 100%">
            <thead>
            <tr>
                <th>Imagen</th>
                <th>SKU</th>
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
                    for (Carrito_Producto cp : lista) {
            %>
            <tr>
                <td> <img src="<%= request.getContextPath() %>/image?sku=<%= cp.getProducto().getSku() %>" width="100px" alt="<%= cp.getProducto().getNombre() %>"></td>
                <td><%= cp.getProducto().getSku() %></td>
                <td><%= cp.getProducto().getDescripcion() %></td>
                <td><%= cp.getCantidad() %></td>
                <td><%= cp.getProducto().getPrecio() %></td>
                <td><%= cp.getTotalProducto() %></td>

                <!-- td para modificar cantidad-->
                <td>
                    <p>si</p>
                </td>
                <!-- td para eliminar del carrito-->
                <td>
                    <p>no</p>
                </td>
            </tr>
            <% }
            } else { %>
            <tr>
                <td colspan="8">No hay productos en el carrito.</td>
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
    session.removeAttribute("mensaje2A");
%>

</body>
</html>
