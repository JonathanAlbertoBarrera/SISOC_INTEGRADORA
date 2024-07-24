// Datos de categorías
const categorias = {
    "Bebidas": {
        Img: ["img/coca.jpg", "img/fanta.jpg"],
        Title: ["Coca-Cola 600ml", "Fanta 600ml"],
        Precios: ["20.00", "18.00"],
        Descripciones: ["Refresco Coca Cola sabor original 600 ml", "Refresco Fanta sabor naranja 600 ml"]
    },
    "Galletas": {
        Img: ["img/emperador.jpg", "img/chokis.jpg"],
        Title: ["Emperador 91 g", "Chokis 76 g"],
        Precios: ["22.00", "22.00"],
        Descripciones: ["Galletas emperador sabor chocolate 91 g", "Galletas chokis con chispas de chocolate 76 g"]
    },
    "Botanas": {
        Img: ["img/doritos.png",],
        Title: ["Doritos xtra flamin’ hot",],
        Precios: ["18.00",],
        Descripciones: ["Botana Doritos xtra flamin’ hot 61 g",]
    }
};

// Datos de productos más vendidos
const masVendidos = {
    Img: [
        "img/coca.jpg",
        "img/doritos.png",
        "img/chilaquilesVerdes.png",
        "img/tortaJamon.jpg"
    ],
    Title: [
        "Coca-Cola 600ml",
        "Doritos xtra flamin’ hot",
        "Chilaquiles",
        "Torta de jamón"
    ],
    Precios: [
        "20.00",
        "18.00",
        "45.00",
        "45.00"
    ],
    Descripciones: [
        "Refresco Coca Cola sabor original 600 ml",
        "Botana Doritos xtra flamin’ hot 61 g",
        "Chilaquiles verdes con pollo",
        "Torta de jamón con lechuga y jitomate"
    ]
};

// Datos de marcas
const marcas = {
    "Gamesa": {
        Img: ["img/emperador.jpg", "img/chokis.jpg"],
        Title: ["Emperador 91 g", "Chokis 76 g"],
        Precios: ["22.00", "22.00"],
        Descripciones: ["Galletas emperador sabor chocolate 91 g", "Galletas chokis con chispas de chocolate 76 g"]
    },
    "Coca-cola": {
        Img: ["img/coca.jpg", "img/fanta.jpg"],
        Title: ["Coca-Cola 600ml", "Fanta 600ml"],
        Precios: ["20.00", "18.00"],
        Descripciones: ["Refresco Coca Cola sabor original 600 ml", "Refresco Fanta sabor naranja 600 ml"]
    },
    "Doritos": {
        Img: ["img/doritos.png", ],
        Title: ["Doritos xtra flamin’ hot", ],
        Precios: ["20.00", ],
        Descripciones: ["Botana Doritos xtra flamin’ hot 61 g",]
    }
};

// Objeto para almacenar el estado de las cantidades
let estadoCantidades = {};

// Función para mostrar los productos
function mostrarProductos(imgArray, titleArray, priceArray, descArray, esSeleccionados = false) {
    const container = document.getElementById("product-cards-container");
    container.innerHTML = ''; // Limpiar el contenedor antes de añadir las tarjetas

    let formHTML = esSeleccionados ? '<form method="GET" class="d-flex flex-wrap container" action="carrito.html">' : '';

    imgArray.forEach((url, index) => {
        const title = titleArray[index];
        const price = priceArray[index];
        const desc = descArray[index];
        const cantidad = estadoCantidades[title] || 0;
        const hiddenClass = cantidad > 0 ? '' : 'hidden';
        const disabledAttr = cantidad > 0 ? '' : 'disabled';

        const cardHTML = `
            <div class="col-md-3 mb-2">
                <div class="card h-100">
                    <img src="${url}" class="card-img-top" height="60%" alt="${title}">
                    <div class="card-body">
                        <h3 class="card-title">${title}</h3>
                        <p class="card-text">$${price}</p>
                        <p class="card-text">${desc}</p>
                        <div class="container mt-3">
                            <div class="row justify-content-center">
                                <button class="btn btn-success col-md-3 mb-2 me-2 botonMas">+</button>
                                <input type="number" class="col-md-3 mb-2 me-2 inputCantidad ${hiddenClass}" name="cantidad_${index}" value="${cantidad}" ${disabledAttr}>
                                <button class="btn btn-danger col-md-3 mb-2 botonMenos ${hiddenClass}">-</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Inputs ocultos para enviar el título y el precio -->
                <input type="hidden" name="title_${index}" value="${title}">
                <input type="hidden" name="price_${index}" value="${price}">
            </div>
        `;
        formHTML += cardHTML;
    });

    if (esSeleccionados) {
        formHTML += `
            <div class="col-12 text-center mt-3">
                <button type="submit" class="btn btn-dark botonesApp col-md-4 mx-auto">Enviar al carrito</button>
            </div>
        </form>`;
    }

    container.innerHTML = formHTML;

    // Registrar eventos después de añadir las tarjetas
    document.querySelectorAll('.botonMas').forEach((button, index) => {
        button.addEventListener('click', (event) => {
            event.preventDefault(); // Evitar que el formulario se envíe
            const inputCantidad = document.querySelectorAll('.inputCantidad')[index];
            const botonMenos = document.querySelectorAll('.botonMenos')[index];
            const title = document.querySelectorAll('.card-title')[index].textContent;
    
            inputCantidad.classList.remove('hidden');
            botonMenos.classList.remove('hidden');
            inputCantidad.value = parseInt(inputCantidad.value) + 1;
            inputCantidad.disabled = false;
            estadoCantidades[title] = parseInt(inputCantidad.value);
            actualizarBotones(inputCantidad, botonMenos);
        });
    });
    
    document.querySelectorAll('.botonMenos').forEach((button, index) => {
        button.addEventListener('click', (event) => {
            event.preventDefault(); // Evitar que el formulario se envíe
            const inputCantidad = document.querySelectorAll('.inputCantidad')[index];
            const title = document.querySelectorAll('.card-title')[index].textContent;
    
            inputCantidad.value = parseInt(inputCantidad.value) - 1;
            estadoCantidades[title] = parseInt(inputCantidad.value);
            actualizarBotones(inputCantidad, button);
        });
    });
    

    function actualizarBotones(inputCantidad, botonMenos) {
        if (parseInt(inputCantidad.value) <= 0) {
            inputCantidad.classList.add('hidden');
            botonMenos.classList.add('hidden');
            inputCantidad.value = 0;
            inputCantidad.disabled = true;
        } else {
            inputCantidad.classList.remove('hidden');
            botonMenos.classList.remove('hidden');
        }
    }
}

