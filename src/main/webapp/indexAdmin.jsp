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
        .barra {
            background-color:#F4AB2C;
            width: 200px;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding-top: 20px; /* Añadir espacio en la parte superior */
        }
        main {
            margin-left: 220px; /* Space for the sidebar */
            text-align: center;
        }
        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #f8f9fa; /* Color de fondo general */
        }
        .container {
            background-color: #ffca2c; /* Color de fondo del contenedor */
            padding: 10px;
            border-radius: 10px;
            margin-top: 20px;
            width: 200px; /* Ajusta el ancho del contenedor */
            margin-left: 0; /* Alinea el contenedor a la izquierda */
            position: absolute;
            top: 20px;
            left: 220px; /* Ajusta el margen izquierdo para alinear con la barra */
            text-align: center; /* Alinea el texto a la izquierda */
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center; /* Alinea los elementos al centro del contenedor */
        }
        .container h2, .container p {
            text-align: center; /* Centra el texto del h2 y p dentro del contenedor */
        }
        .hidden {
            display: none;
        }
        .botonesApp {
            background-color: #F4AB2C;
            border-color:#F4AB2C;
        }
        .navbar-nav {
            width: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .nav-link {
            color: white !important;
            width: 100%;
            padding: 10px 15px;
        }
        .nav-link.active {
            background-color: #D9951E;

        }
        .btn-custom {
            background-color: #F4AB2C;
            border-color: #F4AB2C;
            color: white;
            margin-top: 20px;
        }
        .btn-group {
            width: 100%;
            display: flex;
            flex-direction: column;
            align-items: start;
        }
        .btn-group .btn {
            background-color: #D9951E;
            border-color: #D9951E;
            color: white;
            width: 100%;
        }
    </style>
</head>
<body>
<!-- BARRA NAVEGACION -->
<header>
    <nav class="navbar navbar-expand-lg barra">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Cafetería</a>
            <div class="navbar-nav mt-3">
                <li class="nav-item dropdown" style="top:30px; right: 100px">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <img src="img/login.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Cuenta
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="iniciarSesion.jsp">Cerrar Sesion</a></li>
                        <li><a class="dropdown-item" href="recuperacion.jsp">Cambiar contraseña</a></li>
                    </ul>
                </li>
            </div>
        </div>
    </nav>
</header>

<main>
    <div class="container">
        <h2>Gestión de Usuarios</h2>
        <p>Utiliza el botón de abajo para visualizar a los usuarios registrados.</p>
        <a href="gestionUsuarios.jsp" class="btn btn-custom">Administrar Usuarios</a>
    </div>
</main>

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.11.6/umd/popper.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>
