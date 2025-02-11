const express = require('express');
const router = express.Router();
const db = require('../db.js');
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
            res.json({ total: results.length, products: results });
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
                    products: results // Lista de productos paginados
                });
            });
        });
    }
});


// Función para obtener los proveedores
const getProviders = (callback) => {
    db.query('SELECT id, name FROM providers', (err, results) => {
        if (err) {
            console.error('Error al obtener los proveedores', err);
            return callback(err, null);
        }
        callback(null, results);
    });
};

// Función para obtener los productos
const getProducts = (callback) => {
    db.query('SELECT id, name FROM products', (err, results) => {
        if (err) {
            console.error('Error al obtener los productos', err);
            return callback(err, null);
        }
        callback(null, results);
    });
};

// Función para formatear la fecha en D/M/A
const formatDate = (dateString) => {
    const date = new Date(dateString);
    const day = date.getDate();
    const month = date.getMonth() + 1; // Los meses en JavaScript son de 0 a 11
    const year = date.getFullYear();
    return `${day}/${month}/${year}`;
};

router.get('/supply', (req, res) => {
    let { page = 1, limit = 20, all = false } = req.query;

    page = parseInt(page, 10);
    limit = parseInt(limit, 10);
    all = all === 'true'; // Convertir string a booleano

    if (all || limit === 0) {
        db.query('SELECT * FROM supply', (err, results) => {
            if (err) {
                console.error('Error al realizar la consulta', err);
                return res.status(500).send('Error en el servidor');
            }

            // Obtener proveedores y productos en paralelo
            getProviders((err, providers) => {
                if (err) return res.status(500).send('Error al obtener proveedores');

                getProducts((err, products) => {
                    if (err) return res.status(500).send('Error al obtener productos');

                    // Crear mapas de proveedores y productos {id: name}
                    const providersMap = providers.reduce((acc, provider) => {
                        acc[provider.id] = provider.name;
                        return acc;
                    }, {});

                    const productsMap = products.reduce((acc, product) => {
                        acc[product.id] = product.name;
                        return acc;
                    }, {});

                    // Formatear los datos
                    const formattedResults = results.map(product => {
                        return {
                            ...product,
                            date: formatDate(product.date),  
                            provider: providersMap[product.provider] || product.provider,
                            product_id: productsMap[product.product_id] || product.product_id
                        };
                    });

                    res.json({ total: formattedResults.length, supply: formattedResults });
                });
            });
        });
    } else {
        const offset = (page - 1) * limit;

        db.query('SELECT COUNT(*) AS total FROM supply', (err, countResult) => {
            if (err) {
                console.error('Error al obtener el total de productos', err);
                return res.status(500).send('Error en el servidor');
            }

            const totalProducts = countResult[0].total;

            db.query('SELECT * FROM supply LIMIT ? OFFSET ?', [limit, offset], (err, results) => {
                if (err) {
                    console.error('Error al realizar la consulta', err);
                    return res.status(500).send('Error en el servidor');
                }

                // Obtener proveedores y productos en paralelo
                getProviders((err, providers) => {
                    if (err) return res.status(500).send('Error al obtener proveedores');

                    getProducts((err, products) => {
                        if (err) return res.status(500).send('Error al obtener productos');

                        // Crear mapas de proveedores y productos {id: name}
                        const providersMap = providers.reduce((acc, provider) => {
                            acc[provider.id] = provider.name;
                            return acc;
                        }, {});

                        const productsMap = products.reduce((acc, product) => {
                            acc[product.id] = product.name;
                            return acc;
                        }, {});

                        // Formatear los datos
                        const formattedResults = results.map(product => {
                            return {
                                ...product,
                                date: formatDate(product.date),  
                                provider: providersMap[product.provider] || product.provider,
                                product_id: productsMap[product.product_id] || product.product_id
                            };
                        });

                        res.json({
                            total: totalProducts,
                            page: page,
                            perPage: limit,
                            totalPages: Math.ceil(totalProducts / limit),
                            supply: formattedResults
                        });
                    });
                });
            });
        });
    }
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
router.put('/providers/:id', (req, res) => {
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
        fields.push('category = ?');
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

// Obtener productos con paginación
router.get('/providers', (req, res) => {
    let { page = 1, limit = 20, all = false } = req.query;

    page = parseInt(page, 10);
    limit = parseInt(limit, 10);
    all = all === 'true'; // Convertir string a booleano

    if (all || limit === 0) {
        // Si all=true o limit=0, devolver todos los productos sin paginación
        db.query('SELECT * FROM providers', (err, results) => {
            if (err) {
                console.error('Error al realizar la consulta', err);
                return res.status(500).send('Error en el servidor');
            }
            res.json({ total: results.length, products: results });
        });
    } else {
        // Si se usa paginación, calcular el offset
        const offset = (page - 1) * limit;

        // Obtener total de productos para calcular cuántas páginas hay
        db.query('SELECT COUNT(*) AS total FROM providers', (err, countResult) => {
            if (err) {
                console.error('Error al obtener el total de productos', err);
                return res.status(500).send('Error en el servidor');
            }

            const totalProducts = countResult[0].total;

            // Obtener productos con paginación
            db.query('SELECT * FROM providers LIMIT ? OFFSET ?', [limit, offset], (err, results) => {
                if (err) {
                    console.error('Error al realizar la consulta', err);
                    return res.status(500).send('Error en el servidor');
                }

                res.json({
                    total: totalProducts,  // Total de productos en la BD
                    page: page,            // Página actual
                    perPage: limit,        // Cantidad de productos por página
                    totalPages: Math.ceil(totalProducts / limit), // Total de páginas
                    providers: results // Lista de productos paginados
                });
            });
        });
    }
});

// Agregar un nuevo registro a la tabla supply
router.post('/supply', (req, res) => {
    const { product_id, quantity, type_of_quantity, type, weight, provider, date, payed, owed, price } = req.body;

    // Validar que todos los campos requeridos están presentes
    if (!product_id || !quantity || !type_of_quantity || !type || !weight || !provider || !date || !payed || !owed || !price) {
        return res.status(400).json({ error: "Todos los campos son obligatorios." });
    }

    const query = `
        INSERT INTO supply (product_id, quantity, type_of_quantity, type, weight, provider, date, payed, owed, price)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `;

    const values = [product_id, quantity, type_of_quantity, type, weight, provider, date, payed, owed, price];

    db.query(query, values, (err, result) => {
        if (err) {
            console.error('Error al insertar el registro en $:', err);
            return res.status(500).json({ error: "Error al agregar el registro." });
        }
        res.status(201).json({ message: "Registro agregado correctamente.", id: result.insertId });
    });
});

module.exports = router;
