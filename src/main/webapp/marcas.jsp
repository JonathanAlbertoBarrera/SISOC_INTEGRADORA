<%@ page import="mx.edu.utez.practica3e.dao.MarcaDao" %>
<%@ page import="mx.edu.utez.practica3e.model.Marca" %>
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


    </style>

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

    <h3>Marcas</h3>
    <img src="img/iconoMarcas.png" width="5%" height="5%">
    <!--BOTON NUEVA MARCA -->
    <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modalNuevaMarca">
        Agregar una nueva Marca
    </button>
    <!-- TABLA TODOS LAS MARCAS -->
    <div class="table-responsive container" id="tablaMarcas">

        <!-- Modal PARA AGREGAR MARCA-->
        <div class="modal fade" id="modalNuevaMarca" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="desacModalLabel">Agregar una Marca</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form method="post" action="addMarca">
                            <div class="container">
                                <div class="row justify-content-center">
                                    <div class="col-md-6">
                                        <h2 class="text-center mt-5">Agregar Marca</h2>
                                        <div class="form-group mb-3">
                                            <label for="nombre">Nombre:</label>
                                            <input type="text" class="form-control"  name="nombre" required maxlength="50">
                                        </div>
                                        <div class="form-group mb-3">
                                            <label>Descripción:</label>
                                            <textarea name="descripcion" required maxlength="100"></textarea>
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

        <c:if test="${not empty sessionScope.mensaje2A}">
            <div class="alert alert-success">
                    ${sessionScope.mensaje2A}
            </div>
        </c:if>


        <!--TABLA DE MARCAS -->
        <table id="example3" class="table table-striped table-hover container" style="width: 100%">
            <thead>
            <tr>
                <th>ID marca</th>
                <th >Nombre</th>
                <th>Descripción</th>
                <th>Estatus</th>
                <th>Actualizar</th>
                <th>Cambiar estatus</th>
            </tr>
            </thead>
            <tbody>
            <%
                MarcaDao dao = new MarcaDao();
                ArrayList<Marca> lista = (ArrayList<Marca>) dao.getAll();
                for(Marca m : lista) {
            %>
            <tr>
                <td><%= m.getId_marca() %></td>
                <td><%= m.getNombre() %></td>
                <td><%= m.getDescripcion() %></td>
                <td><%= m.isEstatus() ? "Activo" : "Inactivo" %></td>
                <!-- td para modificar marca-->
                <td>
                    <button type="button" class="btn" data-bs-toggle="modal" data-bs-target="#modalModiMarca-<%= m.getId_marca() %>">
                        <img src="img/boton-editar.png" alt="Actualizar" style="width: 25%; height: 25%;">
                    </button>
                    <!-- Modal PARA MODIFICAR ENCARGADO-->
                    <div class="modal fade" id="modalModiMarca-<%= m.getId_marca() %>" tabindex="-1" aria-labelledby="exampleModalLabel-<%= m.getId_marca() %>" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="modiModalLabel-<%= m.getId_marca() %>">Actualizar Marca</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <form method="post" action="modiMarca">
                                        <div class="container">
                                            <div class="row justify-content-center">
                                                <div class="col-md-6">
                                                    <h2 class="text-center mt-5">Modificar Marca</h2>
                                                    <div class="form-group mb-3">
                                                        <label for="nombre">Nombre:</label>
                                                        <input type="text" class="form-control" id="nombre" name="nombre" value="<%= m.getNombre() %>" required maxlength="50">
                                                    </div>
                                                    <div class="form-group mb-3">
                                                        <label>Descripción:</label>
                                                        <textarea name="descripcion" required maxlength="100"><%= m.getDescripcion() %></textarea>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                                            <input type="hidden" name="id_marca" value="<%= m.getId_marca() %>">
                                            <button type="submit" class="btn btn-primary botonesApp">Confirmar</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </td>
                <!-- td para cambiar estatus-->
                <td>
                    <button type="button" class="btn" data-bs-toggle="modal" data-bs-target="#modalDesac-<%= m.getId_marca() %>">
                        <% if (m.isEstatus()) { %>
                        <img src="img/activobtn.png" alt="Desactivar" width="50%" height="30%">
                        <% } else { %>
                        <img src="img/inactivobtn.png" alt="Activar" width="50%" height="30%">
                        <% } %>
                    </button>
                    <!-- Modal -->
                    <div class="modal fade" id="modalDesac-<%= m.getId_marca() %>" tabindex="-1" aria-labelledby="exampleModalLabel-<%= m.getId_marca() %>" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="desacModalLabel-<%= m.getId_marca() %>">Confirmar cambio de estatus</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    ¿Estás seguro de que deseas <%= m.isEstatus() ? "DESACTIVAR" : "ACTIVAR" %> a la marca
                                    <%= m.getNombre() %>?
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                                    <form method="post" action="desactivarMarca">
                                        <input type="hidden" name="id_marca" value="<%= m.getId_marca() %>">
                                        <input type="hidden" name="estatus" value="<%= m.isEstatus() %>">
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
        const table3 = document.getElementById('example3');
        new DataTable(table3, {
            language: {
                url: '${pageContext.request.contextPath}/JS/es-MX.json'
            }
    });
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.11.6/umd/popper.min.js"></script>
<script src="JS/bootstrap.js"></script>
<%
    session.removeAttribute("mensaje2A");
%>
</body>
</html>