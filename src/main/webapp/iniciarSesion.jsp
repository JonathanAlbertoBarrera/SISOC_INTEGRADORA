<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
<form method="post" action="login">
    <label>Ingrese su correo: </label>
    <input type="text" name="correo">
    <br><br>
    <label>Ingrese contraseña: </label>
    <input type="password" name="contrasena">
    <br><br>
    <%
        HttpSession sesion = request.getSession();
        String mensaje = (String) sesion.getAttribute("mensaje");

        if(mensaje!=null){ %>
    <p style="color: red;"><%=mensaje%></p>
    <% } %>
    <input type="submit" value="Iniciar sesión">
</form>
<br>
<a href="registrarUsuario.jsp">Registrarme</a>
</body>
</html>
