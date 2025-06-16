-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-06-2025 a las 20:38:32
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
-- Base de datos: `escuela`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiantes`
--

CREATE TABLE `estudiantes` (
  `numero_control` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `apellido_paterno` varchar(100) DEFAULT NULL,
  `apellido_materno` varchar(100) NOT NULL,
  `carrera` varchar(100) DEFAULT NULL,
  `semestre_actual` int(11) DEFAULT NULL,
  `periodo_ingreso` varchar(20) DEFAULT NULL,
  `reticula` varchar(20) DEFAULT NULL,
  `modulo` int(11) DEFAULT NULL,
  `tutor` int(100) DEFAULT NULL,
  `contrasena` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estudiantes`
--

INSERT INTO `estudiantes` (`numero_control`, `nombre`, `apellido_paterno`, `apellido_materno`, `carrera`, `semestre_actual`, `periodo_ingreso`, `reticula`, `modulo`, `tutor`, `contrasena`) VALUES
(21011056, 'Luis Gerardo', 'Vargas', 'Puertos', 'Ingeniería en Sistemas Computacionales', 8, 'AGO-DIC-2021', 'CIIU-2010-224', 55, 8, '12345'),
(21011057, 'María José', 'López', 'González', 'Ingeniería en Sistemas Computacionales', 7, 'ENE-JUN-2022', 'CIIU-2010-224', 55, 1, '12345'),
(21011058, 'Pedro Luis', 'Martínez', 'Torres', 'Ingeniería en Sistemas Computacionales', 6, 'AGO-DIC-2022', 'CIIU-2010-224', 55, 6, '12345'),
(21011059, 'Ana Beatriz', 'González', 'Ramírez', 'Ingeniería en Sistemas Computacionales', 5, 'ENE-JUN-2023', 'CIIU-2010-224', 55, 1, '12345'),
(21011060, 'José Alfredo', 'Pérez', 'Sánchez', 'Ingeniería en Sistemas Computacionales', 4, 'AGO-DIC-2023', 'CIIU-2010-224', 55, 12, '12345'),
(21011061, 'Carlos Alberto', 'Ramírez', 'López', 'Ingeniería en Sistemas Computacionales', 3, 'ENE-JUN-2024', 'CIIU-2010-224', 55, 3, '12345');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horario`
--

CREATE TABLE `horario` (
  `id_a` int(11) NOT NULL,
  `materia1` varchar(255) DEFAULT NULL,
  `materia2` varchar(255) DEFAULT NULL,
  `materia3` varchar(255) DEFAULT NULL,
  `materia4` varchar(255) DEFAULT NULL,
  `materia5` varchar(255) DEFAULT NULL,
  `materia6` varchar(255) DEFAULT NULL,
  `materia7` varchar(255) DEFAULT NULL,
  `materia8` varchar(255) DEFAULT NULL,
  `nada` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `horario`
--

INSERT INTO `horario` (`id_a`, `materia1`, `materia2`, `materia3`, `materia4`, `materia5`, `materia6`, `materia7`, `materia8`, `nada`) VALUES
(21011056, '7g4|D', '8g9|F', '6g1|A', '6g6|A', '8g2|C', '8g4|D', '8gE|F', '5g3|C', NULL),
(21011058, '8gF|G', '6g1|A', '6g6|A', '8g2|C', '8g4|D', '8gE|F', '5g3|C', '7gE|B', NULL),
(21011059, '7g4|D', '8g9|F', '6g1|A', '6g6|A', '8g4|D', '8gE|F', '5g3|C', '7gE|B', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `maestros`
--

CREATE TABLE `maestros` (
  `id_maestro` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `apellido_paterno` varchar(100) DEFAULT NULL,
  `apellido_materno` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `maestros`
--

INSERT INTO `maestros` (`id_maestro`, `nombre`, `apellido_paterno`, `apellido_materno`) VALUES
(1, 'Rita', 'Hernández', 'Flores'),
(2, 'Sergio Andrés', 'Cancino', 'Reyes'),
(3, 'Wendy', 'Cancino', 'Reyes'),
(4, 'Concepción', 'Nava', 'Arteaga'),
(5, 'Gabriela Teresa', 'Muñoz', 'Fuentes'),
(6, 'José Alberto', 'Venegas', 'García'),
(7, 'Manuel', 'Panzi', 'Utrera'),
(8, 'Lucía', 'Fernández', 'Vega'),
(9, 'Ramón', 'González', 'Díaz'),
(10, 'Patricia', 'Martín', 'Reyes'),
(11, 'Ricardo', 'Jiménez', 'Luna'),
(12, 'Elena', 'Castro', 'Ríos'),
(13, 'Oscar', 'Vázquez', 'Morales'),
(14, 'Raúl', 'Hernández', 'Gutiérrez');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materia`
--

