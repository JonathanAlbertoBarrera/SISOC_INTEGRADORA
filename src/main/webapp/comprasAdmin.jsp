<%@ page import="mx.edu.utez.practica3e.dao.CategoriaDao" %>
<%@ page import="mx.edu.utez.practica3e.model.Categoria" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="mx.edu.utez.practica3e.dao.ProductoDao" %>
<%@ page import="mx.edu.utez.practica3e.model.Producto" %>
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
        .si{
            color: #ffffff;
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

        .form-check {
            display: flex;
            align-items: center;
        }

        .form-check-input {
            width: 1.5em;
            height: 1.5em;
        }

        .form-check-label {
            margin-left: 0.5em;
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

    <h3>Comprar inventario</h3>
    <img src="img/iconoCompras.png" width="5%" height="5%">

    <br>
    <c:if test="${not empty sessionScope.mensaje2}">
        <div class="alert alert-success">
                ${sessionScope.mensaje2}
        </div>
    </c:if>


    <div class="table-responsive" id="tablaCategorias">

        <!--TABLA DE PRODUCTOS -->
        <table id="example3" class="table table-striped table-hover table-light" style="width: 100%">
            <thead>
            <tr>
                <th>Imagen</th>
                <th>SKU</th>
                <th>Nombre</th>
                <th>Descripción</th>
                <th>Precio</th>
                <th>Stock</th>
                <th>Aumentar Stock</th>
            </tr>
            </thead>
            <tbody>
            <%
                ProductoDao productoDao = new ProductoDao();
                ArrayList<Producto> productos = (ArrayList<Producto>) productoDao.getAll();
                for (Producto p : productos) {
            %>
            <tr>
                <td><img src="<%= request.getContextPath() %>/image?sku=<%= p.getSku() %>" width="20%" alt="<%= p.getNombre() %>"></td>
                <td><%= p.getSku() %></td>
                <td><%= p.getNombre() %></td>
                <td><%= p.getDescripcion() %></td>
                <td><%= p.getPrecio() %></td>
                <td><%= p.getCantidad() %></td>
                <td>
                    <button type="button" class="btn" data-bs-toggle="modal" data-bs-target="#modalModiCantidad-<%= p.getSku() %>">
                        <img src="img/aumentopro.png" alt="Comprar unidades" style="height: 40%; width: 20%;">
                    </button>
                    <!-- Modal PARA MODIFICAR CANTIDAD-->
                    <div class="modal fade" id="modalModiCantidad-<%= p.getSku() %>" tabindex="-1" aria-labelledby="exampleModalLabel-<%= p.getSku() %>" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="modiModalLabel-<%= p.getSku() %>">Agregar unidades</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <form method="post" action="modiCantidadProducto">
                                        <div class="container">
                                            <div class="row justify-content-center">
                                                <div class="col-md-6 text-bg-dark">
                                                    <h2 class="text-center mt-5">Aumentar stock</h2>
                                                    <div class="form-group mb-3">
                                                        <label>Cantidad:</label>
                                                        <input type="number" class="form-control"  name="cantidad" min="1" required>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                                            <input type="hidden" name="sku" value="<%= p.getSku() %>">
                                            <button type="submit" class="btn btn-primary botonesApp">Guardar cambios</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
            <%
                }
            %>
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
    session.removeAttribute("mensaje2");
%>
</body>
</html>
