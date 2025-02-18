const express = require('express');
const router = express.Router();
const db = require('../db.js');

// Obtener proveedores con paginación
router.get('/get', (req, res) => {
    let { page = 1, limit = 20, all = false } = req.query;

    page = parseInt(page, 10);
    limit = parseInt(limit, 10);
    all = all === 'true'; // Convertir string a booleano

    if (all || limit === 0) {
        // Si all=true o limit=0, devolver todos los registros sin paginación
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
                console.error('Error al obtener el total de registros', err);
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

module.exports = router;