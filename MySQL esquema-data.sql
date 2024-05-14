SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `ventas`;
DROP TABLE IF EXISTS `vendedores`;
DROP TABLE IF EXISTS `clientes`;
DROP TABLE IF EXISTS `oficina`;
DROP TABLE IF EXISTS `productos`;

SET FOREIGN_KEY_CHECKS=1;

CREATE TABLE `clientes` (
  `id_cliente` int(11) NOT NULL,
  `NOMBRE` varchar(50) DEFAULT NULL,
  `APELLIDO` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `oficina` (
  `id_oficina` int(11) NOT NULL,
  `descripcion` varchar(225) DEFAULT NULL,
  PRIMARY KEY (`id_oficina`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `descripcion` varchar(225) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `vendedores` (
  `id_vendedor` int(11) NOT NULL,
  `nombre` varchar(225) DEFAULT NULL,
  `apellido` varchar(225) DEFAULT NULL,
  `fecha_nac` date DEFAULT NULL,
  `id_oficina` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_vendedor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `ventas` (
  `id_cliente` int(11) DEFAULT NULL,
  `id_vendedor` int(11) DEFAULT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `FECHA` date DEFAULT NULL,
  `ID_VENTA` varchar(50) NOT NULL,
  PRIMARY KEY (`ID_VENTA`),
  KEY `ID_CLIENTE` (`ID_CLIENTE`),
  KEY `ID_VENDEDOR` (`ID_VENDEDOR`),
  KEY `ID_PRODUCTO` (`ID_PRODUCTO`),
  CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`),
  CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`id_vendedor`) REFERENCES `vendedores` (`id_vendedor`),
  CONSTRAINT `ventas_ibfk_3` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