CREATE TABLE `materia` (
  `clave` varchar(10) NOT NULL,
  `grupo` varchar(10) DEFAULT NULL,
  `materia` varchar(100) DEFAULT NULL,
  `catedratico` int(100) DEFAULT NULL,
  `lun` varchar(20) DEFAULT NULL,
  `mar` varchar(20) DEFAULT NULL,
  `mie` varchar(20) DEFAULT NULL,
  `jue` varchar(20) DEFAULT NULL,
  `vie` varchar(20) DEFAULT NULL,
  `sab` varchar(20) DEFAULT NULL,
  `salones` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `materia`
--

INSERT INTO `materia` (`clave`, `grupo`, `materia`, `catedratico`, `lun`, `mar`, `mie`, `jue`, `vie`, `sab`, `salones`) VALUES
('5g3', 'C', 'Taller de Sistemas Operativos', 11, '15:00-16:00', '15:00-16:00', '15:00-16:00', '15:00-16:00', NULL, NULL, 'L4,L4,L4,L4,NULL'),
('5g7', 'G', 'Programación Lógica y Funcional', 10, '11:00-12:00', '11:00-12:00', '11:00-12:00', '11:00-12:00', '12:00-13:00', NULL, 'LC1,LC1,LC1,LC1,LC2'),
('6g1', 'A', 'Tópicos Avanzados de Programación', 13, '10:00-11:00', '10:00-11:00', '10:00-11:00', '10:00-11:00', '11:00-12:00', NULL, 'L1,L1,L1,L1,L2'),
('6g5', 'E', 'Simulación', 8, '13:00-14:00', '13:00-14:00', '13:00-14:00', '13:00-14:00', NULL, NULL, 'L6,L6,L6,L6,NULL'),
('6g6', 'A', 'Ingeniería de Software', 1, '11:00-12:00', '11:00-12:00', '11:00-12:00', '11:00-12:00', '19:00-20:00', NULL, 'L3,L3,L3,L3,-'),
('7g4', 'D', 'Sistemas Programables', 14, '08:00-09:00', '08:00-09:00', '08:00-09:00', '08:00-09:00', '10:00-11:00', NULL, 'L5,L5,L5,L5,L6'),
('7gE', 'B', 'Marco para Aplicaciones Enriquecidas de Internet', 2, '20:00-21:00', '20:00-21:00', '20:00-21:00', '20:00-21:00', '20:00-21:00', NULL, 'L5,L5,L5,L5,L5'),
('8g1', 'B', 'Taller de Base de Datos', 12, '12:00-13:00', '12:00-13:00', '12:00-13:00', '12:00-13:00', '14:00-15:00', NULL, 'L2,L2,L2,L2,L3'),
('8g2', 'C', 'Administración de Redes', 3, '12:00-13:00', '12:00-13:00', '12:00-13:00', '12:00-13:00', NULL, NULL, 'L10,L10,L10,L10,NULL'),
('8g4', 'D', 'Gestión de Proyectos de Software', 4, '13:00-14:00', '13:00-14:00', '13:00-14:00', '13:00-14:00', '12:00-14:00', NULL, 'L6,L6,L6,L6,L6'),
('8g6', 'E', 'Inteligencia Artificial', 5, '08:00-09:00', '08:00-09:00', '08:00-09:00', '08:00-09:00', NULL, NULL, 'L7,L7,L7,L7,NULL'),
('8g9', 'F', 'Redes de Computadoras', 9, '09:00-10:00', '09:00-10:00', '09:00-10:00', '09:00-10:00', '11:00-12:00', NULL, 'L7,L7,L7,L7,L8'),
('8gE', 'F', 'Administración y Seguridad en Servidores Web', 6, '14:00-15:00', '14:00-15:00', '14:00-15:00', '14:00-15:00', '14:00-15:00', NULL, 'L5,L5,L8,L6,L6'),
('8gF', 'G', 'Técnicas de Programación Emergentes para la Web', 7, '09:00-10:00', '09:00-10:00', '09:00-10:00', '09:00-10:00', '09:00-10:00', NULL, 'LC02,LC02,LC02,LC02,LC02');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `estudiantes`
--
ALTER TABLE `estudiantes`
  ADD PRIMARY KEY (`numero_control`),
  ADD KEY `FK_tutor` (`tutor`);

--
-- Indices de la tabla `horario`
--
ALTER TABLE `horario`
  ADD KEY `FK_AlumnoH` (`id_a`);

--
-- Indices de la tabla `maestros`
--
ALTER TABLE `maestros`
  ADD PRIMARY KEY (`id_maestro`);

--
-- Indices de la tabla `materia`
--
ALTER TABLE `materia`
  ADD PRIMARY KEY (`clave`),
  ADD KEY `FK_Maestro` (`catedratico`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `estudiantes`
--
ALTER TABLE `estudiantes`
  ADD CONSTRAINT `FK_tutor` FOREIGN KEY (`tutor`) REFERENCES `maestros` (`id_maestro`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `horario`
--
ALTER TABLE `horario`
  ADD CONSTRAINT `FK_AlumnoH` FOREIGN KEY (`id_a`) REFERENCES `estudiantes` (`numero_control`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `materia`
--
ALTER TABLE `materia`
  ADD CONSTRAINT `FK_Maestro` FOREIGN KEY (`catedratico`) REFERENCES `maestros` (`id_maestro`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
