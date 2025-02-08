const express = require("express")
const app = express()
const inventoryRoutes = require("./routes/inventory.js")

// Middleware para parsear JSON
app.use(express.json());
app.use(express.urlencoded({ extended: true })); // Para datos de formulario

// Configurar cabeceras y cors
app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Headers', 'Authorization, X-API-KEY, Origin, X-Requested-With, Content-Type, Accept, Access-Control-Allow-Request-Method');
    res.header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, DELETE');
    res.header('Allow', 'GET, POST, OPTIONS, PUT, DELETE');
    next();
});

app.use("/api/inventory", inventoryRoutes)

const PORT = 3000
app.listen(PORT, () =>{
    console.log(`Servidor en el puerto ${PORT}`)
})