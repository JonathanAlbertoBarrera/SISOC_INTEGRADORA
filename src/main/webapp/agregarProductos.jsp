<%@ page import="mx.edu.utez.practica3e.dao.CategoriaDao" %>
<%@ page import="mx.edu.utez.practica3e.model.Categoria" %>
<%@ page import="java.util.ArrayList" %>
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
        .barra {
            background-color: #000000;
        }

        .barra a{
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
<!-- BARRA NAVEGACION -->
<header>
    <nav class="navbar navbar-expand-lg barra">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Cafetería (ADMIN)</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                <div class="navbar-nav mx-auto">
                    <a class="nav-link" aria-current="page" href="indexAdmin.jsp">Inicio</a>
                    <a class="nav-link" href="marcas.jsp">
                        <img src="img/iconoMarcas.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Marcas
                    </a>
                    <a class="nav-link" href="categorias.jsp">
                        <img src="img/iconoCategoria.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Categorias
                    </a>
                    <a class="nav-link" href="productosAdmin.jsp">
                        <img src="img/iconoProductos.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Productos
                    </a>
                    <a class="nav-link" href="#">
                        <img src="img/iconoCompras.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Compras
                    </a>
                    <a class="nav-link" href="#">
                        <img src="img/iconoVentas.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Ventas
                    </a>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <img src="img/login.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Cuenta
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="iniciarSesion.jsp">Iniciar Sesión</a></li>
                            <li><a class="dropdown-item" href="solicitudRecuperacion.jsp">Cambiar contraseña</a></li>
                        </ul>
                    </li>
                </div>
            </div>
        </div>
    </nav>
</header>

<main>

    <div class="table-responsive" id="tablaCategorias">
        <h3>Productos</h3>
        <img src="img/iconoProductos.png" width="5%" height="5%">


        <!--VISTA PARA AGREGAR PRODUCTO -->
        <div id="vistaAddProducto">
            <br>
            <button class="btn btn-dark botonesApp" onclick="mostrarCrud()">Ir a productos registrados</button>
            <br>
            <h3>Agregar un nuevo Producto</h3>

            <!--FORMULARIO AGREGAR PRODUCTO -->
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-6 bg-dark text-white p-4 rounded-circle">
                        <form method="post" action="addProducto" class="mt-4">
                            <div class="form-group mb-3">
                                <label for="sku">SKU (ID) producto:</label>
                                <input type="text" class="form-control bg-dark text-white" id="sku" name="sku" value="<%= request.getAttribute("sku") != null ? request.getAttribute("sku") : "" %>" required>
                            </div>
                            <div class="form-group mb-3">
                                <label for="nombre">Nombre del producto:</label>
                                <input type="text" class="form-control bg-dark text-white" id="nombre" name="nombre" value="<%= request.getAttribute("nombre") != null ? request.getAttribute("nombre") : "" %>" required>
                            </div>
                            <div class="form-group mb-3">
                                <label>Categoría:</label>
                                <br>
                                <select name="categorias" id="categorias" class="form-select bg-dark text-white" value="<%= request.getAttribute("categorias") != null ? request.getAttribute("categorias") : "" %>">
                                    <option value="" selected disabled>Selecciona una categoría</option>
                                    <c:forEach items="${categorias}" var="c">
                                        <option value="${c.id_categoria}" selected disabled>${c.nombre}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group mb-3">
                                <label>Marca:</label>
                                <br>
                                <select name="marcas" id="marcas" class="form-select bg-dark text-white" value="<%= request.getAttribute("marcas") != null ? request.getAttribute("marcas") : "" %>">
                                    <option value="" selected disabled>Selecciona una marca</option>
                                    <c:forEach items="${marcas}" var="m">
                                        <option value="${m.id_marca}" selected disabled>${m.nombre}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-group mb-3">
                                <label for="precio">Precio del producto:</label>
                                <input type="number" class="form-control bg-dark text-white" id="precio" name="precio" value="<%= request.getAttribute("precio") != null ? request.getAttribute("precio") : "" %>" required>
                            </div>
                            <div class="form-group mb-3">
                                <label for="cantidad">Cantidad inicial de existencias del producto:</label>
                                <input type="number" class="form-control bg-dark text-white" id="cantidad" name="cantidad" value="<%= request.getAttribute("cantidad") != null ? request.getAttribute("cantidad") : "" %>" required>
                            </div>
                            <%
                                HttpSession sesion1 = request.getSession();
                                String mensaje2 = (String) sesion1.getAttribute("mensaje2");

                                if(mensaje2 != null){ %>
                            <p class="text-danger"><%=mensaje2%></p>
                            <% } %>

                            <div class="text-center">
                                <button type="submit" class="btn btn-dark botonesApp btn-block">Registrar Producto</button>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>

    </div>

</main>


</body>
</html>

