<%@ page import="mx.edu.utez.practica3e.dao.CategoriaDao" %>
<%@ page import="mx.edu.utez.practica3e.model.Categoria" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="mx.edu.utez.practica3e.dao.ProductoDao" %>
<%@ page import="mx.edu.utez.practica3e.model.Producto" %>
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

         #vistaAddProducto {
            display: none;
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

    <div class="table-responsive" id="tablaCategorias">
        <h3>Productos</h3>
        <img src="img/iconoProductos.png" width="5%" height="5%">

        <!--CARDS DE OPCIONES -->
        <div class="text-center mt-3 card-group" id="opcProducto">
            <div class="card ms-3 me-3" id="add" style="width: 18rem; border: 3px solid #F4AB2C; border-radius: 15px;">
                <div class="d-flex justify-content-center align-items-center" style="height: 150px;">
                    <img src="img/add.gif" class="card-img-top" alt="gif icono agregar" style="width: 10%; height: auto;">
                    <img src="img/addProducto.gif" class="card-img-top" alt="gif creando producto" style="width: 20%; height: auto;">
                </div>
                <div class="card-body">
                    <p class="card-text">Agregar un nuevo producto.</p>
                    <button class="btn btn-dark botonesApp" id="agregarPro" onclick="mostrarAdd()">Agregar Producto</button>
                </div>
            </div>
            <div class="card ms-3 me-3" id="crud" style="width: 18rem; border: 3px solid #F4AB2C; border-radius: 15px;">
                <div class="d-flex justify-content-center align-items-center" style="height: 150px;">
                    <img src="img/search2.gif" class="card-img-top" alt="..." style="width: 15%; height: auto;">
                    <img src="img/search3.gif" class="card-img-top" alt="..." style="width: 20%; height: auto;">
                </div>
                <div class="card-body">
                    <p class="card-text">Ver productos existentes, modificar sus datos o desactivarlos.</p>
                    <button class="btn btn-dark botonesApp" id="crudPro" onclick="mostrarCrud()">Ir a productos registrados   </button>
                </div>
            </div>
        </div>

        <%
            HttpSession sesion1 = request.getSession();
            String mensaje2 = (String) sesion1.getAttribute("mensaje2");

            if(mensaje2 != null){ %>
        <p class="text-danger"><%=mensaje2%></p>
        <% } %>

        <%
            sesion1.removeAttribute("mensaje2");
        %>

        <!--VISTA PARA AGREGAR PRODUCTO -->
        <div id="vistaAddProducto">
            <br>
            <h3>Agregar un nuevo Producto</h3>

            <!--FORMULARIO AGREGAR PRODUCTO -->
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-6 bg-dark text-white p-4 rounded-circle">
                        <form method="post" action="addProducto"  enctype="multipart/form-data" class="mt-4">
                            <div class="form-group mb-3">
                                <label for="sku">SKU (ID) producto:</label>
                                <input type="text" class="form-control bg-dark text-white" id="sku" name="sku" required>
                            </div>
                            <div class="form-group mb-3">
                                <label for="nombre">Nombre del producto:</label>
                                <input type="text" class="form-control bg-dark text-white" id="nombre" name="nombre" required>
                            </div>
                            <div class="form-group mb-3">
                                <label for="imagen_producto">Subir imagen del producto:</label>
                                <input type="file" class="form-control bg-dark text-white" id="imagen_producto" name="imagen_producto"  required>
                            </div>
                            <div class="form-group mb-3">
                                <label>Categoría:</label>
                                <br>
                                <select name="categorias" id="categorias" class="form-select bg-dark text-white"  required>
                                    <option value="" selected disabled>Selecciona una categoría</option>
                                    <c:forEach items="${categorias}" var="c">
                                        <option value="${c.id_categoria}">${c.nombre}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group mb-3">
                                <label>Marca:</label>
                                <br>
                                <select name="marcas" id="marcas" class="form-select bg-dark text-white" required>
                                    <option value="" selected disabled>Selecciona una marca</option>
                                    <c:forEach items="${marcas}" var="m">
                                        <option value="${m.id_marca}" >${m.nombre}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group mb-3">
                                <label for="descripcion">Descripción:</label>
                                <input type="text" class="form-control bg-dark text-white" id="descripcion" name="descripcion" required>
                            </div>
                            <div class="form-group mb-3">
                                <label for="precio">Precio del producto:</label>
                                <input type="number" class="form-control bg-dark text-white" id="precio" name="precio" step="0.01" min="1" required>
                            </div>
                            <div class="form-group mb-3">
                                <label for="cantidad">Cantidad inicial de existencias del producto:</label>
                                <input type="number" class="form-control bg-dark text-white" id="cantidad" name="cantidad" min="1" required>
                            </div>

                            <div class="text-center">
                                <button type="submit" class="btn btn-dark botonesApp btn-block">Registrar Producto</button>
                            </div>

                        </form>
                    </div>
                </div>
            </div>


        </div>

        <!--VISTA PARA CRUD CON DATATABLE -->
        <div id="vistaCrudProducto">
            <br>
            <h3>Productos en existencia</h3>
            <%
                HttpSession sesion = request.getSession();
                String mensaje2A = (String) sesion.getAttribute("mensaje2A");

                if(mensaje2A != null){ %>
            <p class="text-danger"><%=mensaje2A%></p>
            <% } %>

            <!-- TABLA DE PRODUCTOS -->
            <table id="example3" class="table table-striped table-hover" style="width: 100%">
                <thead>
                <tr>
                    <th>Imagen</th>
                    <th>SKU</th>
                    <th>Nombre Producto</th>
                    <th>Descripción</th>
                    <th>Precio</th>
                    <th>Cantidad</th>
                    <th>Estatus</th>
                    <th>Modificar</th>
                    <th>Cambiar estatus</th>
                </tr>
                </thead>
                <tbody>
                <%
                    ProductoDao dao = new ProductoDao();
                    ArrayList<Producto> lista = (ArrayList<Producto>) dao.getAll();
                    for (Producto p : lista) {
                %>
                <tr>
                    <td><img src="<%= request.getContextPath() %>/image?sku=<%= p.getSku() %>" alt="imagen del producto" width="100%"></td>
                    <td><%= p.getSku() %></td>
                    <td><%= p.getNombre() %></td>
                    <td><%= p.getDescripcion() %></td>
                    <td><%= p.getPrecio() %></td>
                    <td><%= p.getCantidad() %></td>
                    <td><%= p.isEstatus() ? "Activo" : "Inactivo" %></td>
                    <!-- td para modificar PRODUCTO-->
                    <td>
                        <img src="img/iconoModificar.png" width="14%" height="14%">
                        <button type="button" class="btn btn-dark botonesApp" data-bs-toggle="modal" data-bs-target="#modalModiProducto-<%= p.getSku() %>">
                            Actualizar Producto
                        </button>

                        <!-- Modal PARA MODIFICAR PRODUCTO-->
                        <div class="modal fade" id="modalModiProducto-<%= p.getSku() %>" tabindex="-1" aria-labelledby="exampleModalLabel-<%= p.getSku() %>" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h1 class="modal-title fs-5" id="modiModalLabel-<%= p.getSku() %>">Actualizar Producto</h1>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <form method="post" action="modiProducto" enctype="multipart/form-data">
                                            <div class="container">
                                                <div class="row justify-content-center">
                                                    <div class="col-md-6">
                                                        <h2 class="text-center mt-5">Modificar Producto</h2>

                                                        <div class="form-group mb-3">
                                                            <label for="nombre">Nombre del producto:</label>
                                                            <input type="text" class="form-control bg-dark text-white" id="nombre2" name="nombre2" value="<%= p.getNombre() %>" required>
                                                        </div>
                                                        <div class="form-group mb-3">
                                                            <label for="imagen_actual">Imagen actual:</label>
                                                            <img src="<%= request.getContextPath() %>/image?sku=<%= p.getSku() %>" alt="imagen del producto" class="img-thumbnail" id="imagen_actual">
                                                            <label for="imagen_producto2">Cambiar imagen del producto:</label>
                                                            <input type="file" class="form-control bg-dark text-white" id="imagen_producto2" name="imagen_producto2">
                                                        </div>
                                                        <div class="form-group mb-3">
                                                            <label>Categoría:</label>
                                                            <select name="categorias2" id="categorias2-<%= p.getSku() %>" class="form-select bg-dark text-white" required>
                                                                <option value="" selected disabled>Selecciona una categoría</option>
                                                                <c:forEach items="${categorias}" var="c">
                                                                    <option value="${c.id_categoria}">${c.nombre}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                        <div class="form-group mb-3">
                                                            <label>Marca:</label>
                                                            <select name="marcas2" id="marcas2-<%= p.getSku() %>" class="form-select bg-dark text-white" required>
                                                                <option value="" selected disabled>Selecciona una marca</option>
                                                                <c:forEach items="${marcas}" var="m">
                                                                    <option value="${m.id_marca}">${m.nombre}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                        <div class="form-group mb-3">
                                                            <label for="descripcion">Descripción:</label>
                                                            <input type="text" class="form-control bg-dark text-white" id="descripcion2" name="descripcion2" value="<%= p.getDescripcion() %>" required>
                                                        </div>
                                                        <div class="form-group mb-3">
                                                            <label for="precio">Precio del producto:</label>
                                                            <input type="number" class="form-control bg-dark text-white" id="precio2" name="precio2" step="0.01" min="1" value="<%= p.getPrecio() %>" required>
                                                        </div>
                                                        <div class="form-group mb-3">
                                                            <label for="cantidad">Cantidad inicial de existencias del producto:</label>
                                                            <input type="number" class="form-control bg-dark text-white" id="cantidad2" min="1" name="cantidad2" value="<%= p.getCantidad() %>" required>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                                                <input type="hidden" name="sku" value="<%= p.getSku() %>">
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
                        <button type="button" class="btn btn-dark botonesApp" data-bs-toggle="modal" data-bs-target="#modalDesac-<%= p.getSku() %>">
                            <%= p.isEstatus() ? "Desactivar" : "Activar" %>
                        </button>
                        <!-- Modal -->
                        <div class="modal fade" id="modalDesac-<%= p.getSku() %>" tabindex="-1" aria-labelledby="exampleModalLabel-<%= p.getSku() %>" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h1 class="modal-title fs-5" id="desacModalLabel-<%= p.getSku() %>">Confirmar cambio de estatus</h1>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        ¿Estás seguro de que deseas <%= p.isEstatus() ? "DESACTIVAR" : "ACTIVAR" %> al producto <%= p.getNombre() %>?
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                                        <form method="post" action="desactivarProducto">
                                            <input type="hidden" name="sku" value="<%= p.getSku() %>">
                                            <input type="hidden" name="estatus" value="<%= p.isEstatus() %>">
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

    </div>

</main>

<!-- JavaScript para poner las opciones seleccionadas  en los selects de modal de modificar -->
<script>
    document.addEventListener("DOMContentLoaded", function() {
        <% for (Producto p : lista) { %>
        document.getElementById("categorias2-<%= p.getSku() %>").value = "<%= p.getCategoria().getId_categoria() %>";
        document.getElementById("marcas2-<%= p.getSku() %>").value = "<%= p.getMarca().getId_marca() %>";
        <% } %>
    });
</script>

<script>
    function mostrarAdd(){
        document.getElementById('vistaCrudProducto').style.display="none";
        document.getElementById('vistaAddProducto').style.display="block";
    }

    function mostrarCrud(){
        document.getElementById('vistaAddProducto').style.display="none";
        document.getElementById('vistaCrudProducto').style.display="block";
    }
</script>

<script src="${pageContext.request.contextPath}/JS/bootstrap.js"></script>
<script src="${pageContext.request.contextPath}/JS/jquery-3.7.0.js"></script>
<script src="${pageContext.request.contextPath}/JS/datatables.js"></script>
<script src="${pageContext.request.contextPath}/JS/dataTables.bootstrap5.js"></script>
<script src="${pageContext.request.contextPath}/JS/es-MX.json"></script>
<script>
    document.addEventListener('DOMContentLoaded', () => {
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
<%
    sesion.removeAttribute("mensaje2A");
%>

</body>
</html>
