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
            background-color: #000000;
        }

        .barra a{
            color:#ffffff;
        }

        .barra a:hover{
            color:#F4AB2C;
        }

        .barra a:focus{
            color:#F4AB2C;
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
            <a class="navbar-brand" href="#">Cafetería (ADMIN)</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                <div class="navbar-nav mx-auto">
                    <a class="nav-link" aria-current="page"  href="indexAdmin.jsp">Inicio</a>
                    <a class="nav-link" href="marcas.jsp">
                        <img src="img/iconoMarcas.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Marcas
                    </a>
                    <a class="nav-link" href="categorias.jsp">
                        <img src="img/iconoCategoria.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Categorias
                    </a>
                    <a class="nav-link" href="productosAdmin.jsp">
                        <img src="img/iconoProductos.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Productos
                    </a>
                    <a class="nav-link" href="#">
                        <img src="img/iconoCompras.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Compras
                    </a>
                    <a class="nav-link" href="#">
                        <img src="img/iconoVentas.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Ventas
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
        <img src="img/iconoUsuarios.png" width="5%" height="5%">
        <table id="example3" class="table table-striped table-hover" style="width: 100%">
            <thead>
            <tr>
                <th>ID usuario</th>
                <th>Nombre(s)</th>
                <th>Apellidos</th>
                <th>Correo</th>
                <th>Tipo</th>
                <th>Teléfono</th>
                <th>Estatus</th>
                <th>Cambiar estatus</th>
            </tr>
            </thead>
            <tbody>
            <%
                UsuarioDao dao3 = new UsuarioDao();
                ArrayList<Usuario> lista3 = (ArrayList<Usuario>) dao3.getAllSinAdmin();
                for(Usuario u : lista3) {
            %>
            <tr>
                <td><%= u.getIdUsuario() %></td>
                <td><%= u.getPersona().getNombre() %></td>
                <td><%= u.getPersona().getApellidos() %></td>
                <td><%= u.getCorreo() %></td>
                <td><%= u.getRol().getTipoRol() %></td>
                <td><%= u.getPersona().getTelefono() %></td>
                <td><%= u.isEstatus() ? "Activo" : "Inactivo" %></td>
                <td>
                    <img src="img/iconoCambiarEstatus.png" width="10%" height="10%">
                    <button type="button" class="btn btn-dark botonesApp" data-bs-toggle="modal" data-bs-target="#modalDesac-<%= u.getIdUsuario() %>">
                        <%= u.isEstatus() ? "Desactivar" : "Activar" %>
                    </button>
                    <!-- Modal -->
                    <div class="modal fade" id="modalDesac-<%= u.getIdUsuario() %>" tabindex="-1" aria-labelledby="exampleModalLabel-<%= u.getIdUsuario() %>" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="desacModalLabel-<%= u.getIdUsuario() %>">Confirmar acción</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    ¿Estás seguro de que deseas <%= u.isEstatus() ? "DESACTIVAR" : "ACTIVAR" %> al usuario
                                    <%= u.getPersona().getNombre() %>  <%= u.getPersona().getApellidos() %> con id de usuario
                                    <%= u.getIdUsuario() %>?
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                                    <form method="post" action="desactivar">
                                        <input type="hidden" name="id" value="<%= u.getIdUsuario() %>">
                                        <input type="hidden" name="estado" value="<%= u.isEstatus() %>">
                                        <button type="submit" class="btn btn-primary botonesApp">Confirmar</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
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
        <img src="img/iconoClientes.png" width="5%" height="5%">
        <table id="example2" class="table table-striped table-hover" style="width: 100%">
            <thead>
            <tr>
                <th>ID usuario</th>
                <th>Nombre(s)</th>
                <th>Apellidos</th>
                <th>Correo</th>
                <th>Tipo</th>
                <th>Teléfono</th>
                <th>Estatus</th>
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
                <td><%= u.getPersona().getTelefono() %></td>
                <td><%=u.isEstatus() ? "Activo" : "Inactivo"%></td>
                <td>
                    <img src="img/iconoCambiarEstatus.png" width="20%" height="20%">
                    <button type="button" class="btn btn-dark botonesApp" data-bs-toggle="modal" data-bs-target="#modalDesac2-<%= u.getIdUsuario() %>">
                        <%= u.isEstatus() ? "Desactivar" : "Activar" %>
                    </button>
                    <!-- Modal -->
                    <div class="modal fade" id="modalDesac2-<%= u.getIdUsuario() %>" tabindex="-1" aria-labelledby="exampleModalLabel-<%= u.getIdUsuario() %>" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="desacModalLabel-<%= u.getIdUsuario() %>">Confirmar acción</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    ¿Estás seguro de que deseas <%= u.isEstatus() ? "DESACTIVAR" : "ACTIVAR" %> al usuario
                                    <%= u.getPersona().getNombre() %>  <%= u.getPersona().getApellidos() %> con id de usuario
                                    <%= u.getIdUsuario() %>?
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                                    <form method="post" action="desactivar">
                                        <input type="hidden" name="id" value="<%= u.getIdUsuario() %>">
                                        <input type="hidden" name="estado" value="<%= u.isEstatus() %>">
                                        <button type="submit" class="btn btn-primary botonesApp">Confirmar</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
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
        <img src="img/agregarEncargado.png" width="5%" height="5%">
        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modalNuevoEncargado">
            Agregar un nuevo encargado
        </button>

        <!-- Modal PARA AGREGAR UN ENCARGADO-->
        <div class="modal fade" id="modalNuevoEncargado" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="desacModalLabel">Agregar un usuario de tipo Encargado</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form method="post" action="addEncargado">
                            <div class="container">
                                <div class="row justify-content-center">
                                    <div class="col-md-6">
                                        <h2 class="text-center mt-5">Agregar Encargado</h2>
                                        <h3 class="text-center mt-5">Datos personales</h3>
                                        <div class="form-group mb-3">
                                            <label for="nombre">Nombre(s):</label>
                                            <input type="text" class="form-control"  name="nombre" required>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="apellidos">Apellidos:</label>
                                            <input type="text" class="form-control"  name="apellidos" required>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="telefono">Número de teléfono:</label>
                                            <input type="text" class="form-control" name="telefono" required>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label>Sexo:</label>
                                            <br>
                                            <select name="sexo" class="form-select">
                                                <option selected ></option>
                                                <option value="Hombre">Hombre</option>
                                                <option value="Mujer">Mujer</option>
                                                <option value="NA">Prefiero no especificarlo</option>
                                            </select>
                                        </div>
                                        <h3 class="text-center mt-5">Datos de la cuenta</h3>
                                        <div class="form-group mb-3">
                                            <label for="correo">Correo:</label>
                                            <input type="email" class="form-control"  name="correo" required>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="pass1">Contraseña:</label>
                                            <input type="password" class="form-control" id="pass1" name="pass1" required>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                                <button type="submit" class="btn btn-primary botonesApp">Confirmar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <%
            HttpSession sesion1 = request.getSession();
            String mensaje2A = (String) sesion1.getAttribute("mensaje2A");

            if(mensaje2A != null){ %>
        <p class="text-danger"><%=mensaje2A%></p>
        <% } %>
        <%
            sesion1.removeAttribute("mensaje2A");
        %>

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
                <td>
                    <img src="img/iconoModificar.png" width="20%" height="20%">
                    <button type="button" class="btn btn-dark botonesApp" data-bs-toggle="modal" data-bs-target="#modalModiEncargado-<%= u.getIdUsuario() %>">
                        Actualizar
                    </button>
                    <!-- Modal PARA MODIFICAR ENCARGADO-->
                    <div class="modal fade" id="modalModiEncargado-<%= u.getIdUsuario() %>" tabindex="-1" aria-labelledby="exampleModalLabel-<%= u.getIdUsuario() %>" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="desacModalLabel-<%= u.getIdUsuario() %>">Actualizar Encargado</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <form method="post" action="modiEncargado">
                                        <div class="container">
                                            <div class="row justify-content-center">
                                                <div class="col-md-6">
                                                    <h2 class="text-center mt-5">Modificar Encargado</h2>
                                                    <h3 class="text-center mt-5">Datos personales</h3>
                                                    <div class="form-group mb-3">
                                                        <label for="nombre">Nombre(s):</label>
                                                        <input type="text" class="form-control" id="nombre" name="nombre" value="<%= u.getPersona().getNombre() %>" required>
                                                    </div>
                                                    <div class="form-group mb-3">
                                                        <label for="apellidos">Apellidos:</label>
                                                        <input type="text" class="form-control" id="apellidos" name="apellidos" value="<%= u.getPersona().getApellidos() %>" required>
                                                    </div>
                                                    <div class="form-group mb-3">
                                                        <label for="telefono">Número de teléfono:</label>
                                                        <input type="text" class="form-control" id="telefono" name="telefono"  value="<%= u.getPersona().getTelefono() %>" required>
                                                    </div>
                                                    <div class="form-group mb-3">
                                                        <label>Sexo:</label>
                                                        <br>
                                                        <select name="sexo" class="form-select">
                                                            <option selected value="<%= u.getPersona().getSexo() %>"><%= u.getPersona().getSexo() %></option>
                                                            <option value="Hombre">Hombre</option>
                                                            <option value="Mujer">Mujer</option>
                                                            <option value="NA">Prefiero no especificarlo</option>
                                                        </select>
                                                    </div>
                                                    <h3 class="text-center mt-5">Datos de la cuenta</h3>
                                                    <div class="form-group mb-3">
                                                        <label for="correo">Correo:</label>
                                                        <input type="email" class="form-control" id="correo" name="correo" value="<%= u.getCorreo() %>" required>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                                            <input type="hidden" name="id_usuario" value="<%= u.getIdUsuario() %>">
                                            <button type="submit" class="btn btn-primary botonesApp">Confirmar</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </td>
                <td>
                    <img src="img/iconoCambiarEstatus.png" width="20%" height="20%">
                    <button type="button" class="btn btn-dark botonesApp" data-bs-toggle="modal" data-bs-target="#modalDesac3-<%= u.getIdUsuario() %>">
                        <%= u.isEstatus() ? "Desactivar" : "Activar" %>
                    </button>
                    <!-- Modal PARA ESTATUS -->
                    <div class="modal fade" id="modalDesac3-<%= u.getIdUsuario() %>" tabindex="-1" aria-labelledby="exampleModalLabel-<%= u.getIdUsuario() %>" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="desacModalLabel-<%= u.getIdUsuario() %>">Confirmar cambio de estatus</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    ¿Estás seguro de que deseas <%= u.isEstatus() ? "DESACTIVAR" : "ACTIVAR" %> al usuario
                                    <%= u.getPersona().getNombre() %>  <%= u.getPersona().getApellidos() %> con id de usuario
                                    <%= u.getIdUsuario() %>?
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                                    <form method="post" action="desactivar">
                                        <input type="hidden" name="id" value="<%= u.getIdUsuario() %>">
                                        <input type="hidden" name="estado" value="<%= u.isEstatus() %>">
                                        <button type="submit" class="btn btn-primary botonesApp">Confirmar</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
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
</body>
</html>