<%@ page import="mx.edu.utez.practica3e.dao.UsuarioDao" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="mx.edu.utez.practica3e.model.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Usuarios Registrados</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/datatables.css">
</head>
<body>
<table id="example" class="table table-striped table-hover" style="width: 100%">
    <thead>
    <tr>
        <th>id</th>
        <th>nombre</th>
        <th>contraseña</th>
        <th>correo</th>
        <th>tipo</th>
        <th>estado</th>
        <th>actualizar</th>
        <th>eliminar</th>
    </tr>
    </thead>
    <tbody>
    <%
        UsuarioDao dao = new UsuarioDao();
        ArrayList<Usuario> lista = (ArrayList<Usuario>) dao.getAll();
        for(Usuario u : lista){%>
    <tr>
        <td><%=u.getIdUsuario()%></td>
        <td><%=u.getPersona().getNombre()%></td>
        <td><%=u.getContrasena()%></td>
        <td><%=u.getCorreo()%></td>
        <td><%=u.getRol().getTipoRol()%></td>
        <td><%=u.isEstatus()%></td>
        <td><a href="login?id=<%=u.getIdUsuario()%>">Actualizar</a></td>
        <td>
            <form method="post" action="desactivar">
                <input type="hidden" name="id" value="<%=u.getIdUsuario()%>">
                <input type="hidden" name="estado" value="<%=u.isEstatus()%>">
                <input type="submit" value="<%=u.isEstatus() ? "Desactivar" : "Activar"%>">
            </form>
        </td>
    </tr>
    <% } %>
    </tbody>
</table>
<script src="${pageContext.request.contextPath}/JS/bootstrap.js"></script>
<script src="${pageContext.request.contextPath}/JS/jquery-3.7.0.js"></script>
<script src="${pageContext.request.contextPath}/JS/datatables.js"></script>
<script src="${pageContext.request.contextPath}/JS/dataTables.bootstrap5.js"></script>
<script src="${pageContext.request.contextPath}/JS/es-MX.json"></script>
<script>
    document.addEventListener('DOMContentLoaded', () => {
        const table = document.getElementById('example');
        new DataTable(table, {
            language: {
                url: '${pageContext.request.contextPath}/JS/es-MX.json'
            }
        });
    });
</script>
</body>
</html>
