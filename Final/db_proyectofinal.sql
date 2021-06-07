SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE DATABASE IF NOT EXISTS `db_proyectofinal` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `db_proyectofinal`;

CREATE TABLE `clientes` (
  `idCliente` int(11) NOT NULL,
  `nombres` varchar(60) NOT NULL,
  `apellidos` varchar(60) NOT NULL,
  `NIT` varchar(12) NOT NULL,
  `genero` bit(1) DEFAULT NULL,
  `telefono` varchar(25) DEFAULT NULL,
  `correo_electronico` varchar(45) DEFAULT NULL,
  `fechaingreso` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `compras` (
  `idcompra` int(11) NOT NULL,
  `no_orden_compra` int(11) NOT NULL,
  `idproveedor` int(11) NOT NULL,
  `fecha_orden` date NOT NULL,
  `fecha_ingreso` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `compras_detalle` (
  `idcompra_detalle` bigint(20) NOT NULL,
  `idcompra` int(11) NOT NULL,
  `idproducto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_costo_unitario` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `empleados` (
  `idEmpleado` int(11) NOT NULL,
  `nombres` varchar(60) NOT NULL,
  `apellidos` varchar(60) NOT NULL,
  `direccion` varchar(80) NOT NULL,
  `telefono` varchar(25) DEFAULT NULL,
  `dpi` varchar(15) NOT NULL,
  `genero` bit(1) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `idPuesto` smallint(6) NOT NULL,
  `fecha_inicio_labores` date NOT NULL,
  `fechaingreso` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `marcas` (
  `idMarca` smallint(6) NOT NULL,
  `marca` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `productos` (
  `idProducto` int(11) NOT NULL,
  `producto` varchar(50) NOT NULL,
  `idMarca` smallint(6) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `imagen` varchar(30) DEFAULT NULL,
  `precio_costo` decimal(8,2) NOT NULL,
  `precio_venta` decimal(8,2) NOT NULL,
  `existencia` int(11) NOT NULL DEFAULT 0,
  `fechaingreso` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `proveedores` (
  `idproveedor` int(11) NOT NULL,
  `proveedor` varchar(60) NOT NULL,
  `nit` varchar(12) NOT NULL,
  `direccion` varchar(80) DEFAULT NULL,
  `telefono` varchar(25) DEFAULT NULL,
  `fechaingreso` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `puestos` (
  `idPuesto` smallint(6) NOT NULL,
  `puesto` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `ventas` (
  `idVenta` int(11) NOT NULL,
  `nofactura` int(11) NOT NULL,
  `serie` char(1) NOT NULL,
  `fechafactura` date DEFAULT NULL,
  `idcliente` int(11) DEFAULT NULL,
  `idempleado` int(11) NOT NULL,
  `fechaingreso` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `ventasdetalle` (
  `idventa_det` bigint(20) NOT NULL,
  `idventa` int(11) NOT NULL,
  `idProducto` int(11) NOT NULL,
  `cantidad` varchar(45) NOT NULL,
  `precio_unitario` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `clientes`
  ADD PRIMARY KEY (`idCliente`);

ALTER TABLE `compras`
  ADD PRIMARY KEY (`idcompra`),
  ADD KEY `fk_prov` (`idproveedor`);

ALTER TABLE `compras_detalle`
  ADD PRIMARY KEY (`idcompra_detalle`),
  ADD KEY `fk_compras` (`idcompra`),
  ADD KEY `fk_prod` (`idproducto`);

ALTER TABLE `empleados`
  ADD PRIMARY KEY (`idEmpleado`),
  ADD KEY `empleados_FK` (`idPuesto`);

ALTER TABLE `marcas`
  ADD PRIMARY KEY (`idMarca`);
ALTER TABLE `productos`
  ADD PRIMARY KEY (`idProducto`),
  ADD KEY `fk_marca` (`idMarca`);

ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`idproveedor`);

ALTER TABLE `puestos`
  ADD PRIMARY KEY (`idPuesto`);
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`idVenta`),
  ADD KEY `fk_clientev` (`idcliente`),
  ADD KEY `fk_empleado` (`idempleado`);

ALTER TABLE `ventasdetalle`
  ADD PRIMARY KEY (`idventa_det`),
  ADD KEY `fk_ventas` (`idventa`),
  ADD KEY `Fk_producto` (`idProducto`);
ALTER TABLE `clientes`
  MODIFY `idCliente` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `compras`
  MODIFY `idcompra` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `compras_detalle`
  MODIFY `idcompra_detalle` bigint(20) NOT NULL AUTO_INCREMENT;
ALTER TABLE `empleados`
  MODIFY `idEmpleado` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `marcas`
  MODIFY `idMarca` smallint(6) NOT NULL AUTO_INCREMENT;

ALTER TABLE `productos`
  MODIFY `idProducto` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `proveedores`
  MODIFY `idproveedor` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `puestos`
  MODIFY `idPuesto` smallint(6) NOT NULL AUTO_INCREMENT;

ALTER TABLE `ventasdetalle`
  MODIFY `idventa_det` bigint(20) NOT NULL AUTO_INCREMENT;

ALTER TABLE `compras`
  ADD CONSTRAINT `fk_prov` FOREIGN KEY (`idproveedor`) REFERENCES `proveedores` (`idproveedor`) ON UPDATE CASCADE;
ALTER TABLE `compras_detalle`
  ADD CONSTRAINT `fk_compras` FOREIGN KEY (`idcompra`) REFERENCES `compras` (`idcompra`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_prod` FOREIGN KEY (`idproducto`) REFERENCES `productos` (`idProducto`) ON UPDATE CASCADE;
ALTER TABLE `empleados`
  ADD CONSTRAINT `empleados_FK` FOREIGN KEY (`idPuesto`) REFERENCES `puestos` (`idPuesto`) ON UPDATE CASCADE;
ALTER TABLE `productos`
  ADD CONSTRAINT `fk_marca` FOREIGN KEY (`idMarca`) REFERENCES `marcas` (`idMarca`) ON UPDATE CASCADE;
ALTER TABLE `ventas`
  ADD CONSTRAINT `fk_clientev` FOREIGN KEY (`idcliente`) REFERENCES `clientes` (`idCliente`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_empleado` FOREIGN KEY (`idempleado`) REFERENCES `empleados` (`idEmpleado`) ON UPDATE CASCADE;
ALTER TABLE `ventasdetalle`
  ADD CONSTRAINT `Fk_producto` FOREIGN KEY (`idProducto`) REFERENCES `productos` (`idProducto`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_ventas` FOREIGN KEY (`idventa`) REFERENCES `ventas` (`idVenta`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
