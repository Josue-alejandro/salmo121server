-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 18-02-2025 a las 15:03:05
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `salmo121db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) NOT NULL,
  `name` varchar(35) NOT NULL,
  `father_category` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `categories`
--

INSERT INTO `categories` (`id`, `name`, `father_category`) VALUES
(2, 'verduras', NULL),
(3, 'Frutas', NULL),
(4, 'Tuberculos', NULL),
(5, 'Hortalizas', NULL),
(6, 'Pulpa', NULL),
(7, 'Frutas Importadas', NULL),
(8, 'Condimentos', NULL),
(9, 'Granos', NULL),
(10, 'Salsas', NULL),
(11, 'Viveres', NULL),
(12, 'Reposteria', NULL),
(13, 'Miscelaneas', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `employees`
--

CREATE TABLE `employees` (
  `id` bigint(20) NOT NULL,
  `name` text NOT NULL,
  `full_name` text NOT NULL,
  `joined_in` date NOT NULL,
  `position` text NOT NULL,
  `salary` decimal(10,2) NOT NULL,
  `salary_type` text NOT NULL,
  `owe_to_company` decimal(10,2) NOT NULL,
  `owe_to_them` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `products`
--

CREATE TABLE `products` (
  `id` bigint(20) NOT NULL,
  `name` varchar(55) NOT NULL,
  `stock` int(11) NOT NULL,
  `category` bigint(20) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `price_type` varchar(35) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `products`
--

INSERT INTO `products` (`id`, `name`, `stock`, `category`, `price`, `price_type`) VALUES
(20, 'Zapote', 100, 3, 100.00, 'por kilo'),
(21, 'Tomate', 0, 2, 50.00, 'por kilo'),
(22, 'Cambur', 5, 9, 60.00, 'unidad'),
(23, 'Uva importada verde', 0, 3, 600.00, 'bolsa'),
(24, 'Platanitos', 0, 13, 40.00, 'unidad'),
(25, 'Platano', 0, 3, 35.00, 'por kilo'),
(26, 'Ajo', 0, 2, 250.00, 'por kilo'),
(27, 'Yuca', 0, 4, 25.00, 'por kilo'),
(28, 'Cilantro', 0, 5, 100.00, 'por kilo'),
(29, 'Cebollin', 0, 5, 100.00, 'por kilo'),
(30, 'Perejil', 0, 5, 100.00, 'por kilo'),
(31, 'Espinaca', 0, 5, 100.00, 'por kilo'),
(32, 'Acelga', 0, 5, 100.00, 'por kilo'),
(33, 'Cedano', 0, 5, 100.00, 'por kilo'),
(34, 'Porro', 0, 5, 100.00, 'por kilo'),
(35, 'Coliflor', 0, 2, 100.00, 'por kilo'),
(36, 'Brocoli', 0, 2, 100.00, 'por kilo'),
(37, 'Romana', 0, 2, 100.00, 'por kilo'),
(38, 'Americana', 3, 2, 100.00, 'por kilo'),
(39, 'Aji', 0, 3, 50.00, 'por kilo'),
(40, 'Pimenton', 0, 3, 50.00, 'por kilo'),
(41, 'Zanahoria', 0, 2, 50.00, 'por kilo'),
(42, 'Cebolla', 0, 2, 50.00, 'por kilo'),
(43, 'Repollo Blanco', 0, 2, 50.00, 'por kilo'),
(44, 'Repollo Morado', 0, 2, 50.00, 'por kilo'),
(45, 'Chayota', 0, 2, 50.00, 'por kilo'),
(46, 'Berenjena', 0, 3, 50.00, 'por kilo'),
(47, 'Apio', 0, 4, 50.00, 'por kilo'),
(48, 'Calabacin', 0, 3, 50.00, 'por kilo'),
(49, 'Pepino', 0, 5, 50.00, 'por kilo'),
(50, 'Batata', 0, 2, 50.00, 'por kilo'),
(51, 'Ocumo', 0, 4, 50.00, 'por kilo'),
(52, 'Ñame', 0, 4, 50.00, 'por kilo'),
(53, 'Barbarita', 0, 3, 50.00, 'por kilo'),
(54, 'Parchita', 0, 3, 100.00, 'por kilo'),
(55, 'Naranja', 0, 3, 50.00, 'por kilo'),
(56, 'Auyama', 0, 3, 30.00, 'por kilo'),
(57, 'Remolacha', 0, 5, 50.00, 'por kilo'),
(58, 'Cebolla Morada', 0, 2, 60.00, 'por kilo'),
(59, 'Manzana Roja Pequeña', 0, 3, 20.00, 'unidad'),
(60, 'Panela', 0, 12, 50.00, 'unidad'),
(61, 'Tamarindo', 0, 3, 50.00, 'unidad'),
(62, 'Huevos', 0, 11, 15.00, 'unidad'),
(63, 'Melon', 0, 3, 50.00, 'por kilo'),
(64, 'Piña', 0, 3, 150.00, 'unidad'),
(65, 'Papas', 0, 4, 50.00, 'por kilo'),
(66, 'Limon', 0, 3, 100.00, 'por kilo'),
(67, 'Lechoza', 0, 3, 50.00, 'por kilo'),
(68, 'Guayaba', 0, 3, 50.00, 'por kilo'),
(69, 'Patilla', 0, 3, 30.00, 'por kilo'),
(70, 'Toronja', 0, 3, 50.00, 'por kilo'),
(71, 'Coco', 0, 3, 120.00, 'unidad'),
(72, 'Durazno', 0, 3, 200.00, 'por kilo'),
(73, 'Ciruela', 0, 3, 450.00, 'por kilo'),
(74, 'Kiwi', 0, 3, 500.00, 'por kilo'),
(75, 'Tomate de Arbol', 0, 3, 200.00, 'por kilo'),
(76, 'Fresa', 0, 3, 80.00, 'bandeja'),
(77, 'Miel', 0, 13, 80.00, 'unidad'),
(78, 'Picante', 0, 10, 80.00, 'unidad'),
(79, 'Frijol Rojo', 0, 9, 65.00, 'unidad'),
(80, 'Caraota', 0, 9, 65.00, 'unidad'),
(81, 'Lenteja', 0, 9, 65.00, 'unidad'),
(82, 'Frijol Cabeza Negra', 0, 9, 65.00, 'unidad'),
(83, 'Maiz', 0, 9, 65.00, 'unidad'),
(84, 'Vinagre 500ml', 1, 11, 40.00, 'unidad'),
(85, 'Vinagre 1L', 576, 11, 70.00, 'unidad'),
(86, 'Arroz Mary', 0, 11, 65.00, 'unidad'),
(87, 'Harina Pan', 0, 11, 65.00, 'unidad'),
(88, 'Harina de Trigo', 0, 11, 80.00, 'unidad'),
(89, 'Vainilla Tasty', 0, 12, 40.00, 'unidad'),
(90, 'Vainilla Vanicol', 0, 12, 70.00, 'unidad'),
(92, 'Mandarina', 0, 3, 100.00, 'por kilo'),
(94, 'Jojoto', 0, 5, 50.00, 'unidad'),
(95, 'Manzana Roja', 0, 3, 100.00, 'por kilo'),
(96, 'Manzana Verde', 0, 3, 100.00, 'por kilo'),
(97, 'Pera', 0, 7, 100.00, 'por kilo'),
(98, 'Rabo de yuca', 0, 4, 25.00, 'por kilo'),
(99, 'Uva importada roja', 0, 7, 100.00, 'por kilo'),
(100, 'botellon de agua', 0, 13, 100.00, 'unidad'),
(101, 'Mostaza Heinz', 1, 10, 100.00, 'unidad'),
(102, 'Bandeja multiplast', 1, 13, 100.00, 'unidad'),
(103, 'Azucar', 0, 11, 100.00, 'unidad'),
(105, 'Trifogon', 0, 8, 100.00, 'unidad'),
(106, 'Pasta Capri', 0, 11, 100.00, 'unidad'),
(108, 'Adobo La Comadre', 1, 8, 100.00, 'unidad'),
(109, 'Cafe La protectora', 1, 13, 100.00, 'unidad'),
(110, 'Cubito Comarrico', 0, 8, 100.00, 'unidad'),
(111, 'Topocho', 1, 3, 100.00, 'por kilo'),
(112, 'Aguacate', 1, 3, 100.00, 'por kilo'),
(113, 'Vainita', 1, 2, 100.00, 'por kilo'),
(114, 'Rabano', 0, 4, 100.00, 'por kilo'),
(115, 'Mora', 1, 6, 100.00, 'unidad'),
(116, 'Cambur Blanco', 1, 3, 0.00, 'por kilo'),
(117, 'Cambur Blanco', 1, 3, 0.00, 'por kilo'),
(118, 'Queso', 1, 11, 0.00, 'por kilo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `providers`
--

CREATE TABLE `providers` (
  `id` bigint(20) NOT NULL,
  `name` text NOT NULL,
  `trust` int(11) NOT NULL,
  `phone` text NOT NULL,
  `mail` text NOT NULL
) ;

--
-- Volcado de datos para la tabla `providers`
--

INSERT INTO `providers` (`id`, `name`, `trust`, `phone`, `mail`) VALUES
(1, 'Alvaro', 5, '', ''),
(2, 'Humberto Cebollin', 3, '', ''),
(3, 'Mercamara', 5, '', ''),
(4, 'Luis Yuca', 5, '', ''),
(5, 'Manuel Auyama', 5, '', ''),
(6, 'Dario Vilchez', 5, '', ''),
(7, 'Elite', 5, '', ''),
(8, 'Beto platano', 5, '', ''),
(9, 'Jesus Huevos', 5, '', ''),
(10, 'Yonardo Queso', 5, '', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `supply`
--

CREATE TABLE `supply` (
  `id` bigint(20) NOT NULL,
  `product_name` varchar(40) NOT NULL,
  `product_id` bigint(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `type_of_quantity` varchar(30) NOT NULL,
  `type` varchar(1) NOT NULL,
  `weight` decimal(10,2) NOT NULL,
  `provider` bigint(11) NOT NULL,
  `date` date NOT NULL,
  `payed` decimal(10,2) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `owed` decimal(10,2) GENERATED ALWAYS AS (`price` - `payed`) VIRTUAL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `supply`
--

INSERT INTO `supply` (`id`, `product_name`, `product_id`, `quantity`, `type_of_quantity`, `type`, `weight`, `provider`, `date`, `payed`, `price`) VALUES
(17, '', 49, 1, 'cesta', 'A', 36.80, 3, '2025-02-10', 0.00, 0.00),
(18, '', 39, 2, 'sacos', 'A', 59.00, 3, '2025-02-10', 0.00, 0.00),
(19, '', 94, 2, 'sacos', 'A', 0.00, 3, '2025-02-10', 0.00, 0.00),
(20, '', 57, 2, 'cesta', 'A', 45.00, 3, '2025-02-10', 0.00, 0.00),
(21, '', 40, 5, 'cestas', 'A', 85.00, 3, '2025-02-10', 0.00, 0.00),
(22, '', 96, 1, 'media caja', 'A', 0.00, 3, '2025-02-10', 0.00, 0.00),
(23, '', 95, 1, 'media caja', 'A', 0.00, 3, '2025-02-10', 0.00, 0.00),
(24, '', 36, 1, 'cesta', 'A', 0.00, 3, '2025-02-10', 0.00, 0.00),
(25, '', 37, 2, 'cesta', 'A', 0.00, 3, '2025-02-10', 0.00, 0.00),
(26, '', 97, 1, 'caja', 'A', 0.00, 3, '2025-02-10', 0.00, 0.00),
(27, '', 67, 4, 'cestas', 'A', 81.00, 3, '2025-02-10', 0.00, 0.00),
(28, '', 35, 1, 'cesta', 'A', 0.00, 3, '2025-02-10', 0.00, 0.00),
(29, '', 54, 3, 'cesta', 'A', 41.00, 3, '2025-02-10', 0.00, 0.00),
(30, '', 92, 2, 'saco', 'A', 60.00, 3, '2025-02-10', 0.00, 0.00),
(31, '', 76, 10, 'paquetes', 'A', 0.00, 3, '2025-02-10', 0.00, 0.00),
(32, '', 48, 1, 'cesta', 'A', 27.00, 3, '2025-02-10', 0.00, 0.00),
(33, '', 22, 5, 'cestas', 'A', 0.00, 3, '2025-02-10', 0.00, 0.00),
(34, '', 64, 30, 'unidad', 'A', 0.00, 3, '2025-02-10', 0.00, 0.00),
(35, '', 68, 3, 'cesta', 'A', 95.00, 3, '2025-02-10', 0.00, 0.00),
(36, '', 21, 20, 'cestas', 'A', 0.00, 3, '2025-02-10', 0.00, 0.00),
(37, '', 66, 1, 'cesta', 'A', 0.00, 3, '2025-02-10', 0.00, 0.00),
(38, '', 46, 1, 'cesta', 'A', 9.00, 3, '2025-02-10', 0.00, 0.00),
(39, '', 43, 10, 'sacos', 'A', 0.00, 3, '2025-02-10', 0.00, 0.00),
(40, '', 45, 1, 'cesta', 'A', 18.50, 3, '2025-02-10', 0.00, 0.00),
(41, '', 20, 1, 'cesta', 'A', 31.00, 3, '2025-02-10', 0.00, 0.00),
(42, '', 27, 1, 'entrega', 'A', 52.00, 4, '2025-02-10', 0.00, 0.00),
(43, '', 98, 1, 'entrega', 'A', 13.00, 4, '2025-02-10', 0.00, 0.00),
(44, '', 23, 1, 'caja', 'A', 8.90, 3, '2025-02-10', 0.00, 0.00),
(45, '', 28, 10, 'pareja', 'A', 0.00, 3, '2025-02-10', 0.00, 0.00),
(46, '', 29, 15, 'pareja', 'A', 0.00, 3, '2025-02-10', 0.00, 0.00),
(47, '', 99, 1, 'caja', 'A', 0.80, 3, '2025-02-11', 0.00, 0.00),
(48, '', 23, 1, 'caja', 'A', 0.92, 3, '2025-02-11', 0.00, 0.00),
(49, '', 28, 10, 'parejas', 'A', 0.00, 3, '2025-02-11', 0.00, 0.00),
(50, '', 29, 10, 'parejas', 'A', 0.00, 3, '2025-02-11', 0.00, 0.00),
(51, '', 27, 1, 'entrega', 'A', 40.00, 4, '2025-02-11', 0.00, 0.00),
(52, '', 98, 1, 'entrega', 'A', 11.00, 4, '2025-02-11', 0.00, 0.00),
(53, '', 33, 1, 'cesta', 'A', 9.95, 3, '2025-02-11', 0.00, 0.00),
(54, '', 64, 163, 'unidad', 'A', 0.00, 3, '2025-02-11', 0.00, 0.00),
(55, '', 32, 1, 'cesta', 'A', 5.50, 3, '2025-02-11', 0.00, 0.00),
(56, '', 31, 1, 'cesta', 'A', 4.00, 3, '2025-02-11', 0.00, 0.00),
(57, '', 76, 11, 'paquetes', 'A', 0.00, 3, '2025-02-11', 0.00, 0.00),
(58, '', 47, 1, 'cesta', 'A', 19.80, 3, '2025-02-11', 0.00, 0.00),
(59, '', 56, 10, 'sacos', 'A', 0.00, 5, '2025-02-11', 0.00, 0.00),
(60, '', 100, 10, 'Botellon', 'A', 0.00, 6, '2025-02-11', 0.00, 0.00),
(61, '', 67, 8, 'sacos', 'A', 712.00, 3, '2025-02-11', 0.00, 0.00),
(62, '', 102, 1, 'unidad', 'A', 0.00, 7, '2025-02-11', 0.00, 0.00),
(63, '', 101, 24, 'unidad', 'A', 0.00, 7, '2025-02-11', 0.00, 0.00),
(64, '', 103, 2, 'bulto', 'A', 0.00, 7, '2025-02-11', 0.00, 0.00),
(65, '', 86, 2, 'bulto', 'A', 0.00, 7, '2025-02-11', 0.00, 0.00),
(66, '', 105, 1, 'paquete', 'A', 0.00, 7, '2025-02-11', 0.00, 0.00),
(67, '', 106, 2, 'paquetes', 'A', 1.50, 7, '2025-02-11', 0.00, 0.00),
(68, '', 87, 2, 'bulto', 'A', 0.00, 7, '2025-02-11', 0.00, 0.00),
(69, '', 108, 1, 'paquete', 'A', 0.00, 7, '2025-02-11', 0.00, 0.00),
(70, '', 110, 1, 'caja', 'A', 0.00, 7, '2025-02-11', 0.00, 0.00),
(71, '', 27, 1, 'entrega', 'A', 72.00, 4, '2025-02-12', 0.00, 0.00),
(72, '', 98, 1, 'entrega', 'A', 11.00, 4, '2025-02-12', 0.00, 0.00),
(73, '', 94, 1, 'saco', 'A', 0.00, 3, '2025-02-12', 0.00, 0.00),
(74, '', 111, 19, 'racimos', 'A', 0.00, 3, '2025-02-12', 0.00, 0.00),
(75, '', 111, 3, 'cestas', 'A', 0.00, 3, '2025-02-12', 0.00, 0.00),
(76, '', 76, 12, 'paquetes', 'A', 0.00, 3, '2025-02-12', 0.00, 0.00),
(77, '', 22, 3, 'cestas', 'A', 0.00, 3, '2025-02-12', 0.00, 0.00),
(78, '', 25, 5, 'cestas', 'A', 0.00, 8, '2025-02-12', 0.00, 0.00),
(79, '', 75, 1, 'bolsa', 'A', 5.00, 3, '2025-02-12', 0.00, 0.00),
(80, '', 63, 1, 'cesta', 'A', 50.00, 3, '2025-02-12', 0.00, 0.00),
(81, '', 112, 1, 'cesta', 'A', 15.00, 3, '2025-02-12', 0.00, 0.00),
(82, '', 40, 5, 'sacos', 'A', 0.00, 3, '2025-02-12', 0.00, 0.00),
(83, '', 42, 2, 'sacos', 'A', 0.00, 3, '2025-02-12', 0.00, 0.00),
(84, '', 49, 2, 'sacos', 'A', 62.00, 3, '2025-02-12', 0.00, 0.00),
(85, '', 47, 1, 'cesta', 'A', 42.50, 3, '2025-02-12', 0.00, 0.00),
(86, '', 50, 1, 'cesta', 'A', 39.00, 3, '2025-02-12', 0.00, 0.00),
(87, '', 45, 1, 'saco', 'A', 45.00, 3, '2025-02-12', 0.00, 0.00),
(88, '', 48, 2, 'cestas', 'A', 53.00, 3, '2025-02-12', 0.00, 0.00),
(89, '', 46, 1, 'saco', 'A', 22.00, 3, '2025-02-12', 0.00, 0.00),
(90, '', 34, 5, 'cestas', 'A', 26.65, 3, '2025-02-12', 0.00, 0.00),
(91, '', 33, 5, 'cesta', 'A', 28.90, 3, '2025-02-12', 0.00, 0.00),
(92, '', 32, 2, 'cestas', 'A', 8.55, 3, '2025-02-12', 0.00, 0.00),
(93, '', 31, 2, 'cesta', 'A', 10.30, 3, '2025-02-12', 0.00, 0.00),
(94, '', 30, 2, 'cesta', 'A', 10.00, 3, '2025-02-12', 0.00, 0.00),
(95, '', 36, 1, 'cesta', 'A', 7.00, 3, '2025-02-12', 0.00, 0.00),
(96, '', 35, 1, 'cesta', 'A', 11.50, 3, '2025-02-12', 0.00, 0.00),
(97, '', 38, 5, 'cesta', 'A', 51.00, 3, '2025-02-12', 0.00, 0.00),
(98, '', 37, 3, 'cesta', 'A', 37.50, 3, '2025-02-12', 0.00, 0.00),
(99, '', 29, 15, 'parejas', 'A', 0.00, 3, '2025-02-12', 0.00, 0.00),
(100, '', 28, 15, 'parejas', 'A', 0.00, 3, '2025-02-12', 0.00, 0.00),
(101, '', 25, 31, 'cestas', 'A', 62.00, 8, '2025-02-12', 0.00, 0.00),
(102, '', 26, 5, 'cajas', 'A', 50.12, 3, '2025-02-12', 0.00, 0.00),
(103, '', 66, 1, 'cestas', 'A', 58.00, 3, '2025-02-13', 0.00, 0.00),
(104, '', 22, 4, 'cestas', 'A', 94.00, 3, '2025-02-13', 0.00, 0.00),
(105, '', 54, 1, 'cestas', 'A', 20.00, 3, '2025-02-13', 0.00, 0.00),
(106, '', 68, 2, 'cestas', 'A', 47.00, 3, '2025-02-13', 0.00, 0.00),
(107, '', 27, 1, 'entrega', 'A', 45.00, 4, '2025-02-13', 0.00, 0.00),
(108, '', 98, 1, 'entrega', 'A', 17.00, 4, '2025-02-13', 0.00, 0.00),
(109, '', 29, 15, 'parejas', 'A', 0.00, 3, '2025-02-13', 0.00, 0.00),
(110, '', 28, 15, 'parejas', 'A', 0.00, 3, '2025-02-13', 0.00, 0.00),
(111, '', 27, 1, 'entrega', 'A', 86.40, 4, '2025-02-14', 0.00, 0.00),
(112, '', 98, 1, 'entrega', 'A', 10.40, 4, '2025-02-14', 0.00, 0.00),
(113, '', 29, 15, 'parejas', 'A', 0.00, 2, '2025-02-14', 0.00, 0.00),
(114, '', 28, 10, 'parejas', 'A', 0.00, 2, '2025-02-14', 0.00, 0.00),
(115, '', 62, 5, 'cajas', 'A', 120.00, 9, '2025-02-14', 0.00, 0.00),
(116, '', 41, 10, 'sacos', 'A', 0.00, 3, '2025-02-14', 0.00, 0.00),
(117, '', 55, 2, 'sacos', 'A', 59.00, 3, '2025-02-14', 0.00, 0.00),
(118, '', 113, 1, 'sacos', 'A', 36.55, 3, '2025-02-14', 0.00, 0.00),
(119, '', 44, 1, 'saco', 'A', 37.00, 3, '2025-02-14', 0.00, 0.00),
(120, '', 111, 4, 'cestas', 'A', 0.00, 3, '2025-02-14', 0.00, 0.00),
(121, '', 111, 11, 'racimos', 'A', 0.00, 3, '2025-02-14', 0.00, 0.00),
(122, '', 64, 142, 'unidad', 'A', 0.00, 3, '2025-02-14', 0.00, 0.00),
(123, '', 112, 2, 'cestas', 'A', 31.00, 3, '2025-02-14', 0.00, 0.00),
(124, '', 114, 1, 'cesta', 'A', 5.25, 3, '2025-02-14', 0.00, 0.00),
(125, '', 96, 1, 'caja', 'A', 0.00, 3, '2025-02-14', 0.00, 0.00),
(126, '', 95, 1, 'caja', 'A', 0.00, 3, '2025-02-14', 0.00, 0.00),
(127, '', 76, 25, 'paquetes', 'A', 0.00, 3, '2025-02-14', 0.00, 0.00),
(128, '', 23, 1, 'paquete', 'A', 1.35, 3, '2025-02-14', 0.00, 0.00),
(129, '', 99, 1, 'paquete', 'A', 1.99, 3, '2025-02-14', 0.00, 0.00),
(130, '', 22, 4, 'cestas', 'A', 0.00, 3, '2025-02-14', 0.00, 0.00),
(131, '', 21, 20, 'cestas', 'A', 0.00, 3, '2025-02-14', 0.00, 0.00),
(132, '', 39, 2, 'saco', 'A', 69.50, 3, '2025-02-14', 0.00, 0.00),
(133, '', 115, 50, 'paquetes', 'A', 0.00, 3, '2025-02-14', 0.00, 0.00),
(134, '', 94, 3, 'sacos', 'A', 0.00, 3, '2025-02-14', 0.00, 0.00),
(135, '', 85, 35, 'docenas', 'A', 0.00, 3, '2025-02-14', 0.00, 0.00),
(136, '', 27, 1, 'entrega', 'A', 56.00, 4, '2025-02-15', 0.00, 0.00),
(137, '', 98, 20, 'entrega', 'A', 20.00, 4, '2025-02-15', 0.00, 0.00),
(138, '', 29, 10, 'parejas', 'A', 0.00, 2, '2025-02-15', 0.00, 0.00),
(139, '', 28, 10, 'parejas', 'A', 0.00, 2, '2025-02-15', 0.00, 0.00),
(140, '', 111, 40, 'racimos', 'A', 0.00, 9, '2025-02-15', 0.00, 0.00),
(141, '', 25, 14, 'cestas', 'A', 447.50, 8, '2025-02-15', 0.00, 0.00),
(142, '', 68, 2, 'cesta', 'A', 35.00, 8, '2025-02-15', 0.00, 0.00),
(143, '', 116, 1, 'cesta', 'A', 22.00, 8, '2025-02-15', 0.00, 0.00),
(144, '', 51, 2, 'cesta', 'A', 51.00, 8, '2025-02-15', 0.00, 0.00),
(145, '', 118, 16, 'ruedas', 'A', 38.70, 10, '2025-02-15', 193.50, 193.50),
(146, '', 78, 25, 'unidades', 'A', 0.00, 3, '2025-02-17', 0.00, 0.00),
(147, '', 39, 3, 'sacos', 'A', 0.00, 3, '2025-02-17', 0.00, 0.00);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `father_category` (`father_category`);

--
-- Indices de la tabla `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_categories` (`category`);

--
-- Indices de la tabla `providers`
--
ALTER TABLE `providers`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `supply`
--
ALTER TABLE `supply`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_product` (`product_id`),
  ADD KEY `fk_provider` (`provider`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `employees`
--
ALTER TABLE `employees`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=119;

--
-- AUTO_INCREMENT de la tabla `providers`
--
ALTER TABLE `providers`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `supply`
--
ALTER TABLE `supply`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=148;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`father_category`) REFERENCES `categories` (`id`);

--
-- Filtros para la tabla `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `fk_categories` FOREIGN KEY (`category`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `supply`
--
ALTER TABLE `supply`
  ADD CONSTRAINT `fk_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_provider` FOREIGN KEY (`provider`) REFERENCES `providers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