// Al cargar la página, en automático se muestran los más vendidos
window.addEventListener("load", () => {
    mostrarProductos(masVendidos.Img, masVendidos.Title, masVendidos.Precios, masVendidos.Descripciones);
});

const titulo = document.getElementById("titSeccion");
function regresarMasVendidos(){
    titulo.innerText="Productos Más Vendidos";
    mostrarProductos(masVendidos.Img, masVendidos.Title, masVendidos.Precios, masVendidos.Descripciones);
}

// Mostrar por CATEGORIAS
const categorySelect = document.getElementById("SelectCategoria");

categorySelect.addEventListener("change", (event) => {//cuando select Categorias cambia, se muestra la categoria correspondiente
    const selectedCategory = event.target.value;

    const categoriaSeleccionada = categorias[selectedCategory];
    titulo.innerHTML = `Categoría de ${selectedCategory}`;

    if (categoriaSeleccionada) {
        mostrarProductos(categoriaSeleccionada.Img, categoriaSeleccionada.Title, categoriaSeleccionada.Precios, categoriaSeleccionada.Descripciones);
    }
});

//Mostrar por MARCAS
const categorySelectMarca = document.getElementById("SelectMarca");

categorySelectMarca.addEventListener("change", (event) => {
    const selectedCategory = event.target.value;

    const marcaSeleccionada = marcas[selectedCategory];
    titulo.innerHTML = `Productos de marca ${selectedCategory}`;

    if (marcaSeleccionada) {
        mostrarProductos(marcaSeleccionada.Img, marcaSeleccionada.Title, marcaSeleccionada.Precios, marcaSeleccionada.Descripciones);
    }
});

// Función para mostrar solo los productos seleccionados
function mostrarSeleccionados() {
    const seleccionados = {
        Img: [],
        Title: [],
        Precios: [],
        Descripciones: []
    };

    for (let titulo in estadoCantidades) {
        if (estadoCantidades[titulo] > 0) {
            let index = masVendidos.Title.indexOf(titulo);
            if (index !== -1) {
                seleccionados.Img.push(masVendidos.Img[index]);
                seleccionados.Title.push(masVendidos.Title[index]);
                seleccionados.Precios.push(masVendidos.Precios[index]);
                seleccionados.Descripciones.push(masVendidos.Descripciones[index]);
            } else {
                for (let cat in categorias) {
                    index = categorias[cat].Title.indexOf(titulo);
                    if (index !== -1) {
                        seleccionados.Img.push(categorias[cat].Img[index]);
                        seleccionados.Title.push(categorias[cat].Title[index]);
                        seleccionados.Precios.push(categorias[cat].Precios[index]);
                        seleccionados.Descripciones.push(categorias[cat].Descripciones[index]);
                        break;
                    }
                }
            }
        }
    }

    mostrarProductos(seleccionados.Img, seleccionados.Title, seleccionados.Precios, seleccionados.Descripciones, true);
    document.getElementById("titSeccion").textContent = "Productos Seleccionados";
}
