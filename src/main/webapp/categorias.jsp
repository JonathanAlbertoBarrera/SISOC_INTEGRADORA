<%@ page import="mx.edu.utez.practica3e.dao.CategoriaDao" %>
<%@ page import="mx.edu.utez.practica3e.model.Categoria" %>
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
    <h3>Categorias</h3>
    <img src="img/iconoCategoria.png" width="5%" height="5%">
    <!--BOTON NUEVA MARCA -->
    <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modalNuevaCategoria">
        Agregar una nueva Categoria
    </button>

    <c:if test="${not empty sessionScope.mensaje2C}">
        <div class="alert alert-success">
                ${sessionScope.mensaje2C}
        </div>
    </c:if>

    <!-- TABLA TODAS LAS CATEGORIAS -->
    <div class="table-responsive" id="tablaCategorias">

        <!-- Modal PARA AGREGAR MARCA-->
        <div class="modal fade" id="modalNuevaCategoria" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="desacModalLabel">Agregar una Categoria</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form method="post" action="addCategoria">
                            <div class="container">
                                <div class="row justify-content-center">
                                    <div class="col-md-6">
                                        <h2 class="text-center mt-5">Agregar Categoria</h2>
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

        <!--TABLA DE CATEGORIAS -->
        <table id="example3" class="table table-striped table-hover" style="width: 100%">
            <thead>
            <tr>
                <th>ID categoria</th>
                <th>Nombre</th>
                <th>Descripción</th>
                <th>Estatus</th>
                <th>Actualizar</th>
                <th>Cambiar estatus</th>
            </tr>
            </thead>
            <tbody>
            <%
                CategoriaDao dao = new CategoriaDao();
                ArrayList<Categoria> lista = (ArrayList<Categoria>) dao.getAll();
                for(Categoria c : lista) {
            %>
            <tr>
                <td><%= c.getId_categoria() %></td>
                <td><%= c.getNombre() %></td>
                <td><%= c.getDescripcion() %></td>
                <td><%= c.isEstatus() ? "Activo" : "Inactivo" %></td>
                <!-- td para modificar categoria-->
                <td>
                    <button type="button" class="btn" data-bs-toggle="modal" data-bs-target="#modalModiMarca-<%= c.getId_categoria() %>">
                        <img src="img/boton-editar.png" alt="Actualizar" style="height: 25%; width: 25%;">
                    </button>
                    <!-- Modal PARA MODIFICAR CATEGORIA-->
                    <div class="modal fade" id="modalModiMarca-<%= c.getId_categoria() %>" tabindex="-1" aria-labelledby="exampleModalLabel-<%= c.getId_categoria() %>" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="modiModalLabel-<%= c.getId_categoria() %>">Actualizar Categoria</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <form method="post" action="modiCategoria">
                                        <div class="container">
                                            <div class="row justify-content-center">
                                                <div class="col-md-6">
                                                    <h2 class="text-center mt-5">Modificar Categoria </h2>
                                                    <div class="form-group mb-3">
                                                        <label for="nombre">Nombre:</label>
                                                        <input type="text" class="form-control" id="nombre" name="nombre" value="<%= c.getNombre() %>" required maxlength="50">
                                                    </div>
                                                    <div class="form-group mb-3">
                                                        <label>Descripción:</label>
                                                        <textarea name="descripcion" required maxlength="100"><%= c.getDescripcion() %></textarea>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                                            <input type="hidden" name="id_categoria" value="<%= c.getId_categoria() %>">
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
                    <button type="button" class="btn" data-bs-toggle="modal" data-bs-target="#modalDesac-<%= c.getId_categoria() %>">
                        <% if (c.isEstatus()) { %>
                        <img src="img/activobtn.png" alt="Desactivar" width="50%" height="30%">
                        <% } else { %>
                        <img src="img/inactivobtn.png" alt="Activar" width="50%" height="30%">
                        <% } %>
                    </button>
                    <!-- Modal -->
                    <div class="modal fade" id="modalDesac-<%= c.getId_categoria() %>" tabindex="-1" aria-labelledby="exampleModalLabel-<%= c.getId_categoria() %>" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="desacModalLabel-<%= c.getId_categoria() %>">Confirmar cambio de estatus</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    ¿Estás seguro de que deseas <%= c.isEstatus() ? "DESACTIVAR" : "ACTIVAR" %> a la marca
                                    <%= c.getNombre() %>?
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                                    <form method="post" action="desactivarCategoria">
                                        <input type="hidden" name="id_categoria" value="<%= c.getId_categoria() %>">
                                        <input type="hidden" name="estatus" value="<%= c.isEstatus() %>">
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
    session.removeAttribute("mensaje2C");
%>
</body>
</html>
