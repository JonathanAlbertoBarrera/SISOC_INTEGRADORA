<%@ page import="mx.edu.utez.practica3e.dao.UsuarioDao" %>
<%@ page import="mx.edu.utez.practica3e.model.Usuario" %>
<%@ page import="java.util.ArrayList" %>
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
            background-color: #F4AB2C;
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

        .botonesApp {
            background-color: #F4AB2C;
            border-color: #F4AB2C;
            margin: 0 10px; /* Añadir margen para asegurar que los botones estén espaciados */
        }

        .botonesApp.activo {
            background-color: black; /* Color de fondo negro para el botón activo */
            color: white; /* Texto blanco para el botón activo */
        }

        #tablaEncargados,
        #tablaClientes{
            display: none; /* Asegurar que todas las tablas estén ocultas inicialmente */
        }

        #tablaAllUsuarios {
            display: block; /* Mostrar la tabla de 'todos los usuarios' por defecto */
        }

    </style>
    <script src="js/mostrarOcultarCosas.js" defer></script>
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
                            <li><a class="dropdown-item" href="solicitudRecuperacion.jsp">Cambiar contraseña</a></li>
                        </ul>
                    </li>
                </div>
            </div>
        </div>
    </nav>
</header>

<main>
    <!-- OPCIONES DE TABLAS -->
    <div class="text-center mt-3 mb-3 text-align-center">
        <button class="btn btn-dark botonesApp activo" id="opcTodosUsuarios" onclick="mostrarTablaAllUsuarios()">Ver todos los usuarios</button>
        <button class="btn btn-dark botonesApp" id="opcEncargados" onclick="mostrarTablaEncargados()">Ver encargados</button>
        <button class="btn btn-dark botonesApp" id="opcClientes" onclick="mostrarTablaClientes()">Ver clientes</button>
    </div>


    <!-- TABLA TODOS LOS USUARIOS -->
    <div class="table-responsive" id="tablaAllUsuarios">
        <h3>Tabla de todos los usuarios</h3>
        <table id="example3" class="table table-striped table-hover" style="width: 100%">
            <thead>
            <tr>
                <th>ID usuario</th>
                <th>Nombre(s)</th>
                <th>Apellidos</th>
                <th>Correo</th>
                <th>Tipo</th>
                <th>Estatus</th>
                <th>Actualizar</th>
                <th>Cambiar estatus</th>
            </tr>
            </thead>
            <tbody>
            <%
                UsuarioDao dao3 = new UsuarioDao();
                ArrayList<Usuario> lista3 = (ArrayList<Usuario>) dao3.getAll();
                for(Usuario u : lista3) {
            %>
            <tr>
                <td><%= u.getIdUsuario() %></td>
                <td><%= u.getPersona().getNombre() %></td>
                <td><%= u.getPersona().getApellidos() %></td>
                <td><%= u.getCorreo() %></td>
                <td><%= u.getRol().getTipoRol() %></td>
                <td><%=u.isEstatus() ? "Activo" : "Inactivo"%></td>
                <td><a href="login?id=<%= u.getIdUsuario() %>">Actualizar</a></td>
                <td>
                    <form method="post" action="desactivar">
                        <input type="hidden" name="id" value="<%= u.getIdUsuario() %>">
                        <input type="hidden" name="estado" value="<%= u.isEstatus() %>">
                        <input type="submit" value="<%= u.isEstatus() ? "Desactivar" : "Activar" %>">
                    </form>
                </td>
                <%
                    HttpSession sesion = request.getSession();
                    String mensaje = (String) sesion.getAttribute("mensaje");
                    if (mensaje != null) {
                %>
                <p style="color: red;"><%= mensaje %></p>
                <%
                        sesion.removeAttribute("mensaje");
                    }
                %>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>

    <!-- TABLA CLIENTES -->
    <div class="table-responsive" id="tablaClientes">
        <h3>Tabla de clientes</h3>
        <table id="example2" class="table table-striped table-hover" style="width: 100%">
            <thead>
            <tr>
                <th>ID usuario</th>
                <th>Nombre(s)</th>
                <th>Apellidos</th>
                <th>Correo</th>
                <th>Tipo</th>
                <th>Estatus</th>
                <th>Actualizar</th>
                <th>Cambiar estatus</th>
            </tr>
            </thead>
            <tbody>
            <%
                UsuarioDao dao2 = new UsuarioDao();
                ArrayList<Usuario> lista2 = (ArrayList<Usuario>) dao2.getAllClientes();
                for(Usuario u : lista2) {
            %>
            <tr>
                <td><%= u.getIdUsuario() %></td>
                <td><%= u.getPersona().getNombre() %></td>
                <td><%= u.getPersona().getApellidos() %></td>
                <td><%= u.getCorreo() %></td>
                <td><%= u.getRol().getTipoRol() %></td>
                <td><%=u.isEstatus() ? "Activo" : "Inactivo"%></td>
                <td><a href="login?id=<%= u.getIdUsuario() %>">Actualizar</a></td>
                <td>
                    <form method="post" action="desactivar">
                        <input type="hidden" name="id" value="<%= u.getIdUsuario() %>">
                        <input type="hidden" name="estado" value="<%= u.isEstatus() %>">
                        <input type="submit" value="<%= u.isEstatus() ? "Desactivar" : "Activar" %>">
                    </form>
                </td>
                <%
                    HttpSession sesion = request.getSession();
                    String mensaje = (String) sesion.getAttribute("mensaje");
                    if (mensaje != null) {
                %>
                <p style="color: red;"><%= mensaje %></p>
                <%
                        sesion.removeAttribute("mensaje");
                    }
                %>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>

    <!-- TABLA ENCARGADOS -->
    <div class="table-responsive" id="tablaEncargados">
        <h3>Tabla de encargados</h3>
        <table id="example" class="table table-striped table-hover" style="width: 100%">
            <thead>
            <tr>
                <th>ID usuario</th>
                <th>Nombre(s)</th>
                <th>Apellidos</th>
                <th>Correo</th>
                <th>Tipo</th>
                <th>Estatus</th>
                <th>Actualizar</th>
                <th>Cambiar estatus</th>
            </tr>
            </thead>
            <tbody>
            <%
                UsuarioDao dao = new UsuarioDao();
                ArrayList<Usuario> lista = (ArrayList<Usuario>) dao.getAllEncargados();
                for(Usuario u : lista) {
            %>
            <tr>
                <td><%= u.getIdUsuario() %></td>
                <td><%= u.getPersona().getNombre() %></td>
                <td><%= u.getPersona().getApellidos() %></td>
                <td><%= u.getCorreo() %></td>
                <td><%= u.getRol().getTipoRol() %></td>
                <td><%=u.isEstatus() ? "Activo" : "Inactivo"%></td>
                <td><a href="login?id=<%= u.getIdUsuario() %>">Actualizar</a></td>
                <td>
                    <form method="post" action="desactivar">
                        <input type="hidden" name="id" value="<%= u.getIdUsuario() %>">
                        <input type="hidden" name="estado" value="<%= u.isEstatus() %>">
                        <input type="submit" value="<%= u.isEstatus() ? "Desactivar" : "Activar" %>">
                    </form>
                </td>
                <%
                    HttpSession sesion = request.getSession();
                    String mensaje = (String) sesion.getAttribute("mensaje");
                    if (mensaje != null) {
                %>
                <p style="color: red;"><%= mensaje %></p>
                <%
                        sesion.removeAttribute("mensaje");
                    }
                %>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</main>

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
        const table2 = document.getElementById('example2');
        new DataTable(table2, {
            language: {
                url: '${pageContext.request.contextPath}/JS/es-MX.json'
            }
        });
        const table3 = document.getElementById('example3');
        new DataTable(table3, {
            language: {
                url: '${pageContext.request.contextPath}/JS/es-MX.json'
            }
        });
    });
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.11.6/umd/popper.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>