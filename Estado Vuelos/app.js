// Simulamos los datos que habrías traído de tu base de datos (tabla locations)
const locationsDB = [
    { id: 1, iata_code: 'BCN', name: 'El Prat', city: 'Barcelona' },
    { id: 2, iata_code: 'MAD', name: 'Barajas', city: 'Madrid' },
    { id: 3, iata_code: 'TFN', name: 'Tenerife Norte', city: 'Tenerife' },
    { id: 4, iata_code: 'LPA', name: 'Gran Canaria', city: 'Las Palmas' },
    { id: 5, iata_code: 'CDG', name: 'Charles de Gaulle', city: 'París' }
];

const inputOrigen = document.getElementById('origen_input');
const hiddenOrigenId = document.getElementById('origen_id');
const resultsList = document.getElementById('origen_results');

// Escuchamos cada vez que el usuario escribe en el input
inputOrigen.addEventListener('input', function() {
    const query = this.value.toLowerCase().trim();
    resultsList.innerHTML = ''; // Limpiamos resultados previos

    // Empezamos a buscar solo si hay al menos 2 caracteres
    if (query.length < 2) {
        resultsList.style.display = 'none';
        return; 
    }

    // Filtramos el array buscando coincidencias en ciudad, código o nombre
    const filteredLocations = locationsDB.filter(loc => 
        loc.city.toLowerCase().includes(query) || 
        loc.iata_code.toLowerCase().includes(query) ||
        loc.name.toLowerCase().includes(query)
    );

    // Si hay resultados, los mostramos
    if (filteredLocations.length > 0) {
        filteredLocations.forEach(loc => {
            const li = document.createElement('li');
            li.textContent = `${loc.city} (${loc.iata_code}) - ${loc.name}`;
            
            // Evento al hacer clic en una sugerencia
            li.addEventListener('click', function() {
                // Llenamos el input visible con texto amigable
                inputOrigen.value = `${loc.city} (${loc.iata_code})`;
                // Guardamos el ID en el input oculto para el formulario
                hiddenOrigenId.value = loc.id; 
                // Ocultamos la lista
                resultsList.style.display = 'none';
            });

            resultsList.appendChild(li);
        });
        resultsList.style.display = 'block';
    } else {
        resultsList.style.display = 'none';
    }
});

// Ocultar la lista si el usuario hace clic en cualquier otra parte de la pantalla
document.addEventListener('click', function(event) {
    if (event.target !== inputOrigen) {
        resultsList.style.display = 'none';
    }
});