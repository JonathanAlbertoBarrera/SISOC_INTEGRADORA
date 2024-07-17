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
            <h2 class="text-center mt-5">Solicitud de Recuperación de contraseña</h2>
            <form method="post" action="recuContra" class="mt-4">
                <div class="form-group mb-3">
                    <label for="correo">Ingrese su correo:</label>
                    <input type="email" class="form-control" id="correo" name="correo" required>
                </div>
                <%
                    HttpSession sesion = request.getSession();
                    String mensaje = (String) sesion.getAttribute("mensaje");
                    sesion.setAttribute("mensaje", null);

                    if(mensaje != null){ %>
                <p class="text-danger"><%=mensaje%></p>
                <% } %>
                <div class="text-center">
                    <button type="submit" class="btn btn-dark botonesApp btn-block">Solicitar</button>
                </div>

            </form>
        </div>
    </div>
</div>
</body>
</html>
