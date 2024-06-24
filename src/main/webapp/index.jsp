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
    </style>
    <script src="js/mostrarProductos.js" defer></script>
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
                    <a class="nav-link active" aria-current="page" onclick="regresarMasVendidos()" href="#">Inicio</a>
                    <a class="nav-link" href="carrito.html">
                        <img src="img/carritoLogo.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Carrito de compra
                    </a>
                    <a class="nav-link" href="#">
                        <img src="img/orden.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Órdenes
                    </a>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <img src="img/login.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Cuenta
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="iniciarSesion.jsp">Iniciar Sesión</a></li>
                            <li><a class="dropdown-item" href="#">Cambiar contraseña</a></li>
                        </ul>
                    </li>
                </div>
            </div>
        </div>
    </nav>
</header>

<main>
    <!-- DIV PARA BUSCAR -->
    <div class="container mt-3">
        <div class="row justify-content-center">
            <div class="col-md-3 mb-2 d-flex">
                <input class="form-control me-2" type="search" placeholder="Buscar" aria-label="Search">
                <button class="btn" type="submit"><img src="img/search.png" alt="Icono de Busqueda" width="30" height="24"></button>
            </div>
            <div class="col-md-3 mb-2 d-flex">
                <select class="form-select" aria-label="Default select example" id="SelectCategoria">
                    <option selected disabled hidden>Categoría</option>
                    <option value="Bebidas">Bebidas</option>
                    <option value="Galletas">Galletas</option>
                    <option value="Botanas">Botanas</option>
                </select>
            </div>
            <div class="col-md-3 mb-2 d-flex">
                <select class="form-select me-2" aria-label="Default select example" id="SelectMarca">
                    <option selected disabled hidden>Marca</option>
                    <option value="Gamesa">Gamesa</option>
                    <option value="Coca-cola">Coca-cola</option>
                    <option value="Doritos">Doritos</option>
                </select>
                <button class="btn btn-dark botonesApp" onclick="mostrarSeleccionados()">Enviar Productos</button>
            </div>
        </div>
    </div>

    <!-- DIV PRODUCTOS -->
    <div class="container mt-2">
        <h2 id="titSeccion">Productos Más Vendidos</h2>
        <div class="row" id="product-cards-container">
            <!-- Aquí se añadirán dinámicamente las tarjetas de productos -->
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
        <p>Contáctanos: info@micafeteria.com</p>
    </div>
</footer>

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.11.6/umd/popper.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>
