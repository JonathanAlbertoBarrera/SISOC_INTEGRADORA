<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <!-- un formulario para insertar el usuario -->
    <form method="post" action="sign_in">
        <label>Ingrese su correo: </label>
        <input type="email" name="correo">
        <br><br>
        <label>Ingrese su contraseña: </label>
        <input type="password" name="pass1">
        <br><br>
        <label>Confirme su contraseña: </label>
        <input type="password" name="pass2">
        <br>
        <br>
        <%
            HttpSession sesion1 = request.getSession();
            String mensaje2 = (String) sesion1.getAttribute("mensaje2");

            if(mensaje2 !=null){ %>
        <p style="color: red;"><%=mensaje2%></p>
        <% } %>
        <input type="submit" value="Registrarse" >
        <%
            HttpSession sesion2 = request.getSession();
            String mensaje3 = (String) sesion2.getAttribute("mensaje3");

            if(mensaje3 !=null){ %>
        <p style="color: red;"><%=mensaje3%></p>
        <% } %>
    </form>
    <br><br>
    <a href="iniciarSesion.jsp">Ingresar</a>
</body>
</html>
