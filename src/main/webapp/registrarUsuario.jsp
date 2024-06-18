<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <!-- un formulario para insertar el usuario -->
    <form method="post" action="sign_in">
        <label>Ingrese su nombre de usuario: </label>
        <input type="text" name="nombre_usuario">
        <br>
        <label>Ingrese su contraseña: </label>
        <input type="password" name="pass1">
        <br>
        <label>Confirme su contraseña: </label>
        <input type="password" name="pass2">
        <br>
        <label>Ingrese su correo: </label>
        <input type="email" name="correo">
        <br>
        <label>Ingrese su tipo de usuario: </label>
        <select name="tipo_usuario">
            <option value="1">Admin</option>
            <option value="2">Normal</option>
        </select>
        <br>
        <input type="submit" value="Registrarse" >
    </form>
</body>
</html>
