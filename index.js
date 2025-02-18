const express = require("express")
const app = express()
const cors = require('cors');
const inventoryRoutes = require("./routes/inventory.js")
const supplyRoutes = require('./routes/supply.js')
const providersRoutes = require('./routes/providers.js')

// Middleware para parsear JSON
app.use(express.json());
app.use(express.urlencoded({ extended: true })); // Para datos de formulario


// Configurar CORS para permitir peticiones desde el frontend
app.use(cors({
    origin: 'http://192.168.1.200:5173', // Reemplaza con la IP de tu frontend
    methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'], // Métodos permitidos
    allowedHeaders: ['Content-Type', 'Authorization'], // Encabezados permitidos
    credentials: true // Si necesitas enviar cookies o credenciales
}));

app.use("/api/inventory", inventoryRoutes)
app.use("/api/supply", supplyRoutes)
app.use("/api/provider", providersRoutes)

const PORT = 3000
app.listen(PORT, '0.0.0.0', () =>{
    console.log(`Servidor en el puerto ${PORT}`)
})