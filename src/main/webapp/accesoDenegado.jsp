<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Acceso Denegado</title>
    <link href="css/bootstrap.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
        }
        .barra {
            background-color: #F4AB2C;
        }
        .botonesApp {
            background-color: #F4AB2C;
            border-color: #F4AB2C;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="text-center">
                <img src="img/iconoAccesoDen.png" alt="imagen de acceso denegado" width="128" height="128" class="d-inline-block align-text-top">
            </div>
            <h1 class="text-center mt-5">Acceso denegado</h1>
            <div class="form-group mb-3">
                <p>No puedes acceder a esta pagina, no tienes los permisos para ver el contenido.</p>
            </div>
            <div class="text-center">
                <a href="iniciarSesion.jsp" class="btn btn-dark botonesApp">Iniciar sesión</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>
