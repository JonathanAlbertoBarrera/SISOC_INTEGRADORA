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
