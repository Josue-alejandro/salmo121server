const express = require('express');
const router = express.Router();
const db = require('../db.js');
const {formatDate} = require('../js/functions.js')

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

// Agregar un nuevo registro a la tabla supply
router.post('/register', (req, res) => {
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

// Actualizar un registro en la tabla supply
router.put('/register/:id', (req, res) => {
    const { id } = req.params;
    const { product_id, quantity, type_of_quantity, type, weight, provider, date, payed, owed, price } = req.body;

    // Validar que al menos un campo ha sido proporcionado para actualizar
    if (!product_id && !quantity && !type_of_quantity && !type && !weight && !provider && !date && !payed && !owed && !price) {
        return res.status(400).json({ error: "Debe proporcionar al menos un campo para actualizar." });
    }

    // Construir la consulta dinámicamente
    let query = 'UPDATE supply SET ';
    const values = [];
    const fieldsToUpdate = [];

    if (product_id) { fieldsToUpdate.push('product_id = ?'); values.push(product_id); }
    if (quantity) { fieldsToUpdate.push('quantity = ?'); values.push(quantity); }
    if (type_of_quantity) { fieldsToUpdate.push('type_of_quantity = ?'); values.push(type_of_quantity); }
    if (type) { fieldsToUpdate.push('type = ?'); values.push(type); }
    if (weight) { fieldsToUpdate.push('weight = ?'); values.push(weight); }
    if (provider) { fieldsToUpdate.push('provider = ?'); values.push(provider); }
    if (date) { fieldsToUpdate.push('date = ?'); values.push(date); }
    if (payed) { fieldsToUpdate.push('payed = ?'); values.push(payed); }
    if (owed) { fieldsToUpdate.push('owed = ?'); values.push(owed); }
    if (price) { fieldsToUpdate.push('price = ?'); values.push(price); }

    query += fieldsToUpdate.join(', ') + ' WHERE id = ?';
    values.push(id);

    db.query(query, values, (err, result) => {
        if (err) {
            console.error('Error al actualizar el registro:', err);
            return res.status(500).json({ error: "Error al actualizar el registro.", details: err.sqlMessage });
        }
        if (result.affectedRows === 0) {
            return res.status(404).json({ error: "Registro no encontrado." });
        }
        res.status(200).json({ message: "Registro actualizado correctamente." });
    });
});


// Eliminar múltiples registros por sus IDs
router.delete('/register', (req, res) => {
    const { ids } = req.body; // Recibe un array de IDs desde el cuerpo de la solicitud
    console.log(req.body)
    
    if (!Array.isArray(ids) || ids.length === 0) {
        return res.status(400).send('Se requiere un array de IDs para eliminar');
    }

    // Construcción de la consulta con múltiples IDs
    const query = `DELETE FROM supply WHERE id IN (${ids.map(() => '?').join(',')})`;
    db.query(query, ids, (err, result) => {
        if (err) {
            console.error('Error al eliminar los registros', err);
            return res.status(500).send('Error en el servidor');
        }

        if (result.affectedRows === 0) {
            return res.status(404).send('Ningún registro encontrado para eliminar');
        }

        res.send('Registros eliminados con éxito');
    });
});

// Obtiene los registros paginados con opción de filtrar por rango de fechas y productos específicos
router.get('/register', (req, res) => {
    let { page = 1, limit = 20, all = false, startDate, endDate, productIds } = req.query;

    page = parseInt(page, 10);
    limit = parseInt(limit, 10);
    all = all === 'true'; // Convertir string a booleano

    // Construir condiciones de filtro de fecha y productos si se proporcionan
    let conditions = [];
    let queryParams = [];

    if (startDate && endDate) {
        conditions.push('date BETWEEN ? AND ?');
        queryParams.push(startDate, endDate);
    }

    if (productIds) {
        const idsArray = productIds.split(',').map(id => parseInt(id, 10)).filter(id => !isNaN(id));
        if (idsArray.length > 0) {
            conditions.push(`product_id IN (${idsArray.map(() => '?').join(',')})`);
            queryParams.push(...idsArray);
        }
    }

    const whereClause = conditions.length > 0 ? ` WHERE ${conditions.join(' AND ')}` : '';

    if (all || limit === 0) {
        // Si se solicitan todos los registros sin paginación
        db.query(`SELECT * FROM supply${whereClause}`, queryParams, (err, results) => {
            if (err) {
                console.error('Error al realizar la consulta', err);
                return res.status(500).send('Error en el servidor');
            }

            // Obtener proveedores y productos para mapear nombres en los resultados
            getProviders((err, providers) => {
                if (err) return res.status(500).send('Error al obtener proveedores');

                getProducts((err, products) => {
                    if (err) return res.status(500).send('Error al obtener productos');

                    const providersMap = providers.reduce((acc, provider) => {
                        acc[provider.id] = provider.name;
                        return acc;
                    }, {});

                    const productsMap = products.reduce((acc, product) => {
                        acc[product.id] = product.name;
                        return acc;
                    }, {});

                    // Formatear resultados
                    const formattedResults = results.map(product => ({
                        ...product,
                        date: formatDate(product.date),  
                        provider: providersMap[product.provider] || product.provider,
                        product_id: productsMap[product.product_id] || product.product_id
                    })).sort((a, b) => new Date(a.date) - new Date(b.date)); // Ordenar por fecha

                    res.json({ total: formattedResults.length, supply: formattedResults });
                });
            });
        });
    } else {
        // Paginación: calcular el offset
        const offset = (page - 1) * limit;

        // Obtener el total de registros filtrados
        db.query(`SELECT COUNT(*) AS total FROM supply${whereClause}`, queryParams, (err, countResult) => {
            if (err) {
                console.error('Error al obtener el total de productos', err);
                return res.status(500).send('Error en el servidor');
            }

            const totalProducts = countResult[0].total;

            // Obtener los registros paginados con el filtro aplicado
            db.query(`SELECT * FROM supply${whereClause} LIMIT ? OFFSET ?`, [...queryParams, limit, offset], (err, results) => {
                if (err) {
                    console.error('Error al realizar la consulta', err);
                    return res.status(500).send('Error en el servidor');
                }

                // Obtener proveedores y productos para mapear nombres en los resultados
                getProviders((err, providers) => {
                    if (err) return res.status(500).send('Error al obtener proveedores');

                    getProducts((err, products) => {
                        if (err) return res.status(500).send('Error al obtener productos');

                        const providersMap = providers.reduce((acc, provider) => {
                            acc[provider.id] = provider.name;
                            return acc;
                        }, {});

                        const productsMap = products.reduce((acc, product) => {
                            acc[product.id] = product.name;
                            return acc;
                        }, {});

                        // Formatear resultados
                        const formattedResults = results.map(product => ({
                            ...product,
                            date: formatDate(product.date),  
                            provider: providersMap[product.provider] || product.provider,
                            product_id: productsMap[product.product_id] || product.product_id
                        })).sort((a, b) => new Date(a.date) - new Date(b.date)); // Ordenar por fecha

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


module.exports = router;