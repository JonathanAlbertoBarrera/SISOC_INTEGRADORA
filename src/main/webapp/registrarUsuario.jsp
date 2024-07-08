<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registro de Usuario</title>
    <!-- Bootstrap CSS -->
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
            <h2 class="text-center mt-5">Registrarse</h2>
            <form method="post" action="sign_in" class="mt-4">
                <h3 class="text-center mt-5">Datos personales</h3>
                <div class="form-group mb-3">
                    <label for="correo">Ingrese su nombre(s):</label>
                    <input type="text" class="form-control" id="nombre" name="nombre" required>
                </div>
                <div class="form-group mb-3">
                    <label for="apellidos">Ingrese sus apellidos:</label>
                    <input type="text" class="form-control" id="apellidos" name="apellidos" required>
                </div>
                <div class="form-group mb-3">
                    <label for="telefono">Ingrese su número de teléfono:</label>
                    <input type="text" class="form-control" id="telefono" name="telefono" required>
                </div>
                <div class="form-group mb-3">
                    <label for="telefono">Ingrese su sexo (opcional):</label>
                    <br>
                    <select name="sexo" class="form-select">
                        <option selected></option>
                        <option value="Hombre">Hombre</option>
                        <option value="Mujer">Mujer</option>
                        <option value="NA">Prefiero no especificarlo</option>
                    </select>
                </div>
                <h3 class="text-center mt-5">Datos de la cuenta</h3>
                <div class="form-group mb-3">
                    <label for="nombre">Ingrese su correo:</label>
                    <input type="email" class="form-control" id="correo" name="correo" required>
                </div>
                <div class="form-group mb-3">
                    <label for="pass1">Ingrese su contraseña:</label>
                    <input type="password" class="form-control" id="pass1" name="pass1" required>
                </div>
                <div class="form-group mb-3">
                    <label for="pass2">Confirme su contraseña:</label>
                    <input type="password" class="form-control" id="pass2" name="pass2" required>
                </div>
                <%
                    HttpSession sesion1 = request.getSession();
                    String mensaje2 = (String) sesion1.getAttribute("mensaje2");

                    if(mensaje2 != null){ %>
                <p class="text-danger"><%=mensaje2%></p>
                <% } %>
                <div class="text-center">
                    <button type="submit" class="btn btn-dark botonesApp btn-block">Registrarse</button>
                </div>

                <%
                    HttpSession sesion2 = request.getSession();
                    String mensaje3 = (String) sesion2.getAttribute("mensaje3");

                    if(mensaje3 != null){ %>
                <p class="text-danger"><%=mensaje3%></p>
                <% } %>
            </form>
            <div class="text-center mt-3">
                <a href="iniciarSesion.jsp" class="btn btn-link">Ir a inicio de sesión</a>
            </div>
            <br>
        </div>
    </div>
</div>
</body>
</html>
