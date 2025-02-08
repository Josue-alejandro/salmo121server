const mysql = require('mysql2');

// Crear la conexión a la base de datos
const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root', 
  password: '', 
  database: 'salmo121db', 
});

// Verificar si la conexión es exitosa
connection.connect((err) => {
  if (err) {
    console.error('Error de conexión: ' + err.stack);
    return;
  }
  console.log('Conexión exitosa a la base de datos como id ' + connection.threadId);
});

// Exportar la conexión para usarla en otras partes de la aplicación
module.exports = connection;
