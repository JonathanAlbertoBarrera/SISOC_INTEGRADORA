<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>JSP - Solicitud de Recuperación</title>
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
            <h2 class="text-center mt-5">Cambiar contraseña</h2>
            <form method="post" action="updateContra">
                <label>Nueva Contraseña: </label>
                <input type="password" name="contraseña">
                <br>
                <input type="hidden" name="codigo" value="<%= request.getParameter("codigo") %>">
                <br>
                <div class="text-center">
                    <input type="submit"  class="btn btn-dark botonesApp btn-block" value="Cambiar">
                </div>

            </form>

        </div>
    </div>
</div>
</body>
</html>
