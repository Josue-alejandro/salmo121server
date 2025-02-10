const express = require('express');
const router = express.Router();
const db = require('../db.js');
const { sortByName } = require('../js/functions.js')

// Obtener productos con paginación
router.get('/products', (req, res) => {
    let { page = 1, limit = 20, all = false } = req.query;

    page = parseInt(page, 10);
    limit = parseInt(limit, 10);
    all = all === 'true'; // Convertir string a booleano

    if (all || limit === 0) {
        // Si all=true o limit=0, devolver todos los productos sin paginación
        db.query('SELECT * FROM products', (err, results) => {
            if (err) {
                console.error('Error al realizar la consulta', err);
                return res.status(500).send('Error en el servidor');
            }
            res.json({ total: results.length, products: sortByName(results) });
        });
    } else {
        // Si se usa paginación, calcular el offset
        const offset = (page - 1) * limit;

        // Obtener total de productos para calcular cuántas páginas hay
        db.query('SELECT COUNT(*) AS total FROM products', (err, countResult) => {
            if (err) {
                console.error('Error al obtener el total de productos', err);
                return res.status(500).send('Error en el servidor');
            }

            const totalProducts = countResult[0].total;

            // Obtener productos con paginación
            db.query('SELECT * FROM products LIMIT ? OFFSET ?', [limit, offset], (err, results) => {
                if (err) {
                    console.error('Error al realizar la consulta', err);
                    return res.status(500).send('Error en el servidor');
                }

                res.json({
                    total: totalProducts,  // Total de productos en la BD
                    page: page,            // Página actual
                    perPage: limit,        // Cantidad de productos por página
                    totalPages: Math.ceil(totalProducts / limit), // Total de páginas
                    products: sortByName(results) // Lista de productos paginados
                });
            });
        });
    }
});


// Obtener el registro
router.get('/supply', (req, res) => {
    db.query('SELECT * FROM supply', (err, results) => {
        if (err) {
            console.error('Error al realizar la consulta', err);
            return res.status(500).send('Error en el servidor');
        }
        res.json(results); // Retornar los productos en formato JSON

    });
});

// Obtener las categorias
router.get('/categories', (req, res) => {
    db.query('SELECT * FROM categories', (err, results) => {
        if (err) {
            console.error('Error al realizar la consulta', err);
            return res.status(500).send('Error en el servidor');
        }
        
        res.json(results); // Retornar los productos en formato JSON
    });
});

// Añadir un nuevo producto
router.post('/products', (req, res) => {
    console.log(req.body)

    const { name, stock, category_id, price, price_type } = req.body;
    
    // Validar que todos los campos sean proporcionados
    if (!name || !category_id || !price || !price_type) {
        return res.status(400).send('Faltan datos requeridos');
    }

    // Insertar el producto en la base de datos
    const query = 'INSERT INTO products (name, stock, category, price, price_type) VALUES (?, ?, ?, ?, ?)';
    db.query(query, [name, stock, category_id, price, price_type], (err, result) => {
        if (err) {
            console.error('Error al añadir el producto', err);
            return res.status(500).send('Error en el servidor');
        }

        res.status(201).send('Producto añadido con éxito');
    });
});

// Eliminar múltiples productos por sus IDs
router.delete('/products', (req, res) => {
    const { ids } = req.body; // Recibe un array de IDs desde el cuerpo de la solicitud
    console.log(req.body)
    
    if (!Array.isArray(ids) || ids.length === 0) {
        return res.status(400).send('Se requiere un array de IDs para eliminar');
    }

    // Construcción de la consulta con múltiples IDs
    const query = `DELETE FROM products WHERE id IN (${ids.map(() => '?').join(',')})`;
    db.query(query, ids, (err, result) => {
        if (err) {
            console.error('Error al eliminar los productos', err);
            return res.status(500).send('Error en el servidor');
        }

        if (result.affectedRows === 0) {
            return res.status(404).send('Ningún producto encontrado para eliminar');
        }

        res.send('Productos eliminados con éxito');
    });
});


// Actualizar un producto por su ID
router.put('/products/:id', (req, res) => {
    const { id } = req.params;
    const { name, stock, category_id, price, price_type } = req.body;
    
    // Validar que al menos uno de los campos a actualizar sea proporcionado
    if (!name && !stock && !category_id && !price && !price_type) {
        return res.status(400).send('Debe proporcionar al menos un campo para actualizar');
    }

    // Preparar la actualización dinámica de los campos
    const fields = [];
    const values = [];

    if (name) {
        fields.push('name = ?');
        values.push(name);
    }
    if (stock) {
        fields.push('stock = ?');
        values.push(stock);
    }
    if (category_id) {
        fields.push('category_id = ?');
        values.push(category_id);
    }
    if (price) {
        fields.push('price = ?');
        values.push(price);
    }
    if (price_type) {
        fields.push('price_type = ?');
        values.push(price_type);
    }

    // Añadir el ID del producto a la lista de valores para la consulta
    values.push(id);

    // Crear la consulta para actualizar el producto
    const query = `UPDATE products SET ${fields.join(', ')} WHERE id = ?`;
    db.query(query, values, (err, result) => {
        if (err) {
            console.error('Error al actualizar el producto', err);
            return res.status(500).send('Error en el servidor');
        }

        if (result.affectedRows === 0) {
            return res.status(404).send('Producto no encontrado');
        }

        res.send('Producto actualizado con éxito');
    });
});

module.exports = router;
