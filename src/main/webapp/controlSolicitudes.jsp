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
                    <a class="nav-link" href="controlSolicitudes.jsp">
                        <img src="img/orden.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Mis Ventas
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

<main>

    <div class="container mt-2">
        <h2 id="titSeccion">Mis Solicitudes</h2>
        <p>Encargado: ${sessionScope.usuario.persona.nombre} ${sessionScope.usuario.persona.apellidos}</p>
        <div class="row" id="product-cards-container">
            <!-- Aquí irán las solicitudes del encargado -->
            <c:forEach items="${solicitudesEncargado}" var="se">
                <div class="col-md-3 mb-2">
                    <div class="card h-100 text-center align-content-center">
                        <div class="card-body">
                            <h3>ESTADO: ${se.solicitud.estado}</h3>
                            <p class="card-title">ID SOLICITUD: ${se.solicitud.id_solicitud}</p>
                            <p class="card-text">Correo del usuario: ${se.solicitud.usuario.correo}</p>
                            <p class="card-text">Nombre: ${se.solicitud.usuario.persona.nombre}</p>
                            <p class="card-text">Fecha: ${se.solicitud.fecha}</p>
                            <p class="card-text">TOTAL A PAGAR: ${se.solicitud.total}</p>
                            <div class="container" id="cajaBoton">
                                <div class="row flex-column text-center">
                                    <img src="img/checklist.gif" alt="gif lista" class="mx-auto" id="icAddCar">
                                    <!-- Lista de productos -->
                                    <p><b>Productos.</b></p>
                                    <ul>
                                        <c:forEach var="producto" items="${productosPorCarritoEncargado[se.solicitud.carrito.id_carrito]}">
                                            <li><b>${producto.producto.nombre}</b> - Cantidad: ${producto.cantidad}</li>
                                        </c:forEach>
                                    </ul>
                                </div>
                                <a class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#modalCambiarEstadoSoli-${se.solicitud.id_solicitud}">Cambiar estado</a>
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
<script src="js/bootstrap.js"></script>
</body>
</html>

