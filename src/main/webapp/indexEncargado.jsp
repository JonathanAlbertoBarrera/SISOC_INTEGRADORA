<%@ page import="mx.edu.utez.practica3e.model.Carrito_Producto" %>
<%@ page import="java.util.List" %>
<%@ page import="mx.edu.utez.practica3e.dao.CarritoProductoDao" %>
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

<main class="content">
    <div class="container mt-2">
        <h2 id="titSeccion">Solicitudes Pendientes</h2>
        <!-- Mostrar el mensaje -->
        <c:if test="${not empty sessionScope.mensaje}">
            <div class="alert alert-success">
                    ${sessionScope.mensaje}
            </div>
        </c:if>

        <!-- Elimina el mensaje después de mostrarlo -->
        <c:if test="${not empty sessionScope.mensaje}">
            <c:remove var="mensaje" scope="session"/>
        </c:if>
        <p>Encargado: ${sessionScope.nombre_usuario} ${sessionScope.apellido_usuario} </p>
        <img src="img/espera.gif" alt="gif solicitud en espera" width="10%" height="10%">
        <div class="row" id="product-cards-container">
            <!-- Aquí irán las solicitudes -->
            <c:forEach items="${solicitudes}" var="s">
                <div class="col-md-3 mb-2">
                    <div class="card h-100 text-center align-content-center">
                        <div class="card-body">
                            <h3 class="card-title">ID SOLICITUD: ${s.id_solicitud}</h3>
                            <p class="card-text">ID CARRITO: ${s.carrito.id_carrito}</p>
                            <p class="card-text">ID USUARIO: ${s.usuario.idUsuario}</p>
                            <p class="card-text">Correo del usuario: ${s.usuario.correo}</p>
                            <p class="card-text">Nombre: ${s.usuario.persona.nombre}</p>
                            <p class="card-text">Fecha: ${s.fecha}</p>
                            <p class="card-text">TOTAL A PAGAR: ${s.total}</p>
                            <div class="container" id="cajaBoton">
                                <div class="row flex-column text-center">
                                    <img src="img/ordern.gif" alt="gif agregar al carrito" class="mx-auto" id="icAddCar">
                                    <a class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#modalTomarSoli-${s.id_solicitud}">Tomar Solicitud</a>
                                </div>
                            </div>
                                    <!-- Modal para mostrar los productos de la solicitud -->
                                    <div class="modal fade" id="modalTomarSoli-${s.id_solicitud}" tabindex="-1" aria-labelledby="exampleModalLabel-${s.id_solicitud}" aria-hidden="true">
                                        <div class="modal-dialog modal-dialog-centered">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h1 class="modal-title fs-5" id="desacModalLabel-${s.id_solicitud}">Tomar Solicitud</h1>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <p><b>Total a pagar: ${s.total}.</b></p>
                                                    Productos de la solicitud:
                                                    <div class="row">
                                                    <c:forEach items="${productosPorCarrito[s.carrito.id_carrito]}" var="producto">
                                                        <div class="col-6 mb-3">
                                                            <div class="card h-100">
                                                                <div class="text-center">
                                                                    <img src="<%= request.getContextPath() %>/image?sku=${producto.producto.sku}" >
                                                                </div>
                                                                <p>Producto: ${producto.producto.nombre}, SKU:${producto.producto.sku} </p>
                                                                <p>Cantidad: ${producto.cantidad}, PRECIO: ${producto.precio} </p>
                                                                <p><b>Total producto: ${producto.totalProducto}</b></p>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                                    <form method="post" action="tomarSolicitud">
                                                        <input type="hidden" name="id_solicitud" value="${s.id_solicitud}">
                                                        <button type="submit" class="btn btn-primary botonesApp">Confirmar</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Fin del Modal -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</main>

<footer class="bg-body-tertiary text-black text-center py-3 barra">
    <div class="container">
        <p>&copy; 2024 Mi Cafetería. Todos los derechos reservados.</p>
        <p>Contáctanos: info@micafeteria.com</p>
    </div>
</footer>

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.11.6/umd/popper.min.js"></script>
<script src="JS/bootstrap.js"></script>
</body>
</html>
