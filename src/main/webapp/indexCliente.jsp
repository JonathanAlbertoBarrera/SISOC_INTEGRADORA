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
                    <a class="nav-link active" aria-current="page" href="indexCliente.jsp">Inicio</a>
                    <a class="nav-link" href="carrito.jsp">
                        <img src="img/carritoLogo.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Carrito de compra
                    </a>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <img src="img/orden.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Solicitudes
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="solicitudes.jsp">Pendientes/En proceso</a></li>
                            <li><a class="dropdown-item" href="miHistorialSolicitudes.jsp">Mi historial</a></li>
                        </ul>
                    </li>
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

<main>
    <!-- DIV PARA BUSCAR y FILTROS -->
    <div class="container mt-3">
        <div class="row justify-content-center">
            <div class="col-md-3 mb-2 d-flex">
                <input class="form-control me-2" type="search" placeholder="Buscar" aria-label="Search">
                <button class="btn" type="submit"><img src="img/search.png" alt="Icono de Busqueda" width="30" height="24"></button>
            </div>
            <div class="col-md-3 mb-2">
                <select name="categorias" id="categorias" class="form-select bg-dark text-white" >
                    <option value="" selected disabled>Selecciona una categoría</option>
                    <c:forEach items="${categorias}" var="c">
                        <option value="${c.id_categoria}">${c.nombre}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-3 mb-2 ">
                <select name="marcas" id="marcas" class="form-select bg-dark text-white" required>
                    <option value="" selected disabled>Selecciona una marca</option>
                    <c:forEach items="${marcas}" var="m">
                        <option value="${m.id_marca}" >${m.nombre}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
    </div>

    <!-- DIV PRODUCTOS -->
    <div class="container mt-2">
        <h2 id="titSeccion">Productos</h2>
        <div class="row" id="product-cards-container">
            <!-- Aquí se añadirán dinámicamente las tarjetas de productos -->
            <c:forEach items="${productos}" var="p">
            <div class="col-md-3 mb-2">
                <div class="card h-100 text-center align-content-center">
                    <img src="<%= request.getContextPath() %>/image?sku=${p.sku}" class="card-img-top mx-auto" height="60%" alt="${p.nombre}">
                    <div class="card-body">
                        <h3 class="card-title">${p.nombre}</h3>
                        <p class="card-text">$${p.precio}</p>
                        <p class="card-text">${p.descripcion}</p>
                        <div class="container" id="cajaBoton">
                            <div class="row flex-column text-center">
                                <img src="img/gifAddCarrito.gif" alt="gif agregar al carrito" class="mx-auto" id="icAddCar">
                                <a class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#modalcantProducto-${p.sku}">Agregar al Carrito</a>

                                <!-- Modal para cantidad-->
                                <div class="modal fade" id="modalcantProducto-${p.sku}" tabindex="-1" aria-labelledby="exampleModalLabel-${p.sku}" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h1 class="modal-title fs-5" id="desacModalLabel-${p.sku}">Agregar al carrito</h1>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <form method="post" action="agregarCarrito">
                                            <div class="modal-body">
                                                Ingresa la cantidad que quieres agregar de tu producto ${p.nombre}:

                                                    <input type="number" name="addCant" min="1" required>
                                                    <input type="hidden" name="id_usuario" value="${sessionScope.id_usuario}">
                                                    <input type="hidden" name="precio" value="${p.precio}" step="0.01">
                                                    <input type="hidden" name="sku" value="${p.sku}">
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                                    <button type="submit" class="btn btn-primary botonesApp">Confirmar</button>
                                            </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </c:forEach>
        </div>
    </div>

    <!-- PAGINACIÓN -->
    <nav aria-label="...">
        <br>
        <br>
        <h6>Ver más</h6>
        <ul class="pagination justify-content-center">
            <li class="page-item disabled">
                <span class="page-link">Previous</span>
            </li>
            <li class="page-item active"><a class="page-link" href="#">1</a></li>
            <li class="page-item" aria-current="page">
                <span class="page-link">2</span>
            </li>
            <li class="page-item"><a class="page-link" href="#">3</a></li>
            <li class="page-item">
                <a class="page-link" href="#">Next</a>
            </li>
        </ul>
    </nav>
</main>

<footer class="bg-body-tertiary text-black text-center py-3 barra">
    <div class="container">
        <p>&copy; 2024 Mi Cafetería. Todos los derechos reservados.</p>
        <p>Contáctanos: sistemasdeordenesdecafeteria@gmail.com</p>
    </div>
</footer>

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.11.6/umd/popper.min.js"></script>
<script src="JS/bootstrap.js"></script>

</body>
</html>
