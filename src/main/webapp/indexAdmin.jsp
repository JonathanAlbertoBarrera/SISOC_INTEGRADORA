<%@ page import="mx.edu.utez.practica3e.dao.UsuarioDao" %>
<%@ page import="mx.edu.utez.practica3e.model.Usuario" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        .si{
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
    <script src="JS/mostrarOcultarCosas.js" defer></script>
</head>
<body>
<!-- BARRA NAVEGACION -->
<header>
    <nav class="navbar navbar-expand-lg barra bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand si" href="#">Cafetería (ADMIN)</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse si" id="navbarNavAltMarkup">
                <div class="navbar-nav mx-auto">
                    <a class="nav-link si" aria-current="page"  href="indexAdmin.jsp">Inicio</a>
                    <a class="nav-link si" href="marcas.jsp">
                        <img src="img/iconoMarcas.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Marcas
                    </a>
                    <a class="nav-link si" href="categorias.jsp">
                        <img src="img/iconoCategoria.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Categorias
                    </a>
                    <a class="nav-link si" href="productosAdmin.jsp">
                        <img src="img/iconoProductos.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Productos
                    </a>
                    <a class="nav-link si" href="comprasAdmin.jsp">
                        <img src="img/iconoCompras.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Compras
                    </a>
                    <a class="nav-link si" href="ventasAdmin.jsp">
                        <img src="img/iconoVentas.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> Ventas
                    </a>
                    <li class="nav-item dropdown bg-dark si">
                        <a class="nav-link dropdown-toggle si" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <img src="img/login.png" alt="Logo" width="30" height="24" class="d-inline-block align-text-top"> ${sessionScope.nombre_usuario != null ? sessionScope.nombre_usuario : 'Cuenta'}
                        </a>
                        <ul class="dropdown-menu text-bg-dark si">
                            <li><a class="dropdown-item si" href="${pageContext.request.contextPath}/logout" >Cerrar Sesión</a></li>
                            <li><a class="dropdown-item si" href="solicitudRecuperacion.jsp">Cambiar contraseña</a></li>
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
    <c:if test="${not empty sessionScope.mensaje2A}">
        <div class="alert alert-success">
                ${sessionScope.mensaje2A}
        </div>
    </c:if>

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
                    <button type="button" class="btn" data-bs-toggle="modal" data-bs-target="#modalDesac-<%= u.getIdUsuario() %>">
                        <% if (u.isEstatus()) { %>
                        <img src="img/activobtn.png" alt="Desactivar" width="10%" height="10%">
                        <% } else { %>
                        <img src="img/inactivobtn.png" alt="Activar" width="10%" height="10%">
                        <% } %>
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
                    <button type="button" class="btn" data-bs-toggle="modal" data-bs-target="#modalDesac2-<%= u.getIdUsuario() %>">
                        <% if (u.isEstatus()) { %>
                        <img src="img/activobtn.png" alt="Desactivar" width="50%" height="30%">
                        <% } else { %>
                        <img src="img/inactivobtn.png" alt="Activar" width="50%" height="30%">
                        <% } %>
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
                                            <input type="text" class="form-control"  name="nombre" required maxlength="50">
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="apellidos">Apellidos:</label>
                                            <input type="text" class="form-control"  name="apellidos" required maxlength="50">
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="telefono">Número de teléfono:</label>
                                            <input type="text" class="form-control" name="telefono" required maxlength="15">
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
                                            <input type="email" class="form-control"  name="correo" required maxlength="50">
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="pass1">Contraseña:</label>
                                            <input type="password" class="form-control" id="pass1" name="pass1" required maxlength="64">
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
                    <button type="button" class="btn" data-bs-toggle="modal" data-bs-target="#modalModiEncargado-<%= u.getIdUsuario() %>">
                        <img src="img/boton-editar.png" alt="Actualizar" style="height: 25%; width: 25%;">
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
                                                        <input type="text" class="form-control" id="nombre" name="nombre" value="<%= u.getPersona().getNombre() %>" required maxlength="50">
                                                    </div>
                                                    <div class="form-group mb-3">
                                                        <label for="apellidos">Apellidos:</label>
                                                        <input type="text" class="form-control" id="apellidos" name="apellidos" value="<%= u.getPersona().getApellidos() %>" required maxlength="50">
                                                    </div>
                                                    <div class="form-group mb-3">
                                                        <label for="telefono">Número de teléfono:</label>
                                                        <input type="text" class="form-control" id="telefono" name="telefono"  value="<%= u.getPersona().getTelefono() %>" required maxlength="15">
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
                                                        <input type="email" class="form-control" id="correo" name="correo" value="<%= u.getCorreo() %>" required maxlength="50">
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

                    <button type="button" class="btn" data-bs-toggle="modal" data-bs-target="#modalDesac3-<%= u.getIdUsuario() %>">
                        <% if (u.isEstatus()) { %>
                        <img src="img/activobtn.png" alt="Desactivar" width="50%" height="30%">
                        <% } else { %>
                        <img src="img/inactivobtn.png" alt="Activar" width="50%" height="30%">
                        <% } %>
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
<script src="JS/bootstrap.js"></script>
<script>
    //PARA CRUD DE USUARIOS EN JSP INDEXADMIN
    function mostrarTablaEncargados() {
        document.getElementById('tablaClientes').style.display = "none";
        document.getElementById('tablaAllUsuarios').style.display = "none";
        document.getElementById('tablaEncargados').style.display = "block";
        actualizarBotonActivo('opcEncargados');
    }

    function mostrarTablaClientes() {
        document.getElementById('tablaEncargados').style.display = "none";
        document.getElementById('tablaAllUsuarios').style.display = "none";
        document.getElementById('tablaClientes').style.display = "block";
        actualizarBotonActivo('opcClientes');
    }

    function mostrarTablaAllUsuarios() {
        document.getElementById('tablaEncargados').style.display = "none";
        document.getElementById('tablaClientes').style.display = "none";
        document.getElementById('tablaAllUsuarios').style.display = "block";
        actualizarBotonActivo('opcTodosUsuarios');
    }

    function actualizarBotonActivo(botonId) {
        const botones = document.querySelectorAll('.botonesApp');
        botones.forEach(boton => {
            boton.classList.remove('activo'); // Remover clase 'activo' de todos los botones
        });
        document.getElementById(botonId).classList.add('activo'); // Añadir clase 'activo' al botón correspondiente
    }
</script>
<%
    session.removeAttribute("mensaje2A");
%>
</body>
</html>