<%@ page import="mx.edu.utez.practica3e.dao.MarcaDao" %>
<%@ page import="mx.edu.utez.practica3e.model.Marca" %>
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


    </style>

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

    <!-- TABLA TODOS LAS MARCAS -->
    <div class="table-responsive" id="tablaMarcas">
        <h3>Marcas</h3>
        <img src="img/iconoMarcas.png" width="5%" height="5%">
        <!--BOTON NUEVA MARCA -->
        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modalNuevaMarca">
            Agregar una nueva Marca
        </button>

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
                                            <input type="text" class="form-control"  name="nombre" required>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label>Descripción:</label>
                                            <textarea name="descripcion" required></textarea>
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

        <!--TABLA DE MARCAS -->
        <table id="example3" class="table table-striped table-hover" style="width: 100%">
            <thead>
            <tr>
                <th>ID marca</th>
                <th>Nombre</th>
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
                    <img src="img/iconoModificar.png" width="8%" height="8%">
                    <button type="button" class="btn btn-dark botonesApp" data-bs-toggle="modal" data-bs-target="#modalModiMarca-<%= m.getId_marca() %>">
                        Actualizar marca
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
                                                        <input type="text" class="form-control" id="nombre" name="nombre" value="<%= m.getNombre() %>" required>
                                                    </div>
                                                    <div class="form-group mb-3">
                                                        <label>Descripción:</label>
                                                        <textarea name="descripcion" required><%= m.getDescripcion() %></textarea>
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
                    <img src="img/iconoCambiarEstatus.png" width="10%" height="10%">
                    <button type="button" class="btn btn-dark botonesApp" data-bs-toggle="modal" data-bs-target="#modalDesac-<%= m.getId_marca() %>">
                        <%= m.isEstatus() ? "Desactivar" : "Activar" %>
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
<script src="js/bootstrap.js"></script>
<%
    sesion1.removeAttribute("mensaje2A");
%>
</body>
</html>